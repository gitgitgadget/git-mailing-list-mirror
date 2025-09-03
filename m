Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEB11FBEB9
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881828; cv=none; b=VlqjfG1sJBsIhjaf5dGuwd3B4e72c/DxCrutMeGvnAuAsI6Elmanlyh91MSczas//mxHuNdueywNQUr3yj27qDW+ub9iTkxP1q0dLWkAorN+YCoPUMzzMVYIj0okbA/mu67v80OXSTS0x0JznK3wACaRm1F+l2HiAX0pOLCLwH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881828; c=relaxed/simple;
	bh=ZxiA+QlWcUEDTl+EY3nR/qzpJDrWC1H8bB1vo+tyFXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIZKhrlYBdwHWdlisVcRnKun3c8CfHx0UsNvc1QR18ZKIR1nQ1ECwklG0TbKN6m3v62GrEa1EVUukrHF7OxBK5H/Z0eXH0GrNOXY8e+POfqAD7Yv7gzGSLL0zeFjRztTYl2KAyC8uWUaE0c33QdvpYD0PYiB0YghdqoJHkQ1VgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tI2J0rUd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CVX3CfF0; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tI2J0rUd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CVX3CfF0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 52A33EC0324;
	Wed,  3 Sep 2025 02:43:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 03 Sep 2025 02:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756881824; x=1756968224; bh=UnF5p591CC
	0Eq6rPPFZnxq0/z6P7Sy5GnWntRIlJkis=; b=tI2J0rUdLZf3HgYylHZ4TnEgr6
	dzUXboF31dD/5CP3NMSaOTZUWYmUyD43zsK+PXMHHorhVGo/ss1zIC1hrDxUCuB/
	pSOXzR57jD7dCf5g0oMcE+/mnHzoqI7MJUVmZsDpgaOeaVqfvtYkNKyDXgRzHfIo
	p0DzolFDpTqTkYwHwk2BtEXebkHt3Ww2JXSt3+ii0CGkymnavrPtVk2CxFd/AW4Z
	daJLTwG98lJKjkZtfKl8mgfoCVCnoTg9/WSc5fHCWRcC06aAsacKt2VtTR+ROx5r
	qeeplMHGWWnReLb0PlhGX2KT+ugsbYxsxteYdtAXoC5cy5Y3N1E2eqtKav0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756881824; x=1756968224; bh=UnF5p591CC0Eq6rPPFZnxq0/z6P7Sy5GnWn
	tRIlJkis=; b=CVX3CfF0aBguyOAXdb1/5uTlWF2VxkQfrbWKMR2dgOT8D7KmAJg
	/8p0TR66LBGz1muW8MJWh2Nobe6/6MfzeEeFndfwiaUGMyAzDF+HgDaKQPHFMbIK
	BP8djIQsbf/Ubg6Ho80NGUFfjMYGPdf3YD+Jx2BlPqI8Y7ZEjVF/LokhAIkV8R4c
	BsM3XZskpxeGaRx/eief24aBd7ddYWDCuJiKkOZ17f2XvXQpOA8YLafx/ba07VLB
	ZVcon59JK88gmgRvsnJdmstuw1zxLBtW3FQbX2R7pzn3n8UyC5++gEnoGTxJYz5y
	yEB0nHNhRd8l8/4+pcAVHtdK++Ov4+a64mg==
X-ME-Sender: <xms:oOO3aDzVuOpDK4tIbKG-Ny6wMWbMembC9UY2tVGO9jtRPgk2pYpFJA>
    <xme:oOO3aDsNWuTmxZvQ-QDoEgLuYTlZPGgXqGbBXG4-2FgPXBKKSrqOL0SpuHX0Tvf29
    GlQh-ZhyZ3-IzgMaQ>
X-ME-Received: <xmr:oOO3aNwTjGIOzyN1XwtXpCiadZ8RajwDiiU8ZyWI85XgMkcSAXv0B7QKPmTjV1oWLEO_gjKTtxAAAoBroX3INtsnb3ejsTT80w-OCbo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhush
    hthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjrhhnihgvuggvrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvth
X-ME-Proxy: <xmx:oOO3aODrwUy_iCVoj_0bCHab7JSNMK-1dqAOHhN8FPhLZYvjrdQ1Sw>
    <xmx:oOO3aDfNLCpERRTCZnEVxqctFv6FP9B2DaaQNL2HIEzwJeajtsgANw>
    <xmx:oOO3aAlBLyR_4MfLNQbKf_uLzCmr8TU20Pu5INP-j2uFi0Y7oj17VQ>
    <xmx:oOO3aCHLpp3NGfr7lQFPZ1XVzFH6V4V8PniG-p6XriKoueDO2Y-HBQ>
    <xmx:oOO3aFQFejLf-riZjcCeuaZnEeF-bzZnhInG1BPhQzWm7_SVbVc_dz65>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 02:43:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id afa4ed2e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 06:43:39 +0000 (UTC)
Date: Wed, 3 Sep 2025 08:43:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Efficiently storing =?utf-8?Q?SHA-1_?= =?utf-8?B?4oaU?= SHA-256
 mappings in compatibility mode
Message-ID: <aLfjk7FalA1A0o6M@pks.im>
References: <aJ03RTHaE_JvHA1t@fruit.crustytoothpaste.net>
 <f61c4070-3d29-465e-8dbf-55c4562c0342@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f61c4070-3d29-465e-8dbf-55c4562c0342@gmail.com>

On Fri, Aug 15, 2025 at 11:27:45AM -0400, Derrick Stolee wrote:

Sorry, a bit late to the party due to various things going on that
distracted me for the last couple weeks.

> On 8/13/2025 9:09 PM, brian m. carlson wrote:
> > TL;DR: We need a different datastore than a flat file for storing
> > mappings between SHA-1 and SHA-256 in compatibility mode.  Advice and
> > opinions sought.
> ...> Our approach for mapping object IDs between algorithms uses data in pack
> > index v3 (outlined in the transition document), plus a flat file called
> > `loose-object-idx` for loose objects.  However, we didn't anticipate
> > that we'd need to handle mappings long-term for data that is neither a
> > loose object nor a packed object.
> 
> I'm generally not a fan of this approach to (ab)use the pack index format
> for this, especially when the translation needs to expand beyond "objects
> in the local repo".
> 
> The requirements, as I see them, are:
> 
> 1. Given an OID in Hash1, load its mapped OID in Hash2 in O(log N) time.
> 2. Given an OID in Hash2, load its mapped OID in Hash1 in O(log N) time.
> 3. As OID pairs are discovered, add them to the data structure in ~O(new)
>    time.
> 
> > Some rough ideas of what this could look like:
> > 
> > * We could repurpose the top-bit of the pack order value in pack index
> >   v3 to indicate an object that's not in the pack (this would limit us
> >   to 2^31 items per pack).
> > * We could put this in new entries in multi-pack index and require that
> >   (although I'm not sure that I love the idea of requiring multi-pack
> >   index in all repositories and I have yet to implement compatibility
> >   mode there).
> > * We could write some sort of quadratic rollup format like reftable.
> 
> My thought is that the last option is going to be best.

Yeah, agreed. One thing that we tend to always end up with eventually is
using geometric sequences for repacking data structures. Because
ultimately, the bigger a repository grows the more expensive it'll
become over time to rewrite the base file. And furthermore, there's
always going to be use cases where rewriting the base file needs to
happen a whole lot more frequently than one would reasonably expect.

> It does require starting a new file format from scratch, but it
> doesn't need to be complicated:
> 
> * Header information includes:
> 	- file version info.
> 	- hash versions in mapping.
> 	- the number of OIDs in the format
> 	- the previous mapping file(s) in the chain
> 	- offsets to the Hash1 and Hash2 tables.
> 	- room for expansion to other data being added to the format,
> 	  as necessary in the future.
> * Hash1 table has a lex-ordered list of Hash1 OIDs and int IDs to do
>   lookups of the mapped Hash2 OIDs from the second table (by position).
> * Hash2 table has a lex-ordered list of Hash2 OIDs and int IDs to do
>   lookups of the mapped Hash1 OIDs from the first table (by position).

I was wondering whether we need to fully reinvent the wheel here. We
already use our chunk format for multiple different data formats (commit
graphs, MIDX), so maybe we can also reuse it for this type of mapping?

> Lookup time would be O(L * log N) where L is the number of layers in
> the collection of files. Writing time could be as low as the size of
> a new layer on top, with squashing of layers handled in the background
> or in the foreground (opportunistically for small layers or as needed
> if background maintenance is not available).
> 
> I'm sure that things are more complicated than I'm making it out to
> be in this email. I haven't looked at your branch to see the subtle
> details around this. Hopefully this just gives you ideas that you
> can use as you compare options.

Likewise, and I'm very sure that due to me being late the ship has
already sailed :)

Patrick
