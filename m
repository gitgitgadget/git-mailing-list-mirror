Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227732951B3
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762384; cv=none; b=RYGrgLL2BOoKSgW8lSeaGbe+akYuMF0gf0aH7ozRRDlqO8TtJg/fashevLOe3KcGYh1sWuYN5PAbjXnWN7Xwtc0Ogt7gWIhmwGiavfRH4WTwaEVwgvznekbueTZ4hOr0G2lGKIO0VOhRa0I+gEeYzjmerTT1H/l1qkrgpH4JztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762384; c=relaxed/simple;
	bh=fvM1v89n+Oho4Zz4/X1SdeI2x4/hpBKHJBz0XP6+ObU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYgl5+WPK7J13wwJbmh4VZcxs0fW+3/90Gu/2zW5/aMAp++yTji5YIfSGc5vymSheKmebX3sOrEgeSQPPRGbtVM/tAUnT5lrEGL1JTIzrgjf97naQIyDFsiQpU1+hl4Jj+XT7gjYcGFe+/PsZ9DF2FXG+JNgfQWaxYSyqvwP9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=iRLLyI4A; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iRLLyI4A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1772762381;
	bh=fvM1v89n+Oho4Zz4/X1SdeI2x4/hpBKHJBz0XP6+ObU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=iRLLyI4A7PY3HPWDbsIrJuDRQQtDwx0+XZhTdbogzAnZ/SDVB7fW+/a7P8YpFA4Nk
	 Sk6BacVwiKrFjlwcYC4v95uP2Cu4tGdqVsbrDbeBp6wrRp21gOr9IBIn/F2dq3oqqw
	 WFdSbtPeTHStcTydiYseCKyVtK8tSQjLtzjaGWwgRfEq17mwp9xRVKqV4b41/EvYzY
	 FbNUe8NSenhG3zW1TIawqCDEwG+YDEVUo24L8r6fr7BZfU1gP+IXBoJlV0hDnn7lzd
	 kPfrBCOdbyPpNfrGG9ux65MCQSh0br94HpTlsJHDcHvR2RQOp4DZBPi3gprutLF7Ug
	 bq6/eJ1s1RXmmbbDkfoeX7QfwKCB0UOS1cnua9nm9+TzZXhDNRe0Ju3MkqYF+fJP+S
	 6Rpr7+TjUMaXCAezxRuGl44eqIVuJ0tGaY/KGhVtNqQA3Qfn7Dc56mH9aAWlyQ0c2n
	 xnr4YETpTAgPuJD1kzoLmOCMKNnuwElpyo6txtU0YAl0h27WG1F
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:941e:963:e525:3a6c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 592672006D;
	Fri,  6 Mar 2026 01:59:41 +0000 (UTC)
Date: Fri, 6 Mar 2026 01:59:40 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ivan Ivanov <qmastery16@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Test "t0300-credentials" is failing on Arch/Artix: asks to enter
 the Username/Password in an infinite loop
Message-ID: <aao1DF3lXfHTMH30@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ivan Ivanov <qmastery16@gmail.com>, git@vger.kernel.org
References: <CAAaskFBp+A9pOhd8O6owd6k0cDj66ipXrqH2Hj_c7j3d=HM10Q@mail.gmail.com>
 <CAAaskFANnrqTAjQOHhAgzES9=S+y7w9u-LMWbRbi8FayVdvzFw@mail.gmail.com>
 <aaosmo1Iluc5KeZw@fruit.crustytoothpaste.net>
 <CAAaskFC=tpuS-saP9t5Kp0+i6qTHe29x-dGkanyAzz-xaq_HDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A6MewYFfG1n3ys45"
Content-Disposition: inline
In-Reply-To: <CAAaskFC=tpuS-saP9t5Kp0+i6qTHe29x-dGkanyAzz-xaq_HDA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--A6MewYFfG1n3ys45
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-06 at 01:44:48, Ivan Ivanov wrote:
> At the moment - just "makepkg ./PKGBUILD --check --noextract
> --noprepare -f" (these flags in order to get straight to the check()
> stage). Btw right now I got a somewhat similar-by-appearance error at
> test t5003, however if I press Enter two times then it gets further
> instead of an infinite loop:

I don't believe we have a `makepkg` script in Git.  What I was hoping to
see was something like this snippet from Debian's `debian/rules`:

