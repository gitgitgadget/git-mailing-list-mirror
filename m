Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D13C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 17:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiKVRSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 12:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiKVRSV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 12:18:21 -0500
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A289E6E576
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:18:20 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id z26so14981972pff.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWNx/ogPAiPCQqAzL1eQ556c7aNhT9uVUtdjqX3LX9E=;
        b=F8tutjZl0HlIBtcSDLdMd/XzDePD7kXELrXjnk5of1+rBEdtxPSk7hG32K5Io1BUvx
         vQ9sRTnUUXs3le8nYe5zIucfoSyYZk+x3Weo55UEs1wC+qVNh6TsUxq7iNIXBBF/KQQL
         C1R7u08qGpj23z+D44u5t+DJujvXtX4o3FjBHsUX22lWL+AKX2gwQGQnQm6UGlJYhMjG
         9o0yqkF+1zRGDjlB6UuzuFIhTR+OJbV3dVe3PE8NmxVK2dmxEcT/GvjuRmcUEE3yhHhD
         LJuhgLYno+ZMV5voJsd23CCeaV7AMYkzRNcocPi27NEOXjbzqqj3NrjE++dP4c6xa+ki
         HDEw==
X-Gm-Message-State: ANoB5pkrWahx28KRUqGKH5XFu9ixLzmUoR/nLjoLqY3GRL2mo7F8vcDN
        2O53tgF0ykHssS0wceF7Q+sBYDdWRnk85BIrxwQ=
X-Google-Smtp-Source: AA0mqf4GXw8YufvTQxYjohr3uUhMfbGPbPnCW0TOVVrJLgQ4y2mwqynBlGeRZ21eNqHhv4ithG38PszljaSPjRDY3FE=
X-Received: by 2002:a63:f048:0:b0:477:5e23:f9d1 with SMTP id
 s8-20020a63f048000000b004775e23f9d1mr4032940pgj.268.1669137500034; Tue, 22
 Nov 2022 09:18:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
 <pull.1384.v6.git.1668547188070.gitgitgadget@gmail.com> <CAPig+cRPQ7bmG6+U+oQGGUFiSiHoMMpMk8FDJ7GMJvwCXifa9g@mail.gmail.com>
 <CANaDLWJM1VRivm8VLqxg+w8K-+49E0km6AgOzWzN9X=TgzaEiA@mail.gmail.com>
 <CAPig+cQgu=i6pZTzoNYGZ_6X=DGdmwa=dPhSQVqD+eLCZCGJSg@mail.gmail.com> <CANaDLWJ+Suye98QKub9nfnknLEsyQ4PK1LxDkPmzGC_-hApkFw@mail.gmail.com>
In-Reply-To: <CANaDLWJ+Suye98QKub9nfnknLEsyQ4PK1LxDkPmzGC_-hApkFw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Nov 2022 12:18:07 -0500
Message-ID: <CAPig+cTrpnVOW0Y2m5xtPhLudY=rPCn3qPQA0RSso7ueFytZbQ@mail.gmail.com>
Subject: Re: [PATCH v6] status: long status advice adapted to recent capabilities
To:     Rudy Rigot <rudy.rigot@gmail.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 11:52 AM Rudy Rigot <rudy.rigot@gmail.com> wrote:
> > you might write the commit message like this
>
> The current phrasing was initially copied as is from a past review
> feedback; I have no issues at all replacing it with yours.

Apparently, I overlooked that when scanning backward through the thread.

> > So, if there is an existing test script in which
> > these new tests might fit, it's better to add them to that script
> > instead
>
> Oh, sorry about that, it hadn't occurred to me that there could be a
> downside to using new test script numbers.

No need to apologize. Reviewers understand that there is a lot to
absorb and figure out.

> I'm 100% on board with the thinking, but I'm struggling quite a bit to
> implement it. There are several existing test scripts where these new
> tests would fit very well semantically (t7060-wtstatus.sh,c,
> t7512-status-help.sh, t7519-status-fsmonitor.sh, ...), and I spent
> quite some time yesterday trying to move the 3 news tests to those.
> For some reason, test_cmp is not giving me a diff anymore when working
> in those script files, so I feel in the dark about what the tests are
> failing about, and I'm stumped about what to try next.
>
> Here is a gist https://gist.github.com/rudyrigot/b31fcb6384e829ca7586818758e48d0b,
> with:
>
> - the patch as I currently have it on t7508-status.sh (it's a bit
> longer than it was, without the isolation in a separate script I've
> had to do a few things to mitigate the side effects from other tests
> in the script)

I probably should have thought to warn about possible interaction with
earlier tests when I made the suggestion to place the tests in an
existing script. Nevertheless, we should be able to sidestep all that
"isolation goop" you had to add to the tests... (more below).

> - the end of what I get when running 'sh ./t7508-status.sh -v':
> https://gist.github.com/rudyrigot/ee80f3d59231f25698c9dd6c48d8ab85. It
> seems like 2 of my 3 tests are failing, but the output isn't very
> helpful to figure out why.
>
> Would you (or someone else) have pointers to help me get through this one?

The second 'gist' URL seems broken, so I can't comment on the exact
output. Without having seen the actual problem, I can't really provide
direct feedback for fixing the precise issue, however...

We actually don't want you to pollute your new tests with goop to
clean up after earlier tests in the script since that just introduces
a bunch of code in your tests which is not directly relevant to what
your tests are checking. So, perhaps the cleanest way to approach this
is to have your "setup" test create a new repository in the trash
directory and then just run your remaining new tests in that
repository. That way, your tests don't have to deal with any gunk from
earlier tests. This basically means taking your tests pretty much as
you had them in v6, but with a little extra boilerplate. Something
like this:

    test_expect_success setup '
        git init slowstatus &&
        (
            cd slowstatus &&
            cat >.gitignore <<-\EOF &&
            /actual
            /expected
            /out
           EOF
           git add .gitignore &&
           git commit -m "Add .gitignore"
        )
    '

    test_expect_success 'when core.untrackedCache and fsmonitor are unset' '
        (
            cd slowstatus &&
            test_unconfig core.untrackedCache &&
            test_unconfig core.fsmonitor &&
            ...
        )
    '

and so on.

> I'm tempted to throw in the towel, since it sounded like it wasn't too
> huge a deal if this lived in its separate script file, and that other
> people's bandwidth (which I'm aware is what I'm requesting here) is an
> even more scarce resource.

My comment about possibly leaving them in a separate script if you
couldn't find a suitable existing script was just general advice. I
can't speak for Junio and thus can't say what he will or will not
accept in his tree.

> So I'll submit a new patch with everything
> else but this, so there's the option to still proceed with it if
> that's the most sensible path forward. But I have to admit I'm quite
> frustrated that I couldn't figure this last one out by myself, so I'm
> more than happy to dig more into it, if anyone has guidance.

Perhaps the suggestion I outlined above will help.
