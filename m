Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595E937C113
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914088; cv=none; b=JDT4rm5XTH3+KVOfPolBQvnR+PXo10fe1Ec08DBPBd4LZ2ogHqv5GvSt3C63UThfK5pWTXlW67jpjTPxU1TmgESC8kumQfjjGiwYkclPMFlClF7/rOVziKR6xF1laQyimZk9ky6dlcBy0fbLxOwRoiuNvc2FZ7eZA5z4vPUIb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914088; c=relaxed/simple;
	bh=MMgkN6g5R4c7OLqq1rfbgXYtbuJoXl3vdrfENGl6JOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5aMQ8/XDjdc3T3a1lEL2Nxu74jrdynCrO3770MKXWwgCUTBpoA7lPbCDrBrcXbJK+X7i1sToywVVaxLFRXKIIQ4Nltmfmsge70ZK7RRLvCwmBMLukRgrSVOBv61W4MTsdclMdGRxVLepXvytbiKgGS+JHxVNKi16j0xeYEsi5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XHvceF4D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0PJojG0p; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XHvceF4D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0PJojG0p"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 168C9EC0170;
	Thu, 19 Mar 2026 05:54:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Mar 2026 05:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773914085; x=1774000485; bh=DGFRgvPhWb
	Kf27LvP3/kVYJLu4mKK9WBuKtKOthTx0Q=; b=XHvceF4D3+s0696pS0BO8lvX0o
	KnvCdRuo9Q+KFloRosb8gAhpftkjGrgjZUhT23iF9Zw7JzL0zeEQUZ8ABEhtlYzk
	wrqO2Ziquh/lZSlVWw8LFHiY6dKXnZGRZJk23QknonaOR/V4HhqFFJHE8jBP4Kgt
	N++sfmfTehF70qpNpDrO8Kw4swLvonYEABjhVyDD6WdhLntiUe/BD1gcSngkcp03
	/f601peivBLRjHmY4+VWmz+qwC5S7q352fYdtHid6exlEGP44bdu6GbT9jkaNOir
	IKVEglf1FPj6IOj4p+Xa/K3OmQWA/toBB7jQOQg4DQe/WyF0qUlY7wDBVezQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773914085; x=1774000485; bh=DGFRgvPhWbKf27LvP3/kVYJLu4mKK9WBuKt
	KOthTx0Q=; b=0PJojG0peckcn9am6AvyFaEsR5dMcIes4LbX5ryjdPVw5OEs5rS
	8wkxHlwhVqIKlr2+GMxjZz74Jng4DgQb32bc8IARy4BK2s1zgXVwchjX5c4xWdT2
	U683yhquOG/0qSaMTFBwaGth7ShOnI9d/nRTbAuBPH2w3KjtbA57u8GVuUqYnHIn
	4XFsaNjWXdOlvPO/b/ajtcgSMxx6CkXtgghjsNKb3o3X7f/wXjOL/Z67eun42s77
	SAMN2u1ythlCw3er0WoeWyY0kohDtlJsp/2Qr1J9jv+deW40l+Bc4YFkk/rfdXwU
	9C6U37LbYN4FqqWeHtGWNmZsWR222Mld1TQ==
X-ME-Sender: <xms:5Me7afDCLnHPi_7EA-ZBZqwunEgZxjhB8Ei_X-sNHg6FeBkFMooY2Q>
    <xme:5Me7achge2zCDtatFtngV5CPX1mmT93bt1QRyvmAH72xWOf531nzdzC_aYq2VCs_i
    IBmdHlXq1g7xDCUu6c9npLwYIO7ulKb-IVgZh48gBbu5Bg0Pb8WObg>
X-ME-Received: <xmr:5Me7afnyxR89xPVifD2ycMkUSlA5SugG2Jg3O_PJ74hx_gTfYFJSFdThjuMfb5oKaVFnhxkDPhh8I1o2KlsJ4uVzcnRFhObxi2LIaOVdU131>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeijedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5Me7aQo4QCRQDmxURH9cjG36Gnlui21fkMvqPYy9otBQsrFvB0SlFw>
    <xmx:5Me7aQEOKiQL8M5Jfst6GXCDF4aUj2GKXhKv-k8gJOlK4Hj6nN8vDA>
    <xmx:5Me7aUwq_0P6XhJAmXq2oWYMgqvd5N3NvmxRxdUOizw4VQ9rDR6fmA>
    <xmx:5Me7adpdoKFnWKas75ZmTqQyCq7AYxzzKOBX2fZy2pTaJ_TRU_tByw>
    <xmx:5ce7aXEqoJHLHw8KaGC3QtFdYjgsmODAVgDNSjwGG_pd-zg6tnTe3LwJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 05:54:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0ef70372 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 09:54:42 +0000 (UTC)
Date: Thu, 19 Mar 2026 10:54:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/5] backfill: accept revision arguments
Message-ID: <abvH29wYAFzk6V0F@pks.im>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2070.git.1773707361.gitgitgadget@gmail.com>

On Tue, Mar 17, 2026 at 12:29:16AM +0000, Derrick Stolee via GitGitGadget wrote:
> The git backfill command assists in downloading missing blobs for blobless
> partial clones. However, its current version lacks some valuable
> functionality. It currently:
> 
>  1. Only walks commits reachable from HEAD.
>  2. It walks all reachable commits to the full history.
>  3. It can focus on the current sparse-checkout definition, but otherwise it
>     doesn't focus on a given pathspec.
> 
> All of these are being updated by this patch series, which allows rev-list
> options to impact the path-walk. These include:
> 
>  1. Specifying a given refspec, including --all.
>  2. Modifying the commit walk, including --first-parent, commit ranges, or
>     recency using --since.
>  3. Modifying the set of paths to download using pathspecs.
> 
> One particularly valuable situation here is that now a user can run git
> backfill -- <path> to download all versions of a specific file or a specific
> directory, accelerating history queries within that path without downloading
> more than necessary. This can accelerate git blame or git log -L for these
> paths, where normally those commands download missing blobs one-by-one
> during its diff algorithms.

Nice.

I think especially blaming is a bit of a sore spot -- downloading blobs
one by one simply doesn't cut it there. I wonder whether we can easily
use the backfill mechanism to fetch blobs automatically in git-blame(1)
so that the user doesn't need to know about git-backfill(1) at all?

Patrick
