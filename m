Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DE01F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeCQH4q (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:56:46 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43118 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeCQHz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:59 -0400
Received: by mail-lf0-f66.google.com with SMTP id g13-v6so7548752lfe.10
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6KqsqITTaThOB5OeVFoRjArpN2/GiyfVBYkKMXjJC6U=;
        b=mCpDcTFx9zJWGGuFA2bU9yGYpxSsnTDt3kI9HQ63TFuAjfhNYwyM4H2ZLrzqxCOvTw
         htHlCvrVgatcRMXoMVnloS+ZelVPmAUMvXAamaLhApY51Zso5Ucgm2hz+FuZidlcAUpx
         E4MUcR/tWmyhxffKjPumITQrI9dvVLqOgxbsM6d8Uue0PGRp+0gaE88uLPMzFBIM+6lW
         sBq352TO8zlTDJ8o8r00zhqoo1gQLLNlu3gRaVaAVJqEJXCnLONJ+Ai9oQjg4uycUJnJ
         bS2561M7us5MiqUcXhbYy9v6yJjPe0jBMv3/L32iwDb6ghCcFJ77YPMFO8T09GeW216b
         EE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6KqsqITTaThOB5OeVFoRjArpN2/GiyfVBYkKMXjJC6U=;
        b=l0S6sWOv+3bE9+y6THrINyR0xkQFKTubghQwUXMvE9lxXWqZEw3U0Wo91y9wCBV3+T
         RJNBmTs6l71XjmDlusYNGmkDgo6jKgWLZQQ4dq7nuCWnleN2t5P/zF7IqujebF5xnyaD
         v18TQB2T+QjUisptf8CoYb5YWzwSCoyFgLMlCbCso2eP9xpkgnL/pOiKYR9whXt24esl
         5E1wJPWXT797Pycdl8FDvXpzZxESfouIZ43QjXLw3GK/GmySx7GbO0FFj5XMoCCjs9OA
         reZlKZlPTTxzMc/xnaC7pGnRUXCp1pb9VtvcYqXyInE+RPJioroCSC+mpZNVNgeib0gY
         H69A==
X-Gm-Message-State: AElRT7EpQ1T0/yJ9fgU4EY97SK3t+8hOqz6syzZaTdhjxWkpOCDdNUzJ
        cMNtuc8WK528FRiLukqIOMiy/w==
X-Google-Smtp-Source: AG47ELsuI1UqJb2TguTeyB1myyn8jP54XMUsGEaHe531lSAL1d8k6cauC57JG6SG0DW0bL0GSAMKww==
X-Received: by 10.46.45.18 with SMTP id t18mr3372648ljt.48.1521273357595;
        Sat, 17 Mar 2018 00:55:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:57 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 24/36] t/helper: merge test-regex into test-tool
Date:   Sat, 17 Mar 2018 08:54:09 +0100
Message-Id: <20180317075421.22032-25-pclouds@gmail.com>
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
 Makefile                        | 2 +-
 t/helper/test-regex.c           | 7 ++++---
 t/helper/test-tool.c            | 1 +
 t/helper/test-tool.h            | 1 +
 t/t0070-fundamental.sh          | 2 +-
 t/t7812-grep-icase-non-ascii.sh | 2 +-
 6 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 20080fddb8..7444c00bbb 100644
--- a/Makefile
+++ b/Makefile
@@ -673,6 +673,7 @@ TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-ref-store.o
+TEST_BUILTINS_OBJS += test-regex.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
@@ -681,7 +682,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-regex
 TEST_PROGRAMS_NEED_X += test-revision-walking
 TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
index b5ea8a97c5..99d1c8edae 100644
--- a/t/helper/test-regex.c
+++ b/t/helper/test-regex.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "git-compat-util.h"
 #include "gettext.h"
 
@@ -36,7 +37,7 @@ static int test_regex_bug(void)
 	return 0;
 }
 
-int cmd_main(int argc, const char **argv)
+int test_regex(int argc, const char **argv)
 {
 	const char *pat;
 	const char *str;
@@ -47,8 +48,8 @@ int cmd_main(int argc, const char **argv)
 	if (argc == 2 && !strcmp(argv[1], "--bug"))
 		return test_regex_bug();
 	else if (argc < 3)
-		usage("test-regex --bug\n"
-		      "test-regex <pattern> <string> [<options>]");
+		usage("test-tool regex --bug\n"
+		      "test-tool regex <pattern> <string> [<options>]");
 
 	argv++;
 	pat = *argv++;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 92bd38ac61..7352bd40e8 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -28,6 +28,7 @@ static struct test_cmd cmds[] = {
 	{ "prio-queue", test_prio_queue },
 	{ "read-cache", test_read_cache },
 	{ "ref-store", test_ref_store },
+	{ "regex", test_regex },
 	{ "sha1", test_sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 662d3c9645..3cb2fd9509 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -22,6 +22,7 @@ int test_path_utils(int argc, const char **argv);
 int test_prio_queue(int argc, const char **argv);
 int test_read_cache(int argc, const char **argv);
 int test_ref_store(int argc, const char **argv);
+int test_regex(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index ac007938ee..23fbe6434a 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -31,7 +31,7 @@ test_expect_success 'git_mkstemps_mode does not fail if fd 0 is not open' '
 
 test_expect_success 'check for a bug in the regex routines' '
 	# if this test fails, re-build git with NO_REGEX=1
-	test-regex --bug
+	test-tool regex --bug
 '
 
 test_done
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 0059a1f837..0c685d3598 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -12,7 +12,7 @@ test_expect_success GETTEXT_LOCALE 'setup' '
 '
 
 test_have_prereq GETTEXT_LOCALE &&
-test-regex "HALLÓ" "Halló" ICASE &&
+test-tool regex "HALLÓ" "Halló" ICASE &&
 test_set_prereq REGEX_LOCALE
 
 test_expect_success REGEX_LOCALE 'grep literal string, no -F' '
-- 
2.16.2.903.gd04caf5039

