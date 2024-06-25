Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9681135A69
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337150; cv=none; b=Xom+9qiWGkJVaAOs+/dSYDSkno0id5lmRZBMCCl6ZLbwYSQDrFRmkZKbgyrM5Gg6VputbTGuwWCUhlD1eLbOQhSCxpGm+tGKEAu67fpJ44a8M2dgxr4WB+AkImlXB3mEiZA/86Ca8FmTkf5bHoIw5sffXp4PfTPOzdMHn14SK0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337150; c=relaxed/simple;
	bh=qT0BwZ/BEu+FIkhuoehAYIf4ObUcx1L/tA/KrAYS5Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGb87tzPZoNCXXNswMrAJNpZL5SkBSqeFghvR0h0nKc9R1ZM+u0ZPZtqz86vYza1/lCToMaRbCPelD5QWlQQPouupTlqNouSHYwIyXr9KGm1m2wieeuxOFFYDeihhMuNdM6YX9haLIgyd6RRcbAyFm+8wdsgtZ2gUyvWsIKtSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=yt1dwzp4; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="yt1dwzp4"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b4fec3a1a7so24248656d6.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1719337147; x=1719941947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oBINOhbAopjn6FH0i3IYKetEt44Sw9PKxcGdWaLsops=;
        b=yt1dwzp43RKgC50pLpOu8+yQmiVAtSe7Hkc9OtauYfLL7n/47zY5SsDDh/qvKA2uXZ
         2mlxDVy11zMVvbd/qvJHFblwRfI9/86WKQHFFEWvArwvvM8qSwAO0qv2BH/LOfh39ASf
         KGorfC6F+S1gXj5rOsdqgfdvXZBzTvJI+n2vuDkNIHCY+3jBHiUweY8y+v0E3PhozwYu
         6/w+c/GXQbQPTB5U3469qCPMWQHH0SFyyNpH3rWbBIIWeCgPRzZUX6qZUxxHnweyBj3U
         7oaSjZkmD/Wuw6nqPnjbJEohEQYBNF8EoKIdoczqtqPefVUcTipi8UD2kus7XgTyAeUz
         YRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337147; x=1719941947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBINOhbAopjn6FH0i3IYKetEt44Sw9PKxcGdWaLsops=;
        b=KIwIkZ908IZaGpgsG0FndOS3sSC+P5E3R+olV56veROhHIGe9bCmAZb3xCrSe8R7bf
         JX0fVv1gwRwUchrZr/dSIeRzXZyZq5/snH8gdkxC0tzLwGDBXxsTptKPhDEyr14+IL+s
         j9HI+4NgnjRYOzG0kJeur9n+KmqeTpjwuR7l3AFb7iKKRH3HPRAR97fwBmDQvAMmepSF
         ZCql5QBS5/k1oQ4jzv3k+Ovi9bB35opIuBJmpdfPVTsJLOuXH2JJqnseq7l5uNNRwRVW
         U6wdL39jESvibqW+w6CSxKkmkpIDGi5+JcQEq2ApIdtECQURago2pUBLB6p3wuZz07jp
         nPkw==
X-Gm-Message-State: AOJu0YwlI45bK5KgIlihSTI5ocbV8ubAMJct7Nlq1h7SfOFdwYJ3Wcfl
	KEjvyKgO8ux81dVWAJnsejxdwUo30AnRjlruYzCer+/jc9DVlIcwY8g2HHziUC8+u2On1qrLPp3
	us9E=
X-Google-Smtp-Source: AGHT+IFcZG3e9URHiNiGFNucmReiki5ecVqPagzcA75CkkEgBrzD9Pr1T4EIfcjqfvUXGBqWVceS2w==
X-Received: by 2002:a05:6214:5150:b0:6b5:2c39:d780 with SMTP id 6a1803df08f44-6b53baaacf4mr90171066d6.22.1719337147059;
        Tue, 25 Jun 2024 10:39:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b531673e6esm33682896d6.85.2024.06.25.10.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:39:06 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:39:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 00/16] bloom: changed-path Bloom filters v2 (& sundries)
Message-ID: <cover.1719333276.git.me@ttaylorr.com>
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

(Rebased onto the tip of 'master', which is now 1e1586e4ed (The
sixteenth batch, 2024-06-24) at the time of writing).

