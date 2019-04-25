Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 387FE1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfDYJyi (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:54:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38742 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbfDYJyh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:54:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so10820885plb.5
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JI/Lia72G0FNL112c0dOM2shPHSe/tqNtZcRPBwe5rk=;
        b=jqBqjEUe+6YIerq+sRjAk6uF3FcHCYF+a56OQ9ndGqc6qIXxcFNnrVG+Q4g6STxUv/
         TkbQqY8r4MeLnqPmzrGUYEAyLoz17TbhkjVMirlUdw1qdoewIhHVj3HjjPdQIFJtFcMF
         M3i4DYNseQOwL4mAAHwG0GzPqkX1aT/kKvwo0qy/fLRubB/U5rEvOWDTjQPaChKe0rqh
         fKlGcMfDwjAFA0W4duJc/j1m3k8FKAey5f6qRubXH/Zyk4iEO7o7+8qFMZ0qR+SjD7Kr
         rZC4/OuKsjV0kY9zB6WCeWBxkJS325MSuGJiRSoXaviNQ2sGihJmvt1F3N79F8ePxvof
         +BqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JI/Lia72G0FNL112c0dOM2shPHSe/tqNtZcRPBwe5rk=;
        b=qpK/QmzsGvA5rJEMl+S0lPu3YvcBZ3Gg1v+b6LbwrOcBIyeUxzYhxvWjvdnhipMDfx
         C9EEdaTpS9fZT2tz7HaBeY7Tne/15/yhjXLZoaSlMif829XB+pfzo5vdJtwb8rm1xaY7
         cyDge2HYj+sfem3p31aI7GGHUF7WEobzdIwMHtmXqiECrdXjPwDfoM6xFhTuvD6BbxUW
         ai9T1xkq/UkWH1fghCtMn5Mn4S5+G5yRNEE6ihLY1Ux+jbh7sXwTkTja6E+CrXMmeEYF
         Bc/mPWpSgwO7cRGtYLeZhNjLtD/d7nuz3RgTC1bxhMkJZwoUD120iN55AtOZPSs3akBp
         aQXg==
X-Gm-Message-State: APjAAAUTisApYuunl/NU1SmuTjoFOpLjzact+8rkTN1I6+37LbQG0FUw
        AadPGcDOS3oBJqonCbN6vSfLkPuV
X-Google-Smtp-Source: APXvYqzL8l+gd2u3Ok+07AZgeYnYKQnZRJhfSEWAqq0MKIWRykeuz04JtlIrh8LpcDN7q2yj+PkCkA==
X-Received: by 2002:a17:902:b597:: with SMTP id a23mr38285210pls.284.1556186075998;
        Thu, 25 Apr 2019 02:54:35 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id f71sm39073544pfc.109.2019.04.25.02.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 02:54:35 -0700 (PDT)
Date:   Thu, 25 Apr 2019 02:54:33 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/6] t7610: unsuppress output
Message-ID: <9f9922cab341396a846edc2f52342c59d294379a.1556185345.git.liu.denton@gmail.com>
References: <cover.1556185345.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556185345.git.liu.denton@gmail.com>
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
2.21.0.1000.g11cd861522

