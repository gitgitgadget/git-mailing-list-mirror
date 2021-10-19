Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A23DC433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E787161154
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhJSWwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhJSWwF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 18:52:05 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27D3C06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 15:49:51 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 3-20020a620403000000b0044dbf310032so769911pfe.0
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 15:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=+Tyjw5MLVCRQiu8nE0/WwgBXBBXV/H8pgPlZRathhiM=;
        b=NShRz42UweaPyvXg+OdiYDCQeC3nURlG687Fo9NfrCcLdMioz7FxayO5HwRghZ1Puc
         mDsrH2kd3+E2BEfTwBqYqFtro1nHzxMw5TRTjcY8qrhVLzFc8PM9QnKBeP9aKyneIoYF
         Umz+rPIG4SPqTiZ82vKnb5z6s4x2ldRlWoBLZFVX5WRPJqDjoZvwq5NP1OGjFN7m/7vx
         DFpO5r6175g26kCoHVVjPoTo40rS6ZfQchXx3sn6uw8LvtNVebeOyCRRCfONmRsaD64u
         5/3rk6KBcouTTXb6X3ijE9VdQvFv6Bzp0CjRvfgXDVln8BuU4hxxEiI/RQ7CcoOhAoy8
         ODTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=+Tyjw5MLVCRQiu8nE0/WwgBXBBXV/H8pgPlZRathhiM=;
        b=ToUGssHummdz6rekYLKdIwgxS9R1mT8XHJPkcSeufCRuztgu2a07jV0aHp4d9zxpsy
         24xvcMe1D954fzzF/i5Sq98kDPVipIinZ/uEP/mQHRaWLJ1QR4cjjJWu2o/KBnNtV1hX
         UifV/Nq3XmNIAVSPUShT6QdYzUhNsgYuf4MwxvU1SeNh3+p6nmet2SD/QACDuKb9mmrW
         vr19n7+PnjC4jD4yvszWYppo1vfHdbeyaaZ87KvmTbzi+8Cvg9R+EcKTBRbY1FU4vFHU
         f3Is3bxQ0P15Wk5I5yQAgebnnggILhxJe3+qzqIBXYtwX7hWEFla4OHwOFjHqY4uFtbk
         zsOQ==
X-Gm-Message-State: AOAM532hirOnHzbdiGrqx2y0X7+afsX08Hsrwx5JbTXT5UC8aBPKSP2U
        EvoeoWxBJwhcyUMkSRPVefKZIRfsiVI7dQ==
X-Google-Smtp-Source: ABdhPJwVTtCtTkmtQ2wMVR6HCuJhh3yKNYqc7JQvyBON2xetejhwQRT+WTx6AYEp761Pv33U2ZI5WUUjP57guA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:3b50:: with SMTP id
 ot16mr3149898pjb.150.1634683791358; Tue, 19 Oct 2021 15:49:51 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:49:49 -0700
In-Reply-To: <xmqq1r4hv7bv.fsf@gitster.g>
Message-Id: <kl6l8ryomxyq.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqq1r4hv7bv.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Oct 2021, #05; Mon, 18)
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * gc/remote-with-fewer-static-global-variables (2021-10-13) 3 commits
>  - remote: add struct repository parameter to external functions
>  - remote: use remote_state parameter internally
>  - remote: move static variables into per-repository struct
> 
>  Code clean-up to eventually allow information on remotes defined
>  for an arbitrary repository to be read.
> 
>  Will merge to 'next'?

I've just sent out a v3 that incorporates a lot of your feedback on v2
and fixes a dumb bug due to a static variable slipped through the cracks
as I was iterating.

https://lore.kernel.org/git/20211019224339.61881-1-chooglen@google.com.
