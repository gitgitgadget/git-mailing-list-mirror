From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] user-manual: introduce "branch" and "branch head" differently
Date: Sun, 18 Mar 2007 23:18:01 -0400
Message-ID: <32944.991978775$1174274339@news.gmane.org>
References: <117427428145-git-send-email-> <1174274281887-git-send-email-> <11742742813855-git-send-email-> <1174274281258-git-send-email-> <11742742811304-git-send-email-> <11742742812465-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 04:18:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT8Ob-0000J6-Uw
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 04:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933797AbXCSDSM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 23:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933788AbXCSDSM
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 23:18:12 -0400
Received: from mail.fieldses.org ([66.93.2.214]:45766 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933801AbXCSDSF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 23:18:05 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HT8Nl-0003Jf-Vl; Sun, 18 Mar 2007 23:18:01 -0400
X-Mailer: git-send-email 1.5.0.3.g6c05
In-Reply-To: <11742742812465-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42570>

From: J. Bruce Fields <bfields@citi.umich.edu>

I was using "branch" to mean "head", but that's perhaps a little
sloppy; so instead start by using the terms "branch head" and "head",
while still quickly falling back on "branch", since that's what
people actually say more frequently.

Also include glossary references on the first uses of "head" and "tag".

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   43 ++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 6df5e61..3ed9f84 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -288,21 +288,22 @@ collection of files.  It stores the history as a compressed
 collection of interrelated snapshots (versions) of the project's
 contents.
 
-A single git repository may contain multiple branches.  Each branch
-is a bookmark referencing a particular point in the project history.
-The gitlink:git-branch[1] command shows you the list of branches:
+A single git repository may contain multiple branches.  It keeps track
+of them by keeping a list of <<def_head,heads>> which reference the
+latest version on each branch; the gitlink:git-branch[1] command shows
+you the list of branch heads:
 
 ------------------------------------------------
 $ git branch
 * master
 ------------------------------------------------
 
-A freshly cloned repository contains a single branch, named "master",
-and the working directory contains the version of the project
-referred to by the master branch.
+A freshly cloned repository contains a single branch head, named
+"master", and working directory is initialized to the state of
+the project referred to by "master".
 
-Most projects also use tags.  Tags, like branches, are references
-into the project's history, and can be listed using the
+Most projects also use <<def_tag,tags>>.  Tags, like heads, are
+references into the project's history, and can be listed using the
 gitlink:git-tag[1] command:
 
 ------------------------------------------------
@@ -320,9 +321,9 @@ v2.6.13
 ------------------------------------------------
 
 Tags are expected to always point at the same version of a project,
-while branches are expected to advance as development progresses.
+while heads are expected to advance as development progresses.
 
-Create a new branch pointing to one of these versions and check it
+Create a new branch head pointing to one of these versions and check it
 out using gitlink:git-checkout[1]:
 
 ------------------------------------------------
@@ -346,10 +347,10 @@ the current branch to point at v2.6.17 instead, with
 $ git reset --hard v2.6.17
 ------------------------------------------------
 
-Note that if the current branch was your only reference to a
+Note that if the current branch head was your only reference to a
 particular point in history, then resetting that branch may leave you
-with no way to find the history it used to point to; so use this
-command carefully.
+with no way to find the history it used to point to; so use this command
+carefully.
 
 Understanding History: Commits
 ------------------------------
@@ -452,17 +453,15 @@ be replaced with another letter or number.
 Understanding history: What is a branch?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Though we've been using the word "branch" to mean a kind of reference
-to a particular commit, the word branch is also commonly used to
-refer to the line of commits leading up to that point.  In the
-example above, git may think of the branch named "A" as just a
-pointer to one particular commit, but we may refer informally to the
-line of three commits leading up to that point as all being part of
+When we need to be precise, we will use the word "branch" to mean a line
+of development, and "branch head" (or just "head") to mean a reference
+to the most recent commit on a branch.  In the example above, the branch
+head named "A" is a pointer to one particular commit, but we refer to
+the line of three commits leading up to that point as all being part of
 "branch A".
 
-If we need to make it clear that we're just talking about the most
-recent commit on the branch, we may refer to that commit as the
-"head" of the branch.
+However, when no confusion will result, we often just use the term
+"branch" both for branches and for branch heads.
 
 Manipulating branches
 ---------------------
-- 
1.5.0.3.31.ge47c
