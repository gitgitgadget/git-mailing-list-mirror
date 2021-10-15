Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8BFC433FE
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 21:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2572560F8F
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 21:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbhJOVWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 17:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbhJOVWp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 17:22:45 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95080C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 14:20:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p21so3480335wmq.1
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 14:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GbQSOqcF9ICm7IiW28cZ7ylur6ZTyozM5nRY6Ew1qs8=;
        b=LhtGHgQfbJHPbGx86yc4sCqd/wUFd2tVI8rHf8s+4rEFW/a3w74mnpymALHkSMsv6y
         Uj07c8Skb4UKBY5Nzi1z59f+g/vuNajrDulN/bVZ7QBJtMRXyAaYakmQx2gjPywFqL44
         BZg1Ul+JTnm4vbTYqRDO8Jbn7ZBhSzzr8Q6vSijGsLHPf/1hMjBFqPiglHK+TbUnr78J
         Z62sDyxGuYx7J5BnuZsX9aMuCp+zxAtk2VBosjGT0JaJI+3MaT5pHm+B9fxofRF/Wofj
         3T6Uc54zBoyF7gRQL7Ttz7xCMRwmQtq1JNwJPE8T1o6imUGONgt6p1NwYLcfktTEVff/
         ZVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GbQSOqcF9ICm7IiW28cZ7ylur6ZTyozM5nRY6Ew1qs8=;
        b=F33H2B/tUGhGCjJrMsduNWGqdxb3M6EZOE9BkG/jxlYK6ReV/WMdpnsw3zvrIPdxTi
         efYETosESJf66V/wGurxFZNLj5dxKgcNlV3oPl8YFfjZwGc7pm+cZ7c3g38VHjih+XuJ
         0A/46k/EM+1x+fJZxUcFt+AhPPggMERq8RiWLUwNiLTMxB5u+Px1G3E6He/0xHp2a7uH
         xKE6XrUHcR1c98XhIVWNC4LXv9MWqGvC4rxspmW62/a9DDkp0QlK3ebEqooENRdpk7Sq
         r3QN7Lxxu1vN6j4Z/dJcjymIsyV6pZGf3wuVDT156ckUHxi/S566aOQ0BRDcaZNbfr4T
         9Wqw==
X-Gm-Message-State: AOAM5309S7bIPjRKRlZhRfaEpCKj6atrDs4uqdbjOY/rz6SLZT8/CubR
        LzwnUZW7iabDk5r86mYTiHioqFBKtgA=
X-Google-Smtp-Source: ABdhPJyQjRqC1HgPVKPAEnq5EQihvum+BWWJv+q0wSbPdiG2TclxNZkMdIR1v88k6rlTNxwlthOxKg==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr15009366wmc.108.1634332837047;
        Fri, 15 Oct 2021 14:20:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e15sm5792632wrv.74.2021.10.15.14.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 14:20:36 -0700 (PDT)
Message-Id: <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.git.1634232352.gitgitgadget@gmail.com>
References: <pull.1050.git.1634232352.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Oct 2021 21:20:33 +0000
Subject: [PATCH v2 0/2] Sparse Index: diff and blame builtins
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on vd/sparse-reset. It integrates the sparse index with
git diff and git blame and includes:

 1. tests added to t1092 and p2000 to establish the baseline functionality
    of the commands
 2. repository settings to enable the sparse index

The p2000 tests demonstrate a ~30% execution time reduction for 'git diff'
and a ~75% execution time reduction for 'git diff --staged' using a sparse
index. For 'git blame', the reduction time was ~60% for a file two levels
deep and ~30% for a file three levels deep.

Test                                         before  after
----------------------------------------------------------------
2000.30: git diff (full-v3)                  0.37    0.36 -2.7%
2000.31: git diff (full-v4)                  0.36    0.35 -2.8%
2000.32: git diff (sparse-v3)                0.46    0.30 -34.8%
2000.33: git diff (sparse-v4)                0.43    0.31 -27.9%
2000.34: git diff --staged (full-v3)         0.08    0.08 +0.0%
2000.35: git diff --staged (full-v4)         0.08    0.08 +0.0%
2000.36: git diff --staged (sparse-v3)       0.17    0.04 -76.5%
2000.37: git diff --staged (sparse-v4)       0.16    0.04 -75.0%
2000.62: git blame f2/f4/a (full-v3)         0.31    0.32 +3.2%
2000.63: git blame f2/f4/a (full-v4)         0.29    0.31 +6.9%
2000.64: git blame f2/f4/a (sparse-v3)       0.55    0.23 -58.2%
2000.65: git blame f2/f4/a (sparse-v4)       0.57    0.23 -59.6%
2000.66: git blame f2/f4/f3/a (full-v3)      0.77    0.85 +10.4%
2000.67: git blame f2/f4/f3/a (full-v4)      0.78    0.81 +3.8%
2000.68: git blame f2/f4/f3/a (sparse-v3)    1.07    0.72 -32.7%
2000.99: git blame f2/f4/f3/a (sparse-v4)    1.05    0.73 -30.5%



Changes since V1
================

 * Fix failing diff partially-staged test in
   t1092-sparse-checkout-compatibility.sh, which was breaking in seen.

Thanks, Lessley

Lessley Dennington (2):
  diff: enable and test the sparse index
  blame: enable and test the sparse index

 builtin/blame.c                          |  3 ++
 builtin/diff.c                           |  3 ++
 t/perf/p2000-sparse-operations.sh        |  4 ++
 t/t1092-sparse-checkout-compatibility.sh | 69 +++++++++++++++++++++---
 4 files changed, 72 insertions(+), 7 deletions(-)


base-commit: 57049e844c80d5fe1394e6d65b28705eabfd6585
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1050%2Fldennington%2Fdiff-blame-sparse-index-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1050/ldennington/diff-blame-sparse-index-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1050

Range-diff vs v1:

 1:  9a597233cf4 ! 1:  ac33159d020 diff: enable and test the sparse index
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff --staged' '
      +	EOF
      +
      +	# Add file within cone
     -+	test_all_match git sparse-checkout set deep &&
     ++	test_sparse_match git sparse-checkout set deep &&
      +	run_on_all ../edit-contents deep/testfile &&
      +	test_all_match git add deep/testfile &&
      +	run_on_all ../edit-contents deep/testfile &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff --staged' '
      +	test_all_match git reset --hard &&
      +	run_on_all mkdir newdirectory &&
      +	run_on_all ../edit-contents newdirectory/testfile &&
     -+	test_all_match git sparse-checkout set newdirectory &&
     ++	test_sparse_match git sparse-checkout set newdirectory &&
      +	test_all_match git add newdirectory/testfile &&
      +	run_on_all ../edit-contents newdirectory/testfile &&
     -+	test_all_match git sparse-checkout set &&
     ++	test_sparse_match git sparse-checkout set &&
      +
      +	test_all_match git diff &&
      +	test_all_match git diff --staged &&
      +
      +	# Merge conflict outside cone
     -+	test_all_match git reset --hard &&
     ++	# The sparse checkout will report a warning that is not in the
     ++	# full checkout, so we use `run_on_all` instead of
     ++	# `test_all_match`
     ++	run_on_all git reset --hard &&
      +	test_all_match git checkout merge-left &&
      +	test_all_match test_must_fail git merge merge-right &&
      +
 2:  ddcee003c92 = 2:  a0b6a152c75 blame: enable and test the sparse index

-- 
gitgitgadget
