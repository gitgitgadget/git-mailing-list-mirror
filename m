From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/7] modernize t9300: single-quote placement and indentation
Date: Thu, 19 Nov 2015 20:09:43 +0100
Message-ID: <281fdb4f4b9f02c9fc1ee6664191ce325045c7bf.1447959452.git.j6t@kdbg.org>
References: <cover.1447959452.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 20:10:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzUbF-0006r2-Oc
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 20:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbbKSTKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 14:10:19 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:7374 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030196AbbKSTKP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 14:10:15 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3p1rDg6CXgz5tlK;
	Thu, 19 Nov 2015 20:10:11 +0100 (CET)
Received: from dx.site (localhost [127.0.0.1])
	by dx.site (Postfix) with ESMTP id 65ABE29D8;
	Thu, 19 Nov 2015 20:10:11 +0100 (CET)
X-Mailer: git-send-email 2.6.2.337.ga235d84
In-Reply-To: <cover.1447959452.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281486>

Many test cases do not follow our modern style that places the
single-quotes that surround the shell code snippets before and after
the shell code. Make it so.

Many of the lines changed in this way are indented other than by a
single tab. Change them (and some additional lines) to be indented
with a tab.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t9300-fast-import.sh | 872 +++++++++++++++++++++++++------------------------
 1 file changed, 437 insertions(+), 435 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 9984c48..566f7bd 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -100,10 +100,10 @@ An annotated tag that annotates a blob.
 EOF
 
 INPUT_END
-test_expect_success \
-    'A: create pack from stdin' \
-    'git fast-import --export-marks=marks.out <input &&
-	 git whatchanged master'
+test_expect_success 'A: create pack from stdin' '
+	git fast-import --export-marks=marks.out <input &&
+	git whatchanged master
+'
 
 test_expect_success 'A: verify pack' '
 	verify_packs
@@ -115,35 +115,35 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 initial
 EOF
-test_expect_success \
-	'A: verify commit' \
-	'git cat-file commit master | sed 1d >actual &&
-	test_cmp expect actual'
+test_expect_success 'A: verify commit' '
+	git cat-file commit master | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect <<EOF
 100644 blob file2
 100644 blob file3
 100755 blob file4
 EOF
-test_expect_success \
-	'A: verify tree' \
-	'git cat-file -p master^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	 test_cmp expect actual'
+test_expect_success 'A: verify tree' '
+	git cat-file -p master^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+	test_cmp expect actual
+'
 
 echo "$file2_data" >expect
-test_expect_success \
-	'A: verify file2' \
-	'git cat-file blob master:file2 >actual && test_cmp expect actual'
+test_expect_success 'A: verify file2' '
+	git cat-file blob master:file2 >actual && test_cmp expect actual
+'
 
 echo "$file3_data" >expect
-test_expect_success \
-	'A: verify file3' \
-	'git cat-file blob master:file3 >actual && test_cmp expect actual'
+test_expect_success 'A: verify file3' '
+	git cat-file blob master:file3 >actual && test_cmp expect actual
+'
 
 printf "$file4_data" >expect
-test_expect_success \
-	'A: verify file4' \
-	'git cat-file blob master:file4 >actual && test_cmp expect actual'
+test_expect_success 'A: verify file4' '
+	git cat-file blob master:file4 >actual && test_cmp expect actual
+'
 
 cat >expect <<EOF
 object $(git rev-parse refs/heads/master)
@@ -175,17 +175,17 @@ cat >expect <<EOF
 :4 `git rev-parse --verify master:file4`
 :5 `git rev-parse --verify master^0`
 EOF
-test_expect_success \
-	'A: verify marks output' \
-	'test_cmp expect marks.out'
+test_expect_success 'A: verify marks output' '
+	test_cmp expect marks.out
+'
 
-test_expect_success \
-	'A: verify marks import' \
-	'git fast-import \
+test_expect_success 'A: verify marks import' '
+	git fast-import \
 		--import-marks=marks.out \
 		--export-marks=marks.new \
 		</dev/null &&
-	test_cmp expect marks.new'
+	test_cmp expect marks.new
+'
 
 test_tick
 new_blob=$(echo testing | git hash-object --stdin)
@@ -229,12 +229,12 @@ tag series-A-blob-3
 Tag new_blob.
 EOF
 
-test_expect_success \
-	'A: tag blob by sha1' \
-	'git fast-import <input &&
+test_expect_success 'A: tag blob by sha1' '
+	git fast-import <input &&
 	git cat-file tag tags/series-A-blob-2 >actual &&
 	git cat-file tag tags/series-A-blob-3 >>actual &&
-	test_cmp expect actual'
+	test_cmp expect actual
+'
 
 test_tick
 cat >input <<INPUT_END
@@ -248,10 +248,10 @@ from :5
 M 755 :2 copy-of-file2
 
 INPUT_END
-test_expect_success \
-	'A: verify marks import does not crash' \
-	'git fast-import --import-marks=marks.out <input &&
-	 git whatchanged verify--import-marks'
+test_expect_success 'A: verify marks import does not crash' '
+	git fast-import --import-marks=marks.out <input &&
+	git whatchanged verify--import-marks
+'
 
 test_expect_success 'A: verify pack' '
 	verify_packs
@@ -261,11 +261,11 @@ cat >expect <<EOF
 :000000 100755 0000000000000000000000000000000000000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 A	copy-of-file2
 EOF
 git diff-tree -M -r master verify--import-marks >actual
-test_expect_success \
-	'A: verify diff' \
-	'compare_diff_raw expect actual &&
-	 test `git rev-parse --verify master:file2` \
-	    = `git rev-parse --verify verify--import-marks:copy-of-file2`'
+test_expect_success 'A: verify diff' '
+	compare_diff_raw expect actual &&
+	test `git rev-parse --verify master:file2` \
+	    = `git rev-parse --verify verify--import-marks:copy-of-file2`
+'
 
 test_tick
 mt=$(git hash-object --stdin < /dev/null)
@@ -322,7 +322,8 @@ test_expect_success 'A: export marks with large values' '
 	cat input.blob input.commit | git fast-import --export-marks=marks.large &&
 	git ls-tree refs/heads/verify--dump-marks >tree.out &&
 	test_cmp tree.exp_s tree.out &&
-	test_cmp marks.exp marks.large'
+	test_cmp marks.exp marks.large
+'
 
 ###
 ### series B
@@ -342,7 +343,7 @@ M 755 0000000000000000000000000000000000000001 zero1
 
 INPUT_END
 test_expect_success 'B: fail on invalid blob sha1' '
-    test_must_fail git fast-import <input
+	test_must_fail git fast-import <input
 '
 rm -f .git/objects/pack_* .git/objects/index_*
 
@@ -356,11 +357,11 @@ COMMIT
 from refs/heads/master
 
 INPUT_END
