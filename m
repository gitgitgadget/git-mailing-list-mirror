From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Convert update-index references in docs to add.
Date: Sat, 17 Feb 2007 04:43:42 -0500
Message-ID: <20070217094342.GA496@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 10:44:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIM6n-0002ke-HX
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 10:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbXBQJny (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 04:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbXBQJny
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 04:43:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35063 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965113AbXBQJnx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 04:43:53 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HIM6f-0002rQ-4g; Sat, 17 Feb 2007 04:43:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4BD7320FBAE; Sat, 17 Feb 2007 04:43:44 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39982>

Since `git add` is the approved porcelain for an end-user to invoke
when they want to manipulate the index, porcelain documentation
should steer the user to this command rather than the pure plumbing
update-index.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Maybe this isn't the best change to make.  I dunno.  I think it is
 cleaner to keep the user looking at add instead of update-index,
 but what do I know.  :-)

 Documentation/core-intro.txt    |    3 ++-
 Documentation/git-checkout.txt  |    6 +++---
 Documentation/git-merge.txt     |    2 +-
 Documentation/git-rebase.txt    |    2 +-
 Documentation/git-rerere.txt    |    3 +--
 Documentation/git-reset.txt     |    4 ++--
 Documentation/git-runstatus.txt |    2 +-
 Documentation/git-status.txt    |    2 +-
 Documentation/tutorial-2.txt    |    4 ++--
 9 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/core-intro.txt b/Documentation/core-intro.txt
index 24b060b..eea44d9 100644
--- a/Documentation/core-intro.txt
+++ b/Documentation/core-intro.txt
@@ -106,7 +106,8 @@ directory tree, and renaming a file does not change the object that
 file is associated with in any way.
 
 A blob is typically created when gitlink:git-update-index[1]
-is run, and its data can be accessed by gitlink:git-cat-file[1].
+(or gitlink:git-add[1]) is run, and its data can be accessed by
+gitlink:git-cat-file[1].
 
 Tree Object
 ~~~~~~~~~~~
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index e4ffde4..f65514e 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -61,7 +61,7 @@ OPTIONS
 +
 When a merge conflict happens, the index entries for conflicting
 paths are left unmerged, and you need to resolve the conflicts
-and mark the resolved paths with `git update-index`.
+and mark the resolved paths with `git add`.
 
 <new_branch>::
 	Name for the new branch.
@@ -179,11 +179,11 @@ fatal: merge program failed
 At this point, `git diff` shows the changes cleanly merged as in
 the previous example, as well as the changes in the conflicted
 files.  Edit and resolve the conflict and mark it resolved with
-`git update-index` as usual:
+`git add` as usual:
 +
 ------------
 $ edit frotz
-$ git update-index frotz
+$ git add frotz
 ------------
 
 
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index e53ff4b..911c69b 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -136,7 +136,7 @@ After seeing a conflict, you can do two things:
 
  * Resolve the conflicts.  `git-diff` would report only the
    conflicting paths because of the above 2. and 3..  Edit the
-   working tree files into a desirable shape, `git-update-index`
+   working tree files into a desirable shape, `git-add`
    them, to make the index file contain what the merge result
    should be, and run `git-commit` to commit the result.
 
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f2ef1f7..7110466 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -142,7 +142,7 @@ file you edit, you need to tell git that the conflict has been resolved,
 typically this would be done with
 
 
-    git update-index <filename>
+    git add <filename>
 
 
 After resolving the conflict manually and updating the index with the
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 139b6eb..7ff9b05 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -163,8 +163,7 @@ If this three-way merge resolves cleanly, the result is written
 out to your working tree file, so you would not have to manually
 resolve it.  Note that `git-rerere` leaves the index file alone,
 so you still need to do the final sanity checks with `git diff`
-(or `git diff -c`) and `git update-index` when you are
-satisfied.
+(or `git diff -c`) and `git add` when you are satisfied.
 
 As a convenience measure, `git-merge` automatically invokes
 `git-rerere` when it exits with a failed automerge, which
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 04475a9..5b55cda 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -94,11 +94,11 @@ current HEAD.
 <2> Rewind the master branch to get rid of those three commits.
 <3> Switch to "topic/wip" branch and keep working.
 
-Undo update-index::
+Undo add::
 +
 ------------
 $ edit                                     <1>
-$ git-update-index frotz.c filfre.c
+$ git add frotz.c filfre.c
 $ mailx                                    <2>
 $ git reset                                <3>
 $ git pull git://info.example.com/ nitfol  <4>
diff --git a/Documentation/git-runstatus.txt b/Documentation/git-runstatus.txt
index 89d7b92..e95662b 100644
--- a/Documentation/git-runstatus.txt
+++ b/Documentation/git-runstatus.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 Examines paths in the working tree that has changes unrecorded
 to the index file, and changes between the index file and the
 current HEAD commit.  The former paths are what you _could_
-commit by running 'git-update-index' before running 'git
+commit by running 'git add' before running 'git
 commit', and the latter paths are what you _would_ commit by
 running 'git commit'.
 
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 03871e5..e9e193f 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -15,7 +15,7 @@ DESCRIPTION
 Examines paths in the working tree that has changes unrecorded
 to the index file, and changes between the index file and the
 current HEAD commit.  The former paths are what you _could_
-commit by running 'git-update-index' before running 'git
+commit by running 'git add' before running 'git
 commit', and the latter paths are what you _would_ commit by
 running 'git commit'.
 
diff --git a/Documentation/tutorial-2.txt b/Documentation/tutorial-2.txt
index 8d89992..af8d43b 100644
--- a/Documentation/tutorial-2.txt
+++ b/Documentation/tutorial-2.txt
@@ -227,7 +227,7 @@ $ git diff
 @@ -1 +1,2 @@
  hello world!
 +hello world, again
-$ git update-index file.txt
+$ git add file.txt
 $ git diff
 ------------------------------------------------
 
@@ -260,7 +260,7 @@ hello world!
 hello world, again
 ------------------------------------------------
 
-So what our "git update-index" did was store a new blob and then put
+So what our "git add" did was store a new blob and then put
 a reference to it in the index file.  If we modify the file again,
 we'll see that the new modifications are reflected in the "git-diff"
 output:
-- 
1.5.0.552.ge1b1c
