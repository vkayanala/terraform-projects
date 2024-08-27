terraform {
  required_version = "~> 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}


provider "aws" {
  region  = "us-east-1"
  profile = "Terraform-lab"
}

/*module "sgmodule" {
  source = "/Users/vayanala/Documents/terraform-training/terraform-modules/modules/ec2"
  //instance_type = "t2.large"
*/

}
resource "aws_instance" "myec2" {
  ami           = "ami-067d1e60475437da2"
  instance_type = "im4gn.large"
  subnet_id     = "subnet-0aeadf406bd73e4ac"
//  vpc_security_group_ids = [module.sgmodule.sg_id]

}
/*resource "aws_instance" "myec2" {
  ami           = "ami-067d1e60475437da2"
  instance_type = var.instancetype
  subnet_id     = "subnet-0aeadf406bd73e4ac"
  count         = 1
  key_name      = "terraform-ec2-key"

  tags = {
    Name = "terraform-ec2-2"
  }


  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/Users/vayanala/Documents/terraform-training/terraform-ec2-key.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /etc/oss/cassandra"
    ]
  }
}*/

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y cassandra"
    ]
  }
}
