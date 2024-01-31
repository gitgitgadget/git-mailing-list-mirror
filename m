Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A41D3A27B
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741542; cv=none; b=SIL5h0ZgHbSGybsS0uCzIc/NYn8TXU510sgYmBg/tkWnYOe+jSpktJ8D52Hgd8aaCG/0vs//W2IwghCCf49UijXA1ApUgglulHijOCiW0SPoZe7NE9+gz8/YIPwrjYkpbREpu6Rrg2+f7/4Zokb+xtjLsUfnqpFC7vAFkf8Q/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741542; c=relaxed/simple;
	bh=fPqpK1i9ViSRSEH7LiQV0UNbXR0L5ZqZi9gu9Xgify4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aTmBpYm9PXdGEn93CvQ3HFnXJA2jN2Usynyh18ktk4bT/ijdJEzxmpVm4/oTjSMJiyZONirH/oqgqTxKYC7mOS5JwRskT1M7Kb6647Pngygvjt3unmJQe6e6kaT9XnXV5lK2yUdtc9LRB0T9Ey6Fp9FwlWXBihXqwWgMZxAZh5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Yeiw2V+l; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Yeiw2V+l"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bebc25da94so208541b6e.2
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706741539; x=1707346339; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIIHpjl/cKPJTyc3zGpKI4+Ckn63gm8Qr9R2RqXjH9c=;
        b=Yeiw2V+la0BRN36Bod3IyaXnENg6YWj8WZW4P31Wsq0wx61MAT29VK+tCP7cm8kblw
         TicIMPDqSbS7CuycL67kGYbJ+4wwbCK0KPHHQNchDLiIKmWO58/bW4PLNHIdAs0KLV+V
         tnierLvXS7V2AudUm6e3u9W3quSNig1POE/Js2sGMrlnf1ByKgV4DmE6HRxxAY25eXfk
         ZYuabPghClt+Z5TxQdU0Nf1SUer9hoSJHOpsUIDwZ3hXyM0yv3t3Von/vQkO7xKqyf0A
         IfO0HK3UdkxMic5oJ1MKGik9eSEdUfETzAvrLhuRZNcVq/+6D/yfjd6R7tH5n5Tgu+lg
         U5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741539; x=1707346339;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIIHpjl/cKPJTyc3zGpKI4+Ckn63gm8Qr9R2RqXjH9c=;
        b=KCh8awjGnyCjgRcQy2/Ea+KFb5GZgorkW6wFWCKXZD4sns4u8Z7BgieQK960MSoo3s
         uYgoz0XWMG30vQ3LDIfeenEX3F6on4YWDSSA6NmFaRJj6rB+3QoDg+CLbJA0FQncrB7e
         edR9GqH7QUxDBVGHdH7yrtGR2cck6AkZgrkCn47t9pIiqjt4mvMaKppmAUJPNEpAa5i/
         gUiKx4UyNApfu5ef/XRZp7jw66aSciNimSSTxZ6B5VSKeCicGsBRBNmd6r/E8+LT9/DV
         Bib6AW6UwEAuuneb0vwXmR4I5BvMoEBKo9IKay3TwBWQaok6JyKQyzA8A3LQCw1LJv6+
         L2zw==
X-Gm-Message-State: AOJu0YwbMo+5CjdQLRrAuwXfarUR+rWYqqzS9ZioWACRsgOCUcSEdDnJ
	uLBA6NbnWEuwbJ8lmY9XqSrb58zJDszE3HpIqht0Sk9eGG0+3dTO4LXxiW0ozy6m795fFF/V2rM
	zVBw=
X-Google-Smtp-Source: AGHT+IHasz77WzzXpa/R5ua8teKCgUi59S/zGDMZfN7keXA8k5HkAopm8It5XNeaQKpYma1P3/5q2Q==
X-Received: by 2002:a54:418c:0:b0:3be:1f50:1c7 with SMTP id 12-20020a54418c000000b003be1f5001c7mr2901041oiy.17.1706741538853;
        Wed, 31 Jan 2024 14:52:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s18-20020ae9f712000000b00783f8693df1sm3393595qkg.37.2024.01.31.14.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:52:18 -0800 (PST)
