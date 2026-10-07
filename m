Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729EB44AB73
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382989; cv=none; b=i4DrBA07o3tgo7YJs4C8/1SBQIf5E7dkRoqU9OIEStu5fJ30DYNpcCVN47bC6jG5fElTD6txq5ppDYKWkSVAoCbwyhfMJhy8f8C96wUz/AwKrTSB2nNzXP0RKiBLE33/daXZUaZeCZJhe8jis8ZcIWHopvoNyMnHO0b+eFFUXeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382989; c=relaxed/simple;
	bh=NWvMjutzeO3SLgS9E824NyuA6TpyMhHVy/6OHRg6y/Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KaSdcgvkSdBVlaiCKJa8Lxjj2RnB+NeoegZx+Yc4UET1mmOq8WeoAPdSAeOmgDEYaZM5JRL3iwkidzh0y2apVeCN6FysU86vnRq70tZ4jo2xfRI4lirAJ/QebBeBS9cprXtsG+rMAh3EH4etai0NtW1Kn/vzAx9RrRnq6/esyYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbSQVovD; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbSQVovD"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5351748222cso32217151cf.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791382982; x=1791987782; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HsmDMKK9svmLKVawYI5H62XAJE3iKUpimxV516kRAXc=;
        b=JbSQVovDtlHRpGw2NW+aBeUsdC0Dn5ygWSjJUNbSnZzmAQ37GjogUZyx6KxT6ye6TC
         abqnmT1oc4H6CwMaytilBlEUrzyLmUBF5MU8OD0sIbWS0dzsMBQs4TxT6cQLfGAKAREU
         p2FCuGdqdYlQEzEzcmFzZkR82oqgEFdGIcfkHNOdz31+Emvcs07XN4g5/ypteXHk1OAi
         LVF43EzouOxEo4CkyJkG3sr9KSCj29Rst/h79umvMnTSTdknIMw5OunGkHxlQXjw2nDl
         /LYAD85pGnevmbOHG86spAFS8JBpuTxFZuUC+MSZysDvq0ra47rRPKJlRQIsbhVTLOQD
         JkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791382982; x=1791987782;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HsmDMKK9svmLKVawYI5H62XAJE3iKUpimxV516kRAXc=;
        b=SBb4WWjuWs+d6JhPD7GY4wPMiNQ6UkeRaX2SFr/LvklYxhFEAzBZW7z5Jm9x/W/+wJ
         ycGSHYtAMg5XgOjBL7HeNuZQ5ZcV/gopDV66fIIMqQ+nGuKa9hQJ33ZEEe0WZ7mbispV
         A1R/4CPbyuwBr0csJZr4GKI+Zs+1F5/X9X6MxImg6/p4EGIDgjbBuAj09Rj0ex1bLW+9
         roiweuIyhuz5ax77o5sJsjF0NrRQoAfYU9YTgZvESdp9u9VCtb5tE/CG83R/AE2r92BG
         r1uO89z7jbbQQq+eplAnqTQU02gA4F3QTXG1Wp2yBVL6Q+AcLDp/Gq/ytgcVRpPNJKoH
         gqeQ==
X-Gm-Message-State: AFuF++n38j9ZKXnR4vQnQ6Zt+yvw7Bqu78Q29mfMYwMHd/6OEx/qmRUA
	Vww2Iod/Yg2CB7AGourtUNA2Cx7j4hWa6uY26WsFnAlGylVGowPCMqmLPcGKPA==
X-Gm-Gg: AYBFou2hHFOhzoy0mkH5kC4vs9NTxfZOsevrWUuRiborHMyxHMjD2Wu+XM5fa3IgR3G
	OpdVKMlYxyACSeRq3S4OTT7luh+vkJiyxvOBe3xqxkPzRQM5vglzT8fAJwR/f/75zidCT/Z/dL7
	N1k1g9pwGjLYFBnXnvyJHg8vcPTl2jIrGu9aklcprZZP+jf3uSbKYEwg9Hov04rkJ3utyt3WhSG
	8Y1e9goeLKedLv+RfSbvp8qbsJrgEI1NJIxG7YUpZ3GCeMmdcT6CPd+AXTvHSSXM+V4ckIRgfL/
	KoRLI3CMEaO+Ay2Jtt1SX3hKwcpPqehnR62CeaonxG0XKv/DyZKlqj3o1oobfIxU4FBplA/1bz1
	CRsM0UpO1Kx221Rtbh8xjYop4oHrv8f9kGpPWHI186SVwIBNbAAjjNGMpYhZyGG2chuHBL48NtG
	sLwHEJrmHLdKqjoktXqBSMfEobXIpqvqTMLRWpHuFUeUmOuwFZrV4Cl5nsYFR5fvFE1Qp+QqmK
X-Received: by 2002:a05:620a:1b93:b0:93e:8774:fba2 with SMTP id af79cd13be357-93e9b7ec7d6mr429828785a.58.1791382981793;
        Wed, 07 Oct 2026 07:23:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e991e9e5csm223264085a.37.2026.10.07.07.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 07:22:58 -0700 (PDT)
Message-Id: <pull.2239.v3.git.1791382977.gitgitgadget@gmail.com>
In-Reply-To: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
References: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Oct 2026 14:22:55 +0000
Subject: [PATCH v3 0/2] fetch: write commit-graph using updated refs only
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


