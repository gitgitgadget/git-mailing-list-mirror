Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD60813635E
	for <git@vger.kernel.org>; Sun,  2 Nov 2025 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762099095; cv=none; b=Xkx+Ev+L6UzXxfIUxmU389xkRJMA1mDnVUQjwYgRB5Yp39BBBxe0gFChEyf8UNasVMCZHZaVprUahBd9TbF/N4h0IDtwBAAjdzjG8Ke/ZK2dfW9k22clV0SRALHjWaH0tNyMPlplNKH04AJ58CvEswRirQFO1oIiDLH7HZIXQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762099095; c=relaxed/simple;
	bh=7oKdMnn1WnuuhAdqGMWToP9FpYARaDO9GQv0TBUcwto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jagyFtK+4/iFL1bw6FBMZQZW3ZXb1fbM4M759OG3qQynB7VxAhPgDv1G7IsZy4pyvisyvDyu/Pt6FMjdEJ0/hjsCwdMiVXSNMeqgdYlYMXe5f8qsuw1NMW6UvzBgpSFwr2Vc9EFdwdXNSrWDMIJ3gkutwJQLkt2Vh/r39d92kg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=BguF5/ud; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BguF5/ud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1762099084;
	bh=7oKdMnn1WnuuhAdqGMWToP9FpYARaDO9GQv0TBUcwto=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=BguF5/udcfG6vSjwrSkNBIWEW7B94+j6d0CZ1WcifLpY6Z9nCbUqxPkYI1SWbtzc1
	 fOUDhdafr7xo1TKi06Y4aePMX+dYaMup6k2SRtbPvNTRWawhNmOXvMYJKRyld7PVSt
	 Pocwo/MqMvNUKGGL8zvlFqSHFxQdA0U1iK9QBCLi5rELStl/KKjg2ax5Yjn3ZrZR46
	 B2ZnSTeC27gYrMs0AZCrMIaSis1FAQCjvHlfrosV9Qn83D0vNuHcsXvzEsOM6KsTTW
	 PL9JkGUSYlUv4ElZ6bc3kutPRN4eufvQaehotetKfLhlvCLfWKZZF6uTw3sit7o4TY
	 QzFJbfFjsql/brUp7wcW1K6zXZzu0GQF8o2Go68MJ4oVBOBJh3gYs/jd0RUGc1c1fI
	 y/niMPlOmtyif2fHwaJcXNNHVAVVSrBVXQ8k6s8W+V2sgrEAeD1Esf/hW1BPb+LR2P
	 a1YsSw0HDPLJ5Ssz4KEd6RayStREiqvSMH0N08Ve06U+Q0LKqcs
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f137:1a1:be0f:4e87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7AFB820037;
	Sun,  2 Nov 2025 15:58:04 +0000 (UTC)
Date: Sun, 2 Nov 2025 15:58:02 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Thomas Klausner <wiz@gatalith.at>
Cc: git@vger.kernel.org
Subject: Re: CVE-2024-52005 status?
Message-ID: <aQd_iisOrwX909Fr@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Thomas Klausner <wiz@gatalith.at>, git@vger.kernel.org
References: <7mfgh4ufx6wr3ict2ee6utg3vvfpiy6xi3rfyfu4yionmcwu6a@yry3kefdxbwf>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ojv/hKmNqaUnxPfF"
Content-Disposition: inline
In-Reply-To: <7mfgh4ufx6wr3ict2ee6utg3vvfpiy6xi3rfyfu4yionmcwu6a@yry3kefdxbwf>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ojv/hKmNqaUnxPfF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-11-02 at 00:48:53, Thomas Klausner wrote:
> Hi!
>=20
> I'm trying to find out more details about CVE-2024-52005 so I can
> handle it correctly in pkgsrc.
>=20
> https://nvd.nist.gov/vuln/detail/CVE-2024-52005
>=20
> points to
>=20
> https://github.com/git/git/security/advisories/GHSA-7jjc-gg6m-3329
>=20
> which lists many affected versions, but no fixed versions.  I only
> found one reference to the CVE in the release announcement for 'Git
> for Windows' 2.47.1(2):
>=20
> https://groups.google.com/g/git-packagers/c/ZWDc6K6tYcc/m/VxikezMeCgAJ
>=20
> The CVE description sounds like this also might affect non-Windows Git
> versions. Can someone please tell me if this was fixed, and in which
> version?

We determined this was not a vulnerability.  The Git for Windows
maintainer disagreed and listed it as one nevertheless.

The problem is that on some terminal emulators, including at least some
of the ones available on Windows, you can execute arbitrary binaries by
creating a hyperlink via terminal codes and having someone click on it.
That is, however, a bug in the terminal emulator and not in Git, since
clicking a URL should not lead to code execution.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ojv/hKmNqaUnxPfF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQd/igAKCRB8DEliiIei
gfibAP0a9JBEgDBNt6gVAgkXYj5UIbts7HKve+0lZj+tWz5gPQD+NVj/XG2AfufK
GDO9bbTn3oTPb8XgK2ks1JVkCCADqAA=
=XpbC
-----END PGP SIGNATURE-----

--ojv/hKmNqaUnxPfF--
