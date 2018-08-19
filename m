Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AB281F954
	for <e@80x24.org>; Sun, 19 Aug 2018 21:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeHTBKn (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 21:10:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40079 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeHTBKn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 21:10:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id y9-v6so12055702wma.5
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 14:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cPPzwSASUcinXcDzBiM5iQT5lGtSsiVGEDoPZiXPNtA=;
        b=NiyUxszfzhFEjMqQ8vL7Z6f2UKA78t8zIeavIwEmmdAreEgoyUg+GKFUz/G3a2D7Vh
         9Q2oaKK/hfIXQ/e6RwoS5azy33kbgU0JKxnnj5RlEL2/2ekaXm17/2VSaiWnBaqqYejm
         8DqHclPr4KoQX2Wi6107jl5/LsZbcFKwCHzZ3v5sUUmVC/vPVHg8Vx5J1Mf1Q4xRurrM
         KV/j3k+YtmacWGUozNWYfIyvjsoc7Txv3BjcZnQ5rjkopd9gDKQ3ReUeK8TSqlZzAzN+
         xaCg/+2NPrpAMfx3gpaZHIvByo8xECidds6SUCztvrftp7Yfq9azTK5WeQ2O4Y4o2swv
         588g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cPPzwSASUcinXcDzBiM5iQT5lGtSsiVGEDoPZiXPNtA=;
        b=fAA8nJqq0TEeM8UL5yFZ13n2FhBTPJUaO+1kBJmqUrEpbrZL3q1BPfLsxPQxjqDCfW
         HQ/zCQS3C+KhGDLeqxIjmtgPe2MJdRUD/UwDuO26vlABMrdTHqua3jE9zeb2rjvQ5vV+
         XwmrBI1FNi9QvvPe0ejZGCDnv3RYOTVtnb43LWSTUJxGeMBODMpBa7VvEmcU4rdJdx7+
         rkLweXYpIibA/fgIH9zTqKkk2y+7vnEYYB+st8zCEBSGncr54KSuIB94QO1emUD0cLDw
         gqiaKQV2wmlUQz/TcXFjKvjUqBHZR4fLLbgBf/B2gYMDUlwzZdDHUzpSzDl1R5WxFVef
         hzcA==
X-Gm-Message-State: AOUpUlFghCt2oDL2wTlF1KnzCwQbt9dbFS1SK88e6DsWUyVkiouvBzZl
        M67kiLD3ki7J6TCwseL6ktY=
X-Google-Smtp-Source: AA+uWPyXQk6dcbK+vzKY5pxsvE3SPHqNr0NjvmxPOYXgSX1W4xZG9WYkQxZsLsG+HpjFBWzVARW/mg==
X-Received: by 2002:a1c:6709:: with SMTP id b9-v6mr24475782wmc.68.1534715862259;
        Sun, 19 Aug 2018 14:57:42 -0700 (PDT)
Received: from localhost.localdomain (84-236-78-30.pool.digikabel.hu. [84.236.78.30])
        by smtp.gmail.com with ESMTPSA id x82-v6sm30485975wmd.11.2018.08.19.14.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Aug 2018 14:57:41 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/4] tests: use 'test_must_be_empty' instead of '! test -s'
Date:   Sun, 19 Aug 2018 23:57:22 +0200
Message-Id: <20180819215725.29001-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.903.gab616d7dc6
In-Reply-To: <20180819215725.29001-1-szeder.dev@gmail.com>
References: <20180819215725.29001-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using 'test_must_be_empty' is preferable to '! test -s', because it
gives a helpful error message if the given file is unexpectedly not
empty, while the latter remains completely silent.  Furthermore, it
also catches cases when the given file unexpectedly does not exist at
all.

This patch was basically created by:

  sed -i -e 's/! test -s/test_must_be_empty/' t[0-9]*.sh

with the following notable exceptions:

  - The '! test -s' check in '.gitmodules ignore=dirty suppresses
    submodules with untracked content' in 't7508-status.sh' is left
    as-is, because it's bogus and, therefore, it's subject of a
    dedicated patch.

  - The '! test -s' checks in 't9131-git-svn-empty-symlink.sh' and
    't9135-git-svn-moved-branch-empty-file.sh' are immediately
    preceeded by a 'test -f' to ensure that the files exist in the
    first place.  'test_must_be_empty' ensures that as well, so those
    'test -f' commands are removed as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

