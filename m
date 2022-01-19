Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DB1C433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 00:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347691AbiASAi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 19:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiASAiX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 19:38:23 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF199C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:38:23 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id u14-20020a170902714e00b0014ace69caccso82267plm.17
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uEw9h6oICG6cR0aJttQtBlvQg17ZSsDlE1mmlMcG62U=;
        b=fBMciwqEDagQqoFHzAIDZszIKLq/OVx3LidYpsSCuR1O/+JMgHI5RLU0VoVh1G0KXf
         yb9VLMwkpSQF+ENCFqz2F115y0MsMw0teZaKo5rxeNbuSpI9+DWhTmk0Edxffbdi7Fpo
         9cNdrgkDbeoRjcYUnjD3MspXLdYNlz2oMvaRLrWITgkQNGfs3XGxbsL89Zs2ka7pcdOu
         71831+TdYtF08Ozu0yGKYGhX6ts1jJWK95+QvzxzS5AjaU18scQ+3h3JrmaI64da48jY
         62LhtZSHNw6jsjAdPerPONje3QeZyqY4RgtWQjy/IQngjMIZYEYe0yAeRpCMDE82NqIZ
         uqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uEw9h6oICG6cR0aJttQtBlvQg17ZSsDlE1mmlMcG62U=;
        b=FRWzumKFZK0jdgK8B6gJFAJmQm+xStFcd0NnoV7PO/mtF3y+1MVToo50Nj3079lCmu
         wQBCONrsg/dJ5vL4mWj1UMQePscPnOSrzI78pT1LiVLhqYU/GkGnCEl/XyMceKKjip/u
         y/Z/+uyVcAZFJ2nqaWvrNW5KL09L7aWPmXi8CfK51Qp98mTNOPGBdvZFg4GGd9H6jvWi
         g4rpvX8aqEHnIt35TANaDz6a++hYvUb5Gv5xEgZyiy7+oM1k0EVVt1cVboURFcOW3a/e
         waUHBaMkMzQrGEsZQKzrdhheU5+JnSOVvmQrnUn1sn23yTQ273EQLsgqEE+j5qpNHFGu
         yJIQ==
X-Gm-Message-State: AOAM532a1YqQDQlcjMZovYT05jO9Ibnm9Ztjux08ZsfAG6L/3rrQUYzm
        TPjrcaVWzJdAsUEthbSE057cGROFw7jREw==
X-Google-Smtp-Source: ABdhPJwpeIyMCbSuROnea2ziUSI2zPXeVQd0D8z8IeUDRg+mnCbUNlc84hWggpQv98OHHE6rWPZtiFw8BQHW0g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4ad2:: with SMTP id
 mh18mr1329280pjb.140.1642552702670; Tue, 18 Jan 2022 16:38:22 -0800 (PST)
Date:   Tue, 18 Jan 2022 16:38:20 -0800
In-Reply-To: <xmqqy23h4nss.fsf@gitster.g>
Message-Id: <kl6llezcy2yr.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqqy23h4nss.fsf@gitster.g>
Subject: ar/submodule-update (was Re: What's cooking in git.git (Jan 2022,
 #04; Fri, 14))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * ar/submodule-update (2021-10-13) 9 commits
>  . submodule--helper: rename helper functions
>  . submodule--helper: remove unused helpers
>  . submodule: move core cmd_update() logic to C
>  . submodule--helper: run update using child process struct
>  . submodule--helper: allow setting superprefix for init_submodule()
>  . submodule--helper: refactor get_submodule_displaypath()
>  . submodule--helper: rename helpers for update-clone
>  . submodule--helper: get remote names from any repository
>  . submodule--helper: split up ensure_core_worktree()
>
>  Rewrite of "git submodule update" in C.
>
>  Expecting a reroll?
>  cf. <YWiXL+plA7GHfuVv@google.com>
>  source: <20211013051805.45662-10-raykar.ath@gmail.com>

How close are we to getting this into 'next'? Last I checked, it seemed
like the only remaining piece is to rebase this onto
es/superproject-aware-submodules.

I have some planned work that will teach "git fetch" how to clone newly
added submodules (this is the issue described in the BUGS section of
Documentation/git-fetch.txt). That work will probably use the same
machinery as `git submodule update`, so I'm wondering whether it's
better to base this new work off ar/submodule-update or master.
