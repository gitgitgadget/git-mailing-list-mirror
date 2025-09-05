Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB6D220F3F
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103719; cv=none; b=rpCsCjjjb5f4OLbruB0igCXn7O4CmUZNAHhtf1i2TAfZiwmh+lA3R5gz8G3v9Evhs3M8SwGorq333LAYfxrVbPx9VjyzD+ozZeoE/ndt3aql4nPoypZsIYQ7dVFMSnOzPwzfcMp4abyshHqFzECOqp9ugOUozjsXoeZ8yUEqpbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103719; c=relaxed/simple;
	bh=ZpFCjULqd90UQCVTAhGfm09tf4lRBDdo1/qF26OaxnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hREqLw40z0J2oJheakwqW2YKyG/P/3O/2H+TGr7etBbtTuWPnrVP/vNcfqfVKKyX7mEVoiAzepHFLpUMOv23wrjPeuU4zEeoqeH2j7b9oTzRFpkR/n0InK0JSgrwXIfXLfQk/XaLIBFwDfkV1MvlugwIz/KH2QLv/Nf88RkJKuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=mjKoqbhV; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mjKoqbhV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757103716;
	bh=ZpFCjULqd90UQCVTAhGfm09tf4lRBDdo1/qF26OaxnQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=mjKoqbhVYga4p08ijDnoEWXiE9qXunfUk+5qopTBjKDoa3tCMrJ25lP2B6ml1zsOl
	 LdM768Bh9t74vs5em573JVU5YfW82KlZhqrGnodkdrnKXhrVwiHr3RFPyaIKc4p/Jd
	 2Zd5DaE8WwcHsCKk+y1lUgj5DOsASDl6JTRtBQiStk8Odsim59ufrDWyY/dj2OLY9H
	 ezYkjdROEDX4TmYVl38/5bjguO7uS6z2SYEpAJZoKzkh0muClj9m8EnecgpnI17Zq4
	 OuxAIoQ524dqcMOwOn5IPxRjSJ6fmwnaE6m8N6m0CJfwOlIa3pBU1MXoegqKRaUWgW
	 SJapc0zmwfqaOO2Zy2FvaCPiAuV9npRmE/GL+hxe7m02aL3ghSzkUm0xRc7j+uPVGm
	 LHodDFyNZCD7S5ldS/k7BLH9mFYXc/YBjS/kK+V4TQ1RIgEuRCDJNpfSBn+2JgjzOq
	 8djYNx2+YfP6XIJo9uBP+bjygu3Wi5Gg+Be74Q/uXKiKKftdSEk
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f8f0:4bbe:8989:f575])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 16A1720100;
	Fri,  5 Sep 2025 20:21:56 +0000 (UTC)
Date: Fri, 5 Sep 2025 20:21:54 +0000
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
Subject: Re: [PATCH RFC v2 2/7] Makefile: introduce infrastructure to build
 internal Rust library
Message-ID: <aLtGYlTXktuzxD0q@fruit.crustytoothpaste.net>
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
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-2-6939cbf4a0b8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4c11t8uLHsMYShTs"
Content-Disposition: inline
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-2-6939cbf4a0b8@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--4c11t8uLHsMYShTs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-05 at 11:50:58, Patrick Steinhardt wrote:
> Introduce infrastructure to build the internal Rust library. This
> mirrors the infrastructure we have added to Meson in the preceding
> commit. Developers can enable the infrastructure by passing the new
> `WITH_RUST` build toggle.

The idea here seems great and I'm fully on board=E2=80=A6

> diff --git a/Makefile b/Makefile
> index 555b7f4dc3..e7b3c8e57b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -483,6 +483,14 @@ include shared.mak
>  # Define LIBPCREDIR=3D/foo/bar if your PCRE header and library files are
>  # in /foo/bar/include and /foo/bar/lib directories.
>  #
> +# =3D=3D Optional Rust support =3D=3D
> +#
> +# Define WITH_RUST if you want to include features and subsystems writte=
n in
> +# Rust into Git. For now, Rust is still an optional feature of the build
> +# process. With Git 3.0 though, Rust will always be enabled.
> +#
> +# Building Rust code requires Cargo.
> +#
>  # =3D=3D SHA-1 and SHA-256 defines =3D=3D
>  #
>  # =3D=3D=3D SHA-1 backend =3D=3D=3D
> @@ -918,6 +926,11 @@ TEST_SHELL_PATH =3D $(SHELL_PATH)
>  LIB_FILE =3D libgit.a
>  XDIFF_LIB =3D xdiff/lib.a
>  REFTABLE_LIB =3D reftable/libreftable.a
> +ifdef DEBUG
> +RUST_LIB =3D target/debug/libgit.a
> +else
> +RUST_LIB =3D target/release/libgit.a
> +endif
> =20
>  GENERATED_H +=3D command-list.h
>  GENERATED_H +=3D config-list.h
> @@ -1387,8 +1400,12 @@ CLAR_TEST_OBJS +=3D $(UNIT_TEST_DIR)/unit-test.o
> =20
>  UNIT_TEST_OBJS +=3D $(UNIT_TEST_DIR)/test-lib.o
> =20
> -# xdiff and reftable libs may in turn depend on what is in libgit.a
> -GITLIBS =3D common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB=
_FILE)
> +GITLIBS =3D common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
> +ifdef WITH_RUST
> +GITLIBS +=3D $(RUST_LIB)
> +endif
> +# Other libs may in turn depend on what is in libgit.a.
> +GITLIBS +=3D $(LIB_FILE)
>  EXTLIBS =3D
> =20
>  GIT_USER_AGENT =3D git/$(GIT_VERSION)
> @@ -1411,6 +1428,19 @@ BASIC_LDFLAGS =3D
>  ARFLAGS =3D rcs
>  PTHREAD_CFLAGS =3D
> =20
> +# Rust flags
> +CARGO_ARGS =3D
> +ifndef V
> +CARGO_ARGS +=3D --quiet
> +endif
> +ifndef DEBUG
> +CARGO_ARGS +=3D --release
> +endif
> +
> +ifdef WITH_RUST
> +BASIC_CFLAGS +=3D -DWITH_RUST
> +endif

=E2=80=A6but unfortunately, all of this code is above the `-include config.=
mak`
line, so if I set `WITH_RUST=3D1` in `config.mak`, it doesn't work: no
`target` directory is created and `git version --build-options` says
Rust isn't enabled.  (It does work if I specify `WITH_RUST=3D1` on the
command line, though.)

Might it be a better idea to place this with the conditional code
farther down so it's properly honoured when configured in `config.mak`
and friends?

I am very pleased by the fact that cargo is quiet by default, though,
and otherwise it seems to be well integrated into our build system.
This patch seems smaller than I was expecting, which is nice.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--4c11t8uLHsMYShTs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaLtGYgAKCRB8DEliiIei
geZeAQDzkis2mG+RURDs44C8pQlb3AWF6SFzaNrF9ke8Bq5SBwEA17IpDZl/81Qo
W++L6O4WUn6uN2w633XplEFXvUaNhgQ=
=0qmt
-----END PGP SIGNATURE-----

--4c11t8uLHsMYShTs--
