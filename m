Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3189331A47
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046620; cv=none; b=oVBk/leyffFI/DaJizWQfAC4d+t8t5WjRTeVqIN9pYw+O6Jyme6xQLvSNS80NKqANcBOMyNDJUIWs0gQhVDwsOY9D8fbnvYNIbTWxFUjwiGLof2cupcZDChHCLwOj37cPB9rz7w9DBIxxGri+BC86Xb5PfZvrLuwpPrtbwfJAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046620; c=relaxed/simple;
	bh=6SxF7hj/d6IwoWJiPDmlh3/niZMVZjBNLNuU9VLS33A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nl+xRc4U6wUd66NUVGiHpp2YtG4l6/QwzgORiGTXLARs8Cr4AQ+rGmkT8AA1o+NCOyRyaQlEPlJOaua7gsaZ+tReSU2vCBPIlG5Sovcx0MJir9qkMIvxkLpadl2tNDUqSBSCBmpsMR2Ms3GpQVtvFuGfKHFqF0x41rBVe31EaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jLePeX9l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xdecCyQx; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jLePeX9l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xdecCyQx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CD4821D00099;
	Thu, 18 Dec 2025 03:30:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 18 Dec 2025 03:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766046615; x=1766133015; bh=H2ZCm2oTlc
	kXhR1O0f6OeFZ62Ipy4AVnQfUZ4X4QOLI=; b=jLePeX9lLcUO72K9/3G9EkFD7E
	jtGGLRhFy5UTk26hXFl3i59igOCvhTMkfyUvPsrkkzYvwRd8aal1gbOs6Rsesvqi
	SP2jecwRJgtkbu7Nx7wzSFGiHlUqIdS53hh9er44UT4Mhnu2ryWd4WVcHbUQHGW4
	ANxRO7vG/jBv0FOOqhBhKPa9lePLz4iRc4rgoR1svICfzm50L3HLG/fDCQtfFLvQ
	CLi5DHhlPJU7oItGm/QRxtJxD1d00uNXs3XYS2JY9d7+1+pGxAimMutp3auu0Fvs
	/Vieo5oKZSFs8DQwmqThAX6WEwCDj9bZgnVYQ1hSX3pc7ZW5hghh309vE01A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766046615; x=1766133015; bh=H2ZCm2oTlckXhR1O0f6OeFZ62Ipy4AVnQfU
	Z4X4QOLI=; b=xdecCyQxkVayqS6s1F2I1R9C1UYPM2pqrhqXThtVn/3u0o/tNOA
	aRKDVyTi4d6V+nYuej2MBrz01gvlReF3J53BEYotq8YHhjoKsWoWUbCY9j6QkXX+
	VuQUQubPYszEA3xBYusXKT8XFoiD4YK4CRRtVSr/e2DBlCaD+ocNu63TikzGYln9
	1Pn7YU48jKvhAGjd49u4xSFj9XsHHyrjy69Q1c+qtGLSCAtTgHEr4//rqKiXHvLK
	xDTQn9jH5fpfF0e/ct/na+dTIzWDoQGOGhioeF7Xtwh7VklpxsqxQRRMRYbwtynv
	jd2CqB4Su5NzCLX9+gANMKCbjEf5EUSWvAw==
X-ME-Sender: <xms:l7tDaQdtlnP7aSJOY00vwFNCgxOOSutiW32_BeGmNGS9ZcSgw__EJQ>
    <xme:l7tDaZqtRqOZKy7gLgoW5VhuvQ5Rwps1XosZ6Ss7RFk9t0TOLu2NomO_hmP6mUMCV
    osE8-tJI8wVmNiuEsyWhIg0rkwRmuqWYk7oZJSUUQwgiJ2_4DId21E>
