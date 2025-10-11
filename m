Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD9CAD24
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760174477; cv=none; b=Ndz3mwcyfQpHd7BQXsIiYczyY/GdGK7laYwk8UZgFd1LXY88iHYzm5kqhIFGTOR09VAfUIg+GdEfX+hO+NdAq3yQjFADafJ63bJilLd+fo8NQ+XunZiCaRzbekQ9O5iuRlbtQ7h3Nv9TNq0f2Dd26X9JsbgKijvXJQPhKy+c0xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760174477; c=relaxed/simple;
	bh=DQoFFoCkekrfNhCg/za/t8lcP0QcVqiHJTZtJEFkAtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDlgZBtBpkNs1/imsWphm27zubPC2pFQDgWZ76M/NPEZRLRdcDS1cc8N92Uc0hqHoE31QD+mLyOg8Rk4ydts/ZUWZaTYM716wS1hz/zRv9QN/mlnbekiaWmg/zf/lQCc1sDzN4U0MF0tvtHQsZzes+ii5MLiLw12XZV9DQ0hXl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2haiVEU; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2haiVEU"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-904d71faab6so2394674241.1
        for <git@vger.kernel.org>; Sat, 11 Oct 2025 02:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760174471; x=1760779271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHCvM82bUv9I+Z4PVKXlLQULl6tWwNSrBti9/Wa5Z40=;
        b=N2haiVEUfv+ji43Fyvw0vuBkZN/cnAycMDAkeX9CRF6UU4+mJHC6TrEKnxfrsZzbXy
         a3oCj1C8vpOd4rvROle3sDVFvfmWf+vFcY+P4UfNjLOr5Hb3o85525mOaFm1re/ikef2
         d5H2cWdnZvcNClQ8destYqZj3lXLxqbHQAPyT1Kpf4oZ8SI8kw5SjbHSV6g9i3yw4BJA
         MmNv8mbGgQOD0rRzNHi7RYC7Y6EQ7QDh9mTaq40GK/ziuHjvs1lQ1+ktxO4QS18rdfXm
         SUTTZBfNPD0NthjoKGMrLa1TxA1eTh5r1GR3zQEJB8SufoM4+XWOhjRf0xDft8w0RXc9
         2lEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760174471; x=1760779271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHCvM82bUv9I+Z4PVKXlLQULl6tWwNSrBti9/Wa5Z40=;
        b=nAim/r1DunHPU9MIHbw8YyeRNXI0lwrRT/b4tA5CH3G/kZo6z3Nhb9jUNCCkKQOUrz
         UIfBlZoaKwfWbiouHV3Yhw6gj2tEmC06pZzQO0bByyUGbkj1/CYD76TPpPY1909RRHvD
         bA251ZUwLTzQUHEIy4SE7sZ1TS0qwzxlpCfYXi8qGuCzM4o6XtH8dBDGBX09MtxXrN7t
         miWOFPc2CMYUxIDFmvZw5kvdT7+ujyBLh5ljvFqSE1qNNrX13x4Ccm/jNGQOVdrl35AV
         It07FcBLzkB0+BnpWUtAPWr+ANbAR35Ap+840IID9Z0wY6MaxKZ3QrrxFTfcNy+ExEUr
         o/zQ==
X-Gm-Message-State: AOJu0YyL2lYWvtO1A/fRKpRGkzqS5i1RiFyFcLROMfos5JU/2EkOFOys
	PAvdfdcDXHZi/QMFonqJLV6V3eyUQT2+Uo3zM7ksKvc0fua/donVeotJVggP0ZbMg3cnpzxfUQU
	7Iulu/Eu028Ti97nkxnLa3eVahpJJmosbbzEmUcgfkg==
X-Gm-Gg: ASbGnct0/QtBMbg5xCkeGFWcX2+WCQDtSd99p0XblldI46eaQKPHH7ivlRhdGYLKII+
	kZh5/D7lVRloK6cH5XOAU9xu7yzLU8qHFAfW7gA974P44PryUEmtpEJ+slJuvlaU4KjZsCAEDUm
	u0/m512MOkwdnRqWzA14KecihfYQ/X7rdL0+VaSuXuVd+UFJzm3asLNY7bmyI0RKznJ11Pv230L
	KS3ZPIBY0y93pFQ1B9VBmEJL6jrofWjVCe/E2rmMl8ePIbWlZ5aWIp6C1IbNHW5lCwn
X-Google-Smtp-Source: AGHT+IE4zvLF3R9Y+vi/aCKZRN12fZpMBTOjKL376TnUL2obapDe9nsaCmZu6CuIIC1u9W4bR4qby+tbV+OKdsVVxsc=
X-Received: by 2002:a05:6102:2ac3:b0:5d5:d1e1:73e8 with SMTP id
 ada2fe7eead31-5d5e2204172mr6772294137.13.1760174471497; Sat, 11 Oct 2025
 02:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010233303.783212-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20251010233303.783212-1-okhuomonajayi54@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 11 Oct 2025 14:51:00 +0530
X-Gm-Features: AS18NWBcCLvanfTbzU4LFivVE9CZ1dAeHCrepCWC1IlBkApVVDr_LI5BQggPjhM
Message-ID: <CAPSxiM-p_wVTe=a2fYSppcvbXxrOpqC5GotQ-5NYFh57+W8+bg@mail.gmail.com>
Subject: Re: [PATCH] [Outreachy] commit.c: remove leftover comment
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 5:04=E2=80=AFAM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
>  commit.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 16d91b2bfc..af20ca7c3d 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -475,10 +475,9 @@ int parse_commit_buffer(struct repository *r, struct=
 commit *item, const void *b
>         if (item->object.parsed)
>                 return 0;
>         /*
> -        * Presumably this is leftover from an earlier failed parse;
> -        * clear it out in preparation for us re-parsing (we'll hit the
> -        * same error, but that's good, since it lets our caller know
> -        * the result cannot be trusted.
> +        * Reset the parent list before re-parsing to ensure a clear
> +        * commit state. This avoids carrying over data from a previous
> +        * incomplete or invalid parse.
>          */
>         free_commit_list(item->parents);
>         item->parents =3D NULL;
> --
> 2.43.0
>
In one of your previous patches, Junio said and I quote:

"And the proposed commit log message should describe what the problem
is, why it matters, and how the updated code is better than the
current state of the code."

This is very important when sending a patch to the Git mailing list.
Your patches are not complete without it. You can check previous
patches to see how it is being done by other contributors.

>
