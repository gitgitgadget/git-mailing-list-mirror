From: Dima Kagan <dima.kagan@gmail.com>
Subject: Git branches - confusing behavior
Date: Sun, 11 May 2008 14:31:06 +0300
Message-ID: <4826D8FA.30305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 11 13:32:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv9mb-00042f-Tb
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 13:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbYEKLbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 07:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbYEKLbL
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 07:31:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:63199 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbYEKLbK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 07:31:10 -0400
Received: by ug-out-1314.google.com with SMTP id h2so499404ugf.16
        for <git@vger.kernel.org>; Sun, 11 May 2008 04:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=p4zv58s+BTkCrGnnpIAe8dyDlyA6GAWM7mMfgeob9KM=;
        b=D3xqhQnb+KAGFryJ7x73c6D6uMIZaL8I9QhNs9F7+VhaED3eCdAtuGJWL0uaawpk9LvuV663/Dug3n1KOyywcHiEKdKAlmRUSr7T2XH8qk9vYMjcDsAmkRU8ze38c/hW6e6D4wGnTB3ELm5yTxMPa9QZzkdCR5IrFiRL8k+avpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=i12Mle//XPtq7BKujd3k7UP9ct97GFwaDleSQVE+sd+/bhbY/WPffrv2pp43HJupDmgCcGgledEfbCFs3sSiN3qsACRkGPJhcYg6eYn8p/vWUwJI235/TX9Fzoj1lz60TEM2AxCq96o9zIcsMtL8R/6/D5o9gISdBOANEF29i4g=
Received: by 10.66.233.10 with SMTP id f10mr3999173ugh.17.1210505468524;
        Sun, 11 May 2008 04:31:08 -0700 (PDT)
Received: from ?192.168.1.60? ( [82.166.58.226])
        by mx.google.com with ESMTPS id q9sm12912913gve.5.2008.05.11.04.31.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 04:31:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81757>

Hi,

I'm currently evaluating git for doing some local work without
depending on the main subversion server. I started with the following
steps:

> git-svn clone http://svn.test.org/test/trunk
> cd trunk
> git branch test_branch
> git checkout test_branch
> vi somefile

Now, when I run 'git status' I get:
# On branch test_branch
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   somefile
#
no changes added to commit (use "git add" and/or "git commit -a")

This is what I expect of course. However, when I execute 'git checkout
master', I get:
M       somefile
Switched to branch "master"

And after running 'git status' on master I get:
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   somefile
#
no changes added to commit (use "git add" and/or "git commit -a")

Basically I see that the same file I edited on the 'test_branch'
branch appears to be modified on the 'master' branch as well. This
behavior is unwanted, of course.

Can someone please tell me, what am doing wrong? Or is this git's
normal behavior?

Thanks in advance! 
