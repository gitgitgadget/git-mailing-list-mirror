Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F211211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 11:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfALLb0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Jan 2019 06:31:26 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40917 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfALLb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jan 2019 06:31:26 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so15083310edr.7
        for <git@vger.kernel.org>; Sat, 12 Jan 2019 03:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=gsiJWSxD0LD4tO5T3fdfLdKR+KFNNUMvWdCGmqZtdKc=;
        b=Qi2wsc/esNxTZG+p7LyBmcHDayQUajPKfMNCpLB7GrFQfqC7QDaxaJ3zUyf0Fm6nwf
         Tt9Ijt49HGzZGm081QEfZEbw2agKyNhN4AHMdGJG+P8cgRsVw8nWJPq2BIvaJpoymY/x
         hpAITkm/hxGH1i8IjlIwNyLu43J3F+9+eLnNcidjsfQ8Bl5YpZaxtL0nqNjbSed70cGs
         em6NPfQS/dWCVFPwH0cQOd9mBQW2BrWGLyJR5zyhUQG7lHK5DQ+VeKUVMb8vCcV7++eH
         uaTH+BOcdTurD5eenJxntBKBJJnkpiy3hb5WlQiQ8nebGsmd6uzjW4nbkI2yLZfHj+j0
         VmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=gsiJWSxD0LD4tO5T3fdfLdKR+KFNNUMvWdCGmqZtdKc=;
        b=QOHrs6/YbsMmYEGYHC2fVcnaCd/tJjqFT6cIG8Bn6zBGPITJOoCd24FZfCnnUX3e7l
         Ji76Rvb5e5Ft3b1mVS86mbicc/1mWdSLZ60Y6qeKp36fNVsC9/hNY/3UQyTXZVRurYIf
         L1yoVJvdwW+eeT3BLz8jDECHuYoajpfaiC1btqR25CC1BZBBuaufMJ0UfzHgoHdL1woo
         sewANmZmGOKGQKX0Lva38V8DF2RzzID0FFDlWw58bhx7ucQL6B6XArlHihb0bsBUrMtk
         HeBSQts0JSZb3PvLvhr7txDPUeCu+xlDTaHPr2uJ/i8Nhcl9dBTspZGgzx8I1WeXMKQN
         WyFA==
X-Gm-Message-State: AJcUukfYRA3/E+XXkJkCmDEb70FVOaI4+9AW5dNGF5eciyspEWHl1uKF
        QZ2PObH0qFpI9F/iA2fKABc=
X-Google-Smtp-Source: ALg8bN7Jb8ok6CCOyeR/PQH8qq4ZdONr/aLtfMA1E2YKw9JKSmEchVeW24GmthVNjnfw9vtWqCFILQ==
X-Received: by 2002:aa7:d602:: with SMTP id c2mr16206074edr.203.1547292683289;
        Sat, 12 Jan 2019 03:31:23 -0800 (PST)
Received: from evledraar (i40217.upc-i.chello.nl. [62.195.40.217])
        by smtp.gmail.com with ESMTPSA id d5sm2909381edb.48.2019.01.12.03.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Jan 2019 03:31:22 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] getenv() timing fixes
References: <20190111221414.GA31335@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190111221414.GA31335@sigill.intra.peff.net>
Date:   Sat, 12 Jan 2019 12:31:21 +0100
Message-ID: <87va2u3yeu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 11 2019, Jeff King wrote:

> Similar to the recent:
>
>   https://public-inbox.org/git/20190109221007.21624-1-kgybels@infogroep.be/
>
> there are some other places where we do not follow the POSIX rule that
> getenv()'s return value may be invalidated by other calls to getenv() or
> setenv().
>
> For the most part we haven't noticed because:
>
>   - on many platforms, you can call getenv() as many times as you want.
>     This changed recently in our mingw_getenv() helper, which is why
>     people are noticing now.
>
>   - calling setenv() in between _often_ works, but it depends on whether
>     libc feels like it needs to reallocate memory. Which is itself
>     platform specific, and even on a single platform may depend on
>     things like how many environment variables you have set.
>
> The first patch here is a problem somebody actually found in the wild.
> That led me to start looking through the results of:
>
>   git grep '= getenv('
>
> There are a ton of hits. I poked at the first 20 or so. A lot of them
> are fine, as they do something like this:
>
>   rla = getenv("GIT_REFLOG_ACTION");
>   strbuf_addstr("blah blah %s", rla);
>
> That's not _strictly_ correct, because strbuf_addstr() may actually look
> at the environment. But it works for our mingw_getenv() case, because
> there we use a rotating series of buffers. So as long as it doesn't look at
> 30 environment variables, we're fine. And many calls fall into that
> bucket (a more complicated one is get_ssh_command(), which runs a fair
> bit of code while holding the pointer, but ultimately probably has a
> small fixed number of opportunities to call getenv(). What is more
> worrisome is code that holds a pointer across an arbitrary number of
> calls (like once per diff'd file, or once per submodule, etc).
>
> Of course it's possible for some platform libc to use a single buffer.
> But in that case, I'd argue that the path of least resistance is
> wrapping getenv, like I described in:
>
>   https://public-inbox.org/git/20181025062037.GC11460@sigill.intra.peff.net/
>
> So anyway. Here are a handful of what seem like pretty low-hanging
> fruit. Beyond the first one, I'm not sure if they're triggerable, but
> they're easy to fix. There are 100+ grep matches that I _didn't_ audit,
> so this is by no means a complete fix. I was mostly trying to get a
> sense of how painful these fixes would be.

I wonder, and not as "you should do this" feedback on this series, just
on future development, whether we shouldn't just make our own getenv()
wrapper for the majority of the GIT_* variables. The semantics would be
fetch value X, and if it's ever requested again return the value we
found the first time.

For some things we rely on getenv(X) -> setenv(X) -> getenv(X) returning
different values of X, e.g. in passing along config, but for
e.g. GIT_TEST_* variables we just want to check them once, and have our
own ad-hoc caches (via static variables) in a couple of places.

Maybe such an API would just loop over "environ" on startup, looking for
any GIT_* variables, i.e. called from the setup.c code.
