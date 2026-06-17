Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C3A2E0925
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695070; cv=pass; b=P3wBge8FJGQr8RoQotr4NSn4fDAc53XyIbkumgUcjl1Mz3Q22NlhsA69dWAzNwvAuqURxxioKCZw4CjIA6CQ7uMHKOscCfydxbhf59wWDJZjiLZFj8LkQWnLmrTFIoUH3YrMudFvkqKaHyxKwwLcQNVEY+760sBj5SYBkIVKL74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695070; c=relaxed/simple;
	bh=e6992zX+6mF9mIt18QU/AHVMwm0epgv571XXwn7z6Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfINITVSfxC7uOi6OtuE4p638nuHdnrRS95Eg1rA0YOc7UhMkrIxHgrbCIjVQi1NfPDCTLq1izQBHKoGVS185wpZEP8joMUvl2x+5JUtxhJX4GXMd+UKa73OGpf9KDMI4Fx//+c5tK+BO+P+VABP1d5FRvFMkNsBvzKJLHtiti8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg/w0mJY; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg/w0mJY"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-693c69b97e7so6238133a12.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 04:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781695066; cv=none;
        d=google.com; s=arc-20240605;
        b=S6UsZNnObpikri/OR/OR1E3Q93QcsFe3GkCo+3gIv66yy8Pu9CPo64VmNCiKMctUpr
         yO3nP/WvI6heViQTKHAaFFi+SGrbmR6t4Qn1qAxbKNrst1rc6JiyvilAr60cXKAuqq9e
         5/JjbpOJt0bsY9j0W+SWB2LVymAPLIDAxEMpXwMY+mqp1EIE7KBNq4S5rmQtizRJz3fa
         x/kVRCgg8Ti3WrgWz/6OIy4hl3UM2kzc9C6ivPuEUPzonhdyiPPqATlG3/UmoP6q2vO1
         TJSOHkRBu0f38VObvmkihfjGVbxmIj4Ay3UoYucJa+T2UicQxJXz5diCYZBGfesj8995
         7nBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=70PveN+CpNEO5nJbOM98yKaOnV7ujBYxSBlCF4hu8Gk=;
        fh=8zPqm3g8k+VGDMIyt2dtE12ozvdD2LUvFPQG2W0oTXY=;
        b=codW/gIIcvaLuUjY6QI4KO7pW96q87qM8v2IooY6x7CCHy4V9Jiu/gAX1DDPXqIZ/m
         p/WkjWu5+Lwxz1NErh+cZp9bh6zyfWp9d6TUpqfEy1Knx5d2nORSdTeAhIrbdGOP4amA
         UiTLByygPEVn71uFDSMdd8wbUdpJsHJ+JwXlIadPzbCpjQpOMY6PMkOCC88zISAQ6Jkb
         gFzXjLnzMuGGS4STbHX1QCjvHpGRuSDl72MUMvhQDrs9hOGbighHERoBMmvmXjYQHntL
         Yc0y7P/bYqgqAH0QkWyiPrJceCwAP/E7bm+8uEok0GFIB4j6GrVhE775Ftoj2+/aJAvg
         Gu6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781695066; x=1782299866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70PveN+CpNEO5nJbOM98yKaOnV7ujBYxSBlCF4hu8Gk=;
        b=lg/w0mJYHQqN5BlPrGPGAvYLBYd+0zso6VPSFm+JG5vCh2B8ZJxwR59C8LS5f2PVLJ
         B+VwduL6bXmTaqBJRecbc8hRRpX6zw8dbPd0P+OMvl69kCQdpEkG91nkC5ODXu07y4sg
         1H+D45/p8YXwCkULJ0x7EAxUUhSiFs6qhovaxGto89M9RY5xBV8gUzIj1Cf+oDUhBtSo
         fnix7oharfvrSa2XoCUPydrcJQFDYk9mhneTJ+txbdSSUfS65ZTr60eTfOB5dZWTnlZb
         0NtutXgjqN6MRvnPZE2/iCiVPQZgDXiH/umOwbGzMR786fE+2aGeZJwrl9nKmSf82jpU
         aAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781695066; x=1782299866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=70PveN+CpNEO5nJbOM98yKaOnV7ujBYxSBlCF4hu8Gk=;
        b=hANmU74nWxFRGTMoA4l/Sf75FP/mXJpqbj76u4cYa3u1cNUCxyLkOWqjlhgG9u7P9X
         m1cnYT30UFNlzQCkq1RIMP31sMisfwytL1Tn5qY7dRtQ/sTRzUwyicHVZhNLO9avYUMp
         NKbXOQwdEZs847ryXaoxzW9CM3OZwSn+7kasbXJ1TnwlP0PKnK9fp7W6Bl3v5FACNmDb
         ItWfxfTtOqTjZGOCoDnBPghUP4L+2SB9axNafeVvXUSqoqfu8HTXmMGXvNwwndFpj0CM
         YhtuFl5HnKze/8T4guIEd146KG1WP0mc6i7EbzBXwBf0Z583ayhceuaQe5qVNYlAS0Lb
         NxmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0IZqo3B88/IUgps+TQ7p1ShiIQOvZ1e4P23WgBL6FuP6yjq5bo+usKZcbCK2yOpvdA4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSI+fAF6JHpYfJbi2aI/b3tEnGxk9qRDd/zVRIzfSjNLhqzq/l
	POu49vmLISB9f1hFwWuSJVH9DM1pZ0KSwpRkywgZ/UGKgeCfumpTKo+HB0BmNvvZjQULgPDCwsR
	5U0EgbjnS0lY/t3w13VaBa/QP92v4PfQ=
