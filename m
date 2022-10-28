Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB94C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 18:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiJ1SSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 14:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ1SSb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 14:18:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2897D241B3B
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 11:18:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so5262345pji.0
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 11:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Kjw/P+SVYSra55MaHRKEROV+gkYlwi9pEaC9QW+98M=;
        b=dCeVPQb4AwcoHn0uIVMOWBxlaV+BkMeVaJ7dZDuPHbVIMKx46fwvB0n0fAseBYCGHw
         i6OV9i/6rJFiI7Ogyz/1S5xtzzK0OqjEv1lvHxpGGX1IvAXJF6o5/c2cCz68aeWJEN0L
         1BizPpsCr65SA6JKd8SnaZ/NLKHjrezZyabEx5G3pV0xjQlUeUydP6x259VV6TL+d6hv
         HeZ/OikV+gngnoSk3Bt/HeHMrppdIERyTwVuwX03cWE/UJr8HDqn9o5XCQv3FTWNsc7m
         9sHTToTzjRjxAM352rLpibLuK6HQGsvlqkN6FZoDIN5DWa7lfxtAFJlFOzDFUJyMwC8I
         MTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Kjw/P+SVYSra55MaHRKEROV+gkYlwi9pEaC9QW+98M=;
        b=rt000Jt64H0WpLf93Ffqgc9RlZXMfI9geT3H2/z5iNP3Ca9CvZFWkvkJiOhyftj362
         nqqJV3X+dnU3YRGkAIAW0azYWEWGno6Oep+E/pwlssYH5dgQ0go4AwI2PCWkJFaZiLdQ
         Y4JOQXuiSdGd43+wU/tOFMMigKwCVZ8kWV015JGU8rp1JZNH85igXopHpbt3z/+9m32U
         lWOK9Vv2B3AnVq6JasJXiunEJIcQZs+tP1JzFMxhV3Ekt5xrviY8frJMFqAM9zMDp9At
         g/P70HG6qU0SJdHFzs9ekkrwr7ka00OcHt8hoh9Na18aIjirvP6AUGCErwKuyUyNo+05
         WQxg==
X-Gm-Message-State: ACrzQf3VHxcHNZB/ONTyAa24eYO2amyH9Smly5QL87PCx90vdz25/IyI
        mBEUDalR/3bqmDM4yjiNzk1YzjQrsYKYVCxXvk8=
X-Google-Smtp-Source: AMsMyM6ArpGzUFyLZGrmNKsO6gTgWEL3UF5ipxIckKt9NVMCikj3XZrEarkJC/yPNpU18KE7cTxOAJ/Jgp3hgVgqiJA=
X-Received: by 2002:a17:902:d891:b0:186:634e:5525 with SMTP id
 b17-20020a170902d89100b00186634e5525mr270064plz.126.1666981110710; Fri, 28
 Oct 2022 11:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
 <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com> <kl6lr0yuqlk0.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lr0yuqlk0.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Heather Lapointe <hthralpha@gmail.com>
Date:   Fri, 28 Oct 2022 14:18:19 -0400
Message-ID: <CAFwvh9A7V_OC-63f2mqEot4ybHeDUWQ5hvFUet3K+XCc3Xva_A@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] archive: Add --recurse-submodules to git-archive command
To:     Glen Choo <chooglen@google.com>
Cc:     Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2022 at 6:15 PM Glen Choo <chooglen@google.com> wrote:

> The Review Club participants generally agreed that this is a really
> well-structured and easy-to-follow series :) As far as new contributions
> go, this is really good.
>
> I think this series broadly makes sense, i.e.:
>
> - the implementation of plumbing "struct repository" through read_tree()
>   (this might also be really helpful for future work)
> - the interface (using "--recurse-submodules")
> - the expected behavior
>
> So I can see this going through with a bit of polish. The others have
> covered style issues quite thoroughly, so I won't comment on those.

Thank you! I've started looking through a lot of these!
I have been a bit swamped with my own work or I would have contributed
another patch series by now.
