Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB95472F69
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056287; cv=pass; b=uh//eAe9ncecA1RRXRH5CDkdhpfz17ohGEZ8N6HAWe7lCFjOBbS7q51uddBRRaJNUxS6UExTP/b2aq1iAM8d4gd065CN0+ugs0bItr7VD0r2TEINTxrYS/F5tuJmHX7Py2k7UObqszItfQCqi5ocMlzIZ6YEsl/UFOI6yjAUcfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056287; c=relaxed/simple;
	bh=3eiG0KfcF/gtuI85a5P1xRarUq8u32k3pACcsKxE/x0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WnPiVyppqlpJMV38i1lBTT85CGgBNTw35E/XTcQLH7Z0WgLXnaAUsUeEGGiqrHN6DidAWyhRQ9swiK/mk+5K2VzJoR6NUmV53611hPdJsP7WMU8iAXZ8GcQSUeFKT0LvIkKwUF6BxH6zOPucUlWodDD3EmSAL84MkrJ62aYxOos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=K1Sfno/y; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="K1Sfno/y"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66c70cff944so4039014d50.0
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 05:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787056282; cv=none;
        d=google.com; s=arc-20260327;
        b=jGAuuwyrg1XQKs3LWy0XSNnXf2p8m0Kz6sTVsRwysoElhL+AXltqpZujzcIZGXBEIR
         AfhaQUb04NH2L2k7v3eF9u206Kg3bUx5FvnldWoaWgr15fiJ1xEl5RhPxa+8jVHujkKH
         KnkwR66JxkP1srV3FDzgQKMD46ZmVMt+7EAnsfMRwBqGYjuAIXIpZBk+M8RmE8bS+w8J
         CxPlLcAovxeyOYzjEwijxlPouDDAg1LDeldPLF0J3UAGxFfWtQhwsfe6CeUJj0yw2xeL
         wxfUxgtQhsL5Oa1dHgn6NjXgjXNFIaSMFl13vB2RgcqRnyGuHi1GQUrMKwB00KTmfxQy
         jNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DbBW8SBL/dl6PzXoLPXXIKQUheRPziVWZISQvzhikhY=;
        fh=7uiKd3Ud4uC5u8f1C5icixH8oiwEAB/Z4DkRm/FWngY=;
        b=ZMdNwqrtmyUvbyrekzLQVD/Nz2cXG7hjLZ820t6QEi1AoiwOgd3viH6rXrgJDaWgM+
         oQPmqc3iNAWwA2i/5qNEdYivkE/LjO276teKDay7JSKWW4ncOFcWznXZmECb7oLQdeKC
         jnh7mYzCztJj/jx8GgFEfp+y4Bb/rgeYLYUYkN2NiJvVrad2kO4FwDLdoMleCI28qvsj
         8xcPoE1E7+t1e5v4Y67yDggChWQjSNSOkC87d10NmmujLNwo2NoooP7lij7XiFYod3tk
         GJm7zkZ7fkiKzQhEazy6+agYklxURP98SIu8H9aGztnYUN2FCD4xAp9I2YKAdeGApsHW
         2K2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1787056282; x=1787661082; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DbBW8SBL/dl6PzXoLPXXIKQUheRPziVWZISQvzhikhY=;
        b=K1Sfno/yYWxQX9cbaBtSksyZMZ9Nl19Ygtp7WBp49Zj1tX8ku67DXEjwvGorhfLceJ
         L3EIct8rGEgQZY4AOua2ujWU1/DCQCItcuxlysXcfZDYOfNF2qxcCZmawIjC07VLIcyl
         k1L3LsN1H/oBE9tQAoFHXb0rbEh24VWXbzXv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787056282; x=1787661082;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DbBW8SBL/dl6PzXoLPXXIKQUheRPziVWZISQvzhikhY=;
        b=MtkcX0+3FflS3tp35s+1xbALX8qnXOGPt+5aTMT4c0jDqR43+x/vgu4qlwIkGn5yCa
         XOUeSkmpApZ/qP9Z1UlIiBWkxBDUMjAT7mZ25Nm6rJ/SfJFaOOoZ0nWNbmS8CM0c9lsd
         qa9puzho4crnxC76xwrDt1Dl1kdVAcDpETZL1zqNtfsm1k4Qr4POdXXDjxefGpeP0unJ
         zrrK55+oZk0mn9xm+AsZddm5GSWnvUmUwwFLEXQeFb6YCEAIz47xRuAuSz23CYs4hYID
         ugjNFFvdr7WnAq9vEoQ6ey0H9TTQLzaVEezzwEZiCQLVyUFOjEu4umgyg2bBLrtbZGN7
         9IyQ==
