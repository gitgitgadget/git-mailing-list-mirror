Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F100C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 16:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 641246101E
	for <git@archiver.kernel.org>; Thu, 20 May 2021 16:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhETQy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 12:54:57 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:43949 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhETQy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 12:54:56 -0400
Received: by mail-ed1-f47.google.com with SMTP id s6so20164920edu.10
        for <git@vger.kernel.org>; Thu, 20 May 2021 09:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ActCasgI8hHTjwiPDp8bVjF8zPhgD38rLeQhYdrB38=;
        b=PYetLTMd/jq1ycxJYOwys+f69HzPyZrOZG4ZGQ0Sb8LBEIEO5pkRTY+YKDFtlUjJ6k
         GbcaJ+GTcJNtVTgMC8bVCVwwRy/VdEBk9DcqGLvpz9OT4BFhfzWS5rAqZiqaiOXMf7/+
         QXOxQtfbEv96vHOUy/klL/6FJR1LkxbDRd2WyN34ToXPYY4X8INBc8WqLtWMq1f2sOaI
         ZPJ32TO2Lib4r8Q+DzYvQDBc4Wsm/h1GCXz7WP3tMtcscb+WsIauIoPg6TEkTE6e/C0H
         r8wifEAVs2Ufbl7NifZNBkVmaN8q3zuGlTxgXtdUaFW8uebGe7zUWPTV2DbZ0fBobVQi
         hl/w==
X-Gm-Message-State: AOAM5301hPXwB4+WdxlnySSeKWAbur3sVBM5SYz2Y6bwBp0lJXOxzz/y
        8a/7fmmNJ2g5XAy7rNJk09PbTg14VNAtz2HSBrQ=
X-Google-Smtp-Source: ABdhPJzT3E94J3te5Jk+qQyc7AUk1qY9/EMZQ9TcVlv6VFcoibQndbhcTdDjzVTRSu/t6+onSBbFsg91UTkfLBDs01U=
X-Received: by 2002:a05:6402:152:: with SMTP id s18mr5828313edu.221.1621529614232;
 Thu, 20 May 2021 09:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqv97g2svd.fsf@gitster.g> <ab2d8b16-42db-9675-083a-efa7cfca6e4c@gmail.com>
 <xmqqh7iyuhlp.fsf@gitster.g> <xmqqcztmuhem.fsf@gitster.g> <CABPp-BEGtrb0QjhVff57=s8-8w1CCvw9N_mAm166pzyVDcL_7g@mail.gmail.com>
In-Reply-To: <CABPp-BEGtrb0QjhVff57=s8-8w1CCvw9N_mAm166pzyVDcL_7g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 20 May 2021 12:53:23 -0400
Message-ID: <CAPig+cR_rNKoY385vp3ZyQ73O1HEbysLSCMpVCG=MT9ebSNiyA@mail.gmail.com>
Subject: Re: [PATCH] revisions(7): clarify that most commands take a single
 revision range
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 12:45 PM Elijah Newren <newren@gmail.com> wrote:
> On Wed, May 19, 2021 at 10:03 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Well, apparently the proposed text may have failed to educate you
> > about what a "revision range" is and how it works, so it is not good
> > enough, so I'll postpone merging the change down further and see if
> > somebody else can come up with a better description.
> >
> > Thanks.
>
> I think it's helpful and would have answered questions for users that
> I've had to manually explain to folks a few times, so while it may not
> be optimal, I do think your description is an improvement to the docs.
> That said, it can't hurt to see if we can find out what caused Bagas'
> confusion and see if we can improve it, but I wouldn't hold it up
> indefinitely if no better wording comes along.

For what it's worth, as a person who is far from being a
revision-range expert (and who doesn't typically think about them), I
found the proposed text illuminating and clearly written. I learned
from it. So, I agree with Elijah[1] that it is a good improvement to
have (even if it's not perfect for every reader).

[1]: Extended LInear Jump AHead
