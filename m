From: Sebastian Kuzminsky <seb@highlab.com>
Subject: documentation polish
Date: Fri, 03 Jun 2005 01:13:19 -0600
Message-ID: <E1De6Mp-0001AD-OQ@highlab.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 09:13:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1De6L6-0007vG-Iw
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 09:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVFCHOg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 03:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVFCHOg
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 03:14:36 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:14809 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261164AbVFCHLj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 03:11:39 -0400
Received: from highlab.com ([24.8.179.27])
          by comcast.net (sccrmhc14) with ESMTP
          id <2005060307113801400dkscue>; Fri, 3 Jun 2005 07:11:38 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1De6Mp-0001AD-OQ
	for git@vger.kernel.org; Fri, 03 Jun 2005 01:13:19 -0600
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This large but repetitive patch polishes the docs a bit.  It does not
touch any files outside the Documentation directory.


It's against cogito-0.11.1, I can split it out into separate patches
for git and cogito if people want - let me know.


Here's the change list:

    Added a txt target to Documentation/Makefile, to explicitly make
    cogito.txt and the cg-*.txt files.

    Fixed what looked like a typo in Documentation/git-commit-tree.txt

    Fixed an incorrect manpage section in Documentation/make-cg-asciidoc

    The git and cogito manpages have links to other manpages, and
    those links are often missing the section, (1) or (7).  Fixed that
    everywhere it seemed appropriate.




 Makefile                      |    4 +
 git-apply-patch-script.txt    |    2 
 git-cat-file.txt              |    2 
 git-check-files.txt           |    4 -
 git-checkout-cache.txt        |    2 
 git-commit-tree.txt           |    6 +-
 git-convert-cache.txt         |    2 
 git-diff-cache.txt            |    2 
 git-diff-files.txt            |    2 
 git-diff-helper.txt           |    4 -
 git-diff-tree.txt             |    2 
 git-export.txt                |    2 
 git-fsck-cache.txt            |    2 
 git-http-pull.txt             |    2 
 git-init-db.txt               |    2 
 git-local-pull.txt            |    2 
 git-ls-files.txt              |    2 
 git-ls-tree.txt               |    2 
 git-merge-base.txt            |    2 
 git-merge-cache.txt           |    2 
 git-merge-one-file-script.txt |    2 
 git-mkdelta.txt               |    2 
 git-mktag.txt                 |    2 
 git-prune-script.txt          |    2 
 git-pull-script.txt           |    2 
 git-read-tree.txt             |    4 -
 git-resolve-script.txt        |    2 
 git-rev-list.txt              |    2 
 git-rev-tree.txt              |    2 
 git-rpull.txt                 |    2 
 git-rpush.txt                 |    2 
 git-tag-script.txt            |    2 
 git-tar-tree.txt              |    2 
 git-unpack-file.txt           |    2 
 git-update-cache.txt          |    2 
 git-write-blob.txt            |    2 
 git-write-tree.txt            |    2 
 git.txt                       |   86 +++++++++++++++++++++---------------------
 make-cg-asciidoc              |    4 -
 make-cogito-asciidoc          |   19 ++++++---
 40 files changed, 102 insertions(+), 93 deletions(-)


diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -18,7 +18,9 @@ DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT
 # yourself - yes, all 6 characters of it!
 #
 
-all: html man
+all: txt html man
+
+txt: $(MAN1_TXT) $(MAN7_TXT)
 
 html: $(DOC_HTML)
 
diff --git a/Documentation/git-apply-patch-script.txt b/Documentation/git-apply-patch-script.txt
--- a/Documentation/git-apply-patch-script.txt
+++ b/Documentation/git-apply-patch-script.txt
@@ -28,5 +28,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -51,5 +51,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-check-files.txt b/Documentation/git-check-files.txt
--- a/Documentation/git-check-files.txt
+++ b/Documentation/git-check-files.txt
@@ -33,7 +33,7 @@ up-to-date.
 
 See Also
 --------
-link:git-update-cache.html[git-update-cache]
+link:git-update-cache.html[git-update-cache(1)]
 
 
 Author
