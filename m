Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046BA26A1AC
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786071797; cv=pass; b=TJaGOxg0JtBj4V6xuCVRfFkCGhSy513ENmql70/e7JLFDBi9axpaVjYXmHOBdXL55nx5hxLh8oQOazeeeJTZbQcBdYzxA0zTODfCIboTVcq+obc5oNyzRiJn0TVsXUnbiAcZ90XkwCXlI50LU56ydP2ROEuRxQxuVVVJzKwaDnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786071797; c=relaxed/simple;
	bh=mzVqt1LxMZE7KUSTOXTrShvwpcUrq9dKNNLopporGm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xp/sgg9bqx4skEw6K2CdWrOzn5T9WCFoazvIt6dlcxRhx4HuLLv/y4QdtKP9WBkWvFmXuhKycUwlTra14+7aqc7fJ7dpH+F8Caw/tKCw+R1+GdQG+5DivJHZEaWBrNeYKkyEbeWc+nwx86/wPW+A9LfyM0oiGIJvMbgLOVMkHI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pybrUAuZ; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pybrUAuZ"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4ab47c40e7eso1239684b6e.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 20:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786071795; cv=none;
        d=google.com; s=arc-20260327;
        b=PxZXNLJ2nBiGLFJ5dU9n5/FN7r8FZRzrtXr2oXgqFsYfUePvjgj0FDJa7qs4quvEI8
         zoIfk0xxsRpfFs4dpyOiCmiO4GUJI1w4iweL1vGK+XfWmXEuh5xsoMO80Z7hjarfQyPC
         2n0wF6dZRG40XjnVW6BBhUAPIn853TrddoNqGHh4Yk8c+emh1MvsoqamnTtUzkOhPy8O
         0bTOdHIthBJDXQkfJJCwg4lqp+2+jp4JgDqG575bOvPnh+Nvea30MW9/FYUW7iK8jc9X
         2hrPiTAWamb0PszNvudsjv6pvlrPISdWSFBdcIu7BgHGSmGAx3Gtl+t8EKLipO/Pu9pM
         xlLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kXGrQQ8yJLyR1/n6fLBjIaRfcYC1gjmDWkgZvwXoidQ=;
        fh=PdGuLsJN9JVZy5BHY9bPXqzeWCeYFKwbJ2iGslXTO1Q=;
        b=KQisVDwR4vu6KRcqFBtL30zLXF2cypE/5tG7hmTDbMAqelf5kjNowQqHZta8Cc3nzd
         4ByBzuA0xheOFv6yrGRZ6saaHU2NWuWie7T81DV2anQFwQaBIg32RRyJjNxw3gKEPIkN
         t2kLmqDCMxFDCYaDwvWlkz30ungxiawQtllgGnTqnVGr3YT6aisLlEu3QRcWdVhvONF4
         g6XZlzqdZBE2PZrXm7V7S2iSbS9WWbSgt93h89VR/ndFFy/G+lFAua38msjZSH/bXY88
         N34IZrF4Vgy/M7SJKdR1d/tDR2I3BkFJ+IpHRFbwIWPB/NCUG3ujp3h4I93pHiSuQ+yF
         A4Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786071795; x=1786676595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kXGrQQ8yJLyR1/n6fLBjIaRfcYC1gjmDWkgZvwXoidQ=;
        b=pybrUAuZftf83SrQfdPtZOWOiTbd4ZmWSUA9gU7h7j/1K+4Yju/KE6v0JJryRqexAF
         5K+HzK5e3ZG8D+LakWAAl+lhUdGHT1Ld2eAfs/1IX2Gp4Ow3f6jcFohnjY6YjH7gVphE
         67R8+oTIMm0NuM6uoQID85EySPI7sGqPGWBMlNdPqBTVVltI0R8vwOke5NeZl9gRq30i
         5dCn917etzMkTDQtd1jxGYPKYOUMPCyEVsL+P2RsfK0Tc2W2rJ6B2N+kV/d5r+vVC1gE
         DLgSwFHoAAfDp0SmBkQKohKsr5X2FOberWXhuUdS252/oLDruHJ0TKP6V+0Wl7hCd976
         AXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786071795; x=1786676595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXGrQQ8yJLyR1/n6fLBjIaRfcYC1gjmDWkgZvwXoidQ=;
        b=l3MzEmluewK2xcS2eA2/l4NgWujO3ufPw9HWev3OqbFWmAb60OEjH3+tNEvhXwdxVD
         xv7xnVI9abABNVnoe1CntQbJeHjqSkok6LUJLIP/OMIAfMZIh+VbdznYsb89U34WZlfe
         xiOt+L5Vcmg1jNXbHzB2u7Ia2esNcOa955njmUNmk2mKCd+KYD0frBUhfHw4DxFBKk3/
         +sYe7IKWMqgI2/R1u16jnnsePsKi5NYuZ2ZMOiCgz6ns61/y8u+3aHn/FoRz6Mkee3R6
         Vi2RvwpILyvvwWrdsxrLCL+cETbLLxzZPh6ydxFEzCyov7iImud3adT/BQEQ2eJrTa5U
         Gyxg==
