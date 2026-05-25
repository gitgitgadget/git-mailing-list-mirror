Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6BD3D648C
	for <git@vger.kernel.org>; Mon, 25 May 2026 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779696014; cv=pass; b=CUeGwodj03EO4RLLYJistYpod9yYMziqvfmN/6+ec2PsbZ6lYwDdAHtSey+/4/BlCoxteu3EestfsD34pZvKh6gsSsItelxpN80FlC2O+GOPozV5PqRibYzUIucSPNq1EfCL6UUUnweTPnFg2xuVKV8+RM/YasjhsTW/TRYxJaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779696014; c=relaxed/simple;
	bh=+Bor0oTZcMZHSUL4aPpkV/BBZq3/vtR4Xy+eLeluU5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRnKwuOOlQIHC+fsnPZvSKqvbI/hh3/epEMrEV0nsrE6XtgNFoX8o8W9EnR7zw3ggPe1i8pwdbOT8GLIhwNRioUPuUfqTq/vPdcKaLlLAWNvkAtw0+1SRPnEv0W/wj4U96HPw8JkU/LqeEK6n8XxqGMfIP0QhYqh2tN5OogvQgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Xs0R6RBb; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Xs0R6RBb"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7bd4c61765dso89061417b3.3
        for <git@vger.kernel.org>; Mon, 25 May 2026 01:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779696011; cv=none;
        d=google.com; s=arc-20240605;
        b=JpZswxycb8JSeqXF52fskM+pld/A0nSZY/pA4VZKTfK1EBGfraX3ec1PPXZuFCKP8d
         pxKfK4Zy4gQtFjMZcn1u0ppbyBskpEk3G5EwsU8e5h61Spgufp/n97b2aEn8yvT1GhSk
         uYkL35W7WDYZ/5mJHetr/ZpHBq33dwwswpM7omeq4Ob9/3lMXTPVBtY8KpkcfUU24aJf
         Z6GC+RQPQ/9OTKopF99fBOZ7ZRs4A4ViMe9XzTk2IJl/nFzHZoBWMtylqFUmIoNtL54h
         XaunnW14zi7rVlHvAohW6/EH1u64z1MXHid/qJF07Bx2nxdrMDYJSFnvQ6R4y2ST/kWs
         AmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=z1vDQphCE6/51TShD/3e2yhnnZWgll00nzkrbcE/PIc=;
        fh=e3wq8csdHGoBhTCTlkFhUgBqLQINJ+TRyNE5GqYCqPE=;
        b=X5Gcc/Xzer0evKnfUzRb5yrIPOMfPjKlHl9qwImGHtRvUrxa0LKq/NbQnqgyPuX6zE
         rXtmRsFZR3N2Sb50Rx0ucX3rzam5FIShvC/Jh+YiB8MgVaOL9wSaDu3Ewfi7XUkRx5Ax
         fvTY99izKbsGKyxWMHJkTvPlwK/fus1LxBMYN4KWR/baAGPODNMBF5juywjtkN6+dH5m
         dVA4d84pSrOFDHuqZ/wFAoWfp37B7Sb0DgjrxZnCWCNHWq3+h9zK1HGy71W2fvoqpV22
         Zo4YgKFwUPE39ILfwhdkO3TzVM2hioyqK9RcrJ4J08afwhAw58EE5iCFtPL6YQGyHWmy
         dpsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1779696011; x=1780300811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z1vDQphCE6/51TShD/3e2yhnnZWgll00nzkrbcE/PIc=;
        b=Xs0R6RBbb6G1hdtZgJpG40iJJCwZDghbkId7tW4ADKSSPxxaDVwYBf9HLvFUFtruzn
         nP9LyOj5X8KXSmm5jmIIrDliLwonVYlAPxH6QF8Cp8rgN9Al/DjY2Cs8OiXPht3q6L/7
         bvmS7jk/UxC4TUvTS0hcmjLWIkXMj3y6b7ZOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779696011; x=1780300811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1vDQphCE6/51TShD/3e2yhnnZWgll00nzkrbcE/PIc=;
        b=WJlb+deGY3hqUXkIqTIyQy7CQ/azJx2TRVdLMU46Q23tPisHOPl+SW+rwtISI0/55K
         wq6qs2ZQ4wSfZr9EYYr43p71pwCRRyvTh8gY+KNMtMOnvEzh7os9n2+SaEGwUVxD8D9A
         0dBwXlify9s46hPAAf/ES8pCZXZPXD2Pl1q9Ep22XfStTf6wXHu5G4TykM96lcK4oGEV
         cngfi6d9l/CRbBPpLzpEGBm/m8cUe8WCOqP+DM2ACRYOthYibYsDG7koQbg4+b+A++QF
         eUSHRtytv6MMU/k4ZRjZSPAa5RGayOgigbbJglSoHhGjCzWYmd/KKvFb6VMwE5aTuLWX
         JCBw==
