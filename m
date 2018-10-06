Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7AD41F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 16:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeJFX6K (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 19:58:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33263 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbeJFX6K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 19:58:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id e4-v6so16535350wrs.0
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 09:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hKJ5NCHMOrQq0ryOeApdgZNgXi/nBJsfPD5QzuQ3u0I=;
        b=sui+lpAvacyLgteQEPN2UNc19O4n+L5mNOE8dxYgMRhfKg0EwuQyYHAAhMWzQct+98
         D1cOz19+qVlnZLcIEXxvC1AKIh2PUSGCCGBTWBt88ltl9BalkIvhYJxJWzhe1GyzcE2d
         zavwEbksgtyu8bb2j4HSA1KwErl1sHKHAm5kRSDYazehn7lzcVDeE4eCWEgDwn2CgwDA
         bBwp9NTqM6wJc3o4c+8Iilr0AD8rJpCqhtCGmzrgP+94HYdNfp8d1bDp9DtD/gSnWwqX
         NudmtbPiCVVXkPimcTHhb632iknrHpz9nIOW9VlmQ9BAH1Y1C0O8JM/f7rEMtz0PFfBT
         k63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=hKJ5NCHMOrQq0ryOeApdgZNgXi/nBJsfPD5QzuQ3u0I=;
        b=HAIRLcu8ujR6tWqQzAxcSzn7QEjuol7W/xmjPnZ990ezjR8X6jP3g3dRdOVxGX+IzB
         TZXdf4cIllc/SeZY+3YDTzzyFslvwdGuXn0+sztuGLHDRoCJZfrGAyRpZ8TKXDP3aa/X
         XkmLo790Bnfd+xfJqrrch5pldG7ljuFJo+Pc82PK/6A9DJVf7joBF5a4NxD1QBuFlut4
         uxJAdAFuwrY44V3IwTAsIkfS8pNo1SrxOTvCpIoCznbZjo8O3jvfiTi1pN4BcS05m2cG
         dt0VJySKq8TE1oeuqXx3Uc+lH/U4PGKGURSttkhqL6E9MmQoDOQryrxYMgUsHC2SvwYH
         VlJQ==
X-Gm-Message-State: ABuFfojfiKc57gz6q21c8ddF2CbseHnIEEORwP2yf8NSiMX4rySiGTnA
        62Fy5mIK1wVELRdqumN9V/M=
X-Google-Smtp-Source: ACcGV63LtUuusH/ICV3dbV2F+KH5ECzBvE2Ir0/l8pkALLFikeGrULSYAwgmDlWmWp1RsO7s81Q8Ig==
X-Received: by 2002:adf:ecc9:: with SMTP id s9-v6mr10767944wro.142.1538844843795;
        Sat, 06 Oct 2018 09:54:03 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (eka203.neoplus.adsl.tpnet.pl. [83.21.168.203])
        by smtp.gmail.com with ESMTPSA id u76-v6sm9834027wmd.10.2018.10.06.09.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 09:54:02 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] commit: don't use generation numbers if not needed
References: <pull.28.git.gitgitgadget@gmail.com>
        <efa3720fb40638e5d61c6130b55e3348d8e4339e.1535633886.git.gitgitgadget@gmail.com>
Date:   Sat, 06 Oct 2018 18:54:01 +0200
In-Reply-To: <efa3720fb40638e5d61c6130b55e3348d8e4339e.1535633886.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 30 Aug 2018
        05:58:09 -0700 (PDT)")
Message-ID: <86woqvxbh2.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> In 3afc679b "commit: use generations in paint_down_to_common()",
> the queue in paint_down_to_common() was changed to use a priority
> order based on generation number before commit date. This served
> two purposes:
>
>  1. When generation numbers are present, the walk guarantees
>     correct topological relationships, regardless of clock skew in
>     commit dates.

Which means that we would walk no more commits that there are on the
_longest_ path...

>  2. It enables short-circuiting the walk when the min_generation
>     parameter is added in d7c1ec3e "commit: add short-circuit to
>     paint_down_to_common()". This short-circuit helps commands
>     like 'git branch --contains' from needing to walk to a merge
>     base when we know the result is false.
>
> The commit message for 3afc679b includes the following sentence:
>
>     This change does not affect the number of commits that are
>     walked during the execution of paint_down_to_common(), only
>     the order that those commits are inspected.
>
> This statement is incorrect. Because it changes the order in which
> the commits are inspected, it changes the order they are added to
> the queue, and hence can change the number of loops before the
> queue_has_nonstale() method returns true.

