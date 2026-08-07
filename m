Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EBE1862
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 03:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786071770; cv=pass; b=Tskq7WPp3jSBo2AmrAk1aizT35He0KryvyOXyealHR6GhA5zdHVUDbVVnbCEVAZXnGiTjOMX4k/Na0syZ8IT3dpJq64MqRfAB6BNdLceeVZOD0xLxgCaFlGNoSuMMU/d5vurntgyohthbwqTTDBUbkrz+rwAU6sjC2mJdkyitQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786071770; c=relaxed/simple;
	bh=J850y5K2SJrbQ37pIplQN3TK10JwhsjNJxDCFTCDFZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlvAaHR3NE+Z0M0bTbu6AJvi4t5JsX8loMHJeptpCIzVxL2sWMbPKCJ0abTCF2MWdTVnqNzEvECJy0uDh0Knric3MNn2jNjOmoT2AMzVa5FolTDd2wru3TFs7TxNREl9tdt5AnsggkFy/HwqGwh0qXADr6Ugq9pxClJtIieS9xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOXN28sA; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOXN28sA"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4583b1703d3so1020868fac.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 20:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786071767; cv=none;
        d=google.com; s=arc-20260327;
        b=luc98Gd0OxAt5k+j4UWk+X0xsIN2fya4hfmbhi6wQcWgUBem7M2nbQeB4qdC5SXGcc
         hvSDjuIvbcJ+TcCuSm8Bfr0FH8PJyNdEJl0938kUhbVyGzN3PkhZNUtaTdDcC07ElRgP
         hcQr+kJJUQGn0jRjVMXHO36/hEm9CZk8LU/hFUd3sp+Uet/0hKhQzlnUDuqt4HEWVlMx
         lwSAVph///QRtH3ZNHYPkDcBaFUiSb5pjQ8Uw8+UrHcHuK89wDhxET9PPXc3qWSMKRsL
         Jlj30K0QeKf2HI2DUma1LHS79pqeI8l9Fwr6q5XN8BJMmfpH0jEbeQi8z7/sAP3Zqph8
         XuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Obdq8zjNLesgWFhS4w3BpvxSAh0GrdGC+Nmwtkxef3Y=;
        fh=PdGuLsJN9JVZy5BHY9bPXqzeWCeYFKwbJ2iGslXTO1Q=;
        b=miqJIhQ/BtA9THsrmKHzAEglf9DT16918EGtJtWLzErdLmcOdnfbLvy/3YXu4i3Qub
         +m0cSj4iOamPA46x5GS1j7ePghLPxO02sc1J1nnZ1kXaSEL50rZUvjDmpfJsHhF6xatf
         usq5a988ZSxCv2n+Fdu4KdPPTQWPPgD0U+GuG6fnov4kdMaWhRhXU+Hm7s2YoJXyRMDH
         injDgNJ99o0QLQ1UegvmVK7jx8y0+jXm8nfpwYy83lNUAYjyKR3WPZxw5F4Kboq+wB3c
         kydv77t+H+wTI+I1HxtSK/uf1ZAiFS1FY9DExXvnTTyesv1p7t4liiDLQS9jmLbN2LvM
         Kb+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786071767; x=1786676567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Obdq8zjNLesgWFhS4w3BpvxSAh0GrdGC+Nmwtkxef3Y=;
        b=jOXN28sA1X9Knc2fI9X6LKQA1cK1w6cLsLHpWJ76LwzWZmS+5Q85HNfojmHxEDbFqa
         TRUKY3tNnHjPUMklN8SAHD1lAOT2IEcMUzS4l4WeclUplMq3iG0YPINz5f0UhOrKVUZF
         m86vjtpgXyW0llNXKemsM6FQAtbf1QufzoITS9h6v2ivNXdFLYZ3pzJGvDIKtucYOKTE
         5VvzPGjnwwoV1czIalQitTITMJGyUxfm2BEs5PrNiLnHeuk2x539rFbnqzFAohrJ192S
         kSgqm3UdcNmzgjf1WkcnYRWf5gWrPCWVZJXU3wTsflYsoYPvKeMZd8cqFyCuyJBVueHr
         WIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786071767; x=1786676567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Obdq8zjNLesgWFhS4w3BpvxSAh0GrdGC+Nmwtkxef3Y=;
        b=eDiWwtRHZNNwoNIRi+JvdDFX7FRYhholwb31gesLgBNIOPwwhdfX6xDxkeAabMDSii
         Qw5AnoGugdHA1cQHGkNsFx8iU8qVYAs7pkJUTC6+JoPI/BbJFoMxUADIPcUO067LH5m2
         PmCWD2MBhoviEpUb9jRwDkiwUuO2yYfr9h/kQe68q/2xgeLQKl7wfquy0699leGfnvYn
         RcpWrRj0/MyiX0h27gSfSVjPlFzP2jUOmaemOZ4C04+sJMegVfnNY4t1okFCKx38uMVZ
         urgUNKGecjKniCY8njT6cxPJJsQcNMp/VzdRcecB0UTC0rmOnYiM/yIHD+YS260zQ3Yj
         Cjig==
