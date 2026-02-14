Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951FE296BD6
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771060566; cv=pass; b=c+N+nvUdH2eq0lc4p18MATbbGLOo2H170gwGxsnsNV1catgvYCyonwJ8eNQy0kURzpGXTEvdlom1ycWR1UseeJTqSv7t3/j4dIPGu7V+iXuURLzbJ20PNxHIAUK6q/YMgXSPsWorF3SPi6RsweWddDTzAUUS6PqSiDFbXkIk9/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771060566; c=relaxed/simple;
	bh=qrbWx9g8zy/0qeWFqWSWAYz7JIpzrNzzc94+jdMzeYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lc9p7KaxezHUKUKE0UT9qFwk0uEHbDE3/RGW4m9pIaX78z/rxA3azsDqn8cI4PhmWwaYOB7Xp//8pX8/bvE/q6wHt7cBtRZAT0PvwdSX6VXDo4EAA371H8rlBKq2dRd8NHaPhgAn8R/XMCBw1XiKHTNZ5GYl1THtzspjdJg/BfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6K2pHtM; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6K2pHtM"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5665171836cso1954587e0c.2
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 01:16:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771060564; cv=none;
        d=google.com; s=arc-20240605;
        b=UfPyvyvlE7iHdkNRfc1ZRONK2QpcAGG9QrWcepRPPl2WI71nl89P9AG/vcohA8nMDh
         W52t66Wl6i/Kro7ohCYF6GhhLBa/3hS4IfLMVulowhgCj+HFaNGblZO3VPW23XST/n/U
         653BWSUrwtWYB1UgNBalWHjEwO+mk+2DfVWxPMTgmJzkYQPZtljdh2tVP/aJtpnvAmgF
         6oJWeTvbxtMxVmSVJmpR7KLaWKi4NeIVeCwPjefRI7VUpgFlyYkZUJm32uB4arzH8LES
         cyMZTp4WmdnSKkIxBTPRq9UCi1W+9o6qMTxOeVFucn1gxau10f4jj4qawPSfivsKiFEn
         ckOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d58j4kOLnpzviUfyWfybmWbyyMvaFd3UkLOJuHFGWqM=;
        fh=wMEuQs+GpV4sPE9aqLGoS837e9vPIyS4RJzxckXqt0E=;
        b=efgBzcQCufEttL58C0DWtg8R/0WqNxHJ8oVj9bUsE3pzc+nWPo6g/z/BuAHalvPFte
         hjr3HY239hNqZNZOxGe9mE4FnNZctaXPlIdOW/1iuQU5yj8u/UqUIgcomTTatEemSPcd
         E64BNqV7HLpbseyKNin/ptY0UFVaYrHjiaac4XtZCR4p8IvWVMH7u/dOTDWBiT257OPW
         xfTIhNI2EuhLyFeb8AXmTzADjHXL3hJUYtQlxXrtObHrSWm2FHVb8SUQ+8m55+temJgX
         I6QBh2AbTkipiFenD80nHS/tnB+Ntmk8ujv9zhERYeGis3/o5sue4X0Fr1/6gYGWXABm
         gQJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771060564; x=1771665364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d58j4kOLnpzviUfyWfybmWbyyMvaFd3UkLOJuHFGWqM=;
        b=Z6K2pHtMn850Hwbe5PnaOwRI2/P5vL4uRvMfe4C6Gl/+W6hfP9Eq3GGiE14lSXPH82
         kuBFLJpxGW1xPnchxOjhbh8KqRy67tVu+r2w8wSyZXE4wW36cvugU2BnrJxgG9Hg1lhB
         MU+oAH56tUxqs21rgeIYSvv3EZWEOPIa+9s2hLtwodjt+4gMW1x70A+y38m0MwCDpk+9
         Fs/flb+oXtQqAmoJoHfKYLj9TehEIdE/NgdpZtowTSTAwnjad2UjRk1j26HiwdSPw1Pu
         D5UWVk9eX4VqQc36+AjuSV44ZKwDN8IW4Zijd7atigJe88+JcBRjCfDJYKmKsi8xufsR
         GJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771060564; x=1771665364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d58j4kOLnpzviUfyWfybmWbyyMvaFd3UkLOJuHFGWqM=;
        b=iiR4d+wwD8KcAyT6t/827sjpFtkI4WP8TAn79jK48r74KOsa4YQZrbzUurmgAhX3Tk
         LTdJQUyidHrmq3sP6PCaf/G/3y21TVcFLbb2UpS4uYh1tpbdV2UHBpmRtsn0TeIQIlen
         0PfU8CRxvVHIh/orOGyhnV8fYacBWclr2DhiyXpTRfOSyhtejMfTcd8QcmXWn963nIaz
         8Y5mWP5yZpPWmbtdGWeqL1Mu1ZZNT7jNFypChFKXuZ0KDSaGbXuES7UzbEpMwovLVoLK
         CXZQytT2usX177GC5O8dBEwHS1mDiFdotINnmeJFLy/2EwiXLHl6bDkirK+O5wB3rRvA
         xxbw==
