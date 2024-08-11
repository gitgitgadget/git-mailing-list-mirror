Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDA227447
	for <git@vger.kernel.org>; Sun, 11 Aug 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723397692; cv=none; b=upWM3VOy8r6z439mFLK/DKw6AUGlNkq+cDYy2mYYDG7i0fe8xnf7UwU34eHGKmXA4rCora4fowGu82gLF2wr8CfWFjxjqzwOcoBwOJe8dXTeXMVfzdxb3kjiP7+YwJNGlrIg0LzsWGf4ZyTryPVWkVZQIr20ZcSBn8Y8rH3n42I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723397692; c=relaxed/simple;
	bh=ETO6ZseZdr2O1iIhIaFJ5jC7qtKr4kVjbuHOi46f4UI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SWHK+hs6gum+QXoxHfslK8F/OT0L7itziCWbCtL55hZxBUPhaB5CAi5dKF3OMRizXps8Vrm1M0zwiZr6Hi+nEHeVTiyr6NL+sEbr2EYaM6azRF2SuYkeM1Okggnzkc/FME8xUoqaogoLBD6UcKT6Zgcec1eH0o4OszeJgPLpzks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dn8VcH5m; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn8VcH5m"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428141be2ddso26840945e9.2
        for <git@vger.kernel.org>; Sun, 11 Aug 2024 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723397689; x=1724002489; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3R6k1Cys9ZH1dB/+qdFw3eIp4SsVTxBtTMdFut2bP/c=;
        b=dn8VcH5mNdW75JplxT016gLNwdhjg2FgwiNkFKGJVadaIjnRaw3SexfE9x/bqwYse4
         AY72MYb9ErKIzlhr2YEqf4b37nsl0oVY65Knj8cFPwRlx19TRZVfRMC4Fvd1KBUbnR6X
         j3V9jmWojKAytWFqEjAknxdW0aJySRZZW7INfAUVVJ2E1wag1pDynj0RCBbTtJC8BJ66
         plBKmLlGnVgGI94jC8qDjSwLUsANBqHkHM2WBNv9TwY3RGkCkLWjLpEjRNvq/gVDgAdV
         3rrvSytk6PezpChUnbJTeSyrLs2Svn0kA5GrIN++sHmaHM6ZRwuUAg7+QOgYwxGLBrDn
         +wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723397689; x=1724002489;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3R6k1Cys9ZH1dB/+qdFw3eIp4SsVTxBtTMdFut2bP/c=;
        b=D43MG6AUsOLTLHG0eWtdRiMxoQPO3kUgsLNyU5JqaJjw394Kcs2zE2i1vmUE/53Koq
         YWCAnU+T5az6Elrx1kCaqoGCnwS/rbpxMdJFg6d1JVUa+BNIULxORrlCo9mcVE2vcSaT
         pU19nOxemcUPpSVSbARq9//NC+0usKNrUPxFIxB18hYODGgn/Dc0CRnwQlzHn5l32EJQ
         is9SAw4Hf+kxfZEZDVsc2C62wTzfy9tYTdZDUgATgVjCVEIoZPUSf0KfgNrYjr/pzuSh
         eV8AxcDWBHpz9XKBPFvth/fS82X8cgDwk+8jJd3hluOoZ1g6/2tbWMH8iOyc2d0KlzZS
         aRHQ==
X-Gm-Message-State: AOJu0YzGV0KVFwOF5MeeFyuPVu6nA4FFC2UB0t3tLiT3tuhNOxx4PR40
	5LZ7mRSeT33hg3l443cfMXLHxp6bEyimIfJBhYKNsR6jhM3iJ2R2H12Z/w==
X-Google-Smtp-Source: AGHT+IFg3QDbZA54C/XXPHdZTYUHDNxvrJiOYIENdoOhua5IgcBQRejxAkf9s7waAdLAw4OKsm43sg==
X-Received: by 2002:a05:600c:5248:b0:426:6308:e2f0 with SMTP id 5b1f17b1804b1-429c3a5690bmr46631955e9.26.1723397688731;
        Sun, 11 Aug 2024 10:34:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c74ffb1esm72883485e9.5.2024.08.11.10.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 10:34:48 -0700 (PDT)
Message-Id: <pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
In-Reply-To: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
References: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 Aug 2024 17:34:44 +0000
Subject: [PATCH v2 0/3] git for-each-ref: is-base atom and base branches
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
Cc: gitster@pobox.com,
    vdye@github.com,
    Derrick Stolee <stolee@gmail.com>

This change introduces a new 'git for-each-ref' atom, 'is-base', in a very
similar way to the 'ahead-behind' atom. As detailed carefully in the first
change, this is motivated by the need to detect the concept of a "base
branch" in a repository with multiple long-lived branches.

