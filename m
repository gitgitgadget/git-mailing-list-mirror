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
	by dcvr.yhbt.net (Postfix) with ESMTP id DE8221F462
	for <e@80x24.org>; Tue, 30 Jul 2019 22:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbfG3WC6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 18:02:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36618 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387561AbfG3WC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 18:02:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id k21so63887317edq.3
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 15:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7iu3ljlOYZ8mrl3w46c7FQMQVwTrQ/AXGhMQXXyfz4=;
        b=fvGcDezCBPCXQDNfh1xr0ACQjs+juKpGBsx0KAFlEEc5EVEZwE2n2KWBlxSe0+scLt
         HZQfjFMjT7h/Rw5xhYUm8R1lm/SbqUmXMr70rPWjjPju6I2nVPAEJbkAamhVZ+2YoJyz
         +hcYp66ve0jKVU5xX6+enxuh3A1Hiz/hoohV1pWss2QgtlwgY9d37A247kXcmzFSkwG2
         91dXYFZoc72qfBF8iVjcNpObV/a71ss+aGQdioE4dmvab/SoPXiQ1DEhzrrdLh8sOoLw
         CvKW0U7Imvn7LV4XRElmJS0qSQTtOvrnPKYUJ/VgfQLfOVzbiAVBCXvEM69mKaRJ4TK2
         nHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7iu3ljlOYZ8mrl3w46c7FQMQVwTrQ/AXGhMQXXyfz4=;
        b=QKty7WmGL55Dx87/oGcSDlNLTtFMiuesj3gdc0Ue/U15fhojkB3nY4aVSUJ3vpS6Bu
         v4AUOa/A+fm0NNngparza1YQUx61tsP4o3x9DUrR3C6Gs+ETBReVyDIDbwmpDPNwCkRz
         y5hbZllw4vR9xJsHtAAmw1X3TyKTbhijCJVbI6w9p1Ze3AHVf5q/a/pM/qwdzslMcQUZ
         xV5TzcOSnBo/gUi60Ad4xaCbyigwT0+0ENvltekIUlDpXGqbva0vVymwnAdDFkTJp7ox
         C+DCrTy4jU0M0FcxmsMHu1eKUUBrv0D5VcSxd5WcmgkOQ/j/a4MRSC2M5xexonJazZJv
         tBUA==
X-Gm-Message-State: APjAAAXX1uypui9UfrMrm5RuVo9mZjIgeArN1BotFJ+yYzeUQFxJtunQ
        8mSVu5xZaFtU/SQvT5w+0pUS6L4LSwcXr74AamE=
X-Google-Smtp-Source: APXvYqyBrWrVxRFA3jqetKAnp4wP60SdZvpdVgnsRIYXuZSCX9PrRhdsuiPhYI89GHaX3Dfpe6rAdkKLnPBs9t3cd18=
X-Received: by 2002:a17:906:6bd4:: with SMTP id t20mr87548542ejs.294.1564524175883;
 Tue, 30 Jul 2019 15:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW61RFCySF+gUj8iYuV6afEoD0RD9oYE+N6rYd7rv3J2nA@mail.gmail.com>
 <ba3d8a953a2cc5b4ff03fefa434ffd7bd6a78f15.1564505605.git.matheus.bernardino@usp.br>
 <xmqqtvb3s2zi.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvb3s2zi.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 31 Jul 2019 00:02:44 +0200
Message-ID: <CAP8UFD0bH7ZNWFt3MfkAQf2tkF6CAgFj5FsZyc9zechg7MkCUw@mail.gmail.com>
Subject: Re: [GSoC][PATCH] grep: fix worktree case in submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com, jackdanielz@eyomi.org,
        Antonio Ospite <ao2@ao2.it>,
        Stefan Beller <stefanbeller@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bwilliams.eng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 30, 2019 at 10:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:

> > @@ -598,7 +599,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> >                       free(data);
> >               } else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
> >                       hit |= grep_submodule(opt, pathspec, &entry.oid,
> > -                                           base->buf, base->buf + tn_len);
> > +                                           base->buf, base->buf + tn_len,
> > +                                           1); /* ignored */
>
> The trailing comment is misleading.  In the context of reviewing
> this patch, we can probably tell it applies only to that "1", but
> if you read only the postimage, the "ignored" comment looks as if
> the call itself is somehow ignored by somebody unspecified.  It is
> not clear at all that it is only about the final parameter.
>
> If you must...
>
>                 hit |= grep_submodule(opt, pathspec, &entry.oid,
>                                       base->buf, base->buf + tn_len,
>                                       1 /* ignored */);

Yeah, I suggested adding an "/* ignored */" comment, but I was indeed
thinking about something like this.

> ... is a reasonable way to write it.
