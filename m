Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4401E5A0EB
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339598; cv=none; b=GlTjFu9UZp2bSEepNqfWWCEGabl8Mileviu7h0Qxv/EWlnSYI+IVx5QddRp4gj3GGInS/b//bwCFlPmhYFxOiP9UW0y26I60wV8PqwMe/CdpGYcuno6jNgVzxu+b6v/RlSwz60OmjZRm3lCJYK4Wbt6GwAc2CufTjeGsxtq44ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339598; c=relaxed/simple;
	bh=7TSddjABWyK3B9HMLRpRzUgilDuWlPe4XWs3savL04E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=tyE9Z6bm2PNpld99ItKkSpHpbbcuhyX1SO16kOtAsfs+vjIn2Hunw7Q7GCZOH9iNPeWXCr0eJwe/XE4Bblj9vZv3wQQZ20SRdc+/GpupoyJ4USLm8CBYIUp4vHjh7IMHJWh4AQ9zOaJ1wcpeNxNRwMmJOLYcdGaNEyKJa8YykNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kH4SVgtW; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH4SVgtW"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6860ff3951aso5350726d6.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 12:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707339596; x=1707944396; darn=vger.kernel.org;
        h=to:autocrypt:content-language:subject:from:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7TSddjABWyK3B9HMLRpRzUgilDuWlPe4XWs3savL04E=;
        b=kH4SVgtWWHo9oROJkn+9ysn+z4a/ik8ATuYbNd2DDYPmbKYwGYqcrek+8sYFUnf9S+
         N5jdUX7j9uDt/kwCIJLAlSfUh9YhkX6K5BSncioeGrdvhBUA8VddVpHtcDd6YldLfySw
         JSWy73GrdfYMyJmhOkgTtCTqLOJPufJl7uz6b1WwQ+i+ImH/i+88LTtbyF+fjcDDd0eG
         FwTNvwisDZ3pcG/ZOGEoCWZZOoI3MkooN8liatUAieavfN0eNVAZLU5UhkMapTl2V7mi
         sofOw3JvfFqFZv8X8TGYzH6Z2bmRfarlMuquubeKLg7H2Y24Z6KDLx7pNlPAqAIh5VvQ
         PTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707339596; x=1707944396;
        h=to:autocrypt:content-language:subject:from:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TSddjABWyK3B9HMLRpRzUgilDuWlPe4XWs3savL04E=;
        b=gJCSzP8JJXAtrw+TYa6MvNsEj0ks4GtEb1x9ZEtqWJ1uo49MhxQFCIvVQCKTgJjeW+
         gAtqYu9mpjbnQSGMefxuJKBcF1MihnKWPpCBCQ5/DCna2kQWyS6vsVmUhNr9kBBoCTv8
         frcxFExYxpVoOTYhHmOhej/fMFIzE6phd2YtzH+n3JT54WyqulHcBInqw8dRIorUvPW1
         nJob8H/Tj+jMptdXA/8RRi9sh2dgq1dgzLLVBsi9Wp34mOxoZL1hQP+EZpwXWoutI1Ht
         3R7vetvOGdmvBKdIG6RIyhRh2BkYov+nH8LKx13LvFrhaty6k6tnXbzEUPnSxVo4CkY7
         rzZg==
X-Gm-Message-State: AOJu0Yxz/djGfDxkwfBsQhV3C9b6VkmDyKlWj8/FO9Ize6mQjq/ZbFx/
	wnIIx0mdpho2RJYUerYi52lkAZt3xzpO6aBiPcu5ndHPmd6y3Uqasdm1SLma
X-Google-Smtp-Source: AGHT+IGDYPIj8tZPw/UxY4AtZOqpS0xof3RRFGWZdKSIBHR2k3nHaMRBf1BT3rsqvOtySDl4bhX/ag==
X-Received: by 2002:a05:6214:21ca:b0:68c:9109:b5f1 with SMTP id d10-20020a05621421ca00b0068c9109b5f1mr9313034qvh.26.1707339595654;
        Wed, 07 Feb 2024 12:59:55 -0800 (PST)
