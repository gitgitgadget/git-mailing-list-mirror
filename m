Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102C2BDC13
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787793788; cv=pass; b=FEGzJJMKVVo1drdkhLvDyGLtyslzq9NnkYvkM3gpnYlB9Ae/5iH0oefYoXHK5SkYTgYV5WqbU8wGJyEkRcik+LlgbadmmDUv4i1xbwiGj9CKeqsaF+efwMh3NAMfOVqwl710mLfmopcDBto7Ys96cUQ8rCn2syDnM5XQhxxz9v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787793788; c=relaxed/simple;
	bh=6l6I6gjJ+ibIkUEw3BdCrokOc2OeA1G+3QEPwajBjNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChZuN2rjnsTXitM0glrGWt1duOuLWScTrUVf7Qe/5LzAYIqmnhMAr9cZuxdyKRVEWH5eIsjoVYsPegd95zjNXSP/UHyL42nEsnUvIjvkWR/H6Wku+hjnNYUjXNe/wCIaLzvLlQ24u1rbqDCrM1QkfZpwHdbdJBf48szb83S2S+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EowxOCDP; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EowxOCDP"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4b381337e1fso322118b6e.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 18:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787793786; cv=none;
        d=google.com; s=arc-20260327;
        b=a8Ey5qDtDBEn+yQVQNcxI2ha6DFj7qecL0095btHldOWwLAhb7biCOScj8F+1fLW9k
         6ozBsYr6rlC1B1f2XwH66Ar0xQDs8TT74FZly6kvFJ+esMllbOATCQtmN1A6lOtU/v4t
         BagVDAHYsW17CRLb4z0XqurwYA9+Y7rO8tJTN9gvwn5CSTHyRKmI5CRGl3lo3qxB7Lu+
         7SdNTdp/1T9fUGAANP5NdYAI9nGKTz4BPHPu6f5w1fr3Ps8aa6eLwivRJfQDE+AHQWpg
         HeVTkr2W2oWbcizu63EpjlfSjvkJuuzOWri0kDjGro2N/aTx5s+g4SjrPVkuHfU1/f7+
         e7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BSixYvDfB7AnKGoG5qKysz4ayYinnKw2WIrFGt5W/QY=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=tAhiPqYGlGy/NHLgIb0Y+/Md+O46PEGyJ6yDCjiUtp9zEw3kOUzkVLl/ooG00Cj+tC
         cgZ2dSMX9+aKaGrXtqUpHQw/dhw3rmfy5rwDgS2bkKWwL1yOhpDJmZTzb9r4cuDC8Jku
         VuJDuG7UYuov9hrKBbeHFCfIcG0spe5k6GJy6kAhBwBttdyxIJHB1gaZ5Lz44Pwtwycr
         JfWJzxu/sAYUizcwc7KJvACRsKmRU5zW6jqB8cvArEein9nsZ6wzxjNIWe2H4kcb5q76
         KRNnljMEfqAk1bdEaG4sNjiTx8F0ykBJkJN9gudGV90f7BxpIJhf5sxAM5srHnaWs7/g
         e5FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787793786; x=1788398586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BSixYvDfB7AnKGoG5qKysz4ayYinnKw2WIrFGt5W/QY=;
        b=EowxOCDPcCegdF11eS/SmTVelPu8eF3XcLZtLkpHbTB6DJQC+thfDcZHwrz3t1cfuy
         rXFm0IW4hW9DMsHmoWFugLGJVmyFFnwLxQsvkzDqS7J1YRffRKyrUJ2xDWeXJSkD7J1O
         omZmu+VVPYHkjFpTOqCj3ChP269av02cao8K9aKYu9xTWLQEio2V1Lx5Wx7H4/LrTEVM
         RFbbTLxpqFCLctJv4p9m/aAIKvc6aDpiu6hzxXE1yh9pUQ4b0yzeWKgPCXooycXi3SWw
         4am79MP0RqsSlx6Tq6WRHKlCo1axaXNStirJ5VdZI3S5L1xlfUTk+ZSkb/75FNLIgJWU
         t3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787793786; x=1788398586;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BSixYvDfB7AnKGoG5qKysz4ayYinnKw2WIrFGt5W/QY=;
        b=XeR/U8+32PLgQdhBB9hIxD6o0aLkqzB8ZJBX330JygaY2EUCTr0k/yIpkv4c1ruNyx
         8doOYejLLLA1czl77UoB6LvJPESKx1fvqags2vHRJ+vbmm+cdDFfUoKMaSR/M9yjLm6Q
         /WupOW7/glUa7txcbgC5jHelwg+JcuLFrLQay57j+RQwlKAOmv0Wfseeu+Z7pEbyjytS
         70BdgHSvmHFfi7NcZe8BPhlS5QTzey3eUXNrWgLaZ2NLG7Ojp2HO30NCr/l14szlbrgd
         pKI6spe7R3lvjseuCYMpUpPwgVEKM3bWhP0c+HKwwHtwBUeoozd2cbRHRbXS1+RyRbi8
         UA2A==
