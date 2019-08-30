Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D991A1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 03:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfH3DuW (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 23:50:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43260 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfH3DuW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 23:50:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so2778652pgb.10
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 20:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=frp+VGUgPY0jEd4hp75Vpo22M5EYc8LHT0iWfC/J8pU=;
        b=GjTyEAtdmoWyqCbnCfNsDhwW0rgUC52/IEn5iubTORTNtKi9/6Zj6adyPhTRG64B+4
         B6bDMK+A/C8cwSz1UqHpC/UGM//+qxu0ietT+DRyjwzRGRVLw/RqxiGvkhSuMurdEfck
         abCR3WtBWBB5MgwUO98fvp3sf2XkAmmVBsTz31XseB/DxwFXxiHsOP+PcsmGMbcu3XK+
         zO3uAN1mGF1Tc3Flw1/RqqBcvHD+p3mKzwtX8ZnElibPzd0JO9hEsemWvaoMaGoENlW1
         Yr157L7UpW1KMXjT/E2vAgIURagfP01YsiSUgx1ybAMvji38EjRVzdla27dQ4sdO8GzT
         8AVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=frp+VGUgPY0jEd4hp75Vpo22M5EYc8LHT0iWfC/J8pU=;
        b=HIvYjJ2ZLcEAD27aUdbGBFZ/KsSOu2pzN8eWthcppHozAGDJ1ICW49/u/9lzYy4YNR
         BUmGD1Izg400B6vW8vyAXPyirDYuJa1S+UUXQT0kPAzpl8znJY5P01aJbN5iw5ykF+eW
         9FRrkTZOxbs2wlssSbGpS8oMtLJcNNbWHbfVQMXfnQOkbsDldIM3+TSgAtxfjjHprMDz
         0SM1z8dBpt+gIghCurW2az8SCs7sycjUAswVyDQDt+O+8f6wqJ3MPy11CYU3iAo+Tz+E
         rUAbHP2KJNFLWanfvUhDANkXNew5XLEripxOjNBCmwGhKwYGlAtjv9IGN8WCzC4umw3q
         BxjQ==
X-Gm-Message-State: APjAAAW5lrmpL96WNgG2Jf/Ex6Juv0bCLcjIu/XVasAu6cickd36gqT4
        WTNmwm4m9R66FMsyDaqUsNR+cINfDYB8U/XzxPM=
X-Google-Smtp-Source: APXvYqyfBW2aBu7C2WbRp55I9JPu8g5EGxs4zoP9WRvfnVRlh6xvQznPilwULpv9dPritqDBKpGv76ip5g0k3gicWMI=
X-Received: by 2002:a65:4841:: with SMTP id i1mr11307347pgs.316.1567137021954;
 Thu, 29 Aug 2019 20:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <d0606d19-0900-3908-2962-ceb24015f753@web.de> <CAN0heSp4bdJt4NKELOkvdpoygbkNZVn-96FrZnu9ymE5UNOSag@mail.gmail.com>
 <bde881b6-7c23-6f4e-5cb0-a793a5e4f5d7@web.de>
In-Reply-To: <bde881b6-7c23-6f4e-5cb0-a793a5e4f5d7@web.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 30 Aug 2019 05:50:09 +0200
Message-ID: <CAN0heSo6YdCn2cHUTiyhuZ3Z_Rk6YFg=yhWCVHhaoAC3_0=0Xg@mail.gmail.com>
Subject: Re: [PATCH] help: make help_unknown_ref() NORETURN
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 29 Aug 2019 at 22:08, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 29.08.19 um 21:40 schrieb Martin =C3=85gren:
> > On Thu, 29 Aug 2019 at 21:15, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> >> diff --git a/help.h b/help.h
> >> index b8780fbd0f..7a455beeb7 100644
> >> --- a/help.h
> >> +++ b/help.h
> >> @@ -42,8 +42,8 @@ void list_commands(unsigned int colopts, struct cmdn=
ames *main_cmds, struct cmdn
> >>  /*
> >>   * call this to die(), when it is suspected that the user mistyped a
> >>   * ref to the command, to give suggested "correct" refs.
> >>   */
> >> -void help_unknown_ref(const char *ref, const char *cmd, const char *e=
rror);
> >> +NORETURN void help_unknown_ref(const char *ref, const char *cmd, cons=
t char *error);
> >
> > Funny how this claims we'll call `die()`, when we'll actually call
> > `exit(1)`.
>
> Ah, I didn't even notice that.
>
> > If we actually did call `die()`, I suppose the compiler
> > should/could figure out by itself that this function, too, won't ever
> > return.
>
> The compiler can figure it out with exit(), too; system headers (at
> least for glibc, but it's probably common) assign it the noreturn
> attribute.  But there is no way to transmit that information to callers
> across compilation units  if not for the header file, right?

Of course, you're right.

> > I wonder whether the real bug here is that the implementation calls

(Re-reading this, "the real bug" might be a bit of a harsh statement. I
didn't mean to imply that this patch does not fix an actual problem.)

> > `exit(1)`, not `die()`. That is, the exit code is wrong (1 !=3D 128) an=
d
> > we're missing out on the flexibility offered by `set_die_routine()`. If
> > not that, then I'd say the documentation is buggy. Hm?
>
> This inconsistency has been present since e56181060e ("help: add
> help_unknown_ref()", 2013-05-04).  Using die() is going to be difficult
> due to the multi-line suggestions printed by the function.

Yeah, that's true. We could manually prefix each line with "fatal: " or
"error: ", then die with something like "see above", which is not very
cool, or die("%s", error), which is a bit repetitive. There are a few
decisions to be made for fixing this discrepancy.

Anyway, I don't think this is something that needs to hold up your
patch.

Martin
