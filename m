Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE1F420756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdAJUmw (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:42:52 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36012 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750956AbdAJUms (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:42:48 -0500
Received: by mail-qt0-f170.google.com with SMTP id k15so406888199qtg.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2W39KrXg+1bsHh43G85xCRqteTzlx+a/Lz8lA9XCQ80=;
        b=VcbOLJn+E1Jutl4c87DOKfDdmXBpERxWNSvJ0STeoqpk9o8i0NZ+T9OA62vkwAJym/
         7zTp72njG/cHqeVfEpkxVtMjDTunY/PzVt8zuKN/TMhD4GJBpM68vkCTO496dTSPJYl0
         6bSB7yIgjrihRBqAvQgWtpHh8ok8wt7drN03uHO4sJ+stv9HkaQWUFx0OBmEIlZjcoMR
         YuZtNUIiDFSUKJ76pXxqXjxJ6JlQ0KArjcyyAZvpMpwaffBvRpdepw8PrC6q5fNG5A7M
         w3CGQMw/Jd0q2FCmV/7CY1XkLq0HNul2phqiu8QvSAFRx1r3lNwRqyKVEkEnsBgmamGd
         RxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2W39KrXg+1bsHh43G85xCRqteTzlx+a/Lz8lA9XCQ80=;
        b=A9R6oGfkfk4r9drz0kbPe2IVshvF6c/la8ia8GUapB7uOujyah2/nSdDH9nmjvEoDs
         l5DzvOnBgUkSUC8n57j2gw4/wcVjanUZaydEWMgNOI9lAmucJ2Jrjs5JciEfWke4nUFw
         f/nyvTiJCXOcSzNUzlGB1mGo6sCCCQn29RGgOqZOUgRHn0LBvzhDpHiucBKXOshwmcwn
         +qwZfKo0AluGKaEtjpf2SEguqi1c505Lm6AkC1vQpYj/QXsN5Yu87jFCdlBISjoLNPWa
         pHVdDrEqO/clkTCSiGTyOpSPSlzS4QI2BkpgHcScKXmA6/eOF2t0dkGiLY0UpVMSo351
         Ef0w==
X-Gm-Message-State: AIkVDXL2I6DutuQpwEvCmHL/Vl6huES92w7nR0PEOBILb9Bors9WG/6x4OUYYzUOiYjMKkPB
X-Received: by 10.200.40.177 with SMTP id i46mr1900285qti.279.1484080967064;
        Tue, 10 Jan 2017 12:42:47 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id z189sm2238137qkb.42.2017.01.10.12.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 12:42:46 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org, gitster@pobox.com
Subject: [PATCH v5 11/14] t7610: spell 'git reset --hard' consistently
Date:   Tue, 10 Jan 2017 15:41:59 -0500
Message-Id: <20170110204202.21779-12-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170110204202.21779-1-hansenr@google.com>
References: <20170109232941.43637-1-hansenr@google.com>
 <20170110204202.21779-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 t/t7610-mergetool.sh | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 54164a320..c031ecd9e 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -289,23 +289,23 @@ test_expect_success 'mergetool takes partial path' '
 '
 
 test_expect_success 'mergetool delete/delete conflict' '
-	test_when_finished "git reset --hard HEAD" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count move-to-c &&
 	test_must_fail git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
 	! test -f a/a/file.txt &&
-	git reset --hard HEAD &&
+	git reset --hard &&
 	test_must_fail git merge move-to-b &&
 	echo m | git mergetool a/a/file.txt &&
 	test -f b/b/file.txt &&
-	git reset --hard HEAD &&
+	git reset --hard &&
 	test_must_fail git merge move-to-b &&
 	! echo a | git mergetool a/a/file.txt &&
 	! test -f a/a/file.txt
 '
 
 test_expect_success 'mergetool produces no errors when keepBackup is used' '
-	test_when_finished "git reset --hard HEAD" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepBackup true &&
 	test_must_fail git merge move-to-b &&
@@ -316,7 +316,7 @@ test_expect_success 'mergetool produces no errors when keepBackup is used' '
 '
 
 test_expect_success 'mergetool honors tempfile config for deleted files' '
-	test_when_finished "git reset --hard HEAD" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepTemporaries false &&
 	test_must_fail git merge move-to-b &&
@@ -325,7 +325,7 @@ test_expect_success 'mergetool honors tempfile config for deleted files' '
 '
 
 test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
-	test_when_finished "git reset --hard HEAD" &&
+	test_when_finished "git reset --hard" &&
 	test_when_finished "git clean -fdx" &&
 	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepTemporaries true &&
@@ -342,7 +342,7 @@ test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
 '
 
 test_expect_success 'deleted vs modified submodule' '
-	test_when_finished "git reset --hard HEAD" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	mv submod submod-movedaside &&
@@ -560,7 +560,7 @@ test_expect_success 'directory vs modified submodule' '
 	test "$(cat submod/file16)" = "not a submodule" &&
 	rm -rf submod.orig &&
 
-	git reset --hard >/dev/null 2>&1 &&
+	git reset --hard &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
 	test ! -e submod.orig &&
@@ -572,7 +572,8 @@ test_expect_success 'directory vs modified submodule' '
 	( cd submod && git clean -f && git reset --hard ) &&
 	git submodule update -N &&
 	test "$(cat submod/bar)" = "master submodule" &&
-	git reset --hard >/dev/null 2>&1 && rm -rf submod-movedaside &&
+	git reset --hard &&
+	rm -rf submod-movedaside &&
 
 	git checkout -b test$test_count.c master &&
 	git submodule update -N &&
@@ -582,7 +583,7 @@ test_expect_success 'directory vs modified submodule' '
 	git submodule update -N &&
 	test "$(cat submod/bar)" = "master submodule" &&
 
-	git reset --hard >/dev/null 2>&1 &&
+	git reset --hard &&
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
@@ -590,13 +591,13 @@ test_expect_success 'directory vs modified submodule' '
 	( yes "r" | git mergetool submod ) &&
 	test "$(cat submod/file16)" = "not a submodule" &&
 
-	git reset --hard master >/dev/null 2>&1 &&
+	git reset --hard master &&
 	( cd submod && git clean -f && git reset --hard ) &&
 	git submodule update -N
 '
 
 test_expect_success 'file with no base' '
-	test_when_finished "git reset --hard master >/dev/null 2>&1" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool mybase -- both &&
@@ -605,7 +606,7 @@ test_expect_success 'file with no base' '
 '
 
 test_expect_success 'custom commands override built-ins' '
-	test_when_finished "git reset --hard master >/dev/null 2>&1" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.defaults.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
 	test_config mergetool.defaults.trustExitCode true &&
@@ -616,7 +617,7 @@ test_expect_success 'custom commands override built-ins' '
 '
 
 test_expect_success 'filenames seen by tools start with ./' '
-	test_when_finished "git reset --hard master >/dev/null 2>&1" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.writeToTemp false &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
@@ -632,7 +633,7 @@ test_lazy_prereq MKTEMP '
 '
 
 test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToTemp' '
-	test_when_finished "git reset --hard master >/dev/null 2>&1" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.writeToTemp true &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
@@ -644,7 +645,7 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
 '
 
 test_expect_success 'diff.orderFile configuration is honored' '
-	test_when_finished "git reset --hard >/dev/null" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count order-file-side2 &&
 	test_config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
@@ -662,7 +663,7 @@ test_expect_success 'diff.orderFile configuration is honored' '
 	test_cmp expect actual
 '
 test_expect_success 'mergetool -Oorder-file is honored' '
-	test_when_finished "git reset --hard >/dev/null 2>&1" &&
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count order-file-side2 &&
 	test_config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
@@ -678,7 +679,7 @@ test_expect_success 'mergetool -Oorder-file is honored' '
 	git mergetool -O/dev/null --no-prompt --tool myecho >output &&
 	git grep --no-index -h -A2 Merging: output >actual &&
 	test_cmp expect actual &&
-	git reset --hard >/dev/null 2>&1 &&
+	git reset --hard &&
 
 	git config --unset diff.orderFile &&
 	test_must_fail git merge order-file-side1 &&
-- 
2.11.0.390.gc69c2f50cf-goog

