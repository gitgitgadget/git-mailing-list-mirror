Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581749;
	b=NDcP1xCntCAw1f3G7DBEAAZweztgNBe4DcY/blj/eMCz67AEE3GLcRAu6m5nrXxAyM5u
	 KvQ8qiGVgFvA8ibNx/+ywINkbvW9tjBFQJqYn/IcX061s2qDItXgaf5Tn5WK5Oy1rtYjL
	 c/MqJ6m8+2bnApo99/VArzQ9gM0c9u0ecePx0LHVuVEWdfPZ6Nnj4/bsdqnoJXeAMiKu9
	 NNsftt/MorNe7FSpFKzMzVaJrvmbVT2//cyLfioP51QJHHdiah9Aoz/wzZL/6r+n5lbrl
	 AEbX6qKffeLWOwnd3/2FRJxyJ0e+rJ9GNEGWExq0c+LDplvKcw+7Srx1h7QKgPVrH6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=yExRW61k3iSkfHypCHztUYX0sW+ywy/m/1PednC3qEA=;
	b=kRG4SlJgLN9HSMtzQKTZ2p8GDHuMeUtZ/EI+u/tC5jGXMEKhpr9DOYkpBMYIthsD9Sg9
	 iRyGcDnG5g7uwLa6FdbF0n/W34SqWWSKY+ysc6PAOq6zO+Tl/AGtEFxxq2O+DVA1iR3Er
	 G5Ok2LTZVFcWn5eq+cAPRJ62S0nVZLENpmfKdEl6BBLeoI/0QxWxamreJpXImbqQl3/CH
	 0YEi3mvj7hXiyGpMna3UDAHQTMXQvwmC7PEDiOn2d0YCDV7EcciaalV5c83LytnTP2kEC
	 1G36APA3++wHUEmQ06I93q8MTrJ55GzUIzMW1jW66Y4FA/kcVtovTwxHcNgMCfnhSPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="WuoPB+X/";
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B941606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B941606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WuoPB+X/
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab41538192so468657a91.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 04:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792581747; x=1793186547; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yExRW61k3iSkfHypCHztUYX0sW+ywy/m/1PednC3qEA=;
        b=WuoPB+X/aeoSx8q2QNzMPAPeptRiKG2cAHZhxvBdgM94GB8N55vnoue+V+y1EJmHhk
         ZEV6BJeVApz5AoOlUUvRt1nAAWM7GkEG0t8QwcYy9UVVSKVZOlJ6m152ciknLSa0jIHx
         UtpbQuD7AeuNIWrLn71A7JsdDaOiZzyqPhs43kLTTzAVxq53igddmXZbPYs0MPqmj6TA
         6Iz4xqt4a3V+SnlY3D1Edsen35povG993nhx+YLp0L5L/ogiUkj2FyW96KwV5eilCfvq
         eFIqRLI5pTkMZDI5SaCtOclLoTm1FQlveg7zpnf70+DTkXVFmPI3B0LrftDWTfwlKq5A
         iWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792581747; x=1793186547;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yExRW61k3iSkfHypCHztUYX0sW+ywy/m/1PednC3qEA=;
        b=E8Hn/8QNxCR6Y5G/HTRJHUV1BLwy239AdI+75zEj2K2q4J2f4yLtB1ZYNqxrQ6FG8F
         gQo+vcjEaa6XhTrp/3oDMCBLijqzM1SFy5/v0eFiAejbylvU2PYTDoujtHrEwCDdnEHs
         TkkrB1oPaO2W8KKnlMNlg/OpJFDqBf79kLlUtUTbcfU9GEXFAZXMrByg2Zx/mCxqbFQv
         ZazL62hbFyQ14RsBHXAiJR9grbNVxpSOjf858+2NHVkFFT9m0+fNVl6XnyLPd460GbFE
         jN8g4YR1ALPw3jL7zZoH+J67gFRKOo7jb96EOVCbsk3zVg+oZDYTgPAGTceGSUIuDNHa
         LqYA==
X-Gm-Message-State: AFq9FYLV7aDh+u4VRQnwgti02GM11Xv3ASCifs1w/QnVkAA+9sGs3dwE
	FToyd6vit+8j34Apa7cdHyLzJVrUd3zOptJpblvnppQmkbTN5lvr2VU2UQtAzA==
X-Gm-Gg: AYBFou1Cm6EVTZWpdVw1suEQ8lVQQ8txdoz6osX2IG/WK3ygpwf4w658khezlLqaGK1
	8ETlvu9wth1bK3lWohT+SZBm0cHxswcY7lkiKmFiAck7wGJEGpTpctwTh6HyMUMeGr5WyEykKH6
	kddpQhdKd/Mj0asoddu+D29mqGD7ZKhIDak9uUAtxBZSgzd2tqHIBY9SCO43vbhq0pnfEi469lQ
	pCS5GGlhB/MSvCFv5zEHflZuRdcQOfMLMqRgF6rZcPll4aSCYoUj8RCBU3W47ow1xya4c1J7DGz
	vXQ6QC9o4UTu0T46FzORtsEyioOrllXKTEmscGF6GAJL51h3Z4H4NEyWKcZ0q/MsPZI76IX2t9Y
	mx3XGlZ18zxhQN9tcVfj/QFTr3crz2ZeQOg73musiM5GDtbtqhjKYSVzEhcSM90Y4ghiStN6RzE
	CjeCbMz+ACvcgMbLs7G60mlZGeDm4+BLv3w4b5BAZvHN0x/EQk2Y2UYGNjud3EfCKcpLNEk+sij
	dz+kTL9OEtSiASyJL39qFATN2WM6lYoz1kM3Fv9X8OHe771ZZWMIqVx
X-Received: by 2002:a17:90b:3d86:b0:3ac:e6a:1b2b with SMTP id 98e67ed59e1d1-3ad86cb08f3mr1496007a91.0.1792581746756;
        Wed, 21 Oct 2026 04:22:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.42.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad835fada1sm1834368a91.1.2026.10.21.04.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 04:22:25 -0700 (PDT)
Message-Id: <pull.2211.v4.git.1792581744.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 11:22:18 +0000
Subject: [PATCH v4 0/6] connected: add incremental connectivity check
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>

This series adds an incremental mode for the connectivity check, gated
behind transfer.connectivityCheck=incremental or "auto" (no expected changes
unless you opt in).

The intent is to solve the problem of the connectivity check slowing down as
the number of reachable objects from the boundary grows.

It relates to the RFC I sent out earlier:

[RFC] check_connected: toward incoming-proportional cost
https://lore.kernel.org/git/CAL71e4Nf=-zCrfN7ghEVGq11irajJhtdxYZgKe0Ycux0qs1ZvQ@mail.gmail.com/



Design
======

The verifier runs inside the same rev-list subprocess that check_connected()
already spawns, triggered by a new internal option --connectivity-check=.
After get_revision() collects the incoming commits, the verifier processes
them in topological order (ancestors before descendants).

The idea is to keep a set of trusted objects, shared across the incoming
commits, that grows over time. We visit the new/untrusted commit trees and
do a comparison walk over the trees of their parents. Entries discovered on
the trusted parent side are remembered as trusted, which lets later
verification skip matching objects and avoid descending into unchanged
subtrees.

More algorithmic details are in
Documentation/technical/connectivity-check.adoc.


Benchmarks
==========

I'll just mention a short summary here, to avoid repeating what's already in
the commit messages (5/6 and 6/6). The incremental mode is faster than the
full mode when there are few commits to verify and when the active object
tree is large. In the happy case, the work tracks the changed paths and
their comparison trees rather than the full reachable object closure, which
substantially reduces the dependence on total repository size. I've seen
speedups of up to about 18x in the synthetic perf tests.

Running against a large real-world repo (3.4 GB boundary closure), the
numbers are more dramatic. These were measured on v1 and not re-run since;
the real-repo numbers for v4 are in 6/6. All timings use rev-list directly
with --not HEADN, isolating the tree verification cost from the
boundary-finding cost:

commits    full  incr.  speedup   full RSS  incr. RSS
      1    1.9s  0.01s    190x      3.4 GB     14 MB
     10    1.9s  0.04s     48x      3.4 GB    125 MB
    100    1.9s  0.37s      5x      3.4 GB    1.1 GB


The full mode takes ~1.9s regardless of commit count because it is dominated
by walking the boundary closure. Incremental scales with the number of
incoming commits and the paths they touch. Memory follows the same pattern:
incremental uses a fraction of the full mode's RSS for small pushes,
converging only when many commits are verified.

There are also regression cases in the synthetic fixtures. With long
incoming histories, the extra parent-tree scans accumulate; in the synthetic
fixture incremental is about 1.5x slower at 10000 commits. Per-commit
changes have less impact than expected: even when every directory is
touched, incremental remains competitive.

In the cases I have tested the regression has remained modest, and it shows
up with long incoming histories, while the target case (small pushes to
large repositories) sees the largest speedup. That is what the "auto" mode
is for: it uses the incremental check for small numbers of incoming commits
and the full check otherwise, with a cutoff that can be configured.

Deepening fetches currently fall back to the full check because the full
check omits --not --all for deepening -- there is no existing-reference
boundary at which the walk can stop. An incremental approach is possible
here too -- using the old shallow roots as the trusted boundary and walking
the deepened ancestry forward -- but that is a separate change and left for
future work. Deepening is also less common than regular fetch and
receive-pack, where the speedup matters most.


Test coverage
=============