That dedicated patch to t7508 can be found at:

  https://public-inbox.org/git/20180818175606.24108-1-szeder.dev@gmail.com/

 t/t0000-basic.sh                             |  2 +-
 t/t0090-cache-tree.sh                        |  2 +-
 t/t0203-gettext-setlocale-sanity.sh          |  4 +-
 t/t1501-work-tree.sh                         |  2 +-
 t/t1510-repo-setup.sh                        | 24 +++++------
 t/t2013-checkout-submodule.sh                |  6 +--
 t/t2204-add-ignored.sh                       |  8 ++--
 t/t3600-rm.sh                                |  6 +--
 t/t4011-diff-symlink.sh                      |  2 +-
 t/t4019-diff-wserror.sh                      |  2 +-
 t/t4027-diff-submodule.sh                    | 26 ++++++------
 t/t4041-diff-submodule-option.sh             | 14 +++----
 t/t4060-diff-submodule-option-diff-format.sh | 14 +++----
 t/t4124-apply-ws-rule.sh                     |  2 +-
 t/t4150-am.sh                                |  4 +-
 t/t5401-update-hooks.sh                      | 10 ++---
 t/t5500-fetch-pack.sh                        |  2 +-
 t/t5526-fetch-submodules.sh                  | 42 ++++++++++----------
 t/t5570-git-daemon.sh                        |  2 +-
 t/t7001-mv.sh                                |  6 +--
 t/t7201-co.sh                                |  4 +-
 t/t7406-submodule-update.sh                  |  2 +-
 t/t7810-grep.sh                              |  2 +-
 t/t9131-git-svn-empty-symlink.sh             |  6 +--
 t/t9135-git-svn-moved-branch-empty-file.sh   |  3 +-
 25 files changed, 98 insertions(+), 99 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index af61d083b4..4e588eda09 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -116,7 +116,7 @@ check_sub_test_lib_test () {
 	name="$1" # stdin is the expected output from the test
 	(
 		cd "$name" &&
-		! test -s err &&
+		test_must_be_empty err &&
 		sed -e 's/^> //' -e 's/Z$//' >expect &&
 		test_cmp expect out
 	)
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 0c61268fd2..9e88a56d61 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -239,7 +239,7 @@ test_expect_success 'no phantom error when switching trees' '
 	>newdir/one &&
 	git add newdir/one &&
 	git checkout 2>errors &&
-	! test -s errors
+	test_must_be_empty errors
 '
 
 test_expect_success 'switching trees does not invalidate shared index' '
diff --git a/t/t0203-gettext-setlocale-sanity.sh b/t/t0203-gettext-setlocale-sanity.sh
index 71b0d74b4d..0ce1f22eff 100755
--- a/t/t0203-gettext-setlocale-sanity.sh
+++ b/t/t0203-gettext-setlocale-sanity.sh
@@ -11,7 +11,7 @@ test_expect_success 'git show a ISO-8859-1 commit under C locale' '
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 	test_commit "iso-c-commit" iso-under-c &&
 	git show >out 2>err &&
-	! test -s err &&
+	test_must_be_empty err &&
 	grep -q "iso-c-commit" out
 '
 
@@ -19,7 +19,7 @@ test_expect_success GETTEXT_LOCALE 'git show a ISO-8859-1 commit under a UTF-8 l
 	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 	test_commit "iso-utf8-commit" iso-under-utf8 &&
 	LANGUAGE=is LC_ALL="$is_IS_locale" git show >out 2>err &&
-	! test -s err &&
+	test_must_be_empty err &&
 	grep -q "iso-utf8-commit" out
 '
 
diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
index afcdfafe45..3498d3d55e 100755
--- a/t/t1501-work-tree.sh
+++ b/t/t1501-work-tree.sh
@@ -41,7 +41,7 @@ test_expect_success 'setup: helper for testing rev-parse' '
 			# rev-parse --show-prefix should output
 			# a single newline when at the top of the work tree,
 			# but we test for that separately.
-			test -z "$4" && ! test -s actual.prefix ||
+			test -z "$4" && test_must_be_empty actual.prefix ||
 			test_cmp expected.prefix actual.prefix
 		fi
 	}
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 972bd9c785..9974457f56 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -234,14 +234,14 @@ test_expect_success '#0: nonbare repo, no explicit configuration' '
 	try_repo 0 unset unset unset "" unset \
 		.git "$here/0" "$here/0" "(null)" \
 		.git "$here/0" "$here/0" sub/ 2>message &&
-	! test -s message
+	test_must_be_empty message
 '
 
 test_expect_success '#1: GIT_WORK_TREE without explicit GIT_DIR is accepted' '
 	try_repo 1 "$here" unset unset "" unset \
 		"$here/1/.git" "$here" "$here" 1/ \
 		"$here/1/.git" "$here" "$here" 1/sub/ 2>message &&
