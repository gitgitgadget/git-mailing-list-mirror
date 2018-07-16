Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125A21F597
	for <e@80x24.org>; Mon, 16 Jul 2018 22:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbeGPWpu (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 18:45:50 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:38615 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbeGPWpu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 18:45:50 -0400
Received: by mail-yw0-f195.google.com with SMTP id r3-v6so14778403ywc.5
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 15:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiFwLi6kYJT/s4lEE4cqQ1IxEPDXK3nQbJcEFpz8izs=;
        b=CD5swg4isYnmpZ/vjBXvi2JhrDB8GC2bjSqP3bdXE1UjOWRgRDzXlfoYsGmWXLRW49
         0YK4n1Qb+kixXDYNY2QlquG0NpMZBfobx6AyiynaPzolchb7XYq2WOIrB5KMr90kIWaA
         y/S9vKBAbL3ZrLISB8R7JWLF2wj1HyvOlIX0Y9JGn4x6NadOus1iutRgrtDZNxbM06hk
         meGqKONa0C2drFvQYZwPlu+zpYd+c3jZiT/9KSRyxWGkYSRgAgfLmeol9BDcoaaBcwsf
         LYVrjBBlA1veJSjY8kiT25v9SCbF6b3CjS/9eT4ENAL/ti/0esEVNDsKmkPDiBvLLKDX
         f70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiFwLi6kYJT/s4lEE4cqQ1IxEPDXK3nQbJcEFpz8izs=;
        b=pLkLRKNSQYUVEQsHSfsqNqhJnfvavQUmZMr/MMep0qVj4usAu1hixB98FzO0FpFonQ
         EqbRfjvvSrtEAUK+Pwky7ZmQxs/9iRCeZcKV/kDAuNkCDp18XPrgM6WH6bkpu43gdVP8
         a01FZmnVR/xxAF3J1kadNpEgUoPqmCAXmf3k7lOZDPrPAHsnlfxm8W0dXZwA9eYKFUek
         +/zFpSPZZdtMgrkb8C/ZjHr4UUN/QN1vezqqDasWfXh7r03GZOTFgfEzm/pbu/m7zjhp
         8tuimIP6TF24kMO2cfJHneRFGwsrMVFaF1aMHGCbYGeGeGZaK3GsqrJgbE2aM309dWtz
         MdYA==
X-Gm-Message-State: AOUpUlG63de2VKHXTxffJq+I5oM2JQOqVlcBw3OJWPIrlHjNcW6zY5D0
        Oc0ti+c50U+5JM+1oWv4/bOElbhPup0+kkZyxC/R6Q==
X-Google-Smtp-Source: AAOMgpfMixJGNkmFaRvmvHEp5sJ9QiR1vCjdonliLCFOpR+t2Fcz1d/MsGgDWYRjU0fBnv2kqXzvRmAyF9oNmJxD2r4=
X-Received: by 2002:a0d:d342:: with SMTP id v63-v6mr9001239ywd.500.1531779383800;
 Mon, 16 Jul 2018 15:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <1fd45ef2b15524c18322183231608fe13a733506.1531746012.git.gitgitgadget@gmail.com>
In-Reply-To: <1fd45ef2b15524c18322183231608fe13a733506.1531746012.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 16 Jul 2018 15:16:12 -0700
Message-ID: <CAGZ79kYJdQAsVW+=G6d2LkXzSe4vcJOreb_+-962i1evgynjUA@mail.gmail.com>
Subject: Re: [PATCH 14/16] commit-reach: replace ref_newer logic
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
> The ref_newer method is used by 'git push' to check if a force-push is
> required. This method does not use any kind of cutoff when walking, so
> in the case of a force-push will walk all reachable commits.
>
> The is_descendant_of method already uses paint_down_to_common along with
> cutoffs. By translating the ref_newer arguments into the commit and
> commit_list required by is_descendant_of, we can have one fewer commit
> walk and also improve our performance!
>
> For a copy of the Linux repository, 'test-tool reach ref_newer' presents
> the following improvements with the specified input. In the case that
> ref_newer returns 1, there is no improvement. The improvement is in the
> second case where ref_newer returns 0.
>
> Input
> -----

I fetched the series as advertised in the cover letter; however Junio
applies the patches manually, for which there is a problem here in the
patch format. Three dashes indicate the end of a commit message and
below that you usually have some ephemeral information such as the
stats, followed by the diffs starting with "diff --git", at least that was the
case.

I just tested and it applies this patch cleanly keeping the information
below the three dashes intact. Cool!

> A:v4.9
> B:v3.19
>
> Before: 0.09 s
>  After: 0.09 s
>
> To test the negative case, add a new commit with parent v3.19,
> regenerate the commit-graph, and then run with B pointing at that
> commit.
>
> Before: 0.43 s
>  After: 0.09 s

Nice! The code looks good, too.
Thanks,
Stefan
