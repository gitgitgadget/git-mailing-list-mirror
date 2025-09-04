Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423192EB874
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025472; cv=none; b=H1gqkreLPa0VShmkjSIEhpGYZ06ZdF8aKCON7HVoYPxSpgc9NjoWrfGXUIbbcekh8G72pu1TjZetuPZAzax2lgYoJy1R22ClSo5H5jpE7ioSetmCumTz1JWfh8FvldZa29koS6VmvUF5aLyns3BBOos/k74d6xK4wdR+CB5+U8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025472; c=relaxed/simple;
	bh=TrnbzhNQLCkdbAsIDpIaIjS3JmqnoE15JErnGePfXyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWbDEGSlTAr5apCeFbbKYnIZ3duiOmMGPOSvCOksqs9VCwbUOSoJP6XK27njVXD6kLFm+7CCc6h8QbkrBun/+BAlO7WPSYf9Pcy2FYD0nhXqx9q+eAM3oKF7+BK3oYev5qRPhtNhDN1VotikiYkreLdf/xNk31qJOanJn53Buyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=A/AFw0IJ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="A/AFw0IJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757025469;
	bh=TrnbzhNQLCkdbAsIDpIaIjS3JmqnoE15JErnGePfXyE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=A/AFw0IJNyQs0P+r+55Yurfg0QhN31yOdX3P9FNCxvnBQy7WEaW9ooKlip2MnsbYY
	 3ye8v4xdeMRFOZ8MKPjfNw8Y/cda++vg0BQ1CxZ3v45CnxOQAhuSGoNmpP8N1KPvSh
	 m+OP39XshL+Q4/UY/JBPjrxc1NP8hHyetn2QGwNo2F4FP7jJsvSP1QkXcP/4xzFiYt
	 JXM06v/OIm37XBe0mkgOIyghKQ4LDe/VM4zNmzOGz5NfLUrg5b3OA5NOD+S4I6EiVF
	 F93usvTRuDEC6w/JteW5enVdrrYbZXCxXBkNIkVITEY+cVFVvb/fxfefRDepsFudvw
	 psqSoV2BKey1WVOXc65zNImEuZOFt3en+HWa9WfBiN9O+E52IDBYPn/7TVCrLPlc8X
	 FUNHRe87ktjvLBURhrSjsM5qbyI/d7da0iqDEXqLVYyZTeE7lQPnlgSBIvZXG1BfZl
	 95TCTvh4Vc81ygr3DgIkkyyVb8qejGUSoLWr1nmZw8/Yox8Rey2
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:bf12:8113:e329:8d0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0FC27200BC;
	Thu,  4 Sep 2025 22:37:49 +0000 (UTC)
Date: Thu, 4 Sep 2025 22:37:47 +0000
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
Subject: Re: [PATCH RFC 2/3] rust: implement a test balloon via the "varint"
 subsystem
Message-ID: <aLoUuxfQmxHdqiYe@fruit.crustytoothpaste.net>
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
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250904-b4-pks-rust-breaking-change-v1-2-3af1d25e0be9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FUExU8ObYVFYiaxm"
Content-Disposition: inline
In-Reply-To: <20250904-b4-pks-rust-breaking-change-v1-2-3af1d25e0be9@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--FUExU8ObYVFYiaxm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-04 at 14:26:44, Patrick Steinhardt wrote:
> diff --git a/meson.build b/meson.build
> index 1c0e98bbc14..b52a68b0bb6 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -522,7 +522,6 @@ libgit_sources =3D [
>    'usage.c',
>    'userdiff.c',
>    'utf8.c',
> -  'varint.c',
>    'version.c',
>    'versioncmp.c',
>    'walker.c',
> @@ -1713,6 +1712,10 @@ rust_option =3D get_option('rust').disable_auto_if=
(not rust_available)
> =20
>  if rust_option.allowed() and meson.version().version_compare('>=3D1.9.0')
>    subdir('src')
> +else
> +  libgit_sources +=3D [
> +    'varint.c',
> +  ]
>  endif

Can we also add a #define constant when building?  For instance, if I'm
writing interop code in Rust, I'll need to be able to do something like
this:

    int do_foobar()
    {
    #ifdef RUST
      /* Call some code */
    #else
      die(_("interoperability not supported"));
    #endif
    }
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--FUExU8ObYVFYiaxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaLoUuwAKCRB8DEliiIei
gaZYAP41NuNRrUAfiq/yWuE27bJxeWCYYpLywiXw5LjJbxnM3wD/RHzlRPaIylQb
sItYJrRNzh6BSV15zDfr83xa2l74+wA=
=J/z/
-----END PGP SIGNATURE-----

--FUExU8ObYVFYiaxm--
