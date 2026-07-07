Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D138F3C0A0E
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418388; cv=none; b=pQppVgCa5MwrUWw11sh3G1wHVLmY7esFfsXPtFwObBmoX2n/49JsCgnId2O4dPftMrBibSYngSVqdRiwNb3jXUWp14c4RHyew8ivVVJX0bg8/Uue2uMsnO6wn68BSkNfzPku7HduN4sZ3cTMp2PTH77+0morJ5ANuPbPpggIO44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418388; c=relaxed/simple;
	bh=XyClFdmtX/WYJ6vbbRXI/vIPSCfds7SqEz/l5hcWYpI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Iw72Amd/Zuz74IxKnuA9fEAFj1crIvxorwkMDjmV4+MV1SjG62AyaK+eKC3N1cADKQUErIM2W/FDGOoBZF1LtaKgOX7pyhtj967XzfV2SoQjSHxC966m3+lSAThcWcPRHODgiP/yCzS/mf25NJ/k4Q3yszUD0bIW69ohi5LQMf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlS2Jtxp; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlS2Jtxp"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36b9d265355so3093190a91.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 02:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783418386; x=1784023186; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ey6MWlZOkm8KpoDVr03ABMU86M8fG2g7uX+rUzs3Hzc=;
        b=RlS2Jtxpsf7LBYnSyCuwG9ixzSL/1fH+vLe4t3ip8KGkEdRkVHlju0tnHb+wy3ZI8Q
         2A3STCEN0xdxV34TTIj0yX59KHvAqDzsrNCbQKv9c3y20XWx9k/+jgXqR/licS2x3zS7
         L+F8Io+Y9IgJwiV6E4avRlCa4M2uie+KtFPdecAWsBr2LK4jkOxiLbPPY5Pq/a0tEbCN
         PmGmO1WyLyFWhUqoEe0s7njhXddnVmZzIJjPsSkL8l4R/zrKOXUu21jXekjwZSlxppsN
         PlwGVqhyqylGnIp0h0EhGa2JTCaZ0bGfWY9qIoTvhvNGOzgKRIoWDDydkEFnLPz7Z8W1
         79lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783418386; x=1784023186;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ey6MWlZOkm8KpoDVr03ABMU86M8fG2g7uX+rUzs3Hzc=;
        b=Teiy6ZR4G5Q0nx8u273TVFa48U4+xbIkM4RQLP0b1bSUtncRNbYDucL8DU+wlBwtLs
         4jy1wq+APjdDBFEt4Hr65C8326HXBM97zL0Ao2ZRpQeK5NFrVSla7j8a36Qu5pboJsDA
         x/yntut8yMgDxjapQ7Zt6OhCUk6BcrQ263faZTvuTB5fG5qcRs5NqGJTJq0QU6prp92T
         sdkFNhIFLVrbfcBSRV6GnzWmLvXx++8q1ktHoW5W9Ls8OWgbi6ak86EyFKn+6SRdOPtn
         kkI817v6d3fIIL6CK3oAi2M1Ddc0rZu/T86SHHiRC0AKGBhMnXne75aIJjyjUBorRWfz
         lZzw==
X-Gm-Message-State: AOJu0Yym9QF/bVwi/RWF0m/IxzLfDnu5gjH8HtoFgsvHnKjTr6vcEHIl
	iIv/wTuTRta4Fxsfk1CWbooSC+C943+MFiZxHUzPFpoe7q/JIV4zhUm1JpWtGQ==
X-Gm-Gg: AfdE7clKfwX7CuNnIwHnhFpaOti5xYQP4oW/HzrLHLpS1Jbm807AjhvXgKmIQjn2sM8
	/m9vOFsIwVumBQfVRQedqkO3TSfZkr9D/0y+taBKE4x0+D178/g3RZJqrMM0PSMe/dQCqYMjU0D
	RtI+pFYQWKC93+nt4Gp4aXjTJogKmWKGYt477g4Ktmljhu0lEAa5ujBo7ilDLusSSxLGWIwZ/K+
	iEao7nlRhQh0+ik6waJS+hQEDwa9CM5ByGVb9kEISMV/c0eGTbswH4ZxhKVlYNxJ75+py8YSovP
	+nRRdLY7W62bcXx7vyOjohqJKv5B+0UiT8p7SY006lgTp3pV003/Sl68DxzuCgaZ5jP/29WmtYB
	pO8DyauzY70kGmZp5IDkyPwnXKleUrYuDqaCrUC0v0M4Uvtlw6oeIi+XuuxY4iMxV4eAbIZW1dQ
	Reu57XHEoQPMW/5w==
X-Received: by 2002:a17:90a:dfc6:b0:37f:9ce1:7360 with SMTP id 98e67ed59e1d1-38758162cc6mr4602852a91.33.1783418386050;
        Tue, 07 Jul 2026 02:59:46 -0700 (PDT)
Received: from [127.0.0.1] ([52.241.30.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d13fd857sm804728a91.7.2026.07.07.02.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:59:45 -0700 (PDT)
Message-Id: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Jul 2026 09:59:41 +0000
Subject: [PATCH 0/2] commit-graph: fix topo_levels slab propagation regression
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
Cc: Kristofer Karlsson <krka@spotify.com>

When fetch.writeCommitGraph is enabled (or git maintenance runs after
fetch), an incremental commit-graph write computes generation numbers for
the newly added commits. For commits already in the graph, their topo levels
should be read from the existing layers, making the DFS proportional to the
number of new commits.

199d452758 (commit-graph: return the prepared commit graph from
prepare_commit_graph(), 2025-04-07), part of the ps/commit-graph-via-source
series [1], refactored the loop that propagates the topo_levels slab to each
layer of the commit-graph chain. The original code used a single variable
that advanced through the chain:

while (g) {
    g->topo_levels = &topo_levels;
    g = g->base_graph;
}


The refactored code introduced a separate iteration variable but did not
update the loop body to match:

for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
    g->topo_levels = &topo_levels;


This always assigns to the topmost layer instead of the current one. The
other loops in the same refactoring all correctly use chain in their bodies:

for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
    ctx.num_commit_graphs_before++;

for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
    ctx.commit_graph_filenames_before[--i] = xstrdup(chain->filename);


With only the topmost layer having topo_levels set, fill_commit_graph_info()
cannot store topo levels for commits parsed from lower layers.
compute_reachable_generation_numbers() then sees GENERATION_NUMBER_ZERO for
those commits and re-walks their entire ancestry.

On a large repo with a 4-layer split commit-graph, the cost of a single
incremental commit-graph write drops from 4133ms to 233ms after the fix,
which directly impacts every git fetch when commit-graph maintenance is
enabled.

[1]
https://lore.kernel.org/git/aMNTELw0Wk8jWoPc@nand.local/T/#mb55b5f0e1ccf82d969ac1d8144c56ecf87b833e8

Kristofer Karlsson (2):
  commit-graph: add trace2 instrumentation for generation DFS
  commit-graph: propagate topo_levels slab to all chain layers

 commit-graph.c                |  7 ++++++-
 t/t5324-split-commit-graph.sh | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2170%2Fspkrka%2Fkrka%2Ffix-topo-levels-slab-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2170/spkrka/krka/fix-topo-levels-slab-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2170
-- 
gitgitgadget
