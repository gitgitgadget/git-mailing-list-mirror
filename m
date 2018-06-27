Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E66D31F516
	for <e@80x24.org>; Wed, 27 Jun 2018 17:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965142AbeF0R16 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 13:27:58 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:42500 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753490AbeF0R16 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 13:27:58 -0400
Received: by mail-vk0-f65.google.com with SMTP id s187-v6so1648648vke.9
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zf6FzxhTJ/Y7Fnc5AeJZWl+LzzG7MaIEYof/Tm/Y6uE=;
        b=JwFzj8Nwje3bzf3oIxP6JhG5+6qoF9MxXs/qapeC0Rg16VdO1UPwBc+QsCTe6udwOZ
         m/J33MFdGl4c0Jd08yNysd04awvpzQEY3YvGqlyg0AkGAxs7rPBiKo+0IjeasRBJX6rU
         Wi+XMr8aDlstbE7WWLZ7vNUSLJfMfV3KZtG+a4drTXrBu3SfcSJ9sK4vGIM42cFjdlTW
         xhcjezdUzXpSApcKamwvSBPjESLhbqpYdpYRXSUtjefHPiNkrbwLCGRoTGlD6R+GxRRB
         /hxu+V/OSdWjUy/4cgKzEy/eJz1c2Kcq4MVZK9kY8uf+lHJuwYMhn7K8oDNHFDrI+RVt
         Wkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zf6FzxhTJ/Y7Fnc5AeJZWl+LzzG7MaIEYof/Tm/Y6uE=;
        b=OszyKPcWS9wZiX6YWVc8Bddz+vRsFLKDVO/ZhCXf7wMpijOLmqtyxAwvzadMCccszS
         xdH3v7GENEdNgi9CKav1FuaahtofRiLdDKSNmkoDbjGr9lqTkuzefSBNLmkBR/GA7ZKC
         7ucour155XfwKk8FVL3oUmUFurCWbGzSsrF0dtr8gRc1DTS1W6zdnwyiW4Q7ap6Xz6Yt
         SlGhjb3sZ/sMUkGx0x3YTy3IGtn4l1GiZ60XiUFZLifNLxgK9lnMyRkN5z3xuK5bxDx3
         cJS5WGG80GFZWdDUjLwR0Qf477nQoApLQ8AhSc/gLbWlZGguUnXEYLAHhQpwsesp+IF4
         nqKQ==
X-Gm-Message-State: APt69E1oxHLAgQMKHt4SiEN9NcrNll5zGkikuCYcWK94ZTUj9/mVbx1C
        HG2HX1Ihv9QSLieC55s2e9Glv//XLIVLPRUzLQA=
X-Google-Smtp-Source: AAOMgpcoP+aBPvU3KJbVePpQJIr28p+Qi/eCGICmZw6IQRRP/GEC+hNagKdn82qms2gF5uXc1h9gNOATwO+BrvqJz6M=
X-Received: by 2002:a1f:41d4:: with SMTP id o203-v6mr4186402vka.149.1530120477314;
 Wed, 27 Jun 2018 10:27:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2310:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 10:27:56
 -0700 (PDT)
In-Reply-To: <xmqqh8logofg.fsf@gitster-ct.c.googlers.com>
References: <20180607050845.19779-1-newren@gmail.com> <20180627073623.31725-1-newren@gmail.com>
 <20180627073623.31725-2-newren@gmail.com> <CAPig+cTwwuqPgF2NtGRgpcdjFqJK22+FFDV2c-20oQXFLEPaWQ@mail.gmail.com>
 <CABPp-BFkjF5z6axqW-v=zPq9U9sOQGpUKK+WvLknkkGzX-F4rA@mail.gmail.com> <xmqqh8logofg.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 27 Jun 2018 10:27:56 -0700
Message-ID: <CABPp-BEYbC0C+bczQuNTcC_jxVM59czh7HTpqi9dv09fvCjMrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t3418: add testcase showing problems with rebase
 -i and strategy options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 27, 2018 at 9:54 AM, Junio C Hamano <gitster@pobox.com> wrote:

> +       (
> +               PATH=./test-bin:$PATH
> +               test_must_fail git rebase -i -s funny -Xopt -Xfoo master topic
> +       ) &&
>
> +       (
> +               PATH=./test-bin:$PATH
> +               git rebase --continue
> +       ) &&
>
> and it would be reasonable to assume that these variable assignments
> would not fail.  IOW, there is no BUG in breaking &&-chain at these
> two places.  It is merely that the automated mechanism introduced by
> step 29/29 of that other series does not understand that (which is
> expected).  It is not wrong to have && at the end of the assignment,
> though.
>
> Having said that, it would be simpler for at least the latter to
> write it using a single-shot environment assignment, perhaps?  I.e.
>
>         PATH=./test-bin:$PATH git rebase --continue &&
>
> without running in a subshell?

Seems reasonable.  Since these tests were essentially copies of other
tests within the same file, just for rebase -i instead of -m, should I
also add another patch to the series fixing up the rebase -m testcase
to also replace the subshell with a single-shot environment
assignment?