-test_expect_success \
-    'B: accept branch name "TEMP_TAG"' \
-    'git fast-import <input &&
-	 test -f .git/TEMP_TAG &&
-	 test `git rev-parse master` = `git rev-parse TEMP_TAG^`'
+test_expect_success 'B: accept branch name "TEMP_TAG"' '
+	git fast-import <input &&
+	test -f .git/TEMP_TAG &&
+	test `git rev-parse master` = `git rev-parse TEMP_TAG^`
+'
 rm -f .git/TEMP_TAG
 
 git gc 2>/dev/null >/dev/null
@@ -482,19 +483,19 @@ M 755 $newf file2/newf
 D file3
 
 INPUT_END
-test_expect_success \
-    'C: incremental import create pack from stdin' \
-    'git fast-import <input &&
-	 git whatchanged branch'
+test_expect_success 'C: incremental import create pack from stdin' '
+	git fast-import <input &&
+	git whatchanged branch
+'
 
 test_expect_success 'C: verify pack' '
 	verify_packs
 '
 
-test_expect_success \
-	'C: validate reuse existing blob' \
-	'test $newf = `git rev-parse --verify branch:file2/newf` &&
-	 test $oldf = `git rev-parse --verify branch:file2/oldf`'
+test_expect_success 'C: validate reuse existing blob' '
+	test $newf = `git rev-parse --verify branch:file2/newf` &&
+	test $oldf = `git rev-parse --verify branch:file2/oldf`
+'
 
 cat >expect <<EOF
 parent `git rev-parse --verify master^0`
@@ -503,10 +504,10 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 second
 EOF
-test_expect_success \
-	'C: verify commit' \
-	'git cat-file commit branch | sed 1d >actual &&
-	 test_cmp expect actual'
+test_expect_success 'C: verify commit' '
+	git cat-file commit branch | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect <<EOF
 :000000 100755 0000000000000000000000000000000000000000 f1fb5da718392694d0076d677d6d0e364c79b0bc A	file2/newf
@@ -514,9 +515,9 @@ cat >expect <<EOF
 :100644 000000 0d92e9f3374ae2947c23aa477cbc68ce598135f1 0000000000000000000000000000000000000000 D	file3
 EOF
 git diff-tree -M -r master branch >actual
-test_expect_success \
-	'C: validate rename result' \
-	'compare_diff_raw expect actual'
+test_expect_success 'C: validate rename result' '
+	compare_diff_raw expect actual
+'
 
 ###
 ### series D
@@ -542,10 +543,10 @@ $file6_data
 EOF
 
 INPUT_END
-test_expect_success \
-    'D: inline data in commit' \
-    'git fast-import <input &&
-	 git whatchanged branch'
+test_expect_success 'D: inline data in commit' '
+	git fast-import <input &&
+	git whatchanged branch
+'
 
 test_expect_success 'D: verify pack' '
 	verify_packs
@@ -556,21 +557,21 @@ cat >expect <<EOF
 :000000 100644 0000000000000000000000000000000000000000 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 A	newdir/interesting
 EOF
 git diff-tree -M -r branch^ branch >actual
-test_expect_success \
-	'D: validate new files added' \
-	'compare_diff_raw expect actual'
+test_expect_success 'D: validate new files added' '
+	compare_diff_raw expect actual
+'
 
 echo "$file5_data" >expect
-test_expect_success \
-	'D: verify file5' \
-	'git cat-file blob branch:newdir/interesting >actual &&
-	 test_cmp expect actual'
+test_expect_success 'D: verify file5' '
+	git cat-file blob branch:newdir/interesting >actual &&
+	test_cmp expect actual
+'
 
 echo "$file6_data" >expect
-test_expect_success \
-	'D: verify file6' \
-	'git cat-file blob branch:newdir/exec.sh >actual &&
-	 test_cmp expect actual'
+test_expect_success 'D: verify file6' '
+	git cat-file blob branch:newdir/exec.sh >actual &&
+	test_cmp expect actual
+'
 
 ###
 ### series E
@@ -588,11 +589,11 @@ from refs/heads/branch^0
 
 INPUT_END
 test_expect_success 'E: rfc2822 date, --date-format=raw' '
-    test_must_fail git fast-import --date-format=raw <input
+	test_must_fail git fast-import --date-format=raw <input
+'
+test_expect_success 'E: rfc2822 date, --date-format=rfc2822' '
+	git fast-import --date-format=rfc2822 <input
 '
-test_expect_success \
-    'E: rfc2822 date, --date-format=rfc2822' \
-    'git fast-import --date-format=rfc2822 <input'
 
 test_expect_success 'E: verify pack' '
 	verify_packs
@@ -604,10 +605,10 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1170783302 -0500
 
 RFC 2822 type date
 EOF
-test_expect_success \
-	'E: verify commit' \
-	'git cat-file commit branch | sed 1,2d >actual &&
-	test_cmp expect actual'
+test_expect_success 'E: verify commit' '
+	git cat-file commit branch | sed 1,2d >actual &&
+	test_cmp expect actual
+'
 
 ###
 ### series F
@@ -628,13 +629,12 @@ reset refs/heads/other
 from refs/heads/branch
 
 INPUT_END
-test_expect_success \
-    'F: non-fast-forward update skips' \
-    'if git fast-import <input
-	 then
+test_expect_success 'F: non-fast-forward update skips' '
+	if git fast-import <input
+	then
 		echo BAD gfi did not fail
 		return 1
-	 else
+	else
 		if test $old_branch = `git rev-parse --verify branch^0`
 		then
 			: branch unaffected and failure returned
@@ -643,8 +643,8 @@ test_expect_success \
 			echo BAD gfi changed branch $old_branch
 			return 1
 		fi
-	 fi
-	'
+	fi
+'
 
 test_expect_success 'F: verify pack' '
 	verify_packs
@@ -658,10 +658,10 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 losing things already?
 EOF
-test_expect_success \
-	'F: verify other commit' \
-	'git cat-file commit other >actual &&
-	test_cmp expect actual'
+test_expect_success 'F: verify other commit' '
+	git cat-file commit other >actual &&
+	test_cmp expect actual
+'
 
 ###
 ### series G
@@ -679,18 +679,18 @@ COMMIT
 from refs/heads/branch~1
 
 INPUT_END
-test_expect_success \
-    'G: non-fast-forward update forced' \
-    'git fast-import --force <input'
+test_expect_success 'G: non-fast-forward update forced' '
+	git fast-import --force <input
+'
 
 test_expect_success 'G: verify pack' '
 	verify_packs
 '
 
-test_expect_success \
-	'G: branch changed, but logged' \
-	'test $old_branch != `git rev-parse --verify branch^0` &&
-	 test $old_branch = `git rev-parse --verify branch@{1}`'
+test_expect_success 'G: branch changed, but logged' '
+	test $old_branch != `git rev-parse --verify branch^0` &&
+	test $old_branch = `git rev-parse --verify branch@{1}`
+'
 
 ###
 ### series H
