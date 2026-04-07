Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B73278156
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775600664; cv=none; b=tzolEit+qLhqr3N49gjxRkclCV/4dlwSGTAZ/n1tZSYLDvbMhFxu/2Pp3Wb9YA0lLSR0XOMg0lSYchrxcYpUV0cN0baxNGkQNgTfiFdwfEdUZ3o+WlAs55n7achsACuuUf3ZKNdgScIZg+iVcSskNT2oby5koBicI2PM1pBtGl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775600664; c=relaxed/simple;
	bh=7Gl4LzetBgsVnK7tk8l3gOv8w3GEvhyFKIHVuABP53s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pT9kcers9CePU7ZAtHhfKaomhL78A7o+bFgfzvF2YQqnCQKZetmgbPeseCcqU6i6/6C15LJf4xkO7bEEyDTvFLv0iue+vWegsfb1+fuk61hRCrmJBlkFs/PQWyIc8R4V8gLHzoMqXEfQbJ6++Z2szXLWCmSWvDzMBE/sn59xDzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=H3QpK3qs; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="H3QpK3qs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775600655;
	bh=7Gl4LzetBgsVnK7tk8l3gOv8w3GEvhyFKIHVuABP53s=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=H3QpK3qsnVzvmqm5mdk9mEQ756qqVC+3vV2rIWhbX+4bq1/7fCjMvhWNXNZdg8ZOL
	 k17QM5dt6qvzQOrPvnRTtkeIgJBeq/ru1/0ESOSUgzA0L1Uv1+Zp1f90tk698Vmq/U
	 tCoTQkEMo6yVKjIE+VLUKKI+sQr5W2VP4VmZY1RBTc5m3qEXY+O0+nLmA7OI1q4jXG
	 tfT8xySzihZejjTzpnldf/1ELX5HgzPWz7dR9TDwgSqbKrrdXH+/vF46S3BYMF3gg4
	 +UexAIfBY7l+vFEiBIO8F0l03aABAcZIONiBXiVpfOWqoH7uZYHyAI02CeVBeaQrKn
	 Y+KcyuAaoMh2W356SJ0kBP0j/YMbVNzqOZ3URJdd9YH0m2kWQ5bDoiyAUwdwxP1FsF
	 TU/q3SdxWXqxAnTEJQq3JS+5BNioywmX96Hb9ERp2ge7ILceB/T3V9h1nuWoadtrf6
	 bVIJSG1v57MsDRdThsnlvhpjGLyeSUYbABayniRh6ly20YNHiNn
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9492:b8ae:a7e1:509f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B853520144;
	Tue,  7 Apr 2026 22:24:15 +0000 (UTC)
Date: Tue, 7 Apr 2026 22:24:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
Subject: Re: [RFC] archive: behavior of --prefix with absolute or parent path
 components
Message-ID: <adWEDmP7A5XzRcyP@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
References: <20260407162101.2285-1-pushkarkumarsingh1970@gmail.com>
 <20260407192454.GA754735@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W/sZDcVPdhVLL0tN"
Content-Disposition: inline
In-Reply-To: <20260407192454.GA754735@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--W/sZDcVPdhVLL0tN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-04-07 at 19:24:54, Jeff King wrote:
> Yes, but note that with "-P" tar will happily allow those paths. They
> _can_ be useful, if you know what you are doing, but they aren't
> necessarily safe when coming from untrusted sources.
>=20
> We can also generate zip files, but I think most unzip implementations
> have similar restrictions (info-zip does, with "-:" to override).

I suspect there are people using this with `/` because they want to
deploy files to places like `/etc`.  We've actually had requests for the
ability to have multiple roots in a repository so that people can do
this kind of thing, so I'm certain there are people finding _some_ way
to do it, even if not with this exact approach.

In conjunction with a tool like mtree(1) to adjust ownership and
permissions, this could be useful.

> In theory we could support other formats, but after 20 years I don't
> think anybody has bothered to do so. Cpio, anyone? :)

cpio doesn't have the long filename support that our pax (tar) archives
have, so I wouldn't recommend adding it.  The only place I still see
people use it is initramfs images for Linux.

> I don't recall it ever being discussed. Of the three you mentioned,
> "../" and leading "/" are potentially useful, so I don't think we'd want
> to disallow them entirely. At least some tar implementations require
> "-P" on the generating side to avoid mistakes, so we could follow that
> path.  It may be considered a regression by anybody who is using the
> feature currently, though.
>=20
> The "////" is meaningless AFAICT, and could be replaced with a single
> slash. But I think it's also mostly harmless, as the reading side (well,
> the kernel) will equate "foo/////file" and "foo/file". I don't know if
> there are systems where that would not be the case.

Technically, POSIX allows `//` to be different than `/`, I believe,
although I'm not aware of anyone outside of Windows (and maybe Interix)
where that has any special meaning.  If you have such a system, it could
be useful to provide that as well as `/`.

I agree that it's more likely a typo, though.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--W/sZDcVPdhVLL0tN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmnVhA0JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ9tLmHKP0sDxjCtVmqChGFo9KdDKHov2E6nGLKsaympS
FiEECCzmip28ZfuD0cORfAxJYoiHooEAANZ+AP959L3WdbQrEZhf2tb9zqmJqXDl
5LBgNMB4GJjIwYMeGAEAvlebAkFLf6bvm+3XGPkfRN0ZZiLCSLYqwezTTvmLRQ4=
=zA2a
-----END PGP SIGNATURE-----

--W/sZDcVPdhVLL0tN--
