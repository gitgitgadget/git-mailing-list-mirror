Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC941863A
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbREJsuX"
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DC71A4
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:51:37 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9db6cf8309cso1001988166b.0
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700059895; x=1700664695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EakWMbkOEpnruJzBuytWIPcZeFZTiR7kbvQalE+4Ylk=;
        b=FbREJsuXNDN3Q/NxzwGoUCRxXVLhEheJ9EYbOlSaRCGCDJ+ARwqcCm/3pBMwaPTp+q
         DPgt+3FxxB+82cO67ZnKWCNoWn7ymgZ2u6O3rmNXh1VQdTXaooZJVix8FCBOrP0CIw4M
         XHSm1noHl39Cn1TashKWn494Prs2D+WDqbRdwubg2AvpuSyqwjKrQW3T+aifHSa/qoDr
         vc4jvrRua2ydHfeNqy+elR4T2XkgkKop52KT2EXRW8a2BqJmdLlNao3/a9rqxaFu2QLA
         9Ga4Ehhw0L33E4h/xCF6tfazsNFCQzcs0KfzVVrp+pVslO/ZBVVz8eH8kiNrj5mH+hir
         c4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700059895; x=1700664695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EakWMbkOEpnruJzBuytWIPcZeFZTiR7kbvQalE+4Ylk=;
        b=np9VWX8xET/SekvxJgdDHnsemoyYsevojWTsHSxhgsurRmwHqZ5g2LUXbbEc+z5Tw6
         LiZ6/wHwPFHSE1Fy/Dc+6Ml7REUmONvGP7VdOmGm7y1g+Qu01i/zImMm73d++3GS3ZxH
         fbxPaB4KUv7tE2LaArrZNoIgbLb0rYdt4Ep0nkW6qnBsTPIPHtY+wIHDq0kU8A6TlwMW
         ptSjEKBebueMacdJo7tZkicfVOC9HDoWE6dPGOJLPE2pffL1FjznoMUzfzLrp783TMsr
         99Ygs30NFJfXEl89erElQcBQw2g19T2ar9n7HOemTamaiYxxSWQcQVbrZ8xc+19uOcrr
         hEQw==
X-Gm-Message-State: AOJu0YxpjqU6u/n4hcRDwOZm9Kn1nJmwx2UgB4I4XYLAKU31qg3KfW52
	vS31JQNB+gImoJGXqo6fGlhYvtdalTh56smtT6E=
X-Google-Smtp-Source: AGHT+IG8HNpKmOk3aMW+0k841nCBQ+UEh3HACVXioSeYFBQH7Z2efTB4gWCZxtzmVOeXyTnZzYDnAbiaDOQ1tdNV7e8=
X-Received: by 2002:a17:906:b28a:b0:9dd:7db7:a0af with SMTP id
 q10-20020a170906b28a00b009dd7db7a0afmr9292155ejz.56.1700059895371; Wed, 15
 Nov 2023 06:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010123847.2777056-1-christian.couder@gmail.com>
 <20231102135151.843758-1-christian.couder@gmail.com> <CABPp-BE6G2qaF50bhz-CwxSsvxGDHzwvsWtfQO4zVcX6ERppLw@mail.gmail.com>
 <CAP8UFD24fzhiecJtANqEsxvh1mxT4pKR=QjfUFZh8C6HQE-k1A@mail.gmail.com>
In-Reply-To: <CAP8UFD24fzhiecJtANqEsxvh1mxT4pKR=QjfUFZh8C6HQE-k1A@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 15 Nov 2023 15:51:23 +0100
Message-ID: <CAP8UFD10Ej1EQKodG=Ujd06X0Q7QXcDdXKU4mH+4-9Ox7Kt3+Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] Introduce new `git replay` command
To: Elijah Newren <newren@gmail.com>, Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Calvin Wan <calvinwan@google.com>, 
	Toon Claes <toon@iotcl.com>, Dragan Simic <dsimic@manjaro.org>, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Elijah and Dscho,

On Tue, Nov 7, 2023 at 10:43=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Nov 7, 2023 at 3:44=E2=80=AFAM Elijah Newren <newren@gmail.com> w=
rote:
> > Looking good, just one comment on one small hunk...
> >
> > On Thu, Nov 2, 2023 at 6:52=E2=80=AFAM Christian Couder
> > <christian.couder@gmail.com> wrote:
> > >
> > [...]
> >
> > >     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, =
const char *prefix
> > >      -
> > >         strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], N=
ULL);
> > >
> > >     ++  /*
> > >     ++   * TODO: For now, let's warn when we see an option that we ar=
e
> > >     ++   * going to override after setup_revisions() below. In the
> > >     ++   * future we might want to either die() or allow them if we
> > >     ++   * think they could be useful though.
> > >     ++   */
> > >     ++  for (i =3D 0; i < argc; i++) {
> > >     ++          if (!strcmp(argv[i], "--reverse") || !strcmp(argv[i],=
 "--date-order") ||
> > >     ++              !strcmp(argv[i], "--topo-order") || !strcmp(argv[=
i], "--author-date-order") ||
> > >     ++              !strcmp(argv[i], "--full-history"))
> > >     ++                  warning(_("option '%s' will be overridden"), =
argv[i]);
> > >     ++  }
> > >     ++

> > 2) This seems like an inefficient way to provide this warning; could
> > we avoid parsing the arguments for an extra time?  Perhaps instead
> >   a) set the desired values here, before setup_revisions()
> >   b) after setup_revisions, check whether these values differ from the
> > desired values, if so throw a warning.
> >   c) set the desired values, again
>
> Yeah, that would work. The downside is that it would be more difficult
> in the warning to tell the user which command line option was
> overridden as there are some values changed by different options.
> Maybe we can come up with a warning message that is still useful and
> enough for now, as the command is supposed to be used by experienced
> users. Perhaps something like:
>
> warning(_("some rev walking options will be overridden as '%s' bit in
> 'struct rev_info' will be forced"), "sort_order");

I have implemented this in the v7 I just sent.

Thanks!
