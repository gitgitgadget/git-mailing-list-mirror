Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3FA16F90B
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341633; cv=none; b=dzw5CN+QB1DjwLHyPp3yxSRoUvvCfip4zA89E5NLhh9qccr+39s8xJ8naWEa2xhBG6EPH1UEI1O76HhAwtjdRLtm55c/6AXHxmMKxs5s2RK2bu+IvCjvPHcHoRkRj0gnbg0lTlta3C9Kls+cC37uialShUr7p9SisOxCEEXx0fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341633; c=relaxed/simple;
	bh=K+bC8fiwN5PFQ+oOgjK9rKOSv3QR1ur7rN0eWsgaxbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwyuN8yPUMCNUnSgVpA51Oi7sJ2KaZUp3IKBc+DTgHUkO1AGiICdzYlu4ihAcvdBUO76YP2W/pu0rch6cVnkgMXZiNIkzV2bZxhKuph2vJL7omHQ0VnNPssg84HOtH5AklrGy+Pl2PvUW0YaUBi/skX7cctr4suFXAh5pZQULKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q7EI0uhf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OqAGp8jy; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q7EI0uhf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OqAGp8jy"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 663BD18000E8;
	Fri, 10 May 2024 07:47:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 07:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715341631; x=1715428031; bh=RkXx/wMKrL
	5020Cgj2pYiEcm5vWUv5gn+x7HlA2O5MM=; b=q7EI0uhfE+/afiZbFW+6hAfj/7
	VlUGdlAHEoRkgesbqhTavzliEukibVAzgQGZHWwU//+LgLg1MC6lnjitWgKtp/YX
	/b9vZkQA0YNcGTN2TrBep5HIwueZ/f/frbfTS+BSy1pNoyAMfmLu0hkiSxwgMh0o
	Pq8lWk7ERex5ltnH/Iuc+mMZNfx7AqK88dRk2jznw5un0ma/g5MWQ9XGHlYwCTxH
	Qc7QYiYjCb9u+wGwWe27vsUdxBhJq0/Lt5x1UUJZFpPpAaFLDvjWKOIKKwTFAZ8c
	7H/L+5z+0dp8qgDW+8hb/gakR7sdolBTdf9MHC1leQFkx95dgncyynQgRR0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715341631; x=1715428031; bh=RkXx/wMKrL5020Cgj2pYiEcm5vWU
	v5gn+x7HlA2O5MM=; b=OqAGp8jyEsXw0tagqnnxd4Q1xK1IXgd/pvrPeRqeB7Km
	9v2Yvr1D2uHcle6ovCtrRzv/X9Tv0d5lOwtqIT0ziPba7UlXcNo3bN72YUYXE65Q
	V0MTI300e6d8VRv3vyxYYckAhttU9I5GcBLjTVNB9LW32W11AGMhDrTt+m8a9oLH
	AEaHQSyGXKdzP9DFcGCABIw8W2CaizAkMfuuW2xlyrtPggljfhnbp42BIztq7S0J
	UM667MR/aCA96hYTYvs4RJG0VrGxmnLSQawnoGnm544OHobnftGvZbfSqW/jXFil
	gBAlG5d/QAGXDsggDS3WBuUJ5zi8Y/N6nG1os4mKAw==
X-ME-Sender: <xms:Pgk-ZneyzlnH4PqiogVyAR6fJnfD97ufbYzJb2aOE-iy38gHVeoEbw>
    <xme:Pgk-ZtMCA_EHzslJmYBon18idzHUblwAiusKCvTm7m2g_wkX-kjtjldfB3tp6xu7I
    d2-epYqDiwxirwUMA>
X-ME-Received: <xmr:Pgk-Zggett7kNdQlSwbX8xrGBf65oKqlgnJSQxMOCvZMsOwU27ADJs7xxE0NIq-YQHWbffLwE-PoxoHpSaYR_nECIlD-KyAsnaCtFk5fsKjl_UTJwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Pgk-Zo9lyVbQDjaQKu3La9b8GIwItZvJToXy16nS7DGTzf9nzpiiEw>
    <xmx:Pgk-Zjt8FsMW06_4RxaTwugtO621e7aPazSnDJ1rjifxyevEHzjppQ>
    <xmx:Pgk-ZnGDenWBOJnFCFNXKdPYMeWhOP-jeS_Z8ZNDbKRtpVVW2gATKw>
    <xmx:Pgk-ZqMOC7Tyf2ec74xtn2X7kAaeA1L7AtLXlGJ6Kc9yxaOhWdfkqQ>
    <xmx:Pwk-ZpUR8Lf3lZJnXZM1Z4j37fzVma_-NLbsAWkqrFLgC3Z35HaDe-0W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 07:47:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 739b08af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 11:46:56 +0000 (UTC)
Date: Fri, 10 May 2024 13:47:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/23] pack-bitmap-write: support storing pseudo-merge
 commits
