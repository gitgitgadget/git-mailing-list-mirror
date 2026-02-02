Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC062D8DCF
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026626; cv=pass; b=ix3f32Ru/dWNAum5fVPas0fRXKjvk4ZGsOS/zC0PGW8ocYkLIle873sYnXioLLxOes5u1PDMyTLYSKuS/qdTUU21Wuznqt3QtqtuEvU7DCNX2toR4X0TsoimOYMendJwCq9qqOJTpR9ocn8jjhS1FGV6ClZO9UJsFW3ZE6BnbQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026626; c=relaxed/simple;
	bh=Q5a/r8EQ1h5wHndpM2ciqbPs4OPQ92RvIqfwBZWJf50=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQcZHEiO98eZq7RgDVS+oZfNm7kdYWTFaQblScLeRTMB5FLUC5NGfr22+PT3JkPdTC8ZNNxva+RsBf9WjPMj/QalzpUSZGBBX5MSfqiuMzwHuWRosLE8425PN7n/4N2HpFDZaoqwLjj4U5+Su+7AynOhWjunjI2UpQFQVBppwj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0EWXklz; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0EWXklz"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-124a95e592fso4469649c88.0
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 02:03:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770026625; cv=none;
        d=google.com; s=arc-20240605;
        b=kECqBNC9nNoeaDr/o2VeyEIaSo3eJ7qg9z5Y+pTq41/c0Cj0vDVsyFUQPMXLzjvhrr
         roSk+SzilLKpbWmTsME0RMdPbP3YM5lzoN88j8c5Zh6UUPCQGs9+rvXcUB3GlMttkLYo
         xcWBm3Hs8Ddtfs3G58W41MVbr/s3OXUhEB7Uq/82zeLpKcMzOHQ0dtFYRqpyTFXowfAQ
         HUrJ09rkRjLR9h5ZjFRPnhi6IBnRnfS9nsptPdZkfN7jmxJBSJL+XT75K2Mfi+wy2lu6
         GbxWBvISIQSwfJXS2+F9yCugP7D6LE6dD+4uG0unCM60B/WVbwsILGywm+F+LlZnB6tj
         icWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Q5a/r8EQ1h5wHndpM2ciqbPs4OPQ92RvIqfwBZWJf50=;
        fh=B5ImfdmY7pPdGt0l17y+VNLxoNYi/OY6/93vDjXi35w=;
        b=DmpRk97XqmeMWQ/HdzeHHbHFHwVTHiirUO2QeNyL5/R4e7Yb0E1vmQRn2cvvTLsRbE
         CUhKDnYR1+SAnF3RenkrEs4zp6PUciRz33cm22UvpoZdijVirIdUXfMLwpY7OCvYTe1P
         upcag8GznOvev7mnnTBx6essbXP+UdPB0lW38AJ3d+oZFvGu3x71kJt022AyLESd3pBu
         26ZEwRvdJwfdAX4tzaDBreRzo6j7zL4vBcGFLE3vH3VrUeF7BUZf1rgZ8FPENfdfshJS
         SKrHYb/1bgGQI6shGidZq+M1hdtuxp87EzLTdTPITQ9CNJ3RvKQ17sLCuKysPMRXbbNC
         HWoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770026625; x=1770631425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5a/r8EQ1h5wHndpM2ciqbPs4OPQ92RvIqfwBZWJf50=;
        b=M0EWXklzbLwOxI8KBDQmIJLFyRjHVsDmyslpY5HoqpfQAiPbkcC1GE2uujakVJuLD5
         mdKb/KQi6OACPEd44SG5bGIuGbOuABGjlZ0bEJwuCOextuxtJ+YHpuclhmiV7RNjzAgm
         AoobL4HIyb6UMkd0whTiUgJzGtdFhWmJ/KJDxF4UPKnegaVjo1qyjGA/cSsudt5siQ1H
         CwbItImkoWMhJEU8KLKpUEZiBTaE5eg3R+65hYD8fZSNkH5Eb1G3QqvO329A9g83oDnn
         pam9gqRCnLjaWj6qLhyfDxGrvBKQshfzjBoBPBw9surm6hEVqnj0iAnKnqXgioLxPxqj
         HuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770026625; x=1770631425;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5a/r8EQ1h5wHndpM2ciqbPs4OPQ92RvIqfwBZWJf50=;
        b=DZAdbq/kYeK998LTRNFTcTscIK0P4zaV6qPpf9EGSmPI9qGrkWEgPl67AIstaKZ463
         4Ij6y8DrzxZ7RbDBHxQIpR6OPKYi4IYlhHgeB0XM2trXM7STX2AYqVr5Ba/jFe6njtJG
         oDaL7wAktXMHqx4Bs49FEOv+/OYC/sFqkEf9JUycolMH1JszReTx7ulzbv+M5WDPALLK
         vMTBd84ixO4XT1Ba/QYJE+yn1tmvy870bTzj8v/MToB0NMB3Vgs1swhQFTtwLubCnuE5
         zebkEkJp8UUhwZIei7enBXWw6w2a3wY6Ag9Ok3SKpC4KvRaZs7EvR+Sq7xr7sUYbRzNn
         sU+w==
