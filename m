Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC6AC433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 05:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiAVFoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 00:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiAVFo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 00:44:29 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEE6C06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 21:44:29 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ka4so5809135ejc.11
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 21:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5eZ1WWf2GY4gzO2qrHJePTvSXAKQvUjFl4ENdzZDro=;
        b=Tfb+WzIXOPcCV8G5ycrwuP+GrfkKK/F2+l475x309LBV2iL3y1NikxtDmIhvhwL0Ib
         DtwkJI4o1MdldvhgBRTJ9NJ4RLWYADN6UnFn4i8weIalmm9amA7xiFKLlwusx6WfB4EQ
         mHmNu/IuZT4830WVOA2hpeAENMF9skkJrcbyKE125gGbXCPoX66hM8D9xqA6BUPvPc94
         eBekFvOAC6BIiFAb/afbei7xJloHRKBO21hTlM/iC3utKG45woOQHIo6GEB3yo9i7k47
         jyBMpY+AbIJFX/rwC0r7ScLJ0TJiEFaNVXv2ZdSdFy4yDc2OcNDIVpplJkrXxVKWFSAj
         bJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5eZ1WWf2GY4gzO2qrHJePTvSXAKQvUjFl4ENdzZDro=;
        b=DQD3G0TzWbBfjpzExJdIbjDvJw2BHKH1p9aszFXSWDEBjxyifxGNqzcMHtPGzSVCek
         07oA89qe5svteuLzg5uKLjGamYdxOgI+38VrNJXjBwGYIcHGi7T1K2TsxPYKuNDYHrNO
         iuR+tLa5585s4U10uIeKCKBmfTDEMecQ+yPZHC9vZO3C4QMav4TMt6L4m7DBBJsoSQNn
         z8jTR4pssGDp/mRgwSGOg2okwPt+V6pe+HLjw6XP5Swdjh4x2icV1obWq1V00Js41uj+
         oQG1jKCbj+e+GQ267nO5ubxmRSSuslkXufsnY7+whZtfQu1cKdrCK6q7KJRbXPchDExN
         HrSQ==
X-Gm-Message-State: AOAM532tVpuIxruZwbFCZoIO8DgOq4f86Hj99tL73T95rSGUvUkzsne2
        RKN/6nLh4m51TOF2iPXL0iczDd9n2XLxCJa9rRc=
X-Google-Smtp-Source: ABdhPJx15sJ+lohRXIqg5MkxuXvZlCEWuE3tPtmKG4U/b5YxKD/3q5YaNXsHb99n8lJlGfaygMV0AovrGFLzmYl48eQ=
X-Received: by 2002:a17:906:dc8e:: with SMTP id cs14mr5591292ejc.269.1642830267684;
 Fri, 21 Jan 2022 21:44:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.1119.git.1642613379.gitgitgadget@gmail.com>
In-Reply-To: <pull.1119.git.1642613379.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 21 Jan 2022 21:44:16 -0800
Message-ID: <CABPp-BFXMMH2_qqWPGaWX76mqEs2Z1GFNzbyeu2rLgaFPt7JyQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] [Non-critical]: sparse index vs split index fixes
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 21, 2022 at 11:53 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> We noticed split/sparse index-related issues while rebasing Microsoft's fork
> of Git. These fixes are necessary for that fork's test suite to pass, but
> they might not be super critical to get into upstream v2.35.0 (especially
> this close to -rc2). However, the team felt that the decision should be left
> to the Git maintainer whether to take these patches into v2.35.0 or not.

Thanks for digging into these and putting in some guardrails to
prevent similar issues.  I hit similar things with some of my changes
and had to fight t1091 to get it to pass in CI under
GIT_TEST_SPLIT_INDEX=1.  I don't recall seeing the specific error you
mention in patch 1, but maybe I just overlooked it.  I ended up
finding little workarounds such as disabling sparse-checkouts at the
end of various tests before new ones I was adding, and being extra
careful to not leave the sparse-index selected.  I probably should
have dug further, but didn't.  Thanks for digging in.

I've read over the patch series; it looks good to me:

Reviewed-by: Elijah Newren <newren@gmail.com>


>
> Johannes Schindelin (3):
>   sparse-index: sparse index is disallowed when split index is active
>   t1091: disable split index
>   split-index: it really is incompatible with the sparse index
>
>  read-cache.c                       |  3 ++
>  sparse-index.c                     |  2 +-
>  split-index.c                      |  3 ++
>  t/t1091-sparse-checkout-builtin.sh | 54 ++++++++++++++----------------
>  4 files changed, 33 insertions(+), 29 deletions(-)
>
>
> base-commit: af4e5f569bc89f356eb34a9373d7f82aca6faa8a
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1119%2Fdscho%2Fsparse-index-vs-split-index-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1119/dscho/sparse-index-vs-split-index-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1119
> --
> gitgitgadget
