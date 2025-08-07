Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B9515624D
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 04:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754541496; cv=none; b=PP30PI5NV/mK+GRZJzbj3teLiLTXz6rW93WPEj9uPaEtEkgPvEVAxWs3HT6bAxqdRRY3QhKF6TCXwix+Mqg7DS7qho7eTHFDltePIk2lo2kq7ZVqNu2QNI85mFF2oWb7oxFt+f5UwKR03zjR2Il7khWcLTYK3/TPcMTKQ46cQW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754541496; c=relaxed/simple;
	bh=NJGx6QgzdW7fohHy0qmME90GVWi8ov3A/DMMFg8d4MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/FJGOY1jvZmvL/TBwl5G7OFMy+8Dy5KtWPPO1hLYmWgvwEGtmvd8n8JB+HDiLE7YJLTwKljFn5F2W6uxqPhCt+dkBEfdlTgrqTULHtWyk49jzfLSvp/XLsOgB5BLeivaT1PX+VjjqJBo9SqzeFjKMthWZRdjhWdSPK9fNh3LXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lwlPq7zq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ae4+XatQ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lwlPq7zq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ae4+XatQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 807F61400120;
	Thu,  7 Aug 2025 00:38:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 07 Aug 2025 00:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754541492; x=1754627892; bh=HfRFnFWcK8
	SrE9qwkCQDJVnzoECJ4N1CS936z2tXnxU=; b=lwlPq7zq7FUIsgM8A0fkSDM2VG
	BfpOnz83lgLbPbXNn/p9K29wxIfVWwbjjljK/324XORFrv/pwfgdOFx8d1986Jp1
	WSqyZpwfibGYOQJxykNKEYeLT8HBgVZ5A8Wsmf1mSkG2hqdUNT+0DnSkkAtXv11C
	3Q8H60DGz9wZYssUOpTD+uaLofEdtSMInImkGPrJ7rXUxDZKUIX+NmwmoRmk53/r
	qfoMhuqXG3H5WcqfYhqq2f4Zc9U+QiGsdhQ8dBfpBAOkw1fGhdQbbNvHXH1DrAAg
	gNU5dKXavJSjWvdEBG86cQI46kZkp9VEo3SKKMkYxURZ+W4cyKjHBnsLXf6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754541492; x=1754627892; bh=HfRFnFWcK8SrE9qwkCQDJVnzoECJ4N1CS93
	6z2tXnxU=; b=Ae4+XatQdR0YsgfjCtKtWZBjeoLFBIqlil+zeAq8BQVZXEU5Hkz
	sY3PHQNgeJyg80eOE4HuvaLGQ3BYc4bp89nMqljjFERWYU89wTLVrywpZ9sUy43l
	QdG8v7/oX6aWFYwXNPuubdbf4EovQWUzD34w9ZzGF3CKzqzweFhHiTHno4PG896Q
	EoVuhoWKeFV7wIHXKNdskAZuKSOuFSKElBp4b0oLgQH/J8Pn/Bpp4eJQMO3i6SPh
	S60lAN4P0mJQaAZm0mmXyHSyIl8RZATUqoYpJrljzE6y1EOZzCbqTIHTNZWKFnE7
	Yfrdncj3U2TQFSkkB65qvBgtUbrAWgWnYQA==
X-ME-Sender: <xms:sy2UaA7b16WbBPBkSu-dd81Y7PM28kDRot_AMvBJhB3NgCRY2ZPnkg>
    <xme:sy2UaFLhHNXIXnQAmJd8KrcWkAeZNQ6rFOeLjmu2iHQL7-rb_VhGR9Nav-Cru-xW3
    7WNeqq9to0DYJb_kw>
X-ME-Received: <xmr:sy2UaI4fHmxo7mz0OSvTxosrbfcj_j6Y0suhBusYQ0Equ_pwrEelCCu98c08mCKw4ZqT6we-VVnwJikZ9BpQxV-jVydYJvTFMI98BGqhIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudelleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtoheplhhiuhdruggvnhhtohhnsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:tC2UaAx_dr42ouU5FsT-pWl2_4zF5_Aojm9Z-R6jWNlvvRYTpeU8gA>
    <xmx:tC2UaEZhOiBD3tT_SpbcYPKS2xoUB7hyG6Q9oOUIyA-xNoaLeG8t1Q>
    <xmx:tC2UaKRYm_qAaslHn3JuLH0GoayKh4QkrntLrH1tY1cceamvC2__Mw>
    <xmx:tC2UaGzWJphlyskFIr3Aaf65RtO9CBrZKMqINNU52uEi20UjJUuEZQ>
    <xmx:tC2UaFxwp33qADPPnwu3BF2RgzPeL3KB65OozQbvJh1PZ-X0guPC1a2A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 00:38:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1ac91c7f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 04:38:09 +0000 (UTC)
Date: Thu, 7 Aug 2025 06:38:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Denton Liu <liu.denton@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote.c: convert if-else tower to switch
Message-ID: <aJQtrgZ1fldaIy4E@pks.im>
References: <xmqqv7n0wkbv.fsf@gitster.g>
 <5866818859be97c091c40602974629eb7e463623.1754540903.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5866818859be97c091c40602974629eb7e463623.1754540903.git.liu.denton@gmail.com>

On Wed, Aug 06, 2025 at 09:30:20PM -0700, Denton Liu wrote:
> For better readability, convert the if-else tower into a switch
> statement.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> Thanks for the suggestion, both. Please queue this patch wherever it
> makes the most sense to do so (either with the existing series or on its
> own separate branch).
> 
>  remote.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/remote.c b/remote.c
> index 465e0ea0eb..c7ae18fcfa 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1197,29 +1197,35 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
>  		    "match_explicit_lhs() should catch this!",
>  		    matched_src_name);
>  	type = odb_read_object_info(the_repository->objects, &oid, NULL);

Nit: we can also drop the `type` variable, we don't need it for anything
but the value of the switch as far as I can see.

Thanks!

Patrick