@@ -46,5 +46,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-checkout-cache.txt b/Documentation/git-checkout-cache.txt
--- a/Documentation/git-checkout-cache.txt
+++ b/Documentation/git-checkout-cache.txt
@@ -102,5 +102,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -9,7 +9,7 @@ git-commit-tree - Creates a new commit o
 
 SYNOPSIS
 --------
-'git-commit-tree' <tree> [-p <parent commit>]\   < changelog
+'git-commit-tree' <tree> [-p <parent commit>]  < changelog
 
 DESCRIPTION
 -----------
@@ -71,7 +71,7 @@ You don't exist. Go away!::
 
 See Also
 --------
-link:git-write-tree.html[git-write-tree]
+link:git-write-tree.html[git-write-tree(1)]
 
 
 Author
@@ -84,5 +84,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-convert-cache.txt b/Documentation/git-convert-cache.txt
--- a/Documentation/git-convert-cache.txt
+++ b/Documentation/git-convert-cache.txt
@@ -26,5 +26,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-diff-cache.txt b/Documentation/git-diff-cache.txt
--- a/Documentation/git-diff-cache.txt
+++ b/Documentation/git-diff-cache.txt
@@ -163,5 +163,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -71,5 +71,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-diff-helper.txt b/Documentation/git-diff-helper.txt
--- a/Documentation/git-diff-helper.txt
+++ b/Documentation/git-diff-helper.txt
@@ -27,7 +27,7 @@ OPTIONS
 
 See Also
 --------
-The section on generating patches in link:git-diff-cache.html[git-diff-cache]
+The section on generating patches in link:git-diff-cache.html[git-diff-cache(1)]
 
 
 Author
@@ -41,5 +41,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -153,5 +153,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-export.txt b/Documentation/git-export.txt
--- a/Documentation/git-export.txt
+++ b/Documentation/git-export.txt
@@ -27,5 +27,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-fsck-cache.txt b/Documentation/git-fsck-cache.txt
--- a/Documentation/git-fsck-cache.txt
+++ b/Documentation/git-fsck-cache.txt
@@ -124,5 +124,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-http-pull.txt b/Documentation/git-http-pull.txt
--- a/Documentation/git-http-pull.txt
+++ b/Documentation/git-http-pull.txt
@@ -35,5 +35,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -36,5 +36,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-local-pull.txt b/Documentation/git-local-pull.txt
--- a/Documentation/git-local-pull.txt
+++ b/Documentation/git-local-pull.txt
@@ -36,5 +36,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -104,5 +104,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -51,5 +51,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -30,5 +30,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-merge-cache.txt b/Documentation/git-merge-cache.txt
--- a/Documentation/git-merge-cache.txt
+++ b/Documentation/git-merge-cache.txt
@@ -80,5 +80,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-merge-one-file-script.txt b/Documentation/git-merge-one-file-script.txt
--- a/Documentation/git-merge-one-file-script.txt
+++ b/Documentation/git-merge-one-file-script.txt
@@ -26,5 +26,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-mkdelta.txt b/Documentation/git-mkdelta.txt
--- a/Documentation/git-mkdelta.txt
+++ b/Documentation/git-mkdelta.txt
@@ -41,5 +41,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -44,5 +44,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-prune-script.txt b/Documentation/git-prune-script.txt
--- a/Documentation/git-prune-script.txt
+++ b/Documentation/git-prune-script.txt
@@ -28,5 +28,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-pull-script.txt b/Documentation/git-pull-script.txt
--- a/Documentation/git-pull-script.txt
+++ b/Documentation/git-pull-script.txt
@@ -27,5 +27,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -135,7 +135,7 @@ and never used.
 
 See Also
 --------
-link:git-write-tree.html[git-write-tree]; link:git-ls-files.html[git-ls-files]
+link:git-write-tree.html[git-write-tree(1)]; link:git-ls-files.html[git-ls-files(1)]
 
 
 Author
