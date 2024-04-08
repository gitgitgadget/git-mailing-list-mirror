Received: from mail.astos.de (mail.astos.de [217.110.68.46])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99552140E2F
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.110.68.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589929; cv=none; b=E4VUkYOZIQpKa+sMbGmS8z7UBQ3pOgpQ1ERJkEslGFr5YLIJElMW9tuY2BVjBpwoaRpc+V53TuHosM57URTzHKKcLSWLtuWs/y6oV+m15b3TvAqgn0UzBkejs0bHGyuZtE7lCPIBdmdFcSC8T6A4FPGCy+twx6qCAaM1cgcpBO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589929; c=relaxed/simple;
	bh=8BIIhvkhy0srkTXVVCfEEBjqAvf8Fi9gVxr9aMbRK78=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=rKu3KY02a4JbK31AfDrtpWZQ0wYXCdCJuGS1E3eYqhx7Ugs4jz8oLDjWtQM3c600Hc6fooXALv3JN66Cyj7bF35mfjPIGZfkGRouWGla/18oyjotRkSHzK6jU05qR53DUfmtaFor1OXE2fyR5JlxvXaAC6K489yep5oTpb/rXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astos.de; spf=pass smtp.mailfrom=astos.de; dkim=pass (2048-bit key) header.d=astos.de header.i=@astos.de header.b=mGaF06wn; arc=none smtp.client-ip=217.110.68.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astos.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astos.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astos.de header.i=@astos.de header.b="mGaF06wn"
Message-ID: <d8415e36-bdd6-4e74-8240-eb71b669f178@astos.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=astos.de;
	s=astos-dkim-2020; t=1712589459;
	bh=8BIIhvkhy0srkTXVVCfEEBjqAvf8Fi9gVxr9aMbRK78=;
	h=Date:To:From:Subject;
	b=mGaF06wnDlwwyjqwIETpAsh+AcHbj4DlJipfGwhrFhkcXn8TA5ISDOpLqpfOLExEo
	 7ROiCbzRVd4s0bCsp0NpaUYTD/og2kT9Hp9WFiF1IycGnwBiPWJ9VV/0jqN4CHVin9
	 9pNTjUUt6kw0umpFcfksFPkU08E7mpWcQMBz8kSIhly31KSh7e3SDcsLqD4XnkfVX7
	 zdRiScVA9SCpBVNHGvuvQyXMXN/E9EwPCSiRv2xdVybMt+MsbQ2oMhSS6Wfd1tsppc
	 KhQvUU5yH1R1FEjgweMH2nbYWOdwMwm6M80bMO7AZjumYvq8BGcb9x8Ol2MD6o3o56
	 9Cy7vj0t2MIyg==
Date: Mon, 8 Apr 2024 17:18:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Content-Language: de-DE, en-US
From: Marc Becker <marc.becker@astos.de>
Subject: [BUG] fast-import crash on refs to in-flight commit SHA1
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gqrgzvCOQQownUqC3npXeCVJ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gqrgzvCOQQownUqC3npXeCVJ
Content-Type: multipart/mixed; boundary="------------r20utrleWA0BfLKahQ0TQhL9";
 protected-headers="v1"
From: Marc Becker <marc.becker@astos.de>
To: git@vger.kernel.org
Message-ID: <d8415e36-bdd6-4e74-8240-eb71b669f178@astos.de>
Subject: [BUG] fast-import crash on refs to in-flight commit SHA1

--------------r20utrleWA0BfLKahQ0TQhL9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

