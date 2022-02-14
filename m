Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9AFC433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 20:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiBNUS4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 15:18:56 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiBNUSz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 15:18:55 -0500
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EB8F9F91
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 12:18:40 -0800 (PST)
Received: by mail-vk1-xa4a.google.com with SMTP id b26-20020ac5c4fa000000b0031fa5646ccaso3055095vkl.22
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 12:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=n/mC4aHCWk5H1wKiZbSUn4NMJT4x831eVO/YZfRAyqw=;
        b=Qq8eMEcE2njI4SBjH4EIX6CWcEMP0/Uz1qQGXUMl0njJWOX4w9z32V120dKKDS3xXC
         C4n78zc5cJSc8hjHkqBRQARD5Cq16DpznDKz2hDGFf2ysdZKteEtWlQ6xsdlXthJSdEN
         O0IEBW504JPTKlkZhvZTof46S0LxfPJVwFIi2PDAPdyAWHoAuQ1gIZ3BsCnpl1+eSPVM
         3Zuk1xLJ+7s014KUi7FM+XJLDuR0IDsp6ZXGgOrxmH+o2Sbw0WHRQtLnddBu1EtCYbGw
         BviOaAji8jQBfbQ1A0y+7GU/sdGk/Wy1eONmniNyryIh8HAiOnQQDmLFkWmEtd3HkDVx
         GAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=n/mC4aHCWk5H1wKiZbSUn4NMJT4x831eVO/YZfRAyqw=;
        b=6nepwCd/tEglLEMllBvkZyrkErzLEzCbLQAZ6BLgKPGh9GuYECYmVUEn6vYistXApk
         C1SE8RoHI8JtoL2GMOUVMBUlxJ+9AKcrWAtqchm8eGCMB6PFd/fjOmDjpSQkawKihJSI
         3WlDwcBIYIix2H5zP0Que3dCuB8u/nrfVdISmKejMCk2/TuDOEaNXSdDM641q/e5RWgY
         cJM1XTz5yDVZCwvmusOCiB4ZXccixOCd4vgbcbI3PYqkcu7SrO/wt8sgtfe4JV1QPVkE
         FvKkB8x0EQ/UYYK16DRdl/PrYmMBWlpELajE7XlurGWBoPCvCQkzCgLNQTkKGboKtrdv
         F4JA==
X-Gm-Message-State: AOAM533ggWY25Au4RUc4Q9SYdNK3ZjUSq/LTC+H2z9nCPjRKSXR8lnyb
        V/fE0E5zF3EG7kTNcKlqQXnWjQOOkb8lp06QQVhj
X-Google-Smtp-Source: ABdhPJz0mGFWl7JEd91Tuxd0Q/G3ADQSlZHbWA7U9Otrk8kNubQ7JrYgKx2nhHfdHW6JNrBLAcgdAiQWzYeySx+GJ67i
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:82c1:: with SMTP id
 f1mr319676pfn.60.1644868921801; Mon, 14 Feb 2022 12:02:01 -0800 (PST)
Date:   Mon, 14 Feb 2022 12:01:54 -0800
In-Reply-To: <xmqq5ypj6rw6.fsf@gitster.g>
Message-Id: <20220214200155.1412357-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: Re: What's cooking in git.git (Feb 2022, #03; Sat, 12)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> * gc/recursive-fetch-with-unused-submodules (2022-02-10) 8 commits
>  - submodule: fix bug and remove add_submodule_odb()
>  - fetch: fetch unpopulated, changed submodules
>  - submodule: extract get_fetch_task()
>  - t5526: use grep to assert on fetches
>  - t5526: introduce test helper to assert on fetches
>  - submodule: make static functions read submodules from commits
>  - submodule: store new submodule commits oid_array in a struct
>  - submodule: inline submodule_commits() into caller
> 
>  When "git fetch --recurse-submodules" grabbed submodule commits
>  that would be needed to recursively check out newly fetched commits
>  in the superproject, it only paid attention to submodules that are
>  in the current checkout of the superproject.  We now do so for all
>  submodules that have been run "git submodule init" on.
> 
>  Will merge to 'next'?
>  source: <20220210044152.78352-1-chooglen@google.com>

This should wait at least until a v2 that addresses comments from both
of us, I believe.