Most correctness cases in t5413-connectivity-check.sh are run in both full
and incremental modes to check semantic equivalence. Selected cases
additionally assert trace2 tree/blob counts for the incremental mode, to
verify that unchanged portions of the object graph are actually skipped. The
tests cover:

 * Corruption detection: missing blobs, missing trees, type mismatches,
   malformed trees (unparseable, mid-tree corruption), and corrupt blobs
   (incremental only, since the full check does not read blobs)
 * Tree optimization: trace2 assertions confirm unchanged subtrees are
   skipped, subtree moves, merge parent boundaries
 * Root commits (no parents -- verifies full tree closure)
 * Partial clones: missing promised blobs, missing promised trees, missing
   promised parent commits, verification of local commits
 * Replacement objects (with and without GIT_NO_REPLACE_OBJECTS)
 * Shallow boundaries
 * Deepening fetches (falls back to full check)
 * Algorithm selection: clones and pushes into an empty repository use the
   full check, "auto" and its cutoff, and unknown config values
 * Tree depth: the incremental check honors core.maxTreeDepth (t6700)
 * Integration: real push, fetch, and clone

Most tests call git rev-list directly with the appropriate flags;
integration tests exercise the full check_connected() path through push,
fetch, and clone.


Alternatives considered
=======================

My first prototype ran the verifier in-process inside connected.c. This
required a second rev-list subprocess just for boundary finding, _nofetch
variants of several object-reading functions to prevent lazy fetches in
partial clones, explicit shallow-file plumbing, and careful avoidance of
die() in all code paths reachable from the verifier. The result worked but
was fragile and touched many files.

Moving the verifier into the rev-list subprocess eliminated all of those
problems: in partial clones the existing --exclude-promisor-objects handling
already disables lazy fetching, a die() in existing helpers only ends the
subprocess, shallow and replacement semantics are established before the
verifier runs, and error routing comes for free via stderr.

So while I liked the idea of doing the check in-process, making that work
ended up being a lot more complex.


Next steps
==========

This series only addresses tree verification; the other significant cost is
finding the commit boundary, especially for repos with many refs. I already
have some prototypes for optimizing that too, and if this ends up landing,
that would be something I would start polishing up.


Changes since v3
================

 * Split, along the lines Patrick suggested, into three steps: the config
   option and the internal --connectivity-check= rev-list option with only
   "full" (4/6), the incremental check (5/6), and the "auto" mode (6/6),
   since choosing between the two is subtle enough to review on its own.

 * The internal rev-list option --verify-trees-incremental is replaced by
   --connectivity-check=, which check_connected() now always passes.
   rev-list dies on an unknown mode, since only check_connected() passes it.

 * An unknown transfer.connectivityCheck value now falls back to full with a
   warning instead of dying, so config written for a newer Git does not
   break fetches.

 * "auto" takes an optional cutoff, "auto=", as Patrick suggested,
   defaulting to 1000.

 * Clones and pushes into an empty repository use the full check even with
   incremental or auto, since there is no boundary to compare against (see
   5/6). check_connected() now decides the deepening fallback before reading
   the config.

 * New patch 3/6 drops the dependency on the_repository in connected.c, as
   Junio suggested. The repository is passed to check_connected() as a
   parameter rather than in check_connected_options, like other functions
   that take a repository.

 * Use parse_commit_gently() instead of dying on a parent that cannot be
   parsed, which Patrick pointed out could happen in a partial clone with
   missing commits. As in the revision walk, a missing parent that is
   promised is skipped; added a test for that. More generally, the verifier
   adds no new die() calls: it returns errors, and rev-list dies once when
   the check fails.

 * An object that cannot be read is now reported as "missing" only when it
   does not exist, and as "unable to read" otherwise, e.g. for a corrupt
   blob.

 * Renamed variables to parent_trees / trusted_bases to make the trust
   direction clearer.

 * size_t for counts and sizes.

 * verify_tree() still recurses, bounded by core.maxTreeDepth like the other
   tree walkers. Its frame was made smaller by moving the tree descriptor
   scratch space into the shared state: with gcc -O2 its frame is 272 bytes,
   against 240 for process_tree(), so at the default depth of 2048 it needs
   about the same stack as "rev-list --objects". The listing of untrusted
   entries and the scan of the base trees are split out into helpers,
   without changing the logic. New t6700 tests check that the incremental
   check (given a boundary, so that it is not replaced by the full check)
   honors core.maxTreeDepth and fails gracefully at the default limit.
   
   I tried a work queue as suggested, but it got messy, and it would be
   stricter than the code we already rely on: the full check's
   process_tree() recurses over trees in the same way, and be20128bfa (add
   core.maxTreeDepth) settled on bounding tree recursion rather than
   removing it. If we want an iterative walk, I think it belongs in a
   separate series that also covers process_tree().

 * Also addressed from v3 review: the technical doc is listed in the
   Makefile and in meson.build, the perf tests require PERL, the leftover
   p5412 is now p5413, "verified against these marks" is reworded, int flags
   are bool, the tree state map's byte-sized values are explained in a
   comment, and the parent tree expansion in tree-verify.c has comments
   explaining it.

 * Documentation: reworded the technical doc, including a shorter
   description of the promisor fast path; transfer.connectivityCheck
   documents the fallbacks to full; and the rev-list option description is
   trimmed to an internal-use note.

 * The --connectivity-check parsing in rev-list moved into a small helper,
   with the mode and cutoff in a struct local to cmd_rev_list() instead of
   globals.

 * Tests are faster and simpler: the auto cutoff is tested with "auto="
   instead of building long histories, and the mode selection tests share
   two small helpers.

 * p5413 passes the mode explicitly, and the tables in 5/6 were re-measured;
   they now report the best of 3 runs, which is what the perf framework
   reports, rather than "median of 3".


Changes since v2
================

Addresses Patrick's review (thanks!).

 * Split from 2 commits to 4: documentation, perf test baseline, config
   plumbing + rev-list flag, then the incremental implementation.
 * Documentation rewrites: added unreachable-objects caveat, removed code
   references to reduce staleness risk, replaced three-phase list with
   cost-focused prose, rewrote trust model to explicitly describe boundary
   mechanism and inductive argument, and several smaller clarifications.
 * Extracted tree_oid variable in verify_commit_tree() to avoid calling
   get_commit_tree_oid(commit) twice.
 * Rebased onto latest master to resolve a meson.build conflict (t5412 was
   taken by another topic). Renumbered test and perf files to t5413/p5413.


Changes since v1
================

 * Guard against get_commit_tree_oid() returning NULL in
   verify_commit_tree(), dying with a clear message instead of a NULL
   dereference. (Thanks Junio for catching this)
 * Set fetch_if_missing = 0 in the rev-list early option parse when
   --verify-trees-incremental is seen, and add a BUG() assertion in
   verify_commits_incremental() to catch any future caller that forgets.
   This makes the lazy-fetch protection explicit rather than relying solely
   on --exclude-promisor-objects having set it earlier. (Thanks again to
   Junio)
 * Add a test that verifies promised blobs are not lazy-fetched during the
   incremental check.
 * Reuse the existing 3-argument type-mismatch format string to avoid adding
   new strings for localization.

Thanks, Kristofer

Kristofer Karlsson (6):
  Documentation: describe connectivity checking
  p5413: add perf tests for connectivity check
  connected: drop dependency on `the_repository`
  connected: add transfer.connectivityCheck config
  connected: add incremental connectivity check via rev-list
  connected: add "auto" connectivity check mode

 Documentation/Makefile                        |   1 +
 Documentation/config/transfer.adoc            |  30 +
 Documentation/rev-list-options.adoc           |   5 +
 .../technical/connectivity-check.adoc         | 259 ++++++
 Documentation/technical/meson.build           |   1 +
 Makefile                                      |   1 +
 builtin/clone.c                               |   2 +-
 builtin/fetch.c                               |   5 +-
 builtin/receive-pack.c                        |  12 +-
 builtin/rev-list.c                            |  77 ++
 bundle.c                                      |   2 +-
 connected.c                                   |  67 +-
 connected.h                                   |   4 +-
 fetch-pack.c                                  |   3 +-
 meson.build                                   |   1 +
 t/meson.build                                 |   1 +
 ...enerate-repo-p5413-connectivity-check.perl |  44 +
 t/perf/p5413-connectivity-check.sh            |  92 ++
 t/t5413-connectivity-check.sh                 | 795 ++++++++++++++++++
 t/t6700-tree-depth.sh                         |  17 +
 tree-verify.c                                 | 427 ++++++++++
 tree-verify.h                                 |  15 +
 22 files changed, 1840 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/technical/connectivity-check.adoc
 create mode 100644 t/perf/generate-repo-p5413-connectivity-check.perl
 create mode 100755 t/perf/p5413-connectivity-check.sh
 create mode 100755 t/t5413-connectivity-check.sh
 create mode 100644 tree-verify.c
 create mode 100644 tree-verify.h


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2211%2Fspkrka%2Ftree-diff-connectivity-v1-clean-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2211/spkrka/tree-diff-connectivity-v1-clean-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2211

