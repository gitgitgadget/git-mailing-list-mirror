Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790317A2F0
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817878; cv=pass; b=V1z1R0hrs7EC4qjR4ZI80aUVYs/0ON32GJUnJoKOaPIrCB8/95vnI/UOUrZzTA7p4OK8bHXVrgegc53LCszWs3PK+gYawH7IktHlLoHBE2vuWRVTDrucOLbEkrOsgf8zczOV6BsrQU+aHtArBD16Of5GXZ/6VXivvCQoPIYA5vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817878; c=relaxed/simple;
	bh=FnZSBu4ktsNb3ZPiIR9UbyoWA4rFjb41oklojBiV6p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVzxulyQnHoU/jK0UcGTaOgCUh9S9sGaIBuOmDdSZCVhjHWrNSfQZbm/862DpMMQRWVLsU1opReBrUOuEn0Nv2mKMMC1rNtt+SY2p32Ehzcr9BmszT4fHBaG9MrWvBqPh151IOsZLkaohlx9zdK7UHPAA/QQUh/9sB2xzyOmWtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTS67Yrj; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTS67Yrj"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79088484065so37933417b3.1
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 02:17:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768817876; cv=none;
        d=google.com; s=arc-20240605;
        b=VoAkFWj2inxtNVPqMXO7bvVF2fa2e052akC5f5fS1RK/0aEyNdYodtw6A//QRxlLLt
         Kft6u1p5h9pHQWT5tMzvrNI79AWsIIv7UkpZ1VX5yPgWo+Nfa/j6DUAhocpTefev/h/5
         8nPGj8aM5uLSoTVS8/agATczXN31PHU2O0j5/g0mosXPWT6iykpqYv/Vc4uJrWv3fTrJ
         JY2Ng97L/deb0EqUiw66cCsQK9mvIWY49jr5YJ4/Cb2irFFgImIx7LF1C+oMlJ2mRr5p
         5kq/yAh1LwXQUMNVI18ZZGKW0qYUGiXsluGQI8rPdFUWMTA18JZHzFhMB4fHpcacL5+b
         DEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EOm0A7qtAptaew6Os/6cJlAzFbmvrNKRGF3DH2BHPG0=;
        fh=LXLRV0ehehwuql0dc9RY56h9a8dTuFWTI0G06CzlgQQ=;
        b=DCT43q8Tk2VhUnw1ZfdvfglMidfIdZ6dTAPecKLp4B3thCXdWxvzPBGLZdQpSAicso
         zhD08UEqeGn+lYuYDESApkq4EyRRuIunWl/brAnoRQbi3upfnaG2luOr6hdmM6oEEVZY
         k8bh5Xk/slnpq12mz30YH09GkWXEr77O4mGmQTVLicYc7avghbtbdvz0RCyvj8NEArRA
         6vBGKQs0w1X2dolGbNApFJKF0DBeM9nCJhA3qHxx7D1nVsBzbxRqxwesVZnM5ZeGvmik
         8XkfdF0yY/cfUskdBd5rMIMHd1nWGRMmFPekulCOI7tY5c0a76BWKLuSD7jPH82Q2pSn
         mSYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768817876; x=1769422676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOm0A7qtAptaew6Os/6cJlAzFbmvrNKRGF3DH2BHPG0=;
        b=hTS67YrjoP2IKtRz6DUFedGEg5s0oRl/GSmzA+mT43c6lV648Elwa52YLJ0Sz7bfA0
         zgTmEbPpSzvTGg7hnYNgesROGqV7zcvs8ch+Y5Ha5rugYAg1vZ3U4HqG3HhEA29nFLTZ
         dziYt3KWmaTipr2SJ5dRsk/BjIlLcyk/PAU1uUu3tqUCm31HB3F94OIBjLriW0Lknsj7
         gAnvG2mMMynQlERgMgz9lKtng4gl4QU58CQZIXZyLK/zAoXDowH3AKR3HEDO+4KtUpux
         V+UnQgS4WZSv8XmNHf6l4VaMpvn6yve5AiEK2csVtI+o7NYuIq7RLjf5hGlv+kiLsn3J
         Izpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817876; x=1769422676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EOm0A7qtAptaew6Os/6cJlAzFbmvrNKRGF3DH2BHPG0=;
        b=GeR05WTbgUi2OEPD5BvBwnelxAI4Ou+BikLqLigyTwvaHwmgMIiGhGOoSF8sY0pw8b
         LGJrhZQAgDerzW/F+Din41/EhFVgWFL3jXCaGmieyLXWxixxgBxQf/hsDo6h/ZFaQ9Jd
         1Q64JyPXSsDinDQD8bxdznQ/uQj0jZ+QkTITatQz8QpRCUKNtCAkurPGCfpGV8KfGzEs
         Xn/wsTdWzwqLwRR7NhcvHsEhCgGli704YuTYYu3k0QWe1TSOKzcvsLhDttnhaVghJjFP
         t2YrxixO+d5O2i/eqMKv+oFe6xJD/a88AeobOGcmMhnBaWb0eNSEuE2lHJ7WFhvZ21Hg
         rXxg==
