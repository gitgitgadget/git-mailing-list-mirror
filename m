Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C23C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 21:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEBC61058
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 21:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbhI0Vdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 17:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbhI0Vda (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 17:33:30 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163E5C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 14:31:52 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id e24so17513542oig.11
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 14:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRKrwTlpnRVwjDAI3meASP0u/ulg6u5copkOx9iDY6s=;
        b=khgcRnZkThS8aT4jFLRLrfrH9R8sqQdkILoOt7uHqFu/DN2wFzYXuWYyx7/WA+Lc8J
         Dp1F+40r/dlYlxJ/W1IOaNB1XjG0BYeThDiIMbTUQL4qn3vifNFJ2oIJoiXVKu25xk3l
         FlhmrNjP8rVq26FRPJgJb6q4p82HgHgxmfWrSBYjCjjHoiXK4g1ww7khjqP5nyCowpR1
         KU2QlLFzqs62CITjw8JfRP9gLVERoq9vF7sZ5fnLzOQXZv3zfASYkS27qrQlAbIUuTjV
         0m+MYDbgDuIXzCsY3swLadOyzqHH0s1Ii/to9zd7/BrNxW4lUhF7a88QsMlAeTDdg7bz
         6nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRKrwTlpnRVwjDAI3meASP0u/ulg6u5copkOx9iDY6s=;
        b=KCuh2RBzHV8zl/7ysFpdoyuAOFBJhsMVyhVzyd3JsjPCJYeZa+CANbcg+fo8/SemIb
         74UbWzXHcWQsIL00LIcsO2Eq1oV3qZOccyy9G21L5ZoUcH9qF8W6H/zGj84WVeyT24n1
         3/2fXVXqB9J0NgMOPfo06cw0sCoJXW8kvyKzxu47aGHT7YOYyQh6NKMek2bCiXKeAsZ7
         b7mCJepSZG0Dv3hQO9aYQdYlfrJZEJPMwj1e/T0jSDJKN+rV9fLA6yY+MX66XZ4NBdfI
         IlvALrQ9J2MYjz9luZMwTjTZG8NVM7eottAJ47qu4cdCg+A9Ml1ISWOED/lGoWwdeG+A
         fW9Q==
X-Gm-Message-State: AOAM53113qjx8cB5l+Zz4Nzc9ZS8NM+MW1x9ub6Vhl6YYOmserS+Ugw8
        7/qRXJeo+XWZNVZIoGnH4P9B0pziT4jfVBniBgQ=
X-Google-Smtp-Source: ABdhPJyQmi7sVGJJ1MJ97f11H4SAQEAi+8KoIVpJEtnKG1PTnakX2gQA/Ct5MPL0sPXlrwYFnjYyC1qFNbVa+vOITrE=
X-Received: by 2002:a05:6808:20a:: with SMTP id l10mr977423oie.31.1632778311415;
 Mon, 27 Sep 2021 14:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
 <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <xmqq7df1pxgh.fsf@gitster.g>
 <CABPp-BESmz+9vcd0r+5MT8vr7HodecUpLKNL=Hyx4qxLJv0ZCA@mail.gmail.com>
In-Reply-To: <CABPp-BESmz+9vcd0r+5MT8vr7HodecUpLKNL=Hyx4qxLJv0ZCA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Sep 2021 14:31:39 -0700
Message-ID: <CABPp-BEMeJ+-LPQigPQvS3Ez7nf2438rNK+dB5Q0xDHFwzY05w@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Fix various issues around removal of untracked files/directories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 1:41 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Sep 27, 2021 at 1:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > Changes since v2 (all due to Junio's request to consolidate
> > > unpack_trees_options.dir handling):
> >
> > Heh, don't blame me.  I even explicitly said it was merely an
> > observation for longer term, not a suggestion to include the first
> > step for such a move in this series.
>
> Well...the repetitive code for setting up and clearing out
> unpack_trees_options.dir that already existed (and which my series was
> copying to more places) bugged me too, but I was worried that it was a
> bit messy to clean up (and the fact that it took five patches suggests
> it was).  But then you also brought it up as an issue when reviewing,
> so I figured I might as well dive in...

I guess I should add that some of your other review comments were
related, e.g. your puzzlement/assumption that some of my changes
preserved ignored files when untracked files were being overwritten
(which was not what the patches actually did).  Trying to make the
code clearer was in some ways easier by first consolidating all those
other bits.
