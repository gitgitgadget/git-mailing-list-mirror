Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD637C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFAA5613CD
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbhI2AML (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 20:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbhI2AML (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 20:12:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8EBC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 17:10:30 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z24so3072545lfu.13
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 17:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMAIhtH+6k4iZFQtu53WEE4uhBnmGA9A+SIedRaNG3w=;
        b=lXBGPaetXgpvGmOrtFFvCuCEWwDgTv91bHbYeO5JQkynSFG3unESfbsWzrUQALvZL5
         3+vutPrYZEJoe3nT6tLRKA9W0g26YN3roNk9mMvKRju36TblLxjtWGTbvMB2+8P9h3Ye
         WgB3/aDNPnHAdY90bbN3Mm8H1m58vw6BJFi+XNaUPCIjRUmhEsyb90Cqhst+il/KMEEv
         UqyIh6Pf+Qm6wjXcr3p3MRhZuYQylQAn4jznPhckLc0O6IGVbGOj4cqvvCsKnaHP8Wyn
         UCzVL9LvfGlrhsRimR+AFn89yiJS98vR0OORBq7VlIgb8s66U81fv5qEFdpTp1kRNguz
         1hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMAIhtH+6k4iZFQtu53WEE4uhBnmGA9A+SIedRaNG3w=;
        b=baSZrCVKGa1cHA4YEnyypiIyxoYsH6o6zzMK3GrwH9raV6Ds76xNJb2WHuMwKnlH1h
         JereojaVWzUdgTnsIHe/e81jx86y6SgmPkT7ffKb3FxAgIf/FfTNoq1LUNdgzJobfZee
         9RB/khenq12AKj+4GVjEiVmibPhEJqbgBKO73xwDWy8h0zJTQP/awYndi814xBNP42u9
         ung1vBPYZMJyZvYcy+zscw/hdGsAKVCwrvvDqE+utIshNPSASFHQoD29oZf524WuABT6
         MEUoCJNLN4vOfaRROjsQZB3p3vRoR/nMJDPN8HY8qbQmoS+4dMWW9pWbKTwecjzmxrK9
         ifwA==
X-Gm-Message-State: AOAM531yFxTpmFO9ZArBfj4P4cOCTr6Z+SxaZZ77KhuKHP435D4ONRi9
        QSTO+n3cvgdpz8qYieJJLnfOVNUDRbOKbAdjRsQ=
X-Google-Smtp-Source: ABdhPJwxWdbLXXPmsMeioNeMw1xIQvUXKufyRmc5UhlZIVoYwhZySBPfDt6wPFUhp6c1CRjjx5cU0E47/CoNyy6q6TI=
X-Received: by 2002:a2e:5712:: with SMTP id l18mr2843071ljb.230.1632874229148;
 Tue, 28 Sep 2021 17:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
 <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com> <6e65f68fd6d4d90b0a7bca2e2e57ace9ad749266.1632871971.git.gitgitgadget@gmail.com>
 <YVOrikAl/u5/Vi61@coredump.intra.peff.net>
In-Reply-To: <YVOrikAl/u5/Vi61@coredump.intra.peff.net>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 28 Sep 2021 17:10:18 -0700
Message-ID: <CANQDOddgurMuxXwpjoTWHDCC0LqSiKdvCtGCikvpu0EPr0x-3g@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] object-file.c: do not rename in a temp odb
To:     Jeff King <peff@peff.net>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 4:55 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Sep 28, 2021 at 11:32:43PM +0000, Neeraj Singh via GitGitGadget wrote:
>
> > If a temporary ODB is active, as determined by GIT_QUARANTINE_PATH
> > being set, create object files with their final names. This avoids
> > an extra rename beyond what is needed to merge the temporary ODB in
> > tmp_objdir_migrate.
>
> What's our goal here? Is it the performance of avoiding the extra
> rename()? Or do we benefit from the simplicity of avoiding it?
>
> If the former, do we have measurements on how much this matters?
>
> If the latter, what does the simplicity buy us? I thought maybe it would
> make reasoning about fsync() easier, because we don't have to worry
> about fsyncing the rename. But we'd eventually have to rename() into the
> real object directory anyway.
>
> The reason I want to push back is...
>
> > Creating an object file with the expected final name should be okay
> > since the git process writing to the temporary object store is the
> > only writer, and it only invokes write_loose_object/create_object_file
> > after checking that the object doesn't exist.
>
> ...this seems like a kind-of dangerous assumption. Most of the time,
> yeah, I'd expect just a single process to be writing. But one of the
> things that happens during the receive-pack quarantine is that we run
> hooks, which can run any set of arbitrary Git commands, including
> simultaneous readers and writers. It seems like we might be introducing
> subtle races there.
>
> -Peff

Yes, the main goal was to avoid an extra rename. I see your concern
and I guess we have no way of knowing if someone is really going to
get bitten by this or not. On the other hand, we do know in the case
of batch_fsync that only Git is running against the objdir at that
time.  I'll remove this change since it's not where the real perf
benefit is.

Thanks,
Neeraj
