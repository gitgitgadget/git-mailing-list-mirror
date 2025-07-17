Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3322AEF5
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752789097; cv=none; b=YVBp7P05NeIRYo5h9q/TB+uVTXCUwB1OgX0WeXNn+nHQOXju8twkqXkTMqDWmTlYqjqI/64H0SI7IOoa/OBvxyg7TWjqR387Ho9RH05eGnSTaikoM0nriLICbNCiz9vGuxQlyc4Ja8PfWedMJHsscFglHoDZl8wiE7z2aAmPKzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752789097; c=relaxed/simple;
	bh=e2BJpCP2dszBc1d0+2Hj5BQKoKxoLA4gI1wQ1GHlH+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQ7iL2Zwl0HT3maWVFojJqiRAx52dmPid9rH3UKJtN2peIh1JP5QZ/baXebFEb2epYCTXVjDrGgOv53G0EY6+pLJmifx1k4wUeZrBtEAqQWeSZYGS/JE4PSPGwR4+Ba60L5/YImGCxvcRaEDbWuZiiQ/qrdW2VUocbtrEdr54O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=jHprnKb9; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jHprnKb9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752789093;
	bh=e2BJpCP2dszBc1d0+2Hj5BQKoKxoLA4gI1wQ1GHlH+8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=jHprnKb9kEkUDUf88GX7L2ClKs90fprXeMb8G4MbeNb3qR+LCGZO1SiWQo4m1XDgJ
	 vKabMB6oahTzurtqNPqxiZVnfNaRtsb1u30ybbCzLhOrJUGAKTCLxqQ7yh/lNisrCM
	 sZlWCWevZeOhgfs9mi27Bne+UbhOUlUMd+IAryagjauCN4koi3XSZWfJ1ut+cav+fT
	 ddiV4K/jt/bNWJCx22f4yTCSO9dofekBWGEArkTuJV3bNM0u9vbhqinSzFXICG+MYg
	 or1/0I8SOUc/seYZ8TMbg+I00hMX16CA37LNShKtPCuIPhCR8h0OboOkxyDOHDsAbB
	 88LpuJdUhP1JrctT80YdqvTNZ4PKEXrIgq0gyGudq31ZZmNyh+t5pQzHS1jWbm3fPN
	 OZt8iZgr64UOUAGdREsv0OOA2PO9ppcTLFJ4Fv5EPVJEKsQcyw9f8CbhjG0ctDOjSG
	 1QqN4aSqfGpV9QzPlFnWNAJg8EjgpiO3OS1o6rYxyGgedeAJmRw
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c351:2fb1:6e4f:b4fb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8360F2007E;
	Thu, 17 Jul 2025 21:51:33 +0000 (UTC)
Date: Thu, 17 Jul 2025 21:51:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
Message-ID: <aHlwZPbiKnakMN75@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nq+Sz7b+C3Q/gikD"
Content-Disposition: inline
In-Reply-To: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Nq+Sz7b+C3Q/gikD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-17 at 20:32:17, Ezekiel Newren via GitGitGadget wrote:
> This series accelerates xdiff by 5-19%.

That's great.

> It also introduces Rust as a hard dependency.

I think that's fine.  We already discussed doing this at the last
Contributor Summit in Berlin and everyone was in favour.  While we did
not have every contributor represented, I think that unanimity of the
contributors present is a compelling enough reason.

> =E2=80=A6and it doesn=E2=80=99t yet pass a couple of the github workflows=
; hints from
> Windows experts, and opinions on ambiguous primitives would be appreciated
> (see below).
>=20
> This is just the beginning of many patches that I have to convert portions
> of, maybe eventually all of, xdiff to Rust. While working on that
> conversion, I found several ways to clarify the code, along with some
> optimizations.
>=20
> So...
>=20
> This obviously raises the question of whether we are ready to accept a ha=
rd
> dependency on Rust. Previous discussions on the mailing list and at Git
> Merge 2024 have not answered that question. If not now, will we be willing
> to accept such a hard dependency later? And what route do we want to take=
 to
> get there?

Again, I think that's fine.

I have a proposed policy at [0] (available from the `rust` branch on
that remote).  Included in that policy is a link to [1], which I
summarize as "the U.S. government is proposing to classify development
in memory unsafe languages as a Product Security Bad Practice."  The
proposal is that a memory safety roadmap be introduced by the end of
2025.

Now, do let me be clear that I don't agree with everything that the U.S.
government says or does (far from it), but I do think this is a sensible
proposal (or I wouldn't have cited it) and it will be showing up in a
lot more security standards coming down the line, especially for those
forges and companies which will be selling to governments around the
world.  There's no time like the present to do this.

I realize that that means that we will lose support for some platforms.
I ultimately think that it's up to the porters and maintainers for a
platform to maintain appropriate toolchains on that platform and that,
while we should be cognizant of the requirements for adding new
platforms or architectures, that shouldn't prevent the inclusion of
important new tools like memory-safe languages.

I would like to see a change to our platform policy and a policy on Rust
before we merge this.  I know your series adds support for 1.87, but
because distros don't run the latest toolchain, we had discussed in the
past targeting Debian stable's version plus an additional year after the
new release.  This means we'll support a Rust version for three years,
which is a reasonable amount of time for a toolchain and allows distros
to easily backport security fixes.

If you would like, you are welcome to use my proposed policy as a basis
for this, or I can send that out as a separate document if you don't
want to write one or revise mine.

[0] https://github.com/bk2204/git/commit/fbeb1180c7473635a964daed2da642c534=
87782d
[1] https://www.cisa.gov/resources-tools/resources/product-security-bad-pra=
ctices
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Nq+Sz7b+C3Q/gikD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaHlwYwAKCRB8DEliiIei
gVglAP0U2Bt8T3CD9Z6VNKsNKMx6ruN0p0MH5D+wfgROl7DDGAD/fOivk0THRqqa
4bctS6nkT5WeQKsarHcsYt/GtD8qdgc=
=zCwf
-----END PGP SIGNATURE-----

--Nq+Sz7b+C3Q/gikD--
