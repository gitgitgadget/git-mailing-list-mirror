Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14B316905
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944859; cv=pass; b=ntypeamlfX0aFmxkxz0FBwYjr/8+wbc1GfG/do0MM9D37Zv7Tnu1Oij6u46uwaWR1Pu5aRjcYwrzU6qrv/dGm49N2Z8Ihi6e0IOb8UI0iNz3DpMvWdKluW1vFx28PuNYPqvL3CodCk4tNaWv+a6u+fcWwOwMIfdYn2qlp9RbgqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944859; c=relaxed/simple;
	bh=zkt3/cl9Ju1lH1yIsujzljwCb795gG7fNincRIiAtbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nu5B4lMoOU30pWKwbO5HhoAJJ8sWDgIqOQpn/vjZdZL2aLadKnQX1g1Rc9G26zepkGnLS6v4j+FSP8++Ly79Njo3m5RrY+Yua8hKF/K2HptMw1OStRAW/7kwCuT39opXA89woRno6hEMc0gmjR6et/YfACZ6beSUf0M12mj5G9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Dj6qhBlk; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Dj6qhBlk"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-6762de1c77eso2863029d50.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 05:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790944856; cv=none;
        d=google.com; s=arc-20260327;
        b=fMPHGntAsYg4E1WmOOLoJ+5TwsKWogAnFdy1dZvayO+St3zoJRxLHrZQpwoDiiXnRY
         OPqBgxL4EIHKZAlH04qsXdtm/RTcG53sw9wDSpP9zMkxx8T25kfNkyMSvV/RCcTu6v49
         eQ34p2ahv//97kTAwoQ8CBUPREH7AMDi/yEi/+8lpOcNsBTWE4638TkxhQAtDHJHnWzl
         fQ5AfGeCZAGFTzMFOWi/UKLd41/pn+j65r5rM/DPe41H7IP4QZzsHCi7i1d1Er8nf0at
         slgGPgX1EDRi9a1LIGrOPAZX74xsG2G9j/ExZUWTQ7Td4+vpjzoE9/7+RdIoQfmeQaz1
         IOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dYg3yaZwsRyLwDgTLypW6tWcXATyfSSRxtNPgUVgHkA=;
        fh=qljI9BEnCiy1dYP534k7cwzMOrL3BlNrBzawE+tMD1k=;
        b=lE7OaYYTRYiKAFFDDF8tgcrJX1vp2JuR287IItszDqz6XXXnBryBgrYoqBammzkXQg
         yB/gp6k+WWr7Th917hfFGRxM4jFTfPZPnhkbKVwOwIeEzcXCnBOpv4rPTwskdsWpnQd6
         poS1jmZp68th8oF0gqg8Cs9lPpSCWrDi7D2YuzsEZC+Sbk3OHhZjZafcEw/7l9Hbzujr
         QFyjJoovHhkcVwcRqDYpZiK6UUmsmN3VD2YV+ksCilU4oZ7BjMJ/J6/50yTG/M96VsZB
         kOy0KIx8C4wRgL9yjj1hk7BNRB0q3bGZKQwH9nc74MwRgymaz9r2ssdR0AZ87gSDMaCY
         DYSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1790944856; x=1791549656; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dYg3yaZwsRyLwDgTLypW6tWcXATyfSSRxtNPgUVgHkA=;
        b=Dj6qhBlk6TmXunGL5x5Dcc5C1YQjkPkj5DiT72/NuEyqDx2En1xiUXdJg3vrf+cd4i
         xzFdWd1JqD4f9mjSIGI0Ogf3OylR29NeD5w2S5G+UYmGKXsd1Zcm+tgvdD73IVh8Pafm
         8J6O5QVaxADqprftVQSS6thm/M2pvPXUtJX4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790944856; x=1791549656;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dYg3yaZwsRyLwDgTLypW6tWcXATyfSSRxtNPgUVgHkA=;
        b=1VuA3jYvwU/RIQ1gO5RuVslYtUICiESvNhUGpN/a/tnyYMN3YMnwPdGKAckktAcBnv
         3KWcH9cU5H+puq6W54t9wfCpXWHQABQ2Uy5/RTpebkW4lBwqT2rBhoAw3Sg3wufj1bEr
         y5B33Q9Q343dj3rrRuJ94QBh/a4nKCvw0wLgxmvISwY6D1gQ7qq5YfDWGKwRi8POa5q5
         oWsd8DhnjVOK+hMaVqm88EHnD2yQ4YmagUg3kD9z11Wemk/GHrxzf0O+tBWsiuQF5Sez
         usLux6JGhiKfk/fAEPEenQfqlLDRMsWXOGgr8mljDIQZxcIOviphyOVDo+aTdjQhVh3l
         pPag==