X-Gm-Message-State: AOJu0YzHinB37x0c8erwooyLLZs4Uu4/X+xrFlzL1dxrXEVw6fZz1n2Y
	RjBmbBP8JER1H1bNb42WWTM1CqrtFfoHtGBRPJKnZM6oTDPpOIwLqdbpJcfuOv63MiEb/IrHe4q
	tx1fFKgFFnOWe7/954447IqV/nOUMvhI=
X-Gm-Gg: AZuq6aKMVkI0Wea5oME6BxavGaqvdKm4aOe5YpIdGXcVtAVjrPnGnN0mMXsbfsDxvtF
	Gjp0YSjdjjEu/9WXgbij9Jp/THttWU8tiKuBseIoaliIivsU8IUtpUHgal7ASuuEr7zEx170LU5
	QwPZtE2Ixos+wz0a1OQi+8jAI5YHn+dpGNNpaTual/UYwsNh9kvSfUP8oaPnZrXhD/V7OjGOTKJ
	sB6yN72ZaVzflC/qXjI4R1VZrdEhsr9YWzu5jZsnRUvuqH5y6Q8Gyjh0lWUb5DjKG/xh6R1KCZR
	DU/HxeOWSMe8
X-Received: by 2002:a05:6122:8c12:b0:563:7390:b17d with SMTP id
 71dfb90a1353d-5676a7493b0mr1806243e0c.0.1771060564451; Sat, 14 Feb 2026
 01:16:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771015581.git.abrahamadekunle50@gmail.com>
 <497ca5b43c84dc4d146a18899461cd02564c0268.1771015581.git.abrahamadekunle50@gmail.com>
 <xmqq4inkjld4.fsf@gitster.g>
In-Reply-To: <xmqq4inkjld4.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Sat, 14 Feb 2026 10:16:04 +0100
X-Gm-Features: AZwV_QgEblPvTubcyM0qDgDDWj_YCNbdCvNIvrb3KWs9hu68qM-uuAIpdr7XKXc
Message-ID: <CADYq+faXoK7FQqG6gs1yiXR3i1FBScNTG5npGp4G=Yc+FEVexQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] interactive -p: add new `--auto-advance` flag
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 14, 2026 at 12:04=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > When using the interactive add, reset, stash or checkout machinery,
> > we do not have the option of reworking with a file when selecting
> > hunks, because the session automatically advances to the next file
> > or ends if we have just one file.
> >
> > Introduce the flag `--auto-advance` which auto advances by default,
> > when interactively selecting patches with the '--patch' option.
> > However, the `--no-auto-advance` option does not auto advance, thereby
> > allowing users the option to rework with files.
> >
> > Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> > ---
> >  add-interactive.c     | 4 ++++
> >  add-interactive.h     | 5 +++--
> >  builtin/add.c         | 4 ++++
> >  builtin/checkout.c    | 7 +++++++
> >  builtin/reset.c       | 4 ++++
> >  builtin/stash.c       | 8 ++++++++
> >  t/t9902-completion.sh | 1 +
> >  7 files changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/add-interactive.c b/add-interactive.c
> > index 95ec5a89f8..c3a36cd11f 100644
> > --- a/add-interactive.c
> > +++ b/add-interactive.c
> > @@ -64,6 +64,7 @@ void init_add_i_state(struct add_i_state *s, struct r=
epository *r,
> >       s->r =3D r;
> >       s->context =3D -1;
> >       s->interhunkcontext =3D -1;
> > +     s->auto_advance =3D 1;
> >
> >       s->use_color_interactive =3D check_color_config(r, "color.interac=
tive");
> >
> > @@ -124,6 +125,8 @@ void init_add_i_state(struct add_i_state *s, struct=
 repository *r,
> >                       die(_("%s cannot be negative"), "--inter-hunk-con=
text");
> >               s->interhunkcontext =3D add_p_opt->interhunkcontext;
> >       }
> > +     if (!add_p_opt->auto_advance)
> > +             s->auto_advance =3D 0;
> >  }
>
> I am confused.  Why do we need above two hunks in this function?
> Wouldn't it suffice to do
>
>         s->auto_advance =3D add_p_opt->auto_advance;
>
> in the first hunk, instead of assigning 1 to it?

Yes thank you

>
> >  struct add_i_state {
> >       struct repository *r;
> > @@ -28,7 +29,7 @@ struct add_i_state {
> >
> >       int use_single_key;
> >       char *interactive_diff_filter, *interactive_diff_algorithm;
> > -     int context, interhunkcontext;
> > +     int context, interhunkcontext, auto_advance;
>
> Please don't do this.
>
> The original is already bad to have two members on the same line,
> but is tolerated as they represent somewhat related concepts.  The
> auto_advance member has nothing to do with these two.
>

Okay
