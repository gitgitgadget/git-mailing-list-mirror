Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6B71392
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705645121; cv=none; b=B+vzLNHdIWqeRb8ekdyDz84adPEhjBWOA7olGNvMr9rbCLEpFnM6jx9joTQPoDn7Egl3Imw+zXnB42ihCAtgV8f4f20IGxSl/BH4csnRd813OPCY5QbbfVYqdgSNIad1LH6YjBqUBpCn3yPYsQWAyYIi5ZrGWNJVLlganNfPwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705645121; c=relaxed/simple;
	bh=wPVCu2ZLJmjnE1Wcedg4KWRMZ33GbUv6sRCKqJ0+ENk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CILEj0tGqMmU9Wbon8RPHF8EtLDCLpGz+R2LOJJyxLbYegpv4SX55lEP+MtpbJL38ETAl/MYnaCV/SXj7akBlvxYKJGIItlir4AO/166yr4LkGCiAFvxpXYXQTXHw4S0ND+F76c4BEme1iMaxWVmBLyYLbALkIqPKdfZPQHFYIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pN6gWnXh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B2IbsyBo; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pN6gWnXh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B2IbsyBo"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id A3E413200A39;
	Fri, 19 Jan 2024 01:18:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 19 Jan 2024 01:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705645117; x=1705731517; bh=wPVCu2ZLJm
	jnE1Wcedg4KWRMZ33GbUv6sRCKqJ0+ENk=; b=pN6gWnXhsaugOdtpK7dLjU8is/
	YylIDOUkkFr/mLbMPUTzeLFNAhw54yQkIXGudJaArGEp5vVyVc+/pLbILYa1+Acf
	FxeCQjkDl6imsYwUXmhaeMNkiJm9UWM1SrqLH9TVihQj/5k5E9UQWe4A7D43z88J
	NZTcp8AFUZ5bHa7gTm78TKzfAHf2qVXqdGmN8ZO8fkwHa52PxeG6arKQbpxAH8ux
	+u8GDL2M9byAl5chx+1Df1tjPC8cFGtrby2CS0JkXY9cG5cJOtwyiWTxd5KOHfpD
	3uutPpSZ/Jd6FNZF0eh4JhxT1g2plWaYfOzFq99icM5Q58/+8y8LIjNtcWlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705645117; x=1705731517; bh=wPVCu2ZLJmjnE1Wcedg4KWRMZ33G
	bUv6sRCKqJ0+ENk=; b=B2IbsyBotx07DpYxZR7+GEr0+V4g3EGmkgzPbxgqZzMm
	F/Slwrn8JHA+qq+bplWeKUksIbEhugKxiXKjuzLqSuD9Eqll6C8csuQLtXYV5Xs4
	0WiYwI5GURMR+/zAu9eo3PTA/9EAgqAHc/m4dpQ8ZLh/ock0DOLK2S92gzlTPGlr
	zXwaYw+ax/FuPI4R4qimkdXOP/MhJGogCpZ4iXnCEkY5Ty/+uxcugoQtf7kEyjfm
	UCK1g9jj3K7xZZg1301ryt6mP4zt4R26oU5kVhTfbnIU3J4ciBUoHFQY2XV08d0O
	ee7p9NLDq0PyHZwKJDebKKB88KEfsfy6dxJL4Bykfw==
X-ME-Sender: <xms:PBSqZQWg687q1UpG9BV8QxtkSk38EFZnpc2D2Lf6U0FYkuDM0r-A-Q>
    <xme:PBSqZUm8qe4HZC02-iLepmzxZT6Xds5cZAtu9veSWZl6LXU8N1mV8MuPsimZ3Q5cp
    vYpp93PS8gh1ISZzw>