Date: Wed, 31 Jan 2024 17:52:08 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v6 00/16] bloom: changed-path Bloom filters v2 (& sundries)
Message-ID: <cover.1706741516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

(Rebased onto the tip of 'master', which is now bc7ee2e5e1 (The twelfth
batch, 2024-01-30), at the time of writing).

This series is a minor reroll of the combined efforts of [1] and [2] to
introduce the v2 changed-path Bloom filters, which fixes a bug in our
existing implementation of murmur3 paths with non-ASCII characters (when
the "char" type is signed).

This version is nearly identical to the previous round, modulo some
patch reorganization prompted by a test failure noticed by SZEDER [3].
I'm still not sure how that failure got through, but this round fixes
it, and I've double checked that 'git rebase -ix "make test"' passes on
across all revisions.

Thanks again to Jonathan, Peff, and SZEDER who have helped a great deal
in assembling these patches. As usual, a range-diff is included below.

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/cover.1684790529.git.jonathantanmy@google.com/
[2]: https://lore.kernel.org/git/cover.1691426160.git.me@ttaylorr.com/
[3]: https://lore.kernel.org/git/20240129212614.GB9612@szeder.dev/

Jonathan Tan (1):
  gitformat-commit-graph: describe version 2 of BDAT

Taylor Blau (15):
  t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
  revision.c: consult Bloom filters for root commits
  commit-graph: ensure Bloom filters are read with consistent settings
  t/helper/test-read-graph.c: extract `dump_graph_info()`
  bloom.h: make `load_bloom_filter_from_graph()` public
  t/helper/test-read-graph: implement `bloom-filters` mode
  t4216: test changed path filters with high bit paths
  repo-settings: introduce commitgraph.changedPathsVersion
  bloom: annotate filters with hash version
  bloom: prepare to discard incompatible Bloom filters
  commit-graph: unconditionally load Bloom filters
  commit-graph: new Bloom filter version that fixes murmur3
  object.h: fix mis-aligned flag bits table
  commit-graph: reuse existing Bloom filters where possible
  bloom: introduce `deinit_bloom_filters()`

 Documentation/config/commitgraph.txt     |  29 ++-
 Documentation/gitformat-commit-graph.txt |   9 +-
 bloom.c                                  | 208 ++++++++++++++-
 bloom.h                                  |  38 ++-
 commit-graph.c                           |  64 ++++-
 object.h                                 |   3 +-
 oss-fuzz/fuzz-commit-graph.c             |   2 +-
 repo-settings.c                          |   6 +-
 repository.h                             |   2 +-
 revision.c                               |  26 +-
 t/helper/test-bloom.c                    |   9 +-
 t/helper/test-read-graph.c               |  67 ++++-
 t/t0095-bloom.sh                         |   8 +
 t/t4216-log-bloom.sh                     | 310 ++++++++++++++++++++++-
 14 files changed, 723 insertions(+), 58 deletions(-)

