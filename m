Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8D120288
	for <e@80x24.org>; Wed, 19 Jul 2017 14:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbdGSOKX (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 10:10:23 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37056 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbdGSOKW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 10:10:22 -0400
Received: by mail-wm0-f44.google.com with SMTP id g127so264632wmd.0
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 07:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=bMnDxT9fvyT7vdCUHwe71hzDrYPoy9DvgzMKbSh2eFc=;
        b=Tq7uttgJHgyTt4ZYAlMalhHk04Sx8W5cIpo/1kH2VnMI6EpkofFqhHpDguSQS9SCwi
         pCJ2tfo3mU0yizCTSo/0Au/czftA5v85Un/eHBWrOxFOKlFajDbHZYNBS5BJLtwFuqh8
         m6BXJhTT8LjhLeWAMvLlNWalH+e8u6754nGKY5M4bE5UCn5BSVGN4ylL7FkOA8BdogPN
         jqJ6nSGfeoTQKbDfSdg57pWDaHJJx+BF/1ISpgyF6+MaYMfKnpZFD+lR5BF/y8ZRPn1S
         gDA1MTPDvOWsb1ZCcwfmOdlwDBsYtT2FGPAqZ5owI1blhjslkM4F0/eDtSvqlrW8+o03
         axqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=bMnDxT9fvyT7vdCUHwe71hzDrYPoy9DvgzMKbSh2eFc=;
        b=hscwEAX/JyY8M5ANdMVhdwhKjucsJ6A7DTyhrR/JUBg4yCbMY+kr+lX/Jx0fCkA0Y9
         JNkg8ztrsj8Z5mNqOIyD0/y1s8+8NVct7Hpd40rMtNhNJh146lrfxMNCwfC3XpDxP47x
         f/014FDLfDAT8XmlRzX9SN5RKOgh7+0QjKYNc9iO/9vttvsSDYbL5Bms97OWKFT8dApJ
         XueAomcE8SPL8HxRI6udTJuLyGG2jd4C0k+lLrJX3JcusKUq8+saWslcr7nJku1LNKhd
         IzmVbNBSG7mzX1kcSM5XKLvfh9dBU0atyrB0HtGuDazObQxXR9nMY/pTFKObwKCv8Jn4
         60fw==
X-Gm-Message-State: AIVw1125gD17W8DPhGhe5JRfeRTM0iJN5z1+20+3imXy7XP4dFoJttqX
        gN9zGhLri3CYug==
X-Received: by 10.80.151.22 with SMTP id c22mr166849edb.30.1500472931575;
        Wed, 19 Jul 2017 07:02:11 -0700 (PDT)
Received: from snth (157-157-140-194.dsl.dynamic.simnet.is. [157.157.140.194])
        by smtp.gmail.com with ESMTPSA id z58sm64152edb.50.2017.07.19.07.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jul 2017 07:02:10 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dXpYG-0006C5-Ii; Wed, 19 Jul 2017 16:02:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: reftable [v2]: new ref storage format
References: <CAJo=hJtTp2eA3z9wW9cHo-nA7kK40vVThqh6inXpbCcqfdMP9g@mail.gmail.com> <xmqqlgnmhmep.fsf@gitster.mtv.corp.google.com> <CAJo=hJuP9GdudFsA_ToFQwx-zESaDHRDXHLxmvAXSX5CKmh7JQ@mail.gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAJo=hJuP9GdudFsA_ToFQwx-zESaDHRDXHLxmvAXSX5CKmh7JQ@mail.gmail.com>
Date:   Wed, 19 Jul 2017 16:02:08 +0200
Message-ID: <87k234tti7.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 18 2017, Shawn Pearce jotted:

> On Mon, Jul 17, 2017 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Shawn Pearce <spearce@spearce.org> writes:
>>> where `time_sec` is the update time in seconds since the epoch.  The
>>> `reverse_int32` function inverses the value so lexographical ordering
>>> the network byte order time sorts more recent records first:
>>>
>>>     reverse_int(int32 t) {
>>>       return 0xffffffff - t;
>>>     }
>>
>> Is 2038 an issue, or by that time we'd all be retired together with
>> this file format and it won't be our problem?
>
> Based on discussion with Michael Haggerty, this is now an 8 byte field
> storing microseconds since the epoch. We should be good through year
> 9999.

I think this should be s/microseconds/nanoseconds/, not because there's
some great need to get better resolution than nanoseconds, but because:

 a) We already have WIP code (bp/fsmonitor) that's storing 64 bit
    nanoseconds since the epoch, albeit for the index, not for refs.

 b) There are several filesystems that have nanosecond resolution now,
    and it's likely more will start using that.

Thus:

 x) If you use such a filesystem you'll lose time resolution with this
    ref backend v.s. storing them on disk, which isn't itself a big
    deal, but more importantly you lose 1=1 time mapping as you
    transition and convert between the two.

 y) Our own code will need to juggle second resolution epochs
    (traditional FSs, any 32bit epoch format), microseconds (this
    proposal), and nanoseconds (new FSs, bp/fsmonitor) internally in
    various places.

    Let's not make this harder than it needs to be and just settle on
    two epoch resolution formats if we can help it, and so far it looks
    like we can.

The downside is that instead of lasting through the year 9999 the 64 bit
nanosecond resolution is only good up until the year 2554, which I think
is an acceptable trade-off given the above.
