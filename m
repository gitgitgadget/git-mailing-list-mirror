Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB2BC433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 02:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443386AbiDVCf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443373AbiDVCfY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 22:35:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF2A4B420
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so4580293wms.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=u+72VbA78jqR1qMaQ/QV6dHjUZYYKPtc+8/hEgDKKWo=;
        b=C7lAzLt2iYmj4BbGsfBlEDNdPtxFp/rA47pBzlJJ/bIhBgTmQdeKLcZk4lrSK73LiO
         VyoXF+LsbJK+COU8EaA7vHWulkXcQSikxqJQtamlKJ8Xh6jCn39hE2YHVICwX6jOS5v4
         Fqz6YH7kxEnztuanMxlGZ/d3GyBYcny9H7tG8UlZpydbrp/lTzOBzeMR7qBbUAFUrhzh
         5DshbOYJZKdG/w1SQUQKVzUsr8x1QjhQgobzw9g1QfNWS98z97FS6cnGIgZF6INvrxJ2
         8YKFFGkFhMXAs9BgXjwVz/YF7avW88Xp3yuOUakLc5VYp+bhU0sbp5EnSxNoUX3im9xD
         nyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=u+72VbA78jqR1qMaQ/QV6dHjUZYYKPtc+8/hEgDKKWo=;
        b=bRCMor1V1NlJWsGncvDNuqfLeebd6PhNVt47U1GV80RcfmQL5CwLljGdayI3Z02yrm
         Z6wun//ehEsQgUzT3Agy/xigRJ21ZMqnO/aUc3MV6vTB3bqSfFbJtc8zRWaqElR3Tit/
         hYEEE45mrSauhu6TdQhVGwMIf4k2Ta5RUV4fHErSCPOCTkH1gXERMRmxcFBcCqnsyakE
         4S0P6kcZTQAvEJ3I0LjZLZCJeUXcsUdEVUVrMX585kuGPTVc2Yd09oZeL+Zcj4ow60uj
         efqCQFNbzL8tumMjXVHzr7cIngyJ6pedj1FsO47Xpk4+hm0oINZnW3hyZ8csEUHdDRHY
         7LZg==
X-Gm-Message-State: AOAM530EC6wIs+I6mOtfdvwvzqAPGdzR3u7Wt+8vImHdJop40S8v0Evf
        BCwc7MlCg1Dil3aQD971nXLSUKCBEig=
X-Google-Smtp-Source: ABdhPJzxlXqPZsj4wsDcuZS9xd7tE8ZV1Lfd5gFBW9eLO5NkCedmLQvgD0QmzwwteZ0ZoFGotuHIew==
X-Received: by 2002:a05:600c:3b1f:b0:392:af6e:cf7e with SMTP id m31-20020a05600c3b1f00b00392af6ecf7emr1869921wms.183.1650594748584;
        Thu, 21 Apr 2022 19:32:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18-20020a05600c34d200b0038ed14b7ac3sm510630wmq.40.2022.04.21.19.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 19:32:27 -0700 (PDT)
Message-Id: <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
References: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 02:32:17 +0000
Subject: [PATCH v3 0/9] sparse-checkout: make cone mode the default
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the long delay since v1. On the plus side, perhaps there will be a
longer feedback period for this series since it's now really early in the
2.37 series?

== Updates Log ==

Changes since v2:

 * Code style tweak suggested by Junio in one area, reverting back to v1.
 * Several documentation updates to address Junio's review. Patches 6 & 7
   had significant changes and would most benefit from a further review.

Changes since v1:

 * rebased on master, to remove dependence on en/present-despite-skipped
   (which has since merged to master). Earlier version of series wasn't
   picked up anyway, so rebasing should be safe.
 * Wording and code style tweaks suggested by Stolee in his review

== Overview ==

This patch changes the default mode for sparse-checkout from non-cone mode
to cone-mode, and marks non-cone mode as deprecated. There is no plan to
remove non-cone mode, we are merely recommending against its use.

