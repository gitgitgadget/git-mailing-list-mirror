Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0359F36E468
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 05:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790832978; cv=none; b=OTTORvXK98FJ1KzYp2BbHxHEkGEwHj78q79wdLpygWMzN8ZQghCZ97eGQ/hs1Ma+5muEwQ6UZh+16i3EmHadT6pTv2XhZq0/gqEMmZJ7kuhzwskGiN3PqyHJEkxKRdMDIn7r7SaZzofhpXksHtMUK/JyNdVzHp9BV2WvqkZDXAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790832978; c=relaxed/simple;
	bh=8j/ei69uACWlbUPIKfaI9II0Oz1DBLHElBdh53Sdyco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7jG890MIeHu1g6HtV+aiI8l/pL4thbN6ewnMXHggj9mzwt3XFHgllczi8CHsGfdrnTGEvIx7fo6gqeqjBE4VdLtoR6MgUAnT9W2vzBZ6b521Wfqhrr2sR4M6DKxnJCyiE0ceV0HManv9/J7sEfc6e2bSy4YQBh05uO4HtqYeG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ChuSic6B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ftFW3+CG; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ChuSic6B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ftFW3+CG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0876414000CC;
	Thu,  1 Oct 2026 01:36:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 01:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790832976; x=1790919376; bh=0ORT6OeT/3
	L0AJ/wShgkJVbJF4mfhOQ724m5XXRFWoE=; b=ChuSic6BAxtbxG6gBWRbjl+F4Y
	DI5t/XfaE/zDK9q0rlfsKyB6wekzYwKlzrPI9B+xlqr/Dx38Q/nzJtJldLEh7vCC
	0k5Fq93CBN+69xTv6XdQZ3hLA+enJJTGlNB/9T/FcMp32h5RvzSUsJhWxNtAE1n2
	u0ZZ7tTFp2/weWTin3FdyVZ5Dq3HWfM4x7o+djlmmTrW3h8vagmeABpZh4uwloOO
	A8mtNp6Eaxfl1NpmMaKBQw/ubRJzwtAoybv6iTIWHNUW17aPPZT6Vcs2GkGIgQ8K
	tb/vJfjkGDryOYZ8g7Sm5EZ+gy2/nICdT89v4sQUUOi/Dwo2iwGukVxlD1Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790832976; x=1790919376; bh=0ORT6OeT/3L0AJ/wShgkJVbJF4mfhOQ724m
	5XXRFWoE=; b=ftFW3+CGbaxmMZDLHYFPnJ90D7E1ksIn68/Npu/I0PciNwkD75b
	Qpv3/QxuIw3PplrnH7v7JgAFK6xjUzbEx33ENiwAs1a7XfJwR4QH1WrLM872D2LF
	ztqLlA9h0TsVZO3FXlS6VaDwXFFueOfaWsiI0hWWewXYPaLIU1iFOE+SLTxzafDp
	Y62Lv329oa6JfrVhmbjmAcD0GwwKt0SXu40n9/FKGe9AgJmJeMnqI6iEWTlLcPSS
	Y5+99QqEhLQ5NM3wDvqEvhAD23FWjnpnMYHUqDfu9lnSbcBDFFo7NU6VvTITFdWU
	vYgBFMy+91Tv5WnHanN7z+tJ7auwEVqyViw==
X-ME-Sender: <xms:T_G9asHtITypwsSBFITfBE9l4wx1vXUirdQ9ffVyifZrTbDvjnhlng>
    <xme:T_G9asyYy1P621qwvHYKsCVd5-YGWuJBISVlJyhjdQBCUoSAuSn9baycBuLzVNHPh
    8O-BAgAV8s1t2Po-la4Aio3CX0YWTHgQ6t1qu9HwxYHoNyfQ9wyXtM>
X-ME-Received: <xmr:T_G9ajhfhZH6UE3ZkTPfO9Om1c2pLaOYj3ZXJ8Oc28eet3_IYlvxm3RcqKUcy864H95Xgw>
X-ME-Proxy-Cause: dmFkZTEBziYnbEQ7hFMMQnUuvmbIEWUB/J1m717tuVfk9JgHefKJ6oOr7/rQAPLtBMbKOL
    i2X/5ti0obt5yn3Wxt928SqDeuSz9w+Gd3SoVXUu375MBgPY5Qtc8Lmgp2FkQEDD939hkV
    PKLcPZ5lUhIO5iX2uDfaTzlivxrggbydGPcPb1DLUZDZqIO6l51iHe4O8omyOQci7qcm5Z
    hpcZHkofIwJCH/y9WuuZUNdBuk7W0qgsfmmn2R1eXMO7pb+YS2T037jC2WJ6AWovdLWVU9
    zNAj/i6MoDjJ8hm6KKqHv05TOl2YUEsPxVVDZ8qmbm1zL+GoUl+L/hCxZvKDeKXI4xGyHs
    82Y0/UYEHql4lpsIQVLm0B5N078oAzmyPEnTjKqgacXLNHwaqO+m11MIbGpYjmlX+f2dRu
    xXdsOL4pi20siNwXJc1sgxSgI45efJnqCkxhze9Uaynn8bOg1M5QAYGZ+YnOkSmODBm7Hm
    wCfyiWbFewJWIMxMzEnFRBXeO4p63QPDBwtbSlVLNr8b9yDso3+VNwovdRgOxJnoRkelQk
    LFuW4H/9EDwENOkG9B9In1DHg6+3YfCa606V2OOe6EZZmtyc8XNpbUWA2Rw1KWmxp9pfK1
    uDYnD2tK84f5a1rM0HErbeT+8vm40gPHVRJur8msAqnCJGmOsv6adk8iVPQQ
