Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACD3255F5E
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765761734; cv=none; b=mhZEdp2tinw8/OBL/ZCbdOrQDJXgk4l6bXki2+Pvi2DSgms0yEsezbdsqnMGmJahqmCDqhDxUw3M3aySuxanZyK8eX2z0OAbfsK05BM0mqZMS/Vd9pU2dryJMKiANkElcdcY63EZWWMHMW2mu/6EXbaC7AcFza7FuEOxCbKTEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765761734; c=relaxed/simple;
	bh=FZEQWCPpSQmTeHcyt2hg0VUyn9/NHmiMejya/gLj/U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPjR8UHWL2Nx1XjC/0Z8SaZQhKzy8i9rh0+tdC3GqX96tfiBqtHGM59jf6lB5if0VFuYCds/h6zvEWY/wlj1GsgV+YAO8bQsc2RO2umRbw/EcqxxS56dt4Xswv3epBC0wfulyZGDNgNUi8J6McNmLT1Ex8diAnTlCXkuelmLWhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uuN6CY2J; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uuN6CY2J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1765761725;
	bh=FZEQWCPpSQmTeHcyt2hg0VUyn9/NHmiMejya/gLj/U8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uuN6CY2JhjAqxYAX1GjIQX/je9mnoQJfOQuE8X1mQxDfQOlDSRFbBFSZ2zD2NRGbx
	 qygc/ckZK29nF66tR9hXjwmqw39436Vn6aNFvg5FcwX7D6rRBKVObEpM82l+o+5IKf
	 y7Oplcxuk2f+VzqHl5Cb5+Fo6dNTWgdAVV21crICM3khYP8TEnJb1rEDgonn3vnqmg
	 /hAVZlCcko7hRm1clVxN1ZswyWL63Kc7zAywJIn1nqnvareSYRnnoz3S+qWmkTC7jm
	 V0vS/EP3es2S7VBUyOna+8EYoGXdv+hDTDDDE+5MM9F0CMCpDPPRtKS3Y7QGHJ1OF+
	 lB2Fm/m4lPHReg32bGuDJU9UdFnijYLEGR6jcgiU1DSCv3oYrOeTO+JFvAkNuZYEVY
	 9VciqcPsyNrU2URavjCRcp+lVIzvofoV+Po1fSTgvRVIuzXyWFSnBLXEQNpB3uS2l+
	 oGzCD/KgDgoOSvEO//LtSC+FEOzRcIKSn1tKeJVBX4LNQ9TDsXx
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:1324:2c20:62f5:889d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 268032008B;
	Mon, 15 Dec 2025 01:22:05 +0000 (UTC)
Date: Mon, 15 Dec 2025 01:22:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>
Subject: Re: Would it make sense to add a commit.signOff config?
Message-ID: <aT9iu9He3yJ3npWX@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>
References: <86c5d40d-5a06-4a69-90d8-a737685b0536@haller-berlin.de>
 <aT7lkXl65-TBIsRS@Carlos-MacBook-Air.local>
 <xmqqsedc8w7k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w65js0Vrwli0171/"
Content-Disposition: inline
In-Reply-To: <xmqqsedc8w7k.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--w65js0Vrwli0171/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-12-14 at 23:44:47, Junio C Hamano wrote:
> Thanks for a spelunking starter.
>=20
> Perhaps we should resurrect a proposed patch from 2020 (which no
> longer apply cleanly, but quoted to show what the additinoal text
> said).
>=20
> https://lore.kernel.org/git/xmqqpnfw8gyn.fsf@gitster-ct.c.googlers.com/
>=20
> to save time from potential contributors?  I do not want to see new
> contributors feeling they wasted their time after putting their
> effort.

I think this would be a fine approach or we could add an entry in the
Git FAQ (or both).  I agree that this is something that comes up
frequently and writing it down in a more visible way would be kinder to
users and mailing list participants.

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index ced5a9beab..1909551087 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -171,6 +171,13 @@ The `-m` option is mutually exclusive with `-c`, `-C=
`, and `-F`.
>  	the rights to submit this work under the same license and
>  	agrees to a Developer Certificate of Origin
>  	(see http://developercertificate.org/ for more information).
> ++
> +As it makes it harder to argue against one who tells the court "that
> +log message ends with a SoB by person X but it is very plausible
> +that it was done by inertia without person X really intending to
> +certify what DCO says, and the SoB is meaningless." to more

I think the period should be replaced here by a comma since the
quotation is part of a larger sentence.

> +publicized ways to add SoB automatically, Git does not (and will not)
> +have a configuration variable to enable it by default.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--w65js0Vrwli0171/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaT9iuwAKCRB8DEliiIei
gbjcAQDT4aMjWXunWEu7rYQw0aVmgG+bcaF1y/GuTfz+GWsoNAEA4a6OWmdXMVby
3dqhquWh33n7JQ7EOkY9+Jpf3xURGw8=
=jeWG
-----END PGP SIGNATURE-----

--w65js0Vrwli0171/--
