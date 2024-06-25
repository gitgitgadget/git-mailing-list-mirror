Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFEA135A69
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337161; cv=none; b=Cu2fFAuJLOptJwDNyXU5egSu4VYh7OtdEslly7ORTAtWzP/Yrh8uJcw9cP6x770kPc9N085A2tdF267ubd0euSxg8KKKVtv4cX43eIlC2JCYpheFXi4Ake7qnOyw8KnkE1Dk5IBg4lOXRz8vDfu7qVkjtqs4Zsu6+XUH8DPYwtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337161; c=relaxed/simple;
	bh=67pqoho0rZtX6XgF1sZBla1YYQUDFKa4eaJtIUWpJLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMbaD7JkI1jb93JnqOK0crwwZkZhtxpUEg8m9oLHy9IhPDMsoUbVx9fWHIfRPbY0GW94IQGEniNyhjWvoy2FVRl/qlgRhTUF2adVA+PB41jyifQRkWU9nF7Dt3oMdgecV7gqvzyzOMxyF1QeumXB9W4G+WSGfYGla4AcDdXQncI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1wFB1xcw; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1wFB1xcw"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dfab4779d95so5738541276.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1719337158; x=1719941958; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ni/yv9aus9DfElXlnyWyNuzjC9sTbva/aRjxmi0SH5w=;
        b=1wFB1xcwQVwFxvI2DBAU2c8bi7p3A3JRF60Lqmb1LhOnPD/lb7YhdHHmg1s4ioYtlT
         TqCGZ2tnYIL6XE803yHZPxf44VapKF/4NkfYX0Msfqw3NGdo6GGWuYP//nJO9ss38CWa
         m69UdgISw/T55IPd9P2hOHfhv0iZI6wvng+hBhPARzjOZKL2THtPRnSVneB6Df3SlcvR
         TLCCLm6XimJrhO6MC5bsEEmRJdJnK99lRVpCxNSpmucSLQXzfA+hPVON88zhH31mup+K
         APFiO41ZzS0o15//uAOulbTIT+JlHBGAHBhB9p6KeIRqD7JkST4Vwb5Gm0q3keg2fAz9
         VA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337158; x=1719941958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ni/yv9aus9DfElXlnyWyNuzjC9sTbva/aRjxmi0SH5w=;
        b=Xtyf9AVrUVkgXCY3SHHRB6kS9S8YBwb2x7oqnq5AJQY1zZdNll6rOBtfczX7YdWIlR
         Nz7y/p3n/zfauvzrk4UeDO5SOJw+PIPxxzysFc1bzFH5q38s00bsQPwNaeVZPwLVawKT
         tq3CeInI+9s+NIuIQ36Fii7s3FYUPhokwzhLAKo5qxX0XGczEA3gX4283dUQ2kt1YrSB
         VBytzMNFrpI/FlhndhmLgy+4wSDvEH0MZCk24JDjzzACxJkBmx4uYHSwkACoJS0UWa45
         9RpukgD35P5D2AeN37sObeqUV0/eZ3D9boEkA4YTUeoC30ScUSi78Y5da0bn5yFnvqgW
         DEqQ==
X-Gm-Message-State: AOJu0Yx9wP4NMQKfvwrsoGt1p7SMA3aMtmjgJc3Joh06rXjV+NsTaI5v
	aUqbrpH+tbxRXMNT5TJo1v/hNcvz7T2DvoPJ9ZeR9rPDPjs2JvjapEc82Ge5R+9OfM1FGlJPxQR
	xqiA=
X-Google-Smtp-Source: AGHT+IFNJtabgRDAgzjZvTriBVEvHS7DcUzfv8s/L5mM1UxFSm9YbcNqVt4sNKacdEU4ycrVlh2LsQ==
X-Received: by 2002:a25:2b89:0:b0:dff:af1:8976 with SMTP id 3f1490d57ef6-e030404eec7mr8272750276.64.1719337158024;
        Tue, 25 Jun 2024 10:39:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef30eebsm46756436d6.97.2024.06.25.10.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:39:17 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:39:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 03/16] commit-graph: ensure Bloom filters are read with
 consistent settings
Message-ID: <f6cf5bfc4eae2945cf2811172ccdb1293d4b0499.1719333276.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
 <cover.1719333276.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719333276.git.me@ttaylorr.com>

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
 commit-graph.c       | 25 ++++++++++++++++
 t/t4216-log-bloom.sh | 68 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 595a349c56..3d89febae4 100644
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
index cc6ebc8140..c1977961d0 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -421,8 +421,74 @@ test_expect_success 'Bloom generation backfills empty commits' '
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
+	>trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+		git -C $repo commit-graph write --reachable --changed-paths 2>err &&
+	grep "disabling Bloom filters for commit-graph layer .$layer." err &&
+	grep "{\"hash_version\":1,\"num_hashes\":7,\"bits_per_entry\":10,\"max_changed_paths\":512" trace2.txt &&
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
2.45.2.664.g446e6a2b1f

