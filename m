Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC214CB24
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563580; cv=none; b=W/mIEjCsYA381GfVsDs25H6bjoIeLolm41NqEEItcSEvW0AbSYEkNz9xvyl4WayS18qT8036bCmBYW7qHoRw2K1lShfpYWCDekEyxf1O4zH0JEw/9mnPEzjTktVroDFiPN1+HCjJLwi+A/86wDAhNWqRaHa+CD9MqAsV03Bdh3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563580; c=relaxed/simple;
	bh=AOcKA0008eE/9T3p2a1c3EhF1gHyZ2jIwanp3CDNG68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMRSeV1fJ1f5JJHHDhz72lzobdQzyL9CkpA2Q9DzcgGNWmmBOxjRn5PRedKG2HS1xv4Wgw9iGZ0Xx0HL3od99Avx68p75dBRKf+qW9k+oOmXnCztzL177LOQnK8hkDPd65NkgmuzHfOuvxh3JFUKfwqn19cwj/0K0UEfYuMd7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxWqFH3b; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxWqFH3b"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so379157866b.2
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 13:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706563576; x=1707168376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=093u7fObZ59oSaLHWrzeVJqU8fpKcpP7XV2ed0wkzU0=;
        b=AxWqFH3bldcY3D/OCu/vaqS+ks904yHoJBx7u3y5x/H++TfUENK26oE2tKAqoLsVtw
         jlzjHuPwAJM57fbZI0V//e7FH2xVqKZzA1Ut/jzKYPELN31W1pMmHNWLp/qTrMeD39Wp
         GysmFIIjnR1RIet7MusAy2lGUuht4e4rZzLGKnv0ah4t2SnNFR+nnd8BqRS2qcy9QbhS
         QsUjLydJ/1sSPwfI+ALaEu+uUv7Z+983AnAZs+SkywLC/uhlnnRnCY7rq1O9leLYWGrF
         CK5Kba8UzC/ZN+eNGdoXRmbwUbgR5XCaBSakBW2V9YNd6KpCQUMtjCDqFx+iz0tuDeOn
         zzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706563576; x=1707168376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=093u7fObZ59oSaLHWrzeVJqU8fpKcpP7XV2ed0wkzU0=;
        b=NzqbJDHZtMyUvuY+ksJN/N+HL8Gzqlc9HZjtX+j9Kh8WHqs+DnF0DxjLFyUPI7JLnA
         k7677tj79RcManY5dhOBRub7aUKKRnuLh3wTuKXaqOOpVhRITv82qn6Wx72HUPzUs0Qv
         aFhSf/bDIHX92TxvUEEImU1h0OinufQiAOIk8LxqleFl/1jgsND/gX4DdhDEEPISlBuV
         Sw9NALOMqa8QNopLE9rum9pGcJat/4AiMUwAd6OUF6ZiPoLml/hw3UNlqO1CyK/rsJXY
         b0vIVHIOHUoMB76gYZWXLN10fiBvnahJ5gyE7OGm+NzvUYojWs75M09knOi8SVgRZ+ds
         ucGQ==
X-Gm-Message-State: AOJu0YyOTFac/G17PpruJCHK2sBfH7qLU0bekR6wxS6FiIEMxAIk+Die
	1rWrSiEaF6NbWgxbyQfhFa/rd4wrs+N1egyoXUCRYx8oWO4K112St4TQZVCU
X-Google-Smtp-Source: AGHT+IEX0KxAaKCH6D6HXyxjQil2p6LH30QXCKEcb5jdecHHBl9sDt+JRFxqyrcz2HnpjNm2fa7Kog==
X-Received: by 2002:a17:906:d8f:b0:a2c:e47a:1d13 with SMTP id m15-20020a1709060d8f00b00a2ce47a1d13mr4110447eji.0.1706563576201;
        Mon, 29 Jan 2024 13:26:16 -0800 (PST)
Received: from localhost (84-236-109-111.pool.digikabel.hu. [84.236.109.111])
        by smtp.gmail.com with ESMTPSA id fj17-20020a1709069c9100b00a2ada87f6a1sm4387030ejc.90.2024.01.29.13.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 13:26:15 -0800 (PST)
Date: Mon, 29 Jan 2024 22:26:14 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v5 09/17] repo-settings: introduce
 commitgraph.changedPathsVersion