X-Forwarded-Encrypted: i=1; AKwUvBxGAYt5vQ3YvwJ1WF8iud0bkMze0HFxaQtAexwYFl7i5ldMemGUC28RxwgxhkklF1YItBI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJX+Pm5kz/uYJ/HnPaZO5Hxa61EsfsCl+XYuPFBaGD0bmDubh8V
	+5B+486Pu+R95oZDo3seh/qEvLhIqRFnwfi3bBj56ELWxtd9MBXSEJjPMT0m5HR3Ep4Pc/Qrdlf
	gLFRLP2WEyLw5Hs8j3DqswKmomJ0/DDhBTFaMTZOv9w==
X-Gm-Gg: AYBFou2Kk8pUu3EmH868kKbX+xuNKzQc3z3AUKomJ5kxGQVPkKAGwJb0tq8DvyHyn0a
	T+pJTBEAKL8a5wLiyA93hELSE4hhzN9iZmJQ1ccmL6isPTAr6ZjtYp0i+zX7ZuWGPxudPV9fcG9
	vQqUxqW6vqCL1oQVvE6aItaROURquc0oAOh5DLCyeCG8iQ+QoHXinKRiwplmD6DZXGWHAW3g9Hp
	BvttDYRQGUP14D5ukRcZLGXC9vzEiiOTJbVHIwD/w6QHZcEOeDRttcZ6C5R89z7hQ7/VscSRcmJ
	Wjy4V60KgcF2Lkm0kbFSiTXLradI7wCJpRcAnPubTeo7TOW/vXFW7xg=
X-Received: by 2002:a53:a103:0:b0:675:405d:643b with SMTP id
 956f58d0204a3-677ac0e6b45mr626910d50.98.1790944855598; Fri, 02 Oct 2026
 05:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
 <fee92f3c2009f8f282fe98e6b16d403704db9ad9.1790930019.git.gitgitgadget@gmail.com>
 <ar-T2y54X1uDQ4mX@pks.im>
In-Reply-To: <ar-T2y54X1uDQ4mX@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 2 Oct 2026 14:40:44 +0200
X-Gm-Features: AclHuK9twjDkG-lVsfCd_JL2QA6mg4Xv9Rl1V1WNkBN4J0jurOWpAyfbFC_yQMc
Message-ID: <CAL71e4OcAg1PYaZZ2474Q5ayQgTeJFR2-7J+0ddrCe+rwwj=3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] fetch: write commit-graph using updated refs only
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Oct 2026 at 13:22, Patrick Steinhardt <ps@pks.im> wrote:
>
> >  1. write_commit_graph() was added, and it accepts an explicit set of
> >     commits as seeds, enabling more targeted commit-graph updates.
>
> Hm. The big question here is whether these additional seeds are additive
> or exclusive. That is, if I have an existing commit graph already, would
> it basically just extend the commit graph with the additional object IDs
> or would it replace the commit graph with a new one that only considers
> the passe object IDs as input?
>
> I would hope that it's additive, because otherwise you may now lose
> commit graph coverage for stuff that was covered before the patch.

Yes, it is additive.  fetch always writes with this flag:

    int commit_graph_flags = COMMIT_GRAPH_WRITE_SPLIT;

so write_commit_graph() only adds the commits that are not already
in the graph, as a new layer on top of the existing chain.  When
layers get merged, the commits of the merged layers are carried over.

You are right that a non-split write without COMMIT_GRAPH_WRITE_APPEND
would replace the graph with just the closure of the seeds, so this
relies on fetch using split mode.  I can extend the test to verify
that commits which were in the graph before the fetch are still there
afterwards.

