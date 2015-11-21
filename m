From: Peter van der Does <pvanderdoes@gmail.com>
Subject: Remote reference deleted on git fetch
Date: Sat, 21 Nov 2015 10:24:20 -0500
Message-ID: <56508CA4.9080403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 21 16:24:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0A1b-0000mO-RS
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 16:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760978AbbKUPYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2015 10:24:24 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33676 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760545AbbKUPYX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2015 10:24:23 -0500
Received: by vkfr145 with SMTP id r145so14669936vkf.0
        for <git@vger.kernel.org>; Sat, 21 Nov 2015 07:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=y9lU4zrRNPq7Ot/d5WIakLsZ3RzF3M2SHV/FTr5HOhs=;
        b=jqb8EDRoGDV7mMA2xqsw5pJoZEe6K4KyF0pT+9uiKHxTyI/DpzoJ5SXjTWedmhJxsi
         g05fTBMPIMPBn7jeJiwwnrJQdKhuE3NYmKmS0Re0lvhUWB8MfpkJfFX5zKcjHDffkfgg
         M8Du88gwLlLsXyyn0DXNMzQQwfRsUftppR8o3v9W/Srh0EmXt5su0+zBuMi+RKEthkjL
         iiQFdErnB7l2lQUwXA22+M/nm+Zf1As+UaTiJ/ryLAt0K32foOTF1yW0vgeYrZSyEsoC
         TlC6uNduZYydi6EhF2pvg7A5YXF+uMxTAS5V3YhLIb4Vxh8jCcL6Q2UotXqVzs/6FK2s
         gwdQ==
X-Received: by 10.31.178.1 with SMTP id b1mr6572643vkf.46.1448119462486;
        Sat, 21 Nov 2015 07:24:22 -0800 (PST)
Received: from [192.168.1.106] (c-69-248-80-32.hsd1.nj.comcast.net. [69.248.80.32])
        by smtp.googlemail.com with ESMTPSA id d78sm3717524vka.10.2015.11.21.07.24.21
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 Nov 2015 07:24:21 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:44.0) Gecko/20100101
 Thunderbird/44.0a2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281557>

Hi,

I have enabled fetch.prune and when I do a push of an existing branch
and fetch that branch the remote reference is deleted. Is this a bug or
expected behavior?

Doing the following commands on an existing repository:
$ git config fetch.prune true
$ git checkout -b bug/bug-1
Switched to a new branch 'bug/bug-1'
$ touch bugfix
$ git add .
$ git commit -a
$ git push --set-upstream origin bug/bug-1
Counting objects: 2, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 242 bytes | 0 bytes/s, done.
Total 2 (delta 1), reused 0 (delta 0)
To git@github.com:petervanderdoes/Testing.git
 * [new branch]      bug/bug-1 -> bug/bug-1
Branch bug/bug-1 set up to track remote branch bug/bug-1 from origin.
$ git fetch origin bug/bug-1:refs/remotes/origin/bug/bug-1
>From github.com:petervanderdoes/Testing
 x [deleted]         (none)     -> origin/bug/bug-1
$ git branch -r
  origin/master
$ git branch
* bug/bug-1
  master

The branch still exists on the remote repository.
Is it correct that the git fetch deletes the remote reference?


Peter

-- 
Peter van der Does

GPG key: CB317D6E

Site: http://avirtualhome.com
GitHub: https://github.com/petervanderdoes
Twitter: @petervanderdoes
