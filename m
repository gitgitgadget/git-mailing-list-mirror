Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2F5C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbiBWO3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241345AbiBWO3u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:29:50 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D448B250B
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:22 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s13so11410353wrb.6
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=43WFuOwFMqkv5O3nGQXs+Cupeolbpy6yS/2ALPMecks=;
        b=CShlSm/BqNIvLEPhA2w4yT8vBpUqEO9Lj7FpMNek2UFGqywqMNlyAQtNWAhFLF/GoP
         qCkvB75XmxXTK4Q4LVDd9g1/iBFu2J/OaU2nKdUosSJRdHUsB+0COo7IpAcUANDbk/QY
         ZUAkHw5AmgKZv84EsBo5ocvX4+39oqkGT2g3nPL54AVw2XGMrFAVuVXnuN0PkaQzpOwg
         Dlf4E7ezpFwzDjjxqIoiSvZsUIUKwCWDN0KKs5jEVW3ql7BzLnraOM4GjxPvpPLsVtLn
         H8ELISY9tG2HyAU8VXmvouIjFjVWHSGgMi6krobf23JuF/8Nh/lpSxLgpWnzlOlEsTjs
         bDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=43WFuOwFMqkv5O3nGQXs+Cupeolbpy6yS/2ALPMecks=;
        b=T7BG418z4GR2xw8F/v99dHkZJ4EmBVbMFSiOl3bUYop7DahQfejy5h3dbEAmHKmqVO
         CR2cjeSwHws2/oTtIydAfG10AYagUsO52XArZwKuftUyPIFzL9Qm1frxi5KL5KKC9L4m
         C1GwD+92cHtprRi52/KHSUJ2sSp3RY3w+mLkMTWAjpq/B1InKEyamKhyw4SHHPtJB+t4
         /uXa/5EShw1CQ/NEawqU8MY4OrD0GqHAw3hrHuiHcY9TSY2PlD+cVcrccsK+eZrBZcmZ
         TsNSdSu+669qOhl85QrYXUQR067u/1pEQvD6Mb5HQPj/kvgAe0haMheKVZjdQPBlEMqe
         XmMA==
X-Gm-Message-State: AOAM533Ho4W9NL7bTG1Xv/cG257viFBkJ5XzEJ0OfopCrS7B9JkYH9gg
        zlcGH8aFSk5lrhemg8171UKmfGX17zg=
X-Google-Smtp-Source: ABdhPJz98UVnxwUQ9f01GDU16Ol9YmmHwkNznKpwuFlGT9QUx6FMjUNPOcojVlQQ6W3F6p+DDC12qg==
X-Received: by 2002:a5d:5988:0:b0:1e8:b518:ad7f with SMTP id n8-20020a5d5988000000b001e8b518ad7fmr22940781wri.193.1645626560689;
        Wed, 23 Feb 2022 06:29:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e20sm1552437wre.90.2022.02.23.06.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:29:20 -0800 (PST)
Message-Id: <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
References: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 14:29:08 +0000
Subject: [PATCH v3 00/11] Updates to worktree code and docs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is built on top of ds/sparse-checkout-requires-per-worktree-config and
includes some forward fixes for comments from that series.

 * Patch 1 combines two translatable messages into one. (Thanks, Jean-Noël)
 * Patches 2-4 extract methods from the already-busy add_worktree() method.
   (Thanks, Eric)
 * Patches 5-11 update git-worktree.txt to use 'worktree' over 'working
   tree'. This involves some rewrapping of the paragraphs, so the diffs are
   not obviously just a find and replace. I split the changes mostly by
   section of the file to keep the diffs from being too large.


Updates in v3
=============

Several typos were fixed:

 * Patch 5: fixed "metata" and "a a" typos.
 * Patch 6: fixed "working directory" typo.
 * Patch 8: fixed typo in Taylor's email.


Updates in v2
=============

Based on Junio and Taylor's review, I updated some language in the docs:

 * Some uses of "worktree" should have stayed as "working tree"
 * Some adjacent wording was improved.

Thanks, -Stolee

