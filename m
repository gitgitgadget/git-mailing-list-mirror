Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0BF57870
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CRQjFIoO"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id ADF5B5A3B7;
	Thu, 11 Jan 2024 23:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1705016941;
	bh=lgNB1e4wpVfwF/0Jedp7wd/1oVHsaZ+IyGZaWxrfHv0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=CRQjFIoOqxlukn8fAgaK0fhpnzNBFO8TsqLEYfFr8LWYPunPCptU0sN3Tn2I9eWh/
	 fctx1kTvlkfbb+ITtxVdjzRgoqCfvfpyrM5AbmQ5UIPXrfCxcT613xQP/NMM2+jZ11
	 sQaYAMiLGv5rp19DzXLxOv7EW9ZgRaX/GUWROifWcsWVfkH6qj3b3yT+9QDv15Kt04
	 QmY2RtM9lcf7nsIqv1R1lj5oMxiwaEDR8V5YZmWDdTIZe5XQptUKAFrUzTFSEG9rdd
	 qrC2O0fb9f8tTq9Zv11xjOnJAiRFPeMdGUP3yC28fmEX465sX8xG5GNEzerLDrmj/l
	 /xkzze3n3EbZwl6EkOTyL7vTE5LG5oMwwaLiwiTjKNyzGi3Cn8S6QC56scic6AVZsc
	 Ped3mTaQuzU9W1niyZrSNwRk3h0YhRUFSHvHEf/0rODbevnQ+5Uen41WOGbLK2bGzE
	 b6ksGvdFgbTIFWZ4YJlGrMgBgsGsHPHpUIGyAzCItz65142mPbi
Date: Thu, 11 Jan 2024 23:48:59 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Sam James <sam@gentoo.org>
Cc: me@ttaylorr.com, git@vger.kernel.org
Subject: Re: [DISCUSS] Introducing Rust into the Git project
Message-ID: <ZaB-ayQuGqrS-mL0@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Sam James <sam@gentoo.org>, me@ttaylorr.com, git@vger.kernel.org
References: <ZZ77NQkSuiRxRDwt@nand.local>
 <87v880m6r3.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Me6t/6/FPOhDVGFD"
Content-Disposition: inline
In-Reply-To: <87v880m6r3.fsf@gentoo.org>
User-Agent: Mutt/2.2.12 (2023-09-09)


--Me6t/6/FPOhDVGFD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-01-11 at 11:45:07, Sam James wrote:
> Something I'm a bit concerned about is that right now, neither
> rustc_codegen_gcc nor gccrs are ready for use here.
>=20
> We've had trouble getting things wired up for rustc_codegen_gcc
> - which is not to speak against their wonderful efforts - because
> the Rust community hasn't yet figured out how to handle things which
> pure rustc supports yet. See
> e.g. https://github.com/rust-lang/libc/pull/3032.

Is this simply library support in the libc crate?  That's very easy to add.

> I think care should be taken in citing rustc_codegen_gcc and gccrs
> as options for alternative platforms for now. They will hopefully
> be great options in the future, but they aren't today, and they probably
> won't be in the next 6 months at the least.

What specifically is missing for rust_codegen_gcc?  I know gccrs is not
ready at the moment, but I was under the impression that
rust_codegen_gcc was at least usable.  I'm aware it requires some
patches to GCC, but distros should be able to carry those.

If rust_codegen_gcc isn't viable, then I agree we should avoid making
Rust mandatory, but I'd like to learn more.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Me6t/6/FPOhDVGFD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZaB+agAKCRB8DEliiIei
gfIiAP9Decw4nUJ8LxFgRccogvdr+OoEX8ZPWQx3GsjbP4KZ4QEA7n7BzXrLzx6u
nem1WK56uQoDkZXfoRp66CGKtygcPgU=
=UJ3x
-----END PGP SIGNATURE-----

--Me6t/6/FPOhDVGFD--
