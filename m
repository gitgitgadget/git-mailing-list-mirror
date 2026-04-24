Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E7633E7
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776998897; cv=pass; b=bz38l2A/+XKai5a18vPV1My2/e8VTjkKzbvJ7lMYyNfYdEj6V0U5XauVKiTcmgRstsspu+p6g9TnG+i9XuLVBBoY8MguqzYL0XhK05WUBWmILKadAX3gtjBmqSc4F4I0zFhCwOEGtF5FgCRYqgZ4vGPOLsV1qmTlh3F86fG001s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776998897; c=relaxed/simple;
	bh=GlcMsPHcgN9W2YK6pVtjH9Qg0xzCU/ZqZBdyDOeEwec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NslET/Pbl0ua6mP8g0zr5nvEEQZszvOcW8EfuzwHgtjHA7w/2am6eRSL5DGB8Bxt1x589ET/vF1B06l0G0jwK9lBtfSpsCUA5wY0M7C1//yRxsH5U+oPZB965HB0QQqMRMa3LO6ype4QcB4em1s60wMgfsLYEELDGrV7SwCqYIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a40cfab24dso7695694e87.2
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 19:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776998895; cv=none;
        d=google.com; s=arc-20240605;
        b=jdbxu8K2Y5V6y3wuTPEtURUVe/ZuI3y3m8SOTaPg02kumWIs64P+SdT3r3Ol7HNvtf
         bDQdFWkAJlXLeVKqCz8IEGb9kKCkn4pPjZfLkaRbu+e/4vMLJSsFQsZGVECGx3e1amD1
         p8iNtYDU5qJ+feJLrAtXnCXQWq+jBvfI9Lxunj+9LC9eP2LDOenAgZqJfz9jjOxpcaj/
         hAAiZkvb59M7p1J6m6Tls9iffj6zEo0skO/LEbd9mea1OEzaAh49VtqL9Q0FWvPNyGjj
         OMqWVxqPr0Dit6D7/cHfGV821w/eQNbgsYH7zOy7RGeSqdlmrTkov2bRdNLHZZY3tGO0
         RNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=yOCbEz4pJenamMKAN280ZqOJPwxAM/sw+curN6BNogc=;
        fh=3JU/BKPb0KH1tYyi95+GJEmVCpeM8u8SG8/PjvzRvkk=;
        b=BmanlvHEaymTAND7EkhxDkRkdwJ74cHeO78jZezbV3dXsXytpU92vvWIQrdErbeZux
         Vpfouo3pBfKgaGTXyKifhVxqEm7yYl1JvkEHqrCXscsdcGfg/YPmJIaK5vCN2WExMFKz
         NVepOwX7JORbDd10AaGzs4LDsbCplqzTE7wgFPkO4pC1ZWuPUz4J3AjvrQw9RBDUTDp6
         AlTDdvbM7RPpFVqaRgeoKsCRHYINTwZsDX9OG7Z+tVD0W+Td2YyXGx7eqBZaFpHW2Yau
         GHNguY9fgTcS8Hlhsf1MoWV7MWL4mjPJSrFVhImT50HZpvF4m9dunJthNW25KfEg2wiY
         ijYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776998895; x=1777603695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yOCbEz4pJenamMKAN280ZqOJPwxAM/sw+curN6BNogc=;
        b=iUI77z4W1RqgGTlj9ppaJdH7cZapEQpzt9FWLgxhhwccZ8TvyVssjijZfB+635Nayy
         YYUXpDO+vKMK2tKYwDseO6HARVEkZzDDGaxop/FAVcN51L3iQx+MB4wTrFqh2uZumXzd
         ZpQC0Xrgt1MVUihUaiZ1nJM7bkoMOugU2l+AZnRP59ahLCRucfixDkr0IrSpDfRq3WJJ
         jMVeh9t5Fs+zEKWU3ndGgPKFFNDsi3ULu/vliReKQZCkY5lW1meQbJUg0q/9NmfeJ2nE
         q2UYpjK7Ihba0Y0lkI4et/H7PHtafXKXzOTrXz3yRk6fuDYYPGFV0wQQ2DY5V8PXcIlZ
         7Fsg==
