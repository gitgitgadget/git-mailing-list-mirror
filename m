Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BDAC433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 15:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242996AbiANPyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 10:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiANPyt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 10:54:49 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389C3C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 07:54:49 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so6619673wme.0
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 07:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zmCqtosOX8fwj53Qo4IpiGDiTtlH2/89WokeWQHiIGo=;
        b=djjqPrw5KLg/eKoxh1n08BAu23VdNqaPzlgqRp/DPjB/69alKGhF4l8QrZHRGSkBJx
         jsUT4c6EtwJL+3H30/Yx9iE9w7P34EdvRms2c80jIlgYUUWwURGi0dFI3yOCeFZ5lfpd
         +RxvqDtTGb1Vq0/RKJPCeqF4k79t3RqvW+TeM89ysftB0ZxksRbxYoHVN3n9Plr2G5GN
         TB6/SwgLebEFRIoBsLBFYFLDIcyiMMIZa4RM9Vcagf2dXbbgKXoBxtqIuRUBhUDV4ESI
         HP032a/FD7hGjBNyN3xyOM9f64HKI4329ejVxsVFn6PeIqmOaZM3/ybl5g/fsnd48XSh
         1yqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmCqtosOX8fwj53Qo4IpiGDiTtlH2/89WokeWQHiIGo=;
        b=YV/hv7jslAmf2HC8vfRtlyky/YkNPiz3k1ewzahO+iEsCt1QjQ8L9Nfke4lOcsBpbe
         tFb26mNW8uc0kRhd63RyAenC5esRnvAxI3tsw1XnoPMyA9bGlq0jvQX3WDHooDLScMOY
         B3aNLSy8lODiUlZg00hmxgZYC85A5+1AaX0ki3c2IbzkC3KiXPltj6yOfG3X8fUjORXh
         YI7ZVipIVaPO/hIOBGJc8PkkEtoIuKFlbThVRySx4O//AT28tr/mmna8Fztupm371e5n
         wZ2AzkKNAwuksqeyvYWieW3cRb2FBwg3e1dZ2WGFvjEEU/ykxFTJd1Gd9Km6nMJd+XIn
         u0Zw==
X-Gm-Message-State: AOAM5306dhhWYUWR2pC/L2RGx8ldoldOoX7KfR9s0xmpwUsPIoF4couV
        w73ZWbl0TDKB3bVwX+clvx/EzmtHz/E0G8bz5q65iTM3RNdFCw==
X-Google-Smtp-Source: ABdhPJwB+wTfkCBChiGBi2BPQKcAgB+4+w4o/WeMU1uguuPAlSVZOJ20c+X+Gaa4CACxK1EtGnMrBmLAOG6txtp5fws=
X-Received: by 2002:a17:907:9712:: with SMTP id jg18mr8219297ejc.328.1642175687616;
 Fri, 14 Jan 2022 07:54:47 -0800 (PST)
MIME-Version: 1.0
References: <xmqq35lrf8g4.fsf@gitster.g>
In-Reply-To: <xmqq35lrf8g4.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 14 Jan 2022 07:54:36 -0800
Message-ID: <CABPp-BFc=_Gns6oDCDvJ9TjtKYAVhYVq_c74hyZJtL=96GqH=w@mail.gmail.com>
Subject: en/present-despite-skipped & en/remerge-diff (Was: Re: What's cooking
 in git.git (Jan 2022, #03; Thu, 13))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 14, 2022 at 7:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/present-despite-skipped (2022-01-13) 6 commits
>  . Accelerate clear_skip_worktree_from_present_files() by caching
>  . Update documentation related to sparsity and the skip-worktree bit
>  . repo_read_index: clear SKIP_WORKTREE bit from files present in worktree
>  . unpack-trees: fix accidental loss of user changes
>  . t1011: add testcase demonstrating accidental loss of user modifications
>  . Merge branch 'vd/sparse-clean-etc' into en/present-despite-skipped
>  (this branch uses vd/sparse-clean-etc.)
>
>  With this topic merged, 'seen' seems to fail t1092.
>  source: <pull.1114.git.1642092230.gitgitgadget@gmail.com>

Doh!  Sorry about that.  I tried to merge with seen to check for
semantic conflicts, because this series was more likely to have them
than others.  That's how I noticed the issue with vd/sparse-clean-etc.
But I apparently missed ds/fetch-pull-with-sparse-index.  Since the
latter has now merged to master and your version of
vd/sparse-clean-etc builds on top of a version of master that has
ds/fetch-pull-with-sparse-index in it, I can simply submit an updated
series and you won't have to merge anything extra into that topic.
I'll submit it soon.

> * en/remerge-diff (2021-12-30) 10 commits
>  - merge-ort: mark conflict/warning messages from inner merges as omittable
>  - show, log: include conflict/warning messages in --remerge-diff headers
>  - diff: add ability to insert additional headers for paths
>  - merge-ort: format messages slightly different for use in headers
>  - merge-ort: mark a few more conflict messages as omittable
>  - merge-ort: capture and print ll-merge warnings in our preferred fashion
>  - ll-merge: make callers responsible for showing warnings
>  - log: clean unneeded objects during `log --remerge-diff`
>  - show, log: provide a --remerge-diff capability
>  - Merge branch 'ns/tmp-objdir' into en/remerge-diff
>
>  "git log --remerge-diff" shows the difference from mechanical merge
>  result and the merge result that is actually recorded.
>
>  Will merge to 'next'?
>  source: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>

Back in September, when you last asked this about an earlier version
of this series, I suggested waiting off[1].  Crazy how many things
have happened since then.  Anyway, this time we've gotten good
feedback from multiple reviewers and I've addressed all of it, so this
time I think it's ready to merge down.

[1] https://lore.kernel.org/git/CABPp-BH2C5HFw_=NtK71oNGXkntzcJd2un0TgMb=UnJ5yJxAAA@mail.gmail.com/
