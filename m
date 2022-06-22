Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA495C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 21:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiFVVQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 17:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiFVVQm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 17:16:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF86664E7
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 14:16:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o9so16462537edt.12
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 14:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ePJDY1Id0fwmipgSSohUBrFBSRbOMOMWBv/Acn6LGA=;
        b=W9pNxGlVJPaxXiJg4IYID1bgk3wb2nJ/gNAHEuDNfChtGkIjlopkYPyqdnImuuLYbk
         XOJQB8AkYJkpU+tObIobxEg9wsiN+pCqzpc+Aw0fDYbEp4zSWTT91C9ujnfmoMwS8FFL
         bVyPJChQY2UftsEEjQ/KR80s+1a6ldUxVHs7kYuW67xH7U3NCJstUKpXUGmdp0T/DdiL
         BOicA2AAKs8uXZ4DMkx+pub+/zqC5kEo5qLQLAtxPIlERvpBnvuaJuxy0Qs90Ybre/6T
         eF5EUE4lokJbQQGensUVVSNuKKsRvB4yWKjhAYUDYtWzJFQyLpK7mfRqS/PSTvVDnNaS
         4Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ePJDY1Id0fwmipgSSohUBrFBSRbOMOMWBv/Acn6LGA=;
        b=jq9x8eI+oKstTmUGIg9he9Tg1Js11wQYn6tnXdgbHt0YdRBtF3lGpjyB2e+9BljmNl
         eT8SVEYSY0mmpb3HxoMMBzRU/xS2Oq3P1Su8BR9+6trFhqJpxhTKnCHeyYKSp/3FnKaO
         3LQ0Yu6vuspnK1rF4HBk6snJfZGN21cShekeBqU2f2DUrN42xAlrWC08otCwMfoJIimY
         r9AoaUWfv9zaxMxd3v+RiUfOUpxh5+Gg7HdlbE+yDu9fzSjNwdJ6v/7lhDJW6aRv7njw
         Oq7V5B9sfY4Ze071IFG1+8eJi1Q2IHJDDibkhozQ14tflFpoywUQaPNytFtpG/TGrxsI
         RSGA==
X-Gm-Message-State: AJIora9v5PL1ex+Rae5W6BTbWiMh0CPnLXfqwRryJwOiu5qeGspeyHHc
        VkCOHfOP+d1UPTtw4gzR8YbXJEzANquAHFo1V6A=
X-Google-Smtp-Source: AGRyM1vDIu7VukGWDhnqoQQGlOFOIKeo5FtxQbgxkTTcZq5CfkOcOYFawQQAngHbZkAAw1yYqyHDqDJxGqIPeFJW2HY=
X-Received: by 2002:a05:6402:50f:b0:435:7996:e90f with SMTP id
 m15-20020a056402050f00b004357996e90fmr6528315edv.110.1655932600171; Wed, 22
 Jun 2022 14:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq7d584hqb.fsf@gitster.g>
In-Reply-To: <xmqq7d584hqb.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 22 Jun 2022 14:16:28 -0700
Message-ID: <CABPp-BGGDvZ40TY939fFM0xPZuaogPS+ymfEpc+hv-sJnO8Jcg@mail.gmail.com>
Subject: en/merge-tree (Was: Re: What's cooking in git.git (Jun 2022, #07;
 Wed, 22))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 22, 2022 at 12:41 PM Junio C Hamano <gitster@pobox.com> wrote:
> [Stalled]
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
>  On hold.
>  cf. <CABPp-BGZ7OAYRR5YKRsxJSo-C=ho+qcNAkqwkim8CkhCfCeHsA@mail.gmail.com>
>  source: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>

Can you update from "On hold" to "new patchset exists" (new source:
<pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>) and move it out
from the stalled section?

(Also, FWIW, v7 was collaborative effort between Dscho and I, and
we're now finally both pretty happy with the state of the patches, as
noted over at https://lore.kernel.org/git/CABPp-BFfRGQybYManC6LfFTaAd3mweBxL=APCGP_vRF-WQxGSw@mail.gmail.com/).