X-Forwarded-Encrypted: i=1; AFNElJ8FCPcGXpiBcnvZaub/KyYibaM0WwZ7wHRZ3RnZKdFFtpN3gF7s1MEs+QLBeuxEdjAZFjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEG4UqIqReWHdO6OGM5Ni38A2hJjbG+bfleoul7BeqZeF7nAfY
	jaP3h9dcwSranD4sBWO+HCCHCTtMmY3lObQS+/pRf+17UYrcsT56Shad6x6VLTrCK6MyP9Yxv+e
	AxtBIrZVjxe8+3o7ZpPKCeU33cVq3EKbQbNHezUHTyA==
X-Gm-Gg: AeBDievlp2rWmNMEegSC/4VcKtoelSqBnqaGlMksi+v0+J7RnmON/QZndeaUlaG+hTX
	dqKwfYrdxfw/eDnaTB2BtyovzNaRzxqy3C+CoIu9qZO+ZTu9PEivBZRSE4fXxTNX1jsWaIKrLWb
	Zc+gmhWh2gu/Ba4197WoqWUzEgHS2HZhHG0mVTzwNJPNMBpElwHt9IFIJXv/pUkzntsXWkLa/IC
	D6WYvn+GV0kpYpoc+/SwhxkrPHzCabKLnh4rICE49Uhjspd8xl+LMJX3uMxPie8hDVwCNgTvvsa
	MaMDMchiloW6RcjDo++wWZVf2oB6WA==
X-Received: by 2002:a05:6512:1595:b0:5a4:52d:4abc with SMTP id
 2adb3069b0e04-5a4172ba775mr9330395e87.8.1776998894487; Thu, 23 Apr 2026
 19:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7aac2206-8b60-484f-a5f6-4943348ad3f6@ramsayjones.plus.com>
In-Reply-To: <7aac2206-8b60-484f-a5f6-4943348ad3f6@ramsayjones.plus.com>
From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 24 Apr 2026 11:47:56 +0900
X-Gm-Features: AQROBzDJVy2xT-rPIwfVO8nJ5WRIVeTtBA2jJrDXMU6ijjBWP1nJOMmH3ujIAnM
Message-ID: <CAPc5daWZUJA0sEqS4Qk2vn5x+LNRgphxjzjdbcLFpEgS+69kUg@mail.gmail.com>
Subject: Re: [PATCH] parse-options: fix sparse 'plain integer as NULL pointer'
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Jiamu Sun <39@barroit.sh>, GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Another thing from GitHub CI

https://github.com/git/git/actions/runs/24825391649/job/72659919418#step:9:=
144

  Error: parse-options.c:680:30: comparison of integer expressions of
different signedness: 'unsigned int' and 'int' [-Werror=3Dsign-compare]
    680 |        (n < cmds->nr && best =3D=3D (intptr_t)cmds->items[n].util=
);
        |                              ^~

2026=E5=B9=B44=E6=9C=8824=E6=97=A5(=E9=87=91) 1:05 Ramsay Jones <ramsay@ram=
sayjones.plus.com>:
>
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Jiamu Sun,
>
> If you need to re-roll your 'js/parseopt-subcommand-autocorrection'
> branch, could you please squash this into the patch corresponding
> to commit b9e6a2d30a ("parseopt: autocorrect mistyped subcommands",
> 2026-04-23).
>
> Thanks.
>
> ATB,
> Ramsay Jones
>
>  parse-options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index d60e7bd3c9..14f3f385eb 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -658,7 +658,7 @@ static const char *autocorrect_subcommand(const char =
*cmd,
>
>         for_each_string_list_item(cand, cmds) {
>                 if (starts_with(cand->string, cmd)) {
> -                       cand->util =3D 0;
> +                       cand->util =3D NULL;
>                 } else {
>                         int edit =3D levenshtein(cmd, cand->string,
>                                                0, 2, 1, 3) + 1;
> --
> 2.54.0
