Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E572E1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 17:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeIIW1H (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 18:27:07 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:44182 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeIIW1H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 18:27:07 -0400
Received: by mail-lj1-f179.google.com with SMTP id q127-v6so15928958ljq.11
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 10:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5uNZiYLip/1WdtP0gjVHEBpa7pD9oIik1b4gHrB6bks=;
        b=ZMTIt3xqpA6/Iy9EbI3CafhfSKRW6YCuneyuzDCsM8pqvqlAhBWsI6Wm2uYVleDcgo
         x8KUbrlBVlgkPNXeALD440aSQ4Vqx9oRJ/J5BvncLeCKroDgsE7Cqs1fync+ckEzdAKz
         qU6PokoNVeYw2GUyT77GPBoboDU4/mBpHge0KYPPc4ggM8u29hen4GFGxceWlmZ8Jt7G
         1rnoszK/bvA+YChAXKZg3FjdPIsh+7LvifXuQ2ByzaBpai5m2zIcPs+bXj/0p3IJU9ky
         Wr/g5qvGc5zpSc5noz5Lb7wOcRwGucjbbNCPFVc1C0rVvs2l3ShmzczLmbJSWRmGhw9/
         AUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5uNZiYLip/1WdtP0gjVHEBpa7pD9oIik1b4gHrB6bks=;
        b=bl85gjQtRuoU/E1H8arjha9IkXUEe/fhnMTk0XyzYrkisVJT9bbSV4JlvqFq64OtAD
         bYbiTgSbh5GgivsawLWV5QVSInPkduAixZXrRVVp0KHSoSm8zIuWwAizYT8SG7UA8huj
         rrnYA6lU2a4lODM312H/MJH+EYbC4ZTktcZj+eZZtfz7+UdVtCBMhEKvJYPmiK8VhfiL
         YfG/F+Q64DEFJt8VXoyuiBmFnqiGKYKMN/8xUf6t4DehraW2uHfiqPyr2FzDX+QQtefw
         McbfcX0wCrdKV8HplUKpD2N7MJvzThbmhV2clQkdTgD7Jxwiq6cvPTmkM08ZR3xiA7DP
         m6nA==
X-Gm-Message-State: APzg51DKHak6+c8t2x6BrNIwjr/yLOceB/zE8Qi6xrcghrBPqe7LX9nS
        noC+cMNq/4emOXUMDmvOBmiNwMw6
X-Google-Smtp-Source: ANB0Vda9aSt3ehbcdOonZgUkmE78Z6ov40p2lJ0hbpbj//E5FQJhTYSOzjHbgwGUN9SLbt/8Q4oQOA==
X-Received: by 2002:a2e:2282:: with SMTP id i124-v6mr10910045lji.11.1536514602564;
        Sun, 09 Sep 2018 10:36:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u19-v6sm2317793lje.51.2018.09.09.10.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 10:36:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 5/6] t/helper: merge test-dump-fsmonitor into test-tool
Date:   Sun,  9 Sep 2018 19:36:30 +0200
Message-Id: <20180909173631.1446-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909173631.1446-1-pclouds@gmail.com>
References: <20180909173631.1446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile                       |  2 +-
 t/helper/test-dump-fsmonitor.c |  3 ++-
 t/helper/test-tool.c           |  1 +
 t/helper/test-tool.h           |  1 +
 t/t7519-status-fsmonitor.sh    | 10 +++++-----
 5 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 1a8a7cb82d..ea7454632d 100644
--- a/Makefile
+++ b/Makefile
@@ -709,6 +709,7 @@ TEST_BUILTINS_OBJS += test-date.o
 TEST_BUILTINS_OBJS += test-delta.o
 TEST_BUILTINS_OBJS += test-drop-caches.o
 TEST_BUILTINS_OBJS += test-dump-cache-tree.o
+TEST_BUILTINS_OBJS += test-dump-fsmonitor.o
 TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
@@ -743,7 +744,6 @@ TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-write-cache.o
 
-TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-svn-fe
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index ad452707e8..08e3684aff 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -1,6 +1,7 @@
+#include "test-tool.h"
 #include "cache.h"
 
-int cmd_main(int ac, const char **av)
+int cmd__dump_fsmonitor(int ac, const char **av)
 {
 	struct index_state *istate = &the_index;
 	int i;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 9cc21024e9..6261c2fda0 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -14,6 +14,7 @@ static struct test_cmd cmds[] = {
 	{ "delta", cmd__delta },
 	{ "drop-caches", cmd__drop_caches },
 	{ "dump-cache-tree", cmd__dump_cache_tree },
+	{ "dump-fsmonitor", cmd__dump_fsmonitor },
 	{ "dump-split-index", cmd__dump_split_index },
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
 	{ "example-decorate", cmd__example_decorate },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 527722f4b0..38da025511 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -10,6 +10,7 @@ int cmd__date(int argc, const char **argv);
 int cmd__delta(int argc, const char **argv);
 int cmd__drop_caches(int argc, const char **argv);
 int cmd__dump_cache_tree(int argc, const char **argv);
+int cmd__dump_fsmonitor(int argc, const char **argv);
 int cmd__dump_split_index(int argc, const char **argv);
 int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 603d27789b..8384ad258c 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -84,21 +84,21 @@ test_expect_success 'setup' '
 
 # test that the fsmonitor extension is off by default
 test_expect_success 'fsmonitor extension is off by default' '
-	test-dump-fsmonitor >actual &&
+	test-tool dump-fsmonitor >actual &&
 	grep "^no fsmonitor" actual
 '
 
 # test that "update-index --fsmonitor" adds the fsmonitor extension
 test_expect_success 'update-index --fsmonitor" adds the fsmonitor extension' '
 	git update-index --fsmonitor &&
-	test-dump-fsmonitor >actual &&
+	test-tool dump-fsmonitor >actual &&
 	grep "^fsmonitor last update" actual
 '
 
 # test that "update-index --no-fsmonitor" removes the fsmonitor extension
 test_expect_success 'update-index --no-fsmonitor" removes the fsmonitor extension' '
 	git update-index --no-fsmonitor &&
-	test-dump-fsmonitor >actual &&
+	test-tool dump-fsmonitor >actual &&
 	grep "^no fsmonitor" actual
 '
 
@@ -307,9 +307,9 @@ test_expect_success 'splitting the index results in the same state' '
 	dirty_repo &&
 	git update-index --fsmonitor  &&
 	git ls-files -f >expect &&
-	test-dump-fsmonitor >&2 && echo &&
+	test-tool dump-fsmonitor >&2 && echo &&
 	git update-index --fsmonitor --split-index &&
-	test-dump-fsmonitor >&2 && echo &&
+	test-tool dump-fsmonitor >&2 && echo &&
 	git ls-files -f >actual &&
 	test_cmp expect actual
 '
-- 
2.19.0.rc0.337.ge906d732e7

