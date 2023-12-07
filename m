Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oRNHVUXT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jz4oFCmu"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12F610F2
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 22:52:25 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id C533C3200A31;
	Thu,  7 Dec 2023 01:52:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 07 Dec 2023 01:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701931941; x=1702018341; bh=Od
	XNev7COKD66TtJjJX/zVnkj+jGfQ/eGiyER7pTI+E=; b=oRNHVUXTw2A1krLuCw
	YRmwDMWkFCeQb8377vgMtirn5CuW+usWwCWsYsg3CvG7LfH8XHdoNq3umU8rsPkC
	LxkYdtCoXYAHqVTk9dE8lcNKIBWjZ58x1ZneMbYq4ue76WZCRxzwiSG1l4kqzoEh
	I51yJ1fwasMPzV8BWPlRACWtFy6utGtxS9YLCDp+HwwjAYE0OgLMOVO6hPXiAOLN
	u834VxE/rdju5MJi/ogCpA/rTqn3zwTPaPpoSzZqRmNz7jkqKS4M2glu8mp2xc3H
	zP+0VnuABRL2U7/wtqk+Ikr2izJr0MHJP5KCtkf3y/bGyJiJJsbBrVIq/qsb3V4/
	oeCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701931941; x=1702018341; bh=OdXNev7COKD66
	TtJjJX/zVnkj+jGfQ/eGiyER7pTI+E=; b=Jz4oFCmuCsfrdXQuJgYiNuKc57T/f
	Zj1hIK55QaVtJSwExxdf0Vq2cTlBSXEzpZvZU1bsuF3LgMJOc7lKuMIVoOiXnj3t
	n7o0SXdp77shIY0IUwAUqH6F+1/5Z6C1XmJvgigIpXnuukym2WYc4i68yDWJVV5s
	eAlSjxihIDrZkfe8tQn2rDfxpAmYCTjvTWy3gSeuayKt6dAYCoRlqEXS+9K/PwEC
	Jqk4Iwu9FpDxcHx1Z099zlu9sbC1K6MYGfoKxtVhYUBYkJTC9/7F3pgNosY/oLRS
	ykM6mqtqWonEa09A4PI+CZzbF4yhcAgoNhXmAInSGuv2K8wxArgTvxHOw==
X-ME-Sender: <xms:pWtxZSn_eQAvkJx5hPJRgqI64i8FgW1kZU4JOIMUdDMNf1OdDg8M4A>
    <xme:pWtxZZ2W8t4xcbTS2x0VpY1ugKiRva-WEbX_fzmoC17riWNaJxraQI4GTCqU37gze
    YihElzEm_oVAoyRng>
X-ME-Received: <xmr:pWtxZQqHt9aRw36_BohyUmX-nvcuBZQ9KND_sYUFMd4Sa2PzaBVi0dmR3tRHmEanEmyAS7ko-gnFh7hHr2d7_sP0oMafDwpahbBSgbRq2BhHp80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:pWtxZWnnkr30XpIXLyvAkwbbh67PqwRBoxSgCHdvL0br6V2QdoDbSQ>
    <xmx:pWtxZQ2ihFLpo7vhKlXVBJwgFhu6xjkvWd1kdXouP-sgrRlTePELog>
    <xmx:pWtxZdtJ83Z5S0Q0a3KaG0aqR9zIaY5NmRuJf9V_pngPqbr9ErEwzQ>
    <xmx:pWtxZdzvige47SfVojlAnoA6apGgypVYExbxnV5_3ylyzee4u5iCAA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 01:52:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8cb4946d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 06:50:50 +0000 (UTC)
Date: Thu, 7 Dec 2023 07:52:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org,
	Carlos =?iso-8859-1?Q?Andr=E9s_Ram=EDrez_Cata=F1o?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH] object-name: reject too-deep recursive ancestor queries
Message-ID: <ZXFroM6x5xY8fszx@tanuki>
References: <57c0b30ddfe7c0ae78069682ff8454791e54469f.1700496801.git.me@ttaylorr.com>
 <ZV9Za7iCL6WiE-Py@tanuki>
 <xmqqy1en7af2.fsf@gitster.g>
 <ZWB26TH0CFW1KC4L@tanuki>
 <20231206194035.GB103708@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IaGte/WX4+WDBcIM"
