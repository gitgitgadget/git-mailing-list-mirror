Received: from smtp1.lxd.bsocat.net (lxd4.cloud.bsocat.net [37.187.92.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F31D6FC5
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.187.92.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728263195; cv=none; b=ca6mqH1jlev9bfPHxOk8m7D645GBaQXUZXuP2TMtE/ffI/xlwj7pIu2zcqHyqGmOmOFdCZLaDm34qpPRJGLmfZJKgMtiFppDrCpVPn/SQUCozIsgTPi/B0lrFjCefr57p7TpwvmUB2hi/X6kCcToFvivv2XFi3rshbDkq3MPjLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728263195; c=relaxed/simple;
	bh=+RS99D1CDFRbVZeIaS1KKGXc7j4AagpT+3lbjIFP7VE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Kidotrg/p7yQlJDr4auz0QikGc6f7nXPA3130B0j+KXZnOsQ5VuBu4QLTOOuZi7gb9U8DMECM+WpcK2pAcVRFzZja3yBNOqCz8ACpocyBgElu7gQQrOfH4V09w3ph9kQLiUlewDCCutYtyU3b8PQsw1XxySt1cvUXgVts0WGQ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=benary.org; spf=pass smtp.mailfrom=benary.org; dkim=pass (1024-bit key) header.d=benary.org header.i=@benary.org header.b=gTPR+Pgm; arc=none smtp.client-ip=37.187.92.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=benary.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benary.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=benary.org header.i=@benary.org header.b="gTPR+Pgm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benary.org; s=gnufor;
	t=1728262790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=+RS99D1CDFRbVZeIaS1KKGXc7j4AagpT+3lbjIFP7VE=;
	b=gTPR+PgmDfqyV8sf7mVt76NtV4TspD+OgpljGmNx467oQprV6zcvD69JE/XJnfFBbv2pj/
	+/JuLZa/etcgw8y/CI83MfVa8RuqxKLTxtKZ/X01vmpx76jACm81zRQo6MpkWQptFINuTb
	of+DO2KIDof5g2JrnuqfvHWW3EGXaTc=
Received: from [IPV6:2a0c:b641:a40:0:2fa:5bff:fe25:4e0b] (gnutoo.home.bsocat.net [2a0c:b641:a40:0:2fa:5bff:fe25:4e0b])
	by smtp1 (OpenSMTPD) with ESMTPSA id 6ecb0861 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 7 Oct 2024 00:59:50 +0000 (UTC)
Message-ID: <353abc17-d65b-409f-8784-e2267e2be243@benary.org>
Date: Mon, 7 Oct 2024 00:59:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: benaryorg <binary@benary.org>
Autocrypt: addr=binary@benary.org; keydata=
 xjMEZPRnKxYJKwYBBAHaRw8BAQdAAKdlNe0o2M0j1n2xyv8Amf+7ct0odnZp4jEAX4Y3S4TN
 HWJlbmFyeW9yZyA8YmluYXJ5QGJlbmFyeS5vcmc+wpwEExYKAEQCGwMFCQWjmoAFCwkIBwIC
 IgIGFQoJCAsCBBYCAwECHgcCF4AWIQSAS2y4rtVh2T2tTcXi8ixe3yARnQUCZPRoPAIZAQAK
 CRDi8ixe3yARnY3PAQCuFua4uDblRjF011aWK6KI0mueNX1gZu+SAzO6myGAKAD/aga/N26m
 1UFPE3yt1MmC6d/3ALQ4tSeuvIbQ0LDFJgLOOARk9GcrEgorBgEEAZdVAQUBAQdAsrZv4Bxa
 d00C48383RfNVMnYtqRP8pu2dwiqr1Y9r3ADAQgHwn4EGBYKACYWIQSAS2y4rtVh2T2tTcXi
 8ixe3yARnQUCZPRnKwIbDAUJBaOagAAKCRDi8ixe3yARnWVmAP0UsdgYTanOIdnE2f2wBCbo
 7oncBxEY0NXIvAA70R4JsAEAu6nxEMD5b7SlMikbj1ARXG6ZlcQWM95zMOCHC7JykgA=
Subject: how to use git with unreachable paths (namespaces, proc)?
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Hyx8lZVr0yP1i03inh9EpFea"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Hyx8lZVr0yP1i03inh9EpFea
Content-Type: multipart/mixed; boundary="------------8wUDr0DeFl7oacS73Mgl0pZ9";
 protected-headers="v1"
From: benaryorg <binary@benary.org>
To: git@vger.kernel.org
Message-ID: <353abc17-d65b-409f-8784-e2267e2be243@benary.org>
Subject: how to use git with unreachable paths (namespaces, proc)?

--------------8wUDr0DeFl7oacS73Mgl0pZ9
Content-Type: multipart/mixed; boundary="------------a0xfao9LCGG1UYaiu7joXwXa"

--------------a0xfao9LCGG1UYaiu7joXwXa
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QWZ0ZXIgdHJ5aW5nIHRvIGNvbnZpbmNlIHNlYXJjaCBlbmdpbmVzIHRvIHRhbGsgdG8gbWUg
YWJvdXQgZ2l0IGFuZCB1bnJlYWNoYWJsZSBwYXRocyBvciBkaXJlY3RvcmllcyBhbmQgc3lt
bGlua3MsIEkndmUgZ2l2ZW4gdXAgZ2l2ZW4gaG93IGRpZmZpY3VsdCBpdCBpcyB0byBzZWFy
Y2ggZm9yIHRoaXMuDQoNClRoZSBpc3N1ZSBJJ20gcnVubmluZyBpbnRvIGlzIHdoZW4gZ2l0
IG9uIExpbnV4IGlzIGZhY2VkIHdpdGggdW5yZWFjaGFibGUgcGF0aHMsIGxpa2UgYSBzeW1s
aW5rIHRoYXQgcG9pbnRzIGF0IGEgZGlyZWN0b3J5IHRoYXQgaXMgb3RoZXJ3aXNlIHVucmVh
Y2hhYmxlIGZyb20gdGhlIGZpbGVzeXN0ZW0sIG9yIHdoZW4gdGhlIGN1cnJlbnQgd29ya2lu
ZyBkaXJlY3RvcnkgcmVzaWRlcyBpbiBhIHBsYWNlIHRoYXQgaXMgbm90IGEgZGVzY2VuZGFu
dCBmcm9tIC8gKHN5bWxpbmtzIHRoZSBsaWtlcyBvZiAvZGV2L2ZkIGFuZCAvcHJvYy8uLi4v
ZmQpLg0KTXkgdXNlIGNhc2UgaXMgdHJ5aW5nIHRvIGFjY2VzcyBhIGRpcmVjdG9yeSB2aWEg
YW4gb3BlbiBmaWxlIGRlc2NyaXB0b3IgZnJvbSB3aXRoaW4gYSBMaW51eCBuYW1lc3BhY2Ug
KGNyZWF0ZWQgdXNpbmcgYnViYmxld3JhcCwgYmFzaWNhbGx5IGEgc2FuZGJveCB3aXRob3V0
IG15IGhvbWUgZGlyZWN0b3J5KS4NClNvbWV0aGluZyBhbG9uZyB0aGVzZSBsaW5lcyBzaG91
bGQgd29yazoNCg0KICAgICBid3JhcCAtLXVuc2hhcmUtYWxsIC0tc2hhcmUtbmV0IC0tcm8t
YmluZCAvYmluIC9iaW4gLS1yby1iaW5kIC91c3IgL3VzciAtLXJvLWJpbmQgL2xpYiAvbGli
IC0tcm8tYmluZCAvZXRjIC9ldGMgLS1yby1iaW5kIC9zYmluIC9zYmluIC0tZGV2IC9kZXYg
LS1wcm9jIC9wcm9jIC0tZGlyIH4gLS1jaGRpciB+ICRTSEVMTCAzPCB+L0RvY3VtZW50cy9t
eV9naXRfZGlyICMgKGFkZCBtb3JlIHJvLWJpbmRzIGFzIG5lY2Vzc2FyeSwgYWxzbyBhc3N1
bWVzIHlvdXIgaG9tZSBpcyBub3QgaW4gYW55IG9mIHRoZSByby1iaW5kcykNCg0KVGhpcyBz
aG91bGQgZHJvcCB5b3UgaW4geW91ciB1c3VhbCBzaGVsbCBidXQgd2l0aG91dCB5b3VyIGhv
bWUgZGlyZWN0b3J5LCBob3dldmVyIGl0IHNob3VsZCBhbHNvIGdpdmUgeW91IGFjY2VzcyB0
byB0aGUgZ2l0IGRpcmVjdG9yeSBwcm92aWRlZCBpbiB0aGUgbGFzdCBiaXQgdmlhIC9wcm9j
LyQkL2ZkLzMsIC9kZXYvZmQvMywgb3Igc2ltaWxhci4NCihJIGFtIGF3YXJlIHRoYXQgdGhp
cyBlZmZlY3RpdmVseSBicmVha3MgdGhlIHNlY3VyaXR5IGd1YXJhbnRlZXMgb2YgdGhlIHNh
bmRib3ggc2luY2UgYWNjZXNzaW5nIC9wcm9jLyQkL2ZkLzMvLi4vLi4vLi4gd29ya3MsIGhv
d2V2ZXIgc2VjdXJpdHkgd2Fzbid0IHRoZSBwb2ludCBvZiB0aGUgc2FuZGJveCB0byBiZWdp
biB3aXRoKQ0KTm93IGlmIHlvdSB0cnkgdG8gY2QgdG8gL3Byb2MvJCQvZmQvMyBhbmQgcnVu
IHNvbWV0aGluZyBsaWtlIGBnaXQgc3RhdHVzYCB5b3UnbGwgYmUgZ3JlZXRlZCBieSBgZmF0
YWw6IFVuYWJsZSB0byByZWFkIGN1cnJlbnQgd29ya2luZyBkaXJlY3Rvcnk6IE5vIHN1Y2gg
ZmlsZSBvciBkaXJlY3RvcnlgIChhdCBsZWFzdCBvbiBteSBtYWNoaW5lKS4NCkNsb25pbmcg
dGhlIHJlcG9zaXRvcnkgc2VlbXMgdG8gd29yaywgaG93ZXZlciBpZiB5b3UnZCB3YW50IHRv
IGNsb25lIGl0IHdpdGhvdXQgZHVwbGljYXRpbmcgdGhlIGRhdGEgeW91IG1heSBiZSBpbmNs
aW5lZCB0byB1c2UgYGdpdCBjbG9uZSAtLXNoYXJlZCAvcHJvYy8kJC9mZC8zYCB3aGljaCBl
cnIncyBvdXQgd2l0aCBhIGxvdCBvZiBgZXJyb3I6IHVuYWJsZSB0byBub3JtYWxpemUgYWx0
ZXJuYXRlIG9iamVjdCBwYXRoOiAvcHJvYy8yL2ZkLzMvLmdpdC9vYmplY3RzYC4NClNpbWls
YXJseSBgY2QgLVAgL3Byb2MvJCQvZmQvMyAmJiBnaXQgY2xvbmUgLS1zaGFyZWQgLiB+L3Rl
c3RgIHdpbGwgZmFpbCB3aXRoIGBmYXRhbDogdW5hYmxlIHRvIGdldCBjdXJyZW50IHdvcmtp
bmcgZGlyZWN0b3J5OiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5YC4NCg0KTm93IGFzIGZh
ciBhcyBJIGNhbiB0ZWxsIHRoaXMgaXMgYmVjYXVzZSBnaXQgdHJpZXMgdG8gcmVzb2x2ZSB0
aGUgc3ltbGlua3MgaW4gdGhlIHBhdGggKC9wcm9jLyQkL2ZkLzMgaXMgcHJvdmlkZWQgYnkg
dGhlIGtlcm5lbCBhcyBhIHN5bWxpbmsgdG8gfi9Eb2N1bWVudHMvbXlfZ2l0X2RpciBldmVu
IHRob3VnaCBpdCBkb2Vzbid0IGV4aXN0IGluIHRoYXQgaGllcmFyY2h5LCB5ZXQgeW91IGNh
biBhY2Nlc3MgaXQsIHBsZWFzZSBkb24ndCBhc2sgbWUgYWJvdXQgdGhlIHNwZWNpZmljcyBv
ZiB0aGF0KSBhbmQgdGhlbiBhY2Nlc3MgdGhlbSwgd2hpY2ggb2YgY291cnNlIGhlcmUgZG9l
c24ndCB3b3JrIG91dC4NCkZvciB0aGUgc2hhcmVkIGNsb25lIEkgdW5kZXJzdGFuZCB3aHkg
YSBwYXRoIGlzIG5lY2Vzc2FyeSwgY29uc2lkZXJpbmcgdGhhdCBpdCBuZWVkcyB0byBhZGQg
dGhlIHJlZmVyZW5jZXMgdG8gdGhlIG5ldyByZXBvc2l0b3J5LCBob3dldmVyIHRoZXJlIHNl
ZW1zIHRvIGJlIG5vIGZhbGxiYWNrIGZvciBhIHNjZW5hcmlvIGxpa2UgdGhpcyBvbmUuDQpz
dHJhY2UgdGVsbHMgbWUgdGhhdCB0aGUgY2FsbCB0byBgZ2V0Y3dkKDIpYCB5aWVsZHMgdGhl
IHBhdGggKG91dHNpZGUgdGhlIG5hbWVzcGFjZSkgcHJlZml4ZWQgd2l0aCAiKHVucmVhY2hh
YmxlKSIsIHdoaWNoIHdvdWxkIGV4cGxhaW4gd2h5IHRoaW5ncyBmYWxsIGFwYXJ0IChhcyB0
aGlzIHBhdGggaXMgbmVpdGhlciBhYnNvbHV0ZSBub3IgYWNjZXNzaWJsZSksIG9yIGluIG90
aGVyIGNhc2VzIHRoYXQgZ2l0IHRyaWVzIHRvIHdhbGsgdGhlIHRyZWUgdXAgKGFuZCBieSB0
aGF0IEkgbWVhbiB0aGUgdHJlZSBvdXRzaWRlIHRoZSBuYW1lc3BhY2UpIHVudGlsIGl0IGhp
dHMgcm9vdCwgd2hpY2ggSSBhc3N1bWUgaXMgaXRzIHdheSB0byB0cnkgYW5kIGNhbm9uaWNh
bGl6ZSB0aGUgcGF0aCwgd2hpY2ggaGVyZSB3b24ndCB3b3JrIGVpdGhlci4NCg0KU28gbXkg
cXVlc3Rpb24gaXM6IGlzIHRoaXMgYSBidWcgb3IgaW50ZW50aW9uYWwgYmVoYXZpb3VyIChn
aXZlbiBob3cgcGFydGljdWxhciBnaXQgaXMgYXJvdW5kIHN5bWxpbmtzIEkgY2FuIGltYWdp
bmUgZWl0aGVyKSwgYW5kIGhvdyBjYW4gSSB3b3JrIGFyb3VuZCB0aGlzIGFuZCBtYWtlIGdp
dCBwZXJmb3JtIGJhc2ljIG9wZXJhdGlvbnMgc3VjaCBhcyBzdGF0dXMsIGFyY2hpdmUsIG9y
IGFsdGVybmF0aXZlbHkgZ2V0IGNsb25lIHdpdGggYC0tc2hhcmVkYCB0byB3b3JrIHNvIHRo
YXQgZ2l0IGNhbiBhdCBsZWFzdCBvcGVyYXRlIG9uIGEgc2VwYXJhdGUgcmVwb3NpdG9yeSB3
aXRob3V0IGFsbCB0aGUgcHJpb3Igb2JqZWN0cyBiZWluZyBkdXBsaWNhdGVkPw0KQWxzbyBu
b3RlIHRoYXQgdGhpcyBpcyBhYnNvbHV0ZWx5IG5vdCBpbXBvcnRhbnQgdG8gbWUsIHNvIGlm
IHRoaXMgaXMganVzdCBzb21ldGhpbmcgdGhhdCBnaXQgY2Fubm90IGhhbmRsZSBpbiBpdHMg
Y3VycmVudCBpbXBsZW1lbnRhdGlvbiB0aGF0J2QgYmUgZmluZSBieSBtZSwgSSBqdXN0IGZp
Z3VyZWQgdGhlIGNoYW5jZXMgdGhhdCBzb21lb25lIHdpbGwgcmVwbHkgdG8gdGhpcyB3aXRo
ICJ3aHkgZG9uJ3QgeW91IHVzZSAtLWlnbm9yZS1wYXRoLXJlYWNoYWJpbGl0eSIgYXJlIG5v
dCBuZWdsaWdpYmxlLg0K
--------------a0xfao9LCGG1UYaiu7joXwXa
Content-Type: application/pgp-keys; name="OpenPGP_0xE2F22C5EDF20119D.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE2F22C5EDF20119D.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZPRnKxYJKwYBBAHaRw8BAQdAAKdlNe0o2M0j1n2xyv8Amf+7ct0odnZp4jEA
X4Y3S4TNHWJlbmFyeW9yZyA8YmluYXJ5QGJlbmFyeS5vcmc+wpwEExYKAEQCGwMF
CQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQSAS2y4rtVh2T2tTcXi
8ixe3yARnQUCZPRoPAIZAQAKCRDi8ixe3yARnY3PAQCuFua4uDblRjF011aWK6KI
0mueNX1gZu+SAzO6myGAKAD/aga/N26m1UFPE3yt1MmC6d/3ALQ4tSeuvIbQ0LDF
JgLNHmJlbmFyeW9yZyA8bm9yZXBseUBiZW5hcnkub3JnPsKZBBMWCgBBFiEEgEts
uK7VYdk9rU3F4vIsXt8gEZ0FAmT0Z2gCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsC
BBYCAwECHgcCF4AACgkQ4vIsXt8gEZ1R/AEApobml/Gwt7WzHGk6gfEqXC22VHT+
/DmGPtxHOmqbm+oBAJ5+Soe1Cy7L4q2lLbIdjf8cVltI0tZhKagIphloCQQNzjgE
ZPRnKxIKKwYBBAGXVQEFAQEHQLK2b+AcWndNAuPN/N0XzVTJ2LakT/KbtncIqq9W
Pa9wAwEIB8J+BBgWCgAmFiEEgEtsuK7VYdk9rU3F4vIsXt8gEZ0FAmT0ZysCGwwF
CQWjmoAACgkQ4vIsXt8gEZ1lZgD9FLHYGE2pziHZxNn9sAQm6O6J3AcRGNDVyLwA
O9EeCbABALup8RDA+W+0pTIpG49QEVxumZXEFjPeczDghwuycpIA
=3DoM9+
-----END PGP PUBLIC KEY BLOCK-----

--------------a0xfao9LCGG1UYaiu7joXwXa--

--------------8wUDr0DeFl7oacS73Mgl0pZ9--

--------------Hyx8lZVr0yP1i03inh9EpFea
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSAS2y4rtVh2T2tTcXi8ixe3yARnQUCZwMyfwUDAAAAAAAKCRDi8ixe3yARnbCB
AP9CCPU73fcpTS7Z9WJ67nNVjzLnY2io2o8i9D0QeuGFfAD+KszGCOpMjot7yJ6YHf26VQNYkN2p
17miaKHttBU6AAs=
=Oc5a
-----END PGP SIGNATURE-----

--------------Hyx8lZVr0yP1i03inh9EpFea--