The code change is pretty small, and most of this series is about
documentation updates -- to focus on directories rather than patterns, to
explain the new default, to explain why we are deprecating non-cone mode
(the final patch), and to make other related cleanups to simplify the
manual.

Patch 1: Update tests to not assume cone-mode is the default Patch 2: Make
cone-mode the default Patches 3-9: Various updates to
git-sparse-checkout.txt, divided up for ease of review

== Alternative ==

There is one primary alternative to this series: make sparse-checkout error
when neither --cone nor --no-cone are specified (so that there is no
default), and wait until a future date to make --cone the default. That'd be
reasonable, but I had three reason to avoid going this route (note that item
2 means there's little practical difference between cone-mode-as-default and
no-mode-is-default):

 1. git-sparse-checkout.txt has the following huge warning early in the
    manual:

""" THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE BEHAVIOR OF OTHER
COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN THE
FUTURE. """

 2. If users are unaware of the default change and attempt to provide
    patterns instead of directories, then they will get error messages added
    from en/sparse-checkout-fixes. They can learn at that time to get around
    the error messages by providing --no-cone.

 3. If users are unaware of the default change and provide directories, then
    that's where non-cone mode and cone mode overlap and things happen to
    work. (There is a slight difference in that cone mode will include files
    from parent directories of any specified directory, but that means the
    user gets a few more files in their sparse-checkout with cone mode than
    they would with non-cone mode.)

== CCs ==

Elijah Newren (9):
  tests: stop assuming --no-cone is the default mode for sparse-checkout
  sparse-checkout: make --cone the default
  git-sparse-checkout.txt: wording updates for the cone mode default
  git-sparse-checkout.txt: update docs for deprecation of 'init'
  git-sparse-checkout.txt: shuffle some sections and mark as internal
  git-sparse-checkout.txt: add a new EXAMPLES section
  git-sparse-checkout.txt: flesh out pattern set sections a bit
  git-sparse-checkout.txt: mark non-cone mode as deprecated
  Documentation: some sparsity wording clarifications

 Documentation/config/core.txt         |   6 +-
 Documentation/git-read-tree.txt       |  11 +-
 Documentation/git-sparse-checkout.txt | 317 +++++++++++++++++++-------
 builtin/sparse-checkout.c             |   2 +-
 t/t1091-sparse-checkout-builtin.sh    |  15 +-
 t/t3602-rm-sparse-checkout.sh         |   6 +-
 t/t3705-add-sparse-checkout.sh        |   4 +-
 t/t6428-merge-conflicts-sparse.sh     |   4 +-
 t/t7002-mv-sparse-checkout.sh         |   2 +-
 t/t7012-skip-worktree-writing.sh      |   2 +-
 10 files changed, 268 insertions(+), 101 deletions(-)


base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1148%2Fnewren%2Fsparse-checkout-default-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1148/newren/sparse-checkout-default-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1148

