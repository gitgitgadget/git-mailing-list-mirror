Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5DC9208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 17:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbdH1Rwx (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 13:52:53 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35846 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbdH1Rww (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 13:52:52 -0400
Received: by mail-yw0-f179.google.com with SMTP id h127so6099783ywf.3
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 10:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/dkjbDHe4OgF1gPXnsOEb1R3TFKSQD5DNIvyuPjaax8=;
        b=nh5Oyluyx6Y2mIP5exEwMVk98/HWq4Pg3NLVH/lM85MCtbvGmOMHISxnXqKcXiUp4/
         n2l5bmCC3fSsi2BXHv4PRupjClW2kJIT6aNxh6dCKStt263G005H63Tfdk9T2KgAv8TL
         8qio4r6z7qWrHUJqKo8DQQFN45fUu4v12A3jIMkk9NyIeeeC3HMQ+4hkPd00oLRvcP45
         JDXg4ZXIAOpmFN7H2L4mJrvZe7PwF9ifRpUqp78Btk86s90P/CoBNcd68hMEgzGS8Mq+
         LdLgK+rVbVb0kznZAZoc5F8ixcYII7xQ686+B9B+ljS0RdhPLQqBhZuDfQ5nU7cT6cfH
         I7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/dkjbDHe4OgF1gPXnsOEb1R3TFKSQD5DNIvyuPjaax8=;
        b=pywALjNJtUkK3FaBeVK8/dPrILemHN7JRi/BKSRnSImCIAaGVTCg+6bMC/a9lAYz2m
         W/NM/2K+kW/5CQ6Gx6a0xSoiKS3sQrOncrv8IXND3uN5oHZJILSq74+2VsufKkTQjMCt
         TFKwo8pupORI6tir2Bl9wnaQNryJf+Una2JmlzRhnbB+p3d6KOyaTvt2SJ/jkL9bls1M
         EiiJjwKe68VVpOBSfJiOtUl3dILW3qOw41HQjvCR0CN3Jx86cXUtiJVB9AWECT5Yb3mV
         OgoH3/GyW1SaoDBxSodeXKSzbJR4u51ExZWSDzkwQ6D8yp0UUgUJAZtLPl2/pGxyxPTW
         hkKA==
X-Gm-Message-State: AHYfb5gaDZ0oyZlDbuNjYU8KSp8BB24eMRVcmU9JXlulicBYbWM/anen
        M4MFiszJwvcyv/St68/qki0AYG2t7qNB
X-Google-Smtp-Source: ADKCNb5GsGAiHbboUvPdbzc0mNlFBSJS6x8w23AwfNTkFmxCTyZ2RZl9vG8BZNbVztVAdyxb7NfHctc8h2GUPyXblj4=
X-Received: by 10.129.109.214 with SMTP id i205mr1209646ywc.4.1503942771741;
 Mon, 28 Aug 2017 10:52:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.248.26 with HTTP; Mon, 28 Aug 2017 10:52:51 -0700 (PDT)
In-Reply-To: <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
References: <20170827073732.546-1-martin.agren@gmail.com> <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
 <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
 <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com> <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
 <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 28 Aug 2017 10:52:51 -0700
Message-ID: <CAGZ79ka3+T+TgakKDcHSmoc83mOdSDgoN=S=P5PtaYygo0nGWA@mail.gmail.com>
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> No mention of "pkt-line.c". Did you run Git with valgrind on one of
>>> your repositories to find it?
>>
>> I'm curious, too. I don't think the valgrind setup in our test suite is
>> great for finding leaks right now.
>

This discussion comes up every once in a while,
the last time I was involved in this discussion I proposed
to have an "optional_free(void *)", which only frees memory
in e.g. the developer build/debug build.

That way we can have a strict "no leaks in developer build"
policy (as it is easy to detect!), but it doesn't slow down the
widely distributed version of Git.

IIRC, then the discussion focused on "what if we misuse
optional_free and the real free", such that the widely distributed
version just leaks large amounts of memory and the developers
do not notice, but quite the opposite(!) the developers would feel
safe to ignore any memory complaints, because the developer build
is clean.

Stefan
