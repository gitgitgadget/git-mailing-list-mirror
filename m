Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7E0C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 23:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiHTXCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 19:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiHTXCH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 19:02:07 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20562717E
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 16:02:06 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id g21so5632118qka.5
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+cxtga50qRgJveYSqFfnWrJgSCYToSd5BZBRu2RZ7/E=;
        b=l37Elj2xMFJlqJsIFOkepqOTMjuH9TPd/O+fT3sLP1DSUCFfpYvOkLs57GbG7RTkth
         QpQ8js7jF6WmmHZo7c82D3ExEvVZjGT/HBAjqr85UBkmxbKg/fbUrt8/rqzsnQaXO/8t
         bKhQ0RLaIRX0dAdS4nVinxTVsu87DOoDm4aLfqM+m0+iEsfUZvKOsA7PScSSji7rrm5p
         vcWSk/8oBNX78RsiZyyI12QckBkvsqGW6yG4hpWp7Kb3mrBJGtbTgd13Vnp4lpl5N0o7
         xUiKrgh2+/V/hH+8BBTKEknzh2kxbEoUXY+CtLnKBavB+GyfCK02+JVJz/cJDhzIOxJD
         GQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+cxtga50qRgJveYSqFfnWrJgSCYToSd5BZBRu2RZ7/E=;
        b=H/4gc5PBJ5PmDvo2nl+5KuoIzPMd8qH0bqsleemxMj4Q6Y6/p5A2zcpqZyFPp5D8IY
         O6JdehszPeX8mwcGP/H5jiIcss/gfHeFJ5MADKH16OqeQkRjo+TlW7GceVSNpZHXyzH1
         tos4W3f4aA8ITC6KW/PomZWVc2k/bGH0LMBmh5CaQLPg/tN2f32lj7ZUP7Ry/M16oUhx
         W7KeWMMYR7cs9N+CYnvRGT1+QYotsB4POfoEjunpnN6txBCEg4eNWgt5DvwIVWhMLAs1
         qZD82bOIAfIP7dMDRMiUjKBxjsBoCvnnsgISVcmpIN3tc/KDljzT5xOXO+YdmqSk3/B5
         dAcg==
X-Gm-Message-State: ACgBeo3X6t6v9qXEK4xDdOTZvnpC/S9v9+cINufimxhHT6xd+3V6bJHT
        QWCPTRCclSXYcMAVWOtY5bdqv6dH48TxBtU/4EI=
X-Google-Smtp-Source: AA6agR7IVbUrRdXAR8J7BEAWRw4bz3FTHFQdHaJCFL2+2dkTaSCQZtdLR+5LMMEMuxHIBf6P+CsfWDHiVZATKnD3yvM=
X-Received: by 2002:a05:620a:205d:b0:6bb:2393:b610 with SMTP id
 d29-20020a05620a205d00b006bb2393b610mr9098842qka.413.1661036525767; Sat, 20
 Aug 2022 16:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1302.git.git.1660884355643.gitgitgadget@gmail.com> <596s400n-s6qs-0s08-s31s-99rq4o016647@tzk.qr>
In-Reply-To: <596s400n-s6qs-0s08-s31s-99rq4o016647@tzk.qr>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 20 Aug 2022 16:01:54 -0700
Message-ID: <CABPp-BH9-k+LiikRLHx8JsfNkihvXazxLPzjQ6-jG-bdDKD5XQ@mail.gmail.com>
Subject: Re: [PATCH] merge-ort: remove code obsoleted by other changes
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 2:22 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Fri, 19 Aug 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Commit 66b209b86a ("merge-ort: implement CE_SKIP_WORKTREE handling with
> > conflicted entries", 2021-03-20) added some code for merge-ort to handle
> > conflicted and skip_worktree entries in general.  Included in this was
> > an ugly hack for dealing with present-despite-skipped entries and a
> > testcase (t6428.2) specific to that hack, since at that time users could
> > accidentally get files into that state when using a sparse checkout.
> >
> > However, with the merging of 82386b4496 ("Merge branch
> > 'en/present-despite-skipped'", 2022-03-09), that class of problems was
> > addressed globally and in a much cleaner way.  As such, the
> > present-despite-skipped hack in merge-ort is no longer needed and can
> > simply be removed.
> >
> > No additional testcase is needed here; t6428.2 was written to test the
> > necessary functionality and is being kept.  The fact that this test
> > continues to pass despite the code being removed shows that the extra
> > code is no longer necessary.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >     merge-ort: remove code obsoleted by other changes
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1302%2Fnewren%2Fnuke-present-despite-skipped-hack-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1302/newren/nuke-present-despite-skipped-hack-v1
> > Pull-Request: https://github.com/git/git/pull/1302
> >
> >  merge-ort.c | 22 ++--------------------
> >  1 file changed, 2 insertions(+), 20 deletions(-)
>
> Nice!
>
> Since I have been in the `merge-ort` code quite a bit as of late, I deem
> myself familiar enough with the code to dare offering my ACK.

Thanks for taking a look.

> What is _particularly_ nice is that this patch removes an `lstat()` call
> that was a bit of a concern for me when using `merge-ort` in a
> worktree-less scenario. After some reasoning about the code, it turned out
> that it is not hit in that use case, nevertheless it is much easier to
> reason about `lstat()` calls that simply are not in the code.

Oh cool, glad there are other benefits too!
