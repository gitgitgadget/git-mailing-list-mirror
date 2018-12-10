Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1FFE20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 15:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbeLJPdZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 10:33:25 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:56268 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeLJPdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 10:33:25 -0500
Received: by mail-it1-f196.google.com with SMTP id o19so17885771itg.5
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 07:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vIUPSjF6N0jwzAruEgRKfbRS+ZHAlbMaYFJUfwHkDsw=;
        b=VxVK7Eu7oTyzai8fb+24qxi4idCrByfT0cpPOZeVx3BvzNlNLUrGAE8lQw9TDl+l6T
         vVWd8lDehvQNru29YR3kBhE95BYhAR/RCj168dBf5sVPlydYF+XDz6KgnCQTDAFsd6d6
         7OA6Y/G/XCCyv+SBba/wTLx/yYm590Uy3GafrlV00V8Z8NPQZAFrn7e3dmMB9ROr9PPt
         Q3xLZaI6ixDut5A1QJLEJw0HEw9OqQi/Lhi1PS6xI+1E9atkTm04wui872Mx+Boh2k3X
         3iWLbwhZ6TDtxu3CO9HPYWuuqGAwqLAint6YWoeeVRgrjdoC+iFO39qVSg1ognqpLMHo
         vtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vIUPSjF6N0jwzAruEgRKfbRS+ZHAlbMaYFJUfwHkDsw=;
        b=rlm273RLBxJoNttSePPFY9O9V8keTqE8vpHxc9EYK1U+2T4V+loNrotn/Rn6L4EPGf
         y0VeU5lnnZSBUUGuwHiOXO0b2qgxyeQY4DAmxgOurm8cCJhleSzJ3MR+csj8uCL5supG
         cMvB6/eyd0jld8eT2Ai8vvRCYcJpELkXfb/XTFKDIJiqOJ9BsBfhMNLJQG7t5wovg8wH
         I64Eux01zujb4khB1AaUbe60yRs92hqUeaRcmKKzRe9TyFzV92S4iObSl8LO9E/hL/21
         2Kkz6R/8pIEU1jxKlwQt371JX8/2h15bC8Ff0lRlASs2QCbFeq5dIARPuGzogMT+0YDL
         Koyw==
X-Gm-Message-State: AA+aEWa3EQOQsK1hvGFKyhUkzdJzbLCzbkTsqnnwTs1LZ2g69UCtyf/o
        rfry/N7+QwRNgVPX7oYYyehK4xF8qPLYOdjhUTY=
X-Google-Smtp-Source: AFSGD/Xr9aXVa0DVdAs1XOjtGJkXZeqVX5Six/QfwnC91M+nR82TMVnCBNZ6Sd4c9qJeWxWvAQuWcc4brbVZIr6O9F4=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr11352666ith.123.1544456004795;
 Mon, 10 Dec 2018 07:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-2-t.gummerer@gmail.com>
In-Reply-To: <20181209200449.16342-2-t.gummerer@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Dec 2018 16:32:57 +0100
Message-ID: <CACsJy8AgbU9YyMHXdp=bkMncBO_Mu0FOQ4kSRkgacHzTJ0DrdA@mail.gmail.com>
Subject: Re: [PATCH 1/8] move worktree tests to t24*
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 9, 2018 at 9:04 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> The 'git worktree' command used to be just another mode in 'git
> checkout', namely 'git checkout --to'.  When the tests for the latter
> were retrofitted for the former, the test name was adjusted, but the
> test number was kept, even though the test is testing a different
> command now.  t/README states: "Second digit tells the particular
> command we are testing.", so 'git worktree' should have a separate
> number just for itself.
>
> Move the worktree tests to t24* to adhere to that guideline. We're
> going to make use of the free'd up numbers in a subsequent commit.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  t/{t2025-worktree-add.sh => t2400-worktree-add.sh}     | 0
>  t/{t2026-worktree-prune.sh => t2401-worktree-prune.sh} | 0
>  t/{t2027-worktree-list.sh => t2402-worktree-list.sh}   | 0
>  3 files changed, 0 insertions(+), 0 deletions(-)
>  rename t/{t2025-worktree-add.sh => t2400-worktree-add.sh} (100%)
>  rename t/{t2026-worktree-prune.sh => t2401-worktree-prune.sh} (100%)
>  rename t/{t2027-worktree-list.sh => t2402-worktree-list.sh} (100%)

Heh.. I did the same thing (in my unsent switch-branch/restore-files
series) and even used the same 24xx range :D You probably want to move
t2028 and t2029 too (not sure if they have landed on 'master')
-- 
Duy
