Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4764CC433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 07:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0513764FB2
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 07:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhBEHHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 02:07:13 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:32908 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhBEHHF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 02:07:05 -0500
Received: by mail-ej1-f42.google.com with SMTP id sa23so10227049ejb.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 23:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUgl0dEpffZmmZP5/KC2Rw1YtIKyTlsELTHcOSI96sE=;
        b=cApnB+Kc4s460W6zEaXRKS71gpZSEAvyt+1xBLDJ6Wf4+bxuc8ZQDCMvhj1o68EZHB
         x6mcbo2cSxn9llej9q0KP88/z/fKy/HI592T9MAM3746MRFLNNDC+8pZRrgP1pTz6LaO
         hzu3xA1gnhl86VZXOMPjzkFkfz0ejwbYUiBYkcZVJtFn8AfcDKNkPQb2CKI6dyOKv20F
         YWA6c8sLcEd1xltAjjAFAvHaR+3OPj5F68qENqLqrTLWNJxOOAuh49f64Le5xY8eS7Y6
         3R+xinVOjEXvorRHy9qrXbloQR9+DPTkVt8nI+IPk9TEAxsM0Pa69ca2uMShLMqPXfj6
         Ja2A==
X-Gm-Message-State: AOAM532LFQHCKvEsWubfovMOCtVeyWEnTjvJX4xfA8g3oL7sZZziBrB2
        30N85+PdtEFVVoARSKRrwEw3nQD7v2r52mb4Gl8=
X-Google-Smtp-Source: ABdhPJxSAdVxScDybJI/6uw2EZ1d+2SPKnF4442wS0IGs8JGi5J1sDRbc5hsvUhrjqGPbXv4a0vEOxTQHpdxV0kCJSw=
X-Received: by 2002:a17:906:4348:: with SMTP id z8mr2740682ejm.371.1612508783718;
 Thu, 04 Feb 2021 23:06:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.954.git.git.1612388043875.gitgitgadget@gmail.com>
 <xmqqa6skbw9u.fsf@gitster.c.googlers.com> <CACPHW2WxXKaDjMY3KdxAQAi82V3_crN763bGQa4aWcJttZ+_cQ@mail.gmail.com>
In-Reply-To: <CACPHW2WxXKaDjMY3KdxAQAi82V3_crN763bGQa4aWcJttZ+_cQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 5 Feb 2021 02:06:12 -0500
Message-ID: <CAPig+cSqhopq1ibWFYuWwV=fET+MYdyusvwGdcvj-pdy6LXbGQ@mail.gmail.com>
Subject: Re: [PATCH] status: fix verbose status coloring inconsistency
To:     Lance Ward <ljward10@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lance Ward via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 7:44 PM Lance Ward <ljward10@gmail.com> wrote:
> On Wed, Feb 3, 2021 at 4:51 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Our log message begins with the description of the current status,
> > so "Currently" is not something you need to say.
>
> I'm disappointed by your tone...
>
> I'll go ahead and close my pull requests, if someone else wants
> to pick them up that's fine with me.

It is, unfortunately, easy to misinterpret a reviewer's neutral tone
as being negative or as an attempt to shame the author. But be assured
that the goal of reviewers on this project is to help the patch author
get the submission into proper shape for acceptance, and when Junio
takes the time to write such a comprehensive review, he does so
because he sees promise in both the patches and in the author of the
patches. A review as extensive as this one is intended to get the
newcomer up to speed quickly with local project conventions (such as
how commit messages are written) and to help land the patches with as
few revisions as possible since both submitter and reviewer time is
valuable.
