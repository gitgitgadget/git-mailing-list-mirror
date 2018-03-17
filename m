Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 739381F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeCQHzo (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:55:44 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36936 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbeCQHzl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:41 -0400
Received: by mail-lf0-f68.google.com with SMTP id y19-v6so18545476lfd.4
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BlLlz/SUWif8coif4KFn0njTrg76P+qknqYKOlVeHMo=;
        b=Ujar0GX6apAfSbGDcK4v91PdGm/mCpjV3y+KL4+1t0nNYvYRHR7/XDt0/iVPJ2AhzY
         Hoer5Lk/c8KMV1YI8WXkDvFk4cWc6K03dAK/NGv4Gf+4OGUBK+7Kl8E0tLAviBF/LtcM
         7fIh7QDcJ7AE2weYppzxbuFX4gt8g2r59cjSeb/iftVl1auVET3RGfwWEdM3VPo68PWf
         mZXAyAbppqdmzM2NM2wzarBxYSXIbLnephXfXVRyLtYf+wWuvQbv23IyrlbD/ARzBUtV
         83kf5P5u17d4s7SI5HsxprNfMxzLMxdmvCiYsGnmuI8T/mwWzVq3z2lLEzDuoPZYMvHa
         toCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BlLlz/SUWif8coif4KFn0njTrg76P+qknqYKOlVeHMo=;
        b=G0vFBF5zmlTb9PbZMKTrKOhXjbvLvY8mPWzkI32TV+o+ZTW/AOLWbqwBt1i3mZjbOU
         2Gq6NEKdlPboaMYK8IjSexTfTt5YUU4bPcpOQkI4IHhZbwNL2550++XS0CIhhlr0GsZ9
         pcO/7wUV6IcVliVBWUwK6FgXw0WF5NN4wTIZ6scZ3FkkwdjUdAVSojIEmaswRGuEsqyg
         NM2J3nq7u8vMFkTBJVuWQfPEGYTfu+E4xbNR3fc/+tCuBi2Jhph4k3SLmMaXWNt2ySEb
         KA8HHTUig9Lh9sCjLqwJRV2ru+k9wBc/7GNiyfRJtSefrrXF24SKQvigkDO/lqLv27g6
         t1vw==
X-Gm-Message-State: AElRT7EzZPv0paxHSYeIsEOIJAxR1G371g0xwgsvxu/oApB0HjEHMV9x
        +g4zUw/DF5vGwOBp7W0OSu9iDA==
X-Google-Smtp-Source: AG47ELt0USMd8mt4jXXDHOx0CysdfEX4cz0BLA98ysKKm82Y56ziQ/Dwx54tJfuM6S9XobO2UL3mqQ==
X-Received: by 10.46.146.84 with SMTP id v20mr3395635ljg.128.1521273339448;
        Sat, 17 Mar 2018 00:55:39 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/36] t/helper: merge (unused) test-delta into test-tool
Date:   Sat, 17 Mar 2018 08:53:53 +0100
Message-Id: <20180317075421.22032-9-pclouds@gmail.com>
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
 Makefile              | 2 +-
 t/helper/test-delta.c | 5 +++--
 t/helper/test-tool.c  | 1 +
 t/helper/test-tool.h  | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index efb1872c52..327d63217a 100644
--- a/Makefile
+++ b/Makefile
@@ -656,10 +656,10 @@ TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-ctype.o
 TEST_BUILTINS_OBJS += test-date.o
+TEST_BUILTINS_OBJS += test-delta.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
-TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-drop-caches
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 591730adc4..fae9712d57 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -8,14 +8,15 @@
  * published by the Free Software Foundation.
  */
 
+#include "test-tool.h"
 #include "git-compat-util.h"
 #include "delta.h"
 #include "cache.h"
 
 static const char usage_str[] =
-	"test-delta (-d|-p) <from_file> <data_file> <out_file>";
+	"test-tool delta (-d|-p) <from_file> <data_file> <out_file>";
 
-int cmd_main(int argc, const char **argv)
+int test_delta(int argc, const char **argv)
 {
 	int fd;
 	struct stat st;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index fe130ffbf2..e48c1f2d5f 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -11,6 +11,7 @@ static struct test_cmd cmds[] = {
 	{ "config", test_config },
 	{ "ctype", test_ctype },
 	{ "date", test_date },
+	{ "delta", test_delta },
 	{ "lazy-init-name-hash", test_lazy_init_name_hash },
 	{ "sha1", test_sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 99ca1176dc..0ee098f1e3 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -5,6 +5,7 @@ int test_chmtime(int argc, const char **argv);
 int test_config(int argc, const char **argv);
 int test_ctype(int argc, const char **argv);
 int test_date(int argc, const char **argv);
+int test_delta(int argc, const char **argv);
 int test_lazy_init_name_hash(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
-- 
2.16.2.903.gd04caf5039

