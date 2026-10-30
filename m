Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793399200;
	b=uufZC7Aj6kklMHPjihZcEQMZ53W9HyW+sgJOoaEYLzqZW8vf47mybGuLq4sfIVGwoPiF
	 8CuAlosmw7SPDUfCgO0PPXkyUyVodurwyZw+hamS+MVDqVLU4A1eQHY9SXvR0kATcPaR4
	 5lwGhwTLalj3+M0BNYUz8yMe7amGXa9pnqOPpvoAPGxndEzE2sMFHF0DKt0F0ISV/dGrK
	 OPz5HrwZT3qVRpX0L1LSHhggmm+YqoivHE/GkZP8MvEDIwNZUXGvWRS2op3oQ/lntOaw8
	 aGEamI613WI0I5ofvIsKsySAuIAx4OwNe9Etjvxbc4DmlmK5w0U2IvFABTiwVg1PKuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=PbWd+f+xq6tQgR2tTxMhZodGNDpE/8mUMSjiX9ZGDT0=;
	b=J2fYHGbLd3j8UtDn9lrkfJv85BYbuc23wtiom3qaFH4Kpib7ggax7sV8itgmG01uIkSG
	 gddyfe7DH7vQKfbNDDidJrA8RQxWN6yzv2FMQsO1ut2MxCf5xtUcVFn8ybJJrLzxLW9PI
	 Zi+wHip61TWBUKzAMn/ni1Y1MK7ikJBi7CSj/+uZIa8/Vw/yiGPosinS0kfXT3ahDhaQC
	 yLbDo/CJu4QhoEIuSlWwJAi/Er4lPtAz02uNKZBf7RyVJJQ4rTqH7PeprGfCX7dUn5LL/
	 4Oz+LfV9oPqTkoxR3S3T3Jz0DJsiNVXq7LNGPj0FWD4Y+Xq5HEjyEHy1DqvwAt1ux1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M4q30d0c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FDF606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 22:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91FDF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M4q30d0c
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1b13e09ffso1693971a12.3
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 15:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793399198; cv=none;
        d=google.com; s=arc-20260327;
        b=qXwxfZnz7R2uF8Rm3NgFHXhN5dRzG2cwKf15BGkR042axr802TdmNE+l+U+5bCbuBZ
         00QvEgSke5Wcsys7NIXQRLkQK0Ln9R2JTSz9fNqWemW8dWfKfuwcyBujDHLNYiC1yPj1
         fmPxzVSH9/CcLkpZBFCi+i0Ws/1sga6icop5DTZrsHNAwd4V4FUGH5bpCKlRL6hKqZPO
         PDWify5zW1aCOSfwriExy/M98fWGwonwm+FajDJtDt4tVTaEDpKCc3naRe1evUnCzG1G
         6r2H5y+YHHLKthgAuksqwmWFzUQ+kA5wR4ZoLw8Rps6WXxoDUC6TBt1wgmwJePeO+V8F
         XSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PbWd+f+xq6tQgR2tTxMhZodGNDpE/8mUMSjiX9ZGDT0=;
        fh=3x62OFMjTkkVBNeErRAjb7TASM+JA6pwOLpeTC4KSQI=;
        b=q7Dnav6Thrgtl7pEYMf5EKM+CJgAWQjFhSgv6mCMfUjoeEcMbtnsqNKuRr98Nqkoz+
         nW88dxwDo+IGJVhy8Kf9lW/kwQ11Lt7jmMS6AyxsIOS79yKrM3QyFqw3z68KDmsMcKz7
         TrmTduSvAEN/JvrzLMy2BUwpCOZwLGNSVay7SXJQSc8x+eDQyCxHS7QGRPs8TdHMwJjf
         43Tl+iki2ddOiyMDuxmkAQxgjXKluF1JfdgrIB9oKHzc6rBTdY6qeiZIVxnmSaNs2V6D
         ooWH5xTWdKve2opNS3pxMiASDzLsItOvVJzmiHs+ENPa8vt7GdblKOr2zmeHnZva7j+y
         Ufzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399198; x=1794003998; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PbWd+f+xq6tQgR2tTxMhZodGNDpE/8mUMSjiX9ZGDT0=;
        b=M4q30d0c2dLambovpWhm2vmhi9Z+7aHrNUq4XQxsUeoQ8cvKQIiElO8vu6S8ppyw0/
         PsFfp7Aia8xd17ULPou2hJGG32rsA8sD0Ur31HA9BQpOb56ztCvBYiIkD0s9d4ZOnIsl
         8cCBSWgTow5+5me+sHsOKnwfoW+LcrBHiQWgOAiJ5LqVj6I7X4dbcubX3+3sUrflJ9Z+
         nx/GNIL5b3VYFyS06vw7G+k+xOY5U+TCF0PiMkR2Qw0L+HHGzxzu3Zh5BZNWUk964TVg
         ppbaAxNtB5UpsTKYxGcYHqHmtRaRaKhNLEWXZ9FeNj7fQsncu6sdra9uP9/quGeyPBAB
         EvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399198; x=1794003998;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PbWd+f+xq6tQgR2tTxMhZodGNDpE/8mUMSjiX9ZGDT0=;
        b=ZXm2I//hzpuerapKDelPfyCCvrA0iTiu2MyIXX0X2KeQHJa4SHexRrSyXWfcKRBpmU
         8yYjB4YsLaULp9re9m2Fz7bz8ngNfANlZMUhosRMQZ/eGaoxt/nYhdBIwBuKCHIcvZQw
         qsRwiDY9bVfolNKPTMAmnRhOGkGQgYx02H6m/DH95U6KLDb/foOU0SbmCe5fV0G48Tuz
         2ObpcvGWwL0DHY+y5CPCDGEdbqItPbxnr/T1Cdn035LUrE8x0djV7eJp1dJ7v4WqBkgz
         J5ePLZ5jOhU3/foJ3E83H4XcYeA+eglqztN6YTXZUOGTRiKDIgJW22igai5rFpISCQnW
         DH7w==
