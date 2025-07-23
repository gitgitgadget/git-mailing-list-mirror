Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ABF1DFCB
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753307847; cv=none; b=N7OOfh8oOc2Zo9gQMTRBtY55YAZVWmzb+eh4xlKbSIs9/YgDfSNngWvegPgsucodfEQKydEROfpHfNyBbZVLCKIOiWm8k04GbxOVLpIJhiGCNcjXZAe9WlV82A5c4gEVsbDU8mG6mvYGU3uiowriAF6SGzVV8H+1+N0wuK+dtPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753307847; c=relaxed/simple;
	bh=TzHUL5IFsAsbBB1W46XXc+ch72DtxeWU8swDDLWtGpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwiVszCsjRnl+O9FZ4t3M/jxnTS2UTQ5sfQCFtcGBsmOf6P7BvYyvVzIeYu8Q9tqFIxV+O51X+jYoti55mgsIlKYcYMhmLGYAXDwD7Kd3AVQkFvQ7oOE0wkkavIytu06pjyQsDlcOSTpkbPdBXUd2aaR8KmGccMBgZQqKKbKkkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=v2YrgV4v; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="v2YrgV4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1753307836;
	bh=TzHUL5IFsAsbBB1W46XXc+ch72DtxeWU8swDDLWtGpk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=v2YrgV4vx194IXn2f62cvIP9Rsi9rDvqTvmbkl0FouEHsCYI6EhIHjIB/r1XVMu8G
	 oDUDK/thGqzNIq55AW0e18XLYjEIzAL8KMcBPFz//M8EjaZmat/FuPKGKxiODBwQSh
	 dOmI9lqIDksh8WH4MA95C5Ay/yMyPTzEgxtoFZkkseaIiRQEs3tqATQMgi0+w9oN64
	 EJzJhG+i8Q5H4gl9BKfcHF6xAlrEescBrYROAxQsOGII3V+c6aWoqg8IGf5C5COC0b
	 u/oBLOH0MpeTpjOM8cel9NFgoZEeEy9D7f7uhsX5T+lelUPhfFXEXOMUjj1qxG3c0S
	 gk0DeqNBW9UHBhtB2zBELJF+bimJNCao9urUXTHMcX96boN2NXRsKIGv9ApXg8kOHA
	 J/CiMUKK54ZYjJtcWoOiys/N6xxxnAqqk2lj/EMON2A8GhRTnPdUshLVwEup3gjduw
	 G1eQUv6pQ0j9BZ2sEn0fdbuZSmdotbABOcasqLt48w26RJruSME
Received: from fruit.crustytoothpaste.net (pool-99-237-158-163.cpe.net.cable.rogers.com [99.237.158.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D7F2820079;
	Wed, 23 Jul 2025 21:57:16 +0000 (UTC)
Date: Wed, 23 Jul 2025 21:57:13 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/7] xdiff: introduce rust
Message-ID: <aIFauT8M0wRfaZV8@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <2a1f4be13dfbdee21811b7a4907f99042c791c2d.1752784344.git.gitgitgadget@gmail.com>
 <aHlrg7pbFqi2qNWH@fruit.crustytoothpaste.net>
 <CAH=ZcbBebM6CememqOUFY2YPOXpk_mC=zE0OnLOKDqcJQTdMuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VbznPgVVlP5EyOwH"
Content-Disposition: inline
In-Reply-To: <CAH=ZcbBebM6CememqOUFY2YPOXpk_mC=zE0OnLOKDqcJQTdMuA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--VbznPgVVlP5EyOwH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-18 at 23:15:19, Ezekiel Newren wrote:
> This goes against what I think is best practices.  Don=E2=80=99t we need
> Cargo.lock to audit and debug platform specific issues, and to ensure
> reproducibility?  Without Cargo.lock, we might get different results
> one minute to the next if one of our dependencies releases a new
> version. Checking in Cargo.lock aligns with Cargo=E2=80=99s documented be=
st
> practices (https://doc.rust-lang.org/cargo/faq.html#why-have-cargolock-in=
-version-control).

I appreciate that, but best practices also don't limit software to a
six-week lifespan.  Rust the language is a great tool, but we also have
a special case here in that we need to support software that upstream
does not and that we care about OS distros, which upstream does not.

Note that when someone builds locally, a Cargo.lock will be created and
they will get reproducible builds from that point on.  It is only on
first build that they will get whatever's the latest.

> I understand your concern and I agree that this could become a
> problem. I=E2=80=99m totally flexible on which rust version should be use=
d,
> but without Cargo.lock checked in we lose the ability to audit why a
> build failed. I think that this will be a pain point, but numbing that
> pain means we can=E2=80=99t solve intermittent problems due to dependenci=
es in
> the future.

I was one of the maintainers for Git LFS for several years.  We
routinely had people come to us and say, "This dependency you're using
has a portion that you're not using, which has a CVE.  I demand you
update it and do a new release immediately because our security scanner
is going off and our company policy is that there be no exceptions."
This happens literally all the time and I absolutely in no case want to
see those people on this list or the security list.

So the options as I see them are (a) we don't check in Cargo.lock, (b)
we convince the Rust project and the ecosystem to provide LTS releases
with security fixes, or (c) we only accept dependencies that have our
same lifetime policy (which are very few and far between).  I know this
makes builds unreproducible (although not under the Reproducible Builds
project's definitions), but we really don't have many alternatives.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--VbznPgVVlP5EyOwH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaIFauQAKCRB8DEliiIei
gaIuAP9g5dSRZ3KC2L6bexDg30oDIhbuv70ewdXwpxjVeyM8twD/TyKYrLSAiBcE
ajBjWWSKZF2svy8cJUE/TO3HY/DGdg8=
=zLxl
-----END PGP SIGNATURE-----

--VbznPgVVlP5EyOwH--
