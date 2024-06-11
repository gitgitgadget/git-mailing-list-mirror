Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766FF249E5
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130294; cv=none; b=eQRbyjzztkUYdQq9yqRPL6sr/QfI2Z297B9+6fN+gD2Och5hC/GeuBoyxwiDPzcj75kO8H6ltETjh6SoirHAp9pBM4GL/DeTKRNf8jxTCDTLUG1AFYTebQjCEKSuYo8mSmVcKAcq98DfPikkbo1GzhY2vbPfG4Yxn4/VpfiR4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130294; c=relaxed/simple;
	bh=ckBezX9QcsSn+3IhP3/EiS7jekxo22iA5D7XmSr1G0A=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=G3si3iiN4HPyjfZxZXQvZluN+/TZY696bJStlmR/R1Fdvor8Zyv0kyyFaFBmunVl3sRG6zeVyD9qbafnLA8nxNZU0rhySI+Z6aTpqcX45QzfJ4eeBtrYjG/GeONzeUaJBurGTyQJV7Er1vlnhv6KPMm8tc6/D8ZkcCR18gNLmzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCWQnnRa; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCWQnnRa"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35f23f3da44so2294752f8f.0
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130290; x=1718735090; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9lSZQvtHK8bpj510EMfU2pbXEjSWj7mLfI2wOz6ukLs=;
        b=NCWQnnRaMZyMor9fN5ARja11gPCZ6abOFzW8eKeHyo1x2Arrv3Pb9TJwe7EP6e1kwX
         xFqOAPYDAXGKWgIi+J30HWNfA4zlbYBnwryX3BOGOIsfAdl6ESKYW/wnB7LCnoOyIGyx
         h9bsSMWoX8C/4zE1xW3FMoXFGRIfnOJDF4hzXcRJpUWH8zzHtVDsdmXxWTQamteK7bc0
         cwv1BrCFmcXaRHYHTazo/HdhCuG/JnkdJ0AC4LDJHKLcK+k/sO1finUps6PFPB5wUkE6
         XZdTucVIrbo5j318RRFK822ETrvzME1H4ojagh4cKYsyTu+wAYM+V4aKg8GQtTzOOffy
         HJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130290; x=1718735090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lSZQvtHK8bpj510EMfU2pbXEjSWj7mLfI2wOz6ukLs=;
        b=OfhknuNfR2nyTLE6hNTiqYi/dtPASnct98OP0/UVZWKWaHBQn8hzxpD2qI4ysxeqxK
         Yl59Zo+M7BCtaDkif6yO9J+pKgQi7nMMTgnwYnAfiYpnWcGTk8T7Nus7boXbckHxIllb
         zK0tx8WRzzVY7Yjuqzw158UBCMLH84ic+aoTWoxtryO47pwk/K7JVK7IOhybXVhRVQNR
         oAKQTT2FlBvsx63SNVoPUkkzzSR2/xKKIf6gKT1eL9HCwE3ifaGUboF9ue/fiAEO3d+m
         2B7mCnmdCDVkpwgeVyM7p7brr/J8UqiqARKBhVTUUqF6W1JAnA6qVYN8M7y/3ZVeDnN5
         WqZA==
X-Gm-Message-State: AOJu0YymeOWQJxtoRqw5iwx7hKzqsU9PxIvWvG6OItyZ3nYHB+1iHyf4
	m7dvtVqqTy1d6heAi+9b9uFcoS5L+q+1rInzVhMh8c3LsD1LWMko4+N30Q==
X-Google-Smtp-Source: AGHT+IFNoOZF+f5Y1oVj7QZ2C7/sbKfeNN3qLrK4WY+BFdfjOI/OUSm30kHzfRfkUk+ffUfl1y+HKQ==
X-Received: by 2002:a5d:408d:0:b0:35f:11c5:5c74 with SMTP id ffacd0b85a97d-35f11c55ee3mr7436858f8f.36.1718130290065;
        Tue, 11 Jun 2024 11:24:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0d512556sm10989224f8f.29.2024.06.11.11.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:24:49 -0700 (PDT)
Message-Id: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:32 +0000
Subject: [PATCH 00/16] mktree: support more flexible usage
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
Cc: Victoria Dye <vdye@github.com>

