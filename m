Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E702236F7
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600561; cv=none; b=BPd6eVnm2Jlq9K4KgIxZ9ABaanuMeENdXrbrjEaWtjrB6EThI8+xqOKnORLSdsh73NCKcU1cqjRCeXid7gRw1sjPS0kTLQTBfL7Pd3glXL5Hp2a//W4m178hZhWMcvY/aztYXSOsUUdrR2Tb7wq+sWDKJAO2SNXrt9pFgIgm418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600561; c=relaxed/simple;
	bh=O3VhmSPnlINblw2xkzQXFSdHgnMBoMrqWTUZhNgxJw4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LGoW1GVM/GcL+F4eFzfP+VzjipUEa37csxWaPcuSwSMd/vRURk8E7Q1JOE3EEWAUJvdYexpZIfzSKTX0WK4o0uXyIpxvx5FsRQRmPQOMc9t+XZY5NN87wlqXBQxO5jlaAiv6EjQj9RdtfvbgBUeCw8eUnM0l5TqtvxC78PxyarE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcW0F0O+; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcW0F0O+"
Received: by mail-qk2-f39.google.com with SMTP id af79cd13be357-93c632d5d42so121187585a.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790600559; x=1791205359; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oy5MwsFAerYLn8YmSTdGLqPoceHYYHbmepnczF2Itrs=;
        b=QcW0F0O+GDkHOpk15LIpFy7667sqAPFQtCRiu9g7dp0nvsBPTgccP30n61BTswAh2h
         arm9u7EejjWXeKSGuDRQG4BvU5VoqSNQ6CeQsEeF+yDVNUg5Iiz9ieuHGs4Ugs2VZxNv
         kdkKY8KkAHhSmFSKZDehl7QyZ4EGOcKFG+j0E/JorcTIq1ZrLZxctFiLkPf/46Zcg9qH
         zPHqQ9VyjwMWJ8zKxrZ3Z8ZDRkVejurVxuWV6SolfZnE85HbDXeQluGzKYJ88YfWjssC
         4Tsn8i8gPKcKUqate2FYUSAdTxPNu6q+pGzD/MGy8Y/kgieVdQCzLd/Pyj2AM8tulUZh
         h9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790600559; x=1791205359;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oy5MwsFAerYLn8YmSTdGLqPoceHYYHbmepnczF2Itrs=;
        b=o3MO9fOlBXkaTsAhaH2p7a/3VdAMe1rEYeOr6iyEKxOoZmLwjXBB9amP2vjrF0haDX
         m2nbzCXCEJi6L7vK7doNe9kIZGs6RbW5G6hCU95eN1ng+o6BoiTn0xniQXELHiAwT3Fi
         kcVizqY4R7i6NZNy6E8X8iushfxycA723SUoRfPIDBb9+tHwIrSeFXtz3aNqlumBt9My
         oxnLbJTW2JbGgpphosuHFAxRa7Zv28TZwkTKIIU8J/KL16xj0u77B1b2UNisqe7oJNws
         wHY/SAEVml8/SQwxqIjhpefafNezoYrwWqMR2a6pr02rq/JdymSFfh5jCyqGg0mxViTR
         8LGQ==
X-Gm-Message-State: AFuF++lVEbzGfwS8mjtJRlTDTgEdls6cs2xr4T0C7X3cANvkNmorA5cS
	TNKNDiH3D9gtrg71Tc/GBg3Dr146jNpQ6SLu2o9ok7XlkWNthuk0T9WD5y9DJEOv
X-Gm-Gg: AYBFou39WG4GoOKxBOknzc8QQuKQKyAaWmKUqEPWsVtZhit3w3FluEk+iyJbg4dtGH6
	npeJM8LCUB6FKQnFUO9NTXdkAT2rJI2assxlaU7OXutWS5IwNqJIPpXhJdkkReWft+fK8veoE/H
	nn0ZS2Z8eJ9cmEM5WgHBznnRKdWXsrlGgUrzVL2CPPZrm/S2YmCUMqINyLjEisVMBajRXGsGf4g
	MePXrmpT8JVm3GlyPNlqMjqofT229CPzh4JJygPfb1hv64ZbDjb7IWuEE2vGmCh12QL7/oJ1FsJ
	FVQe4yJA0XHUjeodjbWFxftGUEbKwJNf6ri2ahNo5V99sULqox8mwUpq8eANLSJ6yXf0TmxQFAh
	TjQMmFc0fIoH0HQwTxnftZsWzfPr3joWCXO1Wx524RFjFkX3dY87ikftmBROdOx30yJpvDSAamt
	jherYM1v7F/o2joIp3GaU6vi5XRyLpGW2ZuSlUTBApbKvKoykLdNxZuTn+oXIRzQQFf1FuYkFI
