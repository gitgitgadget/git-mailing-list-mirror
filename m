Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A860AC4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 23:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiKKXpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 18:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbiKKXpU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 18:45:20 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFC3CE17
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 15:45:17 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso6323544wmb.0
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 15:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhq68edwC4PxyxuwSOf1YgyCdfybt9ruozg/25ZONkU=;
        b=b13+oMCSRRAoNq0nmU1T7R2tq/Mv+MmR7Qz7gI7kKzSifCm6+bTUin6ydJxUfQ9Lue
         11Vot5nhsQUMGs+VYd9oFqJLtmMyzoa2m/oohqCTAZkIAp1JDLekfUttwO+qA1TlQmUp
         C1ftjC5hBHPhB0ir3bj5XzDA1vY7L3EdImp66uJka18ORokuPV0WeyeEeaGYcPvzHrIi
         bMZOTM2Jqf0hJhPmATYCxJa4GEMXXQ2jkhJ39iSYQV4CS2EWPgtK7nY+noNL52qsC07H
         FeB5vSdbTJO18iS7iBkvzZ6zCCuzFCJVht2O0t2P6T1gKX7oIFPa24m6vsH8nQsUSTvQ
         ifNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhq68edwC4PxyxuwSOf1YgyCdfybt9ruozg/25ZONkU=;
        b=O3U8jP56sbNMsFXG62wiVhoZ84QX8inu6Fs2M5DBsHPbHej1vfg/KKROU0CmF4oTk0
         kqgv+9uj13cA65Nhirw72CCA/RG5OG3cmHyb4IyoQvss7HVzzjD60akxjlZVsU4PGICV
         8Y3sqnNp7AIP/PRCoGveO8EuKVWImm7LwenihPr2DehL/LSUkRazalFaTflM3JycX4LF
         3DLcOs7en2YY2CKNTfwzqdW8dYReeDcXQlRUjHtZuvakl3u2ItlVN/uB2MjxdPcRvHNH
         RmQSgoBmpR8ah3nPx5wvtBcFctrcfE7piGwFQ6NU+0JJSPZLjnDH0o8a1WrCdGnD+dGf
         ++/w==
X-Gm-Message-State: ANoB5pm5D3+Vl0tNc9TCX4v3ZAlTNcVPUNKc0XdRsSH96Fc4nQ+FUg22
        230/GDY1cpyAlRA5ilROJ5t6RVcKlok=
X-Google-Smtp-Source: AA0mqf7HNxN9dGYub5OA1UOw+gzD5o+eAE+32+sghIknYvnAyMxKODNiu8xpflAnlttmeBkUPL0AZw==
X-Received: by 2002:a05:600c:1c06:b0:3c3:77c2:cfff with SMTP id j6-20020a05600c1c0600b003c377c2cfffmr2560890wms.171.1668210316054;
        Fri, 11 Nov 2022 15:45:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v193-20020a1cacca000000b003cf37c5ddc0sm4285999wme.22.2022.11.11.15.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:45:15 -0800 (PST)
Message-Id: <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.v6.git.1667472621.gitgitgadget@gmail.com>
References: <pull.1397.v6.git.1667472621.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Nov 2022 23:45:12 +0000
Subject: [PATCH v7 0/2] merge-tree: allow specifying a base commit when --write-tree is passed
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

Thanks for everyone's careful reviews.

In this patch, I introduce a new --merge-base=<commit> option to allow
callers to specify a merge-base for the merge and extend the input accepted
by --stdin to also allow a specified merge-base with each merge requested.

Regards, Kyle

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

Kyle Zhao (2):
  merge-tree.c: add --merge-base=<commit> option
  merge-tree.c: allow specifying the merge-base when --stdin is passed

 Documentation/git-merge-tree.txt | 16 ++++++++
 builtin/merge-tree.c             | 65 ++++++++++++++++++++++++++------
 t/t4301-merge-tree-write-tree.sh | 62 ++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 12 deletions(-)


base-commit: ec1edbcb56ac05e9980299b05924c5c1b51d68b4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1397%2Fkeyu98%2Fkz%2Fmerge-tree-option-merge-base-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1397/keyu98/kz/merge-tree-option-merge-base-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1397

Range-diff vs v6:

 1:  1cf1c69b8e8 = 1:  1cf1c69b8e8 merge-tree.c: add --merge-base=<commit> option
 2:  40d56544e6e ! 2:  48e55d4e97c merge-tree.c: allow specifying the merge-base when --stdin is passed
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'specify merge-base as par
       '
       
      +# Since the earlier tests have verified that individual merge-tree calls
     -+# are doing the right thing, this test case is only used to test whether
     -+# the input format is available.
     ++# are doing the right thing, this test case is only used to verify that
     ++# we can also trigger merges via --stdin, and that when we do we get
     ++# the same answer as running a bunch of separate merges.
      +
      +test_expect_success 'check the input format when --stdin is passed' '
      +	test_when_finished "rm -rf repo" &&

-- 
gitgitgadget
