Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE0101ED
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fop29gf9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0yrgleUw"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 9CE4532009F5;
	Thu, 28 Dec 2023 15:18:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 28 Dec 2023 15:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703794695; x=1703881095; bh=fhuiM8HJhT
	lwom3sF7A+Y+bJvZHbnBShLPCgQxjk1Y8=; b=fop29gf9XLZXDKr58mY+oAPuTw
	blO/gfsgxNRvd8TXFDrT9PuBCZ08lxvVpOIFOv6+PB0xdnQedM+1aTAmYd/frhBZ
	Eg9zLz7m00q64rHAEXlFLWYLJIZd1gzxy0WIv3QoAZEat8g7AU+usFQCYZJb/HcY
	Skm3ZTq4y91tGITaGcl5D0kMydn+fpei+aI2wjYx9mZcll/6Rj0XrifKWfxArJOR
	YMWAJb7zOq+AAVpN2UQwbCuRkpbaA9p9/ZYH7OpherlZxS1T2pg2S8AObqAoicnn
	9+1C8bmaEg5M1+3x8BbJBeTdzvdxelinHOgTgCpRFaAvmsWP20xM8aEHhVKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703794695; x=1703881095; bh=fhuiM8HJhTlwom3sF7A+Y+bJvZHb
	nBShLPCgQxjk1Y8=; b=0yrgleUwodZn1cxxCJBjk32w3cyOsr3u1vNa1ghSbH7E
	YMePtl1Tw+tptWd6FdA2wTMy4+9iL1cLJrw4WTShy9bXCBtYXba8Jgys/QqxpXA+
	Dhs+R340q8zZS7DJM6m0Zg4smeFvJAEzGCexeMBkMUGUVW1gcCOTQYeZmpqxXkqU
	i9KPEiERQd5m5pkvJGAqTU+TL/VjWAI9ZlD9EQ+kL1h4iN3hHhwHJskF+PCYrXAP
	SzUdhK1OJMxTOiIAUbW+yB5ShKb0Tu/tjsrvCT5VpgBgZctc6UrO1CxnNn68YPiK
	2RkLdCboAdr/FNNg5/BUw4JX9EvHJwBsF6w0QXbhfA==
X-ME-Sender: <xms:BtiNZbH6eIMm1bOklg-dUQBKPEZvSKoiTo0sKaWGl8R2ww4ZjItiBw>
    <xme:BtiNZYXf34yFbLj3K-jTMlkaxf2pIscA_golQ_w6o2kvwNqbU1EzAc33fm7Iw8Pa9
    MOV9fRKyK4W8m1_uA>
X-ME-Received: <xmr:BtiNZdIBIHpdAdEcCqKeGDMNiS8shcwOnPb12CE8ITpNNJM3fBJy5RIYB-J-vwZZ5NMGp4CQmhbMKaA1OhVG5WgIyhr0s69nk0dECrv6PnNpWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:B9iNZZHevs8fHuIz0jsythAWoDIKjA4E6wp7l2Hy4nJuj_65mXSXBw>
    <xmx:B9iNZRXOKhgE7ZdJO12aITdeB8X6qfca3c0jzKfqoMkmcGWVLIxemg>
    <xmx:B9iNZUM5o3FWGE_R9qjWcyq9VG87WW1WLGp2OraXYCRYk5bAd2B__A>
    <xmx:B9iNZeioV0SCVHmkzzyiVyikMGE-Y8hHJ2GUYo0MSz7lamUqYAbJ1A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 15:18:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d69b6cc0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 20:15:58 +0000 (UTC)
Date: Thu, 28 Dec 2023 21:18:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/12] worktree: skip reading HEAD when repairing
 worktrees
Message-ID: <ZY3YAyybyZaxctRp@framework>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703753910.git.ps@pks.im>
 <ecf4f1ddee36643f0ff7e3d40b9aa7c7e6e6ce43.1703753910.git.ps@pks.im>
 <CAPig+cT6mRyJijL1qo2g56Yny-JxkDYjjmGpAncyS_4Hcpaz6Q@mail.gmail.com>
 <CAPig+cSKpzOCOzC_mtNoA4yYmHCtMxB-Ujsd7YYHK-SPJvgt8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oiVEdGms77yhKEsV"
Content-Disposition: inline
In-Reply-To: <CAPig+cSKpzOCOzC_mtNoA4yYmHCtMxB-Ujsd7YYHK-SPJvgt8w@mail.gmail.com>


--oiVEdGms77yhKEsV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 01:13:04PM -0500, Eric Sunshine wrote:
> On Thu, Dec 28, 2023 at 1:08=E2=80=AFPM Eric Sunshine <sunshine@sunshinec=
o.com> wrote:
> > Having said all that, I'm not overly opposed to this patch, especially
> > since your main focus is on getting the reftable backend integrated,
> > and because the changes (and ugliness) introduced by this patch are
> > entirely self-contained and private to worktree.c, so are not a
> > show-stopper by any means. Rather, I wanted to get down to writing
> > what I think would be a better future approach if someone gets around
> > to tackling it. (There is no pressing need at the moment, and that
> > someone doesn't have to be you.)
>=20
> I forgot to mention that, if you reroll for some reason, the
> get_worktrees()/get_worktrees_internal() dance might deserve an
> in-source NEEDSWORK comment explaining that get_worktrees_internal()
> exists to work around the shortcoming that a corruption-tolerant
> function for retrieving worktree metadata (for use by the "repair"
> function) does not yet exist.

Thanks for sharing your thoughts, will do.

Patrick

--oiVEdGms77yhKEsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWN2AIACgkQVbJhu7ck
PpTjEA/9GfNt3LftTX6IkVMl3oWnAjHEluUO7PoukNZcvOzEiihYqJvOMEeMiVNb
XvM+jgm36fxnw00vIzDm50pPGMiVbkNWlxNxOUIGggirdwAZ8RAmKPkcZjKOproY
DR4U4nB0Xd//qrhc/nHLsD1yScREwbl1Vd4/do1HoENEba+rdLX1RbgkIPXgcoK0
waI7B7bU0+kEnPOeSETJyeeSTPvrQQjlaLQzZ3TNNJ14IRIQYc3NUtUnjeCuaOwP
ETE6/7Y9gSTYhoVHNuuKkGtt0utd7tvaNbwKjwRwAeL8mfQUvlX94xJVWpTXYt5n
tRMk+dEpmhuTHBs8ATtU48Y86UcJ+fho7CgLO9M2xHG5BiHawZR55v3wqbjPcDjg
pEWSvkS/q6qdVk9FkQy+KgOvsJwqgbhwbd5ZBvJbp79AZmp8d9IleKVj31KpddZE
8qcQG9UtaX1MyLgWwACh54JkQLwnzf7G1rwXrAS07JlwUcpQmLJRqjv3f03cobc5
mv0z7jEdIBcUWPuVdIV/vVvv85Ul4L4f5H/M01sKqt4l6Mg2HUunYfEaBA4IzhLF
lLHNd1bQ7F3qdTeDAFG0JCVMj4D7nc/KrqxmkRWXPbfm2sGkc5bqguYnzZotpclY
OYCWgtepYMWbBEQQ8JajcVWA7EHeXpYGHjs+dU6E9dPKZq6cH9k=
=phqA
-----END PGP SIGNATURE-----

--oiVEdGms77yhKEsV--
