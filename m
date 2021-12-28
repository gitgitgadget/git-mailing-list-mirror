Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603BBC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 17:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbhL1Rmw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 12:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbhL1Rmv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 12:42:51 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A45C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 09:42:51 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id q14so68863570edi.3
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 09:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8K+PsDvvy5SYQjh4APqoz1zyrU35aeq/B38BrgNBs1M=;
        b=EY/oaCZaIGVaDbv2sN9Lh2Bv0xzPjR4gQa4iLVyrrxJdWuXzGP1JNyS5XeWNbguzrg
         mqxF7qg7twUosq3ABFj6oORziKEiNAQ8mU+4YfrE89uCpEXGr73hcYV43xgdgazEu1Br
         JEmnLDYJYMBeJaG1EgbCRbq2TzKAhYk/ekigPiGSl6dbi3GQPrii7T7T5pto7Fotjf5H
         KOftxO1/AhGpzYcrJSVYIBROrj6/sNhTXVrS8/M5FmLSxllO21f170vjaqWtZ8qhuzl/
         vwDuO9hdyohl/2EsOrO9ZVxKEuh9YYyWv+rtwYytuUFYzYL4iKbn+z2HVDmhttkaqITN
         c0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8K+PsDvvy5SYQjh4APqoz1zyrU35aeq/B38BrgNBs1M=;
        b=rOoF/ND/hQdn/cOgFYdQrlBF6H3XjTIdey9T5SLBiXuaiA2nwHyQH9ygvqD1fXDDMq
         e0ExRYum9kxgdF9X/YaFrNbJ0s/K5DsVITM0kVuak81HCwasaYMyu4TzoZgy7Bqii+HD
         0RXGPhnTvIuFeZd9nzXafsUIbQyOtVvum7e8Hv/SpI01Eb+BgrGnatPjjBzYZMvXZ89G
         coVH3fW4zsXnW+pR3j0UqoCf8vCAOZkQCh2L5xQ0UCK4ZfKnf1wBi7yqXlQf3b/FggWn
         DlSajrypZ+/e4RsVjc+42bpz/+70hwH2yjSmUhq36Xa1NNppJDyYdCvQZsXLeN0kKWry
         0r1A==
X-Gm-Message-State: AOAM530ne7uBZoepo7ssQOxYfvtUo52JCfFCGlMISxqSYe9/43GBQI0O
        X/6Dx4znToslQHC5a+adnhwOSNy9n1aqPVSP8DzPVc4YLrb6xA==
X-Google-Smtp-Source: ABdhPJxKMDbkwMi/iiWedkN360LsQdYwWT0GOQJ09x6vakMmgY4r+iUHBkBQZRC6mpMVkuQI4apDt1LhitHJj8H0JmQ=
X-Received: by 2002:a17:907:3f1e:: with SMTP id hq30mr17799112ejc.613.1640713369395;
 Tue, 28 Dec 2021 09:42:49 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7dbpvb0q.fsf@gitster.g>
In-Reply-To: <xmqq7dbpvb0q.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Dec 2021 09:42:38 -0800
Message-ID: <CABPp-BFR29S-Pwq9LZEOjaCxozTV9mkUBpd2SLGwh7jNW+On4w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2021, #06; Mon, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 3:27 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> * ds/sparse-checkout-malformed-pattern-fix (2021-12-25) 4 commits
>   (merged to 'next' on 2021-12-27 at c410caf527)
>  + fixup! sparse-checkout: fix OOM error with mixed patterns
>  + sparse-checkout: refuse to add to bad patterns
>  + sparse-checkout: fix OOM error with mixed patterns
>  + sparse-checkout: fix segfault on malformed patterns
>
>  Certain sparse-checkout patterns that are valid in non-cone mode
>  led to segfault in cone mode, which has been corrected.
>
>  Will merge to 'master'.
>  source: <pull.1069.v4.git.1639671222.gitgitgadget@gmail.com>

Eek, this was merged with the "fixup!" commit to next.  I think that
was a mistake...but what's the plan now?  Merge to master as-is...or
revert from next, then squash, then re-merge?

> * gc/branch-recurse-submodules (2021-12-25) 7 commits
>  - fixup! branch: add --recurse-submodules option for branch creation
>  - branch: add --recurse-submodules option for branch creation
>  - builtin/branch: clean up action-picking logic in cmd_branch()
>  - branch: add a dry_run parameter to create_branch()
>  - branch: make create_branch() always create a branch
>  - branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
>  - Merge branch 'js/branch-track-inherit' into gc/branch-recurse-submodules
>  (this branch uses js/branch-track-inherit.)
>
>  "git branch" learned the "--recurse-submodules" option.
>
>  Will merge to 'next'?
>  source: <20211220233459.45739-1-chooglen@google.com>

Can we squash the "fixup!" commit before merging?

> * ab/cat-file (2021-12-25) 11 commits
>  - fixup! cat-file: fix remaining usage bugs
>  - cat-file: use GET_OID_ONLY_TO_DIE in --(textconv|filters)
>  - object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
>  - cat-file: correct and improve usage information
>  - cat-file: fix remaining usage bugs
>  - cat-file: make --batch-all-objects a CMDMODE
>  - cat-file: move "usage" variable to cmd_cat_file()
>  - cat-file docs: fix SYNOPSIS and "-h" output
>  - parse-options API: add a usage_msg_optf()
>  - cat-file tests: test messaging on bad objects/paths
>  - cat-file tests: test bad usage
>
>  Assorted updates to "git cat-file", especially "-h".
>
>  Will merge to 'next'?
>  source: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>

Can we squash the "fixup!" commit before merging?

> * jt/conditional-config-on-remote-url (2021-12-15) 2 commits
>  - config: include file if remote URL matches a glob
>  - config: make git_config_include() static
>
>  The conditional inclusion mechanism of configuration files using
>  "[includeIf <condition>]" learns to base its decision on the
>  URL of the remote repository the repository interacts with.
>
>  How does this one look these days?
>  source: <cover.1639509048.git.jonathantanmy@google.com>

I gave it my Ack, though it appears we are solving the
make-it-easy-to-include-pre-vetted-configuration multiple different
ways with various caveats.  While each case makes sense to me, I'm
wondering if there's some more general solution that we should work on
at some point (see
https://lore.kernel.org/git/CABPp-BFLNqLuJ8o_6YZDYgd=Ft+wc9EjBPX+RRzwAdASKSW2bw@mail.gmail.com/).
But that need not hold up this series right now.
