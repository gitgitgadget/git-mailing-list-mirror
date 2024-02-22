Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3AD36B15
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612611; cv=none; b=DLOiPuMDcwPO0cRFbeL0GOAM1KmK+e00BpQND5oFSEWcKDdw91K3TG27KA+JcYwKLX3/uz/M8/cIabsDa5gRC+xhzh9QUWFaGf6kQr7Uml7vdI/tpWpQTcvOyNpdIkr3/NB8VNg7HCi/hD13VRC2XBs4L4Uo6+aHuuuBilGimaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612611; c=relaxed/simple;
	bh=KE0VtsHmHIfCuyg0wOqLw5t3mXYycY8TfzVwyO4QzRU=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bPzb8fZ23JwGG1dxkANvrJuN9Y2amyUXuY7sefKbloSw037k+L/NcvcA81fLLaGqYfw/moKX56L1CsnHtJSCndsBO9A2Yemhcyrhozt3MlZnx8p/PLiVUkswZtHE+tUmLbI4gGSAE/52gNaIJpi1AenHcRycmlOv8NrBEUURUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPpKGIXI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPpKGIXI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412730e5b95so18360675e9.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 06:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708612607; x=1709217407; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRU5iZ4F9kzwwGIRKPsOb/kX1xJVQMHxDavLBHzzLZM=;
        b=cPpKGIXI3tgnTYDxQHqef2Wx5PiGvKmRBp3ABq5bB9JfYqpdQExDUiOsgecrl0wQBr
         F0S/T9yYlqoj806wn2lf/KoiYHJ1UG1531LnzLxGRk/uenxt6m4g/bXwU2gGPuQWllHY
         zLldawrGXo3gAmzK/z+5a7zfENPmUJo3FvMxE7yPXVAEr3N9/j+cBLitnbMafEV+zkYY
         vD4X+G8dA7kKM6riULinjTYSEe9kUxPgcvDa0d88xjHeV5ANdEDg1XAz89+KA2B37lnh
         apv0t4ov07PoBHnqoAgwRsegt6Yb998JeDiq1hwCqC8L7LmDzVHlcIZ0It9oqxsVdJTe
         5smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708612607; x=1709217407;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRU5iZ4F9kzwwGIRKPsOb/kX1xJVQMHxDavLBHzzLZM=;
        b=gda2CBVM3iXv0wpjxo/lICHPNj6Bb/Co8NuYIIBwdhPB3ixTJj6oRpkaGb77FRfQua
         Du8fiEVmyE1xggWvJhn7oKxUYZHT2HZf2iUWsHy3IUUU2GtbHUkdxUE1tW8xAwz4FrZ+
         qKSZK2yBWQrXvGvF2n+eg8oc5XmaX6OeSZ71N7D5mtXuIJxZm/03giXzIlEpRQK7EHU9
         BK+TAgLmabHGg4DQDOQ+ba1iTLbJbgtOcRoK3jz3TLFcQH+ytA8arfDlZyrfl1pcCw9U
         hFeGFSR0FlpyfzLKssQNrnS+rPwOaxyqJXh6RH8EmlcD5jVcy5nxmPzjxRJSKcqvvMR4
         suFg==
X-Gm-Message-State: AOJu0YzF5kpoecgSo4o6+c4ucP1FFMesO/5OjCi1y5EkKVQIN/JPulfM
	N7y14tQsktt0rAovmcdi7tmTDsKS+RGOJAJ6aqFJIdjQO1g60u+eymXsmA31
X-Google-Smtp-Source: AGHT+IHY86XFn6Cfq5IZyGSd6HgrRsNvxZwFKMvyksdRzpmERW2xYur+FGte6y4QWVhOMA8duffVog==
X-Received: by 2002:a5d:50d2:0:b0:33d:5272:6a8f with SMTP id f18-20020a5d50d2000000b0033d52726a8fmr7417399wrt.14.1708612607259;
        Thu, 22 Feb 2024 06:36:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3-20020a5d4ec3000000b0033ce06c303csm20247810wrv.40.2024.02.22.06.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:36:46 -0800 (PST)
Message-ID: <pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
References: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 14:36:40 +0000
Subject: [PATCH v3 0/5] merge-tree: handle missing objects correctly
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

I recently looked into issues where git merge-tree calls returned bogus data
(in one instance returning an empty tree for non-empty merge parents). By
the time I had a look at the corresponding repository, the issue was no
longer reproducible, but a closer look at the code combined with some manual
experimenting turned up the fact that missing tree objects aren't handled as
errors by git merge-tree.

While at it, I added a commit on top that tries to catch all remaining
unchecked parse_tree() calls.

This patch series is based on 5f43cf5b2e4 (merge-tree: accept 3 trees as
arguments, 2024-01-28) (the original tip commit of js/merge-tree-3-trees)
because I introduced three unchecked parse_tree() calls in that topic.

