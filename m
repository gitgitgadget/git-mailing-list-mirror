Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA1A2D7BF
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744332456; cv=none; b=eMmQyen3yFvhDx/9vkM12ZM4Yv+Dq/d4XY+V/ioiUN+LUhZ2qcZpFPNccSvuygFAjJuCDb5xcdJ14NqMUY85ruYiL3G9nxAUAC2PVkBq5HLf2LtfmFn3kJAsLp3BDLJdIWMmP7unS4hHKA7vKE3vbuA65VhHZp4BW22unoQJNTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744332456; c=relaxed/simple;
	bh=Qk73f28cW4oOpgLjLn2t1vNB78A4fRS9RP/elCcCxyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kzo5Ih7KzlAqsClWZvGXflAFVygsum7s4v4C2LSnDJNGl4INwuLWSsfT+BPpXjeijVqPjawfIrfUE+EkH3vyggDFHXfSifkzd6eMFJaRd79U/3AbnKwXYss2hTONkqlGvhvjm/xEdfHWsrQB6GAZcoiFUNxa1M+IjQSYxvwmqvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=jYtoo9vj; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jYtoo9vj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1744332445;
	bh=Qk73f28cW4oOpgLjLn2t1vNB78A4fRS9RP/elCcCxyI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=jYtoo9vjlAlQNrb89w1S0TTptR4xPu9oBWdHMxYYKZxnTg2LQReWODooWIf+tLQuF
	 W1hA0Q3lDWdQtiRDGi0Svk/qKaFHsW3YTZqngjMGi+m1Unq3+ffWXdGNRoTLrkHr8U
	 xLZTbBFxVBz0AVvK+ekUYNT7NTvV9Bs9whVxHQzyRXWHIlP+VghPSGlR0KndcKppSR
	 zEIy9sIEI9a9Cj9jTN2P6spVJQVojx6Lk86Fjq3Nw2fgleV5Mvzt+RmoGherR8NVbG
	 fGGIOXSz5bQqJYXeDj7OjHakZcj/WH3Nxi2kFs1rUorN+04c7vd048Litx7fKsV08i
	 xGWY6PNc1bl154Yr1wZQNWg1+6q/ni00rketVEFNdNtqutFY0XeKz267EBPk3zuLzL
	 fonx4m3RtOJGpNBYij3Ts8FnmE8EEc3WENvOVgLggBSdgKd5pXu9Ksbm/Zki8kXdJs
	 96Xkjub9TP6CVwUfi5oy9Nc6hUtC1sNPaftsWPPRD62UDjwKzna
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 863FF20104;
	Fri, 11 Apr 2025 00:47:25 +0000 (UTC)
Date: Fri, 11 Apr 2025 00:47:24 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Nikolaus Rath <nikolaus@quadrature.ai>, git@vger.kernel.org
Subject: Re: 'safe.directory' setting ignored for some operations?
Message-ID: <Z_hmnPoPjXQm6lyP@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Nikolaus Rath <nikolaus@quadrature.ai>,
	git@vger.kernel.org
References: <CAPzgaL2Q4v0LMSek=osugTDCDww9D-Tg+tDsFhFvRSVXFR8g6Q@mail.gmail.com>
 <CAPzgaL1NH_GofMko6f2Auz4e1TjTJNH0w4-ph8np04QRfT_R7A@mail.gmail.com>
 <20250410213542.GA3168175@coredump.intra.peff.net>
 <Z_hCjfoRUIDZoBfP@tapette.crustytoothpaste.net>
 <20250410224223.GA3191424@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5izWINMdUl4Y8Bz8"
Content-Disposition: inline
In-Reply-To: <20250410224223.GA3191424@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--5izWINMdUl4Y8Bz8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-10 at 22:42:23, Jeff King wrote:
> Yeah, that's true in v2.48.0 and later. (I tried it after writing the
> earlier email and was a little puzzled that it works with --no-local but
> not otherwise, but it sounds like that's known).

It is.  The reason for that is that we try to hardlink if `--no-local`
is not provided, which has all the normal security concerns across
ownership boundaries.  However, `--no-local` uses the normal
`git-upload-pack` mechanism, which we know is secure on untrusted
repositories.

One thing we could do to improve things is detect if the repository is
owned by another user and just set `--no-local` automatically, but
that's a #leftoverbits for someone.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--5izWINMdUl4Y8Bz8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ/hmnAAKCRB8DEliiIei
gV4hAP92ulnJeqb/hdSHikbcwT6o97J2G2tuSUKiVvPSxN1L1AEA7CZ9IgRQgmN5
N8e0HqznKNsvN+pNQozxfvnthq7mYAo=
=Dv5h
-----END PGP SIGNATURE-----

--5izWINMdUl4Y8Bz8--
