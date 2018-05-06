Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C8FB200B9
	for <e@80x24.org>; Sun,  6 May 2018 13:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeEFNha (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 09:37:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53734 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeEFNh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 09:37:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id a67so10130420wmf.3
        for <git@vger.kernel.org>; Sun, 06 May 2018 06:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bAjk860N853EOKnn9cYm1JBzbCGxzN0YQqJEbjwrXnk=;
        b=uo8ttSTxT27X7JUgHiyDsEGpkPx2m1GU6Tn+P20w3zvzn3JRrZzusw933ExR2T6ec8
         PT3ubBib6Mm2hWf/XglSZo1le3ORGZCC//VBMop8RzuSIRVQoZhDqEv2ZAd4hnNi+lCb
         BGS3DZvIcbTnprcrZ2aXkMQH205k77QLsEBWoWlwpmRINPmLVLG46w/ytUv0dcRCQ6UF
         WxU7Bbn8/ka/yfoGuDC7jFYxbcnIadfxRFJnpHym6tqI2bmX9vvI//y2yC0pJ3PwHj9u
         f+gWjkapkMhWqrKuEtnaCH7aa1v7LtjnFOj0PJU52GzIBsxdSV/LVUsTmqNcBnVrDpFK
         skcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bAjk860N853EOKnn9cYm1JBzbCGxzN0YQqJEbjwrXnk=;
        b=TGsp5FFs80Rzk876x8XZMDrtRP7L9U1Frf9ebKYQ7kDeJz0SNr0jeAMfYQ/NURcjYc
         kTsWUntJFEPPzsFQE7r+TOz0Mb0f8mtRMjS2b8yzlTug3EGCGXoEYIUEpgsUwyep+bVq
         35EKcN2mAVlKJb8/qBbJiWUBoSdcJvOb175VrnZMfYvoIjSUpYMGbaDdrYIocITeqYWC
         iHY8e0wQvt5m+BWhVU3b0KOPSff0ms/eHwOhVwikye1BB+4px6NSot2ECCcuZnnanz/P
         gw3Pyui76PGWNNhTsjzTJkwYsXhLPFPzhIe1pxZytit0ToMTr6S5EznfS7eoHVDK6Wej
         5nAw==
X-Gm-Message-State: ALQs6tBfjYUZXu0J8P0cop8GVxvPjiJrjsyshNuAJDHplHzv7IJ/3WMZ
        DHkLt5khsMABqY0G4tsST6w=
X-Google-Smtp-Source: AB8JxZrdo4ZhB3qXnBWhuVvLZCexJPOCW9y92ox7ZZvslxQUfbN+zy6kOIQJLp4z87Q3sIx6sn75Mg==
X-Received: by 10.28.74.219 with SMTP id n88mr5494664wmi.31.1525613847499;
        Sun, 06 May 2018 06:37:27 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.179.29])
        by smtp.gmail.com with ESMTPSA id d54-v6sm27946475wrd.94.2018.05.06.06.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 May 2018 06:37:26 -0700 (PDT)
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com>
 <nycvar.QRO.7.76.6.1805061408150.77@tvgsbejvaqbjf.bet>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <e0db15c5-e897-5b03-20ff-d83f38496e61@gmail.com>
Date:   Sun, 6 May 2018 15:37:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1805061408150.77@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 06/05/2018 14:10, Johannes Schindelin wrote:
> 
> > > > > This builtin does not do a whole lot so far, apart from showing a
> > > > > usage that is oddly similar to that of `git tbdiff`. And for a
> > > > > good reason: the next commits will turn `branch-diff` into a
> > > > > full-blown replacement for `tbdiff`.
> > > >
> > > > One minor point about the name: will it become annoying as a tab
> > > > completion conflict with git-branch?
> > >
> > > I did mention this in the commit message of 18/18:
> > >
> > >     Without this patch, we would only complete the `branch-diff` part but
> > >     not the options and other arguments.
> > >
> > >     This of itself may already be slightly disruptive for well-trained
> > >     fingers that assume that `git bra<TAB>ori<TAB>mas<TAB>` would expand to
> > >     `git branch origin/master`, as we now no longer automatically append a
> > >     space after completing `git branch`: this is now ambiguous.
> > >
> > > > It feels really petty complaining about the name, but I just want
> > > > to raise the point, since it will never be easier to change than
> > > > right now.
> > >
> > > I do hear you. Especially since I hate `git cherry` every single
> > > time that I try to tab-complete `git cherry-pick`.
> > >
> > > > (And no, I don't really have another name in mind; I'm just
> > > > wondering if "subset" names like this might be a mild annoyance in
> > > > the long run).
> > >
> > > They totally are, and if you can come up with a better name, I am
> > > really interested in changing it before this hits `next`, even.
> >
> > I gave this just a quick glance so might be I`m missing something 
> > obvious or otherwise well-known here, bur why not `diff-branch` instead?
> 
> I think that is just turning the problem from `branch` to `diff`.
> 
> Of course, we have precedent with diff-index and diff-files. Except that
> they don't auto-complete (because they are low-level commands) and I
> *would* like the subcommand discussed in this here patch series to
> auto-complete.

Yeah, I did suspect it might be something like this (those other ones 
not auto-completing, where we do want it here), thanks for elaborating.

> I think Todd's idea to shift it from a full-blown builtin to a cmdmode
> of `branch` makes tons of sense.

I don`t know, I still find it a bit strange that in order to "diff 
something", you go to "something" and tell it to "diff itself" - not 
because it`s a weird concept (OOP, anyone? :]), but because we 
already have "diff" command that can accept different things, thus 
just teaching it to accept additional "something" (branch, in this 
case), seems more natural (to me) - "branch diff" being just another 
"diff" mode of operation.

What about that side thought you left out from my original message, 
making it `git diff --branch` instead?

But if "branch diff" is considered to be too special-cased mode of 
"diff" so that supporting it from `diff` itself would make it feel 
awkward in both usage and maintenance (in terms of many other regular 
`diff` specific options being unsupported), I guess I would understand 
having it outside `diff` altogether (and implemented as proposed `git 
branch --diff`, or something)... for the time being, at least :)

Regards, Buga
