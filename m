Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109FA35898
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777219048; cv=none; b=mu+N3VJFjExd8NBpGrQ6WOjv/KPeWiJMmw1x7x+qFViVWuk34eUGzuLAY6E7HdvgwN5ezchx1Bdmx0w9fd7jhYHXuU18SelTTNeJtO/OH/yUxwsZu0MafXMAF+pV5J6A4Na8W8uk1npRoyTSu0rxtJpvu0OjIz9ugMwleTndxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777219048; c=relaxed/simple;
	bh=PFEeWQ2pT7Y8KrWIo23tG+2fQR+FJ8CaL8Nrxr+B+QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWtu8fdJfBqFIIQXqMy1Vn71cdJ517nHv9yeAcBskT3FtQgGW+EbiT2GAI5yE0kRjGjyly8c53CjDLMYdiIYuPYWAwBBqeGap3P1QIFVLlJTZr8U2nwVq3X0+tc6rt4WoN7lsotSvtAPYgE3KzG/5bqRrmTjwvGeoT9gWhVGQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=dTvMHB6U; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="dTvMHB6U"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id H1oEwgqqYkMb1H1oGwXHDD; Sun, 26 Apr 2026 16:54:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1777218856; bh=peQXdbUoHOwdhSKPlEcBxQNbOzkhdyRwURsj/w1Ue9o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dTvMHB6UMghSPzvnTrITFWecvr7UX3n66zYT+XCVLy18NX23WA5vhf16QUGZExf56
	 rdNS1gB8gfSsdIzp8EeS940gozGxzJup5P9Wc4PKidKWCjguE21xAz3K3Nd71DBd/C
	 +WM6oTnNewHvFoBeRnxgbIfUQnL62MUjKUFn5WgT/CPcOdC55nhhylFMzwf4qkCRW7
	 dWMfFYXfAcotitAzfa86rhiMMx60Nouczuya1Fpb5CkhWChR0Os4IQitbe3XwqUtUg
	 kTDINtP48TZ+bt+JxTcltLpE5cpmRINHPR0TtghiSILVaWlp4vQZnqcguAkydnWJHr
	 SnRyZSH4OfJZg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=AMGJABRe c=1 sm=1 tr=0 ts=69ee3528
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=S3J8K9lH7AkjNYP_8_oA:9 a=QEXdDO2ut3YA:10
 a=-hiwiRxyD_vHxcgCXVjh:22
X-AUTH: ramsayjones@:2500
Message-ID: <0c589c18-e8f6-42ac-842f-ec1f5f6fb3ff@ramsayjones.plus.com>
Date: Sun, 26 Apr 2026 16:54:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] checkout: add --fetch to fetch remote before resolving
 start-point
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Marc Branchaud <marcnarc@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2281.v2.git.git.1777140755373.gitgitgadget@gmail.com>
 <pull.2281.v3.git.git.1777188295021.gitgitgadget@gmail.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <pull.2281.v3.git.git.1777188295021.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfA3LZfXSAeR48uY7sp55un4Lf+RtF9jiOJ18gkUCGtVuggbM0Bso/Lh1MhyUqzH/p74pXRRzPo1DP41YMMhhVMF1kTCEv8bSuba0lOVREn9anUzZKB+l
 xMvOYJqQlw9wyCkZMSrCPchb33oygsNxQSgrRhiqt03s71E0EYrjKHDKkzsax8UIjdIbKO6uJngq5Z3tZNlYTgrhe+61i4DWGos=



On 26/04/2026 8:24 am, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
[snip]

> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 9bcf7c0b40..cf2ceb4052 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -801,4 +801,72 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
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
> +test_expect_success 'checkout --fetch <remote>/<branch> leaves other tracking branches untouched' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_target &&
> +	test_commit -C fetch_upstream u_target_pre &&
> +	git -C fetch_upstream checkout -b fetch_other &&
> +	test_commit -C fetch_upstream u_other_pre &&
> +	git fetch fetch_upstream &&
> +	other_before=$(git rev-parse refs/remotes/fetch_upstream/fetch_other) &&
> +	git -C fetch_upstream checkout fetch_target &&
> +	test_commit -C fetch_upstream u_target_post &&
> +	git -C fetch_upstream checkout fetch_other &&
> +	test_commit -C fetch_upstream u_other_post &&
> +	git checkout --fetch -b local_target fetch_upstream/fetch_target &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_target HEAD &&
> +	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_other)" = "$other_before"
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
> +test_expect_success 'checkout.fetch=true enables fetching without --fetch' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_cfg &&
> +	test_commit -C fetch_upstream u_cfg &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_cfg &&
> +	git -c checkout.fetch=true checkout -b local_cfg fetch_upstream/fetch_cfg &&
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
>  test_done

Still just skimming the list, so ... ;)

I seem to have missed v2 (but I guess the config name changed in v2), but it seems
that there is still no test that confirms '--no-fetch' can countermand the config
variable (or, indeed, an earlier command-line '--fetch' etc,.).

[I would have no use for this facility (I have _never_ used git-pull for similar
reasons) since I would find it odd to 'mash' git-fetch into git-checkout/switch! :) ]

ATB,
Ramsay Jones


