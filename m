Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1590768EE
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710451300; cv=none; b=WH+9nTqa90KeJC1GLPjYbScWF5fEkOkCQfwfnCHWQ8492wApaRZJ81xVldqKaWLK93Qn1vN6iUG++VzWcjjuSVQJ7mSikRpb5Uj2tSxXPuvwr+lFfTYBtigGSDoPHd4fRQOrApXgsF/7cGtnfylDBT0VwXRXFqREKgabkbalBDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710451300; c=relaxed/simple;
	bh=INO0yebkPgFyrYcN0xCKx6HYGYBsxlXqk5r/voWni0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhBb1wpTgjnME2x4zRAw+RmQc2gZrcFIrP8/pewvJLrh3dWwIC3EMb3ZBWo31C8vFzyz0bKCTxlqQ1PgZaBTXS3GDciYqzkJo5cITgDOk9MLJoMiTYrwGGgyEEOTE29kjcDBQUpAXe1KWEVgsVw7l2nDrgjnvUD3ZqYZeuyMpmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=HcIVkAzD; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HcIVkAzD"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D5EBC5B3D7;
	Thu, 14 Mar 2024 21:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1710451289;
	bh=INO0yebkPgFyrYcN0xCKx6HYGYBsxlXqk5r/voWni0o=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=HcIVkAzD1DtkA/78g9E7cExj3PAd1X76dO/CXZ8zUOQRvmi1E+2d0PtWQ4iohKQsu
	 LYIu9q5q53qlo2xhDLkoaTiCeHD0YRioIGpaBFOQeVBblBNFokwZk0mk55jUXhXsu8
	 /rGUEffv1hjBtlWaE7XYruwPr3J2vtpWy+acN31vO2ozVsechpUXIvwzSImE6L4fvI
	 NzOTEpO5q4b82uSvtjnYpsvc71xTPraaDhzBI5CPvH5o5zjruJ6BQMP/+CRpoFhFlw
	 WjNxPh/TmVX1HDRgSI64zZ2TQc28/QzZzW6VC+UW59X/zgxMNME5i3lZ9euzZ9NC8Y
	 T9pVcj5IBtiHK3wjNEj0lkjqemCFdrI8yZF9Gki1M5Q3wsxKf1EJDofXFe0a5rVqhS
	 Z1PVIxqPmcxpBUxuequUbORW6y/o8AFpDr1TllTQKDEEW5KiiuYDwq9cWEKabfQimk
	 TrLoScdGgkLVfSwSkyQilu6SRlqV+Qv4iBYuPwv7INIpQFZIPrG
Date: Thu, 14 Mar 2024 21:21:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "Eric W. Biederman" <ebiederm@gmail.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc/gitremote-helpers: match object-format option
 docs to code
Message-ID: <ZfNqVowQBy47_92m@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
References: <20240307084735.GA2072130@coredump.intra.peff.net>
 <20240307085632.GB2072294@coredump.intra.peff.net>
 <Zeo9oAkL6kxZRugN@tapette.crustytoothpaste.net>
 <20240312074513.GA47852@coredump.intra.peff.net>
 <ZfIWkJieqcPv5jA8@tapette.crustytoothpaste.net>
 <87ttl99e0b.fsf@gmail.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KX20+gcrPw0MUeif"
Content-Disposition: inline
In-Reply-To: <87ttl99e0b.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Mutt/2.2.12 (2023-09-09)


--KX20+gcrPw0MUeif
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-14 at 12:47:16, Eric W. Biederman wrote:
> That said I think a lot of think we do a lot of that today in practice
> by simply detecting the length of the hash.

That's only true for the dumb HTTP protocol.  Everything else should not
do that and we specifically want to avoid doing that, since we may very
well end up with SHA-3-256 or another 256-bit hash instead of SHA-256 if
there are sufficient cryptographic advances.

In fact, if we're going to support reftables via the dumb HTTP protocol,
then we should add some sort of capability advertisement that tells the
remote side what functionality is supported, and simply specify the hash
in that format.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--KX20+gcrPw0MUeif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZfNqVgAKCRB8DEliiIei
gepyAQDgQkt0AFUsjr78YKtEMhHqVr1hiYatuv2utIim3a3Y8AEA3WrzmeKSIokj
qetc3sohUkeieZREkN7ghNCp6xqHgw4=
=iA5D
-----END PGP SIGNATURE-----

--KX20+gcrPw0MUeif--
