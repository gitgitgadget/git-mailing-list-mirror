Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F351F453
	for <e@80x24.org>; Wed, 24 Apr 2019 22:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfDXWrA (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 18:47:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40889 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfDXWrA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 18:47:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so10066221pfc.7
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 15:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j8Zdhhg6vNpYJBOGDIFvueQHUMcPERcnAMvjpDjNZEw=;
        b=qGs/+OdDnGGsPCdj8NKszkWyM2GkWiiz3H3yx5GXnl8elXfvAEJI7CT32yqp5IFPph
         LXi/fBezKzzYj7e/3zhdTCohu8ClNesJUUdcZB7C55W1Wr1ZZtU3WkoFV9jKbIuwesMJ
         OVAZxOwnlsb703sEOqkXuksAgRYWLnmZmxy+rEylDJpBRlJtq5L8s757GWBVLpenRb3H
         jtis+LQebmA0IOFBWimb9Yb+jXcvt32JJFpaSOycMTpSyTBv0E//akHD2yCiRFKByHD6
         uRZYJw3nhA2sz0/CYU5565MGNNcsbqpooDJXA/jUag1zpTg57Kwb6b0zQBflDc95DmNB
         SJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j8Zdhhg6vNpYJBOGDIFvueQHUMcPERcnAMvjpDjNZEw=;
        b=AolgxGCrg4PMZgPFMgjUoy8TCiWiMhqFNQGXgSxaWuRtns0gZJ0opuqq+U9Ccz9ko6
         IONIgeAuccivphhTa2sC6pIJYm+plFf3nAZU3370XHbfqx6PsYozDHMJwL5oTLpxnDUn
         PIyab8D8RsE3/IFIQOg6n6sf4UopVca9mU9mMiS8QqUkQIpWTLlkTjl0nRpvhODJUPe0
         4nbmXdfpLaztKLfx/QWm1/YJ5miuwkOysEm0KCMojBHtdZPqUJIj+hrOWhH1r2BBXRAt
         BRBgov/pEqFMtNcPa72TfLd/UsS8C61agYO0pnFpIdNI3V+ovlhMpnV2KKwug85ZXi0V
         1lQQ==
X-Gm-Message-State: APjAAAV91Cx/srx5N2m/zC/ShPVYLEjkpC3Q/OnKrLGy2On5jsZWdSLS
        pMoJX0neyxm2JPjnOh5yyrbaPC5l
X-Google-Smtp-Source: APXvYqwcic7yxu5ReIGYG6uk82P8sbqyfK5A9TUiAjKRRlae6mis+9ULXSttE/AnYrfFkwN+S/sWrw==
X-Received: by 2002:a62:5a42:: with SMTP id o63mr37630065pfb.170.1556146019040;
        Wed, 24 Apr 2019 15:46:59 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id d8sm22233655pgv.34.2019.04.24.15.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:46:58 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:46:57 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/6] t7610: unsuppress output
Message-ID: <9f9922cab341396a846edc2f52342c59d294379a.1556142510.git.liu.denton@gmail.com>
References: <cover.1556009181.git.liu.denton@gmail.com>
 <cover.1556142510.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556142510.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
2.21.0.1000.g7817e26e80

