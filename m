Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 757931F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 16:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbeKMCV4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 21:21:56 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:33061 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbeKMCV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 21:21:56 -0500
Received: by mail-io1-f43.google.com with SMTP id f12-v6so6641488iog.0
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 08:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YUVDFikH5+ozKdOCcw8BdCWHKGnUrz8fJrAmPr+I4Q4=;
        b=eSu2rjECy/xZk4jY6yas9V1iuV7zehJywKeE/IbQahXGs9ONEVZgqC7Y/KwCd/NWNW
         dhY+l79Q3lwVS8+A/WeY8Vcy/xWusmZgcAbsC6ryBxK0OHORamG73fCH3Bjrz0nAfjmV
         AIkIqAY1Tfy3Z1dapVLqwli2hJrHtoE8cN6hTOZbC12KL+vXzwyVzFsdi39Gw8Rpw2C5
         /Rhjt7eGFn+Wf4BG5bGLCo4kIp4ecx+oOwMgkgO64Vfxal2fR0Xd/z3BuBDxrMh0HMfR
         TwuPra08nuz4czVXXtYPcHye5LYSgFQR4kZpJI+aZljlW+46qh1waIstQQriKa8Akkk9
         ZBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YUVDFikH5+ozKdOCcw8BdCWHKGnUrz8fJrAmPr+I4Q4=;
        b=F9RXHiI0Nxe8Ms0V8IyeV6LZgE0U+mlyZoOry+c1BQ0w+NY3NCDn9qZvZQUO+/ZgSV
         L2yHxpFgPBMkk87p1hh6Rq3qMQyY1XXJYs+L4Tn6q4tYAZGEA76E3EDwcPbMWGcBmWmJ
         lngcuebs7qCqjJQyiZN6bFb7EMk3YaVfoeQTPkCq0E6Qo/CFfCe01VZBtRF1EaFYFEsB
         U6nueN/tPKDlkwN4g4hStmiGu7jhRDHQ2M6rP+UkcuRobOM8mC2JxZPkNAurhn+Q1QN2
         T4RZhTcNdbHYJ9hVigQROA2f4XdIZPDrsdTr8mkbM5P2A8hoFFDdw/qqQIcQjD2ceyXY
         vxiw==
X-Gm-Message-State: AGRZ1gJTs+tzuaNISjtVmVRsT6s8ZLh7hGY9lOfp0RWhLDPoPT9Kzirx
        xQmp6acst3qKYkA15+cNxGGaOaVuh9hwbYk9HGU=
X-Google-Smtp-Source: AJdET5e8+31n1ogo8WGNtxaWyo7bLNICd1x9uCGc+IXQo/ueQMulLTBOd71R/X4OgUvWKhPS/xeUzyciITHpmDP1fWk=
X-Received: by 2002:a6b:6f0e:: with SMTP id k14-v6mr1048010ioc.236.1542040077467;
 Mon, 12 Nov 2018 08:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20181110133525.17538-1-pclouds@gmail.com> <xmqq8t1y3jex.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8t1y3jex.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 12 Nov 2018 17:27:31 +0100
Message-ID: <CACsJy8BGgf0J=iKNc3qmz_rTMNdaPmR_1v+9i3nhGKcuOH4AFA@mail.gmail.com>
Subject: Re: [PATCH/RFC] checkout: print something when checking out paths
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 7:21 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > Since the purpose of printing this is to help disambiguate. Only do it
> > when "--" is missing (the actual reason though is many tests check
> > empty stderr to see that no error is raised and I'm too lazy to fix
> > all the test cases).
>
> Heh, honesty is good but in this particular case the official reason
> alone would make perfect sense, too ;-)
>
> As with progress output, shouldn't this automatically be turned off
> when the standard error stream goes to non tty, as the real purpose
> of printing is to help the user sitting in front of the terminal and
> interacting with the command?

I see this at the same level as "Switched to branch 'foo'" which is
also protected by opts->quiet. If we start hiding messages based on
tty it should be done for other messages in update_refs_for_switch()
too, I guess?

> And by this, I do not mean to say that "When -- is missing" can go
> away.  I agree that "--" is a clear sign that the user knows what
> s/he is doing---to overwrite the paths in the working tree that
> match the pathspec.

My other problem with deciding to print based on the presence of "--"
is also with branch switching code: it always prints something (unless
it actually does nothing). So it's a bit strange that the
checkout_paths() behaves slightly different based on "--".


> > @@ -371,17 +374,27 @@ static int checkout_paths(const struct checkout_o=
pts *opts,
> >               struct cache_entry *ce =3D active_cache[pos];
> >               if (ce->ce_flags & CE_MATCHED) {
> >                       if (!ce_stage(ce)) {
> > -                             errs |=3D checkout_entry(ce, &state, NULL=
);
> > +                             errs |=3D checkout_entry(ce, &state,
> > +                                                    NULL, &nr_checkout=
s);
> >                               continue;
>
> As we count inside checkout_entry(), we might not actually write
> this out when we know that the working tree file is up to date
> already but we do not increment in that case either, so we keep
> track of the accurate count of "updates", not path matches (i.e. we
> are not reporting "we made sure this many paths are up to date in
> the working tree"; instead we are reporting how many paths we needed
> to overwrite in the working tree).

Yeah. I counted matched paths first, but when you do "git co .", you
get a huge (and meaningless, to me) number. Printing how many files
are updated makes more sense.

> >                       pos =3D skip_same_name(ce, pos) - 1;
> >               }
> >       }
> > -     errs |=3D finish_delayed_checkout(&state);
> > +     errs |=3D finish_delayed_checkout(&state, &nr_checkouts);
> > +
> > +     if (opts->count_checkout_paths)
> > +             fprintf_ln(stderr, Q_("%d path has been updated",
> > +                                   "%d paths have been updated",
> > +                                   nr_checkouts),
> > +                        nr_checkouts);
>
> This one may want to be protected behind isatty(2).  Or the default
> value of count_checkout_paths could be tweakedbased on isatty(2).

Another thing I'm going to change (if this v1 is in the right
direction): print different messages for "git checkout -- foo" and
"git checkout foo -- bar". The first one is "%d paths have been
reverted" but the second one does different things and probably should
say "%d paths have been updated from branch foo" or something like
that.
--=20
Duy
