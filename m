Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BC0C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 18:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbiC2Sis (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 14:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbiC2Sir (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 14:38:47 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFAB18EEA2
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 11:37:03 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id o8so15542801pgf.9
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 11:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9K2VJEL/RYaBuFIPad0ApdmPGIGo/g7vcCWmvM0PR9E=;
        b=Fa6yHmY1fbe3mZSIfsvJnsD8wVtB+slx2jbGIJn6/IwIpkMIvrpEs/XaADrzp+CZOz
         Z8g6aElIId1CABf2HTWGUsnKSs6Si+IoeuQSX0V0YcBs8uvP0GtnIpcImuw7RTG7Di/S
         EPp7uFKpB+5VSL1gAsvBpL10BeSGLZDbj/i/ygu4qPUywN493ok58wONzX9AUdCTPQM/
         oqYyIpMNLb3LlnCSIbRgwzu1CkAV0XwXK+F6KTOqcoKEgI8EmmGqVS73KRHb3ZPgW7be
         nRjRaM/9WgJA2Hpgz6+9OJWnexrvloQY9Qy3YXlPaF8i/TpmdjY7yVHEMkTiuA7yc7Sv
         0DNA==
X-Gm-Message-State: AOAM531syMtPhTelfQuxga3i6kEVNCPtriJ6Fmx0eXSXJnL9f+CNLJ9U
        wn4tyAOF8Lgp4Wlolz9e+iUq//3d95n/oVlXp+wNJTCBSulyxA==
X-Google-Smtp-Source: ABdhPJwoexE6jRHAD8Q4Dffhvw6pbmQU0YpZ5MvMiu/Ag1pABOcUw2NPJER9I2HsVd1ZEcMFNSPGdSoJ3BUiOXOPX6c=
X-Received: by 2002:a63:d23:0:b0:382:70fa:2f0 with SMTP id c35-20020a630d23000000b0038270fa02f0mr2871729pgl.181.1648579022932;
 Tue, 29 Mar 2022 11:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq35j1zi7j.fsf@gitster.g> <48242777-6442-4A4D-BE76-1B9EF2F7175B@gmail.com>
 <xmqq1qykycgc.fsf@gitster.g>
In-Reply-To: <xmqq1qykycgc.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 29 Mar 2022 14:36:52 -0400
Message-ID: <CAPig+cSJPoj8jk_JHmpc4=3bupZ98dKmDi+POZQXZxJR+CjhKA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] worktree: accept multiple paths
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Desmond Preston <despreston@gmail.com>,
        Des Preston via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 29, 2022 at 12:02 PM Junio C Hamano <gitster@pobox.com> wrote:
> Desmond Preston <despreston@gmail.com> writes:
> >> The fact that this line was introduced in [PATCH 1/2] and then
> >> needed to immediately be corrected with this patch means the
> >> previous patch was suboptimal and this patch is "oops, the last one
> >> was bad and here is a band-aid fix-up".
> >>
> >> Let's not do so.  Instead, you are encouraged to pretend to be a
> >> more perfect developer who does not make unnecessary mistake ;-)
>
> FYI, I've queued [1/2] with the fix-up in [2/2] squashed in.
>
>         N_("git worktree remove [<options>] <worktree>"),
> +       N_("git worktree repair [<path>...]"),
>         N_("git worktree unlock <path>"),

This version looks good to me and addresses my review comments[*], and
still has my Acked-by: for what it's worth.

Thanks for putting the finishing touches on this.

[*]: https://lore.kernel.org/git/3f823608-adf4-f717-13d8-8da6f89a9506@sunshineco.com/