X-Gm-Message-State: AOJu0YwiuhhAnC4P3Iaa2j5cDmx/yrrPhVofJrsLkQ4rNEHUHom675Pu
	p5d8S2wCETw3Xp4utLM2dywCMMJ8doCXLQ7gBlD1t1HbyUnq5NEvk11kUp0aaR7R2jlLNQ5FPUj
	T2ToOLAKZIxgNafBI735HPbpZIdN6Y/A=
X-Gm-Gg: AR+sD12pLNkwUtN1gaRkjfnPrDPLKcdGR+HKlBXX2MyTaNM9uQpS545NoOcNl+4Z0zO
	atj6WnOjzpuKYNkjo41e/a+dGPZdWfdxWKCD1FVjS8qjBRssp6+fquR8NWuIkDajVsqsB/qD0fy
	X4tv8Fc+pvrvfnNk9jCuAOhsY5sYYejL4CVkx36tCrSLkvFnzmW2IGEZzVIOGHQeMGdsu09n9+v
	aHH6dpOSchYLfa9DMQM0NoauH5XgktnNPQCwMFcxhhBBCmM10j0JFKPVpQeudAch0GrUXItD6Ct
	HyxT05pFGB2AVoh+wTeK0ozg8pfdmnvb3S6kcVCfr7F5QzxDhrocNfSY2xCd84KchwzAQDiwND3
	XcK380563/Kd4sf/Eelws5EhkSSNJZV69r7zqtB7/dJi1x0L/mpsBAaKbqPYszAW95hT81UCO
X-Received: by 2002:a05:6808:14c5:b0:497:df42:1e04 with SMTP id
 5614622812f47-4afae15ab7bmr10599462b6e.18.1786071794773; Thu, 06 Aug 2026
 20:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <b655b24dc0bedbe8803da87e977684217f7d1f69.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <b655b24dc0bedbe8803da87e977684217f7d1f69.1786013982.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Aug 2026 20:03:02 -0700
X-Gm-Features: AUfX_myyog_K05mdd8XFpc4VcYQvfJnoGzbgk07rNXSk7LyobLlo7mKjzf9oBVY
Message-ID: <CABPp-BFJDc5t3cCj9mZBkXs+Ee+EoWUKw2p9UXq7tSGoosqMmw@mail.gmail.com>
Subject: Re: [PATCH v7 10/10] commit-reach: remove commit-date ordering fallback
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:00=E2=80=AFAM Kristofer Karlsson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kristofer Karlsson <krka@spotify.com>
>
> Remove the fallback that switched paint_down_to_common() from
> generation ordering to commit-date ordering when the commit-graph
> lacks corrected commit dates (v1 graph with topo levels only).
>
> The fallback was added in 091f4cf3 (commit: don't use generation
> numbers if not needed, 2018-08-30) to avoid a performance
> regression on the Linux kernel repo where v1 topo levels caused
> "git merge-base v4.8 v4.9" to walk 636k commits instead of 167k.
> A side branch with a low topo level stayed in the queue behind a
> long chain, preventing early STALE propagation.
>
> Side-exhaustion (added in the previous commits) solves this
> differently by terminating the walk as soon as one paint side
> empties from the queue, preventing the deep walk regardless of
> queue ordering.

Nice!

> Benchmarks of "git merge-base --all v4.8 v4.9"
> on the Linux kernel repo show that side-exhaustion reduces the
> step count far below what the date-ordering fallback achieved:
>
>                          steps      time
>   no graph, baseline:   167,413    3.25 s
>   v1 graph, baseline:   167,413    0.25 s
>   v2 graph, baseline:   167,441    0.29 s
>   v1 graph, this series:  5,725    0.02 s
>   v2 graph, this series:  3,887    0.01 s

Even better!

> With generation ordering always active, the existing min_generation
> check in paint_queue_get() correctly identifies when the walk has
> reached the finite generation region. The date ordering fallback
> broke this invariant: a commit could have a finite topo level
> while the queue was date-ordered, causing the early exit to fire
> before all merge bases were found.
>
> For v1 commit-graphs where generation numbers saturate at
> GENERATION_NUMBER_V1_MAX, introduce a topological ceiling that
> the early exit gates compare against instead of
> GENERATION_NUMBER_INFINITY. This ensures saturated commits are
> treated as unordered, preventing premature termination when
> generation values are unreliable.

