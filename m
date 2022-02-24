Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB93C433FE
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 20:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiBXUjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 15:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiBXUjL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 15:39:11 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915FD179A14
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:38:40 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so536213wme.0
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wvtv2pR79CcNIaHW+fTGq/M5gGXZdqURJ8pamHD494U=;
        b=KiNOxwwvXnkX7lDS/SxLgFnX4l5MvWYl54OXA0klWNBSDWNZKJCqsu8FxdLvMtVxWH
         z3woAQjPhtjvDS8yrnr5KGv+7MdaP2u4Rq6d7lIzgEJbMw84aBX1k3xudp7eNTLOBaBC
         Vzb8zjR8Jnq+b0T0aXX4xGwVnbnHzywAHbEha/iZtppaaYDGrBHElPUSAr+aiLtSq8Yq
         eep7X3+acZzwW19MbRNR18899ZOHKBNOjlSyXE5epOnJkGaCpeaYnRB2D6HHh54m3/Pt
         NqwNfcF21M6JJip4884WFSlDLUuTJr0gyazo7fs+Kj0l0iYz3wHS8xdf7/OqXD2aLam+
         RdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wvtv2pR79CcNIaHW+fTGq/M5gGXZdqURJ8pamHD494U=;
        b=5hZpmZow8YHMlmlV9jQwF6IiG3GoOoeGruCpQL0lM1KnHvl9VdymcTn38nkzkv4jz6
         QaUNhJ6UwIIR+mMe6NMCfWFMllvPzXhnZqIPvyazJ9Ox8is25k+zWUlupeFItyIxUBfk
         HJZmry5LTkEQN/2eDEZhpxOsHEovIc304GYVE3Fx+2JuaE8GBJ9QGCEBKctY56quYIj6
         sMNu+0lUodizaLqp5TgVhRCqt7QvEPv/sJr1rKih+6HF/q06c1lD8m9HXexOSfUPP2Ij
         F+F5RuQNpuGNBUrgWo0NGgdqmbLXWVxXl6OzMVzYfQfNViWJrYD/AheMv2G4XgIQfI2n
         AePg==
X-Gm-Message-State: AOAM530JNbutrsxZwNvQuk4JIEcYFFgw2aMFh68SVF3abOHg3l6vwPhb
        9b14MkJbhgW9TOOBv189GTCJXm9JY3E=
X-Google-Smtp-Source: ABdhPJxGWzlw9qvbSJ1Qou7CP6YcgwxTy3WBA+fQdmcULzwjJ/kIALlv4QHG9bbbmYzN9oqphS8ctw==
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr13200280wmh.21.1645735119025;
        Thu, 24 Feb 2022 12:38:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8-20020adfe888000000b001e060f07236sm400650wrm.14.2022.02.24.12.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:38:38 -0800 (PST)
Message-Id: <2f89275314b4a2a89a18d14e41602bbe2e1988dc.1645735117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 20:38:30 +0000
Subject: [PATCH 1/7] test-read-graph: include extra post-parse info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It can be helpful to verify that the 'struct commit_graph' that results
from parsing a commit-graph is correctly structured. The existence of
different chunks is not enough to verify that all of the optional
features are correctly enabled.

Update 'test-tool read-graph' to output an "options:" line that includes
information for different parts of the struct commit_graph.

In particular, this change demonstrates that the read_generation_data
option is never being enabled, which will be fixed in a later change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/helper/test-read-graph.c    | 13 +++++++++++++
 t/t4216-log-bloom.sh          |  1 +
 t/t5318-commit-graph.sh       |  1 +
 t/t5324-split-commit-graph.sh |  5 +++++
 4 files changed, 20 insertions(+)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 75927b2c81d..c3b6b8d1734 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -3,6 +3,7 @@
 #include "commit-graph.h"
 #include "repository.h"
 #include "object-store.h"
+#include "bloom.h"
 
 int cmd__read_graph(int argc, const char **argv)
 {
@@ -45,6 +46,18 @@ int cmd__read_graph(int argc, const char **argv)
 		printf(" bloom_data");
 	printf("\n");
 
+	printf("options:");
+	if (graph->bloom_filter_settings)
+		printf(" bloom(%d,%d,%d)",
+		       graph->bloom_filter_settings->hash_version,
+		       graph->bloom_filter_settings->bits_per_entry,
+		       graph->bloom_filter_settings->num_hashes);
+	if (graph->read_generation_data)
+		printf(" read_generation_data");
+	if (graph->topo_levels)
+		printf(" topo_levels");
+	printf("\n");
+
 	UNLEAK(graph);
 
 	return 0;
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index cc3cebf6722..5ed6d2a21c1 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -48,6 +48,7 @@ graph_read_expect () {
 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
+	options: bloom(1,10,7)
 	EOF
 	test-tool read-graph >actual &&
 	test_cmp expect actual
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index edb728f77c3..2b05026cf6d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -104,6 +104,7 @@ graph_read_expect() {
 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
+	options:
 	EOF
 	test-tool read-graph >output &&
 	test_cmp expect output
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 847b8097109..778fa418de2 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -34,6 +34,7 @@ graph_read_expect() {
 	header: 43475048 1 $(test_oid oid_version) 4 $NUM_BASE
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata generation_data
+	options:
 	EOF
 	test-tool read-graph >output &&
 	test_cmp expect output
@@ -508,6 +509,7 @@ test_expect_success 'setup repo for mixed generation commit-graph-chain' '
 		header: 43475048 1 $(test_oid oid_version) 4 1
 		num_commits: $NUM_SECOND_LAYER_COMMITS
 		chunks: oid_fanout oid_lookup commit_metadata
+		options:
 		EOF
 		test_cmp expect output &&
 		git commit-graph verify &&
@@ -540,6 +542,7 @@ test_expect_success 'do not write generation data chunk if not present on existi
 		header: 43475048 1 $(test_oid oid_version) 4 2
 		num_commits: $NUM_THIRD_LAYER_COMMITS
 		chunks: oid_fanout oid_lookup commit_metadata
+		options:
 		EOF
 		test_cmp expect output &&
 		git commit-graph verify
@@ -581,6 +584,7 @@ test_expect_success 'do not write generation data chunk if the topmost remaining
 		header: 43475048 1 $(test_oid oid_version) 4 2
 		num_commits: $(($NUM_THIRD_LAYER_COMMITS + $NUM_FOURTH_LAYER_COMMITS))
 		chunks: oid_fanout oid_lookup commit_metadata
+		options:
 		EOF
 		test_cmp expect output &&
 		git commit-graph verify
@@ -620,6 +624,7 @@ test_expect_success 'write generation data chunk if topmost remaining layer has
 		header: 43475048 1 $(test_oid oid_version) 5 1
 		num_commits: $(($NUM_SECOND_LAYER_COMMITS + $NUM_THIRD_LAYER_COMMITS + $NUM_FOURTH_LAYER_COMMITS + $NUM_FIFTH_LAYER_COMMITS))
 		chunks: oid_fanout oid_lookup commit_metadata generation_data
+		options:
 		EOF
 		test_cmp expect output
 	)
-- 
gitgitgadget

