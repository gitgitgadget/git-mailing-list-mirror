Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1B0B1F406
	for <e@80x24.org>; Sun, 13 May 2018 02:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeEMCYS (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:24:18 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35862 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbeEMCYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 22:24:16 -0400
Received: by mail-vk0-f43.google.com with SMTP id i185-v6so5526405vkg.3
        for <git@vger.kernel.org>; Sat, 12 May 2018 19:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LzGE8UCYF7JaPtrhRJuTEccTszyFKah8md8o+m/l4W8=;
        b=fQxLX6MV6uCMtc3dOfrnN47oiTETtWIDS5UHTvIgv/6x4xT/wpHAMJfvqXYt1RvOhH
         0Urb2pMH8aNw82lruTiUsXQc5rGLTBIAlCH95jNJanH00vlKY+nIkGUSYI/+jw0yRqj7
         wxN5OOi+qEvrk+IUP6n9xj7Hcw2LW3vUK12wBrKMesV7O36O6nzLX/CQscUr+2HK+uRW
         6fpNk47bE60KQxDau+awdxjoWZzqatkjbyzgb27S3yYWImG5ojv9hZyUA7vpcf3DJx3T
         PZi6RjWupz6uCaJlV3CaVY+RA6KAat4Sy7gMiL0VnMS2zYlxSK5TE56crAXLpnsW3TfS
         DDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LzGE8UCYF7JaPtrhRJuTEccTszyFKah8md8o+m/l4W8=;
        b=LawvZL+UCk4MlB6sm3uEfKT/xTJQhWoSWgk6bwqZ9Y9kNGq8oIrqop1ZCErVd6QJ4V
         eUc1a9TY49vFKmBCBb1I1rJ2SdaqB1UiFwTwmbEdz6WcmtD8D9bTyxgCGxpeXKV6b/fV
         psqIneLi36lo59aTZmQLDEZOZy6eb5QlKumLsxD4ttP0PEH2WNydfUK+7Ua0srY2Y6KN
         ogLSy0cJTPa1D/1GYtIsjT3eVFM5RV2SGPD7X0oW4aom4meIIHPwadcgZYKHiRp098ps
         NS0bgNivN5KqbZnvd01iC5U/ldk/TUFn7vkvviKkvJMw2S49ouKb7E5w7y7RZTl8IOt8
         Kc7Q==
X-Gm-Message-State: ALKqPwcrnhLIofWOfIlagaKAGNKRhH5PNuQ9VGd37KmxFNvYxpCvPbBm
        gCs5+8gJJc2DA8wsEWb2RUiS9GQ=
X-Google-Smtp-Source: AB8JxZqB5Pb6jAW+QoPgZ9XkXobYFRj460Fx4TlkV6WXXsiwv5FnhcNcUWhJnlBIxwo5w/Hw7njCzw==
X-Received: by 2002:a1f:fc82:: with SMTP id a124-v6mr6955004vki.43.1526178254794;
        Sat, 12 May 2018 19:24:14 -0700 (PDT)
Received: from localhost.localdomain (ip177-101-15-186.ct.co.cr. [186.15.101.177])
        by smtp.gmail.com with ESMTPSA id o24-v6sm1541308vki.33.2018.05.12.19.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 May 2018 19:24:14 -0700 (PDT)
From:   Dannier Castro L <danniercl@gmail.com>
To:     git@vger.kernel.org
Cc:     Dannier Castro L <danniercl@gmail.com>, gitster@pobox.com,
        Matthieu.Moy@imag.fr, jrnieder@gmail.com, bmwill@google.com
Subject: [PATCH 2/3] test: update tests for strict usage of -- checkout
Date:   Sat, 12 May 2018 20:23:33 -0600
Message-Id: <1526178214-30956-2-git-send-email-danniercl@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526178214-30956-1-git-send-email-danniercl@gmail.com>
References: <1526178214-30956-1-git-send-email-danniercl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The flag '--' must always be before any file path when <checkout>
command is used.

The list of 34 test files updated is shown:

  t0021-conversion.sh
  t0027-auto-crlf.sh
  t1011-read-tree-sparse-checkout.sh
  t1050-large.sh
  t1051-large-conversion.sh
  t2009-checkout-statinfo.sh
  t2010-checkout-ambiguous.sh
  t2013-checkout-submodule.sh
  t2016-checkout-patch.sh
  t2022-checkout-paths.sh
  t2028-worktree-move.sh
  t2030-unresolve-info.sh
  t3001-ls-files-others-exclude.sh
  t3509-cherry-pick-merge-df.sh
  t3510-cherry-pick-sequence.sh
  t4015-diff-whitespace.sh
  t4124-apply-ws-rule.sh
  t5403-post-checkout-hook.sh
  t6007-rev-list-cherry-pick-file.sh
  t6026-merge-attr.sh
  t6030-bisect-porcelain.sh
  t6111-rev-list-treesame.sh
  t7001-mv.sh
  t7008-grep-binary.sh
  t7201-co.sh
  t7300-clean.sh
  t7501-commit.sh
  t7502-commit.sh
  t7607-merge-overwrite.sh
  t7810-grep.sh
  t7811-grep-open.sh
  t8006-blame-textconv.sh
  t9010-svn-fe.sh
  t8003-blame-corner-cases.sh

Signed-off-by: Dannier Castro L <danniercl@gmail.com>
---
 t/t0021-conversion.sh                | 12 ++++++------
 t/t0027-auto-crlf.sh                 |  4 ++--
 t/t1011-read-tree-sparse-checkout.sh |  4 ++--
 t/t1050-large.sh                     |  2 +-
 t/t1051-large-conversion.sh          |  4 ++--
 t/t2009-checkout-statinfo.sh         |  6 +++---
 t/t2010-checkout-ambiguous.sh        |  4 ++--
 t/t2013-checkout-submodule.sh        |  4 ++--
 t/t2016-checkout-patch.sh            |  9 +--------
 t/t2022-checkout-paths.sh            |  4 ++--
 t/t2028-worktree-move.sh             |  2 +-
 t/t2030-unresolve-info.sh            |  6 +++---
 t/t3001-ls-files-others-exclude.sh   |  2 +-
 t/t3420-rebase-autostash.sh          |  2 +-
 t/t3510-cherry-pick-sequence.sh      |  4 ++--
 t/t3910-mac-os-precompose.sh         |  4 ++--
 t/t4015-diff-whitespace.sh           |  4 ++--
 t/t4117-apply-reject.sh              |  2 +-
 t/t4124-apply-ws-rule.sh             | 16 ++++++++--------
 t/t5403-post-checkout-hook.sh        |  2 +-
 t/t6007-rev-list-cherry-pick-file.sh |  2 +-
 t/t6026-merge-attr.sh                |  2 +-
 t/t6030-bisect-porcelain.sh          |  2 +-
 t/t6038-merge-text-auto.sh           |  2 +-
 t/t6050-replace.sh                   |  2 +-
 t/t6111-rev-list-treesame.sh         |  2 +-
 t/t7001-mv.sh                        |  2 +-
 t/t7008-grep-binary.sh               |  2 +-
 t/t7201-co.sh                        |  8 ++++----
 t/t7300-clean.sh                     |  2 +-
 t/t7501-commit.sh                    | 10 +++++-----
 t/t7502-commit.sh                    |  2 +-
 t/t7607-merge-overwrite.sh           |  4 ++--
 t/t7810-grep.sh                      |  2 +-
 t/t7811-grep-open.sh                 |  2 +-
 t/t8003-blame-corner-cases.sh        |  2 +-
 t/t8006-blame-textconv.sh            |  2 +-
 t/t9010-svn-fe.sh                    |  2 +-
 38 files changed, 71 insertions(+), 78 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 46f8e58..9f4955a 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -380,7 +380,7 @@ test_expect_success PERL 'required process filter should filter data' '
 		git commit -m "test commit 2" &&
 		rm -f test2.r "testsubdir/test3 '\''sq'\'',\$x=.r" &&
 
-		filter_git checkout --quiet --no-progress . &&
+		filter_git checkout --quiet --no-progress -- . &&
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
@@ -466,7 +466,7 @@ test_expect_success PERL 'required process filter should be used only for "clean
 
 		rm test.r &&
 
-		filter_git checkout --quiet --no-progress . &&
+		filter_git checkout --quiet --no-progress -- . &&
 		# If the filter would be used for "smudge", too, we would see
 		# "IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]" here
 		cat >expected.log <<-EOF &&
@@ -580,7 +580,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 		rm -f *.r &&
 
 		rm -f debug.log &&
-		git checkout --quiet --no-progress . 2>git-stderr.log &&
+		git checkout --quiet --no-progress -- . 2>git-stderr.log &&
 
 		grep "smudge write error at" git-stderr.log &&
 		grep "error: external filter" git-stderr.log &&
@@ -630,7 +630,7 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 		git add . &&
 		rm -f *.r &&
 
-		filter_git checkout --quiet --no-progress . &&
+		filter_git checkout --quiet --no-progress -- . &&
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
@@ -669,7 +669,7 @@ test_expect_success PERL 'process filter abort stops processing of all further f
 
 		# Note: This test assumes that Git filters files in alphabetical
 		# order ("abort.r" before "test.r").
-		filter_git checkout --quiet --no-progress . &&
+		filter_git checkout --quiet --no-progress -- . &&
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
@@ -763,7 +763,7 @@ test_expect_success PERL 'delayed checkout in process filter' '
 		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay10.b &&
 
 		rm *.a *.b &&
-		filter_git checkout . &&
+		filter_git checkout -- . &&
 		test_cmp_count ../a.exp a.log &&
 		test_cmp_count ../b.exp b.log &&
 
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index beb5927..3587e45 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -293,9 +293,9 @@ checkout_files () {
 	do
 		rm crlf_false_attr__$f.txt &&
 		if test -z "$ceol"; then
-			git checkout crlf_false_attr__$f.txt
+			git checkout -- crlf_false_attr__$f.txt
 		else
-			git -c core.eol=$ceol checkout crlf_false_attr__$f.txt
+			git -c core.eol=$ceol checkout -- crlf_false_attr__$f.txt
 		fi
 	done
 
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index c167f60..82e0013 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -257,7 +257,7 @@ test_expect_success 'checkout without --ignore-skip-worktree-bits' '
 	echo sub >.git/info/sparse-checkout &&
 	git checkout &&
 	echo modified >> sub/added &&
-	git checkout . &&
+	git checkout -- . &&
 	test_path_is_missing init.t &&
 	git diff --exit-code HEAD
 '
@@ -269,7 +269,7 @@ test_expect_success 'checkout with --ignore-skip-worktree-bits' '
 	echo sub >.git/info/sparse-checkout &&
 	git checkout &&
 	echo modified >> sub/added &&
-	git checkout --ignore-skip-worktree-bits . &&
+	git checkout --ignore-skip-worktree-bits -- . &&
 	test_path_is_file init.t &&
 	git diff --exit-code HEAD
 '
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 6fd264c..270bb40 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -89,7 +89,7 @@ test_expect_success 'add a large file or two' '
 test_expect_success 'checkout a large file' '
 	large1=$(git rev-parse :large1) &&
 	git update-index --add --cacheinfo 100644 $large1 another &&
-	git checkout another &&
+	git checkout -- another &&
 	test_cmp large1 another
 '
 
diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
index 8b7640b..7326528 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -18,7 +18,7 @@ check_input() {
 
 check_output() {
 	rm -f small large &&
-	git checkout small large &&
+	git checkout -- small large &&
 	head -n 1 large >large.head &&
 	test_cmp small large.head
 }
@@ -76,7 +76,7 @@ test_expect_success 'user-defined filters convert on output' '
 test_expect_success 'ident converts on output' '
 	set_attr ident &&
 	rm -f small large &&
-	git checkout small large &&
+	git checkout -- small large &&
 	sed -n "s/Id: .*/Id: SHA/p" <small >small.clean &&
 	head -n 1 large >large.head &&
 	sed -n "s/Id: .*/Id: SHA/p" <large.head >large.clean &&
diff --git a/t/t2009-checkout-statinfo.sh b/t/t2009-checkout-statinfo.sh
index f3c2152..0a51b14 100755
--- a/t/t2009-checkout-statinfo.sh
+++ b/t/t2009-checkout-statinfo.sh
@@ -37,13 +37,13 @@ test_expect_success 'path checkout' '
 	git reset --hard &&
 	test "$(git diff-files --raw)" = "" &&
 
-	git checkout master world &&
+	git checkout master -- world &&
 	test "$(git diff-files --raw)" = "" &&
 
-	git checkout side world &&
+	git checkout side -- world &&
 	test "$(git diff-files --raw)" = "" &&
 
-	git checkout master world &&
+	git checkout master -- world &&
 	test "$(git diff-files --raw)" = ""
 
 '
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
index 2e47fe0..87c8ad2 100755
--- a/t/t2010-checkout-ambiguous.sh
+++ b/t/t2010-checkout-ambiguous.sh
@@ -29,7 +29,7 @@ test_expect_success 'checkout world from the index' '
 '
 
 test_expect_success 'non ambiguous call' '
-	git checkout all
+	git checkout -- all
 '
 
 test_expect_success 'allow the most common case' '
@@ -44,7 +44,7 @@ test_expect_success 'check ambiguity' '
 test_expect_success 'check ambiguity in subdir' '
 	mkdir sub &&
 	# not ambiguous because sub/world does not exist
-	git -C sub checkout world ../all &&
+	git -C sub checkout world -- ../all &&
 	echo hello >sub/world &&
 	# ambiguous because sub/world does exist
 	test_must_fail git -C sub checkout world ../all
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 6ef1573..2581382 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -34,9 +34,9 @@ test_expect_success '"checkout <submodule>" updates the index only' '
 	git update-index --refresh &&
 	git diff-files --quiet &&
 	git diff-index --quiet --cached HEAD &&
-	git checkout HEAD^ submodule &&
+	git checkout HEAD^ -- submodule &&
 	test_must_fail git diff-files --quiet &&
-	git checkout HEAD submodule &&
+	git checkout HEAD -- submodule &&
 	git diff-files --quiet
 '
 
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index 9cd0ac4..c39d2c4 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -79,13 +79,6 @@ test_expect_success PERL 'git checkout -p handles deletion' '
 # dir/foo.  There's always an extra 'n' to reject edits to dir/foo in
 # the failure case (and thus get out of the loop).
 
-test_expect_success PERL 'path limiting works: dir' '
-	set_state dir/foo work head &&
-	(echo y; echo n) | git checkout -p dir &&
-	verify_saved_state bar &&
-	verify_state dir/foo head head
-'
-
 test_expect_success PERL 'path limiting works: -- dir' '
 	set_state dir/foo work head &&
 	(echo y; echo n) | git checkout -p -- dir &&
@@ -103,7 +96,7 @@ test_expect_success PERL 'path limiting works: HEAD^ -- dir' '
 test_expect_success PERL 'path limiting works: foo inside dir' '
 	set_state dir/foo work head &&
 	# the third n is to get out in case it mistakenly does not apply
-	(echo y; echo n; echo n) | (cd dir && git checkout -p foo) &&
+	(echo y; echo n; echo n) | (cd dir && git checkout -p -- foo) &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
index f46d049..6e254fa 100755
--- a/t/t2022-checkout-paths.sh
+++ b/t/t2022-checkout-paths.sh
@@ -26,7 +26,7 @@ test_expect_success 'checking out paths out of a tree does not clobber unrelated
 	echo untracked >expect.next2 &&
 	cat expect.next2 >dir/next2 &&
 
-	git checkout master dir &&
+	git checkout master -- dir &&
 
 	test_cmp expect.common dir/common &&
 	test_path_is_file dir/master &&
@@ -52,7 +52,7 @@ test_expect_success 'do not touch unmerged entries matching $path but not in $tr
 	EOF
 	git update-index --index-info <expect.next0 &&
 
-	git checkout master dir &&
+	git checkout master -- dir &&
 
 	test_cmp expect.common dir/common &&
 	test_path_is_file dir/master &&
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 5d5b363..3e869e8 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -111,7 +111,7 @@ test_expect_success 'remove locked worktree' '
 
 test_expect_success 'remove worktree with dirty tracked file' '
 	echo dirty >>destination/init.t &&
-	test_when_finished "git -C destination checkout init.t" &&
+	test_when_finished "git -C destination checkout -- init.t" &&
 	test_must_fail git worktree remove destination
 '
 
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index 309199b..b599c37 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -108,7 +108,7 @@ test_expect_success 'plumbing clears' '
 test_expect_success 'add records checkout -m undoes' '
 	prime_resolve_undo &&
 	git diff HEAD &&
-	git checkout --conflict=merge fi/le &&
+	git checkout --conflict=merge -- fi/le &&
 	echo checkout used the record and removed it &&
 	check_resolve_undo removed &&
 	echo the index and the work tree is unmerged again &&
@@ -131,7 +131,7 @@ test_expect_success 'rerere and rerere forget' '
 	rerere_id=$(cd .git/rr-cache && echo */postimage) &&
 	rerere_id=${rerere_id%/postimage} &&
 	test -f .git/rr-cache/$rerere_id/postimage &&
-	git checkout -m fi/le &&
+	git checkout -m -- fi/le &&
 	echo resurrect the conflict &&
 	grep "^=======" fi/le &&
 	echo reresolve the conflict &&
@@ -157,7 +157,7 @@ test_expect_success 'rerere and rerere forget (subdirectory)' '
 	rerere_id=$(cd .git/rr-cache && echo */postimage) &&
 	rerere_id=${rerere_id%/postimage} &&
 	test -f .git/rr-cache/$rerere_id/postimage &&
-	(cd fi && git checkout -m le) &&
+	(cd fi && git checkout -m -- le) &&
 	echo resurrect the conflict &&
 	grep "^=======" fi/le &&
 	echo reresolve the conflict &&
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 3fc484e..f376590 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -103,7 +103,7 @@ test_expect_success \
      test_cmp expect output'
 
 test_expect_success 'restore gitignore' '
-	git checkout --ignore-skip-worktree-bits $allignores &&
+	git checkout --ignore-skip-worktree-bits -- $allignores &&
 	rm .git/index
 '
 
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index e243700..7503b0f 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -345,7 +345,7 @@ test_expect_success 'autostash is saved on editor failure with conflict' '
 	) &&
 	echo conflicting-content >expected &&
 	test_cmp expected file0 &&
-	git checkout file0 &&
+	git checkout -- file0 &&
 	git stash pop &&
 	echo uncommitted-content >expected &&
 	test_cmp expected file0
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 0acf4b1..742e467 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -52,7 +52,7 @@ test_expect_success 'cherry-pick mid-cherry-pick-sequence' '
 	test_must_fail git cherry-pick base..anotherpick &&
 	test_cmp_rev picked CHERRY_PICK_HEAD &&
 	# "oops, I forgot that these patches rely on the change from base"
-	git checkout HEAD foo &&
+	git checkout HEAD -- foo &&
 	git cherry-pick base &&
 	git cherry-pick picked &&
 	git cherry-pick --continue &&
@@ -205,7 +205,7 @@ test_expect_success '--abort refuses to clobber unrelated change, harder case' '
 	test_line_count = 2 log &&
 	test_must_fail git update-index --refresh &&
 
-	git checkout unrelated &&
+	git checkout -- unrelated &&
 	git cherry-pick --abort &&
 	test_cmp_rev initial HEAD
 '
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
index 26dd5b7..6932f20 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -141,9 +141,9 @@ test_expect_success "git checkout nfc" '
 	git checkout f.$Odiarnfc
 '
 # Make it possible to checkout files with their NFD names
-test_expect_success "git checkout file nfd" '
+test_expect_success "git checkout -- file nfd" '
 	rm -f f.* &&
-	git checkout f.$Odiarnfd
+	git checkout -- f.$Odiarnfd
 '
 # Make it possible to checkout links with their NFD names
 test_expect_success "git checkout link nfd" '
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 17df491..90da499 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -552,7 +552,7 @@ test_expect_success 'check with space before tab in indent' '
 '
 
 test_expect_success '--check and --exit-code are not exclusive' '
-	git checkout x &&
+	git checkout -- x &&
 	git diff --check --exit-code
 '
 
@@ -769,7 +769,7 @@ test_expect_success 'checkdiff detects new trailing blank lines (2)' '
 '
 
 test_expect_success 'checkdiff allows new blank lines' '
-	git checkout x &&
+	git checkout -- x &&
 	mv x y &&
 	(
 		echo "/* This is new */" &&
diff --git a/t/t4117-apply-reject.sh b/t/t4117-apply-reject.sh
index d80187d..e97dfa5 100755
--- a/t/t4117-apply-reject.sh
+++ b/t/t4117-apply-reject.sh
@@ -49,7 +49,7 @@ test_expect_success setup '
 test_expect_success 'apply --reject is incompatible with --3way' '
 	test_when_finished "cat saved.file1 >file1" &&
 	git diff >patch.0 &&
-	git checkout file1 &&
+	git checkout -- file1 &&
 	test_must_fail git apply --reject --3way patch.0 &&
 	git diff --exit-code
 '
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 4fc27c5..ae5ace7 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -223,7 +223,7 @@ test_expect_success 'blank at EOF with --whitespace=fix (1)' '
 	{ cat expect; echo; } >one &&
 	git diff -- one >patch &&
 
-	git checkout one &&
+	git checkout -- one &&
 	git apply --whitespace=fix patch &&
 	test_cmp expect one
 '
@@ -235,7 +235,7 @@ test_expect_success 'blank at EOF with --whitespace=fix (2)' '
 	{ cat expect; echo; echo; } >one &&
 	git diff -- one >patch &&
 
-	git checkout one &&
+	git checkout -- one &&
 	git apply --whitespace=fix patch &&
 	test_cmp expect one
 '
@@ -247,7 +247,7 @@ test_expect_success 'blank at EOF with --whitespace=fix (3)' '
 	{ cat expect; echo; echo; } >one &&
 	git diff -- one >patch &&
 
-	git checkout one &&
+	git checkout -- one &&
 	git apply --whitespace=fix patch &&
 	test_cmp expect one
 '
@@ -259,7 +259,7 @@ test_expect_success 'blank at end of hunk, not at EOF with --whitespace=fix' '
 	cp expect one &&
 	git diff -- one >patch &&
 
-	git checkout one &&
+	git checkout -- one &&
 	git apply --whitespace=fix patch &&
 	test_cmp expect one
 '
@@ -271,7 +271,7 @@ test_expect_success 'blank at EOF with --whitespace=warn' '
 	cat one >expect &&
 	git diff -- one >patch &&
 
-	git checkout one &&
+	git checkout -- one &&
 	git apply --whitespace=warn patch 2>error &&
 	test_cmp expect one &&
 	grep "new blank line at EOF" error
@@ -284,7 +284,7 @@ test_expect_success 'blank at EOF with --whitespace=error' '
 	echo >>one &&
 	git diff -- one >patch &&
 
-	git checkout one &&
+	git checkout -- one &&
 	test_must_fail git apply --whitespace=error patch 2>error &&
 	test_cmp expect one &&
 	grep "new blank line at EOF" error
@@ -297,7 +297,7 @@ test_expect_success 'blank but not empty at EOF' '
 	cat one >expect &&
 	git diff -- one >patch &&
 
-	git checkout one &&
+	git checkout -- one &&
 	git apply --whitespace=warn patch 2>error &&
 	test_cmp expect one &&
 	grep "new blank line at EOF" error
@@ -309,7 +309,7 @@ test_expect_success 'applying beyond EOF requires one non-blank context line' '
 	{ echo b; } >>one &&
 	git diff -- one >patch &&
 
-	git checkout one &&
+	git checkout -- one &&
 	{ echo a; echo; } >one &&
 	cp one expect &&
 	test_must_fail git apply --whitespace=fix patch &&
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index fc898c9..f72ee38 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -64,7 +64,7 @@ test_expect_success 'post-checkout receives the right args with HEAD changed ' '
 '
 
 test_expect_success 'post-checkout receives the right args when not switching branches ' '
-	GIT_DIR=clone2/.git git checkout master b &&
+	GIT_DIR=clone2/.git git checkout master -- b &&
 	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
 	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
 	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index f026837..e5b0daa 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -32,7 +32,7 @@ test_expect_success setup '
 	git commit -m "E" &&
 	git tag E &&
 	git checkout master &&
-	git checkout branch foo &&
+	git checkout branch -- foo &&
 	test_tick &&
 	git commit -m "B" &&
 	git tag B &&
diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 8f9b48a..4aae0e9 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -72,7 +72,7 @@ test_expect_success 'check merge result in working tree' '
 
 test_expect_success 'retry the merge with longer context' '
 	echo text conflict-marker-size=32 >>.gitattributes &&
-	git checkout -m text &&
+	git checkout -m -- text &&
 	sed -ne "/^\([<=>]\)\1\1\1*/{
 		s/ .*$//
 		p
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index f84ff94..7104f08 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -177,7 +177,7 @@ test_expect_success 'bisect start: no ".git/BISECT_START" if checkout error' '
 	grep "* other" branch.output > /dev/null &&
 	test_must_fail test -e .git/BISECT_START &&
 	test -z "$(git for-each-ref "refs/bisect/*")" &&
-	git checkout HEAD hello
+	git checkout HEAD -- hello
 '
 
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 5e8d5fa..2e2979b 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -51,7 +51,7 @@ test_expect_success setup '
 
 	git rm .gitattributes &&
 	rm file &&
-	git checkout file &&
+	git checkout -- file &&
 	test_tick &&
 	git commit -m "remove .gitattributes" &&
 	git tag c &&
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c630aba..0bea83c 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -292,7 +292,7 @@ test_expect_success 'not just commits' '
 	git update-ref refs/replace/$ORIGINAL $REPLACED &&
 	mv file file.original &&
 
-	git checkout file &&
+	git checkout -- file &&
 	test_cmp file.replaced file
 '
 
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index 32474c2..bc46a77 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -43,7 +43,7 @@ test_expect_success setup '
 	test_commit "file=Blah" file "Blah" F &&
 
 	test_tick && git merge --no-commit third-branch &&
-	git checkout third-branch file &&
+	git checkout third-branch -- file &&
 	git commit &&
 	note G &&
 	git branch fiddler-branch &&
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index d4e6485..f46903f 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -481,7 +481,7 @@ test_expect_success 'mv -k does not accidentally destroy submodules' '
 	git status --porcelain >actual &&
 	grep "^R  sub -> dest/sub" actual &&
 	git reset --hard &&
-	git checkout .
+	git checkout -- .
 '
 
 test_expect_success 'moving a submodule in nested directories' '
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 615e7e0..de19773 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -192,7 +192,7 @@ test_expect_success 'grep --cached respects binary diff attribute (2)' '
 	rm .gitattributes &&
 	git grep --cached text t >actual &&
 	test_when_finished "git rm --cached .gitattributes" &&
-	test_when_finished "git checkout .gitattributes" &&
+	test_when_finished "git checkout -- .gitattributes" &&
 	test_cmp expect actual
 '
 
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 76c223c..65a3d24 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -498,7 +498,7 @@ test_expect_success 'checkout with an unmerged path can be ignored' '
 	cat sample >fild &&
 	cat sample >file &&
 	cat sample >filf &&
-	git checkout -f fild file filf &&
+	git checkout -f -- fild file filf &&
 	test_cmp expect fild &&
 	test_cmp expect filf &&
 	test_cmp sample file
@@ -511,11 +511,11 @@ test_expect_success 'checkout unmerged stage' '
 	cat sample >fild &&
 	cat sample >file &&
 	cat sample >filf &&
-	git checkout --ours . &&
+	git checkout --ours -- . &&
 	test_cmp expect fild &&
 	test_cmp expect filf &&
 	test_cmp expect file &&
-	git checkout --theirs file &&
+	git checkout --theirs -- file &&
 	test ztheirside = "z$(cat file)"
 '
 
@@ -677,7 +677,7 @@ test_expect_success 'custom merge driver with checkout -m' '
 	) &&
 
 	mv arm expect &&
-	git checkout -m arm &&
+	git checkout -m -- arm &&
 	test_cmp expect arm
 '
 
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 7b36954..7b22454 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -38,7 +38,7 @@ test_expect_success 'git clean with skip-worktree .gitignore' '
 	test -f obj.o &&
 	test -f build/lib.so &&
 	git update-index --no-skip-worktree .gitignore &&
-	git checkout .gitignore
+	git checkout -- .gitignore
 '
 
 test_expect_success 'git clean' '
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index fa61b1a..bae0137 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -30,12 +30,12 @@ test_expect_success 'setup: initial commit' '
 '
 
 test_expect_success '-m and -F do not mix' '
-	git checkout HEAD file && echo >>file && git add file &&
+	git checkout HEAD -- file && echo >>file && git add file &&
 	test_must_fail git commit -m foo -m bar -F file
 '
 
 test_expect_success '-m and -C do not mix' '
-	git checkout HEAD file && echo >>file && git add file &&
+	git checkout HEAD -- file && echo >>file && git add file &&
 	test_must_fail git commit -C HEAD -m illegal
 '
 
@@ -119,18 +119,18 @@ test_expect_success 'empty commit message' '
 '
 
 test_expect_success 'template "emptyness" check does not kick in with -F' '
-	git checkout HEAD file && echo >>file && git add file &&
+	git checkout HEAD -- file && echo >>file && git add file &&
 	git commit -t file -F file
 '
 
 test_expect_success 'template "emptyness" check' '
-	git checkout HEAD file && echo >>file && git add file &&
+	git checkout HEAD -- file && echo >>file && git add file &&
 	test_must_fail git commit -t file 2>err &&
 	test_i18ngrep "did not edit" err
 '
 
 test_expect_success 'setup: commit message from file' '
-	git checkout HEAD file && echo >>file && git add file &&
+	git checkout HEAD -- file && echo >>file && git add file &&
 	echo this is the commit message, coming from a file >msg &&
 	git commit -F msg -a
 '
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index d33a3cb..ec8df56 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -470,7 +470,7 @@ test_expect_success 'Hand committing of a redundant merge removes dups' '
 
 	git rev-parse second master >expect &&
 	test_must_fail git merge second master &&
-	git checkout master g &&
+	git checkout master -- g &&
 	EDITOR=: git commit -a &&
 	git cat-file commit HEAD | sed -n -e "s/^parent //p" -e "/^$/q" >actual &&
 	test_cmp expect actual
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 9c422bc..5e2ea53 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -55,7 +55,7 @@ test_expect_success 'will not overwrite staged changes' '
 	rm c2.c &&
 	test_must_fail git merge c2 &&
 	test_path_is_missing .git/MERGE_HEAD &&
-	git checkout c2.c &&
+	git checkout -- c2.c &&
 	test_cmp important c2.c
 '
 
@@ -88,7 +88,7 @@ test_expect_success 'will not overwrite removed file with staged changes' '
 	rm c1.c &&
 	test_must_fail git merge c1a &&
 	test_path_is_missing .git/MERGE_HEAD &&
-	git checkout c1.c &&
+	git checkout -- c1.c &&
 	test_cmp important c1.c
 '
 
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1797f63..8d00cc6 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -714,7 +714,7 @@ test_expect_success 'grep with CE_VALID file' '
 	rm t/t &&
 	test "$(git grep test)" = "t/t:test" &&
 	git update-index --no-assume-unchanged t/t &&
-	git checkout t/t
+	git checkout -- t/t
 '
 
 cat >expected <<EOF
diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index e1951a5..e0e0fbf 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -119,7 +119,7 @@ test_expect_success 'modified file' '
 	>empty &&
 
 	echo "enum grep_pat_token" >unrelated &&
-	test_when_finished "git checkout HEAD unrelated" &&
+	test_when_finished "git checkout HEAD -- unrelated" &&
 	GIT_PAGER=./less git grep -F -O "enum grep_pat_token" >out &&
 	test_cmp expect actual &&
 	test_cmp empty out
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 661f9d4..da3f98f 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -265,7 +265,7 @@ test_expect_success 'blame file with CRLF core.autocrlf=true' '
 	git commit -m "add crlfinrepo" &&
 	git config core.autocrlf true &&
 	mv crlfinrepo tmp &&
-	git checkout crlfinrepo &&
+	git checkout -- crlfinrepo &&
 	rm tmp &&
 	git blame crlfinrepo >actual &&
 	grep "A U Thor" actual
diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index 7683515..a81d677 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -73,7 +73,7 @@ test_expect_success 'blame --textconv going through revisions' '
 '
 
 test_expect_success 'blame --textconv with local changes' '
-	test_when_finished "git checkout zero.bin" &&
+	test_when_finished "git checkout -- zero.bin" &&
 	printf "bin: updated number 0\015" >zero.bin &&
 	git blame --textconv zero.bin >blame &&
 	expect="(Not Committed Yet ....-..-.. ..:..:.. +0000 1)" &&
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 8eaaca6..ba54fb2 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -258,7 +258,7 @@ test_expect_success 'directory with files' '
 	try_dump directory.dump &&
 
 	git ls-tree -r --name-only HEAD >actual.files &&
-	git checkout HEAD directory &&
+	git checkout HEAD -- directory &&
 	test_cmp expect.files actual.files &&
 	test_cmp hello directory/file1 &&
 	test_cmp hi directory/file2
-- 
2.7.4

