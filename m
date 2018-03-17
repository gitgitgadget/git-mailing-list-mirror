Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 230BB1F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeCQH4c (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:56:32 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46723 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbeCQH4C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:56:02 -0400
Received: by mail-lf0-f66.google.com with SMTP id w16-v6so18467468lfc.13
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wBsZRbCMIWmPft8oe7VcG/ZJc63T0jkOSu7wSLf8RTM=;
        b=OIpK45JcwJPE7SD4Q8nqrJU72VML+EBhrDDM1yLzJ6UTV09dd1wmh73u6MJC1mhDGb
         1kNPV9CWUBi14M72MNYBDp3vyYsI/KWks9OSg9jiITgNQJZxsSFpNXigJ4dvpCvFuIyY
         r91UBv1waW4KiQDu4vnqIEUCvm46R2HWwke8y8Z1mr3IpZYSBPI3ebRc7WZsWYMQZg7R
         MZifEtdAqowet8gNV1mzKUh+t5B82AR3Y5XwaXc3VBcLsGlB5IrOTcjxjZsLzsFhcHj7
         FYOC0zcJ5aY7Nn0u97LLIUcKWF4gnwAkgG9zCJSOjVtNiFvNsCB8VqSo3oS1UHHZgCwS
         1uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wBsZRbCMIWmPft8oe7VcG/ZJc63T0jkOSu7wSLf8RTM=;
        b=YjCmkvQCtQb6gnD4Xt/Y+wQiXsUOFL43Grue4F8pFCK+T8uNrXtJUYd0BgnxdFNfdy
         C606NjGAY2AiKn26gqAb49mZLEljXccCu05Lq/nNqArVIBsn03jEEmIQA5IKZRcEwG2H
         eSSeEUiSIq7yQlQWsNO+j9rW/+2afDSu+azh+d+H0xuzXsSAzXyO5baC+E7/0ForB3JY
         +/HEGcWLKLlqsMToszqHVotAjzS3yTNphnonjGhKVtOru9wXCy7HJMae0V9xe3DBvWBc
         WLmwBhQdGK9U5FmCXP1C+et7Tibj6nSFJaHJCFYx+l4PX+6KY/FmRojOEeoYkx2hvkzZ
         5+Rw==
X-Gm-Message-State: AElRT7GU9xeuEIR6g85DZXyf1k7WAkx4TRAyGwAMYZdE1moYwfxQ7rAG
        j6QSz4Qsca1IqIZ+PKFIPWBuNA==
X-Google-Smtp-Source: AG47ELsP11Wi8WDby8xIuwWUzWpn3uXJxQYIkq4y8Y6EeF89/WvTuCyFdKoDjTBiWx1MQl+KaNHm/g==
X-Received: by 10.46.9.150 with SMTP id 144mr3334255ljj.117.1521273360497;
        Sat, 17 Mar 2018 00:56:00 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:59 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 27/36] t/helper: merge test-scrap-cache-tree into test-tool
Date:   Sat, 17 Mar 2018 08:54:12 +0100
Message-Id: <20180317075421.22032-28-pclouds@gmail.com>
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
 t/helper/test-scrap-cache-tree.c | 3 ++-
 t/helper/test-tool.c             | 1 +
 t/helper/test-tool.h             | 1 +
 t/t0090-cache-tree.sh            | 8 ++++----
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index adece67b8e..ba7c7d8a79 100644
--- a/Makefile
+++ b/Makefile
@@ -676,6 +676,7 @@ TEST_BUILTINS_OBJS += test-ref-store.o
 TEST_BUILTINS_OBJS += test-regex.o
 TEST_BUILTINS_OBJS += test-revision-walking.o
 TEST_BUILTINS_OBJS += test-run-command.o
+TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
@@ -684,7 +685,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-sha1-array
 TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-strcmp-offset
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index d2a63bea43..e1246602a7 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "lockfile.h"
 #include "tree.h"
@@ -5,7 +6,7 @@
 
 static struct lock_file index_lock;
 
-int cmd_main(int ac, const char **av)
+int test_scrap_cache_tree(int ac, const char **av)
 {
 	setup_git_directory();
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index a8a92b6a10..f12f1ec5bb 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -31,6 +31,7 @@ static struct test_cmd cmds[] = {
 	{ "regex", test_regex },
 	{ "revision-walking", test_revision_walking },
 	{ "run-command", test_run_command },
+	{ "scrap-cache-tree", test_scrap_cache_tree },
 	{ "sha1", test_sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 23f63ee357..92504e951f 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -25,6 +25,7 @@ int test_ref_store(int argc, const char **argv);
 int test_regex(int argc, const char **argv);
 int test_revision_walking(int argc, const char **argv);
 int test_run_command(int argc, const char **argv);
+int test_scrap_cache_tree(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 3266209e41..4ae0995cd9 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -115,14 +115,14 @@ test_expect_success 'update-index invalidates cache-tree' '
 '
 
 test_expect_success 'write-tree establishes cache-tree' '
-	test-scrap-cache-tree &&
+	test-tool scrap-cache-tree &&
 	git write-tree &&
 	test_cache_tree
 '
 
-test_expect_success 'test-scrap-cache-tree works' '
+test_expect_success 'test-tool scrap-cache-tree works' '
 	git read-tree HEAD &&
-	test-scrap-cache-tree &&
+	test-tool scrap-cache-tree &&
 	test_no_cache_tree
 '
 
@@ -170,7 +170,7 @@ test_expect_success 'commit in child dir has cache-tree' '
 '
 
 test_expect_success 'reset --hard gives cache-tree' '
-	test-scrap-cache-tree &&
+	test-tool scrap-cache-tree &&
 	git reset --hard &&
 	test_cache_tree
 '
-- 
2.16.2.903.gd04caf5039

