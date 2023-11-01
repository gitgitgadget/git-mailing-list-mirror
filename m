Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D41171F
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="exetaaEg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h1NC/nQQ"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CFF119
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 04:44:39 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id AAF455C04F2;
	Wed,  1 Nov 2023 07:44:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 01 Nov 2023 07:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698839078; x=1698925478; bh=7t
	Ih+pjD0YtxZJCGVsZbP06Op+V7m8+8rwqBaa968To=; b=exetaaEg9/wVVaV/xD
	wAYR8VESjG2d3n8QmBx6bRq5aDBITJ+iIAoa9jpSRXP221MNW1MQi/f4lynNp82b
	o4pF0fbjIF2/P3rwlCn1JLic9EcMO24R/1zRyuPV87AprmtfsqweudaaWECjpcwa
	Y/MnoL9n3gfgGZ9afzZ9qPaMH7aB7T7MUleOW5zadhrxJGpuGLNdJTaDz2JRHn65
	34oxedp7ICemKs0XHsTdJE9FrxujMdH1MabIhGVZswwVPhcQSaHamvTomVp66J5+
	eUtxtIuT9GVAwUC/SjbCA0R76B+lXpjjXCeWGKgH61PSmCkCAHqnzrxa7SUosm8a
	iWSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698839078; x=1698925478; bh=7tIh+pjD0YtxZ
	JCGVsZbP06Op+V7m8+8rwqBaa968To=; b=h1NC/nQQXkt/CZgGWhWwBZp2pfbJ8
	lA5VabjdNeV/Ldn/OPxrBr7JOTWH7vxmpDY4aAATV1My2xO20lUY4W54WUKSGJsS
	vvqxbgCE9zj8GO4qcrjJ3GIq+zYveCSbj9vbZcUH0kQEp2gd9zBFbHL5Lwc0lyfO
	zpBRTziIT3qIwDTBHuQUlO++8ISVl6P4fMZq4NTlMLRYYKhNdYAXmDTEm0wDJsor
	lJFRw+NBlK8dHpNVYB5OJTOC0zyURHZ/8fsrLmtRaubhx8mbozmbO7CRVG2r+cIK
	hP19Wnp9vXgtCcTAh12uf2wcqO8dzk5DqDNZVd+tu7MLdeUjBVVadsg5g==
X-ME-Sender: <xms:JjpCZW0jQuHZybJvHeljVwbduLuFICKiCrAOlxnj_1_yRGxceYlcHQ>
    <xme:JjpCZZEfb8vOqjb-nuIVoTiDeZ8U9bOqNwIDmF_w__GhM5AYnMobhI9-nY_OFpDFX
    9dmwUDUEbpiFc8-OA>
X-ME-Received: <xmr:JjpCZe4OuUM8vCVE9-ktPf11qaIakKLuD-qhysJCkM2a4LMchO7cbHN0j4W2P49Kl-mCK8Rz-VB0CfY5sUJzve854HUIiRqPNqa1uDm1XeGk7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:JjpCZX2bgIWKbUMxrNruqiCwi504VTRgikR6nrRY_jFvSRYKyqrbtA>
    <xmx:JjpCZZFG9FysySA3XDpUmJEmGt3nODoswDmoEvNM8gRaqWF8sgUllg>
    <xmx:JjpCZQ_u-ldPv8MrdeHuaLTm7lzrJxPA01J3XZBCPrGtM71apxOCqw>
    <xmx:JjpCZdiqn36QAhq2KANGntmRcVAQnn8aqUVivJuDdZRuCKN4rKoJKQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 07:44:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cf4f7000 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Nov 2023 11:44:26 +0000 (UTC)
Date: Wed, 1 Nov 2023 12:44:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye <vdye@github.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v4 5/8] ci: unify setup of some environment variables
Message-ID: <ZUI6I8_r7Lff0ruj@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698742590.git.ps@pks.im>
 <a64799b6e25d05e5d5fc7fe3c5602b5ce256d8b9.1698742590.git.ps@pks.im>
 <31ebe4c9-84aa-4d42-9aeb-712e2a6cece3@github.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fKP/fhvoLKlIPbLc"
Content-Disposition: inline
In-Reply-To: <31ebe4c9-84aa-4d42-9aeb-712e2a6cece3@github.com>


