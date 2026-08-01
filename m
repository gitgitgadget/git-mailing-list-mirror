Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6A32580F2
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 06:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567110; cv=pass; b=suxpzl/ttrQZIOIOkUU54kiFhtfqPcV3iD75eD0gehUxPRpwMOIjYroCJ60U1ggrbzDdKN+CC0G8gT9AEI9wtSEv37ZGDpnRdllbzcFdhMp7N2Q9jJ21bUhIRBNRFlWjg3dnjlK41JEciGw24tgM09EGCZvVVOga0AWhseivHUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567110; c=relaxed/simple;
	bh=AwvSx09vXKKqGK3lLoq3hDlF5/CuryJ8a66GzD+4fbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0ZkGgufvXf/I2kdo2SuGrrmLRrJEJoISSgdC/ojxTVfpDr9GvITdHTmUpXcg++L4VMTMdOSFmy/ky+4PkRVq9Lxh2eOcU557n/rtZYfQkM3UQkHqyEXQq+BWPnC5if8+dD7XsR3IKINwkT9YNbyH/Cre/grYvXMOlb8OvaDv8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ge1Am9zv; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge1Am9zv"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso1579085a12.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 23:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785567107; cv=none;
        d=google.com; s=arc-20260327;
        b=N4SjvheW1mKF1jEG6BbAWp6KAKh5KjgnWQSeAqSlaN30X/bChpmBOBH2DseFWpBOu6
         F7EqoN56t02P0OZy3Rv/diVFD3wugeUW2euFbsOXNZ32nDB93R+pT4hwbYy0NrvoPhSo
         ewAAV9ao3jk9V3xeU7rQ0lP549hdDp2GRuecvb18mN1JvPJmujcm2GZZglan4GIlzcLq
         o0Si8+faHR5iLmu5PlHFiHZ35K74sfNTNIntSgd7X2mpY58d88S4d1VzKTYV7BoDM9Ep
         xNR3gKRJC+EHVYcynKzg9uu5eMvtKFcEr7Dv75okbD1M+Z/GH9YW7DxA27+mHIqSAEh+
         Zm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MtYD5hRHdXdiFVlBMos9IF/ppcAunh2SAbLlk+APR2s=;
        fh=IXTb2LAiu+vDk1sz53Gu+uX4DWylB9uI4m3Oz8jYq8c=;
        b=iYiSPKq+lh+8HrZsvp16zAzyBjuJYZD3zFAVZYS5ohWM5s/CKHkWYokekjeGltKKtQ
         kkyG9e9PK3A52eMfg4fWsApWq2A0kTFvSGi5QFBy+5ZfVFmUHXEEQBa4HdpyG1FleX3f
         MbNV2cx/NXWPCTo9oe0ZLJrZt3IpgD3QZLGS/opUdbDQxsRnU97pQNWMn8gdYb1pZ3Cr
         E7ItvUXJmZtsP8lg8VSVyEs9UPX8JDzWf0NCRra3pR85s5nF+WWfzbb773VTMCNPZ0Gh
         oVfmMEQaV0Un+YTHGFVMk7HSyzIOZG/34dk6z4xLw/G4IyRze/HhHpeE0xSFTbGGbbKx
         QJ0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785567107; x=1786171907; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MtYD5hRHdXdiFVlBMos9IF/ppcAunh2SAbLlk+APR2s=;
        b=Ge1Am9zvzq6Y04BKHGh49MP3uzi2FnMDZlSZ9olT9cXstzQZoqJGleVT8cn+emTRC/
         PpbDa0K0n+GZ+Mzjs+oXDpOvn/F/jyF/yT5Uej2xKSQdoj2Bi17qJfN4578+twKw6KEt
         bF14kO1JgmWTNMsa1qFlYryvvzgokGn8R8qMLED0Lx6xd2AKomuLM4tyl91LfJR5P9jH
         HCzzUo6Yyx2MQmcVHJfdze3unTVV8U9tcy3FOALtRdysLDBeBjqSW3zMVwrZRIbwvngZ
         8PUVUTfp+pMwJNUf7SHIeJYjRtagOfjtWoc6C/ZGfuyYoMmDHDD0Tpo11QcQ6sq2cLwF
         OmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785567107; x=1786171907;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MtYD5hRHdXdiFVlBMos9IF/ppcAunh2SAbLlk+APR2s=;
        b=pM0jFXIUinZUwFDosJsGI8DHutSOuhd2GaOoP25cfjxxOsPiu+AO7QgFVwu99emNPf
         FAdwZOP+vgcB3sezqSSu8mz5Rv6KtuScli8CNoq93LJIeg5fZdYNEoI8OmbuH1f+aO9r
         6zKYi128dVoXCmgiPXBh/o6eShdXK7xVYO9zIZSxGmnL71SrMMOA7NYkmXrTaRJrLBRG
         XLuKF1U2389yp1UxXiSRbUl+GY8brdJQbAaro0kk13ZqPnxavS4rUIBs6B9aiGE4N+0M
         POEeTBLrq7L3jCULJITff0vGNe78A5vM76pDFnarfbagLnb9qMxdGOqgxSh2QA7Q2PZr
         q5Tg==
