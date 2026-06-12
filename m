Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1702EA173
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262957; cv=pass; b=Wg8UKdeSc5C8I19Evrk6PEbdza08aCOm405tlwMOXJOzeA5EjL39Q5lBO+KcImj4yJAUQHwqT/Lct5qGGW4pE7GWdAuyRu017ClhKlZQFdLvedxfRu+yY3dM46sFJ8KUoTNhQg4r8cVIuFz6NU4xGr6vqqQ9s5J0ixJimQ3ztgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262957; c=relaxed/simple;
	bh=9XLasY1X2DCsRrgv7+VUEWGjRIa5tHOae7PdlUs0OFg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IBspnybs5BP2I5R9SNWBrvwEdkU/+Xg4PgU/bGE5bDBUVqChIigc7+g4aU/SFVrtOeMqvpdPoxiCc26B4t6vkpYyyDa6sUfYlfyDMFvdrCE+HrXmSYkr98JXXGvi1oTh481zHdx4idNZxQ4Zf7k30FzSM2jKlptGDmnqZy0Nn4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=ICrUiEqa; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="ICrUiEqa"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7dca5a81be2so7953697b3.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 04:15:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781262955; cv=none;
        d=google.com; s=arc-20240605;
        b=lcJSpUw42CBN5IMiqCAvrEDmvycveSxRDr1Tq5qljjtI8JiDDACvuoqw1Li1fsEQUf
         eWBO46KFZySe4W37GtYM3gT3J2VuJt+Hg7Gl36lNOItYOJdpdYHys2fxQ7BdQAiJSi1G
         yUP3n4V8/zvYkK/ZeG8Uq0Df/WR/vHOkMo5cvqxNeBDz8qAVpTwRUm/fyRwq8jjKOpcX
         h6sqjuwu7Mp6mWYW6FEo4mkatyGwf3n8+ccq9phV+DRqlfj5GRFiVKnzY2OY/0Mwao6Q
         EcJmvQzk+iXEz2+SxaJtZi5y+cTorSyYvAklbqEYLnJCdt2teCWBwB6lZ5jI2RQTUxUO
         d6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Dp5L1YSfueaf9o+PtALM//GQPXboA3QXkv9r9sOD9Kw=;
        fh=2tEvzZWQCbE72OYzNAR/NxU4VfFXivKla+PISiRN7uw=;
        b=LMI5m8D6wsuOK7tNDadr7KVUoSTkyqji/rJ3YfTlIM5Kaj7Dnwxi8dy4/wOCz7qJv6
         bzL4JJFjFFKP7AwzxswNDh4iQmHmWbToCxe0n9/e7OfbexH1UiXzziMfd/2+juqLGmQz
         GG2V0bcv9cvyGtO23DwlVNzPblgHBY1eEvHK/a0twFUUhRvAyj2sOEtPd4tVj3fYF10+
         qxK5gqW07AVDfbmsHaWVLluz+ksRn0JWe+aBsoWOUtur8fTt+PhZi3tAJPiCVExxVee9
         kXL8GNXblQvmTYxFqwANttk+2PBCvgYL4jNqRHo4dtQ2tTFhh9cWQBgJhjCCGXn4P1C7
         xliQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1781262955; x=1781867755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dp5L1YSfueaf9o+PtALM//GQPXboA3QXkv9r9sOD9Kw=;
        b=ICrUiEqa7DHTUq1j+TJymGgXDjhO17fa0hOTFSgjGAlqj9JIvwtPFR7ThW0ViNDBij
         OmOo3whBWI6dUlil1yWaar1W3dsgjE6c7j0hPfgnLP/zBoK/o431l4JV5irZmsDGQgv/
         uduvgsoIQ8rg3fvyFcJ1Ntg5ZJglYHDbKhOsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781262955; x=1781867755;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp5L1YSfueaf9o+PtALM//GQPXboA3QXkv9r9sOD9Kw=;
        b=HHtRPhXOHvIz/wStYRi1EX+DWH18VM25Ptli5DOoxJYcOeW1kfwuNMJfwSmbDa5UaV
         REQ2ppeDIULHQoCF36HJGxegZZabWhYc07w0fiCVSsxD8V8eCUT8Yxb5sEdWsLxNlyXu
         c5LMpeVwEP2QhxJBU8JwFOJ/5WM8QSpmlzc4zRAHeav/WNd0a75U5gKaLPwx1XZ7UR0t
         UPxYGPFVlsfCvzWMuTLxIYRgUUnYZtjLYmZbwac3HioweZyVOz6byckzf5b9wCeeUHjQ
         kKZ5PiSHputOOdbsOoMQ6Bg8zxNBqsfbVjob59wLnhXPf6c6ydiTm6gBEZaw7AxtOWT+
         sLzQ==
