Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3392E3377
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119612; cv=none; b=Ld3UW42imSTqtSMhgTKA1G4fppymQfIke9RBUnegDUG3/VnJMP8EHRvC+7Tj3KeHrcnZaTjw6PWnxiYEWsityp8og9+6U6P1wGqe9otQhiiXAiwKaFj4J0fVSwPJ12eo8qURX63syJq3oIKTXJT4MU3CFOWovqhI2msjRYnmnIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119612; c=relaxed/simple;
	bh=td37L+NNW1EKgqj9ZVDqodkzxnCrmFP7wKsvLzoDh94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtn4ifWLluSFa8rbVU2TO9tJPHh6nyouNUwYTArtYrFAUvXHDOpOjbOovrDpNDema9k+Z28g3jW74iPK1NlY/Vf0WmuUAW8/mzl/ogGnky/HFVVO/ZdTIfGDR6K/RRCBkG/mjt1VE3UzNxNYc2hqgGG9wBWtFminHashoCBhMCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGIJLBuP; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGIJLBuP"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-727388e8f6cso3279515a34.0
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 12:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741119610; x=1741724410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+k39ykkeO5aArcV4ngGzznizSy5VxREJ0metjvF1PI=;
        b=UGIJLBuP4mCSD54JByEOPjCwozu1V90XUShcD/oymkbDGY6/i+qCY+tOkFhqfQ3nw3
         l/gCwJtY7s4rvprfMyWUMXaL4hlsgyDW18/EG3t4KjCcafhZclMIYznFeXw4TcrKilNV
         quUDiVH5buYXaJuaS1qG/yL3SvLAiLxOBoV1qoIJfZ0YV7viiUtUB1zCUOv/u9PZM+EE
         DBlz2W606pHG6oremLM5I2PEeQ+yStM8QUZNW67ZuJGDFa+kJpD76g3Cn5NkrX2kR6kT
         gYaHgTZHYPjXM1GfxAA/ilMhgbv+li9AUykRSj5mVDvgdi3FkZX5B1Epu0jvIZC1HAvc
         yWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741119610; x=1741724410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+k39ykkeO5aArcV4ngGzznizSy5VxREJ0metjvF1PI=;
        b=nwp0gakWIYfTbONtcKNRFrcE6SKDhr8z9NsC8xSzdn4ly9v1hgD79gzGyA7C25P8Y4
         fcQE8ujzYfczKhlYF2aEQh0RdPR7ohUxynOW235k0fgJPSdbGIM3CB/VzoH2AwQ7V8lB
         p+IVQ+JC80S++dxSWa6walAzE9kwOUWN9NPwUVryOnr5aL78XfqeSi9X741C0cop0h1N
         H83T0AI9TcrUOcGeNni4bRda7rv1nR3FTTCFVye6uNG0VrdiBzWC01Ks86eIGn4OHDXP
         IxO1P4EMlhfr/B+z5NJ2sk8NrPZ4/GOTNUKwRpnQ7HRm5ld8Ide7HHRHnvo4hlCQamiA
         aYPw==
X-Gm-Message-State: AOJu0YyZ9beemeqPtsYWTwRZe1u0pwPvbjI/1f7NM+Mp02gmWsFOlz4E
	7cQJiFVZg56LaS1Br2LGeiGEfKuTKDgpC8kd2BkIbr8uzVsjg8phzxCOdQ==
X-Gm-Gg: ASbGncswSaVarbTPoOx4LGrXSMTjheL0Cy73AuN17T1uex6cYTvY644ay422kISkLaD
	oag+FMN5EVVdABCQeRxfcxQSrSpKMKYMuQKaceAB+mDibsBvbONWO5oIZoqq2tsjXIOEG1Rn45y
	BSMOsbX2/NHbNH/NOwEI45vnxtfBLXUYF6da0xyrwz7u6ikP3tQ3CUPuW1YuEY9kGFn9x6u30NR
	CMuFE04tsUpcUYw/c4tqZpzlg5TdQ+lJbPIS4wF6gyaNBIC8kN1GV2swMuXpZInLctnhnqTYL27
	afpIApnNLIYtIyIkhIuwZ1/pa9UBrQvtCTpwuQ==