X-ME-Received: <xmr:l7tDae5Ohs8ruHTnY9Bavy4IGObQFEWYgQTTLpB0bAMq7Ehi2k1qmXXd6OWhIDQCrRWMgP2hhHVTgWrN8SgsugxsOINfNjgT-rs9MZrAdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dvveelgfduffefkeeghffgteffhedutddtudfgueelteevheetvdfgffdvtddvheenucff
    ohhmrghinhepphgrtghkvggurdhishdpsggvnhgthhgvrhdruggvvhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrphhlrg
    htthhnvghrsehnvhhiughirgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:l7tDafrySxdRPhGyCOW_p_plcPZgExzjHz2U5WyFdB5YrbCpTvNzfA>
    <xmx:l7tDaQiMfFxBabLGUKFaMxUK-e0uKJ6xqm6cGLnAHp2FXC2NPUVeYQ>
    <xmx:l7tDaZJQyFgkZx55oJGsWN-UxUnmtsIAWT1kN5Z2yn8K_YKi6txD2Q>
    <xmx:l7tDaQCEGBbIImjWEhxp9nyafJaua5no1_6STs7aEOzN9gt1gAzkwg>
    <xmx:l7tDaTTce19Dlu19ZDjMP3nkIVLnVN8BrKMDoooaWnTVzHaZ8R39ERtR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 03:30:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c2de79aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 08:30:13 +0000 (UTC)
Date: Thu, 18 Dec 2025 09:30:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Aaron Plattner <aplattner@nvidia.com>
Subject: Re: [PATCH 0/8] Improvements for reading object info
Message-ID: <aUO7kHwgSkV5uQdX@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
 <xmqq8qf0xlce.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qf0xlce.fsf@gitster.g>

On Thu, Dec 18, 2025 at 05:09:21PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --cc packfile.c
> > index 8daa5a5ee7,ce6716fbea..0000000000
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@@ -2549,9 -2555,8 +2571,9 @@@ int packfile_store_read_object_stream(s
> >   	oi.sizep = &size;
> >   
> >   	if (packfile_store_read_object_info(store, oid, &oi, 0) ||
> >  -	    oi.u.packed.is_delta ||
> >  +	    oi.u.packed.type == PACKED_OBJECT_TYPE_REF_DELTA ||
> >  +	    oi.u.packed.type == PACKED_OBJECT_TYPE_OFS_DELTA ||
> > - 	    repo_settings_get_big_file_threshold(store->odb->repo) >= size)
> > + 	    repo_settings_get_big_file_threshold(store->source->odb->repo) >= size)
> >   		return -1;
> >   
> >   	in_pack_type = unpack_object_header(oi.u.packed.pack,
> >
> > I'd thus propose to merge this series via an evil merge, but if this
> > proves to be burdensome I'm happy to defer it to a later point. Just let
> > me know and I'll adapt accordingly, thanks!
> 
> Indeed the conflicts above are miniscule that it does not even need
> any evil merge.  The surviving lines are all from either ours or
> theirs, that changes are close enough to be shown in --cc.
> 
> But let me first concentrate more on fixing performance regression
> that already made down to 'master'.  It is a shame that nobody
> caught it while it was cooking in 'next'.

Fair enough, so that means that you'd want to merge your patch down
first, right? If so I'll rebase my series on top of your patch and then
resend it soonish.

In any case, I noticed a slight regression in one of the benchmarks that
prints all objects, but I attributed it to CI flakiness [1]. The uptick
didn't seem strong enough to really be a regression, and I'm still not
sure whether it's related to this patch series or not. Chances are it
is. I'll investigate and make sure to extend the benchmarking suite
accordingly so that we have a clearer signal there.

Thanks!

Patrick

[1]: https://bencher.dev/perf/git?branches=595859eb-071c-48e9-97cf-195e0a3d6ed1&testbeds=02dcb8ad-6873-494c-aabc-9a6237601308&benchmarks=0da3d87a-ce30-4125-86e9-12d84ec4bc49&measures=63dafffb-98c4-4c27-ba43-7112cae627fc
