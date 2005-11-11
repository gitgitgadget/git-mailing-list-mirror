From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: [PATCH] Change 'cache' to 'index' in the docs
Date: Fri, 11 Nov 2005 02:12:27 +0100
Organization: Chalmers
Message-ID: <4373EFFB.6060802@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net,
	=?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Fri Nov 11 02:14:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaNSu-0004wc-PO
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 02:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVKKBMH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 10 Nov 2005 20:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVKKBMH
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 20:12:07 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:38784 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932330AbVKKBMF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 20:12:05 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn1.fre.skanova.net (7.2.060.1)
        id 4368D4B90025A848; Fri, 11 Nov 2005 02:12:04 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11547>

This patch makes the documentation refer to the index
as index instead of cache, but some references still
remain. (eg. git-update-index.txt)

Signed-off-by: Lukas Sandstr=F6m <lukass@etek.chalmers.se>

---
git-update-index.txt says:
"Modifies the index or directory cache."

I thought the index was the directory cache.
Is git-update-index.txt badly worded or is there something
I'm missing?

 Documentation/diff-format.txt        |    8 ++++----
 Documentation/diff-options.txt       |    2 +-
 Documentation/git-checkout-index.txt |   14 +++++++-------
 Documentation/git-cvsimport.txt      |    2 +-
 Documentation/git-diff-files.txt     |    6 +++---
 Documentation/git-diff-index.txt     |   14 +++++++-------
 Documentation/git-fsck-objects.txt   |    4 ++--
 Documentation/git-hash-object.txt    |    2 +-
 Documentation/git-ls-files.txt       |    2 +-
 Documentation/git-merge-index.txt    |    4 ++--
 Documentation/git-read-tree.txt      |   20 ++++++++++----------
 Documentation/git-svnimport.txt      |    2 +-
 Documentation/git-update-index.txt   |   24 ++++++++++++------------
 Documentation/git-write-tree.txt     |    8 ++++----
 Documentation/git.txt                |   18 +++++++++---------
 Documentation/glossary.txt           |    6 +++---
 Documentation/tutorial.txt           |    6 +++---
 17 files changed, 71 insertions(+), 71 deletions(-)

applies-to: 6466c53ae80cddbb581c5fdb2332f9321fade867
aa312f087d645cff65c7f86c91b5232898ec4f97
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.=
txt
index d1d0d2d..b426a14 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -8,13 +8,13 @@ git-diff-index <tree-ish>::
         compares the <tree-ish> and the files on the filesystem.
=20
 git-diff-index --cached <tree-ish>::
-        compares the <tree-ish> and the cache.
+        compares the <tree-ish> and the index.
=20
 git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]::
         compares the trees named by the two arguments.
=20
 git-diff-files [<pattern>...]::
-        compares the cache and the files on the filesystem.
+        compares the index and the files on the filesystem.
=20
=20
 An output line is formatted this way:
@@ -47,7 +47,7 @@ That is, from the left to the right:
 . an LF or a NUL when '-z' option is used, to terminate the record.
=20
 <sha1> is shown as all 0's if a file is new on the filesystem
-and it is out of sync with the cache.
+and it is out of sync with the index.
=20
 Example:
=20
@@ -104,7 +104,7 @@ where:
 The file parameters can point at the user's working file
 (e.g. `new-file` in "git-diff-files"), `/dev/null` (e.g. `old-file`
 when a new file is added), or a temporary file (e.g. `old-file` in the
-cache).  'GIT_EXTERNAL_DIFF' should not worry about unlinking the
+index).  'GIT_EXTERNAL_DIFF' should not worry about unlinking the
 temporary file --- it is removed when 'GIT_EXTERNAL_DIFF' exits.
=20
 For a path that is unmerged, 'GIT_EXTERNAL_DIFF' is called with 1
diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index 32005b0..8eef86e 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -50,7 +50,7 @@
 	<orderfile>, which has one shell glob pattern per line.
