Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2070A1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbeCXHqE (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:04 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43467 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeCXHpq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:46 -0400
Received: by mail-lf0-f65.google.com with SMTP id v207-v6so21403421lfa.10
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c63A3tFA8uG0NWRqaktasheN93f/p0iNjpupvcxOqxQ=;
        b=pxKNjIrDnVCH6rd1ZDpvvQUxKjXOyYNlwMJw/ChocODmdQapb1j8ZaRS+wupVz2KzH
         ksii76Clpx2uu+bwA5tGyYOfiuK+Vlccwd0g7IfLBKuUNJyZ6BYIr/x8zjGovKvsi4N5
         vnyNxhKIb93H2t0mXplNaAgAc+Te6c8GUd9KdAILzVIi/5zmVuD0Bhrlp490i2xSRQB3
         3v00zN6KZLS+npF6KMZIhHAtCEgtqGY3ST+4rID2awv744j1vmLSzNx9OtfsCxnKPhyS
         iFAZEYZ/2wUIPqFiSRmKVz9RyOVb2QreMqpH94r/K9ZG8OG3xeyNLXINo3ICgYLyWeRZ
         qVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c63A3tFA8uG0NWRqaktasheN93f/p0iNjpupvcxOqxQ=;
        b=Da8/70xP7AwwMEAc/RA1XWMwq63od/Ikvgl06/jbVFe4uxb8y5uj3Cx06ITWpqp+9I
         UYW0WxN23hRdMrah1BrhFekV+LjjZCMJc7hECESlw20PYgpgm2YOesTOXUmi8HvikYbC
         JtFcm9ebvGf7bGWNAFvTJsgauEVrf7TvR6XCJPJHxDMyML1FufG9ZF94HYNfIAaPYMnz
         aCejHjb7tb8eE5O8m7xoCH9dwkyAHM21GI0I9QldPR/78rbqoa4PpRVYOCX4Sx+2jF+w
         gNf/EGFYN5+DghuU0UgKT2olpaNRhBdxB2WPUYco5hDHcPxg58KpXTBiGlfVz7aj5NCJ
         CcgA==
X-Gm-Message-State: AElRT7H4ibG516hOh9ZkaLp9sPqZ5QgoTRcXq0EfVdLx99mn+JcocN7/
        FHx8ndZ7UXOU5ONf/r1bzAM=
X-Google-Smtp-Source: AG47ELubQNKP3HRImGWf9JbC8BpofEMeWma+6tpwm2ZmZhzHcttzT5EF05e4kIfmOf71xTq49DI8mg==
X-Received: by 10.46.31.10 with SMTP id f10mr20692184ljf.130.1521877545259;
        Sat, 24 Mar 2018 00:45:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/36] t/helper: merge test-example-decorate into test-tool
Date:   Sat, 24 Mar 2018 08:44:41 +0100
Message-Id: <20180324074505.19100-13-pclouds@gmail.com>
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
index 90dc97a9d0..081115bf8e 100644
--- a/t/helper/test-example-decorate.c
+++ b/t/helper/test-example-decorate.c
@@ -1,8 +1,9 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "object.h"
 #include "decorate.h"
 
-int cmd_main(int argc, const char **argv)
+int cmd__example_decorate(int argc, const char **argv)
 {
 	struct decoration n;
 	struct object_id one_oid = { {1} };
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 26ae209cd5..a0e95c13ed 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -15,6 +15,7 @@ static struct test_cmd cmds[] = {
 	{ "drop-caches", cmd__drop_caches },
 	{ "dump-cache-tree", cmd__dump_cache_tree },
 	{ "dump-split-index", cmd__dump_split_index },
+	{ "example-decorate", cmd__example_decorate },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "sha1", cmd__sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e8363e851f..721a1e1b09 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -9,6 +9,7 @@ int cmd__delta(int argc, const char **argv);
 int cmd__drop_caches(int argc, const char **argv);
 int cmd__dump_cache_tree(int argc, const char **argv);
 int cmd__dump_split_index(int argc, const char **argv);
+int cmd__example_decorate(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
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
2.17.0.rc0.348.gd5a49e0b6f

