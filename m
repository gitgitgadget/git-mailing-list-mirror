Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6899C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 21:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245736AbiFNV15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 17:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiFNV1z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 17:27:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4F527CF7
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 14:27:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v14so12883799wra.5
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 14:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=wtJ5y+D+5/CRPAD6GWuFCWJPLbFgGMjuKpZvS3ZezCw=;
        b=LSa7NUtx7cQuhGMTosOug9Fy3CoZEyM2J7r21KX6U9Pa79oyeNru1inaHhi3MlGXsU
         v6WaO31DvQTrkIxjx4v2+WLTdZyuaixzzxIaE/d7rZEfdJI4ZeKGbDVl8FxWpSDH3zMo
         f+Qjp+BQEiFwMnE/ZFdXO6JnwbcqNnuCthm64YQnlSwTFsdDHHoNdg+gyX6hC18X96dE
         3ZEpbyaMlINJbhsJZi+M7hGArNDLh0Ni8NOUG3UVIAlCY1gJdoJrIhNgGp1z5Q4BYu2g
         klUgYT90SMBeb+6pINsJ1SXDp39hRZJJ1aCqH0LvmV/jPjJSedvMYe4u+GLzaktha/cp
         MZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wtJ5y+D+5/CRPAD6GWuFCWJPLbFgGMjuKpZvS3ZezCw=;
        b=pYIrRDoKzSytG+bYaS0olhxBHid/SL0dj0eaFT+9Oby0uvP4Hp543L23R3PDfU9bp3
         DNwj0W5MC6YlrSIVySzuNJP4MAGdKSjy3y4veN/UWjxWbvMxfLNL1dS2jiFzdI+Wh/Lv
         /q8koDtmrupWqaTlHAPXszlXoGI6bweOrqcWSzoamHg+3ADlQtZJbx/pH6YCv4vlX9R0
         5qgA6LmXaPaqF4zLjoD7qJw1PBjsgXRSRVteXvWDgY/QJJR0ombfKQOaMZIey4Vf0xv9
         v5a8j3FJKvxHTRMFjZSqRDEk2VZanBfbGTgGsGA/BTjLeKN+6PFbgM2odiBSk+t3XNQW
         tcVg==
X-Gm-Message-State: AJIora+1zrg4X6Cd0AZ8ivQLY142pji4U4Hugq4j9g40863+oIXBkjHO
        dv9T8iFJ8kRbO2Yzs4Lo1if+0HrCEhS9ZQ==
X-Google-Smtp-Source: AGRyM1vEiGsnFBs/mXqUxyEuEUbpknZkq4W+GrFxmFx1XzaGmYxNPbHTSRh456P4qLCxi3ZkhhmHMQ==
X-Received: by 2002:a05:6000:188c:b0:218:5b98:445 with SMTP id a12-20020a056000188c00b002185b980445mr6467267wri.465.1655242072222;
        Tue, 14 Jun 2022 14:27:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k190-20020a1ca1c7000000b0039c587342d8sm179352wme.3.2022.06.14.14.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:27:51 -0700 (PDT)
Message-Id: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jun 2022 21:27:46 +0000
Subject: [PATCH 0/4] Reactions to v2.37.0-rc0 test coverage report
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches add test coverage or simplify code based on discoveries in the
test coverage report (specifically, some that I highlighted at [1]).

[1]
https://lore.kernel.org/git/3d1c6dfd-1df6-3393-df5e-692719375772@github.com/

 1. Add tests for 'git update-index --verbose'.
 2. Add 'git gc --cruft' without '--prune=now' to test.
 3. Drop an always-NULL parameter from an internal method.
 4. Revert 080ab56a4 (cache-tree: implement cache_tree_find_path(),
    2022-05-23).

Any subset of these could be taken (or dropped), but I thought they would be
worth considering.

Thanks, -Stolee

Derrick Stolee (4):
  t2107: test 'git update-index --verbose'
  t5329: test 'git gc --cruft' without '--prune=now'
  pack-write: drop always-NULL parameter
  cache-tree: remove cache_tree_find_path()

 cache-tree.c                             | 27 ---------------------
 cache-tree.h                             |  2 --
 pack-write.c                             | 17 +++++--------
 t/t2106-update-index-assume-unchanged.sh |  2 +-
 t/t2107-update-index-basic.sh            | 31 +++++++++++++++++++-----
 t/t5329-pack-objects-cruft.sh            |  4 ++-
 6 files changed, 35 insertions(+), 48 deletions(-)


base-commit: 8168d5e9c23ed44ae3d604f392320d66556453c9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1261%2Fderrickstolee%2Ftest-coverage-response-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1261/derrickstolee/test-coverage-response-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1261
-- 
gitgitgadget
