Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3585A4C0
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709928679; cv=none; b=rGiV/AA1VMLrYwc3KEcEPY4kWLizfpoEkMPTqcV7Lp31k/H5YCz23d+fSo+fRQqexXZFnDTLXvL4IzVXsDc5JYVr9+tfaZIK/5Fhvx0/bQCKPkD2MAhLUvDDfYUvo7C2ygRsxkpHPMi+xJj6j1zXcBSg6eVLQsNfNbZ6dtEGwFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709928679; c=relaxed/simple;
	bh=hBlg5uGlqVmz1ki/alts1cfBtdazvsa9SLLYI+iCRpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Px5/mv53cLobkAn5pePsQBI6tmfOEl9sNryEShao+5AgLez6baHT6bkFCGh6GZysLBq3kOJEqo99EGV7WI6V6Soi+DoweRR6epAJWlsAKKSpwnmZH4vRZ2rDVkgnBsOzpRNpyiIVe/plwqr2hI30fCQESXtMZ9cdXtYpHuJ2M1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=AlsgaCCQ; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AlsgaCCQ"
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id EEAA45B3D1;
	Fri,  8 Mar 2024 20:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1709928672;
	bh=hBlg5uGlqVmz1ki/alts1cfBtdazvsa9SLLYI+iCRpA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=AlsgaCCQh3gYuNou4SPXVtFXPFFNzfGmS7Q+SpI1pzs8LjQrKHZYPEqK1tpvXpi1+
	 FOpqgidvk1qF9XxyFdRiXOUueFNULmwm/kGtWhj2fdsYHk8QiyaWUSTZs3zGZ0bQAI
	 gUza6/r2GGNap8VFBFSJEfj0rC+YAbAOh027cNtCbpGGxEJtQ5u5RAu0JuCPOEJKqc
	 8qzdfKDoTFtRmJmRCRszNkTWHaqS36Nd7xeEO9IHf5Bl2W7nDKE/B2fj86vg10y6qF
	 xpSMnZHcHfbfwxQfTflULN37UQohnrqNPZedGYAUlFcjXcc698vjgYqSAO0Ga05wdQ
	 wHAYbYZremAjaZcNpxM0pYs8MUR/tXHSHRhF9SG86P7FZaF2qir041aCRtfDDaGqbZ
	 IFmqPG6Cnha0dWrCtaAokr0pj5OSuCXA+SCgMf7QcJNECOtfiONcojrfzk4ZELzjul
	 OEr/lHfjFqd+Sphoybj5rcU0ZYR0tRlIA0PQu2fwedfJul319XE
Date: Fri, 8 Mar 2024 20:10:56 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [BUG] cannot git clone with includeif onbranch
Message-ID: <Zetw0I0NHgABR_PX@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Angelo Dureghello <angelo@kernel-space.org>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <72771da0-a0ef-4fd9-8071-6467cd7b6a6b@kernel-space.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cqllC+XpDcnCvTj4"
Content-Disposition: inline
In-Reply-To: <72771da0-a0ef-4fd9-8071-6467cd7b6a6b@kernel-space.org>
User-Agent: Mutt/2.2.12 (2023-09-09)


--cqllC+XpDcnCvTj4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-08 at 19:25:52, Angelo Dureghello wrote:
> Hi,
>=20
> below the bug report, not totally sure this is a bug btw.
>=20
> ---
>=20
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> Perform a git clone https with includeif onbranch in the .gitconfig
>=20
> Create a .gitconfig
> with
> [includeIf "onbranch:wip/pippo/**"]
>         path =3D ~/.gitconfig.pippo.inc
>=20
> git clone https://github.com/analogdevicesinc/no-OS.git
>=20
> Cloning into 'no-OS'...
> BUG: refs.c:2083: reference backend is unknown
> error: git-remote-https died of signal 6

Thanks for the report.

I can definitely confirm this with a local Git 2.44.0 built out of my
working tree.  It seems to trigger as long as there's a `path` entry
whether the path exists or not.  It _doesn't_ seem to trigger with a
`gitdir` check, but does trigger for `onbranch`.  v2.43.0 is not
affected.

I do definitely think this is a bug.  First of all, we should not
trigger BUG conditions, even if the user has done something naughty, so
we should fix it for that reason.  Second of all, this seems like a
completely reasonable thing to want to do, and considering it triggers
for existing files, and that it worked just fine in v2.43.0, I don't see
a reason we shouldn't have this work.

A bisection[0] leads us to 0fcc285c5e ("refs: refactor logic to look up
storage backends", 2023-12-29).  I've CCed the author of that commit,
who hopefully can provide some more helpful context.

I have some guesses about what's going on here, but I haven't poked
further into the situation, so I'll refrain from speculating for now.

[0] git bisect run sh -c 'make -j12 && cd $TMPDIR && rm -fr no-OS && PATH=
=3D"$HOME/checkouts/git/bin-wrappers:$PATH" git clone https://github.com/an=
alogdevicesinc/no-OS.git; RET=3D$?; [ "$RET" -eq 128 ] && RET=3D1; exit $RE=
T'
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--cqllC+XpDcnCvTj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZetwzwAKCRB8DEliiIei
gQOSAQDux3SSaEzihf0KQYvijpw8/kRV9ncdjDPxTN7KxaA9ZQD/bbJvxaz2qI8c
POsRaPwb+ZjFWuh1Zaizhxvgdx/A9Qs=
=ousQ
-----END PGP SIGNATURE-----

--cqllC+XpDcnCvTj4--