X-Gm-Message-State: AFuF++lGx0hrl1NNEP0lprqQnUe81CivXRBo6qWej3ZDO8GUdsNOnEFZ
	etqi5KBu2GJOJM1UuKPLtTiu4jBP1x0WBo5e3PX9NNTQOGhoee1rEMLqs9OkXUuEK9eSy7ZyARL
	lZfgSasdJQecJH02UGB/j+ARNlvGH5gSS7g==
X-Gm-Gg: AR+sD11j7I8je+JrstY4X98g9p5gfHWAVDUMZerTdydxCyUivhYOKFOMD9Wz1L8qrh4
	ds5m8mg1tb8SqOvye4BQ3EkT1CqehjR7biZmWFWZsUqbhFCHK6eup5HoiuO0GE4/0oZ5I4sNpDM
	+W7z+L8A3Q9/wiuHjfAZ3igOLb5MsAKjC5K2dWbK8CSc/s26nBjCxbpYP5/1ZA3ZfvMK44tj5aB
	ecwH+DMCmfcDdZ22qRxKyh1L96+EWesYaccum6pboZErZAxEeZEM6M3Jx58s9R/uydAiYoEYXuU
	xyCWj6ZuNL3Y7KoW/PQpm3tT4SqFENkaWaVStWQTdb+3BAHHAXFm45oRJyJr9HdDPUnCGnHSgs4
	a5C0CjDZXQAPhRZMHdqTAonKPKtGYYKQW0vnKeJ7+sg/4zQ91KPNnUgNK2K4+hmo=
X-Received: by 2002:a05:6808:138a:b0:4b3:7dcf:b77d with SMTP id
 5614622812f47-4b37dcfe96bmr4202924b6e.2.1787793786372; Wed, 26 Aug 2026
 18:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqo6epj6is.fsf@gitster.g> <xmqqjypchixe.fsf@gitster.g>
In-Reply-To: <xmqqjypchixe.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 26 Aug 2026 18:22:54 -0700
X-Gm-Features: AcwNN1XPaFZRD1OpotHlwY1oeUYWkqun_zwgbFFKlT8wicNzaP50FX2Z_D1w65k
Message-ID: <CABPp-BEnTWbk7m7jRoBG7Bp6vT62GRHoEfXg7=bJh111BqSx_A@mail.gmail.com>
Subject: Re: [PATCH v2] you_still_use_that(): reword the instructions
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 10:50=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> The message is overly long and may mislead readers into thinking
> there is recourse other than adopting the new workflow.  Clarify
> that the message is there merely to help them find a replacement
> workflow, and is not offering to reconsider a decision that has
> already taken effect.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  usage.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git c/usage.c w/usage.c
> index 3f0118ab2a..365c0bcb90 100644
> --- c/usage.c
> +++ w/usage.c
> @@ -386,21 +386,19 @@ NORETURN void you_still_use_that(const char *comman=
d_name, const char *hint)
>                                  STRBUF_ENCODE_SLASH);
>
>         fprintf(stderr,
> -               _("'%s' is nominated for removal.\n"), command_name);
> +               _("'%s' will be removed soon.\n"), command_name);
>
>         if (hint)
>                 fputs(hint, stderr);
>
>         fprintf(stderr,
> -               _("If you still use this command, here's what you can do:=
\n"
> +               _("If you need a replacement:\n"
>                   "\n"
> -                 "- read https://git-scm.com/docs/BreakingChanges.html\n=
"
> -                 "- check if anyone has discussed this on the mailing\n"
> -                 "  list and if they came up with something that can\n"
> -                 "  help you: https://lore.kernel.org/git/?q=3D%s\n"
> -                 "- send an email to <git@vger.kernel.org> to let us\n"
> -                 "  know that you still use this command and were unable=
\n"
> -                 "  to determine a suitable replacement\n"
> +                 "- Read https://git-scm.com/docs/BreakingChanges.html.\=
n\n"
> +                 "- Check what others on the mailing suggest as a replac=
ement:\n"

missing "list"?  ("mailing [list] suggest")

> +                 "  https://lore.kernel.org/git/?q=3D%s\n\n"
> +                 "- Send an email to <git@vger.kernel.org> asking for he=
lp, only if\n"
> +                 "  suggestions by others do not work for you.\n"
>                   "\n"),
>                 percent_encoded.buf);
>         strbuf_release(&percent_encoded);

Otherwise, looks good.