Received: from [10.197.96.0] ([152.3.43.40])
        by smtp.gmail.com with ESMTPSA id lz10-20020a0562145c4a00b0068caacd861fsm930919qvb.25.2024.02.07.12.59.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 12:59:55 -0800 (PST)
Message-ID: <3470180e-2ef7-4393-9d32-92cd419727f5@gmail.com>
Date: Wed, 7 Feb 2024 15:59:54 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ricardo C <rpc01234@gmail.com>
Subject: Interest in options for stash -k and -u by default
Content-Language: en-US
Autocrypt: addr=rpc01234@gmail.com; keydata=
 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
 jjbjCH/5+g==
To: git@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------aCOou561obxEW0d1gILVE3kd"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------aCOou561obxEW0d1gILVE3kd
Content-Type: multipart/mixed; boundary="------------RlEOMWGBmB3lMMLxdMNajdPB";
 protected-headers="v1"
From: Ricardo C <rpc01234@gmail.com>
To: git@vger.kernel.org
Message-ID: <3470180e-2ef7-4393-9d32-92cd419727f5@gmail.com>
Subject: Interest in options for stash -k and -u by default

--------------RlEOMWGBmB3lMMLxdMNajdPB
Content-Type: multipart/mixed; boundary="------------0msEXuMlEdtg0bcI03P8fb7Y"

--------------0msEXuMlEdtg0bcI03P8fb7Y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCg0KQWZ0ZXIgc29tZSBkaXNjdXNzaW9uIG9uIE1hc3RvZG9uWzFdLCBJIGRl
Y2lkZWQgdG8gdHJ5IG15IGhhbmQgYXQgY3JlYXRpbmcgDQpjb25maWd1cmF0aW9uIG9wdGlv
bnMgdGhhdCBlbmFibGUgLS1rZWVwLWluZGV4IGFuZCAtLWluY2x1ZGUtdW50cmFja2VkIGlu
IA0KZ2l0LXN0YXNoIGJ5IGRlZmF1bHQuIEkgaGF2ZSBtYWRlIGEgcHJlbGltaW5hcnkgc3Vj
aCBwYXRjaFsyXSwgYW5kIHNvbWUgDQphZGRpdGlvbmFsIGRpc2N1c3Npb25bM10gaGFzIGVu
Y291cmFnZWQgbWUgdG8gdHJ5IHN1Ym1pdHRpbmcgaXQgdXBzdHJlYW0uDQoNCkkgYW0gd29u
ZGVyaW5nIHdoZXRoZXIgdGhpcyBjaGFuZ2UgaXMgc29tZXRoaW5nIHRoYXQgd291bGQgZXZl
biBiZSBjb25zaWRlcmVkIA0KZm9yIGJlaW5nIGFjY2VwdGVkLiBUaGUgcGF0Y2ggc3RpbGwg
bmVlZHMgc29tZSB3b3JrIChtYWlubHkgZG9jdW1lbnRhdGlvbiBhbmQgDQp0ZXN0cyksIHdo
aWNoIEknZCBiZSBoYXBweSB0byBkbyBpZiBJIGtuZXcgdGhlcmUgd2FzIHVwc3RyZWFtIGlu
dGVyZXN0IGluIHRoaXMgDQp3b3JrLg0KDQpJIHdvdWxkIGFsc28gYXBwcmVjaWF0ZSBmZWVk
YmFjayBvbiB0aGUgcGF0Y2guIEN1cnJlbnRseSwgaXQgY3JlYXRlcyB0d28gDQpzZXBhcmF0
ZSBvcHRpb25zOiBzdGFzaC5rZWVwaW5kZXggYW5kIHN0YXNoLmluY2x1ZGV1bnRyYWNrZWQu
IFRoZXNlIG9wdGlvbnMgDQpzZXQgdGhlIGRlZmF1bHQgdmFsdWUgb2YgLS1rZWVwLWluZGV4
IGFuZCAtLWluY2x1ZGUtdW50cmFja2VkIGlmIG5vdCBvdGhlcndpc2UgDQpzcGVjaWZpZWQg
KGUuZy4sIC0tbm8ta2VlcC1pbmRleCkgYW5kIGRvIG5vdCBjb25mbGljdCB3aXRoIG90aGVy
IG9wdGlvbnMgDQooZS5nLiwgLS1wYXRjaCkuIE1vcmUgZGV0YWlscyBhcmUgb2YgY291cnNl
IGF2YWlsYWJsZSBpbiB0aGUgc291cmNlIGNvZGVbMl0uDQoNCg0KVGhhbmsgeW91LA0KDQpS
aWNhcmRvICJNaXRoaWNTcGlyaXQiIFByYWRvIEN1bmhhDQoNCg0KWzFdIGh0dHBzOi8vYnNk
Lm5ldHdvcmsvQGVkMWNvbmYvMTExNzgzNTc0ODM5NzQ5Nzk4DQoNClsyXSANCmh0dHBzOi8v
Z2l0aHViLmNvbS9NaXRoaWNTcGlyaXQvZ2l0L2NvbW1pdC9mMzNjOGQ1ZDI2ZDg0MzhkZGIx
MjM3ODFiZDVkYjNiZmY4NjE4MjQ3LnBhdGNoDQoNClszXSBodHRwczovL3NvY2lhbC5qdm5z
LmNhL0BiMHJrLzExMTg4MDIzMDUwNjQ0ODEyMg0KDQo=
--------------0msEXuMlEdtg0bcI03P8fb7Y
Content-Type: application/pgp-keys; name="OpenPGP_0xFEA8F724F2800E40.asc"
Content-Disposition: attachment; filename="OpenPGP_0xFEA8F724F2800E40.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
eU3eXSKNEjMWFB/VjjbjCH/5+g=3D=3D
=3DeS3F
-----END PGP PUBLIC KEY BLOCK-----