X-Forwarded-Encrypted: i=1; AJvYcCU9EDXaBUdvhNh43F/PkFFIKxVkZuGZlSUP6MYjvMN9f8UfKDysXCJcb0uUx1iKvyle2fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSUPQrTg0zJ6SrpGW+mi3oSNRgw5/A4em++heNi9u4xOyyWyF8
	NovrVQXMp2rv/tao6CMYTVj2mXFcqF5aBugNnUrJOdtdFAVrtzPMjzzhDh1XHrhkV7U+YKfDHPj
	GvE1JA+9/zANn4yFwtZEEnM1PpEmKaxWCoQ==
X-Gm-Gg: AZuq6aKv2/zcDpKSycg8aFvWerPuVOgNSRKTlZ6c8K6N1Bn9bWan2dZcwKO+6OCeFhX
	OXTXH2rJ9OXtMJMAnrhKI5Uf1kdGTRTC2wgNJ7DvUPKiCHCQBmdFc7Vw1s27f/lXeyfiFEe/s36
	2/igj0GKYKTNzBXkR0lg1Ufaw7vqztzYp9MbRe1vi1MpTAPIfSFShvaGWgzHtgQSfIxDWxBilIO
	4ojV5AZewRafzs1kLvsfaYrLsyfeY0Xi623/QWIW/OriuUpCPKP38OHZaSs3aRx5fGMGmcaQ8aV
	F0CcDb9YgM8HH9s1hV6ZeOqfZDMPzg==
X-Received: by 2002:a05:7022:418b:b0:11f:3d55:ab9a with SMTP id
 a92af1059eb24-125c0fa6663mr6563717c88.13.1770026624741; Mon, 02 Feb 2026
 02:03:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Feb 2026 05:03:41 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Feb 2026 05:03:41 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260131190106.389289-4-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com> <20260131190106.389289-4-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 2 Feb 2026 05:03:41 -0500
X-Gm-Features: AZwV_QiXdZ5B-vmTAEJbuNDgfIWtVpP2XSjnGeQi_HZaw3NO7qvpeURNOoD1JSg
Message-ID: <CAOLa=ZT6ReeaPvJiNh967Sn2p3K8sQKEOOMJ+6-7ZdFO+wr8mg@mail.gmail.com>
Subject: Re: [PATCH 3/3] wt-status: use hash_algo from local repository
 instead of global the_hash_algo
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000367e770649d47079"

--000000000000367e770649d47079
Content-Type: text/plain; charset="UTF-8"

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> wt-status.c uses the global the_hash_algo even though a repository
> instance is already available via struct repository *r.
>
> Replace uses of the_hash_algo with the hash algorithm stored in the
> associated repository (r->hash_algo).
>
> This removes another dependency on global state and keeps wt-status
> consistent with local repository usage.
>

One final question is, does this mean we can remove
`USE_THE_REPOSITORY_VARIABLE` after these changes? If not, why?

--000000000000367e770649d47079
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6f7a8859c9b2189b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tQWRud1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNk16REFDVFpXWkFmM0ttaHZTVkZlY2hkZHZXRkQ5dQpUMHppYUF1RVVu
ZXJYQ0tzWTRlZlNxb0t3NnZjNEJZZ05LZHRSVE9Ud1RFNCtGTFhkSmc0Z0Fuand2RHBpbzVVClBO
ZXo0M0IzalZaYTZScnVveFo3Y003cVJ0RGpsa1FRTVQ0K2JROEVrSVlpYmpwemh4R3RLQmUyY1J1
TDRVK2MKenp5QWh4UGpLNXVXRXJyVTJ3U3AxNUprMm9yTUZPMERwVUlsYlFCdHdSVTBxMGJJZUFO
QU5abkI3cmVsYW1obApXSHhiN0ZKTS8vbVk5UDc3UmZhN2lKOTlPZjF1NWRiYmpUcDJaci92TTV6
N1hyQWQ5eWVMcGFhK05TUk5FVDVsCmhCNVVEOGlOZm5CYy9qNnkrR1A3aUY2WmJkUHNQdEJZaGVM
aEhhMzMxU0NjdWxpTGt1WmpxRXUxVUVsUzFZK0gKNFFhalhQS1Fud3djMSs3d09EanZOYjZMRFdt
TmtHS1JJclRraVNxemlYN1RZVkV3R2txMk5VeHRHWm1JN2Y5Ywp3cjg5YVBvdGhjbWk1VlQ3eDBL
THE4eUtrNlRHYk5uYy9wVkpvc1ArbU1YUG1uT2g1NFovRGgwVzBkWGRjLyswCnVxQWo3UTdacEMw
UDFhc2piNWg4N0tPbCtDZWo4cHRhOFpPVjlLTT0KPXIreDQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000367e770649d47079--