Message-ID: <20240129212614.GB9612@szeder.dev>
References: <cover.1697653929.git.me@ttaylorr.com>
 <cover.1705442923.git.me@ttaylorr.com>
 <a77dcc99b4eb0a19dc6c09a40a84785413502126.1705442923.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a77dcc99b4eb0a19dc6c09a40a84785413502126.1705442923.git.me@ttaylorr.com>

On Tue, Jan 16, 2024 at 05:09:28PM -0500, Taylor Blau wrote:
> A subsequent commit will introduce another version of the changed-path
> filter in the commit graph file. In order to control which version to
> write (and read), a config variable is needed.
> 
> Therefore, introduce this config variable. For forwards compatibility,
> teach Git to not read commit graphs when the config variable
> is set to an unsupported version. Because we teach Git this,
> commitgraph.readChangedPaths is now redundant, so deprecate it and
> define its behavior in terms of the config variable we introduce.
> 
> This commit does not change the behavior of writing (Git writes changed
> path filters when explicitly instructed regardless of any config
> variable), but a subsequent commit will restrict Git such that it will
> only write when commitgraph.changedPathsVersion is a recognized value.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/config/commitgraph.txt | 26 ++++++++++++++++++++++---
>  commit-graph.c                       |  5 +++--
>  oss-fuzz/fuzz-commit-graph.c         |  2 +-
>  repo-settings.c                      |  6 +++++-
>  repository.h                         |  2 +-
>  t/t4216-log-bloom.sh                 | 29 +++++++++++++++++++++++++++-
>  6 files changed, 61 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
> index 30604e4a4c..e68cdededa 100644
> --- a/Documentation/config/commitgraph.txt
> +++ b/Documentation/config/commitgraph.txt
> @@ -9,6 +9,26 @@ commitGraph.maxNewFilters::
>  	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
>  
>  commitGraph.readChangedPaths::
> -	If true, then git will use the changed-path Bloom filters in the
> -	commit-graph file (if it exists, and they are present). Defaults to
> -	true. See linkgit:git-commit-graph[1] for more information.
> +	Deprecated. Equivalent to commitGraph.changedPathsVersion=-1 if true, and
> +	commitGraph.changedPathsVersion=0 if false. (If commitGraph.changedPathVersion
> +	is also set, commitGraph.changedPathsVersion takes precedence.)
> +
> +commitGraph.changedPathsVersion::
> +	Specifies the version of the changed-path Bloom filters that Git will read and
> +	write. May be -1, 0 or 1. Note that values greater than 1 may be
> +	incompatible with older versions of Git which do not yet understand
> +	those versions. Use caution when operating in a mixed-version
> +	environment.
> ++
> +Defaults to -1.
> ++
> +If -1, Git will use the version of the changed-path Bloom filters in the
> +repository, defaulting to 1 if there are none.
> ++
> +If 0, Git will not read any Bloom filters, and will write version 1 Bloom
> +filters when instructed to write.
> ++
> +If 1, Git will only read version 1 Bloom filters, and will write version 1
> +Bloom filters.
> ++
> +See linkgit:git-commit-graph[1] for more information.
> diff --git a/commit-graph.c b/commit-graph.c
> index 00113b0f62..91c98ebc6c 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -459,7 +459,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
>  			graph->read_generation_data = 1;
>  	}
>  
> -	if (s->commit_graph_read_changed_paths) {
> +	if (s->commit_graph_changed_paths_version) {
>  		read_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
>  			   graph_read_bloom_index, graph);
>  		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
> @@ -555,7 +555,8 @@ static void validate_mixed_bloom_settings(struct commit_graph *g)
>  		}
>  
>  		if (g->bloom_filter_settings->bits_per_entry != settings->bits_per_entry ||
> -		    g->bloom_filter_settings->num_hashes != settings->num_hashes) {
> +		    g->bloom_filter_settings->num_hashes != settings->num_hashes ||
> +		    g->bloom_filter_settings->hash_version != settings->hash_version) {
>  			g->chunk_bloom_indexes = NULL;
>  			g->chunk_bloom_data = NULL;
>  			FREE_AND_NULL(g->bloom_filter_settings);
> diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
> index 2992079dd9..325c0b991a 100644
> --- a/oss-fuzz/fuzz-commit-graph.c
> +++ b/oss-fuzz/fuzz-commit-graph.c
> @@ -19,7 +19,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
>  	 * possible.
>  	 */
>  	the_repository->settings.commit_graph_generation_version = 2;
> -	the_repository->settings.commit_graph_read_changed_paths = 1;
> +	the_repository->settings.commit_graph_changed_paths_version = 1;
>  	g = parse_commit_graph(&the_repository->settings, (void *)data, size);
>  	repo_clear(the_repository);
>  	free_commit_graph(g);
> diff --git a/repo-settings.c b/repo-settings.c
> index 30cd478762..c821583fe5 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -23,6 +23,7 @@ void prepare_repo_settings(struct repository *r)
>  	int value;
>  	const char *strval;
>  	int manyfiles;
> +	int read_changed_paths;
>  
>  	if (!r->gitdir)
>  		BUG("Cannot add settings for uninitialized repository");
> @@ -53,7 +54,10 @@ void prepare_repo_settings(struct repository *r)
>  	/* Commit graph config or default, does not cascade (simple) */
>  	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
>  	repo_cfg_int(r, "commitgraph.generationversion", &r->settings.commit_graph_generation_version, 2);
> -	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
> +	repo_cfg_bool(r, "commitgraph.readchangedpaths", &read_changed_paths, 1);
> +	repo_cfg_int(r, "commitgraph.changedpathsversion",
> +		     &r->settings.commit_graph_changed_paths_version,
> +		     read_changed_paths ? -1 : 0);
>  	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
>  	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
>  
> diff --git a/repository.h b/repository.h
> index 5f18486f64..f71154e12c 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -29,7 +29,7 @@ struct repo_settings {
>  
>  	int core_commit_graph;
>  	int commit_graph_generation_version;
> -	int commit_graph_read_changed_paths;
> +	int commit_graph_changed_paths_version;
>  	int gc_write_commit_graph;
>  	int fetch_write_commit_graph;
>  	int command_requires_full_index;
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index 484dd093cd..642b960893 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -435,7 +435,7 @@ test_expect_success 'setup for mixed Bloom setting tests' '
>  	done
>  '
>  
> -test_expect_success 'ensure incompatible Bloom filters are ignored' '
> +test_expect_success 'ensure Bloom filters with incompatible settings are ignored' '
>  	# Compute Bloom filters with "unusual" settings.
>  	git -C $repo rev-parse one >in &&
>  	GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=3 git -C $repo commit-graph write \
> @@ -485,6 +485,33 @@ test_expect_success 'merge graph layers with incompatible Bloom settings' '
>  	test_must_be_empty err
>  '
>  
> +test_expect_success 'ensure Bloom filter with incompatible versions are ignored' '
> +	rm "$repo/$graph" &&
> +
> +	git -C $repo log --oneline --no-decorate -- $CENT >expect &&
> +
> +	# Compute v1 Bloom filters for commits at the bottom.
> +	git -C $repo rev-parse HEAD^ >in &&
> +	git -C $repo commit-graph write --stdin-commits --changed-paths \
> +		--split <in &&
> +
> +	# Compute v2 Bloomfilters for the rest of the commits at the top.
> +	git -C $repo rev-parse HEAD >in &&
> +	git -C $repo -c commitGraph.changedPathsVersion=2 commit-graph write \
> +		--stdin-commits --changed-paths --split=no-merge <in &&
> +
> +	test_line_count = 2 $repo/$chain &&
> +
> +	git -C $repo log --oneline --no-decorate -- $CENT >actual 2>err &&
> +	test_cmp expect actual &&
> +
> +	layer="$(head -n 1 $repo/$chain)" &&
> +	cat >expect.err <<-EOF &&
> +	warning: disabling Bloom filters for commit-graph layer $SQ$layer$SQ due to incompatible settings
> +	EOF
> +	test_cmp expect.err err
> +'

At this point in the series this test fails with:

  + test_cmp expect.err err
  + test 2 -ne 2
  + eval diff -u "$@"
  + diff -u expect.err err
  --- expect.err  2024-01-29 21:02:57.927462620 +0000
  +++ err 2024-01-29 21:02:57.923462642 +0000
  @@ -1 +0,0 @@
  -warning: disabling Bloom filters for commit-graph layer 'e338a7a1b4cfa5f6bcd31aea3e027df67d06442a' due to incompatible settings
  error: last command exited with $?=1


> +
>  get_first_changed_path_filter () {
>  	test-tool read-graph bloom-filters >filters.dat &&
>  	head -n 1 filters.dat
> -- 
> 2.43.0.334.gd4dbce1db5.dirty
> 
