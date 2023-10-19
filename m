Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE4F2375D
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaonesFP"
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F8EF7
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 06:18:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27cfb8442f9so5200603a91.2
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 06:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697721537; x=1698326337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh93b2Fr71glkrEybTKW2nXsZT3AOEpKSL07ujRJYTU=;
        b=QaonesFP3aQd3Xduq2CYAcUYSJse1XcJKSVxT6eSGzkMaf4Rfn5o+W+yv93La+/LQq
         RSJ0hw3dB56YwvjHNHE4WVw9XeKRk/I7OKMnicJU12Ub6w/neO4vf0UdflVZnJzy2iXt
         8+pY3VoFJLP8LbhGfitb5KngwI5umgyPMILu5mfKGq37UFI/EZolfVRuXQ9+vAhgG0G5
         xvzAxobhh3bqplYbIi/kuAD7cGKMinNzFUVtPKFjCrepxaKzZJ7A1WLKtnZL4uC6O/VS
         OdMoioIjXVGdq5bnOgR1bv20l0y4cGLPE86QJmkOh5JwU0MhQmzDJwjfuRpNDx6PU8HQ
         fd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697721537; x=1698326337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xh93b2Fr71glkrEybTKW2nXsZT3AOEpKSL07ujRJYTU=;
        b=PKLzDcbuNS7qzgkjnn7k59aBVrZFsWLOyjMPOhyOgYyoLYxihJ2MmY9oogWFUe7dns
         WNWP5hPWVqBz340byGepbXB578RXWIUbSqvK5nNgn6a6MRCv/CPPe61q3Zz4zNaF3AUS
         r9V+rM3zZXc8Y/twgX+dkfRgFNgPGkoLlzTf5phXrGxQr0Wz6UF5a/ii1UJ+3+oksF97
         sPLr9I9hB4mNmkyCM18OLiYzQTlmRRoZe1LsBs+xipMJbwsLcDkqxLRFQqeBUDjtgEpd
         +868v31J/t9/XvN/Mt4Im5jYyYhslrX4xp5bNvbK/EpUWmQ2Jz4SZ8bGxgkUV0kVO0aR
         yujA==
X-Gm-Message-State: AOJu0YxVZ3mxKKcJecAs9UeR1/FWHC+3cXrcmcx7jEoO0QGTe1DJmwpH
	nCUK7OCMzVk66Oy6ddbPixW/FrpvK1MWYM51Zns=
X-Google-Smtp-Source: AGHT+IFxyvHWbcI9nseMarsSfSqS4dJN5vHcr8ea9jQYdukA4C2GW8ihvHuzD6J/quR7K5TAp77YfBKd+kwHPNCWm+E=
X-Received: by 2002:a17:90b:2744:b0:27c:facc:e3eb with SMTP id
 qi4-20020a17090b274400b0027cfacce3ebmr1870522pjb.31.1697721537069; Thu, 19
 Oct 2023 06:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKFQ_Q9WjF9i-Rx2jdCw-adPVQrWNfNKrDY-em8Rpa5RNLXz4A@mail.gmail.com>
 <20231014135302.13095-1-martin.agren@gmail.com> <xmqq5y39unvc.fsf@gitster.g>
In-Reply-To: <xmqq5y39unvc.fsf@gitster.g>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Thu, 19 Oct 2023 15:18:45 +0200
Message-ID: <CAN0heSqmZ7QXJbet2Tp=YYCjBLToOHtNy+n=zcf29XYaukYN0w@mail.gmail.com>
Subject: Re: [PATCH] diagnose: require repository
To: Junio C Hamano <gitster@pobox.com>
Cc: ks1322 ks1322 <ks1322@gmail.com>, git@vger.kernel.org, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Oct 2023 at 19:15, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > Switch from the gentle setup to requiring a git directory. Without a gi=
t
> > repo, there isn't really much to diagnose.
> >
> > We could possibly do a best-effort collection of information about the
> > machine and then give up. That would roughly be today's behavior but
> > with a controlled exit rather than a segfault. However, the purpose of
> > this tool is largely to create a zip archive. Rather than creating an
> > empty zip file or no zip file at all, and having to explain that

Correcting myself: The zip archive would actually contain
`diagnostics.log` with some general info about the machine and Git
build.

> > behavior, it seems more helpful to bail out clearly and early with a
> > succinct error message.
>
> Without having thought things through, offhand I agree with your "no
> repository?  there is nothing worth tarring up then" assessment.
>
> Because "git bugreport --diag" unconditionally spawns "git
> diagnose", the former may also want to be extra careful, perhaps
> like the attached patch.

Good point. TBH, I had no idea about `git bugreport --diagnose`.

> +       if (!startup_info->have_repository && diagnose !=3D DIAGNOSE_NONE=
) {
> +               warning(_("no repository--diagnostic output disabled"));
> +               diagnose =3D DIAGNOSE_NONE;
> +       }
> +

When the user explicitly provides that option, it seems unfortunate to
me to drop it. Yes, we'd warn, but `git bugreport` then pops a text
editor, so you would only see the warning after finishing up the report.
(Maybe. By the time you quit your editor, you might not consider
checking the terminal for warnings and such.)

So I'm inclined to instead just die if we see the option outside a repo.
If `diagnose` the command fundamentally requires a repo (as with my
patch) it seems surprising to me to not have `--diagnose` the option
behave the same.

Martin
