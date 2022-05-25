Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08D3C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245106AbiEYPCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245041AbiEYPBz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B53EAFB0E
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:41 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t13so11327304wrg.9
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U8ZqUfuZDEUFYGsmHGxhn6kU6MMzXdTmjRg0f11rgdE=;
        b=Au3wWMdASe8FUYvbkRRxdAZphsu2fnCo1wICNkZ8H8Pt0crUWHUwBzQaPNYggE13ab
         xpX+C4CLxCMmG2OlcWWle9lQ9yrf+Y0UM/iA6MMW2ubxgsGY1FgBYiMnnhUrO5lhcyN9
         z6CPvEjkl5cEOQ1Er67buSyifr1Pg7igL8vh+PcvvgDa5tn74YAwX8FzDXE2Un+JspMm
         KmSchKI9Fl+on0RntQKa6rYO+hYgiGD7yBTQseDfjiPI8sS8bdcTu59/lku/5tsn54np
         mFPIRbauKFdz1QweIc13asI02YD8EMJ7BIFsBz8xi5lUHIQGNR9PJVvS2WLGb1csyPdu
         XnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U8ZqUfuZDEUFYGsmHGxhn6kU6MMzXdTmjRg0f11rgdE=;
        b=FwA0+kYOEYUGbqh5/OUG6q63Zp+LRY/R8d+zDDWvtAsvY6luvk0wAeAQlT4WIBbwRM
         0mNs7UBCfiMByC7lWET5OmeUcGat9JX//RjHbPss+CnImLGdR0pye6EGHjAy5u5lL2y4
         3sABkDG+8Ge2ppKKtLORCT9H+i9HLFz1y2+cbDhRcEO3rPPeXjbBO8Jq07loDkyEakgg
         nOxHAbtNCtuwtfeSHjimEK6aurelAOf5ZwIRSTLQ1Vnt4YNqN23nJWfCMjQe1P1vu6jC
         jHReKzPLsfnyL7inho8CePaKLhpPwnNLkG42KPTiQk1zWi2S4rAE0Vy03x6uYnmPztJy
         /Oog==
X-Gm-Message-State: AOAM530+k7oSS8ghKMnadwAypc9vgRP+B2nFI2BJKCJLB4DCp5DeMtRe
        4ncpgvYNxrDl+bvxmdr5jg6Kk5J8aec=
X-Google-Smtp-Source: ABdhPJwf6+3bRr9CEPwfaTJ+VWSyzK9FQW2xjt5q9j35EpfhEWVbsS/zf8DtcpcjDwSZfu3I1Kg9Ig==
X-Received: by 2002:a05:6000:1867:b0:20f:ca21:7813 with SMTP id d7-20020a056000186700b0020fca217813mr17880242wri.100.1653490895681;
        Wed, 25 May 2022 08:01:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4-20020adfc6c4000000b0020e5d2a9d0bsm2799442wrh.54.2022.05.25.08.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:33 -0700 (PDT)
Message-Id: <66a01db47395a86cce6c0e427779c75d02c37757.1653490853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:48 +0000
Subject: [PATCH v8 26/30] t/helper/hexdump: add helper to print hexdump of
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