Range-diff against v5:
 1:  6292e974c5 =  1:  9df34a2f4f t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
 2:  6437cf5888 =  2:  a6dc377f1b revision.c: consult Bloom filters for root commits
 3:  d5a73b9fa6 !  3:  a77ab941bc commit-graph: ensure Bloom filters are read with consistent settings
    @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backfills empty comm
     +	done
     +'
     +
    -+test_expect_success 'ensure incompatible Bloom filters are ignored' '
    ++test_expect_success 'ensure Bloom filters with incompatible settings are ignored' '
     +	# Compute Bloom filters with "unusual" settings.
     +	git -C $repo rev-parse one >in &&
     +	GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=3 git -C $repo commit-graph write \
 4:  85af5e80ef =  4:  56a9fdaff0 gitformat-commit-graph: describe version 2 of BDAT
 5:  b5ff3a9b34 =  5:  7484a82f7f t/helper/test-read-graph.c: extract `dump_graph_info()`
 6:  1b45dc8d85 =  6:  48343f93a2 bloom.h: make `load_bloom_filter_from_graph()` public
 7:  42b5126016 =  7:  286fd7dcdb t/helper/test-read-graph: implement `bloom-filters` mode
 8:  2029a2e30c =  8:  7de7b89da0 t4216: test changed path filters with high bit paths
 9:  79c6c3025a !  9:  b13c9b8ff9 repo-settings: introduce commitgraph.changedPathsVersion
    @@ repository.h: struct repo_settings {
      	int gc_write_commit_graph;
      	int fetch_write_commit_graph;
      	int command_requires_full_index;
    -
    - ## t/t4216-log-bloom.sh ##
    -@@ t/t4216-log-bloom.sh: test_expect_success 'setup for mixed Bloom setting tests' '
    - 	done
    - '
    - 
    --test_expect_success 'ensure incompatible Bloom filters are ignored' '
    -+test_expect_success 'ensure Bloom filters with incompatible settings are ignored' '
    - 	# Compute Bloom filters with "unusual" settings.
    - 	git -C $repo rev-parse one >in &&
    - 	GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=3 git -C $repo commit-graph write \
    -@@ t/t4216-log-bloom.sh: test_expect_success 'merge graph layers with incompatible Bloom settings' '
    - 	test_must_be_empty err
    - '
    - 
    -+test_expect_success 'ensure Bloom filter with incompatible versions are ignored' '
    -+	rm "$repo/$graph" &&
    -+
    -+	git -C $repo log --oneline --no-decorate -- $CENT >expect &&
    -+
    -+	# Compute v1 Bloom filters for commits at the bottom.
    -+	git -C $repo rev-parse HEAD^ >in &&
    -+	git -C $repo commit-graph write --stdin-commits --changed-paths \
    -+		--split <in &&
    -+
    -+	# Compute v2 Bloomfilters for the rest of the commits at the top.
    -+	git -C $repo rev-parse HEAD >in &&
    -+	git -C $repo -c commitGraph.changedPathsVersion=2 commit-graph write \
    -+		--stdin-commits --changed-paths --split=no-merge <in &&
    -+
    -+	test_line_count = 2 $repo/$chain &&
    -+
    -+	git -C $repo log --oneline --no-decorate -- $CENT >actual 2>err &&
    -+	test_cmp expect actual &&
    -+
    -+	layer="$(head -n 1 $repo/$chain)" &&
    -+	cat >expect.err <<-EOF &&
    -+	warning: disabling Bloom filters for commit-graph layer $SQ$layer$SQ due to incompatible settings
    -+	EOF
    -+	test_cmp expect.err err
    -+'
    -+
    - get_first_changed_path_filter () {
    - 	test-tool read-graph bloom-filters >filters.dat &&
    - 	head -n 1 filters.dat
11:  a73c77a5ba = 10:  09c44c51a5 bloom: annotate filters with hash version
12:  0c62b36206 = 11:  d4995ef600 bloom: prepare to discard incompatible Bloom filters
13:  ff348fc49d ! 12:  c8e9bb7c88 commit-graph.c: unconditionally load Bloom filters
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    commit-graph.c: unconditionally load Bloom filters
    +    commit-graph: unconditionally load Bloom filters
     
         In an earlier commit, we began ignoring the Bloom data ("BDAT") chunk
         for commit-graphs whose Bloom filters were computed using a hash version
    -      incompatible with the value of `commitGraph.changedPathVersion`.
    +    incompatible with the value of `commitGraph.changedPathVersion`.
     
         Now that the Bloom API has been hardened to discard these incompatible
         filters (with the exception of low-level APIs), we can safely load these
    @@ Commit message
     
      ## commit-graph.c ##
     @@ commit-graph.c: static int graph_read_bloom_data(const unsigned char *chunk_start,
    - 
    + 	g->chunk_bloom_data_size = chunk_size;
      	hash_version = get_be32(chunk_start);
      
    --	if (*c->commit_graph_changed_paths_version == -1)
    --		*c->commit_graph_changed_paths_version = hash_version;
    --	else if (hash_version != *c->commit_graph_changed_paths_version)
    +-	if (hash_version != 1)
     -		return 0;
     -
    - 	g->chunk_bloom_data = chunk_start;
    - 	g->chunk_bloom_data_size = chunk_size;
      	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
    + 	g->bloom_filter_settings->hash_version = hash_version;
    + 	g->bloom_filter_settings->num_hashes = get_be32(chunk_start + 4);
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
      	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
      	ctx->num_generation_data_overflows = 0;
      
    --	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version == 2
    --		? 2 : 1;
     +	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version;
      	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
      						      bloom_settings.bits_per_entry);
      	bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
      		/* We have changed-paths already. Keep them in the next graph */
    - 		if (g && g->bloom_filter_settings) {
    + 		if (g && g->chunk_bloom_data) {
      			ctx->changed_paths = 1;
     -			ctx->bloom_settings = g->bloom_filter_settings;
     +
10:  cfa5c358f8 ! 13:  d2f11c082d commit-graph: new Bloom filter version that fixes murmur3
    @@ bloom.h: int load_bloom_filter_from_graph(struct commit_graph *g,
      		    size_t len,
     
      ## commit-graph.c ##
    -@@ commit-graph.c: static int graph_read_bloom_index(const unsigned char *chunk_start,
    - 	return 0;
    - }
    - 
    -+struct graph_read_bloom_data_context {
    -+	struct commit_graph *g;
    -+	int *commit_graph_changed_paths_version;
    -+};
    -+
    - static int graph_read_bloom_data(const unsigned char *chunk_start,
    +@@ commit-graph.c: static int graph_read_bloom_data(const unsigned char *chunk_start,
      				  size_t chunk_size, void *data)
      {
    --	struct commit_graph *g = data;
    -+	struct graph_read_bloom_data_context *c = data;
    -+	struct commit_graph *g = c->g;
    - 	uint32_t hash_version;
    + 	struct commit_graph *g = data;
    +-	uint32_t hash_version;
      
      	if (chunk_size < BLOOMDATA_CHUNK_HEADER_SIZE) {
    + 		warning(_("ignoring too-small changed-path chunk"
     @@ commit-graph.c: static int graph_read_bloom_data(const unsigned char *chunk_start,
    - 		return -1;
    - 	}
      
    -+	hash_version = get_be32(chunk_start);
    -+
    -+	if (*c->commit_graph_changed_paths_version == -1)
    -+		*c->commit_graph_changed_paths_version = hash_version;
    -+	else if (hash_version != *c->commit_graph_changed_paths_version)
    -+		return 0;
    -+
      	g->chunk_bloom_data = chunk_start;
      	g->chunk_bloom_data_size = chunk_size;
     -	hash_version = get_be32(chunk_start);
    --
    --	if (hash_version != 1)
    --		return 0;
    --
    + 
      	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
    - 	g->bloom_filter_settings->hash_version = hash_version;
    +-	g->bloom_filter_settings->hash_version = hash_version;
    ++	g->bloom_filter_settings->hash_version = get_be32(chunk_start);
      	g->bloom_filter_settings->num_hashes = get_be32(chunk_start + 4);
    -@@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repo_settings *s,
    - 	}
    - 
    - 	if (s->commit_graph_changed_paths_version) {
    -+		struct graph_read_bloom_data_context context = {
    -+			.g = graph,
    -+			.commit_graph_changed_paths_version = &s->commit_graph_changed_paths_version
    -+		};
    - 		read_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
    - 			   graph_read_bloom_index, graph);
    - 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
    --			   graph_read_bloom_data, graph);
    -+			   graph_read_bloom_data, &context);
    - 	}
    - 
    - 	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
    + 	g->bloom_filter_settings->bits_per_entry = get_be32(chunk_start + 8);
    + 	g->bloom_filter_settings->max_changed_paths = DEFAULT_BLOOM_MAX_CHANGES;
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
      	}
      	if (!commit_graph_compatible(r))
    @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
      
      	CALLOC_ARRAY(ctx, 1);
      	ctx->r = r;
    -@@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
    - 	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
    - 	ctx->num_generation_data_overflows = 0;
    - 
    -+	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version == 2
    -+		? 2 : 1;
    - 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
    - 						      bloom_settings.bits_per_entry);
    - 	bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
      		g = ctx->r->objects->commit_graph;
      
    @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
     -		if (g && g->chunk_bloom_data) {
     +		if (g && g->bloom_filter_settings) {
      			ctx->changed_paths = 1;
    - 			ctx->bloom_settings = g->bloom_filter_settings;
    - 		}
    + 
    + 			/* don't propagate the hash_version unless unspecified */
     
      ## t/helper/test-bloom.c ##
     @@ t/helper/test-bloom.c: static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
    @@ t/t0095-bloom.sh: test_expect_success 'compute unseeded murmur3 hash for test st
      	Hashes:0x5615800c|0x5b966560|0x61174ab4|0x66983008|0x6c19155c|0x7199fab0|0x771ae004|
     
      ## t/t4216-log-bloom.sh ##
    +@@ t/t4216-log-bloom.sh: test_expect_success 'merge graph layers with incompatible Bloom settings' '
    + 	test_must_be_empty err
    + '
    + 
    ++test_expect_success 'ensure Bloom filter with incompatible versions are ignored' '
    ++	rm "$repo/$graph" &&
    ++
    ++	git -C $repo log --oneline --no-decorate -- $CENT >expect &&
    ++
    ++	# Compute v1 Bloom filters for commits at the bottom.
    ++	git -C $repo rev-parse HEAD^ >in &&
    ++	git -C $repo commit-graph write --stdin-commits --changed-paths \
    ++		--split <in &&
    ++
    ++	# Compute v2 Bloomfilters for the rest of the commits at the top.
    ++	git -C $repo rev-parse HEAD >in &&
    ++	git -C $repo -c commitGraph.changedPathsVersion=2 commit-graph write \
    ++		--stdin-commits --changed-paths --split=no-merge <in &&
    ++
    ++	test_line_count = 2 $repo/$chain &&
    ++
    ++	git -C $repo log --oneline --no-decorate -- $CENT >actual 2>err &&
    ++	test_cmp expect actual &&
    ++
    ++	layer="$(head -n 1 $repo/$chain)" &&
    ++	cat >expect.err <<-EOF &&
    ++	warning: disabling Bloom filters for commit-graph layer $SQ$layer$SQ due to incompatible settings
    ++	EOF
    ++	test_cmp expect.err err
    ++'
    ++
    + get_first_changed_path_filter () {
    + 	test-tool read-graph bloom-filters >filters.dat &&
    + 	head -n 1 filters.dat
     @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when version 1 requested' '
      	)
      '
14:  acc0a097b3 <  -:  ---------- commit-graph: drop unnecessary `graph_read_bloom_data_context`
15:  da401c8853 = 14:  9f54a376fb object.h: fix mis-aligned flag bits table
16:  2674967309 = 15:  67991dea7c commit-graph: reuse existing Bloom filters where possible
17:  bea7ec7b3f ! 16:  12058a074d bloom: introduce `deinit_bloom_filters()`
    @@ bloom.h: void add_key_to_filter(const struct bloom_key *key,
      	BLOOM_NOT_COMPUTED = (1 << 0),
     
      ## commit-graph.c ##
    -@@ commit-graph.c: struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
    - void close_commit_graph(struct raw_object_store *o)
    - {
    +@@ commit-graph.c: void close_commit_graph(struct raw_object_store *o)
    + 		return;
    + 
      	clear_commit_graph_data_slab(&commit_graph_data_slab);
     +	deinit_bloom_filters();
      	free_commit_graph(o->commit_graph);

base-commit: bc7ee2e5e16f0d1e710ef8fab3db59ab11f2bbe7
-- 
2.43.0.509.g253f65a7fc
