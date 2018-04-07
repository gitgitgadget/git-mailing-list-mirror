Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 160ED1F424
	for <e@80x24.org>; Sat,  7 Apr 2018 08:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbeDGIon (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 04:44:43 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42862 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeDGIom (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 04:44:42 -0400
Received: by mail-qt0-f195.google.com with SMTP id j3so3720242qtn.9
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 01:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+5h4w9iOaZrIh8P7O7L4c4p6tfmXxUJJSyS/8mOpIMo=;
        b=cTJNZwlfF1QB8vSfwqgscYZsxQqpKNFYWRf+8q5V+SEHXxP/Z+uO19wflv39s+bLsb
         752nYUtZd+4BqLCQY7+6EiNCbfOygtOwlpxFj/wybife41T9FZS2eKJkUbmyUGB1Tz4D
         FeKD0c5YZMt8gen2R3kK+uyM0bHaeZGNAzXkUDVLuCesBmIXYevP8qcUVqj+fWCQJe9F
         VJk78FVPNgcgkNAwppRMp56tZB4fW8aHEyfz1O/DQEUZR/8GL3uhOA3lrjWwxick9it8
         6dzHKyk0WnDWPh0q/xUazNd5aBtyQjCftOHKHT59HgV2X+BWKaAwaA7bja3LPX8Xd7fD
         LU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+5h4w9iOaZrIh8P7O7L4c4p6tfmXxUJJSyS/8mOpIMo=;
        b=Ii/LXiR5cfG4IoatTq9CA0pfGmz290Y6p8w5MVydD3jDLCFzqbLFIYplMU6o0MGEPt
         z61LVWV0veseJLN/suFrJdGv7WE/3tzMjbn7bSHS2PhQRuNFcuWIUdS8aw2yLh0gDCjO
         sDIO00d0WcQ//87Pkpb/mdMPLWhpMvaMNmB4Wfl7XBNfahcYI2p3vCnFH1EPVvq2lqnc
         /IfteW4g/cs/DXn1+nr+xGnEBJs2zL1rBcltBdvr3RRZ8o2YvGLQGgVQuRhdz/a93d1j
         7eqdkU9tlW9gmbbdaKqnG19Qp+SlVddEUQ2Iju2X/K2QqPdetXPpFXphfIXQa8Nt4jNG
         yJug==
X-Gm-Message-State: ALQs6tBT/rJ16kTFbzpdbAYcR16AmgmkXcJZtFaC7xrbEEfnCpZz85wP
        qtaFoc1aORV0dhPdTLqI19xtcKnarYgYUdEWsos=
X-Google-Smtp-Source: AIpwx49ZFY7ANrt88QEALtcJF3gdVAh15QCZXe1PDux2kwVsAgoKpvstLdgwE+hp8AlT+ulG3moBXSCuex/uG/GZffw=
X-Received: by 10.200.1.2 with SMTP id e2mr43001725qtg.121.1523090681584; Sat,
 07 Apr 2018 01:44:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 7 Apr 2018 01:44:41 -0700 (PDT)
In-Reply-To: <20180407005837.GD78042@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com> <cover.1522996150.git.me@ttaylorr.com>
 <20180406063013.GB662@syl.local> <CAPig+cRKaxECLHb1id6Mcd0O3uOiDzdGB4ZxPt1UpwUDi9Xb+g@mail.gmail.com>
 <CAPig+cRrz_Reb1CJN0u1LSQ38LjED+tuBAT=RT5rESfJ05absg@mail.gmail.com> <20180407005837.GD78042@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 7 Apr 2018 04:44:41 -0400
X-Google-Sender-Auth: 1YG49-jkwR1FHhqbRhBfn51qcTo
Message-ID: <CAPig+cSZPrnCuqZ0JG2hKqQEqYT6qYoGEzy4Une3GOo6hX_LCg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] builtin/config: introduce `--default`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 6, 2018 at 8:58 PM, Taylor Blau <me@ttaylorr.com> wrote:
> On Fri, Apr 06, 2018 at 03:40:56AM -0400, Eric Sunshine wrote:
>> On Fri, Apr 6, 2018 at 2:53 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> One other issue. If "git config --default ..." fails, the --unset line
>> will never be invoked, thus cleanup won't happen.
>>
>> To ensure cleanup, either use:
>>
>>     test_when_finished "git config --unset core.foo" &&
>>
>> earlier in the test (just after the --add line) or use the
>> test_config() function to both set the value and ensure its cleanup.
>
> Neat. I wasn't aware of 'test_when_finished'. I think that I prefer the
> explicitness of 'test_when_finished "git config ..."' over
> 'test_config()', but I am happy to use whichever is preferred. Since
> t1310 is new, there's no historical precedent to follow. Please let me
> know if you have a preference one way or another.

test_config() is preferred; not only is it shorter but, because it
automates cleanup, there's less opportunity to screw up (like
forgetting to use test_when_finished()).

However, since this config setting needs to be present for only a
single command, you can go even simpler by collapsing the entire test
to:

test_expect_success 'does not use --default when entry present' '
    echo bar >expect &&
    git -c core.foo=bar config --default baz core.foo >actual &&
    test_cmp expect actual
'
