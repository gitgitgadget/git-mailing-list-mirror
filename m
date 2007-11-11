From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Local branch to remote branch translation
Date: Sun, 11 Nov 2007 12:54:41 -0500
Message-ID: <9e4733910711110954m3ed3f9adtf19ca15dff61f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 18:55:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrH1P-0002yw-Bi
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 18:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756314AbXKKRyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 12:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756299AbXKKRyn
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 12:54:43 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:5292 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698AbXKKRym (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 12:54:42 -0500
Received: by rv-out-0910.google.com with SMTP id k20so970471rvb
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 09:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=ihmlycw6hdD44sowJk7s/hbLgJP7DalGjnRC4xFuf1Y=;
        b=HpTR/JrOjlxIT7i2zG5Q0afv92xFfWy4Jci5wC8nOfdSTOynnd4wA3XIikPivvmCmXa9MguXNIJaMtB+K4M/2gTXVDkK0DIkVSdURtnlfF+YqfA+8MbLvRqNrHBLBoRu4zi0CWMGrwatjLw66FlF4GUVAz0ztAJj8MWgmKfL6DE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=R3hlN42dlCSWcZj5MYbNMK6IZ4nrTfGcVCHSL99mvw3ceeFfc9LcMCIKHfBv+JVq2Jo2UR7EJ/9ZT8/OLWVj5UMlObYx7a8Lpdb7mG7ACHi/sKvcfn7ZXIxdUlGmZUeuFJIW8rLdQpK0siqkkf9BlJ1930+qRemZ8gbmuwQya5c=
Received: by 10.114.25.3 with SMTP id 3mr1642795way.1194803681973;
        Sun, 11 Nov 2007 09:54:41 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Sun, 11 Nov 2007 09:54:41 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64488>

What am I doing wrong in this sequence?

In my local repo I have two remotes:

jonsmirl@terra:~/mpc5200b$ git remote
dreamhost
linus

I create branches off from these using:
git branch -b m29 linus/master

I update them with
stg rebase linus/master

My repo has a .git/packed-refs file

When I push this repo to a remote server my local branches get renamed.

jonsmirl@terra:~/mpc5200b$ git push dreamhost
To ssh://jonsmirl1@git.digispeaker.com/~/mpc5200b.git
 * [new branch]      m24 -> linus/m24
 * [new branch]      m25 -> linus/m25
 * [new branch]      m26 -> linus/m26
 * [new branch]      m28 -> linus/m28
 * [new branch]      m29 -> linus/m29
Counting objects: 619084, done.
...

So one the remote server I see this:

[daedalus]$ git remote
[daedalus]$ git branch
[daedalus]$ git branch -r
  linus/m24
  linus/m25
  linus/m26
  linus/m28
  linus/m29
[daedalus]$

With the repo in this state at the remote server gitweb thinks the
repo is empty.
Why are these branches getting renamed?

git head is in use on both ends.

-- 
Jon Smirl
jonsmirl@gmail.com
