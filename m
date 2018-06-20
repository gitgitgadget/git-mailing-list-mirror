Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32EF41F403
	for <e@80x24.org>; Wed, 20 Jun 2018 16:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932528AbeFTQrQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 12:47:16 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:44266 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932082AbeFTQrO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 12:47:14 -0400
Received: by mail-vk0-f68.google.com with SMTP id x4-v6so122590vkx.11
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cKoXdumhQUMZNlQXgEZlvDmgznNFm/9z+VVsKXSfOno=;
        b=NmO6t0m1Jz5AUgaEYd9VHwIRDxk/kaaCoETT/tjsFQPXvHgM5k7DP/6mTGhztAOwKC
         PJHhs7w107Pc5HKTAs+FhSdhx+vRKhLaroyxwEpbPq18BJo5qmZCftDgvSq+O/heMeDW
         D6bL78UDClI8l8gw/Hd5y/3Pqawfkil91KvfogTvAKMJFBKlvLxyVSK+Q9qny8dX5XIf
         xKaTRviRqF3eqBHBpuK6RvivbVkvf/O2+evSOTso6Z69HbBqn7XZRZ+u4JuqM1B1mL+w
         Kg5jrug/1R5buZqADguSOEfSs/1jvjSFdsB4N/zUrDRIyxwN5hmOHp0iscxRwikxiebQ
         Kc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cKoXdumhQUMZNlQXgEZlvDmgznNFm/9z+VVsKXSfOno=;
        b=ZvoC5xLG/yKK748nscjrvVHeSZhHTd5mM912A8YqnuFYDkDXFRsqd0O01bskV2UNm0
         ZHRz09ybMNGXERuI+x/1WhMm4G9m4Vi8pNj3DLETFWMUsf998tpqlfMwrzuepp9k0/6G
         a3hl6wpxiq1PGKFU61oodsEeDqfhHXcFsAkFmelraFnhmJgkjSfEqRYyXJCubl3DwqXL
         yl6TC+hJPSomc58/qf9KARIbiNgkUxkhpbnQv/5Tt0F2/L2UpN2hwi5aWiyuiKssCppY
         F3LZ6Od978/ZEVNPAKBJgQ2kpyzUi2qK/k2JBrBK4KSqbY/yQmrCffQKQWXqfFDbTwsz
         +xdg==
X-Gm-Message-State: APt69E2zIUyVgL2AZZJMZFotZUGrAGeUCVtPRhZdTRVwTkSI/7lgIbrw
        JSqnck7hK7ptHrOAwzQnLCx/x94NsgLmG6rm6P8=
X-Google-Smtp-Source: ADUXVKLHUpgVE02jcfyZY/NxKga/vyPL0L5k/VjDLDufsnx7wjMhzzdBJK2JC5RLgXZfqHMf+iVUQRHlmZpp+RdfTn4=
X-Received: by 2002:a1f:a102:: with SMTP id k2-v6mr13012561vke.118.1529513232529;
 Wed, 20 Jun 2018 09:47:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 09:47:12
 -0700 (PDT)
In-Reply-To: <e8a6f54e-4361-dc66-c833-6047f8ea2058@talktalk.net>
References: <20180607050654.19663-1-newren@gmail.com> <20180617055856.22838-1-newren@gmail.com>
 <20180617055856.22838-8-newren@gmail.com> <e8a6f54e-4361-dc66-c833-6047f8ea2058@talktalk.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jun 2018 09:47:12 -0700
Message-ID: <CABPp-BHrcUHX_zHxpojV5=sxJ1=NoDg9uhxv+NH5BsHsQYavPQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 7/7] git-rebase: make --allow-empty-message the default
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Sun, Jun 17, 2018 at 8:30 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:

> Looking at the option parsing in git-rebase.sh it appears that it does not
> check for --no-allow-empty-message so there's no way to turn off the default
> for those modes that support it. I'm not sure what to think of this change,
> I'm slightly uneasy with changing to default to be different from
> cherry-pick, though one could argue rebasing is a different operation and
> just keeping the existing messages even if they are empty is more
> appropriate and having all the rebase modes do the default to the same
> behaviour is definitely an improvement.
>

Here's my extended rationale for why to change the default for rebase
-i/-m (and _maybe_ also for cherry-pick):

First, commits with an empty commit message are fairly rare, so it's
hard to gather that much data on; we're dealing with out-liers.  That
also means that folks who have touched the area in the past probably
weren't dealing with full information either; they just tweaked what
was already there.

It makes sense that git-commit would default to not allowing empty
commit messages without a flag.  We'd like to warn against that kind
of poor practice.  However, that implicitly means that commands which
build on top of git-commit might copy that default even when it
doesn't make sense.  So it's not at all clear to me that cherry-pick
or rebase -i/-m should have the same default.  They do, but that may
have been entirely accidental.  And when someone comes along and
notices the problematic default of stopping with empty commit
messages, they assume it was intended and add a flag to change it, as
happened for both commands.

On the other hand git-am was designed from the workflow of applying
many patches from the beginning, and has a different default.
am-based rebases copy that default of silently applying commits with
empty commit messages; it may not be clear that rebase should copy the
default from am, but it does.  Yet, despite the fact that ignoring
empty commit messages is the default backend for rebases, and thus is
likely used more than the other rebase backends, no one has ever
submitted a patch to add a flag to rebase to get the opposite
behavior.  To me, this argues pretty strongly that not only is
ignoring empty messages the right default, that it's a waste of time
to implement a flag (e.g. --no-allow-empty-message) providing the
opposite behavior for rebases.

It is obvious that one of the two rebase backends have the wrong
default, because they should have the same default as each other.  I
am inclined to believe, based on the above logic, that am-based rebase
has the correct default.  I also suspect that cherry-pick has the
wrong default, though it's not as cut-and-dry since it doesn't have
multiple backends with conflicting defaults.


Does that make sense?  Am I overlooking anything important?
