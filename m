Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA2729AAF7
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767829144; cv=none; b=EHakbDlZp6c4equHfr8HyTG46DPWJZtnwkmLClaQ3FxibMyIHAuucCQwx1aZdqmo4XzqDQgjLN+Lt/74XKN4dhVqqgqAcJjh8ZpOaHx+LKbw6MJ2Gt2i02NGi36GI5DwkmRZApT8wq4nkqIIo+LiwsJ3RxG2qoUH0OWKnlICzDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767829144; c=relaxed/simple;
	bh=L7g49PJS6QL8s5tb/6ndlS7IvaLdaf1emcfAhJGnyho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKv7JPPxkVGBLRlII8R4bnQJp69tk2LTvBhQSqTs1R+K8gdhbjh2pPzlDwo3dG17YzX56yS4L9aVXSsKFWNSROyw//WuYYMYAINzLKxb+fymC0Vw8+/2r34fEi6XMEu+NdAPEy4/0QXoCNCHEf9tOpMy8vqfZUZEHbFmuQfV9lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ACH3NPb+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ACH3NPb+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1767829134;
	bh=L7g49PJS6QL8s5tb/6ndlS7IvaLdaf1emcfAhJGnyho=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ACH3NPb+fzLMNr9s9MvzE8BRbliKjkNlLLNz3XsaBgy7yqcy6EFwzDD0sVEYqzmk4
	 7AgB7cZeDwJqtlQHc+md4leTgMPIIARnVkpq5NUpGiTZ/QWl3eF/InYfFhiUgkFNe1
	 urIP0B6W41JEwyiBRBMg2LLC0Tl2LNJMv+Y83DwDb2byf1QJLBR7KPcBr9hYsaYZrA
	 HkmE5HrWeSwSUr4WngHF3yvFYCy/TY06xQd4HrDWFf8JYrcC+cRsYIvVUrw/bHbeoA
	 /ZES0ptuNZnOu2RNZ+9KdtLmBMyA5Q30pofyaScNp4dwYSPD14cbSml07wEaYS++ng
	 GEj1zVTCLd/Gx75GhvfU3Px5lUKq2N4uit+kQx3kBEkyh9tpiSOmOX9dgXHz+eYOGN
	 oBS1F9BAejpVeRwpdCq9n5wf9lbvi0p/lf4c+cd+aXI06+KMqWd67AcfJWdkL9fP/S
	 oa2Yy3LAMaNsOXPuOqf9Jk8FJSGNvyHOhzRuekdUpUZ7TuCCYm4
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9e0:7608:acdb:97d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 414C620031;
	Wed,  7 Jan 2026 23:38:54 +0000 (UTC)
Date: Wed, 7 Jan 2026 23:38:53 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: Matthieu Beauchamp <matthieu.beauchamp.boulay@gmail.com>,
	Matthieu Beauchamp-Boulay via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Matheus Tavares <matheus.tavb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ignores: handle non UTF-8 exclude files
Message-ID: <aV7ujZ2FeO7EleT5@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Collin Funk <collin.funk1@gmail.com>,
	Matthieu Beauchamp <matthieu.beauchamp.boulay@gmail.com>,
	Matthieu Beauchamp-Boulay via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Matheus Tavares <matheus.tavb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2157.git.git.1767478617198.gitgitgadget@gmail.com>
 <aVrCHr_NRDqNjPn0@fruit.crustytoothpaste.net>
 <CALH9GrYOjb92gjrtdjwapFH9L73XGg1Kan8uz1aVLpSXNURi+Q@mail.gmail.com>
 <aV2ZS1lvLivi8xRH@fruit.crustytoothpaste.net>
 <87secimchc.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QODN/l+k6DnKh/w9"
Content-Disposition: inline
In-Reply-To: <87secimchc.fsf@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--QODN/l+k6DnKh/w9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-07 at 01:35:11, Collin Funk wrote:
> An unfortunate trend that I have seen with Rust programs is that they
> completely disregard the systems locale. E.g. using
> LC_ALL=3Den_US.ISO-8859-1 and passing an "=C3=80" character as an option =
will
> typically fail since it is encoded as 0xC0 which is not a valid UTF-8
> character.

Git does not usually directly read input and then convert it to other
encodings unless specifically asked to (e.g., `working-tree-encoding`),
so I fully expect that nothing will change there.  However, in many
cases, Git also currently does not honour LC_ALL, such as for commit
messages.

> I figured it was worth bringing up since Git may wany to think about it
> some before introducing more Rust. I think it can be worked around by
> using OsString [1], but I guess many people choose not to.

The people who have been working on Rust have been very careful to not
make assumptions that all data is UTF-8, and I don't expect that to
change.

OsString is slightly problematic because it is effectively UTF-8-ish (on
Windows, it's actually WTF-8 and on Unix it allows arbitrary bytes) but
there is no portable way to get any consistent byte encoding out of it.
(In versions of Rust too new for us to use, there is a function that
provides a byte encoding but it's not guaranteed to be stable across
versions.)  I have some custom code in one of my branches to handle the
conversion to and from OsString to a consistent byte encoding using some
traits to paper over the operating system differences.

In general, I expect we will continue to use some C-based interfaces
(possibly called via Rust wrappers) because Rust also does not expose
things like file descriptors on Windows or the full range of stat or
other information we need.

One assumption I do think is safe to make is that arbitrary Unicode can
be printed to the terminal, such as in error messages.  Considering that
virtually everybody sets IUTF8 in Unix terminals and we effectively do
that right now with localized text, I think that's okay.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--QODN/l+k6DnKh/w9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaV7ujAAKCRB8DEliiIei
gbhmAQClhLSKKmnUtIzaUf6UInXP9hzBJLSxEHtlrVETsFVItgEAp2i+mron5TIs
j/m5MEfkkzOXK0MLegdmCuwHnNCgfw0=
=5Xpa
-----END PGP SIGNATURE-----

--QODN/l+k6DnKh/w9--
