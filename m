Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34A1ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 03:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiIADsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 23:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIADsL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 23:48:11 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B94915C796
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 20:48:10 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id f9so8921183qvw.11
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 20:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/crcXGBCdU6+yL550XKEZ2KRjanFosVZgUCwErsFTPo=;
        b=Ftgc14BH28wxcZVylgLrRGn5WKxJfrH6cKHQv0UzmDsZy0/SCQIvOMngrlowcB7Mpd
         zshPIBwlf1GSLEJre73YlgcjSgOXgd3txLGaHz26s3hjkyhZv/noBBqh+fH3osvLI0J7
         BmF/l+SGcxtzeq9eRTOZ7idkuQWDmEWJ2vnQaRasEOGYn+0wdzmAWYES9kltcMd79cba
         8gCswOqHoAYvm7CAoioyQyDurmqmmTNS8aylPN1DK/+B5CxCpRnrSylhpXySPk21G/8G
         8Ad66xLeV4IhKPCQq3teXkAyKPQBil5sMzNMMmboTVxGIScKpe2pjERVKMZLoyzfPoqo
         kuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/crcXGBCdU6+yL550XKEZ2KRjanFosVZgUCwErsFTPo=;
        b=7msHUhtGLAm1bUM2NsYOxyi9YwSdWlkpHJlOysetQR90A7yuKibvADqwYo7IeMxoj0
         KrdMX0ynlvUzX8nfFgViRj0QiZUAWqt5kgSI4Egyg5qPT4KcMjGaE31vIG2xO24YvSKQ
         5UNOhrVFcuPIpLYmL3a3bP9+dmxHTyJMkhCcGg7NDZKz8mGzM9QH6wmZXENpqWVpDsxm
         9YLES54Ljd0S3ckmyUkKmHBWgOu65Kd+eOOLeFm+KhAHeptYAfD8fwZpmNIxb+Nj+iMO
         vqYupI81KnHzo6XMo/LO128x6NcVXDXuqcaFsygzLe9F9kJNh3oakpBuWMrdyX+pYKIl
         ztEQ==
X-Gm-Message-State: ACgBeo1Af7eFiuokb1yVd9QROPPAX4rAyrFMS8QSivmhrG4dBF814g0M
        8h2CqpwCg1o/bgmZ7KPuHLXp342twZK9HsU+inuvvLOrZTs=
X-Google-Smtp-Source: AA6agR5jfItXNGT+PLi4ANBvGlT3h5YZUbQ3opkHMlT6XszA9xYf7V8z7ODmmxc7q25CVZD4K+1V+uigQ7s3zyH4xgE=
X-Received: by 2002:a05:6214:d01:b0:497:fee:f359 with SMTP id
 1-20020a0562140d0100b004970feef359mr22405058qvh.65.1662004089312; Wed, 31 Aug
 2022 20:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com> <xmqqv8q7dhh4.fsf@gitster.g>
In-Reply-To: <xmqqv8q7dhh4.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 31 Aug 2022 20:47:58 -0700
Message-ID: <CABPp-BHULBGAbmY1r9fpRr+MrjqOp7j-devOgkfA25jpYBGY9g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Output fixes for --remerge-diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2022 at 6:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Philippe Blain found and reported a couple issues with the output of
> > --remerge-diff[1]. After digging in, I think one of them actually counts as
> > two separate issues, so here's a series with three patches to fix these
> > issues. Each includes testcases to keep us from regressing.
>
> Including this to 'seen' seems to break the leaks-check CI job X-<.
>
> https://github.com/git/git/runs/8124648321?check_suite_focus=true

That's...surprising.  Any chance of a mis-merge?

I ask for two reasons:
  * This series, built on main, passed the leaks-check job.
  * The link you provide points to t4069 as the test failing, but the
second patch of this series removes the TEST_PASSES_SANITIZE_LEAK=true
line from t4069, which should make that test a no-op for the
leaks-check job.
