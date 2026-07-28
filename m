Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C39412264
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273139; cv=none; b=rVb24rrNdJ3hePaIunxJ9BDYv2wxlWD7v6hfh1t1HFxjJ9XPINnSpFUG56z8FzrwjWiNynrExuRcDmUHAVZesQ8XEzcE9AXyMvFC90nrA02di4FEPHA9AOuQ621xcjp62gLi5Kwe+Z3dHiF9UaeSmzsr3DXQpMMoET1WSz1wy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273139; c=relaxed/simple;
	bh=up7LkGu17O4okZooqoXVZ3e+XEvTzrmUw5GAGZ2OwYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mR89MlMOHxvG/PIKF5R7I4Wdwm8Zt4tIKB73uFnPk6GOirb+GzWgINh79QoZHiArcT9r5++wjClsijW5zet2S0wXNZQOvoggdbNJXRO8Of7qXOJfbGS97MMFEdD8p+d7ei2yEBiI1RXBlO+Hc1jKDGNYIk2q26z/H5kyh3rp0jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=QA0+jFXD; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QA0+jFXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785273136;
	bh=up7LkGu17O4okZooqoXVZ3e+XEvTzrmUw5GAGZ2OwYE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=QA0+jFXDzpmDDdcNUA0FJilCtkdtmce2SFS+QaF1z5NrrGBesA8/SeqEQCeTqmSkU
	 OdcecUXuDqLwjS/gw5210CT5EZRtDGU6WihSPgOTXBd/nl6e+dHqZ1DQ/XjE2EEhKv
	 a1fduOzAahuCVvQdVjznE5lt+ggx02KGCaIuFyabRVBgedldQBkN7BDidL6daBLHdk
	 wHN73IlWtrKHE20XTpSTI0MPrn4nCWzE6L+UOuJoU8Jf0C+s2NvK+3sVhrPM3E3+Il
	 xgzIf+lW5+h9MwFR/aRa7U7leM8QInRkCJOOJhDHgzr3ZP/3vMRRPPaZNMxYsCWKUf
	 eVrtyboTNiksk5JT2d31ZAI+0CenBD+xHKVi9HoPUrNppMTvL4/jZILwrAFg3g9ifz
	 IO30yP6VD4cd7qeNU0JmZeyvSqX3VXWqEW0yK9auaybb130/apIzraIY4Cd+I7JBpU
	 LzLUWJVgoXix2s7mTZ2WhY4dfatSEHpgIx3d9tz6GSU4cOIN2Hm
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3e63:6e70:6235:fd22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 74E4220083;
	Tue, 28 Jul 2026 21:12:16 +0000 (UTC)
Date: Tue, 28 Jul 2026 21:12:15 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [PATCH 2/2] t0014: generate deprecated command names dynamically
Message-ID: <amkbLnNCeeziWATm@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk,
	git@vger.kernel.org
References: <20260728143653.GB11894@coredump.intra.peff.net>
 <20260728143845.GB41686@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3GuAQus1Ghxf+9Lx"
Content-Disposition: inline
In-Reply-To: <20260728143845.GB41686@coredump.intra.peff.net>
User-Agent: Mutt/2.4.0 (2026-06-19)

--3GuAQus1Ghxf+9Lx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-07-28 at 14:38:45, Jeff King wrote:
> We have a few tests related to aliasing of deprecated commands. They use
> whatchanged and pack-redundant because those are the only two deprecated
> commands we have. Eventually those commands will be removed, at which
> point these tests will be checking nothing useful (they'll just be
> regular aliases, which we already cover in other tests).
>=20
> We could remove them at that point, but the code to handle deprecated
> commands will still remain. We probably do want to keep the tests around
> for the eventual day that we deprecate more commands. So let's ask Git
> for its list of deprecated commands, and if we don't have any, skip
> those tests.
>=20
> This also prevents an annoying corner case when your build directory
> contains old build products. Right now those commands are marked as
> deprecated builtins and treated specially; we allow aliases and never
> look for them as dashed external commands. But after they are removed,
> they aren't special anymore. If your directory happens to contain
> hardlinks from the build of an older version, that confuses Git: it sees
> the old hardlinks in place, thinks those are actual external commands,
> and refuses to allow aliasing.
>=20
> You can see that today like this:
>=20
>   make
>   make WITH_BREAKING_CHANGES=3D1 test
>=20
> The first "make" creates git-whatchanged as a hardlink to Git, and the
> second does not clean it up (it doesn't know about the whatchanged
> command at all anymore). t0014 fails because Git won't create an alias
> to the "external" whatchanged command.

These patches look sensible.  I was planning to spend some time this
morning investigating more since I woke up early, but I appreciate you
sending some patches in to fix them.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--3GuAQus1Ghxf+9Lx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmppGy4JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ3l2H+E5TBlxOZWp9D1yriWGvLWjMc0NRONWcyQAKnvY
FiEECCzmip28ZfuD0cORfAxJYoiHooEAALF0AQC9+Z61Ki2Fay9aJgiY233HSg3S
X7JZFEseAaJqwUcpHQEAxeUF24jqc+OhTF3jQDycLsk340I9BGgpdZDn07WlHw4=
=Llm7
-----END PGP SIGNATURE-----

--3GuAQus1Ghxf+9Lx--
