Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4DAC77B6D
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 22:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCZWpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 18:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjCZWpw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 18:45:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D14459E4
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:45:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l27so6850155wrb.2
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679870745;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy8rIU6zY+gVCqSPJW9tGTszLEWihFyx8/olYYeGIqg=;
        b=q7/wQoV1bsyuCmBHM/+HObuekLOrAKn1plXWFXHOV1BLWehvk2LlaAe4wnoVV1b/xJ
         DqG1UB/Wt5twr57F75nvt1W6ogWJVXze78hYsX8n8O7377zIylUSew/AEAgzFzUilESy
         ygS1KM6/AxAwk6L/m6fGOa9A2ruBuMn9kjSoPWAoGH0BDbZX2u4amS39O2Zfiyv8b8fX
         /jwGr/T0GvLkjTINYbECtNJNvOscMSp2E3HMAxv6XKaQS4zGXOGPWuA/kEDafLK/emRs
         pRtwxm6Lg+PKZcnJGT+iMTccDagOTsXkr+lVo2U67gts15g0ivBm8rS9NEelh9cxW/O5
         kgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679870745;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xy8rIU6zY+gVCqSPJW9tGTszLEWihFyx8/olYYeGIqg=;
        b=iPLI8JjsqD5/KSTdetx7VvSrI2Ee6IZL/mS54UO9vW1aNP5fMBzltU2BcATdlW9zej
         3iApYLZL6vIZu6a4WVD7cK+Pbog9RSPovmXXs8dVveAPvqG3heKGoWvTZlL5ixAXbD4Y
         ZuX9vT6rwQyH7A0WoR7T5xedlEogY3FocjeHbuvX0Y0qK9N0+5VdKSfzfvjNl1sfmrp6
         vHV/LW1HMAEUMGbKnE5HwVsbJRBipX45LlOXaob5I+fL/pOGCVjrTpDpXRRhRTC5qMxF
         0uJAatyGMkLj1DquAtZXeiaoRUl4SELintJjuKIqFzjyjQ2mbpKP3/Od44rsnyW7Y7Sh
         srmw==
X-Gm-Message-State: AAQBX9dbcscPdWud8Pfuuv72RxR05P16ShDQMU0FV4kVCzrT0ox7FWJQ
        8UIHDPbMJyGsP8iIN0px9SXmITCdg2o=
X-Google-Smtp-Source: AKy350atwk2W5NOF6d0EOJShnDDToe3PeUMJwJeiEjv1r3u4AKTalhD3y4NEIAl5NJFfe/8Y3BDfFA==
X-Received: by 2002:adf:dd10:0:b0:2d8:e6ba:99e8 with SMTP id a16-20020adfdd10000000b002d8e6ba99e8mr7768161wrm.33.1679870745095;
        Sun, 26 Mar 2023 15:45:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16-20020a1c4b10000000b003e91b9a92c9sm11703939wma.24.2023.03.26.15.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 15:45:44 -0700 (PDT)
Message-Id: <pull.1497.v2.git.1679870743.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
References: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Mar 2023 22:45:39 +0000
Subject: [PATCH v2 0/4] Fix a few split-index bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I received an internal bug report that after upgrading from v2.39.2 to
v2.40.0, some users ran into the following error message:

BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index (57 > 0)


It sounds very much like the report we received in
https://lore.kernel.org/git/CAC7ZvybvykKQyMWcZoKXxFDu_amnkxZCDq2C6KHoyhmHN2tcKw@mail.gmail.com/,
but sadly that thread petered out when the reporter stopped being able to
reproduce the problem.

After a few days of investigating, I am convinced that this is due to some
old bugs, and not actually a regression in v2.40.0 (although I can believe
that some improvements in v2.40.0 might make it easier to run into these
bugs).

This patch series addresses those bugs.

Note: While the Git maintainer has stated a strong preference to introduce
regression tests in the same patch that fixes the corresponding regression,
this patch series starts with a stand-alone patch that demonstrates a
problematic scenario via a new test_expect_failure test case. The reason why
I specifically split out the test into its own commit is that there is a lot
of information to unpack in the commit message that is larger than any of
the subsequent bug fixes. Besides, it motivates not only the second patch
(which marks the test case as test_expect_success) but paints the larger
picture necessary to understand also the need for the remaining two patches.

This patch series is based on maint-2.37, the oldest maintenance branch it
applies without merge conflicts. When merging with next, there are only
trivial conflicts in unpack-trees.c due to en/dir-api-cleanup where
o->result is now o->internal.result.

Changes since v1:

 * Fix a double "the" in a commit message
 * Replace enum strip_extensions by the bit field enum write_extensions,
   inverting the meaning of the values to avoid double negatives
 * Leave a trailing comma at the definition of the enum values

