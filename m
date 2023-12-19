Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F9738FB7
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwjSqSW0"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so22954931fa.1
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 09:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703008547; x=1703613347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3lJvDwqV6sjAHOSDq8GbaFsFBniSrAQdfzv9xme0p8=;
        b=lwjSqSW0qE7hRPWFNvhAn0FHkq1Bx77Vyo28JWf0NsUU78e3V+emISIiPNhaJTVhM1
         dR2kBA/6bEKCgFr+tn7EcghZ+KOGQBz0l7628ffIt3qBzIDB8p4vcCNjsUoL7IeaEtWK
         p6qsLC38lBjNM/iJpdDagpu1mgLHCj7TGtjGAiaw71YuhMJ1Br2E07Qaplz5H9LCZeUB
         pCbD1lAvfOM0JaoRGbT2ytiVvwjexBFGtGZ7fZIBYTgi7dgt6z98+bIeIt+jEdFYOGrs
         bKQppag2XlTM3p9dwiRVitW5VRDFFVpw/eQjzbXi4zYynjEvw4k5IjX1zBrdtIqHs5rM
         IOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703008547; x=1703613347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3lJvDwqV6sjAHOSDq8GbaFsFBniSrAQdfzv9xme0p8=;
        b=Hft2lGsw5K5qQe/8/UQAOvdcgmaOXmBU1q1DUjuAPgoHd15/zxYVKQ4RdK9GiPOvNS
         WBU9oS/m4utSZ7LYMfZ3eZz8yi+Vwd0lGUaczzk4xXU/1zxBmwdZD/ht+qN6mLQOuUA1
         QHGxdXgDG5B3zQala3qRuL31bwUaYAu8e3Do7IKrpCrgq+cN0zsvKk0ZuMV8e41z4aiI
         uoxC+jErkGiLtK9jUfRaEbqvduT1LOhWQ2ow9LSIo5eP8O1tlOfpazaoLHbo0QX8etua
         /HCdABzrvvIjXnqbVruLZitjvts0zcu0cep2uAgoUi1TbjxDRiJxrAeyy3siZqs5ECIc
         hOvA==
X-Gm-Message-State: AOJu0YyVmm+1PjSDqi2b7spxTb4kpDMbwQcjphqwabKTDWBOi6mKw4mo
	h95jC+Z2h6r17lIyH+VmsgdzEZ0fjb4Y7//lfrrRYkyT
X-Google-Smtp-Source: AGHT+IHeFVIy/nquptTxaGJcWxf3Vu8Zg74Gdg88x1oUHq7GwOw7ex8kdOTZn5GAE1zslYd/YNUUt4m7R1djch2iXWU=
X-Received: by 2002:a05:651c:54d:b0:2cb:2d09:791 with SMTP id
 q13-20020a05651c054d00b002cb2d090791mr9584311ljp.3.1703008546483; Tue, 19 Dec
 2023 09:55:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPMMpohbQK+3o46iiY+0o=vS+UC_HBB=CxsNT_hAb5dDz+514Q@mail.gmail.com>
 <CA+t9iMyrLAekwQHNky4w9nWD6WwxidxwfSmbqCpSRnkJgoQ0LA@mail.gmail.com>
In-Reply-To: <CA+t9iMyrLAekwQHNky4w9nWD6WwxidxwfSmbqCpSRnkJgoQ0LA@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 19 Dec 2023 09:55:34 -0800
Message-ID: <CABPp-BEmgOAj17DozyXNaf-9CawDic4uTpMbckef3+zHf7URqQ@mail.gmail.com>
Subject: Re: Is --minimal ever not the right thing?
To: Mike Castle <dalgoda@gmail.com>
Cc: Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To add to what Mike said...

On Tue, Dec 19, 2023 at 9:25=E2=80=AFAM Mike Castle <dalgoda@gmail.com> wro=
te:
>
> I believe that the diff algorithms available are the same one's in GNU
> diff.  From https://www.gnu.org/software/diffutils/manual/html_node/diff-=
Performance.html:
> """
> The way that GNU diff determines which lines have changed always comes
> up with a near-minimal set of differences. Usually it is good enough
> for practical purposes. If the diff output is large, you might want
> diff to use a modified algorithm that sometimes produces a smaller set
> of differences. The --minimal (-d) option does this; however, it can
> also cause diff to run more slowly than usual, so it is not the
> default behavior.
> """
>
> Since it has been that way decades before git even existed, I suspect
> (but do not know) that, yes, analysis has been performed, and it makes
> sense to keep the current default.
>
> Then again, in the decades sense, the entire stack from hardware to
> compilers has improved, and maybe it does deserve a revisit.  You
> could check whatever email archives is used for diffutils and see if
> there has been any discussion on it recently (say, last 5 years?).
>
> As you pointed out, you can set it yourself and see what happens over tim=
e.

There have been various discussions of diff performance, quality of
results, what the default should be, etc.  Including within the last
year.

minimal is guaranteed to produce a minimal diff, i.e. fewest total
subtractions and additions.  That is sometimes "best" quality, but
definitely not always.  On the performance axis, in special cases
minimal can be nearly as fast as myers and the other diff algorithms,
but only in special cases.

I think patience or histogram would make better defaults, at least
with some tweaks.  I had some patches to improve some worst case
performance and quality results coming from histogram that I was
working on in early 2023, but those got put on the backburner when
$DAYJOB pulled support for my Git work.  And I'm not aware of anyone
else currently working in the area.

Hope that helps,
Elijah
