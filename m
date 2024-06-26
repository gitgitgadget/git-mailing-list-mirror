Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4514F134
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719428783; cv=none; b=Qf9wbsh8fZA9ANMBeS0Nngek6QdoyyQk4nhV1sw8OpUq77ktWCiVANEA2MLyQ/SrUyHLFr8WUCPiq5gXpx/TeG7DAyslimrXPKVIQ+Hms4jZuoBooMRrDHK7B9UHuChLqp1vDJD96qhNv/pHCu4lvUW6FHuogA62Wpek+/1lBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719428783; c=relaxed/simple;
	bh=b7DvMD8O66RQ43oFkxTnd98NJZ50MjvlEYCDLVu7zeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXALkP10tZTAWF8xeRmpFtwaUuGHMn4Ti5iKjzJxI6/G9DfI/GpPthlskyd5nDrP7TFx9Tfcc2qVaMrAW7L41xMieBkESM8CZ0F3KG8TEraPMDbuz5mKdoHTv9ViLvkMWcY6mfnsILo0JiwWEQzGxiNolKjMtCVACVMU39CIi+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3651ee582cfso3840081f8f.2
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 12:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719428773; x=1720033573;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b7DvMD8O66RQ43oFkxTnd98NJZ50MjvlEYCDLVu7zeM=;
        b=UEgji15Q7hgi0FHQPgGHWoOHtITHJDxcyDE7/UCNiOtzPXYgjqoTneDRa+7P2L26HT
         NNlVgFNqTuJDBNclqMOM8FeboFQehpPWhbDQ0eDScbXNSExw0nIOivkDcjEMQpz069/X
         u9dyb6hGwwxWh321bQb+/TvhIdPSFWbT7GRlEO/ly91QplV2BaK74mjUMPxKCVHn6oTM
         qD8IZxlu+4JIVT2Glddyb+LfuapKCeBzN5NbsQBDTA4kDAWAArvVEy8B+pQMBsqjlZdh
         za+rXJXbOreuMh4Mmw9s5DP6GGAKxmiAH9O/sVY5wAhWuvgaUx3zUdpPw+yXA9jc5p3F
         PW9Q==
X-Gm-Message-State: AOJu0YzqepqmlKUktjApndj/Mcvd1cNO/7NCmWMfrMgiDqtJwBpLVnYg
	Y5YMedOFQrdOruplK5h4s4BwDyzVTV80pcFLFyRgZG6xg5DXOyIj
X-Google-Smtp-Source: AGHT+IE5Ld1yOb3gz03j4S8LymrcATA1oMEWBLAen45PUo6Nw2ZG8HwL0MrD3v2lkEDkjzRae7NJGQ==
X-Received: by 2002:a05:6000:a83:b0:360:781c:8241 with SMTP id ffacd0b85a97d-366e94cf1b1mr7015419f8f.40.1719428772813;
        Wed, 26 Jun 2024 12:06:12 -0700 (PDT)
