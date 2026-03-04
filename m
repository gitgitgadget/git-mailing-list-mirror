Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251D237189C
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663803; cv=pass; b=COM8gIEOI4r3wgXnx9F8QniQ3nIvjhnpYyMacRpkEjAostZPJ3UNt63rtkWV1OvO/Do5prxwgYbGPio2ABRVMMgogUMJP7EZURbminOTtdJzY19cV3sAmFwL5TwGZqNTxeHqXYm8+/YMBwDmme5dAX6SCsg2KneUFUzDG1AM8fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663803; c=relaxed/simple;
	bh=GXXfJgRUgzOib0V06NYtwD4Bkml7O7ftoqzPNFOYFA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgZ1huae/by9WbT4QEaEJjk3wx28hEOogj7CL7EHsMQ5CzLCymxB6KGbPE8K45Mw/9FmtZTXPNc0T4IT7TwJ6nyR0aLwBeeEDBY4oh/+tGgHaV/Cx0zWNeefJWAMuNiR4CsLZB65qpE+0VbdtrHcGjTKDOh3BlwCzUEHAMgYJ7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xywnzpbl; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xywnzpbl"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d598f60eeaso5345134a34.2
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 14:36:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772663801; cv=none;
        d=google.com; s=arc-20240605;
        b=eIcc7ZKNpM21k6b+YcvbW9mrs0oif4qUxD9hfVKDD2vtk1g4w8isB4whRNxGnuaACV
         ETeE8oszhU5K4emynImamJpSgZ29wPpU+YdLsj/vt8rKgt+QqSaXkeA2Limxd0RRCASk
         Z1hAj90ZmXljcxblAh5tlBzezvfjl7adVBlJUSxCCgUp3xvGI5i3M4Ybze90BBMq8X3K
         drOIb0PL9eZz2Tx8fIPqJmrYASa98yeJhEUCn3Y1CMBrBge4KcBgwn63svjhjv9wBRx6
         LDHDjBkz4Tg23kpSDh/vHwfXU4hASo8o7kS6SYka+L1TbJVrx/I0uiGeriEzdws+0ntN
         WQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pCnLz36897D2jP21ueVaY8fAiguXsPyvelSN5s1lHsk=;
        fh=lYzdD1C88LCoHtxzMjf8YOQ3Xd6danXerg6eqOtvWlg=;
        b=X0Pa5fqdPvieCiqT6nmaetQCbJvh4/nwoNSaYxiFmeG+Jna/ArJGvb3RtBtiMC6I95
         ZPqJEE3GH25E5pl8IMLIt7+F1CebK72TPNI3NNtD9R03OEte0b5bzH/ri/pezeCAuuTm
         RQGBsQjBVSsuKKyTED402+wZBvI701BRbs0wN2w870iQ2vZ0sOWB/TRqTLHUHHajvz6h
         bl2GQf3LbwrnrxASVVGdV9p4XbhntQYy0tXdJy+DRiBFKOIV2/ByYRE9iuxYj5j8t8wQ
         TewjH2kPbXSZjvCL+/5Kq5SXGMzQVeVeJc0kXdnoGZ8+1lp8I2Zgjrz/zb4BijScZpMr
         fYAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772663801; x=1773268601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCnLz36897D2jP21ueVaY8fAiguXsPyvelSN5s1lHsk=;
        b=XywnzpbleTgR9ctzCOoS/DrlOfBp0YtoZTq47Nh9CvesAGSiJykfhzTaAiK6hUEvRW
         H8pkJpAgY+0Bt4gR5mtZQ0+G79PZIbkDjtiqD5ZzmO8KPYGHgiADAIkTImS2qQFIQV1o
         XXONErJviKo+u02fQ1cuNGsi2xJKStevyuETgExd3a9+D+8MUIA3+sqLPyl6KlES0EF0
         38qS6WMgKnfWiXpvZm39dQTuGYnXhTqLO9q7R8xZQ0ZcbEVO9RIf0m6mzxOF0aEksuKR
         MUAmQLqzajIoSQk6+iiSuggO99pO3nJqHaVPs9w40NmLbvEQCbUKLhtKXjzmK1knPRgP
         EC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772663801; x=1773268601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pCnLz36897D2jP21ueVaY8fAiguXsPyvelSN5s1lHsk=;
        b=wiyho6/zhCQ3VHiWifgGc1ir/REDc6S6zZS30cijh1vHSGOr/pubgBgDQ/b4oXE3dv
         WACjOPkEM3bPSoBcihF5z8LfrcTQlK4fs0zBh+FUQ7m3uIBvKsRUY7i4kLjeVFNFUtD/
         RVcpzgQdQa9D9IU/IwIR49PcsnYwRHXxpNPNRSdAPNPoO1Hy3puZmxbOoc6ptTf6Gb6+
         2hrxlbk4GqHM1TJkEWzdMGwde98/gmCAKdX7BOhetdS4V4hCwmSEtJDUeNY61q4q/TMe
         sQaj8my6Wt4oyMA6+1kwJPrZ0mGhMC4D38CW59mxNAvqowvy6ACdKSVh0ekFlWTXMl0w
         HqoA==
