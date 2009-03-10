From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Typo and language fixes for git-checkout.txt
Date: Tue, 10 Mar 2009 16:06:30 +0100
Message-ID: <1236697590-7728-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 16:10:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh3ZU-0002Go-Ej
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 16:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115AbZCJPGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 11:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754848AbZCJPGp
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 11:06:45 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42233 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754188AbZCJPGo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2009 11:06:44 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 5109C2EE28D;
	Tue, 10 Mar 2009 11:06:42 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 10 Mar 2009 11:06:42 -0400
X-Sasl-enc: xyD42R2pq1xoIeFjK4xb6wfoGCcgxTom2eO4r9qBlwyu 1236697601
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 79267165C1;
	Tue, 10 Mar 2009 11:06:41 -0400 (EDT)
X-Mailer: git-send-email 1.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112824>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-checkout.txt |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

A few fixes for typos and speakos. I tried to be lenient, not enforcing
a different writing style esp. w.r.t. punctuation.

In the hunk about --track guess work without -b I removed the
unfortunate term "remote system" which isn't used anywhere else (and is
incorrect).

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 3bccffa..125d8f3 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,7 +8,7 @@ git-checkout - Checkout a branch or paths to the working tree
 SYNOPSIS
 --------
 [verse]
-'git checkout' [-q] [-f] [--track | --no-track] [-b <new_branch> [-l]] [-m] [<branch>]
+'git checkout' [-q] [-f] [-t | --track | --no-track] [-b <new_branch> [-l]] [-m] [<branch>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 
 DESCRIPTION
@@ -21,15 +21,15 @@ specified, <new_branch>.  Using -b will cause <new_branch> to
 be created; in this case you can use the --track or --no-track
 options, which will be passed to `git branch`.
 
-As a convenience, --track will default to create a branch whose
+As a convenience, --track will default to creating a branch whose
 name is constructed from the specified branch name by stripping
 the first namespace level.
 
 When <paths> are given, this command does *not* switch
 branches.  It updates the named paths in the working tree from
 the index file, or from a named <tree-ish> (most often a commit).  In
-this case, the `-b` options is meaningless and giving
-either of them results in an error.  <tree-ish> argument can be
+this case, the `-b` and `--track` options are meaningless and giving
+either of them results in an error. The <tree-ish> argument can be
 used to specify a specific tree-ish (i.e. commit, tag or tree)
 to update the index for the given paths before updating the
 working tree.
@@ -75,14 +75,13 @@ entries; instead, unmerged entries are ignored.
 	<repository> <refspec>" explicitly. This behavior is the default
 	when the start point is a remote branch. Set the
 	branch.autosetupmerge configuration variable to `false` if you want
-	'git-checkout' and 'git-branch' to always behave as if '--no-track' were
+	'git checkout' and 'git branch' to always behave as if '--no-track' were
 	given. Set it to `always` if you want this behavior when the
-	start-point is either a local or remote branch.
+	start point is either a local or remote branch.
 +
-If no '-b' option was given, the name of the new branch will be
-derived from the remote branch, by attempting to guess the name
-of the branch on remote system.  If "remotes/" or "refs/remotes/"
-are prefixed, it is stripped away, and then the part up to the
+If no '-b' option is given, the name of the new branch will be
+derived from the remote branch.  If "remotes/" or "refs/remotes/"
+is prefixed it is stripped away, and then the part up to the
 next slash (which would be the nickname of the remote) is removed.
 This would tell us to use "hack" as the local branch when branching
 off of "origin/hack" (or "remotes/origin/hack", or even
@@ -152,12 +151,12 @@ $ git checkout v2.6.18
 ------------
 
 Earlier versions of git did not allow this and asked you to
-create a temporary branch using `-b` option, but starting from
+create a temporary branch using the `-b` option, but starting from
 version 1.5.0, the above command 'detaches' your HEAD from the
-current branch and directly point at the commit named by the tag
-(`v2.6.18` in the above example).
+current branch and directly points at the commit named by the tag
+(`v2.6.18` in the example above).
 
-You can use usual git commands while in this state.  You can use
+You can use all git commands while in this state.  You can use
 `git reset --hard $othercommit` to further move around, for
 example.  You can make changes and create a new commit on top of
 a detached HEAD.  You can even create a merge by using `git
@@ -191,7 +190,7 @@ $ git checkout hello.c            <3>
 ------------
 +
 <1> switch branch
-<2> take out a file out of other commit
+<2> take a file out of another commit
 <3> restore hello.c from HEAD of current branch
 +
 If you have an unfortunate branch that is named `hello.c`, this
@@ -202,7 +201,7 @@ You should instead write:
 $ git checkout -- hello.c
 ------------
 
-. After working in a wrong branch, switching to the correct
+. After working in the wrong branch, switching to the correct
 branch would be done using:
 +
 ------------
@@ -210,7 +209,7 @@ $ git checkout mytopic
 ------------
 +
 However, your "wrong" branch and correct "mytopic" branch may
-differ in files that you have locally modified, in which case,
+differ in files that you have modified locally, in which case
 the above checkout would fail like this:
 +
 ------------
-- 
1.6.2
