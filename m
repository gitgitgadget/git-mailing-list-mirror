Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F989C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 22:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiKHWoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 17:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKHWoa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 17:44:30 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F07209A9
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 14:44:28 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id z14so23201244wrn.7
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 14:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCdjUgTQDws1aUxV2xH9IPd/S2yz2kRQO7o60vBAWEM=;
        b=nwn7UsxeafoahtkKm6Qx1vbDtpUJvXrKXt2eVq2s3pu8/szXAPxmX789PcHZYYHbD2
         fnO2O6Q76XlTOcBTMyJZONfxJ63WuoByshqxso53mavymhpHa5ISFlfS1PKh+MxrP6dB
         rhYgQ9rhhcY36vG+2O1+PdyqjMMO69H+8Yd94UsNPC95zeDuhtvL9rHLiI0CKoe0QT3y
         cLNA9WjVWeH/j6xZFqONDh675GbbjjEB60D3N+LG+iyhNWlBOsQz+D7luinLeH0JHyUu
         2qrHrunSykn6uSa2kt6t70nOWlax0Nn/L4u2BbGKEESAYHjNQhaQX3f7HSiIR9xwftl/
         RMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCdjUgTQDws1aUxV2xH9IPd/S2yz2kRQO7o60vBAWEM=;
        b=iGDOIJZMxkJ9kK42DBuralP3RivfwW7RQ2MUiWi3xfbSFb9hYUwB6p9RofXGMZQEKg
         2K2Bxy3W17FQc5LkGzo7SZq83FC6duXDZvqdjBUVHmyz6xeuRonZ6BvoMdNEOA7wwN6u
         /5eLObUPJjx8v5oKWf01+H6Oea0MXlpD6sPV52yhHmSA3mdylobz3lnlR+Xqa2mY7v6a
         K/NdDtNm2EIywVeuw+Yp9zxaJteLyOyvKHLHrlRq2+x3zNPhkMuo4Ad1uoZmkKp6np79
         npxU8ZTE6orCD0Mo+JyfO8xF/pYtzS7SONRCqESkQIaHxOO1YSPX3Yzkgn+zHqRWzfZa
         s5rA==
X-Gm-Message-State: ACrzQf3QrwfPTxPtdOU6XJ/LnixXXyKf6GJXs8kGchqaH5zuGqZkirTF
        82rNTXVdv9REJAdaunXxTqWY+7b2IOw=
X-Google-Smtp-Source: AMsMyM7snmCQbST7m7KX///bCc99DHE7y/hoF5W7QdoAe/UYNbWe7YLA9GU2bPFgBOLCoCu75/FT8A==
X-Received: by 2002:adf:f781:0:b0:236:5559:215b with SMTP id q1-20020adff781000000b002365559215bmr37577104wrp.16.1667947467346;
        Tue, 08 Nov 2022 14:44:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3-20020a05600c4f4300b003b47b80cec3sm17139930wmq.42.2022.11.08.14.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 14:44:26 -0800 (PST)
Message-Id: <45c198c629da1627eabf0e63539f50aaa50381bf.1667947465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Nov 2022 22:44:21 +0000
Subject: [PATCH 1/5] cache-tree: add perf test comparing update and prime
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add a performance test comparing the execution times of 'prime_cache_tree()'
and 'cache_tree_update(_, WRITE_TREE_SILENT | WRITE_TREE_REPAIR)'. The goal
of comparing these two is to identify which is the faster method for
rebuilding an invalid cache tree, ultimately to remove one when both are
(reundantly) called in immediate succession.

Both methods are incredibly fast, so the new tests in 'p0090-cache-tree.sh'
must call the tested method many times in succession to get non-negligible
timing results. Results show a substantial difference in execution time
between the two, with 'prime_cache_tree()' appearing to be the overall
faster method:

Test                                 this tree
----------------------------------------------------
0090.1: prime_cache_tree, clean      0.07(0.05+0.01)
0090.2: cache_tree_update, clean     0.11(0.05+0.06)
0090.3: prime_cache_tree, invalid    0.06(0.05+0.01)
0090.4: cache_tree_update, invalid   0.50(0.41+0.07)

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Makefile                   |  1 +
 t/helper/test-cache-tree.c | 52 ++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c       |  1 +
 t/helper/test-tool.h       |  1 +
 t/perf/p0090-cache-tree.sh | 27 ++++++++++++++++++++
 5 files changed, 82 insertions(+)
 create mode 100644 t/helper/test-cache-tree.c
 create mode 100755 t/perf/p0090-cache-tree.sh

