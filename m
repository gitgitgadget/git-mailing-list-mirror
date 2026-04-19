Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516F10F1
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776558382; cv=pass; b=cSMtQEeo1lvsxLkbJB8zJnkNngvWXUxunKYR0EH4Xq0mkw26v6bdpHc/XC9YS++pA6sgvxoTVnd22u6oIxlE5DkN419LAfycosEDmJhh8yKTMpeIw7epirfp/IIfD+yCVDtVNp2litNdigwd9d3L4FquSyUvgUeBkDNZ5VNvX2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776558382; c=relaxed/simple;
	bh=lX9TSLf/9tPHJMpCLoEyk1j0TQuPJqbMflrFoErZEYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDcnY+d2e7g397tKiVOvePaHpenRGxHhwQP8HWkbGHI0Uwb2s0PkscSr99wYvimRVsKiQJXnfh84JhTozzbGcZfOPEDVoZHDW6GUtCvoiTWrW+7TrY+xGXd4DIeJroGK/W3clB22hogCVRnuV2LCy8GdRUm6OWInp6uobVwvHeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+O+cBHf; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+O+cBHf"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2addb31945aso12672385ad.1
        for <git@vger.kernel.org>; Sat, 18 Apr 2026 17:26:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776558381; cv=none;
        d=google.com; s=arc-20240605;
        b=jfCexnvj8U2Ns+T6LCrcxFXOEOisjhllscxtlNia4coNWJjzcFoUaeTS3056LGFObw
         dyfntldQh2Udy4JXylfI8cFwW1L1efCKXztpSR3Quk2LawHLndXdBcYTSvKr0jJildUe
         BWya9lywOK2V5GZ/mH6dbLPAiFYf7IbeaXjAIHCc4d/u5+eA/BEUnjaLJaACxJ0c8gNV
         RkYPBT3V91OmbBw9SMWtZ7z4EmkAAqc9xeYjvURrX5GnlbiWjfRwrTjwmPxFLmF7T20f
         MfJ0hNuwEd+kZ1t68Ewgat0J3wk1rwizyAi+FqCFbM/e7XVS8nEZj0dESXyUAZI2z5oP
         gAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bucV3vk1WRivYaBOKato2Okv5S09j3dNZ9J0uXRWyBY=;
        fh=SlejNgZhDGxYE3RoeDx16OjaGxHLTwSxXQ+/jdvn8IE=;
        b=YkI/JAx3u6hqmMNUNgPro+eokEYwr278226rM9JQcSwStLGxJBuTSwax9tYQFNgwz0
         7DUi2SyWmzBertBPYGGxv2PV/bamhcMvFJVZfvwkpDgf0IO9cYxY4/1zCrOcjmXuln/k
         O8ceivwPqC9Ghpstf2n148B+WjJ1ejvIHDeTaET4juLhmY8B7EwINmQVaCV/LbJwZyeH
         TYRdesZnAXE3Dpgjun/VSHQXupic4nvuwH6Oz1RzElEN8RtxhbmBsqN2i8yfC6FnSQne
         CluOMw8C4Px6dETFEFbfJYr2sPNjwpzRWoCJ0MlZpbjYO897SG5iWCOzB/r7LZL9d2LQ
         /cjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776558381; x=1777163181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bucV3vk1WRivYaBOKato2Okv5S09j3dNZ9J0uXRWyBY=;
        b=Z+O+cBHfUC88yTk01M5b+Zu/gFxvURF+ZBGva/l9I0b+qkqkMaCLS6egkPEgsw3NO1
         OCwccVTn+rDTJr0e7cF0PGt5L78cEPyRNCBWJbrlt8q8e/h+6pI+TeYmf8R9va1TCH1l
         NHuumeHVoqi55npSoey/UejQpXvncWrc4TzkVIURMmsfhlhaXi5wfMl+n1vEXo2Ulm7w
         yiMalNqEs9q3buLuBtdVzIVK7mO2+sxD2dRyC7sb068Aq6CgJDS9o9n815jVLnza+cX9
         dHS4rT26/Msas8ytCyakioaBm3poqg6dHV3iWrLLpwZ2VrM+H7GLQgd1fMTiX5y7Dlyt
         YbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776558381; x=1777163181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bucV3vk1WRivYaBOKato2Okv5S09j3dNZ9J0uXRWyBY=;
        b=M5W5vF0n2UVSrDz2Ls4DHGATl2Voll+CK3FkCQ9Yh89Tu4iKInbtTgGrmTWMcQdqqC
         8oJmtFaBLG6e9bfH/9exfnRMYD0p8qbu9m6plprBFcqnXc5P2DLn7MCOrDyWPysSHMW6
         3ssSSuM46OvUYKLbkxwywZpEDD56DAX7Tl/VboXhfJM0/ICuIBOUI9cIut9LpSoTghIv
         TBbp/MhtLtxUPWa7JBr638/9iDG2snbtbczcVT9uVyqSB2CY/lb8tZymgqb8RRnVdpp8
         qAUDAhrzeZdH3/eXpM93mRi9cuy3bsQTPwvRlE1TdeeAKpx6sTbiJvTOz6+8UkTStA1S
         YR+g==
