Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8DB31F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeBHQXy (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:23:54 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35580 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbeBHQXv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:23:51 -0500
Received: by mail-wm0-f51.google.com with SMTP id r78so11095623wme.0
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=T55b8UoER6SfR+YzbD8e0Jy0N8Eurciw3FwB8fgSi3o=;
        b=RqOXCQHZc75wdFTVO+EZbCtGoDaM8+BsLw/WFgwubXdgrKHz2SuIQHFVBAQ7ZLdjEZ
         a6Rh2RdV0ThGl01UP7rNEO8JOPN6BeSDVA/gbh4iPTiMCW8X4x2I+5oAWEd+kw4tAtJK
         HB6AhI0ljOh+2SBokIbPY9NosiaC4be33Ok7pOHiK/GxRVyu0RRpTrNduemdJVjfJJ4U
         gUcsFA2FfH5Lp5eJaIAp2vhWP1m2YHFEZ/JfpVu3jOSG6LdRM2WI0hq1O1QFA2trsb9d
         MP+uPKxDJeba2Wn5BgUF5fIqcQRA5LpRfZ6eFqWvJdE6n3pK2xmDdvVWYhNCrgtiXj6K
         nhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=T55b8UoER6SfR+YzbD8e0Jy0N8Eurciw3FwB8fgSi3o=;
        b=tVSQccwCz5OOv1uXyid5gQdcuL9fwIshrUaZ48YwwbA7rjWs1s2puxPkvJUFiAtj2l
         n0WJcsMfbwkb6pkp6v40C3kaMpPyZrRr+NRfgpvO8eg+WsKrunKjj4ISBtdH/IeUMTPe
         8PFE+42O5Qe8E3iPtj34OWqOoO85MeqqdKEykzdzqDBrmAwDxoFFha2jLhIYsjw3fW4Z
         JSwVx9m5vJZVHnHIVxrwYTubLw4HlzOvek3g0oF6P3F7Cjzv/VxNclMSndgYmIQP57vh
         AgU1MvBBxMbdzp9b3FR/quUnDsng76xVCWVJpQAasKXpE1QPVqDZzEOyTRLRUiQ/0qlE
         ne9g==
X-Gm-Message-State: APf1xPAtmYEF69nwAqA5nrkfDqShTRXz5siYg7fuqI9jmftGzq3oJAh4
        oEKby7e/CC+CHYxX4XUGOTZlNpRy
X-Google-Smtp-Source: AH8x225tF+2xsF7S8yM09NFqC4fis7dWKbfoO6fV0H++/GAB0ohdNGbZxfMsQCcQSe5RjfS7iKG9dg==
X-Received: by 10.80.180.184 with SMTP id w53mr2377534edd.149.1518107029190;
        Thu, 08 Feb 2018 08:23:49 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id z2sm136411edc.50.2018.02.08.08.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 08:23:48 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
        <pclouds@gmail.com>, Christian Couder <christian.couder@gmail.com>
Subject: Re: git gc --auto yelling at users where a repo legitimately has >6700 loose objects
References: <87inc89j38.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <87inc89j38.fsf@evledraar.gmail.com>
Date:   Thu, 08 Feb 2018 17:23:47 +0100
Message-ID: <87eflvmovg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 11 2018, Ævar Arnfjörð Bjarmason jotted:

> I recently disabled gc.auto=0 and my nightly aggressive repack script on
> our big monorepo across our infra, relying instead on git gc --auto in
> the background to just do its thing.
>
> I didn't want users to wait for git-gc, and I'd written this nightly
> cronjob before git-gc learned to detach to the background.
>
> But now I have git-gc on some servers yelling at users on every pull
> command:
>
>     warning: There are too many unreachable loose objects; run 'git prune' to remove them.
>
> The reason is that I have all the values at git's default settings, and
> there legitimately are >~6700 loose objects that were created in the
> last 2 weeks.
>
> For those rusty on git-gc's defaults, this is what it looks like in this
> scenario:
>
>  1. User runs "git pull"
>  2. git gc --auto is called, there are >6700 loose objects
>  3. it forks into the background, tries to prune and repack, objects
>     older than gc.pruneExpire (2.weeks.ago) are pruned.
>  4. At the end of all this, we check *again* if we have >6700 objects,
>     if we do we print "run 'git prune'" to .git/gc.log, and will just
>     emit that error for the next day before trying again, at which point
>     we unlink the gc.log and retry, see gc.logExpiry.
>
> Right now I've just worked around this by setting gc.pruneExpire to a
> lower value (4.days.ago). But there's a larger issue to be addressed
> here, and I'm not sure how.
>
> When the warning was added in [1] it didn't know to detach to the
> background yet, that came in [2], shortly after came gc.log in [3].
>
> We could add another gc.auto-like limit, which could be set at some
> higher value than gc.auto. "Hey if I have more than 6700 loose objects,
> prune the <2wks old ones, but if at the end there's still >6700 I don't
> want to hear about it unless there's >6700*N".
>
> I thought I'd just add that, but the details of how to pass that message
> around get nasty. With that solution we *also* don't want git gc to
> start churning in the background once we reach >6700 objects, so we need
> something like gc.logExpiry which defers the gc until the next day. We
> might need to create .git/gc-waitabit.marker, ew.
>
> More generally, these hard limits seem contrary to what the user cares
> about. E.g. I suspect that most of these loose objects come from
> branches since deleted in upstream, whose objects could have a different
> retention policy.
>
> Or we could say "I want 2 weeks of objects, but if that runs against the
> 6700 limit just keep the latest 6700/2".
>
> 1. a087cc9819 ("git-gc --auto: protect ourselves from accumulated
>    cruft", 2007-09-17)
> 2. 9f673f9477 ("gc: config option for running --auto in background",
>    2014-02-08)
> 3. 329e6e8794 ("gc: save log from daemonized gc --auto and print it next
>    time", 2015-09-19)

My just-sent "How to produce a loose ref+size explosion via pruning +
git-gc", <87fu6bmr0j.fsf@evledraar.gmail.com>
(https://public-inbox.org/git/87fu6bmr0j.fsf@evledraar.gmail.com/),
shows an easy way to reproduce this.

After the steps outlined there git-gc --auto will end up in a state
where it'll start telling the user off for having too many loose
objects.
