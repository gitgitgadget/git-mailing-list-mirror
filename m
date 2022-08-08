Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35124C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 19:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244179AbiHHTH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 15:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbiHHTH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 15:07:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64A438BA
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 12:07:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay36-20020a05600c1e2400b003a4e30d7995so7874932wmb.5
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=wnH1Kdvpn1IrWVBuLNMFERpz8kvHhdbJ1tPb1OujvJs=;
        b=Rw/KSK/JWMLQW9Oi6mKcrX+1Xz0TU2wEQlRmTK8bZI9vyu84DcUDE7W3x3FnX3vtzI
         OiC/VaFTBq8RP4tnfWew8KuK++yGLRsR+sdsrRYEO0Tu+nO5+LndjovhoH0psMRe6LBw
         K486HdYM0BefgIQiinMfcw97oQZrGLXm3w7wihI7q1drr190piu6lrvpAuXvdjxT5kSn
         nNF1K0544NiyV7WNmYiXnCgBa+imhBIsVGj0h6sg1Fr7W+0eC8aCldMcbws/k4duDZNe
         k5ivRn0Gr0fwD3aTOiBP+9GeXyyyJq/P5Wd//r4qq5e243HYlRyd88zriJqothwYIxVT
         bqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=wnH1Kdvpn1IrWVBuLNMFERpz8kvHhdbJ1tPb1OujvJs=;
        b=M5zZd2RLfVa77sb+lP7i4MEOq8D7e8xMPwYvdjAwoo6ZSu9ignaXj1kyw/jrChr1jy
         odQxpIQ6CC1NNJ5F/2DCJ7/a9beQf8q9qfsV5w8DfFDW9rx1lD4wechG6I15RTdHy4aF
         13HOzcLHYmbSosMXU8a73sXdCiaj8oE0qi6Xj/WHcPRSd21GxR1tv0xz90hXSunRcPoc
         uRuuq4UprWRr+5QTPmi5MloLXz6ddycHJefRVUlDV3CgUqKFoLsu6nZtmLi9OCHCmA7P
         C2mPPQMbg5eAqP0uK8QULsgwo7xAQjefxzykqTlk6AgLWxjgtbTFnQjBVBibtfzXg3wq
         cxEw==
X-Gm-Message-State: ACgBeo0cwaO0EXzVVlL53JbJSH5yCRs7Zg/lOrmqxf7aUiTLn8r+WwbH
        l1549QNmJDQRK+AbBEo6jOHABfmVdwI=
X-Google-Smtp-Source: AA6agR4MTQNE1VzBetNVdePK9Ox6MrxIr+WSpb5T7HqTiWnSo1zTJyjmoDadJsEMaVxg2O2VPI/pdg==
X-Received: by 2002:a05:600c:19cc:b0:3a3:3cfe:d548 with SMTP id u12-20020a05600c19cc00b003a33cfed548mr13724046wmq.6.1659985673942;
        Mon, 08 Aug 2022 12:07:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t28-20020adfa2dc000000b0021f17542fe2sm12118850wra.84.2022.08.08.12.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 12:07:53 -0700 (PDT)
Message-Id: <pull.1312.v3.git.1659985672.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
References: <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 19:07:48 +0000
Subject: [PATCH v3 0/4] reset/checkout: fix miscellaneous sparse index bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, shaoxuan.yuan02@gmail.com,
        newren@gmail.com, gitster@pobox.com, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on sparse index integration for 'git rm' [1], Shaoxuan found
that removed sparse directories, when reset, would no longer be sparse. This
was due to how 'unpack_trees()' determined whether a traversed directory was
a sparse directory or not; it would only unpack an entry as a sparse
directory if it existed in the index. However, if the sparse directory was
removed, it would be treated like a non-sparse directory and its contents
would be individually unpacked.

To avoid this unnecessary traversal and keep the results of 'reset' as
sparse as possible, the decision logic for whether a directory is sparse is
changed to:

 * If the directory is a sparse directory in the index, unpack it.
 * If not, is the directory inside the sparse cone? If so, do not unpack it.
 * If the directory is outside the sparse cone, does it have any child
   entries in the index? If so, do not unpack it.
 * Otherwise, unpack the entry as a sparse directory.

In the process of updating 'reset', a separate issue was found in 'checkout'
where collapsed sparse directories did not have modified contents reported
file-by-file. A similar bug was found with 'status' in 2c521b0e49 (status:
fix nested sparse directory diff in sparse index, 2022-03-01), and
'checkout' was corrected the same way (setting the diff flag 'recursive' to
1).


Changes since V2
================

 * Adjusted 'reset hard with removed sparse dir' test in
   't1092-sparse-checkout-compatibility.sh' to avoid 'git rm' log message
   conflicts with [1]


Changes since V1
================

 * Reverted the removal of 'index_entry_exists()' to avoid breaking other
   in-flight series.
 * Renamed 'is_missing_sparse_dir()' to 'is_new_sparse_dir()'; revised
   comments and commit messages to clarify what that function is doing and
   why.
 * Handled "unexpected" inputs to 'is_new_sparse_dir()' more gently,
   returning 0 if 'p' is not a directory or the directory already exists in
   the index (rather than exiting with 'BUG()'). This is intended to make
   'is_new_sparse_dir()' less reliant on information about the index
   established by 'unpack_callback()' & 'unpack_single_entry()', resulting
   in easier-to-read and more reusable code.

Thanks!

 * Victoria

[1]
https://lore.kernel.org/git/20220803045118.1243087-1-shaoxuan.yuan02@gmail.com/

Victoria Dye (4):
  checkout: fix nested sparse directory diff in sparse index
  oneway_diff: handle removed sparse directories
  cache.h: create 'index_name_pos_sparse()'
  unpack-trees: unpack new trees as sparse directories

 builtin/checkout.c                       |   1 +
 cache.h                                  |   9 ++
 diff-lib.c                               |   5 ++
 read-cache.c                             |   5 ++
 t/t1092-sparse-checkout-compatibility.sh |  25 ++++++
 unpack-trees.c                           | 106 ++++++++++++++++++++---
 6 files changed, 141 insertions(+), 10 deletions(-)


base-commit: 4af7188bc97f70277d0f10d56d5373022b1fa385
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1312%2Fvdye%2Freset%2Fhandle-missing-dirs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1312/vdye/reset/handle-missing-dirs-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1312

Range-diff vs v2:

 1:  255318f4dc6 = 1:  255318f4dc6 checkout: fix nested sparse directory diff in sparse index
 2:  55c77ba4b29 = 2:  55c77ba4b29 oneway_diff: handle removed sparse directories
 3:  d0bdec63286 = 3:  d0bdec63286 cache.h: create 'index_name_pos_sparse()'
 4:  97ca668102c ! 4:  010d5e51595 unpack-trees: unpack new trees as sparse directories
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'reset with wildca
      +test_expect_success 'reset hard with removed sparse dir' '
      +	init_repos &&
      +
     -+	test_all_match git rm -r --sparse folder1 &&
     ++	run_on_all git rm -r --sparse folder1 &&
      +	test_all_match git status --porcelain=v2 &&
      +
      +	test_all_match git reset --hard &&

-- 
gitgitgadget
