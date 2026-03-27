Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD79439A7F9
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774649165; cv=none; b=kEAw9XzJL3WfM1loHpb7qmh2QbWlwYVDjV+bs9SAWMH0mzJOkeAt7haPITgJMWU62HHxsIk7Rtrs7WJlhYpgDx9u0J3/QtO8lD1HRng6Fznm7ofStroovRoSqCfHUU14C4xcdrFU8cRIVEGgPae/qvVHGRR6ZWDwsG2nS2PTuHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774649165; c=relaxed/simple;
	bh=7knKvLgd5uKbEYyU8nKkdXDAg94pnTQif99+RUboTvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cshB9MZlcjhJb7fWCZYqqNjpGHLbwEGdRgqJzrqno72WznE60WVaoX+Y5wsRCvPoNmNNfxb7eyA+OA+aJep33iHnkO3If+9qcyRtkT0k6sbzefRxBMfmFnX1yDQiL/rk+eJP6W5EL0twsMXmlDEpY+Kw1yYYNvcExVv7D9xrMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=sxxk8IXI; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sxxk8IXI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1774649162;
	bh=7knKvLgd5uKbEYyU8nKkdXDAg94pnTQif99+RUboTvM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=sxxk8IXIs+QBpmnitfsnTawA8rejxBPgfZvmSoBWrQxjqXH3iIfuZLxNXmqBPCdbF
	 Pj1DEM4rP9c/cy2ZLyZyktK5cH7GZLlm6iEjzgMLhICa0ltDd+6NGD+GNrGSiPYXBR
	 Bzh9beifQomueXavjYzvhotonn9D0Yrr5fW1GFUxST+Kr18Zgmc2w/ndkHLCviJlHK
	 sNV2LPYD6ILoL1Qe9h9TBL5jpdHioD5pNNpLaOneF/9CWm2xHgoJIkiJpX8/wpQaaB
	 tJ9LcvcF3U7zcXU9QcGiPwQvDQWvGN82LiKGLYGu2NbhUgMb5T8ym+esUm+OK9OX/F
	 ZKN8wUmRcqj3TfIjzjomXV/EPZByueZoSXbMQiaTJhKR5xhoCBvSg26EEMwvgMshH5
	 8hdbqoncRQ9YAQUPUifdZ707QWJy0O30Y3Lx4vg1W6PuEyJHzFqp5tTEt/EXpkNY5a
	 Y8IuVWmcwkXLTRmc7jiI3n1MCZRQRndkb/C2UDHwzHcWmox5Xq3
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:31c6:2b0b:94a9:e348])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AC7F52011B;
	Fri, 27 Mar 2026 22:06:02 +0000 (UTC)
Date: Fri, 27 Mar 2026 22:06:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Wesley <wesleys@opperschaap.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/3] Add support for per-remote and per-namespace SSH
 options
Message-ID: <acb_SQ8gdy-fQaFj@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Wesley <wesleys@opperschaap.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
 <7d3731c5-d766-47f5-af60-813b379cbeef@kdbg.org>
 <xmqqbjg9mex2.fsf@gitster.g>
 <09c5fe7d-8379-4f68-bf1c-9869e2924cb8@opperschaap.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JLcO00C2qnIjd8mZ"
Content-Disposition: inline
In-Reply-To: <09c5fe7d-8379-4f68-bf1c-9869e2924cb8@opperschaap.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--JLcO00C2qnIjd8mZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-27 at 16:49:35, Wesley wrote:
> On 3/27/26 12:10, Junio C Hamano wrote:
>=20
> > I somehow thought that this practice is so widespread that it was
> > one of the few first things any new people learn to do, but perhaps
> > we do not have a good documentation coverage?
>=20
> As said before it is weird thing to configure a global ssh configuration
> just for git transport. It doesn't make much sense.
>=20
> The problem with ssh_config usage is that you need to change your ssh
> config, which is machine global, not just git. And not portable across te=
ams
> with configurations committed to git. Myrepos is a good example of this. =
My
> former employer had this and I know the Perl metacpan project also uses
> mysrepos. Changing every URL dynamically in committed configs isn't reall=
y a
> nice ask.

You can also use the conditional inclusion functionality to rewrite URLs
for repositories in a certain directory with `url.<URL>.insteadOf`.  Or
you can use conditional inclusion to use `core.sshCommand` with the `-i`
option set appropriately.

> The alternative is using core.sshCommand to inject the correct keys, but =
you
> must apply logic there when you have multiple accounts or forges. Which is
> what I initially did with a zsh-scripts.
> Which is why I ported that logic to git itself, I thought it would be
> beneficial to have an easy way to maintain sshIdentityFile settings.
>=20
> In addition, for core.sshCommand to work you must use the full openssh
> command rather than just adding some options to it. Which is an added
> benefit of the proposed changes.

Right, but the additional burden is typing "ssh -i" for that option.
That's not very substantial.  And the existing option is much more
flexible as well, since it allows you to use other options, such as `-o
ControlMaster`, which is useful when you're using a security key and
don't want to re-authenticate all the time.  It also allows you to use
arbitrary shell scripting, too, which means that you can customize
the configuration depending on what keys are available or what machine
you're on (or really anything else).
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--JLcO00C2qnIjd8mZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmnG/0gJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZy3mhPBbEJJkSdHHb3u+CUWvxT8VLjwPd6vT+7WrDcyn
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAOMrAQDOLYkcXCzZEYspQ1yhskRVxFfm
HE4qzGuJEyGEfr16HAD/TJcX0WNh6rVUisSS600pAN+8oiJLYfeTa/KsuFYRkwg=
=0Sqn
-----END PGP SIGNATURE-----

--JLcO00C2qnIjd8mZ--