=20
 -R::
-	Swap two inputs; that is, show differences from cache or
+	Swap two inputs; that is, show differences from index or
 	on-disk file to tree contents.
=20
 For more detailed explanation on these common options, see also
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-c=
heckout-index.txt
index 589dc9a..94b283a 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -3,7 +3,7 @@ git-checkout-index(1)
=20
 NAME
 ----
-git-checkout-index - Copy files from the cache to the working director=
y
+git-checkout-index - Copy files from the index to the working director=
y
=20
=20
 SYNOPSIS
@@ -13,23 +13,23 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-Will copy all files listed from the cache to the working directory
+Will copy all files listed from the index to the working directory
 (not overwriting existing files).
=20
 OPTIONS
 -------
 -u::
 	update stat information for the checked out entries in
-	the cache file.
+	the index file.
=20
 -q::
-	be quiet if files exist or are not in the cache
+	be quiet if files exist or are not in the index
=20
 -f::
 	forces overwrite of existing files
=20
 -a::
-	checks out all files in the cache.  Cannot be used
+	checks out all files in the index.  Cannot be used
 	together with explicit filenames.
=20
 -n::
@@ -57,7 +57,7 @@ supposed to be able to do things like:
=20
 which will force all existing `*.h` files to be replaced with their
 cached copies. If an empty command line implied "all", then this would
-force-refresh everything in the cache, which was not the point.
+force-refresh everything in the index, which was not the point.
=20
 To update and refresh only the files already checked out:
=20
@@ -74,7 +74,7 @@ desired tree into the index, and do a
=20
         git-checkout-index --prefix=3Dgit-export-dir/ -a
=20
-and git-checkout-index will "export" the cache into the specified
+and git-checkout-index will "export" the index into the specified
 directory.
=20
 NOTE The final "/" is important. The exported name is literally just
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimp=
ort.txt
index 4b62256..88bd3b0 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -35,7 +35,7 @@ OPTIONS
=20
 -i::
 	Import-only: don't perform a checkout after importing.  This option
-	ensures the working directory and cache remain untouched and will
+	ensures the working directory and index remain untouched and will
 	not create them if they do not exist.
=20
 -k::
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-=
files.txt
index e387388..3b04bfe 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -3,7 +3,7 @@ git-diff-files(1)
=20
 NAME
 ----
-git-diff-files - Compares files in the working tree and the cache
+git-diff-files - Compares files in the working tree and the index
=20
=20
 SYNOPSIS
@@ -12,9 +12,9 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-Compares the files in the working tree and the cache.  When paths
+Compares the files in the working tree and the index.  When paths
 are specified, compares only those named paths.  Otherwise all
-entries in the cache are compared.  The output format is the
+entries in the index are compared.  The output format is the
 same as "git-diff-index" and "git-diff-tree".
=20
 OPTIONS
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-=
index.txt
index 2fc3eed..d8fc78f 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -3,7 +3,7 @@ git-diff-index(1)
=20
 NAME
 ----
-git-diff-index - Compares content and mode of blobs between the cache =
and repository
+git-diff-index - Compares content and mode of blobs between the index =
and repository
=20
=20
 SYNOPSIS
@@ -13,10 +13,10 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Compares the content and mode of the blobs found via a tree
-object with the content of the current cache and, optionally
+object with the content of the current index and, optionally
 ignoring the stat state of the file on disk.  When paths are
 specified, compares only those named paths.  Otherwise all
-entries in the cache are compared.
+entries in the index are compared.
=20
 OPTIONS
 -------
@@ -49,11 +49,11 @@ Cached Mode
 -----------
 If '--cached' is specified, it allows you to ask:
