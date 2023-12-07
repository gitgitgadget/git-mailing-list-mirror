Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pfhzJMtW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ff/RA54X"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8801713
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:10:10 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 8B46F3200A26;
	Thu,  7 Dec 2023 02:10:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 07 Dec 2023 02:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701933009; x=1702019409; bh=2M
	maP9j1ZaVjgXKFtJDBtThJyOreIueO2WAna8Z9iA0=; b=pfhzJMtWoLVaVC2O6D
	JTl2iiJKnvMPc1qn9p2rZZtH2hQ8121Ipgm3Ked752nLazChzRHW4lNYGksGl6sm
	ZN1XifvWNu5PWVG05W5AwCljhzijxu3VSXdX59Tz4W4bKwMLFgW2hmrJ3qS30k5A
	iRcfl5T1JBeAczsEerkTRtUBvw0GD2dq6sPOUd7ajXNkRPLEn5IAk1xSvo6oLr0H
	MikkvzZ3WZEVhtz40kofy3f5SFFKJjUa7Ww/u65vMSx5JloSPjPUKfY+Q5ODxXIa
	lFwie8upnReoSui3S/9w3P/kFgAiYCl1ncqC9OSPRkmWKVaPFPvayHz6pRL/yTNz
	iR/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701933009; x=1702019409; bh=2MmaP9j1ZaVjg
	XKFtJDBtThJyOreIueO2WAna8Z9iA0=; b=ff/RA54Xbl8B5pOpVJllI55jNlJ8h
	5JWinFzl11FQ4uDdsAE7kuOZ2xWeyaHtgb8ZMwgQxloOppoXvTOUPWdq2I6C+y9d
	s9El3CLq6RJ1QEZ5tRq90MfPMk0Wzy0CUr85BKToGBiIgZEi4vdjw/6PKxdPwFoF
	k//iFR1mC8wRlcQKvpzUIDbQbyGxR4bN3cP8gIbeI9OuKXHwuIl5LyAqiA5Xkc9H
	n8DxD6flm/8lkdbSxW1U05ZYusGcBzy7AmpXL17a8bfMJr9Z4x/IEWuYAfyylEC/
	VHOafEwsIxTla6YFWO1j+EWjmYSM+lghLw37PpMv5bJvDXbK8Z+2M9UZw==
X-ME-Sender: <xms:0G9xZWaIL-DXSz-RnyKwddQC9vyOHvWoPnSCTURFnHPmJqRLEdI5pw>
    <xme:0G9xZZbTxqJZMSP5fF9nRLx24tKU-LzTjq79mFcS2_bfwZsUuu2eRZkuBvH_8bTHi
    t8SuJkuFDnxnEzomg>
X-ME-Received: <xmr:0G9xZQ8zaQqbPmbAqq9OVh4ETriLd3ij3OQ5uysHdQyNg_8IwzX1TleaE_E3Z6NuHHhaB75P7XsKME-NsbLVs7wtpQM1MgUtcXeM1Y1QBW7AGtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepfedvleefueetgeeitdekheelffekke
    fgffduhfduvdefffdtheekiefhkeejkeehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:0G9xZYqjYUvuzCT0IfsWg6Wd9bxRUqxBTRGRDVLJyoii8MkM2bLa2w>
    <xmx:0G9xZRpi_Hx5GpMc3s6lvip6UtjcuAUa-6o-9-JbqDKCL8ExXlHZ_g>
    <xmx:0G9xZWS9d3S9VHmJKKl7-LkUcJtvAuAVreZVuC_1xc1tphlGC1S3jA>
    <xmx:0W9xZSDWcdCYLKCP8SSWGRu34SgHwVGUhPUfw1vGf_YwKZXzeCQbvQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 02:10:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a88eba26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 07:08:38 +0000 (UTC)
Date: Thu, 7 Dec 2023 08:10:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 4/7] revision, rev-parse: factorize incompatibility
 messages about --exclude-hidden
