Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD97D3793D5
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669537; cv=pass; b=UH4CPHX62C2BgjOLnkyUwoKdOAYgTl7BTN3WZP0izhUjQ/wQPrq4RQ3jY+HxSIqk7CClB29TKSrb++L1ObdgYDRs+gBfHX9VrICJg0yJzSqdbGbVUbnjBwnjhlqrW3wAuKlPQk72nePJLykcprqEFtKJGrvrxdB6KTFIDSUurm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669537; c=relaxed/simple;
	bh=9POldFjv2azI6FRSFPNoSvl2Zao//juKE7b9bZm+eI8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=hjmEGuZAq2Rqs+Ey1aOIGb5hcP46YBreLnn6B3y8Sz3oZ1kfHQRLjLXF8HH2mxsdLvA3f/fE+PPnkyci1rjcNdHxQ2zQcBUdCnPv+k008vcLffh4uE9ZMV/zWoUmUQtDPwJjf5EwbkqH+u16F5KLn5We+oTgYDHnGE0TPg/kQKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlYEQ/79; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlYEQ/79"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-138129a622dso267906c88.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 07:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780669535; cv=none;
        d=google.com; s=arc-20240605;
        b=FgmoBh/BPUtLvK3Vl1Wq+GMyy2VYxDcH4XF92Kw7G696jpxEJoOnVa8VkehZb+OWll
         YUGxad4iUFMLl9VlaeyL2f9NbZgxmWc97r9ub8tFlHhBlw4GAIKydqgNgvEk2ZtXyJhy
         V3yuceYvAMouPwdCjlYrOYSwSF5EGCVBOiHVeFW6TPqyQtbJwoFposK9yk3aKOaTyB7L
         DQITYa5f2fYLEe7quHSLrYeUXx9A07MsYseH8NINfhTIHSX6q4BTEqtEUwNIHOmaihE7
         Doub5WgsrsUI9NXxLoNoYyzrpryLPjZ8oDcO5AsfkZK1NGVpkhmpy81YVEqWk5tUcGFY
         cWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=9POldFjv2azI6FRSFPNoSvl2Zao//juKE7b9bZm+eI8=;
        fh=pSWEhGnDDLlvidGGmfN2rtUWBKvfvT2k6PsVq/Eer1E=;
        b=RztMf5GYz6wVMRSv/o6CHBSsmP39cLQ+Wqc0nn9ZnfkvP4CQachbrluznMBcPG8Uhz
         uQFHDoSwHLjUcnJWGM2LvZgy7FOQgpnpC9wx6NwVabjntqGSSRwX85av6M+7R+gcvhsh
         QVkD5IAVkz7uDLJX9DyPcxQjoCyfVvt2TLYBqHBNKinNRYYgs0YdslxNHIexMZkgeqi/
         82pHO4OnS1xFh/Oe7JA6pqPLKMQEiso82UnqsB5DJhRNIbkfBd3rIn3XQZ7Pmfda0uUu
         zVHPfUHCEETbw3hJIabepsvdEfk4F1pkarKpjvksqMJfdg22UN9XK0o+iLTccOmc9rw3
         x4JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780669535; x=1781274335; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9POldFjv2azI6FRSFPNoSvl2Zao//juKE7b9bZm+eI8=;
        b=MlYEQ/793NbuBqzJQatj0t21Ja/ggCsO3+1u71W49jXhi5Or9xRW1PBNcmLOb7G4fT
         pyWQW12vwoX6J0K/z7Oxmt0h25mST4VCBwYUoUf0MhtdSWtHjjG+E0nhOd4ph1g4fUTM
         AYTWfGfRGvPxw5Wz4op0Q3+EPoxSjJ4SYzlaUblho3XEVXcaW4rZ1NyEQw7qierv1b8U
         CLJjwYGV4aJBkrHBiQ60OQIh/tx+dSAUVy9g8Z5z6wKA20NaJmmbPu72gpdKC6Q/cIBI
         OBPL76pdq5YZWB47z0j51xaYYLHZHpYjGtnTwftwlmBFx8OUaePSgfDPVEdiTiEjF9K4
         ltdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780669535; x=1781274335;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9POldFjv2azI6FRSFPNoSvl2Zao//juKE7b9bZm+eI8=;
        b=aTPwNNicdHHVCX85WdxJBEU56vY3aT6+8fsahzdYwwaGlytNP2w32k6fyLd+q0lzoM
         dHUmYzfuBp3/odDq+AwfYIKdqJgMpSLxMgAQIxh4tfQTsm83z/xEBIoWt3QuRc6OW9bw
         /GYeVUgymX5BZRteeERro+vbXRyOBG9GGToD8aJw4CeYCz/0zmRgEF01yZhYC7+FrkFh
         Q7tW5HqI980wSh88bvivAqJecypkjle18DRQkGEaZVzeegNOeD/LBAw0iGwxEddrgJdE
         qnhRBRncsNzBr6ZRa+FagPcWXxidTBvjIBgQxjJqh0YMJ/kXNEPfTGCnsTjOg3j7zKRX
         51/w==
