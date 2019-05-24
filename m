Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407641F462
	for <e@80x24.org>; Fri, 24 May 2019 09:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390013AbfEXJzc (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 05:55:32 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55054 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389911AbfEXJzc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 05:55:32 -0400
Received: by mail-it1-f193.google.com with SMTP id h20so14760637itk.4
        for <git@vger.kernel.org>; Fri, 24 May 2019 02:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xwp5Btmykf5Ykaey2k90ssKQ8hSlJImFPR1/yY0upiM=;
        b=a9pnWC5jChwX+jB82vQ5juA9lPD5b3eti3nrxFeRzDbBaX4d3kcgPPLMTFlw2V7/Yj
         tGaIsm5PqkUE0/hc4Q87SVXTSzy95PKAl3ZRqDIgn5R9i9N6yTF0K3ffa/Bn9Hh8OKrZ
         7EZVevOW3IoZE10Rg/lgWIRy2r0U/ZQb2CjY7VAsnhg7BYGX3T0hH49RuKPNuTYN4y4g
         BPT+GC8uVksyF/u+/WV2KdF7rETbDE3MeEdddXtO1dMGLxLuiQhqqngiahipaeLi0/90
         neouuBi59fd+lrjHnfBpjANU0TZIsFFaczsiVuwDbMBXx/4FQliOnIx2Qyo8UjrlZNm9
         PJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xwp5Btmykf5Ykaey2k90ssKQ8hSlJImFPR1/yY0upiM=;
        b=gl0R3DJiMcCrLSyPCWWTC3mjIaSdaEy02+lA2Q0Sfc9pr5529TSF2B4VBr7UiA6KoC
         IhhTcpNRvuYObm5KZOqE1qmYW8sP7wzTXXzfu+p0C096mkYB2y4M5TfZ10emilme2I8v
         zfIOJiv7I1uLHrxceFPcfDABmovT3HMQsUQslxEWl4tZ4hBkhR04jzWMXpItXVf3g9/R
         megkZEK3TpyrfE6m19w1qbfzilS2/cllaryyuV/PL+Iq3r2Aydgg2AYdM9cy//hvBu3m
         m3zKzVn/UzXV9o2sKpup6uQbZXFTvMXGpiNP9YMpxGvsL17UE2JUS8Rh/KKAm/0n1r7n
         b48Q==
X-Gm-Message-State: APjAAAXFW4zDDR4G8535moXCCzBOeugcNs3bJmhq+k4SKBb00WU/qmRp
        5i2rGY61cu4gggTX0sjudPN7sYH7qTY4cCe68Bc=
X-Google-Smtp-Source: APXvYqxK0eO5/rskEaa2h+6ddAaK2+QQWzCCtAS3zsHSwaXDRmNibKs5fICKJ0oGXe9fDEyxVSG4FWC+NwxjxNrttbQ=
X-Received: by 2002:a24:47cc:: with SMTP id t195mr16250263itb.117.1558691731246;
 Fri, 24 May 2019 02:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW40x3-4rye3QeVGix5pfTCoCHmiwg8ddCeq1E6YYongag@mail.gmail.com>
In-Reply-To: <CAHd-oW40x3-4rye3QeVGix5pfTCoCHmiwg8ddCeq1E6YYongag@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 24 May 2019 16:55:04 +0700
Message-ID: <CACsJy8DFw1Y_bhE=k2ZEMTk+vFvwwmx4GDnRXEQB9cp58M3vLg@mail.gmail.com>
Subject: Re: [GSoC] How to protect cached_objects
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 23, 2019 at 11:51 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>

> Hi, everyone
>
> As one of my first tasks in GSoC, I'm looking to protect the global
> states at sha1-file.c for future parallelizations. Currently, I'm
> analyzing how to deal with the cached_objects array, which is a small
> set of in-memory objects that read_object_file() is able to return
> although they don't really exist on disk. The only current user of
> this set is git-blame, which adds a fake commit containing
> non-committed changes.
>
> As it is now, if we start parallelizing blame, cached_objects won't be
> a problem since it is written to only once, at the beginning, and read
> from a couple times latter, with no possible race conditions.
>
> But should we make these operations thread safe for future uses that
> could involve potential parallel writes and reads too?
>
> If so, we have two options:
> - Make the array thread local, which would oblige us to replicate data, or
> - Protect it with locks, which could impact the sequential
> performance. We could have a macro here, to skip looking on
> single-threaded use cases. But we don't know, a priori, the number of
> threads that would want to use the pack access code.
>
> Any thought on this?

I would go with "that's the problem of the future me". I'll go with a
simple global (I mean per-object store) mutex. After we have a
complete picture how many locks we need, and can run some tests to see
the amount of lock contention we have (or even cache missess if we
have so many locks), then we can start thinking of an optimal
strategy.

I mean, this is an implementation detail and can't affect object
access API right? That gives us some breathing room to change stuff
without preparing for something that we don't need right now (like
multiple cached_objects writers)


> Thanks,
> Matheus Tavares



-- 
Duy
