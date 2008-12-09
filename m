From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Improve language in git-merge.txt and related docs
Date: Tue, 9 Dec 2008 07:23:51 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20081209062350.GA1118@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 07:31:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9w7v-0004qG-8V
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 07:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbYLIGX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 01:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbYLIGX7
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 01:23:59 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:48913 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbYLIGX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 01:23:58 -0500
Received: from localhost.localdomain (xdsl-87-78-133-151.netcologne.de [87.78.133.151])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 329C2400031D1
	for <git@vger.kernel.org>; Tue,  9 Dec 2008 07:23:55 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1L9w0d-0000UX-LT
	for git@vger.kernel.org; Tue, 09 Dec 2008 07:23:51 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102601>

Improve some minor language and format issues like hyphenation,
phrases, spacing, word order, comma, attributes.
---

Hello,

Upon rereading git-merge*.txt, I noticed some language warts
and started fixing some minor issues.  Please note that the
diff contains conflict markers as part of the text explaining
those markers; they will cause the standard commit hook to
complain.

I've tried to be consistent in that I searched Documentation/
for other instances of errors that I found and fixed them, too.

Patch is against master; please ping me if you'd like it split
up in some way.

Thanks,
Ralf

 Documentation/git-fast-export.txt |    2 +-
 Documentation/git-merge-base.txt  |   19 +++++++++----------
 Documentation/git-merge-file.txt  |   12 ++++++------
 Documentation/git-merge-index.txt |    6 +++---
 Documentation/git-merge-tree.txt  |    6 +++---
 Documentation/git-merge.txt       |   34 +++++++++++++++++-----------------
 Documentation/git-mergetool.txt   |    4 ++--
 Documentation/merge-config.txt    |   12 ++++++------
 Documentation/merge-options.txt   |    2 +-
 9 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index b974e21..99a1c31 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -15,7 +15,7 @@ DESCRIPTION
 This program dumps the given revisions in a form suitable to be piped
 into 'git-fast-import'.
 
