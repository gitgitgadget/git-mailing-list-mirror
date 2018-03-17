Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24BB1F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbeCQHz7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:55:59 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41845 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752355AbeCQHzy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:54 -0400
Received: by mail-lf0-f67.google.com with SMTP id m69-v6so18494403lfe.8
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NeBGWXhIpSCIgg1Z5eMnmz3hUP69T49zUex1b5E6cUU=;
        b=khyzW0sf++SD6uw84Uk7Fj2cTp12IdqVPlmzhN9s5qaYbU4UiKH/wq3cO9oa/B7Ihx
         rQW8loniKt6IP6vCnpjJ+oohGOlh6++BeNl6SpkaEo/odZtLsyCqceeyMSt/W/PI2qYD
         FQZi5Ip3yhsPkKmtxC5UzTtwpDfT1vYzdJEBtxuu/DfSEZafznYEj+mfndvJh0XPH/YL
         MBqnvcNEmLg2ErnDckjn08QcPxA+2ZacoEeFC9jqHx+nxVq9qNI5D/Zvb+2yQ1O9AltP
         lb4tWl6rFW2vn9OgJc0K2x4dDTlpk4DKPmXApDAiTFGWessEqyKtqkceVj/q2hZc6S0b
         gf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NeBGWXhIpSCIgg1Z5eMnmz3hUP69T49zUex1b5E6cUU=;
        b=FQSVAQbzkfQDwPSduKpSgBaD1TJprVxcYdtg1FCzPG1GrQjggLgaOB5vJxtVwlNmTG
         DQImP+UgTc9h0/+HMuqlmD7E65wh6VrtaezraqHMOwZq50fJf/a3nKNo1ybwwYTTUjae
         v1yh/V0xa362hjTwwcCWTxc/jhJWYcvh3uxVuYjN7XkBVh+PCPaXxNm7cnOTc/QmOEHh
         XSrkn6Bmegz+2uSNof0SY7SIt+8zeIxpHpzohi5b9y4yG6FdYqX4Bzyo4kk7U4ve5N7y
         SP6vhVYuYnl2jQqieX7DDb4qO26Dev/TwkcgLqP7rhO7ATlPsVzt3Git4JzbhvtDPRL8
         /Sug==
X-Gm-Message-State: AElRT7HT0Y+ZMNbjo8wXZO+06gm2+Qy1cMlW6Fpi3z6j6mM462abYfnw
        Qh3+PLu8PCeTOg0oYj62T7dblA==
X-Google-Smtp-Source: AG47ELvcWy8yItxBO3m0G7OyE6j/YtVWnOLoQaTc2Gw2bI1LLZ9nXXLR6vm7fewSH00uvpD2xcmG/A==
X-Received: by 10.46.135.22 with SMTP id m22mr562093lji.106.1521273352262;
        Sat, 17 Mar 2018 00:55:52 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/36] t/helper: merge test-online-cpus into test-tool
Date:   Sat, 17 Mar 2018 08:54:04 +0100
Message-Id: <20180317075421.22032-20-pclouds@gmail.com>
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
 Makefile                                | 2 +-
 t/helper/test-online-cpus.c             | 3 ++-
 t/helper/test-tool.c                    | 1 +
 t/helper/test-tool.h                    | 1 +
 t/t3008-ls-files-lazy-init-name-hash.sh | 2 +-
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 3145a9b1b2..91af906d08 100644
--- a/Makefile
+++ b/Makefile
@@ -668,13 +668,13 @@ TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
+TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
-TEST_PROGRAMS_NEED_X += test-online-cpus
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
 TEST_PROGRAMS_NEED_X += test-prio-queue
diff --git a/t/helper/test-online-cpus.c b/t/helper/test-online-cpus.c
index 06c09c6b88..5899e3098f 100644
--- a/t/helper/test-online-cpus.c
+++ b/t/helper/test-online-cpus.c
@@ -1,7 +1,8 @@
+#include "test-tool.h"
 #include "git-compat-util.h"
 #include "thread-utils.h"
 
-int cmd_main(int argc, const char **argv)
+int test_online_cpus(int argc, const char **argv)
 {
 	printf("%d\n", online_cpus());
 	return 0;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 4a563e08c3..29b04dd103 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -23,6 +23,7 @@ static struct test_cmd cmds[] = {
 	{ "match-trees", test_match_trees },
 	{ "mergesort", test_mergesort },
 	{ "mktemp", test_mktemp },
+	{ "online-cpus", test_online_cpus },
 	{ "sha1", test_sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 5bbe3e96cf..b7dafee709 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -17,6 +17,7 @@ int test_lazy_init_name_hash(int argc, const char **argv);
 int test_match_trees(int argc, const char **argv);
 int test_mergesort(int argc, const char **argv);
 int test_mktemp(int argc, const char **argv);
+int test_online_cpus(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
index 8df4aa7c99..08af596ba6 100755
--- a/t/t3008-ls-files-lazy-init-name-hash.sh
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -4,7 +4,7 @@ test_description='Test the lazy init name hash with various folder structures'
 
 . ./test-lib.sh
 
-if test 1 -eq $($GIT_BUILD_DIR/t/helper/test-online-cpus)
+if test 1 -eq $($GIT_BUILD_DIR/t/helper/test-tool online-cpus)
 then
 	skip_all='skipping lazy-init tests, single cpu'
 	test_done
-- 
2.16.2.903.gd04caf5039

