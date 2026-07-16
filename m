Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99480367B77
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784228646; cv=pass; b=FVb6Truv/RYiXfF3ZXeh46R3XxkYMxkOENKaEH3LyMSmfJEv+1mlzWZQiujPTKtGUpt2fC1b8eDNHZkaqS3K+XZVW2oKwSqzbNqF5VfrcOO8M8qTcv+9LrKIxPMittgGWrZm6DlA7NQNC8GRWqkVKtcyhOl5J7c244SUJx1Lxj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784228646; c=relaxed/simple;
	bh=U2k23L3iqxeSdEESUfwxRH/r/W++5iEb5kDlrbciDQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sO+1FADavmxTLu2KP7o8nhjBZy/IitHIoxL/KREAfMxVeWgqLqJ6Cfo7Z8FXkpUHebSixN+KOGiCgxCdiCY3aEDAUxONyrCLWJXtIqao1SIyMhg9at9Bpuni0OhRG/zEbCMp+fGWVzYvlEoXnMV5XK2ma1R1rEzCzZJb9cLHTe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU/CNFu/; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU/CNFu/"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69a50b818c8so11697019a12.2
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 12:04:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784228643; cv=none;
        d=google.com; s=arc-20260327;
        b=OLdWJCLNot+EuukjUn3kdrN7Va61iiXeIXKpWTGYL1R3GtsRIwco2EQyDoaWl1SLTk
         CgeV+vHOL+OUwLg/g56eiAiM+JsWXh9xfx/s0zPp4oc/B8pVXCgbuwwkl+4l+6pGGNnE
         HIoNJT/qLJJONsJeZxewcmOxdFdUwCy8plzvidDje27BnSWEMdykncb22Y1MlXnJ5ZYZ
         ICq1zHR886H6N4M9K2jUOIWbMamf1tij4iD230/mWgAI/+DGew2mnqr6V4k2x4lgIA6M
         vRE4lZWhlIJmp2DRe/kUA4moSZe1ew09kPYODYJuJqtohCPRXyr/vYhzRgjh1xbX1KQO
         A2Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2P47fPW3Wp4tZq9vE5ZzbOXJ+X38+AM1J6Z11hp840I=;
        fh=c5FA8AoPXGSaHDdBJBNnqj6ExBoNqgvTy8aQWHU7tzY=;
        b=jMXSHIvTeGlLuS8j4xF42loVDN5cl8+3mGt/w1QqSRwtadXd5kDckzv/QCXgogQ2bx
         t0jysC3iU2K6xXLYlxLqsTNz78eD3PE+WM9u54hiHH2kDwNVF5Ct6f8KTFrxMm5TRc9d
         swEzKtC+397oVflgkmr86YnEdlGUGirmcrpBdoZqzbc/W57u/5Z6thj1NOWJb27Tnlz7
         qr+rLKySNwQ/87Ynblzf05Nw5Blqxeu2gGDGyDgPk9v5msgIU6VugUZ+pG7RcnjPiIlq
         LPofMkhvA4dnwu0/56Z10UkfIB6fG6BfCrM/ejptrPN/2BTJAyYdY6QEnQVAd+F1cY9b
         vAqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784228643; x=1784833443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2P47fPW3Wp4tZq9vE5ZzbOXJ+X38+AM1J6Z11hp840I=;
        b=HU/CNFu/Fe46Nv6KxC1qkjck7XWA84tqN2sOSc50eJn40nkCMpxdcFHvl5Z7oX1CRE
         eS6N5gOvfCjH03TeX1ejPMTRA1HbJIVD6Bsxn6GCI4L76LVK3J9aAN/g5LmXihQxUD8d
         27d9fxE85XmbLFhob2z+NSV/wfxeiungqXkLiJm9Sk31kU4lPcpwjtqYEZ6BqdOXmZz/
         VE8JSRN3NjNta3hbw0iokuoIbPIEVa0UfmVxGJarLrqEJplkqBMW6iWX/KMoWmAokU9L
         awQKoNYuq6JOIvMBOuEUDSPKN4sLvEf6SPXIGX9Egzq19OD4CWZZiy0ilfKy+cxgUkSm
         88JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784228643; x=1784833443;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2P47fPW3Wp4tZq9vE5ZzbOXJ+X38+AM1J6Z11hp840I=;
        b=sC6TsErLTNKtYY6R0cYSTsz8JcyNMvm4VU1jvLIDxAPvqqu1OAIRz0uw6Kzr7Vuw+5
         RC47mkPKb296ku4UWXwRGokxF2mWd2MOXWkUxAqswt72aK2SzAseMnHxwiiFbSrpSGcv
         GJGKddYXL2fEPPbWkuoLZf6SFIFMgSyoDn86C4kcD247kIbC1kAO93IHnTYLzzai3W0y
         y19VZCEK9MnNnNaqGLfR8jtMsAcIO+8NEuf3MDPluzRbeYIsdYVlscc5QoMwODEt776T
         vrvZGpk7PKmJt27v9P38W1UlRqlHTO4S/1YvZFgr7V1mtkdpaY23iWamMJ/0U90969lb
         IOCg==
