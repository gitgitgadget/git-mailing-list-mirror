Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6C42A80
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785630179; cv=pass; b=C7dFeoWk9Ke4qNggMHznYuGcOhCdAnUbsvPMj4uX1SOHolgcM+dbp0hupMwkxOTnYMwuAUxFdJLlSDj0Fv6fZzpbBpm6Hm2ESruFLUaIAPM7MeT1pf4vou2Uwzpm410uwtDJRykNyF36E73JXExqm4VZwDLgaqcRANn/kzbT2Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785630179; c=relaxed/simple;
	bh=REjrYV6zDryvkGXbYRHTMqrWt2IlhPNIfb1vZX93XFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihFrl65zXVXe3j7rp3GL5mhY8nAP3cGqQazEYWfeOrygipKOY9VXXqHZPMdsJ4NBGeYDzBiyjxA950HpAnF4xxRiFw8XSPM4TGVmU7CVSbyDPs/egHA9//G/hVgoLOFDPIuq1n5p8EdOl/yOWdjHLwCTURMlmvHm0ALJC4KbZzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1Ht8PT/; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1Ht8PT/"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4af7283bf83so115047b6e.3
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 17:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785630177; cv=none;
        d=google.com; s=arc-20260327;
        b=ovo8gb0q9gKwfUpdsuehohC7PgLd0b1JuY8Jp5BiYdT4DGi7QFSAbRBNGys6Msoz8x
         JVyFVfwS+CEsBtdoC+TV2eYPT0aDmwAovp2ceHRqQPMttTlUgSzRfbyqrmjP8rG06yiT
         9Xypucx92XIzLRhBD2AsxUgJpYn+wIuYuCKfXDLtRclvkbLhV18SwWnaWyRfpwu91GPO
         cxJgamZFlEgirA9GjNzH4O0lRmonIWagxvOLB+oDAjI3/fO/rLPy9+X6qsOCUMsbqt5e
         9zlvTSILi7VlBtYVJyVgPrP6JtDLBCi3rj7ohvXNEWD0bfTds90bcSgO/zYhdEFoMo6r
         wGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cgQbudsS9QZ5GE+13pqGsRXwCA67Csv2PlT35OJn+d8=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=Psdz2ME+OvvOV7x+XX1eECWryz+v8C+3sR8l2zoEnEbsamdURduUoakJyeRrA+T8LM
         6lOi2QTFEI0KdJZBKKUOf2v3fw/RHCUrTzSjl2dfK7Ujf34Ek6oDzZk/pglbNo9T/wBH
         gHzN+vnVpLCKSQrpCBBBC6ACezZm2xRHXW2CJDe1l6rDDEiTWGazDb5HxPp+drtthu93
         rVh0uB3C1NFUlGhVaRdp/0z2YBYsVz7ZRxSZVAdVnvyhC/wdwalNb8+JurVh/QZK+V0C
         TwBbUPf0ubsLX++tbulR5elzlQogwV6GZCrvC3PIc1fRjYG5bdufpxxNj/OxYjlZ3PtJ
         UD/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785630177; x=1786234977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cgQbudsS9QZ5GE+13pqGsRXwCA67Csv2PlT35OJn+d8=;
        b=g1Ht8PT/iWogPEDsqUNqvTjsTbmONFC1Cky/+4uU2BNolPusu3E2AjNuQq0sxSWUdf
         dVDVfD4m1oOA77DzIjEveJwzGnEitba8AXby195USc+zY5bOvLePeQ/nTzFYacHsBdTU
         M1B8OcTcnuBCRwi3iNNVjG5NtTWsY/PyJ3Q3ONw65QHtKyBgBcYOAa3qLbah3+gG6I5r
         98q+WXwgDJx2kZQKjc7k0O6ZyGblmzjoOkHhjHtviiOxRhsyr9igmn/OCyqGVlE5vdFC
         SXY6RkKmnLnWj+RNu0bp7YuzcNfkiWHrOB5/LXUprD5qrdt+XYqeHltiMx2zslu/dgbi
         V+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785630177; x=1786234977;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cgQbudsS9QZ5GE+13pqGsRXwCA67Csv2PlT35OJn+d8=;
        b=P5eTtvkvDHb2O8mn0rEG/gErtdiRHzbJChIXfrlie++aySwF0l4GT1kImITN1x1tPE
         GJmEWlD2WXX3+IqrTzzMhY16trMMv2dyrAgh6qYWbqYiSl8gbebnv37V9Y9IJDb28F+t
         z8c8QClJB3cAZxhHdjCk4fznUTkBEpj9TGNvl6uCtuWPeuyBolHirFXMLMp1euo28tmY
         vRoxBstU/X+B/2EcJFIuE/5p8Dk97h73Tbv3yah3jp0M+vloZDkvBsM3gzpJ6AB7Vdmx
         CjCZIEYOhttfSJHfyR8KtRPtD1kqG1X35v2OTWSaNyFxj5w528JokFX48PRSasoMSuXP
         y8Yw==
