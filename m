Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEEB1C9872
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726418857; cv=none; b=BBF5UawT+83ALcSXIlWJuTW6QfbNxM4zjy3eIn8geZ9cy6PIOkfJ6tzynJfg8rGmKCBjVjmRaljw5dRVX7fjF9oX9BPDuicwUhs88zPfgaPsAB+js9IL8B2u+kmdhUWZH7ixv2Qhn0fn/U8lSYyEEHtm6nX9TCwOA1dScboKtTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726418857; c=relaxed/simple;
	bh=XEEnQsIzr94eLkyOahLvBm0tdx8EH6B8lv1n7W8SRT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7zFlYs9URpN0bi3vVOwq0QpdZ+RXa/24fRJpJRd1emlFNCrr+FsojOcE/7SYaVgFBv16gH9ZnRQ/Z8CW7NwVWiCVn1RjIe/n57vXZ7sGnZweJwIQldfrLYC8+MAZPZ0yKscZmzBCj5ZvU0MXtI3oUoCY4kVRL3kNxFPy94NktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=kTWkWWsi; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kTWkWWsi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1726418853;
	bh=XEEnQsIzr94eLkyOahLvBm0tdx8EH6B8lv1n7W8SRT8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=kTWkWWsioXtGw2nUBH72WNNNiBbpnEQRaVqiA2xxUPvBXvsr8CE0Kb17LAb7jsC0B
	 IN5BrsbuidAG0M3HysIyTkt7ZOJ4jRsxTFZ69WZvV3Cb4GDkqoKExCKXlKGDSTPEJ1
	 FdnS48QNphi6Ln7FPjH7pTwpWd0hOXt5Nz6ZiFtfr42oHUq1Q6V+JjyerhPVPFun1D
	 GbEPnpCJpTPn8Vy6YjZCqbg95o/LL8Vjfs89ertm+CUbhB3cXjjRVxJ8hhHhqEN6sD
	 vXTabKh4AopQup567Cw3ADdeQWBQrZ3uSHP1+BqhSBGutsrkqOJ5yTdqMHVCraAZq6
	 0tjvguUpRdqoVmSWvGek5W8NAXRFNDAAjfyYVogItV7+NzkJTlisKDJoZTuuz7E3nS
	 DcVFgIJNkhLfW3jPVXQAWVVWjTuIFGcJ2DzcRuJWmXtEHBHcFXMqcKVhoHNoQHlrN5
	 B1/kCHsCW5xtvSJtsp8k1p87ONYOCPNghgb0MiW+tvslpSj+HZq
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8C0F320067;
	Sun, 15 Sep 2024 16:47:33 +0000 (UTC)
Date: Sun, 15 Sep 2024 16:47:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Henrik Holst <henrik.holst@outlook.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
Message-ID: <ZucPpLL3Q5SkVfW1@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Henrik Holst <henrik.holst@outlook.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DzarapNtvMzgvO0S"
Content-Disposition: inline
In-Reply-To: <xmqqldzsrhyp.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--DzarapNtvMzgvO0S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-15 at 16:37:34, Junio C Hamano wrote:
> Henrik Holst <henrik.holst@outlook.com> writes:
>=20
> > If I set LDFLAGS to whatever pkg-config --libs libcurl says on my syste=
m (actually: -lcurl -lssl -lcrypto -lzstd -lbrotlidec -lz) then it compiles=
 just fine. If I add LDFLAGS to the configure environment it will accept th=
at test, and then detect, as expected, the pkg-config settings for libcurl.
> >
> > Should not ./configure FIRST check for a pkg-config environment without=
 assuming that even the most trivial curl programs should compile without a=
ny additional dependencies like zstd etc?
>=20
> Looking at configure.ac, pkg-config is not used for any package.
> Specifically for curl, it seems that "curl-config --libs" is used.
>=20
> Presumably the reason behind the current behaviour is combination of
> (1) ./configure is an after-thought in the build infrastructure for
> this project, (2) pkg-config was not ubiquitous back when autoconf
> support was written for this project, and (3) nobody considered
> "upgrading" our use of "curl-config" and our manual detection of
> dependency detection for other libraries to just use "pkg-config".

I'll also note that the traditional expectation is that users are using
dynamic libraries, where this would have worked because libcurl would
have been linked against all its dependencies, and not static libraries,
where all dependencies must be specified explicitly.

You almost certainly don't want to statically link libcurl or OpenSSL
because you'll have a security issue as soon as one of those packages
issues a security update, which will require that you recompile Git to
apply the update.  With dynamic libraries, security updates are applied
as soon as a new process is spawned.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--DzarapNtvMzgvO0S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZucPowAKCRB8DEliiIei
gV9cAP9DGurAagGGOtDO5x8WzZsbLhBJXmrHe7fFThjKcklsBQD+I1ZrTsHa/dtQ
XhNG47fdL/xNevRtweOrhOdBR+sy8Q0=
=Vnwm
-----END PGP SIGNATURE-----

--DzarapNtvMzgvO0S--