Received: from ?IPV6:2001:4091:a242:8321:34fb:50ff:feac:591b? ([2001:4091:a242:8321:34fb:50ff:feac:591b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b85a2sm16544538f8f.42.2024.06.26.12.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 12:06:12 -0700 (PDT)
Message-ID: <a87a7131-3207-42f2-93c0-e6e9e02a2062@geekplace.eu>
Date: Wed, 26 Jun 2024 21:06:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Phillip Wood <phillip.wood123@gmail.com>
References: <20240626123358.420292-1-flo@geekplace.eu>
 <20240626123358.420292-2-flo@geekplace.eu>
 <9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
 <72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com> <xmqqa5j71snb.fsf@gitster.g>
Content-Language: en-US
From: Florian Schmaus <flo@geekplace.eu>
In-Reply-To: <xmqqa5j71snb.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Dapu1xjaXyF7tFSkgmBYH0EX"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Dapu1xjaXyF7tFSkgmBYH0EX
Content-Type: multipart/mixed; boundary="------------G0AroLgJNf1nK0kTeRYHTXsd";
 protected-headers="v1"
From: Florian Schmaus <flo@geekplace.eu>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a87a7131-3207-42f2-93c0-e6e9e02a2062@geekplace.eu>
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
References: <20240626123358.420292-1-flo@geekplace.eu>
 <20240626123358.420292-2-flo@geekplace.eu>
 <9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
 <72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com> <xmqqa5j71snb.fsf@gitster.g>
In-Reply-To: <xmqqa5j71snb.fsf@gitster.g>

--------------G0AroLgJNf1nK0kTeRYHTXsd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

VGhhbmtzIGZvciBhbGwgeW91ciByZXBsaWVzLiBNdWNoIGFwcHJlY2lhdGVkLg0KDQpPbiAy
Ni8wNi8yMDI0IDIwLjExLCBKdW5pbyBDIEhhbWFubyB3cm90ZToNCj4gUGhpbGxpcCBXb29k
IDxwaGlsbGlwLndvb2QxMjNAZ21haWwuY29tPiB3cml0ZXM6DQo+PiBUbyBleHBhbmQgYW4g
dGhpcyBhIGxpdHRsZSAtIGEgY291cGxlIG9mIHRpbWVzIEkndmUgd2FudGVkIHRvIGNoZWNr
b3V0DQo+PiBhIGJhcmUgcmVwb3NpdG9yeSB0aGF0IGlzIG93bmVkIGJ5IGEgZGlmZmVyZW50
IHVzZXIuIEl0IGlzIGEgcGFpbiB0bw0KPj4gaGF2ZSB0byBhZGQgYSBuZXcgY29uZmlnIHNl
dHRpbmcganVzdCBmb3IgYSBvbmUtb2ZmIGNoZWNrb3V0LiBCZWluZw0KPj4gYWJsZSB0byBh
ZGp1c3QgdGhlIGNvbmZpZyBvbiB0aGUgY29tbWFuZCBsaW5lIHdvdWxkIGJlIHZlcnkgdXNl
ZnVsIGluDQo+PiB0aGF0IGNhc2UuDQo+IA0KPiBUcnVlLiAgQXMgbG9uZyBhcyBpdCBpcyBk
ZWVtZWQgc2FmZSB0byBob25vciB0aGUgb25lLW9mZiAiZ2l0IC1jDQo+IHNhZmUuZGlyZWN0
b3J5PS4uLiIgZnJvbSB0aGUgY29tbWFuZCBsaW5lLCBmb3IgdGhlIHB1cnBvc2Ugb2YgdGhp
cw0KPiAiSSB3aG8gYW0gcnVubmluZyB0aGlzICdnaXQnIHByb2Nlc3MgaGVyZWJ5IGRlY2xh
cmUgdGhhdCBJIHRydXN0DQo+IHRoaXMgYW5kIHRoYXQgcmVwb3NpdG9yeSIsIEkgdGhpbmsg
aXQgd291bGQgYmUgdGhlIGJlc3Qgc29sdXRpb24NCj4gZm9yIHRoZSAiZ2l0IGRhZW1vbiIg
dXNlIGNhc2UuDQoNCkhvdyBkb2VzIG9uZSBwYXNzICItYyBzYWZlLmRpcmVjdG9yeT3igKYi
IHRvIGdpdC1odHRwLWJhY2tlbmQ/DQoNCkkgY3VycmVudGx5IGhhdmUgYW4gQXBhY2hlIGNv
bmZpZyBzbmlwcGV0IGxpa2UNCg0KU2V0RW52IEdJVF9QUk9KRUNUX1JPT1QgL3Zhci93d3cv
ZXhhbXBsZS5vcmcvaHRkb2NzL2dpdA0KU2V0RW52IEdJVF9IVFRQX0VYUE9SVF9BTEwNClNj
cmlwdEFsaWFzIC9naXQvIC91c3IvbGliZXhlYy9naXQtY29yZS9naXQtaHR0cC1iYWNrZW5k
Lw0KDQo8RmlsZXMgImdpdC1odHRwLWJhY2tlbmQiPg0KICAgUmVxdWlyZSBhbGwgZ3JhbnRl
ZA0KICAgQWNjZXB0UGF0aEluZm8gT24NCjwvRmlsZXM+DQoNCnRvIHNlcnZlIGdpdCByZXBv
c2l0b3JpZXMuDQoNCkdyYW50ZWQsIHRoZSBhcGFjaGUgdXNlciBoYXMgYSBob21lIGRpcmVj
dG9yeSwgc28gSSBhbSBwcm9iYWJseSBhYmxlIHRvIA0Kc2V0IHNhdmUuZGlyZWN0b3J5IHZp
YSB+Ly5naXRjb25maWcuDQoNCkhvd2V2ZXIsIHRoZSBwb2ludCBoZXJlIGlzIHRoYXQgZ2l0
IGlzIG9mdGVuIGludm9rZWQgaW5kaXJlY3RseSwgd2l0aCBubyANCmNvbnRyb2wgb3ZlciB0
aGUgY29tbWFuZCBsaW5lIGFyZ3VtZW50cyB0aGF0IGFyZSBwYXNzZWQgdG8gaXQuIE9uIHRo
ZSANCm90aGVyIGhhbmQsIG9uZSBoYXMgdXN1YWxseSBjb250cm9sIG92ZXIgdGhlIGVudmly
b25tZW50IHZhcmlhYmxlcy4NCg0KSSBhZ3JlZSB0aGF0ICItYyBzYWZlLmRpcmVjdG9yeT3i
gKYiIGlzIHByZWZlcmFibGUgdG8gDQpHSVRfSUdOT1JFX0lOU0VDVVJFX09XTkVSLiBIb3dl
dmVyLCBzb21ldGltZXMgdXNpbmcgIi1jIA0Kc2FmZS5kaXJlY3Rvcnk94oCmIiBpcyBjdW1i
ZXJzb21lIGFuZCBtYXliZSBldmVuIGltcG9zc2libGUuDQoNCk9uZSBhbHRlcm5hdGl2ZSB0
byBHSVRfSUdOT1JFX0lOU0VDVVJFX09XTkVSIHdvdWxkIGJlIGEgZ2VuZXJpYyANCkdJVF9F
WFRSQV9BUkdTIGVudmlyb25tZW50IHZhcmlhYmxlLiBTbyBvbmUgY291bGQgc2V0DQoNCkdJ
VF9FWFRSQV9BUkdTPSItYyBzYWZlLmRpcmVjdG9yeT3igKYiDQoNCk5vdCBzYXlpbmcgdGhh
dCBJIGxpa2UgdGhlIGlkZWEsIGp1c3QgcG9pbnRpbmcgb3V0IHRoaXMgb3B0aW9uLg0KDQot
IEZsb3JpYW4NCg==

--------------G0AroLgJNf1nK0kTeRYHTXsd--

--------------Dapu1xjaXyF7tFSkgmBYH0EX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEl3UFnzoh3OFr5PuuIjmn6PWFIFIFAmZ8ZqJfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDk3
NzUwNTlGM0EyMURDRTE2QkU0RkJBRTIyMzlBN0U4RjU4NTIwNTIACgkQIjmn6PWF
IFJf8Af/ZcQx8RamrndBoP3qToYDostH4sBY3FtRzOhsMhAytURcDca4a3WUqTqn
4lnp2bpiveeJYMKLlnPgr2/cIimLBf8OH3wm3JNMGQ0ggFx5x3KR/CXMDmo/cCPs
thyShBGAn3umFk4EHde55vqZ+EEe0N05VnjvjtcJ3URrZ+haa1R8xwDw7/5oJ3OM
4FxPtRStV8iYQnaLOfyDzvmzSwoiGkMIoJsK57Vt/4jA59ULXVLOpY4/0cXJ4tYg
PtjtZ78xLOsb9OhlTAeWd8lrBTvgl/bL36q7/TKA6vfpud1iusHhu2HrskA34RgY
TFSqvx2kSqmfW4vMN6zQWGD3gIh8HA==
=rEUW
-----END PGP SIGNATURE-----

--------------Dapu1xjaXyF7tFSkgmBYH0EX--