Changes since v2:

 * Fixed the new "missing tree object" test case in t4301 that succeeded for
   the wrong reason.
 * Adjusted the new "missing blob object" test case to avoid succeeding for
   the wrong reason.
 * Simplified the "missing blob object" test case.

Changes since v1:

 * Simplified the test case, avoiding a subshell and a pipe in the process.
 * Added a patch to remove a superfluous subtree->object.parsed guard around
   a parse_tree(subtree) call.

Johannes Schindelin (5):
  merge-tree: fail with a non-zero exit code on missing tree objects
  merge-ort: do check `parse_tree()`'s return value
  t4301: verify that merge-tree fails on missing blob objects
  Always check `parse_tree*()`'s return value
  cache-tree: avoid an unnecessary check

 builtin/checkout.c               | 19 ++++++++++++++++---
 builtin/clone.c                  |  3 ++-
 builtin/commit.c                 |  3 ++-
 builtin/merge-tree.c             |  6 ++++++
 builtin/read-tree.c              |  3 ++-
 builtin/reset.c                  |  4 ++++
 cache-tree.c                     |  4 ++--
 merge-ort.c                      | 16 +++++++++++-----
 merge-recursive.c                |  3 ++-
 merge.c                          |  5 ++++-
 reset.c                          |  5 +++++
 sequencer.c                      |  4 ++++
 t/t4301-merge-tree-write-tree.sh | 27 +++++++++++++++++++++++++++
 13 files changed, 87 insertions(+), 15 deletions(-)


base-commit: 5f43cf5b2e4b68386d3774bce880b0f74d801635
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1651%2Fdscho%2Fmerge-tree-and-missing-objects-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1651/dscho/merge-tree-and-missing-objects-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1651

Range-diff vs v2:

 1:  01dfd66568c ! 1:  11b9cd8c5da merge-tree: fail with a non-zero exit code on missing tree objects
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success '--merge-base with tree OI
      +test_expect_success 'error out on missing tree objects' '
      +	git init --bare missing-tree.git &&
      +	git rev-list side3 >list &&
     -+	git rev-parse side3^: >list &&
     ++	git rev-parse side3^: >>list &&
      +	git pack-objects missing-tree.git/objects/pack/side3-tree-is-missing <list &&
      +	side3=$(git rev-parse side3) &&
     -+	test_must_fail git --git-dir=missing-tree.git merge-tree $side3^ $side3 >actual &&
     ++	test_must_fail git --git-dir=missing-tree.git merge-tree $side3^ $side3 >actual 2>err &&
     ++	test_grep "Could not read $(git rev-parse $side3:)" err &&
      +	test_must_be_empty actual
      +'
      +
 2:  a1bbb7e06e5 = 2:  f01f4eb011b merge-ort: do check `parse_tree()`'s return value
 3:  be1dadf2850 ! 3:  e82fdf7fbcb t4301: verify that merge-tree fails on missing blob objects
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'error out on missing tree
       '
       
      +test_expect_success 'error out on missing blob objects' '
     -+	seq1=$(test_seq 1 10 | git hash-object -w --stdin) &&
     -+	seq2=$(test_seq 1 11 | git hash-object -w --stdin) &&
     -+	seq3=$(test_seq 0 10 | git hash-object -w --stdin) &&
     -+	tree1=$(printf "100644 blob %s\tsequence" $seq1 | git mktree) &&
     -+	tree2=$(printf "100644 blob %s\tsequence" $seq2 | git mktree) &&
     -+	tree3=$(printf "100644 blob %s\tsequence" $seq3 | git mktree) &&
     ++	echo 1 | git hash-object -w --stdin >blob1 &&
     ++	echo 2 | git hash-object -w --stdin >blob2 &&
     ++	echo 3 | git hash-object -w --stdin >blob3 &&
     ++	printf "100644 blob $(cat blob1)\tblob\n" | git mktree >tree1 &&
     ++	printf "100644 blob $(cat blob2)\tblob\n" | git mktree >tree2 &&
     ++	printf "100644 blob $(cat blob3)\tblob\n" | git mktree >tree3 &&
      +	git init --bare missing-blob.git &&
     -+	test_write_lines $seq1 $seq3 $tree1 $tree2 $tree3 |
     ++	cat blob1 blob3 tree1 tree2 tree3 |
      +	git pack-objects missing-blob.git/objects/pack/side1-whatever-is-missing &&
     -+	test_must_fail git --git-dir=missing-blob.git merge-tree --merge-base=$tree1 $tree2 $tree3 >actual &&
     ++	test_must_fail git --git-dir=missing-blob.git >actual 2>err \
     ++		merge-tree --merge-base=$(cat tree1) $(cat tree2) $(cat tree3) &&
     ++	test_grep "unable to read blob object $(cat blob2)" err &&
      +	test_must_be_empty actual
      +'
      +
 4:  ffd38ad602a = 4:  9e4dc94ef03 Always check `parse_tree*()`'s return value
 5:  43c04749513 = 5:  91dc4ccd04e cache-tree: avoid an unnecessary check

-- 
gitgitgadget