=20
-	show me the differences between HEAD and the current cache
+	show me the differences between HEAD and the current index
 	contents (the ones I'd write with a "git-write-tree")
=20
 For example, let's say that you have worked on your working directory,=
 updated
-some files in the cache and are ready to commit. You want to see eactl=
y
+some files in the index and are ready to commit. You want to see eactl=
y
 *what* you are going to commit is without having to write a new tree
 object and compare it that way, and to do that, you just do
=20
@@ -92,7 +92,7 @@ which is obviously a very useful questio
 you *could* commit. Again, the output matches the "git-diff-tree -r"
 output to a tee, but with a twist.
=20
-The twist is that if some file doesn't match the cache, we don't have
+The twist is that if some file doesn't match the index, we don't have
 a backing store thing for it, and we use the magic "all-zero" sha1 to
 show that. So let's say that you have edited `kernel/sched.c`, but
 have not actually done a "git-update-index" on it yet - there is no
@@ -110,7 +110,7 @@ NOTE: As with other commands of this typ
 actually look at the contents of the file at all. So maybe
 `kernel/sched.c` hasn't actually changed, and it's just that you
 touched it. In either case, it's a note that you need to
-"git-upate-cache" it to make the cache be in sync.
+"git-upate-index" it to make the index be in sync.
=20
 NOTE: You can have a mixture of files show up as "has been updated"
 and "is still dirty in the working directory" together. You can always
diff --git a/Documentation/git-fsck-objects.txt b/Documentation/git-fsc=
k-objects.txt
index 5dc9dbd..37e8055 100644
--- a/Documentation/git-fsck-objects.txt
+++ b/Documentation/git-fsck-objects.txt
@@ -33,7 +33,7 @@ index file and all SHA1 references in .g
 	Report tags.
=20
 --cache::
-	Consider any object recorded in the cache also as a head node for
+	Consider any object recorded in the index also as a head node for
 	an unreachability trace.
=20
 --standalone::
@@ -125,7 +125,7 @@ GIT_OBJECT_DIRECTORY::
 	used to specify the object database root (usually $GIT_DIR/objects)
=20
 GIT_INDEX_FILE::
-	used to specify the index file of the cache
+	used to specify the index file of the index
=20
 GIT_ALTERNATE_OBJECT_DIRECTORIES::
 	used to specify additional object database roots (usually unset)
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash=
-object.txt
index 9239f11..07d2c42 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -16,7 +16,7 @@ Computes the object ID value for an obje
 with the contents of the named file (which can be outside of the
 work tree), and optionally writes the resulting object into the
 object database.  Reports its object ID to its standard output.
-This is used by "git-cvsimport" to update the cache
+This is used by "git-cvsimport" to update the index
 without modifying files in the work tree.  When <type> is not
 specified, it defaults to "blob".=20
=20
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index 8c1784d..2f308ec 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -3,7 +3,7 @@ git-ls-files(1)
=20
 NAME
 ----
-git-ls-files - Information about files in the cache/working directory
+git-ls-files - Information about files in the index/working directory
=20
=20
 SYNOPSIS
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merg=
e-index.txt
index d072fda..6030642 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -12,7 +12,7 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-This looks up the <file>(s) in the cache and, if there are any merge
+This looks up the <file>(s) in the index and, if there are any merge
 entries, passes the SHA1 hash for those files as arguments 1, 2, 3 (em=
pty
 argument if no file), and <file> as argument 4.  File modes for the th=
ree
 files are passed as arguments 5, 6 and 7.
@@ -23,7 +23,7 @@ OPTIONS
 	Interpret all following arguments as filenames.
=20
 -a::
-	Run merge against all files in the cache that need merging.
+	Run merge against all files in the index that need merging.
=20
 -o::
 	Instead of stopping at the first failed merge, do all of them
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-t=
ree.txt
index 7db5fb5..e219c6a 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -3,7 +3,7 @@ git-read-tree(1)
=20
 NAME
 ----
-git-read-tree - Reads tree information into the directory cache
+git-read-tree - Reads tree information into the index
=20
=20
 SYNOPSIS
@@ -13,11 +13,11 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-Reads the tree information given by <tree-ish> into the directory cach=
e,
+Reads the tree information given by <tree-ish> into the index,
 but does not actually *update* any of the files it "caches". (see:
 git-checkout-index)
=20
-Optionally, it can merge a tree into the cache, perform a
+Optionally, it can merge a tree into the index, perform a
 fast-forward (i.e. 2-way) merge, or a 3-way merge, with the -m
 flag.  When used with -m, the -u flag causes it to also update
 the files in the work tree with the result of the merge.
@@ -59,10 +59,10 @@ provided.
 Single Tree Merge
 ~~~~~~~~~~~~~~~~~
 If only 1 tree is specified, git-read-tree operates as if the user did=
 not
-specify '-m', except that if the original cache has an entry for a
+specify '-m', except that if the original index has an entry for a
 given pathname, and the contents of the path matches with the tree
-being read, the stat info from the cache is used. (In other words, the
-cache's stat()s take precedence over the merged tree's).
+being read, the stat info from the index is used. (In other words, the
+index's stat()s take precedence over the merged tree's).
=20
 That means that if you do a "git-read-tree -m <newtree>" followed by a
 "git-checkout-index -f -u -a", the "git-checkout-index" only checks ou=
t
@@ -96,7 +96,7 @@ Here are the "carry forward" rules:
        -------------------------------------------------------
       0 nothing             nothing  nothing  (does not happen)
       1 nothing             nothing  exists   use M
-      2 nothing             exists   nothing  remove path from cache
+      2 nothing             exists   nothing  remove path from index
       3 nothing             exists   exists   use M
=20
         clean I=3D=3DH  I=3D=3DM
@@ -109,7 +109,7 @@ Here are the "carry forward" rules:
       8 yes   N/A   no      nothing  exists   fail
       9 no    N/A   no      nothing  exists   fail
=20
-     10 yes   yes   N/A     exists   nothing  remove path from cache
+     10 yes   yes   N/A     exists   nothing  remove path from index
      11 no    yes   N/A     exists   nothing  fail
      12 yes   no    N/A     exists   nothing  fail
      13 no    no    N/A     exists   nothing  fail
@@ -128,7 +128,7 @@ Here are the "carry forward" rules:
      20 yes   yes   no      exists   exists   use M
      21 no    yes   no      exists   exists   fail
=20
-In all "keep index" cases, the cache entry stays as in the
+In all "keep index" cases, the index entry stays as in the
 original index file.  If the entry were not up to date,
 git-read-tree keeps the copy in the work tree intact when
 operating under the -u flag.
@@ -245,7 +245,7 @@ since you pulled from him:
=20
 Your work tree is still based on your HEAD ($JC), but you have
 some edits since.  Three-way merge makes sure that you have not
-added or modified cache entries since $JC, and if you haven't,
+added or modified index entries since $JC, and if you haven't,
 then does the right thing.  So with the following sequence:
=20
     $ git-read-tree -m -u `git-merge-base $JC $LT` $JC $LT
diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimp=
ort.txt
index 88bdc08..fcc79fa 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -44,7 +44,7 @@ When importing incementally, you might n
=20
 -i::
 	Import-only: don't perform a checkout after importing.  This option
-	ensures the working directory and cache remain untouched and will
+	ensures the working directory and index remain untouched and will
 	not create them if they do not exist.
=20
 -t <trunk_subdir>::
diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index 58b9e49..52874c8 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -21,7 +21,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Modifies the index or directory cache. Each file mentioned is updated
-into the cache and any 'unmerged' or 'needs updating' state is
+into the index and any 'unmerged' or 'needs updating' state is
 cleared.
=20
 The way "git-update-index" handles files it is told about can be modif=
ied
@@ -30,26 +30,26 @@ using the various options:
 OPTIONS
 -------
 --add::
-	If a specified file isn't in the cache already then it's
+	If a specified file isn't in the index already then it's
 	added.
 	Default behaviour is to ignore new files.
=20
 --remove::
-	If a specified file is in the cache but is missing then it's
+	If a specified file is in the index but is missing then it's
 	removed.
 	Default behaviour is to ignore removed file.
=20
 --refresh::
-	Looks at the current cache and checks to see if merges or
+	Looks at the current index and checks to see if merges or
 	updates are needed by checking stat() information.
=20
 -q::
-        Quiet.  If --refresh finds that the cache needs an update, the
+        Quiet.  If --refresh finds that the index needs an update, the
         default behavior is to error out.  This option makes
         git-update-index continue anyway.
=20
 --unmerged::
-        If --refresh finds unmerged changes in the cache, the default=20
+        If --refresh finds unmerged changes in the index, the default
         behavior is to error out.  This option makes git-update-index=20
         continue anyway.
=20
@@ -57,7 +57,7 @@ OPTIONS
 	Ignores missing files during a --refresh
=20
 --cacheinfo <mode> <object> <path>::
-	Directly insert the specified info into the cache.
+	Directly insert the specified info into the index.
 =09
 --index-info::
         Read index info from stdin.
@@ -68,7 +68,7 @@ OPTIONS
 --info-only::
 	Do not create objects in the object database for all
 	<file> arguments that follow this flag; just insert
-	their object IDs into the cache.
+	their object IDs into the index.
=20
 --force-remove::
 	Remove the file from the index even when the working directory
@@ -106,14 +106,14 @@ OPTIONS
=20
 Using --refresh
 ---------------
-'--refresh' does not calculate a new sha1 file or bring the cache
+'--refresh' does not calculate a new sha1 file or bring the index
 up-to-date for mode/content changes. But what it *does* do is to
-"re-match" the stat information of a file with the cache, so that you
-can refresh the cache for a file that hasn't been changed but where
+"re-match" the stat information of a file with the index, so that you
+can refresh the index for a file that hasn't been changed but where
 the stat entry is out of date.
=20
 For example, you'd want to do this after doing a "git-read-tree", to l=
ink
-up the stat cache details with the proper files.
+up the stat index details with the proper files.
=20
 Using --cacheinfo or --info-only
 --------------------------------
diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write=
-tree.txt
index 51be44d..abee05f 100644
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -3,7 +3,7 @@ git-write-tree(1)
=20
 NAME
 ----
-git-write-tree - Creates a tree object from the current cache
+git-write-tree - Creates a tree object from the current index
=20
=20
 SYNOPSIS
@@ -12,11 +12,11 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-Creates a tree object using the current cache.
+Creates a tree object using the current index.
=20
-The cache must be merged.
+The index must be merged.
=20
-Conceptually, "git-write-tree" sync()s the current directory cache con=
tents
+Conceptually, "git-write-tree" sync()s the current index contents
 into a set of tree files.
 In order to have that match what is actually in your directory right
 now, you need to have done a "git-update-index" phase before you did t=
he
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2f9622f..b7bc4fb 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -40,7 +40,7 @@ reflect recent changes.
 Commands Overview
 -----------------
 The git commands can helpfully be split into those that manipulate
-the repository, the cache and the working fileset, those that
+the repository, the index and the working fileset, those that
 interrogate and compare them, and those that moves objects and
 references between repositories.
=20
@@ -59,7 +59,7 @@ gitlink:git-apply[1]::
 	applies it to the working tree.
=20
 gitlink:git-checkout-index[1]::
-	Copy files from the cache to the working directory
+	Copy files from the index to the working directory
=20
 gitlink:git-commit-tree[1]::
 	Creates a new commit object
@@ -86,7 +86,7 @@ gitlink:git-prune-packed[1]::
 	Remove extra objects that are already in pack files.
=20
 gitlink:git-read-tree[1]::
-	Reads tree information into the directory cache
+	Reads tree information into the directory index
=20
 gitlink:git-unpack-objects[1]::
 	Unpacks objects out of a packed archive.
@@ -95,7 +95,7 @@ gitlink:git-update-index[1]::
 	Modifies the index or directory cache
=20
 gitlink:git-write-tree[1]::
-	Creates a tree from the current cache
+	Creates a tree from the current index
=20
=20
 Interrogation commands
@@ -105,10 +105,10 @@ gitlink:git-cat-file[1]::
 	Provide content or type information for repository objects
=20
 gitlink:git-diff-index[1]::
-	Compares content and mode of blobs between the cache and repository
+	Compares content and mode of blobs between the index and repository
=20
 gitlink:git-diff-files[1]::
-	Compares files in the working tree and the cache
+	Compares files in the working tree and the index
=20
 gitlink:git-diff-stages[1]::
 	Compares two "merge stages" in the index file.
@@ -120,7 +120,7 @@ gitlink:git-fsck-objects[1]::
 	Verifies the connectivity and validity of the objects in the database
=20
 gitlink:git-ls-files[1]::
-	Information about files in the cache/working directory
+	Information about files in the index/working directory
=20
 gitlink:git-ls-tree[1]::
 	Displays a tree object in human readable form
@@ -490,8 +490,8 @@ git so take care if using Cogito etc
=20
 'GIT_INDEX_FILE'::
 	This environment allows the specification of an alternate
-	cache/index file. If not specified, the default of
-	`$GIT_DIR/index` is used.
+	index file. If not specified, the default of `$GIT_DIR/index`
+	is used.
=20
 'GIT_OBJECT_DIRECTORY'::
 	If the object storage directory is specified via this
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index eb7b471..07df6b4 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -43,14 +43,14 @@ DAG::
=20
 index::
 	A collection of files with stat information, whose contents are
-	stored as objects. The cache is a stored version of your working
+	stored as objects. The index is a stored version of your working
 	tree. Truth be told, it can also contain a second, and even a third
 	version of a working tree, which are used when merging.
=20
 index entry::
 	The information regarding a particular file, stored in the index.
 	An index entry can be unmerged, if a merge was started, but not
-	yet finished (i.e. if the cache contains multiple versions of
+	yet finished (i.e. if the index contains multiple versions of
 	that file).
=20
 unmerged index:
@@ -75,7 +75,7 @@ checkout::
 	stored in the object database.
=20
 commit::
-	As a verb: The action of storing the current state of the cache in th=
e
+	As a verb: The action of storing the current state of the index in th=
e
 	object database. The result is a revision.
 	As a noun: Short hand for commit object.
=20
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 95ed852..03eb421 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -131,7 +131,7 @@ actually check in your hard work, you wi
 The first step is trivial: when you want to tell git about any changes
 to your working tree, you use the `git-update-index` program. That
 program normally just takes a list of filenames you want to update, bu=
t
-to avoid trivial mistakes, it refuses to add new entries to the cache
+to avoid trivial mistakes, it refuses to add new entries to the index
 (or remove existing ones) unless you explicitly tell it that you're
 adding a new entry with the `\--add` flag (or removing an entry with t=
he
 `\--remove`) flag.
@@ -199,7 +199,7 @@ was just to show that `git-update-index`
 actually saved away the contents of your files into the git object
 database.
=20
-Updating the cache did something else too: it created a `.git/index`
+Updating the index did something else too: it created a `.git/index`
 file. This is the index that describes your current working tree, and
 something you should be very aware of. Again, you normally never worry
 about the index file itself, but you should be aware of the fact that
@@ -440,7 +440,7 @@ a bit about what you have done.
 Write whatever message you want, and all the lines that start with '#'
 will be pruned out, and the rest will be used as the commit message fo=
r
 the change. If you decide you don't want to commit anything after all =
at
-this point (you can continue to edit things and update the cache), you
+this point (you can continue to edit things and update the index), you
 can just leave an empty message. Otherwise `git commit` will commit
 the change for you.
=20
---
0.99.9.GIT
