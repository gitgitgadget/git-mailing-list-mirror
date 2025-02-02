Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D231D5143
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738538039; cv=none; b=kGXb2e3wTbb+HmuY66NDb7W4mNAVjAGItf1uszYfu53iCmxQ0Cxen2EIRc7hZcJXO1I+Exm41lCzabjZyLdqVRx5m0KDWJtD3sdM50pv+M80eJ9/oZEGaQbXKVntR8C1XhoUZ9WQc7JAUptVsjKzj/hWKQQiG5toR2NzLH95i6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738538039; c=relaxed/simple;
	bh=nSo41tW6GZWyQpSRHCFmk+B3H0ghJGp788OEAW3bKsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCAU566CIDaF8ZcSk3cWCN3bAPo+onrUqdsbSpZ3lOEO8p2nP2goz22RG5Nw4P5Z50uATdkN+5RMd6rPF2uX4ysI/oy8zPOt4lg/4RNHjvZ+nTGzZYHb9agrHeFqM0kfEGc0HsrzIjL6E76eiCnKaxfmF142mpVx0T62fQLiVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=0CWVSkMe; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0CWVSkMe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738538036;
	bh=nSo41tW6GZWyQpSRHCFmk+B3H0ghJGp788OEAW3bKsA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=0CWVSkMef11E1iy/UWNBRJhKd/f6rVbdbeVFgM1fR9wCuqmSVMea9FdbEyYR4uNvi
	 dG9B2AoToGzpfoRZgEcvLVwlcbYuWD17hIy1ZNxYikJxjbHqDTym49LLEBO4C4sjxQ
	 brbMQakGycxsFpQwLxhbaGhiSoj7v8r267Cgy8ua8y/dGARlPag2tcv9F937YBnl8H
	 QHI2NOOheKcmPN2exh4pIDmw9k+2q67TTYIFdjsGTMu54T8sYz0W3hx9bIIRCqq9pg
	 YGWo1rAFSdk3wVVnKqbjntVZfg8H7R3DpG7Y94VNh83nuima1WCCzJRUF06e27kyE8
	 Gev0xXgCRQ7gh3Xo+72oh9CwpR+MpqvSL23I1Sn8cQ9e8EyUA1E/z9zGR9fi8liOsx
	 uuI+T7HlIvCfJfcW4vO1n4lsxdBOTzotvyvIJjYIPCzS5PWMjU8pM3wWYrV1wiPB+w
	 81BDWUwfN2msLLPrTS76skGrw6FuzKu5prrMZtlgtJyIcI/rdxk
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3C845200AF;
	Sun,  2 Feb 2025 23:13:56 +0000 (UTC)
Date: Sun, 2 Feb 2025 23:13:54 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: M Hickford <mirth.hickford@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Patrick Steinhardt <ps@pks.im>,
	soekkle@freenet.de, Git Mailing List <git@vger.kernel.org>
Subject: Re: "meson test" very slow on Windows
Message-ID: <Z5_8MuRxJKZm2bdH@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	M Hickford <mirth.hickford@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Patrick Steinhardt <ps@pks.im>, soekkle@freenet.de,
	Git Mailing List <git@vger.kernel.org>
References: <CAGJzqsmmq1R9_q=p_AsuFMFr3UzyQ4H186CpfWTnCoAnHu_OXA@mail.gmail.com>
 <89612095-6b10-44a1-a29c-b143d67ce7da@kdbg.org>
 <CAGJzqsmo988VwABNgozwQEKBe-nyfw9f2G2obygqs8OtuYpeiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yyPxVyJ3XgcL8VbO"
Content-Disposition: inline
In-Reply-To: <CAGJzqsmo988VwABNgozwQEKBe-nyfw9f2G2obygqs8OtuYpeiQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--yyPxVyJ3XgcL8VbO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-02 at 21:45:34, M Hickford wrote:
> On Sun, 2 Feb 2025 at 07:46, Johannes Sixt <j6t@kdbg.org> wrote:
> >
> > Am 01.02.25 um 23:56 schrieb M Hickford:
> > > Hi. Has anyone else found that "meson test" is very slow on Windows? I
> > > built Git using "meson compile" with compiler MSVC and backend ninja.
> >
> > The tests are very slow on Windows in general. Please clarify: when you
> > say "very slow on Windows with meson", do you then mean "slower than
> > with a Makefile build"?
>=20
> Thanks, I didn't know about that. This is my first time I've
> successfully built Git on Windows, so I can't compare build systems.
> (Makefile and CMake never worked for me.)
>=20
> Out of curiosity, why are the integration tests so much slower on
> Windows than Linux? Is it the 10+ ms overhead of creating each new
> process? https://stackoverflow.com/q/47845/284795
> https://stackoverflow.com/questions/10710912/what-is-the-process-creation=
-overhead-in-windows

Our tests are primarily written in shell, which does a lot of fork and
exec.  These are native to and highly optimized on Unix, but Windows
doesn't have this functionality natively for Win32 programs and the
emulation is slow.  Part of that is because the Cygwin-based libc
actually has to emulate it nearly perfectly for software to work.  While
a partial emulation might work in _some_ cases, it would break in
others, so a lot of care and expense has to be provided in making it
work just so.

Windows _does_ have this functionality in the kernel and it is
reasonably performant, but it's only available in the Linux subsystem
and not in the Win32 subsystem.  The tests will probably be much faster
if you use WSL, although that wouldn't allow you to build a Windows
binary.

Dscho and others put a lot of effort into porting shell programs into C
to make them more performant on Windows (and elsewhere), since this has
been a problem for a long time.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--yyPxVyJ3XgcL8VbO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ5/8MgAKCRB8DEliiIei
gYO4AQDIwzMjEhiCLyPwMai09HizNCj4cbl3mHPWOxrhK3Ei7QD8DuoNayZSDKFi
9NIeSdJDEulhKm65yDVvc5DFjzUS6wM=
=ShgA
-----END PGP SIGNATURE-----

--yyPxVyJ3XgcL8VbO--
