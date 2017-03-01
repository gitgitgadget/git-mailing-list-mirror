Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72F4B2023D
	for <e@80x24.org>; Wed,  1 Mar 2017 17:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbdCARYe (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 12:24:34 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35911 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbdCARYa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 12:24:30 -0500
Received: by mail-pg0-f67.google.com with SMTP id 25so6488689pgy.3
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 09:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IspLNlLsIYXCNGFU0Wal/gMybclTHUbXqO69V59T1GE=;
        b=WKqGFctI/a/UQH1L9hil639F5JyIyg/PcyG9GKPv9PTntMoh8MAgU4/AgxA94FMZJK
         5tdkdHFRxiOQBinBzwCYY//AEJEkWEOw5SGe3d6kW6hIVfV4tyMuQvM3c1B6qDEZ2pJW
         g4hyTH7GGmJvXQe7otVfTpKDJRFVm8+IIYmHSMwF0mrs3w2YH5/rxvVLxfFBuE842fyD
         NcNEW6Hx8QeuLvph0qZlYhdMEcNC8srsGtm9aU0eQcyHXBHphkJb7LuCkCAVs8ySOhxU
         zBNPmXoWj26Ypbt1omd9HdxNWnYTb6pFEQ+dpimNouzRv/UVrxJ080SwbOvzsDOMSORA
         qxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IspLNlLsIYXCNGFU0Wal/gMybclTHUbXqO69V59T1GE=;
        b=ryqxDDpJFZgiLpEKlyX0qZ7s25M5y8BFnfAS1RGItxHH4ezm9TQFVuQVL5CnubBnFK
         z/FepBtIYNMUHfReMSV9T/LxYdX/WSn/jKHwVV8mX0Tnwo/aLQ1Ytoam6WDA93d/O1km
         In+sqdNIDNezDVIZXlUEW2ioWSRsmiE5VGs+HOsvrNPGOakzE/4uuojfCBbbmus7ZoYL
         GZQfgY5bKDiXpfuIr/nKm3VFKMgMOf7H4/u6/QuNFpTuOxAPegewxLP2MdW4cXMTP2lP
         5pqdrX3J6fiq0DH/Xwk3e7uGBXbh3zE4u37Gr1OmSFEotOWVqhg8xjfVrz4Kv+EVNxO5
         /npQ==
X-Gm-Message-State: AMke39kHuY39kproHFTt8RPOQqme3r/TfnnLqHWhU5d8yIyo37Km1qqynEQQ6ROkHR3+lg==
X-Received: by 10.99.188.10 with SMTP id q10mr9985425pge.106.1488389033477;
        Wed, 01 Mar 2017 09:23:53 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:dd87:32f4:da52:1d3d])
        by smtp.gmail.com with ESMTPSA id l3sm11868142pgn.10.2017.03.01.09.23.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 09:23:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] Use time_t
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
        <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net>
        <xmqqvarukz0g.fsf@gitster.mtv.corp.google.com>
        <20170228200145.ymbqmxwrbbrwagks@sigill.intra.peff.net>
        <xmqqh93ehrxx.fsf@gitster.mtv.corp.google.com>
        <20170228223325.vabdrwas2qn52gup@sigill.intra.peff.net>
Date:   Wed, 01 Mar 2017 09:23:52 -0800
In-Reply-To: <20170228223325.vabdrwas2qn52gup@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 28 Feb 2017 17:33:25 -0500")
Message-ID: <xmqq1sugj4gn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Feb 28, 2017 at 02:27:22PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > ... We can certainly stick with it for now (it's awkward if you
>> > really do have an entry on Jan 1 1970, but other than that it's an OK
>> > marker). I agree that the most negatively value is probably a saner
>> > choice, but we can switch to it after the dust settles.
>> 
>> I was trying to suggest that we should strive to switch to the most
>> negative or whatever the most implausible value in the new range
>> (and leave it as a possible bug to be fixed if we missed a place
>> that still used "0 is impossible") while doing the ulong to time_t
>> (or timestamp_t that is i64).  
>> 
>> "safer in the short term" wasn't meant to be "let's not spend time
>> to do quality work".  As long as we are switching, we should follow
>> it through.
>
> Sure, I'd be much happier to see it done now. I just didn't want to pile
> on the requirements to the point that step 1 doesn't get done.

Ah, that was what you meant.

I was assuming that we are switching to a longer _signed_ type.  It
felt silly to tell users "you can use timestamps before the epoch
now with this change, but you cannot express time exactly at the
epoch".

I am perfectly OK with switching to a longer _unsigned_ type with
the "0 is impossible" [*1*] intact, aka "safer in the short term",
if we want to it make our first step.  That may be a smaller step,
but still a step in the right direction.


[Footnote]

*1* It could be "-1 is impossible", I didn't actually check.
    Funnily enough, ISO C99 uses (time_t)(-1) to signal an error
    when returning value from mktime() and time().

