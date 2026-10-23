Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761123;
	b=HF20zNnhPdl663zqKvRLaSzqW2uq0M9wzZ1Ae78IoOQap91MRvehJtPGVaGn6qwlWS+u
	 jTcmm192axgiCKUdiQrPlacNAsNSIdZUjM8rituk6WKUx0gvlJc5ClGN1IIFWCI72oXYX
	 FtpL1xjioGwo1JVxq/nk6rD/KV8UWbqmExK8IxuI7vkrt10zcKD9rhGJxRd5T1ERc+iEn
	 FurLiZnIMjUQp41PrZ/FwM/h2eOoU3E/0ghnjVH6dl6Dg0Eln/YUQ/QsHxKjj6Hx0axHM
	 eNERthlMcKABJDOrpi6Dk9lr0coNBdwkIBbpk5Bjjemu4BlSwCZY9Kiun9X+M+NITzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=MvEKjnStZDXqOypVWhXVCLVRqB9pZ/g5OxJ6Aq8KZ4c=;
	b=l05eXrQX9noQTARzyzE5cMtJbN4eu+IQbuYTdcF3G844cRe96439q7OYIHC41kfaVR2x
	 RG5NIp9h/RkZYuYbYLF7cOpL4Xel2la6xH+PDvgqfQgkArvwfzzFHHaJTcYiiYa+xUPm1
	 uSqIaIz9eUGrzSUG3rSppJvjHcQi300JH8fDuhTUYuFIbl9mYanF0Zl8IR/dyo8hkoNIx
	 2JAHiEYGgmKxM0H7Kht9HEbHGJA1g9LXPqCd68ltDYbskq3R5nxcmH7GYs9M2PMpM+YfR
	 5QRliXpx3Ta3woCgQJ+lWCc6/LP2kvevhDubiMaOeW8yZ65/BgZwaGc4JyxejwhcOPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qM7LphM9;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFF3606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EFF3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qM7LphM9
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93e4c00d71aso79422185a.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792761122; x=1793365922; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MvEKjnStZDXqOypVWhXVCLVRqB9pZ/g5OxJ6Aq8KZ4c=;
        b=qM7LphM92QLTpfccmiSkqrMA1th+R/uO9BxTpzVnKgXHxn5cCq59znhG5NDRkFsUGq
         wvyWlSVn9LOjrOSnTn1PBoN9byIN5UJbJBZVo3jcDErvlNJGdyiWlyw4Wf7YWr09NYNo
         rxJvqKzlCl6IF0uULAalFB5ddmz153keFlN6KjtETFOA9BEbm4nuqF8TorOEk3otud1F
         hDeqKV9BB/06f37PnnMjOt8BI6CISoDsqJIrMMQ0299pVDC9Hd6cdOvZwgtGZ1PmD3fF
         HUDY1elyDKPQ4zJJs2RwElUjRUgr34nkh9sg4nYJtMdvR7Wix1hX+tuoTK4Ykj5TNXi3
         GBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792761122; x=1793365922;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MvEKjnStZDXqOypVWhXVCLVRqB9pZ/g5OxJ6Aq8KZ4c=;
        b=1fI0NFdPqkzWy6Pfe7p8+fCwVbpwf6EYTZpunq4jl6cd+xWViPDebRl1aBQPRJCgYb
         dLp5mJT8wdQyvGNKinaBmnyHASwEH7rR98M9R9qjtOjeEKtkfWgXS5RDT7Oh9z4kYjhB
         KJD9P5Na5aCFX4JzF0qHzb8Ofi9Y7j49HU3OgrrPe/Je/NVr2pPNLKUNiAtVtEfBdeHB
         lpuiHZ9iS4rMzC9AZI/pwVTqnESGEsX5RxEjojtyDr3wg499Mw5FVkwK5s2W9VTN9sIP
         KPbmVMYoTJevQ0y9c/fEUQg+0nuRvu6otTuULe8gFTY3Il0ZTjh865Iy1psDuOFrcIIF
         F7Hg==
X-Gm-Message-State: AFq9FYJVtqAKenFaV7oaw+6Zip+sMVSRd+L3hDefGXrNVjUXbWxg+Ev4
	vcB9YWM39RKckoqh6E2Akw2Z2SzbrMn/wKytDzrsKehL35jCp170vS0mUwBLWfhP
