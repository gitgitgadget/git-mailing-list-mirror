Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5E11F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeCXHqA (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:00 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44546 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCXHpw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:52 -0400
Received: by mail-lf0-f67.google.com with SMTP id g203-v6so21365974lfg.11
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=29CyhTJqZTkwgGrqzJYbHOCyIDleKWRVGA+qMTiivcM=;
        b=jmaO2LAVRmlFjS+mW3g0OFPlYcGVzXfZTYpsLjp7QBbOJdiQIZsvs7EwWNGXnEool+
         A4V157tt3TpXt9gi9+jsjHePi/gamcnZUnO1WaGGmEfJlyqd/2gU0uRwh3sWVWcsx8A6
         O8ibtK8zuqeMZ+8o05ZTo9eEc4XQg0a+x7xThwh46cckFGWWxR1Y4wQionqHtjhfeR1z
         QAy7SmVskI8jSRK8ZSjYdGArWHCj2tFvVfz7juIkwId41apOuaBvPLGJ3/2qlUhzyu2c
         0ezA3OfzjrarsS5wIyKM26v6dOPaVr5oeviIDENoljNBJiL2AvsNjFGmqjDZOSJWhflG
         6xUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=29CyhTJqZTkwgGrqzJYbHOCyIDleKWRVGA+qMTiivcM=;
        b=XL8BRfhKJN0XOv8yQJ0fzk/KaFBXI7MLJXSz6js4p/LI2k/ZdpSAPbI/MpJeoPFNgU
         e69zsdIA5mBnUjBIrpE5fpT5KwyGEvrZkKxMLk5DVFK/z9LT6ALIH+aCF/GMNATE1OIX
         +Q6+Sp6PEhKVztfQPHUmny/NQjIHF68mwY7WUAgkzx3/Ii3Dw1ptjg/Z4PtiBt1GkATk
         twp2chrGaKA7Iyuk9t5OSSAcqgE+j6GxMC0wTXTHQT5P5M8v4TeKklRfgx6MIRB0aA08
         A++eD0gQ59N8aCkXSMcvZH6ViYKA1hJVxQtNAX384pVIxURIvpBpEU9XkTJqEXGANSi5
         h89w==
X-Gm-Message-State: AElRT7HWFks2WP3wf0hp9d1KRfaKMJg0efwsBIhTOTrlB7PsmIX4uOZ8
        pM8WbJngioc8dzqICa/XaNc=
X-Google-Smtp-Source: AG47ELuh5q90bY/T7APumPBxBoxbv1Dhktf7O1N1wSBsJGfkB5TQ5eQufWZlVwvXzuc3BizYhyWlbQ==
X-Received: by 2002:a19:eb0b:: with SMTP id j11-v6mr22460832lfh.120.1521877551045;
        Sat, 24 Mar 2018 00:45:51 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:50 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 17/36] t/helper: merge (unused) test-mergesort into test-tool
Date:   Sat, 24 Mar 2018 08:44:46 +0100
Message-Id: <20180324074505.19100-18-pclouds@gmail.com>
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
 Makefile                  | 2 +-
 t/helper/test-mergesort.c | 3 ++-
 t/helper/test-tool.c      | 1 +
 t/helper/test-tool.h      | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 6552a8f4ed..67f37b849e 100644
--- a/Makefile
+++ b/Makefile
@@ -666,13 +666,13 @@ TEST_BUILTINS_OBJS += test-hashmap.o
 TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
+TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
-TEST_PROGRAMS_NEED_X += test-mergesort
 TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-online-cpus
 TEST_PROGRAMS_NEED_X += test-parse-options
diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 335cf6b626..c5cffaa4b7 100644
--- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "mergesort.h"
 
@@ -22,7 +23,7 @@ static int compare_strings(const void *a, const void *b)
 	return strcmp(x->text, y->text);
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd__mergesort(int argc, const char **argv)
 {
 	struct line *line, *p = NULL, *lines = NULL;
 	struct strbuf sb = STRBUF_INIT;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 3653646f3a..7ec0e8efe5 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -21,6 +21,7 @@ static struct test_cmd cmds[] = {
 	{ "index-version", cmd__index_version },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "match-trees", cmd__match_trees },
+	{ "mergesort", cmd__mergesort },
 	{ "sha1", cmd__sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index d2f009cb3e..6c9437ff5e 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -15,6 +15,7 @@ int cmd__hashmap(int argc, const char **argv);
 int cmd__index_version(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__match_trees(int argc, const char **argv);
+int cmd__mergesort(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
 #endif
-- 
2.17.0.rc0.348.gd5a49e0b6f

