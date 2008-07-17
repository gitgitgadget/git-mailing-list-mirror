From: Len Brown <lenb@kernel.org>
Subject: Segmentation fault      git pull
Date: Thu, 17 Jul 2008 12:52:27 -0400
Message-ID: <200807171652.m6HGqR2h006100@localhost.localdomain>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 18:53:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJWjh-0005g2-NY
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 18:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797AbYGQQwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 12:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756293AbYGQQwr
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 12:52:47 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:41069 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756722AbYGQQwq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 12:52:46 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K4500B0JTJGKR36@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 17 Jul 2008 11:52:29 -0500 (CDT)
Received: from localhost.localdomain (d975xbx2 [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.2) with ESMTP id m6HGqRXB006105	for
 <git@vger.kernel.org>; Thu, 17 Jul 2008 12:52:27 -0400
Received: (from lenb@localhost)	by localhost.localdomain (8.14.2/8.14.2/Submit)
 id m6HGqR2h006100	for git@vger.kernel.org; Thu, 17 Jul 2008 12:52:27 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88880>

$ git --version
git version 1.5.6.3.439.g1e10

...while doing a pull on my vanilla linus' linux tracking tree,
which I have not touched in about a week.

$ good.morning
...
+ git checkout master
Already on "master"
+ git pull
remote: Counting objects: 31759, done.
remote: Compressing objects: 100% (5397/5397), done.
remote: Total 28193 (delta 23770), reused 27116 (delta 22765)
Receiving objects: 100% (28193/28193), 6.76 MiB | 526 KiB/s, done.
Resolving deltas: 100% (23770/23770), completed with 3141 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
   f57e916..33af79d  master     -> origin/master
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
 * [new tag]         v2.6.26    -> v2.6.26
Updating f57e916..33af79d
/lab/bin/good.morning: line 8:  5610 Segmentation fault      git pull
...
$ git pull
Updating f57e916..33af79d
fatal: unable to create '.git/index.lock': File exists
[lenb@d975xbx2 linus (master)]$ rm .git/index.lock

git status
shows no local changes, just a few untracked files i have left around.

clues?

thanks,
-Len

ps.
$ cat /lab/bin/good.morning 
#!/bin/bash -x
cd ~/src/git
git checkout master
git pull
make -j4 install
cd ~/src/linus
git checkout master
git pull
...
