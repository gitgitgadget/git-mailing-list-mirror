Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE66C4332F
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 19:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbiCATur (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbiCATuU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 14:50:20 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C205C554B0
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 11:49:11 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b5so22234855wrr.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 11:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=351duXGBBzHl172YvPTgEEx/kdUTzFDdFxEhP4jeM00=;
        b=CHc6HBx0DzZYxEcMv7TNJYBTtMhN7bohVXdFCcVxsE+aM07HIVO89g5zmjQNQASnJC
         8VvOT2pNo/4c+AFemxNBJV2EkCAnuNJKq0HZTIQso0EQ3wW1O5QBrOyaobc9+b6ILE7E
         o5f1PHRJ8Ogxn8ByVks1gNhS9/9Ogzics0l15Crgpi+XWX69jZDWS8L01t1sJmUzYMKQ
         6QUR8lK/1zg5GtFsZbR6v8Oaa4+GNyaDLIEDu/TSLPPCjS0Ns22zAQN+TNLwS1Mq6J58
         WtXZiCLAl37AAzK5VkqKzyw2DBB0GIm03kZuV3+iBZDSwHEDXncZsCHyM+VRRuet+muL
         F/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=351duXGBBzHl172YvPTgEEx/kdUTzFDdFxEhP4jeM00=;
        b=64bmwgnJ0rQnLYQsmTRqshTanGOKbU7obU5hVSORJZ6kOEYFWK+PP7UF0dWfkUK7jT
         g4npC1HtuwcmaMUVQ16acF9l6thc3Ti4od4gvMNc7NmpjgUToYMsBae3QKi3UGCH4jSN
         TRUN+10zTFgf83B1WwdlC9NFDrna9XIZDplioie4cXdv6p5LbWCZhcK/gBv+5N0yOi8+
         xTYpg6lgboktOuDgTmdowvN7PDRpkE0PQDpB88g4yOrKeSmbzATNglXFFr724BzyLsz2
         BvNHq7lGqNPKsIDXGro/1/rhAq4XeR4UHy0dXKmhjntpVkvlkEFYURZBD5qK6FVwC3Eu
         kCHg==
X-Gm-Message-State: AOAM530iN32s6PvUrcy4EVd5ohPaNpQfDoD5PS7AUowslGWoBScLuxPM
        gbocLbQX/yPYVTtaozAgzIVy0Qm5RzU=
X-Google-Smtp-Source: ABdhPJzYr2vvk3BThlFA50FUB/uD2F96ua9Zlg6f+i18QZaWFUvFFViXVhNa5z+u/Qe0SntgYXzd2Q==
X-Received: by 2002:a5d:6405:0:b0:1ef:7df1:5c04 with SMTP id z5-20020a5d6405000000b001ef7df15c04mr13866086wru.178.1646164117182;
        Tue, 01 Mar 2022 11:48:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d69cb000000b001ef5b49d68esm14785022wrw.37.2022.03.01.11.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 11:48:36 -0800 (PST)
Message-Id: <041d96bf1d7fecbae946ad71cbe2dc0b3492fd65.1646164112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.v3.git.1646164112.gitgitgadget@gmail.com>
References: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
        <pull.1163.v3.git.1646164112.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 19:48:31 +0000
Subject: [PATCH v3 4/5] commit-graph: start parsing generation v2 (again)
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
 t/lib-commit-graph.sh         | 12 +++++++++++-
 t/t4216-log-bloom.sh          |  2 +-
 t/t5318-commit-graph.sh       |  2 +-
 t/t5324-split-commit-graph.sh |  9 +++++++--
 5 files changed, 23 insertions(+), 5 deletions(-)

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
diff --git a/t/lib-commit-graph.sh b/t/lib-commit-graph.sh
index 07e12b9d2fe..5d79e1a4e96 100755
--- a/t/lib-commit-graph.sh
+++ b/t/lib-commit-graph.sh
@@ -37,11 +37,21 @@ graph_read_expect() {
 		OPTIONAL=" $2"
 		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
 	fi
+	GENERATION_VERSION=2
+	if test -n "$3"
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
index 0ed7e9de8e6..fbf0d64578c 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -456,7 +456,7 @@ test_expect_success 'git commit-graph verify' '
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

