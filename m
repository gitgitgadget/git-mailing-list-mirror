Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496D9C433FE
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 13:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbiB1Nye (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 08:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiB1Ny1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 08:54:27 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB504419A7
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 05:53:48 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b5so15629502wrr.2
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 05:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=7Z5V7sOeHr0ggnLaIE0MmZnuQTZSihaETgiBRpj/V28=;
        b=YzW2cMSfkA4gkVTktIMNe4U053nrDEZPO2+erOh2YLDA5aSFArd+rqeDS2hlWa/AcP
         uHgCTTHKZtMteUkWpuJwBdXYNs0H7LSFOt3U9zVcPB+zHYQ5O0GxT8+um+fgJ2pjExxB
         fGr9yKWFh3s6kEH9FQJntXbaynObHIdM7L/j4MDdhrFWOopFCDNmbDvPb4h7qOetw2ti
         M9HkSrik8X9NaswF5wuqdheELfMoRDdrD1larofSRTNGGzSudJzHmnqpYkclcNjKyJ57
         kWGGk9N7z+g4yeZPYqEQLDy+fbhzH7EMsPlqOie2HfJuU0vrXmsRC9SychHV/wZ/oCkC
         a3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=7Z5V7sOeHr0ggnLaIE0MmZnuQTZSihaETgiBRpj/V28=;
        b=xHeohzK6iRwrbUqGdqDrSmtfANKmGogPu4fJSLbjDI/yRW5miaNSqyRJFZlWAsp7gX
         OtBxONJG+4fa4iaPIVykRpeqb+dvCIgmuMq8ZGQd4OPVHT45KfktlN1YeJT2EQzrYAQa
         k4xjIlB6BJ/SPafA1L0UZIA5NArh2QTPObhfVVcFEvxI/gzKIUzmBE/ih09dmdNsUr/E
         FoKIS556XS8ymDAswxtQTLp7eTrq4+455vmri9PLOEdb9Lq56Eb4aoldYC4O+QWS2L0V
         tUFsrw0cZ/u5K6kcI/825iqxOkbv8JKkWel4lFjPkVdioQTqK3Xb9VEU2+d6Frdmf96h
         zNAg==
X-Gm-Message-State: AOAM532EU9LpXY2AVi7oAUQOA5SkBBG4uxzxf0pofgQiPggN5Sl/GA8b
        mxQ6WGL6uWw19cqux53sZi2TL6OmAxU=
X-Google-Smtp-Source: ABdhPJwcCX6/P0/q/JNmd3kjRzOLF1kFsSuh7pdprqgp41qqH8pBoALsi4aqN7/ieTdpk+LtOJWQgw==
X-Received: by 2002:a5d:588a:0:b0:1e8:b478:e74f with SMTP id n10-20020a5d588a000000b001e8b478e74fmr16221150wrf.210.1646056427160;
        Mon, 28 Feb 2022 05:53:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d53ca000000b001d847134b04sm10454358wrw.97.2022.02.28.05.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:53:46 -0800 (PST)
Message-Id: <5bc6a7660d897ca6c52eabba8fb9ecfb6304dabb.1646056423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
        <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Feb 2022 13:53:42 +0000
Subject: [PATCH v2 3/4] commit-graph: start parsing generation v2 (again)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        avarab@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'read_generation_data' member of 'struct commit_graph' was
introduced by 1fdc383c5 (commit-graph: use generation v2 only if entire
chain does, 2021-01-16). The intention was to avoid using corrected
commit dates if not all layers of a commit-graph had that data stored.
The logic in validate_mixed_generation_chain() at that point incorrectly
initialized read_generation_data to 1 if and only if the tip
commit-graph contained the Corrected Commit Date chunk.

This was "fixed" in 448a39e65 (commit-graph: validate layers for
generation data, 2021-02-02) to validate that read_generation_data was
either non-zero for all layers, or it would set read_generation_data to
zero for all layers.

The problem here is that read_generation_data is not initialized to be
non-zero anywhere!

This change initializes read_generation_data immediately after the chunk
is parsed, so each layer will have its value present as soon as
possible.

The read_generation_data member is used in fill_commit_graph_info() to
determine if we should use the corrected commit date or the topological
levels stored in the Commit Data chunk. Due to this bug, all previous
versions of Git were defaulting to topological levels in all cases!

This can be measured with some performance tests. Using the Linux kernel
as a testbed, I generated a complete commit-graph containing corrected
commit dates and tested the 'new' version against the previous, 'old'
version.

First, rev-list with --topo-order demonstrates a 26% improvement using
corrected commit dates:

hyperfine \
	-n "old" "$OLD_GIT rev-list --topo-order -1000 v3.6" \
	-n "new" "$NEW_GIT rev-list --topo-order -1000 v3.6" \
	--warmup=10

Benchmark 1: old
  Time (mean ± σ):      57.1 ms ±   3.1 ms
  Range (min … max):    52.9 ms …  62.0 ms    55 runs

Benchmark 2: new
  Time (mean ± σ):      45.5 ms ±   3.3 ms
  Range (min … max):    39.9 ms …  51.7 ms    59 runs

Summary
  'new' ran
    1.26 ± 0.11 times faster than 'old'

These performance improvements are due to the algorithmic improvements
given by walking fewer commits due to the higher cutoffs from corrected
commit dates.

However, this comes at a cost. The additional I/O cost of parsing the
corrected commit dates is visible in case of merge-base commands that do
not reduce the overall number of walked commits.

hyperfine \
        -n "old" "$OLD_GIT merge-base v4.8 v4.9" \
        -n "new" "$NEW_GIT merge-base v4.8 v4.9" \
        --warmup=10

Benchmark 1: old
  Time (mean ± σ):     110.4 ms ±   6.4 ms
  Range (min … max):    96.0 ms … 118.3 ms    25 runs

Benchmark 2: new
  Time (mean ± σ):     150.7 ms ±   1.1 ms
  Range (min … max):   149.3 ms … 153.4 ms    19 runs

Summary
  'old' ran
    1.36 ± 0.08 times faster than 'new'

Performance issues like this are what motivated 702110aac (commit-graph:
use config to specify generation type, 2021-02-25).

In the future, we could fix this performance problem by inserting the
corrected commit date offsets into the Commit Date chunk instead of
having that data in an extra chunk.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-graph.c                |  3 +++
 t/t4216-log-bloom.sh          |  2 +-
 t/t5318-commit-graph.sh       | 14 ++++++++++++--
 t/t5324-split-commit-graph.sh |  9 +++++++--
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index a19bd96c2ee..8e52bb09552 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -407,6 +407,9 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 			&graph->chunk_generation_data);
 		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
 			&graph->chunk_generation_data_overflow);
