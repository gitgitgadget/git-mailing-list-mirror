Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D40CE1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeDPWaX (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:30:23 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:37905 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbeDPWaX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:30:23 -0400
Received: by mail-io0-f171.google.com with SMTP id h9so6436840iob.5
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SWi2+gtXyUu0Qk48xsW7kBBmzxVY9AHHMdR3rMgXdiQ=;
        b=d8ea9Q/mngkg1vvSozrsU17qMGgkjoE2wvXXoTO+jbxEfKesnZmHk24N705wp5rx5R
         M573vn7Kj/fCUk/qMSIWaipT8YUuf68h2eu55KkjcE7vEU6ajeXD+OJGX/yc3Xq4dFxb
         o6wCGmrfM/4wjZygPVHcNuUQBa7TkgIiFBfmJhzJOTvHOq9BBlTVo1WBSpdZc2Abnv9/
         gQsy9AhHchjo6bUCjjqiZ0cklLj84BeEIWlMlcNw1fE3zMIpK5rp7+gMKeNKVq+MODi7
         xoGJj6qRIRztiHPMgdvDiEiAAkcCt5Kn4Kb7a3kX1v1Hmg8xAx8+Ss0t0QWKMYfwgXv+
         5CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SWi2+gtXyUu0Qk48xsW7kBBmzxVY9AHHMdR3rMgXdiQ=;
        b=Fk1wiho7HAqhr/a6716BQgFSDAW8xu2zkfzYvGQ05HwLDzfjiURv4v9kIy5k15nH+T
         QKlIja6yqZM632sH5t/QT985RisogrpFuG1iGmB5hSmRQdCt3aeeM+ym6QOY0R7IgsWT
         RGGqNpwGmHud+tZrXud1SdKFgoEog/9St1scbwmVB0A5KdeoUdifYwh6Wer65tug/gyw
         ckhXMEpvgtC2Ki50T6O6jhw5LC13Km+K89lQ6INeodi+yEXoPyA8u52+zAVOQTQ9RuyY
         A7kL0nj2CyBnmJeiEpz1EvViFSV3u+WTnCZmc/fJgcmE69BhyMV8mVQDhnZffSQv0sl/
         CqcA==
X-Gm-Message-State: ALQs6tB79z0s/b5WL3/f/XOIX5aCARpeXorrUPzAefOX/MoFdKwBM6GH
        PFH4s3zVyRIS9ZN4Ls4MfoD/tuE8jqwYa5jMbBA=
X-Google-Smtp-Source: AIpwx4+UNk3f7cNygYk2Xmks1fb0vqU8zZCseCEs6uE7ZpJXLmOuXCL6f4NRrYCGUl3snsjTksQgJS0IrfJPZ/jrZ5U=
X-Received: by 10.107.192.2 with SMTP id q2mr11953872iof.53.1523917822220;
 Mon, 16 Apr 2018 15:30:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.219 with HTTP; Mon, 16 Apr 2018 15:30:21 -0700 (PDT)
In-Reply-To: <87efjf6uwg.fsf@javad.com>
References: <CAP8UFD0DagacfeismKoVgo=O1guRUV=u1=EbbwRyrY3g1MeQ8Q@mail.gmail.com>
 <CAP8UFD1vFM8k-1Po=2QXZdBOuCca1Dg_FGaPnSi85hKp1je54w@mail.gmail.com>
 <87in8rz65t.fsf@javad.com> <CAP8UFD3JwHfyr=bByvjDrxboFL+yHVdZnbkXztsUuOU0aRD-9w@mail.gmail.com>
 <87sh7v6vn4.fsf@javad.com> <72f42205-c9c6-03aa-e8df-12e7062e8e62@gmail.com> <87efjf6uwg.fsf@javad.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 17 Apr 2018 00:30:21 +0200
Message-ID: <CAP8UFD3ei7NEfiqBbWe_PKdrcW93t2pA=u-ub29X+jGOi9-Jwg@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 38
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 5:19 PM, Sergey Organov <sorganov@gmail.com> wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
>
>> 1. I see the following sentence in the "Rebasing merges: a jorney to the
>> ultimate solution (Road Clear) (written by Jacob Keller)" article
>>
>>       "A few examples were tried, but it was proven that the original
>>       concept did not work, as dropped commits could end up being
>>       replaid into the merge commits, turning them into "evil"
>>       merges."
>>
>> I'm not sure if 'replaid' is proper English assuming the past tense of
>> replay was intended there (which I think is 'replayed').
>
> It could have meant, say, "reapplied", -- we need to ask the author.

Yeah it could but I would say that it is not very likely compared to
"replayed", so I changed it to "replayed". And yeah I can change it to
something else if Jake (who is Cc'ed) prefers.

> While we are at it, please also consider to replace "original concept"
> by "original algorithm", as it didn't work due to a mistake in the
> algorithm as opposed to failure of the concept itself.

Ok, it's now "original algorithm".

Thanks,
Christian.
