Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44833C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 17:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiKORqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 12:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKORqC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 12:46:02 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2A3EBA
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 09:46:01 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r81so11261485iod.2
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 09:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rusvaiCO8v2sHZWH8wKacAX+QAyxjQ6FXrKT6Yws/UY=;
        b=WrLsWGSyjkJquLT+2XeAWy7gU6oHt/+W7ggo2tUZP0mWfQOdnhpT1dxaORhD7RllML
         UZu6iei1GbYU3rDeEvRyk3qbFP+Iy2ng2kuVsv68ZhP6PQQL8I+kLALVG3syCLB3hzUK
         rxr+Hq4zEaWm/jPNxKdXKk3YYJ1akJwg+SoD5OOjuG6aiW+RhNr4RfaovQITk338XJUB
         RQt6pDy10cbt76xl671sy8cdnjniEWf4kUbLeYOrrUVgmWso2LrCgShWjL0OirKHsxhs
         zLtTtI6Ju4AZ+687+JWUxPw7jjeOoXCLE5PlfF/Qln1ud3dxZJa38xviuUjqY0ERimd+
         fulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rusvaiCO8v2sHZWH8wKacAX+QAyxjQ6FXrKT6Yws/UY=;
        b=vBcI5xPHR+wUvQfAe9CapnB+8jdREG3DYQLXgLfmt+lBmzU53xe+iGDyqQKs0chnPa
         mlbjv8QF0fA2Nt0tzItNQYfJTMxh01gQfb2Hf7wqm8X6fhiFEYhra2nOyFWdbepYLpP/
         335GTHL2RSNXb0kd8EsbG59I+cLI8+fXv07ZNfhLe1XNE45XKrr1NYVdFgpCwhFniTer
         //ICLerPkcbqgLyWTYgs18ec79r+9yfFN4OIgPKKXJfmoImaRgV4kUDUYp6xab5Gu++l
         UNcOtwbUrZG2iocWWF4IGHoe2tssBYbHSbxI1P9smMpgPRK4vP2POzwNiiTsJPzu6I99
         KcIw==
X-Gm-Message-State: ANoB5pmpV3Wlk3hE4yFD88uQjSDIqWmUSUMU8bC94Evmc1jday+MH33h
        bU0z7fqGSD8cPHp4Wow1TTjriOJ2Lghihtr6La4=
X-Google-Smtp-Source: AA0mqf4WfDx11KUEj/NNwUQ3Don8MO1o0GVBqD6TD3xmq9/3oYMn4/BeXYin46Bnx9sABF+1ElEdswXWXvnhsaeJMB0=
X-Received: by 2002:a6b:6514:0:b0:6d6:5fe4:8212 with SMTP id
 z20-20020a6b6514000000b006d65fe48212mr8237346iob.180.1668534360697; Tue, 15
 Nov 2022 09:46:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v4.git.1668055574050.gitgitgadget@gmail.com>
 <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com> <CAPig+cTO3NPg_Kx3dZhFMEtbMe9hRvaumZYxMnSJRyXqUA=p0g@mail.gmail.com>
In-Reply-To: <CAPig+cTO3NPg_Kx3dZhFMEtbMe9hRvaumZYxMnSJRyXqUA=p0g@mail.gmail.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Tue, 15 Nov 2022 11:45:49 -0600
Message-ID: <CANaDLW+Ec0kY4AW5dGvnCaHgcvFOZQZO5EAi595KbVKj7KDg3g@mail.gmail.com>
Subject: Re: [PATCH v5] status: long status advice adapted to recent capabilities
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

Thanks for the feedback, and I'll integrate it into a new patch, most
likely today.

> Does this need to be "inline"?

Oops. Just as I said I don't think I left any feedback unaddressed.
You did mention it last time, and it fell through the cracks. I'll fix
it this time, sorry about that.

> Was there a specific reason you switched around the condition

Totally a whim. After several iterations, the code had changed enough
that the original ordering was lost. I'll switch it back.

> To what does "this" refer? Is it this repository? Or something else?

Hah, good point. The accurate answer is "the status of currently
existing files is being cached, and we'll watch what files changed
after now so we only run things on those next time". Obviously that
would be too verbose for the inexperienced user hitting this, really
this line is here to convey "if you run it again, it's probably going
to be faster".

Here are some ideas:
- "but this result is currently being cached."
- "but git status results are currently being cached." (true but not
perfectly accurate since index updates don't only happen on git
status)
- "but untracked files are currently being cached." (not completely
accurate, I believe the index is updated for all files; the untracked
files are only the interesting ones for this specific performance
consideration)
- "but the results were cached, and your next runs may be faster."

I could use some guidance on what would make most sense here. I
strongly feel like the user should know of it since that's been what's
been confusing the users of our very large repo specifically when
their git status is temporarily slow; but I don't have any opinions at
all about the right phrasing. For now, I'm planning to use the latter
bullet point in my next patch because it's the most explicit, but I'd
be glad to apply someone else's take on this instead.
