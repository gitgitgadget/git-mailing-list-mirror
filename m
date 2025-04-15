Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860E6433A8
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744699388; cv=none; b=uIRZFyfhwA97Y6RmNZ1o1p/xpxyVVCExhusx1srB06ev6lHdFgeb7pk5P+DIhhgf2ZkX2/AvdqdCWX9N2/E9zGfloo8gEwy2iX3BRpr/8tPG8hy5PThTSWE+Wl5bEgAL6xcNL88lEq7ySJcw1Oz+mnPfGeAQbria/IEcU9jeySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744699388; c=relaxed/simple;
	bh=shwZWvBuc8Bps9GYD8e2eA3AFlT3vD9GUn+ciZI2fgk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6k19ZI5X5CtVdHk68kJ3HTItgMyrp3f2DFL+AZPEZoXhetNf1RAQIgUosEWyZWsD16lipWxnpFZxOkonry/pNMKWgPRnTKnFqRc9MIrZFS95XIqRXBre2LmH/5KY5+g1SgKdH8e08KEVvcF4SYjCt8W44QWoYHLg94emsAX7Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMK1kEHd; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMK1kEHd"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86b9ea43955so1981650241.2
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 23:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744699384; x=1745304184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W8g4XACgRMfPrybfLHL9WgS1zvhTR29iSMXhoOb9gfE=;
        b=GMK1kEHdttKrRjGs6l9au721BqBAxxoL2npbUQIgYs7H3Mykl1+2HN5Jx+cFTolXfR
         zMYUsv/OOKMmSPFruhMPdxDwRjpAI+3zyYUtOwSHqG05Z6TYtLrfOrY3exGVU1qqwscE
         9ME5duepHUVBW5lv2IXxP0m5iEkcXmsXqmDaLPfwD30zPz8PZoN/6W2eFmixZC0VTOjE
         bAeB3GQYPYI9hPDv/Ep+Bj6BA5q1ABSNCJYcj20m38y1CeL3CykyZUiJjxDJTdQEYDCQ
         TQuhkYMSWEVWBYR0qGuga2Q08Zceu6ofI/Vzl33XZZvHlK29/aCPNR8RqM6hSXuC3kP8
         Yl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744699384; x=1745304184;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8g4XACgRMfPrybfLHL9WgS1zvhTR29iSMXhoOb9gfE=;
        b=RvSSjjkZWDZEXq1sokM+NqSi1pQ0h+7zdIK6tdXVyBw8qpsLoex0HEKkSZWzliwZ9X
         C2tvuF9nrLZsvxXmX+4Ssa8ohi3O1IH5J0QM5z26hpIf91LNwri/H86t4w108ZwQlTDL
         QROoIfM9IFQiEeBMgO8gx3iLMDYrfCXoqOhfl+7PuqjFo0j5ShSvVja7cTL1DFMV4nkp
         sVeLPIOAXbrNrNT3fU622G2v5ISdgpnAHcTuRNlUwNcZ/v8LxNjlryG+XEFaLnPestYA
         A6IlVwGYyoP7MliigPyA19A6hePMKUuzng+kMeGxnKa0OeoFxqZfXj1Bu2oJMh4CyHCr
         0IqA==
X-Gm-Message-State: AOJu0YxqK3VOSkcgDX42PwEgc6NYyvsBvGn0/vHQQDkflwj68HGkBSJA
	MKxJr83pWvg7R8ScsvkgjKv9x95Q22NwJLZsdB/UwzFbaos/yMfd75qAjX0+wesk4pPK+7Iihov
	8vWrIavBEhjk63C7lPrp4DHRD3ik=
X-Gm-Gg: ASbGncuspancX/SBSlDdzR8ujGWUP6CPjOJ1sFIAjIUfBAgnUwYO5P6+EmXDL6cEhwJ
	GcIboOJ7SGyK6ZuzbNAcdUFHkh0XjfEKrW6sXCVmYkkpR1VPpGmrQmpazJGjDCiymrHrFZ3rnFX
	xyKqHL6Ogjsx0tBHoaVic4X9kKxYJlt2nLE2MPnffDsEBB4vhdHSnbrbEb
X-Google-Smtp-Source: AGHT+IFHorN7IK7Gx/SdKlgegFNRxDkkyigHfHG0z01s8v6IPE+8oNemWWQavgqaiDGviC3ZUeWYfHZrzhPgEvHAOmo=
X-Received: by 2002:a05:6102:4b11:b0:4c2:4b08:12e3 with SMTP id
 ada2fe7eead31-4c9e4f1458dmr10076960137.14.1744699384288; Mon, 14 Apr 2025
 23:43:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Apr 2025 01:43:03 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Apr 2025 01:43:03 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqy0w2o0l0.fsf@gitster.g>
References: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
 <20250414-505-wire-up-sparse-via-meson-v3-3-edc6e7f26745@gmail.com> <xmqqy0w2o0l0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Apr 2025 01:43:03 -0500
X-Gm-Features: ATxdqUEHxgwFe1thrugQ0Qo8IrgqiywDZEEOwC8bGpyJpdLad-PgEu4MuCHyLzg
Message-ID: <CAOLa=ZTjXetN3GNyvRSHb7mjxhnVd3VLSstnHxw8bAsO6S4wqA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] meson: add support for 'hdr-check'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, toon@iotcl.com, phillip.wood123@gmail.com, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000000a6f4d0632cb7b4b"

--0000000000000a6f4d0632cb7b4b
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +if sha256_backend != 'gcrpyt'
>
> That's a bit unexpected name; relative to this one ...
>
>> +  exclude_from_check_headers += 'sha256/gcrypt.h'
>> +endif
>
> ... I have to suspect that it is a typo?

Indeed, I had to double check cause I couldn't spot it when you
mentioned. Will fix. Thanks

--0000000000000a6f4d0632cb7b4b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 996d5156fe1b13d9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mOS8vUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meTJLQy80NHBQTi9LdEtFdndsUkdRUkZibXBCcDlqaApoeTF3N1paNWE5
b0E2dWQ2anR6YjRNaXQrckhmSlNEaDcwaGtVNFM3OGpWb0pSTzNDMmlENUU1bXM3UDFxb2NtCnFL
WWpETzlyeWJDS0dkMWZoeWZYNE1hd3Y2VjFVNC92WGdFUFJwWE5KeHFBY3B1cEQ1WEplRnFMVzhr
cTcyaGwKeTJGcUphNUNTejFBanhZaUZRQ2p4TmFZaVN4Q095Unhjdml4bVZSbnNEWWZXYmNzZ2pi
Ty96OVNnRHhNYWhXbAptb0dPUCt2RHBYc2RCdjFpNDVSbCtpa0ZpekszT2V2Y042RU5xcnkrSmx5
U0dBNTlaNmhQMEhNbUhEYldFU1FJCkhSeW5scUVVVnk1UVZBbTcvaFdsckQ2YmZjRTlaNkpLVHdq
UDh4RVZwUngvVFZmc3dmMC9sMlRMS3NvZzZoRjEKRGtROTRTWTkxZFFmMDFPYU1wSjAwNkp3ZHZT
RU0zL2YwZDNuUmJTTmtRN3JUNmplRWxNNUQ4cnlEOExwR1lpYwpHV0YrTnpVZVBYczc4UG5jdXVX
WDhCQklBM0J1bWJqOHFxbXBybUx2MkpZS0o4eGR1T3MrZHFSNlprc2FaWVFrCkZGWlNhMkQxT25h
UTNFTFhkQit3dDJ6cFlQUGJlQWtUYVFqRCsxMD0KPTBoUHEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000a6f4d0632cb7b4b--
