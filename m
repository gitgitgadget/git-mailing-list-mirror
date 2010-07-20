From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v2] Convert "! git" to "test_must_fail git"
Date: Tue, 20 Jul 2010 19:18:34 -0400
Message-ID: <d0f3d6c2c02ae611aec4c301ff45a9878db7a681.1279667857.git.jaredhance@gmail.com>
References: <_BUqzkdWhTIktk0rYFvr9jdvISwfrShKmEsXaqgCBwm0X5Urcv2osQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 21 01:18:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObM5J-0002Sp-2s
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 01:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933138Ab0GTXSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 19:18:43 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45732 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933114Ab0GTXSm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 19:18:42 -0400
Received: by qyk38 with SMTP id 38so2796571qyk.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 16:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zmkGXxRWjoTn8vc8PD6y3yPp2AxI7+rPQAIVQNnlSXE=;
        b=ji9GDDJZUnXesyfkP5Ml86fzb83zy1jpTADbEVa/SfKfk9GBI83tA0PaTjq2Qf7a0e
         ee5re+d7mrIKJXEzm3wKwwGH8n/jodKxEpXJAYeYCAs4hksMjlgKngERhoER6sDILzp0
         /AonkVP/kYgbQ6m3d5nN2VbqSTAiY3I8s6wiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=c9LieJuXUTy5Z36AcSpn6FgtGA3GnSdvOSG2wvz4QHvoMX5QzhLqrOEjPnIG2YwEBX
         50T7apihQ5dbgnwoWJQw6lODoscTzu5DKPPqLk6QejowGnnYUjsMItWUqaPXE1fSZssv
         qUMyhdpwtjpPuMCscPwQ+jDSc1jSp+uOc4fLc=
Received: by 10.224.11.140 with SMTP id t12mr4678352qat.357.1279667920894;
        Tue, 20 Jul 2010 16:18:40 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id q30sm28567034qcq.0.2010.07.20.16.18.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 16:18:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <_BUqzkdWhTIktk0rYFvr9jdvISwfrShKmEsXaqgCBwm0X5Urcv2osQ@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151373>

test_must_fail will account for segfaults in git, so it should be used
instead of "! git"

This patch does not change any of the commands that use pipes.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 t/t1001-read-tree-m-2way.sh                |    2 +-
 t/t3301-notes.sh                           |    6 +++---
 t/t3306-notes-prune.sh                     |    8 ++++----
 t/t3410-rebase-preserve-dropped-merges.sh  |    8 ++++----
 t/t6037-merge-ours-theirs.sh               |    2 +-
 t/t7509-commit.sh                          |    4 ++--
 t/t7607-merge-overwrite.sh                 |   12 ++++++------
 t/t7810-grep.sh                            |    2 +-
 t/t9130-git-svn-authors-file.sh            |    4 ++--
 t/t9139-git-svn-non-utf8-commitencoding.sh |    2 +-
 t/t9140-git-svn-reset.sh                   |    2 +-
 11 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 0c562bb..93ca84f 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -359,7 +359,7 @@ test_expect_success \
 
 test_expect_success \
     'a/b (untracked) vs a, plus c/d case test.' \
-    '! git read-tree -u -m "$treeH" "$treeM" &&
+    'test_must_fail git read-tree -u -m "$treeH" "$treeM" &&
      git ls-files --stage &&
      test -f a/b'
 
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 2d67a40..421c988 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -299,7 +299,7 @@ cat expect-F >> expect-rm-F
 test_expect_success 'verify note removal with -F /dev/null' '
 	git log -4 > output &&
 	test_cmp expect-rm-F output &&
-	! git notes show
+	test_must_fail git notes show
 '
 
 test_expect_success 'do not create empty note with -m "" (setup)' '
@@ -309,7 +309,7 @@ test_expect_success 'do not create empty note with -m "" (setup)' '
 test_expect_success 'verify non-creation of note with -m ""' '
 	git log -4 > output &&
 	test_cmp expect-rm-F output &&
-	! git notes show
+	test_must_fail git notes show
 '
 
 cat > expect-combine_m_and_F << EOF
@@ -357,7 +357,7 @@ cat expect-multiline >> expect-rm-remove
 test_expect_success 'verify note removal with "git notes remove"' '
 	git log -4 > output &&
 	test_cmp expect-rm-remove output &&
-	! git notes show HEAD^
+	test_must_fail git notes show HEAD^
 '
 
 cat > expect << EOF
