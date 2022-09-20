Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A64BC54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 06:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiITGVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 02:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiITGVE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 02:21:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952A215A27
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 23:21:02 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e16so2545381wrx.7
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 23:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=I8I/dt9AGcWVkc5nAtuGN6PHzjEvYBM4fFX+pIcv1jg=;
        b=KluiPHGa1bQLEhnajDE2LzbSvO98UlRpB5IvEqcQyF7DOfM095Ss4j4nNNDpl7xL2s
         WQaICKk8x54cQorsiKmUTZiNToTBitDGgmaID0ekfph1oqhDvXc/4YvpFFyy5quJKviQ
         ZItuRsDtgqthsXqM2rd1yfJhRqxH0doC4qywtm+0hqjOs5CXAwyLONOoBv7e6TRfgDWN
         w4tQ3peW7dlnB+Xf6rI/ijsq6baX2DkgjQGGwS1uhXm/bWohffF4cb7hMGAZ5Te9K0Oy
         uWP3v49YHI8nD49GQOoV4LbmN6sZnSlnKJg5lrJVVQQZK4cxdQBT/FRE6r5mdHbih836
         ZPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I8I/dt9AGcWVkc5nAtuGN6PHzjEvYBM4fFX+pIcv1jg=;
        b=RpZuv94JKYvpiKu4HKpiexwWe5IUL9LW0gZ/U13bnjMa1ST47+7hILtefFLBVPruSb
         FDX4VLpNpMrT8sgIlczgLdxjoUlIfKRB4KIHY1bYm4oiCJjw6FB3M4o+NKMw5WUdx7fZ
         eKotygfW7PfZT3WiTZe+QvACQmmdxS9QMSnymP7Fw4PG3YTaIvg1yB54rjgXshybe5MP
         YcWHIuEDzX+oFVpMjmyULEd0KO6vrZFkSS7qp1N+pNVB4GespNvApLwiI60l5NnHQsno
         1otMHTHt1nVH9asr4BxS+yTvMHtJI8foB9lkzwKKdkSkrALZO0SoUGHvwfPosy6QLrBA
         NiTQ==
X-Gm-Message-State: ACrzQf0gK39QrnNyZBBKeQ8VArr48gDpo4xqjPU5yAKPC2/phSzCUWoq
        IRhIHMmyQwis478Wiw4V7YqOlSVDAY0=
X-Google-Smtp-Source: AMsMyM4LDI0kslSxNYMjmaZVhZ1pwUTe+6PcCGVqXRV77T1bFaFVlh/9CaMJYZLNf8Qwd2ASFJnkNg==
X-Received: by 2002:a5d:64c3:0:b0:22a:e650:d3d7 with SMTP id f3-20020a5d64c3000000b0022ae650d3d7mr9858744wri.674.1663654860982;
        Mon, 19 Sep 2022 23:21:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5312000000b0022ae59d472esm561397wrv.112.2022.09.19.23.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 23:21:00 -0700 (PDT)
Message-Id: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.git.1663653505.gitgitgadget@gmail.com>
References: <pull.1359.git.1663653505.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 06:20:57 +0000
Subject: [PATCH v2 0/2] update internal patch-id to use "stable" algorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Internal usage of patch-id in rebase / cherry-pick doesn't persist
patch-ids, so there's no need to specifically invoke the unstable variant.

This allows the unstable logic to be cleaned up.

In the process, fixed a bug in the combination of --stable with binary files
and header-only, and expanded the test to cover both binary and non-binary
files.

Signed-off-by: Jerry Zhang jerry@skydio.com

Jerry Zhang (2):
  patch-id: fix stable patch id for binary / header-only
  patch-id: use stable patch-id for rebases

 builtin/log.c              |  2 +-
 diff.c                     | 44 ++++++++++++++++----------------------
 diff.h                     |  2 +-
 patch-ids.c                | 10 ++++-----
 patch-ids.h                |  2 +-
 t/t3419-rebase-patch-id.sh | 19 ++++++++++------
 6 files changed, 39 insertions(+), 40 deletions(-)


base-commit: e188ec3a735ae52a0d0d3c22f9df6b29fa613b1e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1359%2Fjerry-skydio%2Fjerry%2Frevup%2Fmaster%2Fpatch_ids-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1359/jerry-skydio/jerry/revup/master/patch_ids-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1359

Range-diff vs v1:

 1:  82fe77c1ce0 ! 1:  945508df7b6 patch-id: fix stable patch id for binary / header-only
     @@ diff.c: static int diff_get_patch_id(struct diff_options *options, struct object
      -
      -		if (diff_filespec_is_binary(options->repo, p->one) ||
      +		if (diff_header_only) {
     -+			// Don't do anything since we're only populating header info
     ++			/* don't do anything since we're only populating header info */
      +		} else if (diff_filespec_is_binary(options->repo, p->one) ||
       		    diff_filespec_is_binary(options->repo, p->two)) {
       			the_hash_algo->update_fn(&ctx, oid_to_hex(&p->one->oid),
 2:  6abb1ced1bd = 2:  30ec43cd129 patch-id: use stable patch-id for rebases

-- 
gitgitgadget