--------------0msEXuMlEdtg0bcI03P8fb7Y--

--------------RlEOMWGBmB3lMMLxdMNajdPB--

--------------aCOou561obxEW0d1gILVE3kd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEABuPMGh96TZ1R8Gz/qj3JPKADkAFAmXD70oFAwAAAAAACgkQ/qj3JPKADkCU
pA//TqLZIop0PCgyKHjwbzW1fsICLhYwxB8niYwC2h0qv6NWIRl6nqSVF4SBUvEFrDX7nly1YwNG
QPVZ7esIFXHMqV1fUzxu+AOj2b3Z9kQ5s++1jyw5VRfLZPLGpHkcERYXL40zGqr7h9zBmOntol0m
ebIoliN8v9JtLRRW2TeF5xoY16R0DJzC3LdrJLFuHOlG+vxa8Pof+dQ97k98JkGvL0mjyE9xc1LR
aooZXcs7666X/PyKDR8KEP0PXXQhuxcE7zG/82U36k9QBIeQpRZBaYTYYcfobwA9C7uI3DJ4i+sQ
EdEP+IogbLP0BFRqaztT+EBFUct8EBxMEjrpGbNH/hi6nBEJZtERrp9MXWbiXbrr4Zzkalt+SavU
kWyKLXyBkeWTDJy1IKztNF4YC8S3uozaqBvmiFeiNx16uZNa35/ER9uaJef32HcEz2svZ3Eu8ccm
d4X0npU7yMW8qP6iGaERyshh4zeh6vwuyvUT/SuKT13NGLN1W8RQDIVVovs+jvG0DBJYwKCvC8Eh
E/CAV1UH+um6jo2kRZk6Pl8b95rjAIrLJ/bN3tKvNauxrG0reiRUxlBgaqUoJZI0TCb7deuhsXoD
JuEQac1p4tTXf0lvV9Liw3GeujThWdsarR0ifNajnIn8bcA4aqDC0W0RxA9+DB4kL+MEbFti+ZvC
CRs=
=6lzn
-----END PGP SIGNATURE-----

--------------aCOou561obxEW0d1gILVE3kd--