diff --git a/t/t3306-notes-prune.sh b/t/t3306-notes-prune.sh
index b455404..c428217 100755
--- a/t/t3306-notes-prune.sh
+++ b/t/t3306-notes-prune.sh
@@ -67,7 +67,7 @@ test_expect_success 'remove some commits' '
 
 test_expect_success 'verify that commits are gone' '
 
-	! git cat-file -p 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
+	test_must_fail git cat-file -p 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
 	git cat-file -p 08341ad9e94faa089d60fd3f523affb25c6da189 &&
 	git cat-file -p ab5f302035f2e7aaf04265f08b42034c23256e1f
 '
@@ -106,7 +106,7 @@ test_expect_success 'prune notes' '
 
 test_expect_success 'verify that notes are gone' '
 
-	! git notes show 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
+	test_must_fail git notes show 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
 	git notes show 08341ad9e94faa089d60fd3f523affb25c6da189 &&
 	git notes show ab5f302035f2e7aaf04265f08b42034c23256e1f
 '
@@ -130,8 +130,8 @@ test_expect_success 'prune -v notes' '
 
 test_expect_success 'verify that notes are gone' '
 
-	! git notes show 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
-	! git notes show 08341ad9e94faa089d60fd3f523affb25c6da189 &&
+	test_must_fail git notes show 5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
+	test_must_fail git notes show 08341ad9e94faa089d60fd3f523affb25c6da189 &&
 	git notes show ab5f302035f2e7aaf04265f08b42034c23256e1f
 '
 
diff --git a/t/t3410-rebase-preserve-dropped-merges.sh b/t/t3410-rebase-preserve-dropped-merges.sh
index c49143a..6f73b95 100755
--- a/t/t3410-rebase-preserve-dropped-merges.sh
+++ b/t/t3410-rebase-preserve-dropped-merges.sh
@@ -43,11 +43,11 @@ test_expect_success 'setup' '
 # G2 = same changes as G
 test_expect_success 'skip same-resolution merges with -p' '
 	git checkout H &&
-	! git merge E &&
+	test_must_fail git merge E &&
 	test_commit L file1 23 &&
 	git checkout I &&
 	test_commit G2 file1 3 &&
-	! git merge E &&
+	test_must_fail git merge E &&
 	test_commit J file1 23 &&
 	test_commit K file7 file7 &&
 	git rebase -i -p L &&
@@ -65,11 +65,11 @@ test_expect_success 'skip same-resolution merges with -p' '
 # G2 = different changes as G
 test_expect_success 'keep different-resolution merges with -p' '
 	git checkout H &&
-	! git merge E &&
+	test_must_fail git merge E &&
 	test_commit L2 file1 23 &&
 	git checkout I &&
 	test_commit G3 file1 4 &&
-	! git merge E &&
+	test_must_fail git merge E &&
 	test_commit J2 file1 24 &&
 	test_commit K2 file7 file7 &&
 	test_must_fail git rebase -i -p L2 &&
diff --git a/t/t6037-merge-ours-theirs.sh b/t/t6037-merge-ours-theirs.sh
index 8ab3d61..2cf42c7 100755
--- a/t/t6037-merge-ours-theirs.sh
+++ b/t/t6037-merge-ours-theirs.sh
@@ -58,7 +58,7 @@ test_expect_success 'pull with -X' '
 	git reset --hard master && git pull -s recursive -X ours . side &&
 	git reset --hard master && git pull -s recursive -Xtheirs . side &&
 	git reset --hard master && git pull -s recursive -X theirs . side &&
-	git reset --hard master && ! git pull -s recursive -X bork . side
+	git reset --hard master && test_must_fail git pull -s recursive -X bork . side
 '
 
 test_done
diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
index 3ea33db..643ab03 100755
--- a/t/t7509-commit.sh
+++ b/t/t7509-commit.sh
@@ -111,7 +111,7 @@ test_expect_success '--amend option with empty author' '
 	test_when_finished "git checkout Initial" &&
 	echo "Empty author test" >>foo &&
 	test_tick &&
-	! git commit -a -m "empty author" --amend 2>err &&
+	test_must_fail git commit -a -m "empty author" --amend 2>err &&
 	grep "empty ident" err
 '
 
@@ -125,7 +125,7 @@ test_expect_success '--amend option with missing author' '
 	test_when_finished "git checkout Initial" &&
 	echo "Missing author test" >>foo &&
 	test_tick &&