X-Gm-Gg: AYBFou2/aZeN6GwgVSA467faXCgGSYxTHVoIMzjRL1tDTwsTotn1KAfn69J4G3Jig4h
	96B+C7/4PJuWbrXGgy2ViX+nBH1b5SQWGveMlV6xq8aFB2c27ZLi8WRDalj39OiK5oLRyJ35/yV
	k3s3RheK2Hhteb/ISMqxMgM+05po1k78qEcZdK4dZxz/pETQ8+X8tL/A7zf3+apshfkS8u94agu
	0kX5QyDROERDYYLfhX+YFsk4k7QCDzqQ2Ot+U1keOEZ4c66OkM1P8d/TvEMVL8xrCgSzMnA7Ntp
	J3waOIZPeCv9m1AiTJab/BPjEgAnM21XikQVc6a9rDwuKHZayoOD/OD6lV94lfSF0T9VT/B7Ogo
	BwvYtXRyswt9+yEmwr6vxvuTFZPGi5OGDpHiJsXIqzqrqTsmitRg4ni9dyDKvDioCTWjod6gACa
	Qj+koC3O1VJR+xJWowsc2VuKlJYT2CAu7NMZX7O9w0dSeCKXm9eEiztQ3slxZQr8UFmhnKJCGnu
	6rJptYgcW73JnEe/OPvy5yXFX2v0L8HMvS0hY0U1CylwlWeWiRP0rxJ8eE=
X-Received: by 2002:a05:620a:4444:b0:93e:66db:69b9 with SMTP id af79cd13be357-93f6f7df948mr381819685a.55.1792761121847;
        Fri, 23 Oct 2026 06:12:01 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.86.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9402ee30498sm15836485a.3.2026.10.23.06.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:12:00 -0700 (PDT)
Message-Id: <pull.2211.v5.git.1792761119.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 13:11:53 +0000
Subject: [PATCH v5 0/6] connected: add incremental connectivity check
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
Cc: Kristofer Karlsson <krka@spotify.com>

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


Changes since v4
================

 * The series no longer touches repo->fetch_if_missing, which Junio pointed
   out was a trap when cleared only for some modes. The incremental verifier
   instead reads blobs and trees with odb_read_object_info_extended() and
   OBJECT_INFO_SKIP_FETCH_OBJECT, so it never lazily fetches on its own;
   commit parsing already never fetches. The BUG() guard on the flag is
   gone, and parse_connectivity_check() no longer takes a repository. The
   full check is unchanged: in a partial clone check_connected() passes
   --exclude-promisor-objects as before.
 * A tree that cannot be read because it is corrupt is now reported as an
   error, like a corrupt blob, instead of dying.


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

cc: Kristofer Karlsson krka@spotify.com cc: Patrick Steinhardt ps@pks.im

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
 builtin/rev-list.c                            |  73 ++
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
 tree-verify.c                                 | 433 ++++++++++
 tree-verify.h                                 |  15 +
 22 files changed, 1842 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/technical/connectivity-check.adoc
 create mode 100644 t/perf/generate-repo-p5413-connectivity-check.perl
 create mode 100755 t/perf/p5413-connectivity-check.sh
 create mode 100755 t/t5413-connectivity-check.sh
 create mode 100644 tree-verify.c
 create mode 100644 tree-verify.h


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2211%2Fspkrka%2Ftree-diff-connectivity-v1-clean-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2211/spkrka/tree-diff-connectivity-v1-clean-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2211

