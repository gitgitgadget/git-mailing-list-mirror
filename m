Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D3DC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 03:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4BA611AD
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 03:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhGMDuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 23:50:10 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:46627 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhGMDuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 23:50:09 -0400
Received: by mail-ej1-f41.google.com with SMTP id c17so38782707ejk.13
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 20:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOjimYWXXUu10p54b1u8VQPfPM6jILasSFFOGBskoq4=;
        b=GwRBiyA6CQy22L+fXM+aWFfHiEyK2YNgJbIwPTeL6py1NNzMKArAkO4zFTDp0/2YLL
         KA0vChKrdkw/ZmOPUbzIdxYbpIJ94qWXMW36CRalJTgSwOoQqJCMeonhgLlzvBo5uFIX
         pETCwgOZy2mnoIEwkdRT0LsZXsv/LMRXzBZnLdI5g2rGaoxk1ZFMrdYSOEDmOprs6gGf
         IIB43xlYX4iArLgq/qfOcPzyTrQf5m1sIXeeJZrhkg/wK6DFyZ2u5IdejtXzHEBFPRi8
         DjBfac3Rns17F7+xEjNskR4ywFWbLLr50x8cqdoSjoAySsBreW0X7y612xtRnUIK32Yb
         xQzA==
X-Gm-Message-State: AOAM532iz7MzJBE7Nzh+jAhLFZhJmRzMpKORUoaYoqIfDSlSqlV+siwa
        lNPMfJufp3mEZNkft5LjOJE+j5uZgTrmjh5L+S4=
X-Google-Smtp-Source: ABdhPJzeJaOlT7IYiFUM8vW66qbUB6KeoJbVu/vwdAMUub0A9Mma5dHMhb4O/pp0ysbOjX+PNxsQkFA3A0zHBSkMiMA=
X-Received: by 2002:a17:906:f9c5:: with SMTP id lj5mr3029374ejb.482.1626148039246;
 Mon, 12 Jul 2021 20:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.992.v2.git.1625759443.gitgitgadget@gmail.com> <pull.992.v3.git.1625963240.gitgitgadget@gmail.com>
In-Reply-To: <pull.992.v3.git.1625963240.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Jul 2021 23:47:08 -0400
Message-ID: <CAPig+cSVsJ9AtAMqtRQpyuosCDCGi+mu2C1PJUK49WTb5KvcWQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] worktree: teach add to accept --reason with --lock
To:     Stephen Manz via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Stephen Manz <smanz@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 10, 2021 at 8:27 PM Stephen Manz via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Changes since v2:
>  * Updated second commit to wrap "initializing" string with _() to mark it
>    for translation, as requested. I had originally opted not to mark it,
>    since, when --lock is not given, file locked gets removed after the
>    working tree is populated. Thus, it's not really user-facing. Modified
>    the commit message accordingly.

True. Makes sense. A side-benefit of wrapping it in `_(...)`, though,
is that it saves the next person who touches that code from wondering
why only one of the messages has been localized, so it's nice to see
the revised patch making both strings localizable.

I read over the series and played around with the implementation. It
all looks good. With or without addressing the couple extremely minor
comments I left on patch [3/3] regarding one of the tests, consider
this series:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Thanks.