X-Forwarded-Encrypted: i=1; AJvYcCVlbk9feFt9yzFlWcHQJuxl8Q6wOP9cNzPEOPOXnmnTri5r6zafm1IMcpy1cjT2fjacdxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBDuUYc0xOa2vtq3PB2EDcHX2edrKwaeli/XZ82bAEUa+a362+
	aK68+f/6jTf0EiJ8DJuFgaWOSYVrZQAgxiutfvexlc9wIdqbG8n27AkVteTf6MLqikPlPkuKFCf
	qeCKsjYcndErZD9kfK5+r6RmHCx2+GqI=
X-Gm-Gg: ATEYQzzfcmSkTW6op/N2hgUrv6VGs6GKbAbCNcHXLZ2GCL1wcxVOi7pRexNeG/KjWRu
	oWMWDluv8sZL70lffKTOb0gozFczpfVPv0emK+ABEyTeo30aqNfK3mhtm+aqJzX7czAAU+kiUEo
	ZbUFXMNleo5/K4zbw+V1T/msotscKwe8lkbzx1sY2ssceXExRVBvAjiE8iYDdRBFFu/V7RPXZfS
	8AP/GSwAyKejfvJygfMUIGHjZhSgyy7/bjfB/4mjC1phGDv9WmPZtorolfKcGhs1RIEMq6yQvMG
	gWHVpON3OCUUwooxbJXhFtC9sGWKd9hUc7mrHzz0aA==
X-Received: by 2002:a05:6830:3905:b0:7d4:90db:f69a with SMTP id
 46e09a7af769-7d6da1f0750mr1952208a34.35.1772663801149; Wed, 04 Mar 2026
 14:36:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2061.git.1772651484.gitgitgadget@gmail.com>
 <pull.2061.v2.git.1772652091.gitgitgadget@gmail.com> <81cb521401210bfbcd05f8201f75e93bccfba712.1772652091.git.gitgitgadget@gmail.com>
 <xmqq4imv71g8.fsf@gitster.g>
In-Reply-To: <xmqq4imv71g8.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 4 Mar 2026 14:36:30 -0800
X-Gm-Features: AaiRm52xkBcvrhGtmODmHOMkIoh4kN2VQrJRRDy9hceaIk-GTXZ24kQ5S5c61GY
Message-ID: <CAC2Qwm+2pjMk=XFq0cU0Pt1tWkqDy_tOKMtP0jF6JArFX0jmOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] log: reject pickaxe options when combined with -L
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Matthew Hughes <matthewhughes934@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 1:02=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Michael Montalbo <mmontalbo@gmail.com>
> >
> > The previous commit fixed a crash when -G, -S, or --find-object was
> > used together with -L and rename detection.  However, these options
> > still have no effect on -L output: line-log uses its own
> > commit-filtering logic in line_log_filter() and never consults the
> > pickaxe machinery.  Rather than silently ignoring these options, reject
> > the combination with a clear error message.
> >
> > This replaces the known-breakage tests from the previous commit with
> > tests that verify the rejection for all three options.  A future series
> > could teach line-log to honor these options and remove this restriction=
.
> >
> > Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
> > ---
> >  builtin/log.c       |  4 ++++
> >  t/t4211-line-log.sh | 52 ++++++++-------------------------------------
> >  2 files changed, 13 insertions(+), 43 deletions(-)
> >
> > diff --git a/builtin/log.c b/builtin/log.c
> > index 5c9a8ef363..44e2399d59 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -317,6 +317,10 @@ static void cmd_log_init_finish(int argc, const ch=
ar **argv, const char *prefix,
> >       if (rev->line_level_traverse && rev->prune_data.nr)
> >               die(_("-L<range>:<file> cannot be used with pathspec"));
> >
> > +     if (rev->line_level_traverse &&
> > +         (rev->diffopt.pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
> > +             die(_("-L does not yet support -G, -S, or --find-object")=
);
>
> I do not think "-L" meant to work well with these features to begin
> with, and I've never used -L with any other options (-L does not
> even work with --stat), so I personally do not mind this change.
>
> But if this is in place, would we still need [1/2]?

I went back and forth on whether to keep [1/2]. My main reason
for keeping it was as future-proofing if someone removes the die()
to implement support for these features working together.

However, I can easily see the argument that whoever does that work
would likely rework queue_diffs() anyway and it's simpler to drop it.
Happy to do so if it's not worth the churn.