+
+		if (graph->chunk_generation_data)
+			graph->read_generation_data = 1;
 	}
 
 	if (r->settings.commit_graph_read_changed_paths) {
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 5ed6d2a21c1..fa9d32facfb 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -48,7 +48,7 @@ graph_read_expect () {
 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
-	options: bloom(1,10,7)
+	options: bloom(1,10,7) read_generation_data
 	EOF
 	test-tool read-graph >actual &&
 	test_cmp expect actual
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index f9bffe38013..1afee1c2705 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -100,11 +100,21 @@ graph_read_expect() {
 		OPTIONAL=" $2"
 		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
 	fi
+	GENERATION_VERSION=2
+	if test ! -z "$3"
+	then
+		GENERATION_VERSION=$3
+	fi
+	OPTIONS=
+	if test $GENERATION_VERSION -gt 1
+	then
+		OPTIONS=" read_generation_data"
+	fi
 	cat >expect <<- EOF
 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
-	options:
+	options:$OPTIONS
 	EOF
 	test-tool read-graph >output &&
 	test_cmp expect output
@@ -498,7 +508,7 @@ test_expect_success 'git commit-graph verify' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git rev-parse commits/8 | git -c commitGraph.generationVersion=1 commit-graph write --stdin-commits &&
 	git commit-graph verify >output &&
-	graph_read_expect 9 extra_edges
+	graph_read_expect 9 extra_edges 1
 '
 
 NUM_COMMITS=9
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 778fa418de2..669ddc645fa 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -30,11 +30,16 @@ graph_read_expect() {
 	then
 		NUM_BASE=$2
 	fi
+	OPTIONS=
+	if test -z "$3"
+	then
+		OPTIONS=" read_generation_data"
+	fi
 	cat >expect <<- EOF
 	header: 43475048 1 $(test_oid oid_version) 4 $NUM_BASE
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata generation_data
-	options:
+	options:$OPTIONS
 	EOF
 	test-tool read-graph >output &&
 	test_cmp expect output
@@ -624,7 +629,7 @@ test_expect_success 'write generation data chunk if topmost remaining layer has
 		header: 43475048 1 $(test_oid oid_version) 5 1
 		num_commits: $(($NUM_SECOND_LAYER_COMMITS + $NUM_THIRD_LAYER_COMMITS + $NUM_FOURTH_LAYER_COMMITS + $NUM_FIFTH_LAYER_COMMITS))
 		chunks: oid_fanout oid_lookup commit_metadata generation_data
-		options:
+		options: read_generation_data
 		EOF
 		test_cmp expect output
 	)
-- 
gitgitgadget

