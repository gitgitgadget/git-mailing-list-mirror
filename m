Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD6D1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 16:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCUQRJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 12:17:09 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:40225 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbeCUQRI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 12:17:08 -0400
Received: by mail-wm0-f54.google.com with SMTP id t6so10908105wmt.5
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ZzCs1Wkxb/PZdvWGdlNGC2qW+TTLM6OvYT+gj/64XX4=;
        b=tPtrXDNCN67x5uq4w+X6EyIBP9WXzpUqrSy6F6QG+JAP25nG3MYn5NM6YYoSCoozBb
         q1fMZ2DbnINGPGWLNilRhgCZV59Dr81SH1nNBySH/PCLT4yXrnrpQt0Kd4NOOMC6K0A0
         zts1eHpkkeTXxZJukfqV87o/9yWxQJqfm/UjCqO0iTjfJpWTmifQS2wQx7SidKcpcGSg
         Spw+/NR/Kst41EeeNblFN4RpiUaoCtDOnrPl43jBMyyjBuGQ/cFWo/lZkUaCwrIE2zdy
         mCFCRhr1c8kTGLuo4rbtx0iQdbYUqxzVMZAy5o2F4fDiOBGVxorEEemWoWC4fP/VZTo0
         q93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ZzCs1Wkxb/PZdvWGdlNGC2qW+TTLM6OvYT+gj/64XX4=;
        b=RqBZMIG1/a2akXOilaCluFaa7/cY0HbBnu6rMvTHG8jv8lwXg5i+C8GMsxIdVvCG6F
         NcagB9HzAgt0xY+RXnMQnGqU9zPkOSLUyYFq9xwRlRQ/Zc6q+w8Owr5I7INujWVqi5Za
         YKcg5Isbkz1w/XiddAbK/vOwGOB6rfYTK8avdzB77lz/vEgDNx5zDli2uc4BGrlbxp/c
         VAeFkQZKsm1nX4Mf8nry6z9ne4BsVDP0pqLPAX8Se4eoy7Hr0LAthoN8VFC61t2wXy5Q
         26KZn1YRajh1H9GrW6nr7Tx8Fpc86Wn497gdxDsPvJP6GHv3vatEzOvt8OhIn9L/8TtL
         7k7g==
X-Gm-Message-State: AElRT7EH4xZkzlp25sJjzNRg0+ZaQrlsbOfqyQjydUWXuTq4Gx7gl2aV
        wSb3h+r1I9g0PLTWXSPWkvs=
X-Google-Smtp-Source: AG47ELumzO2PSn9glBjBviYlG3IpBzYt+h99Yd+EFuaNTtQ7ASTezzHlOa1g8oX0T8vRENZ6xt1CeQ==
X-Received: by 10.80.185.34 with SMTP id m31mr22350979ede.214.1521649026861;
        Wed, 21 Mar 2018 09:17:06 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id c36sm3453521edf.21.2018.03.21.09.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 09:17:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
References: <20180317141033.21545-1-pclouds@gmail.com> <20180318142526.9378-1-pclouds@gmail.com> <20180321082441.GB25537@sigill.intra.peff.net> <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
Date:   Wed, 21 Mar 2018 17:17:04 +0100
Message-ID: <87vadpxv27.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 21 2018, Duy Nguyen wrote:

> On Wed, Mar 21, 2018 at 9:24 AM, Jeff King <peff@peff.net> wrote:
>> On Sun, Mar 18, 2018 at 03:25:15PM +0100, Nguyễn Thái Ngọc Duy wrote:
>>
>>> v6 fixes the one optimization that I just couldn't get right, fixes
>>> two off-by-one error messages and a couple commit message update
>>> (biggest change is in 11/11 to record some numbers from AEvar)
>>
>> I was traveling during some of the earlier rounds, so I finally got a
>> chance to take a look at this.
>>
>> I hate to be a wet blanket, but am I the only one who is wondering
>> whether the tradeoffs is worth it? 8% memory reduction doesn't seem
>> mind-bogglingly good,
>
> AEvar measured RSS. If we count objects[] array alone, the saving is
> 40% (136 bytes per entry down to 80). Some is probably eaten up by
> mmap in rss.

Yeah, sorry about spreading that confusion.

>> and I'm concerned about two things:
>>
>>   1. The resulting code is harder to read and reason about (things like
>>      the DELTA() macros), and seems a lot more brittle (things like the
>>      new size_valid checks).
>>
>>   2. There are lots of new limits. Some of these are probably fine
>>      (e.g., the cacheable delta size), but things like the
>>      number-of-packs limit don't have very good user-facing behavior.
>>      Yes, having that many packs is insane, but that's going to be small
>>      consolation to somebody whose automated maintenance program now
>>      craps out at 16k packs, when it previously would have just worked
>>      to fix the situation.
>>
>> Saving 8% is nice, but the number of objects in linux.git grew over 12%
>> in the last year. So you've bought yourself 8 months before the problem
>> is back. Is it worth making these changes that we'll have to deal with
>> for many years to buy 8 months of memory savings?
>
> Well, with 40% it buys us a couple more months. The object growth
> affects rev-list --all too so the actual "good months" is probably not
> super far from 8 months.
>
> Is it worth saving? I don't know. I raised the readability point from
> the very first patch and if people believe it makes it much harder to
> read, then no it's not worth it.
>
> While pack-objects is simple from the functionality point of view, it
> has received lots of optimizations and to me is quite fragile.
> Readability does count in this code. Fortunately it still looks quite
> ok to me with this series applied (but then it's subjective)
>
> About the 16k limit (and some other limits as well), I'm making these
> patches with the assumption that large scale deployment probably will
> go with custom builds anyway. Adjusting the limits back should be
> quite easy while we can still provide reasonable defaults for most
> people.
>
>> I think ultimately to work on low-memory machines we'll need a
>> fundamentally different approach that scales with the objects since the
>> last pack, and not with the complete history.
>
> Absolutely. Which is covered in a separate "gc --auto" series. Some
> memory reduction here may be still nice to have though. Even on beefy
> machine, memory can still be reused somewhere other than wasted in
> unused bits.

FWIW I've been running a combination of these two at work (also keeping
the big pack), and they've had a sizable impact on packing our monorepo,
on one of our dev boxes on a real-world checkout with a combo of the
"base" pack and other packs + loose objects, as measured by
/usr/bin/time

 * Reduction in user time by 37%
 * Reduction in system time by 84%
 * Reduction in RSS by 61%
 * Reduction in page faults by 58% & 94% (time(1) reports two different numbers)
 * Reduction in the I of I/O by 58%
 * Reduction in the O of I/O by 94%