-	! test -s message
+	test_must_be_empty message
 '
 
 test_expect_success '#2: worktree defaults to cwd with explicit GIT_DIR' '
@@ -268,7 +268,7 @@ test_expect_success '#4: core.worktree without GIT_DIR set is accepted' '
 	try_case 4 unset unset \
 		.git "$here/4/sub" "$here/4" "(null)" \
 		"$here/4/.git" "$here/4/sub" "$here/4/sub" "(null)" 2>message &&
-	! test -s message
+	test_must_be_empty message
 '
 
 test_expect_success '#5: core.worktree + GIT_WORK_TREE is accepted' '
@@ -279,7 +279,7 @@ test_expect_success '#5: core.worktree + GIT_WORK_TREE is accepted' '
 	try_repo 5a .. unset "$here/5a" "" unset \
 		"$here/5a/.git" "$here" "$here" 5a/ \
 		"$here/5a/.git" "$here/5a" "$here/5a" sub/ &&
-	! test -s message
+	test_must_be_empty message
 '
 
 test_expect_success '#6: setting GIT_DIR brings core.worktree to life' '
@@ -376,7 +376,7 @@ test_expect_success '#9: GIT_WORK_TREE accepted with gitfile' '
 	try_repo 9 wt unset unset gitfile unset \
 		"$here/9.git" "$here/9/wt" "$here/9" "(null)" \
 		"$here/9.git" "$here/9/sub/wt" "$here/9/sub" "(null)" 2>message &&
-	! test -s message
+	test_must_be_empty message
 '
 
 test_expect_success '#10: GIT_DIR can point to gitfile' '
@@ -402,7 +402,7 @@ test_expect_success '#12: core.worktree with gitfile is accepted' '
 	try_repo 12 unset unset "$here/12" gitfile unset \
 		"$here/12.git" "$here/12" "$here/12" "(null)" \
 		"$here/12.git" "$here/12" "$here/12" sub/ 2>message &&
-	! test -s message
+	test_must_be_empty message
 '
 
 test_expect_success '#13: core.worktree+GIT_WORK_TREE accepted (with gitfile)' '
@@ -410,7 +410,7 @@ test_expect_success '#13: core.worktree+GIT_WORK_TREE accepted (with gitfile)' '
 	try_repo 13 non-existent-too unset non-existent gitfile unset \
 		"$here/13.git" "$here/13/non-existent-too" "$here/13" "(null)" \
 		"$here/13.git" "$here/13/sub/non-existent-too" "$here/13/sub" "(null)" 2>message &&
-	! test -s message
+	test_must_be_empty message
 '
 
 # case #14.
@@ -565,7 +565,7 @@ test_expect_success '#17: GIT_WORK_TREE without explicit GIT_DIR is accepted (ba
 	try_repo 17c "$here/17c" unset unset "" true \
 		.git "$here/17c" "$here/17c" "(null)" \
 		"$here/17c/.git" "$here/17c" "$here/17c" sub/ 2>message &&
-	! test -s message
+	test_must_be_empty message
 '
 
 test_expect_success '#18: bare .git named by GIT_DIR has no worktree' '
@@ -594,7 +594,7 @@ test_expect_success '#20a: core.worktree without GIT_DIR accepted (inside .git)'
 		"$here/20a/.git" "$here/20a" "$here/20a" .git/wt/ &&
 	try_case 20a/.git/wt/sub unset unset \
 		"$here/20a/.git" "$here/20a" "$here/20a" .git/wt/sub/ &&
-	! test -s message
+	test_must_be_empty message
 '
 
 test_expect_success '#20b/c: core.worktree and core.bare conflict' '
@@ -626,7 +626,7 @@ test_expect_success '#21: setup, core.worktree warns before overriding core.bare
 		export GIT_WORK_TREE &&
 		git status >/dev/null
 	) 2>message &&
-	! test -s message
+	test_must_be_empty message
 
 '
 run_wt_tests 21
@@ -742,7 +742,7 @@ test_expect_success '#25: GIT_WORK_TREE accepted if GIT_DIR unset (bare gitfile
 	try_repo 25 "$here/25" unset unset gitfile true \
 		"$here/25.git" "$here/25" "$here/25" "(null)"  \
 		"$here/25.git" "$here/25" "$here/25" "sub/" 2>message &&
-	! test -s message
+	test_must_be_empty message
 '
 
 test_expect_success '#26: bare repo has no worktree (GIT_DIR -> gitfile case)' '
@@ -780,7 +780,7 @@ test_expect_success '#29: setup' '
 		export GIT_WORK_TREE &&
 		git status
 	) 2>message &&