X-Forwarded-Encrypted: i=1; AHgh+RpPCiDs13/O42y4qSZBXPnqo3xj3srwNvxV2M31GdaTmggb7LA9JozclpcvDotO8mKubF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvsPSEKWgcowBDotvJLYWbclU7kxlW6gHvP3m2Z7FAghtnuPAC
	pdic1eUebeXkRMMmEru77GECBaS5+HQnoNqvbBVZSJb3SVSK8QzhTjTUVmeoM0Sf9cjM6blVK/a
	BHwNyt7aKsuRtcDcN19hokDd2DvOz3UAPRbuDwL0=
X-Gm-Gg: AfdE7ckOW55OjJBpCHFQ9jTp7HRUfqVyfA9evrsfTi0/47X3BUOf+h4+xXL5YBinigj
	ZMALM27LhG5qB4w7tvObpUo3+Nrdxt4EuV3LRo5HBB/s/Hd+ZVzEmGruKYk4uvtWOFmL2hsS3Y/
	b3hvbh/J78CC1uYDyS7TXBcXwsMJ6niv3NVTCZ6B2pNrj225/vDfU94AmerfmPyYb5PWluCILzO
	+yIftyNsJeF5SOO9v7JPEqP3N9q5wOy94Ll0OADNcrJ4cZLER+XSR/WH2e2DpTO1spQ5PxQ
X-Received: by 2002:a05:6402:510e:b0:698:8f3c:bfb7 with SMTP id
 4fb4d7f45d1cf-69e19ddcfa4mr5001505a12.31.1784228642582; Thu, 16 Jul 2026
 12:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fdef432d-0b84-4b58-9915-83eb4d7dae87@kdbg.org> <xmqqcxwmhlm2.fsf@gitster.g>
In-Reply-To: <xmqqcxwmhlm2.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 16 Jul 2026 21:03:25 +0200
X-Gm-Features: AUfX_mx-3OD1W1msc0H6gJNGdQZQMAOKvZGvs_1geRn2IHtHjV4doQ31GyxMWis
Message-ID: <CAHwyqnXwGGn2r-TMnEaYsjuJgM9f-RgU4s+SP4a6DH1EC9DouQ@mail.gmail.com>
Subject: Re: [GIT PULL] gitk: Bulgarian+Spanish translations, silent make -s
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks!

Do these changes eventually go into mainline Git under
`gitk-git/Makefile` or how does it work?


Harald

On Thu, Jul 16, 2026 at 7:48=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Johannes Sixt <j6t@kdbg.org> writes:
>
> > The following changes since commit bad83ada0ebf9e293d570e6e7ca4f1cd7877=
f482:
> >
> >   Merge branch 'horizontal-scroll' of github.com:ramcdona/gitk (2026-06=
-12 11:30:22 +0200)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/j6t/gitk.git master
> >
> > for you to fetch changes up to f1de86371cb85dd09d55070d139e5fcdc595f026=
:
> >
> >   Merge branch 'spanish_pr_bis' of github.com:basuradeluis/gitkbis (202=
6-07-16 10:53:01 +0200)
>
> Pulled, thanks.
>
> >
> > ----------------------------------------------------------------
> > Alexander Shopov (1):
> >       gitk i18n: Update Bulgarian translation (329t)
> >
> > Harald Nordgren (1):
> >       gitk: make "make -s" silent
> >
> > Johannes Sixt (2):
> >       Merge branch 'master' of github.com:alshopov/gitk
> >       Merge branch 'spanish_pr_bis' of github.com:basuradeluis/gitkbis
> >
> > basuradeluis (1):
> >       gitk: spanish translations
> >
> >  Makefile |   6 +-
> >  po/bg.po |  45 ++++--
> >  po/es.po | 488 +++++++++++++++++++++++++++++++++++++------------------=
--------
> >  3 files changed, 321 insertions(+), 218 deletions(-)
