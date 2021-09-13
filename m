Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54892C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336E3610F7
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242220AbhIMT1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:27:54 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:41604 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240628AbhIMT1x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:27:53 -0400
Received: by mail-ed1-f45.google.com with SMTP id z94so9793750ede.8
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjP+BbV/4sv+O1ynj+JLbfsFWMrGb3vUPGfQeD6+eAk=;
        b=Qht+swK0gnH5y5b/+nRt32Xuhpc94UpIXO2gKd6Vp6bP9QvlBlznW5MkDvyMBwO6GT
         HUkZnL/612KVHwAW5T7FxyCmRabt8Xr8MfuZifwOdpmUFgAIN+AiAY09ruAZ3MGL9Gvc
         BrwGWvFM5JP/8xsPj3aY+VPc3vrhaLMO2WPX7AetN5lZJ8EUHZWMO/YG+2RxhefBVOB8
         eQauGS+j5kyVBk9bawTvv30/C4mkP4/CD6tUAKewWTDWOcULvKEDiw30N7Fvv9eTjRpT
         m9Y+OjsDO7ct/+Qab1qEyMrLcJJCmum8x/KSD1jvULvwl7QRlUJT9H0VFGXOGjzuUmB1
         +Jtw==
X-Gm-Message-State: AOAM533gahHP42MCqCtnc+gREEtdCy6nTe7n5olvzQ5iXTxY9Az9BzYB
        FVLGzoYEjiAH0dJPGiKMIFa7+GX4uHrnEh3BvXWkH0TcA+M=
X-Google-Smtp-Source: ABdhPJyLMcNIiuSLhtU2B9APhLp9OelqN6Lnqy8uETyhjNJFOkMk1kFrhD3UHOtuI0xlwTrBaYV1/luiqydMijNjOk4=
X-Received: by 2002:a50:af86:: with SMTP id h6mr14845620edd.283.1631561196483;
 Mon, 13 Sep 2021 12:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210913185941.6247-1-alban.gruin@gmail.com>
In-Reply-To: <20210913185941.6247-1-alban.gruin@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Sep 2021 15:26:25 -0400
Message-ID: <CAPig+cR=HUDgFctXzcigZ062c=QWYfGWUPuT7scc-xU_w3NT1w@mail.gmail.com>
Subject: Re: [PATCH v1] git-clone.txt: add the --recursive option
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 3:14 PM Alban Gruin <alban.gruin@gmail.com> wrote:
> This adds the --recursive option, an alias of --recurse-submodule, to
> git-clone's manual page.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
> I found this out when a friend told me he could not remember how to
> fetch submodules with git-clone, and when another one suggested
> `--recurse-submodule'.  I checked the man page, and I was surprised to
> find out that `--recursive' is not mentionned at all.
>
> I did not modify the synopsis.  So, this alias, although shorter than
> the "real" option, would still be somewhat hidden in the man page.

Considering that the `--recursive` option was intentionally removed
from `git-clone.txt` by bb62e0a99f (clone: teach --recurse-submodules
to optionally take a pathspec, 2017-03-17), it's not clear that this
change helps the situation.
