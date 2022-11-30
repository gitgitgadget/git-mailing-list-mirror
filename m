Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E664C433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 18:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiK3SIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiK3SIl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 13:08:41 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48313554C2
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:08:40 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id 94-20020a17090a09e700b002191897f70aso2652217pjo.9
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PeKhtP+qWaCoJ5cp5WbfNutU2NYdzeIxXw3ricRRGMw=;
        b=IuonjH24SHJDGRKJF7hmruYxmwoMNn5aySkfQNrMTGBchqfgi/xnBFz318FdIMHnKK
         lZaqlXcPLgfoBqF/PLRGZ7rG1AKmlQMnpg0wQDPJxKE35Mdvr3uRThTCILuJyGZ/VqRD
         yx1j3PxcCk0G54VeEaGwEUnWh75KC4Xmq3UWMYo2hns86VRiEE1pv+qFTi7yHM71ITVo
         QUkpEP+dKzBLIbwttQPLdK25WLsqpffKKc0TNLMpq9DpUiVo/+fTWzHSPiHNwg1hJtn+
         5HTe0hQAiEMXlksvUf9JrXQE+93njC62rkM24CHhc+2/0HYbNqliiKpvUTasA82V93mY
         J2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeKhtP+qWaCoJ5cp5WbfNutU2NYdzeIxXw3ricRRGMw=;
        b=CBUgfVnaqptgNc018zn7ql4JQkxiLhhOD4Qv7MR6xmgqP5v1n2W/r/nI/kBGjflL7t
         /of4nrEl87xHgaX1YxiI7m1OipM2xUnAQbIz2PutwG5zm4zpKIMGOV/BmXzP3yqRlM+k
         xeKtp20FcvU6V15ah0be3xmyWsWshej94ug655Rpq1drTt7dWH3g4s0fAojo6F7SLHlw
         sgciXmLKz0yuDmHgA08xgIRMZKHQPWQlUIDNGJsFE9bbPB9fG4OozmSoKUkWsqu1ZaKk
         yiPnPfpC5gqtyJ1rRJviZSwHxcgm+dMJCJH7Y1DuR/Jrr2FXNC1gZv4uf9Gh+ztlC6nV
         DGYQ==
X-Gm-Message-State: ANoB5pnBKgOGf093BYEutXn1BlXEV5Tz8HU8RqRqFvbL10bCC6E+kzYr
        u/WD/F9DzVHG1/SOzSQdJC2NNg17fV+Arg==
X-Google-Smtp-Source: AA0mqf5MxDXyHPJ2UWPmC1uicy4G+HqD/c/05CnoTkEeu5a9AF04T+zBu/nvtvX3SBBEsyFqDTRxOEk0g/HN0g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:2154:b0:189:98b0:8842 with SMTP
 id s20-20020a170903215400b0018998b08842mr10944590ple.103.1669831719789; Wed,
 30 Nov 2022 10:08:39 -0800 (PST)
Date:   Wed, 30 Nov 2022 10:08:38 -0800
In-Reply-To: <xmqqedtl14xr.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqsfi22j67.fsf@gitster.g> <kl6lpmd5d1e8.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqedtl14xr.fsf@gitster.g>
Message-ID: <kl6lk03cqpqx.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: What's cooking in git.git (Nov 2022, #07; Tue, 29)
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> * gc/submodule-clone-update-with-branches (2022-10-30) 8 commits
>>>  - clone, submodule update: create and check out branches
>>>  - submodule--helper: remove update_data.suboid
>>>  - submodule update: refactor update targets
>>>  - submodule: return target of submodule symref
>>>  - t5617: drop references to remote-tracking branches
>>>  - submodule--helper clone: create named branch
>>>  - repo-settings: add submodule_propagate_branches
>>>  - clone: teach --detach option
>>>
>>>  "git clone --recurse-submodules" and "git submodule update" learns
>>>  to honor the "propagete branches" option.
>>>
>>>  Waiting for review on the updated round.
>>>  source: <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
>>
>> Jonathan left adequate feedback on the updated round, and we had decided
>> on a direction for the reroll in [1].
>>
>> However, Calvin is also looking at how we could parallelize worktree
>> updates to speed up "git clone --recurse-submodules", so the Google
>> folks are taking an even bigger step back to figure out how worktree
>> updating should look, which will probably end in a different approach
>> from [1], but it should answer the questions on that thread about "git
>> checkout" with branches.
>>
>> [1] https://lore.kernel.org/git/20221123013319.1597025-1-jonathantanmy@google.com
>
> Thanks for a status report.
>
> So it sounds more like "discard for now" to expect a fresh restart.

Yes, that is accurate :)
