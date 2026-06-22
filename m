Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AFA18CC13
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124216; cv=pass; b=ZiW8ssfUsn/CB+weAQLDxXrUhVNFIxQfVX11jfzUX3Ns0y2Ow8Q/1YMfDSc/S0MkcdtASHzcS/IWTNlgrVyvX3UH3n2n/rQeYYmiORiU8ZSNGP0K873RE0yVg/r/ol3UiBAaqxePvUPjnNj0df3scugL9laSGYRAX//tnxKGla0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124216; c=relaxed/simple;
	bh=qjHH/Cnfgp4mJoTM3eWnHuQalC7Qa49odfGnFDbpUtg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gf71EXHs/JMEFYKBs2lW1cn+gfQZ2T3J6N5TN7tTWh6F0Z478PdRPz7ZhsaK+bF/REOFyq7l0U8aOabbY0VgX1JZl0i0k5t8eIBqh5axJme6srJhHVA4H4wycGTidjxeMeItOJVXB/V3ejkWcNzUKovps/CyDMaZ6bQPonXiqro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kexzSgOZ; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kexzSgOZ"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-72686746814so2422483137.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 03:30:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782124214; cv=none;
        d=google.com; s=arc-20240605;
        b=LYvfvFDqjv7G6p0ie1V4T3y5JW/V/TLiKC5oVOZxLF4q2HLnKFPP2o25Y8xVuk+94X
         SE4cAT0Ybj+BotWZOos9DGHkpsZvJTrpT7nbUW9tO9fvcQ9i6LE9/6uVQYX5OgBj9Azs
         gmXDoN68I7R9HpA+PVcyaIcqWHtGLh8N3OP90YyckIoXniAU/yxSglsPXtdZf2+8EpG4
         P/sgsOT1opbuh3/m1OvBTa9MlqmI+0NSfmqor5SfuZgMOp8TSJa1zfAjAiedJYJ7vCp+
         85/yXzGeiob01AYm1WJ7xJskYHF2QbK5kQd2KyzsuXZdLFYjSBFBBRMFRDZpdY1HMACK
         Tz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=wNwWaJ6HGeTfud+5xGJhSIeFiOHA3CcaeShlBUC/Pys=;
        fh=sSn8nDWfZVekDe2BIpF4/2O6NUljQKWwefSzWv8I8dM=;
        b=PVCG++LCzkgS36g6hy/zWBhBmSpk2lqDDtkeAavc0WcI1ySrx/CKCiM8hBBrb1h3ae
         y0TCAQASAQjDqp3bMq4SOH/0fTBLOCa+gMwSluUoUGdtu7aMvPE4V8fCA0pDSirkeJlI
         UGZyEy+r8BVIvfPIh2JV+vPyWOPyqitOKV6RGEVjzYjJTDK17+33/rl8gA2sJuNlVXfZ
         b2Hap7WcTbpdG3VMH1OIW3O3iMke4bMu5/TMRXCrCdP5L46JYLO1091KKpAnRbYJNXme
         f4/S6Gxekzo0XJAWMyLZZnsc3ohnYbMmghyMmsiuE35iejGNFmUNENZMPiOeBHStT3Ja
         dThQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782124214; x=1782729014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNwWaJ6HGeTfud+5xGJhSIeFiOHA3CcaeShlBUC/Pys=;
        b=kexzSgOZHSRmJLXxSGPfXQHH6nYSuEOseTIEqK4qJiWfSfXAGL8bFn04MmHNiAz42f
         b+z4Ria3cAlo2BQ91lLEQxNGGRNpS2gwDwiF2KfwGexVsPyetvK5JUnz971DzaPK6/tn
         ZyYx7XG4ge7zNFQ64FWrTb4Ar2y3QUDMt9e3o7PApH1bM1TgAq03q3P+kqw0i6Tfg7SA
         ITxC6ud6sjzr8l9nNrrLz9kRh1LETs5Skw+mtCcnWtkrVm2fawYS4jBx1ML407geDlXL
         QlX5FSlqSHjzm1OYP8MvMEBNfPgfzHcO62FTvi+0rTs9SBcKDLsE/k6woAk75BpV0v7s
         iiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782124214; x=1782729014;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNwWaJ6HGeTfud+5xGJhSIeFiOHA3CcaeShlBUC/Pys=;
        b=eG/SWiZ79BF6a4bPG+jZzD/j1K5jjMH7WMKD7sxbsqS/Hu6pR8vVYW8QiNXm++wSDG
         adnS+Q8Zsrp/P3CUQVq3hO83SRLuQJuO/x3ALKyjvfBPRSImoddq9M906GFH+CzX/E5Z
         MNI5CzWvezjk8s99SqOy6fieOZczeX8xTXEF/BRFdn5E2dA2ymrqy95+5zaPluaHHTtn
         y6z9hVFqbw9zHwY4t27uAADG1aVfEFVl8E4dXCun9JmjjPBgSyw+EQOrZexW97g8kFrh
         1zo8K/FkVNY9Ri/Zx12vuCaCBV86TkOkOIDFpRUNTvkftuv9KlbEbwShF8XJ70+JWKwg
         OPDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rHcODre5DYBuiGNaFFUr7sD4TMhHLW+a95q12Mubu3IQhro+GeF91UuwGWj3dmLfo3WI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8rg4FyHMMyhPMskMcnKHmUY9DQR4LhVeyZWnMWuDoPwe0o2cM
	awfPRsgPSCsFvf6D4jWgD/kOkfJvMHEfxOPg2OgwCxNf7h9M1Uxxd9XAGlcD3Kjz/C9xdKCSQry
	kTLLBTPytkMGRe6mz+G/TCDxqyWNq57k=
