Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 145FD201B0
	for <e@80x24.org>; Mon, 27 Feb 2017 09:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbdB0J5q (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 04:57:46 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:36017 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbdB0J5k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 04:57:40 -0500
Received: by mail-io0-f172.google.com with SMTP id l7so15041260ioe.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 01:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=mtiWUK6SCQdsWvIJaw9APuA/KQKbF0SbZyAHF7KC4ks=;
        b=EoVv/5AhPteAskZUmB2xowrU6g6lrXI4LQz2x3706Cbj0IKkajk4Ym8LI1ffmEQqDb
         414Jr2XyWBLPBKncZRvkY1w+c8MClEPuQmpw2vVQH0Fo2bQk1c3IABayRlTpUkQiQgLp
         5C/qlVpWpFn7vgch8FuTYsK01p43E3Rla7ADM1AnoP3MGObmE6Yn2VpYVo4mjRZyLU0a
         kDownJa+AcJ8y8hrnbWMI/u3IB0NVjXPvB5F5fu8NVUBEryHIB/dIpr13/hFot1ecELN
         dPwk5Fsw5UTxWAOHRBAipW9BHW7MKLLaWi95kfeRLCsYoYfjKMdQ/WLOO/JClIneJ/Ov
         sEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=mtiWUK6SCQdsWvIJaw9APuA/KQKbF0SbZyAHF7KC4ks=;
        b=C/x4FI+tV4ufy/SitAYT04pDsp259ChGnxz/hII+32SzxbbEr1mgorzi0Im03een17
         k9rhw5aRRDYyZ+eix4d77Xf5AotgeWCFxkdjw6RxTnE1NQYpRFws9L4UgYyhtB5k2z51
         gcw+ae1/J8ke2GpRbRV9s7sqXvnMF5m70vOueRXWsXbgeAX2raDE5RH2R3PxQTY/pLP+
         izq9oRIWAGqVntTysxM92C99PDOE4PymCuBHQxYE6aZ6d81KVLoIXiLd9NRjjKvr88Yt
         puohN+m9jNkHKan4NYp/Wi9B3Zu50jBKnbFYX17om57pTZ+vjlbZ2+/1JM9AibCgUeRw
         +ZNg==
X-Gm-Message-State: AMke39mdZuRVURKd2Ls5bViax3KeV5Al5eAgrjHV5IkbRwFNS5Txbd6JdCWm4Bh1vow4l2Qkcf/5f7LtoL58aA==
X-Received: by 10.107.189.197 with SMTP id n188mr15569906iof.88.1488189459338;
 Mon, 27 Feb 2017 01:57:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.137.65 with HTTP; Mon, 27 Feb 2017 01:57:37 -0800 (PST)
In-Reply-To: <20170226213042.rd55ykgymmr37c7n@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <9cedbfa5-4095-15d8-639c-0e3b9b98d6b9@gmail.com>
 <20170224230604.nt37uw5y3uehukfd@sigill.intra.peff.net> <8e98a9f9-a431-9170-df9d-24ad8ec59ed7@virtuell-zuhause.de>
 <20170226213042.rd55ykgymmr37c7n@sigill.intra.peff.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Feb 2017 10:57:37 +0100
X-Google-Sender-Auth: kTyBvQnn7pD3YWfSDs3FP1GVKso
Message-ID: <CAMuHMdXZ2ZPsFbPUgmvx8=-xj3GBNBJwLaGAYj+R=Z2zDQJ+hQ@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Jeff King <peff@peff.net>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 26, 2017 at 10:30 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Feb 26, 2017 at 07:57:19PM +0100, Thomas Braun wrote:
>> While reading about the subject I came across [1]. The author reduced
>> the hash size to 4bits and then played around with git.
>>
>> Diff taken from the posting (not my code)
>> --- git-2.7.0~rc0+next.20151210.orig/block-sha1/sha1.c
>> +++ git-2.7.0~rc0+next.20151210/block-sha1/sha1.c
>> @@ -246,6 +246,8 @@ void blk_SHA1_Final(unsigned char hashou
>>     blk_SHA1_Update(ctx, padlen, 8);
>>
>>     /* Output hash */
>> -   for (i = 0; i < 5; i++)
>> -       put_be32(hashout + i * 4, ctx->H[i]);
>> +   for (i = 0; i < 1; i++)
>> +       put_be32(hashout + i * 4, (ctx->H[i] & 0xf000000));
>> +   for (i = 1; i < 5; i++)
>> +       put_be32(hashout + i * 4, 0);
>>  }
>
> Yeah, that is a lot more flexible for experimenting. Though I'd think
> you'd probably want more than 4 bits just to avoid accidental
> collisions. Something like 24 bits gives you some breathing space (you'd
> expect a random collision after 4096 objects), but it's still easy to
> do a preimage attack if you need to.

Just shortening the hash causes lots of collisions between objects of
different types. While it's valuable to test git behavior for those cases, you
probably want some way to explicitly test collisions that do not change
the object type, as they're not trivial to detect.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
