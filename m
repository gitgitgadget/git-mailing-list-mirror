Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A16D1EA7DB
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964705; cv=none; b=UhduNdhQ8by5nop2gr/3OzgFU0rkgRkvYEvMZLxh4hWp96PKw7k11qLLljU8PwaktkcfbK++WpxKIJSD0V1Z6l5BM+JSA1fo/6u+0OqbKVtnT4gglA+JJQrinGMjRZXGeb2G2Mb4IrAJrSPMvMa+1oRKJdcMeXCr3FyIFsX+LHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964705; c=relaxed/simple;
	bh=SDSSxlaXbBn45C+KjL5hqejMEH/n6Xi7Be4C7BpV2Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PguVGOBfhQGQEPXzQu8cJjjgvpCT8K/sWReKwG99OO2sjv5ZWYmlfCWxLjq52fm7JRdelMQx3tMRmVBscHUqtCubLkQMZbhNHI7wAFFlc80zunyHflWLdmycDmW393D0loWBQMEWqA7TYZGvF09Mw/NjAo42VDZiRft6zzh+J1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ZwdQmZue; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZwdQmZue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1767964702;
	bh=SDSSxlaXbBn45C+KjL5hqejMEH/n6Xi7Be4C7BpV2Kc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ZwdQmZuez6EvVb+Dm49eQN/QU9RqZ0m8gtD0VZj1i6KgGQAZapC/wkKtWUb2ei5SD
	 l1mFAKiXBqzjAww4dk0bUWaoq1g1ZuLJFA440oJojH8F1mgFUbjXHBzHaleBKWWJPf
	 y/nwX0ltBHFrSiQyJbXAIUlXYVnkrcMvIVRTnUlrbxEmSBKXqDH/G2L60RsDAG3wWk
	 pfa8RkpgaXziSQ63EJMMumVqEMkC2+G59umxn62tlMnI5+85HDVYj2fGZIfNhO7JOp
	 tCsD1s+dhj6Ym0DUHQDD94hvdjZwSVwe3hHvOr9H5PalxhAA1kBclY5qZDxa4qMMWh
	 liIH179/lGUFcnUFDSA6N2PDFdXTHbEho4Ud/rp2Ksej8YQ1nzojv0OeEFNDQtfzwb
	 nvEOIEXKDUN9XEPVXJY7xaCAnzLUacgJEaU/LlWdt0cXDuC7v218yhcjn0zTRuKTLd
	 XlCkxHQECS/NN8uBPXIVU9H7IKslS0VkpL9dgrcaZ+AeeT0U2kb
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:8a11:cf76:28ff:b0fa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6660B200B5;
	Fri,  9 Jan 2026 13:18:22 +0000 (UTC)
Date: Fri, 9 Jan 2026 13:18:21 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Simon Cheng <cyqsimon@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Feat. req.: add a flag to `git clean` to also remove ignored
 nested repositories
Message-ID: <aWEAHQLzwTxCpD5Q@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Simon Cheng <cyqsimon@gmail.com>, git@vger.kernel.org
References: <CA+itcS3-RQ=ESqcWj0Pkw=N4e4gwaz2fp2xH2M1MPXQXaMDmCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0epUbXcIOV3Axzok"
Content-Disposition: inline
In-Reply-To: <CA+itcS3-RQ=ESqcWj0Pkw=N4e4gwaz2fp2xH2M1MPXQXaMDmCw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--0epUbXcIOV3Axzok
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-09 at 03:50:30, Simon Cheng wrote:
> Currently, running `git clean -dxf` on a repository that includes
> another repository under an ignored path would skip said repository:
>=20
> $ git clean -dxf
> Removing foo
> Skipping repository ignored-path/repo
> Removing bar
>=20
> This is to request the addition of a new flag to allow altering this
> behaviour, i.e. to make `git clean` remove those repositories too.
>=20
> For me, this feature is relevant for building `*-git` packages from
> the AUR, for example https://aur.archlinux.org/packages/paru-git. By
> default `makepkg` would clone the source repo into `./src/NAME`, which
> creates the aforementioned condition. Without such an option on `git
> clean`, cleanup after build is rather complicated.

Does this work if you use `git clean -dxff` (that is, with a second `-f`
flag)?  I do often clean up ignored repositories that way (and it's
documented to do that in the manual page), but I'm not sure if you're
maybe doing something a little different from my workflow.

If that _doesn't_ work for you, would you mind creating a quick shell
script to demonstrate the problem that you're seeing so that we could
provide better advice?
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--0epUbXcIOV3Axzok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaWEAHAAKCRB8DEliiIei
gf7VAPwKHocsvRjubgc5kTX/9LMfj0l7GG+PfTMyXhP+nnnoxgEA14SqVk32Z/ym
U1SYB5JLUXYHYuxMt3dqR2xwJ5pu6wU=
=Kdn8
-----END PGP SIGNATURE-----

--0epUbXcIOV3Axzok--
