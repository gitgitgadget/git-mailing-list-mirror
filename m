Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 778D51F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeCQH4A (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:56:00 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36950 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbeCQHzw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:52 -0400
Received: by mail-lf0-f66.google.com with SMTP id y19-v6so18545792lfd.4
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8N0qxdcHhD1ok5+FujhP+/OiqkRQn9yZShFwmsVESDw=;
        b=W+Bd+nm9f6DbKKMRAAAogiPY595mpm6AG53t/lsq2R/QWrFmFD049XdrZIxdZWMCP8
         rtPx+y3LUIng5oTgGxVK90SpfTeklGapMvVQpxqnmXjN0aNRn1t3ghEmJdj7sAuqYKOS
         dI7XEysXv3JacPy3/Lg4rJO+eth0gfZoOUTX77WO8/KepXCZvh6NC/QHc8cJvpjOGKXO
         lEf69hgqPUQYK8ryhu8VI8FPpxdPgQAYhvzltd26d2cjiT/SkPdsUUwLSu1fnW5boanN
         YuktOmqlIOOmJVdxZ9Yk5YxRXOabMzuxCXLPDH6Xpa9z+3B+IV5/b/ziJ+FqnmfcAy3C
         BWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8N0qxdcHhD1ok5+FujhP+/OiqkRQn9yZShFwmsVESDw=;
        b=o/hKCm8yhxcdXJjYmFrEU8qC13p+gvK4fpuaY9uvrQf0xM4uEiPlgW/MbhUmr6/Lnk
         yKA9e/4RmgriLLMl2jdnquCYbE9iq7RgSDN9QOTdhXrKZSr12VdNX80TluF6mW8jz8Nx
         mzqSurCnJPxFnUnNtFUFhm3NlOXB7wNB4QjMg82NSPI9YEZIUIdjgzRW5ah820Di+YR5
         2YjXv1E58v/Cgzj/4h1iygCdWNq99wdJ4aNTnQrXdmfzwx7y3pjQaJdNDH1WgItPuxBO
         LgErbNpec2WBEfsnLCNpSH7bCGnsLAtXkKWTmitI6HfBYe+hL+RVHtBltne8bmNyBQKl
         xAGw==
X-Gm-Message-State: AElRT7FfDCmiBKZgLzZYZ1fy4sl4t8tx9TZkNRIi1492YExnfoAtPZRs
        z5BhsEXIYYxo3hJaZwWJCPkYEQ==
X-Google-Smtp-Source: AG47ELtU4uQcAvH7HO/xcP9iSI7LnbUdApgVqWlXU9i6lb7uroO4+FWqI5GNgxTNOXWJmgY8mzObHQ==
X-Received: by 2002:a19:4d46:: with SMTP id a67-v6mr3427535lfb.36.1521273350597;
        Sat, 17 Mar 2018 00:55:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/36] t/helper: merge test-mktemp into test-tool
Date:   Sat, 17 Mar 2018 08:54:03 +0100
Message-Id: <20180317075421.22032-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180317075421.22032-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile               | 2 +-
 t/helper/test-mktemp.c | 3 ++-
 t/helper/test-tool.c   | 1 +
 t/helper/test-tool.h   | 1 +
 t/t0070-fundamental.sh | 4 ++--
 5 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 67f37b849e..3145a9b1b2 100644
--- a/Makefile
+++ b/Makefile
@@ -667,13 +667,13 @@ TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
+TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
-TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-online-cpus
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
diff --git a/t/helper/test-mktemp.c b/t/helper/test-mktemp.c
index 89d9b2f7be..afc9dee91d 100644
--- a/t/helper/test-mktemp.c
+++ b/t/helper/test-mktemp.c
@@ -1,9 +1,10 @@
 /*
  * test-mktemp.c: code to exercise the creation of temporary files
  */
+#include "test-tool.h"
 #include "git-compat-util.h"
 
-int cmd_main(int argc, const char **argv)
+int test_mktemp(int argc, const char **argv)
 {
 	if (argc != 2)
 		usage("Expected 1 parameter defining the temporary file template");
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 4206d96304..4a563e08c3 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -22,6 +22,7 @@ static struct test_cmd cmds[] = {
 	{ "lazy-init-name-hash", test_lazy_init_name_hash },
 	{ "match-trees", test_match_trees },
 	{ "mergesort", test_mergesort },
+	{ "mktemp", test_mktemp },
 	{ "sha1", test_sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index dff1b804cb..5bbe3e96cf 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -16,6 +16,7 @@ int test_index_version(int argc, const char **argv);
 int test_lazy_init_name_hash(int argc, const char **argv);
 int test_match_trees(int argc, const char **argv);
 int test_mergesort(int argc, const char **argv);
+int test_mktemp(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 70d4d98a2e..ac007938ee 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -13,7 +13,7 @@ test_expect_success 'character classes (isspace, isalpha etc.)' '
 '
 
 test_expect_success 'mktemp to nonexistent directory prints filename' '
-	test_must_fail test-mktemp doesnotexist/testXXXXXX 2>err &&
+	test_must_fail test-tool mktemp doesnotexist/testXXXXXX 2>err &&
 	grep "doesnotexist/test" err
 '
 
@@ -21,7 +21,7 @@ test_expect_success POSIXPERM,SANITY 'mktemp to unwritable directory prints file
 	mkdir cannotwrite &&
 	chmod -w cannotwrite &&
 	test_when_finished "chmod +w cannotwrite" &&
-	test_must_fail test-mktemp cannotwrite/testXXXXXX 2>err &&
+	test_must_fail test-tool mktemp cannotwrite/testXXXXXX 2>err &&
 	grep "cannotwrite/test" err
 '
 
-- 
2.16.2.903.gd04caf5039

