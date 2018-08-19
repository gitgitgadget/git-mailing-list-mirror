Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1836A1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 21:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeHTBKt (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 21:10:49 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:38855 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeHTBKt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 21:10:49 -0400
Received: by mail-wr1-f46.google.com with SMTP id w11-v6so8796676wrc.5
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 14:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O1z+UjNAj4B+wlnjZq37FHB3AgLE7vSKRaSk1t1VYqA=;
        b=bccjKi+sato1ZlFVkxlHiyxRSA6GH8GenwPY05T7/nv2wzY1gS5M9gOmBNRNCDcQVs
         4ZCNJsYEqr2vFXZ0645mLAdYSYL/joFEkf2LQ6xYTeFkg9slBxS6Fm5WBf35xR/041Mb
         T+1l9tqqDlOkcZcnj3gV+4nhrg/KOCAQez1YXtFB1P1YHir+Io0FwUmmBbot5jcEgacd
         Vex7HY3hwQWMHkuOJEfQyMYZ804RlH4NkiwYRq/PTGvvo7dGICTKgucMReGWiFXdXncA
         5uuUz/YNIGeESKuDyQUBdMsIUYD5RRI5ET/fz1pfrK8w3F2BkTleMMdvEIO/xG+WK1cG
         xFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O1z+UjNAj4B+wlnjZq37FHB3AgLE7vSKRaSk1t1VYqA=;
        b=h0p2CTaw6bKfmK3FGEKSvTJmLLm/S8V6pMjX9IMKbME5CWqDiZUKEauX1S2eoof9GC
         93qgSzNNixugcOR3Bju4zwH39+18E+aoYsR69tN2NIbOuScwOQp1Z2Y+Lhpqh+j1/xdK
         4uBVISokJ9OLPS72YAhS4J6Tj8wSP2GFU5DASfmCDnKsh8vVS4vqqtzqjKYhwOPjRvld
         FrgN5/l7lmXmjI6CFw13gU382TFq1WXcwXN3OFbYAuUFGoqgxmh47EOv4fMYi6uUNK5y
         D9XrAuOPwbQwYBitfffeiubc1YhIcpEtdWO+mjj7MayZAxsPGHSZTi9Eq+ha3JhgHZe1
         s/5w==
X-Gm-Message-State: AOUpUlHNMCbu6h0gvWnRbeg3+FX/Y8sDDSuozOUp8dOukT/Qivn96p9u
        NrQK/nh36DnZEn2GTftuN6U=
X-Google-Smtp-Source: AA+uWPxAeOPjBZJPwJ5aRyzWkbaspl1IyFkt+pj2bXxgMkuy3yRkq22Vt/g+HwSRACzq7GnC9Cba3g==
X-Received: by 2002:adf:e70a:: with SMTP id c10-v6mr9835538wrm.143.1534715866478;
        Sun, 19 Aug 2018 14:57:46 -0700 (PDT)
Received: from localhost.localdomain (84-236-78-30.pool.digikabel.hu. [84.236.78.30])
        by smtp.gmail.com with ESMTPSA id x82-v6sm30485975wmd.11.2018.08.19.14.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Aug 2018 14:57:45 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/4] tests: use 'test_must_be_empty' instead of 'test_cmp <empty> <out>'
Date:   Sun, 19 Aug 2018 23:57:25 +0200
Message-Id: <20180819215725.29001-5-szeder.dev@gmail.com>
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

Using 'test_must_be_empty' is shorter and more idiomatic than

  >empty &&
  test_cmp empty out

as it saves the creation of an empty file.  Furthermore, sometimes the
expected empty file doesn't have such a descriptive name like 'empty',
and its creation is far away from the place where it's finally used
for comparison (e.g. in 't7600-merge.sh', where two expected empty
files are created in the 'setup' test, but are used only about 500
lines later).

These cases were found by instrumenting 'test_cmp' to error out the
test script when it's used to compare empty files, and then converted
manually.

Note that even after this patch there still remain a lot of cases
where we use 'test_cmp' to check empty files:

  - Sometimes the expected output is not hard-coded in the test, but
    'test_cmp' is used to ensure that two similar git commands produce
    the same output, and that output happens to be empty, e.g. the
    test 'submodule update --merge  - ignores --merge  for new
    submodules' in 't7406-submodule-update.sh'.

  - Repetitive common tasks, including preparing the expected results
    and running 'test_cmp', are often extracted into a helper
    function, and some of this helper's callsites expect no output.

  - For the same reason as above, the whole 'test_expect_success'
    block is within a helper function, e.g. in 't3070-wildmatch.sh'.

  - Or 'test_cmp' is invoked in a loop, e.g. the test 'cvs update
    (-p)' in 't9400-git-cvsserver-server.sh'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

There is also a related discussion about 'test_cmp' and empty files
starting at:

  https://public-inbox.org/git/CAM0VKj=rw14MbLbXvuJiiwf05Txo1tu6A8xzy+_3RHOytX8mXA@mail.gmail.com/T/#md31427850f3ccf8de8252703a49ee431f7e0a6b8

 t/t0001-init.sh                              |  5 ++-
 t/t0003-attributes.sh                        |  3 +-
 t/t0030-stripspace.sh                        | 22 ++++++-------
 t/t0040-parse-options.sh                     |  4 +--
 t/t0061-run-command.sh                       |  9 +++---
 t/t1300-config.sh                            |  5 +--
 t/t1410-reflog.sh                            |  3 +-
 t/t1411-reflog-show.sh                       |  3 +-
 t/t1450-fsck.sh                              | 11 +++----
 t/t1600-index.sh                             |  3 +-
 t/t1700-split-index.sh                       |  4 +--
 t/t2200-add-update.sh                        |  3 +-
 t/t2203-add-intent.sh                        |  6 ++--
 t/t3001-ls-files-others-exclude.sh           |  6 ++--
 t/t3004-ls-files-basic.sh                    |  6 ++--
 t/t3035-merge-sparse.sh                      |  5 ++-
 t/t3301-notes.sh                             |  4 +--
 t/t3404-rebase-interactive.sh                |  5 ++-
 t/t4015-diff-whitespace.sh                   |  4 +--
 t/t4027-diff-submodule.sh                    |  3 +-
 t/t4041-diff-submodule-option.sh             |  4 +--
 t/t4060-diff-submodule-option-diff-format.sh |  4 +--
 t/t4132-apply-removal.sh                     |  5 ++-
 t/t4203-mailmap.sh                           |  4 +--
 t/t4212-log-corrupt.sh                       |  6 ++--
 t/t4300-merge-tree.sh                        | 34 ++++----------------
 t/t5304-prune.sh                             |  3 +-
 t/t5314-pack-cycle-detection.sh              |  3 +-
 t/t5526-fetch-submodules.sh                  |  3 +-
 t/t6112-rev-list-filters-objects.sh          |  3 +-
 t/t6120-describe.sh                          |  3 +-
 t/t6130-pathspec-noglob.sh                   |  9 ++----
 t/t6200-fmt-merge-msg.sh                     |  4 +--
 t/t7004-tag.sh                               |  8 ++---
 t/t7008-grep-binary.sh                       |  6 ++--
 t/t7064-wtstatus-pv2.sh                      |  5 +--
 t/t7201-co.sh                                |  3 +-
 t/t7400-submodule-basic.sh                   | 28 ++++++----------
 t/t7501-commit.sh                            |  6 ++--
 t/t7600-merge.sh                             |  9 ++----
 t/t7610-mergetool.sh                         |  3 +-
 t/t7810-grep.sh                              | 31 +++++++-----------
 t/t7811-grep-open.sh                         | 18 ++++-------
 t/t9011-svn-da.sh                            | 14 ++++----
 t/t9200-git-cvsexportcommit.sh               |  4 +--
 t/t9903-bash-prompt.sh                       |  6 ++--
 46 files changed, 114 insertions(+), 226 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 4c865051e7..28f34fd3bd 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -167,9 +167,8 @@ test_expect_success 'reinit' '
 	) &&
 	test_i18ngrep "Initialized empty" again/out1 &&
 	test_i18ngrep "Reinitialized existing" again/out2 &&