--fKP/fhvoLKlIPbLc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 10:06:24AM -0700, Victoria Dye wrote:
> Patrick Steinhardt wrote:
> > Both GitHub Actions and Azue Pipelines set up the environment variables
>=20
> s/Azue/Azure
>=20
> > GIT_TEST_OPTS, GIT_PROVE_OPTS and MAKEFLAGS. And while most values are
> > actually the same, the setup is completely duplicate. With the upcoming
> > support for GitLab CI this duplication would only extend even further.
> >=20
> > Unify the setup of those environment variables so that only the uncommon
> > parts are separated. While at it, we also perform some additional small
> > improvements:
> >=20
> >     - We now always pass `--state=3Dfailed,slow,save` via GIT_PROVE_OPT=
S.
> >       It doesn't hurt on platforms where we don't persist the state, so
> >       this further reduces boilerplate.
> >=20
> >     - When running on Windows systems we set `--no-chain-lint` and
> >       `--no-bin-wrappers`. Interestingly though, we did so _after_
> >       already having exported the respective environment variables.
> >=20
> >     - We stop using `export VAR=3Dvalue` syntax, which is a Bashism. It=
's
> >       not quite worth it as we still use this syntax all over the place,
> >       but it doesn't hurt readability either.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  ci/lib.sh | 24 ++++++++++++++----------
> >  1 file changed, 14 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index 9ffdf743903..9a9b92c05b3 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -175,11 +175,7 @@ then
> >  	# among *all* phases)
> >  	cache_dir=3D"$HOME/test-cache/$SYSTEM_PHASENAME"
> > =20
> > -	export GIT_PROVE_OPTS=3D"--timer --jobs 10 --state=3Dfailed,slow,save"
> > -	export GIT_TEST_OPTS=3D"--verbose-log -x --write-junit-xml"
> > -	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
> > -	test windows_nt !=3D "$CI_OS_NAME" ||
> > -	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
> > +	GIT_TEST_OPTS=3D"--write-junit-xml"
> >  elif test true =3D "$GITHUB_ACTIONS"
> >  then
> >  	CI_TYPE=3Dgithub-actions
> > @@ -198,17 +194,25 @@ then
> > =20
> >  	cache_dir=3D"$HOME/none"
> > =20
> > -	export GIT_PROVE_OPTS=3D"--timer --jobs 10"
> > -	export GIT_TEST_OPTS=3D"--verbose-log -x --github-workflow-markup"
> > -	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
> > -	test windows !=3D "$CI_OS_NAME" ||
> > -	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
> > +	GIT_TEST_OPTS=3D"--github-workflow-markup"
> >  else
> >  	echo "Could not identify CI type" >&2
> >  	env >&2
> >  	exit 1
> >  fi
> > =20
> > +MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
> > +GIT_PROVE_OPTS=3D"--timer --jobs 10 --state=3Dfailed,slow,save"
> > +
> > +GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --verbose-log -x"
> > +if test windows =3D "$CI_OS_NAME"
>=20
> Based on the deleted lines above, I think this would need to be:
>=20
> 	if test windows =3D "$CI_OS_NAME" || test windows_nt =3D "$CI_OS_NAME"
>=20
> I believe these settings are required on all Windows builds, though, so y=
ou could=20
> instead match on the first 7 characters of $CI_OS_NAME:
>=20
> 	if test windows =3D "$(echo "$CI_OS_NAME" | cut -c1-7)"
>=20
> (full disclosure: I'm not 100% confident in the correctness of that shell=
 syntax)

Oh, right. I didn't notice the slight difference between "windows" and
"windows_nt". Thanks!

Patrick

> > +then
> > +	GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --no-chain-lint --no-bin-wrappers"
> > +fi
> > +
> > +export GIT_TEST_OPTS
> > +export GIT_PROVE_OPTS
> > +
> >  good_trees_file=3D"$cache_dir/good-trees"
> > =20
> >  mkdir -p "$cache_dir"
>=20

--fKP/fhvoLKlIPbLc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVCOiIACgkQVbJhu7ck
PpTvlw//aacjAmQthQFl5LABDXwYcPcu1v3RBJ3Es6+Ylwd2hJ5ZJujWwfdtzMR+
BtchdDZTuT/0ejSg/xG2cG+Vwxkejr9ZS9v8b9kJpfYqmBOYj9FuaQOilAq133zL
ENwUWY+BeJddmDVamZwYsJ4HIZcqZg0Cjz/KjVKVABV/4+HxiUh9t9+Cx1jGx/Bp
XiIsZQBOfAAXepSigCEnBhRpYXffyHeWa8W5u4uebMGjBZP0RdEJ2khOf41RWMXh
mjSRCUBvxLaVeHj/52TyD63NVDVY3Y45ROdQjTokyhwC3B8kR28d8eo8XYtBau65
LoLdOcmPIkskvJG7jsWtJ8fTy8HbiKgWuX2NpESXi0ttShHcglnzV+jT8gTkczIk
fCAeNCaYUvt3HPTrUFyNDmYCiTuvBTqvBwgTwTaQqsnhnNWlwSxDd751/O58iQ+M
ZXVKa4PqppWsaeqM9im7M4m4PGbGfGniaYOM/GrU+gG20hutmANTwMtp4F4a5XKC
xfZ1BeZ7JMQtfq+n3uoKviuQRXPzGhFJVkmxg7AP2IENkdgfBXnnCsxzd+julkdz
uwpWr2LUK5Scb+pGvdfsmVTvVLHuJgwqDrRSBZNCBOypU3HkecgODA2GWV8x3Try
ZsBmO2tQSyVx+A3+6COn+qqE+akdyqzA8QspWePouVrRmmeKjgw=
=Yv7A
-----END PGP SIGNATURE-----

--fKP/fhvoLKlIPbLc--
