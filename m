Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED415C8EB
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770819795; cv=none; b=gB/rl6esgYTsIpfGbmrWuMphGXup5bfTh6SPWS1iPI0P5polX0YG9oxIcYdtQ0KEdyzb5zuLfJpKX3UUNQLi9pBqcjtDpFm4jyewFNw5fIsfgwYd3aIvrCP/ssTqwplIqGXruF4GNTLuDRMTGgDxqYneY2IFysewWBwG/oDdYlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770819795; c=relaxed/simple;
	bh=wb/fqdk+i46zmx6tjh4fXB9F4uYhxURAFxDRTYCjLfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrPaBsgCjNygjQtvrjAjxA6fVAm9U4T39DdACuCgZQXP91uguGHq2HGMp85KV28CSv6c9leAUc5kQK5gmGba/Om45umwHhQEoYAFug1UCI4LYYvV4NNvM81Zl4tLWkZGrS2uw2DZpKS5QmFYgNEJwSUw5iaHyI9B0qd9Pj4Txlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=re7QniZY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GIVCFu3r; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="re7QniZY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GIVCFu3r"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1530C1D00151;
	Wed, 11 Feb 2026 09:23:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Feb 2026 09:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770819792; x=1770906192; bh=Z42p+P0zie
	mklhmFyoSp3wbwxitYt04nX6JrxNJPrOE=; b=re7QniZYrutLczxZPx3Or0oYH7
	eZZ7X9hAHb5O6wVpJM1Kj+rKaXuitj5RHUCJBLI8szgHXl+T7pCCMaWJqEra/Ba1
	5Hak/Y4OMrzhUZbBS5OCGIYtQMjNRUV7Tc2NXekIhPqOyE8LlXmgNfUgYqPoVu7u
	Mnd8rH5aUrAmW2EpPK8PlbvV1MyK3/muK3AMwHCTl0R+nCC2+W4OTnvAL2EhJbl+
	vcmhWtWpq5m7pyRqNY/sEbF+vxYgeYo+EN/AAT1vrFnE8O23Ld0KozpxoiS3c58F
	x6QCNrkOckp9VtG6Dd/ERuWCv2sVkSvs5kke9PONwQ28Zpe0lCZlq2IGpK3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770819792; x=1770906192; bh=Z42p+P0ziemklhmFyoSp3wbwxitYt04nX6J
	rxNJPrOE=; b=GIVCFu3rSFb77X/Y7n5IRswJ02Erw6ODfNZTl6HO9eQcFVKR3R5
	dgcLwZVzksOL/XtNNy9d+SPB3LsNiGQ2WzXl8YUJgoVnWIZ8ndQg1NM6fLBCcdaH
	5hBxCFwB0KS8Cx3GsVmMPShLhS3Th/1yM1EUfglxiWiokF20aEKsvfg9odjAaA6b
	LbSgifYWjOx8Hf0psf7/ViGRmRNkWvqvIad6DcrjEF1T+59UMsfcLch1/UgmlS0L
	FjYoqsdJlcTCGp6CJlRX9mMgdE/HbZTW692/fWMWpcndsp4teS7qWLMCxq/BnB23
	CtpgPHLZKlxgSOIygNdTgdcBkV6d5u3Ko4g==
X-ME-Sender: <xms:0JCMab27rH9mgQkZeUbxGrn-Ku_Ul6qv4dY4irNuyxirqtrqe-PDMA>
    <xme:0JCMaRF-oujapk__WpnJLGd5UGClI7a0Okn0L7cO_Okvh2C8WLAbnH_LuXF_l-dnH
    g1F7qFrRlqrgxaTVhVZVoryaZUsTNWYL-WiV-7itMIR7pRqahvjjQ>
X-ME-Received: <xmr:0JCMaQ4BCW7TIefo7BuaJ6A1w6-80tMmt6fSvINwXtfKNpgCkiEeU8FYiRKgE1x7phi6YqdrB73w3_aaAsx6H3pZyHlRJQCiZ2Sd92fuF8_C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0JCMafsU0Oa14vJH8hcPgIoRnXBZqrz3A36FbeUJlH9rLZ1pyM1YDw>
    <xmx:0JCMaZ6mF-iZeawx7X3kyZQDyurOgO7vY2Om0zsnWq1_urjFu799Ag>
    <xmx:0JCMaSUzAv5ZkE0dgVhTZ2uJgsmsz-m2u0iMwKMMlhl54FWxMoxYkw>
    <xmx:0JCMaT8Y6uQe9Oda9bYzriQE-6sdeyxRnlwqIsXxAvFr_p7FtBKSyQ>
    <xmx:0JCMae5fKkC1qTmRrsJRqcR1cot6XaSRrgDLRbbM1MLPTqLof7GoYrDm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 09:23:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 17371af6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 14:23:10 +0000 (UTC)
Date: Wed, 11 Feb 2026 15:23:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: ps/object-info-bits-cleanup (was: What's cooking in git.git (Feb
 2026, #04))
Message-ID: <aYyQx8Yvx1n4W5L5@pks.im>
References: <xmqq5x84xms1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5x84xms1.fsf@gitster.g>

On Tue, Feb 10, 2026 at 02:21:34PM -0800, Junio C Hamano wrote:
> * ps/object-info-bits-cleanup (2026-01-26) 3 commits
>  - odb: drop gaps in object info flag values
>  - builtin/fsck: fix flags passed to `odb_has_object()`
>  - builtin/backfill: fix flags passed to `odb_has_object()`
> 
>  A couple of bugs in use of flag bits around odb API has been
>  corrected, and the flag bits reordered.
> 
>  Comments?
>  source: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>

The discussion on this series has wound down by now, but I'm not sure
whether anything actionable came out of it. The biggest question was
around whether or not to use an enum as parameter or an unsigned
integer, but there wasn't really a clear conclusion.

Should I reroll this series to convert it to an enum, or should I keep
this as-is and then we can merge this series down?

Thanks!

Patrick