Range-diff vs v4:

 1:  e25824c21d = 1:  e25824c21d Documentation: describe connectivity checking
 2:  427b7315a5 = 2:  427b7315a5 p5413: add perf tests for connectivity check
 3:  3a7a1fb953 = 3:  3a7a1fb953 connected: drop dependency on `the_repository`
 4:  87dbb1f055 ! 4:  7ef572bc05 connected: add transfer.connectivityCheck config
     @@ builtin/rev-list.c
      +	enum connectivity_check_mode mode;
      +};
      +
     -+static void parse_connectivity_check(struct repository *repo UNUSED,
     -+				     const char *arg,
     ++static void parse_connectivity_check(const char *arg,
      +				     struct connectivity_check *check)
      +{
      +	if (!strcmp(arg, "full"))
     @@ builtin/rev-list.c: int cmd_rev_list(int argc,
       			repo->fetch_if_missing = 0;
       			revs.exclude_promisor_objects = 1;
      +		} else if (skip_prefix(arg, "--connectivity-check=", &arg)) {
     -+			parse_connectivity_check(repo, arg, &connectivity_check);
     ++			parse_connectivity_check(arg, &connectivity_check);
       		} else if (skip_prefix(arg, "--missing=", &arg)) {
       			parse_missing_action_value(repo, arg);
       		} else if (!strcmp(arg, "--missing-only")) {
 5:  d76dae801b ! 5:  9e84dd5c32 connected: add incremental connectivity check via rev-list
     @@ builtin/rev-list.c
       };
       
       struct connectivity_check {
     - 	enum connectivity_check_mode mode;
     - };
     - 
     --static void parse_connectivity_check(struct repository *repo UNUSED,
     -+static void parse_connectivity_check(struct repository *repo,
     - 				     const char *arg,
     - 				     struct connectivity_check *check)
     +@@ builtin/rev-list.c: static void parse_connectivity_check(const char *arg,
       {
       	if (!strcmp(arg, "full"))
       		check->mode = CONNECTIVITY_CHECK_FULL;
     @@ builtin/rev-list.c
      +		check->mode = CONNECTIVITY_CHECK_INCREMENTAL;
       	else
       		die(_("unknown --connectivity-check mode '%s'"), arg);
     -+
     -+	if (check->mode != CONNECTIVITY_CHECK_FULL)
     -+		repo->fetch_if_missing = 0;
       }
     - 
     - struct rev_list_info {
      @@ builtin/rev-list.c: int cmd_rev_list(int argc,
       
       	prepare_maximal_independent(&revs);
     @@ tree-verify.c (new)
      +		       const struct object_id *oid,
      +		       struct verify_state *vs)
      +{
     -+	int type;
     ++	struct object_info oi = OBJECT_INFO_INIT;
     ++	enum object_type type;
      +
      +	if (oidset_contains(&vs->trusted_blobs, oid))
      +		return 0;
      +
      +	vs->blobs_checked++;
     -+	type = odb_read_object_info(repo->objects, oid, NULL);
     -+	if (type == OBJ_BLOB) {
     -+		oidset_insert(&vs->trusted_blobs, oid);
     -+		return 0;
     ++	oi.typep = &type;
     ++	if (odb_read_object_info_extended(repo->objects, oid, &oi,
     ++					  OBJECT_INFO_LOOKUP_REPLACE |
     ++					  OBJECT_INFO_SKIP_FETCH_OBJECT)) {
     ++		if (vs->exclude_promisor_objects &&
     ++		    is_promisor_object(repo, oid))
     ++			return 0;
     ++		return unreadable_object_error(repo, oid, "blob");
      +	}
     -+	if (type >= 0)
     ++	if (type != OBJ_BLOB)
      +		return error(_("object %s is a %s, not a %s"),
      +			     oid_to_hex(oid), type_name(type), "blob");
     -+	if (vs->exclude_promisor_objects &&
     -+	    is_promisor_object(repo, oid))
     -+		return 0;
     -+	return unreadable_object_error(repo, oid, "blob");
     ++	oidset_insert(&vs->trusted_blobs, oid);
     ++	return 0;
      +}
      +
      +/*
     @@ tree-verify.c (new)
      +			    const struct object_id *oid,
      +			    void **bufp, size_t *sizep)
      +{
     ++	struct object_info oi = OBJECT_INFO_INIT;
      +	enum object_type type;
      +
     -+	*bufp = odb_read_object(odb, oid, &type, sizep);
     ++	oi.typep = &type;
     ++	oi.sizep = sizep;
     ++	oi.contentp = bufp;
     ++	if (odb_read_object_info_extended(odb, oid, &oi,
     ++					  OBJECT_INFO_LOOKUP_REPLACE |
     ++					  OBJECT_INFO_SKIP_FETCH_OBJECT))
     ++		*bufp = NULL;
      +	if (*bufp && type != OBJ_TREE) {
      +		FREE_AND_NULL(*bufp);
      +		return error(_("object %s is a %s, not a %s"),
     @@ tree-verify.c (new)
      +	unsigned nr_before;
      +	int ret = 0;
      +
     -+	if (repo->fetch_if_missing)
     -+		BUG("verify_commits_incremental must not be called "
     -+		    "with fetch_if_missing set");
     -+
      +	vs.trees = kh_init_oid_tree();
      +	vs.exclude_promisor_objects = exclude_promisor_objects;
      +
 6:  f6031967e6 ! 6:  98f67caa04 connected: add "auto" connectivity check mode
     @@ builtin/rev-list.c
      +	unsigned long max_commits;
       };
       
     - static void parse_connectivity_check(struct repository *repo,
     - 				     const char *arg,
     + static void parse_connectivity_check(const char *arg,
       				     struct connectivity_check *check)
       {
      +	const char *cutoff;
     @@ builtin/rev-list.c
      +		check->mode = CONNECTIVITY_CHECK_AUTO;
       	else
       		die(_("unknown --connectivity-check mode '%s'"), arg);
     - 
     + }
      @@ builtin/rev-list.c: int cmd_rev_list(int argc,
       	int bisect_find_all = 0;
       	int use_bitmap_index = 0;

-- 
gitgitgadget
