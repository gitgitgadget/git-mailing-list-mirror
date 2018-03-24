Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C88F61F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeCXHqY (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:24 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39720 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbeCXHqT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:46:19 -0400
Received: by mail-lf0-f67.google.com with SMTP id p142-v6so21404638lfd.6
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34m9rc5gK3hW7q9NeuL3BLmzAb+BrQgHQ3+6CDXHtSg=;
        b=kU1Hev3IGaEA84p6LhPjm+jxLSNm0RJ/N96Nm4wOie8qL8d1wYsqj8bV8nzo3KLPGJ
         qtHHKUiP1lgGG0rPFWYqoZCEVKatA57GDPep5Wpj6R6F2P9feSx6uTW2I5VS0E0iZJFm
         NEddZ1Xt1C4t6jCzHYireBfh4lYE9kdugGo9UShsclHP11IcTV3gQoD348Ax7CtQozTp
         BbKJmi4fffCh7MlHlNLBEii+ycPtuk1S9T4+upaivPgNLmJUnGXF4TWt593t4vAXwYPX
         iLHGnRumOF045QrovthAnYAp+2Y9WqHprCyCTgpMb9DjQ7qqROVitL69NF3/6nGXP82i
         iqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34m9rc5gK3hW7q9NeuL3BLmzAb+BrQgHQ3+6CDXHtSg=;
        b=D3ZbmCSefaks5TXmrjxpAYusGAa2q3BJv2/u4RFXHi4iiD1CveGug+4M3H8Hn/Vo6z
         BkSzPWL8CFHg7LuxCrb4DXNk1ftUxU1xLYE5VrlXwbUElna8WtWxpoHs/guEBVNjhUiI
         3dqAMlwqM+ljlP9JaEciawTDq4umZglLyggs3Mg9jmWx1IPqeGFJ/LmYiHr35lhUosbM
         GdxpUi8TMBQGXdezpKNsg8Mci+TjNSiHozShbFjONode5Jxy9T9e/UWwkrJ+xnaoBNDD
         DEb7NuIPTU07NHadKF8s1RSeKuzaMfdPQe6PbrORMKoZsrvSs7g01a6726mdSDrkmiSu
         tiIQ==
X-Gm-Message-State: AElRT7GwkctbdgH5U2G17b+xg/lo9B1syAoIrh3kd7nJhk7UkRUv566J
        jxdHOuFyYqpmIfXP7B9EKRg=
X-Google-Smtp-Source: AG47ELv1SK7oE3NA11vcal8ZkUtieEcaBviMLMco08JCwTrthSdxmAN6bVveM943wpeTGlmH47UbFQ==
X-Received: by 10.46.69.85 with SMTP id s82mr20838400lja.19.1521877578100;
        Sat, 24 Mar 2018 00:46:18 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:46:17 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 36/36] t/helper: merge test-write-cache into test-tool
Date:   Sat, 24 Mar 2018 08:45:05 +0100
Message-Id: <20180324074505.19100-37-pclouds@gmail.com>
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
 Makefile                    | 2 +-
 t/helper/test-tool.c        | 1 +
 t/helper/test-tool.h        | 1 +
 t/helper/test-write-cache.c | 3 ++-
 t/perf/p0007-write-cache.sh | 2 +-
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 2ab76c6838..8ad9a2a1a9 100644
--- a/Makefile
+++ b/Makefile
@@ -686,13 +686,13 @@ TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
+TEST_BUILTINS_OBJS += test-write-cache.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
-TEST_PROGRAMS_NEED_X += test-write-cache
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-tool
 
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index a804e64048..cd5e28b045 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -41,6 +41,7 @@ static struct test_cmd cmds[] = {
 	{ "subprocess", cmd__subprocess },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
 	{ "wildmatch", cmd__wildmatch },
+	{ "write-cache", cmd__write_cache },
 };
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 84c583e68f..7116ddfb94 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -35,5 +35,6 @@ int cmd__submodule_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
 int cmd__wildmatch(int argc, const char **argv);
+int cmd__write_cache(int argc, const char **argv);
 
 #endif
diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
index b7ee039669..017dc30380 100644
--- a/t/helper/test-write-cache.c
+++ b/t/helper/test-write-cache.c
@@ -1,9 +1,10 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "lockfile.h"
 
 static struct lock_file index_lock;
 
-int cmd_main(int argc, const char **argv)
+int cmd__write_cache(int argc, const char **argv)
 {
 	int i, cnt = 1, lockfd;
 	if (argc == 2)
diff --git a/t/perf/p0007-write-cache.sh b/t/perf/p0007-write-cache.sh
index 261fe92fd9..09595264f0 100755
--- a/t/perf/p0007-write-cache.sh
+++ b/t/perf/p0007-write-cache.sh
@@ -23,7 +23,7 @@ test_expect_success "setup repo" '
 
 count=3
 test_perf "write_locked_index $count times ($nr_files files)" "
-	test-write-cache $count
+	test-tool write-cache $count
 "
 
 test_done
-- 
2.17.0.rc0.348.gd5a49e0b6f

