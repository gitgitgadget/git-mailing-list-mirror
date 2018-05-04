Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29BD4200B9
	for <e@80x24.org>; Fri,  4 May 2018 18:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbeEDSCi (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 14:02:38 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35575 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeEDSCh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 14:02:37 -0400
Received: by mail-wm0-f53.google.com with SMTP id o78-v6so6328299wmg.0
        for <git@vger.kernel.org>; Fri, 04 May 2018 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=OFpQUSHPDQa+Mi6QoSqkEblzFKrlISH7j+ETfZErV+o=;
        b=nQJGKGyMeeM7ju1ASH30iJpBZrEA6wWLS5xfD8YhHIQnyZ2xzSqTxBTn1cO+f2fAS3
         jfKNZFgwZR60qGtnfJjt4iayWNmfi0FTjdbHRMwCzB3dUmPVJ1mBAi6ZivMVq3cHGxKq
         CRR/zyEPkW7EbMo+RGC2sH3eCYT5X/ls+IILYKUcF1KoY4QClwutgeamtHexq5Sz5Wu8
         Pd5xQDNZW1qVgoSJVJ3oaOrOCrUIwirj8WInCfMknAOxI4NPMttZjhZxXXBWIafvxQlV
         6b5b4Itp96Pd9qTsLOh/EJiS9qV13Hy6ZmNsbyvn8PuV3NIdksmja8cj5Nb+0CFRQn1t
         3osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=OFpQUSHPDQa+Mi6QoSqkEblzFKrlISH7j+ETfZErV+o=;
        b=AhtlDZwnjXfRSAOzm/XTT8J4//0/xzUjJ9Q6WvXFPTCtS/ddJzl07N/uHXti3PSjZp
         iXoKy+4Fau0jdb7yqccoYsfmgP/M9EApivEcAV6YE2wY0tnuTu//t2qk4Adz8COFNiM2
         1IqympCW/Aapx1C8ZH7eNo40HlTnWchV0e74w90p3d9NN8H9uzrAdmiU3LPSdk24jIJZ
         ZjUq1yCvw3xBb/jLn2sBAXdolKYmjGq0qFHSEVPMYFyfhykx8Cjglu9HWTqlPRxHCMvV
         1cA0lEfQ0KveFZsjdJFy2lqxD0jksg/DgXY9cGILJfDcZ4+eWScenfv11ESMjIswNq1E
         ri8w==
X-Gm-Message-State: ALQs6tDLy6F1OKwzYGO8wbMrGBJap9+E8Gfm+AGBQyWXP8lQptIqGRmv
        Ny0trdldkX4Xwm2UYJqYVOJNWL0t
X-Google-Smtp-Source: AB8JxZosJsZ69BFp3Aa1DdAhmVkITIIh6DD++AgtjWsagO+OXhPYVEVRAbV4mxKqabomAzF5l1Afaw==
X-Received: by 2002:a50:afe4:: with SMTP id h91-v6mr33265713edd.154.1525456955424;
        Fri, 04 May 2018 11:02:35 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id l33-v6sm5170965edd.59.2018.05.04.11.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 May 2018 11:02:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] checkout & worktree: introduce checkout.implicitRemote
References: <87y3h1ykwn.fsf@evledraar.gmail.com>
        <20180503131840.27956-1-avarab@gmail.com>
        <CACsJy8CYp3zVSRtS5ozHCitnWU81AamqEGR8RZdDkwujShEatw@mail.gmail.com>
        <87muxfyhy9.fsf@evledraar.gmail.com>
        <CACsJy8D+k+9SNBq7SNFpUhhdZDH7QaZ3+_rXMrge+b5KF_j9xA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8D+k+9SNBq7SNFpUhhdZDH7QaZ3+_rXMrge+b5KF_j9xA@mail.gmail.com>
Date:   Fri, 04 May 2018 20:02:33 +0200
Message-ID: <87k1sjxps6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 04 2018, Duy Nguyen wrote:

