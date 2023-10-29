Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36B85664
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhFqgazG"
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF45C9
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 23:02:13 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c5056059e0so49892871fa.3
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 23:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698559331; x=1699164131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftvJ1CDXnOD57ZFbx5vqyruEm4YxWY8mAHPTszjTP7Q=;
        b=VhFqgazGYPAzeXdGMBTG0TlBzu3lzkxIHcY8Gh0kM0BMcaT3ECWpUhxBuC3DFrl7b6
         ni3tSBE0noJLNVEHYSU1wgQuBGtPUtjohWdGgCrNRmmGprJ5LTuTQUjzB4MfxS4ppPat
         oSPXhXUU0EXoOK3ntSPjAdKiZs0ttVuO0efSWLGvvSKTyXyQRMzAQfAGsCdLf0iW18mC
         8Kg4xWSwQ/XoEz/tcG26e4pckicSX2iVi/I4L2U7phRBUI9Gzxbgvl1iHQTpxgJwySwE
         1yWh6TU3VR1UfCod2HgnHRRU9bO96KJm7rPKaR+9Mh/l2VsBTqKnJVbwMBEaDaJs3Rsz
         RdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698559331; x=1699164131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftvJ1CDXnOD57ZFbx5vqyruEm4YxWY8mAHPTszjTP7Q=;
        b=TOvx1xYNSK1VJxgPnsQByLXOcSAr1zCVzmwqD4Eq996u3g0bTO61Fr7Eb9EanWwo1x
         RUGWVIh6hA9bbz7+RchwAOiWr8dCFnZ8AV3aAoBFpkk/ToHKRnTXMDd+VZt2NDHSmTEq
         2H5RenKJrQuQEoealwT9AVOUhrFNvnDS0vzBKXYwWPB+vFXMwiAjnAGzEDNrhE8IlcTI
         mryQVriYLh3Fq1DawFeGsa8AKRMFcKyNgM5JtNGqiq60OCsp5kqBusk6jXChYowPYzVJ
         YSftXr4gE9Urk8bATh7xjPbHnDDX2exYhC6DQ4g7msRVUZiOxh3WFxhZb50vW66vuFBB
         g6pg==
X-Gm-Message-State: AOJu0Yw1+gXeXoloGbaL3H+d+urCD3aMiy2UB6ohtHPXgKfg0WAEUj6B
	7eKz1b9IxFOkYum3pUjM+p59Mpakk/t77LlURA8=
X-Google-Smtp-Source: AGHT+IE7JFS7xlgvccjH8wgHGVOdLq6qr07x3JCKegcIH4ucaIi1UJX+qcJkyVEHZIFgxIwPXtFa/jtBGZ12QJ3T/5k=
X-Received: by 2002:a2e:9893:0:b0:2c5:9e4:3fdd with SMTP id
 b19-20020a2e9893000000b002c509e43fddmr5249894ljj.27.1698559330912; Sat, 28
 Oct 2023 23:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907092521.733746-1-christian.couder@gmail.com>
 <20231010123847.2777056-1-christian.couder@gmail.com> <bd872b81-80a9-5e4e-dcb6-faebc9671848@gmx.de>
In-Reply-To: <bd872b81-80a9-5e4e-dcb6-faebc9671848@gmx.de>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 28 Oct 2023 23:01:58 -0700
Message-ID: <CABPp-BFrVfGHOrBk7g=4TkGxDv=oSqF1FOkhp6WVbxUV-2yveQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] Introduce new `git replay` command
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, Dragan Simic <dsimic@manjaro.org>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 26, 2023 at 6:44=E2=80=AFAM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Christian,
>
> On Tue, 10 Oct 2023, Christian Couder wrote:
>
[...]
> >      +  /* requirements/overrides for revs */
> >     -+  revs.reverse =3D 1;
> >     ++  revs.reverse =3D !revs.reverse;
> >      +  revs.sort_order =3D REV_SORT_IN_GRAPH_ORDER;
> >      +  revs.topo_order =3D 1;
> >      +  revs.simplify_history =3D 0;
>
> This still overrides a couple of command-line options, _silently_. I woul=
d
> prefer those three assignments to be moved just before the
> `setup_revisions()` call.
>
> Letting users override these settings may not make much sense, but it
> makes even less sense to pretend to let them override the settings and
> then just ignore them without warning. (See also
> https://en.wikipedia.org/wiki/Principle_of_least_astonishment.)
>
> Moving these three assignments before the `setup_revisions()` call would
> neatly remedy that.

I agree that warnings or error messages would be better.

But if we're talking about something short of that, I'd actually argue
the opposite of what you do here.  I intentionally moved these
assignments after setup_revisions(), and in my mind, the purpose in
doing so was to satisfy the Principle of Least Astonishment.  My
experience with git-fast-export, where some settings are made before
calling setup_revisions() and then can be overridden, and then do
completely hideous things, was much worse to me than just admitting
the flags are bad given the various assumptions the tool makes.  I
have some patches sitting around to fix fast-export that I never got
around to upstreaming, but when it came time to implement git-replay,
I made sure to fix what I viewed as the bigger problem.

[...]
> >     @@ Documentation/git-replay.txt (new)
> >      +
> >      +NAME
> >      +----
> >     -+git-replay - Replay commits on a different base, without touching=
 working tree
> >     ++git-replay - Replay commits on a new base, works on bare repos to=
o
> >      +
> >      +
> >      +SYNOPSIS
>
> As mentioned in
> https://lore.kernel.org/git/03460733-0219-c648-5757-db1958f8042e@gmx.de/,
> I would like the `EXPERIMENTAL` label to be shown prominently here.
> Probably not only the `SYNOPSIS` as I had originally suggested but also i=
n
> the `NAME`.
>
> Otherwise we may end up with the same situation as with the (from my
> perspective, failed) `git switch`/`git restore` experiment, where we
> wanted to explore a better user experience than the overloaded `git
> checkout` command, only to now be stuck with having to maintain
> backward-compatibility for `git switch`/`git restore` command-line option=
s
> that were not meant to be set in stone but to be iterated on, instead. A
> real-life demonstration of [Hyrum's Law](hyrumslaw.com/), if you like. Or=
,
> from a different angle, we re-enacted https://xkcd.com/927/ in a way.
>
> I'd like to suggest to learn from history and avoid this by tacking on a
> warning label right at the top of the documentation. We may eventually
> manage to iterate `git replay` to a point where it is totally capable to
> supersede `git rebase`, by doing everything the latter does, except
> better, who knows? But we _do_ need the liberty to make sweeping changes
> to this new builtin if we want to have a prayer of doing that. And I fear
> that not even mentioning the EXPERIMENTAL nature right at the top of the
> manual page would just render us into that undesirable corner.

I fully support this.  Absolutely, 100%.

Thanks both,
Elijah
