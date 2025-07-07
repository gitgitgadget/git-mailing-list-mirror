Received: from mx1.ddevault.org (mx1.ddevault.org [172.233.46.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF58A2620E7
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.233.46.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872189; cv=none; b=sXkXY+ftrMmzBknYznfOWIyNxZN2d/JcsT7iOi1lA2IDqc9vZ7fKUPmqbE2hC+YJanvrTepJwr82g0aIOv8DWunyhO7panCuOwM6B3m61xHYkbzwTi3aU8t0TuiNZehyeWE3IGeHx6B2dX8n7P08d2YRaXQqGXybzypRhE42TXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872189; c=relaxed/simple;
	bh=5KTdX7qLvNEcrXtDke+/M7pXcf+Ha9v3hNW+gcfKQdk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=tKj+to79FcTjpGwnfcIw3TMOxOS0trr6Wf/ZPC8q+BjFhsFHByl5l8P/pbenHgHqS2Fqa/LxctFB8oT4BPSibs752B3RVBts28TFzyD0UHBbet2TmSmII5IEU44Zi8BZM8FSeqK/o/UDZCcku5EtK4FMi1CQotIhTay4mPwhZqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org; spf=pass smtp.mailfrom=ddevault.org; dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b=YSAEc0s0; arc=none smtp.client-ip=172.233.46.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddevault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b="YSAEc0s0"
DKIM-Signature: a=rsa-sha256; bh=Dtaxb+s9acgCGtWxSrkjviDv/EScuDHyzfEq7Y07IOY=;
 c=relaxed/relaxed; d=ddevault.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@ddevault.org; s=default; t=1751872176; v=1; x=1752304176;
 b=YSAEc0s0Tnw3pay7TxprxeVtdok1SECA+16jLOBZuis96zHfmmbrgAfIEGwaW2R+uYLXRC6Y
 C/v0z6xYBuQPM/UiY5sunvtMSZTsPFXz8BkD8fDRUCC+CqrBnhXa+9zRAUDoqmRVu23mDtxiZXP
 PiwwIbDW0wTbUzXfUqBLZQPeUQ49bzWoOcvOOIBZ5yZUpN9K5651DEqP21wfg/Mn9Qr4AOt+yaH
 OcfmRhYUTmWqdzh3xZzeVPk/4uLPj38bL1yr88I6n2PVJell7UwkzqnjHINT84uBtwzrA83Z00Q
 Z4OLpnV4+OX0eTJzzQjk0xE9niEQa+GjoMJlu6c/pUXEg==
Received: by mx1.ddevault.org (envelope-sender <drew@ddevault.org>) with
 ESMTPS id a67284c1; Mon, 07 Jul 2025 07:09:36 +0000
Received: by taiga (Postfix, from userid 1000)
	id 3F0F470206F2; Mon, 07 Jul 2025 09:09:36 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=7af60d983b7d262fa79eae05247ddca0cbee402a9f1f7f20c19f1910e934;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 07 Jul 2025 09:09:34 +0200
Message-Id: <DB5MUUDPF6C0.3OR02N6JQB8H8@ddevault.org>
From: "Drew DeVault" <drew@ddevault.org>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Aditya Garg" <gargaditya08@live.com>, <git@vger.kernel.org>, "Martin
 von Zweigbergk" <martinvonz@google.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Andy Koppe" <andy.koppe@gmail.com>, "Remo Senekowitsch"
 <remo@buenzli.dev>, "Jeff King" <peff@peff.net>, "Junio C Hamano"
 <jch2355@gmail.com>
Subject: Re: [PATCH v2 1/2] pretty: add X-Change-ID to mail formats
X-Mailer: aerc 0.20.1-64-g7cb8e0e7ce24-dirty
References: <20250703113505.11889-1-drew@ddevault.org>
 <PN3PR01MB9597069B8CF014BFE01B53F3B84CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <DB4WQTRHWZN3.3VG20AZDK8VN@ddevault.org> <xmqqfrf8ait6.fsf@gitster.g>
In-Reply-To: <xmqqfrf8ait6.fsf@gitster.g>

--7af60d983b7d262fa79eae05247ddca0cbee402a9f1f7f20c19f1910e934
Content-Type: multipart/mixed;
 boundary=330c2d711f65ee66bf1bb0a137cab8207cf88c6500d94497e8e71aa02544

--330c2d711f65ee66bf1bb0a137cab8207cf88c6500d94497e8e71aa02544
Content-Type: multipart/alternative;
 boundary=165ec16f4967138206d61f7487e38a56022b441db4d74089de46a9790de6

--165ec16f4967138206d61f7487e38a56022b441db4d74089de46a9790de6
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Mon Jul 7, 2025 at 3:30 AM CEST, Junio C Hamano wrote:
> I would suggest a lot more generic implementation to solve it once
> and for all.  How about doing it more like this:
>
>    "git format-patch --extra-headers" grabs all extra headers
>    (i.e. those that are not the bog-standard "tree", "parent",
>    "author", "committer") and emit these
>
>     X-git-extra-commit-header: encoding=3Diso8859-1
>     X-git-extra-commit-header: frotz=3Dnitfol
>
>    next to "Subject:", etc.

+1. I particularly like how this approach throws out a bunch of arguing
over the utility of the specific use-case -- clever :)

Do you think there's any reason not to throw all extra headers into
X-git-extra-commit-header (or whatever) unconditionally? Does it need to
be behind a flag or config option? If some tool added the extra commit
headers, they presumably have a good reason for doing so and we ought to
encode that information so we can reproduce the commit properly, same as
we would with the rest of the commit headers.

I suppose there is a scenario where this breaks something because
someone has a poorly thought-out string munging parser for git
format-patch output that will barf upon encountering the unexpected, or
some mail provider rejects emails rather than silently dropping headers
it doesn't like, but both possibilities seem remote -- especially when
considering that these hypothetical edge cases have to be combined with
a use-case which deploys extra commit headers in the first place.

--165ec16f4967138206d61f7487e38a56022b441db4d74089de46a9790de6--

--330c2d711f65ee66bf1bb0a137cab8207cf88c6500d94497e8e71aa02544
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=42F3F1862E3CC4B8.asc
Content-Type: application/pgp-keys; charset=UTF-8

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptRE1FWjdZOWt4WUpLd1lCQkFI
YVJ3OEJBUWRBL3BQeTZYK25OTDVUMlFhSktFTTA4eE4vS3o3d0ZUQVpvSDVZCnJpVjl4MW0wSUVS
eVpYY2dSR1ZXWVhWc2RDQThaSEpsZDBCa1pHVjJZWFZzZEM1dmNtYytpSk1FRXhZS0FEc0MKR3dN
RkN3a0lCd0lDSWdJR0ZRb0pDQXNDQkJZQ0F3RUNIZ2NDRjRBV0lRU2Z0ZWMzM0NXeW5ZN3NScEZD
OC9HRwpManpFdUFVQ1o3WTl3d0FLQ1JCQzgvR0dManpFdU1FRUFQOURIKzFMZ3ZUcVpETFo4YmFi
QjVDZHA1eTBaVytRClR4NzhtaDFMOGpKZDZnRUFzc21nc0ltY3JadjRhZFAyVVc1UlU1QkhDZTlL
VWR4MER5VjgzUXdsRkFTNE9BUm4KdGoyVEVnb3JCZ0VFQVpkVkFRVUJBUWRBR0FIOWRsYUNPTm9Y
cG1RZ0hvUWdZSTJ0UytWTTNtelU4STJQeVZZUQoxR1VEQVFnSGlIZ0VHQllLQUNBQ0d3d1dJUVNm
dGVjMzNDV3luWTdzUnBGQzgvR0dManpFdUFVQ1o3WTkxZ0FLCkNSQkM4L0dHTGp6RXVIY25BUDR5
ak9pTTB5cWtTVDZ5WHpEVVd6ZTdCOUltMjRGOEhWeCt3TnFjRGFEdGNBRC8KZktRaHowU0NQaWJs
TzZsYzdNRlV2bGFPejJ2ODdVcFVZUmh6UGRnUXF3az0KPWVtcmIKLS0tLS1FTkQgUEdQIFBVQkxJ
QyBLRVkgQkxPQ0stLS0tLQo=
--330c2d711f65ee66bf1bb0a137cab8207cf88c6500d94497e8e71aa02544--

--7af60d983b7d262fa79eae05247ddca0cbee402a9f1f7f20c19f1910e934
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSftec33CWynY7sRpFC8/GGLjzEuAUCaGtyrgAKCRBC8/GGLjzE
uCDCAP4/IIvEqbWx1aBc9SDzub5xrtA22mbi/7gLPYvTBeh3fAD+LHeJUYh4/Nym
ec5jii0+8oRFruakxD7c8SzUFD1xqQM=
=VcR5
-----END PGP SIGNATURE-----

--7af60d983b7d262fa79eae05247ddca0cbee402a9f1f7f20c19f1910e934--
