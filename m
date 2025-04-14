Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11EA19D06A
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 21:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744664756; cv=none; b=KWkKyCj2Fd7yhkMd1ZjidDgTFW+nNU4Ne+Uj5bgjV4vYTpAddSSZsdNbeV+H4s7GlKjTDJC/b5xftbSpg7WgyiNhodIjVYZhnTJxxeYOyTv6n7N4IIeUwFMq58IOgJCxzpXAonp/QOke0lEwtsU5ONexYGHH2Jy+rIn8rovYILg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744664756; c=relaxed/simple;
	bh=ZlGkhjz6/WWEKHMNM+kF0MpySAnr4raTsBlpBTyUYok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFFuz0gNO09k7rVG6lnVSmshVzQhbENDQRgFJULpxVErQMe06m7WC+axuXUSWsZS1+GlzCx8Fe8keYEjd7Kr0BGTSHw561Jk4YfMAhUWLE41TOp0vIWnt3Xm8rGOqr7KqEgMPdyQSnhksp4cENdhduMntgz8tpb3HsTSW+ESo34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=UOHfOa8h; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UOHfOa8h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1744664752;
	bh=ZlGkhjz6/WWEKHMNM+kF0MpySAnr4raTsBlpBTyUYok=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=UOHfOa8hhsjSsVOwti5NCUJblNqpug8SqLDNTBVHTLS4muxuy3/xMOtToRoWEKpPD
	 0bRw0WE8W9IoVOO4yqkEiySXodDgol2l459VnwUazXKNJSJx0C4mTtaUhBiNw5kPBO
	 N0sh+5c3zqY+mZbRF9CrXQHnan3BLIC3ygYcNoDTADpsa+KCAJ5+NyFmIZqr/oLU2g
	 1r04Qf9buPxo6ltaeQGFBtf16VZAF5ECpYfHJ6BgVa8B2uI4mQKGREziWscfTRbOdy
	 I/1ndYpG7y81GhmaF1z7SgzAB7nMli8GR8aH/TYaeJ1xsHLFLI/M6d+cVVbWsH/i1e
	 zstIXLOFEfVNKLlbc1nXpJCx+CTb2aNzAkx/0TwSyCQSUo0xKgQ3eRdlS1rJRYiNLn
	 Tb6v/og1Lop+ta2JjdustELu2dvB0Dowr0XNUru6TnX5x1gi7nUniLebre5NFkAEnp
	 ZFZ7TREhRV2Glah1Q8iIfsqRa0WiPpMVcB4ZB4EOuCb7bpJGll2
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 251912010E;
	Mon, 14 Apr 2025 21:05:52 +0000 (UTC)
Date: Mon, 14 Apr 2025 21:05:50 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: phillip.wood@dunelm.org.uk,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, james@jamesliu.io,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] git: add --no-hooks global option
Message-ID: <Z_14rtSaqdoNDsfa@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	phillip.wood@dunelm.org.uk,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, james@jamesliu.io,
	Derrick Stolee <stolee@gmail.com>
References: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
 <2c7994bc-2be0-43a5-9627-0d530746b3ab@gmail.com>
 <1602379A-B5FB-410D-9622-F31333461E74@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ZDsLd+wS9gYap43"
Content-Disposition: inline
In-Reply-To: <1602379A-B5FB-410D-9622-F31333461E74@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--7ZDsLd+wS9gYap43
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-14 at 15:25:42, Lucas Seiki Oshiro wrote:
> Hi!
>=20
> > I thought "git -c core.hooksPath=3D/dev/null" was a fairly standard way=
 of disabling hooks
>=20
> Given that, wouldn't it be a case to turn this into a documentation patch?
>=20
> I just searched here I found that we even have a test for it (introduced
> in c8f6478), but I couldn't find that as a recommendation in our docs.

I think if we decide to keep this series, then we should probably keep
the documentation in this series, since it will be clearer and more
straightforward as a way to disable hooks, and if we don't, then a new
documentation patch would be a good idea.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--7ZDsLd+wS9gYap43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmf9eK4JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ/bE1xybIa1ErR7uUn+lT+Tto/9uc1wzTBF1Cx33/tb+
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAJG0AQDI7UlQCM61ilmTDnAC5qdHPmjl
U74AQr8wbzUkYjREkgD/SfYS6pk7YndTF3RwLCD9Wy7wjZlQcdYus/zuMvYqXAE=
=Jc1+
-----END PGP SIGNATURE-----

--7ZDsLd+wS9gYap43--