-	! test -s message
+	test_must_be_empty message
 '
 run_wt_tests 29 gitfile
 
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 6ef15738e4..8f86b5f4b2 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -44,7 +44,7 @@ test_expect_success '"checkout <submodule>" honors diff.ignoreSubmodules' '
 	git config diff.ignoreSubmodules dirty &&
 	echo x> submodule/untracked &&
 	git checkout HEAD >actual 2>&1 &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .gitmodules' '
@@ -52,7 +52,7 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .gitm
 	git config -f .gitmodules submodule.submodule.path submodule &&
 	git config -f .gitmodules submodule.submodule.ignore untracked &&
 	git checkout HEAD >actual 2>&1 &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/config' '
@@ -60,7 +60,7 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
 	git config submodule.submodule.path submodule &&
 	git config submodule.submodule.ignore all &&
 	git checkout HEAD >actual 2>&1 &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
index 8340ac2f07..2e07365bbb 100755
--- a/t/t2204-add-ignored.sh
+++ b/t/t2204-add-ignored.sh
@@ -31,7 +31,7 @@ do
 		rm -f .git/index &&
 		test_must_fail git add "$i" 2>err &&
 		git ls-files "$i" >out &&
-		! test -s out
+		test_must_be_empty out
 	'
 
 	test_expect_success "complaints for ignored $i output" '
@@ -42,7 +42,7 @@ do
 		rm -f .git/index &&
 		test_must_fail git add "$i" file 2>err &&
 		git ls-files "$i" >out &&
-		! test -s out
+		test_must_be_empty out
 	'
 	test_expect_success "complaints for ignored $i with unignored file output" '
 		test_i18ngrep -e "Use -f if" err
@@ -57,7 +57,7 @@ do
 			cd dir &&
 			test_must_fail git add "$i" 2>err &&
 			git ls-files "$i" >out &&
-			! test -s out
+			test_must_be_empty out
 		)
 	'
 
@@ -77,7 +77,7 @@ do
 			cd sub &&
 			test_must_fail git add "$i" 2>err &&
 			git ls-files "$i" >out &&
-			! test -s out
+			test_must_be_empty out
 		)
 	'
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b8fbdefcdc..b178a376c4 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -382,7 +382,7 @@ test_expect_success 'rm does not complain when no .gitmodules file is found' '
 	git submodule update &&
 	git rm .gitmodules &&
 	git rm submod >actual 2>actual.err &&
-	! test -s actual.err &&
+	test_must_be_empty actual.err &&
 	! test -d submod &&
 	! test -f submod/.git &&
 	git status -s -uno >actual &&
@@ -400,7 +400,7 @@ test_expect_success 'rm will error out on a modified .gitmodules file unless sta
 	git diff-files --quiet -- submod &&
 	git add .gitmodules &&
 	git rm submod >actual 2>actual.err &&
-	! test -s actual.err &&
+	test_must_be_empty actual.err &&
 	! test -d submod &&
 	! test -f submod/.git &&
 	git status -s -uno >actual &&
@@ -694,7 +694,7 @@ test_expect_success 'checking out a commit after submodule removal needs manual
 	test_cmp expected actual &&
 	rm -rf submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'rm of d/f when d has become a non-directory' '
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 108c012a3a..5ae19b987d 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -126,7 +126,7 @@ test_expect_success SYMLINKS 'diff symlinks with non-existing targets' '
 	ln -s take\ over brain &&
 	test_must_fail git diff --no-index pinky brain >output 2>output.err &&
 	grep narf output &&
-	! test -s output.err
+	test_must_be_empty output.err
 '
 
 test_expect_success SYMLINKS 'setup symlinks with attributes' '
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index a5019759bc..c6135c7548 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -260,7 +260,7 @@ test_expect_success 'trailing empty lines (2)' '
 
 	echo "F -whitespace" >.gitattributes &&
 	git diff --check >output &&
-	! test -s output
+	test_must_be_empty output
 
 '
 
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 6304130ad4..e5f9eb7a11 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -104,19 +104,19 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)'
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
 	git diff --ignore-submodules HEAD >actual2 &&
-	! test -s actual2 &&
+	test_must_be_empty actual2 &&
 	git diff --ignore-submodules=untracked HEAD >actual3 &&
 	sed -e "1,/^@@/d" actual3 >actual3.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual3.body &&
 	git diff --ignore-submodules=dirty HEAD >actual4 &&
-	! test -s actual4
+	test_must_be_empty actual4
 '
 
 test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match) [.gitmodules]' '
 	git config diff.ignoreSubmodules dirty &&
 	git diff HEAD >actual &&
