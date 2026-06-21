Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97878F2E
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 05:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782020297; cv=pass; b=eGdWDhIpRUVpZaFL2xPN5MnyCkYUhQ+r9R1Z8NcB4CEWoSdecK1Nr11SqyXHBsff3RJdLi4ara4jJebAUxUkIzT59/NrCZX7S6O8QMpr4vaIJfiv38XErkuT2QQkm6eHHkNlM2Of28QQLd9D1JdRfUuJkegqtvSbG/0DwQCXvZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782020297; c=relaxed/simple;
	bh=JIUHB5l9jp2GNnhzdUwUd7ZPZzp0En4Bibv6BWxtt5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3zuKAOTJ+rEsrAQ4/WGz55UIYabaKfvmqVT8A2TH8uhjcUzj8BdLiloij0gkY1zlAc9bvPvP2/H/26RgQJ/W1XhHti5/QsRn6QjsQco8wcIZeUFFtQDO9sbMpjvSwF7HynGDyj1frfQlITVNhS7mZcQyIwzsBKsQeo5u3mQlZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+FxK0HW; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+FxK0HW"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6978f80deb3so406546a12.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 22:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782020294; cv=none;
        d=google.com; s=arc-20240605;
        b=CKs9BTL2rVLuM/WvRPU+dlbOVrjU7F6cK3QkArc1dUsJmvSraUnAFGK6y3Sa2PJvC8
         goBVTf2BDtrUlTcUdmZ9d2dP1p2KamudMMTNAa8d8PYyw47FyokjDoFmw4dNdmwNrpLi
         E5rOVMCltlu366GaPmSzlWnbEm7esTEvP6Lm3SO1vBHKCX3uGHqptU0yjYzl34jc6kmv
         m88inWIHQHVG2w1upQRal69hwnl9JPFPhsAyJsC7G/QY1M6vHheKULuxZ4DglKGgDNzy
         90jE5qGa3lLPoqVAJsWaUuWkALCqCAK9JkiGSgeEfisU0WyXK+T/cM+y5EVzYy2UFMJF
         A6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UIgmnM/WBq9uBetRjy1p2zK07X24bunFSWEco+fNyOc=;
        fh=DJe2SkLD011JINA8mBerFIKKdM44MEICMB/sj95jGLk=;
        b=WAG4v/6pDgDQ0Q85QXpG67/oi1Aj+TdqjZp5z83MO4E0U4lkbiLhWK/ZAwhHywTbBp
         R4l01B5azVcV+jgO5jdWJ7nPqLWt0PzRFguDxQGuVbY97muCt8v5nqJ/2Kiknv/ttzEQ
         0QuhKh2lMlpRy5k2iPNTD/bbgCWlWv077xSSK1ItlZ915YPNeYtW+1j/K4KVK8Dl8k+P
         dUNn0GZv4vYy1JYxIlMCMXfUfPcYPZKGM+MyJ+BbFRu6fOeGar/FlskrEsGr6KHT6LcM
         qDhOoO8glszh0RahM7nuvjQfe1auitp66Lo6U6U2ge46lyGYISBaqwkLfohxYtxsrVJO
         fr8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782020294; x=1782625094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UIgmnM/WBq9uBetRjy1p2zK07X24bunFSWEco+fNyOc=;
        b=M+FxK0HW9ehEGtX8g3GFswUxvLQWAGYmibjJndbZjU7/Rph7cMoF5njXeURA+dPmvn
         J0Tyr6BrVWMTFPUdItVrU3Hqshh7CFeaUrODJ7ClV0lcl6eLvqJDh3eYwo51QFe+ixbe
         CSWf9WpxSb0a/72/uirBGVe0zzjG+sUli2+Eu9d+GznDC0HJ63uLJ1byXr7euJUU1g0X
         AxhQZsqmvHYzBXDNPDwLmYKeH5YGHBhoZiV1ZVRbtp8SOJS5CgqC3SB50F7pnkMK4UFL
         x834oVYa5ZIaiuzoEaH8tTMU1scuBh/RKLy6KGlupuMLoOlqefLt5e9VyhbwZKJrgyYo
         LmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782020294; x=1782625094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIgmnM/WBq9uBetRjy1p2zK07X24bunFSWEco+fNyOc=;
        b=KYRmYeD/JfSUlo5ja5YHL2gvCpjh6l0/85z2YjUwJ+mHFuqiU30MgjL4eD1tA7vC8m
         cp7nXnC1KW6RkubrqurBr7UDHe+TcanEqVDy7H7DoVyT+EXMpoYTi/+nNcA+fWDsugKk
         oe3HQenPctT4mBJfIjDf4NW1DcU1t3RxaFwnFALI/FdoHg/ytUAyeXzBrcaqyumymTLR
         rJWERJBeDIs86YR5DgU+qMES+0lVoxeHsU3N/lmkwDJqLBlq5tKcAYu1wOaYGEmarMD7
         rQzdP5lIXMYRhtsfmiWjaLl4+XYcEAAof4CSlyHFEC7Bc46btK0RmsfqS2kTt3CzgFP6
         /sAA==
