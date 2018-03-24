Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B2A11F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeCXHqC (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:02 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46365 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeCXHpu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:50 -0400
Received: by mail-lf0-f66.google.com with SMTP id j68-v6so21388189lfg.13
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ttytg/JdMCCRTFLas84WQbC0ui5ApWk0CXw9fu7dOEQ=;
        b=NTKmMRhxZbbv7mBXw7XfOe8PqHVpToaldSyF4VlCXEYNnau9TkWa5cApW5PNa4S7pQ
         n1DBjj53m2cw2/01toTxCu9zY6Dvl32w6JVHRfmiCL0BC+Qb8GkbjfoNAaQx/J5m7aP6
         2rpWc3WIuQGJUDLlNfeS7ZHzqgY1aCGumDOqPGBZgAlALp1aiRM2dC31aeZ0W20/1Rt3
         8PWsDqLEe2aH9lTXNpz01b+cuazvPNI+CiVbhLs/XHNFVUUTBdXYsOpWoy+LhNTLm4ET
         dwJUpyNyC5Csu271/xrdfsrlGRv1Os5aFbv8o1QrKbBIXV7dhNjphEhlAxyvbEBs6ssG
         9eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ttytg/JdMCCRTFLas84WQbC0ui5ApWk0CXw9fu7dOEQ=;
        b=Bv/ByIkdSvdE0V1DtEnlrgF/thoMpqjEyHjFqYnU8ivuONbyayeUc59H3vXVaAmnz1
         31mK/UhQOMnasAnn83LV9eoQyVTo6FeYvRyPZqpji1GQykWA1bLZ5Re79dlNzSOKn92o
         DeJLnMaEyev/qgWoSn+7M5eS512L0M4cYBQLJjFp9wsngb8DyeXci7Pz47YSFX9pjiJf
         KuWdmH4oQAYAerh/EZGRLvG/jQhifxEU+cAmfWQcOSfl8K0WZ9fnFqPURqQvTuoDtUxc
         HjoI1ORZx2rntjfMJHk0RitYBXCzrIb1FTYvqKCdE9KhcaWDl791KB1tjCKEfU59sOiC
         KNWQ==
X-Gm-Message-State: AElRT7G2gKhmIlT/ofAcL3IpuG3pytJ1wMg3xhNMsTYWdtyACz9Jrs1F
        ME5RCLdvVs1YPts1W9umtuE=
X-Google-Smtp-Source: AG47ELs3lT9QO8c/tRqK+Wa8i0vRUhIRFjfSWiGo/RhGReURQUDfvcqmCJWFs61WnqQCk/CLZPYwLg==
X-Received: by 2002:a19:15d9:: with SMTP id 86-v6mr22326384lfv.96.1521877548862;
        Sat, 24 Mar 2018 00:45:48 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:48 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 15/36] t/helper: merge test-index-version into test-tool
Date:   Sat, 24 Mar 2018 08:44:44 +0100
Message-Id: <20180324074505.19100-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324074505.19100-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
 <20180324074505.19100-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile                              | 2 +-
 t/helper/test-index-version.c         | 3 ++-
 t/helper/test-tool.c                  | 1 +
 t/helper/test-tool.h                  | 1 +
 t/t1600-index.sh                      | 2 +-
 t/t1700-split-index.sh                | 2 +-
 t/t2104-update-index-skip-worktree.sh | 6 +++---
 7 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index f6c3ddc703..d7342e3a8b 100644
--- a/Makefile
+++ b/Makefile
@@ -663,13 +663,13 @@ TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-hashmap.o
+TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
-TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-match-trees
 TEST_PROGRAMS_NEED_X += test-mergesort
diff --git a/t/helper/test-index-version.c b/t/helper/test-index-version.c
index f569f6b7ef..fcd10968cc 100644
--- a/t/helper/test-index-version.c
+++ b/t/helper/test-index-version.c
@@ -1,6 +1,7 @@
+#include "test-tool.h"
 #include "cache.h"
 
-int cmd_main(int argc, const char **argv)
+int cmd__index_version(int argc, const char **argv)
 {
 	struct cache_header hdr;
 	int version;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b9a6e7cbaa..88fbe8ddbd 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -18,6 +18,7 @@ static struct test_cmd cmds[] = {
 	{ "example-decorate", cmd__example_decorate },
 	{ "genrandom", cmd__genrandom },
 	{ "hashmap", cmd__hashmap },
+	{ "index-version", cmd__index_version },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "sha1", cmd__sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index fba4bd80b9..b855203477 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -12,6 +12,7 @@ int cmd__dump_split_index(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
+int cmd__index_version(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 079d241145..c4422312f4 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -68,7 +68,7 @@ test_expect_success 'GIT_INDEX_VERSION takes precedence over config' '
 		git config --add index.version 2 &&
 		git add a 2>&1 &&
 		echo 4 >expect &&
-		test-index-version <.git/index >actual &&
+		test-tool index-version <.git/index >actual &&
 		test_cmp expect actual
 	)
 '
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index ec179fbaf7..e4f4c4df4e 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -12,7 +12,7 @@ test_expect_success 'enable split index' '
 	git config splitIndex.maxPercentChange 100 &&
 	git update-index --split-index &&
 	test-tool dump-split-index .git/index >actual &&
-	indexversion=$(test-index-version <.git/index) &&
+	indexversion=$(test-tool index-version <.git/index) &&
 	if test "$indexversion" = "4"
 	then
 		own=432ef4b63f32193984f339431fd50ca796493569
diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index-skip-worktree.sh
index cc830da58d..7e2e7dd4ae 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -33,7 +33,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'index is at version 2' '
-	test "$(test-index-version < .git/index)" = 2
+	test "$(test-tool index-version < .git/index)" = 2
 '
 
 test_expect_success 'update-index --skip-worktree' '
@@ -42,7 +42,7 @@ test_expect_success 'update-index --skip-worktree' '
 '
 
 test_expect_success 'index is at version 3 after having some skip-worktree entries' '
-	test "$(test-index-version < .git/index)" = 3
+	test "$(test-tool index-version < .git/index)" = 3
 '
 
 test_expect_success 'ls-files -t' '
@@ -55,7 +55,7 @@ test_expect_success 'update-index --no-skip-worktree' '
 '
 
 test_expect_success 'index version is back to 2 when there is no skip-worktree entry' '
-	test "$(test-index-version < .git/index)" = 2
+	test "$(test-tool index-version < .git/index)" = 2
 '
 
 test_done
-- 
2.17.0.rc0.348.gd5a49e0b6f