-	! test -s actual &&
+	test_must_be_empty actual &&
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sub &&
 	git diff HEAD >actual &&
@@ -126,7 +126,7 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)
 	git config -f .gitmodules submodule.subname.ignore all &&
 	git config -f .gitmodules submodule.subname.path sub &&
 	git diff HEAD >actual2 &&
-	! test -s actual2 &&
+	test_must_be_empty actual2 &&
 	git config -f .gitmodules submodule.subname.ignore untracked &&
 	git diff HEAD >actual3 &&
 	sed -e "1,/^@@/d" actual3 >actual3.body &&
@@ -134,7 +134,7 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)
 	test_cmp expect.body actual3.body &&
 	git config -f .gitmodules submodule.subname.ignore dirty &&
 	git diff HEAD >actual4 &&
-	! test -s actual4 &&
+	test_must_be_empty actual4 &&
 	git config submodule.subname.ignore none &&
 	git config submodule.subname.path sub &&
 	git diff HEAD >actual &&
@@ -172,24 +172,24 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
 	git diff --ignore-submodules=all HEAD >actual2 &&
-	! test -s actual2 &&
+	test_must_be_empty actual2 &&
 	git diff --ignore-submodules=untracked HEAD >actual3 &&
-	! test -s actual3 &&
+	test_must_be_empty actual3 &&
 	git diff --ignore-submodules=dirty HEAD >actual4 &&
-	! test -s actual4
+	test_must_be_empty actual4
 '
 
 test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match) [.gitmodules]' '
 	git config --add -f .gitmodules submodule.subname.ignore all &&
 	git config --add -f .gitmodules submodule.subname.path sub &&
 	git diff HEAD >actual2 &&
-	! test -s actual2 &&
+	test_must_be_empty actual2 &&
 	git config -f .gitmodules submodule.subname.ignore untracked &&
 	git diff HEAD >actual3 &&
-	! test -s actual3 &&
+	test_must_be_empty actual3 &&
 	git config -f .gitmodules submodule.subname.ignore dirty &&
 	git diff HEAD >actual4 &&
-	! test -s actual4 &&
+	test_must_be_empty actual4 &&
 	git config submodule.subname.ignore none &&
 	git config submodule.subname.path sub &&
 	git diff HEAD >actual &&
@@ -211,7 +211,7 @@ test_expect_success 'git diff between submodule commits' '
 	expect_from_to >expect.body $subtip $subprev &&
 	test_cmp expect.body actual.body &&
 	git diff --ignore-submodules HEAD^..HEAD >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'git diff between submodule commits [.gitmodules]' '
@@ -227,7 +227,7 @@ test_expect_success 'git diff between submodule commits [.gitmodules]' '
 	test_cmp expect.body actual.body &&
 	git config -f .gitmodules submodule.subname.ignore all &&
 	git diff HEAD^..HEAD >actual &&
-	! test -s actual &&
+	test_must_be_empty actual &&
 	git config submodule.subname.ignore dirty &&
 	git config submodule.subname.path sub &&
 	git diff  HEAD^..HEAD >actual &&
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 058ee0829d..302f2166a9 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -273,17 +273,17 @@ test_expect_success 'submodule contains untracked content' '
 
 test_expect_success 'submodule contains untracked content (untracked ignored)' '
 	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'submodule contains untracked content (dirty ignored)' '
 	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'submodule contains untracked content (all ignored)' '
 	git diff-index -p --ignore-submodules=all --submodule=log HEAD >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'submodule contains untracked and modifed content' '
@@ -308,13 +308,13 @@ test_expect_success 'submodule contains untracked and modifed content (untracked
 test_expect_success 'submodule contains untracked and modifed content (dirty ignored)' '
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'submodule contains untracked and modifed content (all ignored)' '
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'submodule contains modifed content' '
@@ -368,7 +368,7 @@ test_expect_success 'modified submodule contains untracked content (dirty ignore
 
 test_expect_success 'modified submodule contains untracked content (all ignored)' '
 	git diff-index -p --ignore-submodules=all --submodule=log HEAD >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'modified submodule contains untracked and modifed content' '
@@ -407,7 +407,7 @@ test_expect_success 'modified submodule contains untracked and modifed content (
 test_expect_success 'modified submodule contains untracked and modifed content (all ignored)' '
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'modified submodule contains modifed content' '
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 4b168d0ed7..6fc3da8bd2 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -408,17 +408,17 @@ test_expect_success 'submodule contains untracked content' '
 
 test_expect_success 'submodule contains untracked content (untracked ignored)' '
 	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'submodule contains untracked content (dirty ignored)' '
 	git diff-index -p --ignore-submodules=dirty --submodule=diff HEAD >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'submodule contains untracked content (all ignored)' '
 	git diff-index -p --ignore-submodules=all --submodule=diff HEAD >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'submodule contains untracked and modified content' '