VXNpbmcgYGZyb21gIHdpdGggKG5vdC15ZXQtcGVyc2lzdGVudCkgY29tbWl0IFNIQTEgY3Jh
c2hlcyBmYXN0LWltcG9ydC4NCg0KV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhh
cHBlbmVkPyAoU3RlcHMgdG8gcmVwcm9kdWNlIHlvdXIgaXNzdWUpDQogIC0gdXNlIGdpdC1m
YXN0LWltcG9ydCBvbiBhIG5ldyByZXBvc2l0b3J5DQogIC0gY3JlYXRlIGFuIGFyYml0cmFy
eSAobWFya2VkKSBpbml0aWFsIGNvbW1pdA0KICAtIHJlZmVyZW5jZSB0aGlzIGNvbW1pdCBi
eSBtYXJrIHZpYSBgZnJvbWAgaW4gYGNvbW1pdGAgb3IgYHJlc2V0YA0KICAtIHJlZmVyZW5j
ZSBzYW1lIGNvbW1pdCBieSBTSEExIChvdXRwdXQgb2YgYGdldC1tYXJrYCkNCg0KV2hhdCBk
aWQgeW91IGV4cGVjdCB0byBoYXBwZW4/IChFeHBlY3RlZCBiZWhhdmlvcikNCiAgLSBpbi1m
bGlnaHQgY29tbWl0IFNIQTEgaXMgdXNhYmxlIGluIGBmcm9tYCAoc2VlIGRvYyBmb3IgPGNv
bW1pdC1pc2g+KQ0KDQpXaGF0IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1YWwgYmVoYXZpb3Ip
DQogIC0gZmFzdC1pbXBvcnQgY3Jhc2hlcyB3aGVuIHVzaW5nIFNIQTEgZm9ybWF0LCBjbGFp
bXMgaW52YWxpZCBjb21taXQgSUQNCg0KV2hhdCdzIGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQg
eW91IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5IGhhcHBlbmVkPw0KICAtIGluLWZsaWdo
dCBjb21taXQgU0hBMSBpcyB1c2FibGUgaW1tZWRpYXRlbHkgKG5vIG5lZWQgZm9yIG1pdGln
YXRpb24pDQoNCkFueXRoaW5nIGVsc2UgeW91IHdhbnQgdG8gYWRkOg0KICAtIHJlZmVyZW5j
aW5nIGFuIGluLWZsaWdodCBjb21taXQgdmlhIFNIQTEgaW4gYGxzYCB3b3JrcyAoc2VlIGJl
bG93KQ0KICAtIHJlcnVubmluZyBmYXN0LWltcG9ydCBzdWNjZWVkcyAoY29tbWl0IGFscmVh
ZHkgaW4gaW5pdGlhbCBkYXRhKQ0KICAtIHVzaW5nIGluLWZsaWdodCBjb21taXQgU0hBMSBB
RlRFUiBpc3N1aW5nIGBjaGVja3BvaW50YCBzdWNjZWVkcw0KDQouLi4NCmdpdCBpbml0DQpn
aXQgZmFzdC1pbXBvcnQgPDxFT0YNCiMgaW5wdXQgdG8gdHJpZ2dlciBHaXQgZmFzdC1pbXBv
cnQgYnVnDQpjb21taXQgcmVmcy9oZWFkcy9tYWluDQptYXJrIDoxMjM0DQpjb21taXR0ZXIg
QnVnIDxidWdzQGdpdC1zY20uY29tPiAxNzEyNTYzMjAwICswMDAwDQpkYXRhIDE0DQpjb21t
aXQgbWVzc2FnZQ0KTSA2NDQgaW5saW5lIHRlc3QgZmlsZQ0KZGF0YSAxNA0KZHVtbXkgY29u
dGVudA0KDQpnZXQtbWFyayA6MTIzNA0KIyBjcmVhdGUgbmV3IHJlZiBmcm9tIGV4aXN0aW5n
IG1hcmsNCnJlc2V0IHJlZnMvaGVhZHMvb3RoZXINCmZyb20gOjEyMzQNCiMgcmVmZXJlbmNl
IGZpbGUgaW4gZXhpc3RpbmcgY29tbWl0IChTSEExIGlzIHZhbGlkKQ0KbHMgN2YyODM5ZDI5
ZDQ2YjVhOWZmZjU1NzIxNDNmNTM3MGYxNTJmN2IzMyB0ZXN0IGZpbGUNCiMgY2hlY2twb2lu
dCBuZWVkZWQgdG8gdXNlIGluLWZsaWdodCBjb21taXQgdmlhIFNIQTENCiNjaGVja3BvaW50
DQojIGNyZWF0ZSBuZXcgcmVmIGZyb20gZXhpc3RpbmcgY29tbWl0DQpyZXNldCByZWZzL2hl
YWRzL2ZhaWxlZA0KZnJvbSA3ZjI4MzlkMjlkNDZiNWE5ZmZmNTU3MjE0M2Y1MzcwZjE1MmY3
YjMzDQojIHVzZSBwbGFpbiByZWYgaW4gY29tbWl0DQpjb21taXQgcmVmcy9oZWFkcy93b3Jr
cw0KY29tbWl0dGVyIEJ1ZyA8YnVnc0BnaXQtc2NtLmNvbT4gMTcxMjU2MzMwMCArMDAwMA0K
ZGF0YSAxOA0KbmV3IGNvbW1pdCBtZXNzYWdlDQpmcm9tIDdmMjgzOWQyOWQ0NmI1YTlmZmY1
NTcyMTQzZjUzNzBmMTUyZjdiMzMNCiMgZmluaXNoIGltcG9ydA0KZG9uZQ0KRU9GDQoNCg0K
W1N5c3RlbSBJbmZvXQ0KZ2l0IHZlcnNpb246DQpnaXQgdmVyc2lvbiAyLjM5LjINCmNwdTog
eDg2XzY0DQpubyBjb21taXQgYXNzb2NpYXRlZCB3aXRoIHRoaXMgYnVpbGQNCnNpemVvZi1s
b25nOiA4DQpzaXplb2Ytc2l6ZV90OiA4DQpzaGVsbC1wYXRoOiAvYmluL3NoDQp1bmFtZTog
TGludXggNC40LjAtMTkwNDEtTWljcm9zb2Z0ICMzOTk2LU1pY3Jvc29mdCBUaHUgSmFuIDE4
IDE2OjM2OjAwIA0KUFNUIDIwMjQgeDg2XzY0DQpjb21waWxlciBpbmZvOiBnbnVjOiAxMi4y
DQpsaWJjIGluZm86IGdsaWJjOiAyLjM2DQokU0hFTEwgKHR5cGljYWxseSwgaW50ZXJhY3Rp
dmUgc2hlbGwpOiAvYmluL2Jhc2gNCg0K

--------------r20utrleWA0BfLKahQ0TQhL9--

--------------gqrgzvCOQQownUqC3npXeCVJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQmrT0REuiUGVWZb1iEnjq1zqJcyQUCZhQKrAUDAAAAAAAKCRCEnjq1zqJcyTxZ
AP4m2N55+1OW4JX03U6iu979rRukw81lK3fGZJKEMkZe5gD9EhEkxVo/21S8ans8QNNOFgGOzJHY
tZTnUlSDnWdoyQw=
=Sugl
-----END PGP SIGNATURE-----

--------------gqrgzvCOQQownUqC3npXeCVJ--
