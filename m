Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E57CE1F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeCQH5Q (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:57:16 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36937 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751871AbeCQHzm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:42 -0400
Received: by mail-lf0-f67.google.com with SMTP id y19-v6so18545511lfd.4
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bOGc58J1Y8D1tznbgqwOB+1ppx9h0/Lp2g505llepHQ=;
        b=COF+BayLTXEaJq4JkfmQQLUYJlqipYLfRBnFzHlUifim4KBpgj1QShWIp2GwTS8afe
         TiaZu+/b2bCepnuwvKtzUaaOOM3/6AePlfXYUBvKL/hquLTxlHLnyjWFQsAPyN1EyIFF
         TaGM+GEUq5CXIsV0PiZ/lbXXvhxD1kgvrbCAIORiqrfHRCoCQZBZ4ZrXyFWFfxhIkTgx
         VC1cb2U8nJshqUrPBLDN4vbVzed6sF03JCbbKR/pdkptvFvQtQHYODhMd4hXilPoc9Vg
         A/PlSxCKWPWwAzpKgjUA+W/T982NwQjEZbZ0S5jjhCxiYifJTNXATuy0y/gTq1u8rgSa
         txRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bOGc58J1Y8D1tznbgqwOB+1ppx9h0/Lp2g505llepHQ=;
        b=Iwj5GlDwARKc/Cy/ETYeD5xK9JAFGWC02+IOpaecYPc19DUbS9RtzVoz1pezXvUsCA
         7TGAGFL5yoA3F2RMmtlhMQ0OqP/Yxx8AKQCBzDxOsQalQDuWgxRsFQzAffl2Hwn/qian
         6IC8fwfhGPMXvtgnxDVkNetiGmdLY/lwiHUiNO85EIohQpra+sGZ27xgb5kRjOEmkTEH
         NWvPhYvCeyYzGnqFbP17Fv2vG0L6JDgwE7BDWkwv3iDgA276BhP+ahpsEQeDKYeJHRq/
         dHa9tU54lgXFEoXBT5PAREWpBwJpze5FpEtcm7qGkMoVp5F8NUlrxGj++Mjvyv44MOfZ
         v6bQ==
X-Gm-Message-State: AElRT7Hv+2n6SQBwgGiDWHmiB93ZMWzpjbRP0rQvud3lSbLjroGeItXx
        0s4rhkOUqDwiSoxixHMPow5qxQ==
X-Google-Smtp-Source: AG47ELuy5GsNzI3R44tkQX+gfQNHcKXMNz+nxZyIdCKUlb3NBno/OnWZHZdBC3dQ8Z7e6CEz1veyog==
X-Received: by 10.46.42.67 with SMTP id q64mr3368166ljq.133.1521273340352;
        Sat, 17 Mar 2018 00:55:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/36] t/helper: merge test-drop-caches into test-tool
Date:   Sat, 17 Mar 2018 08:53:54 +0100
Message-Id: <20180317075421.22032-10-pclouds@gmail.com>
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
 Makefile                    |  2 +-
 t/helper/test-drop-caches.c |  3 ++-
 t/helper/test-tool.c        |  1 +
 t/helper/test-tool.h        |  1 +
 t/perf/p7519-fsmonitor.sh   | 12 ++++++------
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 327d63217a..edd9c43982 100644
--- a/Makefile
+++ b/Makefile
@@ -657,10 +657,10 @@ TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-ctype.o
 TEST_BUILTINS_OBJS += test-date.o
 TEST_BUILTINS_OBJS += test-delta.o
+TEST_BUILTINS_OBJS += test-drop-caches.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
-TEST_PROGRAMS_NEED_X += test-drop-caches
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-split-index
diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
index bd1a857d52..2aa7c57b4a 100644
--- a/t/helper/test-drop-caches.c
+++ b/t/helper/test-drop-caches.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "git-compat-util.h"
 
 #if defined(GIT_WINDOWS_NATIVE)
@@ -157,7 +158,7 @@ static int cmd_dropcaches(void)
 
 #endif
 
-int cmd_main(int argc, const char **argv)
+int test_drop_caches(int argc, const char **argv)
 {
 	cmd_sync();
 	return cmd_dropcaches();
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index e48c1f2d5f..904e4103fd 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -12,6 +12,7 @@ static struct test_cmd cmds[] = {
 	{ "ctype", test_ctype },
 	{ "date", test_date },
 	{ "delta", test_delta },
+	{ "drop-caches", test_drop_caches },
 	{ "lazy-init-name-hash", test_lazy_init_name_hash },
 	{ "sha1", test_sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 0ee098f1e3..1e96bf44a2 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -6,6 +6,7 @@ int test_config(int argc, const char **argv);
 int test_ctype(int argc, const char **argv);
 int test_date(int argc, const char **argv);
 int test_delta(int argc, const char **argv);
+int test_drop_caches(int argc, const char **argv);
 int test_lazy_init_name_hash(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 65e145c02d..def7ecdbc7 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -118,7 +118,7 @@ test_expect_success "setup for fsmonitor" '
 '
 
 if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-drop-caches
+	test-tool drop-caches
 fi
 
 test_perf "status (fsmonitor=$INTEGRATION_SCRIPT)" '
@@ -126,7 +126,7 @@ test_perf "status (fsmonitor=$INTEGRATION_SCRIPT)" '
 '
 
 if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-drop-caches
+	test-tool drop-caches
 fi
 
 test_perf "status -uno (fsmonitor=$INTEGRATION_SCRIPT)" '
@@ -134,7 +134,7 @@ test_perf "status -uno (fsmonitor=$INTEGRATION_SCRIPT)" '
 '
 
 if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-drop-caches
+	test-tool drop-caches
 fi
 
 test_perf "status -uall (fsmonitor=$INTEGRATION_SCRIPT)" '
@@ -148,7 +148,7 @@ test_expect_success "setup without fsmonitor" '
 '
 
 if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-drop-caches
+	test-tool drop-caches
 fi
 
 test_perf "status (fsmonitor=$INTEGRATION_SCRIPT)" '
@@ -156,7 +156,7 @@ test_perf "status (fsmonitor=$INTEGRATION_SCRIPT)" '
 '
 
 if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-drop-caches
+	test-tool drop-caches
 fi
 
 test_perf "status -uno (fsmonitor=$INTEGRATION_SCRIPT)" '
@@ -164,7 +164,7 @@ test_perf "status -uno (fsmonitor=$INTEGRATION_SCRIPT)" '
 '
 
 if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-drop-caches
+	test-tool drop-caches
 fi
 
 test_perf "status -uall (fsmonitor=$INTEGRATION_SCRIPT)" '
-- 
2.16.2.903.gd04caf5039