This series is another minor reroll of the combined efforts of [1] and
[2] to introduce the v2 changed-path Bloom filters, which fixes a bug in
our existing implementation of murmur3 paths with non-ASCII characters
(when the "char" type is signed).

This version addresses the remaining comments from SZEDER around more
thorough testing of merging commit-graph layers with incompatible Bloom
filters versions, and ensuring the result is as expected.

Thanks again to Jonathan, Peff, and SZEDER who have helped a great deal
in assembling these patches. As usual, a range-diff is included below.

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/cover.1684790529.git.jonathantanmy@google.com/
[2]: https://lore.kernel.org/git/cover.1691426160.git.me@ttaylorr.com/

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

 Documentation/config/commitgraph.txt     |  29 +-
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
 t/t4216-log-bloom.sh                     | 325 ++++++++++++++++++++++-
 14 files changed, 738 insertions(+), 58 deletions(-)

Range-diff against v6:
 1:  9df34a2f4f =  1:  ee651fee33 t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
 2:  a6dc377f1b =  2:  5d88ad6c90 revision.c: consult Bloom filters for root commits
 3:  a77ab941bc !  3:  f6cf5bfc4e commit-graph: ensure Bloom filters are read with consistent settings
    @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backfills empty comm
     +test_expect_success 'merge graph layers with incompatible Bloom settings' '
     +	# Ensure that incompatible Bloom filters are ignored when
     +	# merging existing layers.
    -+	git -C $repo commit-graph write --reachable --changed-paths 2>err &&
    ++	>trace2.txt &&
    ++	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
    ++		git -C $repo commit-graph write --reachable --changed-paths 2>err &&
     +	grep "disabling Bloom filters for commit-graph layer .$layer." err &&
    ++	grep "{\"hash_version\":1,\"num_hashes\":7,\"bits_per_entry\":10,\"max_changed_paths\":512" trace2.txt &&
     +
     +	test_path_is_file $repo/$graph &&
     +	test_dir_is_empty $repo/$graphdir &&
 4:  56a9fdaff0 =  4:  0041600f31 gitformat-commit-graph: describe version 2 of BDAT
 5:  7484a82f7f =  5:  6e7f317551 t/helper/test-read-graph.c: extract `dump_graph_info()`
 6:  48343f93a2 =  6:  ae74fbad3e bloom.h: make `load_bloom_filter_from_graph()` public
 7:  286fd7dcdb =  7:  0dfd1a361e t/helper/test-read-graph: implement `bloom-filters` mode
 8:  7de7b89da0 =  8:  fbcaa686b1 t4216: test changed path filters with high bit paths
 9:  b13c9b8ff9 !  9:  60c063ca4a repo-settings: introduce commitgraph.changedPathsVersion
    @@ commit-graph.c: static void validate_mixed_bloom_settings(struct commit_graph *g
     
      ## oss-fuzz/fuzz-commit-graph.c ##
     @@ oss-fuzz/fuzz-commit-graph.c: int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
    - 	 * possible.
      	 */
    + 	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
      	the_repository->settings.commit_graph_generation_version = 2;
     -	the_repository->settings.commit_graph_read_changed_paths = 1;
     +	the_repository->settings.commit_graph_changed_paths_version = 1;
10:  09c44c51a5 = 10:  ce3a15a517 bloom: annotate filters with hash version
11:  d4995ef600 = 11:  99ab9cf448 bloom: prepare to discard incompatible Bloom filters
12:  c8e9bb7c88 = 12:  99e66d1dba commit-graph: unconditionally load Bloom filters
13:  d2f11c082d ! 13:  2e945c3d2e commit-graph: new Bloom filter version that fixes murmur3
    @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
     +	if (r->settings.commit_graph_changed_paths_version < -1
     +	    || r->settings.commit_graph_changed_paths_version > 2) {
     +		warning(_("attempting to write a commit-graph, but "
    -+			  "'commitgraph.changedPathsVersion' (%d) is not supported"),
    ++			  "'commitGraph.changedPathsVersion' (%d) is not supported"),
     +			r->settings.commit_graph_changed_paths_version);
     +		return 0;
     +	}
    @@ t/t4216-log-bloom.sh: test_expect_success 'merge graph layers with incompatible
      	test_must_be_empty err
      '
      
    ++# chosen to be the same under all Unicode normalization forms
    ++CENT=$(printf "\302\242")
    ++
     +test_expect_success 'ensure Bloom filter with incompatible versions are ignored' '
     +	rm "$repo/$graph" &&
     +
    @@ t/t4216-log-bloom.sh: test_expect_success 'merge graph layers with incompatible
     +	cat >expect.err <<-EOF &&
     +	warning: disabling Bloom filters for commit-graph layer $SQ$layer$SQ due to incompatible settings
     +	EOF
    -+	test_cmp expect.err err
    ++	test_cmp expect.err err &&
    ++
    ++	# Merge the two layers with incompatible bloom filter versions,
    ++	# ensuring that the v2 filters are used.
    ++	>trace2.txt &&
    ++	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
    ++		git -C $repo -c commitGraph.changedPathsVersion=2 commit-graph write --reachable --changed-paths 2>err &&
    ++	grep "disabling Bloom filters for commit-graph layer .$layer." err &&
    ++	grep "{\"hash_version\":2,\"num_hashes\":7,\"bits_per_entry\":10,\"max_changed_paths\":512" trace2.txt
     +'
     +
      get_first_changed_path_filter () {
      	test-tool read-graph bloom-filters >filters.dat &&
      	head -n 1 filters.dat
    + }
    + 
    +-# chosen to be the same under all Unicode normalization forms
    +-CENT=$(printf "\302\242")
    +-
    + test_expect_success 'set up repo with high bit path, version 1 changed-path' '
    + 	git init highbit1 &&
    + 	test_commit -C highbit1 c1 "$CENT" &&
     @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when version 1 requested' '
      	)
      '
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when vers
     +test_expect_success 'version 1 changed-path not used when version 2 requested' '
     +	(
     +		cd highbit1 &&
    -+		git config --add commitgraph.changedPathsVersion 2 &&
    ++		git config --add commitGraph.changedPathsVersion 2 &&
     +		test_bloom_filters_not_used "-- another$CENT"
     +	)
     +'
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when vers
     +test_expect_success 'version 1 changed-path used when autodetect requested' '
     +	(
     +		cd highbit1 &&
    -+		git config --add commitgraph.changedPathsVersion -1 &&
    ++		git config --add commitGraph.changedPathsVersion -1 &&
     +		test_bloom_filters_used "-- another$CENT"
     +	)
     +'
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when vers
     +	git -C highbit1 commit-graph write --reachable --changed-paths &&
     +	(
     +		cd highbit1 &&
    -+		git config --add commitgraph.changedPathsVersion -1 &&
    ++		git config --add commitGraph.changedPathsVersion -1 &&
     +		echo "options: bloom(1,10,7) read_generation_data" >expect &&
     +		test-tool read-graph >full &&
     +		grep options full >actual &&
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when vers
     +
     +test_expect_success 'set up repo with high bit path, version 2 changed-path' '
     +	git init highbit2 &&
    -+	git -C highbit2 config --add commitgraph.changedPathsVersion 2 &&
    ++	git -C highbit2 config --add commitGraph.changedPathsVersion 2 &&
     +	test_commit -C highbit2 c2 "$CENT" &&
     +	git -C highbit2 commit-graph write --reachable --changed-paths
     +'
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when vers
     +test_expect_success 'version 2 changed-path not used when version 1 requested' '
     +	(
     +		cd highbit2 &&
    -+		git config --add commitgraph.changedPathsVersion 1 &&
    ++		git config --add commitGraph.changedPathsVersion 1 &&
     +		test_bloom_filters_not_used "-- another$CENT"
     +	)
     +'
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when vers
     +test_expect_success 'version 2 changed-path used when autodetect requested' '
     +	(
     +		cd highbit2 &&
    -+		git config --add commitgraph.changedPathsVersion -1 &&
    ++		git config --add commitGraph.changedPathsVersion -1 &&
     +		test_bloom_filters_used "-- another$CENT"
     +	)
     +'
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when vers
     +	git -C highbit2 commit-graph write --reachable --changed-paths &&
     +	(
     +		cd highbit2 &&
    -+		git config --add commitgraph.changedPathsVersion -1 &&
    ++		git config --add commitGraph.changedPathsVersion -1 &&
     +		echo "options: bloom(2,10,7) read_generation_data" >expect &&
     +		test-tool read-graph >full &&
     +		grep options full >actual &&
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when vers
     +test_expect_success 'when writing commit graph, do not reuse changed-path of another version' '
     +	git init doublewrite &&
     +	test_commit -C doublewrite c "$CENT" &&
    -+	git -C doublewrite config --add commitgraph.changedPathsVersion 1 &&
    ++	git -C doublewrite config --add commitGraph.changedPathsVersion 1 &&
     +	git -C doublewrite commit-graph write --reachable --changed-paths &&
     +	for v in -2 3
     +	do
    -+		git -C doublewrite config --add commitgraph.changedPathsVersion $v &&
    ++		git -C doublewrite config --add commitGraph.changedPathsVersion $v &&
     +		git -C doublewrite commit-graph write --reachable --changed-paths 2>err &&
     +		cat >expect <<-EOF &&
    -+		warning: attempting to write a commit-graph, but ${SQ}commitgraph.changedPathsVersion${SQ} ($v) is not supported
    ++		warning: attempting to write a commit-graph, but ${SQ}commitGraph.changedPathsVersion${SQ} ($v) is not supported
     +		EOF
     +		test_cmp expect err || return 1
     +	done &&
    -+	git -C doublewrite config --add commitgraph.changedPathsVersion 2 &&
    ++	git -C doublewrite config --add commitGraph.changedPathsVersion 2 &&
     +	git -C doublewrite commit-graph write --reachable --changed-paths &&
     +	(
     +		cd doublewrite &&
14:  9f54a376fb = 14:  242f023135 object.h: fix mis-aligned flag bits table
15:  67991dea7c ! 15:  1b80023e57 commit-graph: reuse existing Bloom filters where possible
    @@ bloom.c: static void init_truncated_large_filter(struct bloom_filter *filter,
     +		struct tree_desc desc;
     +		struct name_entry entry;
     +
    -+		init_tree_desc(&desc, t->buffer, t->size);
    ++		init_tree_desc(&desc, &t->object.oid, t->buffer, t->size);
     +		while (tree_entry(&desc, &entry)) {
     +			size_t i;
     +			for (i = 0; i < entry.pathlen; i++) {
    @@ t/t4216-log-bloom.sh: test_expect_success 'when writing another commit graph, pr
      	git init doublewrite &&
      	test_commit -C doublewrite c "$CENT" &&
     +
    - 	git -C doublewrite config --add commitgraph.changedPathsVersion 1 &&
    + 	git -C doublewrite config --add commitGraph.changedPathsVersion 1 &&
    ++	>trace2.txt &&
     +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
     +		git -C doublewrite commit-graph write --reachable --changed-paths &&
     +	test_filter_computed 1 trace2.txt &&
    @@ t/t4216-log-bloom.sh: test_expect_success 'when writing commit graph, do not reu
      		test_cmp expect err || return 1
      	done &&
     +
    - 	git -C doublewrite config --add commitgraph.changedPathsVersion 2 &&
    + 	git -C doublewrite config --add commitGraph.changedPathsVersion 2 &&
     -	git -C doublewrite commit-graph write --reachable --changed-paths &&
    ++	>trace2.txt &&
     +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
     +		git -C doublewrite commit-graph write --reachable --changed-paths &&
     +	test_filter_computed 1 trace2.txt &&
    @@ t/t4216-log-bloom.sh: test_expect_success 'when writing commit graph, do not reu
     +
     +	test_commit -C upgrade base no-high-bits &&
     +
    -+	git -C upgrade config --add commitgraph.changedPathsVersion 1 &&
    ++	git -C upgrade config --add commitGraph.changedPathsVersion 1 &&
    ++	>trace2.txt &&
     +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
     +		git -C upgrade commit-graph write --reachable --changed-paths &&
     +	test_filter_computed 1 trace2.txt &&
     +	test_filter_upgraded 0 trace2.txt &&
     +
    -+	git -C upgrade config --add commitgraph.changedPathsVersion 2 &&
    ++	git -C upgrade config --add commitGraph.changedPathsVersion 2 &&
    ++	>trace2.txt &&
     +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
     +		git -C upgrade commit-graph write --reachable --changed-paths &&
     +	test_filter_computed 0 trace2.txt &&
16:  12058a074d = 16:  db9991f339 bloom: introduce `deinit_bloom_filters()`

base-commit: 1e1586e4ed626bde864339c10570bc0e73f0ab97
-- 
2.45.2.664.g446e6a2b1f
