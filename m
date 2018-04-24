Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6311F424
	for <e@80x24.org>; Tue, 24 Apr 2018 17:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753006AbeDXRgb (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 13:36:31 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35347 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753004AbeDXRgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 13:36:25 -0400
Received: by mail-vk0-f41.google.com with SMTP id h134so12167903vke.2
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O0zt0f6Ag/7DRXV1vn/6dS15Lb2Lcb3qh9iSRIHCt2Y=;
        b=u+6nQgMovk5De7OjYadAHl74k3tH5DBNjijBdqJa80LXa4aPAvbQ78gOAweuac8k88
         YYzzC9u+A10zSkNapep6iAVUDtXsf4Z3bAuO7arAdiALrn/vMkeyMdUhsycpKHs90Ihx
         Z+f6Q4qAvvQDz/a4O1efSmrptVlrUBB+rq5nXgrybneNeL3+AT7EDt8QgxH/5Vqfmmn5
         /NS9bLCjZYi5ZXlwHT9RR7+Q6WnPSYLih1DQQnxEPDemzUt7jJ1KbEduajvWyPTZOnv3
         gPsL7QxXKDectJbyP2Sj/XFKF7PQOqq24R/JX2uLKgr25w/LLWZVq4gObuvZ0motB0Tb
         5Tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O0zt0f6Ag/7DRXV1vn/6dS15Lb2Lcb3qh9iSRIHCt2Y=;
        b=YhNs20NJwbvi5HY5WUFMM8LTaapTx9GqVSxJl73txuwWC0oh/a7SJ/Pw/CfQc7alD+
         hU3EpePeKvqA65zITNAhtYmR28XXzq2f9vRc/ebiVZw8U8/rY31PRVWM9DJTTgDysXDV
         v/EPGxwv4YLIu8Db/9qOo7ci/vFLaFcqTCAe9e2tY4ii4h/8oGHVhMds5ErJy/jM+ojs
         0tNkMhWnBs1OS6mgTXG27ElyB00akFSivTKsGm29mncqffHvQ9riezsCON5N+hAnzbE2
         G8CqSWbE7g5XVOYxl4klIuk+AoQF6sflnyCxw8OCLWuzToxZE255CZhXcM9mOWqrHLvM
         xmTw==
X-Gm-Message-State: ALQs6tBGSkMq7EJ+2RxVuEqC3Pu0BcQjuY1JlNREGpNd9lI1enBRefI7
        8iJLCq9j7ksC+pOKCWdpQitW9uuNHSPfM5xCq7M=
X-Google-Smtp-Source: AIpwx4/7yjvD/oDjnSjG6PQD0V1bl/hWn2TDtioI3JfMS9jqbpABdRULuFr9vZu2dbzKQAUy3oLI8aOQoFamgAZNAO4=
X-Received: by 10.31.165.10 with SMTP id o10mr18241445vke.187.1524591383925;
 Tue, 24 Apr 2018 10:36:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Tue, 24 Apr 2018 10:36:23 -0700 (PDT)
In-Reply-To: <a34144ff-b91e-6f00-93e8-b472ad5887d0@gmail.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180420133632.17580-3-benpeart@microsoft.com> <CABPp-BFXwbZfFe0bZYMwWxz_Qxw=KQ6XE5SEBmgiE+TzaSycuQ@mail.gmail.com>
 <a34144ff-b91e-6f00-93e8-b472ad5887d0@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 Apr 2018 10:36:23 -0700
Message-ID: <CABPp-BHYrxyg1W0+144M=Bstunuw36ZCtRJhvu5G_kCm1g7e4w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] merge: Add merge.aggressive config setting
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Tue, Apr 24, 2018 at 9:45 AM, Ben Peart <peartben@gmail.com> wrote:
> On 4/20/2018 1:22 PM, Elijah Newren wrote:
>> On Fri, Apr 20, 2018 at 6:36 AM, Ben Peart <Ben.Peart@microsoft.com>
>> wrote:
>>>
>>> Add the ability to control the aggressive flag passed to read-tree via a
>>> config setting.
>>
>> This feels like a workaround to the performance problems with index
>> updates in merge-recursive.c.
>
> This change wasn't done to solve performance problems.  We turned it on
> because it reduced the number of unmerged entries (from 40K to 1) in the
> particular merge we were looking at.  The additional 3 scenarios that
> --aggressive resolves made that much difference.
>
> That said, it makes sense to me to do

Um...color me perplexed here.  aggressive exists just to do some
resolutions that higher-level strategies can and totally ought to be
able to handle easily (the rules are almost trivially
straight-forward), but deferring allows the higher level strategies
(either merge-recursive or resolve's git-merge-one-file) to handle
slightly differently (e.g. by detecting renames).  merge-recursive
should be able to resolve anything that the unpack_trees aggressive
setting handles.  If it can't, it sounds like there's a horrible bug
somewhere.

Perhaps fixing that bug is the real problem?

Is there any chance you can dig out more details about any of these
conflicts or come up with a simple testcase where running 'git merge
-X no-renames' gives a merge conflict but running with this option
would run to completion?

>> this when rename detection is turned off.  In fact, I think you'd
>> automatically want to set aggressive to true whenever rename detection
>> is turned off (whether by your merge.renames option or the
>> -Xno-renames flag).
>> > I can't think of any reason this setting would be useful separate from
>> turning rename detection off, and it'd actively harm rename detection
>> performance improvements I have in the pipeline.  I'd really prefer to
>> not add this option, and instead combine the setting of aggressive
>> with the other flag.  Do you have an independent reason for wanting
>> this?
>>
>
> While combining them would work for our specific use scenario (since we turn
> both on already along with turning off merge.stat), I really hesitate to tie
> these two different flags and code paths together with a single config
> setting.
>
> While I don't want to needlessly complicate your optimizations in this area
> (they are already complex enough!) I believe we need to keep the option to
> turn on --aggressive without turning off rename detection as a viable
> option.  Perhaps if that is the case, your optimizations have less impact or
> don't apply but the user should be able to make that choice for their
> specific situation.

I totally buy that you need at least one option to avoid waiting for
(current) rename detection in some fashion, and that you don't want
lots of spurious conflicts.  But I don't understand why you believe
that we need to keep the option to turn on the aggressive flag
independently.  What's the usecase?  It wasn't possible before in the
code, no one else has asked for it, and even you say you don't need it
as a separate option.  Is it a concern that turning on aggressive
whenever rename-detection is turned off will break something?  The
only reason I can see to keep the aggressive codepath in unpack_trees
behind a branch instead of it always running unconditionally for every
single caller throughout the codebase is because of renames.  So the
fact that you're turning renames off, to me, suggests that aggressive
flag should automatically be turned on.  I'd even call pre-existing
code (e.g. the -X no-renames option in merge-recursive) that doesn't
turn on the aggressive flag buggy (even if the only result is
suboptimal-performance).

I don't see how an option to turn on the aggressive flag independently
is possibly useful to anyone.  Further, we have strong reason to
believe it will soon be actively harmful.  So...why?  It's totally
possible I'm just missing something.  If there's a good reason for it,
providing some kind of benefit that the user could weigh in a
tradeoff, then I can get on board with providing it as an option, but
right now I just don't see it.
