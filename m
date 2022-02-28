Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E39C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 13:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbiB1Ny3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 08:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiB1NyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 08:54:25 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09842403C0
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 05:53:47 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r10so15599944wrp.3
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 05:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wvtv2pR79CcNIaHW+fTGq/M5gGXZdqURJ8pamHD494U=;
        b=H0Xe1WApma9LkzyivbiZC0XourDR5hbim3a/Bwrs28+3uhRUjGx5Io5Pn6P/DSqCOB
         tX/LTbInD6QRF26F/IhEccB+dJ5nR73ySq+0Xwr7bQEdB0FTbnRAMqc+R1tGM9kIHeeB
         6tEdr1G41YJeXH6Z4JfvmeXfQEIOlgDulHefGJcE7Iea7rEPPycPoQzIowY4Tf5vPnfL
         gzLMHMCivgTy49bEiiN8TMePNdsvjUv3h0YHK6gSvZTVXEYaCZKs5buXrIcMc2YmtAS9
         a+NkhF3dKTCqNgGBb+a9Z54XRekoDZvti10q4AeLgi4G+f75+vXlX0t97/GCkCbKRYSc
         Ju4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wvtv2pR79CcNIaHW+fTGq/M5gGXZdqURJ8pamHD494U=;
        b=qd9n94vTpyUN0cKL0RmQTOx0FVR43ANP0rgTlRCFbO0LVOy8vSVCqnVb2cSzz0HbV+
         MhVKS8UKezfm1CzQ8BIE7ZDEBaSp5vEObBtw09IftCw0cfMnrnNF0Ui3N8yPpWUZmnDa
         mryQP4SZoc475SfaAsbCGTxy6DbtfQBaIWRZo5bf9Luy9awaEwAnONfDtpEZikVzPZI7
         qKUzhNL5P48t7h56KQh5CnNk6rtUAugRSJNtUAR35nckV2mIdwc1Jj9UpU0RezNhdudW
         22jDhU0P0l4+fA9xscbVkB8UeNb/fsaR4w/K0K5Uwe3YvaurPuESRgqnOszjd08dW6Y0
         W8JQ==
X-Gm-Message-State: AOAM5309fYnnoq1xLdynkZICXbVMXb7IumCJZwq/QQ/kUjDKCA2IM+Ol
        FZKTLHrW7XurVxwXPFHF8nX1n6O0bRk=
X-Google-Smtp-Source: ABdhPJxkyUMLD4/N8bVpyBwkyVpukB8/kfOJDePR9StOcRIxIeysaCPFRWwcuahSJmiqapSYnwB4bg==
X-Received: by 2002:adf:fbd0:0:b0:1e6:8ec3:570 with SMTP id d16-20020adffbd0000000b001e68ec30570mr16810464wrs.396.1646056425432;
        Mon, 28 Feb 2022 05:53:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d51c7000000b001a38105483dsm10648944wrv.24.2022.02.28.05.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:53:44 -0800 (PST)
Message-Id: <2f89275314b4a2a89a18d14e41602bbe2e1988dc.1646056423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
        <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Feb 2022 13:53:40 +0000
Subject: [PATCH v2 1/4] test-read-graph: include extra post-parse info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        avarab@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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

