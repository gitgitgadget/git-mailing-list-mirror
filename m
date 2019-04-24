Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6463F1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 08:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfDXIKa (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 04:10:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51867 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfDXIKa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 04:10:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so3365399wmf.1
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 01:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=UZrMQyczdSgU2h+tuT7M9ajfAED2PiTq57XTu18uXNg=;
        b=dZITZfq8fQ7O81aWsI8lc4T0jGrSbuawHRx0omei/1EJClEWirlTOSN/F8VYvlKUjo
         ZNZNw0b7u+F0o2uMQLaYhIInobSDP2t1pY0E6x69mvTgCXsIzuvTStIxer6P8cTszB/U
         wyXct/y/kHK5wSLMzuwKz5jCHwquLFvMH9ch3JrclEkqYntjKHYbJ5tag+snmcaZCq8f
         COGx9VIACjK5SkOUhhZFpS2ZaRwvNRE3gcVTKEL1ejMdL2nLNW3y7RftVubQMwMxJP9P
         ivfC7kcyOkOzWIqOgOuzgunMZnyPb+4ixRPctLBVPAv7phws3rE1yNIOoIXbbO2YFMic
         yd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=UZrMQyczdSgU2h+tuT7M9ajfAED2PiTq57XTu18uXNg=;
        b=LzbeQq8sIxKSO0go39kjVcbxHvonk8jZfqHri1z95R9JPfs9yMNYq3shgOoCEXa0hn
         XTFdSYXv7L9NuEGFfGOWsy9Fe3sLd0OulPn0GY99HccGICW24xF4+UDsQNfh5WUUdKzD
         Mk319k24VoNjSEy9mTvn1XJtjNrNueyJFnF6HeA94tNf5ECrSOLjet8Psux4tBTRmrYQ
         IOnTGfqoewAhu66GTYLqjpwdjclUjwDpsV+D/z6ignxYNZX8P44Ow3fJJ2w5P6yKOfi3
         44lztT1eeCba6I9CVoqO/7EJCYy3Vxus3R0M4aQV6psOLdZ8yGlwE9fkciYDRlBrUuvZ
         PmZw==
X-Gm-Message-State: APjAAAWReOCUJ3NBZtgip780woU52xvTmdP9354MP7JoGVUGN259PxH/
        0HO8HAEAa06UlCd6BQ86DyF9rc9W
X-Google-Smtp-Source: APXvYqxJz2zWSA6IqhO02YcSTKGmsKPlHZdPhbcc44N6yFj88VGgSdb3J+Cm+B59XO1XwfDEFbdLWg==
X-Received: by 2002:a1c:e085:: with SMTP id x127mr5412530wmg.87.1556093427494;
        Wed, 24 Apr 2019 01:10:27 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id o16sm13825901wrw.10.2019.04.24.01.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 01:10:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Multiple hook support
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190424004948.728326-1-sandals@crustytoothpaste.net>
Date:   Wed, 24 Apr 2019 10:10:25 +0200
Message-ID: <87tvensu1a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 24 2019, brian m. carlson wrote:

> Oftentimes, people want to use multiple of the same kind of hook. This
> may be because software or a project they use requires a given hook, but
> they would also like to have a custom hook, or because they're using
> multiple pieces of software that both require involvement with the same
> hook.
>
> This series introduces support for multiple hooks by using a ".d"
> directory. For example, instead of using a single
> ".git/hooks/post-checkout" file, you'd use multiple files within
> ".git/hooks/post-checkout.d". This is the standard Unix paradigm for
> multiple files and should be familiar to most people. Hooks are executed
> in sorted order.

I think it's interesting if people can chime in with current in-the-wild
implementations of this.

I know GitLab's the best, not because I was in any way involved in it,
I've just dealt with writing hooks for it:
https://docs.gitlab.com/ee/administration/custom_hooks.html#chained-hooks-support

There:

 1. The instance has a 'hooks' dir in the .git repo that's a symlink to
    /my/global/hooks. They could also use a /etc/gitconfig
    core.hooksPath for this part, but whatever.

 2. That /my/global/hooks has e.g. a /my/global/hooks/pre-receive that
    git itself runs, which is a trampoline script that runs all over the
    place and executes global/per-project hooks (which live in
    .git/custom_hooks/).

 3. "The hooks of the same type are executed in order and execution
     stops on the first script exiting with a non-zero value."

I wonder if the eventual goal of this facility would be to get such
users on board with using git's native feature for this. This series is
most of the way there for GitLab's case, but not quite.

> To preserve backwards compatibility, we don't run the hooks in the ".d"
> directory if the single file is a valid hook (i.e. it exists and is
> executable). This is because some people already have multiple hook
> scripts configured, and if we ran them both, we'd run the hooks twice.
> This would be bad for e.g. the prepare-commit-msg hook. This is also the
> least surprising behavior.
>
> We check each hook for its exit status, even if the hook normally
> ignores exit status, and if it fails, we abort executing further hooks.
> This provides an easy way to reason about what the exit status is when a
> hook fails; we need not consider how to handle multiple failing hooks.
> It's also consistent among all hooks, whether they care about exit
> status or not.

Others have replied to this already. I linked to the 2016 discussion of
my RFC for this in
https://public-inbox.org/git/87wojjsv9p.fsf@evledraar.gmail.com where I
made the same choice. Some points on that:

 * There was the mention of "but what if someone wants to run them all",
   e.g. for logging to N logging systems where one fails, that's been
   brought up again this time around by others.

 * The case I find more interesting is the ability to run the hooks in
   parallel. Saying "glob order and exit on first fail" categorically
   closes the door to that.

> I've talked with some people about this approach, and they've indicated
> they would prefer a configuration-based approach. I've tried to make the
> series such that it can be replaced with such an approach if that's the
> decision we make. It should be easy enough to simply replace find_hooks
> with an appropriate implementation and update the test framework.

I think whatever opinions we all have on the current implementation it's
OK to get this in in *some* form and just made it configurable or
whatever later.

Most of the work is the ability to run N hooks, how exactly that happens
can be tweaked later, and if this series lands and someone isn't 100%
happy with the semantics they're no worse off than they are now.

I.e. we could get something like this in its current form, and later have:

    core.hooksOrder = glob | random
    core.hooksHaltOnError = true | never

Where we'd say that what this series does is core.hooksOrder=glob and
core.hooksHaltOnError=true, but that e.g. parallel "run them all" could
be done in the future with core.hooksOrder=random &
core.hooksHaltOnError=never
