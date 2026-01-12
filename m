Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8FE277035
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768218621; cv=none; b=pIEOd6MWsub7mu79SDdTK+OpVdlMiqSXPdHMCg7oMV/uQSFtV5vTaUXJYojMPGvmB60Ckd5xzqtTU/k8ZZ7g6h9ni2RVTqvCKmy8z2b07txXCke1IDwjIi47DRmVepZys9MFTtBkTun/2F1KLTCbN3/R5ITBZGndb9obLpboWRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768218621; c=relaxed/simple;
	bh=JCuKu0Vohk8lTr3ElMpyls2Tmu9q/O5adX41jjmTot8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUsLiPONho48Xdrx5zttR/KWN6HuOdYBjQ34F0JDE+H0hhAgxolcyGi/5QPy4TFKkwsUpDsOqUC91hqfUDb/g/ooQhcPJGOYLw9ygbY1QNCWDoGNIbbGJK6B96UXckIvxFXc3g4OS1yDhHc9gEP+hS8bE6XCnBeHusi4Bj7I9qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeQN/aU7; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeQN/aU7"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5eeaae0289bso2496207137.2
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 03:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768218619; x=1768823419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3JCrHmSxzJU30AYxhNoxwgLRBlGWDgw5bHk+HlXfXA=;
        b=aeQN/aU7X5BeEfXpwevOX+XfWTLVph95ry7ygx6zJDvQ7HKwpyqITYfM8VYP6RdrwP
         hjoMjnR/dwVDSjpCyVfcISKiJ5uHQoZJl1E9QGBNFoVyDTciCOQ6gupphb7pZ8t++Dhh
         zj8F0t7ne15YT1rL/1KV/tJAHoMFa87sGv7BaPQQRJ4wTrYagFjEVBQfB8/lPI6r3nWU
         yjsbVOWXMfJIonVzxDHgdn8jI0++f3kWeDG0QpR6QDLJcQzEMrlLXuErMWnWB5WJIhU2
         VtcALa4XrRVCTuWAyi3lnUnH/dKKPdFAm7bemzVLI7XZcCOU0Ev+OINQzSJsww0MpfRw
         SDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768218619; x=1768823419;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3JCrHmSxzJU30AYxhNoxwgLRBlGWDgw5bHk+HlXfXA=;
        b=X826UvWHD0y52eGmRd8ktJj6sn8SO/kuGrsv059e3CBcP5c8efjuIGpGt58J3sW7vn
         RpQkzlo8jAfN5Op4oupKLKYjB8smg3lDH1mwyFtMI2hAyfHgQ9JbS2lcMSsw0kADDV1T
         Y+i3fKCfnHFw7HqNABZ0xSmiiuZufSEwpBjYiqqzlYNSaOp+k3H6Q1lg0uW2cx8Cua4z
         iIglZ9go8yCmhItV9D56TUblRQwfWRLrWCyVUstw9R/tc4UvRiPrg3TFe0CXzMRyXnjR
         6C5yl0RLMe91+wm7dTdJ5KZ7pk2ERW5biwqNtzS4GybBcWqOBf/ct7ZykIKvhGay2Pp9
         95Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXJjyyr4Y+Yc5ayYVcBDxlIhCC/wb8joZQaHI/Ei9Tj1Ptsg5+fUcFtci3vA0LHrs7y80w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI128ZEhB6in3xSpbLw8KkfHOEJ7ysfoGrV5CeaBaTcs2vxQwc
	MAw7JeCi0jJC6Jhrs0QwprXmJdYSnQT458Q5w1fNQuJ2BG70MOqMyiiuD43mE4vvl6zkpt6yZg9
	8zT49FuDR3h/YemZvszwo2SkYrG5zoBo=
