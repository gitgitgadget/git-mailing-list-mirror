Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FB5F1F461
	for <e@80x24.org>; Tue, 14 May 2019 02:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfENC05 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 22:26:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40827 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfENC05 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 22:26:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so7756869pgl.7
        for <git@vger.kernel.org>; Mon, 13 May 2019 19:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wJZfRFVGZvA9ggGeSmjv7oCjt3pWpciGLGQlAUVhjOw=;
        b=D8ZmHCUAAp3GN2fU+a0b0ADP/5RG08E/mLW2gqF4uvSEygJCqYFTUZDU5cLNMVR+KH
         aTIMtzcqzAM49aMSeD9zM7H2hyPEbn/+ks1VDTwPtDO1gRYF2ep9auyGEIO0UQv+LtKE
         EzSvRVRVTN5/EOYOR6q2wzRWR5QAKF7eWkiXxU1L1Sa6L5EHOf8Ey1bw1LiIveXT3ueq
         eIXMoZIHLJbODMJJMazCkA+BVokjI9QfuTXQWWD+G3epFx+FD3Ugdg4tYkVH3afzhPPS
         Uv34ZvZ73V+gxaVYPhB8yr9t/XVpUrS8RX7Xs8DAInnDecn67bOMCCzQU/wfCfDLzUYI
         8gCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wJZfRFVGZvA9ggGeSmjv7oCjt3pWpciGLGQlAUVhjOw=;
        b=a8B64bNRjNYt2BjsQ9XzFO2Q/1N7yihlZk9eVCgmL1dWh6q1SWkXuyRjHoJ2UPhdiY
         /Z+UXK/jcMEpyDoZV06KT7MbcVW4/oWc7alYuJBCg8MVLQvJh4in7UXe5GPflf5X6m9g
         ytUxmBbgmLF6v5YvXY8szvn9MpL+letzJufYIkkOrDom3BkmVlWYcMSUSkMhewnA/iqB
         nyWmfvp0UekXiEPlJ8ENHMAOAkwvB4v7duPPIL2ZCIc5X4G6zGgpwWryjIMLLboii6tK
         878f+vVQ5Ih5yqMnUGwpd3fFSwFhz+lgxBVilY4Y2Bjh/HveuQP+tU/8IRB8xU4djMYJ
         6I9A==
X-Gm-Message-State: APjAAAXuScVfKd89AYqQjPt4jFWcuuCnYYYNx6VjlgeXH0/ck7rKGrmQ
        kQ2xQezZXcFdRaOqodGDXAyuc2Dz
X-Google-Smtp-Source: APXvYqwdnOfkKZAsSAQjc6O+yU9VSGC0jxuuJA42RE9zxUecS2hp/7rrksN9vrL6QjugxFhtxga8yQ==
X-Received: by 2002:a62:2805:: with SMTP id o5mr37820189pfo.256.1557800816279;
        Mon, 13 May 2019 19:26:56 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id 79sm14185778pfz.144.2019.05.13.19.26.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 19:26:55 -0700 (PDT)
Date:   Mon, 13 May 2019 19:26:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/7] Multiple hook support
Message-ID: <20190514022653.GA34155@google.com>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514004920.GB136746@google.com>
 <20190514015928.GG7458@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514015928.GG7458@genre.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:
> On Mon, May 13, 2019 at 05:51:01PM -0700, Jonathan Nieder wrote:
>> brian m. carlson wrote:

>>>                          the fact that inheritance in the configuration
>>> is in-order and can't be easily modified means that it's not likely to
>>> be very useful, but it is likely to be quite surprising for the average
>>> user.
>>
>> Can we discuss this some more?  What would it take to make it likely
>> to be useful in your view?
>
> There are two aspects here which I think are worth discussing. Let's
> discuss the inheritance issue first.
>
> Order with multiple hooks matters. The best hook as an example for this
> is prepare-commit-msg. If I have a hook which I want to run on every
> repository, such as a hook that inserts some sort of ID (bug tracker,
> Gerrit, etc.), that hook, due to inheritance, *has* to be first, before
> any other prepare-commit-msg hooks. If I want a hook that runs before
> it, perhaps because a particular repository needs a different
> configuration, I have to wipe the list and insert both hooks. I'm now
> maintaining two separate locations for the command lines instead of just
> inserting a symlink to the global hook and dropping a new hook before
> it.
>
> I don't think there's a good way to make it easier unless we radically
> customize the way configuration is done.

Wouldn't a separate config item e.g. to reverse order (or to perform
whatever other customization seems appropriate) cover this?

In other words, use the standard config convention for the set of
hooks, and treat the order in which they are invoked as a separate
question.  You could even use the hooks.d style alphabetical order
convention.

[...]
> The second issue here is that it's surprising. Users don't know how to
> reset a configuration option because we don't have a consistent way to
> do that.

I agree that it's underdocumented and underimplemented.  But I'm not
aware of any other method that Git provides to reset a configuration
item.  What is it inconsistent with?

>           Users will not expect for there to be multiple ways to set
> hooks. Users will also not expect that their hooks in their
> configuration aren't run if there are hooks in .git/hooks. Tooling that
> has so far used .git/hooks will compete with users' global configuration
> options, which I guarantee you will be a surprise for users using older
> versions of tools.

Indeed, in the long term I think we should remove the .git/hooks/
mechanism entirely.

In the shorter term, I think the kind of inconsistency you're referring
to applies to hooks.d as well.

> The new behavior, which puts everything in the same directory
> (.git/hooks) is much easier to reason about.

That's a good point: a .git/hooks/README sounds like it would be
helpful here.

[...]
> It also provides a convenient place for hooks to live, which a
> config-based option doesn't. We'll need to invoke things using /bin/sh,
> so will they all have to live in PATH? What about one-offs that don't
> really belong in PATH?

This hasn't been a problem for remote helpers, merge drivers, etc in
the past.  Why are hooks different?

To be clear, I think it's a reasonable problem to solve, and I've
actually been surprised that it hasn't been a problem for people.

[...]
> I agree this is an advantage if they don't hit the ordering issue.

Wonderful.  Sounds like if I do some work on the ordering issue, then
we have a path forward.

>                                                                    I
> think a lot of the common use cases where this approach has benefits can
> be handled well with core.hooksPath and hooks that can turn themselves
> on or off depending on the repository config.

I think core.hooksPath attempted to solve this problem, but it has
several deficiencies:

1. It assumes a single, centrally managed hooks directory, and there's
   no standard for where that directory lives.  This means that it
   can't be counted on by tools like "git secrets" --- instead, each
   particular installation has to set up a custom hooks directory for
   themselves.

2. Since it assumes a single, centrally managed hooks directory,
   customizations in a single repository (e.g. to enable or disable a
   single hook) require duplicating the entire directory.

3. It had no migration path defined to becoming the default, so it
   doesn't end up being discoverable.  core.hooksPath is designed as
   a special case, making it hard to debug, instead of being a
   mainstream setting that can be recommended as a future default.

> What might be an interesting approach that would address these concerns
> is a core.globalHooks[0] option that points to a set (or sets,
> depending) of multiple-hook directories. We then enumerate hooks in sort
> order, considering both the global and the local directories as one
> unit, perhaps with some way of disabling hooks. I'm not planning on
> working on this myself, but I wouldn't be opposed to seeing someone else
> work on it.

This sounds overflexible to me.  Because of that, I don't think it
would end up as a default, so we wouldn't have a path to improving our
security stature.

If I implement a config based multiple hooks feature with name based
ordering, would that be useful to you?

Thanks,
Jonathan

> [0] Better name suggestions are, of course, welcome.