-	>again/empty &&
-	test_i18ncmp again/empty again/err1 &&
-	test_i18ncmp again/empty again/err2
+	test_must_be_empty again/err1 &&
+	test_must_be_empty again/err2
 '
 
 test_expect_success 'init with --template' '
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f19ae4f8cc..ee2f5c2389 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -208,9 +208,8 @@ test_expect_success 'attribute test: --all option' '
 '
 
 test_expect_success 'attribute test: --cached option' '
-	: >empty &&
 	git check-attr --cached --stdin --all <stdin-all | sort >actual &&
-	test_cmp empty actual &&
+	test_must_be_empty actual &&
 	git add .gitattributes a/.gitattributes a/b/.gitattributes &&
 	git check-attr --cached --stdin --all <stdin-all | sort >actual &&
 	test_cmp specified-all actual
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index b77948c618..5ce47e8af5 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -320,22 +320,20 @@ test_expect_success \
 
 test_expect_success \
     'spaces with newline at end should be replaced with empty string' '
-    printf "" >expect &&
-
     echo | git stripspace >actual &&
-    test_cmp expect actual &&
+    test_must_be_empty actual &&
 
     echo "$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+    test_must_be_empty actual &&
 
     echo "$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+    test_must_be_empty actual &&
 
     echo "$sss$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+    test_must_be_empty actual &&
 
     echo "$sss$sss$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual
+    test_must_be_empty actual
 '
 
 test_expect_success \
@@ -349,19 +347,17 @@ test_expect_success \
 
 test_expect_success \
     'spaces without newline at end should be replaced with empty string' '
-    printf "" >expect &&
-
     printf "" | git stripspace >actual &&
-    test_cmp expect actual &&
+    test_must_be_empty actual &&
 
     printf "$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+    test_must_be_empty actual &&
 
     printf "$sss$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+    test_must_be_empty actual &&
 
     printf "$sss$sss$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual
+    test_must_be_empty actual
 '
 
 test_expect_success \
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 04d474c84f..5b0560fa20 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -286,11 +286,9 @@ test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
 	test_cmp expect output
 '
 
->expect
-
 test_expect_success 'OPT_CALLBACK() and callback errors work' '
 	test_must_fail test-parse-options --no-length >output 2>output.err &&
-	test_i18ncmp expect output &&
+	test_must_be_empty output &&
 	test_must_be_empty output.err
 '
 
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index c887ed5b45..3e131c5325 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -11,7 +11,6 @@ cat >hello-script <<-EOF
 	#!$SHELL_PATH
 	cat hello-script
 EOF
->empty
 
 test_expect_success 'start_command reports ENOENT' '
 	test-tool run-command start-command-ENOENT ./does-not-exist
@@ -23,7 +22,7 @@ test_expect_success 'run_command can run a command' '
 	test-tool run-command run-command ./hello.sh >actual 2>err &&
 
 	test_cmp hello-script actual &&
-	test_cmp empty err
+	test_must_be_empty err
 '
 
 test_expect_success !MINGW 'run_command can run a script without a #! line' '
@@ -34,7 +33,7 @@ test_expect_success !MINGW 'run_command can run a script without a #! line' '
 	test-tool run-command run-command ./hello >actual 2>err &&
 
 	test_cmp hello-script actual &&
-	test_cmp empty err
+	test_must_be_empty err
 '
 
 test_expect_success 'run_command does not try to execute a directory' '
@@ -47,7 +46,7 @@ test_expect_success 'run_command does not try to execute a directory' '
 	PATH=$PWD/bin1:$PWD/bin2:$PATH \
 		test-tool run-command run-command greet >actual 2>err &&
 	test_cmp bin2/greet actual &&
-	test_cmp empty err
+	test_must_be_empty err
 '
 
 test_expect_success POSIXPERM 'run_command passes over non-executable file' '
@@ -64,7 +63,7 @@ test_expect_success POSIXPERM 'run_command passes over non-executable file' '
 	PATH=$PWD/bin1:$PWD/bin2:$PATH \
 		test-tool run-command run-command greet >actual 2>err &&
 	test_cmp bin2/greet actual &&
-	test_cmp empty err
+	test_must_be_empty err
 '
 
 test_expect_success POSIXPERM 'run_command reports EACCES' '
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 03c223708e..84e88cf5a9 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -346,12 +346,9 @@ test_expect_success 'working --list' '
 	git config --list > output &&
 	test_cmp expect output
 '
-cat > expect << EOF
-EOF
-
 test_expect_success '--list without repo produces empty output' '
 	git --git-dir=nonexistent config --list >output &&
-	test_cmp expect output
+	test_must_be_empty output
 '
 
 cat > expect << EOF
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 8293131001..388b0611d8 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -290,9 +290,8 @@ test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
 	# same as before, but we only create a reflog for "one" if
 	# it already exists, which it does not
 	git -c core.logallrefupdates=false branch one master &&
