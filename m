Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BAD2D73AD
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774778148; cv=pass; b=cw2g9tQF4vfZS8ByGheR2tlasERjp/+feOokBJOyfcrKJAI3rAMVUv0+iXUhtButstnfNT+W4yhcv92lo99kLxYF48fiBRACGSAb26FxeDdzBTDAFPEV5yTYcQxOHfL4A/1SahnqJhE1yC/vPGh3n4BslIOJ89uEXEd9iFoYQPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774778148; c=relaxed/simple;
	bh=omh4yPbZwTYqH1VIgOdvMVvAvaQwBdqSYcUKMEkd+N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogN8acq6uM/KxzUtUYg70soOrIjuSDzfX0gyNehfIHjO5Jvrh7vwE5oznE6OYM6Gkd7sl2O0p95LiX9dGh8esdSrbXqBTZtCmgrxUWA7o0JgJrF5Y5y0EQ3Vfn1FMCnbv3goGwE/ZXYA/9zD1f3292BsiWpjljJfsyGuyTWNtJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDePQA/u; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDePQA/u"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89c52db6231so40190616d6.3
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 02:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774778146; cv=none;
        d=google.com; s=arc-20240605;
        b=d+1egn7j8Dy439ebEl65/PD0DOow4AXPMeNa4PaEPwSOSRmEPQYrBroVU23Mj+CDXy
         HNTKFxFJMGlRMJ9UW4ruHud20n6YJkp3d2iNYyJK+18R0SFtOvxqLBgqaSLI8YTERPtq
         1BicyUS/G9fRicZbT5kU6mrvIGOwJY0Xk24yzIN4CBDys19jmkeCW8SQl3X3arH99F/o
         iM17W2jdhvTiV+7Y5htdC63XU0y+RWu9KtxXsSN8caG7WvSCHkrDbJubHww2ZdKJlikv
         zJvRhDqs4NdBUMZ0M770yfSXTGkKATDFu2I2vFSR1fhMYyDZNcl/eK/PDjvFMAA4KBEE
         AT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AAgkjuTHh3Goca0vLITimSRWvvXc5TW0N4ufkfXWmAg=;
        fh=T3RqhkK6Dx6nDTDoAUbnq5WQEHSukdYBVXt/LlY49Uc=;
        b=cmOPlgmAjlZaex8hNXJDvjgwAnZ/G4ZuErwgBny5GTAsEAnlzZSc/ykOYIjVDGvb6i
         lCsxGY3hch/eUxd+mKojgCTnooF7FMr65bXkwMSSvXn5zLJuVYR+vbaVQkH0Q2LvEM99
         3+jTGbosfaqbxoNKT/5hyuxZGWf0zILvBVOIpg7i2iWEtDfRhDR1IOCaeDSdz4UIHdXo
         x988lkap/G/ZhJvsW7xFaBtsi/B3A5munwiP42bRiHTuW0h5Dqf+HvJBnzSkba6QP2T3
         FtPmrGAnvd3FCNex5YTs6Tdgq4AWVJYHG+yHSKAAhrEbC1sIesimpTeh/6+yVyOsTmmC
         y7wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774778146; x=1775382946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAgkjuTHh3Goca0vLITimSRWvvXc5TW0N4ufkfXWmAg=;
        b=lDePQA/ul/usOGv5/B50CMO48Pqia4b4nofv134+3dVis/1raGvpuScku3vDrzdXRR
         38clXWdciXK+uykw0gYBbDVfYHX8JOxdApXRnIuJ3aEfrA7dWb19877d8kTRdi2XOr0y
         cRjWToa1fRJJUV4cO/FlNLxfdXYpwjnpfUPtWwsf8afwm38PW8qOy9B5/fPsb+0K3oD3
         RtXvvMrF46qVgwpvuNPJJYsrqfmZI223omrkq1/yVzldxN0TZHhIgLgjfEHSNT8U1f+g
         Elf5pTJ3GGJgRwmEP/bzgNhkaoC2hrEp9YCN1iOn88JXvQJDuFHfwuKc3pw7Wfx92AOz
         7ZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774778146; x=1775382946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AAgkjuTHh3Goca0vLITimSRWvvXc5TW0N4ufkfXWmAg=;
        b=NvNsmCEKOrtszVD7WBqly45Hgidb+dU6TFF9KsgEBFquFVsR4oSb/Wu+b547KIco6J
         UtGzFGMNLdgse1omXWgABvVuvXl6cdXZbINayZLD+7OglWgupv2otvVr5FI0/UdQthHU
         xnrS70aAmIIs3GsuETI31y5B3KLozc/HIbNwAcgBM133aOKBCw4+pLM4/w8wa6G6F4Wd
         dnel9Pl6TCrfqWixlXH8p+2t42SZPG4DrKf551m/miDCDE1AZBHZXP46fRl/CxuY/LUn
         l5kS/YnYEaJsY1zEU1WOatAbusaW3aaFCWP8GB8lgKdoPYC8wt5prwF6dFLbW6AXl0DP
         lLCw==