X-Gm-Message-State: AOJu0YxCVxg5sTyLE+VLGq6eUwKiFellnLw2LJhXhu9wU35y6HcwrqLL
	G8dcPIWC7uW+/h7fxPpzfAhiD2HiXTsiHskmJ7mhOaYaIGxEw6cQ3bMI12RCXZOh3fh4RqEH0/c
	nGDcuT1N8UW9qtbhNJAbW0pqaCy4YlPgmsUa4bDrMDAawd+28K8znXjBm1w==
X-Gm-Gg: AR+sD11ZSUX/5UnltkZQi175E5I16eUsgHVbnhvxG8iMFrOZ0ZEbTA2e4iBF0KX6D5E
	85qvdmCWk7qve2y+yoPE8Y+FFKLwaaRjDw/2HnirefuJMb6BDl90Zv25Js0WXcM+gRMNoF1fMzB
	kPNQ6PmsVlHNBB2TG22v5GS9VhmLPQQaMVUQ7K1yGP3l0LBrl4LyVFl98DVFmxCF/rjPhuxohZM
	rklY7y24L6d5QpjMly6AsUc024sG5T6qMF/acaL52wynv6qjdESIngykjM2FSMygzng0lxFXlut
	iCWLe2ldbID5vprDvTBuhgODiV4ZY64QkrfUX8N6NQsl
X-Received: by 2002:a05:690e:1406:b0:66c:bbc4:9fb0 with SMTP id
 956f58d0204a3-66cbbc4a34fmr2065835d50.2.1787056281402; Tue, 18 Aug 2026
 05:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 18 Aug 2026 14:31:09 +0200
X-Gm-Features: AcwNN1U4IFRJYlyE2ssJNXivwSVYqWZrfOV_DL4-naqADGvazJ9Ve_jUucX5DLY
Message-ID: <CAL71e4Nf=-zCrfN7ghEVGq11irajJhtdxYZgKe0Ycux0qs1ZvQ@mail.gmail.com>
Subject: [RFC] check_connected: toward incoming-proportional cost
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

Hi!

The connectivity check (check_connected()) used by both fetch
and receive-pack (and a few other call sites) can be expensive
for repositories with many refs or large active trees, and I
think that is worth optimizing.  I have a couple of ideas for
how to approach that, but before I start sending patches I
want to discuss the high-level need and align on the direction.

This follows up on Patrick Steinhardt's 2021 series [1], which
explored a faster connectivity check.  I found that thread
after independently trying a similar approach (and the thread
was helpful for making me pivot away from it).

My key takeaway from that discussion was that making the
check faster would be useful, but we need to preserve the
connectivity invariant, and I think I found a way to
achieve that.

A few definitions I will use throughout:

  Trusted object (in the context of connectivity check):
    an object whose complete transitive closure is known to
    be present for the purposes of the connectivity check.
    For an object with traversed references, this requires
    those referenced objects to be trusted.  Objects
    reachable from current tips are implicitly trusted by
    the existing connectivity invariant.

  Boundary commit: a trusted commit at the edge between
    already-trusted and newly introduced history.  More
    precisely, a trusted commit reached while walking
    parents from an incoming tip, where the adjacent
    commit toward the incoming tip is not itself reachable
    from any current tip.


Problem statement
-----------------

The current implementation delegates to a rev-list
subprocess:

    rev-list --objects --stdin --not --all --quiet

feeding the incoming tips on stdin.  This reuses the existing
traversal machinery, which is nice, but it performs work that
depends on the existing repository size rather than the size
of the incoming set.

