Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6178C322DC4
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480897; cv=none; b=P8b0ZFv1XJBLXQnrcvHnqUkk3mIlHCtmIBHMgJ76F9koIc2/2ozhpPZoYiKvCifyVFjwtKZSIjeGKfex6Sc7VYgDCDX0dGJdsZkhqarTPXOeBTIlbuj1ezDA44GOXpfvVMN/iVg9iKnChPcgwihAgLq77J+9Tq0aKIvg6fgfsC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480897; c=relaxed/simple;
	bh=gM0Tu/9QLQC2+k+ZWPlG6XqojYs8z2ImH6e8TmYxu3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRi6KiN4nGRO5m+nRQ0uwHDx5BqVNCoNN5NscYtbAxsijJ+yue8kiFhLROomPfCp82zhIIDqzsE693m64VsSdS+NM+XneWaSfLKoxlMyPPgHM61PoS/wIXtSytF6C6B4Z9cLypib5lIzd2MMYtGt8i4tX4q8SrXp6+8i7avNgCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oxlx1fzp; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oxlx1fzp"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-88432d8fdd6so100900839f.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756480895; x=1757085695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7RbWz1oU+xDptzUsGdyJDdifSifIzujUpkKQThrU8k=;
        b=Oxlx1fzpsBk3aOBsp4Xz9SzrGltZKxJ7BmL0K6nGIFnWcy5izNJh7i6G7CVXsPM72q
         DIYQQR4ekEXGI6WXWCUm+5z34RnweTMhVOS2dW6HPsE4CSwgRkSoULAEzcmqsfensBv4
         nHiq0gJDLUbzx1OPo3LuVs4u+JRIAddEEyUQId77U5mkdwATrajKwY60tV5dPnKvKKJD
         DoahwVh8ozRuHrpT/kwff1kOxeJrmHvtZZd9QH1KTcEkQ4oeF6DHK1oj6a47VtlDplm8
         LLtFBmrPf8o4o0Zrv04hNivXGnusrUB80SNoHbI/MeZGPxxACrmSDL8F1pWAkZk2jiSR
         5asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756480895; x=1757085695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7RbWz1oU+xDptzUsGdyJDdifSifIzujUpkKQThrU8k=;
        b=IJXxetpMHYttCUkDiky/HKQExXN2pJNmPgs89iJQkMyna7bcTr9Ji5uZqVgaurdjAj
         +xtFK4LjP1RG+B7QIyBptwUbVD3o5kw9rgLR7siTJsaMhU7+nKH9zMNSf3y3gkM/xVi0
         Fw4vsHb66dzS1XL6xBxVm1hmzyaU9cPON8SJsPqrB/k8baBx4vCw32Q3ceWstn6eUiyr
         z06FoN9zmgmiXKW9n+YgwY0olV6/QvwnJJrGjATvuToeHdHyPXPUwxU7B93EwKlwS2//
         svQ5PmUZL4+anVT7ilKys8IY2OkucumkDo92KoJjVwPpd8k/elAfP1ivDZN3+WtjBnPm
         NU8g==
X-Gm-Message-State: AOJu0Ywh61ohb6tIdWAFNpehAXjQwxXBt8o4NYK43SN0ncdl44i2OPZY
	Zw8U9Z2OTgmm5F784loGTTssO5+HpaCrvk+w+sam//l5NcH9mmOplnhbYcBidestqtVOkvcH+dC
	FXwzftYiRKWKTqip3Cn3L0gJgrXQ2oyk=
X-Gm-Gg: ASbGncviWyZZ00OuYXIoUHdxJhM2Qqa0crr5RLGyP2cMeNm6pObwZ7zDRFya9xnFElB
	2LoAd9YsYdqVlQaPZPRdUbcSzk1K9CONgjUzBp5jm0x8FVQlIwl37E6vhsLliUouujd6VjknYmj
	dY3SxS52BbemMV38zcC1sDOiFsBJmzJ0wPRQ7oLA7LNsc8qlNt88ysNVBg5GTYsC3EvOSIPzjif
	2AyN1LIP25y0TvQGVqLgz6PJT7RHHUgL01lqkeIwoFmAMsMQw==
X-Google-Smtp-Source: AGHT+IFbnwaXLE8gR1ljUzUoxIKHcgMp9svXvQNJVtAAcWZkWdxezt5tKhRhNC20d/dQ5SY4TaclKeIFN3YrnVXge6U=
X-Received: by 2002:a05:6e02:b25:b0:3f3:5ee1:3c83 with SMTP id
 e9e14a558f8ab-3f35ee13ce4mr20359975ab.11.1756480895295; Fri, 29 Aug 2025
 08:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1958.v2.git.1756370289.gitgitgadget@gmail.com> <pull.1958.v3.git.1756465231183.gitgitgadget@gmail.com>
In-Reply-To: <pull.1958.v3.git.1756465231183.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 29 Aug 2025 08:21:24 -0700
X-Gm-Features: Ac12FXyOJSaoSamsleZJ5kAlsbO5EYCcg7GlV4vRbR-qoLyVM7tzCWFG0nwgYYk
Message-ID: <CABPp-BHnCHiTFNKCrnpKF5STkeGNQWMxdVMZ_v-Rp2judZVEgw@mail.gmail.com>
Subject: Re: [PATCH v3] range-diff: add configurable memory limit for cost matrix
To: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Paulo Casaretto <pcasaretto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 4:00=E2=80=AFAM Paulo Casaretto via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> -
> -       ALLOC_ARRAY(cost, st_mult(n, n));
> +       size_t cost_size =3D st_mult(n, n);
> +       size_t cost_bytes =3D st_mult(sizeof(int), cost_size);
> +       if (cost_bytes >=3D max_memory) {
> +               struct strbuf cost_str =3D STRBUF_INIT;
> +               struct strbuf max_str =3D STRBUF_INIT;
> +               strbuf_humanise_bytes(&cost_str, cost_bytes);
> +               strbuf_humanise_bytes(&max_str, max_memory);
> +               die(_("range-diff: unable to compute the range-diff, sinc=
e it "
> +                     "exceeds the maximum memory for the cost matrix: %s=
 "
> +                     "(%"PRIuMAX" bytes) needed, %s (%"PRIuMAX" bytes) a=
vailable"),
> +                   cost_str.buf, (uintmax_t)cost_bytes, max_str.buf, (ui=
ntmax_t)max_memory);
> +       }
> +       ALLOC_ARRAY(cost, cost_size);
>         ALLOC_ARRAY(a2b, n);
>         ALLOC_ARRAY(b2a, n);
>

This still has the same wording issue that I commented on in v2:
https://lore.kernel.org/git/CABPp-BEDje5dYZHEyYMN6j_LdR5CqRN1cxc0riRK06qK-O=
xiTA@mail.gmail.com/
