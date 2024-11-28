Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA102837A
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732814731; cv=none; b=kq/emAEBojhl/geqnjmmfETos4RmEc4lPKECx2U4WfyjKcIAdDgOjOM0mOzlyQGDff4GSPlIdHmNsLKWXKr3zg7vqSHevZ0kuPi/FJWHTKMuWDyhkbyOgpCAP4MUZl3QoLp/wvWRbHCskCmsRCt0p0Jbo1F/rTa/qzrAs+tkwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732814731; c=relaxed/simple;
	bh=K/2e1K+KzaPTUWTV27hjiqcs8Yp7XYy4PO+XXxgSDGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qbm2CN4nam1pjHfYgZnrj8Ax3QJsA7GUkAxdkHeDYjTF9qhVzV65v9qNSQZTTGjRQAI3SNzLOALWoqGsuzk5/4Ixjh09UjHC8Bxt7l2EesOJ6Mp1EB1OQrIWHnCPjcM9etIUYDr3fcKMZAxP/ePMIWKyJAuoAcLn4NDvy9OCQH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=cp4XhUo/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cp4XhUo/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1732814721;
	bh=K/2e1K+KzaPTUWTV27hjiqcs8Yp7XYy4PO+XXxgSDGM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=cp4XhUo/y4Mv8Khz/NjxMAPsA/p1BoxVlnBlKlYiKRg8wBx/0rzFgUA8t98bBeYVh
	 A6PBjq1bieSGY6vr9RimpQRkVlaVjYzN3j3JGUWJjXZ6VjbBUX2L3GNITA+QPwufpH
	 ig8c3MsdGuwbZbNCZLZZGG6wr/bni6jWfm6zyWo+B8+fnB4DBWLhKBSLeOQ4Sk+nW9
	 mKw5LQdYkEvKKUjBC0AyzPD6+U3QR8buAaZOvWOpC3mXC6N1jcY5OUSAYXEk/z5idf
	 AbHU5mihradasqYmekXIWrvGbC1YWLgr2YTn3L9kjM4IGcQmQWMY8qwZn8x88jEeK9
	 cBbC7X98Bm8iz9xqJlWrN5DQAxjx/Fyv5u2QGUUq6wSCay1SiFiWYp7HQeR+mDwNHL
	 9Pe1W4PLYgewBJzwM5CHwEoKBaa8yOd9ZMeXboi5/JvuTqwIZErgEdw00aOYmF17NH
	 aIN52jXOxQOgUwt7NbYqtGtz0DAVS3iBDihkymI2kAgNj9zfZI7
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2600:1700:f991:38c0::39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D1B2420994;
	Thu, 28 Nov 2024 17:25:20 +0000 (UTC)
Date: Thu, 28 Nov 2024 17:25:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>
Cc: git@vger.kernel.org
Subject: Re: Building git with =?utf-8?B?L2Jpbi9z?= =?utf-8?B?aOKHlGRhc2g=?=
 produces suboptimal GIT-CFLAGS file
Message-ID: <Z0inflH-gQbZwNCX@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>,
	git@vger.kernel.org
References: <b4ef94b2a0294c338d115fee68e0c31e44dad3b9.camel@aegee.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BZ551UyuXHMH3gyA"
Content-Disposition: inline
In-Reply-To: <b4ef94b2a0294c338d115fee68e0c31e44dad3b9.camel@aegee.org>
User-Agent: Mutt/2.2.13 (2024-03-09)


--BZ551UyuXHMH3gyA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-28 at 13:53:21, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=
=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2 wrote:
> Hello,
>=20
> when /bin/sh is bash, target GIT-CFLAGS: FORCE in Makefile puts in the fi=
le GIT-CFLAGS the content
>=20
> gcc:  -g -O2  -I. -DHAVE_SYSINFO -DGIT_HOST_CPU=3D"\"x86_64\"" -DUSE_LIBP=
CRE2 -DHAVE_ALLOCA_H -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND -DSUPPOR=
TS_SIMPLE_IPC -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HA=
SH_DEFAULT=3D0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C=3D"\"git-compat-util.h\"" -DS=
HA1DC_CUSTOM_INCLUDE_UBC_CHECK_C=3D"\"git-compat-util.h\"" -DSHA256_BLK  -D=
HAVE_PATHS_H -DHAVE_STRINGS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CL=
OCK_MONOTONIC -DHAVE_SYNC_FILE_RANGE -DHAVE_GETDELIM '-
> DPROCFS_EXECUTABLE_PATH=3D"/proc/self/exe"' -DFREAD_READS_DIRECTORIES -DS=
HELL_PATH=3D'"/bin/sh"':
>=20
> when /bin/sh is dash (b3e38ad), the same file GIT-CFLAGS contains
>=20
> gcc:  -g -O2  -I. -DHAVE_SYSINFO -DGIT_HOST_CPU=3D""x86_64"" -DUSE_LIBPCR=
E2 -DHAVE_ALLOCA_H -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND -DSUPPORTS=
_SIMPLE_IPC -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH=
_DEFAULT=3D0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C=3D""git-compat-util.h"" -DSHA1D=
C_CUSTOM_INCLUDE_UBC_CHECK_C=3D""git-compat-util.h"" -DSHA256_BLK  -DHAVE_P=
ATHS_H -DHAVE_STRINGS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MO=
NOTONIC -DHAVE_SYNC_FILE_RANGE -DHAVE_GETDELIM '-
> DPROCFS_EXECUTABLE_PATH=3D"/proc/self/exe"' -DFREAD_READS_DIRECTORIES -DS=
HELL_PATH=3D'"/bin/sh"':
>=20
> Note the differences in the -DGIT_HOST_CPU, -DSHA1DC_CUSTOM_INCLUDE_SHA1_=
C values.  Because of the differences, in Makefile:3150   if test x"$$FLAGS=
" !=3D x"`cat GIT-CFLAGS 2>/dev/null`" ; then  always succeeds, prints =E2=
=80=9C* new build flags=E2=80=9D and every run of make starts rebuilding da=
emon.o.  So the empty build is not empty.

I don't see this on Debian unstable's 0.5.12-9, so I'd say that this is
likely a dash bug upstream, probably a regression, and I'd suggest you
report it to them.  I don't see any reason that the Makefile should be
doing anything incorrect here after some inspection.

I've noted, looking at the upstream Git repository, that (unlike zsh)
there's no testsuite, so perhaps this is the kind of thing that could
well end up in a future testsuite.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--BZ551UyuXHMH3gyA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ0infQAKCRB8DEliiIei
ga0xAP94++5MnDRDaSfogC9W+6aTPKepoqCjUQ7hcEUWwKdl6gD/aDfZRFfWWnbA
+ziVtbfv1+dEMKWR6AEol4rlP4Tv9g0=
=88PW
-----END PGP SIGNATURE-----

--BZ551UyuXHMH3gyA--
