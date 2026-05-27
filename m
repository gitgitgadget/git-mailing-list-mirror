Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7413254BB
	for <git@vger.kernel.org>; Wed, 27 May 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897007; cv=none; b=R7GU4mCqIvaJO5QJmxgk/7XNEhfbLOpPEgnLB7bHZ4wWBgiwVgspx+vwcXxhiRqhJqMvLjLofBiuQqFF+B1OYAcGG2ci14kfx42QLRtUAfkxE87SNDrFooMrSYVUxtU52MX5wk6otcUh93I/l6aeaOu2hFIaH1uRAqJIhvLh9Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897007; c=relaxed/simple;
	bh=z6bfwM5hGCMD0z78FIY69ZO2gHZb3scaCN56GEVyvJY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=QrQNIjjbHmlJK4hBJGIlmMzZTWurmQcc6fyInyLT1HWv/p/K/01pwjprkZReWojJP7a+pJ+Ysxft1epLQvJj/XxRiIb1Z8GwNXy9nKtevba11cDz7IBqmQEaus2YCq0jgqq/2l2WVZLvIjm7jq9jtzojuIs7AXdGWJ7MUiliaJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKuGo0ZN; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKuGo0ZN"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51306c36c3eso129363471cf.0
        for <git@vger.kernel.org>; Wed, 27 May 2026 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779897004; x=1780501804; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ACsA6KYMvxIQFHg0Tqox5VSQMgVpmZIcZLUh7Kg90PA=;
        b=XKuGo0ZNCB1ku4NND7nAVZpvj1YTkcKIAyLG5WjTTz2qwxG5/K06JJQGp1wiQt3kXk
         ptuVl1InnYVEOKA4xi0NiptBd7JyX06V2JyOCOCe3QjkpqOLSlxeeL9TMaTpgXgOjFcs
         3cN7/QYDZxWA05KS2dAwf4b2zmXlG+/jdjTqnD8DYnUk/2UnhF6mUxouiJEkTxetvEhE
         kA6UDyolcb5Ji15HBgIvsUQbXv0TtgOSxGCRiCfUD91PE6GpTo6fc9F0MsdZBQYssbRR
         1W5psn4UJbhCLtLt8Abjzc1i/f7AX/9updFquzZM8BmgEK5CBoAt7bMxQiQi9RhudrBp
         vyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897004; x=1780501804;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACsA6KYMvxIQFHg0Tqox5VSQMgVpmZIcZLUh7Kg90PA=;
        b=AEXeO0jR3LQp3BEQN+kyGhYT7GXaVoWm3A/MWikDmtFmaxjsHKqmf7vy0bCq16gwVW
         gGn1z2wnMac9UptL2b2yWHTisSoQWTOuwqep6+N4VIkS/E/kJVf4AbPaNYxp9uyreT3d
         reJdYarCGTJ3nKnGEIAw2JM+JWt+73M4RUEviqtBGkviYiqrSWsqEpZ5GE6dxqH5TKnj
         wJ/biU8sfZneXtgWxF+1/kO4+VTDvY2RF3kxfTHXIvcvaAA33+xmuWCbhS+KeMyIpWn8
         tHYZ98Ug7gC58I1+lpY8mXRUM3Dotg/C0w+ubPLWLceLSDgfy6QPER2y6xt9C+arotKm
         jqWg==
X-Gm-Message-State: AOJu0YxAhZhTx9SFaUYlZbz7M6K3edjh1LEGn8Q1vUqmg40O5SSEbssm
	NCnoNhv2yLip5XxpqS9VUlCwWSm5nt6hT+hBVmO6FT1oCh74UrYYAzs4IAEMfA==
X-Gm-Gg: Acq92OEyRxD9DIAbr2uQPZkFUHhd3USyNVcncqCEyfIxEssZ5ik+IpcPsisUmSxbnm/
	iMN9cXKLzHe/FBOXhXYWeCeItfn+PsPW1ZHQokEaKC3HvXAm3d6rT+oVkUqqQqdkjXmfNWOz76Z
	PUe0kEzLQMTHhIN+8JnhciCkHjH02cYbJ7yFJLAb91ILSueXiOk3ZhcwUxGpF2B2+RUnYr6/eyb
	5Rsp6dgKMtcSRcDjUuHjMF3SRa5dE+NDdKJ682VO8wwocRRV8NKYZk+QxotQLqCcw5KpWxogi+A
	BEYcsa0MqkgY9zreelxp8+mTSYMNIRk/VDQo0AHrC3jMisqVs/9Lj4RQD84IqLikZiLEu54m5qD
	v/CByxFrWBiAfxKEavMac1bhQYTheU10IpTiBoj/+lcRPwsIL++4hzAT+MU+XeBCDwp+/kdMpXk
	ankhWulq3XnhuhC4WGX400HjfYntI=
X-Received: by 2002:ac8:5d51:0:b0:516:debc:135e with SMTP id d75a77b69052e-516debc4be3mr289320411cf.35.1779897004362;
        Wed, 27 May 2026 08:50:04 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.239.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80692b1bsm190952326d6.0.2026.05.27.08.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:50:03 -0700 (PDT)
