Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CA4120756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbdAJUnY (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:43:24 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34422 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdAJUmm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:42:42 -0500
Received: by mail-qt0-f177.google.com with SMTP id l7so128224595qtd.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7FrV9A36WT3L2qhRFprZhz4ogKB2bNZwJlu5tJlFUjA=;
        b=my1diIeQDMS9xgBUPbRcfn+liu8AUmawlEpqHu9EMh8r4PC3aR2UVAqPx1KKYQrHJX
         leuZwyNnC/0CWPoPUhuIrijIYJct9f10TJyBKQ3or+7AJnnHlVNW5Le7AMRi5Dwi4gWb
         4KaYKCtNcV7cQn5vBT29JvbvZunOJmSt2G0QbcUudDx36eQz8Ju/lDzZUj0XWDtOYZlq
         1ub2f2PXnNaMiVbwCQdqjaw4/fNFN0Wu+SQjNa7iB3aOs+eDQLw2NmWX5hJl1pMuaDzA
         v1Nl/OXW0bHy8mua2t13LoetMIP918iVe5uaqtHiBfbeSJ3m57lBoP3D/BdovmvSxzDT
         Bn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7FrV9A36WT3L2qhRFprZhz4ogKB2bNZwJlu5tJlFUjA=;
        b=qA2vLQrvZPcOuOtsDZTlv9RsvPZ0pA6sYVA11VBF7/nBx2J0Myzbl1PVBCWDVJB368
         AmvMDgIZ3Ef+hfLVaV+T4W+MYHuVsNCv3s1dsjrQ9YAw5rm85XrtdriMoFx+ymhIbS5Q
         tAYGP6ThV2DPchkS9J0Q46FththuJYtvhAgMlG2hdph3ojsYEYFptnQRtMFMDvxkyE5m
         NYqQ5Chc5SuTuwtk5eMC3w9Zc5tSLj6YJKDM6peja/vHDHZmnYv387dyyhYQMXx61QPR
         7o0oHO/wxiltipg9pqDX7i5Lxke+nyCX4gLVoaBBsy79ra22xERAASYYo2XibXm1PpEi
         wHPQ==
X-Gm-Message-State: AIkVDXIkiR0ZSjFZcUvE71auBBaJ0BC1iywaaQ58casYjJja+h1z8hi4lVOiDkUwuelX8m66
X-Received: by 10.237.48.139 with SMTP id 11mr4531165qtf.219.1484080961135;
        Tue, 10 Jan 2017 12:42:41 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id z189sm2238137qkb.42.2017.01.10.12.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 12:42:40 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org, gitster@pobox.com
Subject: [PATCH v5 03/14] t7610: update branch names to match test number
Date:   Tue, 10 Jan 2017 15:41:51 -0500
Message-Id: <20170110204202.21779-4-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170110204202.21779-1-hansenr@google.com>
References: <20170109232941.43637-1-hansenr@google.com>
 <20170110204202.21779-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the testNN branches so that NN matches the test number.  This
should make it easier to troubleshoot test issues.  Use $test_count to
keep this future-proof.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 t/t7610-mergetool.sh | 82 ++++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 6d9f21511..14090739f 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -94,7 +94,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'custom mergetool' '
-	git checkout -b test1 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
@@ -113,7 +113,7 @@ test_expect_success 'custom mergetool' '
 
 test_expect_success 'mergetool crlf' '
 	test_config core.autocrlf true &&
-	git checkout -b test2 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
 	( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
@@ -134,7 +134,7 @@ test_expect_success 'mergetool crlf' '
 '
 
 test_expect_success 'mergetool in subdir' '
-	git checkout -b test3 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	(
 		cd subdir &&
@@ -161,7 +161,7 @@ test_expect_success 'mergetool on file in parent dir' '
 '
 
 test_expect_success 'mergetool skips autoresolved' '
-	git checkout -b test4 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
@@ -192,7 +192,7 @@ test_expect_success 'mergetool merges all from subdir' '
 test_expect_success 'mergetool skips resolved paths when rerere is active' '
 	test_config rerere.enabled true &&
 	rm -rf .git/rr-cache &&
-	git checkout -b test5 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
 	( yes "l" | git mergetool --no-prompt submod >/dev/null 2>&1 ) &&
@@ -233,7 +233,7 @@ test_expect_success 'conflicted stash sets up rerere'  '
 test_expect_success 'mergetool takes partial path' '
 	git reset --hard &&
 	test_config rerere.enabled false &&
-	git checkout -b test12 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master &&
 
@@ -308,12 +308,12 @@ test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
 '
 
 test_expect_success 'deleted vs modified submodule' '
-	git checkout -b test6 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	mv submod submod-movedaside &&
 	git rm --cached submod &&
 	git commit -m "Submodule deleted from branch" &&
-	git checkout -b test6.a test6 &&
+	git checkout -b test$test_count.a test$test_count &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
@@ -329,7 +329,7 @@ test_expect_success 'deleted vs modified submodule' '
 	git commit -m "Merge resolved by keeping module" &&
 
 	mv submod submod-movedaside &&
-	git checkout -b test6.b test6 &&
+	git checkout -b test$test_count.b test$test_count &&
 	git submodule update -N &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
@@ -343,9 +343,9 @@ test_expect_success 'deleted vs modified submodule' '
 	git commit -m "Merge resolved by deleting module" &&
 
 	mv submod-movedaside submod &&
-	git checkout -b test6.c master &&
+	git checkout -b test$test_count.c master &&
 	git submodule update -N &&
-	test_must_fail git merge test6 &&
+	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
@@ -359,9 +359,9 @@ test_expect_success 'deleted vs modified submodule' '
 	git commit -m "Merge resolved by deleting module" &&
 	mv submod.orig submod &&
 
-	git checkout -b test6.d master &&
+	git checkout -b test$test_count.d master &&
 	git submodule update -N &&
-	test_must_fail git merge test6 &&
+	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
@@ -377,14 +377,14 @@ test_expect_success 'deleted vs modified submodule' '
 '
 
 test_expect_success 'file vs modified submodule' '
-	git checkout -b test7 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	mv submod submod-movedaside &&
 	git rm --cached submod &&
 	echo not a submodule >submod &&
 	git add submod &&
 	git commit -m "Submodule path becomes file" &&
-	git checkout -b test7.a branch1 &&
+	git checkout -b test$test_count.a branch1 &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
@@ -400,7 +400,7 @@ test_expect_success 'file vs modified submodule' '
 	git commit -m "Merge resolved by keeping module" &&
 
 	mv submod submod-movedaside &&
-	git checkout -b test7.b test7 &&
+	git checkout -b test$test_count.b test$test_count &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
@@ -413,11 +413,11 @@ test_expect_success 'file vs modified submodule' '
 	test "$output" = "No files need merging" &&
 	git commit -m "Merge resolved by keeping file" &&
 
-	git checkout -b test7.c master &&
+	git checkout -b test$test_count.c master &&
 	rmdir submod && mv submod-movedaside submod &&
 	test ! -e submod.orig &&
 	git submodule update -N &&
-	test_must_fail git merge test7 &&
+	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
@@ -430,10 +430,10 @@ test_expect_success 'file vs modified submodule' '
 	test "$output" = "No files need merging" &&
 	git commit -m "Merge resolved by keeping file" &&
 
-	git checkout -b test7.d master &&
+	git checkout -b test$test_count.d master &&
 	rmdir submod && mv submod.orig submod &&
 	git submodule update -N &&
-	test_must_fail git merge test7 &&
+	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool both>/dev/null 2>&1 ) &&
@@ -448,7 +448,7 @@ test_expect_success 'file vs modified submodule' '
 '
 
 test_expect_success 'submodule in subdirectory' '
-	git checkout -b test10 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	(
 		cd subdir &&
@@ -464,52 +464,52 @@ test_expect_success 'submodule in subdirectory' '
 	git add subdir/subdir_module &&
 	git commit -m "add submodule in subdirectory" &&
 
-	git checkout -b test10.a test10 &&
+	git checkout -b test$test_count.a test$test_count &&
 	git submodule update -N &&
 	(
 	cd subdir/subdir_module &&
 		git checkout -b super10.a &&
-		echo test10.a >file15 &&
+		echo test$test_count.a >file15 &&
 		git add file15 &&
 		git commit -m "on branch 10.a"
 	) &&
 	git add subdir/subdir_module &&
-	git commit -m "change submodule in subdirectory on test10.a" &&
+	git commit -m "change submodule in subdirectory on test$test_count.a" &&
 
-	git checkout -b test10.b test10 &&
+	git checkout -b test$test_count.b test$test_count &&
 	git submodule update -N &&
 	(
 		cd subdir/subdir_module &&
 		git checkout -b super10.b &&
-		echo test10.b >file15 &&
+		echo test$test_count.b >file15 &&
 		git add file15 &&
 		git commit -m "on branch 10.b"
 	) &&
 	git add subdir/subdir_module &&
-	git commit -m "change submodule in subdirectory on test10.b" &&
+	git commit -m "change submodule in subdirectory on test$test_count.b" &&
 
-	test_must_fail git merge test10.a >/dev/null 2>&1 &&
+	test_must_fail git merge test$test_count.a >/dev/null 2>&1 &&
 	(
 		cd subdir &&
 		( yes "l" | git mergetool subdir_module )
 	) &&
-	test "$(cat subdir/subdir_module/file15)" = "test10.b" &&
+	test "$(cat subdir/subdir_module/file15)" = "test$test_count.b" &&
 	git submodule update -N &&
-	test "$(cat subdir/subdir_module/file15)" = "test10.b" &&
+	test "$(cat subdir/subdir_module/file15)" = "test$test_count.b" &&
 	git reset --hard &&
 	git submodule update -N &&
 
-	test_must_fail git merge test10.a >/dev/null 2>&1 &&
+	test_must_fail git merge test$test_count.a >/dev/null 2>&1 &&
 	( yes "r" | git mergetool subdir/subdir_module ) &&
-	test "$(cat subdir/subdir_module/file15)" = "test10.b" &&
+	test "$(cat subdir/subdir_module/file15)" = "test$test_count.b" &&
 	git submodule update -N &&
-	test "$(cat subdir/subdir_module/file15)" = "test10.a" &&
+	test "$(cat subdir/subdir_module/file15)" = "test$test_count.a" &&
 	git commit -m "branch1 resolved with mergetool" &&
 	rm -rf subdir/subdir_module
 '
 
 test_expect_success 'directory vs modified submodule' '
-	git checkout -b test11 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	mv submod submod-movedaside &&
 	git rm --cached submod &&
 	mkdir submod &&
@@ -537,9 +537,9 @@ test_expect_success 'directory vs modified submodule' '
 	test "$(cat submod/bar)" = "master submodule" &&
 	git reset --hard >/dev/null 2>&1 && rm -rf submod-movedaside &&
 
-	git checkout -b test11.c master &&
+	git checkout -b test$test_count.c master &&
 	git submodule update -N &&
-	test_must_fail git merge test11 &&
+	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	( yes "l" | git mergetool submod ) &&
 	git submodule update -N &&
@@ -547,7 +547,7 @@ test_expect_success 'directory vs modified submodule' '
 
 	git reset --hard >/dev/null 2>&1 &&
 	git submodule update -N &&
-	test_must_fail git merge test11 &&
+	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	test ! -e submod.orig &&
 	( yes "r" | git mergetool submod ) &&
@@ -559,7 +559,7 @@ test_expect_success 'directory vs modified submodule' '
 '
 
 test_expect_success 'file with no base' '
-	git checkout -b test13 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool mybase -- both &&
 	>expected &&
@@ -568,7 +568,7 @@ test_expect_success 'file with no base' '
 '
 
 test_expect_success 'custom commands override built-ins' '
-	git checkout -b test14 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	test_config mergetool.defaults.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
 	test_config mergetool.defaults.trustExitCode true &&
 	test_must_fail git merge master &&
@@ -579,7 +579,7 @@ test_expect_success 'custom commands override built-ins' '
 '
 
 test_expect_success 'filenames seen by tools start with ./' '
-	git checkout -b test15 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	test_config mergetool.writeToTemp false &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
@@ -595,7 +595,7 @@ test_lazy_prereq MKTEMP '
 '
 
 test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToTemp' '
-	git checkout -b test16 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	test_config mergetool.writeToTemp true &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
-- 
2.11.0.390.gc69c2f50cf-goog