Content-Disposition: inline
In-Reply-To: <20231206194035.GB103708@coredump.intra.peff.net>


--IaGte/WX4+WDBcIM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 02:40:35PM -0500, Jeff King wrote:
> On Fri, Nov 24, 2023 at 11:11:53AM +0100, Patrick Steinhardt wrote:
>=20
> > > When we get "HEAD~~~~~~~~~^2~~~~~~" from the user, do we somehow try
> > > to create a file or a directory with that name and fail due to
> > > ENAMETOOLONG?
> >=20
> > Sorry, this was a typo on my part. I didn't mean "revision", I meant
> > "reference" here. References are limited to at most 4kB on most
> > platforms due to filesystem limitations, whereas revisions currently
> > have no limits in place.
>=20
> Even without filesystem limitations, references are effectively limited
> to 64kb due to the pkt-line format.
>=20
> Revisions can be much longer than a reference, though. We accept
> "some_ref:some/path/in/tree", for instance[1].  I think you could argue
> that paths are likewise limited by the filesystem, though. Even on
> systems like Linux where paths can grow arbitrarily long (by descending
> and adding to the current directory), you're still limited in specifying
> a full pathname. And Git will always use the full path from the project
> root when creating worktree entries. Plus my recent tree-depth patches
> effectively limit us to 16MB in the default config.

I was only able to trigger these issues with _really_ long revisions,
like hundreds of megabytes. But that's on a glibc system, other systems
based on e.g. musl libc have a much smaller stack by default where these
limits would be hit sooner.

> So I think it might be reasonable to limit revision lengths just as a
> belt-and-suspenders against overflow attacks, etc. But I suspect that
> the limits we'd choose there might not match what we'd want for
> protection against stack exhaustion via recursion. E.g., I think 8k is
> probably the minimum I'd want for a revision ("my/4k/ref:my/4k/path").
> If one "~" character can create an expensive recursion, that might be
> too much.

Fair enough. I think combining the two approaches would be sensible as a
defense-in-depth approach.

Patrick

> So we probably need something like Taylor's patch anyway (or to switch
> to an iterative algorithm, though that might be tricky because of the
> way we parse). I agree it needs to handle "^", though.
>=20
> -Peff
>=20
> [1] There are other more exotic revisions, too. The most arbitrary-sized
>     that comes to mind is ":/some-string-to-match". I doubt anybody
>     would be too mad if that were limited to 8k or even 4k, though.

--IaGte/WX4+WDBcIM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxa5sACgkQVbJhu7ck
PpS+4xAAnc2sVu8qWbc+hQge3RGudoH/ZRFQo3U/d1JUp5zjYwGg0UYE7STCwete
LPVxelc2w3nAZIIiPh3pO1askMIzfqseIm2c5ZcUQTtq/2pwNDlc6p61wNZg4FJf
/2KQywVkotdtkAR8JZPBiZ9iixi/OfDR7InPwWkSxYwNRVHRp0OcVgg5xqwnkHtL
2Xx+13ZaMF97J/32Rptqbkn4VYD/c++MCHh7vSvlBWqPfa+SS36g+0IAaZAAw7wh
/OOQksHC/Wbh1QhK8wQIGX3aw5P/hJD7pmuD5ocZ7U8QOn7jjRHR6+QVDkaQzvkY
Ln1zhQRvTGVkuel08IOsWxLHACxGAS2dEhWjt14wM3dfQ4GeiaP+zNN0uvWNgN6O
Q8y5PZQjhW79bjwBmGu7UvgXYYYEekj2ilAHOL5MAeRbm22tamESuZl/LhELevHt
iPMtCM4VqTtB+JkoUoeVo9u+RK8sZ0f6EFqVezIYOttU9VOHUpUD3OEgL7GWWtXl
aBW1gvRht4MlWOiYdtbxdVICbY+K7RX5uyGBgdUo2QG8C0I5AlEN7/wdviRywPaB
Jm1WMz7GE3Jt3qYlj4GlBvfimhALsdkRCdWaRPqM0ZbVnM9p6o6u1bZe5WIuR+57
mJZfRIVDQBJ+kWwZi7koBSslEcAE10hrNWDjPsI30j5LAoCreiA=
=jr4n
-----END PGP SIGNATURE-----

--IaGte/WX4+WDBcIM--