@@ -717,10 +717,10 @@ $file5_data
 EOF
 
 INPUT_END
-test_expect_success \
-    'H: deletall, add 1' \
-    'git fast-import <input &&
-	 git whatchanged H'
+test_expect_success 'H: deletall, add 1' '
+	git fast-import <input &&
+	git whatchanged H
+'
 
 test_expect_success 'H: verify pack' '
 	verify_packs
@@ -734,15 +734,15 @@ cat >expect <<EOF
 :100755 000000 e74b7d465e52746be2b4bae983670711e6e66657 0000000000000000000000000000000000000000 D	newdir/exec.sh
 EOF
 git diff-tree -M -r H^ H >actual
-test_expect_success \
-	'H: validate old files removed, new files added' \
-	'compare_diff_raw expect actual'
+test_expect_success 'H: validate old files removed, new files added' '
+	compare_diff_raw expect actual
+'
 
 echo "$file5_data" >expect
-test_expect_success \
-	'H: verify file' \
-	'git cat-file blob H:h/e/l/lo >actual &&
-	 test_cmp expect actual'
+test_expect_success 'H: verify file' '
+	git cat-file blob H:h/e/l/lo >actual &&
+	test_cmp expect actual
+'
 
 ###
 ### series I
@@ -758,17 +758,17 @@ COMMIT
 from refs/heads/branch
 
 INPUT_END
-test_expect_success \
-    'I: export-pack-edges' \
-    'git fast-import --export-pack-edges=edges.list <input'
+test_expect_success 'I: export-pack-edges' '
+	git fast-import --export-pack-edges=edges.list <input
+'
 
 cat >expect <<EOF
 .git/objects/pack/pack-.pack: `git rev-parse --verify export-boundary`
 EOF
-test_expect_success \
-	'I: verify edge list' \
-	'sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
-	 test_cmp expect actual'
+test_expect_success 'I: verify edge list' '
+	sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
+	test_cmp expect actual
+'
 
 ###
 ### series J
@@ -792,13 +792,13 @@ initialize J
 COMMIT
 
 INPUT_END
-test_expect_success \
-    'J: reset existing branch creates empty commit' \
-    'git fast-import <input'
-test_expect_success \
-	'J: branch has 1 commit, empty tree' \
-	'test 1 = `git rev-list J | wc -l` &&
-	 test 0 = `git ls-tree J | wc -l`'
+test_expect_success 'J: reset existing branch creates empty commit' '
+	git fast-import <input
+'
+test_expect_success 'J: branch has 1 commit, empty tree' '
+	test 1 = `git rev-list J | wc -l` &&
+	test 0 = `git ls-tree J | wc -l`
+'
 
 cat >input <<INPUT_END
 reset refs/heads/J2
@@ -809,9 +809,9 @@ data <<EOF
 Tag branch that was reset.
 EOF
 INPUT_END
-test_expect_success \
-	'J: tag must fail on empty branch' \
-	'test_must_fail git fast-import <input'
+test_expect_success 'J: tag must fail on empty branch' '
+	test_must_fail git fast-import <input
+'
 ###
 ### series K
 ###
@@ -834,13 +834,13 @@ COMMIT
 from refs/heads/branch^1
 
 INPUT_END
-test_expect_success \
-    'K: reinit branch with from' \
-    'git fast-import <input'
-test_expect_success \
-    'K: verify K^1 = branch^1' \
-    'test `git rev-parse --verify branch^1` \
-		= `git rev-parse --verify K^1`'
+test_expect_success 'K: reinit branch with from' '
+	git fast-import <input
+'
+test_expect_success 'K: verify K^1 = branch^1' '
+	test `git rev-parse --verify branch^1` \
+		= `git rev-parse --verify K^1`
+'
 
 ###
 ### series L
@@ -886,11 +886,11 @@ cat >expect <<EXPECT_END
 :100644 100644 4268632... 55d3a52... M	ba
 EXPECT_END
 
-test_expect_success \
-    'L: verify internal tree sorting' \
-	'git fast-import <input &&
-	 git diff-tree --abbrev --raw L^ L >output &&
-	 test_cmp expect output'
+test_expect_success 'L: verify internal tree sorting' '
+	git fast-import <input &&
+	git diff-tree --abbrev --raw L^ L >output &&
+	test_cmp expect output
+'
 
 cat >input <<INPUT_END
 blob
@@ -923,13 +923,13 @@ g/b/f
 g/b/h
 EOF
 
-test_expect_success \
-    'L: nested tree copy does not corrupt deltas' \
-	'git fast-import <input &&
+test_expect_success 'L: nested tree copy does not corrupt deltas' '
+	git fast-import <input &&
 	git ls-tree L2 g/b/ >tmp &&
 	cat tmp | cut -f 2 >actual &&
 	test_cmp expect actual &&
-	git fsck `git rev-parse L2`'
+	git fsck `git rev-parse L2`
+'
 
 git update-ref -d refs/heads/L2
 
@@ -953,11 +953,11 @@ INPUT_END
 cat >expect <<EOF
 :100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	file2/n.e.w.f
 EOF
-test_expect_success \
-	'M: rename file in same subdirectory' \
-	'git fast-import <input &&
-	 git diff-tree -M -r M1^ M1 >actual &&
-	 compare_diff_raw expect actual'
+test_expect_success 'M: rename file in same subdirectory' '
+	git fast-import <input &&
+	git diff-tree -M -r M1^ M1 >actual &&
+	compare_diff_raw expect actual
+'
 
 cat >input <<INPUT_END
 commit refs/heads/M2
@@ -974,11 +974,11 @@ INPUT_END
 cat >expect <<EOF
 :100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	i/am/new/to/you
 EOF
-test_expect_success \
-	'M: rename file to new subdirectory' \
-	'git fast-import <input &&
-	 git diff-tree -M -r M2^ M2 >actual &&
-	 compare_diff_raw expect actual'
+test_expect_success 'M: rename file to new subdirectory' '
+	git fast-import <input &&
+	git diff-tree -M -r M2^ M2 >actual &&
+	compare_diff_raw expect actual
+'
 
 cat >input <<INPUT_END
 commit refs/heads/M3
@@ -995,11 +995,11 @@ INPUT_END
 cat >expect <<EOF
 :100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	i/am/new/to/you	other/sub/am/new/to/you
 EOF
-test_expect_success \
-	'M: rename subdirectory to new subdirectory' \
-	'git fast-import <input &&
-	 git diff-tree -M -r M3^ M3 >actual &&
-	 compare_diff_raw expect actual'
+test_expect_success 'M: rename subdirectory to new subdirectory' '
+	git fast-import <input &&
+	git diff-tree -M -r M3^ M3 >actual &&
+	compare_diff_raw expect actual
+'
 
 cat >input <<INPUT_END
 commit refs/heads/M4
