Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE051B951
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708899329; cv=none; b=GDVvPMVGVdcZ3X++Bh+DrT2qSDqKpvgnqarAh2zvBz5ezAzvrOEJvh52c5AlHEruDuokLvqFYeuVpacg/4gJQL3em1sf02d1cbS3EFcEgkkAu6NuXqzzYVebVSMw1ymBGlxPTajlNBjzYijweBiD9OumEQXuXrGILIxVbGxvKl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708899329; c=relaxed/simple;
	bh=CK/lgOb5fBUat8qDOYLsXTy8emoMgXTyaeOTutx9MqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMhkT1dXvdO8hdiP2iLXxcE+yKojNqH4pv2uIPnVlNz8a3dam7ZTtkiCaJ4AsXfMttZ/Y+qJ8c6drkXZSgFy1M+jXzi6kFLQDBFHiYrSBo8+TZBoT79IvOOP1qxlyaUH/bs1rHqmZXeo4HGpg4oKFG0HYHNkMs8MwPP2JmUmgIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqDBHXUT; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqDBHXUT"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5648d92919dso3114086a12.1
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 14:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708899326; x=1709504126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBBD4FjAEl9UKbO4PZvRIe1x8TIkAl6wqbClynRk314=;
        b=IqDBHXUTcjkVUyEYT3UZTNesITmGpp2qVM0dgGFGnEDBVet3U25MT78UeJ/2lVrtA2
         a1Sbe6tH7QkjrM7MINOChp21K6f9NSez47SCy1raHeATzrPw+FVWnbMDXv7ofwKcYLcz
         3NwQIKcFOWU50NFwyjupZk6+DW+w5+oisc5Cm6P79tP+yKxJV+xObbmX7eyVVEOBX51D
         PQ0hc+xfQrn82makf9qLzV+4u//s9QjUpqZF+lxI/MsskWDe/hbbFnGUrGCqr24ZZotZ
         AzhymQgKcfYRuHSX/qEEoIJIIT1okTyX7OqEv1B5YOO2yv0ITtxtdrYPIXTFH044+lwJ
         v0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708899326; x=1709504126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBBD4FjAEl9UKbO4PZvRIe1x8TIkAl6wqbClynRk314=;
        b=EAY2fUyVF0GcU9wGXHUJ+AOhGsDp8FBnjXl6HHciaQMFumXd58V3r9akIT3snYOyjQ
         Um+VjkMPrJd+BG2aCX9c6dnEKr4W1TfiudLjml+mD7KvNjeD4uSJ34cUc/j+5UamKQmS
         tqx4klF6uYcwxF+Ykzh9oW9G33Ct8+c0VFcI4wdbzyIFytqBWcWOKpF35AYEqirwDjlQ
         cRcfKaQLwXsIKkZrD3GzUBtMGXHJNU8SrNQiQRiRdYHUe92e9blUKkOecB/09gUSwM5f
         rB0czEnmMxnhoMZgAgx99fxrmWkqlvDdNnhmz795/YhEYRHMtqYu8xt0hbez7fmouNze
         woLA==
X-Gm-Message-State: AOJu0YzvMNyOVXgta4Lti7HIhqGjWSwiwkiZcJxWWEMo0dgSv59bcj6O
	ILvmKMGzqECHXVEXm2wjgX1zgrX32TQhaI9a3JITVdIBBwj8JZMN
X-Google-Smtp-Source: AGHT+IEW+BOHbNd9U8wzeTmieWVMnP2gsU65YmIwvSjZlEJ0THvSUateAIiifTHjU7g9RxCn9lhwbA==
X-Received: by 2002:a05:6402:40d2:b0:565:e030:2d2c with SMTP id z18-20020a05640240d200b00565e0302d2cmr1165549edb.36.1708899325622;
        Sun, 25 Feb 2024 14:15:25 -0800 (PST)
Received: from localhost (94-21-146-251.pool.digikabel.hu. [94.21.146.251])
        by smtp.gmail.com with ESMTPSA id s8-20020a056402164800b005652f6a9533sm1753439edx.74.2024.02.25.14.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 14:15:25 -0800 (PST)
Date: Sun, 25 Feb 2024 23:15:24 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 13/16] commit-graph: new Bloom filter version that
 fixes murmur3
Message-ID: <20240225221524.GA1940392@szeder.dev>
References: <cover.1706741516.git.me@ttaylorr.com>
 <d2f11c082d3bf10d9127c330a7d59b7e47ac4f21.1706741516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2f11c082d3bf10d9127c330a7d59b7e47ac4f21.1706741516.git.me@ttaylorr.com>

On Wed, Jan 31, 2024 at 05:52:54PM -0500, Taylor Blau wrote:
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index 93b8d096cf..a7bf3a7dca 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -485,6 +485,33 @@ test_expect_success 'merge graph layers with incompatible Bloom settings' '
>  	test_must_be_empty err
>  '
>  
> +test_expect_success 'ensure Bloom filter with incompatible versions are ignored' '
> +	rm "$repo/$graph" &&
> +
> +	git -C $repo log --oneline --no-decorate -- $CENT >expect &&

