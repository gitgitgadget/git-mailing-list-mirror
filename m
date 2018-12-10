Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF5120A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 16:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeLJQuI (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 11:50:08 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39240 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeLJQuI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 11:50:08 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so19209540itl.4
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 08:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qt+f+1RWz8xoqREdXfCiRi9ZRHWN9pFPj4JsNbACnec=;
        b=Al+PpDtn6h7s1C73c0EJAGBKVoFJxvcsWMo/1hd8fVY5Nf5/0Ggr3oVs9CxShocu4C
         WFCdeNaUkN6mTLxkXx7PhlKQMa0WkUpFChFd8wu+3ZaawxglmtexewqRfjCGtQE81cSJ
         wYgyVKjjadO6CRWpqp87QRBG+a+LyUpi2tR5cG4l7nDAwBMDmyKI/E7fBMQwor0W1069
         PzBZkXyeCvF1r/8r3SjIIMCFV2mJp2DMit4zBXGFvMmUqfJHikpUdM7e+hYuk0ieU5JR
         /PYG/t/YtNhpvXc56WQg9vFW2k79iBkFEZPnnLJOgfamx640a1s/+CRazhRQ8tT9ds7x
         1q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qt+f+1RWz8xoqREdXfCiRi9ZRHWN9pFPj4JsNbACnec=;
        b=Kg+9b6USWWn9WzVCA74ZBMrZ9SiUSXWAUe9ts9Pvrlqk1Aq7TdNbGvxUDBJXaHcp1j
         DMRgabNOhd8l6h9EWSQydZVGplWu+ht9b6SAUVg/7XBVxQFJR76JuhcN1KwDCYadOV23
         iCS4CNZA2CvVOC0PFvLGfaNK4ENpgTqPSrT67Up3FhPeBjuB6TNw4gbzqw2tYGxyqxPG
         ZXJ/RroBT+G27ZsfbL6/wkXKgDMEW67NVHMW+6Sqthnl/Xn/grMsBk1TOGWn/OBJLQCC
         tIBUrUeXnuWZhGHFoAVHQpe7Tv4Ys+JC3klfiQJIZ6UfwaLWYV1btsnl5xQ9KtRFrgXz
         nLvQ==
X-Gm-Message-State: AA+aEWae93N+tZPvWVosWeY/8jlUvhndWcI/mW/i20LeerySTd8pZo1T
        oQgsG/jDjWHqWwURc/LsUJTRacwwUwa2xSrCOJ0=
X-Google-Smtp-Source: AFSGD/WizvdDP/yqKUyLwC2BT40TYXhu4/LmrRQCw2aGL66GRK0QOGwilsfA2L8m2PsOGq6YAVZyEL8TfKfC8OagLdE=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr11607911ith.123.1544460607795;
 Mon, 10 Dec 2018 08:50:07 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
In-Reply-To: <20181209200449.16342-7-t.gummerer@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Dec 2018 17:49:41 +0100
Message-ID: <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 9, 2018 at 9:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> Add a new --cached option to git checkout, which works only on the
> index, but not the working tree, similar to what 'git reset <tree-ish>
> -- <pathspec>... does.

Elijah wanted another mode (and I agree) that modifies worktree but
leaves the index alone. This is most useful (or least confusing) when
used with <tree-ish> and would be default in restore-files. I'm not
saying you have to implement it, but how do the new command line
options are designed to make sense?

I guess if --cached is "update index only" then --no-cached goes back
to the default "update both worktree and index" and we need a another
option for "worktree only"? Can we have one option with three possible
values (index-only, index-and-worktree, worktree-only) maybe?
-- 
Duy