X-Forwarded-Encrypted: i=1; AJvYcCXCo+VXYb9v+smQiSq6C7PNrJ6TAbj0w3SAZXTVqqKa47EjqiZZc39ArfnoQt+lu8US38A=@vger.kernel.org
X-Gm-Message-State: AOJu0YydxQ66ecYiP+Wzh8gJ/gEk+wwODhFQm+Ninqk329lwjMRPpWFY
	8rn/QxAwr4eIwuK7hGSZb7DjftumIJ7JnWBrFjCJKgJXVyVaKxj782aNdo7vxVyKuF43XE6VEZO
	choDZw7fRRxS0VaZTKumWdUA8zeMMbW0=
X-Gm-Gg: AZuq6aKUYnnIHjkrWYlIbfR0QlIJcAnbzm6DCun6h1NXZNG+ZxQrrx/LBGfGpWBaqDz
	TwPO3GXoScoj2fNXSUdPJTSEKjTEsWgQDSWz8A2C7AgRDO7CutpGLS0QEJ+d1vCOw9JBVfW0Uln
	8gNVHBW+x0FIJufSQNVENsdJIokr+ksQc9CCfpfTNbqwm9So3sVonF3FPYqXiH014XXcNGKV+bA
	yiNhWzQEK6x79s9DIHA0/hkosnZeqRujmCW1XQ82ODq2FBOJMMBXWSwI649pbgRZ6249jtZ40d4
	x6Hbl2t4g2fbMEWIGlZESY7+Bym0djYkKfCxSF8yYtKfcyIG5H69/+IS1EN/OgKG3SI6o6k=
X-Received: by 2002:a05:690c:dc5:b0:793:db5f:f8fc with SMTP id
 00721157ae682-793db6011d4mr108196337b3.10.1768817876350; Mon, 19 Jan 2026
 02:17:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3500e698fd40297d2e2634785529b76d49ca470.1768530514.git.zhiyou.jx@alibaba-inc.com>
 <xmqqo6mta7bg.fsf@gitster.g> <aW3XUxaomqGbtpEj@pks.im>
In-Reply-To: <aW3XUxaomqGbtpEj@pks.im>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Mon, 19 Jan 2026 18:17:45 +0800
X-Gm-Features: AZwV_QhyUi1PrUfYyrC6hUBLHGmRPbGrDnQrjLTkGaEAEKFw7zWw-SOiwkvufhM
Message-ID: <CANYiYbGn-ANF4jT2Lef+uL=sfcVWukBH7J71VaapGkaDaYHFZA@mail.gmail.com>
Subject: Re: [PATCH] help: report on whether or not gettext is enabled
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 3:03=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
> > ... we do for the curl library, so only reporting "enabled" does
> > feel perfectly OK to me.
> >
> > I would prefer not to see the "disabled" entry myself, by the way.
> > Combined with the vintage of Git binary that had these help text,
> > the fact that an "enabled" line is missing is enough clue to
> > diagnose.  I know you mimicked the Rust entry before this point
> > (just above the precontext of the hunk), but I think we should fix
> > it to drop the "disabled" entry from there.
> >
> > Cc'ed the author of cb2badb4 (help: report on whether or not Rust is
> > enabled, 2025-10-02).
>
> One reason why I personally prefer to have enabled/disabled is that it
> allows you to discern the following two cases:
>
>   - You have a modern version of Git that doesn't have gettext.
>
>   - You have an old version of Git that doesn't know to print
>     information about whether or not gettext is enabled.
>
> If we don't print the info at all when gettext is disabled then it's
> impossible to tell these two cases apart. That argument in my mind also

Both `git version --build-options` and `git bugreport` display the
Git version number. This allows us to identify whether we're
looking at an old version that predates the gettext feature,
or a modern version where we can expect gettext status to
be explicitly reported (even if disabled).

In reroll v2, I considered outputting GIT_LOCALE_PATH
instead of "enabled" for gettext, but that would have required
refactoring git_setup_gettext() in gettext.c. The benefit didn't
seem worth the effort, so I dropped it.

--
Jiang Xin
