Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3241F404
	for <e@80x24.org>; Thu, 25 Jan 2018 20:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751181AbeAYUEs (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 15:04:48 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:41266 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeAYUEr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 15:04:47 -0500
Received: by mail-yw0-f180.google.com with SMTP id b129so3407305ywa.8
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 12:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NCGhTJt6Ac/fN9MX5BsO61KXn+QudBw3cAkdbVCuwKg=;
        b=Xmn6MX7KCeBLmsFHI9C4tsO0nKu5vmUwUpX/yhj2l8lGQjClG6JwFYULiFQ/i0gMGX
         R1UCH0853GIyMQvWXF/ypinvPPb1Yq9rVDEWNDdiMOgtzRP8BVuRGG/dGlBNCn90C0cp
         tWxRi+QWKH4zmPFZmc+265jSLoyVvW8JbDoF0+JWJH3na7UOGwoE5qAdA7Td7rTNffEm
         SVzlJJaRTcA1rkpKFgskFkRmNLdPJNCBbwElUShOTEbWjtBkjP0rVp9nk6ckLwuLdqWd
         aBekt/rI4oPgIQmmTggTHlLeJFLSp2xymlw/A3lpV/EW3qGlDTPVnjrmwaM6+fBERHdC
         no8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NCGhTJt6Ac/fN9MX5BsO61KXn+QudBw3cAkdbVCuwKg=;
        b=QZfmKAU0cwYkqPTM7STMciZZvxk8KfgjbBjgocKcOPyIuRFq5Hv6NlBdcvsvfyKYbo
         YC2mo3CaqFS6vs0L2jNs0o08OtOx/cgKPzdrLC7bsrFBIguwU6hDz1sj1QA72tvN8Hd/
         josURtmCgnM4A7LkuXBPNiX9OSABA6HlX5AgFul87jGaF8RUuwFijpV3mV1qCIWU5jeL
         kV2J/uAR2jbEj9SExkO8gY9XfMQuz+g0X0LtgerNmBMwn/eW2YKL5V4yAEwFZpne/h+6
         7+b6LY0u3m5AT7WbGRhycUMP2qtl1ksmTVWYYyXNbfOBqCsMBPR/kw/v0l+82ZVFUGlQ
         KHVw==
X-Gm-Message-State: AKwxytclzfbPkgwzLuIy+Vx2YzsuousmKH0nU/+hMdg47mQ5hyuut6zy
        8KOD5Gr/2SCYSdbR7FVYnQT8D1qo4+FC+fJJWQkkUw==
X-Google-Smtp-Source: AH8x226LEbkc9P5POADbTRCpsBFmINUtQMfT0rQ+MlMBzsHc6iviF5H7SFsW+0H018D/QpK10fSQBG80rDQZw1TU71c=
X-Received: by 10.129.122.73 with SMTP id v70mr9356996ywc.156.1516910686479;
 Thu, 25 Jan 2018 12:04:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.210.209 with HTTP; Thu, 25 Jan 2018 12:04:45 -0800 (PST)
In-Reply-To: <20180125140231.65604-2-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com> <20180125140231.65604-2-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Jan 2018 12:04:45 -0800
Message-ID: <CAGZ79kbVoJpP3d_jgJ9Ekn=9NBMaKVNoapjygz7BxABxP2dCBg@mail.gmail.com>
Subject: Re: [PATCH 01/14] graph: add packed graph design document
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 6:02 AM, Derrick Stolee <stolee@gmail.com> wrote:
> Add Documentation/technical/packed-graph.txt with details of the planned
> packed graph feature, including future plans.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/packed-graph.txt | 185 +++++++++++++++++++++++++++++++
>  1 file changed, 185 insertions(+)
>  create mode 100644 Documentation/technical/packed-graph.txt
>
> diff --git a/Documentation/technical/packed-graph.txt b/Documentation/technical/packed-graph.txt
> new file mode 100644
> index 0000000000..fcc0c83874
> --- /dev/null
> +++ b/Documentation/technical/packed-graph.txt
> @@ -0,0 +1,185 @@
> +Git Packed Graph Design Notes
> +=============================
> +
> +Git walks the commit graph for many reasons, including:
> +
> +1. Listing and filtering commit history.
> +2. Computing merge bases.
> +
> +These operations can become slow as the commit count grows above 100K.

How did you come up with that specific number? (Is it platform dependent?)
I'd avoid a specific number to not derail the reader here into wondering
how this got measured.

> +The merge base calculation shows up in many user-facing commands, such
> +as 'status' and 'fetch' and can take minutes to compute depending on
> +data shape. There are two main costs here:

status needs the walk for the ahead/behind computation which is (1)?
(I forget how status would need to compute a merge-base)

fetch is a networked command, which traditionally in Git is understood as
"can be slow" because you might be in Australia, or the connection is slow
otherwise. So giving this as an example it is not obvious that the DAG walking
is the bottleneck. Maybe git-merge or "git show --remerge-diff" [1] are better
examples for walk-intensive commands?

[1] https://public-inbox.org/git/cover.1409860234.git.tr@thomasrast.ch/
    never landed, so maybe that is a bad example. But for me that command
    is more obviously dependent on cheap walking the DAG compared to fetch.
    So, take my comments with a grain of salt!

> +1. Decompressing and parsing commits.
> +2. Walking the entire graph to avoid topological order mistakes.
> +
> +The packed graph is a file that stores the commit graph structure along
> +with some extra metadata to speed up graph walks. This format allows a
> +consumer to load the following info for a commit:
> +
> +1. The commit OID.
> +2. The list of parents.
> +3. The commit date.
> +4. The root tree OID.
> +5. An integer ID for fast lookups in the graph.
> +6. The generation number (see definition below).
> +
> +Values 1-4 satisfy the requirements of parse_commit_gently().


This new format is specifically removing the cost of decompression and parsing
(1) completely, whereas (2) we still have to walk the entire graph for now as
the generation numbers are not fully used as of yet, but provided.

> +By providing an integer ID we can avoid lookups in the graph as we walk
> +commits. Specifically, we need to provide the integer ID of the parent
> +commits so we navigate directly to their information on request.

Does this mean we decrease the pressure on fast lookups in
packfiles/loose objects?

> +Define the "generation number" of a commit recursively as follows:
> + * A commit with no parents (a root commit) has generation number 1.
> + * A commit with at least one parent has generation number 1 more than
> +   the largest generation number among its parents.
> +Equivalently, the generation number is one more than the length of a
> +longest path from the commit to a root commit. The recursive definition
> +is easier to use for computation and the following property:
> +
> +    If A and B are commits with generation numbers N and M, respectively,
> +    and N <= M, then A cannot reach B. That is, we know without searching
> +    that B is not an ancestor of A because it is further from a root commit
> +    than A.
> +
> +    Conversely, when checking if A is an ancestor of B, then we only need
> +    to walk commits until all commits on the walk boundary have generation
> +    number at most N. If we walk commits using a priority queue seeded by
> +    generation numbers, then we always expand the boundary commit with highest
> +    generation number and can easily detect the stopping condition.

Thanks for including the definition and potential benefits!

> +
> +This property can be used to significantly reduce the time it takes to
> +walk commits and determine topological relationships. Without generation
> +numbers, the general heuristic is the following:
> +
> +    If A and B are commits with commit time X and Y, respectively, and
> +    X < Y, then A _probably_ cannot reach B.
> +
> +This heuristic is currently used whenever the computation can make
> +mistakes with topological orders (such as "git log" with default order),
> +but is not used when the topological order is required (such as merge
> +base calculations, "git log --graph").
> +
> +Design Details
> +--------------
> +
> +- A graph file is stored in a file named 'graph-<oid>.graph' in the pack
> +  directory.

(guessing)
where every commit up to <oid> is included in the file.

> This could be stored in an alternate.

So I can 'borrow' not just the objects itself, but also the file about object
properties from an alternate. Makes sense, though I wonder if it is
worth stating
this as the first bullet point in the design detail section?

> +- The most-recent graph file OID is stored in a 'graph-head' file for
> +  immediate access and storing backup graphs. This could be stored in an
> +  alternate, and refers to a 'graph-<oid>.graph' file in the same pack
> +  directory.

So we have two copies of the latest in both 'graph-head.graph'
as well as 'graph-<oid>.graph'? Would a link be ok? So instead
we might have a 'graph-head.link' file that just contains 'oid: <oid>' ?

But then again, we can get the oid from HEAD, and these graph files
can contain all information up to multiple tips (i.e. there is just one graph
file needed, even if you have 2 branches, neither of them to be
fast-forwardable to the other).

So maybe I do not understand the <oid> after all, yet.

> +- The core.graph config setting must be on to create or consume graph files.

We already have other local files that speed up things, such as idx files.
Searching our config options for "idx" I find 'pack.indexVersion', which
only controls the write side of idx. Reading idx seems automatic if they are
there, otherwise we fallback to non-idx.

By having the setting a boolean we cannot control the version yet, but we can
later upgrade the config to a boolean-or-int that specifies which graph
version is written out.

Why do we need this config option to control the reading side as well?
AFAICT the user can just delete all graphs if the graphs make problems and
then regenerate them if git is too slow?

As these files need to be manually generated as of this series, I'd further
argue that the reading should be unguarded by the config option.

> +- The graph file is only a supplemental structure. If a user downgrades
> +  or disables the 'core.graph' config setting, then the existing ODB is
> +  sufficient.

(Maybe mention idx files as a comparable design?)

> +- The file format includes parameters for the object id length
> +  and hash algorithm, so a future change of hash algorithm does
> +  not require a change in format.

Cool.

> +
> +Current Limitations
> +-------------------
> +
> +- Only one graph file is used at one time. This allows the integer ID to
> +  seek into the single graph file. It is possible to extend the model
> +  for multiple graph files, but that is currently not part of the design.
> +
> +- .graph files are managed only by the 'graph' builtin. These are not
> +  updated automatically during clone or fetch.
> +
> +- There is no '--verify' option for the 'graph' builtin to verify the
> +  contents of the graph file.

c.f. git index-pack --verify (which is not documented :/)

> +- The graph only considers commits existing in packfiles and does not
> +  walk to fill in reachable commits. [Small]

small?

> +- When rewriting the graph, we do not check for a commit still existing
> +  in the ODB, so garbage collection may remove commits
> +
> +- Generation numbers are not computed in the current version. The file
> +  format supports storing them, along with a mechanism to upgrade from
> +  a file without generation numbers to one that uses them.

Maybe move the definition and explanation of the generation numbers above to
the "Future Work" section?


> +
> +Future Work
> +-----------
> +
> +- The file format includes room for precomputed generation numbers. These
> +  are not currently computed, so all generation numbers will be marked as
> +  0 (or "uncomputed"). A later patch will include this calculation.
> +
> +- The current implementation of the 'graph' builtin walks all packed objects
> +  to find a complete list of commits in packfiles. If some commits are
> +  stored as loose objects, then these do not appear in the graph. This is
> +  handled gracefully by the file format, but it would cause incorrect
> +  generation number calculations. We should implement the construct_graph()
> +  method in a way that walks all commits reachable from some starting set
> +  and then can use complete information for generation numbers. (Some
> +  care must be taken around shallow clones.)
> +
> +- The graph is not currently integrated with grafts.

not integrated? Does that mean we error out on grafts, or gracefully fallback
to a sane thing?

> +- After computing and storing generation numbers, we must make graph
> +  walks aware of generation numbers to gain performance benefits. This
> +  will mostly be accomplished by swapping a commit-date-ordered priority
> +  queue with one ordered by generation number. The following operations
> +  are important candidates:
> +
> +    - paint_down_to_common()
> +    - 'log --topo-order'
> +
> +- The graph currently only adds commits to a previously existing graph.
> +  When writing a new graph, we could check that the ODB still contains
> +  the commits and choose to remove the commits that are deleted from the
> +  ODB. For performance reasons, this check should remain optional.
> +
> +- Currently, parse_commit_gently() requires filling in the root tree
> +  object for a commit. This passes through lookup_tree() and consequently
> +  lookup_object(). Also, it calls lookup_commit() when loading the parents.
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
> +- The current design uses the 'graph' builtin to generate the graph. When
> +  this feature stabilizes enough to recommend to most users, we should
> +  add automatic graph writes to common operations that create many commits.
> +  For example, one coulde compute a graph on 'clone' and 'fetch' commands.

typo "could"

Once we have incrementally-update-able graphs, we certainly want commit/merge
to also write out updates? (or batch them after a long rebase).

Thanks,
Stefan