-	: >expect &&
 	git log -g --format="%gd %gs" one >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 # Triggering the bug detected by this test requires a newline to fall
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 596907758d..26590f9a21 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -136,13 +136,12 @@ test_expect_success '--date magic does not override explicit @{0} syntax' '
 	test_cmp expect actual
 '
 
-: >expect
 test_expect_success 'empty reflog file' '
 	git branch empty &&
 	git reflog expire --expire=all refs/heads/empty &&
 
 	git log -g empty >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 # This guards against the alternative of showing the diffs vs. the
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 91fd71444d..a652f6002a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -16,8 +16,7 @@ test_expect_success setup '
 	git checkout HEAD^0 &&
 	test_commit B fileB two &&
 	git tag -d A B &&
-	git reflog expire --expire=now --all &&
-	>empty
+	git reflog expire --expire=now --all
 '
 
 test_expect_success 'loose objects borrowed from alternate are not missing' '
@@ -29,12 +28,12 @@ test_expect_success 'loose objects borrowed from alternate are not missing' '
 		test_commit C fileC one &&
 		git fsck --no-dangling >../actual 2>&1
 	) &&
-	test_cmp empty actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'HEAD is part of refs, valid objects appear valid' '
 	git fsck >actual 2>&1 &&
-	test_cmp empty actual
+	test_must_be_empty actual
 '
 
 # Corruption tests follow.  Make sure to remove all traces of the
@@ -346,12 +345,12 @@ test_expect_success 'tag with NUL in header' '
 
 test_expect_success 'cleaned up' '
 	git fsck >actual 2>&1 &&
-	test_cmp empty actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'rev-list --verify-objects' '
 	git rev-list --verify-objects --all >/dev/null 2>out &&
-	test_cmp empty out
+	test_must_be_empty out
 '
 
 test_expect_success 'rev-list --verify-objects with bad sha1' '
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index c4422312f4..42962ed7d4 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -41,8 +41,7 @@ test_expect_success 'no warning with bogus GIT_INDEX_VERSION and existing index'
 		GIT_INDEX_VERSION=1 &&
 		export GIT_INDEX_VERSION &&
 		git add a 2>actual.err &&
-		>expect.err &&
-		test_i18ncmp expect.err actual.err
+		test_must_be_empty actual.err
 	)
 '
 
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 1e81b33b2e..f85ba57803 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -143,9 +143,7 @@ test_expect_success 'remove file not in base index' '
 test_expect_success 'remove file in base index' '
 	git update-index --force-remove one &&
 	git ls-files --stage >ls-files.actual &&
-	cat >ls-files.expect <<-EOF &&
-	EOF
-	test_cmp ls-files.expect ls-files.actual &&
+	test_must_be_empty ls-files.actual &&
 
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 314c73c5a7..f764b7e3f5 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -88,9 +88,8 @@ test_expect_success 'non-qualified update in subdir updates from the root' '
 		echo even more >>sub2 &&
 		git add -u
 	) &&
-	: >expect &&
 	git diff-files --name-only >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'replace a file with a symlink' '
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index e7a400b4c7..68e54d5c44 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -195,8 +195,7 @@ test_expect_success 'rename detection finds the right names' '
 		test_cmp expected.4 actual.4 &&
 
 		git diff --cached --stat >actual.5 &&
-		: >expected.5 &&
-		test_cmp expected.5 actual.5
+		test_must_be_empty actual.5
 
 	)
 '
@@ -241,8 +240,7 @@ test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
 	echo " create mode 100644 new-ita" >expected &&
 	test_cmp expected actual &&
 	git diff --cached --summary >actual2 &&
-	: >expected2 &&
-	test_cmp expected2 actual2
+	test_must_be_empty actual2
 '
 
 
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 3b47647ed5..1ec7cb57c7 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -277,9 +277,8 @@ test_expect_success 'hide empty ignored sub-directory with --no-empty-directory'
 '
 
 test_expect_success 'pattern matches prefix completely' '
-	: >expect &&
 	git ls-files -i -o --exclude "/three/a.3[abc]" >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'ls-files with "**" patterns' '
@@ -295,9 +294,8 @@ EOF
 
 
 test_expect_success 'ls-files with "**" patterns and no slashes' '
-	: >expect &&
 	git ls-files -o -i --exclude "one**a.1" >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_done
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index 9c7adbdbe1..9fd5a1f188 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -8,16 +8,14 @@ command-line arguments.
 
 . ./test-lib.sh
 
->empty
-
 test_expect_success 'ls-files in empty repository' '
 	git ls-files >actual &&
-	test_cmp empty actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'ls-files with nonexistent path' '
 	git ls-files doesnotexist >actual &&
-	test_cmp empty actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'ls-files with nonsense option' '
diff --git a/t/t3035-merge-sparse.sh b/t/t3035-merge-sparse.sh
index 0c0b433bd3..c4b4a94324 100755
--- a/t/t3035-merge-sparse.sh
+++ b/t/t3035-merge-sparse.sh
@@ -17,7 +17,6 @@ test_commit_this () {
 }
 
 test_expect_success 'setup' '
-	: >empty &&
 	test_file checked-out init &&
 	test_file modify_delete modify_delete_init &&
 	test_commit_this init &&
@@ -38,7 +37,7 @@ test_expect_success 'reset --hard works after the conflict' '
 
 test_expect_success 'is reset properly' '
 	git status --porcelain -- modify_delete >out &&
-	test_cmp empty out &&
+	test_must_be_empty out &&
 	test_path_is_missing modify_delete
 '
 
@@ -52,7 +51,7 @@ test_expect_success 'Merge abort works after the conflict' '
 
 test_expect_success 'is aborted properly' '
 	git status --porcelain -- modify_delete >out &&
-	test_cmp empty out &&
+	test_must_be_empty out &&
 	test_path_is_missing modify_delete
 '
 
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 2d200fdf36..e5703a0d5b 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -481,10 +481,8 @@ test_expect_success 'list specific note with "git notes list <object>"' '
 '
 
 test_expect_success 'listing non-existing notes fails' '
-	cat >expect <<-EOF &&
-	EOF
 	test_must_fail git notes list HEAD >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'append to existing note with "git notes append"' '
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 01616901bd..5997770dc3 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -787,16 +787,15 @@ test_expect_success 'always cherry-pick with --no-ff' '
 	git tag original-no-ff-branch &&
 	set_fake_editor &&
 	git rebase -i --no-ff A &&
