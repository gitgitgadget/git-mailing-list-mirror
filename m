Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2D15F3EA
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341006; cv=none; b=TfSBDq9CGoj2yihz1jjOIGSHYQ3xOTRMeYMLXUEwPE9qs6eF4TUPku6viP5KeN1e4QiHrQOXnkrv4NnLgg+LoMdWA9LPht8qArBdlw7eh15GRhS3ip2aKyir6J6SnwMTwWLuus2uHbyzMrMnbUVHFvu94yDSvYofRD7IW2rGaAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341006; c=relaxed/simple;
	bh=yuqBSDcFzXyZD4RqJGgYOPSdk4ldKp8IFJ0lLw6adF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPF8fT8dQQVljEO/hcCB4GBqwTm8kNu2JYTCUSMXV4QqdGQp0nEJjl36iRyVd5ZOWTS1MJkhtNzKxexENQkP38dMeUTz1kRJBkN2QizL61u6U30dZ++jjCb7go93Et6Q/AaCUiBYI0V+dS1jIN+VlSRT0GV4QFlYjKh80H38AJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pvWsT5tw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bZN4ULYw; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pvWsT5tw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bZN4ULYw"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id E4A5918000DF;
	Fri, 10 May 2024 07:36:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 10 May 2024 07:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715341003; x=1715427403; bh=6BsKkSWVzb
	gLRPfz7S0kdVSZ3Hduv8eo1kIy/ebcYt0=; b=pvWsT5tw9XV2lhb7z7o7nDo3uq
	5TyRzzj9qbfQKbkzdPTkA/gZuBcylgnpllKboUh0l1GJW7uuuCA7hKJRzlVycL9j
	7WqWF0lDyhCFX6h12RPFcqzNgptd/ndU0VIZkXxpTYggYw8Qm0MTFOOAnsRx7wy2
	G1EBKrUDfuZ8KfFtI09s6Flm3JYhBAd7EaqQv7jqZz4m2+L+c2qiEaBytFmAEhOD
	/DBDZApOYwIeaAe2oAlD/gP1WForziZSGn2lZOAHrGOFicCItun/c0HtboyxNqzq
	xu89GKBEUrvpYQNL00FLcJeqco2LrgIL1TIxDDFizCMCDb+HSRZFiJpaPKnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715341003; x=1715427403; bh=6BsKkSWVzbgLRPfz7S0kdVSZ3Hdu
	v8eo1kIy/ebcYt0=; b=bZN4ULYwRGgjCYQRIOl/T/DKPR7pRt0twl3/xxpBSOLR
	hpu91QODDKLRtdr9t4zlgF6I4dt5oBQqDypjhDDoXexyrKph285PuTb2mpaEWrg4
	7/ZwLy3dKmYyYdWdvkpFGJdtfWML2UwkqF/UNnUh621ccyntV1+PobjDls3wTLAE
	9Oc0wqufyLYngDFaqPVPdbMNHFOk5ry71kfW8rq2vLQsH8B/LIhaiL3XmL/TJSDQ
	bBRpEmBdWZt0eTaX0h5oeKiALCdsysTr4Dy/787+h3oUXz7r9ljzgbWlenv5wMgi
	LfQHb1TyAcaZL8XkCSmbVxXLEdWFtESh+Wsq4jjcAA==
X-ME-Sender: <xms:ywY-ZuRwaNCvD47rvmb9kE-EMH7PUCFfaiomtcdmJbK1czimu_Uodw>
    <xme:ywY-ZjwFC6ROtrPU0F8rY8prxXGNKoJoGGRyU3suZ0YIPqhhOxt7hyHL0G_AP76-0
    3-eM_n4k8M7bd91bg>
