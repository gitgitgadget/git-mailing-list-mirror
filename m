Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E23623C9
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 07:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RpZA4ZWy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BudN96Mz"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 483815C0073;
	Mon, 15 Jan 2024 02:08:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 15 Jan 2024 02:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705302537; x=1705388937; bh=ewXdzlD7Nz
	XTGbRY4DH5SNJHNLsrQ6tZPApYduGrglc=; b=RpZA4ZWyX5a+GWNAe3IMrsf+cz
	ZQCVC3NFxsiiVgOKze6Xy1hs5s9mklmCxIpxgi74WUBWrqU+N8kvFrNvVOqxIJG7
	Z+h9zzJqEJSLuGnNcxBwTDSq6lvVT/tczP5D84xZ0MdLTBfExQUdMTxwwryMIeRU
	/QsY48Br+kQuzu7eHS70Nvh342Lvuz5bdURQKcWjH/c9xTuTZFEIwXH4bFSE9jQI
	sTmDhetdK1W3Gzvb+OjQuT2W5GnDj7Dt4HTjxiRFeL1Rgw2PcutbickUqh/Ym7Qe
	RxthGnhJ6Dh6gsPPrcRtR7zZI7HnKBAkzl5nuHoAhxAixicHF83CBUC7HnbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705302537; x=1705388937; bh=ewXdzlD7NzXTGbRY4DH5SNJHNLsr
	Q6tZPApYduGrglc=; b=BudN96MzlqIfGulPQOLZ5Ynw55rNjmrRzmd73VabcSQC
	wZNBcSOW97gYxbFQw3CVxVyBXWxtXVQu47RUhn2ZtB3UqRv6ZZAtkN26fmPp98/1
	vEyTWGQ+emxlYW2rnE+ejvRLwnlIJWo6e1Hl28BMEBUW6tSzLV2CnSH4Iu62rwCG
	2Cy+yZS5XvqUKJKUuM/VzIIRoNW+IRVSIwytPQ9zQVxaoT/ISCHb8ck9Zxb+3myH
	CXQfIhH0MlFEjM36aecwxj7Bp8on1qGG28pkVfeBxEagGuJeCUNWouHG96LmuwPc
	GOYSUSdjdrjQxn5i0htAPFgjvBSYt3KgFJlv3rQKtg==
X-ME-Sender: <xms:CdqkZRrpqcmCPy7CCjS016VtNa8mhQh2WiK3473E5jhoxR1LBWPOWw>
    <xme:CdqkZTq4szy5afnvNqhj2dxMc1hWjthr4LWJET_wjnvFyUnRlSFCt-ShtW12rBZSG
    kG1NCKDRb-v4qEuyA>
X-ME-Received: <xmr:CdqkZePk4WhdqiR1OUqXO4SyTkQTb5V3Uv1ubDT2ggwJ9hRIFluFTHk2XueJ1kPd6h3Rh1HLu81bQziLxprMGkxJU3YLcH_nh7Tbe-0CLpMYgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejtddguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:CdqkZc7S-buzh7I5IOg3CqmnQHu4T4LvX-6f-qcJNsix15YFbz9nYQ>
    <xmx:CdqkZQ6a77KZi7ZZpYM18Xw3lTCynE3N_0GZKFHwNDu1C8CEn4X6Ew>
    <xmx:CdqkZUjIOx4Cc8tqh6liyIskKFz6qitnTYnwN9YrmQiCPD6_XuCLnA>
    <xmx:CdqkZeQpP-oDIzGdAFbyFXjpFooSZTHSMnJVisSixyomA3poYOfpDQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 02:08:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 22fec45f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jan 2024 07:06:04 +0000 (UTC)
Date: Mon, 15 Jan 2024 08:08:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit-graph: fix memory leak when not writing graph
Message-ID: <ZaTaBN2Xc61sVvTJ@tanuki>
References: <0feab5e7d5bc6275e2c7671cd8f6786ea86fd610.1702891190.git.ps@pks.im>
 <ZZhUWu5pgBEYK409@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Jn4cCxPzhgAnCqPj"
Content-Disposition: inline
In-Reply-To: <ZZhUWu5pgBEYK409@nand.local>


--Jn4cCxPzhgAnCqPj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 02:11:22PM -0500, Taylor Blau wrote:
> On Mon, Dec 18, 2023 at 11:02:28AM +0100, Patrick Steinhardt wrote:
> > When `write_commit_graph()` bails out writing a split commit-graph early
> > then it may happen that we have already gathered the set of existing
> > commit-graph file names without yet determining the new merged set of
> > files. This can result in a memory leak though because we only clear the
> > preimage of files when we have collected the postimage.
> >
> > Fix this issue by dropping the condition altogether so that we always
> > try to free both preimage and postimage filenames. As the context
> > structure is zero-initialized this simplification is safe to do.
>=20
> Looks obviously good to me, thanks for finding and fixing.

Cc'ing Junio so that this fix doesn't fall off the radar. I thought I
saw the topic in "seen" once, but either I misremember or it got dropped
=66rom there.

Patrick

--Jn4cCxPzhgAnCqPj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWk2f4ACgkQVbJhu7ck
PpRogA/+NFWsHil0+kCM5VRSL4iTcHH07Dm35MS9PSTAK8jQnCQVkGEA5/nCc8vw
2N92t5hxxJgMXXd6Eu4YPmQe3mqXv2v597cr6JyhsA1ubgPOlh6e1ue2C8EsJ11p
NkeXgulnXVftr1XKWFuwm61hzmST32QbHwUkzMpeLwIUNa7SjHwbmkGzMxthlDxb
iJ9swjeeby/Qa7uhqoDUL7LaIPw2yrLGBtvMluFQFok3Y/UprkRgUMnjHnuMgTWa
LiTimeyLRFw4EMny8RVRSt7Yw6x4RiZ5w0yX9K4/tPQPJ6hZu0gAvInOJU30wkCj
xhPV5z8R235FI63nCmnW67iGDv8rREjw8ieHnjDU7FX+BJvISMdOYy6Ix+zGfeNg
SgpSJBBxJEOCZJ3wBMlh2gXkb/fORljGBve68EkO6LG4rQ4CsEAE2Zwukd8Hr+4x
cwpkhUbie8Q7NJNHQ5c4gvIztepGaTj9aBVzZi4KJTftgAgNvnbbHL34IgVwym1k
EVXILY+3XMPYYSKRfIDdRY3/f6+mP6sm4xYe9OP58j7skEfJsTuCLMQmmTbkMxry
anS37rPauACxerpEEgpl3W0ICOze2jJCdCqwYUOOiRjI4KDTK5HNLcIaobR6aBDm
XW/6BkCykxx8cUv5sBlgTGvYR46TdAnnA40SPBG0N/Z0esv7W1k=
=BkGF
-----END PGP SIGNATURE-----

--Jn4cCxPzhgAnCqPj--