-	touch empty &&
 	for p in 0 1 2
 	do
 		test ! $(git rev-parse HEAD~$p) = $(git rev-parse original-no-ff-branch~$p) &&
 		git diff HEAD~$p original-no-ff-branch~$p > out &&
-		test_cmp empty out
+		test_must_be_empty out
 	done &&
 	test $(git rev-parse HEAD~3) = $(git rev-parse original-no-ff-branch~3) &&
 	git diff HEAD~3 original-no-ff-branch~3 > out &&
-	test_cmp empty out
+	test_must_be_empty out
 '
 
 test_expect_success 'set up commits with funny messages' '
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 5659c2612d..1ea9e0d21d 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -776,8 +776,6 @@ test_expect_success 'checkdiff allows new blank lines' '
 	git diff --check
 '
 
-cat <<EOF >expect
-EOF
 test_expect_success 'whitespace-only changes not reported' '
 	git reset --hard &&
 	echo >x "hello world" &&
@@ -785,7 +783,7 @@ test_expect_success 'whitespace-only changes not reported' '
 	git commit -m "hello 1" &&
 	echo >x "hello  world" &&
 	git diff -b >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 cat <<EOF >expect
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index e5f9eb7a11..9aa8e2b39b 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -239,10 +239,9 @@ test_expect_success 'git diff between submodule commits [.gitmodules]' '
 '
 
 test_expect_success 'git diff (empty submodule dir)' '
-	: >empty &&
 	rm -rf sub/* sub/.git &&
 	git diff > actual.empty &&
-	test_cmp empty actual.empty
+	test_must_be_empty actual.empty
 '
 
 test_expect_success 'conflicted submodule setup' '
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 302f2166a9..7a4594224b 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -257,9 +257,7 @@ test_expect_success 'typechanged submodule(blob->submodule)' '
 commit_file sm1 &&
 test_expect_success 'submodule is up to date' '
 	git diff-index -p --submodule=log HEAD >actual &&
-	cat >expected <<-EOF &&
-	EOF
-	test_cmp expected actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'submodule contains untracked content' '
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 6fc3da8bd2..60c8dc75a9 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -392,9 +392,7 @@ test_expect_success 'typechanged submodule(blob->submodule)' '
 commit_file sm1 &&
 test_expect_success 'submodule is up to date' '
 	git diff-index -p --submodule=diff HEAD >actual &&
-	cat >expected <<-EOF &&
-	EOF
-	test_cmp expected actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'submodule contains untracked content' '
diff --git a/t/t4132-apply-removal.sh b/t/t4132-apply-removal.sh
index a2bc1cd37d..fec1d6fa51 100755
--- a/t/t4132-apply-removal.sh
+++ b/t/t4132-apply-removal.sh
@@ -49,8 +49,7 @@ test_expect_success setup '
 	sed -e "s/TS0/$timeGMT/" -e "s/TS1/$epocGMT/" <d >removeGMT.patch &&
 	sed -e "s/TS0/$timeWest/" -e "s/TS1/$epocWest2/" <d >removeWest2.patch &&
 
-	echo something >something &&
-	>empty
+	echo something >something
 '
 
 for patch in *.patch
@@ -81,7 +80,7 @@ do
 			git add file &&
 			git apply --index $patch &&
 			test -f file &&
-			test_cmp empty file
+			test_must_be_empty file
 			;;
 		remove*)
 			# must remove the file
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 0dd8b65d7c..43b1522ea2 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -461,11 +461,9 @@ test_expect_success 'Grep author with log.mailmap' '
 	test_cmp expect actual
 '
 
->expect
-
 test_expect_success 'Only grep replaced author with --use-mailmap' '
 	git log --use-mailmap --author "<cto@coompany.xx>" >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 # git blame
diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index 22aa8b7c0e..03b952c90d 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -26,22 +26,20 @@ test_expect_success 'git log with broken author email' '
 		echo
 		echo "    foo"
 	} >expect.out &&
-	: >expect.err &&
 
 	git log broken_email >actual.out 2>actual.err &&
 
 	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err
+	test_must_be_empty actual.err
 '
 
 test_expect_success 'git log --format with broken author email' '
 	echo "A U Thor+author@example.com+Thu Apr 7 15:13:13 2005 -0700" >expect.out &&
-	: >expect.err &&
 
 	git log --format="%an+%ae+%ad" broken_email >actual.out 2>actual.err &&
 
 	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err
+	test_must_be_empty actual.err
 '
 
 munge_author_date () {
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index 9015e47654..d87cc7d9ef 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -25,25 +25,19 @@ EXPECTED
 '
 
 test_expect_success 'file add !A, B' '
-	cat >expected <<\EXPECTED &&
-EXPECTED
-
 	git reset --hard initial &&
 	test_commit "add-not-a-b" "ONE" "AAA" &&
 	git merge-tree initial add-not-a-b initial >actual &&
-	test_cmp expected actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'file add A, B (same)' '
-	cat >expected <<\EXPECTED &&
-EXPECTED
-
 	git reset --hard initial &&
 	test_commit "add-a-b-same-A" "ONE" "AAA" &&
 	git reset --hard initial &&
 	test_commit "add-a-b-same-B" "ONE" "AAA" &&
 	git merge-tree initial add-a-b-same-A add-a-b-same-B >actual &&
-	test_cmp expected actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'file add A, B (different)' '
@@ -68,13 +62,10 @@ EXPECTED
 '
 
 test_expect_success 'file change A, !B' '
-	cat >expected <<\EXPECTED &&
-EXPECTED
-
 	git reset --hard initial &&
 	test_commit "change-a-not-b" "initial-file" "BBB" &&
 	git merge-tree initial change-a-not-b initial >actual &&
-	test_cmp expected actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'file change !A, B' '
@@ -94,15 +85,12 @@ EXPECTED
 '
 
 test_expect_success 'file change A, B (same)' '
-	cat >expected <<\EXPECTED &&
-EXPECTED
-
 	git reset --hard initial &&
 	test_commit "change-a-b-same-A" "initial-file" "AAA" &&
 	git reset --hard initial &&
 	test_commit "change-a-b-same-B" "initial-file" "AAA" &&
 	git merge-tree initial change-a-b-same-A change-a-b-same-B >actual &&
-	test_cmp expected actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'file change A, B (different)' '
@@ -175,16 +163,13 @@ AAA" &&
 '
 
 test_expect_success 'file remove A, !B' '
-	cat >expected <<\EXPECTED &&
-EXPECTED
-
 	git reset --hard initial &&
 	test_commit "rm-a-not-b-base" "ONE" "AAA" &&
 	git rm ONE &&
 	git commit -m "rm-a-not-b" &&
 	git tag "rm-a-not-b" &&
 	git merge-tree rm-a-not-b-base rm-a-not-b rm-a-not-b-base >actual &&
-	test_cmp expected actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'file remove !A, B' '
@@ -206,16 +191,13 @@ EXPECTED
 '
 
 test_expect_success 'file remove A, B (same)' '
-	cat >expected <<\EXPECTED &&
-EXPECTED
-
 	git reset --hard initial &&
 	test_commit "rm-a-b-base" "ONE" "AAA" &&
 	git rm ONE &&
 	git commit -m "rm-a-b" &&
 	git tag "rm-a-b" &&
 	git merge-tree rm-a-b-base rm-a-b rm-a-b >actual &&
-	test_cmp expected actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'file change A, remove B' '
@@ -260,13 +242,11 @@ EXPECTED
 '
 
 test_expect_success 'tree add A, B (same)' '
-	cat >expect <<-\EOF &&
-	EOF
 	git reset --hard initial &&
 	mkdir sub &&
 	test_commit "add sub/file" "sub/file" "file" add-tree-A &&
 	git merge-tree initial add-tree-A add-tree-A >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'tree add A, B (different)' '
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index f20f03c103..270da21ac3 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -112,8 +112,7 @@ test_expect_success 'prune: do not prune detached HEAD with no reflog' '
 	# (should be removed and disabled by previous test)
 	test_path_is_missing .git/logs &&
 	git prune -n >prune_actual &&
-	: >prune_expected &&
-	test_cmp prune_actual prune_expected
+	test_must_be_empty prune_actual
 
 '
 
diff --git a/t/t5314-pack-cycle-detection.sh b/t/t5314-pack-cycle-detection.sh
index f31995d3d2..e525466de0 100755
--- a/t/t5314-pack-cycle-detection.sh
+++ b/t/t5314-pack-cycle-detection.sh
@@ -98,9 +98,8 @@ test_expect_success 'repack' '
 	# We first want to check that we do not have any internal errors,
 	# and also that we do not hit the last-ditch cycle-breaking code
 	# in write_object(), which will issue a warning to stderr.
-	>expect &&
 	git repack -ad 2>stderr &&
-	test_cmp expect stderr &&
+	test_must_be_empty stderr &&
 
 	# And then double-check that the resulting pack is usable (i.e.,
 	# we did not fail to notice any cycles). We know we are accessing
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index ce3af92843..fc95df0d0d 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -495,7 +495,6 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 	git add submodule &&
 	git rm .gitmodules &&
 	git commit -m "new submodule without .gitmodules" &&
-	printf "" >expect.out &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." >expect.err.2 &&
 	echo "   $head1..$head2  master     -> origin/master" >>expect.err.2 &&
@@ -514,7 +513,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 		git config --unset fetch.recurseSubmodules &&
 		git reset --hard
 	) &&
-	test_i18ncmp expect.out actual.out &&
+	test_must_be_empty actual.out &&
 	test_i18ncmp expect.err.2 actual.err &&
 	git checkout HEAD^ -- .gitmodules &&
 	git add .gitmodules &&
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 0a37dd5f97..d4ff0b3bef 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -113,12 +113,11 @@ test_expect_success 'verify blob:limit=1k' '
 '
 
 test_expect_success 'verify blob:limit=1m' '
-	cat </dev/null >expected &&
 	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1m \
 		| awk -f print_1.awk \
 		| sed "s/~//" \
 		| sort >observed &&
-	test_cmp observed expected
+	test_must_be_empty observed
 '
 
 # Test sparse:path=<path> filter.
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 84dd1cb690..d639d94696 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -121,10 +121,9 @@ test_expect_success 'describe --contains defaults to HEAD without commit-ish' '
 	test_cmp expect actual
 '
 
-: >err.expect
 check_describe tags/A --all A^0
 test_expect_success 'no warning was displayed for A' '
-	test_cmp err.expect err.actual
+	test_must_be_empty err.actual
 '
 
 test_expect_success 'rename tag A to Q locally' '
diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
index 658353277e..37760233a5 100755
--- a/t/t6130-pathspec-noglob.sh
+++ b/t/t6130-pathspec-noglob.sh
@@ -97,9 +97,8 @@ test_expect_success 'no-glob option matches literally (bracket)' '
 '
 
 test_expect_success 'no-glob option disables :(literal)' '
-	: >expect &&
 	git --literal-pathspecs log --format=%s -- ":(literal)foo" >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'no-glob environment variable works' '
@@ -130,9 +129,8 @@ test_expect_success '**/ works with :(glob)' '
 '
 
 test_expect_success '**/ does not work with --noglob-pathspecs' '