X-ME-Proxy: <xmx:T_G9anxewAm3v_-FxGKmOLAEEJ3xjSmB2wP8uygL9_CvilttpRdloA>
    <xmx:T_G9amIefQjjmSABStwa7eov8pfWTDm8NeUoEHgoTRpBI2z7EsDNXw>
    <xmx:T_G9auR8ew_4iS-LGXzIvIdTnICIhOWoINwXzAo0MkBX-ymPTgbOGQ>
    <xmx:T_G9auoOzNGWBIvMZCiw2Tog5MP8jZr3St-wSlmGomdDKMR1alaQsg>
    <xmx:UPG9aieo2hu_APi4qGjbjqSD22t_aFyMrz2GKQj1QcEvoFiOLESINXHw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 01:36:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 624b9eeb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 05:36:13 +0000 (UTC)
Date: Thu, 1 Oct 2026 07:36:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Grant Moyer <dev@grantmoyer.com>
Cc: git@vger.kernel.org, Michele Locati <michele@locati.it>
Subject: Re: [PATCH v2] filter-branch: fix commit map init from state branch
Message-ID: <ar3xSurCd0-yDruA@pks.im>
References: <20260801033127.10606-1-dev@grantmoyer.com>
 <20261001012347.3998801-1-dev@grantmoyer.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001012347.3998801-1-dev@grantmoyer.com>

On Wed, Sep 30, 2026 at 09:23:47PM -0400, Grant Moyer wrote:
> The commit map dir is populated from the state branch assuming a
> "to_commit:from_commit" format, but the state branch is written with a
> "from_commit:to_commit" format, resulting in an inverted mapping when the
> map is populated from the state branch. This is especially evident when
> --prune-empty is used and creates commits which map to nothing; when the
> map dir is populated from this state on subsequent runs, git-filter-branch
> outputs many errors while trying to create files with empty names, like:

This still doesn't mention the commit that introduced the regression.

> > /usr/lib/git-core/git-filter-branch: line 305: ../map/: Is a directory
> 
> This change corrects the population of the commit map dir to match the
> "from_commit:to_commit" format and adds/updates tests to check that the
> state branch is written correctly.

Nit: we typically write commit messages in imperative mood, as if you
were instructing the code to change.

> Signed-off-by: Grant Moyer <dev@grantmoyer.com>
> Tested-by: Michele Locati <michele@locati.it>
> Co-authored-by: Michele Locati <michele@locati.it>

Your Signed-off-by should always go last because you're signing off on
everything that comes before it.

How about this message:

  The "--state-branch" option asks git-filter-branch(1) to write a
  mapping from old to new objects into the branch. This map is a
  simple blob stored in "$state_branch:filter.map" with the format
  "$to_commit:$from_commit".

  In f6d855091e (filter-branch: stop depending on Perl, 2025-04-16), we
  have refactored git-filter-branch(1) to no longer require Perl. But as
  part of that change we accidentally started to interpret the above
  format in reverse when populating the map directory. This of course
  breaks incremental rewrites that use the commit map multiple times.
  But we don't seem to  have any tests for this feature, and as a
  consequence we didn't notice the regression.

  Fix this bug by interpreting the mappings in the correct order again.

  Tested-by: Michele Locati <michele@locati.it>
  Co-authored-by: Michele Locati <michele@locati.it>
  Signed-off-by: Grant Moyer <dev@grantmoyer.com>

> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index 86011e7b1f..cf225b0f0f 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -121,10 +121,32 @@ W=$(git rev-parse HEAD)
>  test_expect_success 'using --state-branch to skip already rewritten commits' '
>  	test_when_finished git reset --hard $V &&
>  	git reset --hard $V &&
> -	git filter-branch --state-branch state -f --tree-filter "touch file || :" HEAD &&
> +	git filter-branch --state-branch state -f --tree-filter "exit 1" HEAD &&
>  	test_cmp_rev $W HEAD
>  '
>  
> +test_expect_success '--state-branch incremental rewrite uses the rewritten parents' '

We could add `test_when_finished rm -rf incremental` here.

> +	git init incremental &&
> +	(
> +		cd incremental &&
> +		mkdir sub &&
> +		test_commit first sub/file &&
> +		test_commit outside root-file &&
> +		git filter-branch --state-branch refs/state \
> +			--prune-empty --subdirectory-filter sub -- HEAD &&
> +		rewritten_first=$(git rev-parse HEAD) &&
> +		git reset --hard outside &&
> +		test_commit second sub/file &&
> +		git filter-branch -f --state-branch refs/state \
> +			--prune-empty --subdirectory-filter sub -- outside..HEAD &&
> +		test_cmp_rev $rewritten_first HEAD^ &&
> +		git show refs/state:filter.map >map &&
> +		echo "$(git rev-parse second):$(git rev-parse HEAD)" >expect &&
> +		grep "^$(git rev-parse second):" map >actual &&
> +		test_cmp expect actual
> +	)
> +'

Thanks!

Patrick
