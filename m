Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB75C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 22:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbiADWU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 17:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiADWU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 17:20:27 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C05C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 14:20:26 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id b4-20020a17090a6e0400b001b179d36a57so647534pjk.6
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 14:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QaCLHvXJlwdu3kWBdujYT5QYOHTOgKElMtEEpuHxo+A=;
        b=O4ADAbsBbbQq64l8zlujWPsyzL1o/ogmc2ncGymTotUoUMNEHPnuCBOwXLjrG4Iotp
         rhvDZ9G8KDkd7vrDnhiKJe5E3AL+o6OL94z3ph1Dla/2d+nbXrkXwWJu7JL5PK4+e5pT
         iVBX8eSl/LMrJuU4+wg3qzxCXwEQm5wSYbOrMCITzdKu0dQpDhleuzR1+YkR6Wj8ckCn
         z/8P8Jr2ujMkEWHB6jGV83Iur2Cas/suzJ+DRgXcuHkSGZfwgEoL20juSpkdG4HGkhSz
         Fc+wlyRw2hAekveC5eQpm93M9JqA+VNqHwIZqwwqK1cpk0LpJ08HCxeLHaUfg7u/4TOo
         iKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QaCLHvXJlwdu3kWBdujYT5QYOHTOgKElMtEEpuHxo+A=;
        b=k224hfOhtB555sXPzsbz5M49ACoU836yiwM8Ah0SPF9w4ebG47UnxPugmerg3gvcDx
         D71aB8Dl5DfNUno42bnAMBy+noHMFeMHG0GlLdtV3V+CNuBlvynEiKcMbEguVMIVw/f5
         Tw9VckHXlSx8SUiW+uG1CuvXpG2uMv+95JYXLEs3Zo+ufOwXH6gDDM85MncywhDh4LIL
         HKDxjW0HdDDera6jsujTyD5QcPZjHvtYIHwUMXIiJM92UXNs68PgktPNgM9y55bynH0W
         7qt1LFHiaIkwutUAcjKnjTGO1N+/rU7tHaPsiLFkIOgcCrnjGTzolZk5ZLrIYeOlHFT1
         Ltvw==
X-Gm-Message-State: AOAM532EvbWXG/yp8ZSI76/zNdxep30N113jUTYgIOYnrxa5uQD/wLMV
        njI9+AGp0Xbzy7cQ2jPy1vcEcvxbgwt+yA==
X-Google-Smtp-Source: ABdhPJys31x+4KWUkI+Js2qibuMXybr6UxA4Xrf4DFGv/1rp7AI7CeMDUbUGm1y4ZtmPuIV4FRYRhWKT0iu6Hg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d2c3:b0:149:c577:8f31 with SMTP
 id n3-20020a170902d2c300b00149c5778f31mr4746757plc.166.1641334826367; Tue, 04
 Jan 2022 14:20:26 -0800 (PST)
Date:   Tue, 04 Jan 2022 14:20:23 -0800
In-Reply-To: <CABPp-BFR29S-Pwq9LZEOjaCxozTV9mkUBpd2SLGwh7jNW+On4w@mail.gmail.com>
Message-Id: <kl6ltuej6t3s.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqq7dbpvb0q.fsf@gitster.g> <CABPp-BFR29S-Pwq9LZEOjaCxozTV9mkUBpd2SLGwh7jNW+On4w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2021, #06; Mon, 27)
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> * gc/branch-recurse-submodules (2021-12-25) 7 commits
>>  - fixup! branch: add --recurse-submodules option for branch creation
>>  - branch: add --recurse-submodules option for branch creation
>>  - builtin/branch: clean up action-picking logic in cmd_branch()
>>  - branch: add a dry_run parameter to create_branch()
>>  - branch: make create_branch() always create a branch
>>  - branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
>>  - Merge branch 'js/branch-track-inherit' into gc/branch-recurse-submodules
>>  (this branch uses js/branch-track-inherit.)
>>
>>  "git branch" learned the "--recurse-submodules" option.
>>
>>  Will merge to 'next'?
>>  source: <20211220233459.45739-1-chooglen@google.com>

Is there anything in particular blocking this series? e.g. does it need more review?

>
> Can we squash the "fixup!" commit before merging?

Makes sense, I can squash it :)
