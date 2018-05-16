Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15A911F406
	for <e@80x24.org>; Wed, 16 May 2018 15:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750953AbeEPPei (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 11:34:38 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:50361 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeEPPeh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 11:34:37 -0400
Received: by mail-wm0-f46.google.com with SMTP id t11-v6so2720386wmt.0
        for <git@vger.kernel.org>; Wed, 16 May 2018 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=YrYF4uz5C1q+WgGvAivUyVHM5131zEqOlHb9U5pcpxw=;
        b=ikXm34Mw7/96e7Rpee781pnU5t8VYBlHvL/sL24b88gapzElS+ZMwZJrcXUR1ND3XE
         TVtk7a9c5pJHaQsp7b7lUTpM+gmla2i2Emr4sEoCpnvqnlrpmIDCdS8errUQK/ZN6A41
         tXycspSOuI949Qwwy1PGVS1kQWWu6pOHE9DKbgrmbFei5qw4tRHrgcWTGGaHBIuUpskP
         uaWkr8IS99WDVG6Z7Vfz6daQRRmK8h0ViNmfZLKV7KNhHFnQGgbkxK/1i5gOyyVjAS/l
         jSrccT81LM7d7mIK35P1uglPKfnnNCqr+ZvtvajNrFx9Uutu9asD2p6X7nHt1ir7QL4E
         EETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=YrYF4uz5C1q+WgGvAivUyVHM5131zEqOlHb9U5pcpxw=;
        b=iSrditQa1SEWf3qpq8zyiHo1A786MR6o6NI23t34RyjdGgGo6srZGPCQDNTYOG71Nj
         NwGd17/uLQdPcjcKPSSVo1JLm3HfXVvE7IPb4tttbwqZBZVWwBXTR1pYOMvXQ+v7J76H
         n3d5jM4eKUDcc82C2zHKdNAJHBnP2D07wqEuSDmeQBBxWfhRvMNIOU25PorNG88LOifO
         ogiHCHMagzejLVpf26zPjaSMMGTZ1pxB+SekM14J1X2mVbOWroebnT5ODXrEMzYtA4Wa
         ioL4fh3CKw+qvOdOEGU5LFad/MhGC+RSfmof+h3kZvv7H1RvScgaiQcCJBqf4OPOWgYg
         WuSQ==
X-Gm-Message-State: ALKqPwd/57ad09pnapaWCvyjRjsLmG8RqEOudWBKXOTdC5rOG2o74pei
        FVNwJYz8l370IopmfSvgEGI=
X-Google-Smtp-Source: AB8JxZpR5aYI2zUTM7U3h/SXzHAvHZuuKlo+Ok2/WdTvRAp3lWkRmTXSXn3DTNgS8rslWuQHqaNPRA==
X-Received: by 2002:a50:a5f6:: with SMTP id b51-v6mr1765146edc.147.1526484876046;
        Wed, 16 May 2018 08:34:36 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id x49-v6sm1467070edb.5.2018.05.16.08.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 08:34:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
        <87po1waqyc.fsf@evledraar.gmail.com>
        <81B00B00-00F4-487A-9D3E-6B7514098B29@gmail.com>
        <87muwzc2kv.fsf@evledraar.gmail.com>
        <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com>
        <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org>
Date:   Wed, 16 May 2018 17:34:34 +0200
Message-ID: <87k1s3bomt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 16 2018, Konstantin Ryabitsev wrote:

> On 05/16/18 09:02, Derrick Stolee wrote:
>> This is the biggest difference. You cannot have the same ref checked out
>> in multiple worktrees, as they both may edit that ref. The alternates
>> allow you to share data in a "read only" fashion. If you have one repo
>> that is the "base" repo that manages that objects dir, then that is
>> probably a good way to reduce the duplication. I'm not familiar with
>> what happens when a "child" repo does 'git gc' or 'git repack', will it
>> delete the local objects that is sees exist in the alternate?
>
> The parent repo is not keeping track of any other repositories that may
> be using it for alternates, which is why you basically:
>
> 1. never run auto-gc in the parent repo
> 2. repack it manually using -Ad to keep loose objects that other repos
> may be borrowing (but we don't know if they are)
> 3. never prune the parent repo, because this may delete objects other
> repos are borrowing
>
> Very infrequently you may consider this extra set of maintenance steps:
>
> 1. Find every repo mentioning the parent repository in their alternates
> 2. Repack them without the -l switch (which copies all the borrowed
> objects into those repos)
> 3. Once all child repos have been repacked this way, prune the parent
> repo (it's safe now)
> 4. Repack child repos again, this time with the -l flag, to get your
> savings back.
>
> I would heartily love a way to teach git-repack to recognize when an
> object it's borrowing from the parent repo is in danger of being pruned.
> The cheapest way of doing this would probably be to hardlink loose
> objects into its own objects directory and only consider "safe" objects
> those that are part of the parent repository's pack. This should make
> alternates a lot safer, just in case git-prune happens to run by accident.

I may have missed some edge case, but I believe this entire workaround
isn't needed if you guarantee that the parent repo doesn't contain any
objects that will get un-referenced.

You'd do that in the common case by cloning with --single-branch, and
depending on your setup --no-tags (if you delete tags). This is assuming
that your HEAD branch points to something like a "master" that doesn't
get rewound.

The problem you're describing happens if say you clone git.git and have
the "pu" branch in there in the parent, and as a result you get child
repos referencing those objects, but when the parent GCs after "pu" is
rewound the child repos break. Thus your elaborate work-around.

But that situation isn't possible in the first place if you only ever
import the "master" branch, or other references guaranteed not to
change.

Of course that has the trade-off that every child repo needs to get its
own objects for the "next" branch, "pu", etc. But those are
comparatively tiny.

I wasn't aware of -l (--local), or had forgotten about it. I thought
that we didn't have that and the "child" repos would just keep growing
over time, i.e. not get rid of the objects we're fetching into the
parent (which the parent might get later due to the child, say if it's
fetched in a daily cronjob). Good to know that's not the case.

With that --local flag the trade-off of not fetching "next" and "pu"
etc. should become irrelevant over time, as they migrate to "master"
they'll get de-duplicated, or alternatively GC'd by the child repos if
they don't make it.

>> GVFS uses alternates in this same way: we create a drive-wide "shared
>> object cache" that GVFS manages. We put our prefetch packs filled with
>> commits and trees in there, and any loose objects that are downloaded
>> via the object virtualization are placed as loose objects in the
>> alternate. We also store the multi-pack-index and commit-graph in that
>> alternate. This means that the only objects in each src dir are those
>> created by the developer doing their normal work.
>
> I'm very interested in GVFS, because it would certainly make my life
> easier maintaining source.codeaurora.org, which is many thousands of
> repos that are mostly forks of the same stuff. However, GVFS appears to
> only exist for Windows (hint-hint, nudge-nudge). :)

This should make you happy:

https://arstechnica.com/gadgets/2017/11/microsoft-and-github-team-up-to-take-git-virtual-file-system-to-macos-linux/

But I don't know what the current status is or where it can be followed.
