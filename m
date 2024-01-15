Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B480FF508
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="diia8I4y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HT4XPc/a"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 7E6EE5C0061;
	Mon, 15 Jan 2024 04:02:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Jan 2024 04:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705309376; x=1705395776; bh=4hp4C643dP
	94VL7aZ5dqhd5XRRiLv/6NUGdPWrZn64o=; b=diia8I4y4tFXanP7xuWeLKdQRm
	nF12thNPQXa7ITyc84a0K0LmomQhImfWn9zOIR4Jq0hLob2XoGBJJhxAYU4EPGbJ
	BJ6cS+e84/EtQo0lYzhM3ShPdofrFqNYbpisWP9DlRO8lhpZWj/fWfAnwtQrBhvv
	islHVJ/QUYlk39rZ3z5n5uwk8Tc/zg43rY9GHi7CZi/5dg2M3v2Y9ierZylU55dP
	Xn9g7wKZ4ZUuJbFZ9fJ2rHc3v9yzLFL1keOi1whqRGn9H9Tzl7Pj2SPmgWCXKG3K
	icZUKwDU+HCpVTACz3IYBiEhMcc31p9ufTg0+xTo4LjPMPU2I3r0iaZ8EAAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705309376; x=1705395776; bh=4hp4C643dP94VL7aZ5dqhd5XRRiL
	v/6NUGdPWrZn64o=; b=HT4XPc/aI9HOK29FBJAHqEXiI5BGcn1cCVpHT3azil9N
	yNcL/DlbOUUJ8WRKFKQNrdi40QaQsGa+l4WeBmbOd0UWtvFEcwmeHPJUeFVLJrLX
	HO8olNIzu6UYydbGw1pFjeIij43KF2LdhKZxBHxodLW1CtQVyejzkV022vl7Hwkm
	a01jZcwnSN5ouVNOy5gG/PRWEsfvpvX/xDj+wi6HAKqch0/p50oid9af7JhgbJ49
	yN5FErjJgLKIR3cYUAk7LqzBkFRfa1fhuo5cnkSiYN6lPqYhGn0WJSb7oeMWxl2P
	83lUjPwU3QSf4S0VdULsQfMYom86Zhq6EEkTsLUATw==
X-ME-Sender: <xms:wPSkZUepVUyLKbSJmjI-y54VRH8omI_Lt3W_OTq92Ks1zXiZzxlXfQ>
    <xme:wPSkZWP5-F3ZskmgefhTDwcBk_UNrhoCc3IdpDm2qKYyxMCw_SMu2j4dCKetFQxw1
    9X5k-kzAwURiOLG-Q>
X-ME-Received: <xmr:wPSkZVh5tWsrt3PTQcDJtljLvjdzNlStb3VSUObPw7NJr2Vmw0oFK9I6q1gDI9DLdztRno6ae2XAscRjqpjADclFPtpnmV7GujZcAtJvsCD6uQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:wPSkZZ8mTVkVyFoVQJD6-evNIleLZ8LezhuM-ec_fcC-MQCBrsuGBA>
    <xmx:wPSkZQsQZA_kwEGhIJpO-pH4LBS6NqT3pjis5LbbdD-iiT1D087ouw>
    <xmx:wPSkZQFTD0lCTD3fd7fHNasBR2Lg2bus8HUBCYIZA8KMl9hVnAOnaQ>
    <xmx:wPSkZZ7zPgVTHlQWgdBQdgAw7lV_ypfChWV4Qo-qGVNMShoiDjAsng>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 04:02:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ef79e730 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jan 2024 09:00:03 +0000 (UTC)
Date: Mon, 15 Jan 2024 10:02:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org,
	Stan Hu <stanhu@gmail.com>
Subject: Re: [PATCH 1/2] t9902: verify that completion does not print anything
Message-ID: <ZaT0u4pEfY61V8QS@tanuki>
References: <cover.1704969119.git.ps@pks.im>
 <73406ca9c8f38ac2ad8f0e32d6d81f1566a6b4d1.1704969119.git.ps@pks.im>
 <d978494d-6c48-5923-4745-c42a39e1187a@gmx.de>
 <ZaEZar9OTVgfkD9r@framework>
 <27edf445-d7fa-7aaf-7682-4ecc03366ef0@gmx.de>
 <20240112151655.GA640039@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z4Ldjf6pohTwuVDA"
Content-Disposition: inline
In-Reply-To: <20240112151655.GA640039@coredump.intra.peff.net>


--z4Ldjf6pohTwuVDA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 10:16:55AM -0500, Jeff King wrote:
> On Fri, Jan 12, 2024 at 02:12:43PM +0100, Johannes Schindelin wrote:
>=20
> > But my main concern is: Why does this happen in the first place? If we =
are
> > running with Bash, why does `BASH_XTRACEFD` to work as intended here and
> > makes it necessary to filter out the traced commands?
>=20
> BASH_XTRACEFD was introduced in bash 4.1. macOS ships with the ancient
> bash 3.2.57, which is the last GPLv2 version.
>=20
> One simple solution is to mark the script with test_untraceable. See
> 5fc98e79fc (t: add means to disable '-x' tracing for individual test
> scripts, 2018-02-24) and 5827506928 (t1510-repo-setup: mark as
> untraceable with '-x', 2018-02-24).
>=20
> That will disable tracing entirely in the script for older versions of
> bash, which could make debugging harder. But it will still work as
> expected for people on reasonable versions of bash, and doesn't
> introduce any complicated code.
>=20
> -Peff

Ah, this is indeed the best solution. Thanks for the hints and
investigations everyone, will fix in the next iteration.

Patrick

--z4Ldjf6pohTwuVDA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWk9LoACgkQVbJhu7ck
PpQlthAAk6Yj09bnxxRcIEU9H7b1rmF/eEMk3ewHc9jgvcKgcitmk6fr3IAkB2dt
6LYH6OqoE/KDy9PAqjnR1EvjzOjIhQLHGZsF5DR+uD6o+upzv+aORkYeP/FEK5I7
AHDg9nEeRQ7E+1nsdNZdRSVp3OOmpUF4rlPcyznjHYqHTIXOEh9pwQ5ZwZhRlxPl
ReoZnv6+nC3uNaDNGG/nHB4ooeDdhSnD2SBuKvRbqXyVmoD02PKGrbNwooKMK+2l
5cCRX4ef4tkf/BjcsOku53CpqgKydlGJUix5sJaf4oIE4HAwc2bmeXOllH5DD2lO
RvHb49bP+MyxDHzvRDYYbrDqjUmfvNbRK2+4gDeMU/RT9D1kQH2Cobs972PVXDVl
CuwfTgCtVHlNuOBKSVtjiTqBezugRYbT6c+jEkJq0OZPD5JRLeVzsaPHsu08O8PB
E4coepipXDXz6uBfPVEw9vyHzsyyBeoDIK79vIFdN5QqSlQQwkrXnBqbhOaJryul
+vdsoiVOyTKAw7cQWsooFWQmQKEDJbGKGGbRPNNUOflyEruoH/cClpIAyHyGRFro
zw6OsRRYBFSxa6voXi+FY//B8k8huuYY+yrsmYDH9ytKfV+pDb06ZD2OMK7KR23l
o3knqDiBj66+mTJ4hjJhTkymeB5lYvCL+QJv9+L62xbMgMQHcTM=
=ObfM
-----END PGP SIGNATURE-----

--z4Ldjf6pohTwuVDA--
