Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834AEC4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 22:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJRWMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 18:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJRWMn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 18:12:43 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E0FA98DE
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 15:12:42 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id y72so760145yby.13
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 15:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+d5xjzjr7ubZwdYawDddHYFDepRyTHNnOMsIqdvyCvM=;
        b=OOXWro74ps6qVmTH67kEhDo7m1PQWhtAXsg8f/77LRok7tC5dpdkshO8OJI3DSvrPj
         q1inAAwW2FDOL3uB54Dn7KQTl7JcXdflpCnF0u4/8oZysDTBwP0SHUwuka9eBRSxLa4b
         /iWQb28pQ3O3CNiD1px5D6T/ymQ9sT9NaMOPUW69yCXs+tII6omxb5Qk9hjLXqN3U6bt
         4OyXqZCse1CJnVZJrmA9Rrd+LfwNga7tiiCuZp98JV8dT4g5D17RrJ0pjgEwu2JOzEwv
         DnZ9fxoyRaIwjtl2BwqqxPUSZ9nyHnt0hv+KmgpsmzpGdJ9eThTeI13EDRvPxIwETWRZ
         tR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+d5xjzjr7ubZwdYawDddHYFDepRyTHNnOMsIqdvyCvM=;
        b=XY3MX/tLU/2d9nOfwiqRBFcwDzvtzlDn/Pl5nqcXYauZOGjYYaZwTc0rEqOBNqAufd
         JVvHGKzGDCZ0t0lrxLoF5jYXaJwXZSRmucXwcFRBJy/QyLzUjnnTSvtvhLLe6GFqsmxr
         Q+ZrvQs/e1X+h/mGnrK6UVOYxVpcYc5T4ZcmQGcJ2ki6w5ts5C06axDPeYEivZTulFld
         UijG1uZc9esqThzjblGbCXw/PJv/t64m1JVcKBhn9VCGtpgy2/zeGkyZ+VEYIbaGXAEn
         s+odtvnMuS2Txy+sGqOPadlOsHS4TyQygrXH6r+Y/6L8IyTIEWPtfAoHUGekw4yg1BfG
         xePg==
X-Gm-Message-State: ACrzQf2199rVltKhmSNWgHO5tVW8BQonw42q3/Yx7SzqWZfhySlMXO/M
        uYPgBlXQIKKEhjlMx6Yti7XiH1lT+Bo4FkveDE4dhGeYdL8=
X-Google-Smtp-Source: AMsMyM7dbY8hXe30QJgA6XxZhR2ta96AJ74MTAmJ8kvwZA4nATZkMEVqZwCg39M1qcfo9/jiFXdX7qLsdHTWL4U7AMw=
X-Received: by 2002:a25:8411:0:b0:6a2:d934:f0c3 with SMTP id
 u17-20020a258411000000b006a2d934f0c3mr4434177ybk.397.1666131161813; Tue, 18
 Oct 2022 15:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
 <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com> <bbaa2425ad0cbb4b945cdce3402c6ed5fab381ec.1665737804.git.gitgitgadget@gmail.com>
 <xmqqbkqe6qv4.fsf@gitster.g> <xmqq7d0y1mw7.fsf@gitster.g>
In-Reply-To: <xmqq7d0y1mw7.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Tue, 18 Oct 2022 15:12:30 -0700
Message-ID: <CAMKO5CuEaFwe5WgAC=whz1ouXs1PiD6GW5Qay82w4723EHsEfQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] builtin: patch-id: add --include-whitespace as a
 command mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jerry Zhang via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2022 at 8:38 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> +--include-whitespace::
> >> +    Use the "stable" algorithm described below and also don't strip whitespace
> >> +    from lines when calculating the patch-id.
> >> +
> >> +    This is the default if patchid.includeWhitespace is true and implies
> >> +    patchid.stable.
> >
> > This seems very much orthogonal to "--stable/--unstable.
> >
> > Because the "--stable" variant is more expensive than "--unstable",
>
> Sorry, I misspoke.  The way we make the result stable is *not* by
> enforcing a fixed order to the input of the hash (which would have
> been more expensive), but by hashing each file separately and
> summing up the hashes, and it shouldn't be noticeably more expensive
> than the unstable variant.
>
> So, I do not think I mind if we introduced --include-whitespace as a
> third option in addition to --stable and --unstable, instead of allowing
> it to be combined with both --stable and --unstable.
>
> But I wonder:
>
>  * (minor) Would "--verbatim" work as a better option name?  The
>    name "--include-whitespace" can apply even to an implementation
>    that squashes multiple consecutive spaces and tabs into a single
>    space, i.e. we keep words on a single line as separate words,
>    instead of squishing them together, when hashing.
>
>  * Do users even care about the internal reliance on the "stable"
>    algorithm?  Wouldn't it be better to leave such an implementation
>    detail unsaid?  After all, "--verbatim --unstable" would not work
>    as they expect.
>
> So I would suggest dropping "and implies patchid.stable" from the
> above description.
Sure I can spin a new series with these changes
>
>