-	! git commit -a -m "malformed author" --amend 2>err &&
+	test_must_fail git commit -a -m "malformed author" --amend 2>err &&
 	grep "empty ident" err
 '
 
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 49f4e15..d82349a 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -31,7 +31,7 @@ test_expect_success 'setup' '
 test_expect_success 'will not overwrite untracked file' '
 	git reset --hard c1 &&
 	cat important > c2.c &&
-	! git merge c2 &&
+	test_must_fail git merge c2 &&
 	test_cmp important c2.c
 '
 
@@ -39,7 +39,7 @@ test_expect_success 'will not overwrite new file' '
 	git reset --hard c1 &&
 	cat important > c2.c &&
 	git add c2.c &&
-	! git merge c2 &&
+	test_must_fail git merge c2 &&
 	test_cmp important c2.c
 '
 
@@ -48,7 +48,7 @@ test_expect_success 'will not overwrite staged changes' '
 	cat important > c2.c &&
 	git add c2.c &&
 	rm c2.c &&
-	! git merge c2 &&
+	test_must_fail git merge c2 &&
 	git checkout c2.c &&
 	test_cmp important c2.c
 '
@@ -58,7 +58,7 @@ test_expect_success 'will not overwrite removed file' '
 	git rm c1.c &&
 	git commit -m "rm c1.c" &&
 	cat important > c1.c &&
-	! git merge c1a &&
+	test_must_fail git merge c1a &&
 	test_cmp important c1.c
 '
 
@@ -68,7 +68,7 @@ test_expect_success 'will not overwrite re-added file' '
 	git commit -m "rm c1.c" &&
 	cat important > c1.c &&
 	git add c1.c &&
-	! git merge c1a &&
+	test_must_fail git merge c1a &&
 	test_cmp important c1.c
 '
 
@@ -79,7 +79,7 @@ test_expect_success 'will not overwrite removed file with staged changes' '
 	cat important > c1.c &&
 	git add c1.c &&
 	rm c1.c &&
-	! git merge c1a &&
+	test_must_fail git merge c1a &&
 	git checkout c1.c &&
 	test_cmp important c1.c
 '
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 8a63227..023f225 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -65,7 +65,7 @@ do
 
 	test_expect_success "grep -w $L (w)" '
 		: >expected &&
-		! git grep -n -w -e "^w" >actual &&
+		test_must_fail git grep -n -w -e "^w" >actual &&
 		test_cmp expected actual
 	'
 
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index 134411e..3c4f319 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -20,7 +20,7 @@ test_expect_success 'setup svnrepo' '
 	'
 
 test_expect_success 'start import with incomplete authors file' '
-	! git svn clone --authors-file=svn-authors "$svnrepo" x
+	test_must_fail git svn clone --authors-file=svn-authors "$svnrepo" x
 	'
 
 test_expect_success 'imported 2 revisions successfully' '
@@ -63,7 +63,7 @@ test_expect_success 'authors-file against globs' '
 	'
 
 test_expect_success 'fetch fails on ee' '
-	( cd aa-work && ! git svn fetch --authors-file=../svn-authors )
+	( cd aa-work && test_must_fail git svn fetch --authors-file=../svn-authors )
 	'
 
 tmp_config_get () {
diff --git a/t/t9139-git-svn-non-utf8-commitencoding.sh b/t/t9139-git-svn-non-utf8-commitencoding.sh
index f337959..22d80b0 100755
--- a/t/t9139-git-svn-non-utf8-commitencoding.sh
+++ b/t/t9139-git-svn-non-utf8-commitencoding.sh
@@ -39,7 +39,7 @@ do
 	(
 		cd $H &&
 		git config --unset i18n.commitencoding &&
-		! git svn dcommit
+		test_must_fail git svn dcommit
 	)
 	'
 done
diff --git a/t/t9140-git-svn-reset.sh b/t/t9140-git-svn-reset.sh
index 0735526..e855904 100755
--- a/t/t9140-git-svn-reset.sh
+++ b/t/t9140-git-svn-reset.sh
@@ -41,7 +41,7 @@ test_expect_success 'modify hidden file in SVN repo' '
 test_expect_success 'fetch fails on modified hidden file' '
 	( cd g &&
 	  git svn find-rev refs/remotes/git-svn > ../expect &&
-	  ! git svn fetch 2> ../errors &&
+	  test_must_fail git svn fetch 2> ../errors &&
 	  git svn find-rev refs/remotes/git-svn > ../expect2 ) &&
 	fgrep "not found in commit" errors &&
 	test_cmp expect expect2
-- 
1.7.1.1
