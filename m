Received: from mail.m-u.xyz (mail.m-u.xyz [213.95.149.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD4733F390
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.149.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716619; cv=none; b=D79ecK6mbNie8LU02QXFIdiCf0tBpzHqQU/rZ0oHCLQ4LH1WiIQfZAsvQyaQXuwnB7ocPH2DKrbaeRsOb/yom9j9cx9TKtiQ/FLTjPMXuyPeVoAAW3ILOADKwtaEO8JvEy5k+HOjbL5SdJ+CTl2RK2rEEanpHnRHOa5rCL7LgoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716619; c=relaxed/simple;
	bh=EfsjCZMhUKuJO+H/0eSnZRj+R5qgRAEOgINA3MI18HQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=azD+9rNh0tnxqiaJecgvSJ0McLakOYQwJk5vdMdVfYTtRNjOMwFg3fX/dEqMM/pjjafrwryshIwdtNcPgouXMXqMN+buoftc+09GFEK3OOadQT9ZwzYBkMDa+rT/6Bk6Cm/tlE+4f34QIWjLPRedscfeCd2fym3WVRwdfy0viXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=urlichs.de; spf=pass smtp.mailfrom=urlichs.de; dkim=pass (4096-bit key) header.d=urlichs.de header.i=@urlichs.de header.b=JPIcvf3V; arc=none smtp.client-ip=213.95.149.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=urlichs.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=urlichs.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=urlichs.de header.i=@urlichs.de header.b="JPIcvf3V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=urlichs.de;
	s=20160512; h=From:Date:Message-ID;
	bh=EfsjCZMhUKuJO+H/0eSnZRj+R5qgRAEOgINA3MI18HQ=; b=JPIcvf3V8Nu/eNo4ruTM5o0v2S
	qpemb3mETh8mZixNLKE4YQn4kiaYShZp5BlSAxkWOVFqLXwtJbhSoNiBzk9j73jwcN8TWPaUeOM/D
	VaQZALYRgZkyYxmAGvOkgpp6H3SMojkZOyTGRA3khGGpDQRrGzAwGDTT/DkRqOg4hOCPS4bLFxIcd
	EJ69HCWR0axr9HrzTf0yQccDrim3cA/brbkU7kq6w4+V+3Fha21m8mBu1NfdBER+QuAvHCWQP60d3
	CJMuaSnnLEvU9XB1GzfSXBQ+RoXyX+Bx20SNg6RcpcBKYDyURXa4kDYHBhWBTeokF3NXfta+8jKyr
	9URWx9k7t32OoUAw1tnKWznZK7idFAni2Ch8W8HiJ2xHqDj9LG5to88AM2kcM0euPsB7pdmbjz4Xi
	0CssjZMYQd0I0CaWF7fsGnutHJU+onS4cDbZQGTgnSm8AdYveK7xfDPoZEr6Z3F8xiMiTg6kpQuoE
	g+bEYFbHiSew2OUDw7bWoTKf9qMZPjZ+aMDoxYkkx0YIVjLiTfo6k2qiZlpoGt9g32g5rfL4V5FB8
	pIqFz6tGyFEo+I4V27lVtCt+tjFQHoqxXOVeiPUxO8h73XDb5BYVrbRakQHPkb3u/j/Ra/RSkF8dV
	cbSco3Ctew7ZHJCIyATaM4KHlDyx/tQwaGsZdh7+s=;
Received: from asi.s.smurf.noris.de ([2001:780:107:200::a])
	by vm-mail with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <matthias@urlichs.de>)
	id 1vpjLQ-00000000Ptb-1IZN
	for git@vger.kernel.org;
	Tue, 10 Feb 2026 09:43:42 +0100
Message-ID: <87e16dc6-cac4-473d-aab1-c18a1473b77e@urlichs.de>
Date: Tue, 10 Feb 2026 09:43:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Matthias Urlichs <matthias@urlichs.de>
Subject: Bug: signed commits vs. git-fast-export
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8DcCHctngAoZBWPjCIJo3mvh"
X-Smurf-Spam-Score: -1.0 (-)
X-Smurf-Whitelist: +relay_from_hosts

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8DcCHctngAoZBWPjCIJo3mvh
Content-Type: multipart/mixed; boundary="------------03w2LejBrB2CLXHBxo0iofzW";
 protected-headers="v1"
Message-ID: <87e16dc6-cac4-473d-aab1-c18a1473b77e@urlichs.de>
Date: Tue, 10 Feb 2026 09:43:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Matthias Urlichs <matthias@urlichs.de>
Subject: Bug: signed commits vs. git-fast-export

--------------03w2LejBrB2CLXHBxo0iofzW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

U29tZSByZXBvc2l0b3JpZXMgY29udGFpbiBzaWduZWQgY29tbWl0cy4gImdpdCBmYXN0LWV4
cG9ydCIgc2lsZW50bHkgDQpza2lwcyB0aGVtLiBUaGlzIGJyZWFrcyAiZ2l0IGZpbHRlci1y
ZXBvIi4NCg0KRXhhbXBsZToNCg0KJCBnaXQgY2F0LWZpbGUgLXAgNzY1NzcwOWEyNjAwODQ5
YjY5MzA3YTQyODMxNGE4YWRiMWQ4YTdmNg0KdHJlZSBiNzNkYmJjYjhjMGJiODAxOTdkODJl
ZGFhYTI0YTM4M2JiODA4MzNjDQphdXRob3IgZWFkYWxpIDxlcmthbmFkYWxpOTFAZ21haWwu
Y29tPiAxNjU1NzI5Njc2ICswMzAwDQpjb21taXR0ZXIgR2l0SHViIDxub3JlcGx5QGdpdGh1
Yi5jb20+IDE2NTU3Mjk2NzYgKzAzMDANCmdwZ3NpZyAtLS0tLUJFR0lOIFBHUCBTSUdOQVRV
UkUtLS0tLQ0KDQogwqB3c0JjQkFBQkNBQVFCUUppc0c0TUNSQks3aGo0T3Yzckl3QUFBdlFJ
QUFkY2ZaZndJOENtM0FIUWhYUmpFbnYzDQogwqByNmx4T1BEZkg3dkFiTWVNUzYveVVFWkxR
STJjVm5XdUt6VXRUeXRIMDdhYU5KNmtEYzRGb2lnUnA5Q25uME9WDQogwqAzdUJTbm00VWNw
TGxxNDFxRDMyOEw4NitxQmJIV0hLektBTmoxbkszWlEyZUxRa0RrUStaaTBvenlwdnhLSERt
DQogwqBLMU5OQXZsVEljOGtjemdzZkg5T1JVaW4yNnFnTXZqQVQydnpkbWhLTGxIVmVUelZO
a2k2a2VucXEzemRVQk9nDQogwqA3VmVvbnZweTNTQTVMbm1Qa0NOczlzNHFGVy9QYXVUaGlG
UTg3VzFrWEZiU0o4aGtGWUtIT1NjSVEya2d5LzBNDQogwqBjN0ZoK2p4U3UrSENHTGMyVXYz
V1lodEdiUU5URDUrOVZEVjNGeFdPUzhJaVZ1ai9rYkNUZUVpMTV4UTNzZlk9DQogwqA9RzZk
QQ0KIMKgLS0tLS1FTkQgUEdQIFNJR05BVFVSRS0tLS0tDQoNCg0KSW5pdGlhbCBjb21taXQN
Clsgbm8gdHJhaWxpbmcgbmV3bGluZSBdDQoNCiQgZ2l0IGZhc3QtZXhwb3J0IC0tbm8tZGF0
YSA3NjU3NzA5YTI2MDA4NDliNjkzMDdhNDI4MzE0YThhZGIxZDhhN2Y2IA0KLS1zaWduZWQt
dGFncz12ZXJiYXRpbQ0KcmVzZXQgNzY1NzcwOWEyNjAwODQ5YjY5MzA3YTQyODMxNGE4YWRi
MWQ4YTdmNg0KY29tbWl0IDc2NTc3MDlhMjYwMDg0OWI2OTMwN2E0MjgzMTRhOGFkYjFkOGE3
ZjYNCm1hcmsgOjENCmF1dGhvciBlYWRhbGkgPGVya2FuYWRhbGk5MUBnbWFpbC5jb20+IDE2
NTU3Mjk2NzYgKzAzMDANCmNvbW1pdHRlciBHaXRIdWIgPG5vcmVwbHlAZ2l0aHViLmNvbT4g
MTY1NTcyOTY3NiArMDMwMA0KZGF0YSAxNA0KSW5pdGlhbCBjb21taXRNIDEwMDY0NCBiNmU0
NzYxN2RlMTEwZGVhN2NhNDdlMDg3ZmYxMzQ3Y2MyNjQ2ZWRhIC5naXRpZ25vcmUNCk0gMTAw
NjQ0IGNjYzdhOGMyNTNlNDBjYzA4ZDllNGQxMjJjMTU4NWQyOWVkZmM4ODMgTElDRU5TRQ0K
TSAxMDA2NDQgZjY1ZTI3YTY0ODg1YzdiZjU2M2UwYjZlOTc0YzBiZWFlYzE2NDI4YyBSRUFE
TUUubWQNCg0KLS0gDQotLSBtaXQgZnJldW5kbGljaGVuIEdyw7zDn2VuDQotLSANCi0tIE1h
dHRoaWFzIFVybGljaHMNCg0K

--------------03w2LejBrB2CLXHBxo0iofzW--

--------------8DcCHctngAoZBWPjCIJo3mvh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEr9eXgvO67AILKKGfcs+OXiW0wpMFAmmK76QFAwAAAAAACgkQcs+OXiW0wpO2
wRAAvzldwdh8l8XocgCEW7cKgLfISfuIs9dxBcUbugeJ2Vovgl716RvRbO6Qt5u8NY5mf9iZVAys
o7GxysvAEWf92M/dsbLke7UyZ2Fd8Da8c94VEJ9pU1R8JERdWgTwqiRpG8ANnjFOz4zqa8ahND/E
Eq8JDNi0hCAZHB9is3Ml5/TFHc/no+nJDjUi0/iEmqyZBAe9phCVkmR1Og/Cn8rLCMit4sL+aDaZ
a6FxOPZ7hgvDdtlA2H1LglHVuudw39DC6PMuTcrZm6OHEbsJWDuK0LasRCIB9OVCED8NA/FW0/Vv
MsselRPAVeAfKUHgiVqNBe7CzNCMEtgNn1xpURf314zmwsxorTyRVssF0zf8dPNy/MimsMDtafCj
0qBWMLcTFv9bIfJ1vAzbp7ZpkBnyuUO03Vjzt1Y3kghsIwXwSFfQUlcNY71LJj8cQjADwb/ByXkd
jDQpAQI2f3xX6GCZ2An4fWo6RB3cpEDYQFsr3U1UwMpGpC4IPq87gBrC7ImwD9jQfsXcoqr5Mb4p
eaSYX14hYHDJU6rnbXpyPQjLPVGuxIoAEgGbPjfRPblGu/8E9H/F4fwZ+O5/8POY6SBKW1GOFjdF
gB6yj0LbFFWUsw8JsIhQwW6Uzz2inCTEelm1/ZAdaz0RHyGNJoZjFx+atIZboZbTQ/Wyeg9ao1vV
HsI=
=gEi6
-----END PGP SIGNATURE-----

--------------8DcCHctngAoZBWPjCIJo3mvh--