@@ -1020,12 +1020,12 @@ cat >expect <<EOF
 :100755 100755 e74b7d465e52746be2b4bae983670711e6e66657 e74b7d465e52746be2b4bae983670711e6e66657 R100	newdir/exec.sh	sub/newdir/exec.sh
 :100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 R100	newdir/interesting	sub/newdir/interesting
 EOF
-test_expect_success \
-	'M: rename root to subdirectory' \
-	'git fast-import <input &&
-	 git diff-tree -M -r M4^ M4 >actual &&
-	 cat actual &&
-	 compare_diff_raw expect actual'
+test_expect_success 'M: rename root to subdirectory' '
+	git fast-import <input &&
+	git diff-tree -M -r M4^ M4 >actual &&
+	cat actual &&
+	compare_diff_raw expect actual
+'
 
 ###
 ### series N
@@ -1047,11 +1047,11 @@ INPUT_END
 cat >expect <<EOF
 :100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file2/n.e.w.f
 EOF
-test_expect_success \
-	'N: copy file in same subdirectory' \
-	'git fast-import <input &&
-	 git diff-tree -C --find-copies-harder -r N1^ N1 >actual &&
-	 compare_diff_raw expect actual'
+test_expect_success 'N: copy file in same subdirectory' '
+	git fast-import <input &&
+	git diff-tree -C --find-copies-harder -r N1^ N1 >actual &&
+	compare_diff_raw expect actual
+'
 
 cat >input <<INPUT_END
 commit refs/heads/N2
@@ -1081,11 +1081,11 @@ cat >expect <<EOF
 :100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
 :100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
 EOF
-test_expect_success \
-	'N: copy then modify subdirectory' \
-	'git fast-import <input &&
-	 git diff-tree -C --find-copies-harder -r N2^^ N2 >actual &&
-	 compare_diff_raw expect actual'
+test_expect_success 'N: copy then modify subdirectory' '
+	git fast-import <input &&
+	git diff-tree -C --find-copies-harder -r N2^^ N2 >actual &&
+	compare_diff_raw expect actual
+'
 
 cat >input <<INPUT_END
 commit refs/heads/N3
@@ -1105,19 +1105,18 @@ D file2/file5
 
 INPUT_END
 
-test_expect_success \
-	'N: copy dirty subdirectory' \
-	'git fast-import <input &&
-	 test `git rev-parse N2^{tree}` = `git rev-parse N3^{tree}`'
+test_expect_success 'N: copy dirty subdirectory' '
+	git fast-import <input &&
+	test `git rev-parse N2^{tree}` = `git rev-parse N3^{tree}`
+'
 
-test_expect_success \
-	'N: copy directory by id' \
-	'cat >expect <<-\EOF &&
+test_expect_success 'N: copy directory by id' '
+	cat >expect <<-\EOF &&
 	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
 	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
 	EOF
-	 subdir=$(git rev-parse refs/heads/branch^0:file2) &&
-	 cat >input <<-INPUT_END &&
+	subdir=$(git rev-parse refs/heads/branch^0:file2) &&
+	cat >input <<-INPUT_END &&
 	commit refs/heads/N4
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -1127,9 +1126,10 @@ test_expect_success \
 	from refs/heads/branch^0
 	M 040000 $subdir file3
 	INPUT_END
-	 git fast-import <input &&
-	 git diff-tree -C --find-copies-harder -r N4^ N4 >actual &&
-	 compare_diff_raw expect actual'
+	git fast-import <input &&
+	git diff-tree -C --find-copies-harder -r N4^ N4 >actual &&
+	compare_diff_raw expect actual
+'
 
 test_expect_success PIPE 'N: read and copy directory' '
 	cat >expect <<-\EOF &&
@@ -1202,14 +1202,13 @@ test_expect_success PIPE 'N: empty directory reads as missing' '
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'N: copy root directory by tree hash' \
-	'cat >expect <<-\EOF &&
+test_expect_success 'N: copy root directory by tree hash' '
+	cat >expect <<-\EOF &&
 	:100755 000000 f1fb5da718392694d0076d677d6d0e364c79b0bc 0000000000000000000000000000000000000000 D	file3/newf
 	:100644 000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 0000000000000000000000000000000000000000 D	file3/oldf
 	EOF
-	 root=$(git rev-parse refs/heads/branch^0^{tree}) &&
-	 cat >input <<-INPUT_END &&
+	root=$(git rev-parse refs/heads/branch^0^{tree}) &&
+	cat >input <<-INPUT_END &&
 	commit refs/heads/N6
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -1219,20 +1218,20 @@ test_expect_success \
 	from refs/heads/branch^0
 	M 040000 $root ""
 	INPUT_END
-	 git fast-import <input &&
-	 git diff-tree -C --find-copies-harder -r N4 N6 >actual &&
-	 compare_diff_raw expect actual'
+	git fast-import <input &&
+	git diff-tree -C --find-copies-harder -r N4 N6 >actual &&
+	compare_diff_raw expect actual
+'
 
-test_expect_success \
-	'N: copy root by path' \
-	'cat >expect <<-\EOF &&
+test_expect_success 'N: copy root by path' '
+	cat >expect <<-\EOF &&
 	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	oldroot/file2/newf
 	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	oldroot/file2/oldf
 	:100755 100755 85df50785d62d3b05ab03d9cbf7e4a0b49449730 85df50785d62d3b05ab03d9cbf7e4a0b49449730 C100	file4	oldroot/file4
 	:100755 100755 e74b7d465e52746be2b4bae983670711e6e66657 e74b7d465e52746be2b4bae983670711e6e66657 C100	newdir/exec.sh	oldroot/newdir/exec.sh
 	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	oldroot/newdir/interesting
 	EOF
-	 cat >input <<-INPUT_END &&
+	cat >input <<-INPUT_END &&
 	commit refs/heads/N-copy-root-path
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -1242,21 +1241,21 @@ test_expect_success \
 	from refs/heads/branch^0
 	C "" oldroot
 	INPUT_END
-	 git fast-import <input &&
-	 git diff-tree -C --find-copies-harder -r branch N-copy-root-path >actual &&
-	 compare_diff_raw expect actual'
+	git fast-import <input &&
+	git diff-tree -C --find-copies-harder -r branch N-copy-root-path >actual &&
+	compare_diff_raw expect actual
+'
 
-test_expect_success \
-	'N: delete directory by copying' \
-	'cat >expect <<-\EOF &&
+test_expect_success 'N: delete directory by copying' '
+	cat >expect <<-\EOF &&
 	OBJID
 	:100644 000000 OBJID OBJID D	foo/bar/qux
 	OBJID
 	:000000 100644 OBJID OBJID A	foo/bar/baz
 	:000000 100644 OBJID OBJID A	foo/bar/qux
 	EOF
