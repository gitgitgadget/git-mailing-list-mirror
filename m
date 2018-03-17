Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C964F1F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeCQH4w (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:56:52 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45771 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752400AbeCQHz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:58 -0400
Received: by mail-lf0-f67.google.com with SMTP id h127-v6so18487014lfg.12
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aXT3bytTbpr54Lo80kFMo6/lJnY7kqeNu/lhP7afoQ0=;
        b=G2gP6H0TcCHgPnA8c/sBSDmxj15K15cVUKLwM2sDLB4s52FkD+swWhKWZruVqJdJE8
         7UFYXbzCYp4ji/g9eq0iAwZoEMhj2/Ivm0v4eKsOUN7Du11TSdWfxC2DGRSZ1EcL1sQS
         9GceXzGUjHMLbJba34RIYE+A5DUz13BJNum2xHmCYtNmwYh85Duw256Cz1ffShjDHj6Z
         P/tRWU+uQ1odwmaiZG28Z9p2lrOTpwsa2OUtjhxAuRE0viKFJ0S0BkhfBfdhEEb5fccZ
         zkSt11SGbYEuuM5jz8EDEwa3Zt6I76Q3oJ5oWtTLdV6D5X99seIUS71+UYBrtwhFG9Ny
         jQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aXT3bytTbpr54Lo80kFMo6/lJnY7kqeNu/lhP7afoQ0=;
        b=s94EIweB1/gLexB9+nCDwUaRdz+kXZXS8G886KooOsvBvpRkmaZ5rlEYIorJC1IyXF
         twC+ifO6FzdC3SFJtajNLsENgHNSbiqOHH5gdfwZIifKIaWv6WrPkIk9QQ2T9y3bW/0L
         cItiD1pQntW0kxtw28FDn6SzMLXJCKUcAmLM/rhLverMB3ZpZ52m8RcFmX+TReZySWW4
         XM0Dax3/8510EP/CeF3RXerxT8L8qE2ZNFIXXVhocYjqvMQeGJo/aFlZfKW9chm7GgDa
         FH+z/oEmpsZMPeSdaE49qtydI0c0YBg1yWuMxzJFX/yedcrU5NYIDkdOobTya8ia/p5m
         eQkg==
X-Gm-Message-State: AElRT7GHs4OLnroEBuIkut5Ac7KeSPj0ixtk2Y6N376DXNA3WijRHK7N
        P/MIS5Fm3QeSUjIXnnxnekRZNw==
X-Google-Smtp-Source: AG47ELudYqFQRdRiyz2t5t3CCBOWDxD25BuRbNqGQTd7dPZF8PB+1MmJnF+TLs6ULKWfrOBXiQe63Q==
X-Received: by 10.46.44.6 with SMTP id s6mr3347209ljs.111.1521273356737;
        Sat, 17 Mar 2018 00:55:56 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 23/36] t/helper: merge test-ref-store into test-tool
Date:   Sat, 17 Mar 2018 08:54:08 +0100
Message-Id: <20180317075421.22032-24-pclouds@gmail.com>
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
 Makefile                       | 2 +-
 t/helper/test-ref-store.c      | 3 ++-
 t/helper/test-tool.c           | 1 +
 t/helper/test-tool.h           | 1 +
 t/t1405-main-ref-store.sh      | 2 +-
 t/t1406-submodule-ref-store.sh | 2 +-
 t/t1407-worktree-ref-store.sh  | 4 ++--
 7 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 393fb9aca4..20080fddb8 100644
--- a/Makefile
+++ b/Makefile
@@ -672,6 +672,7 @@ TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-read-cache.o
+TEST_BUILTINS_OBJS += test-ref-store.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
@@ -680,7 +681,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-ref-store
 TEST_PROGRAMS_NEED_X += test-regex
 TEST_PROGRAMS_NEED_X += test-revision-walking
 TEST_PROGRAMS_NEED_X += test-run-command
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 7120634b04..a797bc532b 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "refs.h"
 #include "worktree.h"
@@ -274,7 +275,7 @@ static struct command commands[] = {
 	{ NULL, NULL }
 };
 
-int cmd_main(int argc, const char **argv)
+int test_ref_store(int argc, const char **argv)
 {
 	struct ref_store *refs;
 	const char *func;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index d82db3c90f..92bd38ac61 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -27,6 +27,7 @@ static struct test_cmd cmds[] = {
 	{ "path-utils", test_path_utils },
 	{ "prio-queue", test_prio_queue },
 	{ "read-cache", test_read_cache },
+	{ "ref-store", test_ref_store },
 	{ "sha1", test_sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 2c98cdde41..662d3c9645 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -21,6 +21,7 @@ int test_online_cpus(int argc, const char **argv);
 int test_path_utils(int argc, const char **argv);
 int test_prio_queue(int argc, const char **argv);
 int test_read_cache(int argc, const char **argv);
+int test_ref_store(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index e8115df5ba..a30a080b20 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -4,7 +4,7 @@ test_description='test main ref store api'
 
 . ./test-lib.sh
 
-RUN="test-ref-store main"
+RUN="test-tool ref-store main"
 
 test_expect_success 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
 	test_commit one &&
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index c32d4cc465..e093782cc3 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -4,7 +4,7 @@ test_description='test submodule ref store api'
 
 . ./test-lib.sh
 
-RUN="test-ref-store submodule:sub"
+RUN="test-tool ref-store submodule:sub"
 
 test_expect_success 'setup' '
 	git init sub &&
diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index 8842d0329f..2211f9831f 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -4,8 +4,8 @@ test_description='test worktree ref store api'
 
 . ./test-lib.sh
 
-RWT="test-ref-store worktree:wt"
-RMAIN="test-ref-store worktree:main"
+RWT="test-tool ref-store worktree:wt"
+RMAIN="test-tool ref-store worktree:main"
 
 test_expect_success 'setup' '
 	test_commit first &&
-- 
2.16.2.903.gd04caf5039

