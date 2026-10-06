Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758653DAAAA
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791279997; cv=none; b=A24lrCbWhDgaxYKwDGIEjLFoB/oUm85UuhbjcaDkfkRPBTFWP/85rJcIkbgJ2mDvSs3fjJzgddbdIYknS3wA86nrXak4RYz3t+1eMm1/6wobvwuf5yaJozj9FCdEP6M8qYioNUCKrZv5hZAkQB3sjqBF9yW+9NBYecvXoFhl6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791279997; c=relaxed/simple;
	bh=2LVitDtctYi4NkjVo5V4qnQxY8DFRwJLc3mB9Q77SWg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DUxJ4evgMIpamybFjFtyqu6Cjqh9PJDJtnH7x6UIYygaRplSC2pJhMIvjdBOppf/xk+WgWlnQl+7ASsVK+nSiH0z85nYmERcvhN2IaTdmhh2jCqGnxxuc4cXxJGvpo9NqOYqr5Lkl5ojrRa/YN8QHT4ANFfZCMvZyQfGKhCTM9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1pB5++4; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1pB5++4"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-34bb8b31647so4335735eec.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 02:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791279994; x=1791884794; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mMw2lFr8RW3ofjeHQW3sgBPEKRDhioNB9CeSWaoKSQ4=;
        b=n1pB5++4yfb9JAGgBof/8sehj2DZT0MQv4QrDc1BTqDLY+7HYkJ7pTELP9ybcMamgy
         psriigXgr3Dxtamq1uTKZSOlIzm8jxyazRJc05u/z9Uxkj9BZHCC2fm2qYr5EpPY4H3s
         dEI93j9mRnky1gciQLJFFdbGSYGrdYjHAtHh0+1HYlmpBkKN+nH2eMzxuv8aA1HGh93h
         JsswsT++6JP8vWy6eN5PQp6iiz5mdWxEqOK8AYPwxInax9CqyI/FMY7k/VAYJQj2iI89
         cF9E/BneMbwdKsdNhkuv8XdtZHBmZ6znVcHyQ9MLiOQMmYJuvUrOwHrk/agAKp7EWqMN
         R5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791279994; x=1791884794;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mMw2lFr8RW3ofjeHQW3sgBPEKRDhioNB9CeSWaoKSQ4=;
        b=PJaDYmza3XHrac5qjbZab3Cql5K4tYdAkXN9rsptNYQBHLvlyAw66dyyJ38rYUUnbm
         DcwfHumiUGJX6cc9bm1uSPVi2pdPc137dh81ZzDzG/EYrz3ThzuKZ8h23Kx00cZsca2s
         9iLkwuVm/5qySHe9lgNmiWFkCjVcTr1CC3b8wShK3of859IPVMgVrd8dsbft3EyU77LV
         QLuapWcDao1OEN8GplHwYN565gKzvO8dW1ery1qT03l4TYBaorc482BdX5heNiEGWTmT
         VdOIzg7Zl8lHSjZCaGv4EBHySKAZuHk4CzXvbCuIISF+U5ZkC7KiW8Vwx2UcnLwChJSt
         sJMA==
X-Gm-Message-State: AFq9FYJENqWpoJpFLR6lgYYXT3Df/JOhMDM2kbvDLbp+jiRBW54/Ht/A
	8fewzgN12wQsjsD2BJUT8/uKc2b2ZU6YUb+Ji6AzHZDSOzsYBZuvfU9td3iTHw==
X-Gm-Gg: AYBFou0TBLA+GcL44sEHxyYF5dGVQ0OcYAO06V9b7A016WDtsVYWm3L1EhWQmHLQEma
	2RlyQCTpXGRd1wucvi827mzJPYHrnWGQ4EBD8Guoh5wdJT5SpqBFCMJ7JeytBcYPdeIwDQuQ33r
	zaFapoxjvs8O1zdlROVbeNLzHnx3+vD4wgQjIWsmJe3Ie8PV/WBfJLNBTfO9dIEau2WJggZHdix
	7rEKtczcnOTcqGy5h0MOeu6oWMvpu5FwrEkjEkMvSBeMpwcsejgxlsFcw6m2kY9+vruptEB72Zy
	XbEvyedoITFq7yunYhNAgI6WV6+xEBLVftpaNA/VBAwYhFiojVE57s9CuZF4ycdcT5+pfReaiF2
	LwUWcCAjnsR9YrY44xNjE0S/URoYsdlWD9JYmQrueejnOkePwOvt9s7+wLMBFVwyQGW1a2Awbhs
	Cl36QC/Cpo16TJxwonotzoJdHLBOFBhA97H4dC56iWvSsLMrIhGltQS9L3aSPGBFqQapE+zHCqA
	Q==
