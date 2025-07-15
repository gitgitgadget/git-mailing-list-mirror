Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E9274FDB
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568016; cv=none; b=ZQEGe4H+a9vWv5ckYLqh6XhiuvTQjsgIGf7ohz2rLfrtXHY+07csQnWe9HRI1/es/JthEe4zIxHh+qHiStErmSas40WIcAU3VwxjY7g9uM2kEeZv5rkuo3uvt7gzy0L3SVXF8ud1s2PMT3oFnCyHR7QCCmH8Sf072SCefoZRRGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568016; c=relaxed/simple;
	bh=sQPTeOjbPU2CRzbGP52Z47YPXeMaoN+PkDPJ+dS0j/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWgWi8g98NpK4E9JvPaAmnzFRNvrrEdNLXt1OyLR2861aqCC+fmxjwEq09lWgzM2ovywlpCRbUoTirPAaywCE7yrMkKkGqVnTqTbpqFl/oV5C8MvIuI6c1+04pHlRPo2fzsaxK1HUwQMWYex2seHF+dkoH8vp2JXW6sE3cr/SKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KPgp6o6w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FDHuh2T+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KPgp6o6w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FDHuh2T+"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 05994EC03DA;
	Tue, 15 Jul 2025 04:26:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Jul 2025 04:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752568014; x=1752654414; bh=ew2OKeRt1I
	IWaLQdPx8cRmMLMy6ZLBw02L2CzgqY2WI=; b=KPgp6o6w4wWSYV4oBAyl8ad3YN
	H1VUmpB/zmRDaUReMHw+yr/Km175yUq8H7kVihksHkpVjqmvm+pexqQXEkUPsFFW
	SaCF+cMNvrTxoMrNbwC73peZQLrfUkW8XU50NkbI26doZVORkCmFvQUXv2dfM//4
	EQ0va1eqgprhCL3JGw4Bj8y8GscOKJNOSKl7secZVsgYX8a8pO3jHxUz38JjTY88
	XrmsCSgfGMx6+4b0SE0UK0+whCVp1tEAWUu9i2Ym7bdXgPZZlM2CVltrOaP5YNjl
	PFLvfKtbgvv7A8qRFkkv8CrX3joNGSm/Uq7/hR7UqR5koVT1OQzfGiw8C5Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752568014; x=1752654414; bh=ew2OKeRt1IIWaLQdPx8cRmMLMy6ZLBw02L2
	CzgqY2WI=; b=FDHuh2T+JoUj5zw5ouatphA1TP++WXXZ0/hL6yKIiyu3bCgn7e5
	63bZudsDc5h/b6I91/UzIc28319arjgZje9j7VtlIyhjis/hteAjKj/QzsNrpY7z
	Swb3TclU6nZbFXiOImVGT6kfrLJKKndwPyQJvTS0uAN5k1/+K5g6BMmz470GGpO8
	skVnKqvdjGFLM32rurghMIO/vFZwz/PMaUoOymlTrkksWfp6DliLpnGc2PBD3WWf
	QrDYNGyJgQipp+rORRE7L9sKYdnBpgh0FPend5e1HT/KqB0cjZ9xCczoh3da22Wa
	10KK1rHmGf/jUScawhcFkQa4yEEg17N5/2g==
X-ME-Sender: <xms:zRB2aKyU6XBm_izcBstX7JaLdFXpAItyE25oK4Nv85fEZ331nEtn9A>
    <xme:zRB2aGfL31kqRVE2JOkNniVRmCxuki9KBzP3LDoalRRxbgK_sr1oRJ_S31NKWq9B0
    bcN0hufuiWE4SWbfw>
X-ME-Received: <xmr:zRB2aOJt1lGdlkUdl3YBHgAx6u3j_YpcNNYAqxiZMDcXnYDgH2Yd8W-R1oqQ3EfymHo31bb_XgxaVZ34TKwB5OUU6gk7EMmN2Zpmjqru4HsISQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:zRB2aPFSJLGLoV-vM7_Xo2YkK4bIAltaCloyenx0zxgZsZ4kbrMOng>
    <xmx:zRB2aArCvyCe5N0234sC-jEashLKViP01ZWBYDjOvzKUGRQYTizKkw>
    <xmx:zRB2aARNx6Il-5VR_TolPmNjnExWefIET8SoENelo9JojRdksv5sUg>
    <xmx:zRB2aFNaj4d_035lY5qW15-jw06xFA1zMT9Zgf0gNCN0Q-vqNrDp_w>
    <xmx:zRB2aBPGZHQvSEJfOMz77QqMsc25j3a7grbdkEq6ScJrEeg2qyE4Ivzh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 04:26:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 067d2e81 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 08:26:52 +0000 (UTC)
Date: Tue, 15 Jul 2025 10:26:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/8] midx: stop using linked list when closing MIDX
Message-ID: <aHYQyK0bu-RQcrHH@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-3-f31150d21331@pks.im>
 <aHBLUg7Y1cgf8i7k@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHBLUg7Y1cgf8i7k@nand.local>

On Thu, Jul 10, 2025 at 07:22:58PM -0400, Taylor Blau wrote:
> On Wed, Jul 09, 2025 at 09:54:51AM +0200, Patrick Steinhardt wrote:
> > diff --git a/midx.c b/midx.c
> > index a91231bfcdf..416b3e8b54f 100644
> > --- a/midx.c
> > +++ b/midx.c
> > @@ -835,11 +834,13 @@ void clear_midx_file(struct repository *r)
> >
> >  	get_midx_filename(r->hash_algo, &midx, r->objects->sources->path);
> >
> > -	if (r->objects && r->objects->multi_pack_index) {
> > -		close_midx(r->objects->multi_pack_index);
> > -		r->objects->multi_pack_index = NULL;
> > -		for (struct odb_source *source = r->objects->sources; source; source = source->next)
> > +	if (r->objects) {
> > +		for (struct odb_source *source = r->objects->sources; source; source = source->next) {
> > +			if (source->multi_pack_index)
> > +				close_midx(source->multi_pack_index);
> >  			source->multi_pack_index = NULL;
> 
> ...and then this line would NULL the now-free()'d memory out.
> 
> But instead we are directly iterating through the sources and both
> closing and NULL-ing out their respective MIDXs (if any).
> 
> As an aside: I know we do the C99-style for loop with declarations in
> many places, but in this instance it seems to have produced an awfully
> long line. I wonder if in this instance it would be better to write:
> 
>     struct odb_source *source;
>     for (source = r->objects->sources; source; source = source->next) {
>         /* ... */
>     }
> 
> That's still a little lengthy, but it's fewer than 80 characters ;-).

Fair, can adapt.

> > +		}
> > +		r->objects->multi_pack_index = NULL;
> 
> Presumably this pointer will go away at some point in the future as
> well?

Yup, exactly, it's removed at the end of this series.

Patrick
