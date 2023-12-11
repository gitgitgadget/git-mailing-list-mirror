Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BDmC8J4Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BF5H6s9s"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01321BE
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 03:34:53 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 472643200C19;
	Mon, 11 Dec 2023 06:34:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 11 Dec 2023 06:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702294491; x=1702380891; bh=io
	vw0downmEm/jrfgzDB9sg8b2GdU0puIdABFUsHpUw=; b=BDmC8J4QhszkWr0lHP
	qVRNU8Xest9k1RIqOPxms1BTo1rT1A3GPqwOu6zFu63IR99HJ/iAmfBwda2k3qun
	WfRZgxFk250lBIMIet4YVDx2MsR2Sq9sZT4Pi6K+f8YiStGDQqTxuIWM1m8tHoql
	Hd2crUC495da+ub8VBoQghZGP9MfW8Kf/aslm4sGK9sUPxnsfj6cqyXoBsq3t6j1
	J5P2qISO3O6rYaf8Lpl1zGGtTn/hOGHoLmOOwX2W875ejZxH7IyUi9hwnJg9MtIJ
	uB707DJdbest8V0TYl9affGMPO0px4NjIgE7hwFGuehS3walAU6zoHHDwsGv+Oed
	KWTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702294491; x=1702380891; bh=iovw0downmEm/
	jrfgzDB9sg8b2GdU0puIdABFUsHpUw=; b=BF5H6s9snsoUw8XB67+EOAFZTcaq4
	O2QuFt5FlfhkblG2sAZwotgSTJ1B7eH7xmsj6eUzDQ8B5cLHcKmJJPOrvlnIYZR/
	nD6NzEzDSCuS39CGLrGgeqT/D5JLMluBWM6/ZZv2M9e1qEMkbZT3i7RWIUFHEsEx
	jqCZngOmOjzjsGAhcoQnIJoMX4e2M5ht2eS+unKv4sJRGJm9FIlwGqoF1Jw0ICyu
	RWO3zcrdMRxMj5s7zjAlZNaX+EXQvTT0xiO7Tk/1SdVbxx42LhpKbOcJig9vjxHu
	mjiovDZcu6oJSmmojcL6Dj9x3Qd/dsob4b5nYoQTUWEzCLXJEXnzFLfyw==
X-ME-Sender: <xms:2_N2ZYyG4SE1qTsCBYi1mB1UPQByPuZvgF5pcv7YLhaTXCx0OwmlRQ>
    <xme:2_N2ZcQt7sRb9MYLiEeEeFHuFPW2zFnzKSOLYXowWhOGOvEUNnB9f7i6TPLx_vpT2
    8jfgC6FBcEpNW3ysw>
X-ME-Received: <xmr:2_N2ZaXsl_Y-qBFuMryqDFUj89GNW2lkj0KwKjP-XviTEkLHIw8d9-g5CE6pf9G3Ogy3ZhF68mYVMGebdVSd8RxMSZKS3yqQ17XVPbSXZHG-VA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:2_N2ZWhsSwBlJG0djiv4D8yvnYev8T7nooBFZ3TQZcTxzWnvjEclrg>
    <xmx:2_N2ZaBcpj80zYuuUnEttw0JsbL_Zkf0ZxncuaJi7jo1Zazby7FCWw>
    <xmx:2_N2ZXLMczW4Kq6yV05pF9hQgh5S3WQwmpvqkM9KzYI04j8vpZoO0Q>
    <xmx:2_N2Zb6cbEATwzrz659w1Fn3p2zOfMC6H7H8f3axzbsrEo00fRPfQw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 06:34:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b90f186f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 11:33:14 +0000 (UTC)
Date: Mon, 11 Dec 2023 12:34:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/7] setup: extract function to create the refdb
Message-ID: <ZXbz2eQoz0ReP_IF@tanuki>
References: <cover.1701863960.git.ps@pks.im>
 <b69c57d27269c9b40c9e4394861dffd8a8b9860c.1701863960.git.ps@pks.im>
 <CAOLa=ZSZztJUF9nmSzGdOW0oWBRUp2sw8QyuZO_q06cNymad3Q@mail.gmail.com>
 <ZXFy0_T1AZLh058g@tanuki>
 <xmqq1qbw1f0j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nRm7xGFL+4DlT/dR"
