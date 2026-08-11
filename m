Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24CC418377
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437033; cv=pass; b=Z9oAkgLxcN/8Py5DZBeHlRpUXyAdwFdhhMnB7Nr73urAqFq5zdF6lhLWBT7LPXhFmSLc+aGd6CHqqSZ9Aut25cRt0telyas9UoEdKvX3ZC3zi5WITAfqTnTMlcIfptu8vBTekLwFjeFDvd00+10tYcQ8Fc+rpb9MA5jQxMG49c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437033; c=relaxed/simple;
	bh=sR0er776nmpqs4z89lpExWu3Tf+OON9CkjKLM6y1vxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6a0moNNeJBJyAWAYThhEdm+ymKYkgAf/kW+o5s5RPLHnD81vYUBIL0N0sfZfg4aC7pE2DlcsySx4Vowz+toCasbKk1D++gERDQh0WsfORH3hkuanW1fVFCb0TV6e17Q8a5TI3YB3YCEUPwv/GJxTSBIH3nyFgehJiPem0DXTEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPgMygyt; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPgMygyt"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbb7926836eso1979739a12.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 01:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786437031; cv=none;
        d=google.com; s=arc-20260327;
        b=cF2JXgYYuRtBaf5UZjDivlRz0NEU/usBI9iNNtlSIUxYypzWAMwzH1tcyXO300ZD5I
         LQAeDHrkbIJfHqZjKRwL+Vik3uEtQEp/dcsFZKPveSbO2xGIGFoknc5FAlMkriok/9AJ
         XBYgA+UJKJW5LWbk6GnuOrHIYmr8hoBolbKhim98gI63p6fOyfj4Hs8q9GjmY/Fwyp0H
         0cgVAwd07VrgwuPyj4BOzVr2jjRx7NeQrC/ceEzeJDk12wlq9X68uuhm9J8Q672EHJys
         2h4CITL5M3RNxTMAAq9kvKM6D8NgwjRQ3uSLL++aqSgEfKuoCwxEqRB8brsqv6dZXaMR
         UwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OY0BNqrjfyHY6K5ITFQ+Oupcoluvc657dZetrhgVNWo=;
        fh=KFNjeyWgmnf7cA85VfKAZ5S2SzPYhEM9Piv1MnIZ0+o=;
        b=hy4MTp3+tC5rVLrtheQxP/0rAS3/BT8hWKl5zIeokQ9NHyiohgJKGKxV+sBdbIgIDA
         Nh2HG3DO4i/KiIm4HKXjEVlaLXLKXko7hNuRNXZnPPFJP1C3hdw0iiKr91H0S1gLMDue
         i3/2hFTQTj888mNQlCkBqeQ18LR/brudBsIFmHkb60gUCriyTjd26UJ70kERcGclHIP9
         56vTuhynmV/9l3UE8jtUwHYCDLQwNqoqCHet2yfzh3QbdjC+Ie7cafT/4P9fTWIK7Dkp
         p7m+fsFbVES9ezeoY/hDTz4QwaS3iS/RnuvvtuFnPOr9T/iNC1zFfYkGJyoWtKSlMisK
         Qeaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437031; x=1787041831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OY0BNqrjfyHY6K5ITFQ+Oupcoluvc657dZetrhgVNWo=;
        b=dPgMygyteIHIFZFEAPLC4vQHeK24G2Byymj4kiPtKG7lGYQFtsYCpz7JR3UlFjWFC/
         X1MHVsAJj/mzNPy1g47nAST1J03vTzpHPOxUpJpfqW949odt5KFY5jGjWSdMW8Ae913N
         xGVYpQZsOcRvfz2ZHTFk8U+VdESqUngr9z76m5Yg+XhDiMVuDy700V4UchGuZu7PdEvi
         HW9Wc39DM8Mcb8MzhEAj/vrtlWjt+2egPeZjn/+Am1RHyleydTWa8CmVRImCLUfPbAiu
         GeBrCYAzmIrGzX9acRdc+/QtVXCaOfIGF5f4nij+OFl5wkv96YoIpG7o6Vsga6Y92t1L
         uZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437031; x=1787041831;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OY0BNqrjfyHY6K5ITFQ+Oupcoluvc657dZetrhgVNWo=;
        b=F6XQlSDNGPT0kYJN9gN5gsayDYScHkOAmcavX6pyhty2CEnnrPmJml0PqgDsrPScmY
         PPtJod1AQMZxqiJ8FGLTdE2OGAnbBmHOM6facqThz321ljCQ9lOwszS3ZvnIFnSnTsDx
         N26Rg2taZ3zM4DQSNrarExhIC2wk3/4XjoCkPVZwC8PSJv13Bf4eKLju0BDh0yhmoA1f
         X27kBnRD6zwaidqwhRiuVgOMD411nCz//W9uo294bkvYNW3nH083V9xqwaB25a698XCn
         EqTzoEK0h7Z5LAChov0SN+9urMj/4ZRXPwp97F5Lyj6pZD6VOk2VKeH8qaBj3zLi6PcZ
         STXw==
