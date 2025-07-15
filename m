Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2A1C2DB2
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752618982; cv=none; b=I3SA8TBAc399nsvjBQK/cncFG/y0Onuf1rgeC1N3e7skCrrAI6YmFnYVmlgbHRkaY6yGXs8bkZnfbDIYNSPY4RZs1OtiOILTGRsFlEB15MY30Cbsky9xfxXmh7yZI28Wm3pvzvQb8E35aNc5/QXXox0S0g0v+KDKdt0NJ7p82MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752618982; c=relaxed/simple;
	bh=Ij6a+uCLDfaPaEvrXL8xJhB+1Ppp3mfp0MF1PPK/Rh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qft4PRE0cVhS0koTm7S2Y4G1OuNQ38apVrxdC81VEcD9HJRp7BDIcfLWg4QrMchRlK6NCFHlzSrsjOcGMMaXt0dR84efqIl/LU3BrjiBAr+BPRKOircMegEcoOPq84uMuF/1VHBJ39vxDTxlfjQMzUFKWrPejm/+3emMzvn1muM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=y4I6Awyr; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="y4I6Awyr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752618979;
	bh=Ij6a+uCLDfaPaEvrXL8xJhB+1Ppp3mfp0MF1PPK/Rh0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=y4I6Awyrr/BJzZ7DDaK2qMkefpG+CUyE5hS433fvoc4x95PE9nDR7XSlUvdd1qnl4
	 Me6nPCWv809pQG33YGo4VHrBeI3gXtBuVURYVK71bm6VTAqaQ0JkX5tMv93fxi4cGK
	 +Fo6fl+5L4lnWmBWR7znjSgHij64c89WB95PAE6gUZWckQ4N2T+dokdh7eGR426twG
	 d6lSmhoyN9TMM8J4TSIP4TmVHElUIL5B8rlELn2Q5SDDvJ1q2uv+MSBCVYL3Ti7eOL
	 7BrNh4FlMT+h1EgoFLlXShSebSUsr3P3LSSwwY9ZsRUy7XfwXWqYKLPNEmoPI16ekl
	 GakJsCAega0cA9a/yDgGrtp52qCc9YjD21vqA6B9ZNCRwEVz+0T6oyLIEGQ27i2olp
	 R2km1P8jfnKVm2J5/HRRtFSmqoTM8CVp91qXT79NOWAJp7tADnmrcWhruAF1I9vcyL
	 fh11Jr3+URcusyC9jZOtJVLWw7A6CpkAp2Xkeg39Hp6kjk2HbOL
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ef36:e137:e56a:1fad])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 722022006F;
	Tue, 15 Jul 2025 22:36:19 +0000 (UTC)
Date: Tue, 15 Jul 2025 22:36:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	git@vger.kernel.org, Collin Funk <collin.funk1@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/5] bswap.h: Rework ntohl handling
Message-ID: <aHbX4hIKbjO6h1R5@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	git@vger.kernel.org, Collin Funk <collin.funk1@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250715191230.12081-1-sebastian@breakpoint.cc>
 <xmqqple1f7ge.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dmyZbTbXs4N3V2a6"
Content-Disposition: inline
In-Reply-To: <xmqqple1f7ge.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--dmyZbTbXs4N3V2a6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-15 at 21:52:01, Junio C Hamano wrote:
> Thanks for updating the proposed log messages with typofixes.  I
> understand the patch text has no changes?
>=20
> Cc'ed those who gave comments on the previous round.  How does this
> version look to you folks?

This seems fine to me.

I might go a little farther and simply say that recognizing the pattern
and emitting the most efficient code, whether that's a single
instruction or an optimized pattern of instructions, is a
quality-of-implementation issue in the compiler's peephole optimizer[0]
and that we don't really need to use the builtin functions or provide
special cases for MSVC still, but I realize that is not a very popular
opinion and I think this series is fine without that.

[0] Byte swapping, population count, and rotations are, in my view, the
most frequently open-coded functions and thus every compiler with a
peephole optimizer should recognize and handle them.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--dmyZbTbXs4N3V2a6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaHbX4QAKCRB8DEliiIei
gRNVAP9Ny/6paBNzJNClXXUG/LlFU0jYYtmWYuSaCqbGWatPtwEAyBCP3es65IHK
clmUaML6UlwTgOD6DC+ipTT55ArTmAU=
=My01
-----END PGP SIGNATURE-----

--dmyZbTbXs4N3V2a6--
