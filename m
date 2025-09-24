Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248016F265
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733911; cv=none; b=NRBGnyxnzLEcFW6D3ye3CtS1L1Oa9+qDJUyz/s5O/e/v/d9IwlUP0dfOfRGg1kEmwIjwJsUfSEl6yXxOByqog7vVVMHfxUPy3Y8yy+5kYM23tbiftdUr3aAbB6L8ib2DBVs16MMFZ1KPv2SOWRk21VjfFYm3UCbMuEMd3R3MUwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733911; c=relaxed/simple;
	bh=/w/KN4iNMjJZM0dmLUaaCH6cNw0743uyyluXqMGu418=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWyIOyVSsyC4l0THjJ1GJP/1k9GbTqqt04lcIAahTPPu2IlcUfcqQvMR8ltnnYJgxiY9exPRP/b4Q2xJmNlmid4zZ3VGpO65DNOkY2plZXcrPVZoxLz9VLcDISYuSrFw64CggRLNPSHZsIYHxlC0RAXYTIL93H/w+qqXb5gtoHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com; spf=pass smtp.mailfrom=velocifyer.com; dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b=m0hmc5Hu; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=velocifyer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=velocifyer.com header.i=@velocifyer.com header.b="m0hmc5Hu"
Message-ID: <771fc44e-32d4-4758-b497-bcef86433446@velocifyer.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=velocifyer.com;
	s=key1; t=1758733906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/w/KN4iNMjJZM0dmLUaaCH6cNw0743uyyluXqMGu418=;
	b=m0hmc5HuDf4Ft47z+iEqlK6wfxUUicAc5OfbZJd4Vig6quqlLPv3Dg2a0tUi/vHnyh6jm9
	/jBAUPYgZ398qUsA9ixEGBRLTgR0wtlWtjyUm4RSAfhxX7wYXujlGB4UlIUq7rqi7bsScF
	lfMBeckMyzdHyFZpOviVRGIYmJ8g6Yt1l4Nmo3OU9pzWQPj76jGsLfNgmzY/yfD0PBoayE
	+Ja2gu0fErdem2CzkHEwHkpwEmz5RCyOSEsmG7JEnEjlATxTX1PanBpc3TdbzGz6zNxHq9
	VlEkQvdWNMrJjbWCEmQH4MHMOIoE5jxXDlhKjUJ0wVxHyJWB3/huAE7DdcltwA==
Date: Wed, 24 Sep 2025 13:11:35 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 0-Based indexes for git log
To: Junio C Hamano <gitster@pobox.com>, Nico Williams <nico@cryptonector.com>
Cc: git@vger.kernel.org
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
 <aNQRoMgSRVvNtStG@ubby> <xmqqh5wrn66m.fsf@gitster.g>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
Autocrypt: addr=velocifyer@velocifyer.com; keydata=
 xjMEaCpEhBYJKwYBBAHaRw8BAQdAZBZWSN4ekixMHE7duMBmw/2uteCfmp68D/mxaYk/dyrN
 JlZlbG9jaWZ5ZXIgPHZlbG9jaWZ5ZXJAdmVsb2NpZnllci5jb20+wo8EExYIADcWIQQboPxL
 gODyGwJpjO5jTr+HQMdIvgUCaCpEhAUJBaOagAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEGNO
 v4dAx0i+HU8BAJGd99DA1VdBzcYgch16XK7mC78ZqEwGegVCRerWry8RAQC3MJUOiyQ062Ol
 /3iNXY6zk2QXaAsV8eUbFKUo1HiwAs44BGgqRIUSCisGAQQBl1UBBQEBB0CEoaVGilG8Qt/y
 Xp135G4fhWjJH7VQkPIFo8/MsZspfwMBCAfCfgQYFggAJhYhBBug/EuA4PIbAmmM7mNOv4dA
 x0i+BQJoKkSFBQkFo5qAAhsMAAoJEGNOv4dAx0i+yNYBAKcE1fbRCPqWwsIpRvOjSq9Spvhl
 veEFpUMPaQ1tp7qOAPkBfZroJ8veENH/8sz+Gf/QK6O1kcqC4d/vAASzMpOiAQ==
In-Reply-To: <xmqqh5wrn66m.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bgtam90fFKPO6rMEvDJt5XdH"
X-Migadu-Flow: FLOW_OUT

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bgtam90fFKPO6rMEvDJt5XdH
Content-Type: multipart/mixed; boundary="------------ao80gJcZCVKiC5AtOeu6coKu";
 protected-headers="v1"
