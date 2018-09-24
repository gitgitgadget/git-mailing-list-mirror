Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E181F453
	for <e@80x24.org>; Mon, 24 Sep 2018 21:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeIYDMT (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 23:12:19 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38439 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeIYDMT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 23:12:19 -0400
Received: by mail-ed1-f54.google.com with SMTP id x8-v6so3657743eds.5
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 14:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=xzIISK5yjCTHeMyujJACw+r3ad7jweaI4oRzgy2qXvc=;
        b=ZOA45cAouP0WdZUgnStriVyYA+UvZ+FtJFRZYoxG12P0emV5KbnJF/GSQUPlLfA0Hz
         EpKiwkjCbqfx7fx3uTx9WAX0nq4+hbyJWdlt3+xCQDI9j+1RM8IQJ5ietqLMajrBBpI0
         nYX0mLZzlnCSB3J2hcRzvPFb8fburjrKreogLjAMtu76QEkn5xp0KrvRd9SVJpc2oLDX
         sQEgb/noTd7el8327HEas2UAyAbL286bdoMgZpi3RrmHoXnvHixBYyvYCAXbcpgOdE6F
         QqbSCc/Zr4vkb/GqsyqgvuLugH1yQgCXwlufF848FH24XWoin1mlMEGzaQaCNlgTQb68
         ZZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=xzIISK5yjCTHeMyujJACw+r3ad7jweaI4oRzgy2qXvc=;
        b=fQ8Ob5MhBxBCe+h7QSMRWMebK4PFbq/p3oxQNl3AMTmNG4ca2xSqjhNwXJsXxl1d80
         4kyO6xr9ziC1lMoeBs0Y2hhq8pTHS5YOjFZREF4PC5ljq4pPJHGTgkUI9E2qupErbRQK
         GnWPv6q47AIxmlNei0J0OB7Cultw66mzGkhwRHAOcg5NeFg0u8rbaXZvnq76hfeVk6wf
         UHzlIl/xS5S3n4/ceBDrYuNmvBdL4FtFP1MYKR3TpL/GR9O8sP/eeGbgKGUD7AhYvecN
         C/2W1jGalEYr9S81rAHGV3icWL94RrXvWk0lNr89cczkSS3GKnAmRAij3nt0vtrvPB9i
         3stQ==
X-Gm-Message-State: ABuFfog2rdoXXGXqU3d69s+qcDnsgR2hbT03zgmIxM5L+rWawqHv89rn
        7qUIjG5os5trZUC6iwkVQrbM3tly0BI=
X-Google-Smtp-Source: ACcGV62yS/k7R/3G9dBMScWeIxcMCniDbQeSm3NhyW+jP7TeaJqiIvFTJ+8SPvW9GVoL0ASXQbD7tQ==
X-Received: by 2002:aa7:c549:: with SMTP id s9-v6mr1050706edr.73.1537823290925;
        Mon, 24 Sep 2018 14:08:10 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id k24-v6sm6434058eda.71.2018.09.24.14.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 14:08:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stas Bekman <stas@stason.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git silently ignores include directive with single quotes
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
        <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
        <87bm97rcih.fsf@evledraar.gmail.com>
        <20180908211436.GA31560@sigill.intra.peff.net>
        <ad56c575-1211-61d2-daed-5b0da61db738@ramsayjones.plus.com>
        <20180909023332.GA14762@sigill.intra.peff.net>
        <xmqqk1nrojpq.fsf@gitster-ct.c.googlers.com>
        <20180911205709.GA25828@sigill.intra.peff.net>
        <29173fd8-ce72-0927-9bfe-786442dfd82c@stason.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <29173fd8-ce72-0927-9bfe-786442dfd82c@stason.org>
Date:   Mon, 24 Sep 2018 23:08:09 +0200
Message-ID: <87efdik3ie.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 23 2018, Stas Bekman wrote:

> Apologies for I don't know how this project manages issues, so I'm not
> sure whether it is my responsibility to make sure this issue gets
> resolved, or do you have some tracking mechanism where you have it
> registered? There is no rush, I'm asking because the discussion about
> this issue has suddenly dropped about 2 weeks ago, hence my ping.

Posting to this mailing list is generally how it's done, see
https://github.com/git/git/blame/v2.19.0/README.md#L30-L37

Git's a project worked on by a bunch of people who're either doing it as
a hobby, or are otherwise busy chasing stuff they're planning to work
on.

That doesn't mean the issue you reported doesn't matter, just that
realistically we have thousands of issues big and small at any given
time, and any new reported issue competes with those. There's always too
much to do, and too little time to do it.

Personally, I'm interested enough in this to muse about how it could be
fixed / what sort of general issues it exposes, but not enough to tackle
it myself, the general silence for a couple of weeks means a lot of
people share that sentiment (or care even less).

That doesn't mean this issue doesn't matter, or that it couldn't be
addressed in some way. I just wanted to try to give you some fair &
realistic summary of what's going on.

The best way to fix stuff in git that you can't interest others in is to
do it yourself. Take a look at Documentation/SubmittingPatches in the
git.git repository for how to do that.

In particular, starting by clarifying the docs around this as I
suggested upthread might be a good and easy start to your first
contribution to git!

I hope that helps.