X-Gm-Message-State: AOJu0YxuleIOaeW1M/1rGoRVdIZLlK1VvZGpCLITVLmGHRgGMGXwQF/c
	3LIPyMtSkFVEqIBUVTxpznvLGNwWLpZhNOC2dV1vkfGQ84rYRPflXeezZdtCwsg4+hJ7PW0AkxZ
	2Lup41wrxbTc3jxC7u3Ugz5rBYLLy6cXMJQ==
X-Gm-Gg: AR+sD11Baku52lr8PHWd4iLCBvldRqWw+pqx8ZoD3P+hpyU3Gd5hDtp5nYcPyuo2luF
	uWq/w3JtLk9S7CpNtIGHowZ45me3/fgyRyn2T7w59vJZXpirXhivIaPvF4TNU+m3I10QYMaj9Ja
	xGl/dTAXHBdsBw9KmgUsFoEBHrupoIs/RK1uyKWAc6yPb4GrcPsXLOJKAfTH6al+WmILruLUAQk
	N/AzdyW5bayZTEidlkEdaFZ2VpQhvC6aotvQJOyeeeBQ1k0H7ogv6uhJEW91gdqWBKE2RZrZrre
	LeD7lVrQgebZ7bfFhjNO24C1ahVSJeDt9RFFKKrk7XovI0+C/zGXJoWFU21J1ODZ2m9XKMyV4a6
	QNnQU74d8zijVPkP/oe7btVpPSGIiYeIIe9kpoMHxqiB8ykuwSUptJdWAY3Rb6sJukEXy8bVe+w
	==
X-Received: by 2002:a05:6820:c95:b0:6a3:d77e:725a with SMTP id
 006d021491bc7-6ae96e8bbe3mr10144918eaf.20.1786071767418; Thu, 06 Aug 2026
 20:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <391fa07783a7819a60c0b0c2a3ea86fb13c95079.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <391fa07783a7819a60c0b0c2a3ea86fb13c95079.1786013982.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Aug 2026 20:02:35 -0700
X-Gm-Features: AUfX_mxwuKdh09B47CR6XsIRLUNxutfyourIKw9wF0h4SFAMzny9MdZoG1Kp5ho
Message-ID: <CABPp-BE=MB-j2HOnZEFaf5wrdBz329+J1AKwyRWFwjP-5iao-w@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] commit-reach: terminate merge-base walk when one
 paint side is exhausted
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:05=E2=80=AFAM Kristofer Karlsson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kristofer Karlsson <krka@spotify.com>
>
> Add an early termination check to paint_down_to_common() using the
> per-side counters introduced earlier. Once the walk enters the
> finite-generation region, terminate early when one side's exclusive
> count drops to zero -- no new merge-base can form without both paint
> sides meeting.

...this is the insight behind this optimization, which the previous
patch set up so nicely.

> The check also waits for pending_merge_bases to reach zero, ensuring
> all merge-base candidates have been dequeued and recorded before
> exiting.
>
> The INFINITY gate ensures correctness: commits without a commit-graph
> entry have GENERATION_NUMBER_INFINITY and are ordered by commit date,
> which is not topologically reliable. The optimization only fires
> once the walk enters the finite-generation region where ordering
> guarantees hold.

What about GENERATION_NUMBER_V1_MAX ?

