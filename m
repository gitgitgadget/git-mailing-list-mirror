Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35ED211476
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436285; cv=none; b=jyUZ/kSC6mqGs8DjyQP6GMEq9fGSe6nAsuJsKOA7V7GVJ6/mxooJUj3Oes5dfSLUS9os+xzGWQRQH8VukN3/ZW6teQ1az4SDCDcoj42AXgnRiin5wT771up/qSWB7Ux/1II3UL97T164u40pHrbjAP7qbdNA5pQKKDtdtRhBBe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436285; c=relaxed/simple;
	bh=SnVsrapYf3xhl6HR3ACZzAiHCFp4p5k4HKn4OYJu28k=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=cA3ffyhhvuNvmqnACQ1a/y8odoXAFTIsJIRcHUYGdGrYS+LuSr2h7UxVk0OmdZfUJvfPbobBkInmEIiBYO5IDdkNP7jOKeYjsjrk0dgsnw7M5hs+7NrSOQry3OyyJeJA9w7rbROVGuhpJAukcxWPvuNPaTN9VkWOUP8ltGAs9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfCgZDAL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfCgZDAL"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso4446495f8f.0
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743436282; x=1744041082; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xx9ros77PsXrq4rkgJUmAG5OVhoDykGXFMocpGM28QM=;
        b=kfCgZDALFf5118l223/xFLa71i7W5fxFqRa90V2vcDTeu04IxJcs13ix04s6p0rA0R
         Bht33Ah2bPk3embSuu4XtnvG1lJ0eGcav2W+tuGIjDMaIHFi5I3qBEAuo9aIURN0jmEG
         x4rM8P70+U72chrRhWdWkejMRpGHzgQcG76L5eKSsUGTQujjjeZaq4FX9JKx/FDW+2MF
         awP7dX8k0BQvuAVKNa5UmOM5Ho7GvsclXssVNFsyZ3BZFDUMoD5HrpKiZ84aR4Y0g3kF
         6kLIShFAQ6DId7bmdOJKjOk8cIY9Ta87c4bXwPLCV2MeFTtd8sQpuKS6JcMKxAIi4YuY
         yqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743436282; x=1744041082;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xx9ros77PsXrq4rkgJUmAG5OVhoDykGXFMocpGM28QM=;
        b=a/9b0ALwK8yWQnyI/Uxrmf8YqFm2Fpk0ko9s3vNGKFlx13ryFkkSvgPUvzL+2fxrpL
         6thpZOhRKvhr3MsbOPY/P4bCuIiZLXp9jiCbBhSQcCuCZGRB9OPGj676+DvGLiWek1AF
         GQXck+KsxJoE2R3S1C/DpMffr1gwbTA8GWCabGWAF7SxeymEB5RxeYV+OcZjyuaNug9l
         dpCicmfM4M794GLYf69L9wZAEwI/w3CKtf8Zs1YfNIGM1CVMaGryzUre6g3gAzZv6doR
         AjF8cWSHtM6W3ZI/kDBD8uCVQJ4LW8njNvDL7OTDShjtLG9mTNYA8At7XEpkJYTq9pj3
         2vug==
X-Gm-Message-State: AOJu0YxqH7cTqAirUBlvRyBAZBAtJPiUm66CRkhUG0hA5YUt0mO//J4X
	W+FZlj3vY3ias2tOoXlwGUB9gMlnvJYx/zwot6dgEWb7zFOB+UkAEUDiLQ==
X-Gm-Gg: ASbGncvcqwtrzYUdHtmS19Z1w5lcb9z3pqThYtsunm8bNj6P9jCN9y3G0dvV/fiH1Wz
	z77dPsHTWYjVKAsFTXehgSj3dEQ2Ym8xf6g9s1dAob9e8YrmEwqt9n5DtNZeiaqsrf5xQRyoUuF
	mzKWbX6ObrBlJw9I/lnJQzp+c+VfeGBjhsNcnn68hIJV4/FZ6tb7R0CQBUuyXIgT3FNTNn7gwCu
	upEv/ZUIW0sKXp0vlb0CczuXdbegBRJFt/jRZOzFw/tgzuntoB/5ag/cVuzwe6ypX8hQDSY7kAS
	xnHpc6daoJBS6LAydifgZ8wExSuBAn7LvgTF2BHyWUnY6g==
X-Google-Smtp-Source: AGHT+IGf82n5r5VXB4r4n6XNRk4Y+xOqEsLNKM4h17885I1X3m5qWk9ev2u56aVLsEPgYwRViJ6LgQ==
X-Received: by 2002:a05:6000:1ace:b0:391:48d4:bd02 with SMTP id ffacd0b85a97d-39c120e3d56mr6658362f8f.29.1743436281679;
        Mon, 31 Mar 2025 08:51:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b60a9ddsm11771862f8f.0.2025.03.31.08.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:51:21 -0700 (PDT)
