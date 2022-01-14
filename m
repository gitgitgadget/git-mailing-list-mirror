Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F20C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 16:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243338AbiANQ2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 11:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiANQ2H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 11:28:07 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31219C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 08:28:07 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w16so35813695edc.11
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 08:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FyqkfFe5AH6Wwi1iUS+OaA1M0QHbN5YeFW7PZMbFmM=;
        b=UtDKFo7wAVW45LNExudLsq7GayC6fkyaRvQc91y6vViyUrP3yKuRvinvtRdTebU5qM
         IlDFSO+2Vdm3imHc2imUGAbBXZkogacjNr68jKtgDeZ2vC6sYcTshZjmfyuycdsBZQXu
         avEQAcXnNAYlCF90CnQ7cpellDq3vf6/3ZaCBXE05eSOKxDYKNtDgUevIfLF+2ayxvIY
         nN2RlSvbmkEIORXuRUN7RbllJKBt9YXSbmU9E5k9aPselFmsdujGMitnTfDAk61N/zPn
         ULvQIFf7mOnEJaB1xwT3irz2UuiNruuXcwpiwTgz+2P7azM29fnpWn9+CLkVggoQJ/6X
         x46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FyqkfFe5AH6Wwi1iUS+OaA1M0QHbN5YeFW7PZMbFmM=;
        b=guldL7/KhNG6oeYXrfrIv21W8qFy1EOFPDSpia6DHgk1+LrfV3G0jdHuL3hL4udeDT
         8+2EPVjhnnO+/1I2lFpKrafaxIpuVoIQZk4P+NjRWtPSUpUu/BEL1oyd8EXRs3fN/pR4
         xopQ2mVEMKhyTkvzlLxPv5N6y73BDQLd2b30aPdOzPDnU05HoAj/XeUarspWjGdyc8j5
         bqB0XUjl74bZfXPnp5BVdn53NBB7g2Sq+5LLIYrFQNF7SQCavE+jzGHax/Pk6p5Ro9zU
         3oG+vGz/tdhMt1ntM6Kj2YG+9Q1V+SZzNG6UtxDr92QMC4giUOKkSI59WvyhQqPZ1b3a
         VW6Q==
X-Gm-Message-State: AOAM533biXt1lIoAuG/qvDmXowmuiIg2WIZMbhVXp1cwVuVzTdtXlOmI
        fzQvBvFk4H1pIWUZxCzLYdcAAmGFagUCXtQlhBnKnss8wOS4Fg==
X-Google-Smtp-Source: ABdhPJxfe5S+cEwtx74ibnZzQTDOREtbWcUPuDwVJKCK0Mjt+FQuPaby4WwRKeuIhW5s7eOSLSS1UxVXNh5dTk5qpIU=
X-Received: by 2002:a17:906:dc8e:: with SMTP id cs14mr7624560ejc.269.1642177685726;
 Fri, 14 Jan 2022 08:28:05 -0800 (PST)
MIME-Version: 1.0
References: <xmqq35lrf8g4.fsf@gitster.g> <xmqqk0f3dk5o.fsf@gitster.g>
In-Reply-To: <xmqqk0f3dk5o.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 14 Jan 2022 08:27:54 -0800
Message-ID: <CABPp-BFGxKBzi5RYDuiJv6Vz7yyGYTOdJC9cL_EkPGNJ5BksYQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2022, #03; Thu, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 14, 2022 at 8:19 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > There are a few "oops, what we merged recently is broken" topics
> > that still are not in 'master', but otherwise what we have should
> > be pretty much what we'll have in the final one.
> >
> >  - I am reasonably happy with ab/refs-errno-cleanup (just one patch)
> >    that fixes the incorrect state of the code left by the earlier
> >    parts of the topic that have already been merged during this
> >    cycle.
> >
> >  - I am also OK with ab/reftable-build-fixes (two patches), one for
> >    general type correctness fix, the other for helping older sub-C99
> >    compilers.
> >
> > If there are fixes for regressions that we introduced during this
> > cycle other than these two topics, I certainly am missing them, so
> > please holler loudly and quickly, hopefully in time for me to tag
> > the -rc1 tomorrow.
>
> Oh, by the way, the tip of 'seen' has consistently failing the
> leak-check test.  I didn't have chance, time or energy to see if
> they are failing merely because an existing test script that used to
> be leak-clean gained a use of command that has been known to be
> leak-unclean without introducing any new leaks, or our recent change
> did introduce new leaks to commands that have been leak-clean.

It's apparently the latter, because there have been no test script
changes in the relevant tests.

> Somebody with too much time on their hand should go in and check to
> help, before CI testing on 'seen' becomes useful again.

This "fixes" seen:
https://lore.kernel.org/git/pull.1192.git.git.1642176433017.gitgitgadget@gmail.com/

I briefly looked at a couple leak traces and thought they looked ref
related, but I don't have time to go hunt down memory leaks right now.
I figure this thread has reported them, so let's just get "seen" back
to green.