This change is motivated by a third-party tool created to make this
detection with the same optimization mechanism, but using a much slower
technique due to the limitations of the Git CLI not presenting this
information. The existing algorithm involves using git rev-list
--first-parent -<N> in batches for the collection of considered references,
comparing those lists, and increasing <N> as needed until finding a
collision. This new use of 'git for-each-ref' will allow determining this
mechanism within a single process and walking a minimal number of commits.

There are benefits to users both on client-side and server-side. In an
internal monorepo, this base branch detection algorithm is used to determine
a long-lived branch based on the HEAD commit, mapping to a group within the
organizational structure of the repository, which determines a set of
projects that the user will likely need to build; this leads to
automatically selecting an initial sparse-checkout definition based on the
build dependencies required. An upcoming feature in Azure Repos will use
this algorithm to automatically create a pull request against the correct
target branch, reducing user pain from needing to select a different branch
after a large commit diff is rendered against the default branch. This atom
unlocks that ability for Git hosting services that use Git in their backend.

Thanks, -Stolee


Updates in v2
=============

 * I had forgotten to include a documentation change in v1. My attempt to
   create a succinct doc change in a follow-up hunk continued to be
   confusing. This version includes a more expanded version of the
   documentation blurb for the is-base token.

Derrick Stolee (3):
  commit-reach: add get_branch_base_for_tip
  for-each-ref: add 'is-base' token
  p1500: add is-base performance tests

 Documentation/git-for-each-ref.txt |  42 ++++++++++
 commit-reach.c                     | 118 +++++++++++++++++++++++++++++
 commit-reach.h                     |  17 +++++
 ref-filter.c                       |  78 ++++++++++++++++++-
 ref-filter.h                       |  15 ++++
 t/helper/test-reach.c              |   2 +
 t/perf/p1500-graph-walks.sh        |  31 ++++++++
 t/t6600-test-reach.sh              |  94 +++++++++++++++++++++++
 8 files changed, 396 insertions(+), 1 deletion(-)


base-commit: bea9ecd24b0c3bf06cab4a851694fe09e7e51408
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1768%2Fderrickstolee%2Ftarget-ref-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1768/derrickstolee/target-ref-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1768

Range-diff vs v1:

 1:  580026f910d = 1:  580026f910d commit-reach: add get_branch_base_for_tip
 2:  a1fbdca374f ! 2:  13341e7e512 for-each-ref: add 'is-base' token
     @@ Commit message
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     + ## Documentation/git-for-each-ref.txt ##
     +@@ Documentation/git-for-each-ref.txt: ahead-behind:<committish>::
     + 	commits ahead and behind, respectively, when comparing the output
     + 	ref to the `<committish>` specified in the format.
     + 
     ++is-base:<committish>::
     ++	In at most one row, `(<committish>)` will appear to indicate the ref
     ++	that is most likely the ref used as a starting point for the branch
     ++	that produced `<committish>`. This choice is made using a heuristic:
     ++	choose the ref that minimizes the number of commits in the
     ++	first-parent history of `<committish>` and not in the first-parent
     ++	history of the ref.
     +++
     ++For example, consider the following figure of first-parent histories of
     ++several refs:
     +++
     ++----
     ++*--*--*--*--*--* refs/heads/A
     ++\
     ++ \
     ++  *--*--*--* refs/heads/B
     ++   \     \
     ++    \     \
     ++     *     * refs/heads/C
     ++      \
     ++       \
     ++	*--* refs/heads/D
     ++----
     +++
     ++Here, if `A`, `B`, and `C` are the filtered references, and the format
     ++string is `%(refname):%(is-base:D)`, then the output would be
     +++
     ++----
     ++refs/heads/A:
     ++refs/heads/B:(D)
     ++refs/heads/C:
     ++----
     +++
     ++This is because the first-parent history of `D` has its earliest
     ++intersection with the first-parent histories of the filtered refs at a
     ++common first-parent ancestor of `B` and `C` and ties are broken by the
     ++earliest ref in the sorted order.
     +++
     ++Note that this token will not appear if the first-parent history of
     ++`<committish>` does not intersect the first-parent histories of the
     ++filtered refs.
     ++
     + describe[:options]::
     + 	A human-readable name, like linkgit:git-describe[1];
     + 	empty string for undescribable commits. The `describe` string may
     +
       ## ref-filter.c ##
      @@ ref-filter.c: enum atom_type {
       	ATOM_ELSE,
 3:  db87434e146 = 3:  757c20090db p1500: add is-base performance tests

-- 
gitgitgadget
