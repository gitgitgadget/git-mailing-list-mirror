Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D973BB20
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741578; cv=none; b=sfI6Wn3sNS+UQ4e4999SVb1cW8m8k5X6KGH9uIYJdLYvBsqeNsLaXMj6bB4AY6jr0tLWqqPwAPURQYH5MYqBCT9DhkgeQuqLPERNUpkGq6ReerEfPTJAfn0iYbpusMlzvt4rV8B5u0zc5ban+bL3VxV6f1Zg0BH7rN00sQeL6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741578; c=relaxed/simple;
	bh=SkPqFtEVdAYOIW1zKYgO9xHEyxnA3Nt4cRULiWacK+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWwkOriV63TWWacahhESx3Jh7V5Bc2/3zd3tzTd2TSJ9glbB6J0qC48W9fHD16NlzQ09snosf667La4CJxQoH2EJBIAK5xCbnzRMX57TPHQobdrCAKKl/VNWLAqcOOZei8dbgCg1rn68lKwfO9UQGHIFrRxAReZeRlofd01QReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=GPhfJZ45; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="GPhfJZ45"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bb9d54575cso197803b6e.2
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706741575; x=1707346375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bVDmOtERVGWKjotuRPY7uuh9VoEHqELinFQnOoAAj+o=;
        b=GPhfJZ45Ml91v1/KzRdlDXU8kbLkH1r8Q+VaouCzm1V0ANgKTrA0+9ZYapuCvysXIQ
         ivq162mLJ0lAm8ouNJWz0ko8xjw4+Lr6QlCe7EjoHmc+AHXh+wgZBynCEajlst6/zAma
         GfLC0t4zkrjAfUIDSqfls8w3a0oxlPAIxW+Zc7rM4AUd5WsBp2xowSW5NxJjizM0Fzhc
         t6E9LO+yGvZRVuRWMtjt5/FwsuZOcsifXD358Oqq3XEJcRaL3kitIo7zWWMnuUOHvWnZ
         zTdTi9upzbz9VzbXp2gNqeEg10DI/x6KagUOTEVIpQbmTcttgZNTFFZGgQ0hO3o2OLJQ
         ifyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741575; x=1707346375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVDmOtERVGWKjotuRPY7uuh9VoEHqELinFQnOoAAj+o=;
        b=jUVpaSobAblJOHJDpDNsqGWwPst6lIPvGB8aK3n/7kNsbYiap0bf0InzPbU7TNCtlK
         Hi+DDdIvAgvPgecip30hL2OUv5LGNLE2F9MkcqC8J8L/9QWDqq/wYXrK/awpbkrnqVhg
         JE0QlDYvhQjS7GJXlIvg2jcGMo4Kkw5E5NLQLxHni4SPcq9/WBt4TYhLTA8w9dWqzYV2
         gQbP2cn4N42mRApNx/wFikq7xm2ZDSuzE2GDRSOpwUjyqEgTcyjafnvVJmhqE7UUzsc8
         tcLCU4OjeW0sbMXc3kaKqRmHxNTBv9yBTicZcpKFW4GdBF/oNJgt3qARfCLj1c+QVHyt
         0uig==
X-Gm-Message-State: AOJu0Yz1xIlZkduCwR14pstHrno0skSi3FAfatDV/l+WSn+z0NV+CKYn
	ucGGl28BIblMXIzzLge8stV6z1vBeyVDnNzR1WG/lS/0nZ0igfrTRDczPOvUPtBdKH6+ZCi0ypx
	qsRQ=
X-Google-Smtp-Source: AGHT+IHGVbBZmRM0w0n3Ac5sp8SZ4e7LfEqCwMlFDkIoWZscVI9LKXniTOJkQ07AGXvuN8zW+l1vnA==
X-Received: by 2002:a05:6808:17a5:b0:3be:b787:e461 with SMTP id bg37-20020a05680817a500b003beb787e461mr3874997oib.43.1706741575070;
        Wed, 31 Jan 2024 14:52:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id vz18-20020a05620a495200b0078408de98e6sm1885050qkn.72.2024.01.31.14.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:52:54 -0800 (PST)
Date: Wed, 31 Jan 2024 17:52:54 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v6 13/16] commit-graph: new Bloom filter version that fixes
 murmur3
Message-ID: <d2f11c082d3bf10d9127c330a7d59b7e47ac4f21.1706741516.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1706741516.git.me@ttaylorr.com>