@@ -458,13 +458,13 @@ test_expect_success 'submodule contains untracked and modified content (untracke
 test_expect_success 'submodule contains untracked and modified content (dirty ignored)' '
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules=dirty --submodule=diff HEAD >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'submodule contains untracked and modified content (all ignored)' '
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=diff HEAD >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'submodule contains modified content' '
@@ -549,7 +549,7 @@ test_expect_success 'modified submodule contains untracked content (dirty ignore
 
 test_expect_success 'modified submodule contains untracked content (all ignored)' '
 	git diff-index -p --ignore-submodules=all --submodule=diff HEAD >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'modified submodule contains untracked and modified content' '
@@ -609,7 +609,7 @@ test_expect_success 'modified submodule contains untracked and modified content
 test_expect_success 'modified submodule contains untracked and modified content (all ignored)' '
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=diff HEAD >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 # NOT OK
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 4fc27c51f7..7e32237a2a 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -100,7 +100,7 @@ test_expect_success 'whitespace=warn, default rule' '
 test_expect_success 'whitespace=error-all, default rule' '
 
 	test_must_fail apply_patch --whitespace=error-all &&
-	! test -s target
+	test_must_be_empty target
 
 '
 
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 1ebc587f8f..38fe717c12 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -651,7 +651,7 @@ test_expect_success 'am -3 -q is quiet' '
 	git checkout -f lorem2 &&
 	git reset base3way --hard &&
 	git am -3 -q lorem-move.patch >output.out 2>&1 &&
-	! test -s output.out
+	test_must_be_empty output.out
 '
 
 test_expect_success 'am pauses on conflict' '
@@ -874,7 +874,7 @@ test_expect_success 'am -q is quiet' '
 	git checkout first &&
 	test_tick &&
 	git am -q <patch1 >output.out 2>&1 &&
-	! test -s output.out
+	test_must_be_empty output.out
 '
 
 test_expect_success 'am empty-file does not infloop' '
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 7f278d8ce9..ce151e71c1 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -104,17 +104,17 @@ test_expect_success 'post-update hook arguments' '
 '
 
 test_expect_success 'all hook stdin is /dev/null' '
-	! test -s victim.git/update.stdin &&
-	! test -s victim.git/post-update.stdin
+	test_must_be_empty victim.git/update.stdin &&
+	test_must_be_empty victim.git/post-update.stdin
 '
 
 test_expect_success 'all *-receive hook args are empty' '
-	! test -s victim.git/pre-receive.args &&
-	! test -s victim.git/post-receive.args
+	test_must_be_empty victim.git/pre-receive.args &&
+	test_must_be_empty victim.git/post-receive.args
 '
 
 test_expect_success 'send-pack produced no output' '
-	! test -s send.out
+	test_must_be_empty send.out
 '
 
 cat <<EOF >expect
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 3d33ab3875..07fcea0474 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -161,7 +161,7 @@ test_expect_success 'clone shallow object count' '
 test_expect_success 'clone shallow object count (part 2)' '
 	sed -e "/^in-pack:/d" -e "/^packs:/d" -e "/^size-pack:/d" \
 	    -e "/: 0$/d" count.shallow > count_output &&
-	! test -s count_output
+	test_must_be_empty count_output
 '
 
 test_expect_success 'fsck in shallow repo' '
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 359e03ff83..ce3af92843 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -98,8 +98,8 @@ test_expect_success "fetch alone only fetches superproject" '
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	! test -s actual.out &&
-	! test -s actual.err
+	test_must_be_empty actual.out &&
+	test_must_be_empty actual.err
 '
 
 test_expect_success "fetch --no-recurse-submodules only fetches superproject" '
@@ -107,8 +107,8 @@ test_expect_success "fetch --no-recurse-submodules only fetches superproject" '
 		cd downstream &&
 		git fetch --no-recurse-submodules >../actual.out 2>../actual.err
 	) &&
-	! test -s actual.out &&
-	! test -s actual.err
+	test_must_be_empty actual.out &&
+	test_must_be_empty actual.err
 '
 
 test_expect_success "using fetchRecurseSubmodules=true in .gitmodules recurses into submodules" '
@@ -127,8 +127,8 @@ test_expect_success "--no-recurse-submodules overrides .gitmodules config" '
 		cd downstream &&
 		git fetch --no-recurse-submodules >../actual.out 2>../actual.err
 	) &&