X-Gm-Gg: AY/fxX4OuuYeZFoj1mEjzjikRvjW1t2vNX/jyrb0hLak1hKyMOoaHjXYZ0oBeHsxkq5
	Dlh75Gz17VdxTolIYP91gZizyLMRGctgpKToJV0uMYFj4HutplYCiVUWaCInls/+BF8DTT9vxgW
	JjLOur/jTB8auRcyNZUIY8E4kGDP+0/UJRNf8FwhgfthzcxVpW6AZBMa8AHnz1Qhp86WlDTccUf
	yiGOfEpDbvQjm5Qja0Hl23rWr5pnSawJG7142hpGbtsStsMX8976BDu20fXWba0DHS6y/QVi1sB
	uiLHlnSr8RkV+Afl/2+UtP+2WqG/HQ==
X-Google-Smtp-Source: AGHT+IEVd9NNR2iKC5QQ8NBQW4JZqToLilKLYrwNARi/01r0jVdnO7jKjGi/Xhfk2clVTu1uLllI8lA6c8L/w1XaXjk=
X-Received: by 2002:a05:6102:6050:b0:5ed:d33:a65d with SMTP id
 ada2fe7eead31-5ed0d33ae20mr7197930137.34.1768218618984; Mon, 12 Jan 2026
 03:50:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 06:50:17 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 06:50:17 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im> <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Jan 2026 06:50:17 -0500
X-Gm-Features: AZwV_QjqNJR4rMBWpkWw-460r9M58IWE49ieEVWMhAI3cuj_Wj_Ui49Z-ovm6VA
Message-ID: <CAOLa=ZShPP3BPXa=YnC-vuX4zF=pUTFdUidZwOdna8bfVTNM9w@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] Fixes and improvements for ref consistency checks
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000abada806482f7ae8"

--000000000000abada806482f7ae8
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series contains a bunch of fixes and improvements for ref
> consistency checks. It is structured as follows:
>
>   - Patches 1 to 4 contain a couple of cleanups for the consistency
>     checks done by the "files" backend.
>
>   - Patches 5 to 7 introduce checks for root refs for the "files"
>     backend.
>
>   - Patches 9 to 14 introduce infrastructure for shared checks with the
>     "files" and "reftable" backend.
>
>   - Patches 15 to 17 move some ref consistency checks that were still
>     driven by git-fsck(1) into `git refs verify`.
>

I reviewed the series and it already looks good, thanks for fixing some
of the broken parts and cleaning up.

[snip]

--000000000000abada806482f7ae8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 62c7ac8df5a6d241_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sazMvY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mekdzQy80eFVPVjBiVTR1cmNWMURIZXZjM2FYMkZGRgo5dDRybjBaRHBp
RWcreUEyNU1BdktvRW8rQzNYU1EzMkVHZFJNV3VpbjltaGNKdm1HZGhoTzBRcGw3YXpJcmJpClF6
amFVRDNlbmd4cWI5OFZubGNVMXJFN0RlcElVZXJxWkpwVEI0RHZXY0NWOWZWQzYwYjRPT3Erc3Q5
czVZRkkKK3FUa29UUDAycmMxSEhaZEZMRFlXU2U3cHdXSWtkYytqaTBYQ1B5eVV2dXl1bUZ5dFNz
eWRTaWxVQzJvaDJMZwpvL1h3ekZudWI1WW9FREhIekJnRFJyblVCVUZ6YVVMYWxGOSt5ZXczR0lQ
Q1dHL2RzV0NWSm5ZMG84bk9tWW1OCm54eGNGaStSUnVZdHpEMnViR3RZMFNJOEZjMlphRHA0aFYv
OFU2MDh4VkVvS0luOUhKUS9XN0tmZ1lZOGVqZHgKOGtNZVR1am9KYy80UXNCZFIwZlQybWpaYnVy
bEw1U0gzTFBsSzk0aThNQ3Q3eTRpdUZjQjdWR1VPRzYvaC9QRQpsS3IwNHFRN1J3L0paTG9jaCtH
c0V1MVRDOHNDWnJ2dDV3bXFMUnV4aDd3NnlmRUhQU01JdkhYbHRUbFlod00zCmtTTi85eWFHWjla
TFBCbUkwY0lzSzZ1amdORE1zdVVyOVVEaTZLWT0KPTJXcTUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000abada806482f7ae8--