X-Gm-Gg: AfdE7cnTTmYPvrT20qWe8MxVx8Xeb71oeirBv4bGBpQ+cIU1WKy0bFnerZ1HBFjd7j/
	he84VV8XZW3b7QJaqU3CmkHv1p6D0J1jyuisZBfQCJ6UgFkUJpxebFqGFmPR7xo+9HzikYBuDv7
	X7xNLsumgBKAsGQI8HcSGjnRJEp3OV3CloZQDWI1d4AfJ0g7U7fJKzwHKXg0UE1w/1s+mprIuIc
	DNlmbd0eHOOwP6MFiIB0Oq3qvELgqmQwE9DfMUwxztgcTYsr2C+ymj/UpxxH+Pof9O3bjmC
X-Received: by 2002:a05:6402:5288:b0:674:5b2c:d42c with SMTP id
 4fb4d7f45d1cf-69546fe3b4bmr1895725a12.3.1781695065656; Wed, 17 Jun 2026
 04:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com> <f68e2a11-02a5-47b9-a01a-458eba821c37@gmail.com>
In-Reply-To: <f68e2a11-02a5-47b9-a01a-458eba821c37@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 17 Jun 2026 13:17:08 +0200
X-Gm-Features: AVVi8CdsTlFtmy7RHCd73u4ebTKTZdTgz1Y3izeLtEXXvjlU0luCwLmB8v1mqHo
Message-ID: <CAHwyqnXRo=P5Zihs6s7Uh8CrYCO7mjyeZ5nAv9JqYbGH0RE72g@mail.gmail.com>
Subject: Re: [PATCH v15 0/7] branch: delete-merged
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 12:01=E2=80=AFPM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> Hi Harald
>
> Our SubmittingPatches documentation recommends waiting for the
> discussion to settle before sending a new version. When you know someone
> is going send more comments on a series it is a good idea to wait for
> them before sending a new version to avoid too much churn on the list
> which makes it hard for people to keep up. I'm not going to read this
> version in detail because I know another version will be needed but I
> did spot a couple of things in the summary below.

Got it. I think I am waiting a fair bit between sending new versions.
My last version here was 2 days ago.

> Not changing force sounds like a bad idea. The whole point of unpacking
> the flags at the start of the function is to avoid accidental
> regressions. Unpacking the flags into separate variables means the rest
> of the function does not need to know that the function arguments have
> changed.

My reason for keeping it like this was to avoid the slightly awkward
double re-assignment of both flag and boolean:

```
case FILTER_REFS_REMOTES:
...
    flags |=3D DELETE_BRANCH_FORCE;
    force =3D true;
```

But your way is likely still better, because the definitions at the
top of the function are clearer.


Harald