-	! test -s actual.out &&
-	! test -s actual.err
+	test_must_be_empty actual.out &&
+	test_must_be_empty actual.err
 '
 
 test_expect_success "using fetchRecurseSubmodules=false in .git/config overrides setting in .gitmodules" '
@@ -137,8 +137,8 @@ test_expect_success "using fetchRecurseSubmodules=false in .git/config overrides
 		git config submodule.submodule.fetchRecurseSubmodules false &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	! test -s actual.out &&
-	! test -s actual.err
+	test_must_be_empty actual.out &&
+	test_must_be_empty actual.err
 '
 
 test_expect_success "--recurse-submodules overrides fetchRecurseSubmodules setting from .git/config" '
@@ -157,8 +157,8 @@ test_expect_success "--quiet propagates to submodules" '
 		cd downstream &&
 		git fetch --recurse-submodules --quiet >../actual.out 2>../actual.err
 	) &&
-	! test -s actual.out &&
-	! test -s actual.err
+	test_must_be_empty actual.out &&
+	test_must_be_empty actual.err
 '
 
 test_expect_success "--quiet propagates to parallel submodules" '
@@ -166,8 +166,8 @@ test_expect_success "--quiet propagates to parallel submodules" '
 		cd downstream &&
 		git fetch --recurse-submodules -j 2 --quiet  >../actual.out 2>../actual.err
 	) &&
-	! test -s actual.out &&
-	! test -s actual.err
+	test_must_be_empty actual.out &&
+	test_must_be_empty actual.err
 '
 
 test_expect_success "--dry-run propagates to submodules" '
@@ -221,8 +221,8 @@ test_expect_success "--no-recurse-submodules overrides config setting" '
 		git config fetch.recurseSubmodules true &&
 		git fetch --no-recurse-submodules >../actual.out 2>../actual.err
 	) &&
-	! test -s actual.out &&
-	! test -s actual.err
+	test_must_be_empty actual.out &&
+	test_must_be_empty actual.err
 '
 
 test_expect_success "Recursion doesn't happen when no new commits are fetched in the superproject" '
@@ -235,8 +235,8 @@ test_expect_success "Recursion doesn't happen when no new commits are fetched in
 		git config --unset fetch.recurseSubmodules &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	! test -s actual.out &&
-	! test -s actual.err
+	test_must_be_empty actual.out &&
+	test_must_be_empty actual.err
 '
 
 test_expect_success "Recursion stops when no new submodule commits are fetched" '
@@ -268,7 +268,7 @@ test_expect_success "Recursion doesn't happen when new superproject commits don'
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	! test -s actual.out &&
+	test_must_be_empty actual.out &&
 	test_i18ncmp expect.err.file actual.err
 '
 
@@ -357,8 +357,8 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
 		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err &&
 		git config --unset fetch.recurseSubmodules
 	) &&
-	! test -s actual.out &&
-	! test -s actual.err
+	test_must_be_empty actual.out &&
+	test_must_be_empty actual.err
 '
 
 test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
@@ -402,7 +402,7 @@ test_expect_success "'--recurse-submodules=on-demand' stops when no new submodul
 		cd downstream &&
 		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err
 	) &&
-	! test -s actual.out &&
+	test_must_be_empty actual.out &&
 	test_i18ncmp expect.err.file actual.err
 '
 
