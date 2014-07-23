From: Ross Boylan <ross@biostat.ucsf.edu>
Subject: confused about remote branch management
Date: Tue, 22 Jul 2014 19:49:03 -0700
Message-ID: <1406083743.29001.139.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 05:11:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9mxt-0003Sr-Ie
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 05:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721AbaGWDLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 23:11:32 -0400
Received: from upstrm185.psg-ucsf.org ([38.99.193.74]:57267 "EHLO
	biostat.ucsf.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753988AbaGWDLb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 23:11:31 -0400
X-Greylist: delayed 1344 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jul 2014 23:11:31 EDT
Received: from ns208-a-650ts.psg.net ([10.0.2.3]:22524 helo=[192.168.40.102])
	by biostat.ucsf.edu with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <ross@biostat.ucsf.edu>)
	id 1X9mbx-0002DW-VY; Tue, 22 Jul 2014 19:48:58 -0700
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254056>

My local master branch is the result of a merge of upstream master and
some local changes.  I want to merge in more recent upstream work.
git pull doesn't seem to have updated origin/master, and git checkout
origin/master also doesn't seem to work.

Here's some info that may be relevant.


ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git remote -v
origin	https://github.com/emacs-ess/ESS.git (fetch)
origin	https://github.com/emacs-ess/ESS.git (push)
personal	https://github.com/RossBoylan/ESS.git (fetch)
personal	https://github.com/RossBoylan/ESS.git (push)
# I think I originally cloned from what is now the "personal" remote
# and switched names later so origin refers to upstream.
ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git branch -v
* master 8fa569c [ahead 340] merge from origin
# 340 ahead of personal is plausible, but ahead from origin seems odd
ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git --version
git version 1.7.10.4
ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git branch -a
* master
  remotes/origin/S+eldoc
  remotes/origin/gretl
  remotes/origin/linewise_callbacks
  remotes/origin/litprog
  remotes/origin/master
  remotes/origin/transmissions
  remotes/personal/HEAD -> personal/master
  remotes/personal/S+eldoc
  remotes/personal/gretl
  remotes/personal/linewise_callbacks
  remotes/personal/litprog
  remotes/personal/master
  remotes/personal/transmissions
ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git status
# On branch master
# Your branch is ahead of 'personal/master' by 340 commits.
#
nothing to commit (working directory clean)
ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git checkout origin/master
Note: checking out 'origin/master'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in
this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again.
Example:

  git checkout -b new_branch_name

HEAD is now at a33a2f9... Merge branch 'trunk'
ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git checkout master
Previous HEAD position was a33a2f9... Merge branch 'trunk'
Switched to branch 'master'
ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git pull origin master
# [messages]
Not committing merge; use 'git commit' to complete the merge.
ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git status
# On branch master
# Changes to be committed:
# [long list]
ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git show origin/master
commit a33a2f9e06185a225af7d72ea3896cfd260e455e
Merge: 136742f 6b22a88
Author: Vitalie Spinu <spinuvit@gmail.com>
Date:   Mon Jan 20 00:43:30 2014 -0800

    Merge branch 'trunk'
# this was the head of origin/master BEFORE I did the pull.
# I think this means it has not been updated.
ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git commit -m "merge in
upstream, probably fe7d609..8fa569c"
[master 59f6841] merge in upstream, probably fe7d609..8fa569c
ross@tempserver:~/UCSF/Choi/GitHub/ESS$ git show origin/master -v
# no change
