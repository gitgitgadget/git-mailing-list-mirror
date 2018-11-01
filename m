Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDABD1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 12:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeKAVab (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 17:30:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33468 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbeKAVaa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 17:30:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id f19-v6so981075wmb.0
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 05:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=mS2uHkrWIkD7fmpLQjIdz5f7/BP11CAUm19NMHIOaW4=;
        b=gd3Sk1qEpvZ4T6ATDnr4M8iajQH+xn+/AaEN3C1sk8g/+NBONp/JIJNqEnhqaE8I56
         taW4IBY4X116ysCuC60ZOlKqry5Or26GrN7jiOvQ1smoKgsWL2Ry/HXCbgSc0O36NLQI
         Pdb8h57Dt2HERxlT9qgFHb2GXA3TrrShPgl36gZxB90zFiwIKC31rT9r6O3nVH/PKGe+
         6nSN/2ZuTjbEMI93xv0Jf7H+r0dqt/OfV3gEpRGFmI9iBgOXFTME2hRqES6/tIbujKGl
         Gyf6J4fsm4Z8f/h/O+n3qg2JPyvqg6uxkgNUfTNvZQ4lyLj0qhrsEILCwz7RSXjXOlJq
         A2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=mS2uHkrWIkD7fmpLQjIdz5f7/BP11CAUm19NMHIOaW4=;
        b=KyEMbce5X/tecAezlQUnd51M0FTK++ZU1F+cRCaYBZE9+QmWXY8NUWedogKyi1Xo7d
         ecwNcxBgOXQ2eeDf/u22gDmupsYr+ld0GLhAcqP60Z4aGCQy80Ph2oL9Yvczlx7IxAoD
         7PGP3PvfQx9cGqL+EvmCxl2tUXs8ulBYfehjy1TEwkgM4+DpccBUFNXCj0PtAIPq5d4s
         aSFwtsrzPH2Q0DeKxhiqlRZhJ+d4aGzAIMpOOK+gd5KaLVLeq8o+5qR6mAnhV8wunXV8
         C2MhPrNYaKnVUUs/Cmfq8Nn/lSLvpACGrOx4r3MajS3ROHoT9JYcRZ+H+gq2PfaaweTB
         BYGQ==
X-Gm-Message-State: AGRZ1gL30D5Ok89u0m3ZOAm2w8UOc9jG4OmQiiiDBhPC9CkzWYYrHk/F
        sL4Se6EWpcay27vr6y3PjIM=
X-Google-Smtp-Source: AJdET5dUqmyALLZcwNYLb5+e+DY5MPq7YTgdwY4k03JxH5zAejYMgPVWZxv5QHb9qL3Ype+rh1YO8w==
X-Received: by 2002:a1c:150d:: with SMTP id 13-v6mr5539478wmv.24.1541075259511;
        Thu, 01 Nov 2018 05:27:39 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (end24.neoplus.adsl.tpnet.pl. [83.21.249.24])
        by smtp.gmail.com with ESMTPSA id 4-v6sm27130144wrk.52.2018.11.01.05.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 05:27:38 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Generation Number v2
References: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com>
Date:   Thu, 01 Nov 2018 13:27:30 +0100
In-Reply-To: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com> (Derrick
        Stolee's message of "Mon, 29 Oct 2018 12:55:33 -0400")
Message-ID: <86efc50yq5.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[I have noticed that in some places I wrote A..B instead of B..A.  Sorry
 about that]

Derrick Stolee <stolee@gmail.com> writes:

> We've discussed in several places how to improve upon generation
> numbers. This RFC is a report based on my investigation into a
> few new options, and how they compare for Git's purposes on
> several existing open-source repos.
>
> You can find this report and the associated test scripts at
> https://github.com/derrickstolee/gen-test.

Which use prototype test implementation from the `reach-perf` branch in
https://github.com/derrickstolee/git.

> I have some more work to do in order to make this fully
> reproducible (including a single script to clone all of the
> repos I used, compute the commit-graphs using the different
> index versions, and run the tests).
>
> TL;DR: I recommend we pursue one of the following two options:
>
> 1. Maximum Generation Number.
> 2. Corrected Commit Date.
>
> Each of these perform well, but have different implementation
> drawbacks. I'd like to hear what everyone thinks about those
> drawbacks.

I agree with Junio that incremental computation is more important than
backwards compatibility (that the old clients can work with the new
commit-graph without changes).  We would have compatibility breaking
anyway with the planned move from SHA-1 to NewHash aka. SHA-256.

> Please also let me know about any additional tests that I could
> run. Now that I've got a lot of test scripts built up, I can re-run
> the test suite pretty quickly.

I would add straighforward 1-to-N and N-to-1 reachability tests in the
form of `git branch / tag --contains` and `git branch / tag --merged`,
and perhaps also ahead-behind calculations used by `git status`, and
N-to-M reachability tests used by tag following code in push and fetch.

Possibly also A...B walk, if it is not implemented via calculating
merge-base.

Maybe even --ancestry-path walk, though I am not sure how important best
performance for rhis case is (we would want good performance, but
perhaps best is not needed for rarely used command).

See explanation below.


> Generation Number Performance Test
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Git uses the commit history to answer many basic questions, such as
> computing a merge-base. Some of these algorithms can benefit from a
> _reachability index_, which is a condition that allows us to answer
> "commit A cannot reach commit B" in some cases. These require pre-
> computing some values that we can load and use at run-time. Git
> already has a notion of _generation number_, stores it in the commit-
> graph file, and uses it in several reachability algorithms.

Note that there are other kinds of reachability indices.

First, there are reachability indices that can answer the full
reachability query (if commit A can reach commit B, or if commit A
cannot reach commit B) directly, without walking the commit graph at
all: so called label-only approach.  For example one could store for
each commit the compressed list of all commits reachable from it
(transitive closure compression).

Those, I think (but I have not checked), would be of not much use for
Git, as the size of the index grows stronger than linear with the number
of commits, as grows the time to compute such index.  So probably of no
use to Git, at least not directly (Git uses so called "bitmap index",
see e.g. [1], which stores reachability bit-vector as compressed
bitmap... but not for all commits, only for a small subset).


Second, beside negative-cut reachability indexes, that can answer with
certainity that "commit A cannot reach commit B", like the generation
numbers (also known as level, or topological level), there also
positive-cut indexes (usually if not always based on the spanning tree
or trees for the DAG), that can answer when "commit A can reach commit
B".

I think that those can lead to significant speedups for at least some
types of commit traversal and reachability queries that Git needs to
answer.  But currently no algorithms has a provision for using
positive-cut filter index.  Anyway, such index would be auxiliary thing,
see the next point.


Third, we require more than having reachability index in the sense of
having some kind of _labelling_, often composite, that can answer either
"commit A cannot reach commit B" or "commit A can reach commit B",
depending on the type.  Git for most operations needs more, namely an
actual _ordering_, that is a weak order (or to be more exact a total
preorder, i.e. there can be two different commits with the same
"generation number" or index, but always either idx(A) =E2=89=B2 idx(B) or
idx(B) =E2=89=B2 idx(A)) and not only partial ordering (where there can be
incomparable elements, i.e neither idx(A) =E2=89=BC idx(B) nor idx(B) =E2=
=89=BC idx(A)).
This is because it needs to be used in priority queue to decide which
commit to travel next; more on that later.  This is also why there can
be only one such "main" reachability _index_.

[1]: https://githubengineering.com/counting-objects/

> You can read more about generation numbers and how to use them in
> algorithms in [this blog
> post](https://blogs.msdn.microsoft.com/devops/2018/07/09/supercharging-th=
e-git-commit-graph-iii-generations/).
>
> However, [generation numbers do not always improve our
> algorithms](https://public-inbox.org/git/pull.28.git.gitgitgadget@gmail.c=
om/T/#u).
> Specifically, some algorithms in Git already use commit date as a
> heuristic reachability index. This has some problems, though, since
> commit date can be incorrect for several reasons (clock skew between
> machines, purposefully setting GIT_COMMIT_DATE to the author date,
> etc.).

That's what we use the "slop" mechanism for: Git would walk a few
commits more than necessary than if there were no clock skew (if commit
dates were monotonic), and assume that the skew is not to severe to
finish early.

But as we are adding more early termination condition, this introduces
more places where things can go wrong for Git to return incorrect
results.  Thus the need for strict, non-heuristic reachability index.

> However, the speed boost by using commit date as a cutoff was so
> important in these cases, that the potential for incorrect answers was
> considered acceptable.

Yes, and there were few places where date as cutoff was used; we have
since added more place where generation number / reachbility index is
used as cutoff.  Thus more potential for incorrect answers if using
heuristics.

> When these algorithms were converted to use generation numbers, we
> _added_ the extra constraint that the algorithms are _never incorrect_.

Right.

> Unfortunately, this led to some cases where performance was worse than
> before. There are known cases where `git merge-base A B` or
> `git log --topo-order A..B` are worse when using generation numbers
> than when using commit dates.

In Git there are at least four different types of graph traversal
queries, with somewhat different requirements, and affected differently
by various reachability indexes.


## Pure reachability queries

First there are pure reachability queries, when we are interested only
in nswering he question whether commit A can reach commit B or not.  We
are nt interested in list of commits between A and B; if reachability
index, be it negative-cut or positive-cut, can answer the question, it
is all we need.  If we need to walk (perform online search), then we are
interested in just being able to arrive; we need to walk only one path.

This query can be performed one-to-one, one-to-many (which of commits
from the list can be reached from commit A), many-to-one (which commits
from the list can reach commit B), and many-to-many -- the latest for
example with recently added get_reachable_subset().

These types of queries are done by "git branch --contains" (and
"--no-contains") and "git branch --merged" (and "--no-merged"), the same
for "git tag"; if I remember it correctly those were among first
operations that were sped up by commit-graph mechanism.  Many-to-many
queries are done for tag following in "git push" and "git fetch".

Note that those queries are missing from gen-test.


## Topological ordering

Here reachability index is used to find out in-degree of considered
commits (starting from a set of starting points).  Here we don't really
need to walk all paths, but we need to walk all possible ways of
arriving at given commit.

Though I guess the [new] incremental algorithm could be modified to only
check for in-degree being zero or non-zero.  Would it make it slower or
faster; I guess in absence of good positive-cut reachability filter it
would make it slower.

This operation is benchmarked both standalone i.e. `git log --topo-order -N`
and in combination with A..B walk in `git log --topo-order -10 A..B`.


## (Po)set difference, or B..A range

In this type of query, with at least one "negative" / "negated" commit,
we want to find out all commits that are reachable from commit A that
are not reachable from commit B.

Note that A (commit in positive set) is treated differently with respect
to traversal from B (commit in negative set).  We need to travel (and
possibly list) all paths from A, while when traveling from B the only
thing important is reachability, not the actual path or paths.  We want
to travel as few commits as possible when walking from B, and here one
generation numbers are better than the other in the presence of multiple
paths.

The situation in nontrivial case could look as follows:

  ---.---.---o---*---*---*----*---*-----*---A
              \
               \---x-----x-----x-----B

In such case, the algorithm paints down from positive set i.e. commit A,
and from negative set i.e. commit B, and walk down from A till we get to
commits painted down from B.

We want to walk those commits somewhat in sync, using priority-queue
based variant of breadth-first search (well, kind of), so that we don't
walk more commits from A than necessary, only to notice later that these
are actually reachable from B, and neither we want to walk more commits
from B than necessary, going past the boundary commit.

Sidenote: I think that positive-cut auxiliary reachability index
(reachability filter) can help speed up this operation, making it
possible to mark commit as reachable from the negative set (from commit
B) and stop early without actually having to walk from B... though the
more in sync walks from A and B would be, the less it would probably
help.

This is tested using `git log --topo-order -10 A..B`.


## Merge base, and A...B walk

In this case we either find one or all commits that are reachable from
both A and B, or (which is related query) find all commits reachable
from A that are not reachable from B and vice versa, that is all commits
reachable from B that are not reachable from A.

In this case we walk from both A and B the same way: the operation is
symmetric.  In the merge base calculations we need to walk only one path
if there are many equivaent ones; in A...B walk we have to actually walk
them.  Thus merge base calculation would exhibit, we can concurr, the
same behaviour with respect to reachability indexes as A..B case.

This is tested using `git merge-base A B`; finding all merge bases, and
A...B walk are not tested yet.

Note that IIRC it was merge-base calculation where the problem of
performance regression when using generation number (topological level)
as an ordering was first encountered.  The performance regression happen
for situation like this (the graph is taken from original commit fixing
the issue, just rephrased).

   0   1   2   3   4   5   6   7   8   9  10   11          4    =CE=B4gen(c)
   .---M---*---*---*---*---*---*---*---*--*----A           B
       |\                                  2  /           /     =CE=B4gen(c)
       | \---------------------------------x-/           /
       \                                  2         3   /       =CE=B4gen(c)
        \---------------------------------#---------#--/


    ------------------------------------------------------------>
                                                          time

Here optimal solution would be walk the branch / path with commits
marked with 'x' from commit A, while walking the branch / path with
commits marked '#' from commit B, and after walking 4 commits notice
that the commit M is reachable from both A and B -- thus we have found
[one of] the merge base.

Using (minimum) generation numbers we would walk the path marked with
'*' first, unnecessarily.  (IIUC that for a commit we mark also its
parents, isn't it?).

Using corrected commit date we would walk at most only a few commits on
the *-marked branch.

   0   1   2   3   4   5   6   7   8   9  10   11          11   =CE=B4maxge=
n(c)
   .---M---*---*---*---*---*---*---*---*--*----A           B
       |\                                  10 /           /     =CE=B4maxge=
n(c)
       | \---------------------------------x-/           /
       \                                  9         10  /       =CE=B4maxge=
n(c)
        \---------------------------------#---------#--/


    ------------------------------------------------------------>
                                                          time

Using maximum generation numbers we would also walk at most few *-marked
commits.

Sidenote: on the figure below you can easily see easy correspondence
between maxgen(c) and revgen(c) indices, see below.

   12  11  10  9   8   7   6   5   4   3  2    1           1    revgen(c)
   .---M---*---*---*---*---*---*---*---*--*----A           B
       |\                                  2  /           /     revgen(c)
       | \---------------------------------x-/           /
       \                                  3         2   /       revgen(c)
        \---------------------------------#---------#--/


## Strict ancestry, or ancestry path

When given a range of commits to display (e.g. A..B), only display
commits that exist directly on the ancestry chain between B and A,
i.e. commits that are both descendants of B, and ancestors of A.  In
other words, find all paths from B to A (if they exist).

In this case we want to walk all the paths, heavily pruning.  This
should be less dependent on reachability index quality as an index (as
an ordering), and more on pruning ability of the filter.

This case is not tested in gen-test, but I wonder how often this feature
is actualy used (if it would be worth adding it to the benchmark, and if
so, with what weight behind it).


> This report investigates four replacements for generation numbers, and
> compares the number of walked commits to the existing algorithms (both
> using generation numbers and not using them at all). We can use this
> data to make decisions for the future of the feature.
>
> ### Implementation
>
> The reachability indexes below are implemented in
> [the `reach-perf` branch in
> https://github.com/derrickstolee/git](https://github.com/derrickstolee/gi=
t/tree/reach-perf).
> This implementation is in a very rough condition, as it is intended to
> be a prototype, not production-quality.
>
> Using this implementation, you can compute commit-graph files for the
> specified reachability index using `git commit-graph write --reachable
> --version=3D<V>`.
> The `git` client will read the version from the file, so our tests
> store each version as `.git/objects/info/commit-graph.<V>` and copy
> the necessary file to `.git/objects/info/commit-graph` before testing.
>
> The algorithms count the number of commits walked, as to avoid the
> noise that would occur with time-based performance reporting. We use
> the (in progress) trace2 library for this. To find the values reported,
> use the `GIT_TR2_PERFORMANCE` environment variable.

Where we can read more about this trace2 library?  Thanks in advance.

>
> To ignore reachability indexes entirely and use the old algorithms
> (reported here as "OLD" values) use the environment variable
> `GIT_TEST_OLD_PAINT=3D1`.
>
>
> Reachability Index Versions
> ---------------------------
>
> **V0: (Minimum) Generation Number.**
> The _generation number_ of a commit is exactly one more than the maximum
> generation number of a parent (by convention, the generation number of a
> commit with no parents is 1). This is the definition currently used by
> Git (2.19.0 and later). Given two commits A and B, we can then use the
> following reachability index:
>
> =C2=A0=C2=A0=C2=A0 If gen(A) < gen(B), then A cannot reach B.
>
> _Commentary:_ One issue with generation numbers is that some algorithms
> in Git use commit date as a heuristic, and allow incorrect answers if
> there is enough clock skew. Using that heuristic, the algorithms can walk
> fewer commits than the algorithms using generation number. The other
> reachability indexes introduced below attempt to fix this problem.

This is the existing solution.

> **V1: (Epoch, Date) Pairs.**
> For each commit, store a pair of values called the _epoch_ and the _date_.
> The date is the normal commit date. The _epoch_ of a commit is the minimum
> X such that X is at least the maximum epoch of each parent, and at least
> one more than the epoch of any parent whose date is larger than the date
> of this commit (i.e. there is clock skew between this commit and this
> parent). In this way, we can use the following reachability index:
>
> =C2=A0=C2=A0 If epoch(A) < epoch(B), then A cannot reach B.
> =C2=A0=C2=A0 If epoch(A) =3D=3D epoch(B) and date(A) < date(B), then A ca=
nnot reach B.

I wonder what makes it perform worse than corrected date aka V3.

> **V2: Maximum Generation Numbers.**
> The _maximum generation number_ of a commit (denoted by maxgen(A)) is
> defined using its _children_ and the total number of commits in the repo.
> If A is a commit with no children (that is, there is no commit B with
> A as a parent) then maxgen(A) is equal to the number of commits in the re=
po.
> For all other commits A, maxgen(A) is one less than the minimum maxgen(B)
> among children B. This can be computed by initializing maxgen(C) to the
> number of commits, then walking the commit graph in topological order,
> assigning maxgen(P) =3D min { maxgen(P), maxgen(C) - 1 } for each parent P
> of the currently-walking commit C. We then have the same reachability
> index as minimum generation number:
>
> =C2=A0 If maxgen(A) < maxgen(B), then A cannot reach B.

If I understand it correctly, this is the same as reverse generation
numbers, or reverse topological levels; in other words genertion numbers
on reversed graph -- only transformed:

   maxgen(A) =3D=3D number_of_commits - (revgen(A) - 1)

We define revgen(A) in the following way:
- for head tips (for source nodes), i.e. commits with in-degree of 0,
  with no children, have revgen(A) =3D 1 (revgen(A) =3D 0 is left for
  commits outside commit-graph, which translates to INFINITY for
  maxgen(A)).
- otherwise, it is 1 more than maximum revgen(C) of its children

They are equivalent, but maxgen(A) is "backward compatibile", that is
the rechability condition is exactly the same as for ordinary generation
numbers:

=C2=A0=C2=A0=C2=A0 If gen(A) < gen(B), then A cannot reach B.
=C2=A0=C2=A0=C2=A0 If maxgen(A) < maxgen(B), then A cannot reach B.

But

=C2=A0=C2=A0=C2=A0 If revgen(A) > revgen(B), then A cannot reach B.

>
> _Commentary:_ The known examples where (minimum) generation numbers perfo=
rm
> worse than commit date heuristics involve commits with recent commit dates
> but whose parents have very low generation number compared to most recent
> commits. In a way, minimum generation numbers increase the odds that we
> can say "A cannot reach B" when A is fixed and B is selected at random.
> Maximum generation numbers increase the odds that we can say "A cannot
> reach B" when B is fixed and A is selected at random. This helps us when
> we are exploring during a reachability algorithm and have explored few
> commits and want to say that the large set of unexplored commits cannot
> reach any of the explored commits.

I guess that the situation where shortcut path have recent date, while
having less commits in path (and thus lover ordinary generation number)
is more common in real commit graphs because one might want to base a
commit (for example a bugfix) on an old commit, but commits usually get
merged quickly, and not left for long time.  If they re left for long
time, they usually needs correction (via rebase) before being merged,
and again we have commit with date close to the date of merge, leading
to a shortcut.

Does this reasoning looks correct to you?

> **V3: Corrected Commit Date.**
> For a commit C, let its _corrected commit date_ (denoted by cdate(C))
> be the maximum of the commit date of C and the [corrected] commit dates o=
f its
> parents.

Wouldn't it be better to use the maximum of the commit date of C, and
one second more than the corrected commit dates of its parents?  This
way corrected dates would be strictly monotonic along the chain.

Sidenote: in theory, sufficiently bad clock skew (like e.g. wrong year
in the future) could screw large swatches of the commit graph.  In
practice, in real-life repositories, this doesn't happen, I guess.

> =C2=A0 If cdate(A) < cdate(B), then A cannot reach B.
>
> **V4: FELINE Index.**
> The FELINE index is a two-dimentional reachability index as defined in
> [Reachability Queries in Very Large Graphs: A Fast Refined Online
> Search Approach](https://openproceedings.org/EDBT/2014/paper_166.pdf)
> by Veloso, Cerf, Jeira, and Zaki. The index is not deterministically
> defined, but instead is defined in the following way:
>
> 1. Compute a reverse topological order of the commits. Let felineX(C)
> =C2=A0=C2=A0 be the position in which C appears in this list. Since this =
is
> =C2=A0=C2=A0 a reverse topological order, felineX(C) > felineX(P) for eac=
h parent
> =C2=A0=C2=A0 P of C.

Well, it depends on the definition of the topological order if it is
tolopogical order or reverse topological order.  Anyway, the FELINE
paper includes discussion about FELINE-I, i.e. inversed feline index.
From FELINE and FELINE-I, one of those is what was used here.

> 2. Compute a reverse topological order of the commits using Kahn's
> =C2=A0=C2=A0 algorithm, but when selecting among a list of commits with i=
n-degree
> =C2=A0=C2=A0 zero, prioritize the commit by minimizing felineX. Let felin=
eY(C)
> =C2=A0=C2=A0 be the position in which C appears in this list.

Note that the second step, as given in the paper, is actually
deterministic (assuming that we follow the recommendations; well, up to
a point).  It needs some topological order for felineX, though.

> Essentially, the felineY order is selected with the goal of swapping
> positions of topologically-independent commits relative to the felinX
> ordering. The resulting reachability index is as follows:
>
> =C2=A0=C2=A0 If felineX(A) < felineX(B), then A cannot reach B.
> =C2=A0=C2=A0 If felineY(A) < felineY(B), then A cannot reach B.
>
> _Commentary:_ In terms of comparing two commits directly, this index
> is quite strong. However, when we are performing our reachability
> algorithms that care about reachable sets (git log --graph), or
> boundaries between reachable sets (git merge-base, git log --graph A..B)
> we need to track a single pair (minX,minY) for comparion. In order to not
> miss anything during our search, we need to update this pair to be
> the minimum felineX(A) and minimum felineY(B) among all explored commits
> A and B. That is, the pair (minX, minY) is below our entire explored set.
> This can be a disadvantage for these algorithms.

Actually the problem is that FELINE index is partial order, not an
ordering; not something that we can use in a priority queue.

But the single [reverse] topological ordering is a reachability index in
itself, and it is an ordering.  Thus we can use felineX as an index in
priority queue (or we can use felineY).

One thing to notice is that FELINE index performs well on real world
large graphs which have quite different structure from commit graphs;
among others they have either very large number of sources (head tips)
or sinks (root nodes), or both; those numbers grow with the number of
nodes.  For commit graphs they don't perform as well; well, at least
ccording to my explorations on that matter in the Google Colaboratory
notebook [2].

[2]: https://colab.research.google.com/drive/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5x=
yzg

>
> ### Comparing Reachability Index Versions Viability
>
> Before considering how well these indexes perform during our algorithm
> runs, let's take a moment to consider the implementation details and
> how they relate to the existing commit-graph file format and existing
> Git clients.
>
> * **Compatible?** In our test implementation, we use a previously unused
> =C2=A0 byte of data in the commit-graph format to indicate which reachabi=
lity
> =C2=A0 index version we are using. Existing clients ignore this value, so=
 we
> =C2=A0 will want to consider if these new indexes are _backwards compatib=
le_.
> =C2=A0 That is, will they still report correct values if they ignore this=
 byte
> =C2=A0 and use the generation number column from the commit-graph file as=
suming
> =C2=A0 the values are minimum generation numbers?

In other words "backward compatibility" for a reachability index means
that the reachability condition is exactly the same as it was:

=C2=A0=C2=A0=C2=A0 If index(A) < index(B), then A cannot reach B.

and also values of the reachability index are written in place of
generation numbers in the commit-graph.

>
> * **Immutable?** Git objects are _immutable_. If you change an object you
> =C2=A0 actually create a new object with a new object ID. Are the values =
we
> =C2=A0 store for these reachability indexes also immutable?
>
> * **Local?** Are these values **locally computable**? That is, do we only
> =C2=A0 need to look at the parents of a commit (assuming those parents ha=
ve
> =C2=A0 computed values) in order to determine the value at that commit?

Those two features imply that the number of commits that we need to walk
to be able to update reachability index after appending new commits is
O(new commits), which means O(changes).  I would allow for simple
transformations of other values, e.g. adding a constant; we need to
rewrite commit-graph file anyway.

I wonder if there are reachability indexes that are either immutable but
not local, or not immutable but local.  Doesn't being local imply
immutability, with some common-sense assumptions (like no random choice
for parent-less commits)?

> | Index=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Compatible? | Immu=
table? | Local? |
> |---------------------------|-------------|------------|--------|
> | Minimum Generation Number | Yes=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | Yes=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Yes=C2=A0=C2=A0=
=C2=A0 |
> | (Epoch, Date) pairs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Yes=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Yes=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | Yes=C2=A0=C2=A0=C2=A0 |
> | Maximum Generation Number | Yes=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | No=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | No=C2=A0=
=C2=A0=C2=A0=C2=A0 |
> | Corrected Commit Date=C2=A0=C2=A0=C2=A0=C2=A0 | No=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Yes=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | Yes=C2=A0=C2=A0=C2=A0 |
> | FELINE index=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | Yes=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | No=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | No=C2=A0=C2=A0=C2=
=A0=C2=A0 |
>
> _Note:_ The corrected commit date uses the generation number column
> to store an offset of "how much do I need to add to my commit date
> to get my corrected commit date?" The values stored in that column
> are then not backwards-compatible.

Additional note: this offset / delta based approach to storing corrected
commit data is a form of lightweight compression, allowing it to fit
safely in 30 bits (while the commit date uses 32+2 =3D 34 bits itself).

Assuming that we want to keep this feature from the original
commit-graph file format, that is.

> _Note:_ The FELINE index requires storing two values instead of just
> one. One of these values could be stored in the generation number
> column and the other in an optional chunk, hence it could be backwards
> compatible. (This is not how it is implemented in our example
> implementation.)

So the table above refers to this hypothetical implementation when
stating that FELINE is backwards compatibile, but current test
implementation is not, isn't it?

>
> Data
> ----
>
> We focused on three types of performance tests that test the indexes
> in different ways. Each test lists the `git` command that is used,
> and the table lists which repository is used and which inputs.
>
> ### Test 1: `git log --topo-order -N`
>
> This test focuses on the number of commits that are parsed during
> a `git log --topo-order` before writing `N` commits to output.
>
> You can reproduce this test using `topo-order-tests.sh` and
> see all the data in `topo-order-summary.txt`. The values reported
> here are a sampling of the data, ignoring tests where all values
> were the same or extremely close in value.
>
>
> | Repo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | N=C2=A0=C2=A0=C2=
=A0=C2=A0 | V0=C2=A0=C2=A0=C2=A0=C2=A0 | V1=C2=A0=C2=A0=C2=A0=C2=A0 | V2=C2=
=A0=C2=A0=C2=A0=C2=A0 | V3=C2=A0=C2=A0=C2=A0=C2=A0 | V4=C2=A0=C2=A0=C2=A0 |
> |--------------|-------|--------|--------|--------|--------|-------|
> | android-base | 100=C2=A0=C2=A0 |=C2=A0 5,487 |=C2=A0 8,534 |=C2=A0 6,93=
7 |=C2=A0 6,419 | 6,453 |
> | android-base | 1000=C2=A0 | 36,029 | 44,030 | 41,493 | 41,206 |45,431 |
> | chromium=C2=A0=C2=A0=C2=A0=C2=A0 | 100=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 =
101 |424,406 |=C2=A0=C2=A0=C2=A0 101 |=C2=A0=C2=A0=C2=A0 101 |=C2=A0=C2=A0 =
101 |
> | gerrit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 100=C2=A0=C2=A0 |=C2=A0 8,=
212 |=C2=A0 8,533 |=C2=A0=C2=A0=C2=A0 164 |=C2=A0=C2=A0=C2=A0 159 |=C2=A0=
=C2=A0 162 |
> | gerrit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1000=C2=A0 |=C2=A0 8,512 |=
=C2=A0 8,533 |=C2=A0 1,990 |=C2=A0 1,973 | 3,766 |
> | Linux=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 100=C2=A0=C2=A0 | 12,=
458 | 12,444 | 13,683 | 13,123 |13,124 |
> | Linux=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1000=C2=A0 | 24,436 |=
 26,247 | 27,878 | 26,430 |27,875 |
> | Linux=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10000 | 30,364 | 28,8=
91 | 27,878 | 26,430 |27,875 |
> | electron=C2=A0=C2=A0=C2=A0=C2=A0 | 1000=C2=A0 | 19,927 | 18,733 |=C2=A0=
 1,072 | 18,214 |18,214 |
> | Ffmpeg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10000 | 32,154 | 47,429 | =
10,435 | 11,054 |11,054 |
> | jgit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1000=C2=A0 |=C2=
=A0 1,550 |=C2=A0 6,264 |=C2=A0 1,067 |=C2=A0 1,060 | 1,233 |
> | julia=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10000 | 43,043 | 43,0=
43 | 10,201 | 23,505 |23,828 |
> | odoo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1000=C2=A0 | 17,=
175 |=C2=A0 9,714 |=C2=A0 4,043 |=C2=A0 4,046 | 4,111 |
> | php-src=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1000=C2=A0 | 19,014 | 27,530 |=
=C2=A0 1,311 |=C2=A0 1,305 | 1,320 |
> | rails=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 100=C2=A0=C2=A0 |=C2=
=A0 1,420 |=C2=A0 2,041 |=C2=A0 1,757 |=C2=A0 1,428 | 1,441 |
> | rails=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1000=C2=A0 |=C2=A0 7,=
952 | 10,145 | 10,053 |=C2=A0 8,373 | 8,373 |
> | swift=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1000=C2=A0 |=C2=A0 1,=
914 |=C2=A0 4,004 |=C2=A0 2,071 |=C2=A0 1,939 | 1,940 |
> | tensorflow=C2=A0=C2=A0 | 1000=C2=A0 | 10,019 | 39,221 |=C2=A0 6,711 | 1=
0,051 |10,051 |
> | TypeScript=C2=A0=C2=A0 | 1000=C2=A0 |=C2=A0 2,873 | 12,014 |=C2=A0 3,04=
9 |=C2=A0 2,876 | 2,876 |

Do I understand it correctly that the range of N for a given project is
limited by the depth of the project history (hence maximum N of 10000
for Linux kernel, but only 100 for chromium)?

I wonder what the OLD numbers are for these operations.

>
> ### Test 2: `git log --topo-order -10 A..B`
>
> This test focuses on the number of commits that are parsed during
> a `git log --topo-order A..B` before writing ten commits to output.
> Since we fix a very small set of output commits, we care more about
> the part of the walk that determines which commits are reachable
> from `B` but not reachable from `A`. This part of the walk uses
> commit date as a heuristic in the existing implementation.
[...]

> ### Test 3: `git merge-base A B`
>
> This test focuses on the number of commits that are parsed during
> a `git merge-base A B`. This part of the walk uses commit date as
> a heuristic in the existing implementation.
[...]

> Conclusions
> -----------
>
> Based on the performance results alone, we should remove minimum
> generation numbers, (epoch, date) pairs, and FELINE index from
> consideration. There are enough examples of these indexes performing
> poorly.
>
> In contrast, maximum generation numbers and corrected commit
> dates both performed quite well. They are frequently the top
> two performing indexes, and rarely significantly different.
>
> The trade-off here now seems to be: which _property_ is more important,
> locally-computable or backwards-compatible?
>
> * Maximum generation number is backwards-compatible but not
> =C2=A0 locally-computable or immutable.
>
> * Corrected commit-date is locally-computable and immutable,
> =C2=A0 but not backwards-compatible.
>
> _Editor's Note:_ Every time I think about this trade-off, I can't
> come to a hard conclusion about which is better. Instead, I'll
> leave that up for discussion.

In my opinion being able to update commit-graph data fast is more
important than being backward-compatibile, i.e. beig able to use
commit-data file generated by new clients (and servers) by old clients.


Thank you for all your work,
--
Jakub Nar=C4=99bski