@@ -148,5 +148,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-resolve-script.txt b/Documentation/git-resolve-script.txt
--- a/Documentation/git-resolve-script.txt
+++ b/Documentation/git-resolve-script.txt
@@ -26,5 +26,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -28,5 +28,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-rev-tree.txt b/Documentation/git-rev-tree.txt
--- a/Documentation/git-rev-tree.txt
+++ b/Documentation/git-rev-tree.txt
@@ -84,5 +84,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-rpull.txt b/Documentation/git-rpull.txt
--- a/Documentation/git-rpull.txt
+++ b/Documentation/git-rpull.txt
@@ -39,5 +39,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-rpush.txt b/Documentation/git-rpush.txt
--- a/Documentation/git-rpush.txt
+++ b/Documentation/git-rpush.txt
@@ -26,5 +26,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-tag-script.txt b/Documentation/git-tag-script.txt
--- a/Documentation/git-tag-script.txt
+++ b/Documentation/git-tag-script.txt
@@ -28,5 +28,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -28,5 +28,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.txt
--- a/Documentation/git-unpack-file.txt
+++ b/Documentation/git-unpack-file.txt
@@ -33,5 +33,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-update-cache.txt b/Documentation/git-update-cache.txt
--- a/Documentation/git-update-cache.txt
+++ b/Documentation/git-update-cache.txt
@@ -104,5 +104,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-write-blob.txt b/Documentation/git-write-blob.txt
--- a/Documentation/git-write-blob.txt
+++ b/Documentation/git-write-blob.txt
@@ -29,5 +29,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write-tree.txt
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -48,5 +48,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -18,8 +18,8 @@ This is reference information for the co
 
 The Discussion section below contains much useful definition and
 clarification info - read that first.  And of the commands, I suggest
-reading link:git-update-cache.html[git-update-cache] and
-link:git-read-tree.html[git-read-tree] first - I wish I had!
+reading link:git-update-cache.html[git-update-cache(1)] and
+link:git-read-tree.html[git-read-tree(1)] first - I wish I had!
 
 David Greaves <david@dgreaves.com>
 08/05/05
@@ -39,78 +39,78 @@ SCMs layered over git.
 
 Manipulation commands
 ~~~~~~~~~~~~~~~~~~~~~
-link:git-checkout-cache.html[git-checkout-cache]::
+link:git-checkout-cache.html[git-checkout-cache(1)]::
 	Copy files from the cache to the working directory
 
-link:git-commit-tree.html[git-commit-tree]::
+link:git-commit-tree.html[git-commit-tree(1)]::
 	Creates a new commit object
 
-link:git-init-db.html[git-init-db]::
+link:git-init-db.html[git-init-db(1)]::
 	Creates an empty git object database
 
-link:git-merge-base.html[git-merge-base]::
+link:git-merge-base.html[git-merge-base(1)]::
 	Finds as good a common ancestor as possible for a merge
 
-link:git-mkdelta.html[git-mkdelta]::
+link:git-mkdelta.html[git-mkdelta(1)]::
 	Creates a delta object
 
-link:git-mktag.html[git-mktag]::
+link:git-mktag.html[git-mktag(1)]::
 	Creates a tag object
 
-link:git-read-tree.html[git-read-tree]::
+link:git-read-tree.html[git-read-tree(1)]::
 	Reads tree information into the directory cache
 
-link:git-update-cache.html[git-update-cache]::
+link:git-update-cache.html[git-update-cache(1)]::
 	Modifies the index or directory cache
 
-link:git-write-blob.html[git-write-blob]::
+link:git-write-blob.html[git-write-blob(1)]::
 	Creates a blob from a file
 
-link:git-write-tree.html[git-write-tree]::
+link:git-write-tree.html[git-write-tree(1)]::
 	Creates a tree from the current cache
 
 Interrogation commands
 ~~~~~~~~~~~~~~~~~~~~~~
-link:git-cat-file.html[git-cat-file]::
+link:git-cat-file.html[git-cat-file(1)]::
 	Provide content or type information for repository objects
 
-link:git-check-files.html[git-check-files]::
+link:git-check-files.html[git-check-files(1)]::
 	Verify a list of files are up-to-date
 
-link:git-diff-cache.html[git-diff-cache]::
+link:git-diff-cache.html[git-diff-cache(1)]::
 	Compares content and mode of blobs between the cache and repository
 
-link:git-diff-files.html[git-diff-files]::
+link:git-diff-files.html[git-diff-files(1)]::
 	Compares files in the working tree and the cache
 
-link:git-diff-tree.html[git-diff-tree]::
+link:git-diff-tree.html[git-diff-tree(1)]::
 	Compares the content and mode of blobs found via two tree objects
 