X-Forwarded-Encrypted: i=1; AFNElJ8ndsLJaLvFLF/XKdzPdS1UfU7UI3X7AvvkI68NSJE6TOnUjo/+iixrRpgwzktEBm7pbMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkoreGK1clPXolwxax/yW2kAYwRAmsQqNnXvACaEp1YZD4497m
	n3SazOfz9lGWcMS26jOH+6a4Ci5nMOF1HMl+FpDiCRMLq0vccGNbFkvQc0fj1imWEAz36zN4aRK
	oRsZ2L6ngT4MKe6NUO/Sfe+DQ0cStAlc=
X-Gm-Gg: AfdE7cmPBwC3T6XEMsSl2C1zCZ9ova/OWc/vxp9WOHx6tzJz9eoAEg0WB7xRJKngEXr
	3aWhrlJJfq5f/Iby2v6POwTdnR0jLOY+dJ+QuUHs4EuPuDJ4sXA0zZ9ag+Fkw45U8HR5uGQmpeW
	yOU02n95FQXh0RmdWayDDfZ9gAUsGUMXkYRLB1UE1l5fF6Dx42XSysajpSGfJwBORjxehuwc8AE
	mTlNg7S0ICICYi0rNolCpC3ZED4AZ0qBx344Jo5RdqH7M1VepP1iZmZsacH7zxG67/nzhXj2LkG
	/VfPuvR1g6AT7HV5WDsBsIoHwunsep46ZKTBnuOg77ysqkOzRZXpS7s9e7F8v7MkGGbRLtrKh1D
	7vPj4+i1yUuqwqW8m51XP
X-Received: by 2002:a05:6402:5289:b0:695:53d1:7b8a with SMTP id
 4fb4d7f45d1cf-69711e02d18mr5065689a12.22.1782020294323; Sat, 20 Jun 2026
 22:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com> <20260619-ps-eric-work-rebase-v13-5-3d4c7315d2f8@gmail.com>
In-Reply-To: <20260619-ps-eric-work-rebase-v13-5-3d4c7315d2f8@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sun, 21 Jun 2026 11:07:47 +0530
X-Gm-Features: AVVi8Cf5KIwzgyJBM_lp9ltnSsXzWboBXMFztPKfBLOo2J8kaNztfeT3ezrVrhY
Message-ID: <CA+J6zkQEqTeNWkHJWDD6MmK4hesKofBVobDt9OcQ-FSVLC28pw@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v13 05/12] fetch-pack: move function to connect.c
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, eric.peijian@gmail.com, 
	chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	karthik.188@gmail.com, toon@iotcl.com, 
	Jonathan Tan <jonathantanmy@google.com>, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jun 2026 at 20:26, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> write_fetch_command_and_capabilities will be refactored in a subsequent

Nit: the rest of this patch's body referes to this function as:
`write_fetch_command_and_capabilities()`

Let's use that here as well.

> commit where it will become a more general-purpose function, making it
> more accessible to additional commands in the future.
>
> To move `write_fetch_command_and_capabilities()` to `connect.c`, we need
> to adjust how `advertise_sid` is managed. Previously in `fetch_pack.c`,
> `advertise_sid` was a static variable, modified using
> `repo_config_get_bool()`.
>
> In `connect.c`, we now initialize `advertise_sid` at the begining by
> directly using `repo_config_get_bool()`. This change is safe because:
>
> In the original `fetch-pack.c` code, there are only two places that write
> `advertise_sid`:
>
> 1. In function `do_fetch_pack()`:
>         if (!sever_supports("session_id"))

s/sever/server

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

Nit: this is a better patch header than "move function to connect.c",
since it better describes the exact change we intend to make.

Let's use it instead.
