Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B31215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 21:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeD3Vxv (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 17:53:51 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:40079 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbeD3Vxu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 17:53:50 -0400
Received: by mail-lf0-f45.google.com with SMTP id j16-v6so14144312lfb.7
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 14:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+Z0eYzI3P0KRYqYfZKqMKhELYFZ64MZi235Fq8QagTA=;
        b=PlaVnVwmKQSvanj8ZCzZLhVdgKGIUUUmQyvwWJpCMivRW57Izbll0kxx8mKwFhYek+
         s2o18lOqNXYdS5GJRg6NeCLLUvYhlzmxMCXTbn/ufAuGT9KB2sdT60LKp9TgDYimG8HV
         mNu6118tsV3x6bBQNNjwYeR9GKV5jIf4n/YwpTvG1cMZ31i+OYO5S3PLN43sH/yVNiZP
         qzqZweV7ZgD4yrrB/7rCL9RQGu4m9jrz+XS7GpsaRCjBLosGBVpzR0FUIwgbrV4xFFB0
         Atw2EhUbbwjjvkvuAZg/DU6UwFvRcpu7Mo9CgrNSOF/mF/5qmHLhMpw7lfLk7NGxe+mg
         un+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+Z0eYzI3P0KRYqYfZKqMKhELYFZ64MZi235Fq8QagTA=;
        b=eG882i5c7Br9Y8B1rKhaZxRmT3G/GEgmsH1aC4ryG67TKIAWw0axFQImmWoJhfeFq+
         eTass7V0Au/pdgo80PfZr4IAsWpWwRMFpxot8WSNpANjxaFUILXt+d3i1HL3kzIIiDpS
         eOOECfHFVkfCzU1465888oXvWHQHzSMzD/wMfIpGgc6bS7TZfPGOCe6HPVgSuZqgRFK0
         9Kg6rW9CZtv81eJRoFGUAbuUPoTBbwj8RYVqaveQT5eYxfDSBu03N2P4+FCLASBuZyKt
         CTk+K56DRLbUymvoT1jIHJTBZpu0ehnsnnqm3UEDQMtZmyqqOnmKXDp+Lu5m4c6l9gTm
         yJcQ==
X-Gm-Message-State: ALQs6tAIdx1hVXxrelm5iNCD2qekq+P9imKCqWs/78C4TjTw3TDBIkHU
        FYwET82KLTSVygOnlj9tj0fEh7FcGRiZ0NwOp90=
X-Google-Smtp-Source: AB8JxZomSGAqsbwg+1/bVzTQGXBDtdDk7D7dSYgvBV6NaiN3aUHkvPHhw8zhYE3jbWujHpw/vJ6dMaQBfn77fSHPAkk=
X-Received: by 2002:a19:cd09:: with SMTP id d9-v6mr8040341lfg.87.1525125228605;
 Mon, 30 Apr 2018 14:53:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.146.199 with HTTP; Mon, 30 Apr 2018 14:53:28 -0700 (PDT)
In-Reply-To: <CAGZ79kakirTjA32cTmByLpjnb3QKUL5eGEgPFFMhUnewC73S8Q@mail.gmail.com>
References: <20180430095044.28492-1-avarab@gmail.com> <CAHqTa-0xZteMjgJUZ-_Dv5KcX8sVVWHYu=OdRebVEfYfyP0QRw@mail.gmail.com>
 <CAGZ79kakirTjA32cTmByLpjnb3QKUL5eGEgPFFMhUnewC73S8Q@mail.gmail.com>
From:   Avery Pennarun <apenwarr@gmail.com>
Date:   Mon, 30 Apr 2018 17:53:28 -0400
Message-ID: <CAHqTa-1KCsbG=6T8M0PLuM5s-j972jiv=vvZHUiwOxwgpPWJeA@mail.gmail.com>
Subject: Re: [PATCH 0/4] subtree: move out of contrib
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Stephen R Guglielmo <srguglielmo@gmail.com>,
        "A . Wilcox" <AWilcox@wilcox-tech.com>,
        David Aguilar <davvid@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 5:38 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Apr 30, 2018 at 1:45 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> No objections from me either.
>
> Submodules seem to serve a slightly different purpose, though?

I think the purpose is actually the same - it's just the tradeoffs
that are difference.  Both sets of tradeoffs kind of suck.

> With Subtrees the superproject always contains all the code,
> even when you squash the subtree histroy when merging it in.
> In the submodule world, you may not have access to one of the
> submodules.

Right.  Personally I think it's a disadvantage of subtree that it
always contains all the code (what if some people don't want the code
for a particular build variant?).  However, it's a huge pain that
submodules *don't* contain all the code (what if I'm not online right
now, or the site supposedly containing the code goes offline, or I
want to make my own fork?).

