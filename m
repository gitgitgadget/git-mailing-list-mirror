Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EBF0208CD
	for <e@80x24.org>; Wed, 16 Aug 2017 05:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbdHPFzf (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 01:55:35 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34160 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdHPFze (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 01:55:34 -0400
Received: by mail-yw0-f179.google.com with SMTP id s143so16787116ywg.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 22:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HPFDM75DFQMiAbonPkOV7jzrP+krbG6xZJRT+LIJl5U=;
        b=ItkO5JsQCwUJeH97pzM/Fb4o3UrJmnk91eVz3SWVY5vOuulYpCDw1spN7zocvqFsr7
         Jl6Ujy3/bcuKDyYGLKLSmGmOWsPAtNDsu6Q0+CZfVOU8OhAQOYSSb+sOM9lGczJRFrRR
         KSfal/nnC1PkvzYVgyOefrxsTgaqSp8rKm1MIgwwWRUPgjPBG9Xjq7SZUvIIPT1VMqEz
         CvV06nU5WWdsnL+BMn1irzi3lYw2POq77IlXbjfPW5g/59IPHL273An5RR4QvDe7BYAo
         Sg+XXmdMrYiM1wUamCN3etdw0G/9n3YvTXXnIJclrqJvz6+5CMPVJz4B4NLvC3ohLONe
         vYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HPFDM75DFQMiAbonPkOV7jzrP+krbG6xZJRT+LIJl5U=;
        b=WR76KcvtFNrzFrFqVRL9kY/6oVSdpU8ZKj0d/w0s2TbHdmrbTOuVFmF4STnUOmjfQm
         /RiQYmlTfyllqja4n3Cz1oYGno25yvhwgm/+RAg3y0k7E0ZNkHNZrC033Ie5nPEJ3NUl
         REOR5g/a9P6tJk/y+l1IKrSpvMjEoo9qPLWuHCt/PnYsKDxH2XI5d3q7Co3qCo9UNGie
         WWYXlWcj5WaDHs/qPtOrpdf4aFnNyYiMblIQhbGmvYQ7HCEHE1/YF8hBb4ruiYLuA4f6
         Gi2+xwccKheSoM+lj+cBKn+yWwQDnMlH8c0GD616/muGvejmgsuX7i1v/S0osRLeJ5+B
         rArA==
X-Gm-Message-State: AHYfb5jmb/NWkbgt1XwV9TNnp5G9MAv0beb4+Uf/UmLvbxvsCWRim5F0
        u4fH7P39nxAXw3ptr50/zLN8wI7/1L28
X-Received: by 10.37.55.79 with SMTP id e76mr441688yba.215.1502862933393; Tue,
 15 Aug 2017 22:55:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 22:55:32 -0700 (PDT)
In-Reply-To: <cover.1502846454.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com> <cover.1502846454.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 22:55:32 -0700
Message-ID: <CAGZ79kYscfRQx8x4rK9R-V73aa-QMSZraO_0ZJDvB+aFDWLi6Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] "diff --color-moved" with yet another heuristic
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 6:27 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> These patches are on sb/diff-color-move.
>
> Patches 1 and 2 are unchanged, except for some line wrapping in a test
> in patch 2.
>
> This has been updated to use the same alphanumeric heuristic as blame
> (20 alnum characters). I tried it out and I thought the results were
> reasonable in a patch set that I'm working on (the pack-related function
> refactoring one).

ok, great!

> As for refactoring blame.c and this file, I'm not sure where best to put
> the new function, so I've added a NEEDSWORK for now.

Let's just cook this heuristic a bit and see if we want to refactor them
or tweak them differently.

> As for detecting block boundaries in adjust_last_block(), I've left it
> as-is for now. I think it's clearer if the parent function provides that
> information, since it already tracks that. In addition, we avoid corner
> cases such as what happens if the block is at the start of the diff
> output (we must ensure that we don't read off the beginning edge, for
> example).

ok.

Thanks!
Stefan


>
> Jonathan Tan (3):
>   diff: avoid redundantly clearing a flag
>   diff: respect MIN_BLOCK_LENGTH for last block
>   diff: define block by number of alphanumeric chars
>
>  Documentation/diff-options.txt |   8 +-
>  diff.c                         |  47 ++++++--
>  diff.h                         |   2 +-
>  t/t4015-diff-whitespace.sh     | 261 ++++++++++++++++++++++++++++++-----------
>  4 files changed, 236 insertions(+), 82 deletions(-)
>
> --
> 2.14.1.480.gb18f417b89-goog
>
