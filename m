Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62F41A8F
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203326; cv=none; b=L/ipnIUvA1LSTiZK+4dOz6Qt5p6Eu9RgCxXtmm3Fi7MQihmZJoDh9yvuLlZ3HmGQyxT+FXDCKWT+XX4wC5LP0B+ePJ8um/jX2vA4FFH4qKqVOPUyuA5HJ6NSX8bwGlMSSmHsBUrqYHCjNgCeAdqyeRrAcdnOznkAvnqmsKb0nGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203326; c=relaxed/simple;
	bh=F+X2mPylfJ18FNFvVc2cwdr2notObc46NYZ5K+2mXt4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOMzGZjNydd2KoUktit5hE0lr2Y3PBdJp1YGsAK9JWKRgSy+TWyFxkqB8ic7twe2alOB8EDGdtlm/fTRNH75ZpnsfdgHbUPlkYmR+jYO07fxjDdIxjUEnq4KJeU2KSuGKqnRWqDnWY/6AuuREaiCVPA4YoygWTit924aAdcWZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYLei6Ie; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYLei6Ie"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ee58c5c2e3so491946eaf.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 07:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732203324; x=1732808124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F+X2mPylfJ18FNFvVc2cwdr2notObc46NYZ5K+2mXt4=;
        b=RYLei6Iep83YUDN38cptj19tJovLBbLvppJlLCq0EwOISxHJSxbGe2cvcoCJuPQ9xQ
         x7w/HP2p9su++3WILgNjYsF1/0D0/gPuTgL4y8rJ+5sw6m0V7nCLl4lHoIsJRhJtlALi
         F/i4mexFsmsj29XWaozelbkn+UCh7rtkG1FD4RgpJ5zuvik6vsKPx6S2STp08/h0496D
         CfMmUt/A61flH8VP1pAzFgOfWG5zv2TSY02HdH3WbLbA36bgJaLAbbU96uUnX1M53xQ6
         Pg4ckhc/dp6mKrEfoogBmqO2yisxsC4ZzbvEsMHh/gdMkOtAN/Qla2+Yfr0hEkIb8Mul
         ppcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203324; x=1732808124;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+X2mPylfJ18FNFvVc2cwdr2notObc46NYZ5K+2mXt4=;
        b=VrRmgxO5n1ZVbeiy8Jy20mUy3tIfKMP3cSfJd7hDRGqmxK4vjT6N3NdaiYLFVGHEol
         CzZ7SunvBXhCtjHQK69o9S1egH/r6cF64NlHruFiTmp7Eah2hWWVip0Kjl9DPF+4OwzT
         HWeWJLTG33Pao04euKGmaPAgaIHvqxzdLTyj5jxoJoUH8xImTbpmq4g9kIgmdPbuSGZv
         8zMJ0XEKcqiLsub2RLgsM1mSIwjVgdiR0DocizuqfwR8DD7FQdPe9G/fUcZcB8cCRTE3
         dU7Nw0w3NEd3LbohnpEiAwJMeG5frDf4UyOoiKCjdZA7VH2oLu1UydOAP9UZmQK7Otre
         5nXw==
X-Gm-Message-State: AOJu0Yx0IhR6FoH3GnSNXLdyaZHnm3KKMFJx2WZlUrztXT71c+yiLxUQ
	3+OrfuzfJuBGcG8tK7zgBY+emBK0h1+rdxWzukiAQijAIgukmEfTuwi9hktRNFpIkG7dpvMZ6U5
	OOc/kuUGuGcd82z5OcV/hJXBK1zK7FSNW
X-Gm-Gg: ASbGncuFeHz5jFVc5C6qlp1sgUi03durXcSM2YNPPnD4Dg5iuyfP5fDaY9Q0uCP/leO
	hmyTm/YtTK8+OIUQQjAxuDiMfYUqky/MIB/s9uRcC4FjqRXAEZhD80Ts3LJfAYc0z+Q==