X-Gm-Gg: AfdE7cm5iLis05j57USJZVMD+yJTPF9WejjX38NjOZYEhWq/2ynWesN3i85ftdx0b2v
	geP63YR87TB7iNugHGFnSq8ef7fj7lXj6aNUylIz/IIGSZguPlS0AM0/WGhSifnfst/5pmCrbw0
	Ni2eQQ8B9tE1iJWICAKW0BbTzBQvQ2cJLLnqhbihPCfjiTbqxX6BYXYv/AK44IlSmpOx2ALlugd
	y8+rlGSg9TCLdaOeP8d0hXthYa5apiin4MxA0p9Jfsept2ca3Kmb4IzQvLoZIU738HjyC6IFQAA
	qT1r93Q6tYLA24/l9HRtjBiCMQjyn5l7F+KF5aKOMwYnfvpgdm8hcgQkHY8f0lM=
X-Received: by 2002:a05:6102:2909:b0:631:81d6:e152 with SMTP id
 ada2fe7eead31-72a1a5d0718mr7867408137.0.1782124213819; Mon, 22 Jun 2026
 03:30:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 03:30:13 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 03:30:13 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260619-ps-eric-work-rebase-v13-5-3d4c7315d2f8@gmail.com>
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com> <20260619-ps-eric-work-rebase-v13-5-3d4c7315d2f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jun 2026 03:30:13 -0700
X-Gm-Features: AVVi8CeLM82Wfa5zff41KrdROrvaqJJo22mPGYiOZa_idFUvzpO3UhOTifB3vqY
Message-ID: <CAOLa=ZRUoBKPAjh6He0qgdZdzAzMxmeS9RMRi-czpHEfKG6EKw@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v13 05/12] fetch-pack: move function to connect.c
To: Pablo Sabater <pabloosabaterr@gmail.com>, gitster@pobox.com
Cc: peff@peff.net, eric.peijian@gmail.com, chriscool@tuxfamily.org, 
	git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com, 
	chandrapratap3519@gmail.com, Jonathan Tan <jonathantanmy@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: multipart/mixed; boundary="000000000000b6164c0654d520e8"

--000000000000b6164c0654d520e8
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> write_fetch_command_and_capabilities will be refactored in a subsequent
> commit where it will become a more general-purpose function, making it
> more accessible to additional commands in the future.

Okay.

> To move `write_fetch_command_and_capabilities()` to `connect.c`, we need
> to adjust how `advertise_sid` is managed. Previously in `fetch_pack.c`,
> `advertise_sid` was a static variable, modified using
> `repo_config_get_bool()`.

Nit: What's missing is why do we need to move it to 'connect.c', I
assume this is because it being generic means its better placed in
connect.c over 'fetch-pack.c'. Would be nice to explicitly mention that
perhaps?

>
> In `connect.c`, we now initialize `advertise_sid` at the begining by
> directly using `repo_config_get_bool()`. This change is safe because:
>
> In the original `fetch-pack.c` code, there are only two places that write
> `advertise_sid`:
>
> 1. In function `do_fetch_pack()`:
>         if (!sever_supports("session_id"))
>                advertise_sid = 0;
> 2. In function `fetch_pack_config()`:
>         repo_config_get_bool("transfer.advertisesid", &advertise_sid);
>
> About 1, since `do_fetch_pack()` is only relevant for protocol v1, this
> assignment can be ignored, as `write_fetch_command_and_capabilities()`
> is only used in v2.
>
> About 2, `repo_config_get_bool()` is from `config.h` and it's an out-of-box
> dependency of `connect.c`, so we can reuse it directly.
>
> Move `write_fetch_command_and_capabilities()` to `connect.c`
>

Nit: Wouldn't it then make sense to split this into two?
1. Drop usage of the static `advertise_sid` within
`write_fetch_command_and_capabilities()`.
2. Move `write_fetch_command_and_capabilities()` to `connect.c`

That way the second patch is simply a move?

[snip]

--000000000000b6164c0654d520e8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: abce60a707184e25_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vNURyTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnpDQy80bndKaStSVGdCT3hEZ0dYNTE4S2NKWnhpVwo1c1dWWjVYUmU2
VHB4YWhpV2t2NnlGRkRObDllNmI2UStWcG5WMUxFK214U2d2RkNmNGxaTWs2eTRHWkVFN3hwCi9J
OGdNMW1yaExtdTg4K3FKV2UxREdRcFQ5WUg2a2ZtMERqWXUzWkpmeWJNWEpGbUU4UHQzQkxVR0Qv
K1ExMjUKU21QY1RlL2lqbWFiSlZTMmU1TkVFTlhOSTFsdi85WDJMWldkN2NzaC91RkZLc2ZZTG10
OXU2Ri8xeEhFeTZTQgo3blVzb0l5UEJ4WTJ4enFMc3U0L0dmQTVXMm4zVDU3UGlVNVVJQ2NDdlN0
a3QvNldxWGE1b1FISndoczJpZWIwCmVxYmF0bkRWa0lVY3BsN3dFbmV4eVdFNlNmbkJCQU1yZU5y
Zm1Ga29aclppYjUzKytTWU83b1VMQnU0Rkk1Z0cKaGd2UzA4a01yaW8rNE5aVlhsUTlWdUI2MHZQ
dml4VTI1QWI1c3JqYmhwZzI2WnhDekdpWE5iNEs3TWtCODI5Mgo4UGZHeml3QlFTbUhIZ05la2ZN
NjJBNmNKSjNkUWt5bzBLZHlYTWFvNUk4Y1N0OUd0ZnBYWWQ3d0hBSFRHSkNoCjRJN1FiaHhSUW1N
Zmk2NnRiMTVCNld0Q0doalNBQ0tHbG00LzRIND0KPUF1NHEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b6164c0654d520e8--
