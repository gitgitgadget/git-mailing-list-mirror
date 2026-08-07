Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C87282F1E
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786071752; cv=pass; b=pmMdaKmzw+zPtR8DWqyuab2mrsC41GY9a/EeRLzpS+3i/zh3YgDrUbMRYjYiWwV0CROi79sAI5EjNb/KGZHVW0Twisk9eaD+E8n60REMbRkCe9S1ovdh/+dqcZta9D4joJy6yn/QYctln44Q+TXnG3FTpK/0TWdG0hsJK88uIDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786071752; c=relaxed/simple;
	bh=AliqLAXR3RI3I4Z+ZFTfve+ufRVWB4tssPFa2Dy44+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JudQX3pZuWLxWhK1jfekcpPeDpKS2VPdX0MM9rTPFWHyD0r5zpKtS3XwP9VP/KYyFNDfoO/eJOhLzGCV6NjwgWuP2KgqIi/XmO7Hv1fUVR3XNU51kp9ctCIY7ByKfU05FN6X3wYkjvAl6dc2bnmOeGlfAiB3fgs9U3jv6WKr++c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNwGyNFB; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNwGyNFB"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6aeaaef491cso826498eaf.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 20:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786071750; cv=none;
        d=google.com; s=arc-20260327;
        b=ZAP0AO7Au3K3DT0UTl1B0VuScEyPk7XH2y9TyxkK/T7rMSPSGNz7zfLD+c++RSNWx0
         DOwslF6Gpz6nDkbmu+zUPuz6aSkM96MDIUoue5KjYQGCEmylc7caQX65yxCx0KVYm+QH
         S20hAXdGNJjWcYpALmFWeKbwx79k1h/KapUoNR6143yGanuu9SQaC8F0sTdplGEsJdQP
         3iHG08tET9n9rfZRx3BGkgsvSNi6E2y9iYzj7TQeZWJ7kSt+WnpeYgjcbWtKj4TdtxP+
         43exuTJIMSRup0CQcr35eQ+R6o5E0XvoXTQjW72NWLgcGc8TGmROq5on+NLlI6O6Qb8Z
         z7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h4eEdsPuGaMoBpuRdj7iR2ChaHXxX0GAzv9rXMsBbkI=;
        fh=PdGuLsJN9JVZy5BHY9bPXqzeWCeYFKwbJ2iGslXTO1Q=;
        b=BAbZFlUojZ+HYOFAwz5hpCdLbsVl7CYWB01mxTKK2gUCCdJ/HmLQ3C/ocI9dzXZ4+8
         uQqDWphWoVb0hTAkLcM4FIaCQq20moiz2igQdjnArYkIzbPfzR6OJoMIZfvYw3ofEto1
         I1lx+Ym/wAO+2n+RzBH9tKifr2ry5FP9HKYTKLcb/XueSi5MWU7gzPcosUK4U/wn+rMq
         p8Xr7IoB9LNQRb8V1DTXVBKFcyvYH8/ZBOTLf/oT8iDcQwhf5QKXEhuhPGfqI38UBLH3
         s7/rTVAj4iqefNHhCf5+cqiRRqoeTQiMiij+z8BpIG0TrA9QInCYVID+wwRCz7vmwmZF
         dxmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786071750; x=1786676550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h4eEdsPuGaMoBpuRdj7iR2ChaHXxX0GAzv9rXMsBbkI=;
        b=fNwGyNFBLdFMw1vhNSp5XYUxDDYl7giqtG/yoP80K9MQw/InPVqyEv1u9QQJjYd2T6
         ETJ+GR8SV312nwTRujWBMfgnrlDvHOQ2wxLEwcFykUJXBlakkcjzzb2TswRv3mw2WsTu
         LF6B5FoewCgRHj/LVGK+84N+onDltZDSRbqmqHMZ96imPJL5KEXTd6elcSYJkGzlvnu5
         L+nlpMS/dxqVSW3wJUABgdez+4xs2kjjPkX05afsLQ1GZINdxKuQgGoz1Zng+bzte+rD
         QJQn7NIWzrvoB0kzw4G9g5JLfc/+L/B3kpETfWx+jyUrz/EA8oiGRzoccodiwSK1CWrR
         EwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786071750; x=1786676550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h4eEdsPuGaMoBpuRdj7iR2ChaHXxX0GAzv9rXMsBbkI=;
        b=P3OIF7kL8kmBQ5m7So9cYnhvcC6HZ+/P3aBshYxbPrVYBPpAyVVxHEZSAvtR0fvZ6t
         /AQLfqDBa2TVSL68JwNiFzaLJygGxSUWT3cnbTGhRuNATx1TVJCKJtht2wMitj14hD7D
         FLnPmPR4AAu5rtW292mUjPNUENqOGvdPPRobGA6IWIZajSYHrO40uUpESdp66c56qQ7p
         9Ni/OAWXfAliVgEOTgCQ/iXhzNXoN1C1OW4cPreBp7Gt9xtWMxvwJrFLEYDY+YqxQQbJ
         VV0hz0UDZrMmwM7a2/DlsmSZYZp1jASAiXgYHDC8HZ8mFD91ZFj+8/mpQFua7q1iFBaD
         GzFA==
