Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FC1163
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770676812; cv=none; b=QRuVP1nm6LsTXucCxUeL00NOqWV7jW4EOM2HtFGesYDH86vyoLPA73Gj1CfUtsEp/RhUvUABxI5WkGTxTD7rIzE7SloBVfF5u589wqfLptuifw/bI0BnuSy0uOxvEuMFWOZx22dTqn25RB70Irs8iRlXksk/QlobZea1ACs1dOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770676812; c=relaxed/simple;
	bh=RdUThU86smN/4PtlkHsu4Ttd+ol7mTXQTrVMNVQUHW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBrZEm794jP0XqdTrj9Rx/qelEOnJPHrDvAm/8a1W9CKcPZ1eBkmjPEPjo/fzR/Uyl5s4ZYHlcRfuktX5N+eoBBuO18LdQ1zzCxQCWpQcRBdWaY5T891BeDKFC0jHv4nP5MuRk6u49WWymyGe5Lc8xwkqvJPeZnK1dQeUcgUung=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=coFKssSf; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="coFKssSf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770676809;
	bh=RdUThU86smN/4PtlkHsu4Ttd+ol7mTXQTrVMNVQUHW8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=coFKssSflBbW7prr8Bucu08qG2NWwsChczP+Y4pmIxr+d2Y8jqVjo9u5agfsM50+R
	 OrhjahChlJ14sc9MmtOCr+IVKvKEtW92dlUWtxRwQyKow9ExcVsFxHtGfhTIEQ7NEV
	 7eyefe0PLyRvMhgUE8LizhWJsoT54fG0pAK+H5i015GobRjQwjHUc/cqh4jaREVMQb
	 9BpYkEeusdQSOGy6coOwLdW0AID0zeXWkt4KDMNf+GPywqvhB1sdwy5kZD8kLHXiMS
	 gmkL6hGL1bQbUgxiZvXIFXWwbNLW9gd1GI2LdtdNYV8+yF4XYgJtwzJq4PAuF0pgnu
	 KZxTTwhl7LaVIV6d3JyXCB2hMrDma/UAK3Vi7UBCBhVlbrW1b1P3PebGZ50d51lLcB
	 VOggXwTjgUtm5Uy+XhspZ1p2WABbZ8AbMzH3iqPzvvaHWLdnaFSjS3HQ9yzvC+ju1I
	 MemIR1d/9eh8LCelHfLT0KnKdcx/fOPBkEnEQRm0MJL/kzYG0AI
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:67a7:98fd:8394:6003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C5977200B0;
	Mon,  9 Feb 2026 22:40:09 +0000 (UTC)
Date: Mon, 9 Feb 2026 22:40:08 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonatan Holmgren <jonatan@jontes.page>, git@vger.kernel.org
Subject: Re: [RFC] Support UTF-8 characters in Git alias names
Message-ID: <aYpiSHSxYS2fUUS1@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonatan Holmgren <jonatan@jontes.page>, git@vger.kernel.org
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <aYkaepCu4lwT3xNl@fruit.crustytoothpaste.net>
 <xmqqikc66k5k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="38m/r41GcZxuGIhl"
Content-Disposition: inline
In-Reply-To: <xmqqikc66k5k.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--38m/r41GcZxuGIhl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-09 at 14:55:51, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > I don't think we have any Unicode normalization code at all in Git,
> > though, so if you want a quality implementation, that may be a thing we
> > need.
>=20
> Isn't NKC/NKD a macOS-only issue in practice?  Anything on the
> command line "git" potty and "git-blah" built-in commands receive
> goes through precompose_argv_prefix() to be normalized on that
> platform.

Normalization is not a macOS-only issue.  Many accented characters can
be written in multiple ways, one composed and one decomposed.  If the
alias in the file is composed and what's on the command line is
decomposed, they will not match bytewise even though they are logically
and graphically identical.

For instance, here is the word for "where" in French, first composed,
then decomposed:

o=C3=B9
ou=CC=80

The former is U+006F U+00F9 and the latter is U+006F U+0075 U+0300.
Obviously, if I write one of those in my config file and the other on
the command line, I intended to execute the same alias, but they are not
bytewise identical unless both are normalized identically.

This is why many websites don't accept Unicode in passwords: because
logging in on different systems can produce different sequences and they
must be properly normalized to avoid hard-to-reproduce problems.

There are also canonical (NFC and NFD) and compatibility (NFKC and NFKD)
normalizations.  For instance, a Greek question mark looks like an
English semicolon.  Canonical normalizations preserve this distinction,
but compatibility ones do not.

I'll note that the Mac-native normalizations do not match any standard
Unicode normalizations for any version, so we'd need separate
normalization code.  I also don't think UTF-8-MAC is available on all
versions of libiconv, either.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--38m/r41GcZxuGIhl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaYpiRwAKCRB8DEliiIei
gYxdAQCGq+7u1MFGs1HLENCHewJTrwsX0xbqZkBM3uNT/SgeZgEAqRBOjTdJ8WOY
tgR+/EEJVAaTnoDyekZ91aBzLKeupAE=
=QurV
-----END PGP SIGNATURE-----

--38m/r41GcZxuGIhl--
