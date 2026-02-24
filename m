Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE3B2E11BC
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972888; cv=none; b=dDtQMS0JRnXTsB4BiiCa0/A2HCWNFML6Hwk2CRDzO9nOTOCXkgtGyDqsKAk2rYlZT7pFWFR0mzWujwhxxgJ7BTSAgYE+GUq5bfQMGKLsJNk9uKFq/d44kBK64pYSH71fAIMkvluvHCtbn0wEGM1LWPA5+6d1LXcKYjkRwxtq7Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972888; c=relaxed/simple;
	bh=7QQn7E/pI5bknXTHmnu1klT6tDRddNhCBAMxF8sCR04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsbPpTfGScbLCnfX5pKeLutidW39+QXUR+WPRst32eSnSsZWxwY5Sb8OPTDem8PCv1vdjodMnLgJgoeitXng+v/nnva/z4EoWXzzgX3zsobPHLxXKwh85ab4zkGaqdl4SFHfh4/MslTtfEhV0ME6dMU1ZL4ZHHMdXKmI56WuFrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YTH5zL3/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YTH5zL3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1771972886;
	bh=7QQn7E/pI5bknXTHmnu1klT6tDRddNhCBAMxF8sCR04=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=YTH5zL3/4BemJR0hsUT1CZQiPAG0ZS7jDTPdUc5Zw+Lw+GZEsdftcQ4zp50/5nq4H
	 i+TBg9mFYQeDwMcVqHQE0AY1kyoPJpGlCx8+es9/fsare7HyWTzbMeibjvEtXY48VB
	 OWjYILceowr+CeZ06azgFSBYpmagfEZUv74R+Bu538Fs1nPDSBY4/3RPGVQ+9viV2l
	 2GFxMvL0GXu7J9HaIXJNmKimVdDa27jlyJnsWfwCzBb0Tfk0WuAfcd06AAcD6o/bzN
	 ZW6UzU42pxovthSOYd7RVA9sTvHdrVU1w1xt9tffs88c0LbK+OA7egAwYG85msXhAm
	 VnipkgezsEtDTEmaAPkAEimV3apZ8wzPSWGVlbADUWsemN6hEtWqRLm0Evd6Rb4HmI
	 t12W0bb48YEX9XDHctrF79BXLLrT7gADXPh/bedBlX/2oJGD/scEIwAsvJEVpfEcbO
	 HtgStOLbNl3UbJBQKPXYWD0qzmStg1RSfh4wHE90d4UoJ4+wHCH
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5975:bd7e:3325:4c49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 52C5E2010E;
	Tue, 24 Feb 2026 22:41:26 +0000 (UTC)
Date: Tue, 24 Feb 2026 22:41:25 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH 0/2] fast-import: add mode to re-sign invalid commit
 signatures
Message-ID: <aZ4pFUJApZosh9Gc@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
References: <20260223194146.3476768-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5R04n9EdeVZfQWV6"
Content-Disposition: inline
In-Reply-To: <20260223194146.3476768-1-jltobler@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--5R04n9EdeVZfQWV6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-23 at 19:41:44, Justin Tobler wrote:
> Greetings,
>=20
> With c20f112e51 (fast-import: add 'strip-if-invalid' mode to
> --signed-commits=3D<mode>, 2025-11-17), it became possible to remove
> invalid signatures from commits via git-fast-import(1) while maintaining
> valid commits. Building upon this functionality, a user may want to
> re-sign these invalid commit signatures. This series introduces the
> `re-sign-if-invalid` mode to do so accordingly.
>=20
> The newly added mode in this series currently ignores
> `extensions.compatObjectFormat` when generating the new signatures. From
> my understanding, to generate the compatability structure would also
> require us to reconstruct the compatability object for the object being
> signed. I think this would be possible to do, but would require getting
> the mapped OIDs for the commit parents and tree. I'm not competely sure
> of a good way to go about this yet though. I'm also not completely
> certain if this is something that should be adressed as part of this
> series, or could be done later down the road. So for now I've opted to
> delay its implementation. I'm open going down the other route if that is
> preferred though.

There's an API for converting object IDs to another algorithm:
`repo_oid_to_algop`.  If you want to convert a non-blob object, there's
`convert_object_file`, which will serialize the object in the other
format (blobs are invariant in the hash algorithm transformation, so
converting them is not necessary).  Those are present right now in the
codebase and using them would be a good idea.

If you want to test your code in interoperability mode, you can rebase
onto the `sha256-interop` branch of https://github.com/bk2204/git.git
and run with `GIT_TEST_DEFAULT_HASH=3Dsha256:sha1`.

If you're _not_ going to implement that in interoperability mode, then
I'd rather you just die in that case so that the test fails and then I
or someone else will fix it.  `extensions.compatObjectFormat` is
presently experimental and the data formats will change, so nobody
should be relying on it working as it stands right now.  There _will_ be
more compatibility breakage coming in future series, for instance.

I _would_ recommend regardless that you add a test like in t7004's
"signed tag with embedded PGP message" if you apply this to tags as well
as commits.  That requires a special case in our interoperability code
(since it normally converts things that look like signatures, but when
we're _generating_ a tag, we don't want to do that since there are no
signatures yet) and making sure we do the same thing in fast-import will
avoid corruption in our conversions.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--5R04n9EdeVZfQWV6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaZ4pFAAKCRB8DEliiIei
gRTmAQCtW35wOM/XdFrsjXmBLEZLkeijjQnfGaIq8mVnyNzKagD/d3Fi3nJGBv2v
huX9uwWcfziVHQqY5DwTPTUmaw/E+QA=
=KRqX
-----END PGP SIGNATURE-----

--5R04n9EdeVZfQWV6--
