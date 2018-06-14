Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 624FF1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 15:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755234AbeFNPuT (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 11:50:19 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33315 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755072AbeFNPuS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 11:50:18 -0400
Received: by mail-wr0-f196.google.com with SMTP id k16-v6so6974614wro.0
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=r0P9YkluP/TQFs8fg25zNThH41W14WGynoTLjHLp53A=;
        b=vY2Nt5d7LqxOK8G7kRi2ii3Y0Ax6LAhYHbJ+GjKjIi67hAFLtH6c0p7LqPJtUHmtaK
         +4pw3fJ2YEJW7wx1ntmpCZ6TOMvdht4jqHdxm/MEYtBQK8Iq2DfL3jh/JiLavAp+Dv3R
         UNOFY3MWosEvrf93pbKk9j7W9/HpT249+KoxS+Qyo32HP5JCyATmlaDzK29/3heRfcGQ
         a3K53yZEceN6hVmnyGPu8CV1BDLFn3/CFHpZPkLxYQ0HZc7Qona5OmUvQGFYA4lZFbKt
         u6YqV29Wx5vaSY14v02Ca6OWz1O/bdsFz4CnP0miQtLMR6lLXQ8SAcQLJYpcWcXvPM7b
         JZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=r0P9YkluP/TQFs8fg25zNThH41W14WGynoTLjHLp53A=;
        b=CTjXDqMlRtwDWVJpfXspjFr6OAKfuGy62/yZ7qyvcfcI0AFGYHF7gL5iIlct/lrBJN
         CHJq63XBVQaqiUdaGRQ77ELiQOxWyNxKmShx4ZcTNm+UFsP5RqWgRqRQRNbEPT1sgJ/9
         vXLWdcW7Vl3TfJqC+ESbn5jJipSjsv3mTLdmAw+3XoM4WJvC6C83aKRpC78icUtAHkUZ
         JsHNnpxvObfFQxcdcTObhsc5cDk3zeSwf5XfuyEb72JXB447fiIhcX85TcgaTMls4jo0
         XEPT6btyQlzUUHD+0BbO6sk4TsI1ZLwMGBWDGbqaXPhPC/pOGZGo2OETbTBlru9NcVZK
         tyBg==
X-Gm-Message-State: APt69E0SpcFVRsP4qzFTthzxsm760I2UAbSiaSM/PHQqimns68zQXss5
        j6BfD9lCRMvm6jX6DnexPgs=
X-Google-Smtp-Source: ADUXVKJE3WU62QRV+Wayy9e24Myz6HSnJa3cmiqrilp/FUljpFClFJRtCxBuDpuwqDbKQI0CDvjwKA==
X-Received: by 2002:adf:c358:: with SMTP id e24-v6mr2738928wrg.257.1528991416863;
        Thu, 14 Jun 2018 08:50:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g11-v6sm6291900wrr.46.2018.06.14.08.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 08:50:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 19/20] abbrev: support relative abbrev values
References: <20180608224136.20220-1-avarab@gmail.com>
        <20180608224136.20220-20-avarab@gmail.com>
        <xmqqvaan95os.fsf@gitster-ct.c.googlers.com>
        <871sdawcmh.fsf@evledraar.gmail.com>
        <xmqqa7ry5n9h.fsf@gitster-ct.c.googlers.com>
        <87zhzxvmyv.fsf@evledraar.gmail.com>
Date:   Thu, 14 Jun 2018 08:50:15 -0700
In-Reply-To: <87zhzxvmyv.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 14 Jun 2018 09:36:24 +0200")
Message-ID: <xmqq602l5pvs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, Jun 13 2018, Junio C Hamano wrote:
>
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>>> E.g. here's a breakdown of my dotfiles repo:
>>>
>>>     $ git -c core.abbrev=4 log  --pretty=format:%h|perl -nE 'chomp;say length'|sort|uniq -c|sort -nr
>>>         784 4
>>>          59 5
>>>           7 6
>>>
>>> I don't have a single commit that needs 7 characters, yet that's our
>>> default. This is a sane trade-off for the kernel, but for something
>>> that's just a toy or something you're playing around with something
>>> shorter can make sense.
>>>
>>> SHA-1s aren't just written down, but also e.g. remembered in wetware
>>> short-term memory.
>>
>> That's a fine example of what I called "supporting absurdly small
>> absolute values like 4"; I still do not see why you want "negative
>> relative values" from that example.
>
> Because hardcoding -2 is very different than setting it to 5, because
> the -2 will scale to the size of the repository, but 5 is just 7-2 where
> 7 is our default value.
>
> So, in general if you want less future proof hashes by some
> probabilistic metric (whether you use core.validateAbbrev or not) you'd
> use -2 or -3, just like you might use +2 or +3 if you'd like to have
> more future-proof hashes (especially with core.validateAbbrev=true).

That still does not make much sense to me at all.

I do agree that something shorter than the default 7 may be more
appropriate for our wetware short-term memory, and it would make
sense to grow the "riskier to collide than the default heuristics
but more memorable" variant as the project grows, _ONLY_ _IF_ our
wetware short-term memory scales with the project we happen to be
working on.  But our wetware does not scale with the project we work
on; at least mine does not.

So...

