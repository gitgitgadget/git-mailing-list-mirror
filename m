From: Mike <xandrani@gmail.com>
Subject: Undo last commit?
Date: Sat, 18 Jun 2011 14:15:49 +0100
Message-ID: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 15:15:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXvNU-0001L0-Fp
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 15:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648Ab1FRNPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 09:15:51 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41276 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab1FRNPu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 09:15:50 -0400
Received: by qwk3 with SMTP id 3so280176qwk.19
        for <git@vger.kernel.org>; Sat, 18 Jun 2011 06:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=NS2YXgxPon+DQKIwi6HGCJcVnrX4YKaMqUX0OwpZiy0=;
        b=SryaF5MTCWEaXoW7lzuNhCNGqCMksOHzEOAKXfxShkgSq7YnosIb0xFQoX4Ack62jn
         nIj08dWFFtxqu4tMrhhClPk8NPNaklUDC7SOR77/DkQBi1538SIKsmuFGyMQ9NdkWcsf
         dobuamqOT8j8fgiu2FZJHp90BKvVuVe//yfh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=lkg1GfnjlbWPxLCUump1/Bs6PBeVoNN2iAdiSS+Cc1BcHOD9wSdTtJat9nZ3DCp47l
         2AC37EGmSv4O8ucTYUmLrNgwbxS96oe9F68c4XanYhpuDimVdpGcslQbBMmeQOZwvaX+
         ALxZQ/GZvWmpGxJyDh4nk3wH29Wd7mYZZEysQ=
Received: by 10.229.9.8 with SMTP id j8mr2566358qcj.228.1308402949757; Sat, 18
 Jun 2011 06:15:49 -0700 (PDT)
Received: by 10.229.39.78 with HTTP; Sat, 18 Jun 2011 06:15:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175968>

Hi fellow gitters,

I have performed a 'git commit' on all 'added' files by mistake and
now I want to undo this commit to return to the original state. Here's
a more detailed description:


1. I did a 'git status' and there were files which I had 'added' ready
for a commit. There were also some changes that had not been 'added'
yet. See below:

% git status
# On branch master
# Your branch is ahead of 'origin/master' by 7 commits.
#
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   cgi-bin/example1.php
#	modified:   cgi-bin/example2.php
#	modified:   example3.php
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   cgi-bin/example4.php
#	modified:   example5.php
#


2. I accidentally did a commit for ALL files because I forgot to
specify the filename at the end of the commit.
e.g. instead of 'commit -m "commit message" example3.php' I did
'commit -m "commit message"'.

3. I googled the problem and it seems everyone has a different way of
doing this. (Maybe git is too confusing if everyone has different
methods that all work slightly differently!?). Anyway I executed this
command:

% git commit --amend

But I aborted this by exiting my text editor.

4. I then tried:

% git reset --hard HEAD~1

5. However now when I do a 'git status' none of the files that were
original listed are there. A git status now gives this:

# On branch master
# Your branch is ahead of 'origin/master' by 7 commits.
#
nothing to commit (working directory clean)


Any ideas how to rectify this issue? I presume the 'git commit
--amend' just changes the commit message? I daren't try anything else
myself in case I make matters worse.

Mike