Should the work associated with this paragraph come earlier so 8/10
doesn't have its weird split?

>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  .../technical/paint-down-to-common.adoc       | 51 +++----------------
>  commit-reach.c                                | 23 +++++----
>  t/t6600-test-reach.sh                         | 23 ++++-----
>  3 files changed, 27 insertions(+), 70 deletions(-)
>
> diff --git a/Documentation/technical/paint-down-to-common.adoc b/Document=
ation/technical/paint-down-to-common.adoc
> index 7c93f7e676..bdd5ffb5c3 100644
> --- a/Documentation/technical/paint-down-to-common.adoc
> +++ b/Documentation/technical/paint-down-to-common.adoc
> @@ -44,10 +44,6 @@ ancestor is necessarily redundant.
>  INFINITY and finite generation regions
>  --------------------------------------
>
> -The properties in this section assume generation-number ordering (the
> -default comparator). They do NOT hold when the date-ordering fallback
> -is active -- see <<date-ordering-fallback>>.
> -
>  The commit-graph stores a generation number for each commit.
>  Commits not in the commit-graph have generation
>  `GENERATION_NUMBER_INFINITY`. The graph is closed under
> @@ -91,10 +87,12 @@ traversal: children are always visited before their p=
arents. This
>  means that paint on already-visited commits is final -- no future
>  traversal step can add paint to them.
>
> -In the INFINITY region, commit-date ordering can violate this: a
> -parent with a later date can be visited before a child with an earlier
> -date. Paint flags are therefore NOT final at visit time, and a
> -commit visited with only one side's paint may later gain the other.
> +In the INFINITY region, all commits share the same generation
> +value, so the queue breaks ties by commit date. This can violate
> +topological ordering: a parent with a later date can be visited
> +before a child with an earlier date. Paint flags are therefore
> +NOT final at visit time, and a commit visited with only one
> +side's paint may later gain the other.

Similar issues exist in the GENERATION_NUMBER_V1_MAX region, right?

>  Paint flags are only added, never removed. Since each flag can be set
>  at most once per commit, the number of times a commit can be
> @@ -159,43 +157,6 @@ descendant of this candidate (generation ordering gu=
arantees
>  children are visited first), so it cannot be redundant and the walk
>  can stop immediately.
>
> -This optimization is NOT safe when the date-ordering fallback is
> -active, because commit-date order can visit a deeper ancestor
> -before a shallower one -- see <<date-ordering-fallback>>.
> -
> -[[date-ordering-fallback]]
> -Date-ordering fallback
> -----------------------
> -
> -When the commit-graph has generation numbers v1 and no
> -generation floor is specified, topological ordering
> -(via generation numbers) is disabled.  Topological levels are
> -correct but unbalanced -- ordering by such generation numbers
> -can sometimes cause the walk to detour too far before finding
> -merge bases.  Commit-date ordering typically reaches them in
> -fewer steps -- see this change for more details:
> -
> -   091f4cf3 (commit: don't use generation numbers if not needed,
> -   2018-08-30)
> -
> -With generation number v2 (corrected commit dates) we have the best
> -of both worlds and do not need this fallback.
> -
> -For v1, `paint_down_to_common()` falls back to pure commit-date
> -ordering via `compare_commits_by_commit_date`.  Because commit
> -dates are not monotonic (clock skew, rebases, etc.), the queue
> -may visit commits out of topological order.
> -
> -This disables the optimizations that depend on generation ordering:
> -
> -  - *Single result*: the first merge-base candidate found may not
> -    be the shallowest, because a deeper ancestor with a higher
> -    commit date can be dequeued first.
> -
> -  - *Side exhaustion*: one paint side can appear to drain from the
> -    queue while commits from that side are still waiting with lower
> -    dates, causing premature termination.
> -

Nice seeing all the date-ordering stuff get ripped out.

>  Related documentation
>  ---------------------
>
> diff --git a/commit-reach.c b/commit-reach.c
> index b50b0e4e47..85bda146e6 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -89,9 +89,9 @@ struct paint_state {
>         size_t parent1_count;
>         size_t parent2_count;
>         size_t mb_candidate_count;
> -       int gen_ordered;
>         timestamp_t min_generation;
>         timestamp_t last_gen;
> +       timestamp_t topo_ceiling;
>  };
>
>  static void paint_count_update(struct paint_state *state,
> @@ -166,8 +166,7 @@ static struct commit *paint_queue_get(struct paint_st=
ate *state)
>
>                 /* one side is exhausted */
>                 if ((!state->parent1_count || !state->parent2_count) &&
> -                   state->gen_ordered &&
> -                   generation < GENERATION_NUMBER_INFINITY)
> +                   generation < state->topo_ceiling)
>                         return NULL;
>         }