The murmur3 implementation in bloom.c has a bug when converting series
of 4 bytes into network-order integers when char is signed (which is
controllable by a compiler option, and the default signedness of char is
platform-specific). When a string contains characters with the high bit
set, this bug causes results that, although internally consistent within
Git, does not accord with other implementations of murmur3 (thus,
the changed path filters wouldn't be readable by other off-the-shelf
implementatios of murmur3) and even with Git binaries that were compiled
with different signedness of char. This bug affects both how Git writes
changed path filters to disk and how Git interprets changed path filters
on disk.

Therefore, introduce a new version (2) of changed path filters that
corrects this problem. The existing version (1) is still supported and
is still the default, but users should migrate away from it as soon
as possible.

Because this bug only manifests with characters that have the high bit
set, it may be possible that some (or all) commits in a given repo would
have the same changed path filter both before and after this fix is
applied. However, in order to determine whether this is the case, the
changed paths would first have to be computed, at which point it is not
much more expensive to just compute a new changed path filter.

So this patch does not include any mechanism to "salvage" changed path
filters from repositories. There is also no "mixed" mode - for each
invocation of Git, reading and writing changed path filters are done
with the same version number; this version number may be explicitly
stated (typically if the user knows which version they need) or
automatically determined from the version of the existing changed path
filters in the repository.

There is a change in write_commit_graph(). graph_read_bloom_data()
makes it possible for chunk_bloom_data to be non-NULL but
bloom_filter_settings to be NULL, which causes a segfault later on. I
produced such a segfault while developing this patch, but couldn't find
a way to reproduce it neither after this complete patch (or before),
but in any case it seemed like a good thing to include that might help
future patch authors.

The value in t0095 was obtained from another murmur3 implementation
using the following Go source code:

  package main

  import "fmt"
  import "github.com/spaolacci/murmur3"

  func main() {
          fmt.Printf("%x\n", murmur3.Sum32([]byte("Hello world!")))
          fmt.Printf("%x\n", murmur3.Sum32([]byte{0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff}))
  }

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/commitgraph.txt |   5 +-
 bloom.c                              |  69 ++++++++++++-
 bloom.h                              |   8 +-
 commit-graph.c                       |  13 ++-
 t/helper/test-bloom.c                |   9 +-
 t/t0095-bloom.sh                     |   8 ++
 t/t4216-log-bloom.sh                 | 141 +++++++++++++++++++++++++++
 7 files changed, 241 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
index e68cdededa..7f8c9d6638 100644
--- a/Documentation/config/commitgraph.txt
+++ b/Documentation/config/commitgraph.txt
@@ -15,7 +15,7 @@ commitGraph.readChangedPaths::
 
 commitGraph.changedPathsVersion::
 	Specifies the version of the changed-path Bloom filters that Git will read and
-	write. May be -1, 0 or 1. Note that values greater than 1 may be
+	write. May be -1, 0, 1, or 2. Note that values greater than 1 may be
 	incompatible with older versions of Git which do not yet understand
 	those versions. Use caution when operating in a mixed-version
 	environment.
@@ -31,4 +31,7 @@ filters when instructed to write.
 If 1, Git will only read version 1 Bloom filters, and will write version 1
 Bloom filters.
 +
+If 2, Git will only read version 2 Bloom filters, and will write version 2
+Bloom filters.
++
 See linkgit:git-commit-graph[1] for more information.
diff --git a/bloom.c b/bloom.c
index c24489dbcf..323d8012b8 100644
--- a/bloom.c
+++ b/bloom.c
@@ -100,7 +100,64 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
  * Not considered to be cryptographically secure.
  * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
  */
-uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len)
+uint32_t murmur3_seeded_v2(uint32_t seed, const char *data, size_t len)
+{
+	const uint32_t c1 = 0xcc9e2d51;
+	const uint32_t c2 = 0x1b873593;
+	const uint32_t r1 = 15;
+	const uint32_t r2 = 13;
+	const uint32_t m = 5;
+	const uint32_t n = 0xe6546b64;
+	int i;
+	uint32_t k1 = 0;
+	const char *tail;
+
+	int len4 = len / sizeof(uint32_t);
+
+	uint32_t k;
+	for (i = 0; i < len4; i++) {
+		uint32_t byte1 = (uint32_t)(unsigned char)data[4*i];
+		uint32_t byte2 = ((uint32_t)(unsigned char)data[4*i + 1]) << 8;
+		uint32_t byte3 = ((uint32_t)(unsigned char)data[4*i + 2]) << 16;
+		uint32_t byte4 = ((uint32_t)(unsigned char)data[4*i + 3]) << 24;
+		k = byte1 | byte2 | byte3 | byte4;
+		k *= c1;
+		k = rotate_left(k, r1);
+		k *= c2;
+
+		seed ^= k;
+		seed = rotate_left(seed, r2) * m + n;
+	}
+
+	tail = (data + len4 * sizeof(uint32_t));
+
+	switch (len & (sizeof(uint32_t) - 1)) {
+	case 3:
+		k1 ^= ((uint32_t)(unsigned char)tail[2]) << 16;
+		/*-fallthrough*/
+	case 2:
+		k1 ^= ((uint32_t)(unsigned char)tail[1]) << 8;
+		/*-fallthrough*/
+	case 1:
+		k1 ^= ((uint32_t)(unsigned char)tail[0]) << 0;
+		k1 *= c1;
+		k1 = rotate_left(k1, r1);
+		k1 *= c2;
+		seed ^= k1;
+		break;
+	}
+
+	seed ^= (uint32_t)len;
+	seed ^= (seed >> 16);
+	seed *= 0x85ebca6b;
+	seed ^= (seed >> 13);
+	seed *= 0xc2b2ae35;
+	seed ^= (seed >> 16);
+
+	return seed;
+}
+
+static uint32_t murmur3_seeded_v1(uint32_t seed, const char *data, size_t len)
 {
 	const uint32_t c1 = 0xcc9e2d51;
 	const uint32_t c2 = 0x1b873593;
@@ -165,8 +222,14 @@ void fill_bloom_key(const char *data,
 	int i;
 	const uint32_t seed0 = 0x293ae76f;
 	const uint32_t seed1 = 0x7e646e2c;
-	const uint32_t hash0 = murmur3_seeded(seed0, data, len);
-	const uint32_t hash1 = murmur3_seeded(seed1, data, len);
+	uint32_t hash0, hash1;
+	if (settings->hash_version == 2) {
+		hash0 = murmur3_seeded_v2(seed0, data, len);
+		hash1 = murmur3_seeded_v2(seed1, data, len);
+	} else {
+		hash0 = murmur3_seeded_v1(seed0, data, len);
+		hash1 = murmur3_seeded_v1(seed1, data, len);
+	}
 
 	key->hashes = (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32_t));
 	for (i = 0; i < settings->num_hashes; i++)
diff --git a/bloom.h b/bloom.h
index 052a993aab..bfe389e29c 100644
--- a/bloom.h
+++ b/bloom.h
@@ -8,9 +8,11 @@ struct commit_graph;
 struct bloom_filter_settings {
 	/*
 	 * The version of the hashing technique being used.
-	 * We currently only support version = 1 which is
+	 * The newest version is 2, which is
 	 * the seeded murmur3 hashing technique implemented
-	 * in bloom.c.
+	 * in bloom.c. Bloom filters of version 1 were created
+	 * with prior versions of Git, which had a bug in the
+	 * implementation of the hash function.
 	 */
 	uint32_t hash_version;
 
@@ -81,7 +83,7 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
  * Not considered to be cryptographically secure.
  * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
  */
-uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len);
+uint32_t murmur3_seeded_v2(uint32_t seed, const char *data, size_t len);
 
 void fill_bloom_key(const char *data,
 		    size_t len,
diff --git a/commit-graph.c b/commit-graph.c
index 6c3fbae142..6f9cab181e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -344,7 +344,6 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
 	struct commit_graph *g = data;
-	uint32_t hash_version;
 
 	if (chunk_size < BLOOMDATA_CHUNK_HEADER_SIZE) {
 		warning(_("ignoring too-small changed-path chunk"
@@ -356,10 +355,9 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 
 	g->chunk_bloom_data = chunk_start;
 	g->chunk_bloom_data_size = chunk_size;
-	hash_version = get_be32(chunk_start);
 
 	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
-	g->bloom_filter_settings->hash_version = hash_version;
+	g->bloom_filter_settings->hash_version = get_be32(chunk_start);
 	g->bloom_filter_settings->num_hashes = get_be32(chunk_start + 4);
 	g->bloom_filter_settings->bits_per_entry = get_be32(chunk_start + 8);
 	g->bloom_filter_settings->max_changed_paths = DEFAULT_BLOOM_MAX_CHANGES;
@@ -2501,6 +2499,13 @@ int write_commit_graph(struct object_directory *odb,
 	}
 	if (!commit_graph_compatible(r))
 		return 0;
+	if (r->settings.commit_graph_changed_paths_version < -1
+	    || r->settings.commit_graph_changed_paths_version > 2) {
+		warning(_("attempting to write a commit-graph, but "
+			  "'commitgraph.changedPathsVersion' (%d) is not supported"),
+			r->settings.commit_graph_changed_paths_version);
+		return 0;
+	}
 
 	CALLOC_ARRAY(ctx, 1);
 	ctx->r = r;
@@ -2543,7 +2548,7 @@ int write_commit_graph(struct object_directory *odb,
 		g = ctx->r->objects->commit_graph;
 
 		/* We have changed-paths already. Keep them in the next graph */
-		if (g && g->chunk_bloom_data) {
+		if (g && g->bloom_filter_settings) {
 			ctx->changed_paths = 1;
 
 			/* don't propagate the hash_version unless unspecified */
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 1281e66876..eefc1668c7 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -49,6 +49,7 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
 
 static const char *bloom_usage = "\n"
 "  test-tool bloom get_murmur3 <string>\n"
+"  test-tool bloom get_murmur3_seven_highbit\n"
 "  test-tool bloom generate_filter <string> [<string>...]\n"
 "  test-tool bloom get_filter_for_commit <commit-hex>\n";
 
@@ -63,7 +64,13 @@ int cmd__bloom(int argc, const char **argv)
 		uint32_t hashed;
 		if (argc < 3)
 			usage(bloom_usage);
-		hashed = murmur3_seeded(0, argv[2], strlen(argv[2]));
+		hashed = murmur3_seeded_v2(0, argv[2], strlen(argv[2]));
+		printf("Murmur3 Hash with seed=0:0x%08x\n", hashed);
+	}
+
+	if (!strcmp(argv[1], "get_murmur3_seven_highbit")) {
+		uint32_t hashed;
+		hashed = murmur3_seeded_v2(0, "\x99\xaa\xbb\xcc\xdd\xee\xff", 7);
 		printf("Murmur3 Hash with seed=0:0x%08x\n", hashed);
 	}
 
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index b567383eb8..c8d84ab606 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -29,6 +29,14 @@ test_expect_success 'compute unseeded murmur3 hash for test string 2' '
 	test_cmp expect actual
 '
 
+test_expect_success 'compute unseeded murmur3 hash for test string 3' '
+	cat >expect <<-\EOF &&
+	Murmur3 Hash with seed=0:0xa183ccfd
+	EOF
+	test-tool bloom get_murmur3_seven_highbit >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'compute bloom key for empty string' '
 	cat >expect <<-\EOF &&
 	Hashes:0x5615800c|0x5b966560|0x61174ab4|0x66983008|0x6c19155c|0x7199fab0|0x771ae004|
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 93b8d096cf..a7bf3a7dca 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -485,6 +485,33 @@ test_expect_success 'merge graph layers with incompatible Bloom settings' '
 	test_must_be_empty err
 '
 
+test_expect_success 'ensure Bloom filter with incompatible versions are ignored' '
+	rm "$repo/$graph" &&
+
+	git -C $repo log --oneline --no-decorate -- $CENT >expect &&
+
+	# Compute v1 Bloom filters for commits at the bottom.
+	git -C $repo rev-parse HEAD^ >in &&
+	git -C $repo commit-graph write --stdin-commits --changed-paths \
+		--split <in &&
+
+	# Compute v2 Bloomfilters for the rest of the commits at the top.
+	git -C $repo rev-parse HEAD >in &&
+	git -C $repo -c commitGraph.changedPathsVersion=2 commit-graph write \
+		--stdin-commits --changed-paths --split=no-merge <in &&
+
+	test_line_count = 2 $repo/$chain &&
+
+	git -C $repo log --oneline --no-decorate -- $CENT >actual 2>err &&
+	test_cmp expect actual &&
+
+	layer="$(head -n 1 $repo/$chain)" &&
+	cat >expect.err <<-EOF &&
+	warning: disabling Bloom filters for commit-graph layer $SQ$layer$SQ due to incompatible settings
+	EOF
+	test_cmp expect.err err
+'
+
 get_first_changed_path_filter () {
 	test-tool read-graph bloom-filters >filters.dat &&
 	head -n 1 filters.dat
@@ -536,6 +563,120 @@ test_expect_success 'version 1 changed-path used when version 1 requested' '
 	)
 '
 
+test_expect_success 'version 1 changed-path not used when version 2 requested' '
+	(
+		cd highbit1 &&
+		git config --add commitgraph.changedPathsVersion 2 &&
+		test_bloom_filters_not_used "-- another$CENT"
+	)
+'
+
+test_expect_success 'version 1 changed-path used when autodetect requested' '
+	(
+		cd highbit1 &&
+		git config --add commitgraph.changedPathsVersion -1 &&
+		test_bloom_filters_used "-- another$CENT"
+	)
+'
+
+test_expect_success 'when writing another commit graph, preserve existing version 1 of changed-path' '
+	test_commit -C highbit1 c1double "$CENT$CENT" &&
+	git -C highbit1 commit-graph write --reachable --changed-paths &&
+	(
+		cd highbit1 &&
+		git config --add commitgraph.changedPathsVersion -1 &&
+		echo "options: bloom(1,10,7) read_generation_data" >expect &&
+		test-tool read-graph >full &&
+		grep options full >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'set up repo with high bit path, version 2 changed-path' '
+	git init highbit2 &&
+	git -C highbit2 config --add commitgraph.changedPathsVersion 2 &&
+	test_commit -C highbit2 c2 "$CENT" &&
+	git -C highbit2 commit-graph write --reachable --changed-paths
+'
+
+test_expect_success 'check value of version 2 changed-path' '
+	(
+		cd highbit2 &&
+		echo "c01f" >expect &&
+		get_first_changed_path_filter >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'setup make another commit' '
+	# "git log" does not use Bloom filters for root commits - see how, in
+	# revision.c, rev_compare_tree() (the only code path that eventually calls
+	# get_bloom_filter()) is only called by try_to_simplify_commit() when the commit
+	# has one parent. Therefore, make another commit so that we perform the tests on
+	# a non-root commit.
+	test_commit -C highbit2 anotherc2 "another$CENT"
+'
+
+test_expect_success 'version 2 changed-path used when version 2 requested' '
+	(
+		cd highbit2 &&
+		test_bloom_filters_used "-- another$CENT"
+	)
+'
+
+test_expect_success 'version 2 changed-path not used when version 1 requested' '
+	(
+		cd highbit2 &&
+		git config --add commitgraph.changedPathsVersion 1 &&
+		test_bloom_filters_not_used "-- another$CENT"
+	)
+'
+
+test_expect_success 'version 2 changed-path used when autodetect requested' '
+	(
+		cd highbit2 &&
+		git config --add commitgraph.changedPathsVersion -1 &&
+		test_bloom_filters_used "-- another$CENT"
+	)
+'
+
+test_expect_success 'when writing another commit graph, preserve existing version 2 of changed-path' '
+	test_commit -C highbit2 c2double "$CENT$CENT" &&
+	git -C highbit2 commit-graph write --reachable --changed-paths &&
+	(
+		cd highbit2 &&
+		git config --add commitgraph.changedPathsVersion -1 &&
+		echo "options: bloom(2,10,7) read_generation_data" >expect &&
+		test-tool read-graph >full &&
+		grep options full >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'when writing commit graph, do not reuse changed-path of another version' '
+	git init doublewrite &&
+	test_commit -C doublewrite c "$CENT" &&
+	git -C doublewrite config --add commitgraph.changedPathsVersion 1 &&
+	git -C doublewrite commit-graph write --reachable --changed-paths &&
+	for v in -2 3
+	do
+		git -C doublewrite config --add commitgraph.changedPathsVersion $v &&
+		git -C doublewrite commit-graph write --reachable --changed-paths 2>err &&
+		cat >expect <<-EOF &&
+		warning: attempting to write a commit-graph, but ${SQ}commitgraph.changedPathsVersion${SQ} ($v) is not supported
+		EOF
+		test_cmp expect err || return 1
+	done &&
+	git -C doublewrite config --add commitgraph.changedPathsVersion 2 &&
+	git -C doublewrite commit-graph write --reachable --changed-paths &&
+	(
+		cd doublewrite &&
+		echo "c01f" >expect &&
+		get_first_changed_path_filter >actual &&
+		test_cmp expect actual
+	)
+'
+
 corrupt_graph () {
 	test_when_finished "rm -rf $graph" &&
 	git commit-graph write --reachable --changed-paths &&
-- 
2.43.0.509.g253f65a7fc