@@ -477,7 +477,7 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	! test -s actual.out &&
+	test_must_be_empty actual.out &&
 	test_i18ncmp expect.err actual.err &&
 	(
 		cd submodule &&
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 0d4c52016b..12c1e43a84 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -51,7 +51,7 @@ test_expect_success 'no-op fetch -v stderr is as expected' '
 
 test_expect_success 'no-op fetch without "-v" is quiet' '
 	(cd clone && git fetch 2>../stderr) &&
-	! test -s stderr
+	test_must_be_empty stderr
 '
 
 test_expect_success 'remote detects correct HEAD' '
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index cc3fd2baf2..56ca467c0a 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -384,7 +384,7 @@ test_expect_success 'mv does not complain when no .gitmodules file is found' '
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
 	mkdir mod &&
 	git mv sub mod/sub 2>actual.err &&
-	! test -s actual.err &&
+	test_must_be_empty actual.err &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
 	(
@@ -408,7 +408,7 @@ test_expect_success 'mv will error out on a modified .gitmodules file unless sta
 	git diff-files --quiet -- sub &&
 	git add .gitmodules &&
 	git mv sub mod/sub 2>actual.err &&
-	! test -s actual.err &&
+	test_must_be_empty actual.err &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
 	(
@@ -469,7 +469,7 @@ test_expect_success 'checking out a commit before submodule moved needs manual u
 	git update-index --refresh &&
 	git diff-files --quiet -- sub .gitmodules &&
 	git status -s sub2 >actual &&
-	! test -s actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'mv -k does not accidentally destroy submodules' '
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index ab9da61da3..0e7d4421a7 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -139,7 +139,7 @@ test_expect_success "checkout -m with dirty tree, renamed" '
 	test_cmp expect uno &&
 	! test -f one &&
 	git diff --cached >current &&
-	! test -s current
+	test_must_be_empty current
 
 '
 
@@ -163,7 +163,7 @@ test_expect_success 'checkout -m with merge conflict' '
 	fill d2 aT d7 aS >expect &&
 	test_cmp current expect &&
 	git diff --cached two >current &&
-	! test -s current
+	test_must_be_empty current
 '
 
 test_expect_success 'format of merge conflict from checkout -m' '
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 9e0d31700e..0fef49954f 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -174,7 +174,7 @@ test_expect_success 'submodule update does not fetch already present commits' '
 	  git submodule update > ../actual 2> ../actual.err
 	) &&
 	test_i18ncmp expected actual &&
-	! test -s actual.err
+	test_must_be_empty actual.err
 '
 
 test_expect_success 'submodule update should fail due to local changes' '
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index fc44ec96aa..825da1404a 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -941,7 +941,7 @@ test_expect_success 'grep from a subdirectory to search wider area (2)' '
 	(
 		cd s || exit 1
 		( git grep xxyyzz .. >out ; echo $? >status )
-		! test -s out &&
+		test_must_be_empty out &&
 		test 1 = $(cat status)
 	)
 '
diff --git a/t/t9131-git-svn-empty-symlink.sh b/t/t9131-git-svn-empty-symlink.sh
index f762038f0e..3bf4255aa3 100755
--- a/t/t9131-git-svn-empty-symlink.sh
+++ b/t/t9131-git-svn-empty-symlink.sh
@@ -85,7 +85,7 @@ EOF
 test_expect_success 'clone using git svn' 'git svn clone -r1 "$svnrepo" x'
 test_expect_success 'enable broken symlink workaround' \
   '(cd x && git config svn.brokenSymlinkWorkaround true)'
-test_expect_success '"bar" is an empty file' 'test -f x/bar && ! test -s x/bar'
+test_expect_success '"bar" is an empty file' 'test_must_be_empty x/bar'
 test_expect_success 'get "bar" => symlink fix from svn' \
 		'(cd x && git svn rebase)'
 test_expect_success SYMLINKS '"bar" becomes a symlink' 'test -h x/bar'
@@ -94,14 +94,14 @@ test_expect_success SYMLINKS '"bar" becomes a symlink' 'test -h x/bar'
 test_expect_success 'clone using git svn' 'git svn clone -r1 "$svnrepo" y'
 test_expect_success 'disable broken symlink workaround' \
   '(cd y && git config svn.brokenSymlinkWorkaround false)'
-test_expect_success '"bar" is an empty file' 'test -f y/bar && ! test -s y/bar'
+test_expect_success '"bar" is an empty file' 'test_must_be_empty y/bar'
 test_expect_success 'get "bar" => symlink fix from svn' \
 		'(cd y && git svn rebase)'
 test_expect_success '"bar" does not become a symlink' '! test -L y/bar'
 
 # svn.brokenSymlinkWorkaround is unset
 test_expect_success 'clone using git svn' 'git svn clone -r1 "$svnrepo" z'
-test_expect_success '"bar" is an empty file' 'test -f z/bar && ! test -s z/bar'
+test_expect_success '"bar" is an empty file' 'test_must_be_empty z/bar'
 test_expect_success 'get "bar" => symlink fix from svn' \
 		'(cd z && git svn rebase)'
 test_expect_success '"bar" does not become a symlink' '! test -L z/bar'
diff --git a/t/t9135-git-svn-moved-branch-empty-file.sh b/t/t9135-git-svn-moved-branch-empty-file.sh
index 93db45db7d..2f80b216fe 100755
--- a/t/t9135-git-svn-moved-branch-empty-file.sh
+++ b/t/t9135-git-svn-moved-branch-empty-file.sh
@@ -13,8 +13,7 @@ test_expect_success 'test that b1 exists and is empty' '
 	(
 		cd x &&
 		git reset --hard origin/branch-c &&
-		test -f b1 &&
-		! test -s b1
+		test_must_be_empty b1
 	)
 	'
 
-- 
2.18.0.903.gab616d7dc6

