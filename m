Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1E4C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 20:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8801660FD9
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 20:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhJUUut (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhJUUuq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 16:50:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8A2C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 13:48:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j205so159892wmj.3
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 13:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eE4I6JxxBqToGrrmDCjZXrUo/qYcO+Yp16xpO5p9DGM=;
        b=X2INLtVqQe7tCu8OVjoBh+tvIaw+A/Pr2r9I0ckMkwbaM2k8QxDtROYVJqBR2LjlDL
         SKsMW/EeIhhr7f5exEH63wf9ByqW0sfgIzkwCILYSwgVPnONdfXQqN2Fi8Xu5J7AwSES
         MIfeKcG1W70oqVoUnjwA16SoSi7isG3OoZQjnSSUT05aHTTCgC8jii5e3TfTa9msMWRm
         Ad+AI4JCDde00r4moqXFIugKJZJ6nIpfmm9xk6Vzf8ZIRqkCbfzkC9vX2XFYDE5OIr00
         6RJR94b2OygfDfwbbTGuaHh+F+H3T0g+zep8jTGWkGb/vFk44m7tww+hUYgwZ2zOlEHD
         ohnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eE4I6JxxBqToGrrmDCjZXrUo/qYcO+Yp16xpO5p9DGM=;
        b=czK5ic6e5XRaywjxHEhVrYtNZgMIcmLu8Xp0vZfQk8NzCLbi28zqLBCINqqzu5qLr/
         J7c7dPKAzANR8VJZi45lSpId9SvdOh9KBBTqO4TnkzezBC2jDvU9Bw8POh45QeSJniBh
         U2Cc55KrUvz+A4DfqQJHYzWrMdQMjafyDfgPKyTBZsPTbmaXVxRhnchREmTJCMg6qrmg
         BAlSsQNJ8RkIMC/VeBO9RKrJq+AtQv/lSCijf10NVZEzP4zPoyRfcNQ8gd3DCuOc4gge
         zleEqHEPxDhZhviEFOUabmEGo6V/WcEd94FtEDKRovLYZV/BUf5Lnb+TP5VIupmWijpL
         kYdg==
X-Gm-Message-State: AOAM5333jhtfyEaUkk9C60ZCR+KdnuPYmMUwrHTMjr3nOk+63VCUZL6b
        M8PBO7hpAAdsg5JD1cX2SaQMH9FL3PI=
X-Google-Smtp-Source: ABdhPJxUSgl+kJeYKlAK83LiVGxpf7slR7TZRj+4mDlSzLGLENqks1oRNPPN637vvlV/EIyyPt98IQ==
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr23428154wmk.47.1634849308177;
        Thu, 21 Oct 2021 13:48:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6sm1761865wma.48.2021.10.21.13.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 13:48:27 -0700 (PDT)
Message-Id: <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 20:48:23 +0000
Subject: [PATCH v2 0/3] sparse-index: expand/collapse based on 'index.sparse'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series updates do_read_index to use the index.sparse config setting
when determining whether the index should be expanded or collapsed. If the
command & repo allow use of a sparse index, index.sparse is enabled, and a
full index is read from disk, the index is collapsed before returning to the
caller. Conversely, if index.sparse is disabled but the index read from disk
is sparse, the index is expanded before returning. This allows index.sparse
to control use of the sparse index in addition to its existing control over
how the index is written to disk. It also introduces the ability to
enable/disable the sparse index on a command-by-command basis (e.g.,
allowing a user to troubleshoot a sparse-aware command with '-c
index.sparse=false' [1]).

While testing this change, a bug was found in 'test-tool read-cache' in
which config settings for the repository were not initialized before
preparing the repo settings. This caused index.sparse to always be 'false'
when using the test helper in a cone-mode sparse checkout, breaking tests in
t1091 and t1092. The issue is fixed by moving prepare_repo_settings after
config setup.


Changes since V1
================

 * Add ensure_correct_sparsity function that ensures the index is sparse if
   the repository settings (including index.sparse) allow it, otherwise
   ensuring the index is expanded to full.
 * Restructure condition in do_read_index to, rather than check specifically
   for the index.sparse config setting, call ensure_correct_sparsity
   unconditionally when command_requires_full_index is false.

[1]
https://lore.kernel.org/git/cc60c6e7-ecef-ae22-8ec7-ab290ff2b830@gmail.com/

Thanks! -Victoria

Victoria Dye (3):
  test-read-cache.c: prepare_repo_settings after config init
  sparse-index: add ensure_correct_sparsity function
  sparse-index: update do_read_index to ensure correct sparsity

 read-cache.c                             |  8 +++++
 sparse-index.c                           | 42 ++++++++++++++++++++++--
 sparse-index.h                           |  2 ++
 t/helper/test-read-cache.c               |  5 +--
 t/t1092-sparse-checkout-compatibility.sh | 31 +++++++++++++++++
 5 files changed, 83 insertions(+), 5 deletions(-)


base-commit: f443b226ca681d87a3a31e245a70e6bc2769123c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1059%2Fvdye%2Fsparse%2Findex-sparse-config-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1059/vdye/sparse/index-sparse-config-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1059

Range-diff vs v1:

 1:  6974ce7e7f5 = 1:  6974ce7e7f5 test-read-cache.c: prepare_repo_settings after config init
 -:  ----------- > 2:  0b6e6633bb2 sparse-index: add ensure_correct_sparsity function
 2:  c6279b22545 ! 3:  437cf398256 sparse-index: update index read to consider index.sparse config
     @@ Metadata
      Author: Victoria Dye <vdye@github.com>
      
       ## Commit message ##
     -    sparse-index: update index read to consider index.sparse config
     +    sparse-index: update do_read_index to ensure correct sparsity
      
     -    Use the index.sparse config setting to expand or collapse the index when
     -    read. Previously, index.sparse would determine how the index would be
     -    written to disk, but would not enforce whether the index is read into memory
     -    as full or sparse. Now, the index is expanded when a sparse index is read
     -    with `index.sparse=false` and is collapsed to sparse when a full index is
     -    read with `index.sparse=true` (and the command does not require a full
     -    index).
     +    If `command_requires_full_index` is false, ensure correct in-core index
     +    sparsity on read by calling `ensure_correct_sparsity`. This change is meant
     +    to update the how the index is read in a command after sparse index-related
     +    repository settings are modified. Previously, for example, if `index.sparse`
     +    were changed from `true` to `false`, the in-core index on the next command
     +    would be sparse. The index would only be expanded to full when it was next
     +    written to disk.
      
     -    This makes the behavior of `index.sparse` more intuitive, as it now clearly
     -    enables/disables usage of a sparse index. It also provides users with a way
     -    to disable the sparse index per-command (e.g., for troubleshooting purposes)
     -    without needing to re-initialize the sparse-checkout.
     +    By adding a call to `ensure_correct_sparsity`, the in-core index now matches
     +    the sparsity dictated by the relevant repository settings as soon as it is
     +    read into memory, rather than when it is later written to disk.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## read-cache.c ##
      @@ read-cache.c: int do_read_index(struct index_state *istate, const char *path, int must_exist)
     + 
       	if (!istate->repo)
       		istate->repo = the_repository;
     ++
     ++	/*
     ++	 * If the command explicitly requires a full index, force it
     ++	 * to be full. Otherwise, correct the sparsity based on repository
     ++	 * settings and other properties of the index (if necessary).
     ++	 */
       	prepare_repo_settings(istate->repo);
     --	if (istate->repo->settings.command_requires_full_index)
     -+	if (!istate->repo->settings.sparse_index ||
     -+	    istate->repo->settings.command_requires_full_index)
     + 	if (istate->repo->settings.command_requires_full_index)
       		ensure_full_index(istate);
     -+	else if (!istate->sparse_index)
     -+		convert_to_sparse(istate, 0);
     ++	else
     ++		ensure_correct_sparsity(istate);
       
       	return istate->cache_nr;
       

-- 
gitgitgadget
