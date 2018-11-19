Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EBF11F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 15:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeKTBoQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 20:44:16 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38528 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbeKTBoP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 20:44:15 -0500
Received: by mail-it1-f196.google.com with SMTP id h65so4655793ith.3
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 07:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fAnRjUpJuFJ/8iRU1uYVhHKs0+3LD2AlCJo8Rz0Zqgk=;
        b=B2nPRoiwSE24W29oMszelvfXfvKn+EESghP6h+kpjp/dUkEbgbkGzsPkHpWCIqRnsT
         gUj6tO18KQ3xy57vGM5FzdAUrk9lrECDkZnx+71SbtUU6wGAOxGuy8ROVaB78XiqJcOZ
         9rM/LcEe07P1qnvoYnaniyfo4ZBvK1BegrxPPei0r8J0RqAMF1qMrIZ1y87gOeM7WgE+
         00BMRSH4fP5u0WQMcK1Mt1XFeUUiYK/pYRBdUv31CUZx+oU5BZRq36jP1RTfVEJqu7rT
         /uUQXlOtHd9ixt5LiLJX8V2l9BTtQfPZd6IRgyE64em3snuYzmp9kpmI21xXU9afxf2H
         gSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fAnRjUpJuFJ/8iRU1uYVhHKs0+3LD2AlCJo8Rz0Zqgk=;
        b=L8qCTEByN9Kxzdulox434obBVPG2CijEHXRm3TSmYHIhNf3tl5AjFBgB7JlkjQpVTK
         FPUklcEbsPoodFAdFHWd27rDwQ1lGjpQM11bzlpPYtzcS5bCbrzcrSEf2Wyci7//tRC2
         KfdI7DzD2WYKJTB6KfLpjJFiKiLU8ZhNwXNXnbZxnaPE7cJ5mfzHZirScPZ4+UVG8wEo
         0e2BUvsFr4MiBmqKyWUfPgV3Gcr4NJvhtQe58NP/ejFfQqXtzxCTaJxXipJm2DodkHvB
         UW43dzbbCafkO+VQGdwXD9Oqo2Tz98AVq1ocPdgiTbKHXigWZrSm1ZijgSLdJ9T4Xmoo
         uMjw==
X-Gm-Message-State: AGRZ1gIZaeDQquia4iVPULYhTLt45LD8wVnZaWa/bMTJXqR0L6F61zr7
        WSnAM3/hP2mBG6WqK+HuO8ej4z/AU1uPHEo9Z2FLgA==
X-Google-Smtp-Source: AJdET5e/ISj2iX8gvyq+flrJbLome726wRrEkST/EEA5hMK89Y8280wDrZS7ErpxGGACWi3ClMA7SRzHiROlxwW846A=
X-Received: by 2002:a02:8943:: with SMTP id u3mr11801099jaj.92.1542640820074;
 Mon, 19 Nov 2018 07:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20181110133525.17538-1-pclouds@gmail.com> <xmqq8t1y3jex.fsf@gitster-ct.c.googlers.com>
 <CACsJy8BGgf0J=iKNc3qmz_rTMNdaPmR_1v+9i3nhGKcuOH4AFA@mail.gmail.com> <8736rx1ah9.fsf@evledraar.gmail.com>
In-Reply-To: <8736rx1ah9.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Nov 2018 16:19:53 +0100
Message-ID: <CACsJy8B6wKGg2Jsopct-0dYNhKJGf9RdnrnTqBOt4kxy6LzxMw@mail.gmail.com>
Subject: Re: [PATCH/RFC] checkout: print something when checking out paths
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 2:08 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Nov 12 2018, Duy Nguyen wrote:
>
> > On Mon, Nov 12, 2018 at 7:21 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
> >>
> >> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
> >>
> >> > Since the purpose of printing this is to help disambiguate. Only do =
it
> >> > when "--" is missing (the actual reason though is many tests check
> >> > empty stderr to see that no error is raised and I'm too lazy to fix
> >> > all the test cases).
> >>
> >> Heh, honesty is good but in this particular case the official reason
> >> alone would make perfect sense, too ;-)
> >>
> >> As with progress output, shouldn't this automatically be turned off
> >> when the standard error stream goes to non tty, as the real purpose
> >> of printing is to help the user sitting in front of the terminal and
> >> interacting with the command?
> >
> > I see this at the same level as "Switched to branch 'foo'" which is
> > also protected by opts->quiet. If we start hiding messages based on
> > tty it should be done for other messages in update_refs_for_switch()
> > too, I guess?
>
> I have no real opinion either way, but whatever we can do about
> "checkout" being so confusing since it does so many things is most
> welcome.
>
> Just an alternative: Maybe we can start this out as advice() output
> that's either opt-in via config (not on by default) to start with, or
> have some advice_tty() that only emits it in the same circumstances we
> emit the progress output?

No let's drop this for now. I promise to come back with something
better (at least it still sounds better in my mind). If that idea does
not work out, we can come back and see if we can improve this.
--=20
Duy