Changes since v2:

 * Trim the commit message: inline the commit references, keep the
   explanation of why the incremental write relies on split mode, and drop
   the paragraphs that only restated the diff (collecting the tips,
   auto-followed tags, skipping shallow-rejected refs).
 * Reword the comment on skipping shallow-rejected refs without the
   reference to store_updated_refs().
 * Simplify the t5537 test by using "test_commit -C ... --no-tag" instead of
   subshells.

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
 t/t5537-fetch-shallow.sh   | 22 ++++++++++++
 6 files changed, 165 insertions(+), 11 deletions(-)


base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2239%2Fspkrka%2Fkrka%2Fincremental-commit-graph-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2239/spkrka/krka/incremental-commit-graph-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2239

Range-diff vs v2:

 1:  36cc3ff3b3 = 1:  36cc3ff3b3 test-tool read-graph: add commit-info subcommand
 2:  7507354cc9 ! 2:  01da9857bc fetch: write commit-graph using updated refs only
     @@ Metadata
       ## Commit message ##
          fetch: write commit-graph using updated refs only
      
     -    When fetch.writeCommitGraph was introduced in
     -
     -        50f26bd035 (fetch: add fetch.writeCommitGraph config
     -                    setting, 2019-09-02),
     -
     -    the stated goal was to stay updated with the latest commits after
     -    fetching new objects.  The implementation used
     -    write_commit_graph_reachable() because it was the only API available,
     -    but two things have changed since then:
     +    When fetch.writeCommitGraph was introduced in 50f26bd035 (fetch: add
     +    fetch.writeCommitGraph config setting, 2019-09-02), the stated goal
     +    was to stay updated with the latest commits after fetching new
     +    objects.  The implementation used write_commit_graph_reachable()
     +    because it was the only API available, but two things have changed
     +    since then:
      
           1. write_commit_graph() was added, and it accepts an explicit set of
              commits as seeds, enabling more targeted commit-graph updates.
      
           2. The ref-scanning callback add_ref_to_set() became more expensive
     -        in
     -            630cd5194e (commit-graph.c: peel refs in 'add_ref_to_set',
     -                        2020-07-22)
     -        when it started to validate the refs against the odb
     +        in 630cd5194e (commit-graph.c: peel refs in 'add_ref_to_set',
     +        2020-07-22) when it started to validate the refs against the odb
              for correctness.  On a repository with many refs, this makes the
              full reachable scan unnecessarily costly for a targeted fetch.
      
     @@ Commit message
          (since that would require propagating the set of refs across process
          boundaries).
      
     -    Since do_fetch() already knows which refs were updated, collect them
     -    into an oidset and then pass them directly to write_commit_graph().
     -    fetch always writes the commit-graph in split mode, so this adds a
     -    new layer on top of the existing chain rather than replacing it:
     -    close_reachable() walks from the updated tips and stops at commits
     -    already present in the graph, so the new layer only contains the
     -    newly fetched history, and commits covered by the existing layers
     -    remain covered.  This relies on split mode; a non-split write would
     -    replace the graph with just the closure of the seeds.
     -
     -    The reachability closure also covers auto-followed tags, since their
     -    targets are reachable from the fetched tips that caused them to be
     -    auto-followed.
     -
     -    Refs that are rejected because they would require changes to
     -    .git/shallow are skipped, just like store_updated_refs() does.  Their
     -    objects are received but their history is incomplete, so walking from
     -    them would make the commit-graph write fail.
     +    This relies on the commit-graph write being additive, keeping the
     +    commits that are already in the graph.  fetch already operates in
     +    this mode (COMMIT_GRAPH_WRITE_SPLIT) and now that becomes
     +    required for correctness.  Without that mode, the write would
     +    replace the commit-graph and lose other commits.
      
          After fetch_one() returns, call prepare_commit_graph() (which is
          made non-static by this commit) to determine the graph-write mode:
     @@ builtin/fetch.c: out:
      +	for (rm = ref_map; rm; rm = rm->next) {
      +		struct commit *commit;
      +		/*
     -+		 * Like store_updated_refs(), skip shallow-rejected refs:
     -+		 * they are not stored, and their history is incomplete.
     ++		 * Shallow-rejected refs are not stored and their history
     ++		 * is incomplete, so skip them.
      +		 */
      +		if (rm->status == REF_STATUS_REJECT_SHALLOW)
      +			continue;
     @@ t/t5537-fetch-shallow.sh: test_expect_success 'fetch that requires changes in .g
       
      +test_expect_success 'fetch.writeCommitGraph skips refs that require changes in .git/shallow' '
      +	git clone --no-local --depth=2 .git shallow-graph &&
     -+	(
     -+		cd shallow-graph &&
     -+		git checkout --orphan no-shallow &&
     -+		commit no-shallow
     -+	) &&
     ++	git -C shallow-graph checkout --orphan no-shallow &&
     ++	test_commit -C shallow-graph --no-tag no-shallow &&
      +	git init notshallow-graph &&
      +	git -C notshallow-graph -c fetch.writeCommitGraph=true \
      +		fetch ../shallow-graph/.git "refs/heads/*:refs/remotes/shallow/*" &&
     -+	(
     -+		cd shallow-graph &&
     -+		commit no-shallow-2
     -+	) &&
     ++	test_commit -C shallow-graph --no-tag no-shallow-2 &&
      +	rejected=$(git -C shallow-graph rev-parse main) &&
      +	(
      +		cd notshallow-graph &&

-- 
gitgitgadget
