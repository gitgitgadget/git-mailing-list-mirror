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
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B091F453
	for <e@80x24.org>; Wed, 24 Apr 2019 07:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfDXHnv (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 03:43:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53982 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDXHnv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 03:43:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so3237498wmj.3
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 00:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=GD7GlVHmqV5JtLRyU5RKPoVRh2EZZHNJNI3ZL5jJ6pE=;
        b=bC3/CqIggTf23NIio8u/yuCWr162sdcLxXqRQicU4P50kOduFMpseq/VqlpJUQaz/B
         5hsyQFq8JrDvX8KfhXoim86l3Bdwd9RLGINjqNm/qitWP+9Yv/WTIICEH3chAHGfIXEj
         LX1vN9yYfeebwf3OSSPFiJpi32dGj/HqqiUILpy7DQT9e+dRiS0+ACLqzJQukZhHAD8O
         z2ecUnToPlutEGQ6hOsoMxQVFsXpb/d972udXyLnGtwrJhx8nr1FhiypAQo9kOoBrjcr
         JmfljCnR3XsfKTPjsw5gV3VD1MUbtEQ6vXdexFlXhGb9aNESmvyYPFKGk5Uo9oFspLn0
         vqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=GD7GlVHmqV5JtLRyU5RKPoVRh2EZZHNJNI3ZL5jJ6pE=;
        b=jHXRzQr5CNf+CPT+OFmCCX7fajduJoVyaF9UwiT3YhSJLaS+3/QkQ6p0e2blF/jtQB
         Z/quTosZzxxb5LYUy/+b9088+3g8Hy1j6HgxpbBwTNtRGVE++s5xOmDR6Fro9F4T2jAx
         G7cI4IblE7Zi5+bM7dx0eDenP2NUfg9rA4EtBQya1aqPAWKchJRuWApb+dy4BuJYR2L9
         N8fMRxO+I2e8FEunIP4h5+9DJ6JAASHXU7a4/ANVkYidrAfS9+8Sq0Lq+whFMQnTYBiq
         gBRBuFtEBLaaViRBbQtytm9eglfp0Sc9sti3uIznyJQEcSkpmTTggrYsIJmiircDApie
         bCjg==
X-Gm-Message-State: APjAAAWUYBjIS3XUeqmNkWcMUIEbd397ZCs5WtRkSu9xvv0tcIfPutMA
        IJm1H1bvEigFIGdWlZbJwic=
X-Google-Smtp-Source: APXvYqxuW0v2+puit/h+RK3twPPdhQtWB2tx5FM8JKv0d2bJaLT/VbIZYQyWILwbhFf3udyGF0QuNw==
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr5108079wmg.132.1556091828752;
        Wed, 24 Apr 2019 00:43:48 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id r9sm16963153wmh.38.2019.04.24.00.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 00:43:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Multiple hook support
References: <20190424004948.728326-1-sandals@crustytoothpaste.net> <20190424023438.GE98980@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190424023438.GE98980@google.com>
Date:   Wed, 24 Apr 2019 09:43:46 +0200
Message-ID: <87wojjsv9p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 24 2019, Jonathan Nieder wrote:

> brian m. carlson wrote:

brian: I'm very interested in this. I barked up this tree before almost
exactly 3 years ago:

    https://public-inbox.org/git/CACBZZX6j6q2DUN_Z-Pnent1u714dVNPFBrL_PiEQyLmCzLUVxg@mail.gmail.com/
    https://public-inbox.org/git/1461367997-28745-1-git-send-email-avarab@gmail.com/

If you haven't seen those threads you might find them interesting. In
particular there's a previous discussion about the "exit on first fail"
v.s. "run them all" semantics. I'll elaborate elsewhere in this thread.

The only bit that landed from that was 867ad08a26 ("hooks: allow
customizing where the hook directory is", 2016-05-04), which, in reply
to JN below...:

>> I've talked with some people about this approach, and they've indicated
>> they would prefer a configuration-based approach.
>
> I would, too, mostly because that reduces the problem of securing
> hooks to securing configuration.  See
> https://public-inbox.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/
> for more on this subject.
>
> More precisely, a few problems with the current hooks system:
>
>  1. There's not a standard way to have multiple hooks for a single event.
>     That's what this series is about.
>
>     (The recommended workaround has been to use a trampoline script as
>     your hook, and to make that trampoline script implement whatever
>     policy for the order of invocation and accumulation of results is
>     appropriate, but that's a bit of a cop-out.)
>
>  2. Because they are stored in the Git repository, they do not have a
>     way to be automatically updated.
>
>     (The recommended workaround is to use a trampoline script as your
>     hook and put the actual hook somewhere standard like $PATH where
>     it can be upgraded system-wide.  But that's a bit of a cop-out.)

You can accomplish this with core.hooksPath, and presumably a
combination of core.hooksPath and brian's patches here. That was my
two-step plan in 2016, but I obviously never got to step #2.

So in /etc/gitconfig on your server you set core.hooksPath=/etc/githooks
and then your pre-receive hook will be /etc/githooks/pre-receive, or
/etc/githooks/pre-receive.d/*.

>  3. Because they are part of the Git repository, it is very easy to
>     compromise a user's account by tricking them into running an
>     attacker-authored hook.  Attacks include "hey admin, can you tell
>     me why 'git commit' is failing in this repo?" and "here's a zip file
>     containing a Git repository with our fancy software.  Feel free
>     to look around, run 'git pull', etc".
>
>     Similar attacks, probably even worse, apply to shell prompt scripts
>     using commands from attacker-controlled .git/config.
>
>     (The recommended workaround is to inspect .git/config and
>     .git/hooks whenever you're looking at an untrusted repository, and
>     to write your shell prompt script defensively.)
>
> Solving (1) without (2) feels like a bit of a missed opportunity to
> me.  Ideally, what I would like is
>
>    i. A central registry of trustworthy Git hooks that can be upgraded
>       using the system package manager to address (2).  Perhaps just
>       git-hook-* commands on the $PATH.
>
>   ii. Instead of putting hooks in .git/hooks, put a list of hooks to
>       run for each event in .git/config.
>
>  iii. For backward compatibility, perform a multi-stage migration.
>       In the stage I am most interested in:
>
>       When encountering a hook in .git/hooks, don't run it, but print
>       a message about how to migrate it to the modern scheme.
>
>       To make migration to the modern scheme painless, stick a
>       standard trampoline script in .git/hooks in all converted and
>       all newly "git init"ed repositories to allow old versions of Git
>       to respect the configuration from (i) and (ii).
>
> That doesn't handle core.pager et al, but those we can handle
> separately (for example by, at least optionally, not respecting values
> for them in per-repo config at all).
>
> Thanks for tackling this.  What do you think?
>
> Thanks,
> Jonathan
