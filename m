Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792730101;
	b=4OrIqhLPGEefcKAW1AXUMVWoHoqcDxA+G3ehvyCn/tPG3R08+ETpmBI1rYTywpz4laXx
	 K0hFoTEdCDUUKNCL3hD6bPDf82VAt2oAR/vrrwF0Jf/u20pGyqMiiRV57FDIWtZ5/PswO
	 eTNQCkvy3sy956gx0YHZ0edF/8K6wEQ2HQ1MGwLHMIB0w8B3p7ofKDjCvI+GtvUM5zSEj
	 uph8LYNUBpGi/xX+al6ymQG/yUCqwTDRFoe1u2MyQ8YbfoItGHzkbCBYr24BXrjONzuwO
	 /96/P1qBLcenTl534QkjoMsqY+yLFIEOQY19pAEMETbpxZbj4j2cfVa3tVy2GO7QV4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792730101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XTtPcExagnMS3NZyEuVPvBlxLHTuwiFqUvzEt+TAWJA=;
	b=vDOHtWOKeXfuwUnvbUN1W8JK5mZAZImkvdMqIXNrR54lfjFD0YcqOBG1FSfSRTNi/JBt
	 sHmWTKOhsio2aoJ6+C0gwuFJoLlC4506ld3DOdUIfQRukzcEnjnPwlxV4z/C2o+F/c6lz
	 9+iHz6GOgBAL0sQtFZWv1F0B26ghUkXr1JEmclGZMauC9W2pTQWyq/qTcB23wdjfpQLCG
	 tNyHtviHxxDpXvnz1TWFuMPfC0W0YK99UVqWHk6trUxSiPVpJB2dMc52u86qD7BdY/+am
	 t5hvZOmw9EmdSTUftVsWDvCgua5Xc/SrRV0y1asJV4d0oN4OUOV7Eq43hagoLUiLA+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="V3/Bp1lT";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FDD606A320
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 04:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37FDD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V3/Bp1lT
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91b55859245so8241636d6.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 21:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792730100; cv=none;
        d=google.com; s=arc-20260327;
        b=N+O16t0aHmsGRPHRPQmiAY0EuBF0I3N5KstOItgkUrLSyR6jVcBDd70EAStrd0gJX0
         Qb3TIo4iltdqgDMuRAE+KDmUnVogqfVYyMIIJLXjXP8KWqLTFOlaQcMCa6WnQVqHzuaB
         gZvGVNTzfAY7NAZoQLwuUjX01GKcLqIpypp8+e0Wh7ODk34ZeRgGXBHsL7uCxZlV6WmO
         Zr+5rdlgz6gADe91/501K+XdL7AWME139m4/YXn/+3ZVXR2BK8MpaxjgB0GHknHjOfkb
         cja4Fv3bC6cPGF+TnHP+1jlfKpwJPXJC6riNB0rg3nTDVKU35wCu5ttfXfRabog4e0k1
         Iw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XTtPcExagnMS3NZyEuVPvBlxLHTuwiFqUvzEt+TAWJA=;
        fh=9gtdUkN+VQ5mnNRq42KgUL4cO5wiexsALWc/m6cG2OA=;
        b=k9DIPioAdvdttX0rM/fpWa2O4eg4umLMS27TrLRsNCbjVTWCiDrbyBKXs44kUchow7
         gHk+PDOgmqGl6ZSwx1OQh6i1r8p4d7VmdDl7ZWoYQPoXuJXVjx6IxDpgLC5lPv1ZuC4o
         QuiUmcAttv64Q84gLa14Ezbprg+xsz4Kpd/gFfOufL3Ih0qaSrfwD2XWOjoHkmGb0f/n
         piN2UZg7EPKodicoky9bWnDtGY7Qpb3WXV2o4DHsMckmHzAEdgRz9hg4OYQGp5776uiU
         tU2IBrGV7wkhXzKnZs7FcAoOdxoYFUX7wYTmFtlXR+h758YFBTb+W7XUc8IWptRwzD/S
         MppQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792730100; x=1793334900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XTtPcExagnMS3NZyEuVPvBlxLHTuwiFqUvzEt+TAWJA=;
        b=V3/Bp1lT+pTDwcP/kXgxfZ59a69enRQ33V0iWRDkQTuTfkPOrXFAXHlik7OhHAwUG7
         dPMZUVpeaY2BYAMLxEdE85CB91746RznUswSajvcrFW1ObAlDixYniX2BuboufzVD0tf
         WCz6KWMgh7/e/ElRCvS/vm94pBOFEi8eDl58mvdwhmunXyxZ9cw4mIPKBeL+OO58jlSm
         rIdwKbwAxpbShlYC/3mnWuPxWplKxJoTOLLv5ZYOvzHDInCaQ9VPn4alD+4HpEILNbo3
         pBvvUtqiUR7ArSVSlpq5R5lJs7eSRUlvxxc+pCPROikUInN9NNgcuJf4+QVnFCwnxmiX
         zP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792730100; x=1793334900;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTtPcExagnMS3NZyEuVPvBlxLHTuwiFqUvzEt+TAWJA=;
        b=kZf8vCb6sZjCtRaTLNodCTGJqWgk25nBNf7mPyez+BdsHRkykhnGrPf+yri2GScP7y
         lkxDvlPWkG/ZmwGAoFCjq515kBqM+HmLM8U9T90AazpkJPMC2k4LgZunsqcFsaTGSgAD
         rLx1lBM/QJis/zkApagGshyC3C0jwexaJKU4SlRhb17vcX+6VIJjPLj+AEtP2PRc2Eph
         fpOgTjLr8cld3+eha8MGh1jI5hLxk3jqXbu7gs6py00Vrgt12+ePkn6TY1obfvg8dOhr
         BImlmyOEewfluHLlrerurdWkM9BRQjZLfdjwXyIF1r3Eo7QXAOf4V2kZnS7gBpH+4Szj
         Cisg==
