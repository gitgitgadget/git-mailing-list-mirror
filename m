Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E94CB676
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743264461; cv=none; b=R1VAKBQI1NpI8zKOfhbDkJZY3wiWOY8gPhG4uj193TGRGhtwAYXDRRTQs3zhLU6tvaFdv5lSMzR8GJYDb5jEcc2F5cPQAMnq1n2SSy3H85mYrTrD3W70ERaWWbBHRE9TxtkGFRyTfiaW6SHkKGsMtEEU1KuHLnonDiGUr4Y4MBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743264461; c=relaxed/simple;
	bh=jW+7aPck/kSE1Z63ZlwwuOp2hgxrkcmFpowMQK0HMSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUop91P6KXkYc/9jgUMmer0QKBNUyxh9pYk5D0lvY4mh2J7Szx4kD9xYtFzIkFVgM3drEYCacfhsBIjQsMA3+hoaNnBtlo6+NvBgsaryU07WjM2NHAZ5Z+CmrhCJMipUIMqMSllK+6WaNsZMiA1jhPadn5DZwNmnAiuOfmPgGUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xOsVf5Gg; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xOsVf5Gg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1743264456;
	bh=jW+7aPck/kSE1Z63ZlwwuOp2hgxrkcmFpowMQK0HMSM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=xOsVf5GgiM6Hi2HbhTMlfCv2L17EznkheVgEOU6wZCVnRMlyMtD/eiVB0SQ7CUy4Z
	 YBUh3buB4pHh+60TGpM/NskGzGWB3cAdHwPLe4j3VP2AcTuNMls3yUdBAY2e/FWh8R
	 BHK7ht3Ulj1fhN3HfTB1TqelmVSsy3zCh6/4BFskBmQ2cS62vALdebjseu1KZ+O3bN
	 TgjCq1exua6XTcmLf1SjnMUoIwq3fpqnKa7UNhD1nclHsllZ5kcZ+3MY1vNKsVs+d6
	 niJQf4+UpJaBeNvXSN83UaLoWsR4zMjGGqw2O9I6TQTgx0Tz1wXUSHkZA2x5ORzRiC
	 lkg7KkVN5X3enxDFgTGHtHns1dke+t4sAjxspAM0IxEbR2R4QqMXA1EUykiciIGdL1
	 /pESCHECmG4p/qQj1uSMps2N+bUe7MKwW1i2JkEpaz55jQNvliKYm0mY+t4jomTLEH
	 3SuSsDQqSGngRbM3fNXHkkWxIHGUwhEHnEh0WkVgRMZL0x7wveT
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9C86A200FF;
	Sat, 29 Mar 2025 16:07:36 +0000 (UTC)
Date: Sat, 29 Mar 2025 16:07:35 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Akash S <akashs@commvault.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Adithya Urugudige <aurugudige@commvault.com>,
	Abhishek Dalmia <adalmia@commvault.com>
Subject: Re: git push --mirror hung indefinitely
Message-ID: <Z-gaxw8ctTcFUUoV@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Akash S <akashs@commvault.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Adithya Urugudige <aurugudige@commvault.com>,
	Abhishek Dalmia <adalmia@commvault.com>
References: <SA1PR19MB7013490588962D983094128DC0A02@SA1PR19MB7013.namprd19.prod.outlook.com>
 <Z-b66vVzQRFFHFK_@tapette.crustytoothpaste.net>
 <SA1PR19MB70136689E7823F2062D976B5C0A32@SA1PR19MB7013.namprd19.prod.outlook.com>
 <SA1PR19MB70131FCBD314F579B15F8C69C0A32@SA1PR19MB7013.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SjxBW9+XU5pKrM0g"
Content-Disposition: inline
In-Reply-To: <SA1PR19MB70131FCBD314F579B15F8C69C0A32@SA1PR19MB7013.namprd19.prod.outlook.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--SjxBW9+XU5pKrM0g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-29 at 14:07:17, Akash S wrote:
> We compared the GIT_TRACE_PACKET=3D1 output of successful and
> unsuccessful pushes and noticed that the "git flush message 0000" is
> not being received from the Azure DevOps Server during unsuccessful
> push.=20
>=20
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---
>=20
> Successful git push:
> 11:29:09.032050 pkt-line.c:85           packet:          git< ok refs/tag=
s/v3.9.1
> 11:29:09.034601 http.c:878              =3D=3D Info: TLSv1.3 (IN), TLS ap=
p data, [no content] (0):
> 11:29:09.034630 pkt-line.c:85           packet:     sideband< \10000
> 11:29:09.034643 http.c:878              =3D=3D Info: TLSv1.3 (IN), TLS ap=
p data, [no content] (0):
> 11:29:09.034664 pkt-line.c:85           packet:     sideband< 0000
> 11:29:09.034664 pkt-line.c:85           packet:          git< 0000
> 11:29:09.034699 pkt-line.c:85           packet:          git> 0000
> 11:29:09.035667 http.c:878              =3D=3D Info: TLSv1.3 (IN), TLS ap=
p data, [no content] (0):
> 11:29:09.035701 http.c:878              =3D=3D Info: Connection #0 to hos=
t dev.azure.com left intact
> To https://dev.azure.com/ORGNAME/PRJNAME/_git/REPONAME
>=20
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---
>=20
> Unsuccessful git push:
> 11:33:58.759005 pkt-line.c:85           packet:     sideband< \10018ok re=
fs/tags/v3.1.7
> 11:33:58.759035 pkt-line.c:85           packet:          git< ok refs/tag=
s/v3.1.7
> 11:33:58.760165 http.c:878              =3D=3D Info: TLSv1.3 (IN), TLS ap=
p data, [no content] (0):
> 11:33:58.760197 http.c:878              =3D=3D Info: Connection #0 to hos=
t dev.azure.com left intact
> (process hung here)
>=20
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---
>=20
> We noticed that "git push mirror" ultimately spawns "git send-pack"
> with options "--stdin" and "--stateless-rpc" and from the git
> send-pack documentation we confirmed that the line must end with a
> flush packet which is ultimately not happening in the hung cases.
> pstack of send-pack process also shows it is waiting on reading
> packets as you mentioned earlier.

`--stateless-rpc` is used for HTTPS, so that's expected.

> Can you please confirm if the hung issue is due to the missing message or=
 packet from the Azure DevOps Server?

We don't have a full trace output here, so it's hard to say completely
for certain, but from what I know of the protocol off the top of my
head, a flush packet is always required at the end of the section of
message.  So I would say that it's very likely that's the cause here.

Note that it could be that you're _also_ missing one or more `ok`
responses from the ref updates you're doing here, and that it's hanging
_before_ it would normally send the flush packet.  That might point to a
different cause on the server side, but the effect would be the same.

If you're talking to the Azure DevOps people, I'd provide them a full
trace output of both working and non-working pushes so that they can
inspect it themselves, which will help them figure out where it might be
going wrong.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--SjxBW9+XU5pKrM0g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ+gaxwAKCRB8DEliiIei
gYwcAQDtVInUd9eE/mRaTOgUTUDur98dW5Q7sGGf2RLCVhOWOAEA23ZmBAK2FJfw
pJZm/BJmozJNc/pC8b+AsO2gK20LQAc=
=enFf
-----END PGP SIGNATURE-----

--SjxBW9+XU5pKrM0g--
