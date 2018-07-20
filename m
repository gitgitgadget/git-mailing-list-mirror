Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A4581F597
	for <e@80x24.org>; Fri, 20 Jul 2018 17:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbeGTSas (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 14:30:48 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46651 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbeGTSas (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 14:30:48 -0400
Received: by mail-io0-f193.google.com with SMTP id i18-v6so10550717ioj.13
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MsHQK5AdnUWLss0MiZtFpwkY1tDKBeAkX4DmrGKvNIM=;
        b=tRWGRlDP/TjtDxHyzbv+4sU6ysK2phyMURfZa7dCC968nxp/xsNl+unlSjg5XwOUGE
         tmCSTXNg5zWAP6d7yG0zB4pY2DEZ8aTqWQyKYUxOPGsk5oDBwGbsNogQLfiAtC3o6I7y
         95ZCp5Iu9VCLXciAQLcrPxcGQRmpbfH5ZjPC/RvYKvLR+C22FSSqCWP2V3Iz8j8i8TIi
         sq0b/TO1Tt65jUAKRjzJN3Hpvz/KRmJaFniZnsDUh3es9oKCEs+kJT/LfSnoWUmDHksd
         lsSef+VjOqbm988k7anBTkeVtAYdqhtpuow0kncQBHgAl5kjr13PCZSR8/LN4A43eIaC
         PMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsHQK5AdnUWLss0MiZtFpwkY1tDKBeAkX4DmrGKvNIM=;
        b=S4z0R1QGmyb5PqmWQfHUjHGe3f/PoEXQmgvjeJp1OSN5BMyrgq9D5IuYsTiDvBFNfg
         Q0Ihn0QEjUtafM63e7T4hj3VWYcjfun3i/254mmQqbOtiO8ileLE4tjUz7WpBsv4HA9S
         jAYSMFoSAhSxcUbT39imgq7AkAf3Z/TsFOsuFrqFqvv0JrR4Etyj6h70WulPg5Q6KX5u
         QMc6L+j55OvY6RMtCfq2qXOj91665d1W19fXnl7gR38diWMH1yqV6cvzOtM1CrgmGPRz
         rKCQSNofeUaa88EYEiXTfsfUTUwcFa2fFrGYw3um+ZuIvCw5iSGsLQyubmvzzASZt3ST
         7K3g==
X-Gm-Message-State: AOUpUlGN00Y+nfFTRTkwnwQzNP6+o8eg1gNwb8PGMCFqGCRrILC2VNUU
        XQKI2Bxm6CUyYTCy1lSG5IMScS91meORIGK8vrE=
X-Google-Smtp-Source: AAOMgpdi8R1iQ2GAjH1venf5qDUlnbkA0z7khorfEqG6CBpqTD9yNUJAot/eF0kV3fqfZiI4auC9Xeh6VEWab0MEJHc=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr2155939ioe.282.1532108490322;
 Fri, 20 Jul 2018 10:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <20180720163227.105950-1-dstolee@microsoft.com>
In-Reply-To: <20180720163227.105950-1-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 20 Jul 2018 19:41:03 +0200
Message-ID: <CACsJy8CTPtxLsSoNO8xynHGoPqQ3k6N4mSykWTQ9Ceap3yV1hw@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Consolidate reachability logic
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 6:35 PM Derrick Stolee <dstolee@microsoft.com> wrote:
>
> There are many places in Git that use a commit walk to determine
> reachability between commits and/or refs. A lot of this logic is
> duplicated.
>
> I wanted to achieve the following:
>
> Consolidate several different commit walks into one file

I'm surprised get_shallow_commits() in shallow.c didn't make the cut.
It's no problem though if you already considered it and decided it was
better left alone.

> Reduce duplicate reachability logic
> Increase testability (correctness and performance)
> Improve performance of reachability queries

What's your recommendation on adding new commit reachability code? I
might have to add one to fix prune_shallow() if I don't find anything
fit. I guess the code should go to commit-reach.c too?
-- 
Duy
