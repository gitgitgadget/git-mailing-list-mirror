Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7B5208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 06:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeHFIPH (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 04:15:07 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45372 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeHFIPG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 04:15:06 -0400
Received: by mail-yw1-f68.google.com with SMTP id 139-v6so3200446ywg.12
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 23:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4kQQnysbilwti3HEZ+/q5zQh/765ee4I0DIChTY3cjA=;
        b=DRwXg9yawG2N21rk5qEMthrVbIjnRJ3NG/+icDYZMoOwp5L4aAL33N+QoY5PIGe0fh
         Akfaev8ghEPZ+B5N36D1ykAjYPhUHIygJSma2bxxLyLWx4LJQakKWl8BaMpW5djG7fbV
         ZtMqhkly+qcprzyBYiXjXRxja8wGpaDwaZG3a0oKlsKUeuABOHmNPAQUYfxthjl7eY0x
         PUzK9i+jlNvjxQxbEK1EF3d2qHSdnfoxj47srBYAjxQ8DI8VDA2JRpv9MfNaHj1fQaP3
         hmZ3DK7iTZfgLnLWIz5JHj/3m6XUGjP9RmZXV1PIEq4QbSpiEHfj/Wf6wwu9A/azb4qb
         OjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4kQQnysbilwti3HEZ+/q5zQh/765ee4I0DIChTY3cjA=;
        b=FH5iWgVa9xL2E6HhI4FLz2WqjrI1ap8gbAGDwOOYIWjSj9AtTIgVA9Fq0/0xA3rNeI
         rTuu5zphsX6HMo7WPdGoV0zUZiVH0jdmInlmxhmqfJbtPquADhlOHwoRSeehEe1tbKvk
         75yyI9NLmF4FkccI4KlDiDIihO2HqJVkgTjDoRc+EvUO6vB/pQb132EWP4KLYLDtXTqB
         +fMmABYoap1XHSOXWEiO2bE9iVrO9bHwSuqJwYz9OY59mOBRwi1DnDXRzsD+DG3HGdsy
         BZ/voJNUnpLexM6AEMHaHNbcs2DfEvCfxRmDEqzT0JcdSG/HFHkYbpq2p6TGBJH3z4g4
         xfIw==
X-Gm-Message-State: AOUpUlEffoAhzuqpS5UhWqm8ghdGpIKpXfVM8JuSCCu/2tvF4x+8zH33
        prWTB8hhy3FifBbA+uJwKurWjs4YPa/jyzUvfRWgyn7Y
X-Google-Smtp-Source: AAOMgpf2NXztLtDDDQY+iLAJbyuchYceBvFCQtl5BaDBLke5JBbQhVtH4WepW2k6a32e3XXw+DHu5SUvlVQ9hY7QQVU=
X-Received: by 2002:a0d:d342:: with SMTP id v63-v6mr7063704ywd.500.1533535656693;
 Sun, 05 Aug 2018 23:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180804015317.182683-1-sbeller@google.com> <20180804015317.182683-8-sbeller@google.com>
 <xmqqtvoarr3d.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvoarr3d.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 5 Aug 2018 23:07:25 -0700
Message-ID: <CAGZ79kYA4BNe1N+_S=vqwsn2wNH6qQz=kcgwc9Ufr8nfQT85rA@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] diff/am: enhance diff format to use */~ for moved lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 4, 2018 at 10:15 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > Try it out via
> >     ./git-format-patch --mark-moved 15ef69314d^..15ef69314d
> > to see if you like it.
> >
> > This separates the coloring decision from the detection of moved lines.
> > When giving --mark-moved, move detection is still performed and the output
> > markers are adjusted to */~ for new and old code.
> >
> > git-apply and git-am will also accept these patches by rewriting those
> > signs back to +/-.
> >
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
>
> This does not have anything to do with the range-diff topic, but
> would stand on its own merit.

Yes. I should have emphasized this more in the cover letter.
This is more a "while at it" thing, that is easy to do due to the
refactoring in previous patches.

> I have a mixed feeling about this.

Me, too.

> If you need to convince "GNU patch" maintainers to accept these two
> signs, then probably it is not worth the battle of incompatiblity.
> If it is truly a worthy innovation, they would follow suit, which is
> how they learned to take our renaming diffs without us prodding
> them.  I just do not get the gut feeling that it would happen for
> this particular thing, and I am not convinced myself enough to sell
> this to "patch" maintainers and expect to be taken seriously.

ok.

> When reviewing anything complex that would be helped by moved code
> highlighting, I do not think a normal person would choose to review
> such a change only inside MUA.  I certainly won't.  I'd rather apply
> the patch and view it within a larger context than the piece of
> e-mail that was originally sent offers, with better tools like -W
> and --color-moved applied locally.  So in that sense, I do not think
> I'd appreciate lines that begin with '~'/'*' as different kind of
> '-'/'+', as helpful hints; at least until my eyes get used to them,
> they would only appear as distraction.

My use case would be patches that are *not* complex, but still shuffling
lots of code around, e.g. reordering functions/paragraphs in a file.

> In other words, I have this nagging suspicion that people who
> suggested to you that this would help in e-mail workflow are
> misguided and they do not understand e-mail workflow in the first
> place, but perhaps it is just me.

There are no other people that suggested this.
It was really just a quick shot "while at it" as we had the
refactoring in place that enables this, and I think for trivial
patches (non-complex, but lots of changes) it *may* be beneficial.
But it is more for corner cases, I guess.

Stefan
