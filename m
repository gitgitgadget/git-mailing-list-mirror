Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670261;
	b=c4BvomYLOVLKInXWI5J0VuDfyeG4wDb/gI8UXOG+Cj2ll5D82Hd7I+wdq77241LNTPgU
	 VCDrIWVZr0GHPdxo+hVuS5VuvlsbstJAPblBg7C7dLPeq067ZxARVGBlnnmK8BgAppSen
	 NlU70rcelIx1awgiwuM9FrEmcXnk+rEhXUdktUXhRSEDNbsrPJgDo6hWeT9sUsVhju3et
	 DJM0gDQJAUlkVus6cZjI1dD/tISfGAaGuhqB/NruAyKNlKwweTdSl9uplj+WDjbJPgXHX
	 4AoavWS26UHiQx1I5WHYHMsHDQrl9II5WaKUWcaTsF9njOKP4pqQ2lKsXKJrC2OUwFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670261;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=sBfH+TjKpJJ3RCcjBccXfNZYR+L9Z829yC/wwH/cqTI=;
	b=NUcXcnJLALsScZa9LGlwfrcy5RJMJcdIuMjc5TUTRGShVhMwIJMZxl/KLa2sqT+x3xCo
	 90kFdOPLbTaoPClvkx4VRmjSUure/ScP7J0YCckhkMtdQSf0s/1DdsRsuf/6uHmuYOhMA
	 MS9ovLjE9sv3HeFfTREfBuRvJ1IqRihYE8Y5Gx2w360TsbDe268CODU+4s5fTQa4V6jfr
	 cYQ+YL4RIlSt41W51Dzroz8GEY5x8QeQQu6+yry0HBzQE0nsMlxjY9CGPL8vutEWSl3qR
	 /dI11fBF/qpdKiroRBI9Nvk3tBD7hgfBmJX+36QZeHg5jQOXKRfdUL2zHIcD6I5fOiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cwaPCYe1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="iPtzI3/O";
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8904606A321
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 05:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8904606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cwaPCYe1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iPtzI3/O
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB6597A0563
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 00:17:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 26 Nov 2026 00:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795670259; x=1795756659; bh=sBfH+TjKpJ
	J3RCcjBccXfNZYR+L9Z829yC/wwH/cqTI=; b=cwaPCYe13i+hzhQqlziGHuOOnm
	5QU1nVYwDbbieZruFYJR0WCbtfcP851WOa7N5yPvxy1BTcY5FR27uHFAxUuhbqDX
	lWCdlKjYC7jlTgAg+RbxVtRjwZhFz736JPXvpkt4uRE1MoyUrf6+orViJTFLMdhz
	WZKIyoLLvSm8M/GBOXXQvbrximxv4eGUaAubmCKZgZSZM56LeNgTTWDmMBQhFS/x
	m9VEuWq5miOmkRljeAiToU3zuoGycpX3qVaa42ehSsKN27Zg9WtkbvheQZljHYxC
	TuivhYK229yS8oYNacSfW4qbwhzvmuQTlTXr8KjnNBrtOiJBgdNAQEXp5X4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795670259; x=1795756659; bh=sBfH+TjKpJJ3RCcjBccXfNZYR+L9Z829yC/
	wwH/cqTI=; b=iPtzI3/ORdewo0zFoTEODvhIEJoskMz+Pq9BVBylhfRZYXoU/F9
	F4Jfnb2mRazAScaJpOWA2T8vEAyaJtguAz+Kf/Z+VWfQiow/0Wjc+RHcHwmMF6uO
	Ni7AMC+q4fAR3Ol4Ksa1AoT27Pw6tINlXZ8fxnIi60OaPdDf2IF4Nf0wL0Up1kjO
	EPwWGG+AafSdaRaxe4LIxG8onmfm0N0HPjOfzf9BMJDH76lMLRUV4PkaGQfgAKxZ
	0gGf0JlnuU26UUyhIq2SHCFLn8NAVIJerRQWEAe+O5KVfrnV+VChOY1hTGveCP2k
	vqtX3Yrovqzthqzm9ns3OeeE3whMCFEXpSw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795670259; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WrcSjqS/zLNb+LWMXVGI6QdFB01PEznTBiMLBI4O5kLKPzp
	CLo9BfB9hjfVh+0DPA9Waent+rHSaV2ODHEfyF9Ndy9hmPl9W0AbvlwoVWh8u8/r
	kDPWzpvVT63ZgMggvgx1EbMpTi4fCiyaqmNGexbv6zWa4ogxjr3oZHNamBEhhw5c
	XmI+PcYec89+JLhd79QV1HKOgIbuQ3RzP6m2MOeSp2WsS2uQMuk1TkTdQMgyJDjF
	mcY6mrnA635nizre4HsDR3yZo0p/PcVMoxGYFRjgsiHlTcPMtXVgEvUS4j5vhJh1
	bvfPVCGvxG93neOg4rGW8mc2LLvHKAIKHPWSX2w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:9MTPiqlFW+6r8M9gF9IsXzbinnRa0MmqFicXBtX0TOI=:k+UB/Ocbwtf8EaLGD5gQv11ZtHOrZpUrA3gPXf1TYC8=;
