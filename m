Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBC5C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 22:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245294AbiHRWm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 18:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245196AbiHRWm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 18:42:26 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEA8DC0A3
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 15:42:25 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id a16-20020a17090abe1000b001fad8c29b0bso842511pjs.2
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 15:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date:from:to
         :cc;
        bh=G5Zs1drksnzwGycEBbZ2n2DZUZadI1m2F+JX4YKT26w=;
        b=H9FgaPi+aKwWpJK/nz31+lVjosL3sjPDzFqyD4mgEeHjRMq/X2ccJsah8g4uw1DJj3
         NfmiLb8ZPKONQn2+8NmFwo9e+TwIPFqIKoi8A+lZa1vg2yMjQU7xlVMggUAI2X9DJxxm
         6zWenxXUVVQLJfVDlnjJvWl1w5/9XXyUG2H59HAmRYqogUmeHew27/KPE5IQF1ViFvl0
         HPr8Fs/GNpeifixBlwKK5S87XIRNGk3/V3WvEvJS5yS3EcSLrPfbWoQnf+HrhJfmMgNY
         9e6uQpZaML4O2V85HP1rymHojnGYvVRr/WdUY7VXoNZ3xiSKVh19Q2fG0ywE414ye81b
         1fSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc;
        bh=G5Zs1drksnzwGycEBbZ2n2DZUZadI1m2F+JX4YKT26w=;
        b=4rOx7mqNiM5lCQiKah52jbFR0b8lI7DEQikD5z3woNaMOWmglmxeCB1qqBClJnz2Oi
         wVAKkg7gIPo5Df2ymtgnrqPsoqnfHF2gVfAKC/Ly3kx76lMcwnxt/hx++qRveAy7xrNs
         MK4hnRNlJ2ZMtimTlxUZMQPrb2VtVBoMEL9Zwm1rpf5VZhyS2DTR9HbEiynkqu7+m0eD
         rXdjTfO7jYJKcPW5ofHOpAWf53+f5HiDkpwc/eRxJEezJeLgaz9LucNzI2NvRElqMY4c
         F0QQxDhk6AkRet1q0akGEh1KLXhUOlwwAYVwK7EC0FX8JjGEI56MKRC6NSuCQsomx1oq
         2enQ==
X-Gm-Message-State: ACgBeo32Og1N/hJIZdN2AmuDez29eUbXA8GNxMItq3i1PO5WUNeAT4Eu
        vSuTPZBHyhWfb+ZRxfaSHiQh5eh739nG/Ky9kHjt
X-Google-Smtp-Source: AA6agR6qLAkCM+JBEaQVZr6g30VXv/R3UkOCYOuTSlndDYrxGoTi07rK7+Y0c4QOs2sejhU3oBjIIYbidYuve9ColaPq
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:2402:b0:52c:81cf:8df8 with
 SMTP id z2-20020a056a00240200b0052c81cf8df8mr5017210pfh.60.1660862545065;
 Thu, 18 Aug 2022 15:42:25 -0700 (PDT)
Date:   Thu, 18 Aug 2022 15:42:22 -0700
In-Reply-To: <xmqq7d36s31e.fsf@gitster.g>
Message-Id: <20220818224222.3569397-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: Re: What's cooking in git.git (Aug 2022, #06; Wed, 17)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> * en/ancestry-path-in-a-range (2022-08-17) 2 commits
>  - revision: allow --ancestry-path to take an argument
>  - rev-list-options.txt: fix simple typo
> 
>  "git rev-list --ancestry-path=C A..B" is a natural extension of
>  "git rev-list A..B"; instead of choosing a subset of A..B to those
>  that have ancestry relationship with A, it lets a subset with
>  ancestry relationship with C.
> 
>  Will merge to 'next'?
>  source: <pull.1303.git.1660704498.gitgitgadget@gmail.com>

I had some minor comments [1] but besides that, overall I think this is
good.

[1] https://lore.kernel.org/git/20220818222416.3567602-1-jonathantanmy@google.com/

> * en/submodule-merge-messages-fixes (2022-08-17) 3 commits
>  - merge-ort: provide helpful submodule update message when possible
>  - merge-ort: add comment to avoid surprise with new sub_flag variable
>  - merge-ort: remove translator lego in new "submodule conflict suggestion"
>  (this branch uses cw/submodule-merge-messages.)
> 
>  Further update the help messages given while merging submodules.
> 
>  Will merge to 'next'?
>  source: <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com>

(I reviewed a newer version than what's currently in
https://github.com/gitster/git.)

This looks good. I would have rewritten the last sentence of patch 2's
commit message as "Initialize it instead to the generic
CONFLICT_SUBMODULE_FAILED_TO_MERGE value. There is no change to
user-visible behavior, as the only time this variable is read is when
printing submodule conflict information, which special-cases
CONFLICT_SUBMODULE_NOT_INITIALIZED and
CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE, and treats everything else
identically.", but the existing commit message is fine too.
