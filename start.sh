#!/bin/bash

DCKER_CONTAINER_NAME=ansibleroletest
SSH_PUBLIC_KEY_FILE=ansible/ssh/id_rsa.pub
SSH_PUBLIC_KEY=$(cat "$SSH_PUBLIC_KEY_FILE")
ANSIBLE_HOST_KEY_CHECKING=False

docker run -ti --rm --privileged -d --name ${DCKER_CONTAINER_NAME} -p 5000:22 -e AUTHORIZED_KEYS="$SSH_PUBLIC_KEY" local/centos7-systemd

cd ansible && ansible-playbook -i env/local_docker nginx.yml --private-key ssh/id_rsa

docker stop ${DCKER_CONTAINER_NAME}

#ansible-playbook -i env/local_docker nginx.yml --private-key ssh/id_rsa --extra-vars "nginx_port=99"