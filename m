Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D8701F453
	for <e@80x24.org>; Mon, 29 Apr 2019 06:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfD2GVH (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 02:21:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45808 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfD2GVG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 02:21:06 -0400
Received: by mail-io1-f65.google.com with SMTP id e8so7935856ioe.12
        for <git@vger.kernel.org>; Sun, 28 Apr 2019 23:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ObA2cx1j6wxGPz5oWbxfF0ep2aRhVnZdLrRiRCdHZxI=;
        b=t2Qd/FPmwy4JhLub8n3OnRzixtq0+cfweYWu1Z357dmYltDKhcr+qQzU0wO1qK6gcm
         87t/QWQSQhjot9GdJ1rbbOv0ZQ+N66hwHg/o4WvHfLdNvHqYX9Wb/PffJOQP0B2oN8L9
         JWGgVe7/gAvmgpoVxBehsS9hyYxlgNMRO+XWqmJ7iGAnxTw/Xu2mk18R3oex2HRJCryU
         N9PY27hQritYHSOqNiZBzqeJgC+sKdJc0PJTEuyfWYEFUl0HcTLJglgeaF6LMMMlSRHy
         YIrZfdI9cMrapkJpz9+SxA8X2TDzwfg1pOS4vuY+q+9cjI9+jGLAwB+Gn7kcvqzAWUt4
         iomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ObA2cx1j6wxGPz5oWbxfF0ep2aRhVnZdLrRiRCdHZxI=;
        b=MWyr4xyv5r0hT4CGdln0Cs23v0WCenV6hNrxo00WjQHe0yyXe0Rm74XOJ3UX951YkI
         4OvcuSAUHk2PKvnDzReILO83837Q8rHFympubMwgMW3kwD2YCRfKIZRQ8QDWdQrs74Fw
         gBDeuYRvFtNzpT30+uD19spOimf5nWKEh3iNjpiQ8O0ysWh+f6R7HohWHpqw8+7KbKf+
         SF9RY83JsxgtqiELz1xn0MUBN9UkVczcJhTiMaH4WQcVNiqyAHDeDlmYNyWJExo3vXdG
         r9TMDWBa8wvbuQdkUQdfC9T8WkWWKN3TS6scbLi8Hf6zftPs7xifrjIgJSFi7e8oIEGE
         hPMg==
X-Gm-Message-State: APjAAAUdDZV8UbVxQbyKalAkqzd6Uu+SZ7YTeVsaJL0Kt+xp1Ot2RLdz
        MEhb/wN35KTOAOp4T1qb/OO+u2W7
X-Google-Smtp-Source: APXvYqwnm1BKcHV1uZ3L/w0tk3gUXXYR4UiESbU++5HGmj+9QsCicFm4B1qe484bNVMnliq2DENvfw==
X-Received: by 2002:a5e:8b05:: with SMTP id g5mr12489349iok.274.1556518865381;
        Sun, 28 Apr 2019 23:21:05 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id t191sm9904611itt.17.2019.04.28.23.21.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Apr 2019 23:21:04 -0700 (PDT)
Date:   Mon, 29 Apr 2019 02:21:02 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 1/7] t7610: unsuppress output
Message-ID: <9f9922cab341396a846edc2f52342c59d294379a.1556518203.git.liu.denton@gmail.com>
References: <cover.1556185345.git.liu.denton@gmail.com>
 <cover.1556518203.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556518203.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The output for commands used to be suppressed by redirecting both stdout
and stderr to /dev/null. However, this should not happen since the
output is useful for debugging and, without the "-v" flag, test scripts
don't output anyway.

Unsuppress the output by removing the redirections to /dev/null.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7610-mergetool.sh | 122 +++++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index a9fb971615..69711487dd 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -130,14 +130,14 @@ test_expect_success 'custom mergetool' '
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
-	test_must_fail git merge master >/dev/null 2>&1 &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
+	test_must_fail git merge master &&
+	( yes "" | git mergetool both ) &&
 	( yes "" | git mergetool file1 file1 ) &&
