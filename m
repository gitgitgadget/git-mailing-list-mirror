Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08F73DD52D
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343300; cv=none; b=CWucMdpO4+nr8xDUWYNQC0C+vIABITQxZRrRgi2ToowOM2TDBiqMXCk9Ckz36mVBWWUObC7uXwCVSvHP/+e73ZhzHb97G5JAVo6eblq8HW9gLt0oDmzGf99D6/2sXq7PmUXVk3b0WkMyyz7toh90P7zRl/sVWte8QYgCeEak7mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343300; c=relaxed/simple;
	bh=LfkPGe7fV8PgbOfq4/4B17tRsYbMGYkewmxiTu3XQnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdYfSZJn/sy0HaNDvzya3IKHbMF7isAB2dkN8PNOHhnyVTTAkXLbT+u9MXeYcAONwN3+wmOglQlMrLNIQ39kbTud0JvRKDDBMKdr+nwkOsjPy0t3rI88RwxhOBJpbzubH7WyNts66ko+HztJrgfGQJUgvhmSdYPwFI3T+bPM6XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CA43RqRK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mk3Gdc+X; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CA43RqRK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mk3Gdc+X"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2612E1400262;
	Tue, 24 Mar 2026 05:08:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 24 Mar 2026 05:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774343298; x=1774429698; bh=4QrBqJuude
	UfyerANSdqN0FBxzTLkwjWFNAX9jRfo3c=; b=CA43RqRKCzeOBCDqMkY40hdU89
	ZcBS1MhvjGycbrhbPWpnGLV+qhSg78m3j0eKtPzRiJJ/aQRR+TzUXTGu9ckC35/3
	4BSjAIFdhTijIGkZxeFHS30PHtYsLngENQVpAqXBf9IbYl6KBA/l1IxIWSs592cY
	iCCGYPUOx32jGsl3HqksYnXSwlY4WJos1eL88/ihW7TPksXbIwAgm8zCThMevAj6
	lObfX5WbC1J9IJjrhkV3C5sRcHkwWUAEyN3M3NfnKb19lCqKKtowmrVYpTPTYPha
	WXq/bWlBCKDylbLu4vQl3R5L549JaC1ewt5EVkzQVu1/i8mgA3N/FTxQaKQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774343298; x=1774429698; bh=4QrBqJuudeUfyerANSdqN0FBxzTLkwjWFNA
	X9jRfo3c=; b=mk3Gdc+XCpihM6O3LJeURLBXq8+I0KkpfO5EtILjIwfkOSqK+uz
	/cjSa9IGJ+WqObHUVZmfxEhqr0ximrwwyFV88vlmYuU8pJ1WHpXE7M24UVOA4B2L
	5K5GbRW6T/WhPLc0mieWJSYLXqNfK3x8BSLxpKNt3DJQGQadfqsLrtBq6oV847xq
	29kCUdauP7RUGu9wddADYGsmPAXszX8VfdQ6/pmZcHn/2bi4D3GHwBVlkKMpaDCa
	5XlkkVmWOgIwUJyI7kPKbsLXPTHSPb+LaKIJryCQ1QohC4Oneqfa6nxKaLYv9gdE
	o87ErSyXVYA/Nb9mGRas0IZeNHWD43herdg==
X-ME-Sender: <xms:gVTCadHhP7Yn8X1AOQtH1zuZJc5DgdMpIh0zttywb-Q_wgdXXVtY6g>
    <xme:gVTCaRbnKfciV4_XXtENjyIQHFDAVfKvFFE9Xr1y6AIWff7p8-tnxGYbSBrPFKYKT
    tNVgvpZYKMygqOaXuBcTQkiCspqMRn9LHMUgpJGj2zJ9uWnYEQ6>
X-ME-Received: <xmr:gVTCaVXmSZLYilliAfvd9a17NcIDS_fcYcyMqoTbl9LYRNaXb4km0fQrIo4ejNedET_R5M8mbUuxQvVORuDMuuGe-qlOlqmUjJ1epHiIUshsow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gVTCafmNrC-9UNZSyIBloXrgCgPjoDJgYo_vevvye6mQ2zplhavJCA>
    <xmx:gVTCaYC30EtCtWIx5I56DKnDibO9TcaOpwbdjypkJuFuYvkIoimQlA>
    <xmx:gVTCaWgfc9dpvzUIv8utf3pY5gIgTb4Jf--HmRepmgQaR10gTauMHg>
    <xmx:gVTCadwf39AliyasRkubHrnElB3UkBJcCGQxrHNtQMrswZp9LEDoQw>
    <xmx:glTCaZaVSwbpzBuPoroax4VVomZtSPYumUs1VQ87KMbVP1RU79ISyEpC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 05:08:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b918a0c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 09:08:16 +0000 (UTC)
Date: Tue, 24 Mar 2026 10:08:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 9/9] hook: add hook.<event>.enabled switch
Message-ID: <acJUfVjby_QyZvj1@pks.im>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-10-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320135311.331463-10-adrian.ratiu@collabora.com>

On Fri, Mar 20, 2026 at 03:53:11PM +0200, Adrian Ratiu wrote:
> Add a hook.<event>.enabled config key that disables all hooks for
> a given event, when set to false, acting as a high-level switch
> above the existing per-hook hook.<friendly-name>.enabled.
> 
> Event-disabled hooks are shown in "git hook list" with an
> "event-disabled" tab-separated prefix before the name:
> 
> $ git hook list test-hook
> event-disabled  hook-1
> event-disabled  hook-2
> 
> With --show-scope:
> 
> $ git hook list --show-scope test-hook
> local   event-disabled  hook-1
> 
> When a hook is both per-hook disabled and event-disabled, only
> "event-disabled" is shown: the event-level switch is the more
> relevant piece of information, and the per-hook "disabled" status
> will surface once the event is re-enabled.
> 
> Reuses is_friendly_name() from the previous commit to distinguish
> event names from friendly-names when processing .enabled settings.

I think having this makes sense in general. But what about the case
where I have configured a hook where the friendly name matches the event
name? Is that now forbidden, or would such a hook silently also disable
all the other hooks?

> diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
> index d4fa29d936..0a9f04b154 100644
> --- a/Documentation/config/hook.adoc
> +++ b/Documentation/config/hook.adoc
> @@ -33,6 +33,18 @@ hook.<friendly-name>.parallel::
>  	found in the hooks directory do not need to, and run in parallel when
>  	the effective job count is greater than 1. See linkgit:git-hook[1].
>  
> +hook.<event>.enabled::
> +	Switch to enable or disable all hooks for the `<event>` hook event.
> +	When set to `false`, no hooks fire for that event, regardless of any
> +	per-hook `hook.<friendly-name>.enabled` settings. Defaults to `true`.
> +	See linkgit:git-hook[1].
> ++
> +Note on naming: `<event>` must be the event name (e.g. `pre-commit`),
> +not a hook friendly-name. A name that also carries `.command`, `.event`,
> +or `.parallel` is treated as a friendly-name and its `.enabled` value
> +applies only to that individual hook. See `hook.<friendly-name>.enabled`
> +above.

Ah, okay, so you've thought about that already. I wonder whether this
behaviour is okay in general or whether it is going to be confusing. An
alternative would be to disallow configuring hooks where the event name
matches the friendly name, which would fix the ambiguity that we now
have.

Patrick