For the best of both worlds, I've often thought that a good balance
would be to use the same data structure that submodule uses, but to
store all the code in a single git repo under different refs, which we
might or might not download (or might or might not have different
ACLs) under different circumstances.  However, when some projects get
really huge (lots of very big submodule dependencies), then repacking
one-big-repo starts becoming unwieldy; in that situation git-subtree
also fails completely.

> Submodules do not need to produce a synthetic project history
> when splitting off again, as the history is genuine. This allows
> for easier work with upstream.

Splitting for easier work upstream is great, and there really ought to
be an official version of 'git subtree split', which is good for all
sorts of purposes.

However, I suspect almost all uses of the split feature are a)
splitting a subtree that you previously merged in, or b) splitting a
subtree into a separate project that you want to maintain separately
from now on.  Repeated splits in case (a) are only necessary because
you're not using submodules, or in case (b) are only necessary because
you didn't *switch* to submodules when it finally came time to split
the projects.  (In both cases you probably didn't switch to submodules
because you didn't like one of its tradeoffs, especially the need to
track multiple repos when you fork.)

> Subtrees present you the whole history by default and the user
> needs to be explicit about not wanting to see history from the
> subtree, which is the opposite of submodules (though this
> may be planned in the future to switch).

It turns out that AFAIK, almost everyone prefers 'git subtree
--squash', which squashes into a single commit each time you merge,
much like git submodule does.  I doubt people would cry too much if
the full-history feature went away.

There's one exception, which is doing a one-time permanent merge of
two projects into one.  That's a nice feature, but is probably used
extremely rarely.  More often people get into a
merge-split-merge-split cycle that would be better served by a
slightly improved git-submodule.

>> The gerrit team (eg. Stefan Beller) has been doing some really great
>> stuff to make submodules more usable by helping with relative
>> submodule links and by auto-updating links in supermodules at the
>> right times.  Unfortunately doing that requires help from the server
>> side, which kind of messes up decentralization and so doesn't solve
>> the problem in the general case.
>
> Conceptually Gerrit is doing
>
>   while true:
>     git submodule update --remote
>     if worktree is dirty:
>         git commit "update the submodules"
>
> just that Gerrit doesn't poll but does it event based.

...and it's super handy :)  The problem is it's fundamentally
centralized: because gerrit can serialize merges into the submodule,
it also knows exactly how to update the link in the supermodule.  If
there was wild branching and merging (as there often is in git) and
you had to resolve conflicts between two submodules, I don't think it
would be obvious at all how to do it automatically when pushing a
submodule.  (This also works quite badly with git subtree --squash.)

>> I really wish there were a good answer, but I don't know what it is.
>> I do know that lots of people seem to at least be happy using
>> git-subtree, and would be even happier if it were installed
>> automatically with git.
>
> https://trends.google.com/trends/explore?date=all&q=git%20subtree,git%20submodule
>
> Not sure what to make of this data.

Clearly people need a lot more help when using submodules than when
using subtree :)

Have fun,

Avery
