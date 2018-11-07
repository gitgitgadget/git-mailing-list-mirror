Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDEC81F453
	for <e@80x24.org>; Wed,  7 Nov 2018 22:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeKHIZQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 03:25:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42612 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeKHIZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 03:25:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id y15-v6so19148144wru.9
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 14:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ckH9X5DktrmUkLVX7ZUw2TWbWP/r4Za1DetIv3Q7DMc=;
        b=lZTg23Z03VnIlcZRE7JEfoiHYLXUDj5oaBt7VRYP9PLVYU1VAvfX1A20VhakEOt1fY
         +fHTOBZdVSKm8SjjCoIffQYXBFks4hxK50ro/EAUkQuBkW6iUGHKRsB4aiAOCDVL8Gxk
         8SOfiE6JuDJkfXAcEr2hvxNahpvkwmZ6p0lRBv2tPd38XNEQZj9Q0KIWIJB2bBIaFzHK
         vepaBZli06hm7Z8h5ouYQ4viOIUhHHJqavV6q5GM31gqpIUBemdQo2KDaTfScS9isazS
         +yJ6lQC+OC/IH4xzzoPShnGKSeNRDI3k347Apak26I82thReO/o0YpFyt++LOOI2zk2Y
         fwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ckH9X5DktrmUkLVX7ZUw2TWbWP/r4Za1DetIv3Q7DMc=;
        b=Tm8mDgPSbVSRhJtSHajcirWKcFmw4N6B9f92/eXvwDcljYj5Ttz5brSeue+b60CKls
         Wt/jkTZrcGT4Ndk4+UVuigs5WaAVodAVYrviZASBJXwTiDN8udIvHvIlPyA1Tyd+6BH4
         9lO3DzrWDSgwz/rFYahiv8psgBcVDbzcV0/b6RmDzkTPgvhVJoX5wYzcIC3eu73v13vx
         L0u6BigukVwbrBOiWXN+Nx+SIy9yAowrTzriISg566Ba81KtsX2BJvtByQMNxBUwrs1v
         OFvKHQljoCcGmDuUa/PgzoKS8sOhW1dpnXG+OikiB/ftFtMBXo46T4wCaXE8z92pY5n5
         hbRA==
X-Gm-Message-State: AGRZ1gJp8k85/wanNzp8xTIWisj+tftRCr2OZy5/Guc0d0rgpU6rsaVR
        /SUPL3RP7opTrg1Cgs2i2oY=
X-Google-Smtp-Source: AJdET5cpXAEpTYZ4pRnK6xw4o4XLq8C0QzCwDmy3+XxfXg0GFot7j39TTWB3FlVdkzsanzdMUevXLQ==
X-Received: by 2002:adf:fc0c:: with SMTP id i12-v6mr1906445wrr.145.1541631162288;
        Wed, 07 Nov 2018 14:52:42 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u8-v6sm2108750wrr.33.2018.11.07.14.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 14:52:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen & Linda Smith <ischis2@cox.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] range-diff doc: add a section about output stability
References: <nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet>
        <20181107122202.1813-2-avarab@gmail.com>
        <2504086.hWFjgDPvVf@thunderbird>
Date:   Thu, 08 Nov 2018 07:52:38 +0900
In-Reply-To: <2504086.hWFjgDPvVf@thunderbird> (Stephen & Linda Smith's message
        of "Wed, 07 Nov 2018 06:10:52 -0700")
Message-ID: <xmqqlg64bivd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen & Linda Smith <ischis2@cox.net> writes:

>> +This is particularly true when passing in diff options. Currently some
>> +options like `--stat` can as an emergent effect produce output that's
>
> "`--stat` can as an emergent": I read that for times to decided it was correct 
> grammar.   Should it be reworded to read better?   Just a nit.

A pair of comma around "as an ... effect" would make it a bit more
readable.  It also took me four reads before I convinced myself that
the original wants to say "Some options may just do whatever they
happen to do that result in pretty useless output".

>
>> +quite useless in the context of `range-diff`. Future versions of
>> +`range-diff` may learn to interpret such options in a manner specifc
>> +to `range-diff` (e.g. for `--stat` summarizing how the diffstat
>> +changed).
