Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106296;
	b=rRrEHFv/14Ol7lNaymmXs+hYtxh2MbbH4DX33N1WdHLMELLYKiCZUyF9OnyIyKIwLr6n
	 u+iFad1MJyqLoCsWwctyr3IT7OI0ew6mfZDIcp2W6lpjSDVNZxmKXhAoHf/qJGCNTfdik
	 GRbUoK/at9WPTbSNpVuG4QlOQjaYdtGGOVxoNBC/mW8nNhJ4Xgh9AKeDGY3MrAeeSnNY3
	 IeHbwymIMIgQn8oLre1lx5f+3Gtkr9VReoqvnY3o5W34/g3zuX74K0iV5U/ALNPafnfwf
	 lCbZ8OnodnQPZnzQ/Hc5/rrXrxACyS2yPJY4xYDQz/5DAzAeU2erGKsmmcNBiB1ldiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106296;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Rt7nHHIV85ufBCsQGjDmEVmcDretztNyuDDuXuYtOME=;
	b=zrnRyHGA/kd9kWzVs4xRtjgiJKjAKcf7Sl9fw1O+d3miRutDm/vIfp/sD1oIWoa+Ejnc
	 s20I7yFWAqEPSrxdxPL/LTCmHz4DooPLWrbTFi444khk9fu89peX/vuG0pmxtGA0O27Fo
	 l92IiuZ2HyTI2UozkK4aPBUDsgnVhYRaD40ETBrfOH1NfEn/+chnANE10zgV4G+Qxam06
	 pXetPhHxq+B76s26UvvuigqOYL9EFCAS9IJc8w5/E/yJl5IovZxwD6laRX/PHAvTdR+8r
	 VMRSEkNu675/gQWZ+nTwn06haVoHmTislG6RPoSqNjo2AsRC2zPOFsJrq8yvyWzy2bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=JuDBeXoo;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="dpc/SI6g";
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE83606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 16:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE83606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=JuDBeXoo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dpc/SI6g
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B5187A02F2
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:38:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 19 Nov 2026 11:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795106295; x=1795192695; bh=Rt7nHHIV85
	ufBCsQGjDmEVmcDretztNyuDDuXuYtOME=; b=JuDBeXoo+EG6E2r3v7UAv+gAMh
	XdrbykTrKWo2sLJtseAmMtvSGZ7mXfbrSxgsjCiJ3GueNcihN7GNWt88qosi86QI
	755C2peGpce/RmIFxvcY1+i5F/omAgqD9Acj01qz18pihHzzr5eU42UeYVNKHmJV
	G2Mw6soWtDvGqnFW6e3rKr9A9zJ9ppe1lI9qh5gYPizdQ4sq3O1toyE0SxyI/tyX
	tO8qj9aEYbw3+AHUEjHe/fcQB8u8CC7zvGCNyduihj+zgB7rjVRIqh/YLEBONHtQ
	DnPTaxdG5vODABsFTUQM5VI9jHfNBvTavBWvnCDfp/GGgem2J7spUARVM8vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795106295; x=1795192695; bh=Rt7nHHIV85ufBCsQGjDmEVmcDretztNyuDD
	uXuYtOME=; b=dpc/SI6grxEH/hINcQWhGLkcUMrCmXGkV4rSVNZYV3RzgyWEjVl
	8hUto81cjHBJgpNkP5WjXQZCJjpRIn8UaUxFjORcCzPpiesmKlS2rnHI5rLf/SG4
	7lUt+S8EJ51Dpqf3ISUVBagzSZ04Kn6H5T7uvdvNbxyZyHv3JPsDxcIhu0c8YGHj
	/gF9GwAzY49wShQTaVkR64LOLB4GFs1UP+gGlC9UCRlQNr9f2LGy92QDmpATz3GO
	Fl7Z6PRkUdsaDKzgxuGD0iCLGrv9N3jJ9vupTEXeEhtQgPMW4qdujgB4wOU/LBEi
	3zq/TNQBPzzz4qvB5fCuFq6TrDooHYnnoUg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795106295; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:U87WWt30Rqqgn6R4tn1Dx5MrHVVav7aHECcCGT3rEpZFnAK
	74fn8raoVAeaGgDTyf/nZp50vbzjjvwHZZkUGbGiny03bND2bdmF84cfciNeETQa
	5tCsJ6upoFuhKryWuQOvQodcyeSFrJuY02eTCVzH+zG0jfUrMWLY3Ky8j+Lf4Ch/
	r5XWKZNaahgAFLlHEl6sa/NlRMFC2IvbrJTcJsLwdzvsjQvz56H/JjQdfz20uTTi
	P8v5p/MqLt45yj2x+iGSRUMtWtOEjuVURVeRGMclLGvEFkWtS/21BH0575p+z8wZ
	1aIuIEolG9o/l8IErTi7BU1xVjFwYgfjfzJZqAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:taB5zGJ70i+RI+Ayrcb5kaztuATlX+VJTeXeO8k9Puc=:kx9pHOWI0v2cWZX6/7/mGJiGvflX1mXi/eGSywdpMxQ=;
X-ME-Sender: <xms:9yX_anDMSWBol2Mn3GznxtXgj6N25aOFsMA8UEubXMK3h117M9MLKA>
    <xme:9yX_akaShf98taqaVOCRAIXzCiunJqwVQ8qLW1BCV-Qw9UWfsBwQDlcGJeLXIE8bM
    lai4dGQMswTbtnG9b-eEuwoHyGyx4c8LaNrRp1Z-cqCSRVjm11yuMk>
