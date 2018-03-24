Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9481F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeCXHqQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:16 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38469 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbeCXHqP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:46:15 -0400
Received: by mail-lf0-f65.google.com with SMTP id u3-v6so484152lff.5
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gxcBTlcn/QsPbp4LrYSDp+SMqCOPuX+5fFc7NZYlGPE=;
        b=c/Cam4JEvF4MHTLgSmvNy+phbii9WlYXv4HcupDrBtlSNBRILMWQ/D8YPqxR21ZACD
         e6jclKMrrP+B8BzvYivT6SkeunVsdjx9LoBC5VFXBtYm86A0Nco1OESN2BxlzWRtuVok
         uA8YYBxWUmO+TPN1NvrLZdQG8Bj471tPT7JzeCfmVXFhBcrJs4289YZvWAHCpLX58XUM
         1tMQr0fQXT6ZgEV1UStZX1aR06gi62KWADz2vU8/Cypn0DyPTIhQh0Y3umwZesH2gDdO
         DrkVxSFTbkvVaFh/3LHCdwL/JimXLq8BhM67kArkPVL1U0ABTu8Wx8JXo8mEuy79/sBL
         CqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gxcBTlcn/QsPbp4LrYSDp+SMqCOPuX+5fFc7NZYlGPE=;
        b=gPpG1FEEgjF7hNFh1Lr330PUsaAq6I2/qWQhd7XyXrMrqDCCIMT6nmONp/MDDXASig
         ATYfbV5cfRbKL+mZQB+H0lKzK6Go2x3F144hXvzVMIMsX8pL6iXH5shHgGtitYnyjyYS
         NmzSG6aqav76W6gmysAtUJcOCFiOzEQSmL8qwuOlAdNI0ibyHyJXm1cpV8YxTqdqWTH7
         g1htQYawTkpyRzVxGtBQUJomG2MWNTg9pwQhgpf6Ea7YlWhnGosncsQlI3IwL8dqdQv+
         0eDksGITK49PLDvE7WKbFQeZGvm6EBMG481xaiC4Fi+Jid8bI12oZ2kc34wAeWzsmhx7
         aosQ==
X-Gm-Message-State: AElRT7HM+mtadrTiuV3XJfutM4wOzLZDfY6+T564X+kKT7LMagSaHZEc
        cn6VhZZm3RdjKj7LcOBqpNQ=
X-Google-Smtp-Source: AG47ELvmUj11MaBuCcdz27boLgwgdlIgO3tCNigK01/H/Ahy0aR/SDKNMkYTeP+FwiGl6b08wvcnVg==
X-Received: by 2002:a19:1449:: with SMTP id k70-v6mr22827417lfi.23.1521877572601;
        Sat, 24 Mar 2018 00:46:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:46:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 32/36] t/helper: merge test-submodule-config into test-tool
Date:   Sat, 24 Mar 2018 08:45:01 +0100
Message-Id: <20180324074505.19100-33-pclouds@gmail.com>
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
 Makefile                         |  2 +-
 t/helper/test-submodule-config.c |  3 ++-
 t/helper/test-tool.c             |  1 +
 t/helper/test-tool.h             |  1 +
 t/t7411-submodule-config.sh      | 18 +++++++++---------
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 6819792c2b..c1dc9ff8d6 100644
--- a/Makefile
+++ b/Makefile
@@ -682,6 +682,7 @@ TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sigchain.o
 TEST_BUILTINS_OBJS += test-strcmp-offset.o
 TEST_BUILTINS_OBJS += test-string-list.o
+TEST_BUILTINS_OBJS += test-submodule-config.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
@@ -689,7 +690,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-submodule-config
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-tool
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index f23db3b19a..5c6e4b010d 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "config.h"
 #include "submodule-config.h"
@@ -10,7 +11,7 @@ static void die_usage(int argc, const char **argv, const char *msg)
 	exit(1);
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd__submodule_config(int argc, const char **argv)
 {
 	const char **arg = argv;
 	int my_argc = argc;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 90008533cd..434fedc8d8 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -37,6 +37,7 @@ static struct test_cmd cmds[] = {
 	{ "sigchain", cmd__sigchain },
 	{ "strcmp-offset", cmd__strcmp_offset },
 	{ "string-list", cmd__string_list },
+	{ "submodule-config", cmd__submodule_config },
 };
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 19ad2b0df8..be7e79738f 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -31,5 +31,6 @@ int cmd__sha1(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
 int cmd__strcmp_offset(int argc, const char **argv);
 int cmd__string_list(int argc, const char **argv);
+int cmd__submodule_config(int argc, const char **argv);
 
 #endif
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 46c09c7765..0bde5850ac 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -41,7 +41,7 @@ test_expect_success 'configuration parsing with error' '
 	EOF
 	(
 		cd repo &&
-		test_must_fail test-submodule-config "" s 2>actual &&
+		test_must_fail test-tool submodule-config "" s 2>actual &&
 		test_i18ngrep "bad config" actual
 	)
 '
@@ -55,7 +55,7 @@ EOF
 
 test_expect_success 'test parsing and lookup of submodule config by path' '
 	(cd super &&
-		test-submodule-config \
+		test-tool submodule-config \
 			HEAD^ a \
 			HEAD b \
 			HEAD^ submodule \
@@ -67,7 +67,7 @@ test_expect_success 'test parsing and lookup of submodule config by path' '
 
 test_expect_success 'test parsing and lookup of submodule config by name' '
 	(cd super &&
-		test-submodule-config --name \
+		test-tool submodule-config --name \
 			HEAD^ a \
 			HEAD a \
 			HEAD^ submodule \
@@ -89,7 +89,7 @@ test_expect_success 'error in one submodule config lets continue' '
 		git add .gitmodules &&
 		mv .gitmodules.bak .gitmodules &&
 		git commit -m "add error" &&
-		test-submodule-config \
+		test-tool submodule-config \
 			HEAD b \
 			HEAD submodule \
 				>actual &&
@@ -100,7 +100,7 @@ test_expect_success 'error in one submodule config lets continue' '
 test_expect_success 'error message contains blob reference' '
 	(cd super &&
 		sha1=$(git rev-parse HEAD) &&
-		test-submodule-config \
+		test-tool submodule-config \
 			HEAD b \
 			HEAD submodule \
 				2>actual_err &&
@@ -114,9 +114,9 @@ test_expect_success 'using different treeishs works' '
 		git tag new_tag &&
 		tree=$(git rev-parse HEAD^{tree}) &&
 		commit=$(git rev-parse HEAD^{commit}) &&
-		test-submodule-config $commit b >expect &&
-		test-submodule-config $tree b >actual.1 &&
-		test-submodule-config new_tag b >actual.2 &&
+		test-tool submodule-config $commit b >expect &&
+		test-tool submodule-config $tree b >actual.1 &&
+		test-tool submodule-config new_tag b >actual.2 &&
 		test_cmp expect actual.1 &&
 		test_cmp expect actual.2
 	)
@@ -130,7 +130,7 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
 		git config --unset -f .gitmodules \
 			submodule.submodule.fetchrecursesubmodules &&
 		git commit -m "add error in fetchrecursesubmodules" &&
-		test-submodule-config \
+		test-tool submodule-config \
 			HEAD b \
 			HEAD submodule \
 				>actual &&
-- 
2.17.0.rc0.348.gd5a49e0b6f

