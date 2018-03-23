Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B0121F42D
	for <e@80x24.org>; Fri, 23 Mar 2018 07:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751504AbeCWHGU (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 03:06:20 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:38653 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbeCWHGS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 03:06:18 -0400
Received: by mail-ot0-f178.google.com with SMTP id 95-v6so12234691ote.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 00:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0rWrvjDAVBEWnSHhtdketd22DfJZvsJ6n1txMRJNGUE=;
        b=ARtS19Sm0JbXDbOwzKZJzSruHs9L2uNyxhwBtWFIKWhlRAKZIoK0hN1ZvYmA5e5vbZ
         CL4CsEUu1XGLUswOTu/tjURXSzEJ0bWMWtlY2GwfgiGCNdRWmdymFVEvCTmBHnfKQrL5
         kjCKx7MoAMFjw1soJuGVW2jdBltCQP4CZcojo1F4/gQbqsQdZ/YlVTORgFrX5BNBebb/
         QX6tPzS+B3JvPcfZwJ/rEmqq1cpQINiOTG3EXCoCuS/MRCzj6Daz+X7AJaJaswwPiHxH
         dcIldx+kWy6R0x0qIL0iCCROLXskVBTvms1qCJgWrUBboyojkx8s0I0XodJRmMKXPP8v
         6rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0rWrvjDAVBEWnSHhtdketd22DfJZvsJ6n1txMRJNGUE=;
        b=XmM/rOwVMw9W0v2WfBFbc25DGqiFAKJvfWadLHUeNwsnBx+qHyl5k2+ZX06TteekPx
         I57WwoGR3HfdXFfmHF8bIiQozmCejh1oiYz3jSKJZDbFpyePWMBscTeuS52q9sfEghgs
         MMXg7OrWpjFYgXBivsPg+X+E6cStrD47cuqOzNWq8TlKKeN1XUSvveJiF10PgPfJuta9
         1Pquy255GLUKERdCmUWKcVXbF4YYMukdPBRVmye1PiAAQC/X2kJws9FQcZG14VsORfK8
         3ZqHcvuJyOLuGLO7WdPgwFubTLCqr0G08WQlLYDbNdUJGCXThX0tVx2LTHyurJ7JDq9p
         gsMA==
X-Gm-Message-State: AElRT7GRwfc0kh/zy7abkD6IIFa/c8E65OAjV8GGXrWG6Qirz0iip0H7
        RC6IsnP8rDdwg7blNDXwpPzOxZIhW3PINFzApT4=
X-Google-Smtp-Source: AG47ELufRTNlRPd1w8mfQW6TOrdnT5xzompNbc0Kdrh8+7LThb5uD82twSdfas2M2rQVGJRoSoRpnEzA04p8nAvvzk4=
X-Received: by 2002:a9d:ae9:: with SMTP id 96-v6mr18814531otq.75.1521788778305;
 Fri, 23 Mar 2018 00:06:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Fri, 23 Mar 2018 00:05:47 -0700 (PDT)
In-Reply-To: <20180323024609.GA12229@sigill.intra.peff.net>
References: <20180317141033.21545-1-pclouds@gmail.com> <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net> <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
 <20180322093212.GB28907@sigill.intra.peff.net> <7a49135b-faad-9856-b757-e3ed4886720d@ramsayjones.plus.com>
 <20180323024609.GA12229@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 23 Mar 2018 08:05:47 +0100
Message-ID: <CACsJy8BGykZed6uWg0cEvndDA3iHFaMCGv8tGrk5H0WfeGbgGA@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 3:46 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 23, 2018 at 01:28:12AM +0000, Ramsay Jones wrote:
>
>> > Of the used heap after your patches:
>> >
>> >  - ~40% of that is from packlist_alloc()
>> >  - ~17% goes to "struct object"
>> >  - ~10% for the object.c hash table to store all the "struct object"
>> >  - ~7% goes to the delta cache
>> >  - ~7% goes to the pack revindex (actually, there's a duplicate 7%
>> >        there, too; I think our peak is when we're sorting the revindex
>> >        and have to keep two copies in memory at once)
>>
>> which begs the question, how much slower would it be if we
>> replaced the radix-sort with an in-place sort (e.g. heapsort).
>>
>> I hacked up the patch below, just for fun. I don't have any
>> large repos (or enough disk space) to do any meaningful perf
>> tests, but I did at least compile it and it passes the test-suite.
>> (That is no guarantee that I haven't introduced bugs, of course!)
>
> It might have been easier to just revert 8b8dfd5132 (pack-revindex:
> radix-sort the revindex, 2013-07-11). It even includes some performance
> numbers. :)
>
> In short, no, I don't think we want to go back to a comparison-sort. The
> radix sort back then was around 4 times faster for linux.git. And that
> was when there were half as many objects in the repository, so the radix
> sort should continue to improve as the repo size grows.
>
> The absolute time savings aren't huge for something as bulky as a
> repack, so it's less exciting in this context. But it's also not that
> much memory (7% of the peak here, but as I showed elsewhere, if we can
> stop holding all of the "struct object" memory once we're done with it,
> then this revindex stuff doesn't even factor into the peak).

We probably could do something about revindex after rev-list memory is
freed up too. revindex is used in two places (i'm ignoring
packfile.c): when we look for base objects in ofs-delta in
check_objects() and when we write a reused object. The first case
can't be helped, it's why we need revindex. The second case though is
just to get the compressed object size so we can copy the object.

If we cache the compressed size (like with uint32_t) then we can free
up revindex after check_objects() is done. Even if we repack
everything, this is still a very good saving (32 bits vs 128 bits per
object). The freed up memory could probably be used for delta cache.
But then if we hit a compressed object size larger than 4GB, revindex
must be recreated back, but we could detect this at check_objects
phase and keep revindex alivie.
-- 
Duy
