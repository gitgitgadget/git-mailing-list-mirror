Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8041FC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 18:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbiCISEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiCISEu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 13:04:50 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4DC1261E
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 10:03:51 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id f18-20020a623812000000b004f6a259bbf4so1951361pfa.7
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 10:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=cSNCe9tzRfZRE3KAQRmf9IF4z90VojgbF5fEKjHNfCo=;
        b=tnIyCiaqskeACMFOIP+61VTP/e9yb16kdCwEc4MM4Es8cU0VWQvoV9g7kY/AMpuqhB
         6K833NuCOEFiyAnq+qk0P5O9YpRMcUb6Y3djOvVmo5jSV6cm3uHi3MNWPAFjBreEhWB0
         5H69Kr+evRew+KtH7r3ZiOjh3RQgCnM+t4cEETEd/rjbJgEsKidhPXjXr8JjlvVviEBs
         5Gl4AiHBR8QR4q7wOAL7pilsnoqRB1UgHP1wKy0gI5q1AKUWu9Up+/wPbfn/fqVe5swd
         MsPvG4jFO4TNCewk892mhiO3Sygb3TnXRLJgGP07QD49HTIkXofW6j6oOsbbhorpg77i
         d3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=cSNCe9tzRfZRE3KAQRmf9IF4z90VojgbF5fEKjHNfCo=;
        b=33XEj6/DsMWx+CQlAu/SjUAwBp2WLtMoUnyGoVCmbi2V+T6RG/VrkfeyyEVo1pJJda
         io8/3Zj9oU18ZUNS8eYDYKtl1W/nepBw9g5uFqaU9xKU0/bn3RL+BrCZc899FwsRUN9c
         MsDLmQOeV/mZiRcf5g2o6Y9xOJHjuK45Ao18kpX3E2IxZY7dB1u6/fVxSln7W2xMo3IW
         SwzQ0FSSVKGsjZjpHWibPkY2JyQqM+Xj6o/EMORDJacU9suhwRZMgad4EwPIC4qv732o
         qGWUZlR/x1t77pmQwYvqsmuX15DglQRo4o07H2tJrCIUXv/kL7k9lji+k1CRyYe/JO30
         TaJQ==
X-Gm-Message-State: AOAM533ukNkPI/LbyS9f9o9s+m/qIaHavoEeDN9ATWbMLPki9iCAuTob
        0x9ZZI0wDf+j+HctIXtQE+DsWgc98gQFYw==
X-Google-Smtp-Source: ABdhPJwfJlfx77HL4nkoopfWdIIXt9LZgqqyf4bWpg4YwIrPP91ffleDkbJ2Ojs2B0rtg8ov6lr+EW66vj05Cw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:8203:b0:153:2e8:aaae with SMTP id
 x3-20020a170902820300b0015302e8aaaemr902534pln.14.1646849030879; Wed, 09 Mar
 2022 10:03:50 -0800 (PST)
Date:   Wed, 09 Mar 2022 10:03:42 -0800
In-Reply-To: <xmqqilspp5yg.fsf@gitster.g>
Message-Id: <kl6l8rtj57gh.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqqilspp5yg.fsf@gitster.g>
Subject: ar/submodule-udpate (was Re: What's cooking in git.git (Mar 2022,
 #02; Mon, 7))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * ar/submodule-update (2022-03-04) 13 commits
>  - submodule--helper update-clone: check for --filter and --init
>  - submodule update: add tests for --filter
>  - submodule--helper: remove ensure-core-worktree
>  - submodule--helper update-clone: learn --init
>  - submodule--helper: allow setting superprefix for init_submodule()
>  - submodule--helper: refactor get_submodule_displaypath()
>  - submodule--helper run-update-procedure: learn --remote
>  - submodule--helper: don't use bitfield indirection for parse_options()
>  - submodule--helper: get remote names from any repository
>  - submodule--helper run-update-procedure: remove --suboid
>  - submodule--helper: reorganize code for sh to C conversion
>  - submodule--helper: remove update-module-mode
>  - submodule tests: test for init and update failure output
>
>  Rewrite of "git submodule update" in C (early part).
>
>  Will merge to 'next'?
>  source: <20220305001401.20888-1-chooglen@google.com>

I don't anticipate further comments, so I think this set of patches
should be pretty safe to merge :)

A comment on the branch name: we kept the name 'ar/submodule-update'
from when Atharva Raykar <raykar.ath@gmail.com> prepared v1 of his
series that converts all of "git submodule update" to C. When other
authors sent subsequent versions, it still made sense to keep this name
because the patches still reached the same end state of having all of
"git submodule update" in C.

However, I've since broken this series up in two (to play better with
other topics), and the above-named patches don't do a _full_ conversion
of "git submodule update". Is something like "ar/submodule-update-1"
more appropriate?