X-Forwarded-Encrypted: i=1; AHgh+RrQkxUncc5Fn9lEkCEoOtx/JJMjbb2YKFmi779hc+zNhOlfObH+Ixx7NWZRLu32fAJmXHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+iTBrvxF6trPzvQ8+VyQrSiJb4ufR2LXQTcsexwuLgykAxKiJ
	ZkuRt0t4KL/7C34e7s3CENmy/eDUntLHMx3S8OYG+zgOj+n4FtrkujkytkHZofmOfD1WfRozhyV
	LJ1iwDTij2DIUXX3X20sAPJZkGLMEA3hFRZ7g
X-Gm-Gg: AR+sD12EilFN3GMzpN50YghsraMjlcLbd6Ay1ojIoCFr1yUksZPGr6kM2pU00Jdt41c
	1nMRm/ssL5iosECWWZ3+NpXvEJNlGdo4Z0w/Ev/z8O3vN0dHAJAHLD029O8EVlAPP4dOclma/RS
	q+jO8pOf56ZtAiJsxutAIgaOAIj6m0ERdEq9pQsQF5felD4ZCsHYLtdiP9sERPltMfWqb2grAkP
	9U3bxayaJn9x+XthQilWEb1624BkL2m9TvUej3x308ndF9pP/hbQdBGan8l8z/wLxH+Yycq/rMz
	Yr2/5GY3zIegXEklpSctqMPex+Q5rPElaOTI0N4O/gAc
X-Received: by 2002:a05:6402:51c9:b0:698:3469:fa99 with SMTP id
 4fb4d7f45d1cf-6a0a7bc2d53mr1296086a12.0.1785567107248; Fri, 31 Jul 2026
 23:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
 <pull.2335.v3.git.git.1784538619.gitgitgadget@gmail.com> <542f4b2c8065818b887437add90130d2090fa0f2.1784538619.git.gitgitgadget@gmail.com>
 <faa22968-54ac-4e4f-8324-3326ffb00c5b@kdbg.org>
In-Reply-To: <faa22968-54ac-4e4f-8324-3326ffb00c5b@kdbg.org>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 1 Aug 2026 08:51:10 +0200
X-Gm-Features: AUfX_mwsTpNn-z3H3TtmAzDUJyhyGyYPhczqrs1bA9Krm5okzD0Fq2Hm4LfeqSM
Message-ID: <CAHwyqnXxkqr6EeT-zpSo5KdJR8KsqDiLM1Jj_Q-G6wmVtsXDBw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] bisect: add --reset-when-found to leave when done
To: Johannes Sixt <j6t@kdbg.org>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Am 20.07.26 um 11:10 schrieb Harald Nordgren via GitGitGadget:
> > @@ -784,6 +859,10 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
> >                       break;
> >               }
> >       }
> > +     if (reset_when_found != RESET_WHEN_FOUND_NONE && no_checkout) {
> > +             res = error(_("'--reset-when-found' cannot be used with '--no-checkout'"));
>
> We have a boilerplate text for this kind of error that saves a translation:

Good point, will fix both.

> > diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> > index 081116220a..7dfb871ab9 100755
> > --- a/t/t6030-bisect-porcelain.sh
> > +++ b/t/t6030-bisect-porcelain.sh
> > @@ -43,6 +43,38 @@ test_bisect_usage () {
> >       test_cmp expect actual
> >  }
> >
> > +test_bisect_state_file () {
> > +     test_path_is_file "$(git rev-parse --git-path "$1")"
> > +}
> > +
> > +test_bisect_state_missing () {
> > +     test_path_is_missing "$(git rev-parse --git-path "$1")"
> > +}
>
> These should not use `git` in a $( ) subshell to avoid a case of "ignore
> failure in upstream of pipe". Note that
>
>         local file=$(git rev-parse ...) &&
>         test_path...
>
> would be wrong, too, for the same reason. But
>
>         local file
>         file=$(git rev-parse ...) &&
>         test_path...
>
> works as desired.

Will update.


Harald