Message-ID: <Zj4JOv4wJQh7GuIB@tanuki>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <ee33a70324589a98c2239530b03cc2d7afbdfb9e.1714422410.git.me@ttaylorr.com>
 <ZjjEmGHYnw20wVBg@tanuki>
 <Zjkl6vMHCeDsJKdR@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xyPXgFXSr9qKUTre"
Content-Disposition: inline
In-Reply-To: <Zjkl6vMHCeDsJKdR@nand.local>


--xyPXgFXSr9qKUTre
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 02:48:10PM -0400, Taylor Blau wrote:
> On Mon, May 06, 2024 at 01:52:56PM +0200, Patrick Steinhardt wrote:
> > On Mon, Apr 29, 2024 at 04:43:15PM -0400, Taylor Blau wrote:
> > [snip]
> > > @@ -46,6 +48,11 @@ struct bitmap_writer {
> > >
> > >  static struct bitmap_writer writer;
> > >
> > > +static inline int bitmap_writer_selected_nr(void)
> > > +{
> > > +	return writer.selected_nr - writer.pseudo_merges_nr;
> > > +}
> >
> > This function may use a comment to explain what its meaning actually is.
> > Like, `bitmap_writer_selected_nr()` is obviously not the same as the
> > `selected_nr` of the `bitmap_writer`, which is quite confusing. So why
> > do we subtract values and why are there two different `selected_nr`s?
>=20
> selected_nr is the total number of bitmaps we are writing (including
> pseudo-merges), and writer.pseudo_merges_nr is the number of those
> bitmaps which are pseudo-merges.
>=20
> I renamed this function to bitmap_writer_nr_selected_commits() which
> should clarify things, let me know if that works!

Yup, that's clearer, thanks.

> > [snip]
> > > diff --git a/pack-bitmap.h b/pack-bitmap.h
> > > index dae2d68a338..ca9acd2f735 100644
> > > --- a/pack-bitmap.h
> > > +++ b/pack-bitmap.h
> > > @@ -21,6 +21,7 @@ struct bitmap_disk_header {
> > >  	unsigned char checksum[GIT_MAX_RAWSZ];
> > >  };
> > >
> > > +#define BITMAP_PSEUDO_MERGE (1u<<21)
> > >  #define NEEDS_BITMAP (1u<<22)
> >
> > This flag is already used by "builtin/pack-objects.c", which may be fin=
e.
> > But in any case, shouldn't we update "object.h" with both of these flag=
s?
>=20
> I can't see where in builtin/pack-objects.c this flag is used. The table
> in object.h says that bit 21 is used in:

Yeah, no idea. I must've been seeing ghosts here.

>   - list-objects-filter.c
>   - builtin/index-pack.c
>   - builtin/unpack-objects.c
>=20
> But I think those are all fine. We don't call unpack-objects from the
> bitmap writing paths, and the same is true of index-pack (since we're
> writing the pack out directly).
>=20
> list-objects-filter.c should also be OK, since I am 99% sure that these
> two code paths do not collide, but even if they do, that field is only
> set on tree objects from the list-objects-filter.c code path, and the
> new bits in pack-bitmap.h are only set on commit objects.

Okay, thanks for the explanation!

Patrick

--xyPXgFXSr9qKUTre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+CToACgkQVbJhu7ck
PpTnIg/+JKGrYgY+52I3oP96WYZCRbMeuZvNAPi/Nu3AYlxD6Gh8O18EnqgniRS/
pMrECH3WNkrCjoli16KHGpT5S0tHcmj40KuK+1XGC4zTVP18WF0rg9R/lLoUTOb9
//7yFTObAUGZUeihrgo1137MVRfLYVee1mT3bY5Bme3YDqCttuC4Js0R7AMXdbxH
I2uSUcVyG7onCR+B+FK72EwxsqpY6MhZsYhhkYGTQaXlD8UdIMxU5QHmC5C2mFu1
Nmwj1uix88ZisFRUghNbahFRcZRt2L0541gB2kBcXuXRNeGqtsxOLHjfT6wWcfrV
xkVoyKXgei7VYTdUF0wrg9kWb14x0WVwf6B0u0akLB598rTf2fTCNjvAiHgbu97A
vyBRrVVE7jq3I9jcF/jMhqCMpTVaSbIwIrCeMHkT0oMZl7EeVGZaYckPVfHeUWCF
g/WfIYktBHqC/35d40BiLOQD1jDgfwb994N+JEmz4jPqBMyReaOqq8OYpO2Cz5NQ
GyMby7DCsLowABY0wZrPzoskeg+uYNz+pSaMx1LAQg6O/0DqGC5vt/81LL7cfC+0
mg0tKQNUS4Fx7Z6tD+qebomJvnwj+2N8P4+0n90sBE11g6x8ysUq2cDYYlRxtWBC
OYMu2fTHDl2GX8kk6wp/abL/1bKUpsePisbOvguWMKgiOiTxwRg=
=Xo2G
-----END PGP SIGNATURE-----

--xyPXgFXSr9qKUTre--
