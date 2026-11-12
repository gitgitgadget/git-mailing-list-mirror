Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.175.194.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490809;
	b=GXyeGAracHlufLQ5eTdvjtrOxADgiFbpx+9PyJeZKIRdIb31VGgT3kWL1P8xUR0G4V4G
	 KkshsTGpse6uyIi4s9jfFEuM555reiXBY2N7xE8IwJkQl8GcSU4k6Ls6xNuvy7y7HxYGB
	 vVZ/531Xew4rXvY8BQGqhA3/MAk/cCpobBi+5WzDDf2C3EkkxEPQ0xe6erlaLEjThkztx
	 Vd9yD2kqxI0LJVqBdlC/MC45moIO+2fXHIKeVgUqwt2z2QIhsfSisj26c5Qn33h3mP4iG
	 KS11pV0/KygLyy+Xz45tpj3Y6b4R6BpU4ZYqyvEc4QKFQMIQo8jEHiEdbLIeN3CeJfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490809;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Signed:X-URL-LookUp-ScanningError:X-ThreatScanner-Verdict:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:DKIM-Signature:
	 X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ThreatScanner-Verdict:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:From:To:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:x-tm-snts-smtp:
	 Content-Language:MIME-Version:Content-Type:X-SM-outgoing:
	 X-SM-Actions;
	bh=ZSaToRogWwRXwdMNNMVlMwUuqcQslZhlT0Qph3WhZGE=;
	b=xsX3AFUB+tkLkTzLhfAublBTElX7RTh88ei/ReT1tz50FdIOr9V3UZjCfgqf7CkI3BDk
	 ijQXLTnaBRqTYJGKKK4PVoOAxpAyrERvhgqgDGKvjVDEJevx/hnfooRKX5dcCp6+5snvO
	 E6PVRV/bi11eP56ftpn+P2qbvLdPf0vAGwFHUx7LMd8NKQagZ6HZ62E3/J4QathQs8+Jh
	 rsb/+458nVSbwtq7MY8TUXr/Ihe/6YxmJwiz3/mGJ5TkJbwMIUWCspclRJ7M7+UqgFYHl
	 l7BqeJee7V2M81RSsoLU0xGY0oCEPyUWV/tXRw3vYrHfgoeKVpT2NkWic5q/lvzwQYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ukr.de;
	spf=pass smtp.mailfrom=ukr.de;
	dkim=pass header.d=ukr.de header.i=@ukr.de header.a=rsa-sha256 header.s=ukr header.b=K9hYHudd;
	dkim=fail reason="signature verification failed" header.d=ukr.de header.i=@ukr.de header.a=rsa-sha256 header.s=ukr header.b=GvIpRB7D;
	arc=none smtp.remote-ip=193.175.194.182
