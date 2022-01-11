Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27D2C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 19:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbiAKTpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 14:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbiAKTpe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 14:45:34 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0190DC06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:45:34 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id o1so137337ilo.6
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=55fK9MIteWYuPv94bwe924VLhLnrSsEL1wS1w9og6V8=;
        b=dl7BbKi2toyYdCJQvQmAy86PSvsCXhLr3TYwAobGCeNqZm4JNlQsB3dpzfNH1v+qsS
         OZBZgUXjwfNIg1opUQwBv58RxHlrNTcQD2Nb+6N8pCgVefHm7sTmTDIfN5gPsdM+vY07
         I+BwDyJqQ59c5lX1epDPmh9/wucqp10l4RVi1ONQkioY9UC+HOjYfyrlP3PdjdWR0kUA
         aEinf0iqz8DGpkX0F1blxEHo2oqTSlgBJ3XvT8c4rzdVIut0dpudvY/McrjngWAm4jw9
         XabxOmLy0Xp2AjEEqI+1NuLFgkalE2UxqI3HSTZ7nUe/3QPj80d/JqtvH3zh/cUWRPB+
         AUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=55fK9MIteWYuPv94bwe924VLhLnrSsEL1wS1w9og6V8=;
        b=g6HyO7iUvl4Hbw4yeFfaGlT29LFEg1vFN14ZxbDgp85D4zGGXwgQebeP8ocYQ+CLHp
         uNMQwlMhMA2o5DLWKnHmv3w/mVV73uQgBJlor17u28cOvlKHm9CCG8smENo4q60s/K7e
         zWDB/zyAElfQGLA+cPrNHxLY7mFA4eO3UXRKRF/pbcLGa/GiaoutfN/7W6XqsQzhSIkt
         pFm3Q/+mUqMXP2Yjiir44X/gboie22i37bNoNL5RevjIaGkMLPzBPIg3a45tjV7XGzgg
         nk3MBEi3DrVcoDZA1HWyB0ZdRPJXM/hpvUVdz2A/b1D7izVn23WF/RO2WT7kCGAZ3mw3
         R3kg==
X-Gm-Message-State: AOAM533ZfKLMxuhINaTbzi1OYj0WwqlvpsQNolKjahEHa/WDNr0nccBX
        x31h425kKrUcVxI/nVI8mvXESA==
X-Google-Smtp-Source: ABdhPJyhdA6AD8701E4hwYAAS5yGo6axkMsJOaKUNuBavdFHoFW2pvNHsMg8QCXXd1L0m/UMUruong==
X-Received: by 2002:a05:6e02:b45:: with SMTP id f5mr3462687ilu.131.1641930333428;
        Tue, 11 Jan 2022 11:45:33 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n10sm6221021ioz.17.2022.01.11.11.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 11:45:33 -0800 (PST)
Date:   Tue, 11 Jan 2022 14:45:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 0/3] sparse checkout: custom bash completion updates
Message-ID: <Yd3eXHzEG7nJi8ZB@nand.local>
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <CABPp-BG=wr81CPtW1M12xFN_0dyS8mAZjM6o=77LA20Zge8Xng@mail.gmail.com>
 <92913af3-7985-0789-eee0-c84601d2a31f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92913af3-7985-0789-eee0-c84601d2a31f@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 09:17:38AM -0800, Lessley Dennington wrote:
> On 1/10/22 2:38 PM, Elijah Newren wrote:
> > Other than that one nit, patches 1-2 (and the testcases in patch 3) are:
> >
> > Reviewed-by: Elijah Newren <newren@gmail.com>
> >
> > Since I wrote the new __gitcomp() function in patch 3, it might be
> > nice if we can find another reviewer for it. Especially since I've
> > only lightly touched the completion code and there might be better
> > ways of achieving what I wrote there.
>
> I agree - I'll chat with some folks today to try to find the best person
> to take a look.

Having another set of eyes on this code never hurts, but looking through
this file's shortlog (especially with `--since=1.year.ago`), I'm not
sure how many active reviewers in this area we still have.

Perhaps the best thing to do would be to grow some new area experts here
instead. If I were in Lessley's shoes, I would "think aloud" to make
sure I agreed with your implementation for the new `__gitcomp()`
function.

If other reviewers happen to be around (perhaps Denton, who I added to
the CC) that doesn't hurt either, but short of that...


Thanks,
Taylor
