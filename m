Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192C718FDBD
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781950322; cv=none; b=JzA+BusL36KDJwLFngUljuuoHSnkGvmrtLBr9QO2H9WeYV0lnxx0meQy43IKaSzBNnduXTIUiKiHKH2eCNTPk+wcrg9oFd38j8xvFs2jEr+2hvN+pNq536MZxzsbs/G6VgQXQXUgpKGwrYaU1GWJ4sjeJP7bQ/+6RJmKIxoYrtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781950322; c=relaxed/simple;
	bh=KARz4GrOeTCxbBRu+f/WQfCJM6me5rO6d8OjV2Lqjvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wr+wZYrjsnMlD0HnroPfNB7X8SZvx93qfdwHSg6CxHbEgr4aEHIUK4UC8Wt3/fbjNts2DOo0UFiVJBP+0plYZHWXGa5kVc05Ti+0u8WqsHJMniReYV8rCdfr8UkUFl5jt/CnwGjGbPHhXPyVcOANpoLEH+AWHTZfhrw1DnQF8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSAZNuHg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSAZNuHg"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so22684385e9.0
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 03:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781950319; x=1782555119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40zBzRK0qiKmwmokmhwB5Er3VexOWVDxYpG9+0+ElWg=;
        b=iSAZNuHgZYFzozsCtNkx0xYraxpeVFV11RKdHKUvNEzIuTXHy7gb7luSR4bO5rSdYl
         Mu2LS6GX9PBCc2pqbMREAW8L4CNwK9OVwXySD4F0x0L8DQAYLzaqqlg7VTOe+iKT9Ms6
         /E64Dl+yKzquMD9jx+bvPdX3Mfi46irLUDlCG9pDQT6SJQfT6OPF4PCcSR+kiNvxLqGv
         h8Z/TU8m8S6szdYODzblys6h3dJqiBIxP/ZA8HvT1yQPqLr72YLp+Yo4pq2Zkobntxbm
         fy4BtRKVG/DBtK8EtCqSS8bAtjqNCjFyxkaNm6Sx19T0ffEsDkSIc0NoYbhYT0w4FvQZ
         uL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781950319; x=1782555119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=40zBzRK0qiKmwmokmhwB5Er3VexOWVDxYpG9+0+ElWg=;
        b=WKfIrfdtGOld7pQkGvmnUM5V1JU2POfvLpoQ9iVJsNzhIxQ5H8cVEt99NrbEtQm+/4
         IM0qp4A8OVPn8nuU9QgN6BXLsom10oe0octaVXyLUiCQikjyc4l5hWSMTbGaH9Aw0nBf
         FqA+hJ0sj/u93/jvSXl+bHdRBKF2SqHDFUdN+0x3j6FxVevZTU/65hvxFRPJgzrVGpIp
         gzX/1Z4BHblA29yTxpxj2m2yJlZEyMZ6pNavAfg5Vm15eV9JIsuUtScIO8qxTwU7Zss7
         6LHffcr3ZRskuNn96Egm+XtVNOnJNdrG+LOhSB2flxKQCSnXkax2dxeLr3zFv9zn97OG
         +ihQ==
X-Gm-Message-State: AOJu0YwsWNPzsEo3nM5yrCkRItYoKX6mdr5FTV5zcOtje5xnrew7om/F
	Np+fS2+NCM5+E3eeSZEvFLAACLXxvamUNe6t17Mv+fKmLOJeLHWUlF3oZaJMEcIa
X-Gm-Gg: AfdE7cmO7Y9mB5Ig0rSlzxZEY01YzusnA1OqNTASgtnH+d6TUPlGAmfpdZoNEtVz65H
	xUJiwEGiNIlDfbmsbd+aZkobS3tk74sal7YRRo71Lyr3y48Dw28ZmQKqJlFwXti4BL6K9wjcOop
	nMPr7uzIPT4d6ZYBKaGSoyNDQmYkHFB33H6NI4udL2ne4AJaz2BVO+6LMDixC6ubQeuylV9d8hU
	uKxti2bpficIx+PcL4By/Nsuabt/cA6KgzTy+fkLrprn6t5IuVGgZ7HifXcOviw4HbKOdDjoi3u
	sMYBmQi2oOiWWy9NqP9ESuz1wfs6k+cF3tFokXrXavzim0RJ1OK0kg6UZ7iwLHX2+7rQlvu8ssN
	bvDBCTHU3VV6MmEb7ah9y188Q9Rq0gmMUNgLz3aiXqq5YDVkWqyWqGm+Ihti3lrVwI71UoPjOG8
	VREFYYkRiRw3CMl65HQRt97Vwbke2Yj8DTT7eiDO8Wm0R76V0c38QM/atN0F2nRBSMglD4lRk3c
	0/XMe8ZrSDmX7i5GPEuEckV0PysVHmhDhbAMwJeTQxaYXWA+kSX6S6nUZdMCxy5jwBguSDe31NV
	SoBRguXGg4Is05fMX793wrxRfdlbw/RiaAIlCQvdMxHEnQ==
