#!/bin/bash

# Install Git
yum install -y git

# Install Docker
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum makecache fast
yum install -y docker-ce
systemctl start docker

# Clone the git repo with the Dockerfile
git clone https://github.com/sonatype/docker-nexus3.git
cd docker-nexus3
git checkout -f b4c2ff8

# Build the Docker image
docker build --rm=true --tag=sonatype/nexus3 .

# Create volume for Artifactory data
docker volume create --name nexus3_data

# Run the container
docker run --name nexus3-oss -d -v nexus3_data:/nexus-data -p 8082:8081 sonatype/nexus3



