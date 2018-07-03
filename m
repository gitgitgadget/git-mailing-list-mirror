Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF1B11F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 21:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753104AbeGCVFU (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 17:05:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53249 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752872AbeGCVFT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 17:05:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id b188-v6so3684893wme.3
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 14:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n0+7yXrh+X/ILDgWAwSYiFut7lZdUvIhr9vXhiCj0LM=;
        b=mVv9UfgiI5G56Q4w5H0o/JcKi2kSI4CBO9eO1TdVl3qJ7AN5xxbunhWgcVSAdXr5UX
         D6U6nJsXKwx1OBNlc4KBh0Y+LK5PMAbAPixmCTOF7PX57yQ+tkyDEyBSAWH/VuK5bdDa
         BRA7ftFbD6UHyGpuigu7f/ERw+/STAHrv2t1xCA424umrWeR4Wb4R+0WeRQPeT3f9zLW
         8XetwjXisOlIzT9CmwobmU4YIZYiQDLl0XULPuGPUgQZl4KRAVdvhbqoD6T+CBhTLqwH
         X1ArrU7t35F1N2EXxzq5goDklXwwPhUzl3hDxr2MxhDUObDdzW///XaJf4Dj/c7OZmXQ
         2p1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n0+7yXrh+X/ILDgWAwSYiFut7lZdUvIhr9vXhiCj0LM=;
        b=Jkh5lNFVVZJfAWQB6uDxaxoL4Y73yQSUD2OwXatKkDjtMY2upjwgfqda2pTci3b/50
         pnFHF/i7E6j3fC5pbgg/zPEnLzvj/gBIQJMWXGryhvzfqPBRSgQxpQLiNSOd9kPhTAvR
         8uSMA4Ag7DEEqLliHw+irxhiQLMiVt906WBJ4lii6QCMKmmS5SH4QzOa+nfuurdyXrxB
         vcfaxz7GcR7LhQ2HHNzoJI49Ejogit4HGBWMucAogqRZbAYo0qUrbJ/L3VRw/GOKEVfY
         pb9ltLhLA3bjIxoF0Kp8KbmwsbA/6X6kW4O2TFnJKwD6iYmvC0MUrENz3ofXN4iMPQ5Q
         vLvA==
X-Gm-Message-State: APt69E1AlPxsGCTSo1vqb0Vc82s/30dCrLPOSBag2ksk2N9qhimrB/ZF
        IwFPxUUHgYPPec7FOCLLvD5jSeaB
X-Google-Smtp-Source: AAOMgpcx2zxcZ8LDO6YKOE5ExskxVmS14PPFR/9KpPsdP8IYjt+/WqUnXNtYVeaNznlEFXc4Xv91JA==
X-Received: by 2002:a1c:1182:: with SMTP id 124-v6mr11451283wmr.75.1530651917852;
        Tue, 03 Jul 2018 14:05:17 -0700 (PDT)
Received: from localhost ([2.30.90.233])
        by smtp.gmail.com with ESMTPSA id o17-v6sm1487905wrp.62.2018.07.03.14.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 14:05:16 -0700 (PDT)
Date:   Tue, 3 Jul 2018 22:05:15 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/10] rerere: handle nested conflicts
Message-ID: <20180703210515.GA31234@hank.intra.tgummerer.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
 <20180605215219.28783-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605215219.28783-1-t.gummerer@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05, Thomas Gummerer wrote:
> The previous round was at
> <20180520211210.1248-1-t.gummerer@gmail.com>.
> 
> Thanks Junio for the comments on the previous round.
> 
> Changes since v2:
>  - lowercase the first letter in some error/warning messages before
>    marking them for translation
>  - wrap paths in output in single quotes, for consistency, and to make
>    some of the messages the same as ones that are already translated
>  - mark messages in builtin/rerere.c for translation as well, which I
>    had previously forgotten.
>  - expanded the technical documentation on rerere.  The entire
>    document is basically rewritten.
>  - changed the test in 6/10 to just fake a conflict marker inside of
>    one of the hunks instead of using an inner conflict created by a
>    merge.  This is to make sure the codepath is still hit after we
>    handle inner conflicts properly.
>  - added tests for handling inner conflict markers
>  - added one commit to recalculate the conflict ID when an unresolved
>    conflict is committed, and the subsequent operation conflicts again
>    in the same file.  More explanation in the commit message of that
>    commit.

Now that 2.18 is out (and I'm caught up on the list after being away
from it for a few days), is there any interest in this series? I guess
it was overlooked as it's been sent in the rc phase for 2.18.

I think the most important bit here is 6/10 which fixes a crash that
can happen in "normal" usage of git.  The translation bits are also
nice to have I think, but I could send them in a different series if
that's preferred.

The other patches would be nice to have, but are arguably less
important.

> range-diff below.  A few commits changed enough for range-diff
> to give up showing the differences in those, they are probably best
> reviewed as the whole patch anyway:
>
> [snip]
> 
> Thomas Gummerer (10):
>   rerere: unify error messages when read_cache fails
>   rerere: lowercase error messages
>   rerere: wrap paths in output in sq
>   rerere: mark strings for translation
>   rerere: add some documentation
>   rerere: fix crash when conflict goes unresolved
>   rerere: only return whether a path has conflicts or not
>   rerere: factor out handle_conflict function
>   rerere: teach rerere to handle nested conflicts
>   rerere: recalculate conflict ID when unresolved conflict is committed
> 
>  Documentation/technical/rerere.txt | 182 +++++++++++++++++++++
>  builtin/rerere.c                   |   4 +-
>  rerere.c                           | 246 ++++++++++++++---------------
>  t/t4200-rerere.sh                  |  67 ++++++++
>  4 files changed, 372 insertions(+), 127 deletions(-)
>  create mode 100644 Documentation/technical/rerere.txt
> 
> -- 
> 2.18.0.rc1.242.g61856ae69
> 
