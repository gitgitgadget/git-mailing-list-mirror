Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3EF21F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeCXHqL (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:11 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40570 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeCXHqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:46:09 -0400
Received: by mail-lf0-f68.google.com with SMTP id e5-v6so21420724lfb.7
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQsjj8x62ohyVxtgFHPPte2v+XnD4OQxPEHfAys/iaA=;
        b=qyj0va6yULrPGGPP/M3R48B1zqpmePP2ueasiuXT0H87tWLxvmZs6Hd+MMqHOz2X3D
         GrDPl8fPD+Wu2QyxC5a/0Cfnr1jotVIk844IPr72aMlh2tgOta4wM2cdWca2hmRZZJ/8
         Jh8V2YzKkLubot2C13QaRm5BHPAH89bUqWUBnWhbiC5Hh7qsGpzZsW9Kk3WlIGxHMSgH
         CRUuu0ItwHrwJmJQEubxmyMicuOksWzANHPF1lIMs4JztZDcq4QdZAlyELnDJd60L/9F
         Z5ged382rBvDiCCHGJdmfP2HuRCf16syP4Rk+9zhq1e6RcmLSk9omba2W8dm3JyQVzGP
         r5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQsjj8x62ohyVxtgFHPPte2v+XnD4OQxPEHfAys/iaA=;
        b=l/gv1SupESbJNm11FGMUeNeYNAaEcVWwVjBAfJxiWgkeTOiM0SkXnLBkf8iz7NCcEN
         FMm3z9X9q9OlWL6e3X5AsiopWnmo9t8lQqFCoi8aVMxf1HUrb2+2bFtDThAGO5vDzymz
         xVJbcXW4InEQ1vvE7JVo8YHWYKbmotNPcNtZd+1832aHafaQYBkoacBk+qYM2b+3M5Gp
         HZU76Ag2QNcKlKCDnqUQBhbvjhFnlgb+ZVUqixLl+erLA26wc8v4+7AZ5v0szvMlpsgE
         nFDMF7BOQJzHsJPo02ylnQFArXOcyA7Ynydn7Xahz5sOOPJ5+k96mn/aXOShkmMSlz9Z
         kmnA==
X-Gm-Message-State: AElRT7GBN+n8bMcUpUr8qRljq6mQlRG0EXOLsOX+m1WS0UFCkfDs+Cz4
        Ska8JJQ6/S5sRGYOh2lxD68=
X-Google-Smtp-Source: AG47ELsk4yUDo6FJLMjtEQhmT8xRfOhpF9m+l4m7bZjYhVLF1JoNmBbrVwn6A6oeCeIMj8gdylpN/w==
X-Received: by 10.46.152.88 with SMTP id e24mr6192096ljj.7.1521877568156;
        Sat, 24 Mar 2018 00:46:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.46.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:46:07 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 29/36] t/helper: merge test-sigchain into test-tool
Date:   Sat, 24 Mar 2018 08:44:58 +0100
Message-Id: <20180324074505.19100-30-pclouds@gmail.com>
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
 Makefile                 | 2 +-
 t/helper/test-sigchain.c | 3 ++-
 t/helper/test-tool.c     | 1 +
 t/helper/test-tool.h     | 1 +
 t/t0005-signals.sh       | 4 ++--
 5 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index b50a0818a9..51de8882d0 100644
--- a/Makefile
+++ b/Makefile
@@ -679,6 +679,7 @@ TEST_BUILTINS_OBJS += test-run-command.o
 TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
 TEST_BUILTINS_OBJS += test-sha1-array.o
 TEST_BUILTINS_OBJS += test-sha1.o
+TEST_BUILTINS_OBJS += test-sigchain.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
@@ -686,7 +687,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-strcmp-offset
 TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-submodule-config
diff --git a/t/helper/test-sigchain.c b/t/helper/test-sigchain.c
index b71edbd442..77ac5bc33f 100644
--- a/t/helper/test-sigchain.c
+++ b/t/helper/test-sigchain.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "sigchain.h"
 
@@ -13,7 +14,7 @@ X(two)
 X(three)
 #undef X
 
-int cmd_main(int argc, const char **argv) {
+int cmd__sigchain(int argc, const char **argv) {
 	sigchain_push(SIGTERM, one);
 	sigchain_push(SIGTERM, two);
 	sigchain_push(SIGTERM, three);
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 27f7b6ff75..c1de1a3397 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -34,6 +34,7 @@ static struct test_cmd cmds[] = {
 	{ "scrap-cache-tree", cmd__scrap_cache_tree },
 	{ "sha1-array", cmd__sha1_array },
 	{ "sha1", cmd__sha1 },
+	{ "sigchain", cmd__sigchain },
 };
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index d8066e3f63..1d366846f3 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -28,5 +28,6 @@ int cmd__run_command(int argc, const char **argv);
 int cmd__scrap_cache_tree(int argc, const char **argv);
 int cmd__sha1_array(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
+int cmd__sigchain(int argc, const char **argv);
 
 #endif
diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index c16947cf5d..4c214bd11c 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -10,7 +10,7 @@ one
 EOF
 
 test_expect_success 'sigchain works' '
-	{ test-sigchain >actual; ret=$?; } &&
+	{ test-tool sigchain >actual; ret=$?; } &&
 	{
 		# Signal death by raise() on Windows acts like exit(3),
 		# regardless of the signal number. So we must allow that
@@ -24,7 +24,7 @@ test_expect_success 'sigchain works' '
 test_expect_success !MINGW 'signals are propagated using shell convention' '
 	# we use exec here to avoid any sub-shell interpretation
 	# of the exit code
-	git config alias.sigterm "!exec test-sigchain" &&
+	git config alias.sigterm "!exec test-tool sigchain" &&
 	test_expect_code 143 git sigterm
 '
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

