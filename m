Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220538062A
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324468; cv=none; b=bWPRPI8JKnw4z/Z7eC0x1sn660rxL1N/Xl3S9hF68dH+EKTSdPixtQ14I8PqcBHJBTb9579A0r7oDtRUfm5nJTjfvEuU8BEZ+xlFuOatIxoesyJpe+tIlHr8oYAZ6zPvwrG2mUYi8dpqe1/GrzowpniZ2pJifg5GOTC2h1kjEn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324468; c=relaxed/simple;
	bh=aoQzdEvFkV7NbfffKoG7zBCXiDHlV06CDB2zwlHrT3A=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m+64Ljnvg47VEeiKp/A1K1r2SowkKWRJZpDur8zjoZSzEx6/TrQ/mFar+D1ADsWzfX9dabrYnyMDrdXpoQyyd/BqlgypySIfHRSgmJQL7Ljjv6KllzYnpMgwKM1x7TypqSxEJ+XHMVn8xwyb6Mea16v2XzkSV/t/hB3o8sNhOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmZMcE4A; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmZMcE4A"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40ffd94a707so8135765e9.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 08:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707324463; x=1707929263; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqOr+Td/zrPuaj4iMt06qx2R+eRW4VMqItEJnGg9M6s=;
        b=SmZMcE4ANMEGVjhcha1Bdy8xi5u5wWvEglVXf8kM+f7oAiQABU0H/XYGYh+8gAD+lW
         tatZ8e8GJNjbmqADDpqxXbkcMmm3jJN8qgnAEkxKDLYbqsN/t5wcehWbQb+LRQnvrm/o
         9oACHOtS4LcuZxnuTdYlwtjGg+u1qLnW+QNkRkLBG3mB1bp/q5DAtJSdgy5Xmyk0/h51
         Q0Q8jrKuL7i5+gSmYIzDyqxqQv8ZEoyp18+UHTFxieBPZYNizXz7Dx0o+6ro1gvuCNq6
         lKEMJELMW3aCN+OlkYb7rWrPT3fzIxUP93W7PEFiXxQPzgPbKvWCfBk1M/A+7Q7aJp1F
         +bPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324463; x=1707929263;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqOr+Td/zrPuaj4iMt06qx2R+eRW4VMqItEJnGg9M6s=;
        b=h1Ln97gpFWzoCmV4ODUBTBc1GP/VNZ0wWyYUfxMPyJY3UrpQf04VqHf0MiBfsE4PA1
         JsKKquS9ZllQOHk1oMW20bHSV1WyR/HLUtYC2eDKyQG3eIV78hnJ5+z4UULb/+jvK7PV
         QQWrYjjMfAP6Xm8dgBCTJaFrUC+7tsBJex1YDn3wwQYw/Na4bt1ZBCAUXGDXTJt9J409
         iqiIc5mtdKVmg8EVFrYF/9veRY/VNlwjwx12s1Hg9u1CN5BhCCvmkO8uBQfMTOi7v/ef
         ua4h8mQILdCrKW0hktJnaqa8MYpA8h0J1GYrmxqOSYv/A5468KfSRntErDPSNM2xGRd3
         UwUA==
X-Gm-Message-State: AOJu0YzqWWtih3OZa1VnIFap3bKtOBKCH4qRfTUrxQW7qGGhga1xJT1a
	mOGx4soNqmLKdfmNfYtmN9FgYXfw55UJgE6v78zbnaeZhOWnzZvkovw3oLcr
X-Google-Smtp-Source: AGHT+IHR53E/5Su3vsYAprwM+W0Hodz3o+P7HpTjU5qBVJ2PIbi5kzKkMf1/1DXsq4QcdX1mysmM2w==
X-Received: by 2002:a05:600c:46ce:b0:40f:f4e0:c2c6 with SMTP id q14-20020a05600c46ce00b0040ff4e0c2c6mr3104097wmo.12.1707324463479;
        Wed, 07 Feb 2024 08:47:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLFqzlxAp/4fPRtKc+pi7hT06FyRWnL+8RD/fkCCNcQxccmXZP8qkGHKNllmjweKeSd0Wngtp5qRRgLIWFZingifC4NEwgtgkRxw==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c4f8d00b0040fd1629443sm2613178wmq.18.2024.02.07.08.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:47:43 -0800 (PST)
Message-ID: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Feb 2024 16:47:36 +0000
Subject: [PATCH v2 0/5] merge-tree: handle missing objects correctly
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
    Johannes Schindelin <johannes.schindelin@gmx.de>

I recently looked into issues where git merge-tree calls returned bogus data
(in one instance returning an empty tree for non-empty merge parents). By
the time I had a look at the corresponding repository, the issue was no
longer reproducible, but a closer look at the code combined with some manual
experimenting turned up the fact that missing tree objects aren't handled as
errors by git merge-tree.

While at it, I added a commit on top that tries to catch all remaining
unchecked parse_tree() calls.

This patch series is based on js/merge-tree-3-trees because I introduced
three unchecked parse_tree() calls in that topic branch.

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
 t/t4301-merge-tree-write-tree.sh | 24 ++++++++++++++++++++++++
 13 files changed, 84 insertions(+), 15 deletions(-)


base-commit: 5f43cf5b2e4b68386d3774bce880b0f74d801635
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1651%2Fdscho%2Fmerge-tree-and-missing-objects-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1651/dscho/merge-tree-and-missing-objects-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1651

Range-diff vs v1:

 1:  a3e8ae86114 ! 1:  01dfd66568c merge-tree: fail with a non-zero exit code on missing tree objects
     @@ merge-ort.c: static int collect_merge_info(struct merge_options *opt,
      
       ## t/t4301-merge-tree-write-tree.sh ##
      @@ t/t4301-merge-tree-write-tree.sh: test_expect_success '--merge-base with tree OIDs' '
     - 	git merge-tree --merge-base=side1^^{tree} side1^{tree} side3^{tree} >with-trees &&
       	test_cmp with-commits with-trees
       '
     + 
      +test_expect_success 'error out on missing tree objects' '
      +	git init --bare missing-tree.git &&
     -+	(
     -+		git rev-list side3 &&
     -+		git rev-parse side3^:
     -+	) | git pack-objects missing-tree.git/objects/pack/side3-tree-is-missing &&
     ++	git rev-list side3 >list &&
     ++	git rev-parse side3^: >list &&
     ++	git pack-objects missing-tree.git/objects/pack/side3-tree-is-missing <list &&
      +	side3=$(git rev-parse side3) &&
      +	test_must_fail git --git-dir=missing-tree.git merge-tree $side3^ $side3 >actual &&
      +	test_must_be_empty actual
      +'
     - 
     ++
       test_done
 2:  3e5b787fc03 = 2:  a1bbb7e06e5 merge-ort: do check `parse_tree()`'s return value
 3:  85d3e672871 = 3:  be1dadf2850 t4301: verify that merge-tree fails on missing blob objects
 4:  93abd7000b8 = 4:  ffd38ad602a Always check `parse_tree*()`'s return value
 -:  ----------- > 5:  43c04749513 cache-tree: avoid an unnecessary check

-- 
gitgitgadget