diff --git a/Makefile b/Makefile
index 4927379184c..3639c7c2a94 100644
--- a/Makefile
+++ b/Makefile
@@ -723,6 +723,7 @@ TEST_BUILTINS_OBJS += test-advise.o
 TEST_BUILTINS_OBJS += test-bitmap.o
 TEST_BUILTINS_OBJS += test-bloom.o
 TEST_BUILTINS_OBJS += test-bundle-uri.o
+TEST_BUILTINS_OBJS += test-cache-tree.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-crontab.o
diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
new file mode 100644
index 00000000000..2fad6d06d30
--- /dev/null
+++ b/t/helper/test-cache-tree.c
@@ -0,0 +1,52 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "tree.h"
+#include "cache-tree.h"
+#include "parse-options.h"
+
+static char const * const test_cache_tree_usage[] = {
+	N_("test-tool cache-tree <options> (prime|repair)"),
+	NULL
+};
+
+int cmd__cache_tree(int argc, const char **argv)
+{
+	struct object_id oid;
+	struct tree *tree;
+	int fresh = 0;
+	int count = 1;
+	int i;
+
+	struct option options[] = {
+		OPT_BOOL(0, "fresh", &fresh,
+			 N_("clear the cache tree before each repetition")),
+		OPT_INTEGER_F(0, "count", &count, N_("number of times to repeat the operation"),
+			      PARSE_OPT_NONEG),
+		OPT_END()
+	};
+
+	setup_git_directory();
+
+	parse_options(argc, argv, NULL, options, test_cache_tree_usage, 0);
+
+	if (read_cache() < 0)
+		die("unable to read index file");
+
+	get_oid("HEAD", &oid);
+	tree = parse_tree_indirect(&oid);
+	for (i = 0; i < count; i++) {
+		if (fresh)
+			cache_tree_free(&the_index.cache_tree);
+
+		if (!argc)
+			die("Must specify subcommand");
+		else if (!strcmp(argv[0], "prime"))
+			prime_cache_tree(the_repository, &the_index, tree);
+		else if (!strcmp(argv[0], "update"))
+			cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
+		else
+			die("Unknown command %s", argv[0]);
+	}
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 01cda9358df..547a3be1c8b 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -14,6 +14,7 @@ static struct test_cmd cmds[] = {
 	{ "bitmap", cmd__bitmap },
 	{ "bloom", cmd__bloom },
 	{ "bundle-uri", cmd__bundle_uri },
+	{ "cache-tree", cmd__cache_tree },
 	{ "chmtime", cmd__chmtime },
 	{ "config", cmd__config },
 	{ "crontab", cmd__crontab },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index ca2948066fd..e44e1d896d3 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -8,6 +8,7 @@ int cmd__advise_if_enabled(int argc, const char **argv);
 int cmd__bitmap(int argc, const char **argv);
 int cmd__bloom(int argc, const char **argv);
 int cmd__bundle_uri(int argc, const char **argv);
+int cmd__cache_tree(int argc, const char **argv);
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__crontab(int argc, const char **argv);
diff --git a/t/perf/p0090-cache-tree.sh b/t/perf/p0090-cache-tree.sh
new file mode 100755
index 00000000000..91c13e28a27
--- /dev/null
+++ b/t/perf/p0090-cache-tree.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description="Tests performance of cache tree operations"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+count=200
+test_perf "prime_cache_tree, clean" "
+	test-tool cache-tree --count $count prime
+"
+
+test_perf "cache_tree_update, clean" "
+	test-tool cache-tree --count $count update
+"
+
+test_perf "prime_cache_tree, invalid" "
+	test-tool cache-tree --count $count --fresh prime
+"
+
+test_perf "cache_tree_update, invalid" "
+	test-tool cache-tree --count $count --fresh update
+"
+
+test_done
-- 
gitgitgadget

