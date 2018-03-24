Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7B31F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeCXHqi (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:38 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37328 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbeCXHqD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:46:03 -0400
Received: by mail-lf0-f66.google.com with SMTP id m16-v6so17662573lfc.4
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ney2OTcY6+JEFP062Euht1unwTO5zMuZTTo9L20628I=;
        b=BJAEf6bn4rF2RyD+zbuclVjfjutXY8AgnvxNF91CJjpHWmlG2h/D/snvU1/q/bkdSN
         wj6dwdIc52iwJLxmZOe9AB2+bW/B0T0kcil5pr/hXT7NYDgOqUSEIlybr7nUWcSkxRZK
         XI4MOWKdGHbIrjooGdYz3NrpnL3qzpxghTiXQuBM9fnycIet55nJdhg00bHQt2Fn0Zec
         0MAOK76KFOnQygDtEI2S1cFVKUFAMxcmP0UclxOnBwvobbgNITwi+9KMhmg1RI5BXsw2
         izNmTnn+9SK8Qh0nB1wpjNKsDQT0vaOpE2ljAoQiSnryZUy9ENlfcZRnIz377AdK2cmM
         7G0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ney2OTcY6+JEFP062Euht1unwTO5zMuZTTo9L20628I=;
        b=X+//Kju8pu2njV685N7QAZJp1ylBAB+ersLfPWckJctziQUVmbbLx86nh+RMsVdJhr
         p6PXCES6ginnP0/72zX7qTGN+98UZ05DqscFPj0RMI/QA5ZtrCJwZ6hkEPPrUArepLZ/
         5l0DmfrCD63hxNezYVY3znVQvHvQmMOBVOxOx3biPABol2ZKMnSygE8wfk/knLL8cWkO
         nwN/22w3cm+kgpRBsMvMjmSlIGmlydanKeGvRVibmDc3eqVAVX7ViCFVpuuGwOlNYRdw
         134eGga37wHQZjYUS+B9gZD1BISzaWEqJaZooXM/bloTjx42IDSoi5XRHIH6u4GEKyhb
         HeBw==
X-Gm-Message-State: AElRT7HnAsrfMstooW8WPY6oTn05sbuUfzKT7gFFBEDhu2kAZKnyj6sO
        yF65Ky/zO8fA90ekqAlkaU0=
X-Google-Smtp-Source: AG47ELvGTVtxXsLcxJV1FdjnntnQoh7ue0UJQVtar5hRjz53OvSV/oW8h33htx3qXEu4coRaV9nm0w==
X-Received: by 2002:a19:b2d1:: with SMTP id t78-v6mr22756548lfk.78.1521877561765;
        Sat, 24 Mar 2018 00:46:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:46:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 25/36] t/helper: merge test-revision-walking into test-tool
Date:   Sat, 24 Mar 2018 08:44:54 +0100
Message-Id: <20180324074505.19100-26-pclouds@gmail.com>
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
index b8e6fe1d00..4f8bc75821 100644
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
+int cmd__revision_walking(int argc, const char **argv)
 {
 	if (argc < 2)
 		return 1;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 0dd3b879ad..e43405bea9 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -29,6 +29,7 @@ static struct test_cmd cmds[] = {
 	{ "read-cache", cmd__read_cache },
 	{ "ref-store", cmd__ref_store },
 	{ "regex", cmd__regex },
+	{ "revision-walking", cmd__revision_walking },
 	{ "sha1", cmd__sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 5f73c83ac0..4dff220646 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -23,6 +23,7 @@ int cmd__prio_queue(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
+int cmd__revision_walking(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
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
2.17.0.rc0.348.gd5a49e0b6f