X-Forwarded-Encrypted: i=1; AFNElJ+Bi5o89PqkrmJJx+efoqiAm5/eFITZPXvULtL5uiL7Iv+Oh9FL/6HRPzQ3UauMQYFyJwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8JN4sEiCbQ+PXsNDDrzwTxHnO6v4pE7f5afJ1lIizlqwD8Oyt
	zCJjRGe2wQVjJxXSAA3XU4pPw1pFdSgKo9nrHs38RW98pKgXnn6PQaESdDJI5OMC++3Eu2mNV1R
	QXM53Rqa5mwU4q9J7QCtdIe8c4z7Dh2l1sRxDtUjviQ==
X-Gm-Gg: Acq92OHCaEgg9LS8Pfg8A0BO4+tUgQ2uAQ+2xVEBpIVKHs2BucGlwJWUlRbAkOB5kYb
	41DbhK+bzTYnlloTvcrxe63y2pcw5MYHLDHh5ttT9OVpHbOewQs2O8MIvBryCSHlFxjP6ZO3NuL
	qZ080k99DuhlIAJioHurtcd1+qIr2aogVupcjNfRtVNEiM58j8yNQBstgtJE5QrQFxsJCKrwH5G
	e9dxB4D/agdR4Tqp8IXtTDVl9w8YWhLEms9jxkV5/oDj3ySSEb9+TSPrTAIMWjkBQRJAtpCuuo4
	j17VWSRs
X-Received: by 2002:a05:690c:630d:b0:7d0:2b7:6b14 with SMTP id
 00721157ae682-7d3374b1b83mr149540307b3.50.1779696011092; Mon, 25 May 2026
 01:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com> <20260525064755.GA2737798@coredump.intra.peff.net>
In-Reply-To: <20260525064755.GA2737798@coredump.intra.peff.net>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 25 May 2026 09:59:59 +0200
X-Gm-Features: AVHnY4IL_EFOckhlJ0OskQ9sRvmxhGpbd4d8rmHOUGdelo5C6levSEi_uvhP5-A
Message-ID: <CAL71e4MOH2iPve19dKixLHSgpC3ZAZz59zLWEWRoxW1a7vhMwg@mail.gmail.com>
Subject: Re: [PATCH 0/3] commit-reach: replace queue_has_nonstale with a counter
To: Jeff King <peff@peff.net>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

That's an excellent approach! Much cleaner in general.

I benchmarked it against the counter on a monorepo with wide-frontier DAGs
(2.4M commits, component import merges). Using merge-base --all to bypass
the early-exit optimization from kk/paint-down-to-common-optim:

               Baseline    Cache   Counter
    import(A)    8079ms   3686ms    3723ms
    import(B)    5498ms   3993ms    4038ms
    import(C)    4350ms   1748ms    1766ms

The cache performs on par with the counter - within noise on all three
cases. No new flags needed, much simpler diff.
The amortized O(1) is just as good as true O(1) in practice, and it avoids
the ENQUEUED flag and counter bookkeeping entirely.

I went with back-to-front scanning as you suggested, and also clear
the cache when the cached entry goes stale. Applied to both
paint_down_to_common and ahead_behind.

I can rewrite the patchset with this approach and add you as co-author or
suggested-by? Or I think I can wait for you to push it yourself.
You did all the work here, and just didn't have enough data points to
motivate it?

- Kristofer