> >  2. The ref-scanning callback add_ref_to_set() became more expensive
> >     in
> >         630cd5194e (commit-graph.c: peel refs in 'add_ref_to_set',
> >                     2020-07-22)
> >     when it started to validate the refs against the odb
> >     for correctness.  On a repository with many refs, this makes the
> >     full reachable scan unnecessarily costly for a targeted fetch.
>
> I was wondering whether incremental commit graphs would also be part of
> the reasoning. Because in theory, now that we have those, we could even
> extend the commit graph on a fetch by just writing another layer.

Yes, that is exactly what happens: since fetch writes in split mode,
the newly fetched history ends up in a new layer.  The commit message
should say so explicitly, and I will update it in the reroll.

> > Since do_fetch() already knows which refs were updated, collect them
> > into an oidset and then pass them directly to write_commit_graph().
> > In split mode, close_reachable() walks from the updated tips and
> > stops at commits already present in the graph, efficiently adding
> > the newly fetched history.  This reachability closure also covers
> > auto-followed tags, since their targets are reachable from the
> > fetched tips that caused them to be auto-followed.
>
> Aha! So I wasn't that far off :) Now there's a follow-up question
> though: what happens in non-split mode?

The fetch path never uses non-split mode (see above).  If that ever
changes, the incremental path would need COMMIT_GRAPH_WRITE_APPEND,
or a fallback to the reachable scan, to avoid losing coverage.

> > After fetch_one() returns, call prepare_commit_graph() (which is
> > made non-static by this commit) to determine the graph-write mode:
> >
> >  - If no commit-graph exists yet, fall back to the full reachable
> >    scan so the first graph creation covers all refs.
> >
> >  - If a commit-graph exists and the fetch updated at least one ref,
> >    write incrementally using only the new refs as seeds.
> >
> >  - If a commit-graph exists but the fetch is a no-op, skip the
> >    commit-graph write entirely.
> >
> >  - For the multi-remote path (fetch --all), where child processes
> >    do the actual fetching, fall back to the full reachable scan.
>
> All of these make sense, but the above question is not answered yet.

I hope the answer above covers it. :)

> Curiously, you mention performance as motivating factor for this change
> but don't provide a benchmark demonstrating the benefit.

I left it out since the change avoids work rather than making existing
work faster: the cost of the full scan grows with the number of refs,
so the improvement depends mostly on the repository.  But I agree that
some numbers are useful.  Here is a synthetic setup: git.git with 200K
extra packed refs (~206K total), a local file:// remote, an existing
split commit-graph (and a warmed up page-cache).  Times are the median
of 9 runs and I am looking at the trace2 region for
fetch/write-commit-graph:

    scenario          before    after
    no-op fetch       380 ms    (skipped)
    1 ref updated     357 ms    9.3 ms
    10 refs updated   359 ms    8.9 ms

I will include these numbers in the cover letter of the reroll,
or do you think it makes more sense to also have them in the commit
message?

> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 533fdfe7d8..8ad7331640 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -1903,10 +1903,30 @@ out:
> >       return retcode;
> >  }
> >
> > +static void collect_updated_tips(struct oidset *tips, struct ref *ref_map)
> > +{
> > +     struct ref *rm;
> > +     for (rm = ref_map; rm; rm = rm->next) {
> > +             struct commit *commit;
> > +             if (rm->status == REF_STATUS_REJECT_SHALLOW)
> > +                     continue;
>
> Hm. Shouldn't we also refuse almost all of the other values here? I'd
> expect that we only want to consider a tip when it has REF_STATUS_OK.

This confused me at first too.  REF_STATUS_OK and most of the other
values are only used on the push side.  During fetch, the status stays
at REF_STATUS_NONE, and the only value that fetch-pack sets is
REF_STATUS_REJECT_SHALLOW, so that is the only one we need to filter.
Requiring REF_STATUS_OK would skip every ref.

However, I could change it to use status != REF_STATUS_NONE --
those are the only two statuses we can get so both would work,
but I guess which one is best depends on what kind of new statuses
could be added in the future.

Refs whose local update gets rejected (e.g. a non-fast-forward without
--force) are still harmless to include, since their commits are fully
present in the object store.

> > +             if (is_null_oid(&rm->old_oid))
> > +                     continue;
> > +             if (rm->peer_ref &&
> > +                 oideq(&rm->old_oid, &rm->peer_ref->old_oid))
> > +                     continue;
> > +             commit = lookup_commit_reference_gently(the_repository,
> > +                                                     &rm->old_oid, 1);
> > +             if (commit)
> > +                     oidset_insert(tips, &commit->object.oid);
>
> This is something that always trips me with `struct ref`, that I'm never
> quite sure what's what. So please forgive my ignorance, but why do we
> look up `rm->old_oid` here?

This tripped me up as well.  In the fetch ref_map:

    rm->old_oid            the value advertised by the remote, i.e.
                           the new tip we are fetching
    rm->peer_ref           the local ref it maps to via the refspec
                           (e.g. refs/remotes/origin/main), or NULL
                           if it only goes to FETCH_HEAD
    rm->peer_ref->old_oid  the current local value, before the update

So rm->old_oid is the new tip, and the oideq() check skips refs that
did not change.  rm->new_oid is not set on the ref_map during fetch;
store_updated_refs() copies rm->old_oid into the new_oid of a
separate struct ref for the local update.

As a concrete example, say "git fetch origin" with the default
refspec sees that the remote's main moved from A to B, a new branch
topic appeared at C, and stable is still at D:

    rm->name           old_oid  peer_ref->name             peer old_oid
    refs/heads/main    B        refs/remotes/origin/main   A
    refs/heads/topic   C        refs/remotes/origin/topic  (null)
    refs/heads/stable  D        refs/remotes/origin/stable D

This collects B and C as tips and skips stable.  When fetching from
a URL without a configured remote, e.g. "git fetch <url> main", the
entry has no peer_ref (it only goes to FETCH_HEAD), so B is
collected unconditionally.

> > @@ -2535,6 +2559,12 @@ int cmd_fetch(int argc,
> >       int negotiate_only = 0;
> >       int porcelain = 0;
> >       int i;
> > +     enum {
> > +             GRAPH_WRITE_REACHABLE,
> > +             GRAPH_WRITE_TIPS,
> > +             GRAPH_WRITE_SKIP,
> > +     } graph_write_mode = GRAPH_WRITE_REACHABLE;
> > +     struct oidset updated_tips = OIDSET_INIT;
> >
> >       struct option builtin_fetch_options[] = {
> >               OPT__VERBOSITY(&verbosity),
> > @@ -2822,7 +2852,13 @@ int cmd_fetch(int argc,
> >               }
> >               trace2_region_enter("fetch", "fetch-one", the_repository);
> >               result = fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs,
> > -                                &config, &filter_options);
> > +                                &config, &filter_options, &updated_tips);
> > +             if (prepare_commit_graph(the_repository)) {
> > +                     if (oidset_size(&updated_tips))
> > +                             graph_write_mode = GRAPH_WRITE_TIPS;
> > +                     else
> > +                             graph_write_mode = GRAPH_WRITE_SKIP;
> > +             }
> >               trace2_region_leave("fetch", "fetch-one", the_repository);
> >       } else {
> >               int max_children = max_jobs;
>
> It's a bit curious that we have `GRAPH_WRITE_SKIP` as an explicit value
> here as it can be trivially derived from `oidset_size()` anyway. But
> other than that this is the safeguard that you were talking about: when
> we have a commit graph already then we only update with new tips,
> otherwise we use a full reachability walk.

The oidset can be empty for two different reasons:

 1. the fetch was a no-op, in which case skipping is correct, or

 2. fetch_one() was never called because we took the multi-remote
    path, in which case we must fall back to the reachable scan.

Deriving the mode from oidset_size() alone would make "fetch --all"
with an existing graph skip the write entirely.  Setting the mode right
where the fetch happens seemed like the best way to make this more
explicit and easy to reason about.

> Thanks!
>
> Patrick

Thanks for the careful review!  I will update the commit message to
cover the points above, extend the test, and send a reroll (next
week I suppose, don't want to rush it).

Kristofer
