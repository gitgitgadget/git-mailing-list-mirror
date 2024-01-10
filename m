Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B94C3A8DF
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L7o7jxdE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQtidYhg"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 7A28F3200B33;
	Wed, 10 Jan 2024 02:30:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 10 Jan 2024 02:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704871857; x=1704958257; bh=70QM1Bk3o3
	dsydZZFjK8IgJJwvslTjYPG0oyOFR/gm8=; b=L7o7jxdEM+57y8YRfTdkRkfxK2
	IIhk9oY85bwOh8xYAA0M7STCLv1jFOWAvBq/87MKJh03dMko8illt+bX2AOJ2oKc
	4A+aWAXaLT90Npq+xeN0qPeWoE0qVjDmG7C52nbs7SqAYvqHAopAUeVkTwRrXIXf
	/ypkjrPypnq9kmuQJCPVYnpnEHANsh0ZxJMSZP9AB+UcuzlksctB+z+HQlbjHXzO
	19ev0/V4SihhnubIHnZEX2Dgmktxr+Dzsj6VZ6jceizZsZ11VHtCGS+3CWyfZvun
	CBEnozPL2kkgsEfR+GT5wteY6p5f0H8yxn8SU2vDNESTHbZQhdK4oC65SUcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704871857; x=1704958257; bh=70QM1Bk3o3dsydZZFjK8IgJJwvsl
	TjYPG0oyOFR/gm8=; b=aQtidYhgf1SbP4nRniJ+hftIR+cjEdb66DPZQe+wOf63
	trdqV/KIFuT3rEJCwkGWJGtvhkbSi7F+aLsKQjMrQLCEhXj9QtcGZkqed7PfteKv
	ovn8Vn2sRS/DsJCeDIG02PZpn+ia/U68PS0lzc5ksfiZ7JUcZePT+vdB4cZ2XgV6
	/3+zL4h76LQ/juJbqF6H73hcqhU66fok1HNFj6QittcsJ7coNLEn2JRDs1QWgjst
	Po7BxWN86S8UQNgtibptphPIGRkU60mIaX7x9ieZJ/Q0Yawp3C3WU/dGOLKUfkfR
	enn8/MD6QXoilKP2zPZ4DdCkv4lBSwWNRnkC63uH+w==
X-ME-Sender: <xms:sUeeZZX0GydugE-4cXKc0f4cY_tFd8yCaMH0ndNFhb068axXS11e0w>
    <xme:sUeeZZkd97vSmZqMEJX6-chjO_8O-e2jVkGoPAmERwMgZ3GoLOqdmYJuOwvhYqEev
    JbmmezM75WHil_gWQ>
X-ME-Received: <xmr:sUeeZVZoO_sX6aaTRJgGRszmF6lnyZXLDMX1Un88K8vPrzYEVbac_j2D5gnncL87N38cHpRoa69WYSwpKfg4-ywsaTUgdKW2N-B1-zwB2t58MPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:sUeeZcUcNGDn_gspdbmrENpZ9ygZ7jzPAodXkQERsQ4yBttoqXrv1g>
    <xmx:sUeeZTkC6V900DRZKnMJk9Hl_cP1M0F6HeeLQToVu9-K_RXz1SeS8Q>
    <xmx:sUeeZZfEpym1xt2litc6lb82Ww_VB_U9HRjgH3KDb6InJ6LMJXO-WQ>
    <xmx:sUeeZSv6MO9RacpeObfEORB2B0rsivvon9zfqW29aWVAWCuMQndyXA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 02:30:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 400d3507 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jan 2024 07:28:15 +0000 (UTC)
Date: Wed, 10 Jan 2024 08:30:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] t1419: mark test suite as files-backend specific
Message-ID: <ZZ5HrY76O1x8QABG@tanuki>
References: <cover.1704802213.git.ps@pks.im>
 <d7c6b8b2a7b3b4d776f06ce577bdbdbaff66f225.1704802213.git.ps@pks.im>
 <CAPig+cTAiEFu9p1nRe9LC3mxyPmfQ9m4r7aQUj_9OC8pSbwbig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+xjZIQAz6HwbZ5kD"
Content-Disposition: inline
In-Reply-To: <CAPig+cTAiEFu9p1nRe9LC3mxyPmfQ9m4r7aQUj_9OC8pSbwbig@mail.gmail.com>