X-ME-Received: <xmr:ywY-Zr16FZIvxjjLe1nTli-Gh5TgVjcNtTsyHobslE0mRLlqv8-DnyG5SsFzeUv3n6Hmyo1oy7Rk0uFgHcrhi0JSfl35IEqxQ4MIcVIX6pcDd5sj-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ywY-ZqB8itDzg0hd8vQCcG7xLQWc9p5hj3Uz8k48hG1NTl40rg26LQ>
    <xmx:ywY-ZniUshbPHMzuJ_SBaDP6xuVx8DfAUK4HbXbEQLpRImuvNYhSyQ>
    <xmx:ywY-Zmqj84rH_nP-E--hiUv2yWBi5JTctXEsj2eZJywrw8v0ALNgXw>
    <xmx:ywY-Zqhh4xKDtAcUUBMlaQQqQgLvujVf0kkor41lCQSKleca72w9Bw>
    <xmx:ywY-ZktM4ZWdZASUkTLjLG0DyK0hWwnmi96kNhuiPNzeUU0YH5yKjVov>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 07:36:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6d2222e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 11:36:29 +0000 (UTC)
Date: Fri, 10 May 2024 13:36:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] docs: document upcoming breaking changes
Message-ID: <Zj4Gx6LGSoTGc3eW@tanuki>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <xmqqle4lnuvy.fsf@gitster.g>
 <ZjuEMNsw-KARJjwx@tanuki>
 <112b6568912a6de6672bf5592c3a718e@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9oGUT5TtTVQkXWdk"
Content-Disposition: inline
In-Reply-To: <112b6568912a6de6672bf5592c3a718e@manjaro.org>


--9oGUT5TtTVQkXWdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 05:59:01PM +0200, Dragan Simic wrote:
> Hello Patrick,
>=20
> On 2024-05-08 15:54, Patrick Steinhardt wrote:
> > Okay, I see how that may make sense for some parts. I guess one of the
> > motivations here is things like git-checkout(1) and git-switch(1) /
> > git-restore(1)?
>=20
> As I wrote already, [1] I really see no reasons why git-switch(1) or
> git-restore(1) should be deprecated.  That would make zero sense to me.
>=20
> [1]
> https://lore.kernel.org/git/3d84f2eac9b03eda814332d73b5d5ba6@manjaro.org/

Note that the discussion here is the other way round: whether we want to
eventually deprecate tools like git-checkout(1) that have newer
replacements. Junio argues that there being a replacement is not by
itself a good enough reason to eventually remove the old one, which I'm
fine with.

Patrick

--9oGUT5TtTVQkXWdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+BsYACgkQVbJhu7ck
PpQGmRAAqj+zXkXapvyh5m6cgYyDb6KCn9ySvixAMkv2giOYjif6PAK8XQ0CFwx/
XqgbHyC1JQSklRu3q2mxQlndrno4mXWByAoknrIDRjVX9Xnq//4Ij62NM0rQ+KC5
YSA9eSegoF0GEXdfTmAxIvTxy/0pjiUAdqnoNKRxulCvIhHn4tzK5G25h9Olwt/x
bBJeCDTOIr1Vk5y9H/7ML+GhqwmYwLftiX5NHyX0Zzq2BY2R05ModsqjtIkf92w1
M167F+DEWm5jLwj3KXlMbVM32cVZjkQ2NEheHBk10RDY5OOuJw6zJhcKmJLtzoLo
Myou1Xx5y8epgfbCG0QhLk9hCITizMfxPjZQXUL50Ey53MfQTPvbFbVI8fmNV8xj
jykE8hAs8dXn4TjmhW/HwScjk8SUIoFVivxOKacAsMNk+cU5BC1juGnG4YgraI+b
vYBRPbZkP/qj12RUjPx8j+GWmXL497eFoUgOiYJes0pENM2xd0tFwKx9jz/6Ywyw
chw1XuSUAK2Mfrg5R6Xnl67u3YhC1Eh6xa+izgRZqbErf+ayA6tQNa6Fwc0R5hLt
8ZXngZrtCf7wEmxwLiLG0TW2+hJifSlDj0YXkm+o8bJQXdp094FVgBdTOrJDwyWB
LPPDPpb0RitHkP31DgbgnGJeKx4ZAcN8AouXhYlTIek/ib/Ml5g=
=Dioq
-----END PGP SIGNATURE-----

--9oGUT5TtTVQkXWdk--
