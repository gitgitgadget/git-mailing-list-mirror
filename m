Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC3C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 15:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbiANPou (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 10:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiANPou (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 10:44:50 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D335C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 07:44:50 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ay4-20020a05600c1e0400b0034a81a94607so5576708wmb.1
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 07:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mvu7ndYX5DZprVHGTJcEasA5a1gY1biNEZpjfCSKYr8=;
        b=I7ZzSpLliR53ZJ9jjUo+kw4UbaVHMlpEkDy5ICtNv4ugfB0JP9EICu/TF103ntQAbg
         VC2JTyPLI8yY87Kt0P7DFfN8vPbPgOMI9bZsd166/L7uIUUiC+BjoXSLMG/kFGQfVDGy
         NxCGF8k/nbifH8BV3tMwR7jXf770YvO/9kKMUTDW9djUS13JEyfyuXlORzSTXb/yXzvL
         OdI+mdQXXEXg7hozltJvcHY6GulwcAHMChgOAiTHTrIMPkmPHgJHnSrOhocEO+8ffGAX
         XA+UWje+pO1fduOrvh77UDtzdbQ2ejD3J24yO/UW1JzRq+v4B7+B+/+OUjlXyZpw8C/c
         CLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mvu7ndYX5DZprVHGTJcEasA5a1gY1biNEZpjfCSKYr8=;
        b=AIpJh0YnBLMwZywMQrbhtfGxkoy51x5YDcKPQ9EFXdqf4C9m1ycErkoP+hJo7FGSq1
         /PDdktunRAA8rf/tD0046yoUYTobxXnJKe5xHWo/Cpu8z2ukss/M0n3BEoy1weQa4pcr
         N9AcCJnM0ANh/vthOGy89B9MMhSR8CpUsq+8c3wOIIRvLG0f/fZv6tKd+RJsR5bowYs+
         2QVX2QC+zIQNn8/bGsntBa82uE2ZlZX4MsQVi+zNlwxvMNOs3YxavZTkXcNZTDeZn1Zm
         ypnG70YZcyH4XFb2ElqQ2vc3OYhF2MPMbCNGzEHAeFqdvHw4JdqtV4A9Kg8BJCyHjma0
         SINA==
X-Gm-Message-State: AOAM531pSdgT+BGreHXV3kqNG4Ef0s91uppncjo25qwB0tVpEyUuHKwP
        +PL8my9bRcnO4+oxY/lXBpwUzf6oylGX/TxLl/E=
X-Google-Smtp-Source: ABdhPJyd7znsuRufygKOcmma3RRiA/EmOxY5aWqw8XERHJwR06J8PzSU5vxvGBxfsTlu+mNM09i9duVJcJxO8tECg/A=
X-Received: by 2002:a05:6402:c19:: with SMTP id co25mr9495104edb.33.1642175087915;
 Fri, 14 Jan 2022 07:44:47 -0800 (PST)
MIME-Version: 1.0
References: <xmqq35lrf8g4.fsf@gitster.g>
In-Reply-To: <xmqq35lrf8g4.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 14 Jan 2022 07:44:36 -0800
Message-ID: <CABPp-BFj8NyXG6cQPJeDE46eicbfnP=TgEirRZVcnMM+YNG7OQ@mail.gmail.com>
Subject: Mistakes in the stalled category? (Was: Re: What's cooking in git.git
 (Jan 2022, #03; Thu, 13))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Are there some errors with the stalled category this time around?  In
particular...

On Fri, Jan 14, 2022 at 7:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> --------------------------------------------------
> [Stalled]
>
> * ds/sparse-checkout-requires-per-worktree-config (2021-12-21) 5 commits
>  . sparse-checkout: use repo_config_set_worktree_gently()
>  . config: add repo_config_set_worktree_gently()
>  . worktree: add upgrade_to_worktree_config()
>  . config: make some helpers repo-aware
>  . setup: use a repository when upgrading format
>
>  "git sparse-checkout" wants to work with per-worktree configration,
>  but did not work well in a worktree attached to a bare repository.
>  source: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>

It has been two weeks since the last submission and emails about this
topic, so maybe you put this one in "stalled" intentionally.  (If so,
and Stolee if this really is stalled, would you like me to try
updating?  I know it has expanded quite a bit from the early simple
fix you were trying to provide, but you've got most the code I think
you need and some important fixes I wouldn't want to see dropped.)
But I'm wondering if marking this topic as stalled was intentional,
because:

> * pw/add-p-hunk-split-fix (2022-01-12) 2 commits
>  - builtin add -p: fix hunk splitting
>  - t3701: clean up hunk splitting tests
>
>  "git add -p" rewritten in C regressed hunk splitting in some cases,
>  which has been corrected.
>
>  Will merge to 'next'?
>  source: <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com>
>
>
> * gc/fetch-negotiate-only-early-return (2022-01-12) 3 commits
>  - fetch --negotiate-only: do not update submodules
>  - fetch: skip tasks related to fetching objects
>  - fetch: use goto cleanup in cmd_fetch()
>
>  "git fetch --nogotiate-only" is an internal command used by "git
>  push" to figure out which part of our history is missing from the
>  other side.  It should never recurse into submodules even when
>  fetch.recursesubmodules configuration variable is set, nor it
>  should trigger "gc".  The code has been tightened up to ensure it
>  only does common ancestry discovery and nothing else.
>
>  Almost there.
>  source: <20220113004501.78822-1-chooglen@google.com>

These last two series were submitted in the two days; they don't seem
stalled to me.

(The other series in "stalled" besides these three all seemed to
belong there to me.)
