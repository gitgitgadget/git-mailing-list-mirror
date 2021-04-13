Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAD9C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 20:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF8AF61139
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 20:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhDMUqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 16:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348272AbhDMUqd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 16:46:33 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C6FC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 13:46:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id e14so16712257lfn.11
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 13:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Xa5klVNCPo+tshHdBmEoIIKVHn5fpzPMEAMMrq8NPQ=;
        b=FOygE9W17nVx7D0n0lTz/1f8CUd5l7CL2tM3Ip8uUlJtZALniQZmVqCSq53sbE7iUd
         wExdnLdJmQMd6bOL70Tihn0TNaEt09tsEeiO4PyvVUAks1ShiV2jdsSVH5i3DU/CwFWN
         Sk4LpYsXfAN5vstJoBYuGfUg0TLhGTUgK0KOfotXnw4HYtudl8SpPJdYEN6i++CpsgUm
         6osv+iTVNaqxEATopSHxtzWaYwVKURbgI7JV1x+VPiNUqbSTV/aGKGRjZzeHVBrbVK+C
         7nz9Ii1zY44Ww5prdLm3CvZIIpVrTqVq3GacF/Eei4tb4VXlyKUBtUlvIBIR7FEn2Cbd
         Knyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Xa5klVNCPo+tshHdBmEoIIKVHn5fpzPMEAMMrq8NPQ=;
        b=smltXiq9mejmQC/jZQ8pS2Yx/OHgsUkqVr82+Rr+cbXTxBj9e48eoTpcMaX+9G0f/3
         qTkjo2KPhJpsSTyTZjRrBVh0kWZ1lIb09+JEzRRKp74D4yYo/8cfqd55cYHjRfhuEYmx
         jJOY23meyasOVKfIwfC/UN8DngNm0auVST15RF+dyXlGJMZq6VV2P3jNz0Q/n/fxKfmO
         iUsFfucnkudJjMGiwYE9VIya2U/eh9eBZzSuRhGjirea6BeMY8m++hvKrivWLy3a4QsM
         yADaVEaoA6DTjMrK3npUBisKlKz8mzDns+0erGmj8i8pOlbLoW7UVTBSaGYxAh4LJtxB
         ML0A==
X-Gm-Message-State: AOAM5325MH9MzhGinTehjTwV8eJY5Ao/l2Fqis9f/RXe1KQvtifh2ujx
        PixIsUXu0Zd7YBZwsS1ZTpRCiR5aRL9E+uglLmJQNg==
X-Google-Smtp-Source: ABdhPJz/6pQ7xq0RvpQpn8zp7GRQ6YPDZDiWmVFY2qSoSxj+6OlHmCu4FN/JcBqpmxmVm8PSIcShypMt0FvUhAjdsiY=
X-Received: by 2002:a05:6512:3094:: with SMTP id z20mr12486345lfd.354.1618346769694;
 Tue, 13 Apr 2021 13:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.git.1618322497.gitgitgadget@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 13 Apr 2021 17:45:58 -0300
Message-ID: <CAHd-oW7vCKC-XRM=rX37+jQn_XDzjtar9nNHKQ-4OHSZ=2=KFA@mail.gmail.com>
Subject: Re: [PATCH 00/10] Sparse-index: integrate with status and add
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Stolee

On Tue, Apr 13, 2021 at 11:02 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is the first "payoff" series in the sparse-index work. It makes 'git
> status' and 'git add' very fast when a sparse-index is enabled on a
> repository with cone-mode sparse-checkout (and a small populated set).
>
> This is based on ds/sparse-index-protections AND mt/add-rm-sparse-checkout.

I just noticed that our ds/sparse-index-protections and
mt/add-rm-sparse-checkout had a small semantic conflict. It didn't
appear before, but it does now with this new series.

ds/sparse-index-protections added `ensure_full_index()` guards before
the loops that traverse over all cache entries. At the same time,
mt/add-rm-sparse-checkout added yet another one of these loops, at
`pathspec.c::find_pathspecs_matching_skip_worktree()`. Although the
new place didn't get the `ensure_full_index()` guard, all of its
callers (in `add` and `rm`) did call `ensure_full_index()` before
calling it, so it was fine.

However, patches 7 and 8 remove some of these protections in `add`s
code. And, as a result, if "dir" is a sparse directory entry, `git add
[--refresh] dir/file` no longer emits the warning added at
mt/add-rm-sparse-checkout.

Adding `ensure_full_index()` at
`find_pathspecs_matching_skip_worktree()` fixes the problem. We have
to consider the performance implications, but they _might_ be
acceptable as we only call this function when a pathspec given to
`add` or `rm` does not match any non-ignored file inside the sparse
checkout.

Additionally, the tests I added at t3705 won't catch this problem,
even when running with GIT_TEST_SPARSE_INDEX=true :( That's because
they don't set core.sparseCheckout and core.sparseCheckoutCone, they
only set individual index entries with the SKIP_WORKTREE bit. And
therefore, the index is always written fully. Perhaps, should I reroll
my series using cone mode for these tests?

(And a semi-related question: do you plan on adding
GIT_TEST_SPARSE_INDEX=true to one of the CI jobs? )
