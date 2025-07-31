Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B84D1C7013
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947949; cv=none; b=iP/7uhubRgu6LzX6e+qRvoea1sXCE5RmJrJL6lDCuxB3m4vQB3WLxPK948Xaw0nuS3X1hfrlXVmtWAI9rGZ/sjlMyHpn9N5SF+el1cfFOs/gu6JcpSKVjtwGZg+sCavijPYto+ycs9PKxTvsRD6n42NLO7HyxNgVjC0ACdJLHQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947949; c=relaxed/simple;
	bh=+ZGMR/Y/qHGpbXEnPbz2gjzk+B1GaNnVXeIMgCDj/+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpsS2zinI74Jir6PIHKOSn4ky42VuiL9SzbU7rQg+8JIiMEmsG2fejrMCIX7CPXbRF19Xqgl29odzThT55o1tPcg5mvZEw9YE4h1zR5VqxcLfMBwv9oAC8E/HgiLL2ArB8uHCNKXSIUvkmM9A/2OpM7ZpXDqJGbzY1V+60qyKR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UcTNTx/y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ur3+gMZV; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UcTNTx/y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ur3+gMZV"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 566BE7A1373;
	Thu, 31 Jul 2025 03:45:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 31 Jul 2025 03:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753947946; x=1754034346; bh=y4IeoukLRh
	ek617qQczL+NIojyI8CNKAZAnJgKLcKx4=; b=UcTNTx/yCvUUe9vWuAjGDW1XzW
	HonDA8cGZHt4h4EDKnpviMpghZZjD9SZLYMulHfHFeMDELy7vhc+JB3R2NBMYlby
	dMHB0nKiREQSNf9Na885g/VMxTrHD5FWVyma/TK1TW9mIotpyBppCTMgEFU3MAdN
	2mBS2jroko9AoHNcnDldD2rDY+sKF6lEs7uv1PUAikbG3QW4EpWz1HCKpcG+QSei
	FNCG/liHbtUkfeqLfKkNcKzRp0/toUq2uOgreIDUpqCF0EhWizlRwKvGsuc3VU8/
	QtwjcoF+cQVrDdPm3Xhr899uh5/47ZnPkTGNBq1pxCqfmHwK/6CVeQYY7TpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753947946; x=1754034346; bh=y4IeoukLRhek617qQczL+NIojyI8CNKAZAn
	JgKLcKx4=; b=Ur3+gMZVDCz1mD62KNMHyxuIqWIEXkISzGwfjfK8N75SbvfNKpT
	2/CJhiiCHNFyURauJa+890zb3HczPMWTfYD6+ukoi4ZLRJ8szpCOKX66als4fcCn
	p05z9XeECUN/Dz1l2j5lzqqi6MT3vhHjl8wlDkQyZY5d8pUmYYnLVRn3PAGYvbbs
	D+MKekvonaF7tICHXCqYUGcp4ButpgpBsQ863oRuxzK1vfLsYSFSw0xbK/cRz8bh
	naU2z34nkwuqCVyjg676sZaYo5OpXA2tCEwfPs+3ltQ59PosgShD/DjD2ttvSWv0
	Ig1RYdJGXhWp3H9oLxPOfubzz0PELbyhA9g==
X-ME-Sender: <xms:KR-LaIb3xVsRj88DBMTbwgznaS8PxI9Tq7sX1cuY24JB0iIboXriVg>
    <xme:KR-LaL0i-JsatIZN7zWzDfiQQKJsihZjD_M4D5czsMnn5YHk0WzzMC0b1C3g-2kkr
    50WY_3KXq_SeB0HqQ>
X-ME-Received: <xmr:KR-LaDYIBijwRQvrWzrLtZmHYfdA35McVz50TwbttyljZ5oqoEEsuGKu7Tsb35eOUu8buTl-xSLbt6IZpp0K4eSnUd9neS8_st0D-GjsIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:KR-LaDLSL0KbFa7FKWEnjDVTgThQddqEIU2Is9n9AOovvmEj-knLuw>
    <xmx:KR-LaCGKfdYM7EczRXMXuLSXVJi07KuKxA_Sc8VXWs6AB-ftPLTzCw>
    <xmx:KR-LaKvsASD0Xuk_ehsIL4yO_nMnz9JocUOb7P5JT348QwGyJ59mkw>
    <xmx:KR-LaBtr5dEK-Xtx8Ughl5xUX2HASs1ghkeDNottHTAwZGlgMT3FYA>
    <xmx:Kh-LaFHURhm4f8Gr1ZnfzCVSKPZXReXHY8c82D6w4P0uVl7mLGtiRnfY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 03:45:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 45b4cae5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 31 Jul 2025 07:45:43 +0000 (UTC)
Date: Thu, 31 Jul 2025 09:45:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/6] Introduce git-last-modified(1) command
Message-ID: <aIsfI1NZlmS3QYuh@pks.im>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
 <20250716133206.1787549-1-toon@iotcl.com>
 <aHmJmwvYmAyi3Nlh@nand.local>
 <87a54wkzll.fsf@iotcl.com>
 <87h5yta7bl.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5yta7bl.fsf@iotcl.com>

On Wed, Jul 30, 2025 at 07:59:10PM +0200, Toon Claes wrote:
> Toon Claes <toon@iotcl.com> writes:
> 
> > I've had this patch included in version 2[1]. I'd love to include it,
> > but it didn't give the results we were expecting. Over time I became
> > more confortable with these changes. Let me see if I can get more
> > insights about it.
> 
> I've spent a considerable amount of time on this, I didn't get to any
> breakthrough. I just submitted v6[1] again without these patches. I
> still love to figure it out and bring in the improvements, but for the
> first iteration I think we're okay without.
> 
> [1]: https://lore.kernel.org/git/20250730175510.987383-1-toon@iotcl.com/

I guess that's probably fine. The patches would go on top anyway, so I
don't see a reason why we shouldn't land the "trivial" implementation
that just works and then iterate from thereon. It's going to be way
faster than any scripted solution already, so it does provide benefit
even without the additional performance boost.

Patrick
