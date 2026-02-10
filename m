Received: from mail.m-u.xyz (mail.m-u.xyz [213.95.149.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0DE341648
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.149.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716621; cv=none; b=qHUYVbCl0HzO3fySJPk+FUIfGHayaW7jqM7NaDvJadsnwVW9B4M5gdU+Gvw+rAlcqsq/JpW4pPLi2+1cQfGjIYJfqTQBD0IejoxeeiPhjhgPTKwsZSM2is+nPWtX9YpqfSf3iADQJppLR+OzGSyDZNTT9/TNtn7VnMXcD+nOue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716621; c=relaxed/simple;
	bh=5s/IaDs0MJ2TJQ9snNqHajLaS5Bw/9DE7K+mIo97vUM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=dSit/oj2XgTtPYP7t3OIR6SIJVBpITUOVl+dpJHqVQUPJQNsyg863VeLniKgOSo6SvQZh/4QjrjCDj8BozHj2IZ24YjXn8gjIgUPMXyBfOLK0MsERk7Lw3lA/Aeyguj84aKR2JLsBaV+CQgXMIkIQzJfNsm4mpQUYtq4I5Elj/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=urlichs.de; spf=pass smtp.mailfrom=urlichs.de; dkim=pass (4096-bit key) header.d=urlichs.de header.i=@urlichs.de header.b=vPnqm89I; arc=none smtp.client-ip=213.95.149.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=urlichs.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=urlichs.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=urlichs.de header.i=@urlichs.de header.b="vPnqm89I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=urlichs.de;
	s=20160512; h=From:Date:Message-ID;
	bh=5s/IaDs0MJ2TJQ9snNqHajLaS5Bw/9DE7K+mIo97vUM=; b=vPnqm89InlCbYVFJ4LamwgEv8O
	we1ikIMESC98AaaeNHWjixrcsAgqce9KO6hWKgAp7w2ivPKwAuOQke9r8drJtMXpJXb9J7xHp/LS1
	wI0zk5tBl/xE5t2hn6JlSXSVeu28Tu+7KmRv493x4rgMuBQsKPefSBBpzlJUOM/ZNs9rQeR+7VgsL
	q3jj335ulF9wFrPZ7xrQXFw/JL5yFCIL5hr7VQt4b+WVrFAQbLPDD8QWjpW1aeHIxMKV6P8lcaZ4S
	xTiKSkjH+6+nYzUw3xip/y/+QIC0OEr253EFo9fcswSc/VAfltuSl0+R1GoWaooIOCksoyjI6VSbx
	Z/GBoB1TKS8qNxeh71DkCG/i4A7l/fNDA55OE0nMpbzdJX3VTCUWcQ3Z7Ggm6ciSynBO4FeoAYQ8O
	snAUlXQs8oU6NdQgJ4XhJSN2aT3bfqVP9c+6k/siTUUWu8lL873kvGaHBVdGk2gdFT528AzGkop/g
	fJv67hPvEAT9nUpMYy64DavyRkGh6LPjfdvERQMFoo3lItX0pkRJ/L29K5+blXrCT1kgZMXq4o0o6
	hp1WqdvbK1MOna856N/HGURI80FL9UBNdDHo6Zq+PUKmjqFn/Mdz3xBIi8Mktfuv8cJuig1sFyWp1
	pOVVDcwxRowmZakQ9eEnQFs7jUwAd5zhKgouW3RHY=;
Received: from asi.s.smurf.noris.de ([2001:780:107:200::a])
	by vm-mail with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <matthias@urlichs.de>)
	id 1vpjZr-000000000FU-2J4s
	for git@vger.kernel.org;
	Tue, 10 Feb 2026 09:58:36 +0100
Message-ID: <d00dd3e5-dafc-4967-9212-9780e18aeab2@urlichs.de>
Date: Tue, 10 Feb 2026 09:58:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: signed commits vs. git-fast-export
From: Matthias Urlichs <matthias@urlichs.de>
To: git@vger.kernel.org
References: <87e16dc6-cac4-473d-aab1-c18a1473b77e@urlichs.de>
Content-Language: en-US
In-Reply-To: <87e16dc6-cac4-473d-aab1-c18a1473b77e@urlichs.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rLMD48uGFZkpAvFxNnYFIEkQ"
X-Smurf-Spam-Score: -1.0 (-)
X-Smurf-Whitelist: +relay_from_hosts

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rLMD48uGFZkpAvFxNnYFIEkQ
Content-Type: multipart/mixed; boundary="------------2F82AeUwlsApXMi9cdkLcaFV";
 protected-headers="v1"
Message-ID: <d00dd3e5-dafc-4967-9212-9780e18aeab2@urlichs.de>
Date: Tue, 10 Feb 2026 09:58:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: signed commits vs. git-fast-export
From: Matthias Urlichs <matthias@urlichs.de>
To: git@vger.kernel.org
References: <87e16dc6-cac4-473d-aab1-c18a1473b77e@urlichs.de>
Content-Language: en-US
In-Reply-To: <87e16dc6-cac4-473d-aab1-c18a1473b77e@urlichs.de>

--------------2F82AeUwlsApXMi9cdkLcaFV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T29wcywgSSBzZWUgdGhhdCBjdXJyZW50IGdpdCBhbHJlYWR5IGNvbnRhaW5zIGFuIG9wdGlv
biB0byBjb250cm9sIHRoYXQuIA0KSSBzaG91bGQgaGF2ZSBjaGVja2VkIG1vcmUgY2xvc2Vs
eSDigKYNCg0KTkIgLS1zaWduZWQtY29tbWl0cyBzaG91bGQgcHJvYmFibHkgZGVmYXVsdCB0
byB3aGF0ZXZlciAtLXNpZ25lZC10YWdzIA0Kc2F5cywgdW5sZXNzIG92ZXJyaWRkZW4uDQoN
Ci0tIA0KLS0gbWl0IGZyZXVuZGxpY2hlbiBHcsO8w59lbg0KLS0gDQotLSBNYXR0aGlhcyBV
cmxpY2hzDQoNCg==

--------------2F82AeUwlsApXMi9cdkLcaFV--

--------------rLMD48uGFZkpAvFxNnYFIEkQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEr9eXgvO67AILKKGfcs+OXiW0wpMFAmmK8yAFAwAAAAAACgkQcs+OXiW0wpPA
qQ//ceW6ndFs0hVYnz1wQ7h61Q6ZMyn+UXqDu7/Pl2cc8mvd/Zime+IACKs3hqk6G6x76t9QeT9G
rbPxgwjWBlLmWSnkbqybh10Sl/xpgXub/ew+4XtCcN1SRIvKVW0IUHZoWdb86EvvdUGRK5Nkpw0T
tdyEHufARML6JOQ+tZEFe48cvDnNHlLmDJxndgL7VzRy1mXZWEHEl+pQme+z6GukvPDnQWBR4EMK
TcyJxfa03jA1XVUHrh0dnvCCsOo8UDsQNYHZKmHTsbwXZVKwqlLcPAGx1Jzw32kbDTOH8cVO7JUU
lECFFKNsp4kjS9Xtgpwq+mE6ky068IwxTG0yYOhEBOCPqhP66BV1brVBCEOlC7l7yUHnynS5DpfJ
jS6FIovJE9eM/skGZptWZaAUZbt4GaEG+X+fiV3n/VGRKzQ0EKneVXI3TdRtJmMupEqWPGm92Jfi
GvfrkoOrDjeTc5N5di95qmeILKRIce2/S25o9Oxhe8z2uVVdBtI8k3WF4SzviEaWhFl5es1lnAwv
629gPQyO/qfBgzori19tCpayqQZm5etxNdRxWjLohw8P6NwiKskyLv8gujHpv9YriNhbOK3aIjqQ
wnyRpdENST32rbcQq1Tl4t08JpcpAgVUfcuqUmEqZELkxW4LtJbFXgr4jYES0EN73uXBKJ/1oUBJ
sRg=
=q+Lh
-----END PGP SIGNATURE-----

--------------rLMD48uGFZkpAvFxNnYFIEkQ--