X-Received: by 2002:a05:620a:6493:b0:939:6dfc:8abd with SMTP id af79cd13be357-93c43d0ccc4mr2061692085a.52.1790600553538;
        Mon, 28 Sep 2026 06:02:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.47.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c813dca59sm142073985a.22.2026.09.28.06.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:02:32 -0700 (PDT)
Message-Id: <pull.2211.v2.git.1790600552.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 13:02:30 +0000
Subject: [PATCH v2 0/2] connected: add incremental connectivity check
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

This series adds an incremental mode for the connectivity check, gated
behind transfer.connectivityCheck=incremental (no expected changes unless
you opt in).

The intent is to solve the problem of the connectivity check slowing down as
the number of reachable objects from the boundary grows.

It relates to the RFC I sent out earlier:

[RFC] check_connected: toward incoming-proportional cost
https://lore.kernel.org/git/CAL71e4Nf=-zCrfN7ghEVGq11irajJhtdxYZgKe0Ycux0qs1ZvQ@mail.gmail.com/



Design
======

The verifier runs inside the same rev-list subprocess that check_connected()
already spawns, triggered by a new internal flag --verify-trees-incremental.
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
the commit message. The incremental mode is faster than the full mode when
there are few commits to verify and when the active object tree is large. In
the happy case, the work tracks the changed paths and their comparison trees
rather than the full reachable object closure, which substantially reduces
the dependence on total repository size. I've seen speedups up to around 20x
for the synthetic perf tests.

Running against a large real-world repo (3.4 GB boundary closure), the
numbers are more dramatic. All timings use rev-list directly with --not
HEADN, isolating the tree verification cost from the boundary-finding cost:

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
touched, incremental remains competitive; bypassing the object cache for
tree reads likely helps here.

I cannot establish how common these regression cases are. In the cases I
have tested, however, the regression has remained modest; I have not been
able to provoke a substantially larger slowdown. My feeling is that this is
an acceptable tradeoff behind the opt-in config, since the target case
(small pushes to large repos) sees the largest speedup, while the regression
appears with long incoming histories.

A safety net for this regression could be to dynamically disable the
incremental mode if the number of incoming commits is too large, but this is
left out of the initial version to avoid overly speculative code.

Deepening fetches currently fall back to the full check because the full
check omits --not --all for deepening -- there is no existing-reference
boundary at which the walk can stop. An incremental approach is possible
here too -- using the old shallow roots as the trusted boundary and walking
the deepened ancestry forward -- but that is a separate change and left for
future work. Deepening is also less common than regular fetch and
receive-pack, where the speedup matters most.


Test coverage
=============

Most correctness cases in t5412-connectivity-check.sh are run in both full
and incremental modes to check semantic equivalence. Selected cases
additionally assert trace2 tree/blob counts for the incremental mode, to
verify that unchanged portions of the object graph are actually skipped. It
covers:

 * Corruption detection: missing blobs, missing trees, type mismatches,
   malformed trees (unparseable, mid-tree corruption)
 * Tree optimization: trace2 assertions confirm unchanged subtrees are
   skipped, subtree moves, merge parent boundaries
 * Root commits (no parents -- verifies full tree closure)
 * Partial clones: missing promised blobs, missing promised trees,
   verification of local commits
 * Replacement objects (with and without GIT_NO_REPLACE_OBJECTS)
 * Shallow boundaries
 * Deepening fetches (falls back to full check)
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
already disables lazy fetching, die() is isolated by the process boundary,
shallow and replacement semantics are established before the verifier runs,
and error routing comes for free via stderr.

So while I liked the idea of being less reliant on checking within a
subprocess, making that work ended up being a lot more complex.


Next steps
==========

This series only addresses tree verification; the other significant cost is
finding the commit boundary, especially for repos with many refs. I already
have some prototypes for optimizing that too, and if this ends up landing,
that would be something I would start polishing up.


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

Kristofer Karlsson (2):
  Documentation: describe connectivity checking
  connected: add incremental connectivity check via rev-list

 Documentation/config/transfer.adoc            |  20 +
 Documentation/rev-list-options.adoc           |   6 +
 .../technical/connectivity-check.adoc         | 243 +++++++
 Makefile                                      |   1 +
 builtin/rev-list.c                            |  19 +
 connected.c                                   |  24 +
 meson.build                                   |   1 +
 t/meson.build                                 |   1 +
 ...enerate-repo-p5412-connectivity-check.perl |  44 ++
 t/perf/p5412-connectivity-check.sh            |  92 +++
 t/t5412-connectivity-check.sh                 | 680 ++++++++++++++++++
 tree-verify.c                                 | 316 ++++++++
 tree-verify.h                                 |  15 +
 13 files changed, 1462 insertions(+)
 create mode 100644 Documentation/technical/connectivity-check.adoc
 create mode 100644 t/perf/generate-repo-p5412-connectivity-check.perl
 create mode 100755 t/perf/p5412-connectivity-check.sh
 create mode 100755 t/t5412-connectivity-check.sh
 create mode 100644 tree-verify.c
 create mode 100644 tree-verify.h


