Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0831BF2A
	for <git@vger.kernel.org>; Wed, 22 May 2024 21:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414740; cv=none; b=C/3tP/1uK4WEeH7DXQU1RjfStKPYhzdUgn61MSwNBNYb49GlfMbS433ZZ6lbkTz+r3+BAI7iZh5/jsL0JbqFwpWL/XVdnbb1hPg3HwFkoDsu5wBD1RrxpxVv1C6ApPzQRioIJXeZ+6nNOrSs90KSVm0lRmb2oTVQDib/M+3wLtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414740; c=relaxed/simple;
	bh=yDIU9ini6Caa1D80lFbtBvrf2Rw9MTUYk4r3MHU6+oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdVVmg0Gkn9WkrrdCI9qWGG7LuOfbh3XTs+igKXKyBHzpU4YQg31BO/APDUZ63rlAHyyACLsw0HUxt5KWFacTY5bP/Egr9h4CY+QT0/Sem0iI8lFUQauECsZShfbetpGDAHq3hV/WMqdhlHjmIq8ib8jrx5LsaOm4YAST+XmZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=S0feBL59; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="S0feBL59"
Received: from tapette.crustytoothpaste.net (pool-99-237-34-130.cpe.net.cable.rogers.com [99.237.34.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E8DA95DA9D;
	Wed, 22 May 2024 21:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1716414736;
	bh=yDIU9ini6Caa1D80lFbtBvrf2Rw9MTUYk4r3MHU6+oI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=S0feBL59WZCinm0AhNHwc8W/JHYE5leJtGlubfQ+7T9lsx5VDqIJpZ0Lf42mjcj9O
	 v6TlBX/0rLp2BMbpDX3Cz1BRV8p0B/su1Bm8K/+lCUBU16d2EKFXLBBRaxiN2jS1dk
	 AV/eGXmRkWLOtLgaZyJ6KX0HnUiSBTSvuILR7QFbk1+fgFNliFZ2R72zxrGFCMRiWW
	 cvqNUddF7Jb16Y5VX3G5Fv993Nc5Gegfp5qN1Ox2Bal/flICy/3M/1PG+IdkfmetvG
	 lueXCSGF467GjHc4FNggGdsqORGa5lKs/25NGXECb6Ep5gndS2hJWmElLuGJ+pnfIL
	 hUOXKJc+yA0jj2nMfW5P0s2I7LydC/P9SQiSB89FRvzySSOaTAPtFynj5JVIXM3COR
	 8OceiX20ovvautuOmTg1hxbmXzaaWxzvbnLJF6pzLVGVJC+LqC3qlY81SnEZJgygZN
	 3ab3z+or9MYMp7qwXZC1XcV1T/xr8tT9TAv0DAJpQLhSZGoRIrS
Date: Wed, 22 May 2024 21:52:13 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: =?utf-8?Q?Pawe=C5=82_Bogus=C5=82awski?= <pawel.boguslawski@ib.pl>
Cc: git@vger.kernel.org
Subject: Re: Cloning does not work on available download bandwidth changes
Message-ID: <Zk5pDZ1gTcyrGfUk@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?Q?Pawe=C5=82_Bogus=C5=82awski?= <pawel.boguslawski@ib.pl>,
	git@vger.kernel.org
References: <ed79092c-c37d-4e4c-aae9-af68cd8c20a0@ib.pl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oqjptEbDYyCHTuOq"
Content-Disposition: inline
In-Reply-To: <ed79092c-c37d-4e4c-aae9-af68cd8c20a0@ib.pl>
User-Agent: Mutt/2.2.12 (2023-09-09)


--oqjptEbDYyCHTuOq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-22 at 15:02:51, Pawe=C5=82 Bogus=C5=82awski wrote:
> Started to clone big git repo on not-too-fast, _stable_ VDSL link (up to
> 20mbps down)...
>=20
> =C2=A0=C2=A0=C2=A0 $ git clone https://github.com/googleapis/google-api-g=
o-client
> =C2=A0=C2=A0=C2=A0 Cloning into 'google-api-go-client'...
> =C2=A0=C2=A0=C2=A0 remote: Enumerating objects: 644446, done.
> =C2=A0=C2=A0=C2=A0 remote: Counting objects: 100% (6922/6922), done.
> =C2=A0=C2=A0=C2=A0 remote: Compressing objects: 100% (2904/2904), done.
> =C2=A0=C2=A0=C2=A0 Receiving objects:=C2=A0=C2=A0 0% (3859/644446), 20.82=
 MiB | 1.01 MiB/s
>=20
> ...and then started to watch a VOD movie on same link; when VOD buffers
> data, eats almost all available down bandwidth and leaves only about 100
> kB/s for git...
>=20
> =C2=A0=C2=A0=C2=A0 Receiving objects:=C2=A0=C2=A0 1% (7111/644446), 44.49=
 MiB | 130.00 KiB/s
>=20
> ...and when VOD stops buffering and whole bandwith is available for git
> again, git transfer starts to grow...
>=20
> =C2=A0=C2=A0=C2=A0 Receiving objects:=C2=A0=C2=A0 1% (7660/644446), 50.56=
 MiB | 575.00 KiB/s
>=20
> ...but finally git throws an error
>=20
> =C2=A0=C2=A0=C2=A0 error: 181 bytes of body are still expected5 MiB | 101=
5.00 KiB/s
> =C2=A0=C2=A0=C2=A0 fetch-pack: unexpected disconnect while reading sideba=
nd packet
> =C2=A0=C2=A0=C2=A0 fatal: early EOF
> =C2=A0=C2=A0=C2=A0 fatal: index-pack failed
>=20
> or sometimes:
>=20
> =C2=A0=C2=A0=C2=A0 error: RPC failed; curl 92 HTTP/2 stream 5 was not clo=
sed cleanly:
> CANCEL (err 8)
> =C2=A0=C2=A0=C2=A0 error: 6109 bytes of body are still expected
> =C2=A0=C2=A0=C2=A0 fetch-pack: unexpected disconnect while reading sideba=
nd packet
> =C2=A0=C2=A0=C2=A0 fatal: early EOF
> =C2=A0=C2=A0=C2=A0 fatal: fetch-pack: invalid index-pack output
>=20
> No such problems when downloading bigger file (i.e. linux kernel source)
> with wget or curl instead of git clone (wget/curl transfer drops to about
> 100 kB/s when VOD buffers and increases to full speed when VOD is not
> transferring and transfer finishes successfully).
>=20
> Sounds like a bug in git; should not throw an error on available download
> bandwidth changes as wget and curl do and should not require any params
> tuning (to stop users flooding bugtrackers).

I don't believe this is a bug in Git.  The problem here is a network
issue of some sort that's causing the connection to be interrupted or
dropped.  This is very common, but the possible causes are many.

A lot of times we see this it's some sort of proxy, and that can be a
non-default antivirus or firewall or TLS MITM device, but that's usually
on Windows, and you're using Debian.  It can also be just a bad
connection, poor traffic management by your ISP, or a flaky wireless or
wired network card.

My _guess_ about what's happening here is poor traffic management:
because video is typically flagged as low-latency in DSCP, some device
on the path is prioritizing it to the exclusion of all other traffic,
which is causing the Git connection to be dropped.  I have no proof of
this, though.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--oqjptEbDYyCHTuOq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZk5pDQAKCRB8DEliiIei
gZm/AQCQKHRzSAW93dVqaPxKLDnrGtOxr4rqG+AZ0sqZt/8yaAEA0kJS10jLCcJy
KzsDixrYYaOyW3IOFqqdhRPoyD4/pgA=
=r4Ba
-----END PGP SIGNATURE-----

--oqjptEbDYyCHTuOq--
