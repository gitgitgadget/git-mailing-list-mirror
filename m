Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9C6202A0
	for <e@80x24.org>; Wed, 15 Nov 2017 09:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756633AbdKOJMu (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 04:12:50 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:52481 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756173AbdKOJMo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 04:12:44 -0500
Received: by mail-qt0-f171.google.com with SMTP id 31so32781407qtz.9
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 01:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=obktEk104LSO0JFJc64h3BqiWh+kN88Hj6w1epAsJ0U=;
        b=DRLjF7fl5W+QMrzCNqzhVwBgvcqm2ocnQTaMLcVASz/LNrv8OePUvtDntCKm4dtdaM
         4dphKAZA0tg8z24LvMisHze0SYiXErOd82O8pckIN/Mf7alGCib50cW0edwzk0UZEKuk
         nKO0p9CSVCM3C7p73aXa9654DuR1QmHZgYWp4IiVja9VAe3y+oGgu33Y7/91ZXTzoS2U
         6Q4lzohWBJ2l3kLUcBuEZOtc+pDW/2y5NhnJQvnLTWphJLzJvnO4BFI1WDxAZEciqXqr
         aXIiKeym5MzH5eHeSSnrERWeDHnyOsphfbyjcmGXi2CueyKLp1uoXTyLfbFBKqyQXVDE
         6ETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=obktEk104LSO0JFJc64h3BqiWh+kN88Hj6w1epAsJ0U=;
        b=O465JcOkL8W0+Alb/nDY+gcbg27nj6nLjM50Ua4GuzAO6c2Xg6U8jQD4J6GIeGylK0
         bNC8PQPyWi6qCa0GsoYdzp9mWvfa/TIs0ElSlR/OKb4X+j6RxutBGRxME0LLm72B0pxP
         G9drYeKyFgbEGErd03FdpfTo0PbJb7A1fHAf7OD5PbSsLqUbSL/GAafEPplBhbKcLWmO
         skLBHcr6uptCIFaqlilZ/lP73c5YuJzhUvIVthuBR+DkOoHMTv5npRHH523g4x+QT7kO
         3/Q0+xWUHLdIqY4kgtlrnrHTY/2l92Hc/WPax8w02IT4bOk9cUQ+J6QqiIXAcLm1Xivh
         Y+tw==
X-Gm-Message-State: AJaThX7fH4NCgrUWyAvOrcXRJ5vuPDuJa0fMms7H1rL1pvpQtNJGWAnb
        P+cL9DiYSrQbUzMmkEqbnYk7gnK86kwYjRSHK6Q=
X-Google-Smtp-Source: AGs4zMYG+uXYA+tQ/XxNzSVCqq9tQ9LN/GnawBSfuon6fbAcCckKP/yxThPMy2JNOe3PhsxP1nhQ/2unsL3dZPd+m3E=
X-Received: by 10.237.37.162 with SMTP id x31mr287297qtc.58.1510737164100;
 Wed, 15 Nov 2017 01:12:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Wed, 15 Nov 2017 01:12:43 -0800 (PST)
In-Reply-To: <20171115085039.GA32324@hank>
References: <20171112134305.3949-1-t.gummerer@gmail.com> <20171112134305.3949-2-t.gummerer@gmail.com>
 <xmqq1sl2c21g.fsf@gitster.mtv.corp.google.com> <20171114084517.GA12097@hank>
 <CAPig+cTYC01Y9-EvyNo9hxQRbT60iqp8MqXEB_zWBi14kPV1Ng@mail.gmail.com> <20171115085039.GA32324@hank>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 15 Nov 2017 04:12:43 -0500
X-Google-Sender-Auth: KfepAcfmG0NJjqx2nKZXtxKDFwI
Message-ID: <CAPig+cTBkWrmFQeSLhtKXpdNKs2wFDmNArqScv9nHLaBbCZjqg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] worktree: make add dwim
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 15, 2017 at 3:50 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 11/14, Eric Sunshine wrote:
>> git worktree add ../topic
>> [...]
>> The desired new DWIMing would change the second bullet point to:
>>
>> * If no local branch named "topic" exists, DWIM it from "origin/topic"
>> if possible, else create a new local branch named "topic".
>>
>> But that's a behavior change since, with the existing implementation,
>> a newly created local "topic" has no relation to, and does not track,
>> any origin/topic branch. The proposed --guess option is to avoid users
>> being hit by this backward incompatibility, however, one could also
>> view the proposed DWIMing as some sort of bug fix since, at least
>> some, users would expect the DWIMing since it already takes place
>> elsewhere.
>
> I'm not sure we can call it a bug fix anymore, since as Junio pointed
> out the current behaviour of creating a new branch at HEAD is
> documented in the man page.
>
> However git-worktree is also still marked as experimental in the man
> page, so we could allow ourselves to be a little bit more lax when it
> comes to backwards compatibility, especially because it is easy to
> take corrective action after the new DWIMing happened.

Yep, my leaning toward making this new DWIMing default (without a
--guess or --track option) also is based in part on git-worktree still
being marked "experimental".

>> So, at least two options exist:
>>
>> * Just make the new DWIMing the default behavior, accepting that it
>> might bite a few people. Fallout can be mitigated somewhat by
>> prominently announcing that the DWIMing took place, in which case the
>> user can take corrective action (say, by choosing a different worktree
>> name); nothing is lost and no damage done since this is happening only
>> at worktree creation time.
>>
>> * Add a new option to enable DWIMing; perhaps name it -t/--track,
>> which is familiar terminology and still gives you a relatively short
>> and sweet "git worktree add -t ../topic".
>>
>> Given the mentioned mitigation factor and that some/many users likely
>> would expect it to DWIM "origin/topic -> topic" anyhow, I'd lean in
>> favor of the first option (but perhaps I'm too daring with other
>> people's workflows).
>
> Yeah, I'm leaning towards the first option as well, but I'm clearly
> biased as that's how I'd like it to behave, and others might want the
> other behaviour.  Unfortunately I don't know many worktree users, so I
> can't tell what the general consensus on this would be.

Aside from the mentioned mitigation factor, which somewhat eases my
worries about backward incompatibility, one genuine concern is
breaking existing scripts. At the very least, if the new DWIM becomes
default, there might need to be some escape hatch for scripts to opt
out of it.

> I guess the second option would be the safer one, and we can still
> switch that to be the default at some point if we wish to do so
> later.

The longer you wait, the less likely you'll have the chance since
git-worktree will (presumably) gain more users and be used in more
scripts as time passes. So, if the new DWIMing is to become the
default, better to do so earlier rather than later.

> tl;dr I have no idea which of the options would be better :)

I'm probably too cavalier and shortsighted (at least on this topic) to
make a well-informed decision about it. Junio probably has a better
feeling about whether such a change of behavior makes sense at this
late date, and, of course, it's his decision whether to accept such a
change into his tree.
