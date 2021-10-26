Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8FEC433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 00:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1499860E09
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 00:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbhJZA5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 20:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhJZA5k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 20:57:40 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67816C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 17:55:17 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b188so17953819iof.8
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 17:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j5fT3+XnfMNzvRdK9GfWq1bYkmUQfW6YZoda7ZdWnyo=;
        b=YxOlRbv/3OHcv02kPHYU+qTFdxQHDC5E+DSQgoStuxFVELB87GsUlxPXhZeQYQ9kfy
         FRecBZ4sfuxnjpTLTAIzzsgLzqWYCE2OVENgrFcl/PMJMHC2+GCtRReLrB1CkHCwmoUZ
         gdsqA+D+zI5SjqTmYf+NjBF/fAC1l0k57Toh4JW1D1oagoS+ZmDeARM/5NcrQjYEHxW4
         ckV112y+XabWlexhhn5yHwHbxAQFN/yLGf6wUjbtjGy1Z4RrfQwoO5CMbTVKeGlXROO4
         9ybCoHTVp3ttdYfEgQnZeRAawvnQ6bWL5+h9I6eDAYF+icBBnS1OoZNIm2sC05aU4n+t
         h3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5fT3+XnfMNzvRdK9GfWq1bYkmUQfW6YZoda7ZdWnyo=;
        b=nofy1LLIruZx5aT1cvvl1aJtxE/Y4DV7rDa3mdvLQWtjXRx1FfSLC418/rJK3GgVtb
         OpQFXy4TjcnRVG0FRee71nWNtdaSyr+1Vs/sirHwmlH5taPo80vgxXvidw8TtB4XMVue
         LeEmWkE435hxcwgDQgjslTeBrr/VdN/JV+HXZ2KV84Bish8I0db63JKcuOeGvM4AVr0g
         KKczLaDchSneBwZfgafXzEg2/gAzdQmrFDX34rBMkUb5hbxoCePjfQLWrpb8VNTOq6MH
         RUyxYhGAJSWjuPK9pQQyuPuDPs0fCvMYLOAjfleO30IYuCGXfPH1bxnWcrFvc5d1qg47
         ZVTA==
X-Gm-Message-State: AOAM532Xv0xCicgFV6mPZ0jCFKYS55+Ex+ExluIvNi5UzkbWjjHGi4/Q
        S05dPiHLnb1Xv2p1o4pMmjdbjFMt1OE4zHK68jk=
X-Google-Smtp-Source: ABdhPJzCS/V7lxuXmR8nIVQagXBWcTbKVAuhPlrP2ySeICBQnGhCCJIs0QK5xZPNK4zcn5twDS2AuwcvRwHfCCQg4DM=
X-Received: by 2002:a6b:6a05:: with SMTP id x5mr12911790iog.6.1635209716612;
 Mon, 25 Oct 2021 17:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1116.git.git.1635201156.gitgitgadget@gmail.com>
 <504da32a95bd4a1e4368aca68b609387316ea671.1635201156.git.gitgitgadget@gmail.com>
 <YXcyJBmRvIEVSiaM@camp.crustytoothpaste.net> <xmqqr1c8zpmw.fsf@gitster.g>
In-Reply-To: <xmqqr1c8zpmw.fsf@gitster.g>
From:   Robert Estelle <robertestelle@gmail.com>
Date:   Mon, 25 Oct 2021 17:54:50 -0700
Message-ID: <CAMmwyQor1AekB9cCUE3osLJeb2r_w0q0T1JqUcNFk6L=7O2-Jg@mail.gmail.com>
Subject: Re: [PATCH 2/2] color: support "default" to restore fg/bg color
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Those are good examples. Note that this applies to more cases than
those relying on transparency or patterns: color terms often have
defaults that are not identical to their ANSI palette. I suspect
*most* themes are probably this way, based on a quick sampling.

You can see a bunch of examples here:
https://github.com/mbadolato/iTerm2-Color-Schemes#screenshots in all
the themes where the background color in the "40m" column isn't the
same as the unset column before it. (All of Terminal.app's built-in
themes are that way; I know xterm defaults to black on white vs white
on black; and so on).

Best,
Robert

On Mon, Oct 25, 2021 at 3:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > For an example of why this differs from white on black, let me mention
> > that I use a semi-transparent terminal, where a black background is
> > opaque black, and the default is semi-transparent.  I assume other
> > possibilities include patterned backgrounds (Enlightenment, anyone?).
> > Whether you want to include something to this effect in the commit
> > message is up to you, but I provide it for the interested reader.
>
> It would help support the description of the cause, I would think.
>
> I am also OK with these changes.  [1/2] is good for completeness,
> and being able to say "go back to the default" without having to
> know what the default is with [2/2] is also a good change.
>
> Thanks, both.
