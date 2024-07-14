Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA0F381A1
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720980943; cv=none; b=bktuiXdVYsiw5ok51juTgWyZdEtXzKNY5gKf8ofcjGuceg0pDbmxD/YgFn1MV0MnNQhKM2WaTXKc0WqcqxFDQAkZomGOSEuu3ZfQ4KHKQllESLDKBQ50iH4NsmXgCqn2os1j4XxB7Wh+U05HSLyJzGj1UiocL0pjBSYfHnr1bG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720980943; c=relaxed/simple;
	bh=i1wYiadpUwOM3ua3V5frJE0MipKy2MWHH+l6YBQpAEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfponktkFLYiC/vfL2wft9pdEFiWIEhCPA/ljIkVmubM/grtNt5il1o6TGSYaxjUbWkX8PTUA4xy3QKBRJK2ayRDuleRTEQKnTmFkIvgOevsN4qXFqJvlskTIlgaEbkGqY+1TVh3LDupLzdduouOa2Yw3qv9Cc13thvsM1RwJgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=1LmGK2lD; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1LmGK2lD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720980932;
	bh=i1wYiadpUwOM3ua3V5frJE0MipKy2MWHH+l6YBQpAEE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=1LmGK2lDmLfzLyga1/DyUt/0xzGhOK0y7hq0rQ+cAqtLc9r/g+6ZdQZALhSwOjV49
	 pYZRNU1T08Ilt4O0jpSZZDSYC2hjIxDZlRM88I4w2IQvNjNx2McmdRXNPWlrNPuqKc
	 8iLsmobocVmJE27GJu5u8d+phAt1JKrsAOdFwJAhzb/vBI3BiZq9HLB0MYgJl7ys3R
	 T9BD+SCxLTseiip7PIbcioiAsi3CfzXivM4T5f7FcvGtI6hqtzOrX9gas0AGZhErKT
	 pdcr//bEsw54us/RCSd87xJXpwGmK/w7kLnW0s6OdGYFk9Os+U7GmHBA6upHiIo5i6
	 BBj5TjK14NSC/Iw6S6OP2QjN8HFNKgeSymIP5zpTzyjK7V+4J7ToTslnT18SRyDC7a
	 9EJp/QspZ968ZFZ8tD7igLpWjCzcq08EhC9xR2WhGljczeGGOE4jTZ6vNRq/fnnAtw
	 jUWfZTfsZHj+QSw4H6AueSrOxmj4yP897AROdEtRpJ55BgyApnI
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BC9C820991;
	Sun, 14 Jul 2024 18:15:32 +0000 (UTC)
Date: Sun, 14 Jul 2024 18:15:31 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
Message-ID: <ZpQVwyVQT8Wf5AeX@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
	git@vger.kernel.org
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com>
 <xmqq8qy4adl4.fsf@gitster.g>
 <001f01dad5f1$e518e6e0$af4ab4a0$@nexbridge.com>
 <xmqqttgr9aeb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KJxzzYsp6W7ZvMND"
Content-Disposition: inline
In-Reply-To: <xmqqttgr9aeb.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--KJxzzYsp6W7ZvMND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-14 at 17:00:12, Junio C Hamano wrote:
> <rsbecker@nexbridge.com> writes:
>=20
> > This looks like a different between ksh and bash. Under bash, the test
> > works. I can live with that but will have to force bash to be used as t=
he
> > shebang #!/bin/sh defaults to ksh on this box.
>=20
> It turns out that the version of ksh I used in my description does
> not seem to grok "local" at all. I vaguely recall that we've written
> off various hobbist reimplementation of ksh as unusable enough, but
> this one is ksh93 direct from AT&T Research.
>=20
> I guess when we said "as long as we limit our use to a simple 'this
> variable has visibility limited to the function and its children'
> and nothing else, it is portable enough across practically everybody
> we care about", we have written off the real ksh, too.
>=20
> In the meantime, we may want to document this in a more prominent
> way.  Perhaps like so:
>=20
> -------- >8 --------------- >8 --------------- >8 --------
> Subject: doc: guide to use of "local" shell language construct
>=20
> The scripted Porcelain commands do not allow use of "local" because
> it is not universally supported, but we use it liberally in our test
> scripts, which means some POSIX compliant shells (like "ksh93") can
> not be used to run our tests.
>=20
> Document the status quo, and hint that we might want to change the
> situation in the fiture.

I don't think this is the right approach.  Every version of ksh _except_
AT&T ksh works just fine here.  pdksh, mksh, lksh, OpenBSD's ksh (which
is also its /bin/sh) work fine, as do bash, dash, FreeBSD's sh (ash),
Busybox's sh (also ash), and zsh (when run in sh mode with 5.9 or
newer).  AT&T ksh is considering adding local in a newer version for
this reason.

Literally only AT&T ksh is not supported here, and so anyone can set
SHELL_PATH to any suitable shell.  I don't think it's useful to get rid
of local when there are a variety of acceptable and portable options.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--KJxzzYsp6W7ZvMND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZpQVwgAKCRB8DEliiIei
gQ/wAQCQdZEVoHxWkPy/r/Q6L5ucEgWS/VX0mCbsK1HVS5n2iQEA9rlhn+twbEzk
X8sh94fC7vdvt+Oc5M5bON3SfOWvfQY=
=DOwQ
-----END PGP SIGNATURE-----

--KJxzzYsp6W7ZvMND--