-	 empty_tree=$(git mktree </dev/null) &&
-	 cat >input <<-INPUT_END &&
+	empty_tree=$(git mktree </dev/null) &&
+	cat >input <<-INPUT_END &&
 	commit refs/heads/N-delete
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -1282,21 +1281,21 @@ test_expect_success \
 
 	M 040000 $empty_tree foo/bar/qux
 	INPUT_END
-	 git fast-import <input &&
-	 git rev-list N-delete |
+	git fast-import <input &&
+	git rev-list N-delete |
 		git diff-tree -r --stdin --root --always |
 		sed -e "s/$_x40/OBJID/g" >actual &&
-	 test_cmp expect actual'
+	test_cmp expect actual
+'
 
-test_expect_success \
-	'N: modify copied tree' \
-	'cat >expect <<-\EOF &&
+test_expect_success 'N: modify copied tree' '
+	cat >expect <<-\EOF &&
 	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/file5
 	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
 	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
 	EOF
-	 subdir=$(git rev-parse refs/heads/branch^0:file2) &&
-	 cat >input <<-INPUT_END &&
+	subdir=$(git rev-parse refs/heads/branch^0:file2) &&
+	cat >input <<-INPUT_END &&
 	commit refs/heads/N5
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -1317,14 +1316,14 @@ test_expect_success \
 	$file5_data
 	EOF
 	INPUT_END
-	 git fast-import <input &&
-	 git diff-tree -C --find-copies-harder -r N5^^ N5 >actual &&
-	 compare_diff_raw expect actual'
-
-test_expect_success \
-	'N: reject foo/ syntax' \
-	'subdir=$(git rev-parse refs/heads/branch^0:file2) &&
-	 test_must_fail git fast-import <<-INPUT_END
+	git fast-import <input &&
+	git diff-tree -C --find-copies-harder -r N5^^ N5 >actual &&
+	compare_diff_raw expect actual
+'
+
+test_expect_success 'N: reject foo/ syntax' '
+	subdir=$(git rev-parse refs/heads/branch^0:file2) &&
+	test_must_fail git fast-import <<-INPUT_END
 	commit refs/heads/N5B
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -1333,11 +1332,11 @@ test_expect_success \
 
 	from refs/heads/branch^0
 	M 040000 $subdir file3/
-	INPUT_END'
+	INPUT_END
+'
 
-test_expect_success \
-	'N: reject foo/ syntax in copy source' \
-	'test_must_fail git fast-import <<-INPUT_END
+test_expect_success 'N: reject foo/ syntax in copy source' '
+	test_must_fail git fast-import <<-INPUT_END
 	commit refs/heads/N5C
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -1346,11 +1345,11 @@ test_expect_success \
 
 	from refs/heads/branch^0
 	C file2/ file3
-	INPUT_END'
+	INPUT_END
+'
 
-test_expect_success \
-	'N: reject foo/ syntax in rename source' \
-	'test_must_fail git fast-import <<-INPUT_END
+test_expect_success 'N: reject foo/ syntax in rename source' '
+	test_must_fail git fast-import <<-INPUT_END
 	commit refs/heads/N5D
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -1359,11 +1358,11 @@ test_expect_success \
 
 	from refs/heads/branch^0
 	R file2/ file3
-	INPUT_END'
+	INPUT_END
+'
 
-test_expect_success \
-	'N: reject foo/ syntax in ls argument' \
-	'test_must_fail git fast-import <<-INPUT_END
+test_expect_success 'N: reject foo/ syntax in ls argument' '
+	test_must_fail git fast-import <<-INPUT_END
 	commit refs/heads/N5E
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -1372,13 +1371,13 @@ test_expect_success \
 
 	from refs/heads/branch^0
 	ls "file2/"
-	INPUT_END'
+	INPUT_END
+'
 
-test_expect_success \
-	'N: copy to root by id and modify' \
-	'echo "hello, world" >expect.foo &&
-	 echo hello >expect.bar &&
-	 git fast-import <<-SETUP_END &&
+test_expect_success 'N: copy to root by id and modify' '
+	echo "hello, world" >expect.foo &&
+	echo hello >expect.bar &&
+	git fast-import <<-SETUP_END &&
 	commit refs/heads/N7
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -1392,8 +1391,8 @@ test_expect_success \
 	EOF
 	SETUP_END
 
-	 tree=$(git rev-parse --verify N7:) &&
-	 git fast-import <<-INPUT_END &&
+	tree=$(git rev-parse --verify N7:) &&
+	git fast-import <<-INPUT_END &&
 	commit refs/heads/N8
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -1406,15 +1405,15 @@ test_expect_success \
 	hello, world
 	EOF
 	INPUT_END
-	 git show N8:foo/foo >actual.foo &&
-	 git show N8:foo/bar >actual.bar &&
-	 test_cmp expect.foo actual.foo &&
-	 test_cmp expect.bar actual.bar'
-
-test_expect_success \
-	'N: extract subtree' \
-	'branch=$(git rev-parse --verify refs/heads/branch^{tree}) &&
-	 cat >input <<-INPUT_END &&
+	git show N8:foo/foo >actual.foo &&
+	git show N8:foo/bar >actual.bar &&
+	test_cmp expect.foo actual.foo &&
+	test_cmp expect.bar actual.bar
+'
+
+test_expect_success 'N: extract subtree' '
+	branch=$(git rev-parse --verify refs/heads/branch^{tree}) &&
+	cat >input <<-INPUT_END &&
 	commit refs/heads/N9
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -1424,14 +1423,14 @@ test_expect_success \
 	M 040000 $branch ""
 	C "newdir" ""
 	INPUT_END
-	 git fast-import <input &&
-	 git diff --exit-code branch:newdir N9'
-
-test_expect_success \
-	'N: modify subtree, extract it, and modify again' \
-	'echo hello >expect.baz &&
-	 echo hello, world >expect.qux &&
-	 git fast-import <<-SETUP_END &&
+	git fast-import <input &&
+	git diff --exit-code branch:newdir N9
+'
+
+test_expect_success 'N: modify subtree, extract it, and modify again' '
+	echo hello >expect.baz &&
+	echo hello, world >expect.qux &&
+	git fast-import <<-SETUP_END &&
 	commit refs/heads/N10
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -1445,8 +1444,8 @@ test_expect_success \
 	EOF
 	SETUP_END
 
-	 tree=$(git rev-parse --verify N10:) &&
-	 git fast-import <<-INPUT_END &&
+	tree=$(git rev-parse --verify N10:) &&
+	git fast-import <<-INPUT_END &&
 	commit refs/heads/N11
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -1461,12 +1460,12 @@ test_expect_success \
 	R "foo" ""
 	C "bar/qux" "bar/quux"
 	INPUT_END