The $CENT variable is not set at this point in the test script.
However, even if it were, the repository used in this test case
doesn't contain any file with that name.

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

The variable $repo is used 9 times in this test case.  I think it
would be simpler and easier follow if it used a ( cd $repo && ... )
subshell, like many of the previous tests in this test script, 

> +'
> +
>  get_first_changed_path_filter () {
>  	test-tool read-graph bloom-filters >filters.dat &&
>  	head -n 1 filters.dat
> @@ -536,6 +563,120 @@ test_expect_success 'version 1 changed-path used when version 1 requested' '
>  	)
>  '
>  
> +test_expect_success 'version 1 changed-path not used when version 2 requested' '
> +	(
> +		cd highbit1 &&
> +		git config --add commitgraph.changedPathsVersion 2 &&
> +		test_bloom_filters_not_used "-- another$CENT"
> +	)
> +'
> +
> +test_expect_success 'version 1 changed-path used when autodetect requested' '
> +	(
> +		cd highbit1 &&
> +		git config --add commitgraph.changedPathsVersion -1 &&
> +		test_bloom_filters_used "-- another$CENT"
> +	)
> +'
> +
> +test_expect_success 'when writing another commit graph, preserve existing version 1 of changed-path' '
> +	test_commit -C highbit1 c1double "$CENT$CENT" &&
> +	git -C highbit1 commit-graph write --reachable --changed-paths &&
> +	(
> +		cd highbit1 &&
> +		git config --add commitgraph.changedPathsVersion -1 &&
> +		echo "options: bloom(1,10,7) read_generation_data" >expect &&
> +		test-tool read-graph >full &&
> +		grep options full >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'set up repo with high bit path, version 2 changed-path' '
> +	git init highbit2 &&
> +	git -C highbit2 config --add commitgraph.changedPathsVersion 2 &&
> +	test_commit -C highbit2 c2 "$CENT" &&
> +	git -C highbit2 commit-graph write --reachable --changed-paths
> +'
> +
> +test_expect_success 'check value of version 2 changed-path' '
> +	(
> +		cd highbit2 &&
> +		echo "c01f" >expect &&
> +		get_first_changed_path_filter >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'setup make another commit' '
> +	# "git log" does not use Bloom filters for root commits - see how, in
> +	# revision.c, rev_compare_tree() (the only code path that eventually calls
> +	# get_bloom_filter()) is only called by try_to_simplify_commit() when the commit
> +	# has one parent. Therefore, make another commit so that we perform the tests on
> +	# a non-root commit.
> +	test_commit -C highbit2 anotherc2 "another$CENT"
> +'
> +
> +test_expect_success 'version 2 changed-path used when version 2 requested' '
> +	(
> +		cd highbit2 &&
> +		test_bloom_filters_used "-- another$CENT"
> +	)
> +'
> +
> +test_expect_success 'version 2 changed-path not used when version 1 requested' '
> +	(
> +		cd highbit2 &&
> +		git config --add commitgraph.changedPathsVersion 1 &&
> +		test_bloom_filters_not_used "-- another$CENT"
> +	)
> +'
> +
> +test_expect_success 'version 2 changed-path used when autodetect requested' '
> +	(
> +		cd highbit2 &&
> +		git config --add commitgraph.changedPathsVersion -1 &&
> +		test_bloom_filters_used "-- another$CENT"
> +	)
> +'
> +
> +test_expect_success 'when writing another commit graph, preserve existing version 2 of changed-path' '
> +	test_commit -C highbit2 c2double "$CENT$CENT" &&
> +	git -C highbit2 commit-graph write --reachable --changed-paths &&
> +	(
> +		cd highbit2 &&
> +		git config --add commitgraph.changedPathsVersion -1 &&
> +		echo "options: bloom(2,10,7) read_generation_data" >expect &&
> +		test-tool read-graph >full &&
> +		grep options full >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'when writing commit graph, do not reuse changed-path of another version' '
> +	git init doublewrite &&
> +	test_commit -C doublewrite c "$CENT" &&
> +	git -C doublewrite config --add commitgraph.changedPathsVersion 1 &&
> +	git -C doublewrite commit-graph write --reachable --changed-paths &&
> +	for v in -2 3
> +	do
> +		git -C doublewrite config --add commitgraph.changedPathsVersion $v &&
> +		git -C doublewrite commit-graph write --reachable --changed-paths 2>err &&
> +		cat >expect <<-EOF &&
> +		warning: attempting to write a commit-graph, but ${SQ}commitgraph.changedPathsVersion${SQ} ($v) is not supported
> +		EOF
> +		test_cmp expect err || return 1
> +	done &&
> +	git -C doublewrite config --add commitgraph.changedPathsVersion 2 &&
> +	git -C doublewrite commit-graph write --reachable --changed-paths &&

The path 'doublewrite' is used 8 times in this test case before
finally cd-ing into that directory in a subshell...

> +	(
> +		cd doublewrite &&
> +		echo "c01f" >expect &&
> +		get_first_changed_path_filter >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  corrupt_graph () {
>  	test_when_finished "rm -rf $graph" &&
>  	git commit-graph write --reachable --changed-paths &&
> -- 
> 2.43.0.509.g253f65a7fc
> 
