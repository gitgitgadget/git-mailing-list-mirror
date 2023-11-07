Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA15312E40
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKPryH2U"
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB07102
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 01:43:36 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso9104955a12.1
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 01:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699350215; x=1699955015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlVLHso9CGXaXN2cC2rslbIZ1Af3gNQTuDGOPzt+3Fk=;
        b=XKPryH2UpvJnJbQHYgJaZ5OFvvN+OFeBAJ3PkiadjyJd/zP1pjNLA07bGDVvweXeEM
         jB9DL3l/Rmu0sdXspFQ3AOIbH+BNPqy4I80UoRauwiLD6XmClhZiz7BvTmHXF+imnC3d
         vnuIMAv0ACoJ6jUCIOBnHYDkpDeCMtKCG5WmwwVLo19ML5XTbITvnRNeT9eZ3pV2JmSB
         sDe0NYKzLyM3m+udTh2S6t/MV+SGZLQmvAkQNbbDRiVlWvQTlgE8l8zmLR6hvqx2ThUc
         koUnuXycHot29A6mJzE+CBRUxynDHACCgk2EL/NOXXrvSVIl5uyd/KQlPq60uW1JPznL
         oBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699350215; x=1699955015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlVLHso9CGXaXN2cC2rslbIZ1Af3gNQTuDGOPzt+3Fk=;
        b=qESW/tZg4NshmDlNlHzHmjIkmKRpJsu4yY5Eh+tth5ecoC9UCrgjqW4Lds98w+b+ub
         kIi72JepKCqnAwOvPeW5qeYkFESBVi63N56qhMQHcesyy17fjaEqy55cq2Ldw5VRguO6
         Z87zi0V1M7YXrc0WUiUfogphQNzRxhUpYQHbQ78GuPrCtuWGd/fQd4NOsK3M0ceoy6z1
         mjXc6DfHJfBYCOIVSR9EKXlnFgSlPljsZAzLSPvF3Bugm0Ub198CBk/ZAf8SCR8vXPi8
         pZmX1glKUdQ59o6303euqZ8MlQ1NuHUbkctZ/jXDVl+nfT3vsODEgnzo3tBhQ7OOdzOp
         mzPQ==
X-Gm-Message-State: AOJu0YzuFSTRhef3g0hr9wleDwHPWG4NeHpe1czmbLl68fhG5KKc3blF
	jt4bUFBpo4gijZmPaQRSaanm2geGZ0y61FX+7O1iOHqtHjg=
X-Google-Smtp-Source: AGHT+IFufhK+A9DHHBm75EKtAqIoTTSSZFGZGf9Fddo2CXwbw4i3NugcbYFAl+TnnsDrBvAQJAAgVo0JsODbGaeq51k=
X-Received: by 2002:a50:d658:0:b0:53d:b5bc:6415 with SMTP id
 c24-20020a50d658000000b0053db5bc6415mr24329106edj.15.1699350214386; Tue, 07
 Nov 2023 01:43:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010123847.2777056-1-christian.couder@gmail.com>
 <20231102135151.843758-1-christian.couder@gmail.com> <CABPp-BE6G2qaF50bhz-CwxSsvxGDHzwvsWtfQO4zVcX6ERppLw@mail.gmail.com>
In-Reply-To: <CABPp-BE6G2qaF50bhz-CwxSsvxGDHzwvsWtfQO4zVcX6ERppLw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 7 Nov 2023 10:43:22 +0100
Message-ID: <CAP8UFD24fzhiecJtANqEsxvh1mxT4pKR=QjfUFZh8C6HQE-k1A@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] Introduce new `git replay` command
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, John Cai <johncai86@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, Dragan Simic <dsimic@manjaro.org>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 7, 2023 at 3:44=E2=80=AFAM Elijah Newren <newren@gmail.com> wro=
te:
> Looking good, just one comment on one small hunk...
>
> On Thu, Nov 2, 2023 at 6:52=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> [...]
>
> >     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, co=
nst char *prefix
> >      -
> >         strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NUL=
L);
> >
> >     ++  /*
> >     ++   * TODO: For now, let's warn when we see an option that we are
> >     ++   * going to override after setup_revisions() below. In the
> >     ++   * future we might want to either die() or allow them if we
> >     ++   * think they could be useful though.
> >     ++   */
> >     ++  for (i =3D 0; i < argc; i++) {
> >     ++          if (!strcmp(argv[i], "--reverse") || !strcmp(argv[i], "=
--date-order") ||
> >     ++              !strcmp(argv[i], "--topo-order") || !strcmp(argv[i]=
, "--author-date-order") ||
> >     ++              !strcmp(argv[i], "--full-history"))
> >     ++                  warning(_("option '%s' will be overridden"), ar=
gv[i]);
> >     ++  }
> >     ++
>
> Two things:
>
> 1) Not sure it makes sense to throw a warning with --topo-order or
> --full-history, since they would result in a value matching what we
> would be setting anyway.

Yeah, I am not sure about this either. About "--reverse" I think it
makes sense because even if the command is setting the reverse bit, it
would be possible to reverse the reverse like Dscho wanted. But I
agree "--topo-order" and "--full-history" will very unlikely be reused
for anything else in the future.

> 2) This seems like an inefficient way to provide this warning; could
> we avoid parsing the arguments for an extra time?  Perhaps instead
>   a) set the desired values here, before setup_revisions()
>   b) after setup_revisions, check whether these values differ from the
> desired values, if so throw a warning.
>   c) set the desired values, again

Yeah, that would work. The downside is that it would be more difficult
in the warning to tell the user which command line option was
overridden as there are some values changed by different options.
Maybe we can come up with a warning message that is still useful and
enough for now, as the command is supposed to be used by experienced
users. Perhaps something like:

warning(_("some rev walking options will be overridden as '%s' bit in
'struct rev_info' will be forced"), "sort_order");

Thanks!