The rev-list operation can be modeled as two steps.

  1. Find the set of boundary commits, using graph traversal
     seeded by all current tips and all the incoming tips.

     The cost here comes both from the number of current tips
     and the overall graph distance from the seeds to the
     boundary.  As Patrick noted in the previous thread, this
     becomes very slow with 880k refs.

  2. Verify the objects reachable through the trees of the
     incoming commits.  This is implemented by first walking
     the complete tree closure of the boundary commits,
     marking all visited objects as trusted (UNINTERESTING
     in the rev-list semantics).  This ensures that walking
     the tree closure of the incoming commits can be pruned
     efficiently and thus becomes cheaper.

     The cost here is the initial marking, which effectively
     visits all active objects.

Since the cost is approximately proportional to both the
number of local tips and the size of the active object tree,
it can slow down local fetch operations and server-side
receive-pack -- and I have observed this being one of the
bottlenecks for servers with very frequent pushes.

The recent --skip-connectivity-check addition [2] lets server
operators bypass the check entirely when they have external
validation, which suggests the cost is a meaningful pain point
for some server operators.

Ideally the connectivity check should be proportional to only
the incoming set.  I am not sure if we can fully reach that
for all scenarios, but it is possible for simple cases such
as:

  * pushing new commits on top of an existing branch
  * force-pushing new commits that have been rebased on a
    more recent origin/master.

If we manage to optimize the check for most scenarios, we can
reduce the overall load on git servers even if edge cases will
still exist.

The two steps (finding the boundary, and verifying commit
trees) have independent scaling problems and I believe they
can be optimized mostly independently.

I start with step 2 because it seems like the simplest one to
reason about, and I also need it to simplify the solution for
the other problem (step 1).


Proposal for opportunistic trusted-tree discovery (for step 2)
--------------------------------------------------------------

The current implementation eagerly walks the tree closure of
the boundary commits and marks the visited objects as trusted
before verifying the incoming commits.  Instead, I propose
maintaining a cache of trusted objects while verifying the
incoming commits.  A cached object does not need to be
verified again; for a tree, this also lets us prune its
entire closure.

The cache is populated in two ways with different goals:

First, every object verified during the walk is cached, so
we never need to verify the same object twice.

Second, we can introduce a heuristic for opportunistically
populating the cache based on doing a parallel tree walk
against trusted parent commits.

Ignoring details like missing entries and type-changing paths,
the core idea is roughly:

    global trusted_objects = {}
    def visit_tree(candidate_tree, parent_trees):
      for parent_tree in parent_trees:
        for (_, obj) in entries(parent_tree):
          trusted_objects += obj
      for (name, obj) in candidate_tree:
        if obj in trusted_objects: continue
        if obj is a tree:
          parent_subtrees = parent_trees.map(_.get(name))
          visit_tree(obj, parent_subtrees)
        // verify obj itself
        trusted_objects += obj

This heuristic prunes verification to roughly the changed
entries, as long as there are no cross-directory moves.  If
there are moves, such subtrees would be verified instead of
skipped -- we may lose some pruning opportunities, but that
affects performance rather than correctness.

This heuristic relies on parent-before-child processing
order: all parents must already be known to be trusted before
processing the child, otherwise entries from the parent side
cannot safely be added to the cache.


Proposal for finding the boundary (step 1)
------------------------------------------

This part is harder, but I think there are approaches that can
speed up the common case.

The simplest option: seed the traversal with a small set of
likely-useful refs (the old values of the refs being updated,
possibly together with a few other likely tips) and a bounded
walk budget.  If every ancestry path from each incoming tip
reaches a trusted commit within the budget, the boundary is
closed and we are done.  Otherwise fall back to --not --all
as today.  This should cover many common push workflows and
is straightforward to reason about.

If this finds a solution, it is not necessarily minimal.
Walking from other refs could tighten the boundary, but this
is still valid for correctness.  A non-minimal boundary means
more candidate commits to verify, but with opportunistic
discovery (Proposal 1) that extra work is typically cheap --
those commits share most of their trees with their parents.

A more ambitious follow-up could interleave lazy iteration of
the refs with the graph walk, rather than enumerating all refs
up front.  Each newly loaded ref adds its tip to a shared
priority queue, and the walk budget is charged globally
regardless of which ref's ancestry is being explored.  Refs
would ideally be loaded in an order likely to close the
boundary quickly, with a fallback to full ref enumeration if
the budget runs out.

