Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 639792023D
	for <e@80x24.org>; Sun,  6 May 2018 08:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeEFIdV (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 04:33:21 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:40092 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeEFIdR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 04:33:17 -0400
Received: by mail-oi0-f41.google.com with SMTP id c203-v6so22637954oib.7
        for <git@vger.kernel.org>; Sun, 06 May 2018 01:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dBXMRTqasx6usBuUtWIMrwQPaGMc/i6ew50dGHru880=;
        b=DdyQOefBkUAxpijoGjNxnrL8bhGX5KzVxnnoFHMFJiuDTLd3sQAYZa+Aeqh7zhPc54
         wtLLvxiF/SPtJZS11Cl3WFpHuBznNxR0ahKFbHFSW3NZENuI1PKlm1CvCxWYnI+Qr7Rs
         bS/oslPRcBr1W4swrACIWN3be1Vps+fmKaTxGSkf8OD50DpXdiqvS9g0UwpibGdON/E+
         eAlgtd1Z2qe9allxqIszWGFTcn+Noj579DXcm4kUtTNLI4cufF7PAtrf6deKE68sqpLx
         MGTQEDU+Pquxj4ABL3OGPhuj0vdGUKbWX2yKVt7w0OxY8wYHUtn9FPOJOBs+vaH0BSPW
         oz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dBXMRTqasx6usBuUtWIMrwQPaGMc/i6ew50dGHru880=;
        b=eSv7ZVOSOYl3ARF09BjbwqQbk95C/aRKhs4xKDDvwUDa1oHPEItD71MKZLsvJ1emS7
         Lz2Jw1JzyWzC/6tX3UHkkoiRkNJFzYIfH+ZasBWB4HL+7zSWjJCxIL6m80cL4YTK/jXq
         nBxg/qtuu+UJHMiRlO1HeYOR+eSK8ovJC1l3OMO3KZxqUCpHAygg1W0ISrxneWrkWJur
         m1iRSjKExI7oRCYCYa61ItfYhcc1czmK9D3wApWvXDh/7DseIT+Ea8wMrBcAFsy0krS5
         sS7kTLiC8WcW2mPGCz6JYjIYAL/aWbGAxfBfKsJCu6c9wh9P3Dhx4tWKIOzQoUwCzy9Z
         Du/g==
X-Gm-Message-State: ALQs6tDXrt8IscQIfGHnw4xcsVP9RRTYUJAktG57B8FONLIw3RfB23Zh
        KFxpQgwnNUc3P/771GAridfDs3jqEwuRYAHnrtc=
X-Google-Smtp-Source: AB8JxZqPMt1QyfQcIy/nu1LLmNt2Doi8ET1lNxlHeROjtX2cLeHCCX5NzgPFrtl61SZY/8bycXs5U5W+BAr74Yb5lYA=
X-Received: by 2002:aca:2813:: with SMTP id 19-v6mr21848001oix.281.1525595597331;
 Sun, 06 May 2018 01:33:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Sun, 6 May 2018 01:32:46 -0700 (PDT)
In-Reply-To: <CA+P7+xphRqZhwQAutph9RHAYxq=v0Zv9omdaPD3m8oV3KPdRhQ@mail.gmail.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com> <CA+P7+xphRqZhwQAutph9RHAYxq=v0Zv9omdaPD3m8oV3KPdRhQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 6 May 2018 10:32:46 +0200
Message-ID: <CACsJy8D0HYZFAWWn-8XEk63QohBKBE8Gx4=39Cp9_FMmbtJDew@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 6, 2018 at 6:53 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Sat, May 5, 2018 at 6:05 PM, Igor Djordjevic
> <igor.d.djordjevic@gmail.com> wrote:
>> Hi Dscho,
>>
>> On 05/05/2018 23:57, Johannes Schindelin wrote:
>>>
>>> > > This builtin does not do a whole lot so far, apart from showing a
>>> > > usage that is oddly similar to that of `git tbdiff`. And for a
>>> > > good reason: the next commits will turn `branch-diff` into a
>>> > > full-blown replacement for `tbdiff`.
>>> >
>>> > One minor point about the name: will it become annoying as a tab
>>> > completion conflict with git-branch?
>>>
>>> I did mention this in the commit message of 18/18:
>>>
>>>     Without this patch, we would only complete the `branch-diff` part but
>>>     not the options and other arguments.
>>>
>>>     This of itself may already be slightly disruptive for well-trained
>>>     fingers that assume that `git bra<TAB>ori<TAB>mas<TAB>` would expand to
>>>     `git branch origin/master`, as we now no longer automatically append a
>>>     space after completing `git branch`: this is now ambiguous.
>>>
>>> > It feels really petty complaining about the name, but I just want
>>> > to raise the point, since it will never be easier to change than
>>> > right now.
>>>
>>> I do hear you. Especially since I hate `git cherry` every single
>>> time that I try to tab-complete `git cherry-pick`.
>>>
>>> > (And no, I don't really have another name in mind; I'm just
>>> > wondering if "subset" names like this might be a mild annoyance in
>>> > the long run).
>>>
>>> They totally are, and if you can come up with a better name, I am
>>> really interested in changing it before this hits `next`, even.
>>
>> I gave this just a quick glance so might be I`m missing something
>> obvious or otherwise well-known here, bur why not `diff-branch` instead?
>>
>> From user interface perspective, I would (personally) rather expect a
>> command that does "diff of branches" to belong to "diff family" of
>> commands (just operating on branches, instead of "branch" command
>> knowing to "diff itself"), and I see we already have `diff-files`,
>> `diff-index` and `diff-tree`, for what that`s worth.
>>
>> Heck, I might even expect something like `git diff --branch ...` to work,
>> but I guess that is yet a different matter :)
>>
>> Thanks, Buga
>
> I like diff-branch, though I suppose that also conflicts with diff too.

How about interdiff?

-- 
Duy
