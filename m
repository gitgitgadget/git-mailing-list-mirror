Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AFCC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349290AbiEZVuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349220AbiEZVtg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E840DE32B
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i9so3622924wrc.13
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U8ZqUfuZDEUFYGsmHGxhn6kU6MMzXdTmjRg0f11rgdE=;
        b=aNqhZdW6THFKcQiEjFC3TLMWqNWkEwD7bhI75KEeSsLfBTH3eTUdTYxRbjGmi8RDHJ
         XXhCJAlNbo8aS80uH+vR0CIjg4xEK0ISoTFq7Bmxm2DBwKBIeG6J7utlr88U4iJTdKTF
         RekfF/r0efW5MiEdZam9Qe7PCYhxy4/1ZljiqcLWKqoT9BmNAIfhy2XJhEH9qI7CiWwG
         aIa4+tze9KxhpMvrY7oJcd5/Eraf5fH68rYDz/gs810336+2lVaCNAFwFqnSvYWsCDCf
         IJkvNzx0UNahZC350T6eWSy3TWSKl7vX9KIsRYJOSFNMTMt2+96B1U3/HtsrZHLoCpQh
         DbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U8ZqUfuZDEUFYGsmHGxhn6kU6MMzXdTmjRg0f11rgdE=;
        b=aWgyVCcRl31XzUi01joRIUynTGQYs0rc4BFLwx6q80DYNvCG9A/QKGPThHbujRQZhE
         3wpdnjHaoUbQH0E8Xvh+voDtvvFvNgh/nt9Fi6r/AdqTrONSotRLQmITNevV7eSNusIt
         r7ndHb1DqvDStfC+7R+nJAH/ARmvFGB9uXzqxG+n/04c7l7kZNWZ8xr3ca3ixa3626rW
         cWUPuMYZcfmfOLByAtxmvIGYoIjx1CIYUa+UV/1t8AG1ErD8UlOmQGrOglgXKF9cpnS9
         ED4HHKQS4zZiT58uzf/rsmLun0/+ourkDOd70h5MzEKe0E25dGuM4Cb5ZsvZqXmHwQQg
         xKvQ==
X-Gm-Message-State: AOAM533I5V8OA4s++zToZ7f8DSuY+J1f24WEkwE58dRpVxTvucz/y2ag
        F0yBdZ+ZtRf0ceRV8L+pevoYvSS4cpE=
X-Google-Smtp-Source: ABdhPJwS37ULo4DOHvGcHCAkRFAhrZPWiFp9SVkkcjJZ19oq0EkFUCv2c4nPNm5scUPJeCWr8r/pXw==
X-Received: by 2002:a5d:4947:0:b0:210:10aa:d with SMTP id r7-20020a5d4947000000b0021010aa000dmr2730411wrs.669.1653601772933;
        Thu, 26 May 2022 14:49:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2-20020adfe102000000b002100316b126sm266826wrz.6.2022.05.26.14.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:32 -0700 (PDT)
Message-Id: <1612dcba5035672253165a99ffba22fe78a601da.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:20 +0000
Subject: [PATCH v9 26/30] t/helper/hexdump: add helper to print hexdump of
 stdin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                |  1 +
 t/helper/test-hexdump.c | 30 ++++++++++++++++++++++++++++++
 t/helper/test-tool.c    |  1 +
 t/helper/test-tool.h    |  1 +
 4 files changed, 33 insertions(+)
 create mode 100644 t/helper/test-hexdump.c

diff --git a/Makefile b/Makefile
index 5f1623baadd..5afa194aac6 100644
--- a/Makefile
+++ b/Makefile
@@ -729,6 +729,7 @@ TEST_BUILTINS_OBJS += test-getcwd.o
 TEST_BUILTINS_OBJS += test-hash-speed.o
 TEST_BUILTINS_OBJS += test-hash.o
 TEST_BUILTINS_OBJS += test-hashmap.o
+TEST_BUILTINS_OBJS += test-hexdump.o
 TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-json-writer.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
diff --git a/t/helper/test-hexdump.c b/t/helper/test-hexdump.c
new file mode 100644
index 00000000000..811e89c1bcb
--- /dev/null
+++ b/t/helper/test-hexdump.c
@@ -0,0 +1,30 @@
+#include "test-tool.h"
+#include "git-compat-util.h"
+
+/*
+ * Read stdin and print a hexdump to stdout.
+ */
+int cmd__hexdump(int argc, const char **argv)
+{
+	char buf[1024];
+	ssize_t i, len;
+	int have_data = 0;
+
+	for (;;) {
+		len = xread(0, buf, sizeof(buf));
+		if (len < 0)
+			die_errno("failure reading stdin");
+		if (!len)
+			break;
+
+		have_data = 1;
+
+		for (i = 0; i < len; i++)
+			printf("%02x ", (unsigned char)buf[i]);
+	}
+
+	if (have_data)
+		putchar('\n');
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 0424f7adf5d..88c4b28cdfa 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -38,6 +38,7 @@ static struct test_cmd cmds[] = {
 	{ "getcwd", cmd__getcwd },
 	{ "hashmap", cmd__hashmap },
 	{ "hash-speed", cmd__hash_speed },
+	{ "hexdump", cmd__hexdump },
 	{ "index-version", cmd__index_version },
 	{ "json-writer", cmd__json_writer },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index c876e8246fb..511f6251bf5 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -29,6 +29,7 @@ int cmd__genzeros(int argc, const char **argv);
 int cmd__getcwd(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
 int cmd__hash_speed(int argc, const char **argv);
+int cmd__hexdump(int argc, const char **argv);
 int cmd__index_version(int argc, const char **argv);
 int cmd__json_writer(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
-- 
gitgitgadget

