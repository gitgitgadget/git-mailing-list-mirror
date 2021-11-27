Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA9BC433F5
	for <git@archiver.kernel.org>; Sat, 27 Nov 2021 09:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350121AbhK0JIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Nov 2021 04:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239311AbhK0JGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Nov 2021 04:06:16 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B410C061574
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 01:03:02 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y13so48412211edd.13
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 01:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=n50NWK80mUw3Kx7HxXeuaApDW3ZHqImTssFRlWKd3hw=;
        b=qcxXDKEFxbYvZy6WCYiW/uhpTofV77Q7WJXpaJrMTjCEdaT8pKKEoqpbIrHw1rX2WY
         JNK43X7K+f0bXQlOpOhCw5XM/xaUWIvkrFPsWyqco9Pa5iHqzWV6mYAtC3wALBt56LkH
         2aTSaoEqy79mTV9FBFpPkanuGde6hIWaVEUS0e249KnnyFwAVY5PRqV3nwOGY7MiIdjt
         QXiBhZL3fahcbL6JzCe1ZeBLViwAbvnb+2VWbaq1q8Lg5Vh+WMS0aumb2qdnwbf/bXqO
         1HSGA6yBG9E7sYbYiSM9rd4OXe/lGToPWJ1nMPY6+nTX4Yr+s64+0M1iL78xvnHP2SzI
         lGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=n50NWK80mUw3Kx7HxXeuaApDW3ZHqImTssFRlWKd3hw=;
        b=xDqBWcYDG0NL1yWEKvzohm5h9UGS95YTBqXE/ynoSknvSj3TW/c0ZtyirysPPTRrjF
         fxQ1//qEdJcQ5OgnGMMMtZo0g3IE9MSb9vkvadHXcbRal2YQThDhX+hbcnNq3PNQXH+M
         lByAEgherrF1aaElA9COr8lVpuFc6hRb23hnKAqOkJtT6DOFdCqF5WVsV/C+4VQ5Okgq
         /veX46EHr//Twj/6xH6N+MJegfC8wnHQJFGBt7dOHQqvQhrr1S9xSz9VWZpf1lYZiFcx
         2HTNnApNAsUshnWe8bGkeYFPRSIvROSdi3c+VS5sLWcw9ZBh/z9GsuqYDSMWGvO9ru+A
         yuiw==
X-Gm-Message-State: AOAM5323/SjGDHS5BIuM3U2ZFGsaGOmqlF2YcusZnpqTpPi9iPmyfK3p
        OvGLnNgtzuVyHCFzk/r6lWjudmyz41CRr9ZmmzVca7OcHes=
X-Google-Smtp-Source: ABdhPJwOX4VG824mWTgsMSvI1jceBEMgcoifT5RqZ87ux8ECTHvij3xkwNwHJuvqG7CkBA+FKckHfK6asUhSWVTY0ow=
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr54376061edd.212.1638003780445;
 Sat, 27 Nov 2021 01:03:00 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 27 Nov 2021 10:02:49 +0100
Message-ID: <CAP8UFD0EnURwcwKCGnmQsTw1t8soBYe3=xtexYN7icpGUBFZSg@mail.gmail.com>
Subject: Draft of Git Rev News edition 81
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-81.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/529

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Monday
November 29th.

Thanks,
Christian.