Message-Id: <pull.2127.git.1779897003.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 27 May 2026 15:49:59 +0000
Subject: [PATCH 0/3] revision: use priority queue for streaming walks
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

This is a follow-up to kk/limit-list-optim (now in master), which replaced
the O(N) sorted linked-list insertion in limit_list() with a priority queue.
In the review thread for that patch, I mentioned that the same approach
could be applied to the streaming (non-limited) walk in get_revision_1().
Junio suggested doing it as a separate topic, and Peff noted he had a local
branch (jk/revs-commits-prio-queue) doing a broader conversion of
revs->commits to prio_queue entirely.

This series takes a lighter-weight approach: it keeps the linked list for
setup and external callers, and adds a separate commit_queue field that the
streaming walk drains into on first use. This avoids touching bisect,
line-log, and list-objects code, at the cost of a "only one should be
non-empty" invariant between the two fields.

Together with the limit_list() change already in master, this eliminates all
commit_list_insert_by_date() callers from revision.c.

Patch 1 is a small leak fix -- a missing release_revisions() call in
pack-objects that becomes visible once the commit queue uses a dynamically
allocated prio_queue array.

Patch 2 introduces a rev_walk_mode enum to replace the repeated if/else
chains in get_revision_1(). The function dispatches on walk mode in multiple
places (next commit, expand parents, flag clearing) and these chains must
stay in sync. The enum resolves the mode once and both dispatch sites switch
on the same variable. This is a lighter alternative to the vtable-based
refactoring I mentioned before. No functional change.

Patch 3 is the actual conversion of the streaming walk to use a priority
queue.

== Why this helps ==

The streaming walk in get_revision_1() inserts newly discovered parent
commits into a date-sorted queue. On master, this uses
commit_list_insert_by_date(), which walks the linked list to find the
insertion point -- O(w) per insert, where w is the queue width (active walk
frontier).

In merge-heavy repositories, the walk frontier stays wide:


Repository Commits Peak width Avg width
=======================================

monorepo (2.4M) 2,420K 2,653 1,700 linux.git 1,445K 581 235 git.git 82K 188
82

On the monorepo, each of the 2.4M commits requires scanning an average of
1,700 list entries to find the insertion point. With the priority queue,
this drops to ~11 heap comparisons.

== Benchmarks ==

All benchmarks: best of 3 runs, same machine, commit-graph present.

Streaming walks (affected by this series):

git rev-list --count HEAD (monorepo, 2.4M commits)

  master:   17.94s
  patched:   3.38s   (5.3x faster)

git rev-list HEAD (monorepo, full output)

  master:   27.72s
  patched:   8.61s   (2.8x faster, I/O-bound fraction unchanged)


Regression checks -- non-merge-heavy repos (streaming path, but frontier
stays narrow so O(w) insertion was never the bottleneck):

git rev-list --count HEAD (linux.git, 1.4M commits)

  master:    1.76s
  patched:   1.81s   (no change)

git rev-list HEAD (linux.git, full output)

  master:    4.46s
  patched:   4.52s   (no change)

git rev-list --count HEAD (git.git, 82K commits)

  master:     83ms
  patched:    86ms   (no change)


Regression checks -- other walk modes (not affected by this series):

git rev-list --count HEAD~5000...HEAD (monorepo, limited path)

  master:    7.36s
  patched:   7.02s   (no change)


== Profile breakdown ==

perf profiling of rev-list --count HEAD on the monorepo shows where the time
goes:

master (17.94s): commit_list_insert_by_date 79% 14.25s fixed overhead
(parse/lookup) 21% 3.69s

patched (3.38s): heap ops (compare + sift) 16% 0.53s fixed overhead
(parse/lookup) 84% 2.85s

The queue maintenance itself sped up 27x (14.25s to 0.53s). The overall 5.3x
is lower because the fixed costs -- object lookup (17%), commit-graph
parsing (14%), memory allocation (10%) -- are roughly constant between the
two versions at ~3s.

This means the patch removes the dominant bottleneck entirely. After the
patch, the walk cost is dominated by irreducible per-commit work (parsing
and object lookup) which scales linearly with commit count regardless of
frontier width.

Kristofer Karlsson (3):
  pack-objects: call release_revisions() after cruft traversal
  revision: introduce rev_walk_mode to clarify get_revision_1()
  revision: use priority queue for non-limited streaming walks

 builtin/pack-objects.c |   1 +
 commit.c               |  13 -----
 commit.h               |   2 -
 revision.c             | 113 +++++++++++++++++++++++++++--------------
 revision.h             |  12 ++++-
 5 files changed, 88 insertions(+), 53 deletions(-)


base-commit: c69baaf57ba26cf117c2b6793802877f19738b0d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2127%2Fspkrka%2Fstreaming-prio-queue-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2127/spkrka/streaming-prio-queue-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2127
-- 
gitgitgadget
