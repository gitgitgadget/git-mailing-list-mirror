Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AAA3A8E0
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741550; cv=none; b=Fb7Jf1H4wOseRH7yLpXux7siRTsPfAXdFUjC+gAajlJmfZgFMw01muoejwvCUjez+G33JkLQYwBO9ZHZggVRftpHR1no88FrH8f+C7LAdsJhOMbTkw3zYNEuYlbfjdfd1UuAiIdLsKhmOR3L0S1Wlnf8XZ6JKKcd9YksTsXsTq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741550; c=relaxed/simple;
	bh=Tx53PZbRBDMeIHiec7/7WqFNf3mZcEiYy9/Dp0+afvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq6qJdcGumfSfHXVDTls14+aiBBG40dH17jXHg/rWGfLX43XEBgAs/004Rgx34erHiS3vAD7QzRkP8mnwbjIBW6O3Y8a6kZ7QmlGkqiRYQlMe1PmgUluSLDQ4xmx8mImylN0jfHz9eVosL5TN27hjnB/aQZkQshJkCTtkeNaRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=F+YQvscz; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="F+YQvscz"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6b7df1169so230646276.0
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706741547; x=1707346347; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L7JmEiC/QvMRZuCY1vDkFxL1XU/ro565ss6SRiED2gI=;
        b=F+YQvsczA8RHKb8moo/gKa8NSePwBc7lx1BggvgF4l8OCeSwc3ylA4E6bHgTQLjm5/
         4SO3lPOrxsR65ol3hAB/MNByBLR6G56H8INTMq69W6ao+ZTly+2MxxvMX6PVZreDChzB
         XNxqFAfzZNcNUHf1qUL1vnTwh7FpcWxWLhTWz9zMItpKAi0hknA1xT+Yc76HAl+Rlccm
         n+di1gSGeou/k6J14FRy9e+iRzdQKejwRNvwSFEH9SiA0vUC/EA6Ob1y+ub6wLOLnTjU
         pgdnoDGP6qRBgE/EwSIfDDzZ88Ln58N7lVwMHchXwTz3sWWB/CDA3ITz5TWNyc6dcAlb
         mS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741547; x=1707346347;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7JmEiC/QvMRZuCY1vDkFxL1XU/ro565ss6SRiED2gI=;
        b=RR0rQQGAp8ZafZMzJHNVcSBuZ6DWeNRjmfuppykdryG+aW/1f/hovIPUtznWdxf1CJ
         advTmeGGy9jihxWXO3qL68EStohkpOeyW792X4vOXI9J37h4hz0Tjl9U6dDhsURKdXY8
         gzfktcnhJB7ICkBRogR0ZZyI4X1drd4233EGovYrq46P8D3fFpE7dAv4HakdEWK/oyWu
         js47H9REKCq8Aqp8Lqgz7TgG8wvhQi2cxn8Z6yukzH3udnpn8D7kbW0S2mqVTOYPHxXr
         YxYF9HCqodkEDkfgIfbTF5SU52SUfhTsc+l5CKmFiXSxnFmiAzPoNaBGBg/MQv58SSYD
         NDpA==
X-Gm-Message-State: AOJu0Yy+01nH2ELutbcDmcNIn8eQokBkvM62QzhlnZ/8YDpHZqxCxjV7
	tRDkppYN6wuMZPBmF7tnzWaTyGl1jpQsP4OiH9TS0/Zlga9tCgU0n2bhRkm5W8UO7URRfq7wFiJ
	Kfn8=
X-Google-Smtp-Source: AGHT+IHHa+6VjiMD15sIezGXVizIv9wxyx0fSZ2ZZcLZQs2SYhu5+VZ5Htaux/aadWV5WOvijp7uxw==
X-Received: by 2002:a25:b1a4:0:b0:dc6:8b4:7388 with SMTP id h36-20020a25b1a4000000b00dc608b47388mr490938ybj.35.1706741547367;
        Wed, 31 Jan 2024 14:52:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ow11-20020a0562143f8b00b0068c41c0d346sm1207209qvb.27.2024.01.31.14.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:52:27 -0800 (PST)
Date: Wed, 31 Jan 2024 17:52:26 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v6 03/16] commit-graph: ensure Bloom filters are read with
 consistent settings
Message-ID: <a77ab941bc8867a2a40e02a0f9be4194681aa6e1.1706741516.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1706741516.git.me@ttaylorr.com>

The changed-path Bloom filter mechanism is parameterized by a couple of
variables, notably the number of bits per hash (typically "m" in Bloom
filter literature) and the number of hashes themselves (typically "k").

It is critically important that filters are read with the Bloom filter
settings that they were written with. Failing to do so would mean that
each query is liable to compute different fingerprints, meaning that the
filter itself could return a false negative. This goes against a basic
assumption of using Bloom filters (that they may return false positives,
but never false negatives) and can lead to incorrect results.

We have some existing logic to carry forward existing Bloom filter
settings from one layer to the next. In `write_commit_graph()`, we have
something like:

    if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
        struct commit_graph *g = ctx->r->objects->commit_graph;

        /* We have changed-paths already. Keep them in the next graph */
        if (g && g->chunk_bloom_data) {
            ctx->changed_paths = 1;
            ctx->bloom_settings = g->bloom_filter_settings;
        }
    }

, which drags forward Bloom filter settings across adjacent layers.