X-Received: by 2002:a05:600c:5490:b0:492:4714:2d7e with SMTP id 5b1f17b1804b1-49247142f73mr55624355e9.36.1781950319281;
        Sat, 20 Jun 2026 03:11:59 -0700 (PDT)
Received: from localhost.localdomain ([89.6.100.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1f886sm126350925e9.4.2026.06.20.03.11.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 20 Jun 2026 03:11:58 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: krka@spotify.com,
	ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	pabloosabaterr@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v6 0/3] graph: indent visual roots in graph
Date: Sat, 20 Jun 2026 12:11:49 +0200
Message-ID: <20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
References: <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260612-ps-pre-commit-indent-39ca72816382
Content-Transfer-Encoding: 8bit

When rendering a graph, if the history contains multiple "visual roots",
actual roots or commits that look like roots (i.e. have their parents
filtered out) can end up being vertically adjacent to unrelated commits,
falsely appearing to be related.

A fix for this issue was already attempted [1] a while ago.

This series adds indentation to the visual root commits, so they cannot be
vertically adjacent anymore making it easier to identify them.

before indentation:

	* A
	* B1
	* B2
	* C1
	* C2

after indentation:

	  * A
	* B1
	 \
	  * B2
	* C1
	* C2

Indents the visual root commits that have still commits to show after them, and
if they have children it connects them with an edge at a new row.

If there are multiple visual roots adjacent in history, the indentation starts
with the second one, avoiding redundant indentation of the first one and cascades
after the second.

	* A
	  * B
	    * C
	* D1
	* D2

This series first commit is a cleanup that brings a common function from t4215
and t6016 to a graph functions file which they both use, so the new test file
for indentation, t4218, can use it as well.

There are two main limitations to predict if the next commit will be a
visual root candidate:

1. The peek only gives us the next entry reliably, we cannot see past it
   reliably in order.

2. Even if we could peek past in order, its parents might not have been
   simplified yet, so a future commit that will become a visual root is
   not detected as a visual root in peek-time.

This causes the cascading to not be set and result in a extra
indentation. For example:

Given:

	* A unrelated (visual root)
	* B child of C
	* C visual root WILL BE FILTERED OUT
	* D unrelated (visual root)

The actual output is:

	  * A
	    * B
	* D

But we wanted:

	* A
	  * B
	* D

A test has been added to t4218 and a NEEDSWORK to the lookahead function
to document this edge case but I'm not that familiar with revision.c.
Maybe there's a better way to make the lookahead more reliable.

[1]: https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/

V5 DIFF:

- Added new commit with lookahead functions to abstract the commit
  traverse to the graph. Changed the lookahead function from graph to
  call this new functions.
- Added new test with two unrelated branches with merges.
- Fixed test_expect_failure to have the correct expected output.
- Simplified the NEEDSWORK.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Pablo Sabater (3):
      lib-log-graph: move check_graph function
      revision: add peek functions for lookahead
      graph: indent visual root in graph

 graph.c                                    | 271 +++++++++++++++++
 revision.c                                 |  38 +++
 revision.h                                 |  10 +
 t/lib-log-graph.sh                         |   5 +
 t/meson.build                              |   1 +
 t/t4215-log-skewed-merges.sh               |  33 +-
 t/t4218-log-graph-indentation.sh           | 468 +++++++++++++++++++++++++++++
 t/t6016-rev-list-graph-simplify-history.sh |  25 +-
 8 files changed, 817 insertions(+), 34 deletions(-)
---
base-commit: 95e20213faefeb95df29277c58ac1980ab68f701
change-id: 20260612-ps-pre-commit-indent-39ca72816382

Best regards,
--  
Pablo Sabater <pabloosabaterr@gmail.com>