X-ME-Received: <xmr:PBSqZUYZG_Yq2yWj8pt1ZZOAJGFb_Ohr3jr6jBobtKBTHeS-QOBmQ3fTs0MaHla1yj-9lyjyhc3aJFtWt6zaVwJdS6djIv9cTnTFqv9qlA6aCu2r7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejledgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:PBSqZfUSqmcmDmTjMrwKj80zpn0gmGLlO6FqtzM0yCLhuWcouKKygQ>
    <xmx:PBSqZan0kRx4Kmmv12RfhQDOgvfIhCoXcysWp5zp8_DG2TxAS3j3SA>
    <xmx:PBSqZUeep-aZqQOHUfdBvx3su69hPkSNDosaQOMcwN-G_c2uRIxcEQ>
    <xmx:PRSqZcjl1LWIFm81UtDfdxHTSRg98rjVsRntAvB5_DLHpqJJJR8hOQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 01:18:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c9ca3738 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jan 2024 06:15:37 +0000 (UTC)
Date: Fri, 19 Jan 2024 07:18:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, stolee@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 3/4] config: factor out global config file retrieval
Message-ID: <ZaoUOPsze7rhtT2M@tanuki>
References: <cover.1697660181.git.code@khaugsbakk.name>
 <cover.1705267839.git.code@khaugsbakk.name>
 <32e5ec7d866ff8fd26554b325812c6e19cb65126.1705267839.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dACltNeQrvbPtCpQ"
Content-Disposition: inline
In-Reply-To: <32e5ec7d866ff8fd26554b325812c6e19cb65126.1705267839.git.code@khaugsbakk.name>


--dACltNeQrvbPtCpQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 10:43:18PM +0100, Kristoffer Haugsbakk wrote:
> Factor out code that retrieves the global config file so that we can use
> it in `gc.c` as well.
>=20
> Use the old name from the previous commit since this function acts
> functionally the same as `git_system_config` but for =E2=80=9Cglobal=E2=
=80=9D.

I was briefly wondering whether we also want to give this new function a
more descriptive name. For one, calling it `git_system_config()` which
we have just removed in the preceding set may easily lead to confusion
for any in-flight patch series because the parameters now got dropped
(or at least it looks like that).

But second, I think that the new function you introduce here has the
same issue as the old function that you refactored in the preceding
patch: `git_config_global()` isn't very descriptive, and it is also
inconsistent the new `git_config_global_paths()`. I'd propose to name
the new function something like `git_config_global_preferred_path()` or
`git_config_global_path()`.

Sorry for not mentioning this in my first review round. Also, it's only
a minor concern, nothing that needs to block this series if either you
or others disagree with my opinion.

Patrick

--dACltNeQrvbPtCpQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqFDgACgkQVbJhu7ck
PpTDKQ/8CM7uO397Cpo0dYONoAOpFLMxaNSTQ6Qnjrvs477nqYPzI3ayhP7IqB1K
VIGVi5NaVwVg1PyUcvWNGW2UEU2VNIs1R6RGb5ZhQa94y2qKxJfHKHUYMfiyX5AA
lDM1COz8ieVT16BB4fB70SyQ5/Lch+dRRKZmDv4PlSXaX87Kjl7ThWyZhGnooPnB
io+tt/3Kf17sg+62/uCx3iKWu9wCWMhg8/Q7qm3FhtzBGm9XcuDAMqy913lH3+77
MlZ/EbUcW/xRideU5HNsTfugJCeXRmUoyUjdHemNTtlMSg+2h9K2R+3NgQ8TWNGm
UqZQVx1m8FjPDUTLbEQp9e9Fikpv4M90z4pd86Xvy/gRmQZQsv775sCsOJeBl2uQ
O8yvBB5hh53z+pGzi6s7C8DS//eEr62zq4b/2OZJMDBg27bYtT/bJanRvHOV+hPp
uUIgG332X/0pRxyOZSXrB4sOsnrKYB2EVt/5AlggRez/gTtTM160AI1IKP7BxyZr
kCCgju4iix+misvt1GXUrctqTuZ43eJM0NO6d7Nhec8GpUV1Qb6YgW9m0SRrbVH2
cQ/f3xIUDUf1mG3CXID/o+hFn21Xa9Ukl58Z9+rgbHNU/+kJnEKqRlc5CzyWkjxr
yMYEzieSxCXUqFTMiz+6x8LLqSik92CSNaywGa+XGfg8ui2K6lA=
=h5na
-----END PGP SIGNATURE-----

--dACltNeQrvbPtCpQ--
