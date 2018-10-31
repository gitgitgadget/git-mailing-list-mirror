Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5645B1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 03:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeJaMk6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 08:40:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33278 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbeJaMk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 08:40:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id y140-v6so265096wmd.0
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 20:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lJO7sabGYFtkt80QjzMP0sx38c2NIlkxzYIOUBJ+Fh4=;
        b=ELw/AlGerIaHUvbbITsLvlAsNhUZunMhtas8aTFAb2xJ+cUD/tquSONPGPtSp3G/Hh
         6XA7nAFUO4N0ME6YRjKSoCmvpNYNfNueQ3chhofmMru+Uoy1YzXVUrj7acmkZV/9JNEm
         T0G4yAji4swUma40pxgSfOzbx1gacPBy7MlzeEu9gn8arXeMsViv5xHINyA/+FKBrrZs
         /NrrHm8QEdOhndgS6dYxHUWz78E1PKZK9Nq3FjkxKqf3JZw7TYjufQX21ntrWhOnFxM8
         Ig1IXr1yKeoubCQQxEAv6pCMG3bnN3sbsJsRZJO/T5wl+XZGL/q/nVlFvGtXwMDZXhaE
         DPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lJO7sabGYFtkt80QjzMP0sx38c2NIlkxzYIOUBJ+Fh4=;
        b=SxHCmW/0MzkFKCrfqfLIqBbwupElBNMABO3OzUahMrNTcfMxQ4TaLA1Dj1h9LOgHO6
         a9YTY1xVCPFzmHCg3Jzr/RTb+WfPAh6eLYZ2i3LD3uwNfIeyZjJtS8vNo7AEwCt/madH
         9677dXwwM8lGaIJjX9BlNxRHQSAiFGiPt2ltwqE0nmWM/FOiWKDoCetegXf107YOYFDc
         nWh6QNhCvFWpOvR8LasNf3//rREbQ73BeqIBT7j7kYpRQ7aw4eX4pRGHAZtS2LSjcY3n
         48Hc+SjGYOMCdaqm0SknV2oVeNpg5qpHRmQwTRL6k4Wl3bTZdoE+g+Uo6rKrPC/HzAEY
         G7uQ==
X-Gm-Message-State: AGRZ1gJbtdpae3ZeU3bZuruezWlq87AbANupGbAF1mb2gu98m0o6YsSa
        KAKD+ktRfKEsJookqcWN25c=
X-Google-Smtp-Source: AJdET5frmuMZf6FMbLD6LDlr9gZMVG3goi4eVOhTJ7edMe1Tp0U30oBqw+rKpPzQ3P2QAuTWhs6uRw==
X-Received: by 2002:a1c:9e93:: with SMTP id h141-v6mr999044wme.56.1540957482639;
        Tue, 30 Oct 2018 20:44:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 191-v6sm17619603wmk.30.2018.10.30.20.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 20:44:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] mingw: prevent external PERL5LIB from interfering
References: <pull.62.git.gitgitgadget@gmail.com>
Date:   Wed, 31 Oct 2018 12:44:40 +0900
In-Reply-To: <pull.62.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Tue, 30 Oct 2018 11:40:02 -0700 (PDT)")
Message-ID: <xmqqtvl2ye3b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> An alternative approach which was rejected at the time (because it
> interfered with the then-ongoing work to compile Git for Windows using MS
> Visual C++) would patch the make_environment_block() function to skip the
> specified environment variables before handing down the environment block to
> the spawned process. Currently it would interfere with the mingw-utf-8-env
> patch series I sent earlier today
> [https://public-inbox.org/git/pull.57.git.gitgitgadget@gmail.com].

So the rejected approach that was not used in this series would
interfere with the other one, but I do not have to worry about it
because this series does not use that approach?  I had to read the
six lines above twice to figure out that it essentially is saying "I
shouldn't care", but please let me know if I misread the paragraph
and I need to care ;-)

> While at it, this patch series also cleans up house and moves the
> Windows-specific core.* variable handling to compat/mingw.c rather than
> cluttering environment.c and config.c with things that e.g. developers on
> Linux do not want to care about.

Or Macs.  When I skimmed this series earlier, I found that patches 2
& 3 sensibly implemented to achieve this goal.

>
> Johannes Schindelin (4):
>   config: rename `dummy` parameter to `cb` in git_default_config()
>   Allow for platform-specific core.* config settings
>   Move Windows-specific config settings into compat/mingw.c
>   mingw: unset PERL5LIB by default
>
>  Documentation/config.txt     |  6 ++++
>  cache.h                      |  8 -----
>  compat/mingw.c               | 58 +++++++++++++++++++++++++++++++++++-
>  compat/mingw.h               |  3 ++
>  config.c                     | 18 ++++-------
>  environment.c                |  1 -
>  git-compat-util.h            |  8 +++++
>  t/t0029-core-unsetenvvars.sh | 30 +++++++++++++++++++
>  8 files changed, 109 insertions(+), 23 deletions(-)
>  create mode 100755 t/t0029-core-unsetenvvars.sh
>
>
> base-commit: 4ede3d42dfb57f9a41ac96a1f216c62eb7566cc2
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-62%2Fdscho%2Fperl5lib-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-62/dscho/perl5lib-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/62
