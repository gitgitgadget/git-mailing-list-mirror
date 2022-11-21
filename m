Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0BBC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 16:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiKUQSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 11:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiKUQRw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 11:17:52 -0500
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6281707D
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 08:17:48 -0800 (PST)
Received: by mail-pj1-f44.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so11335224pjb.0
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 08:17:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KN34GVBR1IUd8BRCDhNxMRF0TvoRvF1hwr65TBqxEhs=;
        b=WoU0j07Fkusi0TxhiZc2UdwLE0/eE4U9GHwqD+NQMjDXXEZ8EDFvM/4jbZkYe75hkV
         Amo2n8FGn2dFkeedfucwsGIDQJgKb4qTt23kHlGd9XRjs+lEdr8XKMDx+w+izOgd96vQ
         3WVcUVFZvwlzUs/Vh47P83JYCeSMHiwpnc5aP7wvDSujCe5bCCh4NlOfQUFF7WIR73OY
         963RyXMiuFhrpvPvqLc0Mj24K/MInQC1kWKD+pQnJwbFfeM6rPK+0f6yzUOOK1mFDHBi
         LrLcVVYa/Ei6M9K0/Tei64URgAIt0FqUocb+lGG/K6miK4fPtlL7V0GQZ2eT5abaoI6v
         Nk0Q==
X-Gm-Message-State: ANoB5pnszpddS9QKOQBPVzkrf0XV2amE5cXzvcRMhJl1n3DhPPx0PF9w
        7A34U1XIA3MmU33FuT706T+A8+aWwx8iLOcyWUGuvIH+1Us=
X-Google-Smtp-Source: AA0mqf78znudyrg3cBGG6dfaH/q3UGreevBz/82GzQBiZiRCkzt7uIFO9TKkqfdN//5HbxoY+I5WnF9qEIUCJsL2U3I=
X-Received: by 2002:a17:902:aa07:b0:188:eee6:e1a6 with SMTP id
 be7-20020a170902aa0700b00188eee6e1a6mr404295plb.120.1669047468128; Mon, 21
 Nov 2022 08:17:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
 <pull.1384.v6.git.1668547188070.gitgitgadget@gmail.com> <CAPig+cRPQ7bmG6+U+oQGGUFiSiHoMMpMk8FDJ7GMJvwCXifa9g@mail.gmail.com>
 <CANaDLWJM1VRivm8VLqxg+w8K-+49E0km6AgOzWzN9X=TgzaEiA@mail.gmail.com>
In-Reply-To: <CANaDLWJM1VRivm8VLqxg+w8K-+49E0km6AgOzWzN9X=TgzaEiA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Nov 2022 11:17:36 -0500
Message-ID: <CAPig+cQgu=i6pZTzoNYGZ_6X=DGdmwa=dPhSQVqD+eLCZCGJSg@mail.gmail.com>
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

On Mon, Nov 21, 2022 at 10:55 AM Rudy Rigot <rudy.rigot@gmail.com> wrote:
> > That said, this is minor, and I'm not keen on eating up more of your
> > time or reviewer time, so I doubt this is worth a reroll.
>
> Eh, there's nothing wrong with striving for perfection. Lemme do one
> more reroll...

Reviewer time is a scarce resource on the mailing list these days,
which is why I'm hesitant to see rerolls for minor or subjective
changes. However, if you're going to reroll anyhow, I have a couple
more things to say... (below)

> > So, it's not apparent
> > why you need to create a specially-named branch here rather than
> > simply accepting the default branch name.
>
> The reason was that it failed some CI pipelines before I did this,
> with some pipelines printing "main" instead of "master" into the git
> status output. I fixed it right away, so I don't know if it was a CI
> glitch that day or if it would still be the same running it now. I
> could have redacted the branch name away from the output, but it
> seemed simpler and more readable to just set the branch name in stone
> for all pipelines.

Most likely it wasn't a glitch, but rather (I'd guess) that Windows CI
uses "main" already, whereas Unix CI's still use "master".

> > an alternative would have been to override the default branch name at the
> > top of the script:
>
> Oh, this seems like a better way to do what I was trying to do. I'll
> change it now.
>
> > we have a test_unconfig() function
>
> I'll use that.
>
> New patch coming!

If you're going to reroll, then I'll mention a couple more things
which I held back before since I want to use reviewer time wisely.
Nevertheless...

First, having the commit message explain the problem first and then
the solution is more reviewer-friendly, not the solution and then the
problem as this patch is doing. Additionally, the commit message
should be written in imperative mood. Documentation/SubmittingPatches
has a good discussion of these points. It's also typically unnecessary
for the commit message to say that the patch is adding new tests;
reviewers assume that you will do so when appropriate, and the patch
itself shows plainly enough that you did. Taking these points into
consideration, you might write the commit message like this:

    status: modernize git-status "slow untracked files" advice

    `git status` can be slow when there are a large number of
    untracked files and directories since Git must search the entire
    worktree to enumerate them.  When it is too slow, Git prints
    advice with the elapsed search time and a suggestion to disable
    the search using the `-uno` option.  This suggestion also carries
    a warning that might scare off some users.

    However, these days, `-uno` isn't the only option.  Git can reduce
    the size and time of the untracked file search when the
    `core.untrackedCache` and `core.fsmonitor` features are enabled by
    caching results from previous `git status` invocations.

    Therefore, update the `git status` man page to explain the various
    configuration options, and update the advice to provide more
    detail about the current configuration and to refer to the updated
    documentation.

Second, we usually don't want to waste a test script number (such as
"t7065") if we can avoid it, especially for so few tests and such
minor functionality. So, if there is an existing test script in which
these new tests might fit, it's better to add them to that script
instead, usually at the end of the script. (I haven't checked, but
maybe you can find an existing script which would be a good fit; if
not, then placing them in a new standalone script, as the patch is
already doing, may be okay.)
