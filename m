Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA2241695
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771871; cv=none; b=OCstgaCOr6jy2HmEGeJZE4BlH5WgTNeWMhxZq4XDTBjgNugiGVQtmXuiycFt3zD04pivIHEQizxeaI6s7hHkzfQMXq8R6ZfqfVyDvwJUU2sFVCNlHjoQ3dCuru0n/HWLls3blfAEV7J6QA9W/cLz5SmrpRG4Ip+t1O3UmmenIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771871; c=relaxed/simple;
	bh=cKKu2o2CljXNTTx3ANiBZioKHPb2tpr2rWMBgOou5II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0Le1FxlA/gckKeBkNHrjRQLUjbG4QbYEtadmpGZHBpBiKdycbZc+PgrKOQ0pI359lyywcwLG8wFo4e46fRiFZbm1mqOVil3z4SNjsZq95aGG2YmrGgZk4sP+mSNUgrQc7pyX5wzpB61HGcuYeA94FXFkU+/SZZ6sU03B3HLxeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYhpqvuD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYhpqvuD"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d5c59f2b6so79712466b.2
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 14:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761771868; x=1762376668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bFaYUISnCA2KwI7NgGERWj8ztThA6Y69ACXbn9cFqk=;
        b=EYhpqvuDyH7hPUkIREU8nYtAoJ3ZNDK5MeeLjutNGT74u8ZzxjepGC/UqkXb0ue0yY
         WKHL0mdiHr5JWnc+PgNo9Ac7xV3QHgZKRls++J8g4eL49FiW7vb30PteqI6U5LY8BORR
         WarXfhW/jpHF4or3e/MiLPcxiLWOXwG5g/ClnynP8JFfkgfNTRpnypYCs1zckCWp3VQi
         fPUmFbNeSvMHVdzMsAlcljoQpugIgwGp2tQIRhEmM8d6VcI5tI6MqsIiMtQL9HlmBwid
         ZKZcm+osBJuElpXi/ycI4EdiGUHxKCMZNssr7VJBZbjBcPA6OESTGCMwiRzfEau0GIrk
         NWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761771868; x=1762376668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bFaYUISnCA2KwI7NgGERWj8ztThA6Y69ACXbn9cFqk=;
        b=Rt3vL3TzbS8A6qqx4VedV9Cr3U9MBb37Wb4fsWfLWLeTv+Uqxnh9VAJnWDqaTC+LJr
         YYXe3BZIcnXOh5kiFyrV4rtfyfVa4g46CSDj/Dsednbv+FoQO9SjMngVTKG06/8JURTW
         PH5BnifOYMaX1xVeT1Iz15Ts7E+MJ2T8Ofi4YjpyGgUybQEFTn0mxFxnzdz8eTd7LmH3
         ReRirNyb794lrjetwE3K071m9glQR2HDq4rGDZPMk0R8iCvGj57yzQdT1gRU2B8/3jla
         P/rfmf9Re3q/9s7YUklAMmRoSlIEpS6bxaNTEngrRLpuooHuc/7Z2JGtnNvhPA037vtD
         L/+g==
X-Gm-Message-State: AOJu0Yy4qYseDjOcDBQB9+MS/75bzjCf/CZyWAHMCVO+PbsNSIBhIsHM
	wrZhNv1LSL2bp4Tl9VOLwa/4SoUObWtI8psC24/+Rub4Uo5a8CpD9PT8
X-Gm-Gg: ASbGncsqdXWmWY7IV6kTQ2XhRi/EOb++G7YEVcq5IJzQYO/2gvAH5kLlh49TBn9TwQA
	2GmcOWiDEGv1fBanT7Oz+YWY9/EkIxO/TbI+9KBZcDo/MMOyx/Mg3W1PhN/UYSWSVDmVZogGxy7
	KzbZ7BXi8wg9nR7zJ0nXlyU1k1lUzgWix7q5W7h67woUzicJ4MkjuWa8HMp6FFm94ono2KQ+plm
	zuWCk99VBtjVyENXNTNSygenP4HyAPKzaOsIrH1ibAuTsdruVqK2XWgyUVyb/iAIwHkFICzfujZ
	hgdBVPg18aVjzLoDBShQZP77bDp0CBLoRI3pRDVDJUrkg3UwOd387+VDPdbIxam2fwvPIwKHyYh
	fEsHCzbxu+4zQyw7UEcbYuuD2IMYiK+C/8oWOkfFIGHXCRrCqg0Asb+W6w70KTedp1wYOxpz2y5
	NvBp8iTeD2Xx+AoSdeYrbyLwp0UGoGMDcSBjptflIH
X-Google-Smtp-Source: AGHT+IGRZyiJMk0KvzpyXVHjS4jkN3Ctq6XXiUbPhyCy8gWcB2is99vGHXk9pr6mf4LRB1CdWApJiQ==
X-Received: by 2002:a17:907:d8e:b0:b04:6546:345a with SMTP id a640c23a62f3a-b703d55d4c0mr426755066b.52.1761771867896;
        Wed, 29 Oct 2025 14:04:27 -0700 (PDT)
