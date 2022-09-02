Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC77ECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 17:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiIBRYs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 13:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbiIBRYq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 13:24:46 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B06D26C
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 10:24:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y1so2514686plb.2
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=iaRCTatJqwk4nnjJhBnRTtL6+4yrns2OUUheTesHyPo=;
        b=AwGMugUV+gpVxv2lNtTULYumU2gBFyG2u0H/A1tqAWgK00sJADl8qKD8tcK5x0yDYJ
         lfV/ETR33D4rs2Lwms2phJ0k0f4SDOkdA067AVm+HGcnxuoD/7Df/PcnVbs0c29OyzDN
         mTRpGf2dsSo/g2dIaAQXrMF59t3nl6a0M4UG8PMF/93AcXfc5kxZDdjsyfEpQovkth1W
         Kx4wpI/xWxaH/QlkZLyTVGTF7Ig+zcQ7VNijnG81GAI7HSbWE/bBNcLYLVnfowr6miJz
         MYkRLKqV0iOFwL9k3PhZOk3HhQv1nNoM/KSGQ0Ldv1ovhKr2wboBq3f+YiAUHOZk/mRF
         U5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=iaRCTatJqwk4nnjJhBnRTtL6+4yrns2OUUheTesHyPo=;
        b=s78326tPb0rrOSVd51FQf1h12MQXRWH3aSgZ8wjXU3XOlnJtbZNck3F7aKB73Y4w8g
         kBsJcIQQbMYQBQ3o+8vktSHdeR3FxTbOQPMoff5PBM5fMMDNEuujIP6jwDLzK+VpR7tJ
         lbfsSp0bYttrpIlcr/NhKcDxYqAx2yv+QSznk2vK6wCS2B1c8yhoSFWEB7qfkmd4svQz
         7QVH71Vlb42Q28OdvWj10VTNpFayUDmbjtWUGMEldKU00bahC1uJFi1uABoDUtThGmZD
         Pcsn0JHD+Hygdpy4yrQCFkc8HZM1cvvY7ZO1ZMGIaZ7e6AB8vZCVhrITjs2E1SWZslHC
         m3Yg==
X-Gm-Message-State: ACgBeo2uz7uAyqlRgrHtilWkjrswLI8JSx0to2pmXQd8YYbEARn8fFFk
        IsQEVFx286Cjf/iFZeqzcc4=
X-Google-Smtp-Source: AA6agR5oIUj70K+/VT5chLJURqzo33Pa3cz1c4Y+gQ0TtNBej04jSdfWlB3EKzRuu3jFwx4U16fZHA==
X-Received: by 2002:a17:90b:4c4f:b0:200:2ce:ad39 with SMTP id np15-20020a17090b4c4f00b0020002cead39mr1819598pjb.98.1662139484558;
        Fri, 02 Sep 2022 10:24:44 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z27-20020aa79e5b000000b00536b975b013sm2112623pfq.24.2022.09.02.10.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 10:24:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git-security@googlegroups.com,
        Julia Ramer <gitprplr@gmail.com>
Subject: Re: [PATCH] embargoed releases: also describe the git-security list
 and the process
References: <pull.1345.git.1662071998812.gitgitgadget@gmail.com>
Date:   Fri, 02 Sep 2022 10:24:43 -0700
In-Reply-To: <pull.1345.git.1662071998812.gitgitgadget@gmail.com> (Julia Ramer
        via GitGitGadget's message of "Thu, 01 Sep 2022 22:39:58 +0000")
Message-ID: <xmqqa67h8zac.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Ramer <gitprplr@gmail.com>
>
> With the recent turnover on the git-security list, questions came up how
> things are usually run. Rather than answering questions individually,
> extend Git's existing documentation about security vulnerabilities to
> describe the git-security mailing list, how things are run on that list,
> and what to expect throughout the process from the time a security bug
> is reported all the way to the time when a fix is released.

Thanks for writing this down.

> +- Once the review has settled and everyone involved in the review agrees that
> +  the patches are ready, the Git maintainer determines a release date as well

s/maintainer determines/& and others determine/ or "stakeholders
discuss and agree on".  You might want to mention that the schedule
for disclosure and release tend to be constrained by so called patch
Tuesday, which is the least flexible among various binary packagers.

> +- Subsequently, branches with the fixes are pushed to private repositories that
> +  are owned by the Git project, with tightly controlled access.
> +
> +- The tags are created by the Git maintainer and pushed to the same
> +  repositories.

Between this point in time when the tags are prepared and release
materials are made available to packagers and ...

> +- Less than a week before the release, a mail with the relevant information is
> +  sent to <distros@vs.openwall.org> (see below), a list used to pre-announce embargoed
> +  releases of open source projects to the stakeholders of all major Linux
> +  distributions. This includes a Git bundle of the tagged version(s), but no
> +  further specifics of the vulnerability.

... the time when we start to disclose to a bit wider audience, is
when binary packagers are expected to prepare updates for their
users.  So ...

> +
> +- Public communication is then prepared in advance of the release date. This
> +  includes blog posts and mails to the Git and Git for Windows mailing lists.

... the following two bullet items are better written before the
"Less than a week before...".

> +- The Git for Windows maintainer prepares the corresponding release artifacts,
> +  based on the tags created that have been prepared by the Git maintainer.
> +
> +- Git for Windows release artifacts are made available under embargo to
> +  stakeholders via a mail to the `git-security` list.

It also is probably a good idea to avoid singling out GfW too much.
Folks who package Git for macOS, BSD, Debian etc. are all expected
to work on the same timeline.

> +- On the day of the release, at around 10am Pacific Time, the Git maintainer
> +  pushes the tag and the `master` branch to the public repository, then sends
> +  out an announcement mail.

OK.  Thanks for being explicit about 10am Pacific.

> +- Once the tag is pushed, the Git for Windows maintainer publishes the
> +  corresponding tag and creates a GitHub Release with the associated release
> +  artifacts (Git for Windows installer, Portable Git, MinGit, etc).
> +
> +- Git for Windows release is then announced via a mail to the public Git and
> +  Git for Windows mailing lists as well as via a tweet.

Ditto for various distro packagers.

> +- A mail to <oss-security@lists.openwall.org> (see below for details) is sent as a
> +  follow-up to the <distros@vs.openwall.org> one, describing the vulnerability in
> +  detail, often including a proof of concept of an exploit.
> +
> +Note: The Git project makes no guarantees about timelines, but aims to keep
> +embargoes reasonably short in the interest of keeping Git's users safe.

;-)
