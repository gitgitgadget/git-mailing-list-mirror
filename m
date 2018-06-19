Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EB471F403
	for <e@80x24.org>; Tue, 19 Jun 2018 22:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbeFSWlt (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 18:41:49 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:41433 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753486AbeFSWls (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 18:41:48 -0400
Received: by mail-yb0-f175.google.com with SMTP id e16-v6so4582ybh.8
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 15:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4uXk98rNLvqyhp32AFOQrtVvAdEw9XjBIBSieGqEH0=;
        b=V2xqSyk9AbH9yps2GvBlGpDjxwWtkBCAo5RDQHKSPYW7yW9Kt4Z7jGf/j2AglHl8w2
         yJzIbbPbX3OPbrl/CP1jYrPWweU1Gk2/N07P9TybbAkFSwtImuY31IDc+r5GpVvyVyZS
         BstsuZeQLaeEQZGqaSwQ/ZkOj0ITMBnr79wJI86b93cAyIyeZ5nVE0IUTb4uuqtdsJcw
         CWoL7U1F0npSs54aRxZjCuSU+N2Y40uX2UYtwnb5Csb8ic/LMTGrq0TWlatzLt5MYOZU
         d9Vxb1COpOWlMqglJ1XDT1wTf5Iflp925wKRvsQAkiS0nXWRyYtsRHfwidWARYN07ByJ
         29jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4uXk98rNLvqyhp32AFOQrtVvAdEw9XjBIBSieGqEH0=;
        b=TV+PPgY5DkOQKk6hUhNeoGyF2LoSmgh78kpM7bQORZzbHHDGA6HoFsu0Rp9yBwVh9o
         PfMEs8CtqUJLVZcFZHYZFW5rc7ik8XeG3xZQ+0vopRpCRWkEjWai3w9hmbl6bCoGGPg2
         kSryeS0TBCNMkxQJFI1TX2OiWRnxKCj4aTiedXqZrfEdZyEKfMw+qxjbu4B8ICxbEYyq
         Zcjkh/Gs9xk12zAInBq3Kfu73ABelUpWR171VSxEAjBzToxaddMql4q+XQSNkT1JTo74
         UmecKfF2wAkamIH6Q/Oe38MXVtKw8EyEexYwsenZEMSLCHvXAut5n08uftrU9O4K9USi
         hg6Q==
X-Gm-Message-State: APt69E2Z/4wLCSIr/PTI0l40cgtl2MqkN4HDygsE/Qi2MzJwBU9xuUIJ
        HQ+Zsw8Cbbm+qzwAhYcHt+3OKF1m7DUgp0pJ58l1Iw==
X-Google-Smtp-Source: ADUXVKKIHttXAt64sogWINx3hMvTtAunik/p8qGe1nU+e0W63HookR64/a161Iphog5rdE6MY0pr+et2EUFL0kvTjM0=
X-Received: by 2002:a5b:307:: with SMTP id j7-v6mr9531698ybp.352.1529448107249;
 Tue, 19 Jun 2018 15:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAGZ79kZtEZA1rvgfSCS+m4dsrB86Cf-XiePWQmeU-kCNxP_NLQ@mail.gmail.com>
 <20180619223712.127990-1-jonathantanmy@google.com>
In-Reply-To: <20180619223712.127990-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 19 Jun 2018 15:41:36 -0700
Message-ID: <CAGZ79kZ7XDevLouEPcy9qezKtVAKnkLa-pQvuUXv6Fevi5df2A@mail.gmail.com>
Subject: Re: The state of the object store series
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 3:37 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > Floating on the mailing list, not cooking yet:
>
> One more is my bitmap one here:

Oh right. Thanks for writing the series!

When writing this I dabbled back and forth whether I only present the series
that are on the critical path to reach the submodule goal or to
include all of them
(see Duys series) and that is how I missed yours.

> https://public-inbox.org/git/cover.1528397984.git.jonathantanmy@google.com/
>
> It's not in any branch yet, as far as I can tell, so I've just sent out
> an e-mail letting Junio know [1].

Thanks!

>
> [1] https://public-inbox.org/git/20180619222749.124671-1-jonathantanmy@google.com/