X-Gm-Message-State: AOJu0YxLM90h1AHqyJdGd5mdjWKO0OV83F3EiyYOqnN57L1upCKSep9G
	h/Jm71TZ/7cl5NutwhYMBFMfXroR6ZplShT2pt61y1NtECkDCby9NIAwd+s3DDnadCauUz745Kw
	M2LylPvB1E2sq0QkgFWTQXOyWkn2dR5A=
X-Gm-Gg: AR+sD13gWuUNS7jDZcpEqbJu5PYyDTtK9xBtsQs7himzDkIxvTidk14ayNV1fhYyn8r
	zmdWo7KqqRN5V/xTnCN/GJ7bQT3wZqh2vzMhwPZoPLtj1jPYtwP9L0UGFvNtUMcHYGQ9kJA0ZnC
	9jwroIeIXAAOC5+EsG9sg4APBOfg2pwPg7mvClybnFo0vfDVoT4dFDzyrC1rEOal9rVbpnxp0X6
	wvX3q6soVJSAd/0ERxI2yBmJvRbcOnZ6PBFWs0Lx60emePMoMgA6z43qQwypVMYRCLydqx7BES6
	ZQ2OrJBcn/wgeNSVRlx/BtvIqSm6Of8Ieztdwr/czRmkZwpprwPlJfKb+jjffH9ICRuZ6kIHzd8
	A7f+a5z9Ug6dUau1CPpyBp+5SZPzaRPCW2VYwb+F7bsEMepGXnWowznfEClAeHg==
X-Received: by 2002:a05:6820:2224:b0:6ae:90c3:32c1 with SMTP id
 006d021491bc7-6ae96c50854mr9060020eaf.8.1786071749688; Thu, 06 Aug 2026
 20:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <a1c8e89ef9f1d0fb5cb10ec9687633df8792ec7b.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <a1c8e89ef9f1d0fb5cb10ec9687633df8792ec7b.1786013982.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Aug 2026 20:02:16 -0700
X-Gm-Features: AUfX_mwsTpkr7x3H1mLt-CiDfadvQgZb4iwCLF5SOtWplE8JoFzniVXSl_OdD08
Message-ID: <CABPp-BFqghtx4p_Nqx+AWpU7SVn3mXOZGDQ0yoN-ZYQgXmZC=g@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] commit-reach: introduce struct paint_state with
 per-side counters
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:05=E2=80=AFAM Kristofer Karlsson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kristofer Karlsson <krka@spotify.com>
>
> Add a paint_state struct for use by paint_down_to_common() that
> wraps a prio_queue with per-side commit counters. Each non-stale
> queued commit occupies exactly one counter bucket based on its
> paint flags: PARENT1-only, PARENT2-only, or both sides (a pending
> merge-base candidate).
>
> The counters are maintained by paint_count_update() which adjusts
> the appropriate bucket by a signed delta. An exhaustive switch on
> the paint+stale bits documents all valid flag combinations in one
> place.
>
> Convert paint_down_to_common() to use paint_state. The loop now
> drains the queue via paint_queue_get() which returns NULL when all
> counters reach zero, replacing the old pointer-based termination
> (max_nonstale).

Ooh, I like this setup for what comes later; it sets the stage
perfectly for the key insight behind the optimization.  Very nice.

> This is equivalent behavior -- both conditions
> detect that no non-stale entries remain.
>
> paint_queue_get() uses a "pop first" form: it dequeues a commit,
> then checks the counters. This means the loop exits one iteration
> earlier than the old code in some topologies (the popped stale
> commit is never processed), so a few step counts drop by one.
>
> The existing nonstale_queue is left in place for ahead_behind(),
> though nonstale_queue_put_dedup() and nonstale_queue_get_dedup()
> became unused and are removed.

became -> become