Good, together with the setting of state->topo_ceiling, this fixes the
GENERATION_NUMBER_V1_MAX issue.

>
> @@ -187,9 +186,13 @@ static int paint_down_to_common(struct repository *r=
,
>                                 enum merge_base_flags mb_flags,
>                                 struct commit_list **result)
>  {
> +       /*
> +        * Generation ordering is required for the side-exhaustion and
> +        * single-result early exits, which rely on topological traversal
> +        * order (children visited before parents) in the finite region.
> +        */
>         struct paint_state state =3D {
> -               .queue =3D { compare_commits_by_gen_then_commit_date },
> -               .gen_ordered =3D 1,
> +               .queue =3D { compare_commits_by_gen_then_commit_date }
>         };
>         struct commit *commit;
>         int i;
> @@ -198,10 +201,9 @@ static int paint_down_to_common(struct repository *r=
,
>
>         state.min_generation =3D min_generation;
>         state.last_gen =3D GENERATION_NUMBER_INFINITY;
> -       if (!min_generation && !corrected_commit_dates_enabled(r)) {
> -               state.queue.compare =3D compare_commits_by_commit_date;
> -               state.gen_ordered =3D 0;
> -       }
> +       state.topo_ceiling =3D corrected_commit_dates_enabled(r)
> +               ? GENERATION_NUMBER_INFINITY
> +               : GENERATION_NUMBER_V1_MAX;
>
>         one->object.flags |=3D PARENT1;
>         if (!n) {
> @@ -229,8 +231,7 @@ static int paint_down_to_common(struct repository *r,
>                                  * descendant of this one.
>                                  */
>                                 if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
> -                                   state.gen_ordered &&
> -                                   state.last_gen < GENERATION_NUMBER_IN=
FINITY)
> +                                   state.last_gen < state.topo_ceiling)
>                                         break;
>                         }
>                         /* Mark parents of a found merge stale */
> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> index 6bf17cb7b6..445449a458 100755
> --- a/t/t6600-test-reach.sh
> +++ b/t/t6600-test-reach.sh
> @@ -381,7 +381,7 @@ test_expect_success 'get_merge_bases_many:infinity-bo=
th-sides' '
>                 git rev-parse pi-B
>         } >expect &&
>         test_all_modes get_merge_bases_many &&
> -       test_paint_down_steps 5 4 5 5
> +       test_paint_down_steps 5 4 5 4
>  '
>
>  test_expect_success 'setup mixed finite/INFINITY topology' '
> @@ -414,31 +414,26 @@ test_expect_success 'merge-base --all commit-walk s=
teps' '
>         >input &&
>         git rev-parse commit-9-1 >expect &&
>         run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
> -       test_paint_down_steps 81 9 57 81
> +       test_paint_down_steps 81 9 57 37
>  '
>
>  test_expect_success 'merge-base --all with clock skew (side-exhaustion)'=
 '
> -       # Verify correct merge base under clock skew.  se-D (the
> -       # merge base) has a higher date than its child se-C.
> -       # Generation ordering ensures se-C is visited before se-D,
> -       # so P1 paint propagates correctly and se-D is found.
> +       # Verify that the merge base is computed correctly even
> +       # when commits have non-monotonic commit dates.
>         >input &&
>         git rev-parse se-D >expect &&
>         run_all_modes git merge-base --all se-A se-B &&
> -       test_paint_down_steps 6 4 6 6
> +       test_paint_down_steps 6 4 6 4
>  '
>
>  test_expect_success 'merge-base --all with clock skew and redundant ance=
stor (side-exhaustion)' '
> -       # Verify correct merge base when clock skew could cause a
> -       # too-deep result.  MB1 is the correct merge base; MB2 is
> -       # its ancestor.  A reaches MB2 via E (high date) and MB1
> -       # via C (low date).  Generation ordering ensures C is
> -       # visited before side-exhaustion fires, so MB1 is found
> -       # and remove_redundant correctly discards MB2.
> +       # Verify that the correct merge base is found even when
> +       # non-monotonic commit dates could cause a redundant
> +       # ancestor to be visited first.
>         >input &&
>         git rev-parse se2-MB1 >expect &&
>         run_all_modes git merge-base --all se2-A se2-B &&
> -       test_paint_down_steps 8 6 8 8
> +       test_paint_down_steps 8 6 8 6
>  '
>
>  test_expect_success 'reduce_heads' '
> --
> gitgitgadget

The code and tests look good, my main issue is that the documentation
and code are not consistent at patch 08/10, so we need some way of
correcting that.  I don't know whether that means splitting the code
differently in patches 8 & 10, or splitting the documentation
differently or something else.  Thoughts?

Anyway, nicely done overall, this is nearly ready to merge; it just
needs a few small touch-ups.
