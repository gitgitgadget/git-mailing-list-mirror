Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C402120A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 14:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbeLMOCa (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 09:02:30 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:52514 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbeLMOCa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 09:02:30 -0500
Received: by mail-wm1-f53.google.com with SMTP id m1so2469927wml.2
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 06:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=odQrVFvLMoalHxIGhvSI/MOzlJh6tISFZor040vHXoo=;
        b=c6C3+6ZZ+rNmp/izYJU2BLIBTZUWyzJmr8s6iVhTXaEvtlzfakKCyp48fAHympdHPg
         pTmH7dMVeCkXTdpqRXphCrcyG+TWafQ7qpH4OASa26e+SZB/AOTjM4dIn002RWUOSx9m
         W4Oylybx9cVEzUln4MBzeGTiEZSv2CJBMZIFXPgPvNvqfN2X4fWXrUUfw7Mid5fEBCJh
         hK/kM0+BAMqxytLYBgrpyOJ1Xn16uj+ZkA7/F2AoFmjlUhpqAWDvvYFuA4RG6GGZtQQf
         9G+1b1DT1OqurDUS3SR6riiKwf8hQlSczDtJREOx8W7h5yR56nuP5q++HrjCPh6ldjY+
         SieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=odQrVFvLMoalHxIGhvSI/MOzlJh6tISFZor040vHXoo=;
        b=DhJF4CF1o3P7m0gbCK9Jdo1AXMwtqWuH3h25miHo9DTI3O1QowmVjoTn10FCJkDGdE
         jpmBcnR3XMmX1hHVXDRo82lA9j7B60LdV6oIjDBwxXIIoqeTV7X3TjawB87tGxLQNv3n
         81ikFpVMB0KXXRBaH6j3Peo8F/aaisyatF0PtymrfurXOTjjjun3jtLjICxM3pq2lwOa
         KU69AiJ+PaCw4KWpCJYLE3lvFrwWj+nojpMsd/+4F3TB6ZDro+ekCZSAA7xodKPWhqtI
         pVRi8imAtLNhEN2S39gULKB6HPxx0UDt49lY9iPMMRveccPgT2xqmDKUpu64OFpJdMHr
         iQyw==
X-Gm-Message-State: AA+aEWaJO4IgfWKm98R/yMTL4hnGfgpZLo4N4f6CWVMo0Pkq6FGgVBTs
        HsdhJCwqob+JLalozGBdtfE=
X-Google-Smtp-Source: AFSGD/XnSGuc74qMCCamKareyRL5M2okcIcdVUA0D6Wx/JunzmM8QQmjnusXWouvXSn6p4jruuQ37w==
X-Received: by 2002:a1c:3c06:: with SMTP id j6mr9468974wma.27.1544709748649;
        Thu, 13 Dec 2018 06:02:28 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id o81sm2690591wmd.10.2018.12.13.06.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 06:02:27 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sjon Hortensius <sjon@parse.nl>
Cc:     git@vger.kernel.org
Subject: Re: 2.20.0 - Undocumented change in submodule update wrt # parallel jobs
References: <CAHef355RQt9gN-7QjuAAT8mZsNFKfCo4hOYi2+bkp-0Av7W=Qw@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAHef355RQt9gN-7QjuAAT8mZsNFKfCo4hOYi2+bkp-0Av7W=Qw@mail.gmail.com>
Date:   Thu, 13 Dec 2018 15:02:25 +0100
Message-ID: <87sgz11q4u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 13 2018, Sjon Hortensius wrote:

> When switching to 2.20 our `git submodule update' (which clones
> through ssh) broke because our ssh-server rejected the ~20
> simultaneous connections the git-client makes. This seems to be caused
> by a (possibly unintended) change in
> https://github.com/git/git/commit/90efe595c53f4bb1851371344c35eff71f604d2b
> which removed the default of max_jobs=1
>
> While this can easily be fixed by configuring submodule.fetchJobs I
> think this change should be documented - or reverted back to it's
> previous default of 1

Just to add to this. SSH-ing with -j<ncores> (which I assume that ~20
is) is going to run into MaxStartups in sshd_config, which is especially
annoying as it's pre-ssh-auth, so the server doesn't even get "so and so
tried to login", it's just dropped as a potential DoS attack.
