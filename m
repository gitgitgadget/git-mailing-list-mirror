Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A797690A
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 21:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710453295; cv=none; b=qCs5eF9eZ85UBDIEo+mwqEQ9zegWzEWfphnkAshJqtoJfNmk3fm9ik8KgnFbtUdlMo8KOHRVh58trGhGP68oSskZTGfbRGmEBG/vBRkh93Q8PXz7qrijkO8pIswZRYy+6IANOMHxcQlyUAUl7DWXSs72XVRLVPDxaMrYkLx66DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710453295; c=relaxed/simple;
	bh=HOFQsVM/AepvIw3xL7qUqDuBCEhZnZL79Pex/R9BOyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHAEsYsrqV4JQqjYPl5/T+BoYk972RQS7QAeSVuexwb1af0h4ZH7w9syU/INJOX5tRQAjP2OOt+6MpfiO8X3byWTA4ZFRoXMuerb/ary2LYilhbJC8s0GUAA5xHkr4yGl/QcQFv73SlU3P/peTpB4Dfi0xSHhEA8KGC4203iNeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Z9uZV7vD; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Z9uZV7vD"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id EA7DB5B3D9;
	Thu, 14 Mar 2024 21:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1710453291;
	bh=HOFQsVM/AepvIw3xL7qUqDuBCEhZnZL79Pex/R9BOyw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Z9uZV7vDYEBvWgMuRxGuytuyBREHPV4MLhxV1CLyDx6MfUHr5AIBZX6XtDVK0R8/o
	 hfxL+8NuDKFPvGYFswK79ymT1Mm66GLkXKiviehFSIiPyiaV8MtYLEGe8aVnZokr2N
	 JPwFIXrZhZ2qw1kZbLqJttbfuLMC1cl5WOSL3sYzGKk9NCZsQLnIQJ2dX9LoU4YpiG
	 xqmiND60QrTKqSNHv07wsXYa2OE3vFb6a5veQcmWHM/UncZCGkhbUWEilEzrpQZDgw
	 HTq64yzViGHUbRoRlOlLe4PYwBzzNQbEduLCkDND2UVv7XJThdHCUq4s/z/Gc/btDT
	 TOUO4J+NX31Y+ROo6rFcALbXPtvUpEzFnVEmlOzrPis9LgDYtgXF+Fv/eDManIi93f
	 FLrqUzAcG0BFpWQpxgcs5YsItj6wjjNXmSWdj4dLEM0AuEk26CFIGwRGaBx1B9NY20
	 IuoOsI2equuWb5JQlqEW/NjSAodw3ci1VSVl/y2aYUD5PJN69H4
Date: Thu, 14 Mar 2024 21:54:48 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@gmail.com>
Subject: Re: [PATCH 2/2] doc/gitremote-helpers: match object-format option
 docs to code
Message-ID: <ZfNyKIEOvnRKjL5O@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, "Eric W. Biederman" <ebiederm@gmail.com>
References: <20240307084735.GA2072130@coredump.intra.peff.net>
 <20240307085632.GB2072294@coredump.intra.peff.net>
 <Zeo9oAkL6kxZRugN@tapette.crustytoothpaste.net>
 <20240312074513.GA47852@coredump.intra.peff.net>
 <ZfIWkJieqcPv5jA8@tapette.crustytoothpaste.net>
 <xmqqv85ozv3v.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z3CEfksPfSOH30yB"
Content-Disposition: inline
In-Reply-To: <xmqqv85ozv3v.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--Z3CEfksPfSOH30yB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-14 at 15:33:24, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > The answer is that I'm not planning on doing the SHA-1/SHA-256 interop
> > work except as part of my employment, since I'm kinda out of energy in
> > that area and it's a lot of work, and I don't believe that my employer
> > is planning to have me do that anytime soon.
>=20
> It is sad to hear that it is depriotised, even though it is one of
> the larger areas with high importance for the longer term.  Thank
> you very much for the progress in this area so far..

I don't want to claim that my employer is not prioritizing SHA-256, it's
just that the focus right now is not having me write the interop code.
Other work is ongoing which has and probably will in the future result
in Git contributions, although not necessarily directly related to the
interop work.  Some of our work porting away from from libgit2 to Git to
get better SHA-256 support has resulted in us writing new features which
we upstream.

As far as my personal contributions, I'm focusing on other, smaller
Git-related things right now[0], and I'm just writing less code in C
(and effectively no code in C other than Git).  And I'm also doing other
things in my life which leave me less time to work on Git.

[0] Including, hopefully soon, some credential helper improvements.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Z3CEfksPfSOH30yB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZfNyKAAKCRB8DEliiIei
gYsCAP9hLwFZB8rtc/ja/OZPpCG3NsmtNxd0nWF2hMiCi6zSxwD7BTF7GxS2C+0t
zEifqLW2PVo4+4wM9KH2AD3rQB2rxwI=
=Eora
-----END PGP SIGNATURE-----

--Z3CEfksPfSOH30yB--