-	: >expect &&
 	git --noglob-pathspecs log --format=%s -- "**/bar" >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success '**/ works with :(glob) and --noglob-pathspecs' '
@@ -154,9 +152,8 @@ test_expect_success '**/ works with --glob-pathspecs' '
 '
 
 test_expect_success '**/ does not work with :(literal) and --glob-pathspecs' '
-	: >expect &&
 	git --glob-pathspecs log --format=%s -- ":(literal)**/bar" >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_done
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index a54a52aaa4..93f23cfa82 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -366,8 +366,6 @@ test_expect_success 'merge-msg with nothing to merge' '
 	test_unconfig merge.log &&
 	test_config merge.summary yes &&
 
-	>empty &&
-
 	(
 		cd remote &&
 		git checkout -b unrelated &&
@@ -376,7 +374,7 @@ test_expect_success 'merge-msg with nothing to merge' '
 		git fmt-merge-msg <.git/FETCH_HEAD >../actual
 	) &&
 
-	test_cmp empty actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'merge-msg tag' '
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 93a6694f0e..2e17cdb084 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -325,11 +325,10 @@ test_expect_success \
 	test_cmp expect actual
 '
 
->expect
 test_expect_success \
 	'listing tags using v.* should print nothing because none have v.' '
 	git tag -l "v.*" > actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 cat >expect <<EOF
@@ -1498,12 +1497,9 @@ test_expect_success 'inverse of the last test, with --no-contains' "
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
-EOF
-
 test_expect_success 'checking that third commit has no tags' "
 	git tag -l --contains $hash3 v* >actual &&
