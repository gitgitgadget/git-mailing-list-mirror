From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: stgit error on status command
Date: Mon, 7 Jul 2008 11:10:32 -0400
Message-ID: <9e4733910807070810i14c8856vfbec24127e711285@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 07 17:11:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFsNI-0008VB-Kz
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 17:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbYGGPKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 11:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753451AbYGGPKe
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 11:10:34 -0400
Received: from rn-out-0910.google.com ([64.233.170.191]:62754 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbYGGPKd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 11:10:33 -0400
Received: by rn-out-0910.google.com with SMTP id k40so357703rnd.17
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=dkjspDhhqpJzoQ6JwxamFt7QgPInU9jrjKIoidJ8K9E=;
        b=jgWR8CZXNt2bG4oapLM7DRKElXs483R1pdC31fC+dK8L7IuAIfC8Nwb1to1IeAhxSC
         VTrQRKnwdRgoD9MKF3DoEh9HzX/MOYFuEOTuO9Z8PFyYIJeDV7M2DRmsfpn5k8oWpZxj
         thBv9Kc0QM7tdLo6bDKcb+AzEYb/Ji33s64KQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=GgpAsTwDd6h8NDeQz+AafCeeOZcRRKBbtbXSO6+xFi2JclqCirma/JvpuXVCTNZYMw
         /fxeV28u8D8XhFvvZTOscYKYarnV7qghBpJ8WqTi6s66iCPsojibrQKYdkHkNbWpUCvS
         C27hKJ+Z2kDf/oF382nOBStVcEbkK1NeSC0T4=
Received: by 10.151.145.17 with SMTP id x17mr8382349ybn.102.1215443432909;
        Mon, 07 Jul 2008 08:10:32 -0700 (PDT)
Received: by 10.151.78.17 with HTTP; Mon, 7 Jul 2008 08:10:32 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87623>

jonsmirl@terra:~$ stg --version
Stacked GIT 0.14.3.163.g06f9
git version 1.5.6.1
Python version 2.5.2 (r252:60911, Apr 21 2008, 11:17:30)
[GCC 4.2.3 (Ubuntu 4.2.3-2ubuntu7)]
jonsmirl@terra:~$

jonsmirl@terra:~/fs$ stg status
Error: Unhandled exception:
Traceback (most recent call last):
  File "/usr/local/lib/python2.5/site-packages/stgit/main.py", line 278, in main
    ret = command.func(parser, options, args)
  File "/usr/local/lib/python2.5/site-packages/stgit/commands/status.py",
line 119, in func
    options.diff_flags)
  File "/usr/local/lib/python2.5/site-packages/stgit/commands/status.py",
line 75, in status
    diff_flags = diff_flags)
  File "/usr/local/lib/python2.5/site-packages/stgit/git.py", line
255, in tree_status
    for t, fn in parse_git_ls(GRun('diff-index', '-z', *args).raw_output()):
  File "/usr/local/lib/python2.5/site-packages/stgit/git.py", line
201, in parse_git_ls
    mode_a, mode_b, sha1_a, sha1_b, t = line.split(' ')
ValueError: need more than 1 value to unpack
jonsmirl@terra:~/fs$

jonsmirl@terra:~/fs$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       renamed:    arch/powerpc/boot/dts/digispeaker-alpha.dts ->
arch/powerpc/boot/dts/dspeak01.dts
#       renamed:    arch/powerpc/platforms/52xx/digispeaker_alpha.c ->
arch/powerpc/platforms/52xx/dspeak0
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   arch/powerpc/platforms/52xx/dspeak01.c


-- 
Jon Smirl
jonsmirl@gmail.com