-link:git-export.html[git-export]::
+link:git-export.html[git-export(1)]::
 	Exports each commit and a diff against each of its parents
 
-link:git-fsck-cache.html[git-fsck-cache]::
+link:git-fsck-cache.html[git-fsck-cache(1)]::
 	Verifies the connectivity and validity of the objects in the database
 
-link:git-ls-files.html[git-ls-files]::
+link:git-ls-files.html[git-ls-files(1)]::
 	Information about files in the cache/working directory
 
-link:git-ls-tree.html[git-ls-tree]::
+link:git-ls-tree.html[git-ls-tree(1)]::
 	Displays a tree object in human readable form
 
-link:git-merge-cache.html[git-merge-cache]::
+link:git-merge-cache.html[git-merge-cache(1)]::
 	Runs a merge for files needing merging
 
-link:git-rev-list.html[git-rev-list]::
+link:git-rev-list.html[git-rev-list(1)]::
 	Lists commit objects in reverse chronological order
 
-link:git-rev-tree.html[git-rev-tree]::
+link:git-rev-tree.html[git-rev-tree(1)]::
 	Provides the revision tree for one or more commits
 
-link:git-tar-tree.html[git-tar-tree]::
+link:git-tar-tree.html[git-tar-tree(1)]::
 	Creates a tar archive of the files in the named tree
 
-link:git-unpack-file.html[git-unpack-file]::
+link:git-unpack-file.html[git-unpack-file(1)]::
 	Creates a temporary file with a blob's contents
 
 The interrogate commands may create files - and you can force them to
@@ -121,42 +121,42 @@ Ancilliary Commands
 -------------------
 Manipulators:
 
-link:git-apply-patch-script.html[git-apply-patch-script]::
+link:git-apply-patch-script.html[git-apply-patch-script(1)]::
 	Sample script to apply the diffs from git-diff-*
 
-link:git-convert-cache.html[git-convert-cache]::
+link:git-convert-cache.html[git-convert-cache(1)]::
 	Converts old-style GIT repository
 
-link:git-http-pull.html[git-http-pull]::
+link:git-http-pull.html[git-http-pull(1)]::
 	Downloads a remote GIT repository via HTTP
 
-link:git-local-pull.html[git-local-pull]::
+link:git-local-pull.html[git-local-pull(1)]::
 	Duplicates another GIT repository on a local system
 
-link:git-merge-one-file-script.html[git-merge-one-file-script]::
+link:git-merge-one-file-script.html[git-merge-one-file-script(1)]::
 	The standard helper program to use with "git-merge-cache"
 
-link:git-pull-script.html[git-pull-script]::
+link:git-pull-script.html[git-pull-script(1)]::
 	Script used by Linus to pull and merge a remote repository
 
-link:git-prune-script.html[git-prune-script]::
+link:git-prune-script.html[git-prune-script(1)]::
 	Prunes all unreachable objects from the object database
 
-link:git-resolve-script.html[git-resolve-script]::
+link:git-resolve-script.html[git-resolve-script(1)]::
 	Script used to merge two trees
 
-link:git-tag-script.html[git-tag-script]::
+link:git-tag-script.html[git-tag-script(1)]::
 	An example script to create a tag object signed with GPG
 
-link:git-rpull.html[git-rpull]::
+link:git-rpull.html[git-rpull(1)]::
 	Pulls from a remote repository over ssh connection
 
 Interogators:
 
-link:git-diff-helper.html[git-diff-helper]::
+link:git-diff-helper.html[git-diff-helper(1)]::
 	Generates patch format output for git-diff-*
 
-link:git-rpush.html[git-rpush]::
+link:git-rpush.html[git-rpush(1)]::
 	Helper "server-side" program used by git-rpull
 
 
@@ -279,16 +279,16 @@ git Commits
 'GIT_AUTHOR_DATE'::
 'GIT_COMMITTER_NAME'::
 'GIT_COMMITTER_EMAIL'::
-	see link:git-commit-tree.html[git-commit-tree]
+	see link:git-commit-tree.html[git-commit-tree(1)]
 
 git Diffs
 ~~~~~~~~~
 'GIT_DIFF_OPTS'::
 'GIT_EXTERNAL_DIFF'::
 	see the "generating patches" section in :