X-Forwarded-Encrypted: i=1; AKwUvBwRElUbGgXquhBLuum/4S4RCApXVZJWF4LTjuhr4untoLy4/xfjb+5M2Wq077R3pFR6wUM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOhpirtEHSzM8q34emuRFv9BwEiEA8HcoUKGL9+U/T1KjdwNMo
	T7+PamJuZSBZYHUymZCvdEGhkE1qEJ5RSVWIzn0L2ufFEjBDol17XIUh136eyH0zuQ0UQxs8O2h
	4NnvDEFiHJ4XQgMjbnnzxFg5vsjz+hu2nf9b5JwkTxQ==
X-Gm-Gg: AYBFou0dWTtSAJWrVbY2nDs+9eUTNmv7Cxcuv8mDOjwHoET7QnDUVe2SZbC1hKsIzia
	tsKwJ7NBf5vBfOB3m0HGlw1pEZvLuVagexNxxqHTaOOSAV+KgK0njwoTsdzqNNZCEve/DXMIAKv
	AJUmiUDBK1hjw9s2agml5A9ZONuYPuboA/JN/Y0+IVTP0m7Eck3eghGhXl9OCDYvumgTPATB1C2
	ZXA2Q64fEicL9pnvTsRw8pfY879q+eg9vncxoW/nZHA4tGi6f5X5OI7YuUvKYGBzFGAyVnSdZ9S
	Spdpgu1GY/QUfFASmxpRHaofbbJu0TSP8+V8Dge9vHGo7M8CSJAwoa6XeT4Ma2rk9rF+Jp8pDDj
	luaR/FQsmXgYTkHA09/tgnZuqCUpRNLnp6XZXIRh4gprDWDTPcUIwziq9
X-Received: by 2002:a05:6402:5009:b0:6b4:d731:4bf3 with SMTP id
 4fb4d7f45d1cf-6b4d7315217mr2768360a12.41.1793399197909; Fri, 30 Oct 2026
 15:26:37 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2464.git.git.1793104847288.gitgitgadget@gmail.com>
 <579C36BA-1418-4E15-9CA7-70C752A69FCE@gmail.com> <CAHwyqnX3sR9YxfK3NtPxVgmTfzfbgXX2bzPKzGGAbfC9k1iF4A@mail.gmail.com>
 <CALnO6CDpsQtAX0rHr9Cuot08K4j_6WMpiPOKA38sjDbWB-wj7A@mail.gmail.com>
 <auGln4usFADtcUPB@pks.im> <CAHwyqnW8kx7BmGq99twGfC2ZB0u0sj17345dcyZ7sxw8A4ZZaA@mail.gmail.com>
In-Reply-To: <CAHwyqnW8kx7BmGq99twGfC2ZB0u0sj17345dcyZ7sxw8A4ZZaA@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 31 Oct 2026 00:26:00 +0200
X-Gm-Features: AclHuK-Ek5YzquNo_rCqFIPcXCRNRSLTBdAJe-2HJhPTXyxDVqhYIdiiuMzX_pE
Message-ID: <CAHwyqnWw6VpR+4WUMEn9LOhqUyd_sGSbFUqP_p8wui2NZQOiRA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: let ccache cache objects built with the
 precompiled header
To: Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > > > And, what about Meson?
> > > >
> > > > I think it's not touched by this? My goal is just to speed up my local builds.
> > >
> > > Yeah, it'd generally be nice to keep the 2 on par though ;)
> > >
> > > I don't know enough about our pch infra, though, so I'll bow out from
> > > here. Just thought maybe we should make Meson do the same?
> >
> > As Meson auto-detects ccache I'd think that stuff like this should
> > rather be handled in Meson itself. I e.g. found [1], which feels like
> > the right direction to me.
> >
> > But if somebody wants to implement this in our instructions meanwhile I
> > won't complain.
> >
> > Patrick
> >
> > [1]: https://github.com/mesonbuild/meson/issues/14662
>
> Ok, so I'll leave Meson out of this. Maybe I'll look into opening a PR
> there instead.

This has now been merged into Meson:
https://github.com/mesonbuild/meson/pull/16317


Harald