X-Received: by 2002:a05:7301:4d08:b0:34c:2850:abaa with SMTP id 5a478bee46e88-3514e2e304dmr1060108eec.26.1791279994284;
        Tue, 06 Oct 2026 02:46:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.108.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146a5a0fasm6653051eec.17.2026.10.06.02.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 02:46:33 -0700 (PDT)
Message-Id: <pull.2239.v2.git.1791279992.gitgitgadget@gmail.com>
In-Reply-To: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
References: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 09:46:30 +0000
Subject: [PATCH v2 0/2] fetch: write commit-graph using updated refs only
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

When fetch.writeCommitGraph is enabled, the commit-graph is rebuilt from all
reachable refs after every fetch. This is unnecessarily expensive on
repositories with many refs, since add_ref_to_set() validates each ref
against the odb.

This series optimizes the commit-graph write by using only the newly updated
refs as seeds instead of scanning all refs. Since fetch writes the
commit-graph in split mode, the newly fetched history is added as a new
layer on top of the existing chain. A three-mode enum (REACHABLE / TIPS /
SKIP) makes the policy explicit:

 * No-op fetch: skip the commit-graph write entirely
 * Updated refs + existing graph: write incrementally from updated tips only
 * No existing graph or multi-remote fetch: fall back to full reachable scan

Patch 1 adds a commit-info subcommand to test-tool read-graph for verifying
graph contents in tests.

Patch 2 implements the optimization in builtin/fetch.c with tests covering
the incremental, unrelated-commit, no-op, fallback, and shallow-rejected
cases.

Benchmark on a synthetic setup: git.git with 200K extra packed refs (~206K
total), a local file:// remote, an existing split commit-graph and a warm
page cache. Times are the median of 9 runs of the trace2 region
fetch/write-commit-graph:

scenario          before    after
no-op fetch       380 ms    (skipped)
1 ref updated     357 ms    9.3 ms
10 refs updated   359 ms    8.9 ms


Changes since v1:

 * Explain in the commit message that fetch writes in split mode, so the new
   tips are added as a new layer on top of the existing chain, and that the
   incremental path relies on this (a non-split write would replace the
   graph with only the closure of the seeds).
 * Extend the incremental test to check that a local-only commit, which was
   in the graph before the fetch but is not reachable from the fetched tips,
   is still in the graph afterwards.
 * Add benchmark numbers to the commit message.
 * Add a comment explaining why shallow-rejected refs are skipped when
   collecting the updated tips (like store_updated_refs(), since their
   history is incomplete), and mention it in the commit message.
 * Add a test in t5537 for a fetch with fetch.writeCommitGraph where a ref
   is rejected because it would require changes to .git/shallow. Without the
   check, the commit-graph write dies on the missing parent.

Kristofer Karlsson (2):
  test-tool read-graph: add commit-info subcommand
  fetch: write commit-graph using updated refs only

 builtin/fetch.c            | 69 +++++++++++++++++++++++++++++++++-----
 commit-graph.c             |  2 +-
 commit-graph.h             |  1 +
 t/helper/test-read-graph.c | 23 ++++++++++++-
 t/t5510-fetch.sh           | 59 ++++++++++++++++++++++++++++++++
 t/t5537-fetch-shallow.sh   | 28 ++++++++++++++++
 6 files changed, 171 insertions(+), 11 deletions(-)


base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2239%2Fspkrka%2Fkrka%2Fincremental-commit-graph-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2239/spkrka/krka/incremental-commit-graph-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2239

