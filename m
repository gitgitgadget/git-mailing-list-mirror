Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC74BEB64DD
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 01:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGZBgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 21:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGZBgV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 21:36:21 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BA62699
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 18:36:20 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bb8f751372so30128895ad.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 18:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690335379; x=1690940179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGrpWSk993ArUMTjo5EzL/7mLw/QfFcO1XiaFkLvi0U=;
        b=LFp1UF5QQUIfte55zxlQjTwG3yPBwa9iicm3GymkkN+3vD2hfjSBQs2glUbajtR/5o
         lGwyPFk67JKoMx5LdAr6hiLeIXlHeFAVw8oI7Gcm9Cvm0AoV0uQAdOMsGEE6awVObVhB
         7CHU8cx4eQGxyvAU49jpW0mZ6z0yXSCUWDE52qbTATVZNNcudFTCxFqnGthYIMI3r4jH
         E+jxwKH2YPUqbJEKumMr71s43iESlQLoLDtsV1szXgvg5I5XKaWYv2uvEBb7Fj9EMBvz
         lHK3h16a+RqF0qIKDfNIS0HBjlXZMwPiRX5OaWvZl57c89oqagmii05peI0etfODRr/n
         QKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690335379; x=1690940179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGrpWSk993ArUMTjo5EzL/7mLw/QfFcO1XiaFkLvi0U=;
        b=CGELbIzkFQUPAc6gkDjdZSF5wW7QQkYBoeBGj2/ereRRlg9sg7yKWAZrqHNhHoBXl4
         9MOHzZbfdgt6BqTnRz+di7W4r1Tamagf52PoCzmtlcwmJ+ifUoUvuhZtuL7kwTachjfM
         hOK0fX6sylhkfmHg50yTBxYTsaVxITICBQvqhEirbRS6Qu+F0Gf+YN2j+DBE5JzOsC6e
         2RM16v9JrYZOaOuK4r1oalgvbTqK5EM2yyb1MSkbcFnV4GioQE1zrpw5mid/u4lGDwXV
         zUxqAdFEJoD3ysPvmU6uiyitcng5L48bKvLTJsZ4HDVp/xsx0KobmdF7do9HAWZZzpdQ
         Fxlw==
X-Gm-Message-State: ABy/qLaXD6aYnzVUSKr5y92YB3ds56eOyC/nuJqVG83PdnPOTCwpB624
        QO8+QhVMEZHhPDx7YpFm3+jGS/6dZsc=
X-Google-Smtp-Source: APBJJlEWMhVK4o77wN2mLLJ3TPW2FvfZ/ABshvnJXnpydGZ/5bgZnxuofqNWgD1XQVL/M7D9fxDVF01PcSU=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:903:41c9:b0:1bb:8e2a:cdcb with SMTP id
 u9-20020a17090341c900b001bb8e2acdcbmr4529ple.5.1690335379597; Tue, 25 Jul
 2023 18:36:19 -0700 (PDT)
Date:   Tue, 25 Jul 2023 18:36:18 -0700
In-Reply-To: <xmqq5y6mpfhm.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
 <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com> <5ec91d02b7ae767cc9b2395e1c0fa10e1424c0c5.1689314493.git.gitgitgadget@gmail.com>
 <xmqq5y6mpfhm.fsf@gitster.g>
Message-ID: <owlyy1j3fo8d.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 5/5] SubmittingPatches: simplify guidance for choosing
 a starting point
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +There is one guiding principle for choosing the right starting point: in
>> +general, always base your work on the oldest integration branch that
>> +your change is relevant to (see "Merge upwards" in
>> +linkgit:gitworkflows[7]).  What this principle means is that for the
>> +vast majority of cases, the starting point for new work should be the
>> +latest HEAD commit of `maint` or `master` based on the following cases:
>> +
>> +* If you are fixing bugs in the released version, use `maint` as the
>> +  starting point (which may mean you have to fix things without using
>> +  new API features on the cutting edge that recently appeared in
>> +  `master` but were not available in the released version).
>
> I think this is technically not optimal, but is good enough for the
> sake of simplicity and brevity[*].
> 
> [Footnote]
>
>  * An very old but still severe bug in tagged versions would want to
>    be fixed ideally not on top of 'maint' but on top of the latest
>    tagged version in the same maintenance track.  E.g. if the commit
>    X introduced the bug, you may ask "git describe --contains X" the
>    oldest version the commit appears in, say "v2.30.0-rc2-gXXXXXX".
>    Then you would run "git checkout -b fix v2.30.9" to start the
>    branch to fix it.

In this example, are we using v2.30.9 as a starting point, not v2.30.0
because v2.30.9 is the latest tagged version that is in 'maint'? 

I think this nugget of knowledge should be included in a v3 of this
series. Will update.

>> +* Otherwise (such as if you are adding new features) use `master`.
>> +
>> +This also means that `next` or `seen` are inappropriate starting points
>> +for your work, if you want your work to have a realistic chance of
>> +graduating to `master`.  They are simply not designed to provide a
>> +stable base for new work, because they are (by design) frequently
>> +re-integrated with incoming patches on the mailing list and force-pushed
>> +to replace previous versions of these branches.
>
> "unstable" is not the primary reason why you shouldn't build on
> 'next'.  It is "your work, if queued on 'next', cannot be merged to
> 'master' without pulling all the other undercooked stuff still in
> 'next'", as you describe in the next paragraph.  But that is
> different from being unstable.  I'd suggest to use something like
> this instead:
>
> 	... not designed to be used as a base for new work---they
> 	are there only to make sure that topics in flight work well
> 	together.  A topic that is literally built on top of 'next'
> 	cannot be merged to 'master' without dragging all the other
> 	topics in 'next', some of which may not be ready.  In
> 	addition, `seen` is frequently re-integrated with incoming
> 	patches ...

Will update. Thanks.
