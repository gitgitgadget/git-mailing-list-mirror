From: Evan Li <li.evan.chao@gmail.com>
Subject: git objects mode 755 vs 700
Date: Thu, 11 Dec 2014 21:48:09 +0800
Message-ID: <8195C4C373DD42D6813F0181902AC916@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 14:48:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xz46U-0004Nq-Ox
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 14:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933810AbaLKNsW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Dec 2014 08:48:22 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41716 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932470AbaLKNsV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2014 08:48:21 -0500
Received: by mail-pa0-f46.google.com with SMTP id lf10so4476075pab.33
        for <git@vger.kernel.org>; Thu, 11 Dec 2014 05:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        bh=SIzhlxObuUdqC0BEWBJfFy+1vLP6ouJBRNEH78Rb6Hk=;
        b=BBo2lXDR6PcEcw2CqnDDEzhKMDYp06sL1rOjQp3ULVn3gvETSu6iA47Jj8ItPHR/lG
         dEiku0yPBesF7+kV/GjMLbiM8EWxKi+sgUIhlkUhrkBsZNshqNU2fGzNNOiElBp0os4k
         sJ8TM0uGK/N0TEC+7UJW+G3/4xXEH9+4XHMm3OcqS2B44kgQbG8Ii7eDLogETvvm8in0
         ZtvgWva8YkpPSHQr270nZUgYSQInhwrvg/5SWavDv0BrW3fHxBycSNl4HZw9mIOwcdyZ
         QvqfVE9JcJPC5YWSd0RFd+IQNpfI8Wx/Ge22gSstP1QdPkKMXyZUtDmwoPq1xHcAdBLO
         9VYQ==
X-Received: by 10.70.98.233 with SMTP id el9mr17384063pdb.132.1418305701422;
        Thu, 11 Dec 2014 05:48:21 -0800 (PST)
Received: from [192.168.1.111] ([39.65.69.130])
        by mx.google.com with ESMTPSA id cq6sm1504156pad.30.2014.12.11.05.48.18
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 11 Dec 2014 05:48:20 -0800 (PST)
X-Mailer: sparrow 1.6.3 (build 1173)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261278>

Greetings,

I have setup a git server for my company, but one problem I found is li=
ke the following problem:

[root@localhost objects]# pwd
/home/git/repositories/testing.git/objects
[root@localhost objects]# ls -l
total 0
drwx------ 2 git git 59 Dec 11 03:04 0e
drwx------ 2 git git 59 Dec 11 03:14 11
drwx------ 2 git git 59 Dec 11 03:12 1b
drwxr-xr-x 2 git git 59 Dec 5 02:53 24
drwx------ 2 git git 59 Dec 11 03:01 39
drwx------ 2 git git 59 Dec 11 03:01 42
drwx------ 2 git git 59 Dec 11 03:01 47
drwxr-xr-x 2 git git 59 Dec 5 02:57 4c


As you can see, on the git server, take a repo =E2=80=99testing.git=E2=80=
=99 as example, under the =E2=80=98objects=E2=80=99 directory, some sub=
-directory has 755 mode, but most of them are 700.

To work with reviewboard, I export =E2=80=98repositories=E2=80=99 direc=
tory to NFS as readonly mode, but I need sub-directories under =E2=80=98=
objects=E2=80=99 to be 755 mode.

Why some of them are of 755 but some 700? How can I set all sub-directo=
ries under =E2=80=98objects=E2=80=99 to be of 755 mode?

-- =20
Evan Li
