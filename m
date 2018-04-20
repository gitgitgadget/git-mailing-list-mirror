Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD6C1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 19:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeDTTbN (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 15:31:13 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39017 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeDTTbM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 15:31:12 -0400
Received: by mail-qk0-f194.google.com with SMTP id i73so9795107qke.6
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PS0RdBOC6IGrVRSM62p+RDEaJO/+390cEvAoktQDGE4=;
        b=EYqWRMHOh0dDQCq3eZzh2+O1O0WcwHCsI/+UwgA/PlDi3fEhyG4TEglX8e7aznfQP6
         /Nwxoj7Vv+SglHJvbvbDQ6rky/2SmwRJALN5dh3+OQ0wgzUEbJMHxTxlbeBjkK99sRed
         hREfDvCxdVulint00ivUxPFvSRiHb477Vd0U+431m6Nci99ggpgsFgiWxoMjPOTX7wsO
         pRG/CDsbMC/kmHdbuPM5qRGK0L3fOkGHikdVD8ibX7viBYBGtkw7oomR2m35mapr6W50
         IqWhJjxvhWaLPK85oxwYdHLi1d5v8BRCjmF691CsiZBLO+omxRbIUW2O1egf4116/Gq5
         ZnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PS0RdBOC6IGrVRSM62p+RDEaJO/+390cEvAoktQDGE4=;
        b=I+5zP3vLi6lebPaRqxAL4eZp7dVMCE0Z1bdQ40glnnkGhrZYUO+uM6awyeUAPJoil3
         1a8s4eP7sy5GtAYAW0drieJ10KfnjL9AvipVeJ9ZO8kGRQdqQ4mUaYvnfF0otV7vh1Al
         ySNyb9enW2BkeSBpkgsz/4a1uUq/Pjo7iMwixfdWcxirXqS9RNPyHeO5DFAkoUodSxr4
         5VoLkdBGWO5GzBNF2h+ngk3sa6Sq4MrxaJLcRmZYZXl0HqA8YanDmJK5SboxoVpPlpKK
         a7PIL3jo7knPS4Z4Sd3oGCKZL00l53JZnuxfuSl45zBBR9AlovicTGuJO0tst1wwRCtE
         pv0A==
X-Gm-Message-State: ALQs6tDSgHIYTlCAjYYoUcxSIQ2nRnGPL3WSWCfz1i9lTrLsPl3amr2z
        PvZpv/CQKJihSFDNIJv6Y5kM32+fjWYoi8Ofk1Y=
X-Google-Smtp-Source: AB8JxZor6hdGRkyeLSrN+I1WiZKK9Wo5hqEK/Ma2c2nu/Ju6GdltY7IycvgZBLe9C14mzW/05CSC9R7m/lpJsRBf0cM=
X-Received: by 10.55.79.9 with SMTP id d9mr11872776qkb.2.1524252672100; Fri,
 20 Apr 2018 12:31:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 20 Apr 2018 12:31:11 -0700 (PDT)
In-Reply-To: <CAPig+cSb33EG2nATjCem4-2dp87SKOXm_SCWU=fCXJCBRZzgeg@mail.gmail.com>
References: <cover.1524226637.git.johannes.schindelin@gmx.de>
 <ad2a1b2c60341d692e94b1cb997df05dd7cded88.1524226637.git.johannes.schindelin@gmx.de>
 <CAPig+cSb33EG2nATjCem4-2dp87SKOXm_SCWU=fCXJCBRZzgeg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Apr 2018 15:31:11 -0400
X-Google-Sender-Auth: 4VRTvOujRd3NZopdJVT0NVyJGCQ
Message-ID: <CAPig+cRO2+NJ0-DiuHXA=mWjPnivqH3PiwM9R6OGj2Rr3eLauA@mail.gmail.com>
Subject: Re: [PATCH 1/3] rebase -i: demonstrate bug with fixup!/squash! commit messages
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 20, 2018 at 3:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Apr 20, 2018 at 8:17 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> +       test_must_fail env FAKE_LINES="1 fixup 2 fixup 4" \
>> +               git rebase -i HEAD~4 &&
>> +
>> +       : now there is a conflict, and comments in the commit message &&
>> +       git show HEAD >out &&
>> +       grep "This is a combination of" out &&
>> +
>> +       : skip and continue &&
>> +       git rebase --skip &&
>
> I see that this test script doesn't utilize it, but do you want a
>
>     test_when_finished "reset_rebase" &&
>
> before starting the rebase to clean up in case something before "git
> rebase --skip" fails?

Stated less ambiguously:

    ... in case something fails between "git rebase -i ..."
    and "git rebase --skip"?