X-Gm-Message-State: AOJu0Yzd5hn0vMoKTTGSej9IWmXLoe555OsOcpipWpxIjX0KWoyKXkPb
	s9kl0oEKXlQpZ4OSRcY2JSQugdxKQIfx+Xp8GbzYrKdlr+KYWIlbS9O3PoL/Ug0puKtbtd9wAZi
	u6iScLa/Y08Ivha/1ScKnTFTDzWhdRjkurv8q
X-Gm-Gg: AR+sD13gOsf/AULKJ/oHrLlNPzM/ek6VCkZU48U6ezfPV5/VxlOSIY2Hd377RqnnKcK
	Ar6CNQZxHfelOmjxVYHnBOCZqagsr9UdZLfO/ul8DRNXomeZ0S/qdYH3YN7iPbGUHius+cTdARu
	aEpU7f/jB3cRTJldplr4bdVYRZl95yyJ4s4SMBq6eAh0G94UkPdRlo7A6OZ2dT5omtLKHy4FDN5
	/oj6epQqgQG70dn3gxswCuOW2Zjl7UObfaUTQeGuOf2Ph6a2ymaegElw0u0AOjKKZSxxRXlFGQF
	meIJJX4xUaJVxYZ0CkyJzCO1dyqpKLvZhu+2L+mvPSU3+5994gS7bOzKusLnyuYMP4m4NuXssF7
	V2rz9MMl59dKBKWoFH/2UniCwH7PeBldZTh8Mm5seRAK9yKdSEOM1GE16ZSYQaC8=
X-Received: by 2002:a05:6808:124e:b0:495:f67c:d96a with SMTP id
 5614622812f47-4af5e1c80efmr8283276b6e.12.1785630176804; Sat, 01 Aug 2026
 17:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728215219.753678-1-gitster@pobox.com> <20260729172524.4022621-1-gitster@pobox.com>
 <CAC2QwmKD1d=-mz4WrkA7CHwi-ko75MP2LDFPWx+1FGLQtf4QtA@mail.gmail.com> <xmqqfr10lvhx.fsf@gitster.g>
In-Reply-To: <xmqqfr10lvhx.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sat, 1 Aug 2026 17:22:45 -0700
X-Gm-Features: AUfX_mwyOhYhHp155ZVpA1T6Q_7DWZw0iwcQraRPxYKkhb49TxgMoJiAJ9rypV0
Message-ID: <CAC2Qwm+6e8ZW36--iPmrCLT2tS7R4O_TDbx4S1MaSMb9bg=epg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] git add --resolved
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 1:41=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Sure, but I do not think of a reason why the posted patches cannot
> later be extended in that direction if somebody wanted to...
>

Yes, that is fair.

> Have no idea how the user recovers after performing an operation
> like that.
>

My thought was that a partial set of resolved files without markers
would still be added and files with markers would be available for
a subsequent add once they were resolved too. My understanding
may be incorrect, though.

> The naming is very much deliberate.  "git am --resolved" tells the
> command "I am done with them, so please continue".  It is not like I
> want to add anything that are unmerged.  I dealt with unmerged stuff
> and turned them into the resolved state, and the command is a request
> to record that fact.  It is a regression to call it "--unmerged".
>

Thank you for the pointer to "git am --resolved", the context helps me
see what you mean that the naming is a regression in the workflow. The
name makes sense to me, especially in relation to the existing --resolved
flag.
