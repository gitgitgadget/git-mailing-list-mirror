Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5D0C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 23:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345076AbhK3Xj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 18:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241388AbhK3Xj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 18:39:26 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BA9C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 15:36:06 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v1so93590618edx.2
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 15:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvfIZbrK/Yv9ZLibMRh9Jm39yTpz8AKU19r3LWb4LlU=;
        b=IwMv6SUyFfysOFDwxjkxrt3ygJuisbbCyMyEGDvUyO1UxppYfMNWGSfAbFgW8787cM
         E2zOKhowamJLUZKOKXgjGH0X8bMjMcsRdWHcNz4+zR8W2QUvxYX8/QOQPi9jsyjH19uT
         rDFQXhpgpBsBk585wNF9CFsEJu/dyDbjBg0KhK5yWqaYAtn4jDVIYdNzC9xk90+fdUYz
         TPmLLuZAuNMOb3KRUmivfkveERzvwfcp5yHWId2moI/uQ7nZHnDlDqseFqRrmi4wDJqs
         SCtYLO/dVNGMyW90fIGJwqw5PDGKTVuoWiOw78ShY5QOMVmRX1g75l452XQmUA04qsYj
         9RBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvfIZbrK/Yv9ZLibMRh9Jm39yTpz8AKU19r3LWb4LlU=;
        b=s9nCtnaypCwCT/o7vWNQmI9hIIr7y5OHGxFi+MPgZkKLh6GgoHItkVYiZkOrnRl9Qs
         73Z7su+j1eKIri93+saPyPiO7mNmW6EfPWuM0mLa0tD8fsp6Ln+5qKQ03H3pTgQc+Kj5
         WTiQ+/REPosW5X/w1sFs/mbvCX0ojcBN8HqNS7Kze85LOB57vXEm58Pnienf7TGq1bp3
         BJ6ANAl2u3Tk94T0va4iA/1ivtZ/9C/x4TW/mZFUUaU8Jnd0pCPi4pF20InPGw+UkmaM
         6Nb0wpsCqUE1lMadSSikne4y4sLEda+H6r0pp+wyvzycLTIQEOKnlkcNo4WEAIKXw4/i
         2tdw==
X-Gm-Message-State: AOAM530TWa86J6fjaUTaale826bQUXdXD8ci8o2UTGO5r496vOpmNWZp
        rnJ1tV+DKBwgoPhZo2nVo/fDflay9gYrJu8jQ7E=
X-Google-Smtp-Source: ABdhPJzAi2vok6hFICFDbSx+mZp83E+VxtQmsGdRz8cx1PU83YafvftQ5saHDX35fg8WzrEhK+EKefRLnRZvzPBK0yM=
X-Received: by 2002:a05:6402:d73:: with SMTP id ec51mr3061002edb.175.1638315365089;
 Tue, 30 Nov 2021 15:36:05 -0800 (PST)
MIME-Version: 1.0
References: <xmqqzgpm2xrd.fsf@gitster.g>
In-Reply-To: <xmqqzgpm2xrd.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Nov 2021 15:35:53 -0800
Message-ID: <CABPp-BE=NhC0W7H2uF3LuSNOEXfdLw7KH11YXVz6G53QF6gE8A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not sure if it help/hurts/matters, but thought I'd send a thumbs up on
several of the topics.  For topics I have comments other than a thumbs
up for, I'll post separate messages...

On Tue, Nov 30, 2021 at 6:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> * pw/xdiff-classify-record-in-histogram (2021-11-18) 3 commits
> ...
>  Will merge to 'next'.
>
>
> * ab/mark-leak-free-tests-even-more (2021-11-01) 15 commits
> ...
>  Will merge to 'next'.
>
>
> * pw/diff-color-moved-fix (2021-10-27) 15 commits
> ...
>  Will merge to 'next'.
>
>
> * vd/sparse-sparsity-fix-on-read (2021-11-24) 4 commits
> ...
>  Will merge to 'next'.

Thumb up on all these from me.

> * vd/sparse-reset (2021-11-29) 8 commits
> ...
>  Will merge to 'next'.

There were two tiny issues pointed out at
https://lore.kernel.org/git/9c5b7067-b0e3-0153-5cd3-042bae92f91e@github.com/,
but it'd be fine to merge the series as-is and consider those as later
potential improvements.
