Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325421F424
	for <e@80x24.org>; Sun,  8 Apr 2018 11:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeDHLGg (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 07:06:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53970 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbeDHLGe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 07:06:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id 66so5522415wmd.3
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 04:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=DgWSM/CjNO+5DIn/indPs6dz1tzTH8Btex9Xo/1g1Yw=;
        b=eyUdlCnTLMq27WQIVzkgHhJVNJqq13DcfdsrdApB165VotWWHvCfPvMx25Y87lJvnC
         Wbn4Q3X2w+GHoyZbhmL8/4C6I1hpoYKkh6lNfItTr8zU+mUnBEN734jcpiONky38wkya
         XUuyeaK9WxPnXcU1s+FwOoVzVXslIol0AukCTyVrbinl4/yIHEEAEXyCoO1PVSa6NLc4
         XBOZyHa2mRLX17nwRVZxppXUXec34mUKX4PGzfitdWaO6fzbegV8Pp7Q0v70fMgLPTJy
         o3nIE7WvEQ40H1vN1/IKbisqPd6jidBGjPEUWEcGnpdTuiQ7pLvoebDmpxkA7eyxClEP
         bBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=DgWSM/CjNO+5DIn/indPs6dz1tzTH8Btex9Xo/1g1Yw=;
        b=YTmeGmQS1KD0iXx2mygd0ZUOXApuWI76FuzIA3PmXB6oa8hcfJXyumZTeO1dj1W4Pj
         zLOHaKh74EKRUCK48vqklU06kB90SXtJRk7TYUJdGrgpnhkFnlWuCJW+QKcNb055vjgI
         LKmGuf2AWTed36cv1N0959wb4vF3PgSeHYpP9gAQLJbP3NTcRwwpGLXVtorGfgpfvy6Y
         ihILWkAw3kh+UjqHAz8aM2bAMpJwXaTS8dqKcqIozpDVMYya5f/TLiteyinQSSisaPhp
         qcMJDnYBa0Nt6gkkZgogaFwj+oKkj5JrqvowURRXo/jFhOoOeAovFh9FH4y429GAfZfM
         YsrQ==
X-Gm-Message-State: AElRT7Gu/ZpQqYDDMZDRNY9HTsR0zqgcxM2z3z6qmR1VPRKcMX1V5wfN
        +90FpZpBURy+kVJCQPwSMBw=
X-Google-Smtp-Source: AIpwx486uaAr7gjq+/aRpAf2id7J9pSuL3zhl3KVp7tBcp9O5l0EjTkt5KBw1OUBsPVgpcbJO3/uqQ==
X-Received: by 10.46.133.217 with SMTP id h25mr20183312ljj.109.1523185593275;
        Sun, 08 Apr 2018 04:06:33 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (aga121.neoplus.adsl.tpnet.pl. [83.25.156.121])
        by smtp.gmail.com with ESMTPSA id w73-v6sm2943844lfi.60.2018.04.08.04.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 04:06:32 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v7 04/14] graph: add commit graph design document
References: <20180314192736.70602-1-dstolee@microsoft.com>
        <20180402203427.170177-1-dstolee@microsoft.com>
        <20180402203427.170177-5-dstolee@microsoft.com>
Date:   Sun, 08 Apr 2018 13:06:29 +0200
In-Reply-To: <20180402203427.170177-5-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 2 Apr 2018 16:34:17 -0400")
Message-ID: <866052dkju.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Add Documentation/technical/commit-graph.txt with details of the planned
> commit graph feature, including future plans.