-You can use it as a human readable bundle replacement (see
+You can use it as a human-readable bundle replacement (see
 linkgit:git-bundle[1]), or as a kind of an interactive
 'git-filter-branch'.
 
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 2f0c525..767486c 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -16,15 +16,15 @@ DESCRIPTION
 'git-merge-base' finds best common ancestor(s) between two commits to use
 in a three-way merge.  One common ancestor is 'better' than another common
 ancestor if the latter is an ancestor of the former.  A common ancestor
-that does not have any better common ancestor than it is a 'best common
+that does not have any better common ancestor is a 'best common
 ancestor', i.e. a 'merge base'.  Note that there can be more than one
-merge bases between two commits.
+merge base for a pair of commits.
 
-Among the two commits to compute their merge bases, one is specified by
+Among the two commits to compute the merge base from, one is specified by
 the first commit argument on the command line; the other commit is a
 (possibly hypothetical) commit that is a merge across all the remaining
-commits on the command line.  As the most common special case, giving only
-two commits from the command line means computing the merge base between
+commits on the command line.  As the most common special case, specifying only
+two commits on the command line means computing the merge base between
 the given two commits.
 
 OPTIONS
@@ -47,7 +47,7 @@ For example, with this topology:
 the merge base between 'A' and 'B' is '1'.
 
 Given three commits 'A', 'B' and 'C', `git merge-base A B C` will compute the
-merge base between 'A' and an hypothetical commit 'M', which is a merge
+merge base between 'A' and a hypothetical commit 'M', which is a merge
 between 'B' and 'C'.  For example, with this topology:
 
 	       o---o---o---o---C
@@ -71,8 +71,7 @@ common ancestor between 'A' and 'M', but '1' is a better common ancestor,
 because '2' is an ancestor of '1'.  Hence, '2' is not a merge base.
 
 When the history involves criss-cross merges, there can be more than one
-'best' common ancestors between two commits.  For example, with this
-topology:
+'best' common ancestor for two commits.  For example, with this topology:
 
        ---1---o---A
 	   \ /
@@ -80,8 +79,8 @@ topology:
 	   / \
        ---2---o---o---B
 
-both '1' and '2' are merge-base of A and B.  Neither one is better than
-the other (both are 'best' merge base).  When `--all` option is not given,
+both '1' and '2' are merge-bases of A and B.  Neither one is better than
+the other (both are 'best' merge bases).  When the `--all` option is not given,
 it is unspecified which best one is output.
 
 Author
diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index 024ec01..3035373 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -15,17 +15,17 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-'git-file-merge' incorporates all changes that lead from the `<base-file>`
+'git-merge-file' incorporates all changes that lead from the `<base-file>`
 to `<other-file>` into `<current-file>`. The result ordinarily goes into
 `<current-file>`. 'git-merge-file' is useful for combining separate changes
 to an original. Suppose `<base-file>` is the original, and both
-`<current-file>` and `<other-file>` are modifications of `<base-file>`.
-Then 'git-merge-file' combines both changes.
+`<current-file>` and `<other-file>` are modifications of `<base-file>`,
+then 'git-merge-file' combines both changes.
 
 A conflict occurs if both `<current-file>` and `<other-file>` have changes
 in a common segment of lines. If a conflict is found, 'git-merge-file'
-normally outputs a warning and brackets the conflict with <<<<<<< and
->>>>>>> lines. A typical conflict will look like this:
+normally outputs a warning and brackets the conflict with lines containing
+<<<<<<< and >>>>>>> markers. A typical conflict will look like this:
 
 	<<<<<<< A
 	lines in file A
@@ -60,7 +60,7 @@ OPTIONS
 	`<current-file>`.
 
 -q::
-	Quiet;  do  not  warn about conflicts.
+	Quiet; do not warn about conflicts.
 
 
 EXAMPLES
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index ff088c5..123e6d0 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -29,11 +29,11 @@ OPTIONS
 	Instead of stopping at the first failed merge, do all of them
 	in one shot - continue with merging even when previous merges
 	returned errors, and only return the error code after all the
-	merges are over.
+	merges.
 
 -q::
-	Do not complain about failed merge program (the merge program
-	failure usually indicates conflicts during merge). This is for
+	Do not complain about a failed merge program (a merge program
+	failure usually indicates conflicts during the merge). This is for
 	porcelains which might want to emit custom messages.
 
 If 'git-merge-index' is called with multiple <file>s (or -a) then it
diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index dbb0c18..f869a7f 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -14,14 +14,14 @@ DESCRIPTION
 -----------
 Reads three treeish, and output trivial merge results and
 conflicting stages to the standard output.  This is similar to
-what three-way read-tree -m does, but instead of storing the
+what three-way 'git read-tree -m' does, but instead of storing the
 results in the index, the command outputs the entries to the
 standard output.
 
 This is meant to be used by higher level scripts to compute
-merge results outside index, and stuff the results back into the
+merge results outside of the index, and stuff the results back into the
 index.  For this reason, the output from the command omits
-entries that match <branch1> tree.
+entries that match the <branch1> tree.
 
 Author
 ------
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 1f30830..f7be584 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -69,20 +69,20 @@ Three kinds of merge can happen:
   simplest case, called "Already up-to-date."
 
 * `HEAD` is already contained in the merged commit. This is the
-  most common case especially when involved through 'git pull':
-  you are tracking an upstream repository, committed no local
+  most common case especially when invoked from 'git pull':
+  you are tracking an upstream repository, have committed no local
   changes and now you want to update to a newer upstream revision.
-  Your `HEAD` (and the index) is updated to at point the merged
+  Your `HEAD` (and the index) is updated to point at the merged
   commit, without creating an extra merge commit.  This is
   called "Fast-forward".
 
 * Both the merged commit and `HEAD` are independent and must be
-  tied together by a merge commit that has them both as its parents.
+  tied together by a merge commit that has both of them as its parents.
   The rest of this section describes this "True merge" case.
 
 The chosen merge strategy merges the two commits into a single
 new source tree.
-When things cleanly merge, these things happen:
+When things merge cleanly, this is what happens:
 
 1. The results are updated both in the index file and in your
    working tree;
@@ -91,16 +91,16 @@ When things cleanly merge, these things happen:
 4. The `HEAD` pointer gets advanced.
 
 Because of 2., we require that the original state of the index
-file to match exactly the current `HEAD` commit; otherwise we
+file matches exactly the current `HEAD` commit; otherwise we
 will write out your local changes already registered in your
 index file along with the merge result, which is not good.
-Because 1. involves only the paths different between your
+Because 1. involves only those paths differing between your
 branch and the remote branch you are pulling from during the
 merge (which is typically a fraction of the whole tree), you can
 have local modifications in your working tree as long as they do
 not overlap with what the merge updates.
 
-When there are conflicts, these things happen:
+When there are conflicts, the following happens:
 
 1. `HEAD` stays the same.
 
@@ -111,8 +111,8 @@ When there are conflicts, these things happen:
    versions; stage1 stores the version from the common ancestor,
    stage2 from `HEAD`, and stage3 from the remote branch (you
    can inspect the stages with `git ls-files -u`).  The working
-   tree files have the result of "merge" program; i.e. 3-way
-   merge result with familiar conflict markers `<<< === >>>`.
+   tree files contain the result of the "merge" program; i.e. 3-way
+   merge results with familiar conflict markers `<<< === >>>`.
 
 4. No other changes are done.  In particular, the local
    modifications you had before you started merge will stay the
@@ -145,13 +145,13 @@ Git makes conflict resolution easy.
 And here is another line that is cleanly resolved or unmodified.
 ------------
 
-The area a pair of conflicting changes happened is marked with markers
+The area where a pair of conflicting changes happened is marked with markers
 "`<<<<<<<`", "`=======`", and "`>>>>>>>`".  The part before the "`=======`"
-is typically your side, and the part after it is typically their side.
+is typically your side, and the part afterwards is typically their side.
 
-The default format does not show what the original said in the conflicted
-area.  You cannot tell how many lines are deleted and replaced with the
-Barbie's remark by your side.  The only thing you can tell is that your
+The default format does not show what the original said in the conflicting
+area.  You cannot tell how many lines are deleted and replaced with
+Barbie's remark on your side.  The only thing you can tell is that your
 side wants to say it is hard and you'd prefer to go shopping, while the
 other side wants to claim it is easy.
 
@@ -186,14 +186,14 @@ HOW TO RESOLVE CONFLICTS
 
 After seeing a conflict, you can do two things:
 
- * Decide not to merge.  The only clean-up you need are to reset
+ * Decide not to merge.  The only clean-ups you need are to reset
    the index file to the `HEAD` commit to reverse 2. and to clean
    up working tree changes made by 2. and 3.; 'git-reset --hard' can
    be used for this.
 
  * Resolve the conflicts.  Git will mark the conflicts in
    the working tree.  Edit the files into shape and
-   'git-add' to the index.  'git-commit' to seal the deal.
+   'git-add' them to the index.  Use 'git-commit' to seal the deal.
 
 You can work through the conflict with a number of tools:
 
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index e0b2703..602e7c6 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -38,7 +38,7 @@ can configure the absolute path to kdiff3 by setting
 `mergetool.kdiff3.path`. Otherwise, 'git-mergetool' assumes the
 tool is available in PATH.
 +
-Instead of running one of the known merge tool programs
+Instead of running one of the known merge tool programs,
 'git-mergetool' can be customized to run an alternative program
 by specifying the command line to invoke in a configuration
 variable `mergetool.<tool>.cmd`.
@@ -55,7 +55,7 @@ of the file to which the merge tool should write the result of the
 merge resolution.
 +
 If the custom merge tool correctly indicates the success of a
-merge resolution with its exit code then the configuration
+merge resolution with its exit code, then the configuration
 variable `mergetool.<tool>.trustExitCode` can be set to `true`.
 Otherwise, 'git-mergetool' will prompt the user to indicate the
 success of the resolution after the custom tool has exited.
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 86d5b26..1ff08ff 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -1,10 +1,10 @@
 merge.conflictstyle::
 	Specify the style in which conflicted hunks are written out to
 	working tree files upon merge.  The default is "merge", which
-	shows `<<<<<<<` conflict marker, change made by one side,
-	`=======` marker, change made by the other side, and then
-	`>>>>>>>` marker.  An alternate style, "diff3", adds `|||||||`
-	marker and the original text before `=======` marker.
+	shows a `<<<<<<<` conflict marker, changes made by one side,
+	a `=======` marker, changes made by the other side, and then
+	a `>>>>>>>` marker.  An alternate style, "diff3", adds a `|||||||`
+	marker and the original text before the `=======` marker.
 
 merge.log::
 	Whether to include summaries of merged commits in newly created
@@ -32,10 +32,10 @@ merge.verbosity::
 	message if conflicts were detected. Level 1 outputs only
 	conflicts, 2 outputs conflicts and file changes.  Level 5 and
 	above outputs debugging information.  The default is level 2.
-	Can be overridden by 'GIT_MERGE_VERBOSITY' environment variable.
+	Can be overridden by the 'GIT_MERGE_VERBOSITY' environment variable.
 
 merge.<driver>.name::
-	Defines a human readable name for a custom low-level
+	Defines a human-readable name for a custom low-level
 	merge driver.  See linkgit:gitattributes[5] for details.
 
 merge.<driver>.driver::
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 427cdef..637b53f 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -12,7 +12,7 @@
 
 -n::
 --no-stat::
-	Do not show diffstat at the end of the merge.
+	Do not show a diffstat at the end of the merge.
 
 --summary::
 --no-summary::
-- 
1.6.1.rc1.25.g27a91
