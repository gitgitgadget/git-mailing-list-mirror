Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC58C43219
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 15:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKUPzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 10:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiKUPzE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 10:55:04 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6454CB957
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 07:55:03 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id n189so1649486yba.8
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 07:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wGRIYPQGGLIf3yh8XvjwRR3H+zlTV05khJbjiXXTXl8=;
        b=oZH2rYY3QpjDWwrH7aE0gsVo8lQcUMDlihVeEcGCYGOx8HbzEEL0zUh8Qyka2Zpl2y
         7bM9FGJRWTPVcPSypbj8nhBslgblUHcFTWojXtH01RprnGSpqzs6Y4cm5li5ryZ5e9NL
         f3jOvyAEX+cmJD8UoVfJQ0CHvGP3MkGU6434DlxMVZkrt049X9+pSbmlZrVlgl0T7lI2
         2L0LuWJdEbyohESgI4kcXdTVe57trRNhrtSI5sNPKUdDXx0rdmAVG5H7wa++KwA0kh2r
         Y3wQ4X0qXGJJvs9TUpcwdG4XhWukQAlwAT9akm3WVIZeuHY/FfVQ0juJ44a6ixrthIG4
         GxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGRIYPQGGLIf3yh8XvjwRR3H+zlTV05khJbjiXXTXl8=;
        b=XV8pBejzZOMg13XIoLZc5ZdQ3F1SHFa+XeSRBpOUCj5k9GQwkrAa1/F0eTVIpf+MMb
         6FvwARDVb6wP12S8GJCOBTruSwNjmtxTtNzvcATj/0nYVtA/OV5gONr0xRuysuvXixsj
         w0oMYW8Kwfsz7J67IcwVRxFavjHRhPXoveQe7FbcUAMMl7XqQfz5Wbz9CplaTxx1jVBO
         HeWFkpR+PTnZmN4RNN53P1+ov4GddNr8/ePRppQsUhR9CIiL0OqDuT9/GRcp+dLbf3Yi
         ccs9TipB6yAFn/5hUpVpZf98BUHNmsd/P+5sK1RQOqpaP5pm+mhgw423IHS1vnXCa9f0
         VTag==
X-Gm-Message-State: ANoB5pkXwyD97SCjoRf5DSKEtiPLnLRdsIeFrvue9Jvm8Do+cjUdVBgc
        wqLj6KvDGTvGlTv2OGGdjFxSQTmyuRFnzjGIvFo=
X-Google-Smtp-Source: AA0mqf7/j5KjuwTGp6WW8blKiPjF3vBRNU/Xprr8Y0/h1VJILewzcVGiosNQGcjwV5HPnf79dFcrqDESubg0Z+GoPho=
X-Received: by 2002:a25:918c:0:b0:6cb:e6c1:ac06 with SMTP id
 w12-20020a25918c000000b006cbe6c1ac06mr18471153ybl.115.1669046102860; Mon, 21
 Nov 2022 07:55:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
 <pull.1384.v6.git.1668547188070.gitgitgadget@gmail.com> <CAPig+cRPQ7bmG6+U+oQGGUFiSiHoMMpMk8FDJ7GMJvwCXifa9g@mail.gmail.com>
In-Reply-To: <CAPig+cRPQ7bmG6+U+oQGGUFiSiHoMMpMk8FDJ7GMJvwCXifa9g@mail.gmail.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Mon, 21 Nov 2022 09:54:51 -0600
Message-ID: <CANaDLWJM1VRivm8VLqxg+w8K-+49E0km6AgOzWzN9X=TgzaEiA@mail.gmail.com>
Subject: Re: [PATCH v6] status: long status advice adapted to recent capabilities
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> That said, this is minor, and I'm not keen on eating up more of your
> time or reviewer time, so I doubt this is worth a reroll.

Eh, there's nothing wrong with striving for perfection. Lemme do one
more reroll...

> So, it's not apparent
> why you need to create a specially-named branch here rather than
> simply accepting the default branch name.

The reason was that it failed some CI pipelines before I did this,
with some pipelines printing "main" instead of "master" into the git
status output. I fixed it right away, so I don't know if it was a CI
glitch that day or if it would still be the same running it now. I
could have redacted the branch name away from the output, but it
seemed simpler and more readable to just set the branch name in stone
for all pipelines.

> an alternative would have been to override the default branch name at the
> top of the script:

Oh, this seems like a better way to do what I was trying to do. I'll
change it now.

> we have a test_unconfig() function

I'll use that.

New patch coming!
