Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564111F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbeCQHzt (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:55:49 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36947 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeCQHzs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:48 -0400
Received: by mail-lf0-f67.google.com with SMTP id y19-v6so18545670lfd.4
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=th3GrZ6T6AUPlPffs4KuwyP6pRI9x4NJXz9bNN5o+hg=;
        b=t+GxVUBv39H2106mebN17me4g5LajZ97fS2ycyd+ioiM7CA7UQj7rk+6LRn/Q0EAiA
         90T7a/7zEnhRlv6rx9+awts8K8ExbEM7X+vw0vlpooKnzDc5lappI1GE5Bl/VUumB9JL
         VWi124XeTUPm/tL7lNasGP/uxpZleUFmAdziLVoauJ6RA/VH3v4eJ29vn9MXAbWBFNKE
         O6vl/9RJQwWxxaC4fMqvAhKYtZ2xFw83d96p7M9/RhWvFr5KQwHvtQex70uv1+hOWA/6
         kASpirH2XPMWqayWRji4NNMGa5RxycT7xWTGrARCCc5Q7/qtrvI1CzNWbhHFkMu+dXUB
         J8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=th3GrZ6T6AUPlPffs4KuwyP6pRI9x4NJXz9bNN5o+hg=;
        b=Hk3UMn0zyf91fkm/HxlP2J4XuZNTnObFc7kUVDcxfPxyISC/MWlJniFhBgL3yB/m0E
         hZ9sShwg4ZScRGXEAA2LMcpt/f/U4gjup3ylws0tEtXXF+QaBa6emRsuNP1jrD17Al8n
         wi620AP0bhwbk34jCcS2eoSZxxfStXjog/tmfToO84hnum8DGUCtkyr8QD0uUT18wfdX
         nOmkx1iQKElBVoVC5A+Y31kzYRnzSqkxxFjgy+tYnRkQGbLaQ9YqpNTnJ1OJV2weYLbO
         3/vopQJTFsrjSBUossBTo4HjkUNgnDgDv5fjRbbW7iNWGJOVzJ/bEmm9JyiLyzGGZM73
         +wPg==
X-Gm-Message-State: AElRT7EHgypqPD1U6/WjB08RbKJa8HfniSR/3nTHwXfN24MKzU5jb2MA
        9lvySQjOD8J7FLB55Wc9DDaokg==
X-Google-Smtp-Source: AG47ELvZ7gec9pKkCzwKkSrLQHZxsBGyn7t3cdu2kpfu4ZzumeQBksjV2kOACBSFHiCf9QV8ipG33g==
X-Received: by 2002:a19:dd4c:: with SMTP id u73-v6mr3454757lfg.145.1521273345917;
        Sat, 17 Mar 2018 00:55:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:45 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/36] t/helper: merge test-index-version into test-tool
Date:   Sat, 17 Mar 2018 08:54:00 +0100
Message-Id: <20180317075421.22032-16-pclouds@gmail.com>
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
 Makefile                              | 2 +-
 t/helper/test-index-version.c         | 3 ++-
 t/helper/test-tool.c                  | 1 +
 t/helper/test-tool.h                  | 1 +
 t/t1600-index.sh                      | 2 +-
 t/t1700-split-index.sh                | 2 +-
 t/t2104-update-index-skip-worktree.sh | 6 +++---
 7 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index f6c3ddc703..d7342e3a8b 100644
--- a/Makefile
+++ b/Makefile
@@ -663,13 +663,13 @@ TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-hashmap.o
+TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
-TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-match-trees
 TEST_PROGRAMS_NEED_X += test-mergesort
diff --git a/t/helper/test-index-version.c b/t/helper/test-index-version.c
index f569f6b7ef..5fc3b8d7ba 100644
--- a/t/helper/test-index-version.c
+++ b/t/helper/test-index-version.c
@@ -1,6 +1,7 @@
+#include "test-tool.h"
 #include "cache.h"
 
-int cmd_main(int argc, const char **argv)
+int test_index_version(int argc, const char **argv)
 {
 	struct cache_header hdr;
 	int version;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 924d8c80f7..c8c8f3ead6 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -18,6 +18,7 @@ static struct test_cmd cmds[] = {
 	{ "example-decorate", test_example_decorate },
 	{ "genrandom", test_genrandom },
 	{ "hashmap", test_hashmap },
+	{ "index-version", test_index_version },
 	{ "lazy-init-name-hash", test_lazy_init_name_hash },
 	{ "sha1", test_sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 161f5becb7..a81e071a80 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -12,6 +12,7 @@ int test_dump_split_index(int argc, const char **argv);
 int test_example_decorate(int argc, const char **argv);
 int test_genrandom(int argc, const char **argv);
 int test_hashmap(int argc, const char **argv);
+int test_index_version(int argc, const char **argv);
 int test_lazy_init_name_hash(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 079d241145..c4422312f4 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -68,7 +68,7 @@ test_expect_success 'GIT_INDEX_VERSION takes precedence over config' '
 		git config --add index.version 2 &&
 		git add a 2>&1 &&
 		echo 4 >expect &&
-		test-index-version <.git/index >actual &&
+		test-tool index-version <.git/index >actual &&
 		test_cmp expect actual
 	)
 '
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index ec179fbaf7..e4f4c4df4e 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -12,7 +12,7 @@ test_expect_success 'enable split index' '
 	git config splitIndex.maxPercentChange 100 &&
 	git update-index --split-index &&
 	test-tool dump-split-index .git/index >actual &&
-	indexversion=$(test-index-version <.git/index) &&
+	indexversion=$(test-tool index-version <.git/index) &&
 	if test "$indexversion" = "4"
 	then
 		own=432ef4b63f32193984f339431fd50ca796493569
diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index-skip-worktree.sh
index cc830da58d..7e2e7dd4ae 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -33,7 +33,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'index is at version 2' '
-	test "$(test-index-version < .git/index)" = 2
+	test "$(test-tool index-version < .git/index)" = 2
 '
 
 test_expect_success 'update-index --skip-worktree' '
@@ -42,7 +42,7 @@ test_expect_success 'update-index --skip-worktree' '
 '
 
 test_expect_success 'index is at version 3 after having some skip-worktree entries' '
-	test "$(test-index-version < .git/index)" = 3
+	test "$(test-tool index-version < .git/index)" = 3
 '
 
 test_expect_success 'ls-files -t' '
@@ -55,7 +55,7 @@ test_expect_success 'update-index --no-skip-worktree' '
 '
 
 test_expect_success 'index version is back to 2 when there is no skip-worktree entry' '
-	test "$(test-index-version < .git/index)" = 2
+	test "$(test-tool index-version < .git/index)" = 2
 '
 
 test_done
-- 
2.16.2.903.gd04caf5039