-	link:git-diff-cache.html[git-diff-cache];
-	link:git-diff-files.html[git-diff-files];
-	link:git-diff-tree.html[git-diff-tree]
+	link:git-diff-cache.html[git-diff-cache(1)];
+	link:git-diff-files.html[git-diff-files(1)];
+	link:git-diff-tree.html[git-diff-tree(1)]
 
 Discussion
 ----------
@@ -304,5 +304,5 @@ Documentation by David Greaves, Junio C 
 
 GIT
 ---
-Part of the link:git.html[git] suite
+Part of the link:git.html[git(7)] suite
 
diff --git a/Documentation/make-cg-asciidoc b/Documentation/make-cg-asciidoc
--- a/Documentation/make-cg-asciidoc
+++ b/Documentation/make-cg-asciidoc
@@ -40,7 +40,7 @@ CAPTION=$(echo "$HEADER" | head -n 1 | t
 # were referenced as "`cg-command`". This way references from cg-* combos in
 # code listings will be ignored.
 BODY=$(echo "$HEADER" | sed '0,/^$/d' \
-		      | sed 's/`\(cg-[a-z-]\+\)`/link:\1.html[\1]/')
+		      | sed 's/`\(cg-[a-z-]\+\)`/link:\1.html[\1(1)]/')
 
 DESCRIPTION=
 OPTIONS=
@@ -109,5 +109,5 @@ $COPYRIGHT
 SEE ALSO
 --------
 $COMMAND command is part of link:cogito.html[cogito(7)],
-a toolkit for managing link:git.html[git(1)] trees.
+a toolkit for managing link:git.html[git(7)] trees.
 __END__
diff --git a/Documentation/make-cogito-asciidoc b/Documentation/make-cogito-asciidoc
--- a/Documentation/make-cogito-asciidoc
+++ b/Documentation/make-cogito-asciidoc
@@ -11,7 +11,14 @@ HELPER_COMMANDS="$(ls ../cg-X*) $(ls ../
 link()
 {
 	command="$1"
-	echo "link:$command.html['$command']"
+
+        if [ ! -z "$2" ]; then
+            section="($2)"
+        else
+            section=""
+        fi
+
+	echo "link:$command.html['$command$section']"
 }
 
 # Print description list entry.
@@ -62,7 +69,7 @@ storage system. Amongst some of the note
 for branching, tagging and multiple backends for distributing repositories
 (local files, rsync, HTTP, ssh).
 
-'Cogito' is implemented as a series of 'bash(1)' scripts on top of $(link git)
+'Cogito' is implemented as a series of 'bash(1)' scripts on top of $(link git 7)
 (a content-tracking filesystem) with the goal of providing an interface for
 working with the 'GIT' database in a manner similar to other SCM tools (like
 'CVS', 'BitKeeper' or 'Monotone').
@@ -107,21 +114,21 @@ $(print_command_listing $HELPER_COMMANDS
 Command Identifiers
 -------------------
 BRANCH_NAME::
-	Indicates a branch name added with the $(link cg-branch-add) command.
+	Indicates a branch name added with the $(link cg-branch-add 1) command.
 
 COMMAND::
 	Indicates a 'Cogito' command. The \`cg-\` prefix is optional.
 
 LOCATION::
-	Indicates a local file path or a URI. See $(link cg-branch-add) for a
+	Indicates a local file path or a URI. See $(link cg-branch-add 1) for a
 	list of supported URI schemes.
 
 COMMIT_ID, FROM_ID, TO_ID, BASE_COMMIT::
 	Indicates an ID resolving to a commit. The following expressions can
 	be used interchangably as IDs:
 	- empty string, 'this' or 'HEAD' (current HEAD)
-	- branch name (as registered with $(link cg-branch-add))
-	- tag name (as registered with $(link cg-tag))
+	- branch name (as registered with $(link cg-branch-add 1))
+	- tag name (as registered with $(link cg-tag 1))
 	- shortcut object hash (shorted unambiguous hash lead)
 	- commit object hash (as returned by 'commit-id')
 	- tree object hash (as returned by 'tree-id')


-- 
Sebastian Kuzminsky
