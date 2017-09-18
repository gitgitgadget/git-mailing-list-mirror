Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68FC72047F
	for <e@80x24.org>; Mon, 18 Sep 2017 18:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755741AbdIRSei (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 14:34:38 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:54685 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754300AbdIRSeh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 14:34:37 -0400
Received: by mail-wr0-f172.google.com with SMTP id g29so1241475wrg.11
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=10Xelbt+jUI2KsAiHOTYQFt83174fS/kBrcmMFwUl+c=;
        b=QTtaVKzrMlliLPqMnSk5JjwARBNhkVXJciIvGrSV5dK0beYdzfjmS2dTNHZjgo8KCb
         fhSn4+l1u17htSYP2lbbt7c1rmrTdgFmCO9K3DRMjB0fldkj7x+tLl604mIkQBuvbrdN
         xKsi8tDdFyIvwRPhOk9wj7fhw8tUH+wo73DxgCsTi8Us9/MIrC1LjYl6prNL4qXBtTeY
         MXyrXLgkazK5M24SPhsLucjPlwPLgOSRehl54qSz2OknqidqJ/KvLqs92f+7/CpdGW1x
         p96VbbBtdfjDQgX6yCvvmHLsFl1Y/6PYHwkscAcWmOWEy9gsGfznpUGOgF6nFyyMV6NR
         Brqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=10Xelbt+jUI2KsAiHOTYQFt83174fS/kBrcmMFwUl+c=;
        b=VdtV64v885PfTKRxkXUcFrZxRhQZPg/EFB6/1rJ3FyqvBEpesTdenzJg1okTFcma6o
         XCBpfOTk2NJSXn83bVis7Kno6B8fDngqZ3QAJL8rSi4WpdwF/gUztHYfXFYE54ZzPQER
         LghjxIUaqyzLQL9sxhskM2BEcoITyWyETgDW5qgu7g9/lqM0nrNCNCtpufLAC3rl8LM8
         kvYfZtAMfAHjMo+nsJENgC3ErGUVJW65ylQ5DOhOUbeDCU9pq6Vp4XWRec28AoZZqKJv
         YhYsvvZWOkK3CB+3p6bFtv5xDPmINLRXnLi7fvlDNp31v6vQi8qL0cnZWPYOU/7m9jE1
         nbTA==
X-Gm-Message-State: AHPjjUj3cqMcZy/6eqBJKUM3vZiBYMTxP8psPsh6iszKm2RZV+b1TDPL
        knHw6Y+gbZzyPrwmLTrNpXYcrbDTcAx3yERqE3yH2Im1UFY=
X-Google-Smtp-Source: ADKCNb49jgm8inDyAPV00X8nwiEqioKBdAtZnMOrP0RSM0VV3eOL1HPzYqAk7MS58JcOs317jK/D8iPVukcLGQD1YSw=
X-Received: by 10.223.182.10 with SMTP id f10mr27383933wre.38.1505759676520;
 Mon, 18 Sep 2017 11:34:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.170.68 with HTTP; Mon, 18 Sep 2017 11:34:35 -0700 (PDT)
In-Reply-To: <20170918170207.GF144331@google.com>
References: <20170913215448.84674-1-bmwill@google.com> <20170913215448.84674-3-bmwill@google.com>
 <CAGZ79kaeWsWdhoC7VDy-YkL1wVWqaQ9=TQUti9HfwjbT2poQdw@mail.gmail.com> <20170918170207.GF144331@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 18 Sep 2017 11:34:35 -0700
Message-ID: <CAGZ79kYQGguodnaiNfT_vWWDQdDdXwZmTi7JnqOmz+Po+FL1+Q@mail.gmail.com>
Subject: Re: [PATCH 2/8] protocol: introduce protocol extention mechanisms
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> From a users POV this may be frustrating as I would imagine that
>> people want to run
>>
>>   git config --global protocol.version 2
>>
>> to try it out and then realize that some of their hosts do not speak
>> 2, so they have to actually configure it per repo/remote.
>
> The point would be to be able to set this globally, not per-repo.  Even
> if a repo doesn't speak v2 then it should be able to gracefully degrade
> to v1 without the user having to do anything.  The reason why there is
> this escape hatch is if doing the protocol negotiation out of band
> causing issues with communicating with a server that it can be shut off.

In the current situation it is easy to assume that if v1 (and not v0)
is configured, that the users intent is "to try out v1 and fallback
gracefully to v0".

But this will change over time in the future!

Eventually people will have the desire to say:
"Use version N+1, but never version N", because N has
performance or security issues; the user might not want
to bother to try N or even actively want to be affirmed that
Git will never use version N.

In this future we need a mechanism, that either contains a
white list or black list of protocols. To keep it simple (I assume
there won't be many protocol versions), a single white list will do.

However transitioning from the currently proposed "try the new
configured thing and fallback to whatever" to "this is the exact list
of options that Git will try for you" will be hard, as we may break people
if we do not unconditionally fall back to v0.

That is why I propose to start with an explicit white list as then we
do not have to have a transition plan or otherwise work around the
issue. Also it doesn't hurt now to use

    git config --global protocol.version v1,v0

instead compared to the proposed configuration above.
(Even better yet, then people could play around with "v1 only"
and see how it falls apart on old servers)