That's in my opinion a very good idea.  It would help anyone trying to
add to and extend this feature.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/commit-graph.txt | 163 +++++++++++++++++++++++
>  1 file changed, 163 insertions(+)
>  create mode 100644 Documentation/technical/commit-graph.txt
>
> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/tec=
hnical/commit-graph.txt
> new file mode 100644
> index 0000000000..0550c6d0dc
> --- /dev/null
> +++ b/Documentation/technical/commit-graph.txt
> @@ -0,0 +1,163 @@
> +Git Commit Graph Design Notes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +Git walks the commit graph for many reasons, including:
> +
> +1. Listing and filtering commit history.
> +2. Computing merge bases.
> +
> +These operations can become slow as the commit count grows. The merge
> +base calculation shows up in many user-facing commands, such as 'merge-b=
ase'
> +or 'status' and can take minutes to compute depending on history shape.
> +
> +There are two main costs here:
> +
> +1. Decompressing and parsing commits.
> +2. Walking the entire graph to satisfy topological order constraints.
> +
> +The commit graph file is a supplemental data structure that accelerates
> +commit graph walks. If a user downgrades or disables the 'core.commitGra=
ph'
> +config setting, then the existing ODB is sufficient.

This is a good explanation of why we want to have this, and why in this
form.  I really like the "Related links" with summary.

>                                                       The file is stored
> +as "commit-graph" either in the .git/objects/info directory or in the in=
fo
> +directory of an alternate.

That is a good thing.

Do I understand it correctly that Git would use first "commit-graph"
file that it would encounter, or would it merge information from all
alternates (including perhaps self)?  What if repository is a
subtree-merge of different repositories, with each listed separately as
alternate?

> +
> +The commit graph file stores the commit graph structure along with some
> +extra metadata to speed up graph walks. By listing commit OIDs in lexi-
> +cographic order, we can identify an integer position for each commit and
> +refer to the parents of a commit using those integer positions. We use
> +binary search to find initial commits and then use the integer positions
> +for fast lookups during the walk.

It might be worth emphasizing here that fast access using integer
positions for commits in the chunk is possible only if chunk used
fixed-width format (each commit taking the same amount of space -- which
for example is not true for packfile).

> +
> +A consumer may load the following info for a commit from the graph:
> +
> +1. The commit OID.
> +2. The list of parents, along with their integer position.
> +3. The commit date.
> +4. The root tree OID.
> +5. The generation number (see definition below).
> +
> +Values 1-4 satisfy the requirements of parse_commit_gently().

Good to have it here.  It is nice to know why 1-4 are needed to be in
the "commit-graph" structure.

Do I understand it correctly that this feature is what makes porting Git
to start using "commit-graph" information easy, because it is single
point of entry, isn't it?

> +
> +Define the "generation number" of a commit recursively as follows:
> +
> + * A commit with no parents (a root commit) has generation number one.
> +
> + * A commit with at least one parent has generation number one more than
> +   the largest generation number among its parents.
> +
> +Equivalently, the generation number of a commit A is one more than the
> +length of a longest path from A to a root commit. The recursive definiti=
on
> +is easier to use for computation and observing the following property:
> +
> +    If A and B are commits with generation numbers N and M, respectively,
> +    and N <=3D M, then A cannot reach B. That is, we know without search=
ing
> +    that B is not an ancestor of A because it is further from a root com=
mit
> +    than A.

Because generation numbers from the "commit-graph" may not cover all
commits (recent commits can have no generation number information), I
think it would be good idea to state what happens then.

Because of how generation numbers are defined, if commit A has
generation number provided, then all ancestors also have generation
number information.  Thus:

       If A is a commit with generation number N, and B is a commit
       without generation number information, then A cannot reach B.
       That is, we know without searching that B is not an ancestor of A
       because if it was, it would have generation number information.

Additionally (but that might be not worth adding here):

       If A is a commit without generation number information, and B is
       a commit with generation number M, then we walk till we get to
       commits with generation numbers, at which points the problem
       reduces to the first case.


Which I think (but it might be worth spelling out explicitly) is what
using "infinity" number for unknown generation number gives
automatically.

> +
> +    Conversely, when checking if A is an ancestor of B, then we only need
> +    to walk commits until all commits on the walk boundary have generati=
on
> +    number at most N. If we walk commits using a priority queue seeded by
> +    generation numbers, then we always expand the boundary commit with h=
ighest
> +    generation number and can easily detect the stopping condition.

Well, that is a bit information dense for me.  Let me unpack, and check
if I understand it correctly.

We have a priority queue, ordered by generation number:

