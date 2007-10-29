From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCH] core-tutorial: Catch up with current Git
Date: Mon, 29 Oct 2007 08:00:32 +0100
Message-ID: <1193641233-3880-1-git-send-email-tsuna@lrde.epita.fr>
Cc: gitster@pobox.com, Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 29 08:01:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImOcK-0006pf-QI
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 08:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbXJ2HAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 03:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbXJ2HAk
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 03:00:40 -0400
Received: from quanta.tsunanet.net ([82.229.223.213]:60616 "EHLO
	quanta.tsunanet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbXJ2HAi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 03:00:38 -0400
Received: by quanta.tsunanet.net (Postfix, from userid 501)
	id 80ED9BEAC67; Mon, 29 Oct 2007 08:00:33 +0100 (CET)
X-Mailer: git-send-email 1.5.3.4.398.g859b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62605>

No longer talk about Cogito since it's deprecated.  Some scripts (such as
git-reset or git-branch) have undergone builtinification so adjust the text
to reflect this.

Fix a typo in the description of git-show-branch (merges are indicated by a
`-', not by a `.').

git-pull/git-push do not seem to use the dumb git-ssh-fetch/git-ssh-upload
(the text was probably missing a word).

Adjust a link that wasn't rendered properly because it was wrapped.

Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
---
I intentionally modified the text the least possible.

 Documentation/core-tutorial.txt |   26 ++++++++++----------------
 1 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 6b2590d..d8e78ac 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -553,13 +553,8 @@ can explore on your own.
 
 [NOTE]
 Most likely, you are not directly using the core
-git Plumbing commands, but using Porcelain like Cogito on top
-of it. Cogito works a bit differently and you usually do not
-have to run `git-update-index` yourself for changed files (you
-do tell underlying git about additions and removals via
-`cg-add` and `cg-rm` commands). Just before you make a commit
-with `cg-commit`, Cogito figures out which files you modified,
-and runs `git-update-index` on them for you.
+git Plumbing commands, but using Porcelain such as `git-add`, `git-rm'
+and `git-commit'.
 
 
 Tagging a version
@@ -686,8 +681,8 @@ $ git reset
 
 and in fact a lot of the common git command combinations can be scripted
 with the `git xyz` interfaces.  You can learn things by just looking
-at what the various git scripts do.  For example, `git reset` is the
-above two lines implemented in `git-reset`, but some things like
+at what the various git scripts do.  For example, `git reset` used to be
+the above two lines implemented in `git-reset`, but some things like
 `git status` and `git commit` are slightly more complex scripts around
 the basic git commands.
 
@@ -805,8 +800,8 @@ you have, you can say
 $ git branch
 ------------
 
-which is nothing more than a simple script around `ls .git/refs/heads`.
-There will be asterisk in front of the branch you are currently on.
+which used to be nothing more than a simple script around `ls .git/refs/heads`.
+There will be an asterisk in front of the branch you are currently on.
 
 Sometimes you may wish to create a new branch _without_ actually
 checking it out and switching to it. If so, just use the command
@@ -952,7 +947,7 @@ the later output lines is used to show commits contained in the
 `master` branch, and the second column for the `mybranch`
 branch. Three commits are shown along with their log messages.
 All of them have non blank characters in the first column (`*`
-shows an ordinary commit on the current branch, `.` is a merge commit), which
+shows an ordinary commit on the current branch, `-` is a merge commit), which
 means they are now part of the `master` branch. Only the "Some
 work" commit has the plus `+` character in the second column,
 because `mybranch` has not been merged to incorporate these
@@ -1086,7 +1081,7 @@ to help dumb transport downloaders.
 There are (confusingly enough) `git-ssh-fetch` and `git-ssh-upload`
 programs, which are 'commit walkers'; they outlived their
 usefulness when git Native and SSH transports were introduced,
-and not used by `git pull` or `git push` scripts.
+and are not used by `git pull` or `git push` scripts.
 
 Once you fetch from the remote repository, you `merge` that
 with your current branch.
@@ -1193,7 +1188,7 @@ $ mb=$(git-merge-base HEAD mybranch)
 
 The command writes the commit object name of the common ancestor
 to the standard output, so we captured its output to a variable,
-because we will be using it in the next step.  BTW, the common
+because we will be using it in the next step.  By the way, the common
 ancestor commit is the "New day." commit in this case.  You can
 tell it by:
 
@@ -1459,8 +1454,7 @@ Although git is a truly distributed system, it is often
 convenient to organize your project with an informal hierarchy
 of developers. Linux kernel development is run this way. There
 is a nice illustration (page 17, "Merges to Mainline") in
-link:http://www.xenotime.net/linux/mentor/linux-mentoring-2006.pdf
-[Randy Dunlap's presentation].
+link:http://www.xenotime.net/linux/mentor/linux-mentoring-2006.pdf[Randy Dunlap's presentation].
 
 It should be stressed that this hierarchy is purely *informal*.
 There is nothing fundamental in git that enforces the "chain of
-- 
1.5.3.4.398.g859b
