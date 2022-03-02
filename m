Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7393BC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 01:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbiCBB2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 20:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbiCBB2k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 20:28:40 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04813DA4D
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 17:27:51 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gb39so587211ejc.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 17:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ai/FEsWNKavn7Pmob7mqFgTEXh2XmQvDW0k/pJuHmHQ=;
        b=hD7/YboqvEMFXZPgOY91FImVeFS9pFw0kwyjOB0wNjwlyPAGR6vdieUm8IAYMRNcFn
         /RaPPyMMIVMsOsaTvCyqJfhKjrtLQfO5bjMkvaPO7YLl0q8uG/QYnyyW6nz2RN537f/p
         UU5LDu/czfa6eaxG2lsjn+c6Av4YYSWEk4QNGUOWI6KvYUKbJA9JXQOKKMpysCWsnXGV
         jqfhAcjp4dMAAjLvYyG/zeUUeayt0007qjMxS5AZHqTSKCsT5v6wpPgklu98F/gyOWHX
         MSNGPHfU+uL5fT6npUwvvwGgzLxxhX6mW1HvVNVh0FTw/h84CTSUmdCtxTux91C+IBs4
         JDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ai/FEsWNKavn7Pmob7mqFgTEXh2XmQvDW0k/pJuHmHQ=;
        b=IuRCaB1547NTOaQP+qsqCi3g8fV/6NYA5IZq7GU/a4fai4ed8ZXghWCAa0g0rJDr7+
         gIANa39qyoDHDKAr9CSMXDA3OFnWjcq4bjBeg5iUADFf9NW+8nAocIY8fgaXKdisbkvs
         J41KyTwonhGOX7Siys89kI9o3PWPI7eJBfisNGYsilXA8+vNQepmXrHIk5cqIqhQM5WK
         ePWY/O9VVk6MqTu8GZxOlnZYU8vVca4f4MvXv731E6WefZyN2C1EVz622+yI8MRvy6/3
         f33BQe7u80eWBT7djh/wxA7CJVTcc75Z2mwZBnP+XdvMQouJF7bHdQ8MkgD+IuaHGa1P
         OPNw==
X-Gm-Message-State: AOAM532MqMb7RzINrFurql3DimlWYAHDEmqZDJ5zJL9Pxtv7LliE8Imh
        +Yf2pY9atGj2tq/+qB7p3LaMIidrAJUBAx/Nzdc2Rcj/BkTIeA==
X-Google-Smtp-Source: ABdhPJzbYRLHIRHsTTRcsfP00JEbyizjPgD4Nca5MDxefsEozRP8wMIYinHtzlX+nvgX2oRnSHvbg3wgI+7utmt3sWk=
X-Received: by 2002:a17:906:3a18:b0:6cd:ba45:995f with SMTP id
 z24-20020a1709063a1800b006cdba45995fmr21718317eje.328.1646184470164; Tue, 01
 Mar 2022 17:27:50 -0800 (PST)
MIME-Version: 1.0
References: <xmqqmti9ssah.fsf@gitster.g>
In-Reply-To: <xmqqmti9ssah.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 1 Mar 2022 17:26:00 -0800
Message-ID: <CABPp-BGZ7OAYRR5YKRsxJSo-C=ho+qcNAkqwkim8CkhCfCeHsA@mail.gmail.com>
Subject: en/merge-tree (Was: Re: What's cooking in git.git (Feb 2022, #08;
 Mon, 28))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 1, 2022 at 7:26 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/merge-tree (2022-02-23) 13 commits
>  - git-merge-tree.txt: add a section on potentional usage mistakes
>  - merge-tree: add a --allow-unrelated-histories flag
>  - merge-tree: allow `ls-files -u` style info to be NUL terminated
>  - merge-tree: provide easy access to `ls-files -u` style info
>  - merge-tree: provide a list of which files have conflicts
>  - merge-ort: provide a merge_get_conflicted_files() helper function
>  - merge-tree: support including merge messages in output
>  - merge-ort: split out a separate display_update_messages() function
>  - merge-tree: implement real merges
>  - merge-tree: add option parsing and initial shell for real merge function
>  - merge-tree: move logic for existing merge into new function
>  - merge-tree: rename merge_trees() to trivial_merge_trees()
>  - Merge branch 'en/remerge-diff' into en/merge-trees
>
>  A new command is introduced that takes two commits and computes a
>  tree that would be contained in the resulting merge commit, if the
>  histories leading to these two commits were to be merged, and is
>  added as a new mode of "git merge-tree" subcommand.
>
>  Will merge to 'next'.
>  source: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>

As I mentioned on the last "What's cooking", let's not.  Please mark
it as expecting a reroll instead.  I'm waiting to hear back from Dscho
on whether my latest proposal at [1] would solve his usecase.  That
proposal suggests output format and various code changes.

[1] https://lore.kernel.org/git/CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95dKAR-e1zSjQ@mail.gmail.com/