X-Gm-Message-State: AOJu0YzeBx6fpgl8ogU4hnfVWQ4HL3148zXFUoyRMB/1HJWd93chT3N6
	5UpcYQc2p7nDK4QqIbZ6EaR5QOCOpGJALhXj1HAZms6EBhdyJCpkNHlu1DMQxGI9yuBSuHy4E2u
	59hmCC5iu6pg+AQgkvk9ODcNq4z8ZC1A=
X-Gm-Gg: ATEYQzwWQ5ziWyB0+IvJGb7Lrs6vBY7DhqpSaVZZCCB0pXN87RTCa20edpGWSbZCgAP
	OOV3G6ZlberAyozCMlpcz/7hb9s9hoBW/XqMBRhVqId80bs0rXJ0EfTJSjggQvMCd5sdLZ5kFr4
	PeYFCmqUtOviHNkOV12rLbVPD4pscon8+YvYxxweRTbxB6DTIo6Le2sFKlFXG11VTQq8wzOvbWX
	iJ9Qb3OO/TKDuY9wwu9O8HOJCjHo4XdCYhCFZanLVc2wjlOuWiSlGcd1RKsmHOO3L8PeNSFV2IL
	T3QrclPjsUNSUiZbGehux0Thdkwd6F2nbMuPL/yBlB9VfqUfnZBk
X-Received: by 2002:ac8:5acd:0:b0:509:17e4:cee7 with SMTP id
 d75a77b69052e-50ba37f5b8fmr121380211cf.23.1774778146100; Sun, 29 Mar 2026
 02:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260328141146.1095115-2-shreyanshpaliwalcmsmn@gmail.com> <c3f032e4-d50b-4e35-846f-5f5da95f82a6@gmail.com>
In-Reply-To: <c3f032e4-d50b-4e35-846f-5f5da95f82a6@gmail.com>
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Date: Sun, 29 Mar 2026 15:25:34 +0530
X-Gm-Features: AQROBzBMGHSqnrlgt6OqRght-uz9cDQxLmSzA_byEQOARTKslltHS6yMDFU8jvc
Message-ID: <CAPYXD64H654k0RoKDiU91dsj0Fr9mf+f46Vfe54K+zueMzh+0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] refs: make branchname helpers repository aware
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 10:24=E2=80=AFPM Tian Yuchen <a3205153416@gmail.com=
> wrote:
>
> Hi Shreyansh,
>
> On 3/28/26 22:09, Shreyansh Paliwal wrote:
>
>
> > @@ -5,6 +5,7 @@
> >   #include "refs.h"
> >   #include "setup.h"
> >   #include "strbuf.h"
> > +#include "repository.c"
>
> I'm surprised that it doesn't cause any errors. Or maybe you haven't
> build it yet?
>

Thanks for pointing this out. Apparently it didn't raise any errors in the
build or test suite. Will send a reroll.

>
> ---
>
>
> > -int check_branch_ref(struct strbuf *sb, const char *name)
> > +int check_branch_ref(struct repository *repo, struct strbuf *sb, const=
 char *name)
> >   {
> >       if (startup_info->have_repository)
> > -             copy_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
> > +             copy_branchname(repo, sb, name, INTERPRET_BRANCH_LOCAL);
> >       else
> >               strbuf_addstr(sb, name);
> >
>
> startup_info itself is a global variable, isn't it?
>
> I think a more appropriate approach is something like:
>
>         if (repo && repo->gitdir)
>                 copy_branchname(repo, sb, name, INTERPRET_BRANCH_LOCAL);
>
> I dunno, just a thought.

I hadn=E2=80=99t considered this as it is outside my scope of this patch se=
ries.
While the change makes sense, I am not very sure whether it could cause
any behavioral change or not.
Thanks.
