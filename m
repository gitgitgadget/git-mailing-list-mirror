Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851AAECAAD2
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 02:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiH3C4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 22:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiH3C4q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 22:56:46 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B69174DD2
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 19:56:45 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-33dc345ad78so241870727b3.3
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 19:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UbZbYsBeHx25q2VON9eFC7upZHTQRnKairFUeU1ZgBM=;
        b=oU3fmG/jQqVxeL88SDjvUCXSI0Jas7u59XDvy4+pjAQyPZemAiouqSaGwmuUipNUTX
         s+v3aShD0yPLOpFUof0QPfAFyEn1WFiBpmA21zXSYFN3NfxrqcHoboTY16In/xTgnCk+
         dVT/oCEwNDPKEkxwc4cpMTYYv4AbLfbITAvnjxntmRuMwKKgiTH4Lsuy26Pvg9i/81Kg
         5z1pHPMwWzvyVtUjVe4MERX13jIzM07Cyh/rJg6ra3vtbESMyW6UzIJf6dHGLWkNr9oC
         OK2mkacxsEXsTxw/q9WzcwpcZrPwtkiKy0SKdGOE78WLmk5Y/wuQh2tFHMjr8aY7Vlat
         ol+Q==
X-Gm-Message-State: ACgBeo3CapszvRugHxlqaxU792pqejBI3yLOPswU0rk/o7VUnhHVP4Nm
        jj4C5Cpayyq+K5bg40VcfUxJM2mel7v5CbN9YDc=
X-Google-Smtp-Source: AA6agR46LTDAtsuOk2M7xCGiCfb/CTcTgs3p0vz9N/VGaUcPnFp9c/8lYTy9iFrrcGMCWCa1pstqnoG0xof+LRg/4Rw=
X-Received: by 2002:a81:6c02:0:b0:340:b4ae:5aa7 with SMTP id
 h2-20020a816c02000000b00340b4ae5aa7mr10474776ywc.13.1661828204280; Mon, 29
 Aug 2022 19:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1339.git.1661663879.gitgitgadget@gmail.com>
 <xmqq35dgt9ph.fsf@gitster.g> <CABPp-BGTdqo9rBoWYeOp+ATU1NS+GFzBcdPnMPGgH0_Jksr7zA@mail.gmail.com>
In-Reply-To: <CABPp-BGTdqo9rBoWYeOp+ATU1NS+GFzBcdPnMPGgH0_Jksr7zA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 29 Aug 2022 22:56:33 -0400
Message-ID: <CAPig+cTNaE8sBRyMqMzRiE7+RMwaFEUNPuArr8dvrOrRzq-QFA@mail.gmail.com>
Subject: Re: [PATCH 0/3] fix failing t4301 test and &&-chain breakage
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2022 at 10:53 PM Elijah Newren <newren@gmail.com> wrote:
> On Sun, Aug 28, 2022 at 1:05 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >   t4301: account for behavior differences between sed implementations
> > >   t4031: fix broken &&-chains and add missing loop termination
> > >   t4301: emit blank line in more idiomatic fashion
> >
> > The second one is off by 270.
>
> Apparently Eric knew what you meant, but I'm perplexed by this
> statement and what it means.  What am I missing?

Junio's comment was opaque to me, as well, and it took several minutes
to figure it out (especially since I authored the patches, thus I read
what I expected to read, not what was really there). Taking a look at
just prefixes on the patch subject lines...

    t4301
    t4031
    t4301

there's a transposition in there which, mathematically speaking, makes
one of the test script numbers 270 less than the others.