Message-ID: <ZXFvzAb93otxIPjs@tanuki>
References: <20231206115215.94467-1-l.s.r@web.de>
 <20231206115215.94467-5-l.s.r@web.de>
 <ZXByOXWo6cIy71s2@tanuki>
 <389cd7b3-2350-4dc6-b282-e9d6e25fa68c@web.de>
 <ZXCHj3hIpQb900WX@tanuki>
 <4954cf77-63f6-4225-833f-3c28d642ed11@web.de>
 <ZXDKjdOiIdHipaKy@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lpZeTdeNLbTYFVU9"
Content-Disposition: inline
In-Reply-To: <ZXDKjdOiIdHipaKy@nand.local>


--lpZeTdeNLbTYFVU9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 02:25:01PM -0500, Taylor Blau wrote:
> On Wed, Dec 06, 2023 at 06:07:29PM +0100, Ren=E9 Scharfe wrote:
> > > It's not perfect
> > > of course, but would at least ensure that we can easily convert things
> > > over time without having to duplicate the exact message everywhere.
> >
> > Maybe the simplest option would be to use a macro, e.g.
> >
> >    #define INCOMPATIBLE_OPTIONS_MESSAGE \
> >            _("options '%s' and '%s' cannot be used together")
> >
> > It could be used with both error() and die(), and the compiler would
> > still ensure that two strings are passed along with it, but I don't know
> > how to encode that requirement in the macro name somehow to make it
> > self-documenting.  Perhaps by getting the number two in there?
>=20
> I think that this is a great idea. It nicely solves Patrick's concern
> that we have to duplicate this message ID everywhere, and equally solves
> yours by calling error() inline instead of having to pass down the
> option values.
>=20
> I think that including a number in the macro name would be helpful here.

Does our i18n tooling know how to extract such messages defined in
macros? I have to admit I don't really know how it works under the hood.
But if it does work then this looks like a good solution to me.

Patrick

--lpZeTdeNLbTYFVU9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxb8sACgkQVbJhu7ck
PpTbsw/+LAjfQDmHNgEnbwuVOAi0oLcF4B6uhlvHN1bTBgpPC12JlGTqhLjV8lDh
4w8EZXYZQniQ+5689vAltK0VoejvtZB8g3dxyY3Ts66zWBegX88/5OCw477X1UwM
pVFxFgZ6oKwpvUrEMx1oy8+qcaEB2foX5H/3dHm7Q4FxfU/7+aybPg/HuKmsTBEt
7mCMT1WSBhGNbYp5mMCtKiQtIsVCpkJVq6cEJV/HShU7VZAcjNl6Kjgm70utI+kO
+KNfaf56m5auIUIfda8TVlVwA9CK86+vTiJxkuZ5i4taTa/JcZKVBPEevtG+RADK
RZ8cORhpz/B5tFKi9Hl1pMpCgPRrtiAdcU6QzrRie7K8NxmE+bHHsd4Wu3l9luDW
r/3C4nJh4pKt2+X9ZbMN9rP9rjaUMGnyD58Xjcy6YCQgVS5hYPlJlXZ/WPx96UDj
Cec69nSfmYD2Z/2a20U9ZppnXqs/uZ+CgM8omf9rjlMtOaYbNQREF+rz2r4I4ktc
7Gd0nNHpbDj5dE1C58h4dzSF6MvY916sgaWDkrJTKsNtphpMkpZQF6M4aroJyZ4z
2K0DwEtQBAK3ey9mHTrbeDhCKijmTSkdWpvXbjY6IBZGgdgm5L3LTgzRnZrXgfEp
s8BYOCl6DOG0y5ox4WRDQlQhlZ9J9CnuGRAXETd0qcAJY/qSBxk=
=fijw
-----END PGP SIGNATURE-----

--lpZeTdeNLbTYFVU9--
