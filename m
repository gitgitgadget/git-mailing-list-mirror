Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B29241F597
	for <e@80x24.org>; Mon, 16 Jul 2018 22:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeGPXRW (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:17:22 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:39237 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbeGPXRW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:17:22 -0400
Received: by mail-yw0-f195.google.com with SMTP id r184-v6so9422547ywg.6
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PBPxN+V2uXBPwCTudaeJuxMam0sHIEU2RXoF0CNVFJo=;
        b=VddlZqKDnJKCd2ZxkhMKrBNGP2M9IvSYMai5itozn3HReckDnVJ7VS19xWuLYqObbM
         dkTgvgBidkoG8+08F8V/QNo+fo8eFdmTAAsr+EJTpFPz4E51vIgxhXd5QjgAPSIWn/E/
         z3e+F+FuT9MMzi/SFEcDJCQkvBEbjvTbbGnItObc/nR9TuN5cwHtFCgpV1AVdba9epZ0
         aZkV4XN5p8Un+qOd0k/pzdqcrKpgkuxzkXk/pPwrFzYptGZ7YBTYPh20yLO0z/4THOnU
         XPigPY46QZQEUihS3QD9GXjYOnrEy8jjmdt6KukBO1u/HBjqXpt+JHSo0uUlUlnoT7BT
         hBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PBPxN+V2uXBPwCTudaeJuxMam0sHIEU2RXoF0CNVFJo=;
        b=bLx+pmP1V7yhzAn8SxqI0Grhz+QjU9Jt5jGz7vqskRHzqo4stQJDikFtYUi4VKDtH3
         eVI1o6GIqcn6g1FCNpl7FX6cQ6rp0es5WLG0tNTY4AVRO8kg458mivnDwNciBLlTexK/
         c0nEbIKfvYU+vkoi1vS+2Vo9FbG4PkIGPXof6t0RxfhXNAuBqwwBF6Q3guVK/O76KsWt
         ts71JRkvH12lPCdm9kCSy6yerrl98AUjoadL5jDrziVoH+pXOKAbRSpgHxuWTFHRecDg
         6VlBBMKXMT6OMEX5ym6p4+fXV2XsOJifBbQlIBaCnwvdk334utcEtUKUFQFc9rf8ehQi
         qpNw==
X-Gm-Message-State: AOUpUlFB2WR8CXLdGcxbwFOGg/idwl7pf6OdcSR2nE6zli76vOo68Uqg
        yeJC8CCk1pQdh9iGtExt2ZPHQy+pGpNsQOeiN3wBxg==
X-Google-Smtp-Source: AAOMgpegcRLA9SfeNV/Sl7cJ3VQJHvDUIb+m0PRwElO+0U93/fn3ZppiGNq01H1CSan28ANV2+sFh/m5DFiDb5qbzus=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr7115401ywh.238.1531781269813;
 Mon, 16 Jul 2018 15:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <a60b7011adfd107633d7d3158c9c3fa127dc1a61.1531746012.git.gitgitgadget@gmail.com>
In-Reply-To: <a60b7011adfd107633d7d3158c9c3fa127dc1a61.1531746012.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 16 Jul 2018 15:47:38 -0700
Message-ID: <CAGZ79kZesqs4=OWcgT_8ycpc5wFTArLKCbu+9dnOPJJLUbuuZw@mail.gmail.com>
Subject: Re: [PATCH 16/16] commit-reach: use can_all_from_reach
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 6:00 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The is_descendant_of method previously used in_merge_bases() to check if
> the commit can reach any of the commits in the provided list. This had
> two performance problems:
>
> 1. The performance is quadratic in worst-case.
>
> 2. A single in_merge_bases() call requires walking beyond the target
>    commit in order to find the full set of boundary commits that may be
>    merge-bases.
>
> The can_all_from_reach method avoids this quadratic behavior and can
> limit the search beyond the target commits using generation numbers. It
> requires a small prototype adjustment to stop using commit-date as a
> cutoff, as that optimization is no longer appropriate here.
>
> Since in_merge_bases() uses paint_down_to_common(), is_descendant_of()
> naturally found cutoffs to avoid walking the entire commit graph. Since
> we want to always return the correct result, we cannot use the
> min_commit_date cutoff in can_all_from_reach. We then rely on generation
> numbers to provide the cutoff.
>
> Since not all repos will have a commit-graph file, nor will we always
> have generation numbers computed for a commit-graph file, create a new
> method, generation_numbers_enabled(), that checks for a commit-graph
> file and sees if the first commit in the file has a non-zero generation
> number. In the case that we do not have generation numbers, use the old
> logic for is_descendant_of().
>
> Performance was meausured on a copy of the Linux repository using the
> 'test-tool reach is_descendant_of' command using this input:
>
> A:v4.9
> X:v4.10
> X:v4.11
> X:v4.12
> X:v4.13
> X:v4.14
> X:v4.15
> X:v4.16
> X:v4.17
> X.v3.0
>
> Note that this input is tailored to demonstrate the quadratic nature of
> the previous method, as it will compute merge-bases for v4.9 versus all
> of the later versions before checking against v4.1.
>
> Before: 0.26 s
>  After: 0.21 s
>
> Since we previously used the is_descendant_of method in the ref_newer
> method, we also measured performance there using
> 'test-tool reach ref_newer' with this input:
>
> A:v4.9
> B:v3.19
>
> Before: 0.10 s
>  After: 0.08 s
>
> By adding a new commit with parent v3.19, we test the non-reachable case
> of ref_newer:
>
> Before: 0.09 s
>  After: 0.08 s
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---

Thanks for the commit message. The code itself looks good!

I think this series is nearly done, I have only commented on
style issues so far, which are easier to address than fundamental
design issues or naming things.

Thanks,
Stefan