X-Forwarded-Encrypted: i=1; AKwUvBxMY1gHcn8n8ChPwyI1xyPONrzX+++uO1jqaeGjVV1jfPQX6IBx9N2qvrDGmGcZxzW5rXA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMsJs7cSzQb24XsYipdX+dX98h2wdc3Dg2/Ums0GQPLJk/T3GU
	1F+JG5kAHhSlvLRRTswunAunmBkTKD0nbYzkSmG+V2x6nRoKaHXRQcxaNvz3AjtFJ+701nUTva5
	REgJNHz8kxmZ823rNrdZqo8bBXYmb/Xc=
X-Gm-Gg: AYBFou1RH+lpF5kWBu3tIRdlYsH+AZLQnfnPItZM7d7bl2yW1jHUHz2fs33K4gAnVab
	px9b65ED+2YtcU62S0+4eswWJJ/Ff7pm11A333O7gpk9QxpssyTrG5xybgFhE0BYw+0j8kmKV6q
	z+VQZG2AL6/HiYTeamFl5aWilhcBmjlrGr0OyHIgQjlUCELlNzPBH92mB4QlLIT8+vjy5+21Ca7
	5q0eSxlDpWumETJKms3HBUb2gYWn3dcVfF24ICnByy3ImyZnwMVxpTpuG/tLSLwRz9tkHPq3rCQ
	yQumr6+oiMDn5FO1Jiq/4oUBI4rao+q/OCap68aVar5ch3vpQS/y7OKF3CRVF9m0i3AAKxGoeTp
	lS+T4/GrfBaM164oOKBblRX61Zw+URNA3Zz/l9u+8Q+F347RwiNOVPANuHh1R7rhNovzjUQ==
X-Received: by 2002:a05:6214:5b09:b0:917:b50e:44ca with SMTP id
 6a1803df08f44-91c3a9e0b52mr12314806d6.19.1792730100155; Thu, 22 Oct 2026
 21:35:00 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2260.git.1792299301663.gitgitgadget@gmail.com>
 <pull.2260.v2.git.1792666211685.gitgitgadget@gmail.com> <xmqqbj8lhcng.fsf@gitster.g>
In-Reply-To: <xmqqbj8lhcng.fsf@gitster.g>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Fri, 23 Oct 2026 10:04:48 +0530
X-Gm-Features: AclHuK8AaPb6VdfqfTYCTTeQ6ulrvvZbOT83I5my9kPCltuE-QEZECroxPW9B2Q
Message-ID: <CABh_KWhyZYaXa9Mtfu-XSW7k_KA1BnV31BjDev8wogUoHSjAfg@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy PATCH] t0001: avoid pipes in test scripts
To: Junio C Hamano <gitster@pobox.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Thanks for pointing that out! I've removed the extra indentation in v3
so the sed line aligns properly with the surrounding commands.

Best,
Srujith


On Thu, Oct 22, 2026 at 10:54=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Srujith Poojary <poojarysrujith@gmail.com>
> >
> > Avoid piping output from git version directly into sed to ensure
> >
> > that any command failure is properly caught by test scripts.
> >
> > Signed-off-by: Srujith Poojary <poojarysrujith@gmail.com>
> > ---
>
> You do not want a blank line in the middle of a sentence.
>
> > diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> > index f1d227f271..02217a9bf8 100755
> > --- a/t/t0001-init.sh
> > +++ b/t/t0001-init.sh
> > @@ -678,7 +678,8 @@ test_expect_success 'default ref format' '
> >               sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
> >               git init refformat
> >       ) &&
> > -     git version --build-options | sed -ne "s/^default-ref-storage-for=
mat: //p" >expect &&
> > +     git version --build-options >build-options &&
> > +             sed -ne "s/^default-ref-storage-format: //p" build-option=
s >expect &&
>
> Unnecessary indentation.  The only reason why you thought it was
> needed was because the original was (wrongly) expressed as a single
> pipeline.  Once that glitch is gone, anybody reading the resulting
> code has no reason to think that this "sed" is associated stronger
> to the previous "git version" than with the next "git rev-parse"
> line.
>
> >       git -C refformat rev-parse --show-ref-storage-format >actual &&
> >       test_cmp expect actual
> >  '
> >
> > base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