Johannes Schindelin (4):
  split-index & fsmonitor: demonstrate a bug
  split-index; stop abusing the `base_oid` to strip the "link" extension
  fsmonitor: avoid overriding `cache_changed` bits
  unpack-trees: take care to propagate the split-index flag

 fsmonitor.h                  |  2 +-
 read-cache.c                 | 49 +++++++++++++++++++++++-------------
 t/t7527-builtin-fsmonitor.sh | 37 +++++++++++++++++++++++++++
 unpack-trees.c               |  2 ++
 4 files changed, 72 insertions(+), 18 deletions(-)


base-commit: eb88fe1ff5ceb34845f0919b8bdc60d8a1703cf6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1497%2Fdscho%2Ffix-split-index-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1497/dscho/fix-split-index-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1497

Range-diff vs v1:

 1:  c025fccbdde = 1:  c025fccbdde split-index & fsmonitor: demonstrate a bug
 2:  f1897b88072 ! 2:  8cc075f6325 split-index; stop abusing the `base_oid` to strip the "link" extension
     @@ Commit message
      
          One might be tempted to simply call `discard_split_index()` instead,
          under the assumption that Git decided to write a non-split index and
     -    therefore the the `split_index` structure might no longer be wanted.
     +    therefore the `split_index` structure might no longer be wanted.
          However, that is not possible because that would release index entries
          in `split_index->base` that are likely to still be in use. Therefore we
          cannot do that.
      
     -    The next best thing we _can_ do is to introduce a flag, specifically
     -    indicating when the "link" extension should be skipped. So that's what
     -    we do here.
     +    The next best thing we _can_ do is to introduce a bit field to indicate
     +    specifically which index extensions (not) to write. So that's what we do
     +    here.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ read-cache.c: static int record_ieot(void)
       	return !git_config_get_index_threads(&val) && val != 1;
       }
       
     -+enum strip_extensions {
     -+	WRITE_ALL_EXTENSIONS = 0,
     -+	STRIP_ALL_EXTENSIONS = 1,
     -+	STRIP_LINK_EXTENSION_ONLY = 2
     ++enum write_extensions {
     ++	WRITE_NO_EXTENSION =              0,
     ++	WRITE_SPLIT_INDEX_EXTENSION =     1<<0,
     ++	WRITE_CACHE_TREE_EXTENSION =      1<<1,
     ++	WRITE_RESOLVE_UNDO_EXTENSION =    1<<2,
     ++	WRITE_UNTRACKED_CACHE_EXTENSION = 1<<3,
     ++	WRITE_FSMONITOR_EXTENSION =       1<<4,
      +};
     ++#define WRITE_ALL_EXTENSIONS ((enum write_extensions)-1)
      +
       /*
        * On success, `tempfile` is closed. If it is the temporary file
     @@ read-cache.c: static int record_ieot(void)
        */
       static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
      -			  int strip_extensions, unsigned flags)
     -+			  enum strip_extensions strip_extensions, unsigned flags)
     ++			  enum write_extensions write_extensions, unsigned flags)
       {
       	uint64_t start = getnanotime();
       	struct hashfile *f;
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
       	}
       
      -	if (!strip_extensions && istate->split_index &&
     -+	if (strip_extensions == WRITE_ALL_EXTENSIONS && istate->split_index &&
     - 	    !is_null_oid(&istate->split_index->base_oid)) {
     +-	    !is_null_oid(&istate->split_index->base_oid)) {
     ++	if (write_extensions & WRITE_SPLIT_INDEX_EXTENSION &&
     ++	    istate->split_index) {
       		struct strbuf sb = STRBUF_INIT;
       
     + 		if (istate->sparse_index)
      @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
       		if (err)
       			return -1;
       	}
      -	if (!strip_extensions && !drop_cache_tree && istate->cache_tree) {
     -+	if (strip_extensions != STRIP_ALL_EXTENSIONS && !drop_cache_tree && istate->cache_tree) {
     ++	if (write_extensions & WRITE_CACHE_TREE_EXTENSION &&
     ++	    !drop_cache_tree && istate->cache_tree) {
       		struct strbuf sb = STRBUF_INIT;
       
       		cache_tree_write(&sb, istate->cache_tree);
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
       			return -1;
       	}
      -	if (!strip_extensions && istate->resolve_undo) {
     -+	if (strip_extensions != STRIP_ALL_EXTENSIONS && istate->resolve_undo) {
     ++	if (write_extensions & WRITE_RESOLVE_UNDO_EXTENSION &&
     ++	    istate->resolve_undo) {
       		struct strbuf sb = STRBUF_INIT;
       
       		resolve_undo_write(&sb, istate->resolve_undo);
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
       			return -1;
       	}
      -	if (!strip_extensions && istate->untracked) {
     -+	if (strip_extensions != STRIP_ALL_EXTENSIONS && istate->untracked) {
     ++	if (write_extensions & WRITE_UNTRACKED_CACHE_EXTENSION &&
     ++	    istate->untracked) {
       		struct strbuf sb = STRBUF_INIT;
       
       		write_untracked_extension(&sb, istate->untracked);
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
       			return -1;
       	}
      -	if (!strip_extensions && istate->fsmonitor_last_update) {
     -+	if (strip_extensions != STRIP_ALL_EXTENSIONS && istate->fsmonitor_last_update) {
     ++	if (write_extensions & WRITE_FSMONITOR_EXTENSION &&
     ++	    istate->fsmonitor_last_update) {
       		struct strbuf sb = STRBUF_INIT;
       
       		write_fsmonitor_extension(&sb, istate);
     @@ read-cache.c: static int commit_locked_index(struct lock_file *lk)
       		return commit_lock_file(lk);
       }
       
     -+/*
     -+ * Write the Git index into a `.lock` file
     -+ *
     -+ * If `strip_link_extension` is non-zero, avoid writing any "link" extension
     -+ * (used by the split-index feature).
     -+ */
     - static int do_write_locked_index(struct index_state *istate, struct lock_file *lock,
     +-static int do_write_locked_index(struct index_state *istate, struct lock_file *lock,
      -				 unsigned flags)
     -+				 unsigned flags, int strip_link_extension)
     ++static int do_write_locked_index(struct index_state *istate,
     ++				 struct lock_file *lock,
     ++				 unsigned flags,
     ++				 enum write_extensions write_extensions)
       {
       	int ret;
       	int was_full = istate->sparse_index == INDEX_EXPANDED;
     @@ read-cache.c: static int do_write_locked_index(struct index_state *istate, struc
       	trace2_region_enter_printf("index", "do_write_index", the_repository,
       				   "%s", get_lock_file_path(lock));
      -	ret = do_write_index(istate, lock->tempfile, 0, flags);
     -+	ret = do_write_index(istate, lock->tempfile, strip_link_extension ? STRIP_LINK_EXTENSION_ONLY : 0, flags);
     ++	ret = do_write_index(istate, lock->tempfile, write_extensions, flags);
       	trace2_region_leave_printf("index", "do_write_index", the_repository,
       				   "%s", get_lock_file_path(lock));
       
     @@ read-cache.c: static int write_split_index(struct index_state *istate,
       	int ret;
       	prepare_to_write_split_index(istate);
      -	ret = do_write_locked_index(istate, lock, flags);
     -+	ret = do_write_locked_index(istate, lock, flags, 0);
     ++	ret = do_write_locked_index(istate, lock, flags, WRITE_ALL_EXTENSIONS);
       	finish_writing_split_index(istate);
       	return ret;
       }
     +@@ read-cache.c: static int write_shared_index(struct index_state *istate,
     + 
     + 	trace2_region_enter_printf("index", "shared/do_write_index",
     + 				   the_repository, "%s", get_tempfile_path(*temp));
     +-	ret = do_write_index(si->base, *temp, 1, flags);
     ++	ret = do_write_index(si->base, *temp, WRITE_NO_EXTENSION, flags);
     + 	trace2_region_leave_printf("index", "shared/do_write_index",
     + 				   the_repository, "%s", get_tempfile_path(*temp));
     + 
      @@ read-cache.c: int write_locked_index(struct index_state *istate, struct lock_file *lock,
       	if ((!si && !test_split_index_env) ||
       	    alternate_index_output ||
     @@ read-cache.c: int write_locked_index(struct index_state *istate, struct lock_fil
      -		if (si)
      -			oidclr(&si->base_oid);
      -		ret = do_write_locked_index(istate, lock, flags);
     -+		ret = do_write_locked_index(istate, lock, flags, 1);
     ++		ret = do_write_locked_index(istate, lock, flags,
     ++					    ~WRITE_SPLIT_INDEX_EXTENSION);
       		goto out;
       	}
       
     @@ read-cache.c: int write_locked_index(struct index_state *istate, struct lock_fil
       		if (!temp) {
      -			oidclr(&si->base_oid);
      -			ret = do_write_locked_index(istate, lock, flags);
     -+			ret = do_write_locked_index(istate, lock, flags, 1);
     ++			ret = do_write_locked_index(istate, lock, flags,
     ++						    ~WRITE_SPLIT_INDEX_EXTENSION);
       			goto out;
       		}
       		ret = write_shared_index(istate, &temp, flags);
 3:  c1c35f0f026 = 3:  89b3cd9a668 fsmonitor: avoid overriding `cache_changed` bits
 4:  3963d3e5428 = 4:  df61146eaf5 unpack-trees: take care to propagate the split-index flag

-- 
gitgitgadget
