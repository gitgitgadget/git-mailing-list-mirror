Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5335C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 00:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbiBVASc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 19:18:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237600AbiBVASb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 19:18:31 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB28824BF9
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:03 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i19so10396236wmq.5
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=trPQeE1aH3TZ7PkE3lmTl4Tsm7nVepjbIC3+eCH+6os=;
        b=KRybEb2zG5Y6ayMEx/2JR9dMXK+X9cJxi/jlu9V0JSpxryRoVQCnPZ5VDR/QPgQGlJ
         Gk5KD4NlstTEPthFjfD41fPhLNyMovKEgDU8ChghYW1vivnpBc/KW7rajwrJCDWWGiVb
         j4XygBFmBH3atG9Sdg8+HcoouDY6pg1ogGoPTEcVnDDU29UqB3hWCXAWyIDCskpIhT+h
         pHo7fib4EFb+NnuZguvbC40d2ZNjCn3z1MtanV53cg4/q24q09RiRIZwQgE7kNmEMWqe
         JRNtRP/g8ZOQnHK5hzMnil89FG2gAkWQKLQIEcp1wLKo6vC8V7xBxVS3HHKcBtWjK2yD
         //4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=trPQeE1aH3TZ7PkE3lmTl4Tsm7nVepjbIC3+eCH+6os=;
        b=8MOU7olAJGbgQuPaOnJVAMfRx/5TQOI6XnQ/MVm9QQ9Z/776IUQ7VkzN/Wd2crtVTO
         5/03Apgx8ucYS+AzS15rBchrfI7TqXJBxTyRlOfuQcjj7K74tPuXgD/pIHCzcxyVoXSP
         I8sOI80+SwR8HL7loTffkSEw+lcVIQOQpyZdANTrapQQjSq8fERHdkRyjykiZXHv/Jg2
         p0eani4Km/EFGsPSxemlNP2YK5wEG0mSCM4ZxajFU1yolIpIY5wVO29oXgLCV8563kgf
         dDdFHon0Z/5ZuwEaZttKWJcQT+Nhi2+mw5jaQfhRs5qYQYhEeULwR3GbkiEXUcGrZXxY
         zWOg==
X-Gm-Message-State: AOAM5325MkvV2JFyplCV27i3ZzdaWFfPoaTYZfOIGMlSWtYNx8gtMZ/1
        414GRobnXPTLOW+lRs1Mpk/Iu3M3/gc=
X-Google-Smtp-Source: ABdhPJw4kd/Pesl9dR576BonqjBCZKwYlRPH1dYJeCiDhFQ+uBUVn17/ymtqfGnT5ssylIxarfVKGg==
X-Received: by 2002:a1c:e916:0:b0:37c:f44f:573 with SMTP id q22-20020a1ce916000000b0037cf44f0573mr1132416wmc.179.1645489082109;
        Mon, 21 Feb 2022 16:18:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10sm919961wmq.20.2022.02.21.16.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 16:18:01 -0800 (PST)
Message-Id: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 00:17:49 +0000
Subject: [PATCH v2 00/11] Updates to worktree code and docs
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1154%2Fderrickstolee%2Fworktree-forward-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1154/derrickstolee/worktree-forward-fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1154