X-Gm-Message-State: AOJu0YyXyxENBU/GrO3JO+7INgVvPkL755y4T9XIfCD/wPZSk2QpbUtf
	POxCADiAg2cvgXp7HzxnP+c1PVPSYgxMtR5tGHuEw09CPkyIKTrLgP8Y5t9RhKnY/wjmtsgGi4O
	F97U9EVyN+IhO49/18DUgnjx3Cq9KAjkZhfO/JnjdSjAIXg4dyTQylH8=
X-Gm-Gg: Acq92OET/ObRleB2itZsDU1kpxKMQ/52lR/77Mf3PSGFYDB3nDkU1oercvq7oTxwXWl
	iOPAHXmTTvN6kfLseH4selsiPdLJv8x7WPDcNSmUOtHIqNLHHSejAwzKeRAgSFiTWqizJvTz9ot
	WvybbLIu1wtCu8mBShisemXAvoTD7qrzJYX2jNTKAfWNaXD0MvYFezpvfmYbWrHdBDNPB5ZoQ+U
	CIUWlj+TYKBH1emrx+wXWywvX961//ZmItk7LuqhIFDmKwqQnIWpT20g/84ql4M2oIFHM0MvOl5
	07xeCCQ=
X-Received: by 2002:a05:690c:62c4:b0:7da:150a:18b6 with SMTP id
 00721157ae682-7f7b6345a51mr19964687b3.16.1781262954794; Fri, 12 Jun 2026
 04:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 12 Jun 2026 13:15:43 +0200
X-Gm-Features: AVVi8CfnvKgq1e7DKbFqakC1FDizq7gAaW4boR2eQCicTLh8VOP2-1J_CoBozWA
Message-ID: <CAL71e4Mp7ewv0UGS8j=iTq6quyxLXzrr0uNDbWR8JKaOsTSVyA@mail.gmail.com>
Subject: [RFC] commit-reach: terminate merge-base walk when one paint side is exhausted
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi! I previously sent a patch[1] to optimize paint_down_to_common
for the single merge-base case. I believe I have found a stronger
optimization, but before sending a patch I wanted to discuss the
correctness argument.

The main problem to solve is that computing merge-bases is slow today
in some scenarios, especially large monorepos with complex graphs.
This affects multiple operations, including merge-base and merge-tree.

The previous patch improved it for the special case of the
merge-base being part of the commit-graph and the caller only
needing to know about one merge-base.

I have an idea to make it faster for fetching all merge-bases for
common flows in large repos, as long as the commit graph is
reasonably up to date.

The key part is the exit condition in paint_down_to_common.
Instead of waiting for the queue to only contain stale entries,
it is enough to wait for one of the sides to be exhausted,
i.e. side 1 is exhausted if no more commits exist in the
traversal queue flagged with only PARENT1. For example, if
the two sides are origin/HEAD and a small PR branch, the PR
branch will quickly become exhausted at the merge-base, while
the main side will continue.

Now you may ask: why is that a safe condition?

The traversal in paint_down_to_common has two logical phases
due to the priority queue ordering:

  1. Process all commits with infinite generation numbers.
     This includes all commits when there is no commit-graph.
  2. Process all commits with finite generation numbers.

These happen in strict order -- all INFINITY commits are popped
before any finite-generation commit.

The optimization only applies after the walk enters the second phase.
In the first phase, the traversal behaves exactly as today
and uses the existing termination condition.

In the second phase, traversal follows strict topological
order -- descendants are processed before ancestors. Paint flags
propagate from each processed commit to its parents, which have
strictly lower generation and are therefore not yet examined.

A new merge-base candidate can only form when a PARENT1-only path
meets a PARENT2-only path. Once a commit acquires both paint flags
in this phase, any descendant carrying both paint flags would
already have been processed.

Once one side is exhausted from the queue, no new meeting between
pure sides can occur. Any commit that subsequently acquires both
paint flags must inherit them from a commit that already had both
flags -- it is deeper in the graph and cannot affect the final
merge-base set. We can stop.

On a large monorepo with previously expensive merge-base and
merge-tree queries, I observed speedups ranging from roughly 300x
to 1000x. The nice thing is that this works for merge-base --all
and every internal caller of paint_down_to_common -- we no longer
have to restrict the optimization to finding just the first merge-base.

Does the correctness argument above hold?

Happy to come back with a patch later if the logic holds and the
overall approach is wanted.

Thanks,
Kristofer

[1] https://lore.kernel.org/git/pull.2109.v4.git.1778504352.gitgitgadget@gmail.com/
