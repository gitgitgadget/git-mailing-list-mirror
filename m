Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 812D91F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeCQHzw (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:55:52 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46699 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbeCQHzo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:44 -0400
Received: by mail-lf0-f65.google.com with SMTP id w16-v6so18466984lfc.13
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EGiGinKfREcklFEkhVHr/d6FQk11eh48Rmw5LamBEhc=;
        b=NFAFPUdZNBpXAmGZxqwikUl3hOCQ7VolBVpEt+krNPMtLm4w7ZMCPtLb6hFH3kcG/r
         kbFl7Od0BadSF+NsA4X1DsOy4mcKoNj+FA1jP2rxcC8RBIh6EfY4rMyJLVQz8fO7F4ku
         WcpJ2I2r+XTuhGlz/VHkijckBmJvh4CM+MZrQN3Qb4HoupEryCMnCQKSIy5Uh29giyH2
         FDE3URX2KqVUTRyiqPybieRsq/Qdra16pT9Wj11cC4efmkPBbOt0yQorKj3dMqfd6POi
         T09kaULzGsr2yRt7YOYB8xW3bPDQNcu3ypgdWWBCuqVrqDylA4dROUYVuXif4LRSlsnR
         NPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGiGinKfREcklFEkhVHr/d6FQk11eh48Rmw5LamBEhc=;
        b=Tj5z6aRWaTcqfzsZ2t8JWymzRExdOyinWAfZa3y5WLhel6xXoEyOjDuUU+eXYesiz3
         SJ5T+3cRVs96/7bnR+U27hQsB3/fwavCVPWXVXhfbYnWc3ZhFEx3VsE/2ctyz5mU8MvR
         kuLA8DlJHwZv2gVBJYs2CNAUKlwNOdii6RvrcaDbXWjmNDF+0JdEwHiPBvD567bhT+wP
         Hj5F5VqBgtq0/qks5PgFrc4RNn6j73oNNEjmmJ7iqCis9g2DRF+z0OCaRAZrFR4HhlQ1
         9Tx3YT5KZNrPUPgnjvNUP5JU8ptekr4umifHdflfud9HhgJle7tjLUL6FT8fOkvMaQGy
         xf0w==
X-Gm-Message-State: AElRT7F8VaHpSwrZJikL1kuZQRzO0XbYlDKRZ/OtCMNxSN+99kGSY0pR
        Xzgg/N74ywmf/1iTTuU62rAHzQ==
X-Google-Smtp-Source: AG47ELvT1X7N8EjIB8KWPsqcQ4+KOijhO0cXknD0x6eh5VNDvu634UGj0lP7vfSsdbXOQPgla1YQjw==
X-Received: by 2002:a19:730d:: with SMTP id o13-v6mr3414415lfc.88.1521273343087;
        Sat, 17 Mar 2018 00:55:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/36] t/helper: merge test-example-decorate into test-tool
Date:   Sat, 17 Mar 2018 08:53:57 +0100
Message-Id: <20180317075421.22032-13-pclouds@gmail.com>
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
 Makefile                         | 2 +-
 t/helper/test-example-decorate.c | 3 ++-
 t/helper/test-tool.c             | 1 +
 t/helper/test-tool.h             | 1 +
 t/t9004-example.sh               | 2 +-
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 8993cec274..895b170fe3 100644
--- a/Makefile
+++ b/Makefile
@@ -660,12 +660,12 @@ TEST_BUILTINS_OBJS += test-delta.o
 TEST_BUILTINS_OBJS += test-drop-caches.o
 TEST_BUILTINS_OBJS += test-dump-cache-tree.o
 TEST_BUILTINS_OBJS += test-dump-split-index.o
+TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
-TEST_PROGRAMS_NEED_X += test-example-decorate
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-hashmap
diff --git a/t/helper/test-example-decorate.c b/t/helper/test-example-decorate.c
index 90dc97a9d0..280b5a8fbe 100644
--- a/t/helper/test-example-decorate.c
+++ b/t/helper/test-example-decorate.c
@@ -1,8 +1,9 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "object.h"
 #include "decorate.h"
 
-int cmd_main(int argc, const char **argv)
+int test_example_decorate(int argc, const char **argv)
 {
 	struct decoration n;
 	struct object_id one_oid = { {1} };
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 9be6ec3764..92e6f0d5b4 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -15,6 +15,7 @@ static struct test_cmd cmds[] = {
 	{ "drop-caches", test_drop_caches },
 	{ "dump-cache-tree", test_dump_cache_tree },
 	{ "dump-split-index", test_dump_split_index },
+	{ "example-decorate", test_example_decorate },
 	{ "lazy-init-name-hash", test_lazy_init_name_hash },
 	{ "sha1", test_sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index d062bad365..e97d6c4aaa 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -9,6 +9,7 @@ int test_delta(int argc, const char **argv);
 int test_drop_caches(int argc, const char **argv);
 int test_dump_cache_tree(int argc, const char **argv);
 int test_dump_split_index(int argc, const char **argv);
+int test_example_decorate(int argc, const char **argv);
 int test_lazy_init_name_hash(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
diff --git a/t/t9004-example.sh b/t/t9004-example.sh
index b28a028f55..7e8894a4a7 100755
--- a/t/t9004-example.sh
+++ b/t/t9004-example.sh
@@ -4,7 +4,7 @@ test_description='check that example code compiles and runs'
 . ./test-lib.sh
 
 test_expect_success 'decorate' '
-	test-example-decorate
+	test-tool example-decorate
 '
 
 test_done
-- 
2.16.2.903.gd04caf5039