Received: from localhost (62-165-236-60.pool.digikabel.hu. [62.165.236.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7044d00de6sm264880266b.74.2025.10.29.14.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:04:27 -0700 (PDT)
Date: Wed, 29 Oct 2025 22:04:13 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Emily Yang via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
	me@ttaylorr.com, ps@pks.im, newren@gmail.com,
	Emily Yang <emilyyang.git@gmail.com>
Subject: Re: [PATCH v2] commit-graph: add new config for changed-paths &
 recommend it in scalar
Message-ID: <aQKBTQRQkGTgXkd6@szeder.dev>
References: <pull.1983.git.1760043710502.gitgitgadget@gmail.com>
 <pull.1983.v2.git.1760734739642.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1983.v2.git.1760734739642.gitgitgadget@gmail.com>

On Fri, Oct 17, 2025 at 08:58:59PM +0000, Emily Yang via GitGitGadget wrote:
> From: Emily Yang <emilyyang.git@gmail.com>
> 
> The changed-path Bloom filters feature has proven stable and reliable
> over several years of use, delivering significant performance
> improvement for file history computation in large monorepos. Currently
> a user can opt-in to writing the changed-path Bloom filters using the
> "--changed-paths" option to "git commit-graph write". The filters will
> be persisted until the user drops the filters using the
> "--no-changed-paths" option. For this functionality, refer to 0087a87ba8
> (commit-graph: persist existence of changed-paths, 2020-07-01).
> 
> Large monorepos using Git's background maintenance to build and update
> commit-graph files could use an easy switch to enable this feature
> without a foreground computation. In this commit, we're proposing a new
> config option "commitGraph.changedPaths":
> 
> * If "true", "git commit-graph write" will write Bloom filters,
>   equivalent to passing "--changed-paths";
> * If "false" or "unset", Bloom filters will be written during "git
>   commit-graph write" only if the filters already exist in the current
>   commit-graph file. This matches the default behaviour of "git
>   commit-graph write" without any "--[no-]changed-paths" option. Note
>   "false" can disable a previous "true" config value but doesn't imply
>   "--no-changed-paths".

So if the commit-graph contains changed path Bloom filters, and the
user takes the effort, and explicitly sets this config variable to
false, then Git will just ignore that, and will continue to waste
resources to compute the Bloom filters?!  This doesn't seems like a
sensible behavior to me.


> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 0b3404f58f..98c6910963 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -946,4 +946,48 @@ test_expect_success 'stale commit cannot be parsed when traversing graph' '
>  	)
>  '
>  
> +test_expect_success 'config commitGraph.changedPaths acts like --changed-paths' '
> +	git init config-changed-paths &&
> +	(
> +		cd config-changed-paths &&
> +
> +		# commitGraph.changedPaths is not set and it should not write Bloom filters
> +		test_commit first &&
> +		GIT_PROGRESS_DELAY=0 git commit-graph write --reachable --progress 2>error &&
> +		test_grep ! "Bloom filters" error &&
> +
> +		# Set commitGraph.changedPaths to true and it should write Bloom filters
> +		test_commit second &&
> +		git config commitGraph.changedPaths true &&
> +		GIT_PROGRESS_DELAY=0 git commit-graph write --reachable --progress 2>error &&
> +		test_grep "Bloom filters" error &&
> +
> +		# Add one more config commitGraph.changedPaths as false to disable the previous true config value
> +		# It should still write Bloom filters due to existing filters
> +		test_commit third &&
> +		git config --add commitGraph.changedPaths false &&
> +		GIT_PROGRESS_DELAY=0 git commit-graph write --reachable --progress 2>error &&
> +		test_grep "Bloom filters" error &&
> +
> +		# commitGraph.changedPaths is still false and command line options should take precedence
> +		test_commit fourth &&
> +		GIT_PROGRESS_DELAY=0 git commit-graph write --no-changed-paths --reachable --progress 2>error &&
> +		test_grep ! "Bloom filters" error &&
> +		GIT_PROGRESS_DELAY=0 git commit-graph write --reachable --progress 2>error &&
> +		test_grep ! "Bloom filters" error &&
> +
> +		# commitGraph.changedPaths is all cleared and then set to false again, command line options should take precedence
> +		test_commit fifth &&
> +		git config --unset-all commitGraph.changedPaths &&
> +		git config commitGraph.changedPaths false &&
> +		GIT_PROGRESS_DELAY=0 git commit-graph write --changed-paths --reachable --progress 2>error &&
> +		test_grep "Bloom filters" error &&
> +
> +		# commitGraph.changedPaths is still false and it should write Bloom filters due to existing filters
> +		test_commit sixth &&
> +		GIT_PROGRESS_DELAY=0 git commit-graph write --reachable --progress 2>error &&
> +		test_grep "Bloom filters" error
> +	)
> +'

The interaction of split commit-graphs and changed path Bloom filters
used to be buggy, even after attempts to fix it.  Therefore, I think
this config variable should be tested with split commit-graphs as
well.

