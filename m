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
	by dcvr.yhbt.net (Postfix) with ESMTP id C18621F453
	for <e@80x24.org>; Tue, 16 Oct 2018 21:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJQFJl (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 01:09:41 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:46378 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQFJl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 01:09:41 -0400
Received: by mail-ed1-f43.google.com with SMTP id g32-v6so22764615edg.13
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=1RfOdXjroCA7jlYPEE5yWsMmFBJGy2IrUPw6XSYv/RA=;
        b=HSGifJoo3Ss/I+upJEZFBhg9iyslukI9lZiyoevJuVnWHPKYSR5twPsmGd+7UhNwvD
         CLfNVI9tWu3voO++kABe1Uy+XtkGgQB/xLXZ40fWnxtWO+IApBk7Q+89SmLur0Jg8mUS
         rmasOfSy/1xGBcdajXNmCocghaVJXasj9ra++1ldcinB1o3y7GjMQbBrpJC+IAricYsC
         B99PDx+iBpdPUDNlf7de9vU4yf1DePq4uJP9UyLtvwQntdg3kGtNCU2U2mQe9LsgTGrF
         6BsgmfYjWxDWNUSrWm3R7TghZ1ldK3FjuSZlT5C6+hOC0W+qzQQki7JSh9qWP5mmesIi
         RlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=1RfOdXjroCA7jlYPEE5yWsMmFBJGy2IrUPw6XSYv/RA=;
        b=LLW3VqvVuLdounC5fU7Kn6lq+qA5AJEp8exmE9k/CxqNaShDkf435T3AKQJZb6JEny
         FVg58DSbSlFW/eM/MIt/VkMK1cVY6IgPO6h13zN8rCwYSDbXGeWmDmEj9KH4rUPhlKaM
         IR3Pps42TaH2/Xv35MLjaFXN0kInOU1EpEZbNmzONoiLglEDs8a32clM9jsE0YvCQT4a
         +Cih0p2qnTHkmAJ5X6awk31k2Dz2IcygrUrk4lFdLCuwr1fYG2aTtyYxw3cYymTOdXl1
         bAl6wceVdHGgv3APE5veVZKBBvVqlqRjYw2J0oC+g4rqMJFjvVDuqFM/xoJWPGSHNdV7
         +1Fw==
X-Gm-Message-State: ABuFfoi13ENBrIXr78b3uwfpmHgAEbsewL6VsMVr/j8335Xob3Ol/RRe
        bfcmQdbyRb29ddJUsCxmx2ow41bi
X-Google-Smtp-Source: ACcGV60SVI/AfaerdaQg4/uViLSLInc2QQOJP6l1UIE+jkOBCOcXdRZu5GHjFI7xlUnIyY9pb3kskQ==
X-Received: by 2002:a50:ab81:: with SMTP id u1-v6mr32534516edc.259.1539724643086;
        Tue, 16 Oct 2018 14:17:23 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id z7-v6sm5393995edd.71.2018.10.16.14.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 14:17:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stas Bekman <stas@stason.org>
Cc:     git@vger.kernel.org
Subject: Re: problem with not being able to enforce git content filters
References: <5d4966c8-8171-9a0a-5120-f7c151c2b81f@stason.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <5d4966c8-8171-9a0a-5120-f7c151c2b81f@stason.org>
Date:   Tue, 16 Oct 2018 23:17:21 +0200
Message-ID: <87y3axd21q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 16 2018, Stas Bekman wrote:

> When a person has a stripped out notebook checked out, when another
> person commits un-stripped out notebook, it leads to: invalid `git
> status` reports, `git pull` breaks, `git stash` doesn't work, since it
> tries to stash using the filters, and `git pull' can never succeed
> because it thinks that it'll overwrite the local changes, but `git diff`
> returns no changes.

Planting a flag here. Let's get to this later.

> So the only solution when this happens is to disable the filters, clean
> up the mess, re-enable the filters. Many people just make a new clone -
> ouch!
>
> And the biggest problem is that it affects all users who may have the
> filters enabled, e.g. because they worked on a PR, and not just devs -
> i.e. the repercussions are much bigger than just a few devs affected.
>
> We can't use server-side hooks to enforce this because the project is on
> github.

Ultimately git's a distributed system and we won't ever be able to
enforce that users in their local copies use filters, and they might
edit stuff e.g. in the GitHub UI directly, or with some other git
implementation.

So if you have such special needs maybe consider hosting your own setup
where you can have pre-receive hooks, or within GitHub e.g. enforce that
all things must go through merge requests, and have some robot that
checks that the content to be merged has gone through filters before
being approved.

> And the devs honestly try to do their best to remember to configure the
> filters, but for some reason they disappear for them, don't ask me why,
> I don't know. This is an open source project team, not a work place.

*Picks up flag*. For the purposes of us trying to understand this report
it would be really useful to boil what's happening down to some
step-by-step reproducible recipe.

I.e. with some dummy filter configured & not configured how does "git
pull" end up breaking, and in this case you're alluding to git simply
forgetting config, how would that happen?

> There needs to be a way for a project to define content filters w/o
> going via user's .gitconfig configuration, since due to git's security
> it can't be distributed to all users and must be enabled manually by
> each user, which is just not the right solution in this case.
>
> Of course, I'm open to other suggestions that may help this issue.
>
> "Tell your developers they must configure the filters" is not it - I
> tried it for a long time and in vain. If you look at our install
> instructions: https://github.com/fastai/fastai#developer-install
>
>   git clone https://github.com/fastai/fastai
>   cd fastai
>   tools/run-after-git-clone
>
> It already includes an instruction to run a script which enables the
> filters, but this doesn't seem to help (and no, it's not a problem with
> the script). The devs report that the configuration is there for a
> while, and then suddenly it is not there, I don't know why. Perhaps they
> make a new clone and forget to re-enable the filters, perhaps they
> disable them to clean up and forget to reenable them, I can't tell.

FWIW I tried following these on my Debian install and both on python2
and python3 I get either syntax errors or a combo of that and a missing
pathlib from that script. I don't know Python well enough to debug
it. Maybe that's part of the issue?

> The bottom line it sucks and I hope that you can help with offering a
> programmatic solution, rather than recommending creating a police
> department.

I think it would be great to have .gitconfig in-repo support, but a lot
of security & UI problems need to be surmounted before that would
happen, here's some previous ramblings of mine on that issue:
https://public-inbox.org/git/?q=87zi6eakkt.fsf%40evledraar.gmail.com

It now occurs to me that a rather minimal proof-of-concept version of
that would be:

 1. On repository clone, detect if HEAD:.gitconfig exists

 2. If it does, and we trust $(git config -f <untrusted file> -l)
    enough, emit some advice() output saying the project suggests
    setting config so-and-so, and that you could run the following one
    liner(s) to set it if you agree.

 3. Once we have that we could eventually nudge our way towards
    something like what I suggested in the linked threads above,
    i.e. consuming some subset of that config directly from the repo's
    HEAD:.gitconfig
