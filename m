Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027854D5BC
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FfweiC71";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KYtQnI8d"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id C04E73200A40;
	Thu, 21 Dec 2023 05:45:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 21 Dec 2023 05:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703155524; x=1703241924; bh=zvJgNsLM8S
	N+YRVLL9+lpb37i5UTfzM77AijgNyPRp0=; b=FfweiC71HfMhj4ATh4lQMLifeF
	H+E3zuA7eQBsji2Whc5Z/xTo9scCmhTFQvajnZnY7NV0MDQ+CHEdfIyYDZcVeKF+
	yUnrPauI67U6Eurr+x0yzJnaeVYwMO0JLf38tGT2I0Hvu2jDEhBrpnkKNnQQlCll
	Yfwv9fEXnGA4GavYWP9ADkhTQZYusLJ9kAntKj7uAAclfEo8mQT6gJTc7Q0kNWts
	hN0zCVC97MzTlScxDIXjh6nT2vSzvAOtDhhca3xF/QHpawlHRFQDefomJDUqyA0c
	vidtzRvaCjeF0DEYUqefWQv4q9rK8f0zvTuK+L4Ar/rpQeibZeGmkfxwAocQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703155524; x=1703241924; bh=zvJgNsLM8SN+YRVLL9+lpb37i5UT
	fzM77AijgNyPRp0=; b=KYtQnI8deUBu0dcLVi+RUn72vlsIia13WcU+RhCOigiY
	TXZy29hrvxXwEYeYm2PIk0BuZKKamskhPYMEx5u8a0JDuVhRtI04Aw90+O3Uo1dQ
	ZBsdZabl/jOISc2Q8w/Dudjb5/QTqqBMZLqJfd466GLAxM+24Fa7NDuNxVUwU8iz
	R/WDmikgySOfiBD5laeMg1prip7eblIjBB9kPNXkH17rhDu7ZQP318qWm4cuX/yd
	N+rRZdDfhGtwUnqfMbKcCGToEmHZWFKUgqOniEWB4A2ktmTDX/Tck3x7R7Bz4B/z
	egS3ktEcYqE31NNWTCn3G+9INDBHO7Biwfx/dc/sMQ==
X-ME-Sender: <xms:RBeEZUpCoBhMsjHuPzXQ1jbNY9wJ7-9hzQDMpeXuZy9va3pcjj_9XQ>
    <xme:RBeEZarR-Af9CCFImlaCI7CBwh3h5LprQQaQ_cmy82I0U95bbwysjrtjGnOtokBdo
    pRqaId8KFJYjPXx9Q>
X-ME-Received: <xmr:RBeEZZNZaJ3X1QMz4OLHoOu_Ka89OPJ-NoWNILdhb5-0lUDJlt0XVDpm3MstKBdXBAdMYtGlM9pfsWSYJ33BKJG-vFM1uG-NVLylZLnbdHhBow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddugedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptefgkedthedvkeejtedttdehgeefheehtefgudetheduudefkefgtdfggeejgedt
    necuffhomhgrihhnpehpuhgslhhitgdqihhnsghogidrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:RBeEZb6hTxissQzCCRZpgv3RP48Yde3CsSteb9A777VRUmdLDXu3kA>
    <xmx:RBeEZT5WpAC4aCq663fPlvgV2XYkTyMd0gTnj_9Ihk1V-pFDEg6Mpg>
    <xmx:RBeEZbgIg7HrUbIL7D5yXX3EvX1wiSz2P1_AJfgeIJjlIDLRWdfzgQ>
    <xmx:RBeEZTGtgNxPKBWQSJvgdwx08vkJiN0EwvjOt6nlFxUvPM5acTkgEA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 05:45:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b021a13b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Dec 2023 10:43:24 +0000 (UTC)
Date: Thu, 21 Dec 2023 11:45:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	psteinhardt@gitlab.com
Subject: Re: [PATCH 5/8] reftable/stack: perform auto-compaction with
 transactional interface
Message-ID: <ZYQXP6xPiZbM2aOf@framework>
References: <cover.1700549493.git.ps@pks.im>
 <25522b042cdc5986972cc7b62e6b88be0569d3cb.1700549493.git.ps@pks.im>
 <CAOw_e7Yfdt_Wqm-9XDJknaN-iH=haP0R4K-S4c_E3EFDzvG5aA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iZ4bOytCvuLY2pH7"
Content-Disposition: inline
In-Reply-To: <CAOw_e7Yfdt_Wqm-9XDJknaN-iH=haP0R4K-S4c_E3EFDzvG5aA@mail.gmail.com>


--iZ4bOytCvuLY2pH7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 11:29:52AM +0100, Han-Wen Nienhuys wrote:
> On Tue, Nov 21, 2023 at 8:07=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > Whenever updating references or reflog entries in the reftable stack, we
> > need to add a new table to the stack, thus growing the stack's length by
> ..
>=20
> bug is correctly identified, but can't the fix remove the
>=20
>          if (!st->disable_auto_compact)
>                 return reftable_stack_auto_compact(st);
>=20
> fragment from reftable_stack_add? reftable_addition_commit eventually
> calls reftable_addition_commit.

"calls reftable_stack_add" you probably mean here. But yes, you're
right. As this patch series has already been merged to `next` I can roll
this cleanup into my second patch series that addresses issues with the
reftable library [1]. Does that work for you?

[1]: http://public-inbox.org/git/xmqqr0jgsn9g.fsf@gitster.g/T/#t

Patrick

--iZ4bOytCvuLY2pH7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWEFz4ACgkQVbJhu7ck
PpQsBhAAj9brNP+uO5Eq37Qu1UIZr7dl3ZC8S8IwO4YCdorW49uuV8vfOYERRX17
2kbdj9LvlZJpb11Z+qogrup2GrYqq9bj4GwsrnTuHVqrovdlCI9O3B4zwe3y9KO0
M0exekueX4EyNUyYe3yy8iTw0JsazBKwrag9bSmuYlE/jiGHJkCPiDH14QfA0pEi
xaaXHIHOIqUKIEXlCGOH1YpAnmXpbmB1QFfjiDBbo1UXbsio6K+OhV4zJxeCJc7r
2XB+VviE4pRhhU2lYlXIEW45oS28WZ4Z3+QbILqVYioY2nSaYO8vvCG02qYovXtG
xh80p0H0DzjHUK8MXcB47jHStyZ2ucljCSU6+r/C/g+yMfNa15T+PWyp85MBAd4t
Q3HEz3VKsMSbqqdx6SlmJCjQLR3dGAxMdK91X8Pza0DVo47snCAIxtwhBGXET5XC
e8Srf2MbOdW81kMgCxGtnHaRo1/+qYqJPhdzbXsMpUIvcWebWx1D0ekuQdVUTknb
oqBKKPbk1TTyP668Y4lZY2pqqQDIzip1/v63B3d1opaEaVp9LrN6Cgn3JZU3wwZP
2nAmmJMu/hleW2lTczP1ORdH1pY3eHYvjG73Ah/91xb/PVpppVVZh+mfNvxW1Am3
rmPAVqOiuZ/TcstRtW2AbK9lZ+cuaz16v7GFd2XYXj42Ke41pEA=
=T2j4
-----END PGP SIGNATURE-----

--iZ4bOytCvuLY2pH7--
