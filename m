Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989DC8495
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720994497; cv=none; b=XSKW7LRY1vQAV6RtSOF79wcbuNzCSbdb9ArmdVBfU3kWALqVFt+KOqu7Mh1aoI5BVomY96YLFBlqyZoEaroFMDPYYoa7BR0Baq8tK3gsKBDDowI/vvgToV0WdgFhCp/1yvObVRcemgEBs2tK0hhpVY2GgfdVp0hKtMSno3dxIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720994497; c=relaxed/simple;
	bh=FsyWlgE+cbU+sLMRQ+ECHfSFXU/gsL2jidmhnyD//QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izxXtQQ05t04iz3HyXvISOqLFwfoE6NhNGxd1j4ppZgRobo5m8Rg8IOsvrA9t/4Igl1e+BYGbBs5ewigEusKqSLDJITyB6cr8gJqalvKLcETPk22SBijBAk9jX25pnnfsuhobOTZOxVDsiTTVM/CJHnuH/NQ0bmU/cwi3hVjVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=J5KxX5op; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="J5KxX5op"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720994493;
	bh=FsyWlgE+cbU+sLMRQ+ECHfSFXU/gsL2jidmhnyD//QI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=J5KxX5opch4hQOdmk3+7evbmhw0/Y7E++h4h5j1OFL6y+IC2pAvNIm4avnccrjEx+
	 gGeoC+06upybryRTDhPY+G146CutboZdbxClWY5JbbDf+jpK8QKVuDnChAV1FtfhDq
	 VWYgZEziTxCKodvcfjO+iBBMiOkD1jQtgaJGap5pn42G85sId8N5Jx3u/yYEBuIaet
	 +qWn2vTvWV3MRnVk8ZYvZYpReUWj1mrxnG1CFiTNx2wcm13cmgPKsnyVfrunzjDfhs
	 ZmOL6caEM1i8DypiYWiOs+EezIWRK3W4YdfJbJKZKuSi2p6Ej/95YaricLKU1PJn8y
	 ypW0c5FZ6y05T5lwz8L5sbXlX6L9YTAKIfF17y9Ng0KoqTRpJzPOnF5HV1p2L0IhTB
	 4tZ4ucb5YaG78ZuY5/ap3Ys0h2E0VK3rLZa55txEr6tu4Jdrn8Kz1UT34gmIaOHkmc
	 PMx/dSm0VIWfukeanV6nSOzGkUi3kYhasXfycJk1X4Y/9MX+tf/
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6CC5620991;
	Sun, 14 Jul 2024 22:01:33 +0000 (UTC)
Date: Sun, 14 Jul 2024 22:01:31 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
Message-ID: <ZpRKu8Xsz70xNHFp@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
	git@vger.kernel.org
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com>
 <xmqq8qy4adl4.fsf@gitster.g>
 <001f01dad5f1$e518e6e0$af4ab4a0$@nexbridge.com>
 <xmqqttgr9aeb.fsf@gitster.g>
 <ZpQVwyVQT8Wf5AeX@tapette.crustytoothpaste.net>
 <004501dad61b$b35b7f30$1a127d90$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w+a3qk7OmIryF/e/"
Content-Disposition: inline
In-Reply-To: <004501dad61b$b35b7f30$1a127d90$@nexbridge.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--w+a3qk7OmIryF/e/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-14 at 18:28:56, rsbecker@nexbridge.com wrote:
> On Sunday, July 14, 2024 2:16 PM, brian m. carlson wrote:
> >I don't think this is the right approach.  Every version of ksh _except_=
 AT&T ksh
> >works just fine here.  pdksh, mksh, lksh, OpenBSD's ksh (which is also i=
ts /bin/sh)
> >work fine, as do bash, dash, FreeBSD's sh (ash), Busybox's sh (also ash)=
, and zsh
> >(when run in sh mode with 5.9 or newer).  AT&T ksh is considering adding=
 local in a
> >newer version for this reason.
> >
> >Literally only AT&T ksh is not supported here, and so anyone can set SHE=
LL_PATH to
> >any suitable shell.  I don't think it's useful to get rid of local when =
there are a variety
> >of acceptable and portable options.
>=20
> We can add NonStop's ksh to the list of not supported. I'm using TEST_SHE=
LL_PATH while running make all in the t directory. Test passes when I use b=
ash. For some reason (maybe GNUMake 4.1, which is what I have in my POSIX e=
nvironment, I don't get TEST_SHELL_PATH passed down from the outer Makefile=
, but I can work with that. t0021 is now passing in my current CI stream us=
ing bash 5.0.18.

I think we had discussed that you were using AT&T ksh on NonStop, which
would explain the situation.  That's the most common version of ksh on
proprietary Unix systems, and you can usually detect it with something
like this:

% ksh -c 'echo $KSH_VERSION'
Version AJM 93u+m/1.0.8 2024-01-01

Variants of pdksh look like this (this one from OpenBSD):

% ksh -c 'echo $KSH_VERSION'
@(#)PD KSH v5.2.14 99/07/13.2

And mksh and lksh (which are the same shell, just compiled differently,
look like this:

% mksh -c 'echo $KSH_VERSION'
@(#)MIRBSD KSH R59 2024/02/01 +Debian

% lksh -c 'echo $KSH_VERSION'
@(#)LEGACY KSH R59 2024/02/01 +Debian

I think using bash as a workaround is the right choice here if all you
have is AT&T ksh.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--w+a3qk7OmIryF/e/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZpRKuwAKCRB8DEliiIei
gaN+AP9tIT9zQrKLsmRTDvUynxKJ2aWq+V2JTBy2i0FsmORgxQEAh7GwioEIwn9h
W6vSVZHigoUpwNaRyuAhwiA6qMktaw4=
=qWe4
-----END PGP SIGNATURE-----

--w+a3qk7OmIryF/e/--