On Mon, 25 May 2026 at 08:47, Jeff King <peff@peff.net> wrote:
>
> On Sun, May 24, 2026 at 05:42:17PM +0000, Kristofer Karlsson via GitGitGadget wrote:
>
> > paint_down_to_common() and ahead_behind() terminate when every commit in
> > their priority queue is STALE. The current check, queue_has_nonstale(), does
> > an O(n) linear scan of the queue on every iteration, costing O(n*m) total
> > where n is the queue size and m is the number of commits processed. This
> > series replaces that scan with an O(1) counter.
>
> We faced a similar problem in limit_list() but solved it a bit
> differently (mostly because I was worried about keeping the counter up
> to date in all cases).
>
> It's described in more detail in b6e8a3b540 (limit_list: avoid quadratic
> behavior from still_interesting, 2015-04-17), but the general idea is to
> just cache the interesting element we found, and invalidate the cache
> when it gets removed from the queue or gets marked UNINTERESTING.
>
> The equivalent code for the STALE flag here is something like this:
>
> diff --git a/commit-reach.c b/commit-reach.c
> index d3a9b3ed6f..d1621be89f 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -39,12 +39,25 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
>         return 0;
>  }
>
> -static int queue_has_nonstale(struct prio_queue *queue)
> +static int queue_has_nonstale(struct prio_queue *queue,
> +                             struct commit **nonstale_cache)
>  {
> +       if (*nonstale_cache) {
> +               struct commit *commit = *nonstale_cache;
> +               if (!(commit->object.flags & STALE))
> +                       return 1;
> +       }
> +
> +       /*
> +        * This might also benefit from looking back-to-front, since
> +        * earlier commits are more likely to get popped sooner.
> +        */
>         for (size_t i = 0; i < queue->nr; i++) {
>                 struct commit *commit = queue->array[i].data;
> -               if (!(commit->object.flags & STALE))
> +               if (!(commit->object.flags & STALE)) {
> +                       *nonstale_cache = commit;
>                         return 1;
> +               }
>         }
>         return 0;
>  }
> @@ -61,6 +74,7 @@ static int paint_down_to_common(struct repository *r,
>         int i;
>         timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
>         struct commit_list **tail = result;
> +       struct commit *nonstale_cache = NULL;
>
>         if (!min_generation && !corrected_commit_dates_enabled(r))
>                 queue.compare = compare_commits_by_commit_date;
> @@ -77,12 +91,15 @@ static int paint_down_to_common(struct repository *r,
>                 prio_queue_put(&queue, twos[i]);
>         }
>
> -       while (queue_has_nonstale(&queue)) {
> +       while (queue_has_nonstale(&queue, &nonstale_cache)) {
>                 struct commit *commit = prio_queue_get(&queue);
>                 struct commit_list *parents;
>                 int flags;
>                 timestamp_t generation = commit_graph_generation(commit);
>
> +               if (nonstale_cache == commit)
> +                       nonstale_cache = NULL;
> +
>                 if (min_generation && generation > last_gen)
>                         BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
>                             generation, last_gen,
> @@ -1053,6 +1070,7 @@ void ahead_behind(struct repository *r,
>  {
>         struct prio_queue queue = { .compare = compare_commits_by_gen_then_commit_date };
>         size_t width = DIV_ROUND_UP(commits_nr, BITS_IN_EWORD);
> +       struct commit *nonstale_cache = NULL;
>
>         if (!commits_nr || !counts_nr)
>                 return;
> @@ -1074,11 +1092,14 @@ void ahead_behind(struct repository *r,
>                 insert_no_dup(&queue, c);
>         }
>
> -       while (queue_has_nonstale(&queue)) {
> +       while (queue_has_nonstale(&queue, &nonstale_cache)) {
>                 struct commit *c = prio_queue_get(&queue);
>                 struct commit_list *p;
>                 struct bitmap *bitmap_c = get_bit_array(c, width);
>
> +               if (c == nonstale_cache)
> +                       nonstale_cache = NULL;
> +
>                 for (size_t i = 0; i < counts_nr; i++) {
>                         int reach_from_tip = !!bitmap_get(bitmap_c, counts[i].tip_index);
>                         int reach_from_base = !!bitmap_get(bitmap_c, counts[i].base_index);
>
>
> I don't have a repo handy which reproduces the problem, so I can't see
> if it improves things. But if it's easy to do, can you report on the
> timing change with your monorepo?
>
> I do think what I've shown here is a bit hacky (just like the
> limit_list() one), as we are relying on heuristics about the order in
> which items are taken from the queue. So even if it performs well, we
> may still prefer the counter version for being truly O(1). But having
> timing numbers would be useful for comparing the two approaches.
>
> -Peff