Range-diff vs v2:

  1:  05dba7069c5 =  1:  05dba7069c5 tests: stop assuming --no-cone is the default mode for sparse-checkout
  2:  a53179764bc !  2:  d86c9179435 sparse-checkout: make --cone the default
     @@ Commit message
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     + ## Documentation/config/core.txt ##
     +@@ Documentation/config/core.txt: core.sparseCheckout::
     + 
     + core.sparseCheckoutCone::
     + 	Enables the "cone mode" of the sparse checkout feature. When the
     +-	sparse-checkout file contains a limited set of patterns, then this
     +-	mode provides significant performance advantages. See
     ++	sparse-checkout file contains a limited set of patterns, this
     ++	mode provides significant performance advantages. The "non
     ++	cone mode" can be requested to allow specifying a more flexible
     ++	patterns by setting this variable to 'false'. See
     + 	linkgit:git-sparse-checkout[1] for more information.
     + 
     + core.abbrev::
     +
       ## Documentation/git-sparse-checkout.txt ##
      @@ Documentation/git-sparse-checkout.txt: present, or undo and go back to having all tracked files present in the
       working copy.
     @@ Documentation/git-sparse-checkout.txt: SET' below).  The input format matches th
      +siblings of ancestor directories.
       +
      -When `--no-cone` is passed or `core.sparseCheckoutCone` is not enabled,
     -+When `--no-cone` is passed or `core.sparseCheckoutCone` is false,
     ++When `--no-cone` is passed or `core.sparseCheckoutCone` is set to false,
       the input list is considered a list of patterns.  This mode is harder
       to use and less performant, and is thus not recommended.  See the
       "Sparse Checkout" section of linkgit:git-read-tree[1] and the "Pattern
     @@ Documentation/git-sparse-checkout.txt: patterns. The resulting sparse-checkout f
      -expecting patterns of these types. Git will warn if the patterns do not match.
      -If the patterns do match the expected format, then Git will use faster hash-
      -based algorithms to compute inclusion in the sparse-checkout.
     -+If `core.sparseCheckoutCone=true` (set by default or with an explicit
     -+`--cone`), then Git will parse the sparse-checkout file expecting
     -+patterns of these types. Git will warn if the patterns do not match.  If
     -+the patterns do match the expected format, then Git will use faster
     -+hash-based algorithms to compute inclusion in the sparse-checkout.
     ++Unless `core.sparseCheckoutCone` is explicitly set to `false`, Git will
     ++parse the sparse-checkout file expecting patterns of these types. Git will
     ++warn if the patterns do not match.  If the patterns do match the expected
     ++format, then Git will use faster hash-based algorithms to compute inclusion
     ++in the sparse-checkout.
       
       In the cone mode case, the `git sparse-checkout list` subcommand will list the
       directories that define the recursive patterns. For the example sparse-checkout
     @@ builtin/sparse-checkout.c: static int update_modes(int *cone_mode, int *sparse_i
       	/* Set cone/non-cone mode appropriately */
       	core_apply_sparse_checkout = 1;
      -	if (*cone_mode == 1) {
     -+	if (*cone_mode) { /* also handles "not specified" (value of -1) */
     ++	if (*cone_mode == 1 || *cone_mode == -1) {
       		mode = MODE_CONE_PATTERNS;
       		core_sparse_checkout_cone = 1;
       	} else {
  3:  8eab21996c7 !  3:  b1e2c95a278 git-sparse-checkout.txt: wording updates for the cone mode default
     @@ Documentation/git-sparse-checkout.txt: When the `--stdin` option is provided, th
      +and `--cone` needed to be specified or `core.sparseCheckoutCone` needed
      +to be enabled.
       +
     - When `--no-cone` is passed or `core.sparseCheckoutCone` is false,
     + When `--no-cone` is passed or `core.sparseCheckoutCone` is set to false,
       the input list is considered a list of patterns.  This mode is harder
      @@ Documentation/git-sparse-checkout.txt: the following patterns:
       This says "include everything in root, but nothing two levels below root."
  4:  eb3b318b39e !  4:  b0b57cd37e7 git-sparse-checkout.txt: update docs for deprecation of 'init'
     @@ Documentation/git-sparse-checkout.txt: SET' below for more details).  In the pas
       and `--cone` needed to be specified or `core.sparseCheckoutCone` needed
       to be enabled.
       +
     --When `--no-cone` is passed or `core.sparseCheckoutCone` is false,
     +-When `--no-cone` is passed or `core.sparseCheckoutCone` is set to false,
      -the input list is considered a list of patterns.  This mode is harder
      -to use and less performant, and is thus not recommended.  See the
      -"Sparse Checkout" section of linkgit:git-read-tree[1] and the "Pattern
  5:  7333198b778 !  5:  eda0f41395b git-sparse-checkout.txt: shuffle some sections and mark as internal
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-sparse-checkout.txt ##
     +@@ Documentation/git-sparse-checkout.txt: to be enabled.
     + When `--no-cone` is passed, the input list is considered a list of
     + patterns.  This mode is harder to use and less performant, and is thus
     + not recommended.  See the "Sparse Checkout" section of
     +-linkgit:git-read-tree[1] and the "Pattern Set" sections below for more
     +-details.
     ++linkgit:git-read-tree[1] and the "Internals...Pattern Set" sections
     ++below for more details.
     + +
     + Use the `--[no-]sparse-index` option to use a sparse index (the
     + default is to not use it).  A sparse index reduces the size of the
      @@ Documentation/git-sparse-checkout.txt: paths to pass to a subsequent 'set' or 'add' command.  However,
       the disable command, so the easy restore of calling a plain `init`
       decreased in utility.
  6:  a814ea9e8d2 =  6:  7908c8f83d8 git-sparse-checkout.txt: add a new EXAMPLES section
  7:  78028ecaa58 !  7:  546ae3d6732 git-sparse-checkout.txt: flesh out non-cone mode pattern discussion a bit
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    git-sparse-checkout.txt: flesh out non-cone mode pattern discussion a bit
     +    git-sparse-checkout.txt: flesh out pattern set sections a bit
     +
     +    The "Internals -- Cone Pattern Set" section starts off discussing
     +    patterns, despite the fact that cone mode is about avoiding the
     +    patterns.  This made sense back when non-cone mode was the default and
     +    we started by discussing the full pattern set, but now that we are
     +    changing the default, it makes more sense to discuss cone-mode first and
     +    avoid the full discussion of patterns.  Split this section into two, the
     +    first with details about how cone mode operates, and the second
     +    following the full pattern set section and discussing how the cone mode
     +    patterns used under the hood relate to the full pattern set.
     +
     +    While at it, flesh out the "Internals -- Full Pattern Set" section a bit
     +    to include more examples as well.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-sparse-checkout.txt ##
     -@@ Documentation/git-sparse-checkout.txt: manually to ensure Git can behave optimally.
     - INTERNALS -- FULL PATTERN SET
     +@@ Documentation/git-sparse-checkout.txt: on this file. The files matching the patterns in the file will
     + appear in the working directory, and the rest will not.
     + 
     + 
     +-INTERNALS -- CONE PATTERN SET
     ++INTERNALS -- CONE MODE HANDLING
     ++-------------------------------
     ++
     ++The "cone mode", which is the default, lets you specify only what
     ++directories to include.  For any directory specified, all paths below
     ++that directory will be included, and any paths immediately under
     ++leading directories (including the toplevel directory) will also be
     ++included.  Thus, if you specified the directory
     ++    Documentation/technical/
     ++then your sparse checkout would contain:
     ++
     ++  * all files in the toplevel-directory
     ++  * all files immediately under Documentation/
     ++  * all files at any depth under Documentation/technical/
     ++
     ++Also, in cone mode, even if no directories are specified, then the
     ++files in the toplevel directory will be included.
     ++
     ++When changing the sparse-checkout patterns in cone mode, Git will inspect each
     ++tracked directory that is not within the sparse-checkout cone to see if it
     ++contains any untracked files. If all of those files are ignored due to the
     ++`.gitignore` patterns, then the directory will be deleted. If any of the
     ++untracked files within that directory is not ignored, then no deletions will
     ++occur within that directory and a warning message will appear. If these files
     ++are important, then reset your sparse-checkout definition so they are included,
     ++use `git add` and `git commit` to store them, then remove any remaining files
     ++manually to ensure Git can behave optimally.
     ++
     ++See also the "Internals -- Cone Pattern Set" section to learn how the
     ++directories are transformed under the hood into a subset of the
     ++Full Pattern Set of sparse-checkout.
     ++
     ++
     ++INTERNALS -- FULL PATTERN SET
       -----------------------------
       
     --By default, the sparse-checkout file uses the same syntax as `.gitignore`
     --files.
     --
     --While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
     --files are included, you can also specify what files are _not_ included,
     --using negative patterns. For example, to remove the file `unwanted`:
     -+As noted above, the sparse-checkout file uses the same syntax as
     -+`.gitignore` files; see linkgit:gitignore[5] for details.  Here,
     -+though, the patterns are usually being used to select which files to
     -+include rather than which files to exclude.  (However, it can get a
     -+bit confusing since gitignore-style patterns have negations defined by
     -+patterns which begin with a '!', so you can also select files to _not_
     -+include.)
     + The full pattern set allows for arbitrary pattern matches and complicated
     +@@ Documentation/git-sparse-checkout.txt: updating the index, where N is the number of patterns and M is the number
     + of paths in the index. To combat this performance issue, a more restricted
     + pattern set is allowed when `core.sparseCheckoutCone` is enabled.
     + 
     +-The accepted patterns in the cone pattern set are:
     ++The sparse-checkout file uses the same syntax as `.gitignore` files;
     ++see linkgit:gitignore[5] for details.  Here, though, the patterns are
     ++usually being used to select which files to include rather than which
     ++files to exclude.  (However, it can get a bit confusing since
     ++gitignore-style patterns have negations defined by patterns which
     ++begin with a '!', so you can also select files to _not_ include.)
      +
      +For example, to select everything, and then to remove the file
      +`unwanted` (so that every file will appear in your working tree except
     @@ Documentation/git-sparse-checkout.txt: manually to ensure Git can behave optimal
      +These patterns are just placed into the
      +`$GIT_DIR/info/sparse-checkout` as-is, so the contents of that file
      +at this point would be
     ++
     ++----------------
     ++/*
     ++!unwanted
     ++----------------
     ++
     ++See also the "Sparse Checkout" section of linkgit:git-read-tree[1] to
     ++learn more about the gitignore-style patterns used in sparse
     ++checkouts.
     ++
     ++
     ++INTERNALS -- CONE PATTERN SET
     ++-----------------------------
     ++
     ++In cone mode, only directories are accepted, but they are translated into
     ++the same gitignore-style patterns used in the full pattern set.  We refer
     ++to the particular patterns used in those mode as being of one of two types:
     + 
     + 1. *Recursive:* All paths inside a directory are included.
     + 
     + 2. *Parent:* All files immediately inside a directory are included.
     + 
     +-In addition to the above two patterns, we also expect that all files in the
     +-root directory are included. If a recursive pattern is added, then all
     +-leading directories are added as parent patterns.
     +-
     +-By default, when running `git sparse-checkout set` with no directories
     +-specified, the root directory is added as a parent pattern. At this
     +-point, the sparse-checkout file contains the following patterns:
     ++Since cone mode always includes files at the toplevel, when running
     ++`git sparse-checkout set` with no directories specified, the toplevel
     ++directory is added as a parent pattern.  At this point, the
     ++sparse-checkout file contains the following patterns:
     + 
     + ----------------
     + /*
     + !/*/
     + ----------------
     + 
     +-This says "include everything in root, but nothing two levels below root."
     ++This says "include everything immediately under the toplevel
     ++directory, but nothing at any level below that."
     + 
     +-When in cone mode, the `git sparse-checkout set` subcommand takes a list of
     +-directories. In this mode, the command `git sparse-checkout set A/B/C` sets
     +-the directory `A/B/C` as a recursive pattern, the directories `A` and `A/B`
     +-are added as parent patterns. The resulting sparse-checkout file is now
     ++When in cone mode, the `git sparse-checkout set` subcommand takes a
     ++list of directories.  The command `git sparse-checkout set A/B/C` sets
     ++the directory `A/B/C` as a recursive pattern, the directories `A` and
     ++`A/B` are added as parent patterns. The resulting sparse-checkout file
     ++is now
       
       ----------------
       /*
     +@@ Documentation/git-sparse-checkout.txt: Unless `core.sparseCheckoutCone` is explicitly set to `false`, Git will
     + parse the sparse-checkout file expecting patterns of these types. Git will
     + warn if the patterns do not match.  If the patterns do match the expected
     + format, then Git will use faster hash-based algorithms to compute inclusion
     +-in the sparse-checkout.
     ++in the sparse-checkout.  If they do not match, git will behave as though
     ++`core.sparseCheckoutCone` was false, regardless of its setting.
     + 
     +-In the cone mode case, the `git sparse-checkout list` subcommand will list the
     +-directories that define the recursive patterns. For the example sparse-checkout
     +-file above, the output is as follows:
     ++In the cone mode case, despite the fact that full patterns are written
     ++to the $GIT_DIR/info/sparse-checkout file, the `git sparse-checkout
     ++list` subcommand will list the directories that define the recursive
     ++patterns. For the example sparse-checkout file above, the output is as
     ++follows:
     + 
     + --------------------------
     + $ git sparse-checkout list
     +@@ Documentation/git-sparse-checkout.txt: case-insensitive check. This corrects for case mismatched filenames in the
     + 'git sparse-checkout set' command to reflect the expected cone in the working
     + directory.
     + 
     +-When changing the sparse-checkout patterns in cone mode, Git will inspect each
     +-tracked directory that is not within the sparse-checkout cone to see if it
     +-contains any untracked files. If all of those files are ignored due to the
     +-`.gitignore` patterns, then the directory will be deleted. If any of the
     +-untracked files within that directory is not ignored, then no deletions will
     +-occur within that directory and a warning message will appear. If these files
     +-are important, then reset your sparse-checkout definition so they are included,
     +-use `git add` and `git commit` to store them, then remove any remaining files
     +-manually to ensure Git can behave optimally.
     +-
     +-
     +-INTERNALS -- FULL PATTERN SET
     +------------------------------
     +-
     +-By default, the sparse-checkout file uses the same syntax as `.gitignore`
     +-files.
     +-
     +-While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
     +-files are included, you can also specify what files are _not_ included,
     +-using negative patterns. For example, to remove the file `unwanted`:
     +-
     +-----------------
     +-/*
     +-!unwanted
     +-----------------
     +-
     + 
     + INTERNALS -- SUBMODULES
     + -----------------------
  8:  2d2b81986a5 !  8:  a1b68fd6126 git-sparse-checkout.txt: mark non-cone mode as deprecated
     @@ Documentation/git-sparse-checkout.txt: and `--cone` needed to be specified or `c
       When `--no-cone` is passed, the input list is considered a list of
      -patterns.  This mode is harder to use and less performant, and is thus
      -not recommended.  See the "Sparse Checkout" section of
     --linkgit:git-read-tree[1] and the "Pattern Set" sections below for more
     --details.
     -+patterns.  This mode is harder to use, and unless you can keep the
     -+number of patterns small, its design also scales poorly.  It used to be
     -+the default mode, but we do not recommend using it.  It does not work
     -+with the `--sparse-index` option, and will likely be incompatible with
     -+other new features as they are added.  See the "Non-cone Problems"
     -+section below and the "Sparse Checkout" section of
     -+linkgit:git-read-tree[1] for more details.
     +-linkgit:git-read-tree[1] and the "Internals...Pattern Set" sections
     +-below for more details.
     ++patterns.  This mode has a number of drawbacks, including not working
     ++with some options like `--sparse-index`.  As explained in the
     ++"Non-cone Problems" section below, we do not recommend using it.
       +
       Use the `--[no-]sparse-index` option to use a sparse index (the
       default is to not use it).  A sparse index reduces the size of the
     @@ Documentation/git-sparse-checkout.txt: directory, it updates the skip-worktree b
      +  * Passing globs on the command line is error-prone as users may
      +    forget to quote the glob, causing the shell to expand it into all
      +    matching files and pass them all individually along to
     -+    sparse-checkout set/add.  This both exacerbates the scaling
     -+    problem, and hardcodes the list of selected files to those which
     -+    were present at the time the initial set/add subcommand was run
     -+    (and thus ignoring other files matching the same glob which come
     -+    into the working tree after switching branches or pulling down
     -+    updates).
     ++    sparse-checkout set/add.  While this could also be a problem with
     ++    e.g. "git grep -- *.c", mistakes with grep/log/status appear in
     ++    the immediate output.  With sparse-checkout, the mistake gets
     ++    recorded at the time the sparse-checkout command is run and might
     ++    not be problematic until the user later switches branches or rebases
     ++    or merges, thus putting a delay between the user's error and when
     ++    they have a chance to catch/notice it.
      +
     -+  * It uses "ignore"/"exclude" syntax for selecting what to "include",
     -+    which periodically causes confusion.
     ++  * Related to the previous item, sparse-checkout has an 'add'
     ++    subcommand but no 'remove' subcommand.  Even if a 'remove'
     ++    subcommand were added, undoing an accidental unquoted glob runs
     ++    the risk of "removing too much", as it may remove entries that had
     ++    been included before the accidental add.
      +
     -+  * It introduces inconsistencies in the Git command line, since other
     -+    commands use pathspecs, but sparse-checkout (in non-cone mode) uses
     -+    gitignore patterns.
     ++  * Non-cone mode uses gitignore-style patterns to select what to
     ++    *include* (with the exception of negated patterns), while
     ++    .gitignore files use gitignore-style patterns to select what to
     ++    *exclude* (with the exception of negated patterns).  The
     ++    documentation on gitignore-style patterns usually does not talk in
     ++    terms of matching or non-matching, but on what the user wants to
     ++    "exclude".  This can cause confusion for users trying to learn how
     ++    to specify sparse-checkout patterns to get their desired behavior.
     ++
     ++  * Every other git subcommand that wants to provide "special path
     ++    pattern matching" of some sort uses pathspecs, but non-cone mode
     ++    for sparse-checkout uses gitignore patterns, which feels
     ++    inconsistent.
      +
      +  * It has edge cases where the "right" behavior is unclear.  Two examples:
      +
     @@ Documentation/git-sparse-checkout.txt: directory, it updates the skip-worktree b
      +    all these cases.
      +
      +  * The excessive flexibility made other extensions essentially
     -+    impractical.  `--sparse-index` may not have been feasible in
     -+    non-cone mode, but even if it was, it would have been far more work
     -+    to implement and may have been too slow in practice.  Some ideas for
     -+    adding coupling between partial clones and sparse checkouts are only
     -+    practical with a more restricted set of paths.
     ++    impractical.  `--sparse-index` is likely impossible in non-cone
     ++    mode; even if it is somehow feasible, it would have been far more
     ++    work to implement and may have been too slow in practice.  Some
     ++    ideas for adding coupling between partial clones and sparse
     ++    checkouts are only practical with a more restricted set of paths
     ++    as well.
      +
      +For all these reasons, non-cone mode is deprecated.  Please switch to
      +using cone mode.
     ++
       
     - INTERNALS -- CONE PATTERN SET
     - -----------------------------
     + INTERNALS -- CONE MODE HANDLING
     + -------------------------------
  9:  4b89a3392b0 !  9:  5f0e80777de Documentation: some sparsity wording clarifications
     @@ Documentation/git-read-tree.txt: have finished your work-in-progress), attempt t
      +and `read-tree` predated the introduction of
      +linkgit:git-sparse-checkout[1].  Users are encouraged to use the
      +`sparse-checkout` command in preference to these plumbing commands for
     -+sparse-checkout/skip-worktree related needs.
     ++sparse-checkout/skip-worktree related needs.  However, the information
     ++below might be useful to users trying to understand the pattern style
     ++used in non-cone mode of the `sparse-checkout` command.
       
       "Sparse checkout" allows populating the working directory sparsely.
       It uses the skip-worktree bit (see linkgit:git-update-index[1]) to

-- 
gitgitgadget