-	 git show N11:bar/baz >actual.baz &&
-	 git show N11:bar/qux >actual.qux &&
-	 git show N11:bar/quux >actual.quux &&
-	 test_cmp expect.baz actual.baz &&
-	 test_cmp expect.qux actual.qux &&
-	 test_cmp expect.qux actual.quux'
+	git show N11:bar/baz >actual.baz &&
+	git show N11:bar/qux >actual.qux &&
+	git show N11:bar/quux >actual.quux &&
+	test_cmp expect.baz actual.baz &&
+	test_cmp expect.qux actual.qux &&
+	test_cmp expect.qux actual.quux'
 
 ###
 ### series O
@@ -1503,10 +1502,10 @@ D file2/file5
 
 INPUT_END
 
-test_expect_success \
-	'O: comments are all skipped' \
-	'git fast-import <input &&
-	 test `git rev-parse N3` = `git rev-parse O1`'
+test_expect_success 'O: comments are all skipped' '
+	git fast-import <input &&
+	test `git rev-parse N3` = `git rev-parse O1`
+'
 
 cat >input <<INPUT_END
 commit refs/heads/O2
@@ -1524,14 +1523,14 @@ D file2/file5
 
 INPUT_END
 
-test_expect_success \
-	'O: blank lines not necessary after data commands' \
-	'git fast-import <input &&
-	 test `git rev-parse N3` = `git rev-parse O2`'
+test_expect_success 'O: blank lines not necessary after data commands' '
+	git fast-import <input &&
+	test `git rev-parse N3` = `git rev-parse O2`
+'
 
-test_expect_success \
-	'O: repack before next test' \
-	'git repack -a -d'
+test_expect_success 'O: repack before next test' '
+	git repack -a -d
+'
 
 cat >input <<INPUT_END
 commit refs/heads/O3
@@ -1569,13 +1568,13 @@ of
 empty
 commits
 INPUT_END
-test_expect_success \
-	'O: blank lines not necessary after other commands' \
-	'git fast-import <input &&
-	 test 8 = `find .git/objects/pack -type f | wc -l` &&
-	 test `git rev-parse refs/tags/O3-2nd` = `git rev-parse O3^` &&
-	 git log --reverse --pretty=oneline O3 | sed s/^.*z// >actual &&
-	 test_cmp expect actual'
+test_expect_success 'O: blank lines not necessary after other commands' '
+	git fast-import <input &&
+	test 8 = `find .git/objects/pack -type f | wc -l` &&
+	test `git rev-parse refs/tags/O3-2nd` = `git rev-parse O3^` &&
+	git log --reverse --pretty=oneline O3 | sed s/^.*z// >actual &&
+	test_cmp expect actual
+'
 
 cat >input <<INPUT_END
 commit refs/heads/O4
@@ -1602,11 +1601,11 @@ zcommits
 COMMIT
 progress I'm done!
 INPUT_END
-test_expect_success \
-	'O: progress outputs as requested by input' \
-	'git fast-import <input >actual &&
-	 grep "progress " <input >expect &&
-	 test_cmp expect actual'
+test_expect_success 'O: progress outputs as requested by input' '
+	git fast-import <input >actual &&
+	grep "progress " <input >expect &&
+	test_cmp expect actual
+'
 
 ###
 ### series P (gitlinks)
@@ -1667,16 +1666,16 @@ M 160000 :6 sub
 
 INPUT_END
 
-test_expect_success \
-	'P: superproject & submodule mix' \
-	'git fast-import <input &&
-	 git checkout subuse1 &&
-	 rm -rf sub && mkdir sub && (cd sub &&
-	 git init &&
-	 git fetch --update-head-ok .. refs/heads/sub:refs/heads/master &&
-	 git checkout master) &&
-	 git submodule init &&
-	 git submodule update'
+test_expect_success 'P: superproject & submodule mix' '
+	git fast-import <input &&
+	git checkout subuse1 &&
+	rm -rf sub && mkdir sub && (cd sub &&
+	git init &&
+	git fetch --update-head-ok .. refs/heads/sub:refs/heads/master &&
+	git checkout master) &&
+	git submodule init &&
+	git submodule update
+'
 
 SUBLAST=$(git rev-parse --verify sub)
 SUBPREV=$(git rev-parse --verify sub^)
@@ -1709,12 +1708,12 @@ M 160000 $SUBLAST sub
 
 INPUT_END
 
-test_expect_success \
-	'P: verbatim SHA gitlinks' \
-	'git branch -D sub &&
-	 git gc && git prune &&
-	 git fast-import <input &&
-	 test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)'
+test_expect_success 'P: verbatim SHA gitlinks' '
+	git branch -D sub &&
+	git gc && git prune &&
+	git fast-import <input &&
+	test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)
+'
 
 test_tick
 cat >input <<INPUT_END
@@ -1734,7 +1733,8 @@ DATA
 INPUT_END
 
 test_expect_success 'P: fail on inline gitlink' '
-    test_must_fail git fast-import <input'
+	test_must_fail git fast-import <input
+'
 
 test_tick
 cat >input <<INPUT_END
@@ -1757,7 +1757,8 @@ M 160000 :1 sub
 INPUT_END
 
 test_expect_success 'P: fail on blob mark in gitlink' '
-    test_must_fail git fast-import <input'
+	test_must_fail git fast-import <input
+'
 
 ###
 ### series Q (notes)
@@ -1882,10 +1883,10 @@ EOF
 
 INPUT_END
 
-test_expect_success \
-	'Q: commit notes' \
-	'git fast-import <input &&
-	 git whatchanged notes-test'
+test_expect_success 'Q: commit notes' '
+	git fast-import <input &&
+	git whatchanged notes-test
+'
 
 test_expect_success 'Q: verify pack' '
 	verify_packs
@@ -1901,10 +1902,10 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 first (:3)
 EOF
-test_expect_success \
-	'Q: verify first commit' \
-	'git cat-file commit notes-test~2 | sed 1d >actual &&
-	test_cmp expect actual'
+test_expect_success 'Q: verify first commit' '
+	git cat-file commit notes-test~2 | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect <<EOF
 parent $commit1
@@ -1913,10 +1914,10 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 second (:5)
 EOF
-test_expect_success \
-	'Q: verify second commit' \
-	'git cat-file commit notes-test^ | sed 1d >actual &&
-	test_cmp expect actual'
+test_expect_success 'Q: verify second commit' '
+	git cat-file commit notes-test^ | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect <<EOF
 parent $commit2
@@ -1925,10 +1926,10 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 third (:6)
 EOF