Range-diff vs v3:

 1:  19ea8cb534 ! 1:  e25824c21d Documentation: describe connectivity checking
     @@ Commit message
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     + ## Documentation/Makefile ##
     +@@ Documentation/Makefile: TECH_DOCS += technical/bitmap-format
     + TECH_DOCS += technical/build-systems
     + TECH_DOCS += technical/bundle-uri
     + TECH_DOCS += technical/commit-graph
     ++TECH_DOCS += technical/connectivity-check
     + TECH_DOCS += technical/directory-rename-detection
     + TECH_DOCS += technical/hash-function-transition
     + TECH_DOCS += technical/large-object-promisors
     +
       ## Documentation/technical/connectivity-check.adoc (new) ##
      @@
      +Connectivity checking
     @@ Documentation/technical/connectivity-check.adoc (new)
      +    git rev-list --objects --stdin --not --all --quiet
      +        --alternate-refs [--exclude-promisor-objects]
      +
     -+When promisor remotes are configured, a fast path based on
     -+promisor packfiles is attempted first.  If it falls back to
     -+the `rev-list` check, `--exclude-promisor-objects` is added so
     -+that the traversal does not trigger on-demand fetches.
     ++In a partial clone, objects received from a promisor remote do
     ++not need to be checked: anything they reference is promised by
     ++that remote and can be fetched on demand.  So if every new tip is
     ++found in a promisor packfile, `rev-list` is not run at all.
     ++Otherwise it runs with `--exclude-promisor-objects`, so that the
     ++traversal stops at promisor objects instead of fetching them.
      +
      +Consider the following graph after a fetch, where all reference
      +tips point directly to commits.  For simplicity, only local
     @@ Documentation/technical/connectivity-check.adoc (new)
      +
      +The traversal then walks the trees of the boundary commits and
      +marks those objects uninteresting.  Trees of incoming commits
     -+are verified against these marks, stopping at objects already
     -+covered.  The cost of marking boundary trees uninteresting
     ++are then walked, stopping at objects already marked as
     ++uninteresting.  The cost of marking boundary trees uninteresting
      +dominates when the boundary commits have large trees, even when
      +the incoming changes are small.
      +
     @@ Documentation/technical/connectivity-check.adoc (new)
      +These non-commit tips are verified during the tree and blob
      +traversal that follows the commit walk within the same rev-list
      +invocation.
     +
     + ## Documentation/technical/meson.build ##
     +@@ Documentation/technical/meson.build: articles = [
     +   'build-systems.adoc',
     +   'bundle-uri.adoc',
     +   'commit-graph.adoc',
     ++  'connectivity-check.adoc',
     +   'directory-rename-detection.adoc',
     +   'hash-function-transition.adoc',
     +   'large-object-promisors.adoc',
 2:  211794c925 ! 2:  427b7315a5 p5413: add perf tests for connectivity check
     @@ t/perf/generate-repo-p5413-connectivity-check.perl (new)
      @@
      +#!/usr/bin/perl
      +#
     -+# Generate a fast-import stream for p5412 connectivity check benchmarks.
     ++# Generate a fast-import stream for p5413 connectivity check benchmarks.
      +#
     -+# Usage: generate-repo-p5412-connectivity-check.perl
     ++# Usage: generate-repo-p5413-connectivity-check.perl
      +#            <dirs> <files_per_dir> <commits> [<hot_dirs>] [<files_per_commit>]
      +#
      +# Creates one initial commit with dirs*files_per_dir files, then
     @@ t/perf/p5413-connectivity-check.sh (new)
      +		label="$label (${fpc} files/commit)"
      +	fi
      +
     -+	test_expect_success "setup $label" '
     ++	test_expect_success PERL "setup $label" '
      +		if test -d '"$name"'
      +		then
      +			true
     @@ t/perf/p5413-connectivity-check.sh (new)
      +		fi
      +	'
      +
     -+	test_perf "$label" '
     ++	test_perf "$label" --prereq PERL '
      +		cat '"${name}"'_new |
      +		git -C '"$name"' rev-list \
      +			--objects --stdin --not --all --quiet \
 -:  ---------- > 3:  3a7a1fb953 connected: drop dependency on `the_repository`
 3:  cdf28f1df6 ! 4:  87dbb1f055 connected: add transfer.connectivityCheck config and rev-list flag
     @@ Metadata
      Author: Kristofer Karlsson <krka@spotify.com>
      
       ## Commit message ##
     -    connected: add transfer.connectivityCheck config and rev-list flag
     +    connected: add transfer.connectivityCheck config
      
     -    Add the transfer.connectivityCheck configuration option, accepting
     -    "full" (default) and "incremental".  When set to "incremental",
     -    check_connected() passes --verify-trees-incremental to its rev-list
     -    subprocess.
     +    Add the transfer.connectivityCheck configuration option to choose
     +    the algorithm used for the connectivity check.  For now the only
     +    accepted value is "full", which is the existing behavior and the
     +    default.  Unknown values fall back to "full" with a warning, so
     +    that configuration written for a newer version of Git does not
     +    break fetches and pushes; "full" is always a correct check.
      
     -    The rev-list flag is accepted but has no effect yet; the incremental
     -    verification will be implemented in the next commit.
     +    check_connected() now always tells its rev-list subprocess which
     +    algorithm to use with an internal --connectivity-check=<mode>
     +    option, which so far only accepts "full".  Passing the mode
     +    explicitly means rev-list knows it is running a connectivity
     +    check, so later optimizations can be limited to that case.
      
     +    This prepares for an incremental check added in the next commit.
     +
     +    Suggested-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## Documentation/config/transfer.adoc ##
     @@ Documentation/config/transfer.adoc
      +--
      +`full` (default);;
      +	Walk the full object closure of the boundary commits.
     -+`incremental`;;
     -+	Verify incoming commits by diffing their trees against parent
     -+	trees, recursively descending only into entries that differ.
     -+	The largest benefits occur when incoming commits change a
     -+	small fraction of a large tree closure.
     -+	Falls back to `full` for deepening fetches.
      +--
     +++
     ++Unknown values are treated as `full`, with a warning.
      +
       transfer.credentialsInUrl::
       	A configured URL can contain plaintext credentials in the form
     @@ Documentation/rev-list-options.adoc: It is an error to use `--missing-only` with
       	traversal, rather than just silencing errors about missing
       	objects.
      +
     -+`--verify-trees-incremental`::
     -+	(For internal use only.)  Verify tree connectivity
     -+	incrementally by comparing each commit's tree against its
     -+	parent trees.  Used by `check_connected()` when
     -+	`transfer.connectivityCheck` is set to `incremental`.
     ++`--connectivity-check=full`::
     ++	(For internal use only.)  Used by `check_connected()` to
     ++	select the connectivity check algorithm; see
     ++	`transfer.connectivityCheck` in linkgit:git-config[1].
       endif::git-rev-list[]
       
       `--no-walk[=(sorted|unsorted)]`::
      
       ## builtin/rev-list.c ##
     +@@
     + #include "quote.h"
     + #include "strbuf.h"
     + 
     ++enum connectivity_check_mode {
     ++	CONNECTIVITY_CHECK_FULL,
     ++};
     ++
     ++struct connectivity_check {
     ++	enum connectivity_check_mode mode;
     ++};
     ++
     ++static void parse_connectivity_check(struct repository *repo UNUSED,
     ++				     const char *arg,
     ++				     struct connectivity_check *check)
     ++{
     ++	if (!strcmp(arg, "full"))
     ++		check->mode = CONNECTIVITY_CHECK_FULL;
     ++	else
     ++		die(_("unknown --connectivity-check mode '%s'"), arg);
     ++}
     ++
     + struct rev_list_info {
     + 	struct rev_info *revs;
     + 	int flags;
     +@@ builtin/rev-list.c: int cmd_rev_list(int argc,
     + 	int bisect_find_all = 0;
     + 	int use_bitmap_index = 0;
     + 	int filter_provided_objects = 0;
     ++	struct connectivity_check connectivity_check = { 0 };
     + 	const char *show_progress = NULL;
     + 	int ret = 0;
     + 
      @@ builtin/rev-list.c: int cmd_rev_list(int argc,
       		if (!strcmp(arg, "--exclude-promisor-objects")) {
       			repo->fetch_if_missing = 0;
       			revs.exclude_promisor_objects = 1;
     -+		} else if (!strcmp(arg, "--verify-trees-incremental")) {
     -+			repo->fetch_if_missing = 0;
     ++		} else if (skip_prefix(arg, "--connectivity-check=", &arg)) {
     ++			parse_connectivity_check(repo, arg, &connectivity_check);
       		} else if (skip_prefix(arg, "--missing=", &arg)) {
       			parse_missing_action_value(repo, arg);
       		} else if (!strcmp(arg, "--missing-only")) {
     @@ builtin/rev-list.c: int cmd_rev_list(int argc,
       
       		if (!strcmp(arg, "--exclude-promisor-objects"))
       			continue; /* already handled above */
     -+		if (!strcmp(arg, "--verify-trees-incremental"))
     ++		if (starts_with(arg, "--connectivity-check="))
      +			continue; /* already handled above */
       		if (skip_prefix(arg, "--missing=", &arg))
       			continue; /* already handled above */
     @@ builtin/rev-list.c: int cmd_rev_list(int argc,
      
       ## connected.c ##
      @@
     - #define USE_THE_REPOSITORY_VARIABLE
     - 
       #include "git-compat-util.h"
      +#include "config.h"
       #include "gettext.h"
       #include "hex.h"
       #include "odb.h"
     -@@ connected.c: static int check_connected_promisor(oid_iterate_fn fn,
     +@@ connected.c: static int check_connected_promisor(struct repository *repo,
       	return 1;
       }
       
     -+static int incremental_check_applicable(struct check_connected_options *opt)
     ++/*
     ++ * Fills in the --connectivity-check mode to pass to rev-list.
     ++ */
     ++static void connectivity_check_mode(struct repository *repo,
     ++				    struct strbuf *mode)
      +{
      +	const char *algorithm = NULL;
      +
     -+	if (repo_config_get_string_tmp(the_repository,
     ++	if (repo_config_get_string_tmp(repo,
      +				       "transfer.connectivitycheck",
      +				       &algorithm))
     -+		return 0;
     ++		algorithm = "full";
      +	if (!strcasecmp(algorithm, "full"))
     -+		return 0;
     -+	if (strcasecmp(algorithm, "incremental"))
     -+		die(_("unknown transfer.connectivityCheck algorithm '%s'"),
     -+		    algorithm);
     -+
     -+	if (opt->is_deepening_fetch)
     -+		return 0;
     -+
     -+	return 1;
     ++		strbuf_addstr(mode, "full");
     ++	else {
     ++		warning(_("unknown transfer.connectivityCheck algorithm '%s', "
     ++			  "using 'full'"), algorithm);
     ++		strbuf_addstr(mode, "full");
     ++	}
      +}
      +
       /*
        * If we feed all the commits we want to verify to this command
        *
     -@@ connected.c: int check_connected(oid_iterate_fn fn, void *cb_data,
     +@@ connected.c: int check_connected(struct repository *repo,
     + 	struct child_process rev_list = CHILD_PROCESS_INIT;
     + 	FILE *rev_list_in;
     + 	struct check_connected_options defaults = CHECK_CONNECTED_INIT;
     ++	struct strbuf mode = STRBUF_INIT;
     + 	const struct object_id *oid;
     + 	int err = 0;
     + 	struct packed_git *new_pack = NULL;
     +@@ connected.c: int check_connected(struct repository *repo,
       	if (opt->progress)
       		strvec_pushf(&rev_list.args, "--progress=%s",
       			     _("Checking connectivity"));
     -+	if (incremental_check_applicable(opt))
     -+		strvec_push(&rev_list.args,
     -+			    "--verify-trees-incremental");
     ++	connectivity_check_mode(repo, &mode);
     ++	strvec_pushf(&rev_list.args, "--connectivity-check=%s", mode.buf);
     ++	strbuf_release(&mode);
       
       	rev_list.git_cmd = 1;
       	if (opt->env)
 4:  efaada0b6a ! 5:  d76dae801b connected: add incremental connectivity check via rev-list
     @@ Commit message
          See Documentation/technical/connectivity-check.adoc for the trust
          invariants and detailed algorithm.
      
     -    The incremental check runs as an internal
     -    --verify-trees-incremental mode in rev-list.  After the normal
     +    The incremental check runs inside rev-list, selected by the
     +    internal --connectivity-check option.  After the normal
          revision walk identifies the incoming commits, the verifier
          consumes them before the usual object traversal; any pending
          non-commit tips are still handled by the existing traversal.
      
          Partial-clone semantics are preserved: objects promised by a
          promisor remote are accepted as connected, and on-demand fetching
     -    is prevented by excluding promisor objects from traversal.  The
     -    new mode is selected by transfer.connectivityCheck=incremental,
     -    with full remaining the default.  Deepening fetches fall back to
     -    the full check because they do not have the normal
     +    is prevented by excluding promisor objects from traversal.
     +
     +    A new transfer.connectivityCheck value "incremental" selects the
     +    new mode, with "full" remaining the default.  Deepening fetches
     +    fall back to the full check because they do not have the normal
          existing-reference boundary, and traversal instead follows the
          effective shallow boundary.
      
     -    p5413 results (median of 3), scaling one dimension at a time.
     +    Clones and pushes into an empty repository also use the full
     +    check.  Without negative revisions there is no trusted boundary,
     +    and the incremental check would have to verify all of history
     +    from scratch like the full check does, with extra per-commit
     +    overhead on top.  On git.git, checking 70K commits without a
     +    boundary takes 5.3s with the full check and 9.2s with the
     +    incremental one.
     +
     +    p5413 results (best of 3), scaling one dimension at a time.
          Each fixture is a repository with a flat tree of many
          directories containing 100 files each.  The incoming set is a
          chain of commits on top of the existing history, with each
     @@ Commit message
              files    full  incr.  full/incr
                5K    0.01s  0.01s    1.0x
               50K    0.04s  0.01s    4.0x
     -        200K    0.15s  0.01s   15.0x
     -        800K    0.61s  0.03s   20.3x
     +        200K    0.13s  0.01s   13.0x
     +        800K    0.54s  0.03s   18.0x
      
          The full mode must walk the trees of boundary commits, which
          grows with overall tree size.  Incremental still scans the
     @@ Commit message
          Scaling incoming commit count (200K files, 10 files/commit):
      
              commits    full  incr.  full/incr
     -              1    0.14s  0.01s   14.0x
     -             10    0.15s  0.01s   15.0x
     -            100    0.19s  0.05s    3.8x
     -            500    0.32s  0.27s    1.2x
     -           3000    1.23s  1.52s    0.8x
     -           5000    1.88s  2.43s    0.8x
     -          10000    3.72s  5.36s    0.7x
     +              1    0.13s  0.01s   13.0x
     +             10    0.13s  0.01s   13.0x
     +            100    0.16s  0.06s    2.7x
     +            500    0.29s  0.25s    1.2x
     +           3000    1.14s  1.44s    0.8x
     +           5000    1.87s  2.39s    0.8x
     +          10000    3.45s  5.13s    0.7x
      
          With many commits the per-commit overhead of scanning both
          the new and parent root trees accumulates and incremental
     @@ Commit message
          Scaling files per incoming commit (200K files, 10 commits):
      
              files/commit    full  incr.  full/incr
     -                   1    0.14s  0.01s   14.0x
     -                  10    0.15s  0.01s   15.0x
     -                 100    0.16s  0.04s    4.0x
     -                 500    0.23s  0.14s    1.6x
     -                1000    0.34s  0.28s    1.2x
     -                2000    0.70s  0.63s    1.1x
     -
     -    Breakeven is around 1000 files/commit.  At 2000 files/commit
     -    (every directory touched), incremental remains slightly faster;
     -    bypassing the object cache for tree reads likely helps here.
     +                   1    0.13s  0.01s   13.0x
     +                  10    0.13s  0.01s   13.0x
     +                 100    0.15s  0.03s    5.0x
     +                 500    0.23s  0.13s    1.8x
     +                1000    0.34s  0.27s    1.3x
     +                2000    0.65s  0.56s    1.2x
      
     -    For small repositories both modes are fast enough that the
     -    difference is difficult to measure reliably.
     +    The advantage shrinks as more files change per commit, but
     +    incremental stays slightly faster even at 2000 files/commit,
     +    where every directory is touched.
      
          Selected peak RSS measurements from the same fixtures:
      
     @@ Commit message
              800K files, 10 commits     110 MB    26 MB   0.2x
              200K files, 5000 commits   155 MB   151 MB   1.0x
      
     -    Incremental uses substantially less memory when it can prune
     -    most of the boundary tree walk.  In the long-history case the
     -    two modes visit similar object sets and memory converges.
     +    Incremental uses less memory when it can prune enough of the
     +    boundary tree walk.  In the long-history case the two modes
     +    visit similar object sets and memory converges.
      
          The regression cases in the CPU benchmarks are in wall-clock
          time rather than memory, primarily from scanning some trees
     -    more than once.
     +    more than once: a commit's tree is read as a candidate when the
     +    commit is verified, and again as a trusted parent tree when its
     +    children are verified.
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     + ## Documentation/config/transfer.adoc ##
     +@@ Documentation/config/transfer.adoc: transfer.connectivityCheck::
     + --
     + `full` (default);;
     + 	Walk the full object closure of the boundary commits.
     ++`incremental`;;
     ++	Verify incoming commits by diffing their trees against parent
     ++	trees, recursively descending only into entries that differ.
     ++	The largest benefits occur when incoming commits change a
     ++	small fraction of a large tree closure, and it can be slower
     ++	than `full` when there are many incoming commits.
     ++	Falls back to `full` for clones, pushes into an empty
     ++	repository and deepening fetches.
     + --
     + +
     + Unknown values are treated as `full`, with a warning.
     +
     + ## Documentation/rev-list-options.adoc ##
     +@@ Documentation/rev-list-options.adoc: It is an error to use `--missing-only` without `--missing=print` or
     + 	traversal, rather than just silencing errors about missing
     + 	objects.
     + 
     +-`--connectivity-check=full`::
     ++`--connectivity-check=(full|incremental)`::
     + 	(For internal use only.)  Used by `check_connected()` to
     + 	select the connectivity check algorithm; see
     + 	`transfer.connectivityCheck` in linkgit:git-config[1].
     +
       ## Documentation/technical/connectivity-check.adoc ##
      @@ Documentation/technical/connectivity-check.adoc: tag, tree, or blob, that object is not part of the commit walk.
       These non-commit tips are verified during the tree and blob
     @@ Documentation/technical/connectivity-check.adoc: tag, tree, or blob, that object
      +replaces what happens afterwards: rather than walking boundary
      +trees to mark objects uninteresting, it compares each incoming
      +commit's tree against its parents' trees, processing commits in
     -+topological order (ancestors first).
     ++topological order (ancestors first).  This all happens inside
     ++the same `rev-list` invocation, and the promisor fast path above
     ++still runs first.
      +
      +Trust model
      +~~~~~~~~~~~
     @@ builtin/rev-list.c
       #include "strbuf.h"
      +#include "tree-verify.h"
       
     - struct rev_list_info {
     - 	struct rev_info *revs;
     -@@ builtin/rev-list.c: int cmd_rev_list(int argc,
     - 	int bisect_find_all = 0;
     - 	int use_bitmap_index = 0;
     - 	int filter_provided_objects = 0;
     -+	int verify_trees_incremental = 0;
     - 	const char *show_progress = NULL;
     - 	int ret = 0;
     + enum connectivity_check_mode {
     + 	CONNECTIVITY_CHECK_FULL,
     ++	CONNECTIVITY_CHECK_INCREMENTAL,
     + };
       
     -@@ builtin/rev-list.c: int cmd_rev_list(int argc,
     - 			repo->fetch_if_missing = 0;
     - 			revs.exclude_promisor_objects = 1;
     - 		} else if (!strcmp(arg, "--verify-trees-incremental")) {
     -+			verify_trees_incremental = 1;
     - 			repo->fetch_if_missing = 0;
     - 		} else if (skip_prefix(arg, "--missing=", &arg)) {
     - 			parse_missing_action_value(repo, arg);
     + struct connectivity_check {
     + 	enum connectivity_check_mode mode;
     + };
     + 
     +-static void parse_connectivity_check(struct repository *repo UNUSED,
     ++static void parse_connectivity_check(struct repository *repo,
     + 				     const char *arg,
     + 				     struct connectivity_check *check)
     + {
     + 	if (!strcmp(arg, "full"))
     + 		check->mode = CONNECTIVITY_CHECK_FULL;
     ++	else if (!strcmp(arg, "incremental"))
     ++		check->mode = CONNECTIVITY_CHECK_INCREMENTAL;
     + 	else
     + 		die(_("unknown --connectivity-check mode '%s'"), arg);
     ++
     ++	if (check->mode != CONNECTIVITY_CHECK_FULL)
     ++		repo->fetch_if_missing = 0;
     + }
     + 
     + struct rev_list_info {
      @@ builtin/rev-list.c: int cmd_rev_list(int argc,
       
       	prepare_maximal_independent(&revs);
       
     -+	if (verify_trees_incremental) {
     ++	/*
     ++	 * Without a boundary of negative revisions, as in a clone or a
     ++	 * push into an empty repository, every incoming commit is new.
     ++	 * The incremental check would still work, but it would verify
     ++	 * the whole object graph like the full check, with extra
     ++	 * per-commit overhead on top, so use the full check.
     ++	 */
     ++	if (!revs.limited)
     ++		connectivity_check.mode = CONNECTIVITY_CHECK_FULL;
     ++
     ++	if (connectivity_check.mode == CONNECTIVITY_CHECK_INCREMENTAL) {
      +		struct commit *commit;
      +		struct commit_list *new_commits = NULL;
      +
      +		while ((commit = get_revision(&revs)) != NULL)
      +			commit_list_insert(commit, &new_commits);
      +
     -+		verify_commits_incremental(repo, &new_commits,
     -+					   revs.exclude_promisor_objects);
     ++		if (verify_commits_incremental(repo, &new_commits,
     ++					       revs.exclude_promisor_objects))
     ++			die(_("connectivity check failed"));
      +		commit_list_free(new_commits);
      +	}
      +
     @@ builtin/rev-list.c: int cmd_rev_list(int argc,
       		mark_edges_uninteresting(&revs, show_edge, 0);
       
      
     + ## connected.c ##
     +@@ connected.c: static int check_connected_promisor(struct repository *repo,
     +  * Fills in the --connectivity-check mode to pass to rev-list.
     +  */
     + static void connectivity_check_mode(struct repository *repo,
     ++				    struct check_connected_options *opt,
     + 				    struct strbuf *mode)
     + {
     + 	const char *algorithm = NULL;
     + 
     ++	/*
     ++	 * Deepening fetches do not have the usual boundary of
     ++	 * existing references, so use the full check for them.
     ++	 */
     ++	if (opt->is_deepening_fetch) {
     ++		strbuf_addstr(mode, "full");
     ++		return;
     ++	}
     ++
     + 	if (repo_config_get_string_tmp(repo,
     + 				       "transfer.connectivitycheck",
     + 				       &algorithm))
     + 		algorithm = "full";
     + 	if (!strcasecmp(algorithm, "full"))
     + 		strbuf_addstr(mode, "full");
     ++	else if (!strcasecmp(algorithm, "incremental"))
     ++		strbuf_addstr(mode, "incremental");
     + 	else {
     + 		warning(_("unknown transfer.connectivityCheck algorithm '%s', "
     + 			  "using 'full'"), algorithm);
     +@@ connected.c: int check_connected(struct repository *repo,
     + 	if (opt->progress)
     + 		strvec_pushf(&rev_list.args, "--progress=%s",
     + 			     _("Checking connectivity"));
     +-	connectivity_check_mode(repo, &mode);
     ++	connectivity_check_mode(repo, opt, &mode);
     + 	strvec_pushf(&rev_list.args, "--connectivity-check=%s", mode.buf);
     + 	strbuf_release(&mode);
     + 
     +
       ## meson.build ##
      @@ meson.build: libgit_sources = [
         'transport-helper.c',
     @@ t/perf/p5413-connectivity-check.sh: test_perf_conn () {
       		fi
       	'
       
     --	test_perf "$label" '
     -+	test_perf "$label (full)" '
     +-	test_perf "$label" --prereq PERL '
     ++	test_perf "$label (full)" --prereq PERL '
       		cat '"${name}"'_new |
     - 		git -C '"$name"' rev-list \
     - 			--objects --stdin --not --all --quiet \
     - 			--exclude-promisor-objects
     - 	'
     -+
     -+	test_perf "$label (incremental)" '
     -+		cat '"${name}"'_new |
     -+		git -C '"$name"' rev-list --verify-trees-incremental \
     +-		git -C '"$name"' rev-list \
     ++		git -C '"$name"' rev-list --connectivity-check=full \
      +			--objects --stdin --not --all --quiet \
      +			--exclude-promisor-objects
      +	'
     - }
     - 
     - # Scaling tree size (10 commits, 10 files/commit).
     ++
     ++	test_perf "$label (incremental)" --prereq PERL '
     ++		cat '"${name}"'_new |
     ++		git -C '"$name"' rev-list --connectivity-check=incremental \
     + 			--objects --stdin --not --all --quiet \
     + 			--exclude-promisor-objects
     + 	'
      
       ## t/t5413-connectivity-check.sh (new) ##
      @@
     @@ t/t5413-connectivity-check.sh (new)
      +# Run a connectivity check via rev-list directly.  Uses $mode
      +# (set by the enclosing for-loop) to choose full or incremental.
      +check_connected () {
     -+	flags= &&
     -+	if test "$mode" = incremental
     -+	then
     -+		flags=--verify-trees-incremental
     -+	fi &&
      +	printf '%s\n' "$@" |
     -+	git rev-list $flags \
     ++	git rev-list --connectivity-check="$mode" \
      +		--objects --stdin --not --all --quiet \
      +		--exclude-promisor-objects
      +}
     @@ t/t5413-connectivity-check.sh (new)
      +		git update-ref -d refs/heads/main &&
      +		git update-ref -d HEAD &&
      +
     -+		echo "$original" >.git/test-oid
     ++		echo "$original" >.git/test-oid &&
     ++		echo "$orig_blob" >.git/test-blob
      +	)
      +'
      +
      +missing_oid=$(test_oid missing)
      +original_oid=$(cat replace-test/.git/test-oid)
     ++orig_blob_oid=$(cat replace-test/.git/test-blob)
      +
      +for mode in full incremental
      +do
      +
     ++# The full traversal reports a missing tree as "bad tree object".
     ++case "$mode" in
     ++full)
     ++	missing_tree="bad tree object"
     ++	;;
     ++incremental)
     ++	missing_tree="missing tree object"
     ++	;;
     ++esac
     ++
      +# Corruption detection: craft broken object graphs and verify detection.
      +# All tests use main-repo without modifying its refs or worktree.
      +
     @@ t/t5413-connectivity-check.sh (new)
      +			git mktree --missing) &&
      +		bad_commit=$(git commit-tree "$bad_tree" -p HEAD -m "bad") &&
      +		test_expect_code 128 check_connected "$bad_commit" 2>err &&
     -+		test_grep "missing blob object" err
     ++		test_grep "missing blob object.*$missing_oid" err
      +	)
      +'
      +
     @@ t/t5413-connectivity-check.sh (new)
      +			git mktree --missing) &&
      +		bad_commit=$(git commit-tree "$bad_tree" -p HEAD -m "bad") &&
      +		test_expect_code 128 check_connected "$bad_commit" 2>err &&
     -+		test_grep "bad tree object" err
     ++		test_grep "$missing_tree $missing_oid" err
      +	)
      +'
      +
     @@ t/t5413-connectivity-check.sh (new)
      +		bad_tree=$(printf "100644 blob ${missing_oid}\tfile.txt\n" |
      +			git mktree --missing) &&
      +		test_expect_code 128 check_connected "$bad_tree" 2>err &&
     -+		test_grep "missing blob object" err
     ++		test_grep "missing blob object.*$missing_oid" err
      +	)
      +'
      +
     @@ t/t5413-connectivity-check.sh (new)
      +		export GIT_NO_REPLACE_OBJECTS &&
      +		test_expect_code 128 check_connected \
      +			"$original_oid" 2>err &&
     -+		test_grep "missing blob object" err
     ++		test_grep "missing blob object.*$orig_blob_oid" err
      +	)
      +'
      +
     @@ t/t5413-connectivity-check.sh (new)
      +	)
      +'
      +
     ++test_expect_success "$mode: tolerates missing promisor parent commit" '
     ++	test_when_finished "rm -rf mp-src mp-server.git mp-client" &&
     ++	git init mp-src &&
     ++	test_commit -C mp-src --no-tag base file.txt &&
     ++	git clone --bare mp-src mp-server.git &&
     ++	git -C mp-server.git config uploadpack.allowfilter true &&
     ++	git -C mp-server.git config uploadpack.allowanysha1inwant true &&
     ++	git clone --filter=blob:none \
     ++		"file://$(pwd)/mp-server.git" mp-client &&
     ++	test_commit -C mp-src --no-tag c1 file.txt &&
     ++	test_commit -C mp-src --no-tag c2 file.txt &&
     ++	c1=$(git -C mp-src rev-parse HEAD~1) &&
     ++	c2=$(git -C mp-src rev-parse HEAD) &&
     ++	(
     ++		cd mp-client &&
     ++		# Add a promisor pack holding only c2, so its parent c1
     ++		# is missing but promised (as after a lazy fetch that
     ++		# omits dependents).
     ++		echo "$c2" |
     ++		git -C ../mp-src pack-objects --stdout >c2.pack &&
     ++		git index-pack --promisor --stdin <c2.pack &&
     ++		test_must_fail env GIT_NO_LAZY_FETCH=1 \
     ++			git cat-file -e "$c1" &&
     ++		tree=$(git rev-parse HEAD^{tree}) &&
     ++		local_commit=$(git hash-object -t commit -w --stdin <<-EOF
     ++		tree $tree
     ++		parent $c1
     ++		author A U Thor <author@example.com> 1112912053 -0700
     ++		committer C O Mitter <committer@example.com> 1112912053 -0700
     ++
     ++		on top of a missing promisor commit
     ++		EOF
     ++		) &&
     ++		check_connected "$local_commit"
     ++	)
     ++'
     ++
      +test_expect_success "$mode: respects shallow boundary" '
      +	test_when_finished "rm -rf shallow-src shallow" &&
      +	git init shallow-src &&
     @@ t/t5413-connectivity-check.sh (new)
      +
      +done
      +
     ++# The full check only checks that blobs exist, but the incremental
     ++# check reads their headers and reports a corrupt blob.
     ++test_expect_success 'incremental: rejects corrupt blob' '
     ++	test_when_finished "rm -rf corrupt-repo" &&
     ++	git init corrupt-repo &&
     ++	(
     ++		cd corrupt-repo &&
     ++		test_commit base &&
     ++		blob=$(echo corrupt | git hash-object -w --stdin) &&
     ++		tree=$(printf "100644 blob $blob\tfile\n" | git mktree) &&
     ++		commit=$(git commit-tree "$tree" -p HEAD -m corrupt) &&
     ++		path=.git/objects/$(test_oid_to_path "$blob") &&
     ++		chmod +w "$path" &&
     ++		echo garbage >"$path" &&
     ++		mode=incremental &&
     ++		test_expect_code 128 check_connected "$commit" 2>err &&
     ++		test_grep "unable to read blob object $blob" err
     ++	)
     ++'
     ++
      +# Algorithm selection.
      +
     -+test_expect_success 'invalid transfer.connectivityCheck is rejected' '
     -+	test_when_finished "rm -rf invalid-cfg-src invalid-cfg-dst" &&
     -+	git init invalid-cfg-src &&
     -+	test_commit -C invalid-cfg-src --no-tag base file.txt &&
     -+	git clone invalid-cfg-src invalid-cfg-dst &&
     -+	test_commit -C invalid-cfg-src --no-tag update file.txt updated &&
     -+	git -C invalid-cfg-dst config transfer.connectivityCheck bogus &&
     -+	test_must_fail git -C invalid-cfg-dst fetch origin main 2>err &&
     -+	test_grep "unknown transfer.connectivityCheck" err
     ++# Run a command with its trace2 events in "trace" and its stderr
     ++# in "err".
     ++run_traced () {
     ++	rm -f trace &&
     ++	GIT_TRACE2_EVENT="$(pwd)/trace" "$@" 2>err
     ++}
     ++
     ++# Check which connectivity check the last run_traced used.
     ++expect_mode () {
     ++	case "$1" in
     ++	full)
     ++		test_grep ! trees_loaded trace
     ++		;;
     ++	incremental)
     ++		test_grep trees_loaded trace
     ++		;;
     ++	*)
     ++		BUG "unknown mode: $1"
     ++		;;
     ++	esac
     ++}
     ++
     ++test_expect_success 'setup source repository' '
     ++	git init src &&
     ++	test_commit -C src base file.txt &&
     ++	test_commit -C src --no-tag update file.txt updated
     ++'
     ++
     ++test_expect_success 'unknown transfer.connectivityCheck falls back to full' '
     ++	test_when_finished "rm -rf dst" &&
     ++	git init --bare dst &&
     ++	git -C dst fetch ../src base:refs/heads/main &&
     ++	for value in bogus
     ++	do
     ++		set_connectivity_check dst "$value" &&
     ++		run_traced git -C dst fetch ../src main &&
     ++		expect_mode full &&
     ++		test_grep "unknown transfer.connectivityCheck algorithm .$value., using .full." err ||
     ++		return 1
     ++	done
      +'
      +
      +test_expect_success 'push uses incremental when configured' '
     -+	test_when_finished "rm -rf int-src int-dst.git" &&
     -+	git init int-src &&
     -+	test_commit -C int-src --no-tag base file.txt &&
     -+	git clone --bare int-src int-dst.git &&
     -+	test_commit -C int-src --no-tag update file.txt updated &&
     -+	set_connectivity_check int-dst.git incremental &&
     -+	GIT_TRACE2_EVENT="$(pwd)/push-trace.txt" \
     -+		git -C int-src push ../int-dst.git main &&
     -+	test_trace2_data_singular connectivity trees_loaded 2 \
     -+		<push-trace.txt
     ++	test_when_finished "rm -rf dst" &&
     ++	git init --bare dst &&
     ++	git -C src push ../dst base:refs/heads/main &&
     ++	set_connectivity_check dst incremental &&
     ++	run_traced git -C src push ../dst main &&
     ++	expect_mode incremental
      +'
      +
      +test_expect_success 'fetch uses incremental when configured' '
     -+	test_when_finished "rm -rf fetch-src fetch-dst" &&
     -+	git init fetch-src &&
     -+	test_commit -C fetch-src --no-tag base file.txt &&
     -+	git clone fetch-src fetch-dst &&
     -+	test_commit -C fetch-src --no-tag update file.txt updated &&
     -+	set_connectivity_check fetch-dst incremental &&
     -+	GIT_TRACE2_EVENT="$(pwd)/fetch-trace.txt" \
     -+		git -C fetch-dst fetch origin main &&
     -+	test_trace2_data_singular connectivity trees_loaded 2 \
     -+		<fetch-trace.txt
     ++	test_when_finished "rm -rf dst" &&
     ++	git init --bare dst &&
     ++	git -C dst fetch ../src base:refs/heads/main &&
     ++	set_connectivity_check dst incremental &&
     ++	run_traced git -C dst fetch ../src main &&
     ++	expect_mode incremental
      +'
      +
     -+test_expect_success 'clone respects transfer.connectivityCheck' '
     -+	test_when_finished "rm -rf clone-src clone-dst" &&
     -+	git init clone-src &&
     -+	test_commit -C clone-src --no-tag base file.txt &&
     -+	GIT_TRACE2_EVENT="$(pwd)/clone-trace.txt" \
     -+		git -c transfer.connectivityCheck=incremental \
     -+		clone --no-local clone-src clone-dst &&
     -+	test_trace2_data_singular connectivity trees_loaded 0 \
     -+		<clone-trace.txt
     -+'
     ++for mode in incremental
     ++do
     ++	test_expect_success "push with $mode into an empty repository uses full" '
     ++		test_when_finished "rm -rf dst" &&
     ++		git init --bare dst &&
     ++		set_connectivity_check dst $mode &&
     ++		run_traced git -C src push ../dst main &&
     ++		expect_mode full
     ++	'
     ++
     ++	test_expect_success "clone with $mode uses full" '
     ++		test_when_finished "rm -rf dst" &&
     ++		run_traced git -c transfer.connectivityCheck=$mode \
     ++			clone --no-local src dst &&
     ++		expect_mode full
     ++	'
     ++done
      +
      +test_done
      
     + ## t/t6700-tree-depth.sh ##
     +@@ t/t6700-tree-depth.sh: test_expect_success 'default limit for rev-list fails gracefully' '
     + 	test_must_fail git rev-list --objects big >/dev/null
     + '
     + 
     ++# The incremental check needs a boundary; without negative revisions
     ++# rev-list falls back to the full check.
     ++test_expect_success 'limit recursion of incremental check' '
     ++	boundary=$(git commit-tree $EMPTY_TREE -m boundary) &&
     ++	git $small_ok rev-list --connectivity-check=incremental \
     ++		--objects small --not $boundary >/dev/null &&
     ++	test_must_fail git $small_no rev-list \
     ++		--connectivity-check=incremental --objects small \
     ++		--not $boundary >/dev/null
     ++'
     ++
     ++test_expect_success 'default limit for incremental check fails gracefully' '
     ++	boundary=$(git commit-tree $EMPTY_TREE -m boundary) &&
     ++	test_must_fail git rev-list --connectivity-check=incremental \
     ++		--objects big --not $boundary >/dev/null
     ++'
     ++
     + test_expect_success 'limit recursion of diff-tree -r' '
     + 	git $small_ok diff-tree -r $EMPTY_TREE small &&
     + 	test_must_fail git $small_no diff-tree -r $EMPTY_TREE small
     +
       ## tree-verify.c (new) ##
      @@
      +#include "git-compat-util.h"
     @@ tree-verify.c (new)
      +	TREE_EXPANDED  = 2,
      +};
      +
     ++/* Values are enum tree_state, stored as a byte to keep the map small. */
      +KHASH_INIT(oid_tree, struct object_id, unsigned char, 1,
      +	   oidhash_by_value, oideq_by_value)
      +
     @@ tree-verify.c (new)
      +	struct oid_array parent_trees;
      +};
      +
     ++/* The entries of a tree that still need to be verified. */
     ++struct work_list {
     ++	struct work_item *items;
     ++	size_t nr, alloc;
     ++	bool has_subtrees;
     ++};
     ++
     ++static void work_list_clear(struct work_list *list)
     ++{
     ++	for (size_t i = 0; i < list->nr; i++)
     ++		oid_array_clear(&list->items[i].parent_trees);
     ++	free(list->items);
     ++}
     ++
      +struct verify_state {
      +	kh_oid_tree_t *trees;
      +	struct oidset trusted_blobs;
     -+	int trees_loaded;
     -+	int blobs_checked;
     ++	size_t trees_loaded;
     ++	size_t blobs_checked;
      +	int exclude_promisor_objects;
     ++
     ++	/*
     ++	 * Scratch space for reading one tree at a time.  It lives here
     ++	 * rather than on the stack to keep the frame of the recursive
     ++	 * verify_tree() small.
     ++	 */
     ++	struct tree_desc desc;
     ++	struct name_entry entry;
      +};
      +
      +/*
     @@ tree-verify.c (new)
      + * same-path parent subtrees as recursive comparison bases.
      + * Returns the updated work-list cursor.
      + */
     -+static size_t collect_subtree_bases(struct work_item *work, size_t nr_work,
     -+				    size_t wi, const struct name_entry *entry)
     ++static size_t collect_subtree_bases(struct work_list *list, size_t wi,
     ++				    const struct name_entry *entry)
      +{
     -+	while (wi < nr_work) {
     -+		int cmp = base_name_compare(
     -+			work[wi].entry.path, work[wi].entry.pathlen,
     -+			work[wi].entry.mode,
     -+			entry->path, entry->pathlen,
     -+			entry->mode);
     ++	while (wi < list->nr) {
     ++		struct work_item *item = &list->items[wi];
     ++		int cmp = base_name_compare(item->entry.path,
     ++					    item->entry.pathlen,
     ++					    item->entry.mode,
     ++					    entry->path, entry->pathlen,
     ++					    entry->mode);
      +		if (cmp > 0)
      +			break;
      +		if (cmp < 0) {
      +			wi++;
      +			continue;
      +		}
     -+		if (S_ISDIR(work[wi].entry.mode) &&
     -+		    S_ISDIR(entry->mode))
     -+			oid_array_append(&work[wi].parent_trees,
     -+					 &entry->oid);
     ++		if (S_ISDIR(item->entry.mode) && S_ISDIR(entry->mode))
     ++			oid_array_append(&item->parent_trees, &entry->oid);
      +		return wi + 1;
      +	}
      +	return wi;
      +}
      +
     -+static void verify_blob(struct repository *repo,
     -+			const struct object_id *oid,
     -+			struct verify_state *vs)
     ++/*
     ++ * Report an object that could not be read, telling a missing object
     ++ * apart from one that exists but cannot be read, e.g. because it is
     ++ * corrupt.
     ++ */
     ++static int unreadable_object_error(struct repository *repo,
     ++				   const struct object_id *oid,
     ++				   const char *type)
     ++{
     ++	if (!odb_has_object(repo->objects, oid, 0))
     ++		return error(_("missing %s object %s"), type, oid_to_hex(oid));
     ++	return error(_("unable to read %s object %s"), type, oid_to_hex(oid));
     ++}
     ++
     ++static int verify_blob(struct repository *repo,
     ++		       const struct object_id *oid,
     ++		       struct verify_state *vs)
      +{
      +	int type;
      +
      +	if (oidset_contains(&vs->trusted_blobs, oid))
     -+		return;
     ++		return 0;
      +
      +	vs->blobs_checked++;
      +	type = odb_read_object_info(repo->objects, oid, NULL);
      +	if (type == OBJ_BLOB) {
      +		oidset_insert(&vs->trusted_blobs, oid);
     -+		return;
     ++		return 0;
      +	}
      +	if (type >= 0)
     -+		die(_("object %s is a %s, not a %s"),
     -+		    oid_to_hex(oid), type_name(type), "blob");
     ++		return error(_("object %s is a %s, not a %s"),
     ++			     oid_to_hex(oid), type_name(type), "blob");
      +	if (vs->exclude_promisor_objects &&
      +	    is_promisor_object(repo, oid))
     -+		return;
     -+	die(_("missing blob object '%s'"), oid_to_hex(oid));
     ++		return 0;
     ++	return unreadable_object_error(repo, oid, "blob");
      +}
      +
     -+static void *read_tree_object(struct object_database *odb,
     -+			      const struct object_id *oid,
     -+			      size_t *sizep)
     ++/*
     ++ * Read a tree object into *bufp.  Returns -1 if the object exists
     ++ * but is not a tree.  Otherwise returns 0, leaving *bufp NULL if the
     ++ * object could not be read.
     ++ */
     ++static int read_tree_object(struct object_database *odb,
     ++			    const struct object_id *oid,
     ++			    void **bufp, size_t *sizep)
      +{
      +	enum object_type type;
     -+	void *buf = odb_read_object(odb, oid, &type, sizep);
      +
     -+	if (buf && type != OBJ_TREE) {
     -+		free(buf);
     -+		die(_("object %s is a %s, not a %s"),
     -+		    oid_to_hex(oid), type_name(type), "tree");
     ++	*bufp = odb_read_object(odb, oid, &type, sizep);
     ++	if (*bufp && type != OBJ_TREE) {
     ++		FREE_AND_NULL(*bufp);
     ++		return error(_("object %s is a %s, not a %s"),
     ++			     oid_to_hex(oid), type_name(type), "tree");
      +	}
     -+	return buf;
     ++	return 0;
      +}
      +
     -+static void verify_tree(struct repository *repo,
     -+			const struct object_id *new_tree_oid,
     -+			const struct oid_array *base_trees,
     -+			struct verify_state *vs, int depth)
     ++/* List the entries of a tree that are not yet known to be trusted. */
     ++static void list_untrusted_entries(struct verify_state *vs,
     ++				   const struct object_id *tree_oid,
     ++				   void *tree_buf, size_t tree_size,
     ++				   struct work_list *list)
      +{
     -+	struct tree_desc desc;
     -+	struct name_entry entry;
     -+	struct work_item *work = NULL;
     -+	size_t nr_work = 0, alloc_work = 0;
     -+	int need_subtree_bases = 0;
     -+	size_t i, tree_size;
     -+	void *tree_buf;
     -+
     -+	if (depth > repo->settings.max_allowed_tree_depth)
     -+		die(_("exceeded maximum allowed tree depth"));
     -+
     -+	if (tree_map_get(vs->trees, new_tree_oid) >= TREE_TRUSTED)
     -+		return;
     -+
     -+	tree_buf = read_tree_object(repo->objects, new_tree_oid, &tree_size);
     -+	if (!tree_buf) {
     -+		if (vs->exclude_promisor_objects &&
     -+		    is_promisor_object(repo, new_tree_oid))
     -+			return;
     -+		die(_("bad tree object %s"),
     -+		    oid_to_hex(new_tree_oid));
     -+	}
     -+
     -+	vs->trees_loaded++;
     -+	init_tree_desc(&desc, new_tree_oid, tree_buf, tree_size);
     ++	struct name_entry *entry = &vs->entry;
      +
     -+	while (tree_entry(&desc, &entry)) {
     -+		if (S_ISGITLINK(entry.mode))
     ++	init_tree_desc(&vs->desc, tree_oid, tree_buf, tree_size);
     ++	while (tree_entry(&vs->desc, entry)) {
     ++		if (S_ISGITLINK(entry->mode))
      +			continue;
     -+		if (S_ISDIR(entry.mode)) {
     -+			if (tree_map_get(vs->trees, &entry.oid) >= TREE_TRUSTED)
     ++		if (S_ISDIR(entry->mode)) {
     ++			if (tree_map_get(vs->trees, &entry->oid) >=
     ++			    TREE_TRUSTED)
      +				continue;
     -+			need_subtree_bases = 1;
     ++			list->has_subtrees = true;
      +		} else {
     -+			if (oidset_contains(&vs->trusted_blobs, &entry.oid))
     ++			if (oidset_contains(&vs->trusted_blobs, &entry->oid))
      +				continue;
      +		}
     -+		ALLOC_GROW(work, nr_work + 1, alloc_work);
     -+		memset(&work[nr_work], 0, sizeof(work[nr_work]));
     -+		work[nr_work].entry = entry;
     -+		nr_work++;
     ++		ALLOC_GROW(list->items, list->nr + 1, list->alloc);
     ++		memset(&list->items[list->nr], 0, sizeof(list->items[0]));
     ++		list->items[list->nr++].entry = *entry;
      +	}
     ++}
     ++
     ++/*
     ++ * Scan one trusted base tree: expand it if that has not happened yet,
     ++ * and collect its same-path subtrees as bases for untrusted subtrees.
     ++ */
     ++static int scan_base_tree(struct repository *repo, struct verify_state *vs,
     ++			  const struct object_id *base_oid,
     ++			  struct work_list *list)
     ++{
     ++	int expanded = tree_map_get(vs->trees, base_oid) >= TREE_EXPANDED;
     ++	struct name_entry *entry = &vs->entry;
     ++	size_t wi = 0, base_size;
     ++	void *base_buf;
     ++
     ++	if (expanded && !list->has_subtrees)
     ++		return 0;
      +
     -+	if (!nr_work) {
     -+		free(tree_buf);
     -+		goto done;
     ++	if (read_tree_object(repo->objects, base_oid, &base_buf, &base_size))
     ++		return -1;
     ++	if (!base_buf) {
     ++		if (vs->exclude_promisor_objects &&
     ++		    is_promisor_object(repo, base_oid))
     ++			return 0;
     ++		return unreadable_object_error(repo, base_oid, "tree");
      +	}
      +
     -+	for (i = 0; base_trees && i < base_trees->nr; i++) {
     -+		const struct object_id *base_oid = &base_trees->oid[i];
     -+		int expanded = tree_map_get(vs->trees, base_oid) >= TREE_EXPANDED;
     -+		struct tree_desc base_desc;
     -+		struct name_entry scan_entry;
     -+		size_t wi = 0, base_size;
     -+		void *base_buf;
     ++	vs->trees_loaded++;
     ++	init_tree_desc(&vs->desc, base_oid, base_buf, base_size);
      +
     -+		if (expanded && !need_subtree_bases)
     ++	while (tree_entry(&vs->desc, entry)) {
     ++		if (S_ISGITLINK(entry->mode))
      +			continue;
      +
     -+		base_buf = read_tree_object(repo->objects, base_oid,
     -+					    &base_size);
     -+		if (!base_buf) {
     -+			if (vs->exclude_promisor_objects &&
     -+			    is_promisor_object(repo, base_oid))
     -+				continue;
     -+			die(_("bad tree object %s"),
     -+			    oid_to_hex(base_oid));
     ++		/* Same-path subtree as a base for an untrusted one. */
     ++		if (list->has_subtrees)
     ++			wi = collect_subtree_bases(list, wi, entry);
     ++
     ++		/* Expand: the base is trusted, so are its entries. */
     ++		if (!expanded) {
     ++			if (S_ISDIR(entry->mode))
     ++				tree_map_add(vs->trees, &entry->oid,
     ++					     TREE_TRUSTED);
     ++			else
     ++				oidset_insert(&vs->trusted_blobs,
     ++					      &entry->oid);
      +		}
     ++	}
      +
     -+		vs->trees_loaded++;
     -+		init_tree_desc(&base_desc, base_oid, base_buf, base_size);
     ++	if (!expanded)
     ++		tree_map_add(vs->trees, base_oid, TREE_EXPANDED);
      +
     -+		while (tree_entry(&base_desc, &scan_entry)) {
     -+			if (S_ISGITLINK(scan_entry.mode))
     -+				continue;
     ++	free(base_buf);
     ++	return 0;
     ++}
      +
     -+			if (need_subtree_bases)
     -+				wi = collect_subtree_bases(work, nr_work,
     -+							   wi, &scan_entry);
     -+
     -+			if (!expanded) {
     -+				if (S_ISDIR(scan_entry.mode))
     -+					tree_map_add(vs->trees,
     -+						     &scan_entry.oid,
     -+						     TREE_TRUSTED);
     -+				else
     -+					oidset_insert(&vs->trusted_blobs,
     -+						      &scan_entry.oid);
     -+			}
     -+		}
     ++/*
     ++ * Verify a tree against the trusted base trees, loading as little as
     ++ * possible:
     ++ *
     ++ * First list the entries that are not yet known to be trusted.  When
     ++ * the parent trees have been expanded before, only the changed entries
     ++ * remain.
     ++ *
     ++ * Then scan the trusted base trees (the same-path trees of the parent
     ++ * commits).  A base that has not been expanded yet is read so that its
     ++ * entries can be marked trusted; this often shows that listed entries
     ++ * are trusted after all.  An already expanded base is still read when
     ++ * there are untrusted subtrees, because its subtree at the same path is
     ++ * what lets the untrusted subtree skip its own unchanged entries in
     ++ * turn.
     ++ *
     ++ * Finally check that the remaining blobs exist, and recurse into the
     ++ * remaining subtrees with the same-path subtrees as their bases.
     ++ */
     ++static int verify_tree(struct repository *repo,
     ++		       const struct object_id *tree_oid,
     ++		       const struct oid_array *trusted_bases,
     ++		       struct verify_state *vs, int depth)
     ++{
     ++	struct work_list list = { 0 };
     ++	size_t i, tree_size;
     ++	void *tree_buf;
     ++	int ret = 0;
     ++
     ++	/*
     ++	 * Enforce core.maxTreeDepth like process_tree() in list-objects.c,
     ++	 * so that the full and incremental checks reject the same trees.
     ++	 */
     ++	if (depth > repo->settings.max_allowed_tree_depth)
     ++		return error(_("exceeded maximum allowed tree depth"));
     ++
     ++	if (tree_map_get(vs->trees, tree_oid) >= TREE_TRUSTED)
     ++		return 0;
      +
     -+		if (!expanded)
     -+			tree_map_add(vs->trees, base_oid, TREE_EXPANDED);
     ++	if (read_tree_object(repo->objects, tree_oid, &tree_buf, &tree_size))
     ++		return -1;
     ++	if (!tree_buf) {
     ++		/*
     ++		 * A missing tree that is promised can be fetched on demand,
     ++		 * so it is not an error, as in the full check.
     ++		 */
     ++		if (vs->exclude_promisor_objects &&
     ++		    is_promisor_object(repo, tree_oid))
     ++			return 0;
     ++		return unreadable_object_error(repo, tree_oid, "tree");
     ++	}
     ++
     ++	vs->trees_loaded++;
     ++	list_untrusted_entries(vs, tree_oid, tree_buf, tree_size, &list);
      +
     -+		free(base_buf);
     ++	/* Scan the base trees, unless nothing is left to verify. */
     ++	for (i = 0; list.nr && i < trusted_bases->nr; i++) {
     ++		ret = scan_base_tree(repo, vs, &trusted_bases->oid[i], &list);
     ++		if (ret)
     ++			goto done;
      +	}
      +
     -+	for (i = 0; i < nr_work; i++) {
     -+		if (S_ISDIR(work[i].entry.mode))
     -+			verify_tree(repo, &work[i].entry.oid,
     -+				    &work[i].parent_trees, vs,
     -+				    depth + 1);
     ++	/*
     ++	 * Check the remaining entries in tree order.  Verifying a subtree
     ++	 * can show that later entries are trusted, which then makes them
     ++	 * cheap to skip.
     ++	 */
     ++	for (i = 0; i < list.nr && !ret; i++) {
     ++		struct work_item *item = &list.items[i];
     ++
     ++		if (S_ISDIR(item->entry.mode))
     ++			ret = verify_tree(repo, &item->entry.oid,
     ++					  &item->parent_trees, vs, depth + 1);
      +		else
     -+			verify_blob(repo, &work[i].entry.oid, vs);
     ++			ret = verify_blob(repo, &item->entry.oid, vs);
      +	}
     -+
     -+	free(tree_buf);
     ++	if (!ret)
     ++		tree_map_add(vs->trees, tree_oid, TREE_EXPANDED);
      +
      +done:
     -+	tree_map_add(vs->trees, new_tree_oid, TREE_EXPANDED);
     -+	for (i = 0; i < nr_work; i++)
     -+		oid_array_clear(&work[i].parent_trees);
     -+	free(work);
     ++	free(tree_buf);
     ++	work_list_clear(&list);
     ++	return ret;
      +}
      +
     -+static void verify_commit_tree(struct repository *repo,
     -+			       struct commit *commit,
     -+			       struct verify_state *vs)
     ++static int verify_commit_tree(struct repository *repo,
     ++			      struct commit *commit,
     ++			      struct verify_state *vs)
      +{
     -+	struct oid_array base_trees = OID_ARRAY_INIT;
     ++	struct oid_array parent_trees = OID_ARRAY_INIT;
      +	const struct object_id *tree_oid;
      +	struct commit_list *p;
     ++	int ret;
      +
      +	/*
      +	 * Parent trees are trusted: boundary parents are already
      +	 * connected, and earlier incoming parents were verified
      +	 * first due to the topological processing order.
     ++	 *
     ++	 * The revision walk skips missing parents that are promised
     ++	 * (see process_parents()), so do the same here.  Such a parent
     ++	 * contributes no base, which only means less of the new tree
     ++	 * can be skipped.
      +	 */
      +	for (p = commit->parents; p; p = p->next) {
     -+		parse_commit_or_die(p->item);
     ++		if (repo_parse_commit_gently(repo, p->item, 1) < 0) {
     ++			if (vs->exclude_promisor_objects &&
     ++			    is_promisor_object(repo, &p->item->object.oid))
     ++				continue;
     ++			ret = error(_("unable to parse commit %s"),
     ++				    oid_to_hex(&p->item->object.oid));
     ++			goto out;
     ++		}
      +		tree_oid = get_commit_tree_oid(p->item);
     -+		if (!tree_oid)
     -+			die(_("unable to load root tree for commit %s"),
     -+			    oid_to_hex(&p->item->object.oid));
     ++		if (!tree_oid) {
     ++			ret = error(_("unable to load root tree for commit %s"),
     ++				    oid_to_hex(&p->item->object.oid));
     ++			goto out;
     ++		}
      +		tree_map_add(vs->trees, tree_oid, TREE_TRUSTED);
     -+		oid_array_append(&base_trees, tree_oid);
     ++		oid_array_append(&parent_trees, tree_oid);
      +	}
      +
      +	tree_oid = get_commit_tree_oid(commit);
     -+	if (!tree_oid)
     -+		die(_("unable to load root tree for commit %s"),
     -+		    oid_to_hex(&commit->object.oid));
     -+	verify_tree(repo, tree_oid, &base_trees, vs, 0);
     -+	oid_array_clear(&base_trees);
     ++	if (!tree_oid) {
     ++		ret = error(_("unable to load root tree for commit %s"),
     ++			    oid_to_hex(&commit->object.oid));
     ++		goto out;
     ++	}
     ++	ret = verify_tree(repo, tree_oid, &parent_trees, vs, 0);
     ++out:
     ++	oid_array_clear(&parent_trees);
     ++	return ret;
      +}
      +
     -+void verify_commits_incremental(struct repository *repo,
     -+				struct commit_list **commits,
     -+				int exclude_promisor_objects)
     ++int verify_commits_incremental(struct repository *repo,
     ++			       struct commit_list **commits,
     ++			       int exclude_promisor_objects)
      +{
      +	struct verify_state vs = { 0 };
      +	struct commit_list *iter;
      +	unsigned nr_before;
     ++	int ret = 0;
      +
      +	if (repo->fetch_if_missing)
      +		BUG("verify_commits_incremental must not be called "
     @@ tree-verify.c (new)
      +	 */
      +	nr_before = commit_list_count(*commits);
      +	sort_in_topological_order(commits, REV_SORT_IN_GRAPH_ORDER);
     -+	if (commit_list_count(*commits) < nr_before)
     -+		die(_("cycle detected in incoming commit graph"));
     ++	if (commit_list_count(*commits) < nr_before) {
     ++		ret = error(_("cycle detected in incoming commit graph"));
     ++		goto out;
     ++	}
      +
      +	*commits = commit_list_reverse(*commits);
      +
     -+	for (iter = *commits; iter; iter = iter->next)
     -+		verify_commit_tree(repo, iter->item, &vs);
     ++	for (iter = *commits; iter && !ret; iter = iter->next)
     ++		ret = verify_commit_tree(repo, iter->item, &vs);
      +
     ++out:
      +	kh_destroy_oid_tree(vs.trees);
      +	oidset_clear(&vs.trusted_blobs);
      +	trace2_data_intmax("connectivity", repo,
     -+			   "trees_loaded", vs.trees_loaded);
     ++			   "trees_loaded", (intmax_t)vs.trees_loaded);
      +	trace2_data_intmax("connectivity", repo,
     -+			   "blobs_checked", vs.blobs_checked);
     ++			   "blobs_checked", (intmax_t)vs.blobs_checked);
     ++	return ret;
      +}
      
       ## tree-verify.h (new) ##
     @@ tree-verify.h (new)
      +
      +/*
      + * Verify trees of commits incrementally against their parents.
     -+ * Dies on verification failure.
     ++ * Returns 0 on success, or reports an error and returns -1.
      + */
     -+void verify_commits_incremental(struct repository *repo,
     -+				struct commit_list **commits,
     -+				int exclude_promisor_objects);
     ++int verify_commits_incremental(struct repository *repo,
     ++			       struct commit_list **commits,
     ++			       int exclude_promisor_objects);
      +
      +#endif /* TREE_VERIFY_H */
 -:  ---------- > 6:  f6031967e6 connected: add "auto" connectivity check mode

-- 
gitgitgadget
