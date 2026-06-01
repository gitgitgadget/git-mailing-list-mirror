Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655973093CB
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 04:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780288138; cv=pass; b=HbowumdRlACkToorq3zYzui03rM+dMRu4K6dFjMJhNrtCkm4qXbNE+wkHvvcSAB/A/vadgniVVRPb/Hsc/F0VwuchiApQU4/hsAaalBH5kJK3LA4UXcSHWFg8PH2riUKXGVnRCxAdbi6iIRVzqz1+NVmAh6R7mKUnPM+RJCbZsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780288138; c=relaxed/simple;
	bh=kEcsOLRbQIX5Ix5fRaLH+Q5UXdTnw7V2K/Mhn7gaQOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckTSMYHu/jXesJgVm4SZ8DEXu6jjp3smYn4B6xcbtMdCYpGWJ/2KlaIwBgqXpbN/JxZU1oQSYEsqTVZmDfgn01e1+IgahCiXN5NYaJNAFhr8UtphYjG99YCWLDDb1tGcnhyGLFst8uz3phYTBO/ixate6QRhXTYoTFWhWwmngrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pF1FFm3A; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pF1FFm3A"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-43ccdf988beso645117fac.1
        for <git@vger.kernel.org>; Sun, 31 May 2026 21:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780288136; cv=none;
        d=google.com; s=arc-20240605;
        b=FJxK/x7DTU/nZhVKYXwe6kzTGP9LW2QYrSrJSq0xRh8BWlX9QFFJTvFHqCdQwlYR+b
         tpGB5Wqqr9ZtmWsOiV78vOtrQkDhEiEbYQRZEO/YkgHl+ErmOlDbf8TeQJDdqNqdAQjw
         nsaTwfDNjn9qD7D/ZISIfcCRcYzDO9yjJYxFPSkaO7rRNagk3EpQebgJ6JC4vLNZ506Z
         U+aCVhnPVlaOYBuC4ScmuM5Vx2hOnaVUnQrHusQs7tU9iPHY7NffyDD2caiRhtP4ezIk
         jNyNGuVwsmmVKCmSzhCKVMupkYJO1eiCjiOtce91X33jE+BuF9d6aN9dPBXMdtVzwqmC
         yXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WhHy8COOkfuRB+d3pvLUxx6PHrlW3/NH9zngsDwKV0s=;
        fh=IGLTUFsofzQ1WTuhpXTgnniKjmViKKkyViJB8iCrzSQ=;
        b=TPsvTmBnfs8cRrzk05s4ZzyHc4/GJzkn8Yvh6pWvY0H5xSba+M0hXkXSVmyh2fNERE
         +LTuSYrtOjG64OWoAgg780fRmGcqPJHcVXhxTqEVAfa+JiTYJ86KbbIwOIgR76k15VT2
         XlwSsFPUXvM+bIpACSLJ4jgksaknK65A9XYB4EUWezHoEQz913Jmop6YulNX7URFh0zH
         UCUeOs99FtRHewGHY4vEof6S56W8CEHKlFw8cN+7c3Xy5BWLnA3USbsIMsh6fXHT7K93
         obmrvyAzBPSoyGkgu3A5llTSfF9Oczv2WrFiD5dbN9JUQ/hMS/DFAgw7uTy5NkFRdkbv
         x9lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780288136; x=1780892936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhHy8COOkfuRB+d3pvLUxx6PHrlW3/NH9zngsDwKV0s=;
        b=pF1FFm3A/++6dS2hRLg+A06gUqo7+6mzfuY/jUuQlyTDVy0f4FXo32XOhejqBTZXXS
         wnlDQ79K8kRImEvy09eYsiHYKrTxZiM2b0LJyZDNY4WneJknrzTSebczIm1PBNKC27Q9
         qWEBg5tZDxROU5+DlCZmpffOAT7gsw12KqmDa27BKdz2B4Ep4vSu0+hlDQSGNv3v40/x
         cVvRNZG4xEH1mogYEJicq9Hu2SG5hvaLF8X+2NE/1tQoAM04x7dF+TkbRI3BNTGW6xhb
         +vx3tKM5uaAHSfv42aEx8AWwXwCC1AYhQIWcEH6n1kmcBM1MpFmjf6flmX01SSYJVYY4
         9DoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780288136; x=1780892936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WhHy8COOkfuRB+d3pvLUxx6PHrlW3/NH9zngsDwKV0s=;
        b=Tse7X244OJPhT7y79vIMJEBZDzCBHcBvAV0Ta+VFzzSIyuwS+R4quhCtO4xUh4wdIw
         JujRgRvGUGBgCKBZfygcfUTpg56yAtMh9md/A4a93AG4opcslz7BMbQ91Iri//cEJnaG
         8WxpnlZPT8HaVkGqysKuaTZYok+tjDCozUeyvNw/qFPtIXfjf0+TavpvrBZR5/CcibQq
         lKSy7P51cgq3Bhuw+hOgOrRdPVIQjNrCDLW5T9rkZPxksPz2m3TlIHdu30uJjECT7tf/
         Ai3Hy/yd6zMRiqT3zD0djXtqu1WHOSvNFo/wHgNU1zMSQZwUdFPWWH51OZn+zXF9S/HH
         DB2g==
