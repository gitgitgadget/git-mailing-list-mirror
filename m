Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC0CC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 18:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92BA961221
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 18:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbhGLSQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 14:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhGLSQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 14:16:57 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A77C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 11:14:09 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id w15-20020a056830144fb02904af2a0d96f3so19792858otp.6
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D05+uPneYbGt/y4LvwM57B4Oz9J8X2l3nCy3APxyFzY=;
        b=YXNG1qTT92uTGoTCD6A4xzhK5INSG2nofzwap3rJkngCR+r1i2HxRS55TcMGGy/f0Q
         uTCeZGCz32XU/bs73mmqkgxqnu297Vv+D92FeCJ1TImPdbr1wPnIkEarD0vTNQOaxAwr
         6SuEBXLIKJljybWP1CPkAyn3luwjRpUusVH9WrrR1Kp++8qPSYmU+CbZw68mPPWDAp8b
         E+ksJHiBFHKWb4VeDY0FAdBT4nhiqTKvgNJxdqe2s9RY+4VlN/FAqfjv4biITmVWJboJ
         /hjJxmHrd55CP6585Rf1adb7sXNTuCq7P5B8LE7SMZVDj7+YiQPMkKJ0sR0d0e+1zrnj
         Riyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D05+uPneYbGt/y4LvwM57B4Oz9J8X2l3nCy3APxyFzY=;
        b=AK7fpomGFJn3WmQBR5nAGy9j2DG7PcXboJPJkDpxohCjO7NnXfbGAjXAyF6uoY+HLF
         nVCzlZ2Tngf/7JCw0xw9+EmeDx9F349quShZeo9K4glb8z9bHn52N4LEYLNxyyypt/1z
         jOTo5kqOYPCv/hKoJceei39iHrG3Z4fkhAHxdwiLvCVvOX91Eii0a1s5KjMPxrkvzJ1p
         SWkaZK7Fdy4JlP/GrvuldpNDnGH+hKjGxRQsBW8O6c4WZNJ2SIQMu0d6wSiXD0mjL/uD
         FfGzNoi/S/nUZXJPsuv7w+mML3lblKEck6CDjWC4uKWSuSpsU0gef2j3iF6Nmbhs6R5K
         I+9w==
X-Gm-Message-State: AOAM533LmWaOkPEqZFG41AV/FkadLd+Fx/eAuakZDxSO1TlaDyJKW8m3
        FEfU/BaOAyXQTNc1CDkKWQ685+lqaJbRnsLkIbI=
X-Google-Smtp-Source: ABdhPJwgAjMmAPLzFpU4SgpkgyOgRpEon91f2BGx2CWkvmFlKdY6JYm6iOtd+HxNtMg9ON2STWGXs2sf0E6PJYIfekY=
X-Received: by 2002:a9d:6d03:: with SMTP id o3mr240323otp.316.1626113648831;
 Mon, 12 Jul 2021 11:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <44a5d5efaa637d01ec3266b34f31d46acce5ef24.1625964399.git.gitgitgadget@gmail.com>
 <9707b299-3846-6388-36ba-e8d93a28e2ac@gmail.com>
In-Reply-To: <9707b299-3846-6388-36ba-e8d93a28e2ac@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Jul 2021 11:13:57 -0700
Message-ID: <CABPp-BHF3Os7fOeaF_EQOo+Bs7f1DXbYr26WmAQrPjv63nq1Pg@mail.gmail.com>
Subject: Re: [PATCH 3/3] diff: correct warning message when renameLimit exceeded
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 8:09 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/10/2021 8:46 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > The warning when quadratic rename detection was skipped referred to
> > "inexact rename detection".  For years, the only linear portion of
> > rename detection was looking for exact renames, so "inexact rename
> > detection" was an accurate way to refer to the quadratic portion of
> > rename detection.  However, that changed with commit bd24aa2f97a0
> > (diffcore-rename: guide inexact rename detection based on basenames,
> > 2021-02-14), so now the correct way to refer to quadratic rename
> > detection is "quadratic rename detection".  Fix the warning accordingly.
>
> Now that I read this more specific reason for using "quadratic", my
> earlier comments on patch 1 are slightly less helpful. Specifically,
> I was recommending to continue using "inexact renames" but that is
> not 100% true anymore.
>
> I still think this "quadratic rename detection" is perhaps hard to
> parse as a non-expert. This subtlety of some "easy" inexact renames
> definitely makes the definition harder.
>
> Since the steps that find inexact renames without the quadratic
> algorithm are heuristics, perhaps this portion could instead be
> called "exhaustive rename detection" or even "expensive rename
> detection"? It perhaps implies more directly that the limit exists
> as a way to prevent an expensive operation.

The name "exhaustive rename detection" seems reasonable to me.  I'll
resubmit using that term and see what folks think.