* If it is min-order queue, where we can find commit on the walk
  boundary with lowest generation number, we can quickly discard those
  that cannot reach B because they have generation number smaller than
  M=3Dgen(B).

  If I understand it correctly, with this we would get shortest path, if
  it exists.
=20=20
* If it is max-order queue, we can quickly find if there is anything in
  the queue that can reach B: if maximum generation number in the
  priority queue is smaller than M=3Dgen(B), we can discard the whole
  queue and decide that B cannot be reached.

Which is it?


Sidenote: what makes the above possible is that generation numbers
(which are integers) are fully ordered: we have gen(A) < gen(B) or
gen(A) =3D gen(B), or gen(B) < gen(A).  This is not the case for FELINE
index (which is, similarly to generation number, a negative-cut filter),
neither for min-post spanning-tree intervals index (which is a
positive-cut filter).


To gather information about [some of] reachability helpers in one place,
let me put it here:

 - If A can reach B (if B is ancestor of A) and A !=3D B,
   then gen(B) < gen(A)

 - If A can reach B (if B is ancestor of A),
   then fel(A) =E2=89=BC fel(B),
   where fel(A) =3D (x_A, y_A), fel(B) =3D (x_B, y_B),
   and ((x_B, y_B) =E2=89=BC (x_B, y_B)) <=3D> (x_A <=3D x_B and y_A <=3D y=
_B)
   for NW [weak] dominance drawing

 + If interval(B) =E2=8A=86 interval(A),
   then A can reach B via spanning-tree path (B is ancestor of A)

> +
> +This property can be used to significantly reduce the time it takes to
> +walk commits and determine topological relationships. Without generation
> +numbers, the general heuristic is the following:
> +
> +    If A and B are commits with commit time X and Y, respectively, and
> +    X < Y, then A _probably_ cannot reach B.
> +
> +This heuristic is currently used whenever the computation is allowed to
> +violate topological relationships due to clock skew (such as "git log"
> +with default order), but is not used when the topological order is
> +required (such as merge base calculations, "git log --graph").

Doesn't Git have some kind of allowed clock skew, doesn't it have some
slop value for comparing timestamps?  Just for completeness.

This of course is not needed for generation numbers.

> +
> +In practice, we expect some commits to be created recently and not stored
> +in the commit graph. We can treat these commits as having "infinite"
> +generation number and walk until reaching commits with known generation
> +number.

Ah, so here is some of the information on what to do if commit A does
not have generation number information, or commit B does not have
generation number information, or both do not have it.

> +
> +Design Details
> +--------------
> +
> +- The commit graph file is stored in a file named 'commit-graph' in the
> +  .git/objects/info directory. This could be stored in the info directory
> +  of an alternate.

Note that this repeats some of information from above, which is not
necessarily a bad thing, but we need to take care to keep the two in
sync if we change either one.

> +
> +- The core.commitGraph config setting must be on to consume graph files.

This is similar to how it is done for bitmaps, with pack.useBitmaps.  We
would probably have separate settng for automatic creation and updating
of "commit-pack" files, isn't it?

> +
> +- The file format includes parameters for the object ID hash function,
> +  so a future change of hash algorithm does not require a change in form=
at.

That's a good thing.  As I understand the format uses ID hash for
addressing and for integrity check (the latter could in princible be
replaced by other fast to calculate and reliable checksum, like
e.g. CRC).

If I understand it you can port "commit-graph" file from one ID hash to
other without recalculating it, isn't it?  The only thing that is needed
is old-to-new mappings for commits and top trees.

> +
> +Future Work
> +-----------
> +
> +- The commit graph feature currently does not honor commit grafts. This =
can
> +  be remedied by duplicating or refactoring the current graft logic.

From what I remember there are actually three mechanisms that can affect
the way Git views history:
 * the [deprecated] grafts file
 * shallow clone, which is kind of grafts file
 * the git-replace feature (if it replaces commits with other commits
   with different parents)

All of those could change.  Also, one can request for Git to not honor
replacements, and cloning does not by default transfer replacement info.