X-Google-Smtp-Source: AGHT+IGBFBKt3FG9wpkF1J6k3q5tYuEi2Jx5zZMPSD5qWnfpcgjgd0MBSe11AqKYppdcbHk4Esnl1w==
X-Received: by 2002:a05:6830:3c0c:b0:727:2fbd:1147 with SMTP id 46e09a7af769-72a1faf1ffbmr254236a34.2.1741119610260;
        Tue, 04 Mar 2025 12:20:10 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-60027b0a741sm328991eaf.11.2025.03.04.12.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 12:20:09 -0800 (PST)
Date: Tue, 4 Mar 2025 14:16:48 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 12/12] hash: stop depending on `the_repository` in
 `null_oid()`
Message-ID: <yl7t44tp5zhygppxrusdpiehjydncv3b6bmxhp2hgzk6xjwvbr@cjpzvpwo4vxk>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
 <20250303-b4-pks-objects-without-the-repository-v1-12-c5dd43f2476e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-12-c5dd43f2476e@pks.im>

On 25/03/03 09:47AM, Patrick Steinhardt wrote:
> The `null_oid()` function returns the object ID that only consists of
> zeroes. Naturally, this ID also depends on the hash algorithm used, as
> the number of zeroes is different between SHA1 and SHA256. Consequently,
> the function returns the hash-algorithm-specific null object ID.
> 
> This is currently done by depending on `the_hash_algo`, which implicitly
> makes us depend on `the_repository`. Refactor the function to instead
> pass in the hash algorithm for which we want to retrieve the null object
> ID. Adapt callsites accordingly by passing in `the_repository`, thus
> bubbling up the dependency on that global variable by one layer.
> 
> There are a couple of trivial exceptions for subsystems that already got
> rid of `the_repository`. These subsystems instead use the repository
> that is available via the calling context:
> 
>   - "builtin/grep.c"
>   - "grep.c"
>   - "refs/debug.c"
> 
> There is also a single non-trivial exception with "diff-no-index.c".
> Here we know that we may not have a repository initialized at all, so we
> cannot rely on `the_repository`. Instead, we adapt `diff_no_index()` to
> get a `struct git_hash_algo` as parameter. The only caller is located in
> "builtin/diff.c", where we know to call `repo_set_hash_algo()` in case
> we're running outside of a Git repository. Consequently, it is fine to
> continue passing `the_repository->hash_algo` even in this case.
> 
> This means that we could in theory just not bother about this edge case
> at all and just use `the_repository` in "diff-no-index.c". But doing so
> would feel misdesigned.
> 
> Remove the `USE_THE_REPOSITORY_VARIABLE` preprocessor define in
> "hash.c".
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> -int diff_no_index(struct rev_info *revs,
> -		  int implicit_no_index,
> -		  int argc, const char **argv)
> +int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
> +		  int implicit_no_index, int argc, const char **argv)

As mentioned in the commit message, diff_no_index() may not have a
repository initialized, so the git_hash_algo should be explicitly
passed.

Makes sense.

>  {
>  	int i, no_index;
>  	int ret = 1;
> @@ -354,7 +354,7 @@ int diff_no_index(struct rev_info *revs,
>  	setup_diff_pager(&revs->diffopt);
>  	revs->diffopt.flags.exit_with_status = 1;
>  
> -	if (queue_diff(&revs->diffopt, paths[0], paths[1], 0))
> +	if (queue_diff(&revs->diffopt, algop, paths[0], paths[1], 0))
>  		goto out;
>  	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
>  	diffcore_std(&revs->diffopt);
[snip]

The other changes in this patch largely consist of just updating
null_oid() and its call sites to recieve the git_hash_algo explicitly.

Looks good to me.

-Justin