-	test_cmp expected actual
+	test_must_be_empty actual
 "
 
 cat > expected <<EOF
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 615e7e0162..2d87c49b75 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -57,9 +57,8 @@ test_expect_success 'git grep -ah ina a' '
 '
 
 test_expect_success 'git grep -I ina a' '
-	: >expect &&
 	test_must_fail git grep -I ina a >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'git grep -c ina a' '
@@ -81,9 +80,8 @@ test_expect_success 'git grep -L bar a' '
 '
 
 test_expect_success 'git grep -q ina a' '
-	: >expect &&
 	git grep -q ina a >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'git grep -F ile a' '
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index b9a86d3347..11eccc231a 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -364,11 +364,8 @@ test_expect_success 'verify upstream fields in branch header' '
 		test_cmp expect actual &&
 
 		## Repeat the above but without --branch.
-		cat >expect <<-EOF &&
-		EOF
-
 		git status --porcelain=v2 --untracked-files=all >actual &&
-		test_cmp expect actual &&
+		test_must_be_empty actual &&
 
 		## Test upstream-gone case. Fake this by pointing origin/master at
 		## a non-existing commit.
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 0e7d4421a7..d67b10ce00 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -116,9 +116,8 @@ test_expect_success "checkout -m with dirty tree" '
 	git diff --name-status side >current.side &&
 	test_cmp expect.side current.side &&
 
-	: >expect.index &&
 	git diff --cached >current.index &&