X-Forwarded-Encrypted: i=1; AFNElJ+P/e8i4I66axD+yL5OJ6SG1QPTxlgYgIzlVCd4ECld+7Dk5h2fIMRwYKT8A3+ETLnu2jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxSaZOaZC6oqOHHf939F7tz8RX1x5A3gPBDovbOv8AeWMuUKFN
	YjFLwiwK0KTwmwiAkhnesueSTPGCqrmnEz91M+q8iwsoBJdI9PlEBCD0eerXMR8HxLhiX8EgC96
	Oc0//jGJm0T2ywkV7dEWcNlR5LM9FzGi8yju/
X-Gm-Gg: Acq92OG/joXBAyPLo6EBnFn3ae/8qqY+rb0+lfN6wqdlgxZ3zi4n+8ZG+5ZB16GYWxg
	fssam5gZx4+GP1b+NZZZzy8doG08hRWpTaw+9IGiDceVI+cd1m6z0YBRg21RBxblPf96+dLbkaW
	JiGoELPtMmikL8A8tYEWrGq8oW6c8fQtIM+lvd4o5m7Lf0Ppv/jbZL4ULYhnf0LaEeJXYNRwb2U
	C+viR1Z2lVGr+wYw0kdB7xdBONZmn8er7bTvydRcWQ6A/WyYEWC0qRUlYDJmX7FCG45FU2l1/hF
	tFFlAdycaQ/tn30OvAZzbSQzRQSgdCQxkg8cAVLmstjpny+o30w=
X-Received: by 2002:a05:6808:5387:b0:479:e869:5424 with SMTP id
 5614622812f47-485fb2a3b1cmr4781907b6e.19.1780288136334; Sun, 31 May 2026
 21:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
 <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com> <xmqq5x43dfk4.fsf@gitster.g>
In-Reply-To: <xmqq5x43dfk4.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sun, 31 May 2026 21:28:43 -0700
X-Gm-Features: AVHnY4J5TGM1vK4TZcPGu860Y9u4IBvj0hrs-Dsn24MvGdYL_vfPfQB62y-ZVFU
Message-ID: <CAC2QwmJu=Ud_qQMB7T2zmjiGpxk0=s0T_ZEt4Ei+ssHF2DHZ6w@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] [RFC] diff: add diff.<driver>.process for external
 hunk providers
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 3:44=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Language-aware diff tools (e.g., Difftastic) and format-specific analyz=
ers
> > can produce better line matching than Git's builtin diff algorithm, but
> > diff.<driver>.command replaces Git's output entirely, losing downstream
> > features like word diff, function context, color, and blame.
>
> This seems to break CI on Windows; take a look at
>
>   https://github.com/git/git/actions/runs/26709491830/job/78717295153
>
> for an example.
>
> Thanks.

Thanks for the heads up. Interestingly, I think Windows exposed a latent is=
sue
with sub-process startup dying instead of erroring out when there is a spac=
e in
the path.

I've submitted https://lore.kernel.org/git/pull.2133.git.1780287309846.gitg=
itgadget@gmail.com/T/#u
which I believe addresses the issue, however it seems like there are
some potentially
unrelated CI failures going on right now which is making verification
a bit harder.
