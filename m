Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E45161F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeCQH4B (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:56:01 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35658 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbeCQHz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:57 -0400
Received: by mail-lf0-f68.google.com with SMTP id t132-v6so18526544lfe.2
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EarU2zM32ebF4OSpJOZ1ID+BBlXfS5Pk/4A3NDaJcmA=;
        b=cOt9NkWwivNAMaXJONl5mA3i+LtA3u0x40gAyw36PJf5NM8bENTFBkT5ufLR/4xi/b
         J8ut7tt6J9jnJ53W+cdDmsPYA7gMeEQVeeWhXGjQ8S8Y41Xn1RErhqnkI49wQh9Vk0ID
         GcEHBE9YmSuoy5aiaY+esBI5YFKqGg+01R4Q6NwAbmUa+D2n1wi5QofVDEitlTjtIDO/
         z2yJb7pBXclME4Md+42/I9Rc9u/1buspWzN/8gnNdWafi99wp7aS5jDobfIPlESHLqxO
         OL6wgTNRO23jZSg/KPEgnqh9RankwznFVvhn765gVpY7U7pzlKov9rZW8OgxLnJ6d+tx
         s00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EarU2zM32ebF4OSpJOZ1ID+BBlXfS5Pk/4A3NDaJcmA=;
        b=MMqgj13wxreD9O2NzNKBQgORSlhYHLqHHXh5SH6JaKb8bP3OhRWBtN29BQTgDh72r+
         i3k7DtdJEkm1C+GtptS7fzWeW98n8W/iWCqECzUANt3UMA+Wfj/H8fCdHIoW9dxWxBrx
         3Od8WB5B2GgYpNmFStLbPvTp0ZfLNmpAEfiOCTF16GjPYNBAAIN5cG7tIERRay/Lp+Ve
         Hq8Chiu1MY+DHvcV0QkhusPFpqXLCav3o4qFz1apIWWwQl84zsg+N239qkF4uEMmKw21
         GafWZ99E9F1vQZtHl/tLKfxi6MlIY/YFBinGeiIDEs7su4A0y9lG3Mfui6mZZvHn8txY
         Ga/Q==
X-Gm-Message-State: AElRT7GLPFkauIPDGOHVe+0B1+P4QviONUNoWbJlFZH7OqTzhdLiH4r9
        GLVs6adf3oFSZ1585YZIWtVnuA==
X-Google-Smtp-Source: AG47ELvjJqgBb3GF9fOlYY6wM5P/zj7SYIYa2uDkCIMQh2Nz21WC25uKVsTbAdTQ9Y0Sd5kiToVNFw==
X-Received: by 10.46.117.12 with SMTP id q12mr3379650ljc.65.1521273355859;
        Sat, 17 Mar 2018 00:55:55 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:55 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 22/36] t/helepr: merge test-read-cache into test-tool
Date:   Sat, 17 Mar 2018 08:54:07 +0100
Message-Id: <20180317075421.22032-23-pclouds@gmail.com>
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
 Makefile                   | 2 +-
 t/helper/test-read-cache.c | 3 ++-
 t/helper/test-tool.c       | 1 +
 t/helper/test-tool.h       | 1 +
 t/perf/p0002-read-cache.sh | 2 +-
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 076c778494..393fb9aca4 100644
--- a/Makefile
+++ b/Makefile
@@ -671,6 +671,7 @@ TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
+TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
@@ -678,7 +679,6 @@ TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
-TEST_PROGRAMS_NEED_X += test-read-cache
 TEST_PROGRAMS_NEED_X += test-write-cache
 TEST_PROGRAMS_NEED_X += test-ref-store
 TEST_PROGRAMS_NEED_X += test-regex
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 48255eef31..cd38f09414 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -1,6 +1,7 @@
+#include "test-tool.h"
 #include "cache.h"
 
-int cmd_main(int argc, const char **argv)
+int test_read_cache(int argc, const char **argv)
 {
 	int i, cnt = 1;
 	if (argc == 2)
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 24ce124868..d82db3c90f 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -26,6 +26,7 @@ static struct test_cmd cmds[] = {
 	{ "online-cpus", test_online_cpus },
 	{ "path-utils", test_path_utils },
 	{ "prio-queue", test_prio_queue },
+	{ "read-cache", test_read_cache },
 	{ "sha1", test_sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 713be481d5..2c98cdde41 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -20,6 +20,7 @@ int test_mktemp(int argc, const char **argv);
 int test_online_cpus(int argc, const char **argv);
 int test_path_utils(int argc, const char **argv);
 int test_prio_queue(int argc, const char **argv);
+int test_read_cache(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/perf/p0002-read-cache.sh b/t/perf/p0002-read-cache.sh
index 9180ae9343..cdd105a594 100755
--- a/t/perf/p0002-read-cache.sh
+++ b/t/perf/p0002-read-cache.sh
@@ -8,7 +8,7 @@ test_perf_default_repo
 
 count=1000
 test_perf "read_cache/discard_cache $count times" "
-	test-read-cache $count
+	test-tool read-cache $count
 "
 
 test_done
-- 
2.16.2.903.gd04caf5039

