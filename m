Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A54FECAAD2
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 02:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiH3C74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 22:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiH3C7x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 22:59:53 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5391CDA9
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 19:59:46 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id r6so7623081qtx.6
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 19:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kOJVPUu24MkeIpQMjEBrsmpZQvf1mePv9SMabn0Gnq0=;
        b=ovyvwsrrazhlSdYWs9oIhmcpuBBTo4GbYFJ4rkI6CIfrI7ATbiSY3rq/l0GlNTyE/h
         YEYrV1/gP6ypw5sj7hN3zzCQN2nlegOqWXdwxWXKvMjOu1sNzItMMBBM8EImozSqTsrT
         +Oxk0F0O4lYbTbmqVfiqY+/1FBbWFs52NgKNU/xcgMJiTUivpeuO8f+AGrUvWfGv3j8r
         2ltUVUBd+RrMqng4awZ52KF+vrIIRYGR/X8BrmB6cr65MGsdT7nPiukP0CDoM+2hRq8E
         9N4M9BkmITGTCl0SLyKOnaR3QaM8MaQMARbd2Ba7W/KfueeqNdFqNPDaU84DKVo706F5
         dTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kOJVPUu24MkeIpQMjEBrsmpZQvf1mePv9SMabn0Gnq0=;
        b=PY/Hvt2CaUDuHhmNQcJPqTSAAfzpGgBN+WM2OUj8qFfuHSNVC04EQoZH/p7iCFcdE5
         y0589LXr48DpaJCtVISABSsKwPmV3rAsdQok+hbRM4Ud/7ZB13wtOg1utIkfQ7zIkgNk
         d5R5BCXAZDV8j8naIoOH2OEKHM0Zid1CCvr5Ua7SchiyZN0oNnzm0LXcdEEaKPQXv7pv
         j2Y89jPIboPqBE1YpNFHRM1H3zPBfQr2qni/YrigfUinL1C393GKudk27UcLaDLPJR7J
         3JuUvbaE4Qmsi9mpAp8/eQI/+0/VIni6g/icO3dYdC90ckrsJ1vtGCWsSuKDx6eNFUz5
         p9ng==
X-Gm-Message-State: ACgBeo1Epcnk7NmpyiztEqD001W4yvAnFnbdhBqzoQmquUo8Bj3W+BXZ
        0niRmjj5BNyKoMUy85i8wMulYbEUBQjW7n6SMqOGVKgC8iM=
X-Google-Smtp-Source: AA6agR6H1FPpo60Ac/jd67YejY108XSayMZbNdKXwnAwhQe3cEmdwhKo3sosR2k8k2y4OCefZhIfli8hyB8cij5FPnY=
X-Received: by 2002:a05:622a:406:b0:343:7ae:4fe9 with SMTP id
 n6-20020a05622a040600b0034307ae4fe9mr13090592qtx.541.1661828386108; Mon, 29
 Aug 2022 19:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1339.git.1661663879.gitgitgadget@gmail.com>
 <xmqq35dgt9ph.fsf@gitster.g> <CABPp-BGTdqo9rBoWYeOp+ATU1NS+GFzBcdPnMPGgH0_Jksr7zA@mail.gmail.com>
 <CAPig+cTNaE8sBRyMqMzRiE7+RMwaFEUNPuArr8dvrOrRzq-QFA@mail.gmail.com>
In-Reply-To: <CAPig+cTNaE8sBRyMqMzRiE7+RMwaFEUNPuArr8dvrOrRzq-QFA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Aug 2022 19:59:35 -0700
Message-ID: <CABPp-BEeyyx4GbtYEUk3kXK=-3hneLACmD0_yLJZEhcTN2qpGA@mail.gmail.com>
Subject: Re: [PATCH 0/3] fix failing t4301 test and &&-chain breakage
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2022 at 7:56 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Aug 29, 2022 at 10:53 PM Elijah Newren <newren@gmail.com> wrote:
> > On Sun, Aug 28, 2022 at 1:05 PM Junio C Hamano <gitster@pobox.com> wrote:
> > > >   t4301: account for behavior differences between sed implementations
> > > >   t4031: fix broken &&-chains and add missing loop termination
> > > >   t4301: emit blank line in more idiomatic fashion
> > >
> > > The second one is off by 270.
> >
> > Apparently Eric knew what you meant, but I'm perplexed by this
> > statement and what it means.  What am I missing?
>
> Junio's comment was opaque to me, as well, and it took several minutes
> to figure it out (especially since I authored the patches, thus I read
> what I expected to read, not what was really there). Taking a look at
> just prefixes on the patch subject lines...
>
>     t4301
>     t4031
>     t4301
>
> there's a transposition in there which, mathematically speaking, makes
> one of the test script numbers 270 less than the others.

Ah, gotcha.  Yeah, I totally missed both the digit transposition and
the attempt to highlight it.  Thanks for the explanation.