X-Google-Smtp-Source: AGHT+IHmhTHuECer2xp1nuLfxl0BIh2Bff5FSaZqQTZafL5yPZn3sUMtp9XSG1NFOzpcGeyzE0yxXRQbgDl0stJ+yrE=
X-Received: by 2002:a05:6358:928d:b0:1c3:8366:7e92 with SMTP id
 e5c5f4694b2df-1ca66471a00mr450190555d.3.1732203323774; Thu, 21 Nov 2024
 07:35:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Nov 2024 07:35:23 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD3ZuTtd2SckoyvXmkMG3eeGqH3eHSHtda-4o5yGdj6cBg@mail.gmail.com>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-8-e2f607174efc@gmail.com>
 <CAP8UFD3ZuTtd2SckoyvXmkMG3eeGqH3eHSHtda-4o5yGdj6cBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 07:35:22 -0800
Message-ID: <CAOLa=ZQPtxeuqf3VaZKai8=15shpynOA5yn1pWjnQ89wnc2U7w@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] midx: pass down `hash_algo` to `get_midx_filename[_ext]`
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="000000000000cbbf8706276e0363"

--000000000000cbbf8706276e0363
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Nov 19, 2024 at 4:39=E2=80=AFPM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>>
>> The function `get_midx_filename_ext` uses `hash_to_hex` which internally
>> uses the global variable `the_repository`. To remove this dependency,
>> pass down the `hash_algo` to both `get_midx_filename` and
>> `get_midx_filename_ext`.
>
> Technically passing down the `hash_algo` to both functions is not
> enough to remove the dependency, as replacing `hash_to_hex()` with
> `hash_to_hex_algop*()` is also needed. It's a bit unclear if
> `hash_to_hex()` calls are replaced with other calls in this patch or
> not though.
>

I see what you mean, this patch itself swaps `hash_to_hex()` with
`hash_to_hex_algop()`, but only in `get_midx_filename[_ext]`.

> So you might want to add something like: "Replacing `hash_to_hex` with
> functions that take an `hash_algo` as argument will be done in a
> followup commit."

While we also do something similar in the next patch, I'll amend this
commit message to be less vague and clarify the intention. Thanks.

>
>> This adds `the_repository` variable usage to
>> `midx-write.c`, which will be resolved in a future commit.

I think this is stale too and will remove it ;)

--000000000000cbbf8706276e0363
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 26521dc726b7a4cb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jL1V6a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1melFqREFDU1RBa0J6RWRKVnFReitiM3BzaHludUtXTAp5czJnSkRMbXRt
eTRvUUdJamcxeHVkaVhaQjRKM0xYUjNFVlNRenBOOUdEWFBSUWs3Q3V5UXJ0V2h2d0IyRUhrCmor
VDlydE82OGtaM1psODAxK0NWQWpnM0o0U2prbnkvaWFMa0dTYzVFcHNEMlYyRUMxT2M4RGpWYTZz
YjBiRmIKeGJ2OXd3dVVTcmsyMkt0OENpVXVZQlNFTzlpdmwwL2hLdW5zL3ZmQnRaWk8rK1MxaUhq
eEJlZVY0TUJGbE90cAo5Mk9ET3kzV3N1NmZMQ2Q1U1RoUVZlMllxTzJDU1d0eDRlNXI2cm5DOGpQ
bW5kcW01eVpYQTNQNHV5Z2lQd0xmCkZ1VmNsQ1JvZ0hKTjhCek1NMEViVHc1NkYvdmpJQ3Y3MjNU
ek1OTVhJMmhYQ2ppSktJV1h2VVArU1RoZEVBNlMKTWtyNHh3SE9TOWtxc0pwNFI4RGVmKzlOZHJ4
Y2hiN3dVZDdXYmJFZElyeC9VakhjYnd1SVVNRkFLNWZPUUxVOQpwMmUxYlBCTnZNS3IxUEdFZDds
TmJsT1J0MVcwdFR3N1pFTE5pUTR3eEVpWmUyQXhuL1hJNXovM1NoRzByQk4rClF0N3A0WlJIQjds
VWhpaDM4Q21IOVh2Wm9qWXJVUUJVRWdPaExYdz0KPW5NSy8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000cbbf8706276e0363--
