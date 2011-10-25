From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: git stash show doesn't show stashed untracked files
Date: Tue, 25 Oct 2011 17:21:36 +0400
Message-ID: <5284251B-7265-493B-981D-DD10B80F85B1@jetbrains.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 15:21:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIgwq-0004En-79
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 15:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933408Ab1JYNVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 09:21:40 -0400
Received: from mail1.intellij.net ([46.137.178.215]:56817 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933399Ab1JYNVj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2011 09:21:39 -0400
Received: (qmail 26669 invoked by uid 89); 25 Oct 2011 13:21:37 -0000
Received: by simscan 1.1.0 ppid: 26562, pid: 26647, t: 0.0830s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@195.5.138.42)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 25 Oct 2011 13:21:37 -0000
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184204>


Git 1.7.7 introduced a very useful feature - stashing untracked files via "-u" option.

However, there is a problems with it:
'git stash show' doesn't show stashed untracked files.

# git version
git version 1.7.7
# touch untracked.txt
# git stash save -u
# git stash show         // no output

If changes in tracked files are stashed along with untracked files, then only tracked changes are shown in "git stash show" output.

Moreover, if I have the same file in the working tree, I wouldn't be able to 'git stash pop':
# git stash pop -v
untracked.txt already exists, no checkout
Could not restore untracked files from stash

In this case the only way to access the stashed content is to remove the tracked file and pop the stash again.

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