This doesn't quite address all cases, however, since it is possible for
intermediate layers to contain no Bloom filters at all. For example,
suppose we have two layers in a commit-graph chain, say, {G1, G2}. If G1
contains Bloom filters, but G2 doesn't, a new G3 (whose base graph is
G2) may be written with arbitrary Bloom filter settings, because we only
check the immediately adjacent layer's settings for compatibility.

This behavior has existed since the introduction of changed-path Bloom
filters. But in practice, this is not such a big deal, since the only
way up until this point to modify the Bloom filter settings at write
time is with the undocumented environment variables:

  - GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY
  - GIT_TEST_BLOOM_SETTINGS_NUM_HASHES
  - GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS

(it is still possible to tweak MAX_CHANGED_PATHS between layers, but
this does not affect reads, so is allowed to differ across multiple
graph layers).

But in future commits, we will introduce another parameter to change the
hash algorithm used to compute Bloom fingerprints itself. This will be
exposed via a configuration setting, making this foot-gun easier to use.

To prevent this potential issue, validate that all layers of a split
commit-graph have compatible settings with the newest layer which
contains Bloom filters.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Original-test-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c       | 25 +++++++++++++++++
 t/t4216-log-bloom.sh | 65 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 45417d7412..216cf03da1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -543,6 +543,30 @@ static int validate_mixed_generation_chain(struct commit_graph *g)
 	return 0;
 }
 
+static void validate_mixed_bloom_settings(struct commit_graph *g)
+{
+	struct bloom_filter_settings *settings = NULL;
+	for (; g; g = g->base_graph) {
+		if (!g->bloom_filter_settings)
+			continue;
+		if (!settings) {
+			settings = g->bloom_filter_settings;
+			continue;
+		}
+
+		if (g->bloom_filter_settings->bits_per_entry != settings->bits_per_entry ||
+		    g->bloom_filter_settings->num_hashes != settings->num_hashes) {
+			g->chunk_bloom_indexes = NULL;
+			g->chunk_bloom_data = NULL;
+			FREE_AND_NULL(g->bloom_filter_settings);
+
+			warning(_("disabling Bloom filters for commit-graph "
+				  "layer '%s' due to incompatible settings"),
+				oid_to_hex(&g->oid));
+		}
+	}
+}
+
 static int add_graph_to_chain(struct commit_graph *g,
 			      struct commit_graph *chain,
 			      struct object_id *oids,
@@ -666,6 +690,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	}
 
 	validate_mixed_generation_chain(graph_chain);
+	validate_mixed_bloom_settings(graph_chain);
 
 	free(oids);
 	fclose(fp);
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index cc6ebc8140..64737b6ee9 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -421,8 +421,71 @@ test_expect_success 'Bloom generation backfills empty commits' '
 	)
 '
 
+graph=.git/objects/info/commit-graph
+graphdir=.git/objects/info/commit-graphs
+chain=$graphdir/commit-graph-chain
+
+test_expect_success 'setup for mixed Bloom setting tests' '
+	repo=mixed-bloom-settings &&
+
+	git init $repo &&
+	for i in one two three
+	do
+		test_commit -C $repo $i file || return 1
+	done
+'
+
+test_expect_success 'ensure Bloom filters with incompatible settings are ignored' '
+	# Compute Bloom filters with "unusual" settings.
+	git -C $repo rev-parse one >in &&
+	GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=3 git -C $repo commit-graph write \
+		--stdin-commits --changed-paths --split <in &&
+	layer=$(head -n 1 $repo/$chain) &&
+
+	# A commit-graph layer without Bloom filters "hides" the layers
+	# below ...
+	git -C $repo rev-parse two >in &&
+	git -C $repo commit-graph write --stdin-commits --no-changed-paths \
+		--split=no-merge <in &&
+
+	# Another commit-graph layer that has Bloom filters, but with
+	# standard settings, and is thus incompatible with the base
+	# layer written above.
+	git -C $repo rev-parse HEAD >in &&
+	git -C $repo commit-graph write --stdin-commits --changed-paths \
+		--split=no-merge <in &&
+
+	test_line_count = 3 $repo/$chain &&
+
+	# Ensure that incompatible Bloom filters are ignored.
+	git -C $repo -c core.commitGraph=false log --oneline --no-decorate -- file \
+		>expect 2>err &&
+	git -C $repo log --oneline --no-decorate -- file >actual 2>err &&
+	test_cmp expect actual &&
+	grep "disabling Bloom filters for commit-graph layer .$layer." err
+'
+
+test_expect_success 'merge graph layers with incompatible Bloom settings' '
+	# Ensure that incompatible Bloom filters are ignored when
+	# merging existing layers.
+	git -C $repo commit-graph write --reachable --changed-paths 2>err &&
+	grep "disabling Bloom filters for commit-graph layer .$layer." err &&
+
+	test_path_is_file $repo/$graph &&
+	test_dir_is_empty $repo/$graphdir &&
+
+	git -C $repo -c core.commitGraph=false log --oneline --no-decorate -- \
+		file >expect &&
+	trace_out="$(pwd)/trace.perf" &&
+	GIT_TRACE2_PERF="$trace_out" \
+		git -C $repo log --oneline --no-decorate -- file >actual 2>err &&
+
+	test_cmp expect actual &&
+	grep "statistics:{\"filter_not_present\":0," trace.perf &&
+	test_must_be_empty err
+'
+
 corrupt_graph () {
-	graph=.git/objects/info/commit-graph &&
 	test_when_finished "rm -rf $graph" &&
 	git commit-graph write --reachable --changed-paths &&
 	corrupt_chunk_file $graph "$@"
-- 
2.43.0.509.g253f65a7fc

