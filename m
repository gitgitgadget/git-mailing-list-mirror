Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ECA18593A
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729751454; cv=none; b=Xkxvdua/spUHJaUz9ofjTxeKtGRcDTbFAWmmJQByf3qEhKZCjLEooE+SU9brp818wVrVIdKwg6lBLU7QXSK9+/ai00jfFH4Wezu5r+rQLjax6zbsDyRx5i0DjeIuTvCnbG/Duilu+n5XoLaP0XiWcpTakzz1m+kQ9kS+Zm6XWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729751454; c=relaxed/simple;
	bh=43d72b4ZcCLEAAUnpc+f2q2VBcnrP8XNGuRwD5Mhn6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGUNam6hbKck56AXtjpNj62idUSg20wFbde3hCKXMBlX14Fc03HT3N2FMBhkWoT9HX1Ygn8Qg00oIIE/1vWpFOdiHDXqs6vDjRxicrj7S2wh6XKWUihT8Xrp9FOvqggMZuarME14lQZMtjvBzIxL5NKE2Toky+HbJT1BLoXnYq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l561luru; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uo+6NuHD; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l561luru";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uo+6NuHD"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 886D213805FC;
	Thu, 24 Oct 2024 02:30:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Oct 2024 02:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729751451; x=1729837851; bh=qgAnNsJmZq
	i5d07sF34WsZG9bDONIHMvxoH27NG6S9Y=; b=l561luruXjtdphnSejPchYlOlv
	SMHYRRu12EDcfE9xMhs7sPx1PpqcVWjx6ZpxmRSSA4moJq/eYpY+mg3ClFLyWWlB
	076S8RuiyxvoT2/0TOJglKJZmcuwHGLj6cAizpDlWWoS0vwwyeJU+vFrPXoP8NhP
	lJZltm5q0RTCgVoU5ijhK0K68pDnbaraZjQZdpiuA2RVMbdsQMg99XpB168whyDN
	JgnyF3+0Boe8wV6YotjFU2eUghvSRM85PFYg7hUqyIlMrnkkVN+nIth8Tt3lZmsA
	4lbzEgX8X5+cb91YuyAxTxssrMAdPs/d+0IBzLJ2YlUevKZtkAxjlqddS6iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729751451; x=1729837851; bh=qgAnNsJmZqi5d07sF34WsZG9bDON
	IHMvxoH27NG6S9Y=; b=Uo+6NuHDNosFpTE5Dy7Ig3Q7X0W/NLUTEy12Bz4YfRpv
	61t4YTA26yvvlnGsfnK9lzD62eV7QwxcX3mlNw8y/pbMhs/j0avZQA8+CnxgX7ZW
	SjHzgAplqavzMtyCcq6/PZpVCijGGKUxQWNG56n+XYRI76lbY84aQbpmc6+6Zo4S
	mJhiUVMMWDbc+4Lg4775rQpHHCIUysuB9WTNi+q3SuiKRWOtGgzPnugbj02qpBhV
	hceGt0fXcCVsHIsOcuVxGUP6GIqTQ9MDbgWAQEdoLBABkVP4YzwyT0eaGrRBR5y7
	SzjfiYvav0c8EP4VnucqdCgyHkOo+RAGCl8nRY/4bg==
X-ME-Sender: <xms:m-kZZ1BQJGFvzsBOJVWJ8Hu9JilQjaxZrnvvfKGCLghIHofOq2fkWQ>
    <xme:m-kZZzguVK6fFNBKbPQkGj4UejylHJg1Wwe2aozWntnj6d3i2C2gU6yto_i4dNjEp
    en04GGEKOeIMJ_iVw>
X-ME-Received: <xmr:m-kZZwlWXv7mkipYFi8gpZMdBiUpRvP0O3PCgyolx6e1NwaiKrrExJG2D387TKZeEDQ7VsuQG3cWLogryLNTvLFoF-sCetjhBcBAE3bDOnrlObCB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeikedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghs
    rdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomh
X-ME-Proxy: <xmx:m-kZZ_wjpnLbLYGkmecXORvvIhsydAP0QQB5VEOnSyAkQCVEbeGnFQ>
    <xmx:m-kZZ6R-pQXXkf17DrpOAM0rtvrBo0a0Rh8VdwuX1k8olyI-C5IznA>
    <xmx:m-kZZybgVI_Ne2676Z0YT3qr9V-fFfanWv-WWKv14nq9WY3tKEjiag>
    <xmx:m-kZZ7QlK1J90vkn9CgXfXy4xYqj-D-z5s_cISvKvzVxTpOS-fBugQ>
    <xmx:m-kZZwM38PdnYzlnQE3ST-3raH45KIE-P8E_QnHeEyk7iaYAGK-iiqkN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 02:30:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f96b708 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 06:30:53 +0000 (UTC)
Date: Thu, 24 Oct 2024 08:30:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/3] compat/mingw: share file handles created via
 `CreateFileW()`
Message-ID: <ZxnpmPbKDNiQl66p@pks.im>
References: <cover.1729695349.git.ps@pks.im>
 <907576d23d1dc39b679a323e74b6bfb227d6c17d.1729695349.git.ps@pks.im>
 <ZxkxAvLeMtxstVdS@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxkxAvLeMtxstVdS@nand.local>

On Wed, Oct 23, 2024 at 01:23:14PM -0400, Taylor Blau wrote:
> On Wed, Oct 23, 2024 at 05:04:58PM +0200, Patrick Steinhardt wrote:
> > Unless told otherwise, Windows will keep other processes from reading,
> > writing and deleting files when one has an open handle that was created
> > via `CreateFileW()`. This behaviour can be altered via `FILE_SHARE_*`
> > flags such that other processes _can_ read and/or modify such a file.
> > This sharing mechanism is quite important in the context of Git, as we
> > assume POSIX semantics all over the place.
> >
> > There are two calls where we don't set up those flags though:
> >
> >   - We don't set `FILE_SHARE_DELETE` when creating a file for appending
> >     via `mingw_open_append()`. This makes it impossible to delete the
> >     file from another process or to replace it via an atomic rename.
> >
> >   - When opening a file such that we can change its access/modification
> >     times. This makes it impossible to perform any kind of operation
> >     on this file at all from another process. While we only open the
> >     file for a short amount of time to update its timestamps, this still
> >     opens us up for a race condition with another process.
> >
> > Adapt both of these callsites to pass all three sharing flags.
> 
> Interesting, and especially so noting that we *do* call CreateFileW()
> with the FILE_SHARE_DELETE flag in other functions like create_watch(),
> mingw_open_existing(), mingw_getcwd(), etc.
> 
> Why didn't we call CreateFileW() with FILE_SHARE_DELETE in the below two
> functions? I assume Johannes Schindelin and/or Johannes Sixt (both CC'd)
> would know the answer. Regardless, it would be interesting and useful
> (IMHO) to include such a detail in the commit message.

Hard to tell, but I think it's basically an oversight.

  - `mingw_utime()` was originally implemented via `_wopen()`, which
    doesn't give you full control over the sharing mode. It was then
    refactored via 090a3085bc (t/helper/test-chmtime: update mingw to
    support chmtime on directories, 2022-03-02) to use `CreateFileW()`.
    This refactoring wasn't quite to the old code, because we use no
    sharing flags at all. But in fact, `_wopen()` calls `_wsopen()` with
    `_SH_DENYNO`, which ultimately translates to `FILE_SHARE_READ |
    `FILE_SHARE_WRITE`. So we lost the read/write sharing with that
    conversion.

  - `mingw_open_append()` was introduced via d641097589 (mingw: enable
    atomic O_APPEND, 2018-08-13) and had `FILE_SHARE_READ |
    FILE_SHARE_WRITE` since the beginning.

Why we didn't set `FILE_SHARE_DELETE` is a different question though,
and none that I can answer based on the commit messages. I would claim
that it's likely an oversight and wasn't done intentionally, but I
cannot say for sure.

Anyway, I'll include the above information in the commit message.

Patrick