X-Gm-Message-State: AOJu0Yz1LXVSJYghTGTFSzCteFM8G8dcVNhgtrfNXG9s36ernv3oGQeZ
	ZxOcRB4GZYqB+ZcKCWkcV/tgWSgDR9lbccqH9kJaHohVA8eneElAxkV4+b9E9BNEyKCzB7qJWND
	YfQLFEFI3JELTQJ7Akp5V3MWC/aLmZQ4=
X-Gm-Gg: AR+sD13cnKSWMZk9iI5wmFKXXnX/+CXWlQYQfzXcqovIDYGaBnQwHJF8yLzhICj3K02
	tJSQk77gsVMZIF4A+Cfe2TZkIiF+5/PdYCkQJZo1wE53rw+AzdBuCwnkq0YguWDWwYhgS3My0D5
	WQ7Ch9QE6cPUrUb1nTqz1Ye7gfAI1TR475GqDGjaJQiInUjz6BVficseR7mwb52FzKtLml1jcNX
	haPGvoawKu+x+8SKKtUkU16ZckOK0LFElPpr2JZQxt6HIC2sretkFO5+nW3Sq2+XlmoBMWXMD5m
	U9V+tE6n3gpPUIngAamBrvu0gTsh8JURODmlIhIkU/H6+zzYXNDJMlAnt3TAmrmx4txoq5/dWkd
	RxRScNsn1XReI50EKcPbBEPcmSnTb32C1x5R5uYIR/tMbl9l/zLCdwPI5ogcYWA==
X-Received: by 2002:a05:6a21:7308:b0:3c3:7cfe:b337 with SMTP id
 adf61e73a8af0-3cc2bbca4camr2381284637.30.1786437031062; Tue, 11 Aug 2026
 01:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260804100355.1299498-1-christian.couder@gmail.com> <20260804100355.1299498-3-christian.couder@gmail.com>
 <CABPp-BGfeF1t+siEUuYgTtDG5LtfL5iskSHferbGwFj8axA+tA@mail.gmail.com>
In-Reply-To: <CABPp-BGfeF1t+siEUuYgTtDG5LtfL5iskSHferbGwFj8axA+tA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 11 Aug 2026 10:30:18 +0200
X-Gm-Features: AUfX_mz5WhkE9pEqaQwCCGdurFezmkc2CKgxGmhbAqw87g8IfYKZp9Xu4pkkJhQ
Message-ID: <CAP8UFD0usk3kMW-qztB0jokexBnOGtmjH8Se3a2k6nkCP_qdsQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] api-parse-options.adoc: document per-option flags
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 9:25=E2=80=AFAM Elijah Newren <newren@gmail.com> wro=
te:
>
> On Tue, Aug 4, 2026 at 3:04=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:

> > +`PARSE_OPT_LASTARG_DEFAULT`::
> > +       Use the default value (`defval`) when the option is used
> > +       without an argument, even for an option that normally requires
> > +       one. Only the last argument on the command line takes effect.
>
> Is this accurate?  Sufficiently precise?  parse-options.h says
>
>  *   PARSE_OPT_LASTARG_DEFAULT: says that this option will take the defau=
lt
>  *                value if no argument is given when the option
>  *                is last on the command line. If the option is
>  *                not last it will require an argument.
>  *                Should not be used with PARSE_OPT_OPTARG.
>
> If you want to reword that, maybe something like:
>
>         The no-argument form is only accepted when the option is the
>         last token on the command line; used earlier, it still
>         requires an argument. Should not be combined with
>         `PARSE_OPT_OPTARG`.
>
> ?

Yeah, in the v3 I will send soon, I have reworded it like you suggested.

Thanks.
