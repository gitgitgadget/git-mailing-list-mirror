Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24F241F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeCQH4L (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:56:11 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32966 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752467AbeCQH4J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:56:09 -0400
Received: by mail-lf0-f67.google.com with SMTP id x205-v6so18550479lfa.0
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aaYTl5+Tq/v9Lmd1h+sIYXIpyZBsdwSW1Kd5gM6wSx4=;
        b=JW5w+r/Lhf3e6wZWW8tHeLWpDExSa66yHVMuXQLljpVfNcwol3yAAnyE8x2Z2KhFt/
         0P1p3VdHun9NHYosYad+VRD91W8nQFphvxSqau3NEdVhqJF7fmTNkOpHQFcM70go3mkr
         XmivLjo3mV2Iafq+00ieSX5dN+MFE0FjX/jtMUSc9IOwVPKaPfL1M4sI2a2p/MM9tUmo
         g/syi7P5xB5SrPjj/lFW3o2q5nLZjFC7fTyKZRmb+3p2n2by6DlLiWQv15eZ/+kG1tMz
         MBKKD8WV3py7C2zZ6jVDsLPmxs9pGmepMIKdGPEQpJPP7xuka9tUDUbXkiroHm/mpT3H
         4AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aaYTl5+Tq/v9Lmd1h+sIYXIpyZBsdwSW1Kd5gM6wSx4=;
        b=bzzrjyfBMR6rqoN6bXmv+DR9Fl2s/OBLMNMeXNkTFVDI6V+dF+SY7NDdjY194EsZPH
         529Irhdjz1SBwvMKw0UeO7DnQXXKm/FP4XmvtWmub+cB7U8OgtpXu/gLTOFHWD+53dMW
         yQ3H2oU6+Q4+19ADdtrybWKAo6VyqxzMCO0ikEULVORtbQhEqegMYxxAGO+13b+XJEJr
         iBKX9dhAWPY4gsICJeSpyzGZ2fd8sSbYvOKd6FU5wrWxpxQB+wEAY9HZF2jaKf0Irqy4
         phEdOLVwuYNezGBbr/9xrsXTe7GU4SP36GUnjrshv30VQWoO+tb53nOxA5Gz2UyjsIV2
         kLNw==
X-Gm-Message-State: AElRT7FXGmIu6V1TseEv/gu5P+hfcseSYhNSSOwWZQ9g6tTqYvG5TY5P
        cjVzeK5M9g6nWfy6F1ipjKLQuA==
X-Google-Smtp-Source: AG47ELuSnQZVDLzh0DDraYcv+YFLBsDx+3XH2SCwuj4QouB3zo7tYz1bkdvbBSeNP47ozz0CHB52yw==
X-Received: by 10.46.137.203 with SMTP id c11mr3346526ljk.61.1521273367256;
        Sat, 17 Mar 2018 00:56:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:56:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 33/36] t/helper: merge test-subprocess into test-tool
Date:   Sat, 17 Mar 2018 08:54:18 +0100
Message-Id: <20180317075421.22032-34-pclouds@gmail.com>
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
 t/helper/test-subprocess.c | 3 ++-
 t/helper/test-tool.c       | 1 +
 t/helper/test-tool.h       | 1 +
 t/t1501-work-tree.sh       | 2 +-
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index c1dc9ff8d6..893ea64ca2 100644
--- a/Makefile
+++ b/Makefile
@@ -683,6 +683,7 @@ TEST_BUILTINS_OBJS += test-sigchain.o
 TEST_BUILTINS_OBJS += test-strcmp-offset.o
 TEST_BUILTINS_OBJS += test-string-list.o
 TEST_BUILTINS_OBJS += test-submodule-config.o
+TEST_BUILTINS_OBJS += test-subprocess.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
@@ -690,7 +691,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-tool
 TEST_PROGRAMS_NEED_X += test-urlmatch-normalization
diff --git a/t/helper/test-subprocess.c b/t/helper/test-subprocess.c
index 30c5765bfc..2699257663 100644
--- a/t/helper/test-subprocess.c
+++ b/t/helper/test-subprocess.c
@@ -1,7 +1,8 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "run-command.h"
 
-int cmd_main(int argc, const char **argv)
+int test_subprocess(int argc, const char **argv)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int nogit = 0;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 1b95f1b30b..49f4d6f901 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -38,6 +38,7 @@ static struct test_cmd cmds[] = {
 	{ "strcmp-offset", test_strcmp_offset },
 	{ "string-list", test_string_list },
 	{ "submodule-config", test_submodule_config },
+	{ "subprocess", test_subprocess },
 };
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 16a05993e5..eaf15cbd84 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -32,5 +32,6 @@ int test_sigchain(int argc, const char **argv);
 int test_strcmp_offset(int argc, const char **argv);
 int test_string_list(int argc, const char **argv);
 int test_submodule_config(int argc, const char **argv);
+int test_subprocess(int argc, const char **argv);
 
 #endif
diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
index b07cb9140e..02cf2013fc 100755
--- a/t/t1501-work-tree.sh
+++ b/t/t1501-work-tree.sh
@@ -341,7 +341,7 @@ test_expect_success 'make_relative_path handles double slashes in GIT_DIR' '
 
 test_expect_success 'relative $GIT_WORK_TREE and git subprocesses' '
 	GIT_DIR=repo.git GIT_WORK_TREE=repo.git/work \
-	test-subprocess --setup-work-tree rev-parse --show-toplevel >actual &&
+	test-tool subprocess --setup-work-tree rev-parse --show-toplevel >actual &&
 	echo "$(pwd)/repo.git/work" >expected &&
 	test_cmp expected actual
 '
-- 
2.16.2.903.gd04caf5039