> On Fri, May 4, 2018 at 9:54 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> Realistically the way we do hooks now would make the UI of this suck,
>> i.e. you couldn't configure it globally or system-wide easily. Something
>> like what I noted in
>> https://public-inbox.org/git/871sf3el01.fsf@evledraar.gmail.com/ would
>> make it suck less, but that's a much bigger task.
>
> I thought you would bring this up :) I've given some more thoughts on
> this topic and am willing to implement something like below, in a week
> or two. Would that help change your mind?
>
> I proposed hooks.* config space in that same thread. Here is the
> extension to make it cover both of your points.
>
> hooks.* can have multiple values. So you can specify
> hooks.post-checkout multiple times and all those scripts will run (in
> the same order you specified). Since we already have a search path for
> config (/etc/gitconfig -> $HOME/.gitconfig -> $REPO/config) this helps
> hooks management as well. Execution order is still the same: if you
> specify hooks.post-checkout in both /etc/gitconfig and .git/config,
> then the one in /etc/gitconfig is executed first, the one in .git
> second.
>
> And here's something extra to make it possible to override the search
> order: if you specify hooks.post-checkout = reset (reset is a random
> keyword) then _all_ post-checkout hooks before this point are ignored.
> So you can put this in .git/config
>
> [hooks]
>     post-checkout = reset
>     post-checkout = ~/some-hook
>
> and can be sure that post-checkout specified in $HOME and /etc will
> not affect you, only ~/some-hook will run. If you drop the second line
> then you have no post-checkout hooks. This is a workaround for a
> bigger problem (not being able to unset a config entry) but I think
> it's sufficient for this use case.

A few things:

 1) I don't see a reason to hold back this feature in particular waiting
    for some way to do it via config / hooks. If we grow some compatible
    way to do it via hooks in the future, great, then we can just make
    this (and numerous other config values) historical aliases for that
    facility.

 2) Let's not have some per-config type way to reset earlier config. I
    suggested a way to do it generally in
    https://public-inbox.org/git/874lkq11ug.fsf@evledraar.gmail.com/ I'm
    not saying we should go for that suggestion in particular, but that
    we should have something general.

 3) Doing #2 will take a lot longer to implement than what you're
    suggesting.

 4) I think such a facility should also be able to replace something
    like https://docs.gitlab.com/ee/administration/custom_hooks.html
    which requires not just supporting hooks from the config, but
    executing some hooks on the FS in glob() order.

 5) What you're describing above is just 1/2 of what we need to have a
    viable way to replace something like this checkout.implicitRemote
    with a hook while providing the same functionality to the end
    user.

    If something ships as a config value like checkout.implicitRemote
    users can just turn it on in their ~/.gitconfig without any further
    config, or you can tell users in docs via one-liner to enable it.

    We also need the other half which some method of shipping "standard"
    hooks with git, i.e. with your proposal something like (along with
    the general config reset):

        [config]
            reject = hooks.post-checkout
        [hooks]
            # Reads config from hooks.post-checkout-implicit-remote.*
            # (e.g. hooks.post-checkout-implicit-remote.remote = origin)
            post-checkout = git-hooks://post-checkout-implicit-remote-config

   Only then will this be as easy to enable as `git config --global..`
   (although you'll need two invocations of that, which is fine...)

 6) The feature being discussed here would not be a post-checkout hook,
    but would need to be fairly integrated with the internals of
    checkout, see `dwim_ok` and the big comment in
    parse_branchname_arg().

    I.e. the thing that makes this work is the Nth step in some fairly
    intricate fallback logic. It's not clear to me in the general case
    how we'd turn this into a hook without having N number of
    checkout-what-step-N-hooks, or requiring every checkout-what hook to
    implement a huge part of what checkout.c is doing now just to tweak
    some tiny aspect of it, such as this tweak of
    unique_tracking_name().
