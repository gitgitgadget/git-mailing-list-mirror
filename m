Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEBC01F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeCQH4k (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:56:40 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45774 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbeCQH4A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:56:00 -0400
Received: by mail-lf0-f66.google.com with SMTP id h127-v6so18487066lfg.12
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wMe6CtIG9cLNO96Ea/7RqtMCCBF4CC1lMfDxu+5yfzs=;
        b=uA685KCOsBN0BRfzC3WdlDf74rVArtjsmBca5x4sOWrIwB/af5WmTDx+sugKpHk3AC
         5RlAj8Jpc8q+qPRyw/r/HZfvX9s7sfHk6NyChoWIrKOM4i6jEtC2yoLvZ5pA4lklW2T4
         9kk6Ydjo02YunAe3+1KwdxTszxU7qSBNGI/BFw8ph6Jb2OPiA4iHOvVR6ghpVhMXjlCc
         SuaMwk888rLbmcYtipC6JyiR244IcgbLKGyJMkruTgNRiXBwCIG7MQfVOIe3qh9shGeC
         XI2bT1hccrOST5SjW6x1lXMBlqDl8UQAmJQ7YCCPiDIxj6bWCCg4Q7qO0KubMysgKiAo
         AU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wMe6CtIG9cLNO96Ea/7RqtMCCBF4CC1lMfDxu+5yfzs=;
        b=I2PLk3OV//rTlC42hH9QIcqSlPNVgK0Et+xIaMoDPs2lOnt/adriZzl0p2tckMrEks
         2isZ/IU3jg7XfEFa31C6Ga6OM4gbFXxuuS2r+UUxTecarbNYdoJ1jSrGb3jkTf+u67VR
         uUTM4TkXjox8fRRtzfKfZnMeLezkIuVC5o69sQimyWh1v0Clc0tpFNujbbWdFb22kt2K
         W05ORLq1dR4gZ6ch9YBzASCBY9Kka9Xtaa84IDtkaqXhIEMEe9E5VOHPUuHv97R0jt5x
         Oh4k7wBcAnB1trsfukWHrPv6IPJc06l88FlfLry+T8sMtlHFb6YJ2WH3LThc4b/w4SCQ
         ZR3Q==
X-Gm-Message-State: AElRT7F48Ms3BkH47c5o8KoJ+YVjLbdN/Fp+Taw9H8mGy3o2pOh/Y1gs
        GYxOtxVMyqRwRRI+rE4UOy7xug==
X-Google-Smtp-Source: AG47ELtHAbTen8DFtOlxmjYkawcbvZL0yC45OxYtgJukjIc6hYwcBkAzzwM7ZsNnwGf2Zl3gZgAnlQ==
X-Received: by 10.46.135.214 with SMTP id v22mr1111653ljj.94.1521273358533;
        Sat, 17 Mar 2018 00:55:58 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:57 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 25/36] t/helper: merge test-revision-walking into test-tool
Date:   Sat, 17 Mar 2018 08:54:10 +0100
Message-Id: <20180317075421.22032-26-pclouds@gmail.com>
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
 Makefile                         | 2 +-
 t/helper/test-revision-walking.c | 3 ++-
 t/helper/test-tool.c             | 1 +
 t/helper/test-tool.h             | 1 +
 t/t0062-revision-walking.sh      | 2 +-
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 7444c00bbb..3ed461cd55 100644
--- a/Makefile
+++ b/Makefile
@@ -674,6 +674,7 @@ TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-ref-store.o
 TEST_BUILTINS_OBJS += test-regex.o
+TEST_BUILTINS_OBJS += test-revision-walking.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
@@ -682,7 +683,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-revision-walking
 TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-sha1-array
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index b8e6fe1d00..467d710da8 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 
+#include "test-tool.h"
 #include "cache.h"
 #include "commit.h"
 #include "diff.h"
@@ -45,7 +46,7 @@ static int run_revision_walk(void)
 	return got_revision;
 }
 
-int cmd_main(int argc, const char **argv)
+int test_revision_walking(int argc, const char **argv)
 {
 	if (argc < 2)
 		return 1;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 7352bd40e8..4586ae9440 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -29,6 +29,7 @@ static struct test_cmd cmds[] = {
 	{ "read-cache", test_read_cache },
 	{ "ref-store", test_ref_store },
 	{ "regex", test_regex },
+	{ "revision-walking", test_revision_walking },
 	{ "sha1", test_sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 3cb2fd9509..9bbdb05848 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -23,6 +23,7 @@ int test_prio_queue(int argc, const char **argv);
 int test_read_cache(int argc, const char **argv);
 int test_ref_store(int argc, const char **argv);
 int test_regex(int argc, const char **argv);
+int test_revision_walking(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/t0062-revision-walking.sh b/t/t0062-revision-walking.sh
index 113c728e67..8e215867b8 100755
--- a/t/t0062-revision-walking.sh
+++ b/t/t0062-revision-walking.sh
@@ -26,7 +26,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'revision walking can be done twice' '
-	test-revision-walking run-twice >run_twice_actual &&
+	test-tool revision-walking run-twice >run_twice_actual &&
 	test_cmp run_twice_expected run_twice_actual
 '
 
-- 
2.16.2.903.gd04caf5039

