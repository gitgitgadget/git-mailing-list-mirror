Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75F2C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 03:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKXDhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 22:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKXDhL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 22:37:11 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F31D229A
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 19:37:10 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bs21so642625wrb.4
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 19:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rw+VgAnElwxqjy7TD1B7NjQ1xsG2FhEfpPrYGjxzbuk=;
        b=c+8Jn2wrgGMel4teLqifHg0s46js+FEGPH5rcv7zAtzD2t8hJdT/kAZ6sFIawr+Jhj
         l1vYlWCtnGql2oDPMphv8T4glg1t0UqNYthbx3nwl0uj6gmL6iH5HL/ctEhUGpVDauDJ
         uJvHk7BBizKDB+M34vV2viLl34Wa6rWHIDJ4k9FsSIB7+dATcJkoXz1aJxYQCLiICT3U
         2tSSa6oRGbV2/G4Mgr4uucCubPAt3oidOycLirIRYMf1ieTXfrZhBrN8A7AZzIr/Inkj
         ZdDAg/YXfAhYprRvduA41SBtEvFbBPQ8gyQH1ABDniJEBMm0CAM8ojiH0fIJIH3od2FS
         h76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rw+VgAnElwxqjy7TD1B7NjQ1xsG2FhEfpPrYGjxzbuk=;
        b=mXXULTycrjt+0+Gq26xA23/Qwyd/KIFuYhVZF5CDUl0xwk2P1hBLSJA+GLJmCxuWYS
         m0yPsabXLjrgSDposVR2A0cuwopXttqvxB1aIXdEu2dp9IjwCqVHpUaWYfZd6Tf7Gtqt
         ZNKXc6mqbsI09ged4PPKS54YDC4YLcPBsd1QlbMKF6R6rt42rEG4lBZjKNw/0n26gSRB
         YP4eaePNjMVe1IhGChxQgFF95TfJ6asaveIWZ+NvfmTAr0rn/7ROg/IsN6xoPuxXuy8F
         Uyr6srMJPUqieLT5yRHvtDuJPlwexCgBqSWSuv8l+WiR7oxI7Vu9HpwTLNBIABCAqCDA
         S+PQ==
X-Gm-Message-State: ANoB5pmZX6nQrD7bpIY8AQ9JdxxiJPisqCzqvewH64XMAbqIrdiG9l4s
        xEIvXxJDSh+IJsJp4ZvEPdp5G3n8dIs=
X-Google-Smtp-Source: AA0mqf6TPEHiIRiwM9V4cFoToAJMUSait4dKjemiaA8NUCImtrXJnEdEIEOPmjcwXxvBoyOlo4ukGw==
X-Received: by 2002:a5d:4a47:0:b0:241:e6b7:3ba7 with SMTP id v7-20020a5d4a47000000b00241e6b73ba7mr5899438wrs.137.1669261028399;
        Wed, 23 Nov 2022 19:37:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bs30-20020a056000071e00b002364c77bcacsm91890wrb.38.2022.11.23.19.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 19:37:07 -0800 (PST)
Message-Id: <pull.1397.v8.git.1669261026.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
References: <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Nov 2022 03:37:03 +0000
Subject: [PATCH v8 0/3] merge-tree: allow specifying a base commit when --write-tree is passed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, kylezhao <kylezhao@tencent.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Kyle Zhao <kylezhao@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users may specify the merge-base multiple times, such as "git merge-tree
--merge-base=X --merge-base=Y A B", but found it doesn't work.

This patch I fix the description of option "--merge-base".

By the way, the amount of the effort support specifying multiple bases from
the codebase without these patches feels more or less the same ballpark as
these patches.

One point worth discussing is whether manually specifying multiple bases is
a rarely used feature and do we need to support it in the first version.

If needed, It might take a while for me to implement it, and the feature
might be delayed to the version after 2.39.

Thanks, Kyle

Changes since v1:

 * Changed merge_incore_recursive() to merge_incore_nonrecursive() when
   merge-base is specified.
 * Fixed c style problem.
 * Moved commit lookup/die logic out to the parsing logic in
   cmd_merge_tree().
 * use test_commit for test

Changes since v2:

 * commit message
 * Rebased on top of en/merge-tree-sequence.
 * Set opt.ancestor to o->merge_base. Because opt.ancestor is a *char. To
   make it easier to pass parameters, I moved
   lookup_commit_reference_by_name() to real_ merge() again.
 * Added test comment.

Changes since v3:

 * support --merge-base in conjunction with --stdin

Changes since v4:

 * commit message
 * added input format document
 * changed the input format for specifying the merge-base when --stdin is
   passed
 * changed the output when --stdin and --merge-base are used at the same
   time
 * add comment for test

Changes since v5:

 * improved test: remove the test repo after the test; avoid sub-shell.

Changes since v6:

 * fixed comment of test

Changes since v7:

 * docs: fix description of the --merge-base option

Kyle Zhao (3):
  merge-tree.c: add --merge-base=<commit> option
  merge-tree.c: allow specifying the merge-base when --stdin is passed
  docs: fix description of the `--merge-base` option

 Documentation/git-merge-tree.txt | 16 ++++++++
 builtin/merge-tree.c             | 65 ++++++++++++++++++++++++++------
 t/t4301-merge-tree-write-tree.sh | 62 ++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 12 deletions(-)


base-commit: ec1edbcb56ac05e9980299b05924c5c1b51d68b4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1397%2Fkeyu98%2Fkz%2Fmerge-tree-option-merge-base-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1397/keyu98/kz/merge-tree-option-merge-base-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/1397

Range-diff vs v7:

 1:  1cf1c69b8e8 = 1:  1cf1c69b8e8 merge-tree.c: add --merge-base=<commit> option
 2:  48e55d4e97c = 2:  48e55d4e97c merge-tree.c: allow specifying the merge-base when --stdin is passed
 -:  ----------- > 3:  c21466d1db0 docs: fix description of the `--merge-base` option

-- 
gitgitgadget