Range-diff vs v1:

 1:  36cc3ff3b3 = 1:  36cc3ff3b3 test-tool read-graph: add commit-info subcommand
 2:  fee92f3c20 ! 2:  7507354cc9 fetch: write commit-graph using updated refs only
     @@ Commit message
      
          Since do_fetch() already knows which refs were updated, collect them
          into an oidset and then pass them directly to write_commit_graph().
     -    In split mode, close_reachable() walks from the updated tips and
     -    stops at commits already present in the graph, efficiently adding
     -    the newly fetched history.  This reachability closure also covers
     -    auto-followed tags, since their targets are reachable from the
     -    fetched tips that caused them to be auto-followed.
     +    fetch always writes the commit-graph in split mode, so this adds a
     +    new layer on top of the existing chain rather than replacing it:
     +    close_reachable() walks from the updated tips and stops at commits
     +    already present in the graph, so the new layer only contains the
     +    newly fetched history, and commits covered by the existing layers
     +    remain covered.  This relies on split mode; a non-split write would
     +    replace the graph with just the closure of the seeds.
     +
     +    The reachability closure also covers auto-followed tags, since their
     +    targets are reachable from the fetched tips that caused them to be
     +    auto-followed.
     +
     +    Refs that are rejected because they would require changes to
     +    .git/shallow are skipped, just like store_updated_refs() does.  Their
     +    objects are received but their history is incomplete, so walking from
     +    them would make the commit-graph write fail.
      
          After fetch_one() returns, call prepare_commit_graph() (which is
          made non-static by this commit) to determine the graph-write mode:
     @@ Commit message
          which periodically rebuilds the commit-graph from all reachable
          refs.
      
     +    The effect was measured on a synthetic setup: git.git with 200K
     +    extra packed refs (~206K total), a local file:// remote, an existing
     +    split commit-graph and a warm page cache.  The times below are the
     +    median of 9 runs of the trace2 region fetch/write-commit-graph:
     +
     +        scenario          before    after
     +        no-op fetch       380 ms    (skipped)
     +        1 ref updated     357 ms    9.3 ms
     +        10 refs updated   359 ms    8.9 ms
     +
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## builtin/fetch.c ##
     @@ builtin/fetch.c: out:
      +	struct ref *rm;
      +	for (rm = ref_map; rm; rm = rm->next) {
      +		struct commit *commit;
     ++		/*
     ++		 * Like store_updated_refs(), skip shallow-rejected refs:
     ++		 * they are not stored, and their history is incomplete.
     ++		 */
      +		if (rm->status == REF_STATUS_REJECT_SHALLOW)
      +			continue;
      +		if (is_null_oid(&rm->old_oid))
     @@ t/t5510-fetch.sh: test_expect_success 'fetch.writeCommitGraph' '
      +	git init incremental-source &&
      +	test_commit -C incremental-source one &&
      +	git clone incremental-source incremental-dest &&
     ++	test_commit -C incremental-dest local &&
      +	git -C incremental-dest commit-graph write --reachable --split &&
      +	test_commit -C incremental-source two &&
      +	test_commit -C incremental-source three &&
      +	(
      +		cd incremental-dest &&
      +		git -c fetch.writeCommitGraph=true fetch origin &&
     -+		test-tool read-graph commit-info three two
     ++		test-tool read-graph commit-info three two local
      +	)
      +'
      +
     @@ t/t5510-fetch.sh: test_expect_success 'fetch.writeCommitGraph' '
       test_expect_success 'fetch.writeCommitGraph with submodules' '
       	test_config_global protocol.file.allow always &&
       	git clone dups super &&
     +
     + ## t/t5537-fetch-shallow.sh ##
     +@@ t/t5537-fetch-shallow.sh: test_expect_success 'fetch that requires changes in .git/shallow is filtered' '
     + 	)
     + '
     + 
     ++test_expect_success 'fetch.writeCommitGraph skips refs that require changes in .git/shallow' '
     ++	git clone --no-local --depth=2 .git shallow-graph &&
     ++	(
     ++		cd shallow-graph &&
     ++		git checkout --orphan no-shallow &&
     ++		commit no-shallow
     ++	) &&
     ++	git init notshallow-graph &&
     ++	git -C notshallow-graph -c fetch.writeCommitGraph=true \
     ++		fetch ../shallow-graph/.git "refs/heads/*:refs/remotes/shallow/*" &&
     ++	(
     ++		cd shallow-graph &&
     ++		commit no-shallow-2
     ++	) &&
     ++	rejected=$(git -C shallow-graph rev-parse main) &&
     ++	(
     ++		cd notshallow-graph &&
     ++		git -c fetch.writeCommitGraph=true \
     ++			fetch ../shallow-graph/.git "refs/heads/*:refs/remotes/shallow/*" &&
     ++		git for-each-ref --format="%(refname)" >actual.refs &&
     ++		echo refs/remotes/shallow/no-shallow >expect.refs &&
     ++		test_cmp expect.refs actual.refs &&
     ++		test-tool read-graph commit-info shallow/no-shallow &&
     ++		test_expect_code 1 \
     ++			test-tool read-graph commit-info $rejected 2>/dev/null
     ++	)
     ++'
     ++
     + test_expect_success 'fetch --update-shallow' '
     + 	(
     + 	cd shallow &&

-- 
gitgitgadget