X-ME-Received: <xmr:9yX_aq6-5PzvVelM0m2oV6ow-EDKaJPh_zyQzzjh8tLH5zvQbv0B4-8h1qhYLseJ527Gizy16t4I3vzLte670Al7PXyN_XkKJhkk>
X-ME-Proxy-Cause: dmFkZTEzI4GJtRtPqTaz0KDa/xZpm8OVYhJiwurIGJrbhEFkFDdxjNORPbuV7UGHMtD73r
    L+DzFHQq2nf4MnXyn5R52JAVKDKiW9RKERVX9lkmdaQX4cL51HCpBXjQsp2iRrsCY7t47W
    yuujVU5lzko3XaYnI8jD8giJ3E0F2+NFL5LYxxXOyzHQBilFrO5BterDg80ygUe2g46AqF
    4v0oon9GEIVWqNlOsOCYvhQWmdwEdfdOe3LmB+JRRijZJbBGurEY1inHvL2PzrAa57ozkb
    MCF3OT7kBccPVdnAy8C0qcxUPIT1Vy94S8R2VCYXAmiep4gYvMH7r+swCrrswUjIkZlTH8
    bnB9ItfpnXJ35y8PgiZ7d4LZnrSmuLkWgE8xRyf2m7w1cJd4WTlKZhLJCRI/AiGJM/fMFa
    YnGCGU0PWOYY3WdIMcj/ogW9MurlNfX+0jiCJbY09SUcPx7aPJEohrS/Zd/BXZY1clUdO/
    JutkvoPPxx9RT9aT5xpgSX/B93KwMXocvpg5QvXwDsitVAfuJpLxfw42Wvpf5k2jPaQtwX
    80WeLNvysGrvStZDkim/VzhqwjOl0CZYHd/5wgv+FZtarhg0t5FyAoFHBguAMrT1DP+fpo
    GQ/K1TCxA3twfCIStrcGTQR0Ynkw8tMZKkO/xWxbl0zqjjYtyrxJBFN2VamQ
X-ME-Proxy: <xmx:9yX_alauvmKyVo_0mO1oiB055U9QxasUT70ZOk09nqfFAt37wL4wTA>
    <xmx:9yX_apg7L9zN0YvDy6gMlMEl0NJKtLc4tJZA1AU2BIhyLtUntV34ZA>
    <xmx:9yX_am9Jw_MGuIcNTd113ROzqGjRD84-qWJLA0RUNJZeNdni_YKvEw>
    <xmx:9yX_akpGrYhU668Yoo8WuuitWOH2BItZ_EHF1yAntkOvlktYsWYtyw>
    <xmx:9yX_aroerbflRikMBzmBdEU6H1ubh5doOIKntkZUCw8xetzvMBgWimTm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 11:38:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Adam Dinwoodie
 <adam@dinwoodie.org>
Subject: Re: [PATCH v3] setup: fix hash algorithm detection
In-Reply-To: <20261119010612.687733-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 19 Nov 2026 01:06:12 +0000")
References: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
	<20261119010612.687733-1-sandals@crustytoothpaste.net>
Date: Thu, 19 Nov 2026 08:38:13 -0800
Message-ID: <xmqqmrr4zsi2.fsf@gitster.g>
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

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Our current hash algorithm selection code has a few different problems.
> First, we do not actually default to GIT_HASH_DEFAULT.  Second, if we
> have an algorithm chosen by init.defaultObjectFormat and we re-init a
> repository, we will change the hash algorithm, which is very much not
> desired.

Can we end the "first" sentence with a reason?  We do not actually
default to GIT_HASH_DEFAULT because we initialize a variable to
SHA1_LEGACY and we do not consider it as "nowhere the user specifies
which algorithm they want", or something?

> Let's restructure this code slightly.  First, if an algorithm was
> selected on the command line, assume that's what the user wanted.
> Otherwise, the other options should only be chosen if our repository
> doesn't exist (that is, repo_fmt->version is -1) or it's specifically
> detected as having no hash algorithm.  In that case, first use the
> environment, then the config, and finally, the default algorithm.

In the current code, does "it's specifically having no hash
algorithm" ever happen?  Or is it our wish in near future to have
such a state to allow "the first use determines the hash algorithm
used" mode?

> Then, if the algorithm does not match the repository, complain loudly
> and refuse to reinitialize the repository with a different hash
> algorithm.
>
> With this change, we will choose SHA-256 in breaking changes mode and in
> Git 3.0, which is what we want.  Add several tests to cover this case
> and several others discovered along the way.  Remove the now-inaccurate
> comment.

Is the comment "now inaccurate"?  

> -	/*
> -	 * If we already have an initialized repo, don't allow the user to
> -	 * specify a different algorithm, as that could cause corruption.
> -	 * Otherwise, if the user has specified one on the command line, use it.
> -	 */

I think the first two lines is still relevant and serves as a
caution to whoever will be mucking with this function in the future.
The last sentence is not quite right in that following the user's
wish is not limited to the command line instruction (if they tell us
via an environment variable, we would honor it).

Oh, it just occured to me while I was writing the above
parenthesized comment.  If I have ~/.gitconfig that was modified via
"git config set --global init.defaultObjectFormat sha256", would
that count as "the user has specified"?

Thanks.