>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  .../technical/paint-down-to-common.adoc       |   9 +-
>  commit-reach.c                                | 103 +++++++++++++-----
>  t/t6600-test-reach.sh                         |   6 +-
>  3 files changed, 82 insertions(+), 36 deletions(-)
>
> diff --git a/Documentation/technical/paint-down-to-common.adoc b/Document=
ation/technical/paint-down-to-common.adoc
> index cea0cc2f91..37fa6f93c1 100644
> --- a/Documentation/technical/paint-down-to-common.adoc
> +++ b/Documentation/technical/paint-down-to-common.adoc
> @@ -103,15 +103,12 @@ re-enqueued is bounded by the number of flag transi=
tions.
>  Termination
>  -----------
>
> -The walk uses a `nonstale_queue` wrapper around `prio_queue` that
> -tracks `max_nonstale`: the lowest-priority non-stale commit enqueued
> -so far. Once that commit is dequeued, every remaining entry is known
> -to be STALE and the loop terminates. Specifically, the main loop
> +The walk tracks the number of commits of each type in the queue
> +(PARENT1-only, PARENT2-only, pending merge-base). The main loop
>  ends when one of the following conditions holds:
>
>    1. The queue is empty.
> -  2. `max_nonstale` has been dequeued, meaning the queue only contains
> -     STALE entries.
> +  2. The queue contains only stale entries.
>    3. Generation cutoff: the dequeued commit's generation is below
>       a caller-supplied `min_generation` threshold.
>    4. Single result: the caller only needs one merge base, one has
> diff --git a/commit-reach.c b/commit-reach.c
> index d59e76a2e2..a62b5e4624 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -79,21 +79,73 @@ static void clear_nonstale_queue(struct nonstale_queu=
e *queue)
>         queue->max_nonstale =3D NULL;
>  }
>
> -static void nonstale_queue_put_dedup(struct nonstale_queue *queue,
> -                                    struct commit *c)
> +/*
> + * Priority queue with per-side commit counters for paint_down_to_common=
().
> + * Each non-stale queued commit occupies exactly one bucket: PARENT1-onl=
y,
> + * PARENT2-only, or both (a pending merge-base candidate).
> + */
> +struct paint_state {
> +       struct prio_queue queue;
> +       size_t parent1_count;
> +       size_t parent2_count;
> +       size_t mb_candidate_count;
> +       int gen_ordered;
> +};
> +
> +static void paint_count_update(struct paint_state *state,
> +                              unsigned flags, int delta)
>  {
> -       if (c->object.flags & ENQUEUED)
> -               return;
> -       c->object.flags |=3D ENQUEUED;
> -       nonstale_queue_put(queue, c);
> +       switch (flags & (PARENT1 | PARENT2 | STALE)) {
> +       case PARENT1:
> +               state->parent1_count +=3D delta;
> +               break;
> +
> +       case PARENT2:
> +               state->parent2_count +=3D delta;
> +               break;
> +
> +       case PARENT1 | PARENT2:
> +               state->mb_candidate_count +=3D delta;
> +               break;
> +
> +       case PARENT1 | PARENT2 | STALE:
> +               break;
> +
> +       default:
> +               BUG("unexpected paint state");

So, if anyone tries to refactor and adds a nonsense flag combination,
e.g. PARENT1 | STALE, this will trip.  Good.

> +       }
> +}
> +
> +static void paint_queue_put(struct paint_state *state,
> +                           struct commit *c, unsigned add_flags)
> +{
> +       unsigned old_flags =3D c->object.flags;
> +       c->object.flags |=3D add_flags;
> +
> +       if (old_flags & ENQUEUED) {
> +               paint_count_update(state, old_flags, -1);
> +               paint_count_update(state, c->object.flags, 1);

If this object was already in the queue, remove the old counters for
it (e.g. PARENT1), and add the new union counters for it (e.g. PARENT1
| PARENT2).  Good.

> +       } else {
> +               c->object.flags |=3D ENQUEUED;
> +               prio_queue_put(&state->queue, c);
> +               paint_count_update(state, c->object.flags, 1);

...and if it wasn't, put it in the queue and add the counters for it.
Also good.

> +       }
>  }
>
> -static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *qu=
eue)
> +static struct commit *paint_queue_get(struct paint_state *state)
>  {
> -       struct commit *commit =3D nonstale_queue_get(queue);
> +       struct commit *commit =3D prio_queue_get(&state->queue);
> +
> +       if (!commit)
> +               return NULL;
> +
> +       commit->object.flags &=3D ~ENQUEUED;
> +
> +       if (!state->parent1_count && !state->parent2_count &&
> +           !state->mb_candidate_count)
> +               return NULL;
>
> -       if (commit)
> -               commit->object.flags &=3D ~ENQUEUED;
> +       paint_count_update(state, commit->object.flags, -1);
>         return commit;
>  }

So: pop, clear, check the counters, and _then_ decrement the counters.
This means the zero-counter-check still include the just-popped
commit.  If the decrement were before the check, we'd actually just
barely miss the merge-base most the time, so this order is important.