>
> Step counts measured with trace2 on git.git with commit-graph:
>
>   merge-base --all v2.0.0 v2.55.0-rc1:
>     before: 72264 steps    after: 44589 steps
>
>   merge-base --all v2.55.0-rc1 v2.55.0-rc1~5:
>     before:   110 steps    after:     7 steps
>
> Helped-by: Derrick Stolee <stolee@gmail.com>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  .../technical/paint-down-to-common.adoc       | 23 ++++++++++++++++++-
>  commit-reach.c                                | 18 ++++++++++++---
>  t/t6600-test-reach.sh                         |  4 ++--
>  3 files changed, 39 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/technical/paint-down-to-common.adoc b/Document=
ation/technical/paint-down-to-common.adoc
> index 37fa6f93c1..7c93f7e676 100644
> --- a/Documentation/technical/paint-down-to-common.adoc
> +++ b/Documentation/technical/paint-down-to-common.adoc
[...]

> +  5. Side exhaustion: no pure PARENT1 or pure PARENT2 commits
> +     remain in the queue, no pending merge-base candidates exist,
> +     and the walk has entered the finite-generation region.

"finite" or "small enough" ?

> +Side-exhaustion condition
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +A new merge-base requires commits from both sides to meet. When one
> +side's exclusive counter reaches zero and there are no pending
> +merge-base candidates, no future traversal step can produce a new
> +candidate.
> +
> +This optimization only activates in the finite-generation region

"finite-generation region" -> "reliably-ordered region" , or something
like that?

> +where topological ordering holds. In that region, children are
> +always visited before parents, so paint flags are final at visit
> +time and an exhausted side cannot reappear. In the INFINITY region,
> +commit-date ordering can violate this guarantee, so the check is
> +skipped.

"In the INFINITY region" -> "outside the reliably-ordered region" ?

>  Related documentation
>  ---------------------
>
> diff --git a/commit-reach.c b/commit-reach.c
> index a62b5e4624..e03505b535 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -132,6 +132,10 @@ static void paint_queue_put(struct paint_state *stat=
e,
>         }
>  }
>
> +/*
> + * Dequeue the next commit for the paint walk, or return NULL when
> + * no more merge bases can be discovered.
> + */
>  static struct commit *paint_queue_get(struct paint_state *state)
>  {
>         struct commit *commit =3D prio_queue_get(&state->queue);
> @@ -141,9 +145,17 @@ static struct commit *paint_queue_get(struct paint_s=
tate *state)
>
>         commit->object.flags &=3D ~ENQUEUED;
>
> -       if (!state->parent1_count && !state->parent2_count &&
> -           !state->mb_candidate_count)
> -               return NULL;
> +       if (!state->mb_candidate_count) {
> +               /* only stale entries remain */
> +               if (!state->parent1_count && !state->parent2_count)
> +                       return NULL;
> +
> +               /* one side is exhausted */
> +               if ((!state->parent1_count || !state->parent2_count) &&
> +                   state->gen_ordered &&
> +                   commit_graph_generation(commit) < GENERATION_NUMBER_I=
NFINITY)

At this point in the series,
Documentation/technical/paint-down-to-common.adoc does point out the
GENERATION_NUMBER_V1_MAX issue in one of the paragraphs; it's kind of
glossed over in other later paragraphs (as I highlighted above), but
there's a clear incongruence at this point in the series.  I'm
guessing you're going to fix that up in the next two patches, but the
splitting feels a bit off.

> +                       return NULL;
> +       }
>
>         paint_count_update(state, commit->object.flags, -1);
>         return commit;
> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> index f9895f5fd7..6bf17cb7b6 100755
> --- a/t/t6600-test-reach.sh
> +++ b/t/t6600-test-reach.sh
> @@ -297,7 +297,7 @@ test_expect_success 'in_merge_bases_many:self' '
>         EOF
>         echo "in_merge_bases_many(A,X):1" >expect &&
>         test_all_modes in_merge_bases_many &&
> -       test_paint_down_steps 45 2 25 3
> +       test_paint_down_steps 45 1 25 1
>  '
>
>  test_expect_success 'is_descendant_of:hit' '
> @@ -414,7 +414,7 @@ test_expect_success 'merge-base --all commit-walk ste=
ps' '
>         >input &&
>         git rev-parse commit-9-1 >expect &&
>         run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
> -       test_paint_down_steps 81 80 81 81
> +       test_paint_down_steps 81 9 57 81
>  '
>
>  test_expect_success 'merge-base --all with clock skew (side-exhaustion)'=
 '
> --
> gitgitgadget

Other than the GENERATION_NUMBER_V1_MAX stuff, this commit looks good.
There may be a way to reword things to allow the current split, but
I'll keep reading to the next patches.