We also need to clarify what "does not honor" means for _use_ of commit
graph feature (not only for _generation_ of it).  Does it mean that it
is disabled if any of those [rare] features are in use?


I think in the future we could add VAL4 / VALF chunk that would specify
for what contents of grafts, shallow and replaces the commit graph was
constructed.  If the value does not match, or if the repository has some
history-view-changing feature enabled that is not included in VAL4
chunk, then Git cannot use information in this file.  What are your
thoughts about this?

> +
> +- The 'commit-graph' subcommand does not have a "verify" mode that is
> +  necessary for integration with fsck.

This is still in the future, isn't it?

> +
> +- The file format includes room for precomputed generation numbers. These
> +  are not currently computed, so all generation numbers will be marked as
> +  0 (or "uncomputed"). A later patch will include this calculation.
> +
> +- After computing and storing generation numbers, we must make graph
> +  walks aware of generation numbers to gain the performance benefits they
> +  enable. This will mostly be accomplished by swapping a commit-date-ord=
ered
> +  priority queue with one ordered by generation number. The following
> +  operations are important candidates:
> +
> +    - paint_down_to_common()
> +    - 'log --topo-order'
> +
> +- Currently, parse_commit_gently() requires filling in the root tree
> +  object for a commit. This passes through lookup_tree() and consequently
> +  lookup_object(). Also, it calls lookup_commit() when loading the paren=
ts.
> +  These method calls check the ODB for object existence, even if the
> +  consumer does not need the content. For example, we do not need the
> +  tree contents when computing merge bases. Now that commit parsing is
> +  removed from the computation time, these lookup operations are the
> +  slowest operations keeping graph walks from being fast. Consider
> +  loading these objects without verifying their existence in the ODB and
> +  only loading them fully when consumers need them. Consider a method
> +  such as "ensure_tree_loaded(commit)" that fully loads a tree before
> +  using commit->tree.
> +
> +- The current design uses the 'commit-graph' subcommand to generate the =
graph.
> +  When this feature stabilizes enough to recommend to most users, we sho=
uld
> +  add automatic graph writes to common operations that create many commi=
ts.
> +  For example, one could compute a graph on 'clone', 'fetch', or 'repack'
> +  commands.

All of the above were sent as subsequent patch series, isn't it?

> +
> +- A server could provide a commit graph file as part of the network prot=
ocol
> +  to avoid extra calculations by clients. This feature is only of benefi=
t if
> +  the user is willing to trust the file, because verifying the file is c=
orrect
> +  is as hard as computing it from scratch.

VSTS / GVFS has it, isn't it?

> +
> +Related Links
> +-------------

I really like this, and especially the summary of each entry.

> +[0] https://bugs.chromium.org/p/git/issues/detail?id=3D8
> +    Chromium work item for: Serialized Commit Graph
> +
> +[1] https://public-inbox.org/git/20110713070517.GC18566@sigill.intra.pef=
f.net/
> +    An abandoned patch that introduced generation numbers.
> +
> +[2] https://public-inbox.org/git/20170908033403.q7e6dj7benasrjes@sigill.=
intra.peff.net/
> +    Discussion about generation numbers on commits and how they interact
> +    with fsck.
> +
> +[3] https://public-inbox.org/git/20170908034739.4op3w4f2ma5s65ku@sigill.=
intra.peff.net/
> +    More discussion about generation numbers and not storing them inside
> +    commit objects. A valuable quote:
> +
> +    "I think we should be moving more in the direction of keeping
> +     repo-local caches for optimizations. Reachability bitmaps have been
> +     a big performance win. I think we should be doing the same with our
> +     properties of commits. Not just generation numbers, but making it
> +     cheap to access the graph structure without zlib-inflating whole
> +     commit objects (i.e., packv4 or something like the "metapacks" I
> +     proposed a few years ago)."
> +
> +[4] https://public-inbox.org/git/20180108154822.54829-1-git@jeffhostetle=
r.com/T/#u
> +    A patch to remove the ahead-behind calculation from 'status'.

Thank you for all the work on this,
--=20
Jakub Nar=C4=99bski