From: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>
To: Junio C Hamano <gitster@pobox.com>, Nico Williams <nico@cryptonector.com>
Cc: git@vger.kernel.org
Message-ID: <771fc44e-32d4-4758-b497-bcef86433446@velocifyer.com>
Subject: Re: 0-Based indexes for git log
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
 <aNQRoMgSRVvNtStG@ubby> <xmqqh5wrn66m.fsf@gitster.g>
In-Reply-To: <xmqqh5wrn66m.fsf@gitster.g>

--------------ao80gJcZCVKiC5AtOeu6coKu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

Pj4gRGF5IG9mIG1vbnRoIG51bWJlcnMgYXJlIDEtYmFzZWQuDQo+IENvcnJlY3QuDQpObywg
ZGF5IG9mIG1vbnRoIG51bWJlcnMgYXJlIDAtYmFzZWQuDQo+IFRoZXJlIGFyZSBhIGZldyB0
aGluZ3MgaW4gR2l0IHRoYXQgYXJlIDAgYmFzZWQsIGJ1dCBub3Qgc28gbWFueS4NCj4NCj4g
ICAqIHBhcmVudCBudW1iZXJzIGFyZSAxLWJhc2VkLiAgSEVBRH4xIGlzIHRoZSAicHJldmlv
dXMgY29tbWl0IiwgYWthDQo+ICAgICAiZmlyc3QgcGFyZW50Ii4gIEhFQUR+MCBpcyB0aGUg
SEVBRCBpdHNlbGYuDQpIRUFEfjEganVzdCBtZWFucyBIRUFEIC0gMSBjb21taXQuKEFLQSAi
cmV2ZXJzZSAwLWJhc2VkIGluZGV4IikNCj4gICAqIHJlZmxvZyBlbnRyaWVzIGFyZSAxLWJh
c2VkLiAgQHsxfSBpcyB0aGUgInByZXZpb3VzIG9iamVjdCBwb2ludGVkDQo+ICAgICBieSB0
aGUgY3VycmVudCBicmFuY2giLCBAezJ9IGlzIG9uZSBiZWZvcmUgdGhhdC4gIEB7MH0gaXMg
dGhlDQo+ICAgICBjdXJyZW50IGJyYW5jaCBpdHNlbGYuDQpObywgdGhhdCBpcyBqdXN0IGEg
cmV2ZXJzZSAwLWJhc2VkIGluZGV4Lg0KPiAgICogc3Rhc2ggZW50cmllcyBhcmUgY291bnRl
ZCAwLWJhc2VkLiAgImdpdCBzdGFzaCBsaXN0IiBzaG93cyBmcm9tDQo+ICAgICBzdGFzaEB7
MH0gdGhhdCBpcyB0aGUgbW9zdCByZWNlbnRseSBjcmVhdGVkIHN0YXNoIGVudHJ5Lg0KDQpU
aGF0IGlzIGNvcnJlY3QuIEl0J3MgYSByZXZlcnNlIDAtYmFzZWQgaW5kZXggYmVjdWFzZSBp
dCB1c2VzIHJlZmxvZyBzeW50YXguDQoNCi0tIA0KR2VvcmdlIHRydWx5LCDwnZWN8J2VlvCd
lZ3wnZWg8J2VlPCdlZrwnZWX8J2VqvCdlZbwnZWjDQpUaGlzIGVtYWlsIGRvZXMgbm90IGNv
bnN0aXR1dGUgYSBsZWdhbGx5IGJpbmRpbmcgY29udHJhY3QNCg==

--------------ao80gJcZCVKiC5AtOeu6coKu--

--------------bgtam90fFKPO6rMEvDJt5XdH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQboPxLgODyGwJpjO5jTr+HQMdIvgUCaNQmRwUDAAAAAAAKCRBjTr+HQMdIvlf5
AQDPYvt1BLi9/zbwe8QIyBn0sTJyHsPz/UUH4Cx1gCMV7wD7BJ3FOCpFHr0DT628PiB78pnKiiM4
rBt9l+NPlft0UQ8=
=fcPk
-----END PGP SIGNATURE-----

--------------bgtam90fFKPO6rMEvDJt5XdH--