One possible ordering mechanism would be a user-configured
priority list of ref prefixes, though I have not explored that
enough to argue for it yet.  The point is mostly that I think
this is solvable, but I do not know exactly what the best
solution would look like.

For the prototype I used the simple option, but I am less
sure that hard-coding that heuristic is the right upstream
interface, and I would be happy to either flesh out the
follow-up idea or hopefully arrive at an even better approach
through the discussion here.


Preliminary results
-------------------

It's too early for proper benchmarks, but I think it's useful
to get a sense of what is possible.  My local prototype for
both proposals speeds up the connectivity check for a large
repository (3M commits, 200K refs, ~600K tree and blob
objects reachable from the boundary).  Numbers are
intentionally rounded to one significant digit since this is
not scientific, purely intended as guidance for knowing if
it's worth exploring further.

  5-commit push, 45 changed files:

  Current (rev-list --not --all):               1     s
  Opportunistic discovery + bounded traversal:  0.03  s

  1-commit push, trivial change:

  Current (rev-list --not --all):               1     s
  Opportunistic discovery + bounded traversal:  0.007 s


On this workload, the opportunistic discovery is much less
impactful than the boundary walk, but it is included here
because I never attempted to combine the existing rev-list
--objects mechanism with the new boundary search.

The bounded traversal (seeded with the old branch value)
avoids loading the full ref set, and opportunistic discovery
reduces the object verification: around 100 objects walked
instead of the full 600 000 tree and blob objects.


Other approaches considered
---------------------------

I also explored using commit-graph membership as evidence of
past trust: if a commit is in the commit-graph and in the odb,
treat it as trusted and stop the walk there.  I initially
hoped that GC's treatment of reachable closures might make
this safe as well.  However, it turns out to still
be hard to reason about what it means for an object to exist
in the odb -- it may still exist in a pack that is retained
because other objects inside are reachable.

I gave up on that approach for now, but I am honestly not
certain if it's fully a dead end or not.

Feedback requested
------------------

I am primarily interested in feedback on whether this problem
is worth solving and if the proposed solution is going in the
right direction, but any useful insights or gotchas that break
the idea are of course appreciated.

I tried to keep this as high-level as possible and avoided
discussing some of the edge cases -- some of my earlier
email drafts were much too long and it was a struggle to
condense it. That said, I included an appendix to present
how my prototype handles those cases if anyone is curious.

Thanks,
Kristofer


Appendix: special cases
-----------------------

Non-commit tips: tags are peeled iteratively until reaching
a non-tag object.  Blob tips are verified for existence by
the peel step itself.  Tree tips get full closure verification
(no parent diff, since there is no parent commit to diff
against).  This is correct but not optimized -- and tree tips
are uncommon in practice (I think).

Shallow clones: when a temporary shallow file is in effect,
the listed commits are treated as roots with no parents.
Their trees get full closure verification rather than a
parent diff.  The parent-diff heuristic only applies above
the shallow boundary, which is where incoming commits are in
practice.

Deepening fetches: the entire deepened ancestry becomes
candidates, so there is no small incoming set to optimize
for.  The implementation falls back to the current rev-list
path to avoid the memory overhead of tracking millions of
candidate commits in-process.  This could be optimized later
if needed.

Promisor remotes: the existing fast path that checks whether
all wanted tips are present in promisor packs runs first,
unchanged.  If that fast path does not cover all tips, the
optimized verification path accepts any missing object
(tree, blob, or tag target) that is a promisor object,
matching the --exclude-promisor-objects semantics.

Replace objects: the optimized path assumes the physical
commit graph is acyclic.  Replace objects can violate that, so
the implementation falls back to the current rev-list path
when any replace objects are configured.


[1] https://lore.kernel.org/git/cover.1621451532.git.ps@pks.im/
    (Speed up connectivity checks via quarantine dir,
    Patrick Steinhardt, 2021)
[2] https://lore.kernel.org/git/20250507030249.4802-1-jltobler@gmail.com/
    (builtin/receive-pack: introduce option to skip connectivity checks,
    Justin Tobler, 2025)