Message-Id: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Mar 2025 15:51:11 +0000
Subject: [PATCH 0/8] Debug merge-recursive.[ch]
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
Cc: Elijah Newren <newren@gmail.com>

As a wise man once told me, "Deleted code is debugged code!"

This series does some preparation, then moves the code shared between
merge-recursive and merge-ort from the former to the latter, and then debugs
the remainder of merge-recursive.[ch].

Series overview:

 * Patches 1-5: Preparation; switch remaining callers of
   merge-recursive.[ch] functions to merge-ort equivalents, and add sole
   remaining missing feature (diff-algorithm selection)
 * Patch 6: Nuke merge-recursive.[ch]
 * Patch 7-8: Cleanup testsuite; we don't need GIT_TEST_MERGE_ALGORITHM
   anymore

While the diffstat might look large, the non-test code changes are actually
pretty small. The drivers of the big diffstat are:

 * We move a significant chunk of shared code from merge-recursive.[ch] to
   merge-ort.[ch], without modifying it
 * We delete (the remainder of) merge-recursive.[ch]
 * We rip out all the temporary GIT_TEST_MERGE_ALGORITHM stuff designed to
   let us reuse tests between recursive and ort

Elijah Newren (8):
  checkout: replace merge_trees() with merge_ort_nonrecursive()
  builtin/merge-recursive: switch to using merge_ort_generic()
  merge-ort: enable diff-algorithms other than histogram
  sequencer: switch non-recursive merges over to ort
  merge, sequencer: switch recursive merges over to ort
  merge-recursive.[ch]: thoroughly debug these
  tests: remove GIT_TEST_MERGE_ALGORITHM and test_expect_merge_algorithm
  builtin/{merge,rebase,revert}: remove GIT_TEST_MERGE_ALGORITHM

 Documentation/merge-strategies.adoc           |   51 +-
 Documentation/technical/sparse-checkout.adoc  |    2 -
 Makefile                                      |    1 -
 builtin/checkout.c                            |   10 +-
 builtin/merge-recursive.c                     |    4 +-
 builtin/merge.c                               |   23 +-
 builtin/rebase.c                              |    5 -
 builtin/revert.c                              |    2 -
 ci/run-build-and-tests.sh                     |    1 -
 merge-ort-wrappers.h                          |    2 +-
 merge-ort.c                                   |  162 +-
 merge-ort.h                                   |   60 +-
 merge-recursive.c                             | 4079 -----------------
 merge-recursive.h                             |  132 -
 meson.build                                   |    1 -
 sequencer.c                                   |   58 +-
 t/lib-merge.sh                                |   13 -
 t/t1092-sparse-checkout-compatibility.sh      |    2 -
 t/t2501-cwd-empty.sh                          |    2 -
 t/t3512-cherry-pick-submodule.sh              |    5 -
 t/t3513-revert-submodule.sh                   |    4 -
 t/t4069-remerge-diff.sh                       |    7 -
 t/t4301-merge-tree-write-tree.sh              |    7 -
 t/t5572-pull-submodule.sh                     |    5 -
 t/t6400-merge-df.sh                           |   14 +-
 t/t6402-merge-rename.sh                       |  125 +-
 t/t6404-recursive-merge.sh                    |   21 +-
 t/t6406-merge-attr.sh                         |    7 +-
 t/t6416-recursive-corner-cases.sh             |  194 +-
 t/t6421-merge-partial-clone.sh                |    7 +-
 t/t6422-merge-rename-corner-cases.sh          |   31 +-
 t/t6423-merge-rename-directories.sh           |  517 +--
 t/t6424-merge-unrelated-index-changes.sh      |    8 +-
 t/t6426-merge-skip-unneeded-updates.sh        |    4 +-
 t/t6428-merge-conflicts-sparse.sh             |    2 -
 t/t6430-merge-recursive.sh                    |   46 +-
 t/t6434-merge-recursive-rename-options.sh     |   16 +-
 t/t6436-merge-overwrite.sh                    |   17 +-
 t/t6437-submodule-merge.sh                    |   65 +-
 t/t6438-submodule-directory-file-conflicts.sh |    5 -
 t/t6439-merge-co-error-msgs.sh                |    2 +-
 t/t7402-submodule-rebase.sh                   |    7 +-
 t/t7602-merge-octopus-many.sh                 |    9 +-
 t/t7610-mergetool.sh                          |   40 +-
 t/t7615-diff-algo-with-mergy-operations.sh    |    2 -
 t/test-lib.sh                                 |    2 -
 46 files changed, 538 insertions(+), 5241 deletions(-)
 delete mode 100644 merge-recursive.c
 delete mode 100644 merge-recursive.h
 delete mode 100644 t/lib-merge.sh


base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1898%2Fnewren%2Fendit-quote-debugging-unquote-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1898/newren/endit-quote-debugging-unquote-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1898
-- 
gitgitgadget
