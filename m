Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636922862BC
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917851; cv=none; b=UEbwvuCOxTHnMJna1ipLW7JvwW9zxVDp4xEg6FA8tMFYlHhKw0cb4xk1j+kB55i+oN6Xvod2qG+lOHe5bokakZ4KWms6e8IkjRM/3umA6QuMNC4cp3XHIifG0opBIMnAyVHWepvlJBSw9PqltguPBFknSQyAwUZLOD+HJRiXrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917851; c=relaxed/simple;
	bh=Lh5j6QnxpgnVhrPmEHfuIo6DXh2JAxGalTgBJU142LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGmzcKrEWa60gAPngexXzdr81sRsoFd8i5fYhRW50lZRmDGR0swnGrUMNqr1s+Ea/g28J+RsHg+kMmJZOyqvOOY0FJICxd8PjycmKyc9Nh+/xaeraykbj56J8X6BKIVlOO9Ggpn/OanWHNe9RANQIm+YwH7WorV7BXds/2R1mro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=mGx+0hW0; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mGx+0hW0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1739917847;
	bh=Lh5j6QnxpgnVhrPmEHfuIo6DXh2JAxGalTgBJU142LY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=mGx+0hW0ZYBFZ7xvCGfP6MIKj59qRBlSf4xweMKXv+z1B+OwuQbekqNEQnzmLvUHr
	 9zhxSCUoKHL9AEkWDKl6/7jhorNG+d/ayUglB5VXzR0vVaV1AyMjNxmU2F1trEQCaV
	 5xegeZdR4A7egqUG8TnRAVEUr3GkRW9ms18RKxtwWzqnED8e3+pdgXiwgt/dlzhFpI
	 ItFPSItJ6TBchgUFW1K3DmRj8culB3SAjlRzPS1CNSq9oGr9ddqfWEQBVPmXtVB7tm
	 v3oiKf8//VEh+5tHW4jx+Sq3zF6dcPpTrbd1XUe6gCZaSXDvwymNRUSC+mbUWQk6yA
	 5amRTSMap8fdqMPlLNMTsXh7cwTPrT/tNFA+Ir70g48+CrPcaRjNVihI3fdO5iOHaT
	 NPbJd9ohCTISkFnPxRh0fddDigSDgi+MYhOHVwlVVJV6krg9Ooh6+Pz4Ag8otY/Nca
	 B4bY3Em6CNIeZm+wurYOAspsoXl3Dc25sxCviUI2WPClQggZYzp
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id F2D732007A;
	Tue, 18 Feb 2025 22:30:46 +0000 (UTC)
Date: Tue, 18 Feb 2025 22:30:45 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "Maloney, Bryan" <bryanhm@amazon.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"Perry, Daniel" <dtperry@amazon.com>,
	"Das, Satabdi" <dsatabdi@amazon.com>,
	"Damojipurapu, Deepika" <deedam@amazon.com>
Subject: Re: [Bug] Git ReadOnly Temp Packfile Causes "Bad file descriptor"And
 -13 Access Error With NFSv4
Message-ID: <Z7UKFQHHBJLfLrjY@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Maloney, Bryan" <bryanhm@amazon.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Perry, Daniel" <dtperry@amazon.com>,
	"Das, Satabdi" <dsatabdi@amazon.com>,
	"Damojipurapu, Deepika" <deedam@amazon.com>
References: <1628B638-81DC-4116-BD7B-85D691B54331@amazon.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fSdVlqfQALMTMAqy"
Content-Disposition: inline
In-Reply-To: <1628B638-81DC-4116-BD7B-85D691B54331@amazon.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--fSdVlqfQALMTMAqy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-18 at 21:35:42, Maloney, Bryan wrote:
> Good point on the POSIX compliance. I'd like to call out that this
> behavior of re-opening the file during NFSv4 state recovery is
> according to the NFS spec. So this scenario isn't something specific
> to just this filesystem. I think it comes down to NFS not being fully
> POSIX compliant in all situations.

I haven't read the NFS spec, so I can't speak to that, but I suspect
it's entirely possible to have the NFS server paper over this problem
during state recovery, which is what I would recommend here.  That might
require an in-kernel NFS server (which Linux has) or some sort of
shenanigans under the hood of a userspace server (e.g., temporarily
changing the permissions of the file but exposing the existing
permissions to clients[0]), but it should be possible to do.  I can
imagine doing this without a problem in 9P and SFTP (which I have
implemented), for instance.

In general, I'm loathe to support a file server that's going to
spontaneously decide to produce EBADF in the middle of operating on a
file for any reason, since that's asking for a bunch of hard-to-fix
breakage.  That also exposes a huge race condition where we thought we
had a valid file descriptor, but it got closed for some reason and then
another thread opened a new file and got assigned the same number, and
now we're writing to a file we didn't expect.  That will very likely end
up with repository corruption, which would be really bad.

As Peff said, it's possible to work around this particular problem, but
I'm concerned we'll find more weird edge cases that will break and that
it will lead to data loss for users if we tolerate the NFS server just
producing an EBADF at a moment's notice.

[0] This is grossly oversimplified and has a lot of edge cases, but I
can imagine how I'd go about it.  It also depends on how you're storing
the files and a lot of other factors.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--fSdVlqfQALMTMAqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ7UKFQAKCRB8DEliiIei
gX+BAQCko0qh0+MuXbRpGuCI5ZdAcbCxI9fgxD+tvlBDpqbhlwD/Xrhn8o71ahRx
cSeNgTc0aEVHwmzpI7Znc+7HLBG8rQs=
=ZN4D
-----END PGP SIGNATURE-----

--fSdVlqfQALMTMAqy--
