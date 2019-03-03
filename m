Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C9D20248
	for <e@80x24.org>; Sun,  3 Mar 2019 18:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfCCSZP (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 13:25:15 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33424 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfCCSZP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 13:25:15 -0500
Received: by mail-ed1-f67.google.com with SMTP id c55so2434924edb.0
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 10:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1AU2syCpEc0bVA7o9Sy/4Z6Yi7h182TRkJS9kkuT2s=;
        b=TSwIySFMWFNVGj6jljpmlKTZSIsbuXbkzEDAxJm7QGHclI2OfG6P53EwBYQFJq10Up
         thnKKoWSTlu/kQbLOL+j0QMDbE2rvn8Z5Vi5EwhoKnc0DkJ5aGtp5lgMP4LUncnPNVdo
         RgVY9ioRzFLGUP2vch70o5L1KDSwWUBL9XXP0uXojOrpflMkUkp3815SYjx+LQwLaP5m
         y5jzb9acC7arInQZVElHKa1ETXP018NGTiUetj1B3IsBJDYX9Wc2Qw1Rb1knFnSxPZUl
         bwg/6JGiWcYeu4VHGWfc16fy6V6Y1bWSY2f+OTG0sUgo6v8vccwMM0F9jrRhziPZK7YZ
         0O2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1AU2syCpEc0bVA7o9Sy/4Z6Yi7h182TRkJS9kkuT2s=;
        b=JFZV/8hsxe1jVmg+A3j6xv6WtfebJYNwYp5ti+EyZ7MmEgxoCb7Cdgr8AkM7W0yI3G
         KHApdJLqzIyLmZ8y71fhC1cmX+Pe+OL7KXkiql8uw4QIHxY5gmSfkmsvk81qOpymn+nk
         5RpJ5CzeWDh03hKnEsKiFFxI9QZ/+R/8ZDuKK74xuKLegw5kcHHF8Epvxg6WZA+4Tfx0
         i36w8qPcWVTWMJskw+ZaVLSq/bPBHL6Ijh4m7BovqpMcP7qCxhMx2m+NcA9d5uZQ2CGl
         u9B8+zsS4kBfPAD0m4ahRwvn6ovlKOJ+Wy6BQXkIsU+1SjQdIchfmvqB9/jzgRoVcJjn
         bnqA==
X-Gm-Message-State: APjAAAVCJCG0gvi9/LKBCzCJBNs4C5/qFQeUGvRYTnKu8xd5VAqUUIza
        kmS3GVkayWheuTc69sWGaxG+nt5nYaXiBJ38tP1P8GLy
X-Google-Smtp-Source: APXvYqwHaQhzvD9sadqWYq6J15ggqqcluVZyF8X4h48cXFh5NaXlR5DKyG/eHP5iXMQ/kSHhJjXBUIlKDsGzlvvbIME=
X-Received: by 2002:a17:906:c286:: with SMTP id r6mr10161575ejz.7.1551637513663;
 Sun, 03 Mar 2019 10:25:13 -0800 (PST)
MIME-Version: 1.0
References: <20190222061949.GA9875@sigill.intra.peff.net> <20190222062327.GC10248@sigill.intra.peff.net>
 <xmqqsgwfr9vr.fsf@gitster-ct.c.googlers.com> <20190223134452.GE22403@sigill.intra.peff.net>
In-Reply-To: <20190223134452.GE22403@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 3 Mar 2019 19:25:02 +0100
Message-ID: <CAP8UFD3bBMNq6p+oSaO8up8pWXJpMCWMQZfDn_kH-ZGPhqUpFA@mail.gmail.com>
Subject: Re: [PATCH 3/3] bisect: make diff-tree output prettier
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bartosz Baranowski <bbaranow@redhat.com>,
        git <git@vger.kernel.org>, Jon Seymour <jon.seymour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 23, 2019 at 2:44 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Feb 22, 2019 at 09:49:44AM -0800, Junio C Hamano wrote:
>

> > > If we do care about the change in exit code from bisect, then it
> > > probably does make sense to go with an external process. Then it can
> > > happily die on the corruption, while bisect continues with the rest of
> > > the high-level operation. I'm not sure it really matters much, though.
> > > Once your repository is corrupted, all bets are off. It's nice that we
> > > can bisect in such a state at all.
> >
> > This is about showing the very final message after finding which one
> > is the culprit.  Is there any other "clean-up" action we need to do
> > after showing the message?  I do not care too much about the exit
> > code from the bisection, but if dying from diff-tree can interfere
> > with such a clean-up, that would bother me a lot more, and at that
> > point, given especially that this is not a performance sensitive
> > thing at all (it is not even invoked log(n) times---just once at the
> > end), moving to external process may make it a lot simpler and
> > cleaner.
>
> Thanks, I had a vague feeling along these lines, but you nicely put it
> into words. As far as I can tell, no, we're not missing any important
> cleanup in that process; it looks like the only call to show_diff_tree()
> then calls exit(10) immediately after.
>
> However, that does change our exit code, which git-bisect.sh then
> propagates instead of writing the entry into the BISECT_LOG.
>
> I'm still not convinced this is really worth caring about, as it implies
> a corrupt repo.

I don't care much about what happens in a corrupt repo, but I am
adding Jon Seymour in CC who wrote those tests in:

d3dfeedf2e (bisect: add tests to document expected behaviour in
presence of broken trees., 2011-08-04)
b704a8b3fd (bisect: add tests for the --no-checkout option., 2011-08-04)