--+xjZIQAz6HwbZ5kD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 02:40:50PM -0500, Eric Sunshine wrote:
> On Tue, Jan 9, 2024 at 7:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > With 59c35fac54 (refs/packed-backend.c: implement jump lists to avoid
> > excluded pattern(s), 2023-07-10) we have implemented logic to handle
> > excluded refs more efficiently in the "packed" ref backend. This logic
> > allows us to skip emitting refs completely which we know to not be of
> > any interest to the caller, which can avoid quite some allocaitons and
> > object lookups.
>=20
> s/allocaitons/allocations/
>=20
> > This was wired up via a new `exclude_patterns` parameter passed to the
> > backend's ref iterator. The backend only needs to handle them on a best
> > effort basis though, and in fact we only handle it for the "packed-refs"
> > file, but not for loose references. Consequentially, all callers must
> > still filter emitted refs with those exclude patterns.
>=20
> s/Consequentially/Consequently/

Hum. I had the last time when you mentioned the in mind while writing
the commit message, but seemingly misremembered the outcome. So I now
looked things up in a dictionary, and both words seem to be used in
equivalent ways. As a non-native speaker, could you maybe elaborate a
bit to help me out? :)

> > The result is that handling exclude patterns is completely optional in
> > the ref backend, and any future backends may or may not implement it.
> > Let's thus mark the test for t1419 to depend on the REFFILES prereq.
>=20
> This change seems to be abusing the meaning of the REFFILES
> prerequisite. Instead the above description argues for introduction of
> a new prerequisite which indicates whether or not the backend honors
> the exclude patterns. Or, am I misunderstanding this?

I wouldn't say that this is abuse. We know the logic is only implemented
by certain backends, and for the time being the only backend that does
is the "files" backend. Furthermore, no test outside of t1419 ever cares
for whether the backend knows to handle exclude patterns, so introducing
a separate prereq that simply maps to REFFILES doesn't really feel worth
it. If we ever implement this behaviour in the "reftable" backend, then
we can easily extend the prereq like follows:

```
if ! test_have_prereq REFFILES && ! test_have_prereq REFTABLE
then
       skip_all=3D'skipping `git for-each-ref --exclude` tests; need files =
backend'
       test_done
fi
```

Now we could of course make the prereq clever and auto-detect whether
the ref backend supports excludes. But this has the downside that it
could lead to silent failures in case the exclude pattern handling ever
breaks because now the prereq would potentially evaluate to "false".

Patrick

--+xjZIQAz6HwbZ5kD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWeR6wACgkQVbJhu7ck
PpS4mg//erOJpwJdJt+HpeIeIj7W+9vrOJx43hAf2m2jlJhrGPjhP8t6ao+Ylw66
tFw3nqOO7J6PmH6cMXeaQAD1Q9ebsj4Po04whqK3o+lmni+W6LJqezoh7fyuUR2u
YO2kU/p25F3pH/mEBU4u6oDrDPTYegY9tZ4F2oHEVHoA2K0asiu4AGq2dqBXpOa0
X0leRP21DqSyqENUXdMJR+5FW1KM32ZwK82eug0+DHW2OQm1vymMaV47pg+tItL5
UXe5cwRwE0QzXHiHOd1U7HZRyLSs8kWlpiQhhXOaEUCLFKk2u53NeWw/Q4SSYzwv
hKUjZiczPz2yCJgKTCDMcZd4FVN3ZCaoHn/cjkkZ0BUnfvVT34XD9NavBsbecyNs
0JUruvjiIES2Y1ddrF5w6lUGlH1iBo7oLnN7mHaoKVdfLT0EYo4FX6aI99Q3b+31
TyuptWGhSSBccCLSyX3yhe6uZsUqBc4YP3angbk2n+LSehiLMkSj2IIvEXKTLuKX
KExNRc4NXQ+O4F4Bj2aEEB7uouWQ7WKRCSXTyRb7Vw6CBy/430U+cw80n9jkcXN4
atb7xMc5YXoR68BWeXcf6zhfVCkmBSxvJQtX9nvB6vCjTUa1zsKRGfObL8HGtktZ
UOaKmyT/cIqH+Ax7avaQjzDKcIKAeCcNpT0nRartr8jZ3cB6ygs=
=zziG
-----END PGP SIGNATURE-----

--+xjZIQAz6HwbZ5kD--