>
> @@ -109,18 +161,19 @@ static int paint_down_to_common(struct repository *=
r,
>                                 enum merge_base_flags mb_flags,
>                                 struct commit_list **result)
>  {
> -       struct nonstale_queue queue =3D {
> -               { compare_commits_by_gen_then_commit_date }
> +       struct paint_state state =3D {
> +               .queue =3D { compare_commits_by_gen_then_commit_date },
> +               .gen_ordered =3D 1,
>         };
> +       struct commit *commit;
>         int i;
> -       int gen_ordered =3D 1;
>         int steps =3D 0;
>         timestamp_t last_gen =3D GENERATION_NUMBER_INFINITY;
>         struct commit_list **tail =3D result;
>
>         if (!min_generation && !corrected_commit_dates_enabled(r)) {
> -               queue.pq.compare =3D compare_commits_by_commit_date;
> -               gen_ordered =3D 0;
> +               state.queue.compare =3D compare_commits_by_commit_date;
> +               state.gen_ordered =3D 0;
>         }
>
>         one->object.flags |=3D PARENT1;
> @@ -128,15 +181,12 @@ static int paint_down_to_common(struct repository *=
r,
>                 commit_list_append(one, result);
>                 return 0;
>         }
> -       nonstale_queue_put_dedup(&queue, one);
> +       paint_queue_put(&state, one, 0);
>
> -       for (i =3D 0; i < n; i++) {
> -               twos[i]->object.flags |=3D PARENT2;
> -               nonstale_queue_put_dedup(&queue, twos[i]);
> -       }
> +       for (i =3D 0; i < n; i++)
> +               paint_queue_put(&state, twos[i], PARENT2);
>
> -       while (queue.max_nonstale) {
> -               struct commit *commit =3D nonstale_queue_get_dedup(&queue=
);
> +       while ((commit =3D paint_queue_get(&state))) {
>                 struct commit_list *parents;
>                 int flags;
>                 timestamp_t generation =3D commit_graph_generation(commit=
);
> @@ -162,7 +212,7 @@ static int paint_down_to_common(struct repository *r,
>                                  * descendant of this one.
>                                  */
>                                 if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
> -                                   gen_ordered &&
> +                                   state.gen_ordered &&
>                                     generation < GENERATION_NUMBER_INFINI=
TY)
>                                         break;
>                         }
> @@ -176,7 +226,7 @@ static int paint_down_to_common(struct repository *r,
>                         if ((p->object.flags & flags) =3D=3D flags)
>                                 continue;
>                         if (repo_parse_commit(r, p)) {
> -                               clear_nonstale_queue(&queue);
> +                               clear_prio_queue(&state.queue);
>                                 commit_list_free(*result);
>                                 *result =3D NULL;
>                                 /*
> @@ -191,12 +241,11 @@ static int paint_down_to_common(struct repository *=
r,
>                                 return error(_("could not parse commit %s=
"),
>                                              oid_to_hex(&p->object.oid));
>                         }
> -                       p->object.flags |=3D flags;
> -                       nonstale_queue_put_dedup(&queue, p);
> +                       paint_queue_put(&state, p, flags);
>                 }
>         }
>
> -       clear_nonstale_queue(&queue);
> +       clear_prio_queue(&state.queue);
>         trace2_data_intmax("paint_down_to_common", r,
>                            "steps", steps);
>         commit_list_sort_by_date(result);

Looks like the straightforward translation in paint_down_to_common()
from the old algorithm to the new adjustment; nice that a few spots
actually become a little shorter.

> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> index 55aa220bb3..f9895f5fd7 100755
> --- a/t/t6600-test-reach.sh
> +++ b/t/t6600-test-reach.sh
> @@ -366,7 +366,7 @@ test_expect_success 'get_merge_bases_many:pending-sta=
le' '
>                 git rev-parse ps-B
>         } >expect &&
>         test_all_modes get_merge_bases_many &&
> -       test_paint_down_steps 6 6 6 6
> +       test_paint_down_steps 5 5 5 5
>  '
>
>  test_expect_success 'get_merge_bases_many:infinity-both-sides' '
> @@ -381,7 +381,7 @@ test_expect_success 'get_merge_bases_many:infinity-bo=
th-sides' '
>                 git rev-parse pi-B
>         } >expect &&
>         test_all_modes get_merge_bases_many &&
> -       test_paint_down_steps 5 5 5 5
> +       test_paint_down_steps 5 4 5 5
>  '
>
>  test_expect_success 'setup mixed finite/INFINITY topology' '
> @@ -438,7 +438,7 @@ test_expect_success 'merge-base --all with clock skew=
 and redundant ancestor (si
>         >input &&
>         git rev-parse se2-MB1 >expect &&
>         run_all_modes git merge-base --all se2-A se2-B &&
> -       test_paint_down_steps 8 7 8 8
> +       test_paint_down_steps 8 6 8 8
>  '
>
>  test_expect_success 'reduce_heads' '
> --
> gitgitgadget

Looks good.
