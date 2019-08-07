Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2841F731
	for <e@80x24.org>; Wed,  7 Aug 2019 20:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389423AbfHGUd4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 16:33:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37653 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389419AbfHGUdz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 16:33:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id c9so64974890lfh.4
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 13:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GifQTIap2NDSc6sbXWrHLwzEzpqvMTxJMRNpOCstosc=;
        b=ROxBciCBUudVf79AXxZ+gmyAsPDSKYhoomwB6JxtnxdyZk5BJJCxs8OuRFO+36EjTJ
         AY4ufRVhmBG58QT6H05+ktta/T0xXm4P5Qttm6Z6YmPvVd9PRpU9CARWFg5Hin0BI27B
         IeTEZuzl/3kBqcj6DeS9ngp8DWYH4Y6a/GVQuND9Rv2GljzoeSqLFemJBDi8zAvOl4BI
         JjZuQ7EO6lSmToKdEzLxsJiKDhMptTyUWr/x7dwqkvrccQbFC0VJOY8KeCy+PwcbnaoT
         X9BZfupCCB/m4E4oT36PVWZBlHfj1UkBzCBKCJljPuG6QLNR2teK9A5Hm3bNdOVBIZGM
         47uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GifQTIap2NDSc6sbXWrHLwzEzpqvMTxJMRNpOCstosc=;
        b=dGA/k6bCmdaJu/MZ7xiQefAQIQfs7N+ruomWNXQvNxjjj5KZYyZGrqINLzMeBbvMUv
         rsIV7p1uCJTp8SQtuM4V/2IMW6Au9vUSAlUWmSpn9LinkQ48UYW+EziNt+BpceKuOB2Y
         XB2M3weDz5QZKUTxfs6eVQNn+o5PwmDuN+TD2SVKRcDHI//jLf8RkJuYCaShZvbf8usC
         pqPCxArS8N1XYor1bqdgBo+4spPQyQquQYhysyCx9sWCrq14R1JGSkucGb0LCWjMs8sL
         7S2SJAomE6VG2a4eIoT7K4sg6rliWKtjFCWuXXrpGojQzfVF9hS6zZxr4OB3/F5+o63w
         VpNg==
X-Gm-Message-State: APjAAAVUfrfN6h2p41FuFYQJd9LrePmOL4aiDGuxB0RsHwodd89PQx0z
        br9C/CRUwgd3YuDmPu48smGLOjIe1PPwdgJ1gr4=
X-Google-Smtp-Source: APXvYqztqYbMrjmzsJKkOJyVzOYsMZIVZVmgkVL2Qwp2RIpLVtTmZ2Xdpo4q6ctJnA+aCaaE7AKR6JMxfR3GD6yEpC0=
X-Received: by 2002:a19:dc14:: with SMTP id t20mr7024813lfg.182.1565210033499;
 Wed, 07 Aug 2019 13:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190806173638.17510-6-rohit.ashiwal265@gmail.com> <nycvar.QRO.7.76.6.1908072139190.46@tvgsbejvaqbjf.bet>
 <xmqqimr8hgjl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimr8hgjl.fsf@gitster-ct.c.googlers.com>
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Date:   Thu, 8 Aug 2019 02:03:14 +0530
Message-ID: <CAL7ArXoaZU2zPq=nLRghwY+Rj1HPKtTXqaOF75b406iybX9bqw@mail.gmail.com>
Subject: Re: [GSoC][PATCHl 5/6] rebase -i: support --ignore-date
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     GIT Mailing List <git@vger.kernel.org>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Martin <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio and Dscho

On Thu, Aug 8, 2019 at 1:52 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Tue, 6 Aug 2019, Rohit Ashiwal wrote:
> >
> >> @@ -1046,6 +1066,8 @@ static int run_git_commit(struct repository *r,
> >>              argv_array_push(&cmd.args, "--amend");
> >>      if (opts->gpg_sign)
> >>              argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
> >> +    if (opts->ignore_date)
> >> +            argv_array_pushf(&cmd.args, "--date=%ld", time(NULL));
> >>      if (defmsg)
> >>              argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
> >>      else if (!(flags & EDIT_MSG))
> >
> > I need this patch to make the code _at least_ compile on Windows again
> > (I don't know whether it breaks the test suite yet):
> >
> > -- snipsnap --
> > Subject: [PATCH] fixup! rebase -i: support --ignore-date
> >
> > It is a mistake to believe that the return value of `time()` is always
> > an `unsigned long`.
>
> Good catch.  We can at least expect it to be some integral type ;-)
>
> With or without this fix-up, I think the patch is still not quite
> right.  Output from time() formatted as an integer is a string of
> digits, and the side that reads that string and interprets it as a
> timestamp does so by calling parse_date(); it is up to that function
> to decide what datestring format it is in, and it does not
> necessarily take it as seconds since epoch.  It is safer to force
> the "seconds since epoch" interpretation by writing the timestamp
> string like so:
>
>         argv_array_pushf(&args, "--date=@%ld", time(NULL));
>
> See 14ac2864 ("commit: accept more date formats for "--date"",
> 2014-05-01), which gives a good hint on how to do this right, and
> 2c733fb2 ("parse_date(): '@' prefix forces git-timestamp",
> 2012-02-02) for a backstory.
>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  sequencer.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 539c0ef601b..a4c932d3407 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -1070,7 +1070,8 @@ static int run_git_commit(struct repository *r,
> >       if (opts->gpg_sign)
> >               argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
> >       if (opts->ignore_date)
> > -             argv_array_pushf(&cmd.args, "--date=%ld", time(NULL));
> > +             argv_array_pushf(&cmd.args, "--date=%"PRIuMAX,
> > +                              (uintmax_t)time(NULL));
> >       if (defmsg)
> >               argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
> >       else if (!(flags & EDIT_MSG))
> > @@ -3642,7 +3643,8 @@ static int do_merge(struct repository *r,
> >                       argv_array_push(&cmd.args, opts->gpg_sign);
> >               if (opts->ignore_date)
> >                       argv_array_pushf(&cmd.args,
> > -                                      "GIT_AUTHOR_DATE=%ld", time(NULL));
> > +                                      "GIT_AUTHOR_DATE=%"PRIuMAX,
> > +                                      (uintmax_t)time(NULL));
> >
> >               /* Add the tips to be merged */
> >               for (j = to_merge; j; j = j->next)
> > --
> > 2.22.0.windows.1.6.g271c090e89

Thanks for suggestions, I'll incorporate these changes along
with changes suggested by Junio and re-send the patch.

- Rohit
