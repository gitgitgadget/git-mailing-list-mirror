Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5649EC33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333F32072E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgAQN4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:56:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43317 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgAQN4R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 08:56:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so22814585wre.10
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 05:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hPL4DneeMMxETmnVLNXlkhqMSMAvaS4LpnRozQEGzv0=;
        b=Bgrc7Qc7P5LnTewMBEVsZosfxrPwAvBo81kBCWX5+ajX1/KihK8mXT+KuQ7RBwzSJR
         fNHx97QX+hTIWeDGL1sDzm+OGxvdFG64ZuNb97LEaWuXNubCiawhvHzYWDDYsZ2VY3gU
         AGu+R6eXHqvAWt9Ayzu8YpbzMf9oWJnOFN+KCciglB+Gmd8tYth4OSdOYKEE5/ke3fZ7
         eBCjDuE4/ZyB3QR/ULhaREFteJWc9mFbtSSgLQhGgV0mF29iB/2iUKprJt3XJ6POAki7
         ubaYOIlj5AylD7/lZCFLwKu3Uh/RGXYmPKyM0Ns+5WjApDAw97459SBB7oUWsQfnAQdZ
         Gvrw==
X-Gm-Message-State: APjAAAVkkVi7scNjlgQCIPKsT66TJRQr0sTxQoGp9opzbwR1/h1aFMmQ
        R6mWIHpHseSaZkXjdFFCu6BBv6CGkXbSv+DuDHfe7PJA
X-Google-Smtp-Source: APXvYqzTV/AsZaeQGy7FNmPxyIMxzUAJpW4FD4aYZW6kSgTxNX55zkMcxHVvthqLDorq399d50dmREgMTW7HJgq4KKs=
X-Received: by 2002:adf:e74a:: with SMTP id c10mr3208070wrn.386.1579269375095;
 Fri, 17 Jan 2020 05:56:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.523.git.1579263809.gitgitgadget@gmail.com> <6e0e664026757315a337dead8079167f4fb29c4b.1579263809.git.gitgitgadget@gmail.com>
In-Reply-To: <6e0e664026757315a337dead8079167f4fb29c4b.1579263809.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Jan 2020 08:56:04 -0500
Message-ID: <CAPig+cR82mrG=eiOMtyd3sAAqRRL2FD_VG2+W_j15uhWyx30gA@mail.gmail.com>
Subject: Re: [PATCH 3/4] t2405: clarify test descriptions and simplify test
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 17, 2020 at 7:25 AM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When 'checkout --to' functionality was moved to 'worktree add', tests were adapted
> in f194b1ef6e (tests: worktree: retrofit "checkout --to" tests for "worktree add",
> 2015-07-06).
>
> The calls were changed to 'worktree add' in this test (then t7410), but the test
> descriptions were not updated, keeping 'checkout' instead of using the new
> terminology (linked worktrees).
>
> Clarify the tests by using the right terminology. While at it, remove some unnecessary
> leading directories such that all superproject worktrees are directly next to one
> another in the trash directory.

The unanswered questions which popped into my head when reading the
"While at it..." include:

    Why is it desirable for the worktrees to live in this new location
    rather than their original locations?

    Is it safe to relocate the worktrees like this without losing some
    important aspect of the test?

    Why were the worktrees located as they were originally? Was there
    some hidden or not-so-obvious reason that we're overlooking? (I
    guess this is really the same as question #2.)
