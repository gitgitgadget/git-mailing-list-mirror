Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00655C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 00:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhL3Acf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 19:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhL3Ace (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 19:32:34 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA13C061574
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 16:32:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v7so47227034wrv.12
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 16:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=0Eem2p53QyE8YskL5BVGod/+zfCxi+PsMXsRdWNosi0=;
        b=Hgmz2HVNsfS8mZ1WI7Vl8ADyFw1P5AgW+CwhcXrOWo3WPSQJql6ev8hPfNun83udgN
         2PNhY6C1XBHHVnfvxZ+BoVCvrX7qvgKeQl4DhYKFL9m24VsdmX75qCm7a9GWnXTCU59/
         zlsabLRFu3Ib4p5sMfm5Fyxr/7mJXscRbSbnxEN2yXJp97Ih/oTOnHM3XlriGgarj7X7
         lGfKrOxTMfygrDEfr+1XNB3fdypnGXI89AKCe7WnVShwXyxRwhhnFturMQjXHhtsRuBB
         IR9N//HLB7eNboNd5AoAwnmBfs/EOH7lUNS1Wn1Vd4JZ3E4GZBZwjIlVrQB2gt70RrmX
         PFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0Eem2p53QyE8YskL5BVGod/+zfCxi+PsMXsRdWNosi0=;
        b=3Ad9T2w6/eQEuM/mQHf9YaRotajptvAH+6GuCG3aVYnOG8nXaHaijQavXV3v6AxamE
         fDI016tRoQy12nPmrro+7b3j2pbjiAbT3eP8mxKPJdHJFmcyWwcj8YUZwjM1bJKMHcHk
         mNTXw5UzrmDRPdn4+xLxpxVDD5D9OYijY4epjXsD5B5pTmooiLQPhFvx7eK/WunIxL1A
         qddD/wdxMnfuk6yi8rAI2jKbLCsMeZ+OfO1p7hg79Ldoob5HuydbgC3YYCpiRL5VxLgF
         pTjN+qzycdtQUofW0ssM+UWQYJNXUILjRTRdRgBTJ3/Lbvd5o2LZYlHZVC5+m9KNzPza
         VCPA==
X-Gm-Message-State: AOAM532LU1+D0NK4wNzIFONdx/csY7hpA4gvWPGmaDBgndZZtcKBaISj
        64XbNCdFFRej9DlKt8Q5dKm3n5N1JQM=
X-Google-Smtp-Source: ABdhPJywXSXhdVwlAnDsGMpP4bmEnuIJkm/C1iyr2c7Sp9ot4GcN5wlwxh8LM+8Gjr8of1VkgPwX9g==
X-Received: by 2002:a5d:6146:: with SMTP id y6mr22442277wrt.693.1640824353043;
        Wed, 29 Dec 2021 16:32:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h19sm21634008wmm.13.2021.12.29.16.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 16:32:32 -0800 (PST)
Message-Id: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 00:32:29 +0000
Subject: [PATCH 0/2] sparse checkout: custom bash completion updates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series updates custom tab completion for the sparse-checkout command.
Specifically, it corrects the following issues with the current method:

 1. git sparse-checkout <TAB> results in an incomplete list of subcommands
    (it is missing reapply and add).
 2. git sparse-checkout --<TAB> does not complete the help option.
 3. Options for subcommands are not tab-completable.
 4. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
    both file names and directory names.

The first commit in this series is a set of failing tests that highlight
each of the above issues. The next commit updates the _git_sparse_checkout
method in git-completion.bash to enable each of these tests to pass.

Thanks, Lessley

Lessley Dennington (2):
  sparse-checkout: custom tab completion tests
  sparse-checkout: custom tab completion

 contrib/completion/git-completion.bash | 34 +++++++-----
 t/t9902-completion.sh                  | 74 ++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 12 deletions(-)


base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1108%2Fldennington%2Fsparse-checkout-bash-completion-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1108/ldennington/sparse-checkout-bash-completion-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1108
-- 
gitgitgadget
