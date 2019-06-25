Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 204A21F461
	for <e@80x24.org>; Tue, 25 Jun 2019 18:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfFYSLt (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 14:11:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33403 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfFYSLt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 14:11:49 -0400
Received: by mail-io1-f68.google.com with SMTP id u13so1876767iop.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GwWVu2+5Fr9I917aKcPT/HS0aZzUuwXyiK6hQYxff0Y=;
        b=tCVwdef6Su/odGlMCO8tDHu2Ol07xRY02c+e3i2hynojq0h7LhPWFjvURUfTvQVeo6
         72dh9+bFvlM7S442TWZVQVtUWnsbDvAj+IMPg0gMEwcm3oOAd2kK8yDfGHDBbvTNxDWn
         6Xq2lbTU4QZm3nSSi5L2ipYSx9m0oSKbQgfY1giFU0i3qZGmqq0olfhToZPfNPT82zQn
         rDtcSMg2oBO5X3OPc4715GZ9PfZLOSZuo84OqIZWjqEWME8RGaRbnEiDPZtxaME//HPT
         XzXbLuFQWVc3TwiSCDIR3mPXrD2w/W8lnMU+IIJkBvJvAZ+vAB2ClkpRX/VApOaO/pve
         UUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GwWVu2+5Fr9I917aKcPT/HS0aZzUuwXyiK6hQYxff0Y=;
        b=WYqOVfXLEmv5TKnN3o7bGxvj4LYz1hBeEes4YviNxTKJ7MRcIe8HnqAKLyzgIE2ECu
         NlFSbFSHSN2+4lDaqMMVpMjJOjrgdveTGhrgvtNF1UjZwTDcf49IhWLr3Q4LEQPCFOiL
         IBoVtQdUwi0JOqDeTeLzhZi7p3JKtiYHmCrYkUZtD0Yl3SyZ5UAwyDqqwlMS+lTJ08iX
         6Xb1PfrPau6HT0u5sYx9HzHcgEDBArDILjuLW5S8DK/ntzAoQd00zv/yXh9LGnbY65aq
         jM54oo/q2gQUaLtLqQbHhwcOC+cCnnoXRBSUncUkI86niT8APGTCEzFFoo3Rmbry8iZT
         U4BQ==
X-Gm-Message-State: APjAAAVU2ETDgv1EFp7qzddH8XRb3ffV/GVV9/vgksaTHetDuAvDGyzv
        exuGRBvgVL3g3MB+LQZwfPqphi0FdgZgGnTEA5UbYQ==
X-Google-Smtp-Source: APXvYqyeXn5oMaTGLhKcxf0Phu69ND6nGk4txUZfLo/aYJdsiNxunZFvwptxPiQ8knbXgDiQoRo8eLMoRaF8ZWPm5TI=
X-Received: by 2002:a02:4e05:: with SMTP id r5mr54122035jaa.27.1561486308075;
 Tue, 25 Jun 2019 11:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560898723.git.matheus.bernardino@usp.br>
 <5a678ee74de42f1373deeed718fa24d368347d13.1560898723.git.matheus.bernardino@usp.br>
 <xmqqimstfsui.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimstfsui.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 25 Jun 2019 15:11:37 -0300
Message-ID: <CAHd-oW5UCqnXDoLcx5=BRBwobHF52h-wJUBJh2B3-sy-p1nS5Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH v7 06/10] dir-iterator: add flags parameter to dir_iterator_begin
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Daniel Ferreira <bnmvco@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 25, 2019 at 3:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> This hunk, which claims to have 25 lines in the postimage ...
>
> > @@ -44,6 +45,25 @@
> >   * dir_iterator_advance() again.
> >   */
> >
> > +/*
> > + * Flags for dir_iterator_begin:
> > + *
> > + * - DIR_ITERATOR_PEDANTIC: override dir-iterator's default behavior
> > + *   in case of an error at dir_iterator_advance(), which is to keep
> > + *   looking for a next valid entry. With this flag, resources are freed
> > + *   and ITER_ERROR is returned immediately. In both cases, a meaningful
> > + *   warning is emitted. Note: ENOENT errors are always ignored so that
> > + *   the API users may remove files during iteration.
> > + *
> > + * - DIR_ITERATOR_FOLLOW_SYMLINKS: make dir-iterator follow symlinks.
> > + *   i.e., linked directories' contents will be iterated over and
> > + *   iter->base.st will contain information on the referred files,
> > + *   not the symlinks themselves, which is the default behavior.
> > + *   Recursive symlinks are skipped with a warning and broken symlinks
> > + *   are ignored.
> > + */
> > +#define DIR_ITERATOR_PEDANTIC (1 << 0)
> > +#define DIR_ITERATOR_FOLLOW_SYMLINKS (1 << 1)
> > +
> >  struct dir_iterator {
> >       /* The current path: */
> >       struct strbuf path;
> > @@ -58,29 +78,38 @@ struct dir_iterator {
>
> ... adds 20 lines, making the postimage 26 lines long.
>
> Did you hand edit your patch?  It is OK to do so, as long as you
> know what you are doing ;-).  Adjust the length of the postimage on
> the @@ ... @@ line to make it consistent with the patch text, and
> also make sure a tweak you do here won't make later patches not
> apply.

Oh, I'm sorry for that, I'll be more careful with hand editing next
time. Thanks for the advice. I think for this time it won't affect the
later patches as it was a minor addition at one comment, but should I
perhaps re-send it?