base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2211%2Fspkrka%2Ftree-diff-connectivity-v1-clean-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2211/spkrka/tree-diff-connectivity-v1-clean-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2211

Range-diff vs v1:

 1:  e55c5452db = 1:  97c11449ae Documentation: describe connectivity checking
 2:  ebe6c90cc5 ! 2:  6ad528f4bb connected: add incremental connectivity check via rev-list
     @@ builtin/rev-list.c: int cmd_rev_list(int argc,
       			revs.exclude_promisor_objects = 1;
      +		} else if (!strcmp(arg, "--verify-trees-incremental")) {
      +			verify_trees_incremental = 1;
     ++			repo->fetch_if_missing = 0;
       		} else if (skip_prefix(arg, "--missing=", &arg)) {
       			parse_missing_action_value(repo, arg);
       		} else if (!strcmp(arg, "-z")) {
     @@ t/t5412-connectivity-check.sh (new)
      +	)
      +'
      +
     ++test_expect_success "$mode: does not lazy-fetch promised blob" '
     ++	test_when_finished "rm -rf nofetch-src nofetch-server.git nofetch-client" &&
     ++	git init nofetch-src &&
     ++	test_commit -C nofetch-src --no-tag base file.txt content &&
     ++	git clone --bare nofetch-src nofetch-server.git &&
     ++	git -C nofetch-server.git config uploadpack.allowfilter true &&
     ++	git -C nofetch-server.git config uploadpack.allowanysha1inwant true &&
     ++	git clone --no-checkout --filter=blob:none \
     ++		"file://$(pwd)/nofetch-server.git" nofetch-client &&
     ++	(
     ++		cd nofetch-client &&
     ++		promised_blob=$(git rev-parse HEAD:file.txt) &&
     ++		test_must_fail env GIT_NO_LAZY_FETCH=1 \
     ++			git cat-file -e "$promised_blob" &&
     ++		new_tree=$(printf "100644 blob %s\tfile.txt\n" \
     ++			"$promised_blob" |
     ++			git mktree --missing) &&
     ++		new_commit=$(git commit-tree "$new_tree" \
     ++			-m "root commit with promised blob") &&
     ++		check_connected "$new_commit" &&
     ++		test_must_fail env GIT_NO_LAZY_FETCH=1 \
     ++			git cat-file -e "$promised_blob"
     ++	)
     ++'
     ++
      +test_expect_success "$mode: accepts missing promised tree" '
      +	test_when_finished "rm -rf prom-tree-src prom-tree-server.git prom-tree-client" &&
      +	git init prom-tree-src &&
     @@ tree-verify.c (new)
      +		return;
      +	}
      +	if (type >= 0)
     -+		die(_("object %s is a %s, not a blob"),
     -+		    oid_to_hex(oid), type_name(type));
     ++		die(_("object %s is a %s, not a %s"),
     ++		    oid_to_hex(oid), type_name(type), "blob");
      +	if (vs->exclude_promisor_objects &&
      +	    is_promisor_object(repo, oid))
      +		return;
     @@ tree-verify.c (new)
      +
      +	if (buf && type != OBJ_TREE) {
      +		free(buf);
     -+		die(_("object %s is a %s, not a tree"),
     -+		    oid_to_hex(oid), type_name(type));
     ++		die(_("object %s is a %s, not a %s"),
     ++		    oid_to_hex(oid), type_name(type), "tree");
      +	}
      +	return buf;
      +}
     @@ tree-verify.c (new)
      +		const struct object_id *tree_oid;
      +		parse_commit_or_die(p->item);
      +		tree_oid = get_commit_tree_oid(p->item);
     ++		if (!tree_oid)
     ++			die(_("unable to load root tree for commit %s"),
     ++			    oid_to_hex(&p->item->object.oid));
      +		tree_map_add(vs->trees, tree_oid, TREE_TRUSTED);
      +		oid_array_append(&base_trees, tree_oid);
      +	}
      +
     ++	if (!get_commit_tree_oid(commit))
     ++		die(_("unable to load root tree for commit %s"),
     ++		    oid_to_hex(&commit->object.oid));
      +	verify_tree(repo, get_commit_tree_oid(commit),
      +		    &base_trees, vs, 0);
      +	oid_array_clear(&base_trees);
     @@ tree-verify.c (new)
      +	struct commit_list *iter;
      +	unsigned nr_before;
      +
     ++	if (repo->fetch_if_missing)
     ++		BUG("verify_commits_incremental must not be called "
     ++		    "with fetch_if_missing set");
     ++
      +	vs.trees = kh_init_oid_tree();
      +	vs.exclude_promisor_objects = exclude_promisor_objects;
      +

-- 
gitgitgadget
