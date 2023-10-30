Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384B15EA1
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7JGYyRo"
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C302A9F
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:18:28 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a62d4788so7200327e87.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698686307; x=1699291107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02/ULIouUYibY+jkLvETgXRxQjHMar6q16IrWznmR4s=;
        b=R7JGYyRo2v9v/Dimt6QY+u3YtpH/+P6VGF91XtpZLcNONoyCbiueRZ5TT4JXzIQ12V
         Tn1NDf87tcDaNDB1XlqH9XlDCWm2gs1GoHTqCTiffXqKxzYALjOC5oOWcCnoYvaWD8bn
         RYz9IWejo+bEAYD52Rkf0zHKEblJaLje6WxfWUzs+HcN/dDIp53Z8ETw0eY/xyZ1RZJb
         y873DRk8Nf+GTezNkcwClM1Ji4FC6+YH3Jgj+DRHXkcQdx2BOAhh2pzaM4TzxDvP0t9Q
         VSir2JVt+5K8+q4CrXHBaDGGmUQZ7RTzScGBRQNUB72XJj/cdXGlxufP3jCuVvOb1/1b
         vLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698686307; x=1699291107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02/ULIouUYibY+jkLvETgXRxQjHMar6q16IrWznmR4s=;
        b=bB8CSApINUEqrsUr0LEUhrr0IZ562vmUIZVhoBl8dVxPOvq9uVliiXvaC3s1ska6RV
         1kVN9X0K/vBepSkPZyEuXEITiMKljAk+bPDvl/NVduhjrww0/ZBP8gFDwfJ5WfqnXfCr
         5KqFg+9ztc4sRxNeruK/KUmbqw87XkBi3Vgp3957l7g5CVZldDMHiblrGCGoqOsW5lCw
         bMu04yRsaFDXeHMtOEpvRXGUuILquJsDm9hwamsYud2jTrLE/+LGTqcB69bsJBrKS3Fi
         yFvARjbYoFuHWHwa4CEmxa5AgyNXvKIHZS96GAcJzUNj5LxBRTOCCXbEXMag1ggwAN1f
         V3fw==
X-Gm-Message-State: AOJu0YzjDVzy38cqYfON5KZksZ6b2x/MQw0ej2yB176JszcrpZdjkR1B
	bhSKGpgQJqG/jVycHrwJRaU7wDL6YLVRGG5LkOc=
X-Google-Smtp-Source: AGHT+IGkYKpS9MX1rQmOOIyVpyCaZaqgmNAQLX/BPw+dXHzzlemWBgWTlu+6M+VeJu2w4WYk4VwNySoLyxLFm1Xx+pY=
X-Received: by 2002:a05:6512:3c8d:b0:507:b922:f920 with SMTP id
 h13-20020a0565123c8d00b00507b922f920mr9739739lfv.8.1698686306675; Mon, 30 Oct
 2023 10:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907092521.733746-1-christian.couder@gmail.com>
 <20231010123847.2777056-1-christian.couder@gmail.com> <CABPp-BGCzxL-kpOvZzWRTJcx2v18QHm5ev8bFv7bm0dyNqhKug@mail.gmail.com>
 <e04cfbdc-fd28-c645-8f5d-132f7ceec6be@gmx.de>
In-Reply-To: <e04cfbdc-fd28-c645-8f5d-132f7ceec6be@gmx.de>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 30 Oct 2023 10:18:14 -0700
Message-ID: <CABPp-BGfsda-8CK7_YPJfhGMfpLqdDeB8X6wnqPAGmhiY4KjDA@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] Introduce new `git replay` command
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, Dragan Simic <dsimic@manjaro.org>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Sun, Oct 29, 2023 at 7:14=E2=80=AFAM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Sat, 28 Oct 2023, Elijah Newren wrote:
>
> > On Tue, Oct 10, 2023 at 5:39=E2=80=AFAM Christian Couder
> > <christian.couder@gmail.com> wrote:
> > > * Patch 12/15 (replay: disallow revision specific options and
> > >   pathspecs) in version 4 has been removed, so there are now only 14
> > >   patches instead of 15 in the series. This follows a suggestion by
> > >   Dscho, and goes in the direction Elijah initially wanted before
> > >   Derrick Stolee argued for disallowing revision specific options and
> > >   pathspecs.
> >
> > [... snipping many parts that I agree with...]
> >
> > >   Also instead of forcing reverse order we use the reverse order by
> > >   default but allow it to be changed using `--reverse`. Thanks to
> > >   Dscho.
> >
> > I can see why this might sometimes be useful for exclusively linear
> > history, but it seems to open a can of worms and possibly unfixable
> > corner cases for non-linear history.  I'd rather not do this, or at
> > least pull it out of this series and let us discuss it in some follow
> > up series.  There are some other alternatives that might handle such
> > usecases better.
>
> I find myself wishing for an easy way to reverse commits, if only to
> switch around the latest two commits while stopped during a rebase.
>
> So it would have been nice for me if there had been an easy, worktree-les=
s
> way to make that happen.

Seems reasonable; we'll definitely want to keep this in mind.

> I guess this would be going in the direction of reordering commits,
> though, something we deliberately left for later?

Yes, I think that's a good framing for it.

Thanks,
Elijah
