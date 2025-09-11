Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE027462
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626445; cv=none; b=KbBJL03FixkLOsfhhUVYNAuajZ6UN+mXiKbeqaMw8/2JJGrob9ivRwHeQstIOF/VKE0wkfRDC+i3SYZgScALsvA5cn8Ex2fAnvhVUQkn7jOKVj5/ohMlzruc/fk1b4lhjAt6LbUuHyhwbDevdgCg2vc3BAHxXO9WsstAyLEQenE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626445; c=relaxed/simple;
	bh=nPS5BiDTkq6T6LsvFqyp7aPnGWzyinPOx8Xi0Jez6UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c85DCuU7Y3AseHdve4LNygZpZbPLS4i516eRLtJsjTF8ji1DpUfSnBbk8/fkcE6LxquTOJ0Ahe+2evD6IDEnMKTbYTKaY3NuWS9D6Gtiq+f9VmRcblIoCibPE+NbT8xC93r++n/URWUzplV73K8QrmNDSwj0Q0j2N2hgQG4gQmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=cFXTbHqi; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cFXTbHqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757626441;
	bh=nPS5BiDTkq6T6LsvFqyp7aPnGWzyinPOx8Xi0Jez6UA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=cFXTbHqi3H9Zd0ROnriAfnQdSm09waytSUo5ZrAg259F1NaWQdnhm/xoiKndLI2KJ
	 qr3JQ6XeaJC69foXQ2LCD99ubX+8p5/rYtfylhKPLYPa0+o+ae0ktR0d7z0fDsYw4x
	 2vMqbeDq98aJZFoEbYsIGQ5pTLi8ClYALZyUKt1NsINJrAg9c3TDZkcYmcqx8Ce7Xp
	 RsDDYI4+mr77f3Z9KzABXHai9MpiZoiBDWsPC0/ioyOFA4b6wk45dBvSkCO0rUQyzM
	 HSxMfnBpDPSxE+MSPux9GGtmt/ZGflwOAkCRnZ3LMlmVLn7HBYkrCWGm3okTlT24Kv
	 JHiZSAZZ0v2OwoCmNtwkF5PFrgnT9TTdn8Q4rc/0ofYnCqPgZY0dcZrDXUPYVsPSHo
	 5NG4PJS8pdDLeVh4N3O3FokTVs3jDbsCQhaeaREU46udOEpMrbuod+vw6zboagloxq
	 vyU/pzomxCEO0v8RbxBrn3MSxmA4EMS7+nABhtNhiI7uoljxHmB
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:8d65:5356:c950:b152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3A03020105;
	Thu, 11 Sep 2025 21:34:01 +0000 (UTC)
Date: Thu, 11 Sep 2025 21:33:59 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v4 1/9] meson: add infrastructure to build internal
 Rust library
Message-ID: <aMNAR35R8aCXhVjM@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
 <20250910-b4-pks-rust-breaking-change-v4-1-4a63fc69278d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KZVwbeclLd0+Y6wr"
Content-Disposition: inline
In-Reply-To: <20250910-b4-pks-rust-breaking-change-v4-1-4a63fc69278d@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--KZVwbeclLd0+Y6wr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-10 at 15:35:47, Patrick Steinhardt wrote:
> diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
> new file mode 100755
> index 00000000000..f29745beb36
> --- /dev/null
> +++ b/src/cargo-meson.sh
> @@ -0,0 +1,32 @@
> +#!/bin/sh
> +
> +if test "$#" -lt 2
> +then
> +	exit 1
> +fi
> +
> +SOURCE_DIR=3D"$1"
> +BUILD_DIR=3D"$2"
> +BUILD_TYPE=3Ddebug
> +
> +shift 2
> +
> +for arg
> +do
> +	case "$arg" in
> +	--release)
> +		BUILD_TYPE=3Drelease;;
> +	esac
> +done
> +
> +cargo build --lib --quiet --manifest-path=3D"$SOURCE_DIR/Cargo.toml" --t=
arget-dir=3D"$BUILD_DIR" "$@"
> +RET=3D$?
> +if test $RET -ne 0
> +then
> +	exit $RET
> +fi
> +
> +if ! cmp "$BUILD_DIR/$BUILD_TYPE/libgit.a" "$BUILD_DIR/libgit.a" >/dev/n=
ull 2>&1
> +then
> +	cp "$BUILD_DIR/$BUILD_TYPE/libgit.a" "$BUILD_DIR/libgit.a"
> +fi

Okay, this seems like a reasonable approach.  It would be nicer to not
have to do this, but we've got to work with what we've got.

If I get mrustc working, this could also be a nice way to abstract that
functionality in a useful way.

> diff --git a/src/lib.rs b/src/lib.rs
> new file mode 100644
> index 00000000000..e69de29bb2d

An empty file seems like a good start.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--KZVwbeclLd0+Y6wr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaMNARwAKCRB8DEliiIei
gRf1AQDy3b91u4WxdBI3+1oxOWgpnbxJi0Pe9Q8qmVqOVe813gEA8vg1WcGRJCZw
R/jRrQli6oxF676g7Kb4A+Gk3JeV7AA=
=kNl4
-----END PGP SIGNATURE-----

--KZVwbeclLd0+Y6wr--
