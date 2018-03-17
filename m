Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D5C71F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeCQH4a (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:56:30 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36252 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbeCQH4F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:56:05 -0400
Received: by mail-lf0-f68.google.com with SMTP id z143-v6so12272527lff.3
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=efsauZutHqeErKmjNzjvG8s16JrXYOYw7uXm6GmwCYo=;
        b=fE3RFsUzh+Vo31PQcJbML13PdUR1GsPvR46aZhIY8qRT4jW8tAHVkzVzR/PpLEajjl
         IWQ7TzoS9RaeMNFkI1sWc4iy3UzIQSexUkjcBRpy6fxkTGtmDvS7rsecF4j5t5qkLcUQ
         feFflir/+ABxrtpXQrszpg4SSCjY4fpNE5Z1OHwAb0JcVJe8Mp8bHU/FG10dPjyynx4M
         IoPGVGW8LUgPyEJHfmUL9KmMtlxoMpN2qbfO8gchtBYSttElBvWy3pMWyyJRm2N9We4v
         +UWkxi1/wSxSsTmh3nKTSTvneznwppHbA1DcAo/Xh2ZyFCLbD+to7YxorhMxGWq1l8Zd
         8Ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=efsauZutHqeErKmjNzjvG8s16JrXYOYw7uXm6GmwCYo=;
        b=fUwJ2x4+KT0IjuHtcpu1ea4cna4isvChkb4lOjp4m+j8FPH7fQqGfYB6en2fwwlJ5I
         VAtn9fvGYy9GErV/+7CeIGrcfm+eVbySGJsM/gAbkGfe/r+tHj5xGNTDduYqmqDMNX+4
         3toKdAHagtuHsfGcBiBh7M6LYRMPnYNIgCIcS9IjZcK9WopG4aOJ1bpXT1P2BzPoPPHH
         zOaQ1jJh/Cdy3A6506DWxavX2j7jKLWafdFr8PfCMqeuMnE8mtG4NnVkSeYfBueDDU7g
         ADYFemTHPcNcV/12VxsAGAKqFORAGtPkdXVfQn3/5DRU8k16OgEGQoHnlEPd3xL7+xlj
         Vu8w==
X-Gm-Message-State: AElRT7E5z6H10cOykx1Z/tkfk2AFhP22SG6WC99RbzWVnxvRaZgpbh1H
        qheFAZNsqT1vtuU5hnA7tfJvDw==
X-Google-Smtp-Source: AG47ELvasLVkfmHitUQns2lmZDxcwV22bIOen0EtmdBbIjMK2vIiUbRaPSIchM+geSE1uZax6FuV4A==
X-Received: by 2002:a19:4402:: with SMTP id r2-v6mr2955905lfa.105.1521273364185;
        Sat, 17 Mar 2018 00:56:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:56:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 30/36] t/helper: merge test-strcmp-offset into test-tool
Date:   Sat, 17 Mar 2018 08:54:15 +0100
Message-Id: <20180317075421.22032-31-pclouds@gmail.com>
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
 Makefile                      | 2 +-
 t/helper/test-strcmp-offset.c | 3 ++-
 t/helper/test-tool.c          | 1 +
 t/helper/test-tool.h          | 1 +
 t/t0065-strcmp-offset.sh      | 2 +-
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 51de8882d0..528a80b6a6 100644
--- a/Makefile
+++ b/Makefile
@@ -680,6 +680,7 @@ TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
 TEST_BUILTINS_OBJS += test-sha1-array.o
 TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sigchain.o
+TEST_BUILTINS_OBJS += test-strcmp-offset.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
@@ -687,7 +688,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-strcmp-offset
 TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-submodule-config
 TEST_PROGRAMS_NEED_X += test-subprocess
diff --git a/t/helper/test-strcmp-offset.c b/t/helper/test-strcmp-offset.c
index e159c9a127..3f80833542 100644
--- a/t/helper/test-strcmp-offset.c
+++ b/t/helper/test-strcmp-offset.c
@@ -1,6 +1,7 @@
+#include "test-tool.h"
 #include "cache.h"
 
-int cmd_main(int argc, const char **argv)
+int test_strcmp_offset(int argc, const char **argv)
 {
 	int result;
 	size_t offset;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 99db507a24..7e684960e0 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -35,6 +35,7 @@ static struct test_cmd cmds[] = {
 	{ "sha1-array", test_sha1_array },
 	{ "sha1", test_sha1 },
 	{ "sigchain", test_sigchain },
+	{ "strcmp-offset", test_strcmp_offset },
 };
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 4c71df8c79..42ebb67af6 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -29,5 +29,6 @@ int test_scrap_cache_tree(int argc, const char **argv);
 int test_sha1_array(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 int test_sigchain(int argc, const char **argv);
+int test_strcmp_offset(int argc, const char **argv);
 
 #endif
diff --git a/t/t0065-strcmp-offset.sh b/t/t0065-strcmp-offset.sh
index 7d6d21425f..91fa639c4a 100755
--- a/t/t0065-strcmp-offset.sh
+++ b/t/t0065-strcmp-offset.sh
@@ -8,7 +8,7 @@ while read s1 s2 expect
 do
 	test_expect_success "strcmp_offset($s1, $s2)" '
 		echo "$expect" >expect &&
-		test-strcmp-offset "$s1" "$s2" >actual &&
+		test-tool strcmp-offset "$s1" "$s2" >actual &&
 		test_cmp expect actual
 	'
 done <<-EOF
-- 
2.16.2.903.gd04caf5039