...which does not mean that it would walk no more commits than on
shortest path; thus it can give performance regression if it chooses to
walk longer path first, compared to date-based heuristic if it chooses
shorter one (but can walk few commits more that strictly necessary on
chosen path).

O.K., I can understand that.

>
> This change makes a concrete difference depending on the topology
> of the commit graph. For instance, computing the merge-base between
> consecutive versions of the Linux kernel has no effect for versions
> after v4.9, but 'git merge-base v4.8 v4.9' presents a performance
> regression:
>
>     v2.18.0: 0.122s
> v2.19.0-rc1: 0.547s
>        HEAD: 0.127s

Now I will wonder if the 0.005s difference between v2.18.0 and HEAD
version is within the noise (within the standard deviation), or
not... (just kidding).

>
> To determine that this was simply an ordering issue, I inserted
> a counter within the while loop of paint_down_to_common() and
> found that the loop runs 167,468 times in v2.18.0 and 635,579
> times in v2.19.0-rc1.

Nice analysis.

>
> The topology of this case can be described in a simplified way
> here:
>
>   v4.9
>    |  \
>    |   \
>   v4.8  \
>    | \   \
>    |  \   |
>   ...  A  B
>    |  /  /
>    | /  /
>    |/__/
>    C
>
> Here, the "..." means "a very long line of commits". By generation
> number, A and B have generation one more than C. However, A and B
> have commit date higher than most of the commits reachable from
> v4.8. When the walk reaches v4.8, we realize that it has PARENT1
> and PARENT2 flags, so everything it can reach is marked as STALE,
> including A. B has only the PARENT1 flag, so is not STALE.
>
> When paint_down_to_common() is run using
> compare_commits_by_commit_date, A and B are removed from the queue
> early and C is inserted into the queue. At this point, C and the
> rest of the queue entries are marked as STALE. The loop then
> terminates.
>
> When paint_down_to_common() is run using
> compare_commits_by_gen_then_commit_date, B is removed from the
> queue only after the many commits reachable from v4.8 are explored.
> This causes the loop to run longer. The reason for this regression
> is simple: the queue order is intended to not explore a commit
> until everything that _could_ reach that commit is explored. From
> the information gathered by the original ordering, we have no
> guarantee that there is not a commit D reachable from v4.8 that
> can also reach B.

So the problem is with shortcuts, i.e. merges of short-length branches
(like e.g. fixup topic branches) based on an older commits (like best
practices recommend: base off oldest applicable commit).  Due to the
bottom-up nature of generation numbers examining such shortcut is
postponed, compared to "heuristic" ordering by the creation date.

By problem I mean that generation-number based code gives worse
performance than commitdate-based code.

>                  We gained absolute correctness in exchange for
> a performance regression.

Or rather we gained better worst case performance in exchange for worse
average case performance (thus a performance regression).

> The performance regression is probably the worse option, since
> these incorrect results in paint_down_to_common() are rare. The
> topology required for the performance regression are less rare,
> but still require multiple merge commits where the parents differ
> greatly in generation number. In our example above, the commit A
> is as important as the commit B to demonstrate the problem, since
> otherwise the commit C will sit in the queue as non-stale just as
> long in both orders.

All right, that is good explanation of why the change.  Worst case
performance is rare, performance in case of "shortcuts" is more
important: they are more often (I guess -- are there any tests for
this?).

> The solution provided uses the min_generation parameter to decide
> if we should use generation numbers in our ordering. When
> min_generation is equal to zero, it means that the caller has no
> known cutoff for the walk, so we should rely on our commit-date
> heuristic as before; this is the case with merge_bases_many().
> When min_generation is non-zero, then the caller knows a valuable
> cutoff for the short-circuit mechanism; this is the case with
> remove_redundant() and in_merge_bases_many().

TLDR; use compare_commits_by_commit_date() if there is no min generation
cutoff, compare_commits_by_gen_then_commit_date() otherwise, right?

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/commit.c b/commit.c
> index 1a6e632185..449c1f4920 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -874,6 +874,9 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n,
>  	int i;
>  	uint32_t last_gen = GENERATION_NUMBER_INFINITY;
>  
> +	if (!min_generation)
> +		queue.compare = compare_commits_by_commit_date;
> +
>  	one->object.flags |= PARENT1;
>  	if (!n) {
>  		commit_list_append(one, &result);
> @@ -891,7 +894,7 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n,
>  		struct commit_list *parents;
>  		int flags;
>  
> -		if (commit->generation > last_gen)
> +		if (min_generation && commit->generation > last_gen)
>  			BUG("bad generation skip %8x > %8x at %s",
>  			    commit->generation, last_gen,
>  			    oid_to_hex(&commit->object.oid));