-test_expect_success \
-	'Q: verify third commit' \
-	'git cat-file commit notes-test | sed 1d >actual &&
-	test_cmp expect actual'
+test_expect_success 'Q: verify third commit' '
+	git cat-file commit notes-test | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect <<EOF
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -1936,10 +1937,10 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 notes (:9)
 EOF
-test_expect_success \
-	'Q: verify first notes commit' \
-	'git cat-file commit refs/notes/foobar~2 | sed 1d >actual &&
-	test_cmp expect actual'
+test_expect_success 'Q: verify first notes commit' '
+	git cat-file commit refs/notes/foobar~2 | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect.unsorted <<EOF
 100644 blob $commit1
@@ -1947,25 +1948,25 @@ cat >expect.unsorted <<EOF
 100644 blob $commit3
 EOF
 cat expect.unsorted | sort >expect
-test_expect_success \
-	'Q: verify first notes tree' \
-	'git cat-file -p refs/notes/foobar~2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	 test_cmp expect actual'
+test_expect_success 'Q: verify first notes tree' '
+	git cat-file -p refs/notes/foobar~2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+	test_cmp expect actual
+'
 
 echo "$note1_data" >expect
-test_expect_success \
-	'Q: verify first note for first commit' \
-	'git cat-file blob refs/notes/foobar~2:$commit1 >actual && test_cmp expect actual'
+test_expect_success 'Q: verify first note for first commit' '
+	git cat-file blob refs/notes/foobar~2:$commit1 >actual && test_cmp expect actual
+'
 
 echo "$note2_data" >expect
-test_expect_success \
-	'Q: verify first note for second commit' \
-	'git cat-file blob refs/notes/foobar~2:$commit2 >actual && test_cmp expect actual'
+test_expect_success 'Q: verify first note for second commit' '
+	git cat-file blob refs/notes/foobar~2:$commit2 >actual && test_cmp expect actual
+'
 
 echo "$note3_data" >expect
-test_expect_success \
-	'Q: verify first note for third commit' \
-	'git cat-file blob refs/notes/foobar~2:$commit3 >actual && test_cmp expect actual'
+test_expect_success 'Q: verify first note for third commit' '
+	git cat-file blob refs/notes/foobar~2:$commit3 >actual && test_cmp expect actual
+'
 
 cat >expect <<EOF
 parent `git rev-parse --verify refs/notes/foobar~2`
@@ -1974,10 +1975,10 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 notes (:10)
 EOF
-test_expect_success \
-	'Q: verify second notes commit' \
-	'git cat-file commit refs/notes/foobar^ | sed 1d >actual &&
-	test_cmp expect actual'
+test_expect_success 'Q: verify second notes commit' '
+	git cat-file commit refs/notes/foobar^ | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect.unsorted <<EOF
 100644 blob $commit1
@@ -1985,25 +1986,25 @@ cat >expect.unsorted <<EOF
 100644 blob $commit3
 EOF
 cat expect.unsorted | sort >expect
-test_expect_success \
-	'Q: verify second notes tree' \
-	'git cat-file -p refs/notes/foobar^^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	 test_cmp expect actual'
+test_expect_success 'Q: verify second notes tree' '
+	git cat-file -p refs/notes/foobar^^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+	test_cmp expect actual
+'
 
 echo "$note1b_data" >expect
-test_expect_success \
-	'Q: verify second note for first commit' \
-	'git cat-file blob refs/notes/foobar^:$commit1 >actual && test_cmp expect actual'
+test_expect_success 'Q: verify second note for first commit' '
+	git cat-file blob refs/notes/foobar^:$commit1 >actual && test_cmp expect actual
+'
 
 echo "$note2_data" >expect
-test_expect_success \
-	'Q: verify first note for second commit' \
-	'git cat-file blob refs/notes/foobar^:$commit2 >actual && test_cmp expect actual'
+test_expect_success 'Q: verify first note for second commit' '
+	git cat-file blob refs/notes/foobar^:$commit2 >actual && test_cmp expect actual
+'
 
 echo "$note3_data" >expect
-test_expect_success \
-	'Q: verify first note for third commit' \
-	'git cat-file blob refs/notes/foobar^:$commit3 >actual && test_cmp expect actual'
+test_expect_success 'Q: verify first note for third commit' '
+	git cat-file blob refs/notes/foobar^:$commit3 >actual && test_cmp expect actual
+'
 
 cat >expect <<EOF
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -2011,24 +2012,24 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 notes (:11)
 EOF
-test_expect_success \
-	'Q: verify third notes commit' \
-	'git cat-file commit refs/notes/foobar2 | sed 1d >actual &&
-	test_cmp expect actual'
+test_expect_success 'Q: verify third notes commit' '
+	git cat-file commit refs/notes/foobar2 | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect.unsorted <<EOF
 100644 blob $commit1
 EOF
 cat expect.unsorted | sort >expect
-test_expect_success \
-	'Q: verify third notes tree' \
-	'git cat-file -p refs/notes/foobar2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	 test_cmp expect actual'
+test_expect_success 'Q: verify third notes tree' '
+	git cat-file -p refs/notes/foobar2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+	test_cmp expect actual
+'
 
 echo "$note1c_data" >expect
-test_expect_success \
-	'Q: verify third note for first commit' \
-	'git cat-file blob refs/notes/foobar2:$commit1 >actual && test_cmp expect actual'
+test_expect_success 'Q: verify third note for first commit' '
+	git cat-file blob refs/notes/foobar2:$commit1 >actual && test_cmp expect actual
+'
 
 cat >expect <<EOF
 parent `git rev-parse --verify refs/notes/foobar^`
@@ -2037,24 +2038,24 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 notes (:12)
 EOF
-test_expect_success \
-	'Q: verify fourth notes commit' \
-	'git cat-file commit refs/notes/foobar | sed 1d >actual &&
-	test_cmp expect actual'
+test_expect_success 'Q: verify fourth notes commit' '
+	git cat-file commit refs/notes/foobar | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect.unsorted <<EOF
 100644 blob $commit2
 EOF
 cat expect.unsorted | sort >expect
-test_expect_success \
-	'Q: verify fourth notes tree' \
-	'git cat-file -p refs/notes/foobar^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	 test_cmp expect actual'
+test_expect_success 'Q: verify fourth notes tree' '
+	git cat-file -p refs/notes/foobar^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+	test_cmp expect actual
+'
 
 echo "$note2b_data" >expect
-test_expect_success \
-	'Q: verify second note for second commit' \
-	'git cat-file blob refs/notes/foobar:$commit2 >actual && test_cmp expect actual'
+test_expect_success 'Q: verify second note for second commit' '
+	git cat-file blob refs/notes/foobar:$commit2 >actual && test_cmp expect actual
+'
 
 cat >input <<EOF
 reset refs/heads/Q0
@@ -2070,9 +2071,9 @@ data <<NOTE
 some note
 NOTE
 EOF