Content-Disposition: inline
In-Reply-To: <xmqq1qbw1f0j.fsf@gitster.g>


--nRm7xGFL+4DlT/dR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2023 at 07:54:52AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > On Wed, Dec 06, 2023 at 10:10:37PM +0100, Karthik Nayak wrote:
> >> On Wed, Dec 6, 2023 at 1:40=E2=80=AFPM Patrick Steinhardt <ps@pks.im> =
wrote:
> >> > +static void create_reference_database(const char *initial_branch, i=
nt quiet)
> >> > +{
> >> > +       struct strbuf err =3D STRBUF_INIT;
> >> > +       int reinit =3D is_reinit();
> >> > +
> >> > +       /*
> >> > +        * We need to create a "refs" dir in any case so that older
> >> > +        * versions of git can tell that this is a repository.
> >> > +        */
> >>=20
> >> How does this work though, even if an earlier version of git can tell
> >> that this is a repository, it still won't be able to read the reftable
> >> backend. In that sense, what do we achieve here?
> >
> > This is a good question, and there is related ongoing discussion about
> > this topic in the thread starting at [1]. There are a few benefits to
> > letting clients discover such repos even if they don't understand the
> > new reference backend format:
> >
> >   - They know to stop walking up the parent-directory chain. Otherwise a
> >     client might end up detecting a Git repository in the parent dir.
> >
> >   - The user gets a proper error message why the repository cannot be
> >     accessed. Instead of failing to detect the repository altogether we
> >     instead say that we don't understand the "extensions.refFormat"
> >     extension.
>=20
> Yup, both are very good reasons.  Would it help to sneak a condensed
> version of it in the in-code comment, perhaps?

Sure, let's do so. I failed to condense this meaningfully, but hope that
the result will be okay regardless of that.

Patrick

--nRm7xGFL+4DlT/dR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV289gACgkQVbJhu7ck
PpRy1BAAnJH4bUEsTCHK6wkxeDMQjWqGlNJzboUUM4h14imgFko2YqDEaJaeeN7P
+HZflLlJfEuVtuaEk7cI9BV31uWLlhIZ7DcKpX8g2cqcCkmSeHuAbk1QxaZqAVeG
XV+aW0RObJ7RXP+nq84jKYNyHrvWkQ1nfUt+5xu6lYa5ystEFdI/Hnsbdl1hOeck
5ilNKwMyn/kNeTQ31nkIhc48Vztkkc5hxVHffkUQirSfgZ35gVIpUiY6K+ByEtja
Xh6CuDZ+5is2tDPBqxg94NbSUSiELMGo+311oF0D9eiHPBsage6dk2tJePsb4Hgf
j+TSmCnJJ8Zntx9rv2plL3sogX8HwJ+6vhlOh/s1y3hvkT0mynOac2jIwqusvmxd
7Ks0oHQYqNq7LaWV65akCmXJUU+GryTCFr6pTwKsBHthMT0bp/SxEnB80lC0Ynjp
bKw3/tFC1A2VTZJ+WEDlwjHgqLmHi8kaB8fahJAs/6HvKZhPPazlBq0UAK72dexs
uq6K0omvqqo9ikwJjLnjvX/n4T0KOQq23pz6THq3mPC0Ka+gwJLAfz9jomiBlIXC
PPfNyhAPemahr22hLrdStoXeKSm1eBs9fZdGoLkStrhEsCfT9ejuiLqTkjICCi7S
LZUxzbr6sMm9X/3DOevNXQICWGqA+5AmLSv46e/50oZdP+4KAt8=
=061C
-----END PGP SIGNATURE-----

--nRm7xGFL+4DlT/dR--