X-ME-Sender: <xms:88AHa5dMIp2ddVCcBhBBN811MWY8TSV7JGk9gBaEdQtHC7NjpGm1bQ>
    <xme:88AHa-MGzahjkNSTLuN_xc1Is4U9nGs-HZTB2Jzm4_nkVVDa3X_qPlRHDo25jdgEj
    k3EcLEKkWEIcvrCet2q1Vp82QBsm8joz-OsXhVuGoMIgetzHfSAeQk>
X-ME-Received: <xmr:88AHa3juqbS-N3ZwOngERKOiSmTurhUApnntK3kU27bnh22DDmnhtwyMVKhTGfBJoxIVoYgqtzOf_y6utfuzDa8n2VbbuC5TIVppO40>
X-ME-Proxy-Cause: dmFkZTGHTj2ylvXsvdvaIKjuBhjMH4sHjRjowj3k4sjcUFjAbc7+qiIwPgkuPuQv47YUMP
    a73l6DWRfMtmhGu4ej15ObpE3ATBfBBCwKm5YvkLOAxGVnZmorpAfQLLJnh7eGwTnPFA5c
    JOaLX2oy1V/kY5vXQR/dpmbgW7UZsTzFg3b3ucCgY+N4axr7ch78/uq3p0HHKgWaahS/ZA
    ayJQPI1vjVspkIigOg8NB7pFNAdlarhhZoS4ayrYPSKm+lhpel9f0nPONjBd719xkSHkiG
    ylMlyQ10A/+Y41wZOFZ+PWfUbSWi+KTV76hqLmun9u0VLBZs1oLirKcPTzv8SQnzBTjqJp
    i6XAtZ4s0djqknB0suTILUPx45OeqJvgmP/i5/G0lvRKQ5FI1tGwBODGWkvVllpeLdJBJ7
    7VdtXKPkjtoP4+Vb4gzVxUrq0CAaNaOeHl26M8f9AEEJiXiFPK9tfdpqrjuwyvABR40nLG
    IkK5CkUxlLFezNivmkw8eeOUcc1Fz+qmgjkoEXHGc0LzN62SFFGqAj/GlfSIZxkZGLMhbo
    JKgShhHlAdOjHPaLzZR4DOITAKFZnRUiIjXUKL3MHsnNa3mzxmclgUXT9PXfp/c0Bog00V
    Q/mXMo5zs0HW1Rkbpaw/GHUrehV9iyLoR/hUtArbMOl/OgbyyT5NyR80mhxw
X-ME-Proxy: <xmx:88AHax1nWlgpuf9ewSXYPcGr8Q451WmxBVPLguE6c6uq-l29y78jwA>
    <xmx:88AHaxgrH7me1hSQovhtrxNHA9qC0Q8ZnX5k1oqFUYE_MeqEcyQfSA>
    <xmx:88AHaxc3s6tGgJlgB8p59WRo_ROmO9B2ZFQT04BC6Nv-7RJVyP6meg>
    <xmx:88AHa0ky7GEhqfzCwUpVMURnBXxTbmulKeEiqpcRPce-kb_8wDXsYA>
    <xmx:88AHa7DaIuS7qprFO7-CsnAFf0S4_lXGsMR7jqQIQI46Vc5WMTFCNG2C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 00:17:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 2/3] remote: reject invalid branch names in set-branches
In-Reply-To: <5140655d23413ea5e739ecd4f413b931bddfd5f8.1795632934.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 25 Nov 2026
	18:55:33 +0000")
References: <pull.2429.git.git.1795632934.gitgitgadget@gmail.com>
	<5140655d23413ea5e739ecd4f413b931bddfd5f8.1795632934.git.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 21:17:38 -0800
Message-ID: <xmqqa4mwqih9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Giving "git remote set-branches" a name like @{u} wrote a fetch
> refspec that could never match anything. Worse, without --add the
> existing remote.<name>.fetch entries were thrown away first, so a
> single typo left the remote with a broken configuration and no
> indication of what went wrong.

The same "make an observation on the current state in the present tense"
applies here.

In fact, once an invalid refspec like '+refs/heads/@{u}:...' is written
to remote.<name>.fetch, even running 'git remote set-branches' again
cannot fix it, because remote_get() dies while parsing the existing
config.  Good catch.

> diff --git a/builtin/remote.c b/builtin/remote.c
> index 63d2db39fe..b04cbe70b6 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1786,6 +1787,9 @@ static int set_remote_branches(const char *remotename, const char **branches,
>  		exit(2);
>  	}
>  
> +	for (branch = branches; *branch; branch++)
> +		validate_tracked_branchname(*branch, remote->mirror);
> +

In the unshown call at the end of set_remote_branches(), add_branches()
passes the '.mirror' member to add_branch():

    static void add_branches(struct remote *remote, const char **branches,
                             const char *key)
    {
            const char *remotename = remote->name;
            int mirror = remote->mirror;
            ...
            for (; *branches; branches++)
                    add_branch(key, *branches, remotename, mirror, &refspec);

So passing remote->mirror to validate_tracked_branchname() matches the
refspec construction that follows, and checking every element of
branches before remove_all_fetch_refspecs() ensures neither replace mode
nor --add touches existing config on failure.

Looking good.
