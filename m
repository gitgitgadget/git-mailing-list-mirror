Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7B20CCDE
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729282064; cv=none; b=kIbf3CO0UDLYcdQEB8Rn1QnEW+WJDLFPVG544G7Wqjn8Vh9gqaZxVpMwX/CPCOx6cmM+HjZJ/iVBUtHl1GL9TiFz0/ah1TgjVJZwtlB6+QxjBzm5lziDbLExNCxYGCrUgm4+/fCTxvsCZz4xb3i/zvz476cp80oG2kbygAv4l20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729282064; c=relaxed/simple;
	bh=s0o/7SFhu2F7CWeZeM/U0Gi81nO4zkrNOiJwgyZdmBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2VuMWVj7LLTRIBIKkjiovWYCT3Mh2gMoJL1iY47kkYZ9RrQmPNWKl3EGJ7tza5k4tGEcLFtul8jEjox7CxVwmjNSskBY2+n06yKo7h/G5pm37iRJHvNB85oGGE+ZPtmXAaMTPxk64IQ3w/qNaU++VWNX0icAh5LvtTPrnvaEq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=yPLDQkjd; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yPLDQkjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729282060;
	bh=s0o/7SFhu2F7CWeZeM/U0Gi81nO4zkrNOiJwgyZdmBg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=yPLDQkjd4dywrjSvkLJGLU/+Ax+xoSiuMWPQn0+YQ1JaoJNL6KP1fqQkJZOYEewv1
	 IWphXJLF2qiT2OJsX4ntADuh7I9ng4xwTc2BurQIP8/SxYtD1qwVNQy9YEVjlz7RXU
	 gTStxktIVMJxLf6Z0soTJXrwQTs1vuS2Oc2F7RsJP1TzHj8lW8E23f/4zKqG4f7HNx
	 VLlE7vRUj5N9S6ro0IUhoi+mWpDxS/yLsZ+Oxnphe3+DwyNCKBPH/QdZtWefmqDaot
	 r9i2zga+o2H76hfsGPJBlXtPjnuaygPEb2xY5HJIWwkBZOZ7gdmTLpNghE6tZOCwUD
	 ++FEgUKjIjbs7Ik3JerTZ5GSC4CZrm4cZ3jB0t4goYpNTvpp44H9MDXojvZNWz2P2Z
	 0g5d7DmAusuXCimrOkac1KIT319TMdy3yFq+INaEOKX4K5XxUCy7/QRdetR404iBNP
	 1fKRoX3g52qfEZ1tFucKopNf5S3n4quT7Yt3QzV6xcP8/MYlr7l
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6455C200B1;
	Fri, 18 Oct 2024 20:07:40 +0000 (UTC)
Date: Fri, 18 Oct 2024 20:07:39 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <ZxLAC-c4y7_sQqzw@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
References: <ZxCJqe4-rsRo1yHg@archie.me>
 <ZxESP0xHV4cK64i0@pks.im>
 <ZxEXFI80i4Q_4NJT@pks.im>
 <ZxGN9zzt55GcL4Qj@tapette.crustytoothpaste.net>
 <20241018045155.GC2408674@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GWE5CknlruRED9kD"
Content-Disposition: inline
In-Reply-To: <20241018045155.GC2408674@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--GWE5CknlruRED9kD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-18 at 04:51:55, Jeff King wrote:
> Perhaps, but...don't the current releases of Git work just fine on such
> a wchar-less uclibc system now? We don't use wchar or include wchar.h
> ourselves, except on Windows or via compat/regex (though it is even
> conditional there). This is a new portability problem introduced by the
> clar test harness. And even there I doubt it is something we care about
> (it looks like it's for allowing "%ls" in assertions).
>=20
> Our approach to portability has traditionally been a cost/benefit for
> individual features. Standards are a nice guideline, but the real world
> does not always follow them. Sometimes accommodating platforms that
> don't strictly follow the standard is cheap enough that it's worth
> doing.
>=20
> I think more recent discussions have trended to looking at standards in
> a bit stronger way: giving minimum requirements and sticking to them.
> Certainly I'm sympathetic to that viewpoint, as it can reduce noise.

I think there's a tradeoff here in what is reasonable to support.  For
example, we know FreeBSD and NetBSD return something than the
POSIX-mandated ELOOP for an open(2) on a symlink with O_NOFOLLOW.  This
is really minor to work around, and overall, both operating systems
overwhelmingly are easy to support and run almost all POSIX-compatible
software with ease and support a modern POSIX version.

And then we have uclibc, which has decided to optionally fail to
implement obligatory functionality that has been around for 35 years,
which is longer than some of my colleagues have been alive.  This isn't
even that it doesn't implement all of the POSIX functionality, but that
it doesn't even support what was standardized in C89=E2=80=94not C17, or C1=
1, or
C99, but C89.

I should point out that the entirety of musl, a competing libc which
does ship with fully functional wide character support, is less than 800
KiB in shared object form, so there's really no defensible reason for
this option to even exist.  Nobody is shipping even embedded Linux
systems with so little storage or memory that this option matters
(because you need a decent amount of space for the kernel as well),
especially considering that flash can be cheaper than CAD 0.06 per GB.

The difference is one set of systems has a minor incompatibility that
requires little work to work around and has few practical effects, and
the other tried to exclude major functionality from a tiny, ancient
standard, the result of which is a wide variety of software that's
broken.  (For example, ncurses normally builds a wide character
version of the shared library in addition to the byte-based version.)

So I agree that we should allow minor variances for nonconformance,
because very few systems practically comply with all of the standards
(Linux, for example, does not).  That's a prudent and sensible thing to
do, and we should definitely continue to do that in the future.  But
given that this is major core functionality in the standard and there's
actually an option to include it which this distributor has just chosen
not to enable, I think it's fine for us to tell the distributor to just
use the appropriate compile-time option for their libc.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--GWE5CknlruRED9kD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZxLACgAKCRB8DEliiIei
gRKMAQCeH7dzHmtkmBsMVPXn1KcXelXI6gWFNTtNdrAqaOhUlAD/c8pzg3Iyl7cx
xiFUL2/UTkRHHcGi9EWmRUL7gx1niww=
=hlo3
-----END PGP SIGNATURE-----

--GWE5CknlruRED9kD--