X-Forwarded-Encrypted: i=1; AFNElJ9HrvBME87nG1sgnBf9h+64HtEXD98Jr/Gru0Y6e914AXGHQr3RMncjOcJJF5szoKAb7zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbDVRjpo5RQOIeJ5JJ2PiTsk6Xg+L4YifNvi2SB+kcdce2r9Xc
	j21vTNCrkEzOAngZDC0330MgFdOBO6Z+Df+q1wSUGQhjhXLrGJJbbGZb8iD8uyWSSlgCv8FyPgM
	httU5whc9fZpFS+cXxHeu4WUAOahgpe8TRA==
X-Gm-Gg: Acq92OFYdp1em74jKvaJQrNQdIIJzWII4KMwH5by3hXYXRHUIkdn8dvWx4d9dUutQgW
	VfpKdFjM6RTUM+cCMW9SM2fFk6tUvj9oDhHGLlb5JGQdPbR6N4KCTG21cqXcrTDP+lijtJUgF9E
	DBhubRp+vOJw+sdOQ1FAbtky8zyOAOnxLRUaC8ZIJ8xWKnoADTuU0u9Et5zIdKTNHmPXv6yq3kN
	3TeSdmgMHTUGpkQF8MPei/cvBSIW3/Kvx9pm7IA5O1CSq2iKft24NroKtbxuQRUcw45MCxrjIYv
	FR6vsIYKmLl6+JvJ1Vz22lJbRjGI14ZEc91OTyzQBNTi4HKsFn/zXC/PPhJe49mbOMbFctI3gZv
	n843ynjxHFa97ZAQC
X-Received: by 2002:a05:7022:6613:b0:136:5e4c:7aba with SMTP id
 a92af1059eb24-138066c93e3mr1886266c88.16.1780669534744; Fri, 05 Jun 2026
 07:25:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jun 2026 07:25:31 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jun 2026 07:25:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260604-pks-odb-source-packed-v1-1-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im> <20260604-pks-odb-source-packed-v1-1-2e7ab31b4b5c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 5 Jun 2026 07:25:31 -0700
X-Gm-Features: AVHnY4Kp1GOIH2p-7nWQdn08UH5AXJ6i3Z36y7vSXqbAPlnfLNQPrubxPV8zMjg
Message-ID: <CAOLa=ZQhGbjFbn_cpOmhYYN0xNjp1K8_Pj2mi34WzS25DG4ZEA@mail.gmail.com>
Subject: Re: [PATCH 01/16] packfile: rename `struct packfile_store` to `odb_source_packed`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000153ff10653826fb0"

--000000000000153ff10653826fb0
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Not too long ago, we have introduced the packfile store in b7983adb51
> (packfile: introduce a new `struct packfile_store`, 2025-09-23). This
> struct is responsible for managing all of our access to packfiles and is
> used as one of the two sources of objects for the "files" source.
>
> Back when I introduced this structure I didn't have the clear vision yet
> that it will eventually also turn into a proper object database source,
> and how exactly that infrastructure will look like. Now though it's
> becoming increasingly clear that it does make sense to treat it just the
> same as any of our other ODB sources.
>
> The consequence is that the naming is now a bit out-of-date: it's just
> another source and will be turned into a proper `struct odb_source` over
> the next couple of commits, but it's not named accordingly.
>
> Rename the structure to `odb_source_packed` to align it with this goal
> and to bring it in line with the other sources we already have.
>

Looks good, I'm assuming we'll also rename drop some of the
`packfile_store_*` functions as things get cleaned up in the following
commits.

--000000000000153ff10653826fb0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: caa9cd3eaa8b65e9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vaTNGa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNytZQy8wVmpSbExFNkxTYkZiMWFxRVJqSXlaZVA4Ngo2Y1FTYjRUdDhs
Q09DV1VaSWJwelIvcnp3Z2o5T0RnZTJWZHk1QXpaOWF4R2JQZXBUNUxmTFlVT0tCbytXd0tMCkZ3
ZjVmVDBWd29IMHhnbUNibTZpS2VqdDgvWXlaSHFoVW13ZUdkRkVhQWhQWnBzOTltay9seUJhUU5T
SnhvU3AKeWJxbkVZU0xITGkrZVQxT3F0Y29EanlnZ0NKZERCbWJKR0p5bndVbzliWVVFeHFzVFVt
VDJFeUd4cmluZ0h0YgpuRlZiWXdIZDhVbFd4VUcwNVhReDU5RDVJc3NzQmVnSHg2YnVuWHZ0SXM4
TlUxUkp3YUJOZFYrMUoyN2ZvbUxBCi9ydEdwTkJEeWcxNkRpUUpYcEdWbnprSVJVS21ZRGJZTCtS
emFHUTFBMThzS2hiM3VjaEVUNmdxWUxlR002aEwKaGh6MmswU1BuU1hPMXl2NDF6WmViZXZHcWFZ
MGoyZVd2RE92YTdOMHFacm9QNEhQQnljNnY4M0VTMW9zSlZLMApPOTI2bDdURmw4T1VGUDNJU0xt
cFZsN0xPc1o1QVdJVDVYZjhBYWlLR25XVVN6d1NubGJaWFFtRjlUMTArbGthClFlQm45aDZWRVBV
Z2tKbnYxRnFrNTVOTUdLNENXaHJ2ZDRXSzRFOD0KPUdnblQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000153ff10653826fb0--
