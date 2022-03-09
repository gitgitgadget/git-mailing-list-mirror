Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2107FC433FE
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 22:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiCIWLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 17:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiCIWLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 17:11:09 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B61201B7
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 14:10:09 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id s12-20020a17090a13cc00b001bee1e1677fso2231162pjf.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 14:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=px11QaT2MqaG67e5a9Ld65ZjMrKJHnMCwpE5/IDAkB4=;
        b=VjZUlh10z7lDULBUXu2VtncB/MayFnWAI0BOdWbD3YfvDgx71vo42Ngbt8gCPcgUd3
         Y4ACiZ3ig174BhNIX26isg9zhAq66HcGlPNznlW/PuHoMJ42EmUUL+X6nTpii4vj0XLM
         FiwwmzhHnI64r8WSwNKS4Bsei2Zu2LrKopSKDfIFF+NYFFh3MKTHqKmv6SGoqG3hZ5hO
         k9vfrhxQLd8ikSxOrxPObH09w/kstujTVMlbu3SWA5NCEr9TnvwhB7tRBl8ervGcl+rH
         q/dbDX3e8XVrvoW8hicLcVem6C4BUHGSRXxIbqntEYXWbSjJO0edauvKDvLBnCQzkjd6
         wnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=px11QaT2MqaG67e5a9Ld65ZjMrKJHnMCwpE5/IDAkB4=;
        b=A8sKhy7h6S+/d43Pc6k83JTzOZkeAk9NhQynje0l1ABmfEdUP0ixO9rZvMBbgdfHuD
         57n2X23a/rUfzGzV1DLb10PqbA/IInhk61jT+qdAZyeLGQdKGzWsBVDeAzv3rLjwMghX
         C4p6QbuahwswNF9btEptUCbELHH+M/tEIwojTNRwHNV5RP25agkypIsV5syby8i3D6ez
         FjW5XbsLrgaJbNkM/C7qAd20CCeNDU4Lqkg0LSxXAS5y3P4VgLQ1Vm63RTEo3OIRID3y
         RA+fe/8srIpGzxHgGv5Od8omFRqh8ufU0aJxWkeMC3F1653esyuwgn1Bs+gI4sj43ULF
         T/0w==
X-Gm-Message-State: AOAM533qrNguRh7Q2VEHKMF8IX3KQGmSN8XPdpEz6rE9Kwe40X/Z6JEg
        VP/AClxrPe+gKxBmTXCF+gqAowv1Dy7osA==
X-Google-Smtp-Source: ABdhPJzktQUbSKGJs3UW4AWGXHgk0LUXdyWWxrifxV3erZokqm0x7iUsdfMKpmC+c+QLGBilanvicRq24bcg5Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2481:b0:4f6:b71f:3330 with SMTP
 id c1-20020a056a00248100b004f6b71f3330mr1521869pfv.47.1646863809195; Wed, 09
 Mar 2022 14:10:09 -0800 (PST)
Date:   Wed, 09 Mar 2022 14:09:58 -0800
In-Reply-To: <xmqq7d93kjsy.fsf@gitster.g>
Message-Id: <kl6l35jq6amh.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqqilspp5yg.fsf@gitster.g> <kl6l8rtj57gh.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq7d93kjsy.fsf@gitster.g>
Subject: Re: ar/submodule-udpate (was Re: What's cooking in git.git (Mar 2022,
 #02; Mon, 7))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> * ar/submodule-update (2022-03-04) 13 commits
>>>  - submodule--helper update-clone: check for --filter and --init
>>>  - submodule update: add tests for --filter
>>>  - submodule--helper: remove ensure-core-worktree
>>>  - submodule--helper update-clone: learn --init
>>>  - submodule--helper: allow setting superprefix for init_submodule()
>>>  - submodule--helper: refactor get_submodule_displaypath()
>>>  - submodule--helper run-update-procedure: learn --remote
>>>  - submodule--helper: don't use bitfield indirection for parse_options()
>>>  - submodule--helper: get remote names from any repository
>>>  - submodule--helper run-update-procedure: remove --suboid
>>>  - submodule--helper: reorganize code for sh to C conversion
>>>  - submodule--helper: remove update-module-mode
>>>  - submodule tests: test for init and update failure output
>>>
>>>  Rewrite of "git submodule update" in C (early part).
>>>
>>>  Will merge to 'next'?
>>>  source: <20220305001401.20888-1-chooglen@google.com>
>> A comment on the branch name: we kept the name 'ar/submodule-update'
>> from when Atharva Raykar <raykar.ath@gmail.com> prepared v1 of his
>> series that converts all of "git submodule update" to C. When other
>> authors sent subsequent versions, it still made sense to keep this name
>> because the patches still reached the same end state of having all of
>> "git submodule update" in C.
>>
>> However, I've since broken this series up in two (to play better with
>> other topics), and the above-named patches don't do a _full_ conversion
>> of "git submodule update". Is something like "ar/submodule-update-1"
>> more appropriate?
>
> You've already taken over the ownership of the majority of patches
> in the series, and it may not be a bad idea to rename it to
> something like gc/submodule-update-part-1 before it hits 'next'.

Sounds reasonable to me. That's similar to e.g.
ab/config-based-hooks-[1|2], which used to be es/config-based-hooks.

> How many more parts do you anticipate to have, by the way?

Just one more (thankfully) :).
