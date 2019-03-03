Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D75220248
	for <e@80x24.org>; Sun,  3 Mar 2019 10:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfCCKN1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 05:13:27 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:51003 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCCKN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 05:13:27 -0500
Received: by mail-it1-f173.google.com with SMTP id m137so3276876ita.0
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 02:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8whHE/TqcupmBs5KPZQNfDl2f77NhF04By6SzF3iGxY=;
        b=EOumzGwiDyMNhoSUEwmcRiBxCaYhw4upH3WTtZ6ZnMIQ1DnJoN44e26FjasO2XjXkd
         rQi2cpB9a2zxWaJIKzZclTNofa23lkqXOuQvlvIervdUoI2tmO833qFttEH00imFaFjd
         VVMF35l8zi9QgQE74FJHM6nrBObTNfEU/mEci4GwzApo7jU7faN8M4LTYq5yAo+YezCo
         jv4JVKgvmtbfKTMXo9bS8ZbzrneyGezgAuPetvcFuxOdJoz0zDKVpdheoFEQ44+iNYeJ
         H+QOBlUD0d16bJLBDxvu3Lud23u2j9XqMbWXVXDIzPvnhXLXk2kjbBsyI7TQYLn1MEOD
         Sq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8whHE/TqcupmBs5KPZQNfDl2f77NhF04By6SzF3iGxY=;
        b=QnE/rPXCqzDzfWABnGMFcaaz2HQA+hWrZJ1FREQb3cqtBkN+XmlGjmMPpGUF0ojxVv
         NDjCWnwvsB1RkurefPaGKQRAjV6aqb/n+z/GezjB46RpYvu1ajnTxywYWrn4HwV1gm5I
         oUjkjBtuQSgyc/MaPxHVLrJ4wcHtRs3bbAxv8uVnLLq1jmVKelNplgu5vmiSl/d+du8i
         QyK0dI32tT2kdGmp3RffZMsYemzPWze866+tJv1gxu35oEBMBpquB0IFQosW7gEisuHf
         eeoUF3jEqu8/2wejFioZrEt2LVjP71NeqOMqmmvSpZbwsBlGAacoEdG45voPOVDUeNfn
         kxZQ==
X-Gm-Message-State: APjAAAWykOHJU6rmCoFiKlHPyodGxV6uVj47JO/J1sd25ET1kPu4qlpb
        a7j4qHaKgaq2A5uL2WPE6J53SvtK3VO/JYB4fRA=
X-Google-Smtp-Source: AHgI3IauaQnUlwQBuGPBKL3G5fYe6KC7o5JJ3nWYUrm6g+5S1ks58eJBqUsUp9O8t4aBzYAh43r/Qxmab7PJSoI7e5E=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr6762500ita.10.1551608005967;
 Sun, 03 Mar 2019 02:13:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
 <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
 <20190302150900.GU6085@hank.intra.tgummerer.com> <CAP8UFD31YKt7fm+shWdBxsL4fCSO4dU=97YwFsZ9gZBpEWmRPQ@mail.gmail.com>
In-Reply-To: <CAP8UFD31YKt7fm+shWdBxsL4fCSO4dU=97YwFsZ9gZBpEWmRPQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 3 Mar 2019 17:12:59 +0700
Message-ID: <CACsJy8ATKdcDdbTzCdZFhChKEAWhjuYQJBpGXZ9HAVXK1r2pFw@mail.gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 3, 2019 at 2:18 PM Christian Couder
<christian.couder@gmail.com> wrote:
> One thing I am still worried about is if we are sure that adding
> parallelism is likely to get us a significant performance improvement
> or not. If the performance of this code is bounded by disk or memory
> access, then adding parallelism might not bring any benefit. (It could
> perhaps decrease performance if memory locality gets worse.) So I'd
> like some confirmation either by running some tests or by experienced
> Git developers that it is likely to be a win.

This is a good point. My guess is the pack access consists of two
parts: deflate zlib, resolve delta objects (which is just another form
of compression) and actual I/O. The former is CPU bound and may take
advantage of multiple cores. However, the cache we have kinda helps
reduce CPU work load already, so perhaps the actual gain is not that
much (or maybe we could just improve this cache to be more efficient).
I'm adding Jeff, maybe he has done some experiments on parallel pack
access, who knows.

The second good thing from parallel pack access is not about utilizing
processing power from multiple cores, but about _not_ blocking. I
think one example use case here is parallel checkout. While one thread
is blocked by pack access code for whatever reason, the others can
still continue doing other stuff (e.g. write the checked out file to
disk) or even access the pack again to check more things out.
-- 
Duy