The goal of this series is to make 'git mktree' a much more flexible and
powerful tool for constructing arbitrary trees in memory without the use of
an index or worktree. The main additions are:

 * Using an optional "base tree" to add or replace entries in an existing
   tree rather than creating a new one from scratch.
   * Building off of this, having entries with mode "0" indicate "remove
     this entry, if it exists, from the tree"
 * Handling tree entries inside of subtrees (e.g., folder1/my-file.txt)

It also introduces some quality-of-life updates:

 * Using the same input parsing as 'update-index' to allow a wider variety
   of tree entry formats.
 * Adding deduplication of input entries & more thorough validation of
   inputs (with an option to disable both - plus input sorting - if desired
   with '--literally').

The implementation change underpinning the new features is completely
revamping how the tree is constructed in memory. Instead of writing a single
tree object into a strbuf and hashing it into the object database, we
construct an in-core sparse index and write out the root tree, as well as
any new subtrees, using the cache tree infrastructure.

The series is organized as follows:

 * Commits 1-3 contain miscellaneous small renames/refactors to make the
   code more readable & prepare for larger refactoring later.
 * Commits 4-7 generalize the input parsing performed by 'read_index_info()'
   in 'update-index' and update 'mktree' to use it.
 * Commit 8 adds the '--literally' option to 'mktree'. Practically, this
   option allows tests that currently use 'mktree' to generate corrupt trees
   to continue functioning after we strengthen input validations.
 * Commits 9 & 10 add input path validation & entry deduplication,
   respectively.
 * Commit 11 replaces the strbuf-to-object tree creation with construction
   of an in-core index & writing out the cache tree.
 * Commits 12-14 add the ability to add tree entries to an existing "base"
   tree. Takes 3 commits to do it because it requires a bit of finesse
   around directory/file deduplication and iterating over a tree with
   'read_tree()' with a parallel iteration over the input tree entries.
 * Commit 15 allows for deeper paths in the input.
 * Commit 16 adds handling for mode '0' as "removal" entries.

I also plan to add a '--strict' option that runs 'fsck' checks on the new
tree(s) before writing to the object database (similar to 'mkttag
--strict'), but this series is pretty long as it is and that part can easily
be separated out into its own series.

Thanks!

 * Victoria

Victoria Dye (16):
  mktree: use OPT_BOOL
  mktree: rename treeent to tree_entry
  mktree: use non-static tree_entry array
  update-index: generalize 'read_index_info'
  index-info.c: identify empty input lines in read_index_info
  index-info.c: parse object type in provided in read_index_info
  mktree: use read_index_info to read stdin lines
  mktree: add a --literally option
  mktree: validate paths more carefully
  mktree: overwrite duplicate entries
  mktree: create tree using an in-core index
  mktree: use iterator struct to add tree entries to index
  mktree: add directory-file conflict hashmap
  mktree: optionally add to an existing tree
  mktree: allow deeper paths in input
  mktree: remove entries when mode is 0

 Documentation/git-mktree.txt       |  42 +-
 Makefile                           |   1 +
 builtin/mktree.c                   | 595 +++++++++++++++++++++++------
 builtin/update-index.c             | 119 ++----
 index-info.c                       | 104 +++++
 index-info.h                       |  14 +
 t/t1010-mktree.sh                  | 354 ++++++++++++++++-
 t/t1014-read-tree-confusing.sh     |   6 +-
 t/t1450-fsck.sh                    |   4 +-
 t/t1601-index-bogus.sh             |   2 +-
 t/t1700-split-index.sh             |   6 +-
 t/t2107-update-index-basic.sh      |  32 ++
 t/t7008-filter-branch-null-sha1.sh |   6 +-
 t/t7417-submodule-path-url.sh      |   2 +-
 t/t7450-bad-git-dotfiles.sh        |   8 +-
 15 files changed, 1055 insertions(+), 240 deletions(-)
 create mode 100644 index-info.c
 create mode 100644 index-info.h


base-commit: 8d94cfb54504f2ec9edc7ca3eb5c29a3dd3675ae
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1746%2Fvdye%2Fvdye%2Fmktree-recursive-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1746/vdye/vdye/mktree-recursive-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1746
-- 
gitgitgadget
