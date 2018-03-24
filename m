Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E67E31F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeCXHpp (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:45:45 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40525 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeCXHpm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:42 -0400
Received: by mail-lf0-f65.google.com with SMTP id e5-v6so21419831lfb.7
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JUqwDIZ9DGeDNe7oZ58vYfk7ICB5jeSEQOoSx0+Y2qM=;
        b=V0J9cOfBQ1GGfGmk/VzgH00JO9DVz94IBWIS3+qxvOoNAAPt4M8wNfB7uJKBvxH5os
         cougTJ6uYt9TLw14H5yzglBW4lquFn38OK/jK63QspTU3AFmZFPf5qq4pZ/kZooJSAac
         zh6ybNOUad2zT/0RE+QP+pQlVvAZIP7lw8IpHbMSoj0xMjLj/GuBlzdFinV474cd23OZ
         LmylAyT4WyfvkRR5MxBeo2EIsVeYuPWdkX3eA4gakxi4MAHEiSFwD8aiVzLRUTLq3iuL
         5OUOqN5j99Eqwdw9A443mmqHissYIefnFYLqF5fyY7Vxun9myGBN3Q/xeEowLunZGdVo
         DPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JUqwDIZ9DGeDNe7oZ58vYfk7ICB5jeSEQOoSx0+Y2qM=;
        b=nbjgIJz24t7tW+yaCVwL9OgNcNiij7Tlq2Z7755z/D73xhBgq28EKrOvx1N/pJDEh+
         hsE2b/FPb0qbsnceTHbNvK2opHEl/DOW6xQWYottghazq4TEo5Hm2u34LnQgqCIEFj8q
         GR18mmzPvsqoSfXWxdco4HbGsQUulQnaceMHTHBLhGS+5Y/O/rR3ONI1nlwLzEfiJYX4
         QbFRPwYPOGaJA+LZoEbw2VR5pNrzDI61QtBt39WaYiapsZ9WOQawjfCB4+tFDTm9avvF
         VdXoTjAebmqz6SvcV2VmRcpvFnGUGpjNKQrElfwx+N16qdPShbqignLx/JBnCmRoskrl
         2eFw==
X-Gm-Message-State: AElRT7Hylfbk3+Rehipt4NOHxMU7PK/obx8wGCxOlbxNsLsJ84d/IlOj
        Ho2rr1hdr0jfkBAYbuX/JGY=
X-Google-Smtp-Source: AIpwx4/bFtnEIck7y2V+I/ET9kLNKyteOmxnv0cjKmRuAGQsbPAtSihnDQCjb043+UhMBM8dCqkCvg==
X-Received: by 2002:a19:1619:: with SMTP id m25-v6mr4329508lfi.17.1521877540643;
        Sat, 24 Mar 2018 00:45:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/36] t/helper: merge (unused) test-delta into test-tool
Date:   Sat, 24 Mar 2018 08:44:37 +0100
Message-Id: <20180324074505.19100-9-pclouds@gmail.com>
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
index 591730adc4..34c7259248 100644
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
+int cmd__delta(int argc, const char **argv)
 {
 	int fd;
 	struct stat st;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index e92f93ac3b..6bef386842 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -11,6 +11,7 @@ static struct test_cmd cmds[] = {
 	{ "config", cmd__config },
 	{ "ctype", cmd__ctype },
 	{ "date", cmd__date },
+	{ "delta", cmd__delta },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "sha1", cmd__sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 31c20bb656..761705e110 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -5,6 +5,7 @@ int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__ctype(int argc, const char **argv);
 int cmd__date(int argc, const char **argv);
+int cmd__delta(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

