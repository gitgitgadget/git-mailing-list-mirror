Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EFA3D34B7
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038490; cv=none; b=hA5T0GgS5D4cfes/h66IqgjasxXhYJ5AXOXT5GPleD57rsSuRbWBpjr9hC1Ba2WSXIDm4Fr5fmJr8ZBFmFj37w2g9s2p+4vxquY1JK1hPoa97uJuH7JZT0b6prJIyh8FbG3REajaknEr9g27o4QEsqNsXAIv9F5t4SDgBENzcWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038490; c=relaxed/simple;
	bh=uH7n9ALRf+Njvx1qP/uZsqjoZJYFA5d6jQnustDS/9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAtzUtjyVYHHuma5O6j0VOB+MxclY8lyS0ZgShO1+OLlUpovIGa6rbkd4PN/xkQ2PEjLZIs/pVtkacz7h7X12xDmp5c9rd5Uguc+dOzQT1hCSDQgAEJj0fMgCiEv1ju1n27kFikm6210/zkTQHkvSbBol7Vyg2GJGQrOHc/kOXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=PFnayA/E; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="PFnayA/E"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id GGt2wLv0de3PcGGt3wdzfd; Fri, 24 Apr 2026 14:48:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1777038485; bh=Y+6BNU4ukAGItBTpdcOrv3VeTkLnndZxUcgyeiP7y5k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PFnayA/EabZ7oUZ1Q1ycdPDx2iE/7t4m7AW8wF5HE8Jq826/RhCtCPBCYyPvJCML2
	 DEkGiTiZTfrXyzzUrhGGcQYn26RtxUewX70LCsz+nmzRBZXsHwX/omQXOMeoI6t36x
	 /E5HPMq0L05v/l6a9xMKEKLO7CakdZV4gTaP16GXJWG0WFDnnjAysfdtFMTOpysW62
	 11yxmh0IqE6NnjMiah9CSJ6q9V95iHPRDp2jn15khjFACIyjCY2OMCEVAb+31Rpa7/
	 a4ZXYhEqT7TIoSalAaV4612J6Su22TALJiebpYVU6qE5XxVcfE/iX7uYsONHR1cjHr
	 5PQUE2JmyLANA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=FMy4xPos c=1 sm=1 tr=0 ts=69eb7495
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=Memj1J29uPYTSwaFmhkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <d7ffcab0-cec3-4cea-97d7-1b359b4ff55e@ramsayjones.plus.com>
Date: Fri, 24 Apr 2026 14:48:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkout: add --fetch to fetch remote before resolving
 start-point
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2281.git.git.1777024991531.gitgitgadget@gmail.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <pull.2281.git.git.1777024991531.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOEgxCayTFuhXUCfly6pHPMLzNTEMsKkMLy33mG249vJ6pSVxwri7cXmmsOCYwXyotUf3g7qInhisShc4UvK32v0+ad/EgRws7xmErzowjFA/sC4ANNL
 0UAzYamuUGaPtjLdb2RoEjPvDXl3FV4+IwmrCBCOWD2ISv3YRUnAQBYiZt84YHk6TgqBMkCtgC2k+TlxA94KxDCDywa3ew3uv0k=



On 24/04/2026 11:03 am, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add a --fetch option to git checkout and git switch, plus a
> checkout.autoFetch config to enable it by default. When set and the
> start-point argument names a configured remote (either bare, like
> "origin", or prefixed, like "origin/foo"), fetch that remote before
> resolving the ref. Aborts the checkout if the fetch fails.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---

[snip]

>  
> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 9bcf7c0b40..60ddebd9c3 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -801,4 +801,55 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
>  	test_cmp_config "" --default "" branch.main2.merge
>  '
>  
> +test_expect_success 'setup upstream for --fetch tests' '
> +	git checkout main &&
> +	git init fetch_upstream &&
> +	test_commit -C fetch_upstream u_main &&
> +	git remote add fetch_upstream fetch_upstream &&
> +	git fetch fetch_upstream &&
> +	git -C fetch_upstream checkout -b fetch_new &&
> +	test_commit -C fetch_upstream u_new
> +'
> +
> +test_expect_success 'checkout --fetch -b picks up branch created upstream after clone' '
> +	git checkout main &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_new &&
> +	git checkout --fetch -b local_new fetch_upstream/fetch_new &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_new HEAD
> +'
> +
> +test_expect_success 'checkout --fetch with bare remote name fetches the remote' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_new2 &&
> +	test_commit -C fetch_upstream u_new2 &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_new2 &&
> +	git checkout --fetch -b local_from_remote fetch_upstream &&
> +	git rev-parse --verify refs/remotes/fetch_upstream/fetch_new2
> +'
> +
> +test_expect_success 'checkout --fetch aborts and does not create branch on fetch failure' '
> +	git checkout main &&
> +	test_might_fail git branch -D bogus &&
> +	test_must_fail git checkout --fetch -b bogus fetch_upstream/does_not_exist &&
> +	test_must_fail git rev-parse --verify refs/heads/bogus
> +'
> +
> +test_expect_success 'checkout.autoFetch=true enables fetching without --fetch' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_cfg &&
> +	test_commit -C fetch_upstream u_cfg &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_cfg &&
> +	git -c checkout.autoFetch=true checkout -b local_cfg fetch_upstream/fetch_cfg &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_cfg HEAD
> +'
> +
> +test_expect_success 'switch --fetch -c picks up branch created upstream after clone' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_switch &&
> +	test_commit -C fetch_upstream u_switch &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_switch &&
> +	git switch --fetch -c local_switch fetch_upstream/fetch_switch &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_switch HEAD
> +'
> +

I was just skimming the list (so if this is not appropriate, please just ignore) and,
although I think '--no-fetch' will probably countermand the autoFetch config, I do not
see a test that confirms it.

Thanks.

ATB,
Ramsay Jones