-	( yes "" | git mergetool file2 "spaced name" >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
-	( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
-	( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool file2 "spaced name" ) &&
+	( yes "" | git mergetool subdir/file3 ) &&
+	( yes "d" | git mergetool file11 ) &&
+	( yes "d" | git mergetool file12 ) &&
+	( yes "l" | git mergetool submod ) &&
 	test "$(cat file1)" = "master updated" &&
 	test "$(cat file2)" = "master new" &&
 	test "$(cat subdir/file3)" = "master new sub" &&
@@ -153,15 +153,15 @@ test_expect_success 'mergetool crlf' '
 	# test_when_finished is LIFO.)
 	test_config core.autocrlf true &&
 	git checkout -b test$test_count branch1 &&
-	test_must_fail git merge master >/dev/null 2>&1 &&
-	( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool "spaced name" >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
-	( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
-	( yes "r" | git mergetool submod >/dev/null 2>&1 ) &&
+	test_must_fail git merge master &&
+	( yes "" | git mergetool file1 ) &&
+	( yes "" | git mergetool file2 ) &&
+	( yes "" | git mergetool "spaced name" ) &&
+	( yes "" | git mergetool both ) &&
+	( yes "" | git mergetool subdir/file3 ) &&
+	( yes "d" | git mergetool file11 ) &&
+	( yes "d" | git mergetool file12 ) &&
+	( yes "r" | git mergetool submod ) &&
 	test "$(printf x | cat file1 -)" = "$(printf "master updated\r\nx")" &&
 	test "$(printf x | cat file2 -)" = "$(printf "master new\r\nx")" &&
 	test "$(printf x | cat subdir/file3 -)" = "$(printf "master new sub\r\nx")" &&
@@ -176,8 +176,8 @@ test_expect_success 'mergetool in subdir' '
 	git submodule update -N &&
 	(
 		cd subdir &&
-		test_must_fail git merge master >/dev/null 2>&1 &&
-		( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
+		test_must_fail git merge master &&
+		( yes "" | git mergetool file3 ) &&
 		test "$(cat file3)" = "master new sub"
 	)
 '
@@ -188,14 +188,14 @@ test_expect_success 'mergetool on file in parent dir' '
 	git submodule update -N &&
 	(
 		cd subdir &&
-		test_must_fail git merge master >/dev/null 2>&1 &&
-		( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
-		( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
-		( yes "" | git mergetool ../file2 ../spaced\ name >/dev/null 2>&1 ) &&
-		( yes "" | git mergetool ../both >/dev/null 2>&1 ) &&
-		( yes "d" | git mergetool ../file11 >/dev/null 2>&1 ) &&
-		( yes "d" | git mergetool ../file12 >/dev/null 2>&1 ) &&
-		( yes "l" | git mergetool ../submod >/dev/null 2>&1 ) &&
+		test_must_fail git merge master &&
+		( yes "" | git mergetool file3 ) &&
+		( yes "" | git mergetool ../file1 ) &&
+		( yes "" | git mergetool ../file2 ../spaced\ name ) &&
+		( yes "" | git mergetool ../both ) &&
+		( yes "d" | git mergetool ../file11 ) &&
+		( yes "d" | git mergetool ../file12 ) &&
+		( yes "l" | git mergetool ../submod ) &&
 		test "$(cat ../file1)" = "master updated" &&
 		test "$(cat ../file2)" = "master new" &&
 		test "$(cat ../submod/bar)" = "branch1 submodule" &&
@@ -209,9 +209,9 @@ test_expect_success 'mergetool skips autoresolved' '
 	git submodule update -N &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
-	( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
-	( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
-	( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
+	( yes "d" | git mergetool file11 ) &&
+	( yes "d" | git mergetool file12 ) &&
+	( yes "l" | git mergetool submod ) &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging"
 '
@@ -259,9 +259,9 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
 	rm -rf .git/rr-cache &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
-	test_must_fail git merge master >/dev/null 2>&1 &&
-	( yes "l" | git mergetool --no-prompt submod >/dev/null 2>&1 ) &&
-	( yes "d" "d" | git mergetool --no-prompt >/dev/null 2>&1 ) &&
+	test_must_fail git merge master &&
+	( yes "l" | git mergetool --no-prompt submod ) &&
+	( yes "d" "d" | git mergetool --no-prompt ) &&
 	git submodule update -N &&
 	output="$(yes "n" | git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging"
@@ -369,9 +369,9 @@ test_expect_success 'deleted vs modified submodule' '
 	git checkout -b test$test_count.a test$test_count &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
-	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
+	( yes "" | git mergetool both ) &&
+	( yes "d" | git mergetool file11 file12 ) &&
 	( yes "r" | git mergetool submod ) &&
 	rmdir submod && mv submod-movedaside submod &&
 	test "$(cat submod/bar)" = "branch1 submodule" &&
@@ -386,9 +386,9 @@ test_expect_success 'deleted vs modified submodule' '
 	git submodule update -N &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
-	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
+	( yes "" | git mergetool both ) &&
+	( yes "d" | git mergetool file11 file12 ) &&
 	( yes "l" | git mergetool submod ) &&
 	test ! -e submod &&
 	output="$(git mergetool --no-prompt)" &&
@@ -400,9 +400,9 @@ test_expect_success 'deleted vs modified submodule' '
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
-	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
+	( yes "" | git mergetool both ) &&
+	( yes "d" | git mergetool file11 file12 ) &&
 	( yes "r" | git mergetool submod ) &&
 	test ! -e submod &&
 	test -d submod.orig &&
@@ -416,9 +416,9 @@ test_expect_success 'deleted vs modified submodule' '
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
-	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
+	( yes "" | git mergetool both ) &&
+	( yes "d" | git mergetool file11 file12 ) &&
 	( yes "l" | git mergetool submod ) &&
 	test "$(cat submod/bar)" = "master submodule" &&
 	git submodule update -N &&
@@ -440,9 +440,9 @@ test_expect_success 'file vs modified submodule' '
 	git checkout -b test$test_count.a branch1 &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
-	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
+	( yes "" | git mergetool both ) &&
+	( yes "d" | git mergetool file11 file12 ) &&
 	( yes "r" | git mergetool submod ) &&
 	rmdir submod && mv submod-movedaside submod &&
 	test "$(cat submod/bar)" = "branch1 submodule" &&
@@ -456,9 +456,9 @@ test_expect_success 'file vs modified submodule' '
 	git checkout -b test$test_count.b test$test_count &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
-	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
+	( yes "" | git mergetool both ) &&
+	( yes "d" | git mergetool file11 file12 ) &&
 	( yes "l" | git mergetool submod ) &&
 	git submodule update -N &&
 	test "$(cat submod)" = "not a submodule" &&
@@ -472,9 +472,9 @@ test_expect_success 'file vs modified submodule' '
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
-	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
+	( yes "" | git mergetool both ) &&
+	( yes "d" | git mergetool file11 file12 ) &&
 	( yes "r" | git mergetool submod ) &&
 	test -d submod.orig &&
 	git submodule update -N &&
@@ -488,9 +488,9 @@ test_expect_success 'file vs modified submodule' '
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both>/dev/null 2>&1 ) &&
-	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 ) &&
+	( yes "" | git mergetool both ) &&
+	( yes "d" | git mergetool file11 file12 ) &&
 	( yes "l" | git mergetool submod ) &&
 	test "$(cat submod/bar)" = "master submodule" &&
 	git submodule update -N &&
@@ -543,7 +543,7 @@ test_expect_success 'submodule in subdirectory' '
 	git add subdir/subdir_module &&
 	git commit -m "change submodule in subdirectory on test$test_count.b" &&
 
-	test_must_fail git merge test$test_count.a >/dev/null 2>&1 &&
+	test_must_fail git merge test$test_count.a &&
 	(
 		cd subdir &&
 		( yes "l" | git mergetool subdir_module )
@@ -554,7 +554,7 @@ test_expect_success 'submodule in subdirectory' '
 	git reset --hard &&
 	git submodule update -N &&
 
-	test_must_fail git merge test$test_count.a >/dev/null 2>&1 &&
+	test_must_fail git merge test$test_count.a &&
 	( yes "r" | git mergetool subdir/subdir_module ) &&
 	test "$(cat subdir/subdir_module/file15)" = "test$test_count.b" &&
 	git submodule update -N &&
@@ -641,7 +641,7 @@ test_expect_success 'filenames seen by tools start with ./' '
 	test_config mergetool.myecho.trustExitCode true &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool myecho -- both >actual &&
-	grep ^\./both_LOCAL_ actual >/dev/null
+	grep ^\./both_LOCAL_ actual
 '
 
 test_lazy_prereq MKTEMP '
@@ -658,8 +658,8 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
 	test_config mergetool.myecho.trustExitCode true &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool myecho -- both >actual &&
-	! grep ^\./both_LOCAL_ actual >/dev/null &&
-	grep /both_LOCAL_ actual >/dev/null
+	! grep ^\./both_LOCAL_ actual &&
+	grep /both_LOCAL_ actual
 '
 
 test_expect_success 'diff.orderFile configuration is honored' '
-- 
2.21.0.1033.g0e8cc1100c

