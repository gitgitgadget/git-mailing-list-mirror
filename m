Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C51C433FE
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 21:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7305560295
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 21:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244510AbhIXVvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 17:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbhIXVvR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 17:51:17 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42B6C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 14:49:42 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b15so44987052lfe.7
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 14:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=52ejU2hA7zpN3fxfitLIh8LQ5jUh5VN9GbOcyyA/0Ck=;
        b=QOrbFk/RRgvvJNBzV5If89Kg1fwL0sT5UR2uZtu/p/5DpDb289Ro8AVDrx7o9a14jd
         sWMNNltenQl9KU0ALgCGShw6HRzrSi2+T7cEB8kZKdmZsANteYV18Th0aehTQ+bI8ZSf
         E5vqRglR0O2jWmw9x17/Zya1IIRhJ9YgQxpqu1dcRbDeW5HWY2+ue8snlEEXyQ/uK/T2
         HZAHlBOgQEYWtPRFjzvNfv+wWGSMWvEusUYtxHQZuZjBxtDRCXSi3R6H3PrwYunqN9Q0
         0nMi8qDlMjUMNvNpofusdA/Jo3milrCUdd5za5rVqYPT2SoNC8do3aikAAEdawXgDrhS
         w5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52ejU2hA7zpN3fxfitLIh8LQ5jUh5VN9GbOcyyA/0Ck=;
        b=QUxx5eXqJxPT77KaHBURRxH7TFLRAj3kheDkOpBMpDrtUVop34ycRq9NVWvruDrKip
         BXaJUnVNvus9jDjmdC+XJnHFtiumIBrXQ02Hb2s0smrm2ASBKqH71/h6Ld8m6s/BVD05
         cGgEictnKLZQS/xIELq1dSndgPUhe3tDAVYhbg9azkE5HWzaR2CyLgwRcecWtZbJlH+O
         /fx1mYzPolxioU+LmC8fK5kY1sMmV5Ob2zWGLqQuc+a4vFdsUSxn8YRPYwtxx2gc8Id5
         RBHYZRC3Qkotz/FenGxpac0O/xjTt5cClkWrU3nYeIXDhB/579rGH0RtrsB1kFkO6l79
         QGDA==
X-Gm-Message-State: AOAM533tKAtrQI/jKmvZ+wXbnDE3ICWRROBW5PXR8U/WJ5grjJbIwcy3
        oqJ2VT9TBTe6HInWrb6xpt1Fuqi2ptSvD26tabg=
X-Google-Smtp-Source: ABdhPJyAf9M/Gw3APDlDQQIeB9ddhE86T8BkwNYkl6UMaCBwNGvJHTyql9Ap5fiveS0gY0iI2IIgpDvg+h2p8E4d2ks=
X-Received: by 2002:a05:6512:3190:: with SMTP id i16mr11415936lfe.241.1632520181275;
 Fri, 24 Sep 2021 14:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
 <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com> <485b4a767dfa54729c40b32b7fea033aedc870d1.1632514331.git.gitgitgadget@gmail.com>
In-Reply-To: <485b4a767dfa54729c40b32b7fea033aedc870d1.1632514331.git.gitgitgadget@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Fri, 24 Sep 2021 14:49:30 -0700
Message-ID: <CANQDOdfZrn0YK0_HomzqHkqnxmjXc20aa6TPkmwpiapeGpjjyw@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] update-index: use the bulk-checkin infrastructure
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 1:12 PM Neeraj Singh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Neeraj Singh <neerajsi@microsoft.com>
>
> The update-index functionality is used internally by 'git stash push' to
> setup the internal stashed commit.
>
> This change enables bulk-checkin for update-index infrastructure to
> speed up adding new objects to the object database by leveraging the
> pack functionality and the new bulk-fsync functionality. This mode
> is enabled when passing paths to update-index via the --stdin flag,
> as is done by 'git stash'.

This part of the description is now inaccurate. All modes of update-index are
now enlightened to use bulk_checkin. I'll just remove the sentence that
scopes the change to --stdin on reroll.

>
> There is some risk with this change, since under batch fsync, the object
> files will not be available until the update-index is entirely complete.
> This usage is unlikely, since any tool invoking update-index and
> expecting to see objects would have to synchronize with the update-index
> process after passing it a file path.
>
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  builtin/update-index.c | 6 ++++++
>  1 file changed, 6 insertions(+)