-	test_cmp expect.index current.index
+	test_must_be_empty current.index
 '
 
 test_expect_success "checkout -m with dirty tree, renamed" '
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 48fd14fae6..894ea2f27d 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -101,7 +101,6 @@ inspect() {
 
 test_expect_success 'submodule add' '
 	echo "refs/heads/master" >expect &&
-	>empty &&
 
 	(
 		cd addtest &&
@@ -123,7 +122,7 @@ test_expect_success 'submodule add' '
 	inspect addtest/submod ../.. &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
-	test_cmp empty untracked
+	test_must_be_empty untracked
 '
 
 test_expect_success 'setup parent and one repository' '
@@ -188,7 +187,6 @@ test_expect_success 'submodule add --branch' '
 	refs/heads/initial
 	refs/heads/master
 	EOF
-	>empty &&
 
 	(
 		cd addtest &&
@@ -201,12 +199,11 @@ test_expect_success 'submodule add --branch' '
 	inspect addtest/submod-branch ../.. &&
 	test_cmp expect-heads heads &&
 	test_cmp expect-head head &&
-	test_cmp empty untracked
+	test_must_be_empty untracked
 '
 
 test_expect_success 'submodule add with ./ in path' '
 	echo "refs/heads/master" >expect &&
-	>empty &&
 
 	(
 		cd addtest &&
@@ -218,12 +215,11 @@ test_expect_success 'submodule add with ./ in path' '
 	inspect addtest/dotsubmod/frotz ../../.. &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
-	test_cmp empty untracked
+	test_must_be_empty untracked
 '
 
 test_expect_success 'submodule add with /././ in path' '
 	echo "refs/heads/master" >expect &&
-	>empty &&
 
 	(
 		cd addtest &&
@@ -235,12 +231,11 @@ test_expect_success 'submodule add with /././ in path' '
 	inspect addtest/dotslashdotsubmod/frotz ../../.. &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
-	test_cmp empty untracked
+	test_must_be_empty untracked
 '
 
 test_expect_success 'submodule add with // in path' '
 	echo "refs/heads/master" >expect &&
-	>empty &&
 
 	(
 		cd addtest &&
@@ -252,12 +247,11 @@ test_expect_success 'submodule add with // in path' '
 	inspect addtest/slashslashsubmod/frotz ../../.. &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
-	test_cmp empty untracked
+	test_must_be_empty untracked
 '
 
 test_expect_success 'submodule add with /.. in path' '
 	echo "refs/heads/master" >expect &&
-	>empty &&
 
 	(
 		cd addtest &&
@@ -269,12 +263,11 @@ test_expect_success 'submodule add with /.. in path' '
 	inspect addtest/realsubmod ../.. &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
-	test_cmp empty untracked
+	test_must_be_empty untracked
 '
 
 test_expect_success 'submodule add with ./, /.. and // in path' '
 	echo "refs/heads/master" >expect &&
-	>empty &&
 
 	(
 		cd addtest &&
@@ -286,7 +279,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	inspect addtest/realsubmod2 ../.. &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
-	test_cmp empty untracked
+	test_must_be_empty untracked
 '
 
 test_expect_success !CYGWIN 'submodule add with \\ in path' '
@@ -305,7 +298,6 @@ test_expect_success !CYGWIN 'submodule add with \\ in path' '
 
 test_expect_success 'submodule add in subdirectory' '
 	echo "refs/heads/master" >expect &&
-	>empty &&
 
 	mkdir addtest/sub &&
 	(
@@ -318,7 +310,7 @@ test_expect_success 'submodule add in subdirectory' '
 	inspect addtest/realsubmod3 ../.. &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
-	test_cmp empty untracked
+	test_must_be_empty untracked
 '
 
 test_expect_success 'submodule add in subdirectory with relative path should fail' '
@@ -501,8 +493,6 @@ test_expect_success 'checkout superproject with subproject already present' '
 '
 
 test_expect_success 'apply submodule diff' '
-	>empty &&
-
 	git branch second &&
 	(
 		cd init &&
@@ -517,7 +507,7 @@ test_expect_success 'apply submodule diff' '
 	git apply --index P.diff &&
 
 	git diff --cached master >staged &&
-	test_cmp empty staged
+	test_must_be_empty staged
 '
 
 test_expect_success 'update --init' '
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 9dbbd01fc0..c1d232e92d 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -582,13 +582,11 @@ test_expect_success 'same tree (merge and amend merge)' '
 
 	git merge -s ours side -m "empty ok" &&
 	git diff HEAD^ HEAD >actual &&
-	: >expected &&
-	test_cmp expected actual &&
+	test_must_be_empty actual &&
 
 	git commit --amend -m "empty really ok" &&
 	git diff HEAD^ HEAD >actual &&
-	: >expected &&
-	test_cmp expected actual
+	test_must_be_empty actual
 
 '
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 6736d8d131..106148254d 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -38,7 +38,6 @@ printf '%s\n' '1 X' 2 3 4 5 6 7 8 9 >result.1
 printf '%s\n' '1 X' 2 3 4 '5 X' 6 7 8 9 >result.1-5
 printf '%s\n' '1 X' 2 3 4 '5 X' 6 7 8 '9 X' >result.1-5-9
 printf '%s\n' 1 2 3 4 5 6 7 8 '9 Z' >result.9z
->empty
 
 create_merge_msgs () {
 	echo "Merge tag 'c2'" >msg.1-5 &&
@@ -58,8 +57,6 @@ create_merge_msgs () {
 		echo &&
 		git log --no-merges ^HEAD c2 c3
 	} >squash.1-5-9 &&
-	: >msg.nologff &&
-	: >msg.nolognoff &&
 	{
 		echo "* tag 'c3':" &&
 		echo "  commit 3"
@@ -519,7 +516,7 @@ test_expect_success 'tolerate unknown values for merge.ff' '
 	test_tick &&
 	git merge c1 2>message &&
 	verify_head "$c1" &&
-	test_cmp empty message
+	test_must_be_empty message
 '
 
 test_expect_success 'combining --squash and --no-ff is refused' '
@@ -551,13 +548,13 @@ test_expect_success 'merge log message' '
 	git reset --hard c0 &&
 	git merge --no-log c2 &&
 	git show -s --pretty=format:%b HEAD >msg.act &&
-	test_cmp msg.nologff msg.act &&
+	test_must_be_empty msg.act &&
 
 	git reset --hard c0 &&
 	test_config branch.master.mergeoptions "--no-ff" &&
 	git merge --no-log c2 &&
 	git show -s --pretty=format:%b HEAD >msg.act &&
-	test_cmp msg.nolognoff msg.act &&
+	test_must_be_empty msg.act &&
 
 	git merge --log c3 &&
 	git show -s --pretty=format:%b HEAD >msg.act &&
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 4d46c599f8..78bed2aee1 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -328,9 +328,8 @@ test_expect_success 'mergetool produces no errors when keepBackup is used' '
 	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepBackup true &&
 	test_must_fail git merge move-to-b &&
-	: >expect &&
 	echo d | git mergetool a/a/file.txt 2>actual &&
-	test_cmp expect actual &&
+	test_must_be_empty actual &&
 	! test -d a
 '
 
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 42d5354c2a..c82c8f5f72 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -217,9 +217,8 @@ do
 	'
 
 	test_expect_success "grep -w $L (w)" '
-		: >expected &&
 		test_must_fail git grep -n -w -e "^w" $H >actual &&
-		test_cmp expected actual
+		test_must_be_empty actual
 	'
 
 	test_expect_success "grep -w $L (x)" '
@@ -239,26 +238,24 @@ do
 	'
 
 	test_expect_success "grep -w $L (y-2)" '
-		: >expected &&
 		if git grep -n -w -e "^y y" $H >actual
 		then
 			echo should not have matched
 			cat actual
 			false
 		else
-			test_cmp expected actual
+			test_must_be_empty actual
 		fi
 	'
 
 	test_expect_success "grep -w $L (z)" '
-		: >expected &&
 		if git grep -n -w -e "^z" $H >actual
 		then
 			echo should not have matched
 			cat actual
 			false
 		else
-			test_cmp expected actual
+			test_must_be_empty actual
 		fi
 	'
 
@@ -604,11 +601,10 @@ z:zzz
 EOF
 
 test_expect_success 'grep -q, silently report matches' '
-	>empty &&
 	git grep -q mmap >actual &&
-	test_cmp empty actual &&
+	test_must_be_empty actual &&
 	test_must_fail git grep -q qfwfq >actual &&
-	test_cmp empty actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'grep -C1 hunk mark between files' '
@@ -701,8 +697,7 @@ test_expect_success 'log grep (9)' '
 
 test_expect_success 'log grep (9)' '
 	git log -g --grep-reflog="commit: third" --author="non-existent" --pretty=tformat:%s >actual &&
-	: >expect &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'log --grep-reflog can only be used under -g' '
@@ -792,15 +787,13 @@ test_expect_success 'log --all-match --grep --grep --author takes intersection'
 '
 
 test_expect_success 'log --author does not search in timestamp' '
-	: >expect &&
 	git log --author="$GIT_AUTHOR_DATE" >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'log --committer does not search in timestamp' '
-	: >expect &&
 	git log --committer="$GIT_COMMITTER_DATE" >actual &&
-	test_cmp expect actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'grep with CE_VALID file' '
@@ -1051,13 +1044,12 @@ test_expect_success 'inside git repository but with --no-index' '
 		echo ".gitignore:.*o*" &&
 		cat is/expect.unignored
 	} >is/expect.full &&
-	: >is/expect.empty &&
 	echo file2:world >is/expect.sub &&
 	(
 		cd is/git &&
 		git init &&
 		test_must_fail git grep o >../actual.full &&
-		test_cmp ../expect.empty ../actual.full &&
+		test_must_be_empty ../actual.full &&
 
 		git grep --untracked o >../actual.unignored &&
 		test_cmp ../expect.unignored ../actual.unignored &&
@@ -1070,7 +1062,7 @@ test_expect_success 'inside git repository but with --no-index' '
 
 		cd sub &&
 		test_must_fail git grep o >../../actual.sub &&
-		test_cmp ../../expect.empty ../../actual.sub &&
+		test_must_be_empty ../../actual.sub &&
 
 		git grep --no-index o >../../actual.sub &&
 		test_cmp ../../expect.sub ../../actual.sub &&
@@ -1236,10 +1228,9 @@ test_expect_success !PCRE 'grep -P pattern errors without PCRE' '
 '
 
 test_expect_success 'grep pattern with grep.extendedRegexp=true' '
-	>empty &&
 	test_must_fail git -c grep.extendedregexp=true \
 		grep "\p{Ps}.*?\p{Pe}" hello.c >actual &&
-	test_cmp empty actual
+	test_must_be_empty actual
 '
 
 test_expect_success PCRE 'grep -P pattern with grep.extendedRegexp=true' '
diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index e1951a5cbb..d1ebfd88c7 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -51,14 +51,13 @@ test_expect_success SIMPLEPAGER 'git grep -O' '
 	grep.h
 	EOF
 	echo grep.h >expect.notless &&
-	>empty &&
 
 	PATH=.:$PATH git grep -O GREP_PATTERN >out &&
 	{
 		test_cmp expect.less pager-args ||
 		test_cmp expect.notless pager-args
 	} &&
-	test_cmp empty out
+	test_must_be_empty out
 '
 
 test_expect_success 'git grep -O --cached' '
@@ -72,7 +71,6 @@ test_expect_success 'git grep -O --no-index' '
 	grep.h
 	untracked
 	EOF
-	>empty &&
 
 	(
 		GIT_PAGER='\''printf "%s\n" >pager-args'\'' &&
@@ -80,7 +78,7 @@ test_expect_success 'git grep -O --no-index' '
 		git grep --no-index -O GREP_PATTERN >out
 	) &&
 	test_cmp expect pager-args &&
-	test_cmp empty out
+	test_must_be_empty out
 '
 
 test_expect_success 'setup: fake "less"' '
@@ -96,15 +94,14 @@ test_expect_success 'git grep -O jumps to line in less' '
 	+/*GREP_PATTERN
 	grep.h
 	EOF
-	>empty &&
 
 	GIT_PAGER=./less git grep -O GREP_PATTERN >out &&
 	test_cmp expect actual &&
-	test_cmp empty out &&
+	test_must_be_empty out &&
 
 	git grep -O./less GREP_PATTERN >out2 &&
 	test_cmp expect actual &&
-	test_cmp empty out2
+	test_must_be_empty out2
 '
 
 test_expect_success 'modified file' '
@@ -122,7 +119,7 @@ test_expect_success 'modified file' '
 	test_when_finished "git checkout HEAD unrelated" &&
 	GIT_PAGER=./less git grep -F -O "enum grep_pat_token" >out &&
 	test_cmp expect actual &&
-	test_cmp empty out
+	test_must_be_empty out
 '
 
 test_expect_success 'copes with color settings' '
@@ -138,7 +135,6 @@ test_expect_success 'copes with color settings' '
 test_expect_success 'run from subdir' '
 	rm -f actual &&
 	echo grep.c >expect &&
-	>empty &&
 
 	(
 		cd subdir &&
@@ -156,8 +152,8 @@ test_expect_success 'run from subdir' '
 		;;
 	esac &&
 	test_cmp expect args &&
-	test_cmp empty out &&
-	test_cmp empty out2
+	test_must_be_empty out &&
+	test_must_be_empty out2
 '
 
 test_done
diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index b38d16f9db..ab1ef28fd9 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -18,7 +18,7 @@ test_expect_success 'reject empty delta' '
 test_expect_success 'delta can empty file' '
 	printf "SVNQ" | q_to_nul >clear.delta &&
 	test-svn-fe -d preimage clear.delta 4 >actual &&
-	test_cmp empty actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'reject svndiff2' '
@@ -29,7 +29,7 @@ test_expect_success 'reject svndiff2' '
 test_expect_success 'one-window empty delta' '
 	printf "SVNQ%s" "QQQQQ" | q_to_nul >clear.onewindow &&
 	test-svn-fe -d preimage clear.onewindow 9 >actual &&
-	test_cmp empty actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'reject incomplete window header' '
@@ -50,7 +50,7 @@ test_expect_success 'two-window empty delta' '
 	printf "SVNQ%s%s" "QQQQQ" "QQQQQ" | q_to_nul >clear.twowindow &&
 	test-svn-fe -d preimage clear.twowindow 14 >actual &&
 	test_must_fail test-svn-fe -d preimage clear.twowindow 13 &&
-	test_cmp empty actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'noisy zeroes' '
@@ -60,7 +60,7 @@ test_expect_success 'noisy zeroes' '
 		q_to_nul >clear.noisy &&
 	len=$(wc -c <clear.noisy) &&
 	test-svn-fe -d preimage clear.noisy $len &&
-	test_cmp empty actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'reject variable-length int in magic' '
@@ -83,7 +83,7 @@ test_expect_success 'reject truncated integer' '
 test_expect_success 'nonempty (but unused) preimage view' '
 	printf "SVNQ%b" "Q\003QQQ" | q_to_nul >clear.readpreimage &&
 	test-svn-fe -d preimage clear.readpreimage 9 >actual &&
-	test_cmp empty actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'preimage view: right endpoint cannot backtrack' '
@@ -99,7 +99,7 @@ test_expect_success 'preimage view: left endpoint can advance' '
 		q_to_nul >clear.shrinkbacktrack &&
 	test-svn-fe -d preimage clear.preshrink 14 >actual &&
 	test_must_fail test-svn-fe -d preimage clear.shrinkbacktrack 14 &&
-	test_cmp empty actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'preimage view: offsets compared by value' '
@@ -109,7 +109,7 @@ test_expect_success 'preimage view: offsets compared by value' '
 		q_to_nul >clear.noisyadvance &&
 	test_must_fail test-svn-fe -d preimage clear.noisybacktrack 15 &&
 	test-svn-fe -d preimage clear.noisyadvance 15 &&
-	test_cmp empty actual
+	test_must_be_empty actual
 '
 
 test_expect_success 'preimage view: reject truncated preimage' '
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 1319415ba8..99d7aa621d 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -43,11 +43,11 @@ check_entries () {
 	sed -ne '/^\//p' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
 	if test -z "$2"
 	then
-		>expected
+		test_must_be_empty actual
 	else
 		printf '%s\n' "$2" | tr '|' '\012' >expected
+		test_cmp expected actual
 	fi
-	test_cmp expected actual
 }
 
 test_expect_success \
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index c3b89ae783..056bf1dcda 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -516,10 +516,9 @@ test_expect_success 'prompt - format string starting with dash' '
 
 test_expect_success 'prompt - pc mode' '
 	printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\nmaster" >expected &&
-	printf "" >expected_output &&
 	(
 		__git_ps1 "BEFORE:" ":AFTER" >"$actual" &&
-		test_cmp expected_output "$actual" &&
+		test_must_be_empty "$actual" &&
 		printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
 	) &&
 	test_cmp expected "$actual"
@@ -715,13 +714,12 @@ test_expect_success 'prompt - hide if pwd ignored - env var set, config disabled
 '
 
 test_expect_success 'prompt - hide if pwd ignored - env var set, config unset' '
-	printf "" >expected &&
 	(
 		cd ignored_dir &&
 		GIT_PS1_HIDE_IF_PWD_IGNORED=y &&
 		__git_ps1 >"$actual"
 	) &&
-	test_cmp expected "$actual"
+	test_must_be_empty "$actual"
 '
 
 test_expect_success 'prompt - hide if pwd ignored - env var set, config unset, pc mode' '
-- 
2.18.0.903.gab616d7dc6

