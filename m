Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85058F5B
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 06:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497128; cv=none; b=raIJCRqVCHPrisrZ5erJ46Oz6rrDlmdra3wU9SD/KIh3Qf+hZ6REREhkh2MX25gkVh8ifG8cNot78KbEYfLtkcPA5BfYwt7UqYnCv7oULLMRiFLi9o+QyQJvXM5h68e8O8U76qQ4zpnACRiefN7l74DgrHy4reIYyB2lJ7X2wA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497128; c=relaxed/simple;
	bh=XIUrCE22C2ylfmLwUm8rtsFoJ4/MoY7+rWDarrBu4yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIEsBAyIN7YjfQFzkc7ZzivzCkykkPsNesOxHFZ0Kg+6D3/26hVCf9ZlOJ37UcJSCJAQ0eukDwHr4pmi8QzL6ONOPFsPjlGYWGm6JqiGYFNDj6zOxYqWqrxOszhXsWFLSzlm8q5ggYF9878R0EOEWupg7jWPI8YPr911uixUizI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C2UXrLoq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iIFMkVf1; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C2UXrLoq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iIFMkVf1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3341C1400226;
	Tue, 27 Jan 2026 01:58:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 Jan 2026 01:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769497126; x=1769583526; bh=q5RCBVAKFt
	1YjwpbhP3mTJuP2kNeQqWbSmCn91z4aB8=; b=C2UXrLoqlL5I42zv6M386SNxoD
	j5luWjDyAlCKat6i28StstOPZYZ+M+B5F7VPQ9XRKykkN3f9PxIp13INdOkw8N81
	id8nwBt+8Aeil3ZOE7Zt4C6we6BDa11v1CehATGvFSoMMBd5kD/r7UVbnmhnH1fs
	4t9GzRwZ7Gnor04vsCugZATR3z3M/ArOfuSDNhktMY4L3HL/FNvEGHD0fyxDu4GY
	GVU8HdCpws5aymohdQd0nx4F7ixZJW0NTDugvwLquNU69yoYZL44KMqkJbLCCdTM
	rKaBlx7+D8cL4oMRg7sv/QBTfsVPHYZbU/D6RR7nsVYit8UmVXRY5HsW1qyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769497126; x=1769583526; bh=q5RCBVAKFt1YjwpbhP3mTJuP2kNeQqWbSmC
	n91z4aB8=; b=iIFMkVf1CymtUerfljC5i5LkJySAEjxLBSaQXcNju4aI/PTSTET
	fL5PvbR/jFnzex7+KH7pl1zku3A8Qip+2XZIswMYwr+8uQhQK+1sRHZnupu+Xf6A
	fNpVPrJHhO5Ojs+zdMYfUzkqF06I/M38SwZhD1+nvHsaVISbcOg4oFyrzBYTUEsU
	irJKt+G/PDaFT/J1Kx6k8vbfDVCj94M4UWB8XfnH74ECND2XtLl78Mnmls1j4XCz
	tVJlUxg/v4uzcu3ov+RYkeIVyrYhbWEUq0Ps+86bpUb1hka5S3Fa6KJ6BdNmqB7+
	Csj0VUjKZMalYIBXCEeg1WFNxFg4DmwQEcg==
X-ME-Sender: <xms:JmJ4aZ0N6M53zZfGwwjPfwyiiK51G5YNpUnRfA-yZNqYgaqSnyn8fQ>
    <xme:JmJ4aW_A8WKuIrMYKZf_D3HvDuN1Cxs161KDyC_KMQngkUjAtZBtt4iH57jSSNLzr
    QwEhyJdbNlrsW7uzSyn3LggFPXLoOcA32pbPQS_FpjWNOXGKMXCkYQ>
X-ME-Received: <xmr:JmJ4aSM8OZ-1K3b6LQ8DgRmAFS9zaVnK8CkDkrjSSH4r78Twgcfx8VASX3bp2MzZP3zo2ZRV55izEHkccLeXvF14pdpORaxAG_EABRaClwSd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheelkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghvihhlrgdrjh
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    eplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:JmJ4aSc3S4eN6samuUtVMSHhbVll7C8ke905P8mPRwlyWgsMf7HGzw>
    <xmx:JmJ4aZVCnQ3QY9ZmRqYFy6DP-X4dTEfbqNJ0KaVggBTaUyYi0vZRxw>
    <xmx:JmJ4aSiRH7FQyzm_r1DYvq0V99ZhXE9D3jSMYk04r1SqkUjRne8EtA>
    <xmx:JmJ4aQ8G9J0czJ7L_yeJELz9q7ByoZQpe838tFnf77Mf8kBR16aejA>
    <xmx:JmJ4aRtwYH6BxELEuCThQDCt4JfbEaMIbsi2daRu-5fGmPvhiuARoiNa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 01:58:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 18b70258 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Jan 2026 06:58:44 +0000 (UTC)
Date: Tue, 27 Jan 2026 07:58:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com,
	avila.jn@gmail.com
Subject: Re: [PATCH v5 2/2] repo: add new flag --keys to git-repo-info
Message-ID: <aXhiIQXBvMhzkFy9@pks.im>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20260123164900.35092-1-lucasseikioshiro@gmail.com>
 <20260123164900.35092-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123164900.35092-3-lucasseikioshiro@gmail.com>

On Fri, Jan 23, 2026 at 01:34:54PM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 693e1bbced..f474274009 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -45,6 +46,16 @@ supported:
>  +
>  `-z` is an alias for `--format=nul`.
>  
> +`info --keys [--format=(lines|nul) | -z]`::
> +	List all the available keys, one per line. The output format can be chosen
> +	through the flag `--format`. The following formats are supported:
> ++
> +`lines`:::
> +	output the keys one per line. This is the default.
> +
> +`nul`:::
> +	similar to `lines`, but using a _NUL_ character after each value.

Shouldn' these sentences start with an upper-case character? I see that
we don't do it either for the existing docs, but it reads a bit weird to
me.

Patrick
