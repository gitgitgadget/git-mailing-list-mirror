Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96CF01F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeCXHqR (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:17 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36330 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbeCXHqP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:46:15 -0400
Received: by mail-lf0-f68.google.com with SMTP id z143-v6so21408592lff.3
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8/msiUEW1f57vIFdh3pN9FiCuYXFs7VxbGRUnaQVeUU=;
        b=D62QsptfE+LzT2bBV+7oDn1XsxWjOX+xCPbma99DKb/LoSgrgQqbWyPcRFVOi4l3JQ
         mge7A0UEIN1uFnXcZmyQkudm4o/76+rIaB6OYhxizEkfQkTtXkbr8IR19Rjh6Vc0+w2t
         Rb/n+9qwTp/6Bi0Yx0uVDXUHxFeKNVvKTf7raZydez4T2+zigOdF3ljV6Tcvr3cTBNwc
         J3pH3dw+hc8BYC/7sX79FBMrcekyM5fMw9KgA98TcP8ZQw/m/WlqnGPpx9NRU0Rw02OP
         FN05gp4lXLQVRhrZoHVsHv+mXMD5eIVhPTTS2fqZataSEsAwXjXSYwQlCJIe1pNtXNIv
         zdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/msiUEW1f57vIFdh3pN9FiCuYXFs7VxbGRUnaQVeUU=;
        b=Ie/HJxZH0KBEMukTcladGw+dSS2aRALW6gEBBdHOwqexdrfULhKzPEHTFnWZinDFVQ
         yU+87bHalI1MAfm/z69m1U+Z1t9+RzEx4w2R/ZkRwOeyiDfMzVSUHimLmsCU5g2oYDfm
         kYLMajl9PvB7ycRPSINje2BzUDCH4Do0r2cQ7NNe8Xg6VuQ7R80/RIPkkqqr3sQTgpBN
         d+hzfGKMgI0bViX6+akeOb9shzwoweMfEPIckWr5plRipYT3d69ntFVFOkAT11Vblp7n
         EF2NW1fo/OufbK4IhDJcU6jvLmuB9X7p98SbOR8Wv3fqEkyhMhMKiX5RDg6y8/N2/MS+
         wmpw==
X-Gm-Message-State: AElRT7GcrAQ7MnbyfSJlCbAZVnPZJWUGHsdi5XM6O/NcsvXUgo6i5wOI
        /GrC64CgSXBc7XTjtezaWuc=
X-Google-Smtp-Source: AG47ELu3+a2cb1yoQnAMxv3V3o5rU44r5Hb4zmh5Fb8r4wjLX3dI1MAYHvwlJSndA2+SHfRUjySPIA==
X-Received: by 2002:a19:7b12:: with SMTP id w18-v6mr22307268lfc.104.1521877573622;
        Sat, 24 Mar 2018 00:46:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:46:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 33/36] t/helper: merge test-subprocess into test-tool
Date:   Sat, 24 Mar 2018 08:45:02 +0100
Message-Id: <20180324074505.19100-34-pclouds@gmail.com>
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
index 30c5765bfc..92b69de635 100644
--- a/t/helper/test-subprocess.c
+++ b/t/helper/test-subprocess.c
@@ -1,7 +1,8 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "run-command.h"
 
-int cmd_main(int argc, const char **argv)
+int cmd__subprocess(int argc, const char **argv)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int nogit = 0;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 434fedc8d8..96180f0350 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -38,6 +38,7 @@ static struct test_cmd cmds[] = {
 	{ "strcmp-offset", cmd__strcmp_offset },
 	{ "string-list", cmd__string_list },
 	{ "submodule-config", cmd__submodule_config },
+	{ "subprocess", cmd__subprocess },
 };
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index be7e79738f..a611801061 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -32,5 +32,6 @@ int cmd__sigchain(int argc, const char **argv);
 int cmd__strcmp_offset(int argc, const char **argv);
 int cmd__string_list(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
+int cmd__subprocess(int argc, const char **argv);
 
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
2.17.0.rc0.348.gd5a49e0b6f

