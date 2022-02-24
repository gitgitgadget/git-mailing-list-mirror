Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAA1C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 17:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiBXRt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 12:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiBXRt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 12:49:28 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EF21A8065
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 09:48:58 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id g19-20020aa796b3000000b004e136dcec34so1628591pfk.23
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 09:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Acr3tgFbCbSSv6ABClCCG/CfKZl6vKRMVWBF3Sy/lhg=;
        b=YAz4CtswgXPrsI48791c9HhFVGd76Boauo4eMRq9VSprg749CI9xX2mm9IJslovTxc
         BbwfplDo3Y0wgaTsQNogy5whBN1VsVpSWTEgjjkOgYQ7bNjRsDTYp1VLD0s4kfqNWCsM
         IGFz30t/tQvnSX2+RenL+nSo+TouREGt0IkcZBwkeIZLQ8R3nyjf38Sld6NO+D+CJl4g
         UbigMd33SjzinTBjv4QO5CHDDms9QCqZ+DyyCq1BnRhRs52PqvRj8jvJAiMZRwW37J60
         fSksLYKS9plvMjU1d1Yb/bmA6YAQUKqKFyYxaXgEMK2Bsz8ZZ9nm7AKdZjYSm2rCraBy
         DXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Acr3tgFbCbSSv6ABClCCG/CfKZl6vKRMVWBF3Sy/lhg=;
        b=uMouNSOppgmbEDhJoMgmJLtzLWOY93ctZk79rvIVrnkwLBJjVldzXqBkU+8DGP7l7m
         PGgFEhPrXPsncVrOOAlBzTaWSILPkAJObYAl8D+9ByYFc7nPJwv/LINPIixKaJhPIVhc
         xbew0HO00BxNfo1jaJVWmspNtU55yC9IAYcIzwgic+G/YWJ8mw0ICfNfDqReoZ3s0Pk4
         hthLPfP44lek1JpfTnncX+iEWeSU4Us3RqrH6DkG2VH175Qj7qhBEKy2mSKKJ1+15npi
         1tv7rqd7NmDEmLuqF2OQ6Kj3oXhxAWtpk+744dQ68aV7Vs9j+HIZ7eJL3+LL6DfhZLj0
         SGUA==
X-Gm-Message-State: AOAM531yB+aEtKBHMPyLHbMxu/x/M7ZsWmGFwOmJwcC16PWHX8LDeiL5
        hmvU81gZxYWcsYyCJTDX8cuDami+6Gq92A==
X-Google-Smtp-Source: ABdhPJwUBMgGrr3hUUWoLlfpTU5rHWLRTGT7tRVg+K6Tz/8zXakFxIGEGArmlpf03LaYI0HrLFRvuAMox5bW3Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:9008:b0:14f:b1f9:5271 with SMTP
 id a8-20020a170902900800b0014fb1f95271mr3601467plp.86.1645724937345; Thu, 24
 Feb 2022 09:48:57 -0800 (PST)
Date:   Fri, 25 Feb 2022 01:48:55 +0800
In-Reply-To: <xmqq1qztortk.fsf@gitster.g>
Message-Id: <kl6lmtig40l4.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqq1qztortk.fsf@gitster.g>
Subject: ar/submodule-update (wa Re: What's cooking in git.git (Feb 2022, #06;
 Wed, 23))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * ar/submodule-update (2022-02-10) 20 commits
>  . fixup! submodule: move core cmd_update() logic to C
>  . fixup! submodule--helper run-update-procedure: learn --remote
>  . fixup! submodule--helper run-update-procedure: remove --suboid
>  . submodule: move core cmd_update() logic to C
>  . submodule--helper: reduce logic in run_update_procedure()
>  . submodule--helper: move functions around
>  . submodule--helper update-clone: learn --init
>  . submodule--helper: remove ensure-core-worktree
>  . submodule--helper run-update-procedure: learn --remote
>  . submodule--helper run-update-procedure: remove --suboid
>  . submodule--helper: reorganize code for sh to C conversion
>  . submodule--helper: remove update-module-mode
>  . submodule tests: test for init and update failure output
>  . submodule--helper: don't use bitfield indirection for parse_options()
>  . builtin/submodule--helper.c: rename option variables to "opt"
>  . builtin/submodule--helper.c: reformat designated initializers
>  . submodule--helper: run update using child process struct
>  . submodule--helper: allow setting superprefix for init_submodule()
>  . submodule--helper: refactor get_submodule_displaypath()
>  . submodule--helper: get remote names from any repository
>
>  Rewrite of "git submodule update" in C.
>
>  Does not seem to play well with other topics in flight, with heavy conflicts.
>  cf. <xmqqv8xj71mt.fsf@gitster.g>
>  source: <20220210092833.55360-1-chooglen@google.com>

I've dug a little deeper, and I think my plan to reroll this as two
series [1] makes sense:

1. Small, obvious conversions from sh->C.
2. Finalizing the conversion.

(1) has only trivial conflicts, and is relatively easy to review, so I
expect that to go through quickly.

This should also buy some time to finalize those other topics and
hopefully make coordination simpler.

[1] https://lore.kernel.org/git/kl6l4k4y59p4.fsf@chooglen-macbookpro.roam.corp.google.com