-test_expect_success \
-	'Q: deny note on empty branch' \
-	'test_must_fail git fast-import <input'
+test_expect_success 'Q: deny note on empty branch' '
+	test_must_fail git fast-import <input
+'
 ###
 ### series R (feature and option)
 ###
@@ -2122,15 +2123,15 @@ hi
 
 EOF
 
-test_expect_success \
-    'R: export-marks feature results in a marks file being created' \
-    'cat input | git fast-import &&
-    grep :1 git.marks'
+test_expect_success 'R: export-marks feature results in a marks file being created' '
+	cat input | git fast-import &&
+	grep :1 git.marks
+'
 
-test_expect_success \
-    'R: export-marks options can be overridden by commandline options' \
-    'cat input | git fast-import --export-marks=other.marks &&
-    grep :1 other.marks'
+test_expect_success 'R: export-marks options can be overridden by commandline options' '
+	cat input | git fast-import --export-marks=other.marks &&
+	grep :1 other.marks
+'
 
 test_expect_success 'R: catch typo in marks file name' '
 	test_must_fail git fast-import --import-marks=nonexistent.marks </dev/null &&
@@ -2239,20 +2240,20 @@ feature import-marks=marks.out
 feature export-marks=marks.new
 EOF
 
-test_expect_success \
-    'R: import to output marks works without any content' \
-    'cat input | git fast-import &&
-    test_cmp marks.out marks.new'
+test_expect_success 'R: import to output marks works without any content' '
+	cat input | git fast-import &&
+	test_cmp marks.out marks.new
+'
 
 cat >input <<EOF
 feature import-marks=nonexistent.marks
 feature export-marks=marks.new
 EOF
 
-test_expect_success \
-    'R: import marks prefers commandline marks file over the stream' \
-    'cat input | git fast-import --import-marks=marks.out &&
-    test_cmp marks.out marks.new'
+test_expect_success 'R: import marks prefers commandline marks file over the stream' '
+	cat input | git fast-import --import-marks=marks.out &&
+	test_cmp marks.out marks.new
+'
 
 
 cat >input <<EOF
@@ -2261,10 +2262,10 @@ feature export-marks=combined.marks
 EOF
 
 test_expect_success 'R: multiple --import-marks= should be honoured' '
-    head -n2 marks.out > one.marks &&
-    tail -n +3 marks.out > two.marks &&
-    git fast-import --import-marks=one.marks --import-marks=two.marks <input &&
-    test_cmp marks.out combined.marks
+	head -n2 marks.out > one.marks &&
+	tail -n +3 marks.out > two.marks &&
+	git fast-import --import-marks=one.marks --import-marks=two.marks <input &&
+	test_cmp marks.out combined.marks
 '
 
 cat >input <<EOF
@@ -2274,10 +2275,10 @@ feature export-marks=relative.out
 EOF
 
 test_expect_success 'R: feature relative-marks should be honoured' '
-    mkdir -p .git/info/fast-import/ &&
-    cp marks.new .git/info/fast-import/relative.in &&
-    git fast-import <input &&
-    test_cmp marks.new .git/info/fast-import/relative.out
+	mkdir -p .git/info/fast-import/ &&
+	cp marks.new .git/info/fast-import/relative.in &&
+	git fast-import <input &&
+	test_cmp marks.new .git/info/fast-import/relative.out
 '
 
 cat >input <<EOF
@@ -2288,8 +2289,8 @@ feature export-marks=non-relative.out
 EOF
 
 test_expect_success 'R: feature no-relative-marks should be honoured' '
-    git fast-import <input &&
-    test_cmp marks.new non-relative.out
+	git fast-import <input &&
+	test_cmp marks.new non-relative.out
 '
 
 test_expect_success 'R: feature ls supported' '
@@ -2558,8 +2559,8 @@ hi
 EOF
 
 test_expect_success 'R: quiet option results in no stats being output' '
-    cat input | git fast-import 2> output &&
-    test_cmp empty output
+	cat input | git fast-import 2> output &&
+	test_cmp empty output
 '
 
 test_expect_success 'R: feature done means terminating "done" is mandatory' '
@@ -2609,11 +2610,11 @@ option git non-existing-option
 EOF
 
 test_expect_success 'R: die on unknown option' '
-    test_must_fail git fast-import <input
+	test_must_fail git fast-import <input
 '
 
 test_expect_success 'R: unknown commandline options are rejected' '\
-    test_must_fail git fast-import --non-existing-option < /dev/null
+	test_must_fail git fast-import --non-existing-option < /dev/null
 '
 
 test_expect_success 'R: die on invalid option argument' '
@@ -2629,7 +2630,7 @@ option non-existing-vcs non-existing-option
 EOF
 
 test_expect_success 'R: ignore non-git options' '
-    git fast-import <input
+	git fast-import <input
 '
 
 ##
@@ -2655,10 +2656,10 @@ INPUT_END
 cat expect >>input
 echo >>input
 
-test_expect_success \
-	'R: blob bigger than threshold' \
-	'test_create_repo R &&
-	 git --git-dir=R/.git fast-import --big-file-threshold=1 <input'
+test_expect_success 'R: blob bigger than threshold' '
+	test_create_repo R &&
+	git --git-dir=R/.git fast-import --big-file-threshold=1 <input
+'
 
 test_expect_success 'R: verify created pack' '
 	(
@@ -2667,17 +2668,18 @@ test_expect_success 'R: verify created pack' '
 	)
 '
 
-test_expect_success \
-	'R: verify written objects' \
-	'git --git-dir=R/.git cat-file blob big-file:big1 >actual &&
-	 test_cmp_bin expect actual &&
-	 a=$(git --git-dir=R/.git rev-parse big-file:big1) &&
-	 b=$(git --git-dir=R/.git rev-parse big-file:big2) &&
-	 test $a = $b'
-test_expect_success \
-	'R: blob appears only once' \
-	'n=$(grep $a verify | wc -l) &&
-	 test 1 = $n'
+test_expect_success 'R: verify written objects' '
+	git --git-dir=R/.git cat-file blob big-file:big1 >actual &&
+	test_cmp_bin expect actual &&
+	a=$(git --git-dir=R/.git rev-parse big-file:big1) &&
+	b=$(git --git-dir=R/.git rev-parse big-file:big2) &&
+	test $a = $b
+'
+
+test_expect_success 'R: blob appears only once' '
+	n=$(grep $a verify | wc -l) &&
+	test 1 = $n
+'
 
 ###
 ### series S
@@ -3088,7 +3090,7 @@ D ""
 INPUT_END
 
 test_expect_success 'U: filedelete root succeeds' '
-    git fast-import <input
+	git fast-import <input
 '
 
 cat >expect <<EOF
-- 
2.6.2.337.ga235d84
