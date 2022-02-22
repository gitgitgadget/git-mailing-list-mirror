Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E5BC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 18:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiBVSQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiBVSQy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 13:16:54 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627CB172E5E
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:16:28 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cm8so29373937edb.3
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwvm5Wdin5TapaIKZucF2SgLl19g6iSUNuLxrTiWTrM=;
        b=UxdBcHPZT6WS8fd9sQjdwT13GhG7qas4xkDro3wwYzEztGquYHOYb0zdqr/POQyPRa
         esyuDu58570KSWrr322s+MupYrlCxO5x5KQoXuqtZrY50sANQ2GD3Toykb0g+/6qqWiN
         /Cg8Et7YeN7YTP+vBrk4FkSusJJksOKwbI6eeI6+yTlqRUj8IBKP9d7WlTWuIBlo8g+X
         T061Pu40wnAe3V5kuMTHzYSnwzYIVssV4IIGzu7O7U2r5C/WNY0ByU2nBpz9eqEBe0DE
         tc1iu5LJOhl1mFuGSsz0T5UU5Vp/yX018wk45YUPDHmNGvxFmszH6GtGoIBnR7iQH3O7
         vTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwvm5Wdin5TapaIKZucF2SgLl19g6iSUNuLxrTiWTrM=;
        b=1ZVA4ZyLgzPcYr5M2vb7tTfiZjB3R8Io++drA5oasG/vluBol1YC+ndnc+WXIv8ZRE
         EnJf0YnVd5keWF8/jp+tF/2AODGJ0WrL2L6tU5BhF4nkW8Ahoo16uwwWf3hGlK0PYXfn
         5LIcPq9vnoxCe3GoPekyNjovW2zwQXRmicc/XAcAkc19f70lcEBDsqeG0DXbsyRlE1PS
         1ird5ERl8PlGC5B2WP4UvBZJLPrTR1KTYM+JBQBKTaYJJnrf5tphNBlT20Qq0YR2CJy4
         erjPQW7JQGo2QkJ9jCoAMpvE0nVn6Gya6qiqkkjSkp/J+Gt/mS5m3cDjVs12sSa70A0j
         yW9w==
X-Gm-Message-State: AOAM532kjHikVwpYfQSAp7qFPRA0mQTVRZTdYTd5YWM0G8mbCaEgyIWQ
        Q1fGyfixk+IyhE3DUe91VtCLH2BNS2AEy80Zug1JF17fAhovFYkK
X-Google-Smtp-Source: ABdhPJzls66MIuUCxxVgqv3rLI9pQDQqNPigr+YpHrJTuXrjPDOFP0Z9x/Sig88g3WMy8jw4ptHkZqLA5Aboe5oZ+c8=
X-Received: by 2002:a05:6402:1341:b0:407:cece:49f8 with SMTP id
 y1-20020a056402134100b00407cece49f8mr27045068edw.152.1645553786819; Tue, 22
 Feb 2022 10:16:26 -0800 (PST)
MIME-Version: 1.0
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <20220222114313.14921-2-shivam828787@gmail.com> <9d08d2a6-82ed-7d6c-6a82-0e89c55bd94a@github.com>
In-Reply-To: <9d08d2a6-82ed-7d6c-6a82-0e89c55bd94a@github.com>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Tue, 22 Feb 2022 23:46:14 +0530
Message-ID: <CAC316V5CcB_UxpVYdAYZDPpY_ebauu4K23TrU1zLnTdgXg0PNQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] t0001: remove pipes
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > pipes doesn't care about error codes and ignore them thus we should not use them in tests.
> > As an easy alternative, I am using a tmp file to write from git command so we can test the exit code.
>
> Please be careful about the length of your lines in your
> commit message. vim should auto-wrap as you write.

Oops, I mostly use Nano, I think it's time to use vim. I will take care of it.

> There are also some grammar issues, so here is an update
> to what you wrote:
>
>   Pipes ignore error codes and thus we should not use them
>   in tests. As an alternative, use a 'tmp' file to write the
>   Git output so we can test the exit code.

Thanks for pointing this out. I will update it. I am a non-native
English speaker, and looking to improve my command in language with
time :)

> Split each part of the &&-chain across lines, like this:
>
> +               find .git/worktrees -print >tmp &&
> +               sort tmp >expected &&
>
> >               git -C ../linked-worktree init &&
> >               test_cmp expected-exclude .git/info/exclude &&
> >               test_cmp expected-config .git/config &&
> > -             find .git/worktrees -print | sort >actual &&
> > +             find .git/worktrees -print >tmp && sort tmp >actual &&
>
> Here, too.
>
> I could make the same comments on patch 2, but I think you
> have enough info to go on.

Sure, I get it! I will consider all these suggestions in v2.

Thanks,
Shubham
