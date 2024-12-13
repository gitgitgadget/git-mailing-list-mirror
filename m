Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE57915F41F
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 03:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734061286; cv=none; b=B4+KHwCSiAKTuiUUR0ySKLroSrsro8s3UKvh/z4PgvrZ7u7ypRp7vchP3s4LaDMK2jigic+YQqeXifaWba3H4is7eYE4gujn0Zpf4SdoC00Hamtnd7vCEdBSZ7VHc74ZbS3N3UCuOZU8dajSYZbNbVng83sIDLC1n9Vv1jtTFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734061286; c=relaxed/simple;
	bh=YGLEeFXjIneN1jQ2fVKpWhixDcn24aE6TlGAS1WYCew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZrXOU7Hbl9b8hDw6NfHx95SWut2T5xgnugrWaQE8fdBwyZYCqRZZyGCuFT+NpM4cf1zjpLg+jzIIq7lw/YbKI6Vs6qVqotVl1zH4ITAT9qx8nDw3iODna0UrknVrojBhGvA2gbHoPHzBqFnfXR4OC15Kr72l1Opks00qQvZAO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xdvMqcnX; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xdvMqcnX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1734061276;
	bh=YGLEeFXjIneN1jQ2fVKpWhixDcn24aE6TlGAS1WYCew=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=xdvMqcnXM91j3Y68czK9H9PSaom7lKcnywtEm1FeRS4eG1O+RUr6J3WLZ+mTTw7CM
	 DoS9FhN8Hp/JbvaouFJyu+0QiM15RJPCPbXBUtMDaJgP9hNHdK900RV/paef9SuM0p
	 wIf/BzXDhHW5IQEWcDm918rAc8GKy/kUcsdrEsePksJ37q4tc+KQh/tag8zwAh5Ges
	 6ExU8Bmobbws8pKem2E6ZcrN10ihbCht7fxtMHXUdqpLtFvhPYRgOJKOjYHeCEZhgY
	 4RkDQ2hWaUAC0b3oLd9Q1YKBKHKQaeOe9a0T0fTKpHM9X1ikedtxAB7tgwhkUDLQTB
	 e0LDTDGFZo6nh2Mb86DEIaGALtwyiBj1ZKF9pcBQao0e0Z1LAHH3kq+OkdKSlQEO5Q
	 Z1BNztxjQE1Krv0wetTyzGN3bdOb+ByNNAnOmXKEUPBCInscTKbJgoD25G6JmwRyVA
	 wn3nJEsu3i4HKf0ZO6l89MfYchAbTVuI02YnLzImUbfX6wYTG/d
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9CD03209AD;
	Fri, 13 Dec 2024 03:41:15 +0000 (UTC)
Date: Fri, 13 Dec 2024 03:41:12 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "Konrad Bucheli (PSI)" <konrad.bucheli@psi.ch>
Cc: git@vger.kernel.org
Subject: Re: chmod failure on GVFS mounted CIFS share
Message-ID: <Z1us2FpyObVpJlsM@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Konrad Bucheli (PSI)" <konrad.bucheli@psi.ch>, git@vger.kernel.org
References: <d26f4b93-57a3-4536-8c32-3ed5b3e98a86@psi.ch>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nqprz+4ewWLy9xJ5"
Content-Disposition: inline
In-Reply-To: <d26f4b93-57a3-4536-8c32-3ed5b3e98a86@psi.ch>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Nqprz+4ewWLy9xJ5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-12-12 at 09:14:50, Konrad Bucheli (PSI) wrote:
> Dear git developers
>=20
> Below my bug report:
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> I do a `git init .` on a directory which is CIFS mounted via gio mount
> (FUSE).
> On RHEL8 this needs gvfs-smb and gvfs-fuse installed.
> Mount command: gio mount smb://fs01.psi.ch/my_user_name$

In general, gvfs's FUSE driver isn't a good way to interact with files.
My experience with its SFTP driver is that it has a bunch of weird,
non-Unixy behaviour that's due to limitations in the gio interface.  So
it probably doesn't provide the functionality most Unix programs will
expect from a file system, which will cause you a world of problems down
the line, as you've seen here.

> What did you expect to happen? (Expected behavior)
>=20
> It initializes the git repo.
>=20
> What happened instead? (Actual behavior)
>=20
> $ git init .
> error: chmod on /run/user/44951/gvfs/smb-share:server=3Dfs01.psi.ch,share=
=3Dmy_user_name$/git/foo/.git/config.lock
> failed: Operation not supported
> fatal: could not set 'core.filemode' to 'false'
> $

This is indeed the case, since the chmod on the config file fails.  We
always rewrite the config file as a separate lock file, and then rename
into place.  (This prevents concurrent modification correctly even on
network file systems.)  The user generally wants the permissions to be
preserved, so this is the safe default.

This also happens when using a Linux Git on a WSL Windows mount.

Note that even Windows honours the read-only/read-write difference for
files, so in theory chmod is useful even on CIFS and other Windows file
systems.

If I remember correctly, the consensus last time this came up was that
someone is welcome to add a config option that ignores the chmod
failure, but that in general, we don't want to just silently ignore it.
Unfortunately, nobody has added such a configuration option yet.

I will note that the `mount.cifs(8)` manual page[0] indicates that the
Linux kernel CIFS driver _does_ silently ignore chmod operations when
the server doesn't support them, but it also supports using and storing
Unix permissions if the server does, so that may be a workaround.

[0] https://linux.die.net/man/8/mount.cifs
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Nqprz+4ewWLy9xJ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ1us1wAKCRB8DEliiIei
gQ41AQCoYQjZnkphhZfTyqx1axtx/YencOpAh1oHMBqYwtISowD7BU8lB8/7XEI3
THeVHn+J1QpNigMpOOc+G4U7VdUKgAY=
=SCB4
-----END PGP SIGNATURE-----

--Nqprz+4ewWLy9xJ5--
