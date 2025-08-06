Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235FE3FC7
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463179; cv=none; b=PzsQYFxpqCn4Rv+ZshupMDmrGtJJgs+iNVyOV6lnWfgOUJ4Y5ZdKGm45PtrK5YYCNeZpUS6ueh2xvuJxWha3JzP2s2NhdbIBSF1fl1kZ41qlhuQZyXCE16QxXzXlFGmaAynh6+Aie9iXAgAoS29kLyXLo/SLqQUE2w6NY53RcSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463179; c=relaxed/simple;
	bh=TBSNT/hWqfbMMd7qUSPE83TjtMM0QuB+HX1Zxzai3Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4tLlnVbRTtJwZH1WJH2bh32NQkzP/LaYmyHzj2C9+qVHU+ffNUeF/i5boURP07Ue5smpc2IOibv+5S+RKHBK3TQmmkBF5e/7qr11ILmMQs+wapI8rNkcj1NHhMlji0U0gS4ErCAbSs112RSJCJo1+SalXnisXSR9vJ14t3kWM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T6P+9v/s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HSra+hkT; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T6P+9v/s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HSra+hkT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4FC977A00B5;
	Wed,  6 Aug 2025 02:52:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 06 Aug 2025 02:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754463176; x=1754549576; bh=nZ5F7L4rPr
	hHyCogpY6Jo6qBlUm+66suLUlAgqW5sCo=; b=T6P+9v/sqh3KRehDx1FfUQhd3r
	cahvflBuRtRmJcrfyOda56HwR+461olSvSBNJmzc2+PCF8bDtMg7bqE6vV4E+MdW
	Yt63ahChra6enC50LSyOymv1lVeA/O7woAvaB1rgogmgYgn/J714m1XP65OAt6Hz
	3Hso79wH5F00FjlrwYzF2pKTEY70z406ZYDC+Iz/Ci15bRxl9QnMxJwcmNGMynJU
	rtf6219l4QJmL43mM5YgdkC4rFSgc1mFlkLISIAMBBDUTFACaVOypp1eXFgzwSVG
	D3/XbUPxhEW/gpd48RFmJ3fXb1jTPUbu1eUfw6pHRQrW+pWFyB+z4JSFgy4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754463176; x=1754549576; bh=nZ5F7L4rPrhHyCogpY6Jo6qBlUm+66suLUl
	AgqW5sCo=; b=HSra+hkTk/k/yiXjFTRseSNaLg/l/3+wkKb2D78NKMU9GXmleTg
	VPNC1NeDzLbdBApmJNFIpNZHzm0tU7Khyv8xYi4p0LUjL5qxroccfhAeNMnvg9cl
	+ed7VcHstG6IUvw3xbP+2Mte7AvIRDsAw8wtqcZVl1AxmCua701i2jbhvE7DRE/7
	Gm9K0yYqs6UdY8mJLujDMUIIwQxUDd3yZX77DsH9DhxapYQMZnANWdWaG6QZaG1B
	HCjEk4WjpsFS1irZOpytcbrVzYNT9N8HoMrldBFK2IgKTlxeDCoO0xxVOz7M6q72
	VBn5e/Tivs8hfiPvbYhoLnkbzvgheEkfp4A==
X-ME-Sender: <xms:x_uSaOnSHgxPPZynDR5UEZKVk8o95MbUMIxSJt-xLrt7LKFOX_7khg>
    <xme:x_uSaGAZsouLa167qlmX7UWvPcxF6omJ2OJm9X3hTyLLzm8-KttmasDPqGVqeKGsn
    VS_uu-vj_0R3_cKSQ>
X-ME-Received: <xmr:x_uSaOdW-0ljl9juLZCLU7AMXdVrhSbheLyiLK-Jc2ChmZxUqr_BlMj3fT9hzqzRj9yILI0Dk3JjSVRSVwU6Q9L-ipw-7U1ovEr2kEG0-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:x_uSaBII0qibgLweMNmoMo9eyIEznVuAs326TSW_k2_x3bdZceMcsA>
    <xmx:x_uSaBeH3T4Qnslf4UhidJPqyer-wCIDl_aZMGHBLYlN8TMnhKDAqQ>
    <xmx:x_uSaI3heSK9V3HyJUslgtyo1wqNJhRYLB4GxRSwYq8nDy-V3R9Yng>
    <xmx:x_uSaKiuVxS55C0sk1522aE2waK5enmEzudE8jrnu_ZPWOW0HKBcfQ>
    <xmx:yPuSaID_5-9UeBfjmhDRIdSLTb7lufelp66qdm6PVnPAjSieWIOq_7k->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 02:52:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 49e9c0fa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 06:52:54 +0000 (UTC)
Date: Wed, 6 Aug 2025 08:52:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/9] commit-graph: fix sign comparison warnings
Message-ID: <aJL7witwAASbQvXZ@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-4-850d626eb2e8@pks.im>
 <aJEuZnhxbJcfdWFw@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJEuZnhxbJcfdWFw@nand.local>

On Mon, Aug 04, 2025 at 06:04:22PM -0400, Taylor Blau wrote:
> On Mon, Aug 04, 2025 at 10:17:20AM +0200, Patrick Steinhardt wrote:
> > The "commit-graph.c" file has a bunch of sign comparison warnings:
> >
> >   - There are a bunch of variables that are declared as signed integers
> >     even though they are used to count entities, like for example
> >     `num_commit_graphs_before` and `num_commit_graphs_after`.
> 
> I have similar thoughts as in the previous patch about this spot, too.

I'll convert these to be `uint32_t` instead of `size_t`. We already use
that type to iterate through these counters anyway.

> > @@ -622,7 +621,7 @@ int open_commit_graph_chain(const char *chain_file,
> >  		close(*fd);
> >  		return 0;
> >  	}
> > -	if (st->st_size < the_hash_algo->hexsz) {
> > +	if (st->st_size < (ssize_t) the_hash_algo->hexsz) {
> 
> I understand why the compiler is telling you to make hexsz a signed
> quantity, but I am not sure that the cast here is aiding the reader, nor
> am I sure that it is making the code safer.

No, it definitely isn't. What makes the code safer is that from now on
we'll get warnings about signedness mismatches.

Patrick