X-Gm-Message-State: AOJu0Yw4j9Gt4k3g7xvzAu0ocu3TvzpnP10tZpXfVJFlnJtPW277H+sg
	woFnA7k/O5x4M4m7Qjt5+2Huy6frfFiXpp6ZTGfJvyCG8gqbRqKlpzy/EFyhB//Bx7HkdM1sX5Q
	1iU2YGLXZ4xVCmG9dOtda8zyv1BO7BMk=
X-Gm-Gg: AeBDiesfEWQWZLXwIVYQm0m0lAIsOY/noesQeLsNqmwP2B3j80MvsI/oiIYIiDJJN8q
	612AI8LrVpXZCoWXGIm1jyv6EQmBZz/6slLqovBatg9fM+y9OTdc1LeZ2uKnP/aRyOUztV0N5G6
	/Hgly6tpJkTp8yhoj8tYv26GqkFCsouXlciyrLL+ah9JMRFvnBpS6qR5M2R7qrvgZy6uham04Yx
	TsS3KrJomsVs/ZcXps2e5qaK6bzPAHjwA0BcVlmzxEnnsDvrGVU3lvXjWnysnCLhiQveFbEMiij
	91teYasx20hUk9DNHvKb5WpkNs/DE7zzRZl+3MnBqUPS+Y08kxw2fMhriv9RpzUanHkzzR/iMtr
	9m54m4iRgaw+UAV6sRYUCFsvthK8C2E0FHTZ/
X-Received: by 2002:a17:902:ff04:b0:2b4:5d87:a207 with SMTP id
 d9443c01a7336-2b5f9f64174mr70307685ad.30.1776558381090; Sat, 18 Apr 2026
 17:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776124588.git.me@ttaylorr.com> <1b0f7295c21bf6240bef975e5f3fb9da685f29d3.1776124589.git.me@ttaylorr.com>
In-Reply-To: <1b0f7295c21bf6240bef975e5f3fb9da685f29d3.1776124589.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 18 Apr 2026 17:26:08 -0700
X-Gm-Features: AQROBzD8D3YqoReNP46r0_rF0YKp3rhRnr9RvZ3AMwltVrdky_AbceysgfKfxhQ
Message-ID: <CABPp-BH2Zsf03DT8MOtCn=3Sn=Tz_7MF1VwosPjVLdAGo42OCA@mail.gmail.com>
Subject: Re: [PATCH 7/8] pack-bitmap: reject pseudo-merge "sampleRate" of 0
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 4:56=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> The "bitmapPseudoMerge.*.sampleRate" configuration controls what
> fraction of unstable commits are included in each pseudo-merge group.
> The config validation accepts values in the range `[0, 1]`, but a value
> of exactly 0 causes a division by zero in `select_pseudo_merges_1()`:
>
>     if (j % (uint32_t)(1.0 / group->sample_rate))
>
> When `sample_rate` is 0, `1.0 / 0.0` produces `+inf`, and casting
> infinity to `uint32_t` is undefined behavior in C. On most platforms
> this yields 0, making the subsequent modulo operation (`j % 0`) a
> fatal arithmetic trap.
>
> This path was not previously reachable because an earlier bug caused
> all pseudo-merge candidates to be classified as "stable" (where the
> sampling rate is not used), regardless of their actual commit date. Now
> that the date classification is fixed, the unstable path is exercised
> and the division by zero can fire.
>
> Fix this by changing the validation to require a strict lower bound and
> thus reject 0.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pseudo-merge.c                  | 4 ++--
>  t/t5333-pseudo-merge-bitmaps.sh | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/pseudo-merge.c b/pseudo-merge.c
> index d79e5fb649a..75bed043602 100644
> --- a/pseudo-merge.c
> +++ b/pseudo-merge.c
> @@ -169,8 +169,8 @@ static int pseudo_merge_config(const char *var, const=
 char *value,
>                 }
>         } else if (!strcmp(key, "samplerate")) {
>                 group->sample_rate =3D git_config_double(var, value, ctx-=
>kvi);
> -               if (!(0 <=3D group->sample_rate && group->sample_rate <=
=3D 1)) {
> -                       warning(_("%s must be between 0 and 1, using defa=
ult"), var);
> +               if (!(0 < group->sample_rate && group->sample_rate <=3D 1=
)) {
> +                       warning(_("%s must be between 0 (exclusive) and 1=
, using default"), var);

The documentation for `bitmapPseudoMerge.<name>.sampleRate` in
Documentation/config/bitmap-pseudo-merge.adoc still claims that 0 is
allowed; should that be fixed as part of this patch?

Also:

```
$ git grep -B 4 -i samplerate.*=3D
Documentation/gitpacking.adoc-[bitmapPseudoMerge "all"]
Documentation/gitpacking.adoc-  pattern =3D "refs/"
Documentation/gitpacking.adoc-  threshold =3D now
Documentation/gitpacking.adoc-  stableThreshold =3D never
Documentation/gitpacking.adoc:  sampleRate =3D 100
--
Documentation/gitpacking.adoc-[bitmapPseudoMerge "all"]
Documentation/gitpacking.adoc-  pattern =3D "refs/virtual/([0-9]+)/(heads|t=
ags)/"
Documentation/gitpacking.adoc-  threshold =3D now
Documentation/gitpacking.adoc-  stableThreshold =3D never
Documentation/gitpacking.adoc:  sampleRate =3D 100
```

Should those sampleRates be fixed?