Range-diff vs v1:

  1:  a113ed9a844 =  1:  a113ed9a844 worktree: combine two translatable messages
  2:  f8aa87112a8 =  2:  f8aa87112a8 worktree: extract copy_filtered_worktree_config()
  3:  ccc5b1ef9fb =  3:  ccc5b1ef9fb worktree: extract copy_sparse_checkout()
  4:  1e62e4e4fa1 =  4:  1e62e4e4fa1 worktree: extract checkout_worktree()
  5:  a6a8eb8e7bb !  5:  2801ae232ae worktree: use 'worktree' over 'working tree'
     @@ Commit message
          This is the first of multiple changes to git-worktree.txt, restricted to
          the DESCRIPTION section.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/git-worktree.txt ##
     @@ Documentation/git-worktree.txt: Manage multiple working trees attached to the sa
      -'throwaway' working tree not associated with any branch. For instance,
      -`git worktree add -d <path>` creates a new working tree with a detached
      -`HEAD` at the same commit as the current branch.
     --
     --If a working tree is deleted without using `git worktree remove`, then
      +path `../hotfix`. To instead work on an existing branch in a new worktree,
      +use `git worktree add <path> <branch>`. On the other hand, if you just
      +plan to make some experimental changes or do testing without disturbing
     @@ Documentation/git-worktree.txt: Manage multiple working trees attached to the sa
      +worktree not associated with any branch. For instance,
      +`git worktree add -d <path>` creates a new worktree with a detached `HEAD`
      +at the same commit as the current branch.
     -+
     -+If a worktree is deleted without using `git worktree remove`, then
     + 
     + If a working tree is deleted without using `git worktree remove`, then
       its associated administrative files, which reside in the repository
       (see "DETAILS" below), will eventually be removed automatically (see
       `gc.worktreePruneExpire` in linkgit:git-config[1]), or you can run
     @@ Documentation/git-worktree.txt: Manage multiple working trees attached to the sa
      -which is not always mounted, you can prevent its administrative files from
      -being pruned by issuing the `git worktree lock` command, optionally
      -specifying `--reason` to explain why the working tree is locked.
     -+If a linked worktree is stored on a portable device or network share which
     -+is not always mounted, you can prevent its administrative files from being
     -+pruned by issuing the `git worktree lock` command, optionally specifying
     -+`--reason` to explain why the worktree is locked.
     ++If the working tree for a a linked worktree is stored on a portable device
     ++or network share which is not always mounted, you can prevent its
     ++administrative files from being pruned by issuing the `git worktree lock`
     ++command, optionally specifying `--reason` to explain why the worktree is
     ++locked.
       
       COMMANDS
       --------
     @@ Documentation/git-worktree.txt: Manage multiple working trees attached to the sa
      -is linked to the current repository, sharing everything except working
      -directory specific files such as `HEAD`, `index`, etc. As a convenience,
      -`<commit-ish>` may be a bare "`-`", which is synonymous with `@{-1}`.
     -+Create `<path>` and checkout `<commit-ish>` into it. The new worktree
     ++Create a worktree at `<path>` and checkout `<commit-ish>` into it. The new worktree
      +is linked to the current repository, sharing everything except per-worktree
      +files such as `HEAD`, `index`, etc. As a convenience, `<commit-ish>` may
      +be a bare "`-`", which is synonymous with `@{-1}`.
  6:  1fc4a98dc7a !  6:  a375e4b6ff0 worktree: use 'worktree' over 'working tree'
     @@ Commit message
          This is the second of multiple changes to git-worktree.txt, restricted
          to the COMMANDS section.
      
     +    There is some language around the movement of "the working tree of a
     +    linked worktree" which is used once, but the remaining uses are left as
     +    just moving "a linked worktree" for brevity.
     +
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/git-worktree.txt ##
     @@ Documentation/git-worktree.txt: branches from there if `<branch>` is ambiguous b
      -reestablish the connection. If multiple linked working trees are moved,
      -running `repair` from any working tree with each tree's new `<path>` as
      -an argument, will reestablish the connection to all the specified paths.
     -+Similarly, if a linked worktree is moved without using `git worktree
     -+move`, the main worktree (or bare repository) will be unable to locate it.
     -+Running `repair` within the recently-moved worktree will reestablish the
     -+connection. If multiple linked worktrees are moved, running `repair` from
     -+any worktree with each tree's new `<path>` as an argument, will
     -+reestablish the connection to all the specified paths.
     ++Similarly, if the working directory for a linked worktree is moved without
     ++using `git worktree move`, the main worktree (or bare repository) will be
     ++unable to locate it. Running `repair` within the recently-moved worktree
     ++will reestablish the connection. If multiple linked worktrees are moved,
     ++running `repair` from any worktree with each tree's new `<path>` as an
     ++argument, will reestablish the connection to all the specified paths.
       +
      -If both the main working tree and linked working trees have been moved
      -manually, then running `repair` in the main working tree and specifying the
  7:  00d261d0a2a =  7:  d1c4b687cbc worktree: use 'worktree' over 'working tree'
  8:  e7e579d2995 !  8:  65a0cd52711 worktree: use 'worktree' over 'working tree'
     @@ Commit message
          now replaced with "per-worktree" refs, which matches the definition in
          glossary-content.txt.
      
     +    The first paragraph of this section was also a bit confusing, so it is
     +    cleaned up to make it easier to understand.
     +
     +    Helped-by: Taylor Blau <m3@ttaylorr.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/git-worktree.txt ##
     @@ Documentation/git-worktree.txt: have two worktrees, at `/abc/def/ghi` and `/abc/
      -working tree via two special paths, `main-worktree` and `worktrees`. The
      -former gives access to per-working tree refs of the main working tree,
      -while the latter to all linked working trees.
     -+In multiple worktrees, some refs may be shared between all worktrees and
     -+some refs are local. One example is `HEAD` which is different for each
     -+worktree. This section is about the sharing rules and how to access
     -+refs of one worktree from another.
     ++When using multiple worktrees, some refs are shared between all worktrees,
     ++but others are specific to an individual worktree. One example is `HEAD`,
     ++which is different for each worktree. This section is about the sharing
     ++rules and how to access refs of one worktree from another.
      +
      +In general, all pseudo refs are per-worktree and all refs starting with
      +`refs/` are shared. Pseudo refs are ones like `HEAD` which are directly
  9:  23e74c87116 !  9:  e8890134fb4 worktree: use 'worktree' over 'working tree'
     @@ Commit message
          This is the fifth of multiple changes to git-worktree.txt, restricted to
          the CONFIGURATION FILE section.
      
     +    While here, clear up some language to improve readability.
     +
     +    Helped-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/git-worktree.txt ##
     @@ Documentation/git-worktree.txt: which will handle refs correctly.
      +will be applied to the main worktree only.
       
      -In order to have configuration specific to working trees, you can turn
     -+In order to have configuration specific to worktrees, you can turn
     - on the `worktreeConfig` extension, e.g.:
     +-on the `worktreeConfig` extension, e.g.:
     ++In order to have worktree-specific configuration, you can turn on the
     ++`worktreeConfig` extension, e.g.:
       
       ------------
     + $ git config extensions.worktreeConfig true
      @@ Documentation/git-worktree.txt: versions will refuse to access repositories with this extension.
       
       Note that in this file, the exception for `core.bare` and `core.worktree`
     @@ Documentation/git-worktree.txt: versions will refuse to access repositories with
       
      - - `core.sparseCheckout` is recommended per working tree, unless you
      -   are sure you always use sparse checkout for all working trees.
     -+ - `core.sparseCheckout` is recommended per worktree, unless you are sure
     -+   you always use sparse checkout for all worktrees.
     ++ - `core.sparseCheckout` should not be shared, unless you are sure you
     ++   always use sparse checkout for all worktrees.
       
       See the documentation of `extensions.worktreeConfig` in
       linkgit:git-config[1] for more details.
 10:  4729a96af6e = 10:  75f0e4ff5c2 worktree: use 'worktree' over 'working tree'
 11:  91773337675 ! 11:  1e07383552a worktree: use 'worktree' over 'working tree'
     @@ Commit message
          This is the last of multiple changes to git-worktree.txt, starting at
          the LIST OUTPUT FORMAT section.
      
     +    The EXAMPLES section has an instance of "working tree" that must stay as
     +    it is, because it is not talking about a worktree, but an example of why
     +    a user might want to create a worktree.
     +
     +    Helped-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/git-worktree.txt ##
     @@ Documentation/git-worktree.txt: label and value separated by a single space.  Bo
       end of the record.  For example:
       
       ------------
     -@@ Documentation/git-worktree.txt: EXAMPLES
     - You are in the middle of a refactoring session and your boss comes in and
     - demands that you fix something immediately. You might typically use
     +@@ Documentation/git-worktree.txt: demands that you fix something immediately. You might typically use
       linkgit:git-stash[1] to store your changes away temporarily, however, your
     --working tree is in such a state of disarray (with new, moved, and removed
     -+worktree is in such a state of disarray (with new, moved, and removed
     + working tree is in such a state of disarray (with new, moved, and removed
       files, and other bits and pieces strewn around) that you don't want to risk
      -disturbing any of it. Instead, you create a temporary linked working tree to
      +disturbing any of it. Instead, you create a temporary linked worktree to

-- 
gitgitgadget
