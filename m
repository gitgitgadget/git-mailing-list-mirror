From: Emanuel Rietveld <codehotter@gmail.com>
Subject: Git push to samba/cifs share fails
Date: Fri, 30 Mar 2012 18:23:21 +0200
Message-ID: <4F75DDF9.8060305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 18:22:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDeam-0003so-DA
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 18:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab2C3QWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 12:22:20 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38385 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab2C3QWT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 12:22:19 -0400
Received: by eekc41 with SMTP id c41so278963eek.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=hoxKvQDIHV3rAqwZASktvamP+BZAenVXsI2XPu3bVAM=;
        b=vz61Y4y2nfbgb9FyyYcIHSehjny4dACRX4IF+9SmumS2IcX9yO5eewKTq0xu2oGhez
         76KeAUnRZBGaZc+44Y4mRDOTQ0pc3BBuOcCRmOaa6rMbDZwPAEno+8o4GHGEfnavIYgN
         +UdYxI+O8UpxrXkE1/2TfpyTkmVRTo8Jj3XuF6o8KdQ8i2A1Bbu4GgTUZ9hefoKTyoYq
         S9N4U7NPOY/pzJiDCULV2MOmoeAhXvc5GP6H5EssHZlS8vD4GHPM9lbEipEi2SUy1x0I
         5IqTyq6myfCN5NLKyKInBdYnbJZqNLK1P33d8c8N8YW8K0zjCcnEWr3tiARvf8/sMeGX
         DF4g==
Received: by 10.14.53.13 with SMTP id f13mr783077eec.122.1333124538125;
        Fri, 30 Mar 2012 09:22:18 -0700 (PDT)
Received: from [192.168.2.53] (82-204-15-146.dsl.bbeyond.nl. [82.204.15.146])
        by mx.google.com with ESMTPS id e56sm34606922eea.11.2012.03.30.09.22.17
        (version=SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 09:22:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120316 Thunderbird/11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194376>

I get an error message when I try to push my git repository to a share 
mounted with mount.cifs.

[emanuel@faseri01 frog]$ sudo mount.cifs //windows2003/emanuel /mnt/e -o 
user=emanuel,uid=500
Password:
[emanuel@faseri01 frog]$ mkdir /mnt/e/frog.git
[emanuel@faseri01 frog]$ git init --bare /mnt/e/frog.git
Initialized empty Git repository in /mnt/e/frog.git/
[emanuel@faseri01 frog]$ git push /mnt/e/frog.git/ master
Counting objects: 18, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (16/16), done.
fatal: error when closing sha1 file: Bad file descriptor
error: pack-objects died of signal 13
error: failed to push some refs to '/mnt/e/frog.git/'
[emanuel@faseri01 frog]$ du -hs
67M	.
[emanuel@faseri01 frog]$ uname -a
Linux faseri01 3.3.0-4.fc16.x86_64 #1 SMP Tue Mar 20 18:05:40 UTC 2012 
x86_64 x86_64 x86_64 GNU/Linux
[emanuel@faseri01 frog]$ git --version
git version 1.7.7.6

This repository is 67M. I do not have any git hooks configured. Another, 
smaller repository works without errors if I follow the same procedure. 
The client is a fully up to date Fedora 16 machine. The server is a 
windows 2003 server.

Is this kind of usage possible with git? I just want to back up my 
repository to the fileserver.

Thank you for your time.

Kind Regards,

Emanuel Rietveld