Derrick Stolee (11):
  worktree: combine two translatable messages
  worktree: extract copy_filtered_worktree_config()
  worktree: extract copy_sparse_checkout()
  worktree: extract checkout_worktree()
  worktree: use 'worktree' over 'working tree'
  worktree: use 'worktree' over 'working tree'
  worktree: use 'worktree' over 'working tree'
  worktree: use 'worktree' over 'working tree'
  worktree: use 'worktree' over 'working tree'
  worktree: use 'worktree' over 'working tree'
  worktree: use 'worktree' over 'working tree'

 Documentation/git-worktree.txt | 268 ++++++++++++++++-----------------
 builtin/worktree.c             | 138 +++++++++--------
 2 files changed, 209 insertions(+), 197 deletions(-)


base-commit: 3ce113827287079dced9aaf9c5d1e1734ecaa265
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1154%2Fderrickstolee%2Fworktree-forward-fixes-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1154/derrickstolee/worktree-forward-fixes-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1154

Range-diff vs v2:

  1:  a113ed9a844 =  1:  a113ed9a844 worktree: combine two translatable messages
  2:  f8aa87112a8 =  2:  f8aa87112a8 worktree: extract copy_filtered_worktree_config()
  3:  ccc5b1ef9fb =  3:  ccc5b1ef9fb worktree: extract copy_sparse_checkout()
  4:  1e62e4e4fa1 =  4:  1e62e4e4fa1 worktree: extract checkout_worktree()
  5:  2801ae232ae !  5:  4e66cf33648 worktree: use 'worktree' over 'working tree'
     @@ Documentation/git-worktree.txt: Manage multiple working trees attached to the sa
      -with a linked working tree, remove it with `git worktree remove`.
      +tree is associated with the repository, along with additional metadata
      +that differentiates that working tree from others in the same repository.
     -+The working tree, along with this metada, is called a "worktree".
     ++The working tree, along with this metadata, is called a "worktree".
      +
      +This new worktree is called a "linked worktree" as opposed to the "main
      +worktree" prepared by linkgit:git-init[1] or linkgit:git-clone[1].
     @@ Documentation/git-worktree.txt: Manage multiple working trees attached to the sa
      -which is not always mounted, you can prevent its administrative files from
      -being pruned by issuing the `git worktree lock` command, optionally
      -specifying `--reason` to explain why the working tree is locked.
     -+If the working tree for a a linked worktree is stored on a portable device
     ++If the working tree for a linked worktree is stored on a portable device
      +or network share which is not always mounted, you can prevent its
      +administrative files from being pruned by issuing the `git worktree lock`
      +command, optionally specifying `--reason` to explain why the worktree is
  6:  a375e4b6ff0 !  6:  704cce17815 worktree: use 'worktree' over 'working tree'
     @@ Documentation/git-worktree.txt: branches from there if `<branch>` is ambiguous b
      -reestablish the connection. If multiple linked working trees are moved,
      -running `repair` from any working tree with each tree's new `<path>` as
      -an argument, will reestablish the connection to all the specified paths.
     -+Similarly, if the working directory for a linked worktree is moved without
     ++Similarly, if the working tree for a linked worktree is moved without
      +using `git worktree move`, the main worktree (or bare repository) will be
      +unable to locate it. Running `repair` within the recently-moved worktree
      +will reestablish the connection. If multiple linked worktrees are moved,
  7:  d1c4b687cbc =  7:  bee53e679ff worktree: use 'worktree' over 'working tree'
  8:  65a0cd52711 !  8:  0eb374620a7 worktree: use 'worktree' over 'working tree'
     @@ Commit message
          The first paragraph of this section was also a bit confusing, so it is
          cleaned up to make it easier to understand.
      
     -    Helped-by: Taylor Blau <m3@ttaylorr.com>
     +    Helped-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/git-worktree.txt ##
  9:  e8890134fb4 =  9:  c9afb58d967 worktree: use 'worktree' over 'working tree'
 10:  75f0e4ff5c2 = 10:  1e235677ef0 worktree: use 'worktree' over 'working tree'
 11:  1e07383552a = 11:  11ee7e107b4 worktree: use 'worktree' over 'working tree'

-- 
gitgitgadget
