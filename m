Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64064C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 20:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D42822AAE
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 20:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgLVU02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 15:26:28 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:37767 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgLVU01 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 15:26:27 -0500
Received: by mail-ed1-f42.google.com with SMTP id cm17so14158736edb.4
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 12:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A3zySINbnrL2wLfflRtF6at0NWjV7Ktc6FO4HZ7Mbpg=;
        b=ne+sZsp3jkKdVfVLnpqCQyP0MwiwGetXFrKxZIRXxcX3PJ48XB2k62b8l36/aKL4UU
         c9UWIsu0n/5/U8eC2cHCJQ4+IdayX8CgUxOKBm5YIKguSMK62Cd6etqEK2nJ8aW8KTg3
         3fChtnAxKSUpGaGtP/tHC1vjNXJGlIsrcdccr4yoi2JQ591S3VByqZ602SwNScMHUOh8
         wcB+jFhmqSaVw5Htt8GtN2ln+2J2skis/dRbLK5o5m/tmksf5rAFhYVlw19eIiXRpRNh
         fRrdH/kZs+pQUN7g4pSgDFF4SL5Y/z4JltpFgQMwBYFAHXhvwGmMptRNvOKczyKb2dKn
         bx1g==
X-Gm-Message-State: AOAM530FWM7kJzoJU4v0IiwUSFX0bpv4fKkjL11trNRvYDBniwSZiW++
        jnfepBYdVtWuFEGqCoARl2cGpR8cilngX7mSxGc=
X-Google-Smtp-Source: ABdhPJzdswruzyZXDqdKaqfC+5pK7bMvx1Y87MVvgIfQ9ALdQpzKsfT/UYi1/k5zS8Quc6p1Yu3Bw7tX48fjT83t1yY=
X-Received: by 2002:a50:ab51:: with SMTP id t17mr22015471edc.89.1608668746066;
 Tue, 22 Dec 2020 12:25:46 -0800 (PST)
MIME-Version: 1.0
References: <xmqqo8ilhafa.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8ilhafa.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Dec 2020 15:25:35 -0500
Message-ID: <CAPig+cT7q76NMubK3N2R-OmRUnH6HVWOt7eKRNCVjtv_qWK97g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2020, #04; Tue, 22)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 22, 2020 at 3:08 PM Junio C Hamano <gitster@pobox.com> wrote:
> * es/worktree-repair-both-moved (2020-12-21) 1 commit
>  - worktree: teach `repair` to fix multi-directional breakage
>
>  "git worktree repair" learned to take advantage of the fact that it
>  knows both ends (i.e. the main repository is found in the location
>  the command runs, the worktrees are given as arguments) to deal
>  with the case where both the repository and the worktree moved.

The lengthy parenthetical comment makes this description a bit
difficult to digest. I had to read it a couple times to understand
what it was saying. Perhaps it could be simplified, perhaps like this:

    "git worktree repair" learned to handle the case when both the
    repository and worktrees have been moved.

By the way, an unrelated patch[1] I sent a day before sending the
es/worktree-repair-both-moved topic doesn't seem to have made it into
'seen', so I'm wondering if it was overlooked (or perhaps it just
hasn't been processed yet).

[1]: https://lore.kernel.org/git/20201220212740.44273-1-sunshine@sunshineco.com/