----
OPTS =3DNO_OPENSSL=3D1 prefix=3D/usr gitexecdir=3D/usr/lib/git-core \
  mandir=3D/usr/share/man htmldir=3D/usr/share/doc/git/html \
  INSTALLDIRS=3Dvendor \
  SANE_TOOL_PATH=3D INSTALL=3Dinstall TAR=3Dtar \
  NO_CROSS_DIRECTORY_HARDLINKS=3D1 NO_INSTALL_HARDLINKS=3D1 \
  NO_PERL_CPAN_FALLBACKS=3D1 \
  PYTHON_PATH=3D/usr/bin/python3 \
  DEFAULT_PAGER=3Dpager DEFAULT_EDITOR=3Deditor \
  CC=3D'$(CC)' CFLAGS=3D'$(CFLAGS)' LDFLAGS=3D'$(LDFLAGS)' \
  HOST_CPU=3D'$(HOST_CPU)'
DOCS =3Dhtml
DOC_OPTS =3Dprefix=3D/usr htmldir=3D/usr/share/doc/git/html \
  ASCIIDOC8=3D1 ASCIIDOC_NO_ROFF=3D1

# https://wiki.debian.org/ReproducibleBuilds/TimestampsInDocumentationGener=
atedByAsciidoc
DOC_OPTS +=3D ASCIIDOC=3D'TZ=3DUTC asciidoc'

ifeq (,$(findstring terse,$(DEB_BUILD_OPTIONS)))
  OPTS +=3D V=3D1
  DOC_OPTS +=3D V=3D1
  TEST_OPTS =3D --verbose
endif
ifneq (,$(findstring nocheck,$(DEB_BUILD_OPTIONS)))
  TEST =3D
endif
ifneq (,$(findstring nodoc,$(DEB_BUILD_OPTIONS)))
  DOCS =3D
endif
ifneq (,$(filter parallel=3D%,$(DEB_BUILD_OPTIONS)))
  NUMJOBS =3D $(patsubst parallel=3D%,%,$(filter parallel=3D%,$(DEB_BUILD_O=
PTIONS)))
  MAKEFLAGS +=3D -j$(NUMJOBS)
  # Setting this with a pattern-specific rule prevents -O from
  # affecting the top-level make, which would break realtime build
  # output (unless dh is run as +dh, which causes other problems).
  %: MAKEFLAGS +=3D -O
endif
ifneq (,$(shell dpkg-query -f '$${Version}' -W libpcre2-dev))
  OPTS +=3D USE_LIBPCRE2=3D1
else
  OPTS +=3D USE_LIBPCRE1=3D1
endif
----

Those options tell us how your package is configured and what Makefile
options you're using.

> Username for 'http://127.0.0.1:5003':
> Password for 'http://127.0.0.1:5003':
>=20
> Here are the contents of a related .out file for this t5003 . Please
> note that not so long ago I did chmod -R 755 on this
> /dev/shm/git-test/ just in case, so I am not sure why this is failing
>=20
> ok 81 - remote archive does not work with protocol v1
> expecting success of 5003.82 'archive remote http repository':
>     git archive --remote=3D"$HTTPD_URL/auth/smart/bare.git" \
>         --output=3Dremote-http.zip HEAD &&
>     test_cmp_bin d.zip remote-http.zip
>=20
> fatal: cannot exec '/dev/shm/git-test/trash
> directory.t5003-archive-zip/askpass': Permission denied
>=20
> fatal: cannot exec '/dev/shm/git-test/trash
> directory.t5003-archive-zip/askpass': Permission denied
> fatal: cannot exec '/dev/shm/git-test/trash
> directory.t5003-archive-zip/askpass': Permission denied
> fatal: Authentication failed for 'http://127.0.0.1:5003/auth/smart/bare.g=
it/'

I think this is your problem.  First of all, `/dev/shm` is not a
general-purpose temporary directory and should not be used that way.
It's designed for shared-memory segments that live in the file system
(usually POSIX shared-memory segments).

My guess is that you've specified `TEST_OUTPUT_DIRECTORY` to something
under `/dev/shm` and on your system that file system is marked `noexec`.
Git's testsuite uses many shell scripts and the test directory will need
to live on a fully functional file system according to the standards of
the OS.  Normally people run the tests under `t` in the repository root
and the repository effectively cannot be `noexec`, since otherwise
the binaries would not work.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--A6MewYFfG1n3ys45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaao1CwAKCRB8DEliiIei
gYSMAP9ETJAand/gbH5JmGR4dVVp3VQeAjl2cLLGm36AUpv6+AD/XvGmMQL1PEV5
N5BNd4jqKDvlWzg3S71ENxO1CY8+TQI=
=kOX1
-----END PGP SIGNATURE-----

--A6MewYFfG1n3ys45--