Received: from mail02.ukr.de (mail02.ukr.de [193.175.194.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081FB606A8BC
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 13:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 081FB606A8BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ukr.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ukr.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ukr.de header.i=@ukr.de header.a=rsa-sha256 header.s=ukr header.b=K9hYHudd;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ukr.de header.i=@ukr.de header.a=rsa-sha256 header.s=ukr header.b=GvIpRB7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ukr.de; i=@ukr.de; q=dns/txt; s=ukr; t=1794490808;
  x=1826026808;
  h=from:to:subject:date:message-id:mime-version;
  bh=ZSaToRogWwRXwdMNNMVlMwUuqcQslZhlT0Qph3WhZGE=;
  b=K9hYHuddTYWWkD7QvKsH2BLPIUZnoDNsnAJ5A89d5nBuviX1utGXlgTN
   54dGQa8ZN1xam0N0sN6zEoy8g99b32dt6AHqKibHT8pNoy+C2yqEsRwOR
   Lk6miKDBxiKrNWuap6fRRmhfn6RpZG4SYXB34/QiHPeTEe84qT4gLOBZ0
   fSxYlcsRqyYrroAJnAB3L+P6tKUAHpAXzlEB+D8i6a+taypfszKg5D0t3
   YVRkaZ2jNwM1lE1Ie0/YqTT1Dm1rGjPzkmejHq8o00mihEka/x9IPc8Kq
   a5BnRcdo1m+1/81/242YUyK63XQrBXJKzhmtf9DWknOnCcladCuN98n+U
   w==;
X-CSE-ConnectionGUID: wbDzMffSQPqrTd3OA/coFA==
X-CSE-MsgGUID: sPllnubKQwqXxqTqqZeS4g==
X-Signed: true
X-URL-LookUp-ScanningError: 1
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="15129817"
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="p7s'346?scan'346,208,346";a="15129817"
Received: from unknown (HELO dmz-infsep01.ukr.dmz) ([192.168.236.68])
  by dmz-infcsg02.ukr.dmz with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Nov 2026 14:40:00 +0100
Received: from dmz-infsep01 (localhost [127.0.0.1])
	by dmz-infsep01.ukr.dmz (Postfix) with SMTP id 4jQM2S00YnzKYsC
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:39:59 +0100 (CET)
Received: from dmz-infcsg01.ukr.dmz (dmz-infcsg01.ukr.dmz [192.168.236.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by dmz-infsep01.ukr.dmz (Postfix) with ESMTPS
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:39:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ukr.de; i=@ukr.de; q=dns/txt; s=ukr; t=1794490799;
  x=1826026799;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=sL8u1TjoAlexg4b/yqKxjthq0pFo+R6e7d1rD7mY/8A=;
  b=GvIpRB7DTY9KfUG3pKO3VAFmHbeQY+Y8VYRxF+01yYIG1+eUtxEhKxrH
   nyjNsEA2Zu70hEmkFGebByYc1vyJe230m2bmslx3o3YTqz1otOCqmojfi
   EkVc+uuGNpVNi59HEHAH3w0LkIJ+8MAMTe8XXrJvVm0TFC+Rm3Cf4FjSd
   U+T2grPF7eun/jEae5CoTj9G4J6SxQ2c3ks6UzbICuHs9slccrUYBqT1b
   bzm+eOPkIU6SaxFBJJe2PBPY79CFnI4isdn/klCEWMwCF0Sy8KdAPD9Y0
   cIsJaCnAHDnpxCfQiFqgsOHrMLeVVgK3qz3556nH2LK80bVMKB/UwTTyH
   g==;
X-CSE-ConnectionGUID: DelDp2mdQdW2V8viZpADiQ==
X-CSE-MsgGUID: WidhMqFYS+GqaYrKrLgYoA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="15168244"
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="15168244"
Received: from unknown (HELO ukr.de) ([172.24.2.107])
  by dmz-infcsg01.ukr.dmz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 14:39:59 +0100
Received: from ukr-excmb07.ukr.local (172.24.2.107) by ukr-excmb07.ukr.local
 (172.24.2.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 14:39:58 +0100
Received: from ukr-excmb07.ukr.local ([fe80::4dee:3e0b:b33f:60ac]) by
 ukr-excmb07.ukr.local ([fe80::4dee:3e0b:b33f:60ac%8]) with mapi id
 15.02.2562.056; Thu, 12 Nov 2026 14:39:58 +0100
From: "Windl, Ulrich" <u.windl@ukr.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git context diff does not recognize shell function name
Thread-Topic: git context diff does not recognize shell function name
Thread-Index: Ad1yqitR2y7gFB7SQGGj6rm4n6fGRA==
Date: Thu, 12 Nov 2026 13:39:58 +0000
Message-ID: <340dc2eef42f4f6690c58765a07621e1@ukr.de>
Accept-Language: de-DE, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-snts-smtp: 8A116D74BE5D7B1A5F97D6A93681200FC43127DDB45858691E46BFD767E246BC2000:8
Content-Language: de-DE
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg="sha-256"; boundary="----5D431524C15AF18791EE006EAB82E522"
X-SM-outgoing: yes
X-SM-Actions: SMIME_SIGNATURE_ADDED,DKIM_SIGNATURE_VERIFIED

This is an S/MIME signed message

------5D431524C15AF18791EE006EAB82E522
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-version: 1.0

SGkhDQoNCkluIGdpdCAyLjUxLjAgSSBmb3VuZCBhIG1pbm9yIGlzc3VlOg0KImdpdCBkaWZmIiBk
aWQgbm90IHNob3cgdGhlIGNvcnJlc3BvbmRpbmcgc2hlbGwgZnVuY3Rpb24gbmFtZS4gQWRtaXR0
ZWRseSBJIHVzZWQgYSBzb21ld2hhdCB1bmNvbW1vbiBsaW5lLWJyZWFraW5nOg0KDQpUaGUgY29u
dGV4dCBpbiBxdWVzdGlvbiBsb29rcyBsaWtlIHRoaXM6DQotLS0NCi4uLg0KcnVuX3F1ZXJ5KCkN
CnsNCiAgICBsb2NhbCBwX2xfMD0iJDEiIExPR19CQVNFPSIkMiIgU1VGRklYPSIkMyIgVVJMX0JB
U0U9IiQ0IiBVUkw9IiQ1IiBcDQpfQ09VTlQ9IiR7NjotJENPVU5UfSIgUkVTUE9OU0VfQ0hFQ0tF
Uj0iJDciDQogICAgbG9jYWwgbWU9IiR7RlVOQ05BTUVbMF19IiBtDQouLi4NCi0tLQ0KDQpUaGUg
Y29udGV4dCBkaWZmIGxvb2tlZCBsaWtlIHRoaXM6DQotLS0NCi4uLg0KQEAgLTE5Myw2ICsxODgs
MzYgQEAgZ2V0X3BhcmFtcygpDQouLi4gDQpydW5fcXVlcnkoKQ0KIHsNCkBAIC0yMDEsMTAgKzIy
Niw5IEBAIF9DT1VOVD0iJHs2Oi0kQ09VTlR9IiBSRVNQT05TRV9DSEVDS0VSPSIkNyINCiAgICAg
bG9jYWwgbWU9IiR7RlVOQ05BTUVbMF19IiBtDQouLi4NCi0tLQ0KKCIuLi4iIGlzIGRlbGV0ZWQg
bGluZXMpDQpTbyB0aGlzIG1heSBiZSBhIGNvbWJpbmF0aW9uIG9mIHVuZm9ydHVuYXRlIGNvbnRl
eHQgc2VxdWVuY2luZyBhbmQgdGhlIGZpcnN0IGxpbmUgb2YgdGhlIG5ldyBjb250ZXh0IGJlaW5n
IHVudXN1YWwuDQpUaGUgc2Vjb25kIGNodW5rIHdvdWxkIHN0aWxsIGJlIHRoZSBzYW1lIGNvbnRl
eHQsIG5hbWVseSAicnVuX3F1ZXJ5KCkiLg0KDQpLaW5kIHJlZ2FyZHMsDQpVbHJpY2ggV2luZGwN
Cg0K

------5D431524C15AF18791EE006EAB82E522
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
2jto8H/AFaYc1uj4kA==

------5D431524C15AF18791EE006EAB82E522--

