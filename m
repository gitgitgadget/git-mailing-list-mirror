Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F06C4167B
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 16:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiLLQbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 11:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiLLQbY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 11:31:24 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D5EFCEB
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 08:31:20 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n9-20020a05600c3b8900b003d0944dba41so5669871wms.4
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 08:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LoHj608NLlxQr1o15V2oVMLSTuhW2bw0m9MwAhS7go=;
        b=ZqcH6i9pBCZxLFn+mDgIOQYKA+bY7vNYxNOPOin/y8Aevy3Tc5brG61EbyJ2693AK5
         G9JQN5oi08u7G8b19sOqXl522dNouCot2NyU9bGH/sTY/0eR10KwrRVcWK5LYq0pg4gG
         QwUiM3mLEehiWLIuL8aCYUsM6GFQcoZrXfhMtm4ovewPmy406T2NRSPRbPRi7wdR1Dzn
         gI1TljnbcR1rcSckUNQJgEfltq1jcG1L5bN19Q7Eo3Z+qS7zjxwV5t8/rh7TuDCWowgU
         ejgazg859q06/abqZuhWTOP6rRZlUCqnVL/qrQi94D4XhPC6mGW3wiXJK2SZXRbBSHOq
         12Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LoHj608NLlxQr1o15V2oVMLSTuhW2bw0m9MwAhS7go=;
        b=ttlUnC6lJYfxknTxQctKn4jB0JAJUf6HeliMw2oZBZmyRyn/07SKg5VbHD4vq+oGIF
         o1nM7FUCI41UQY9Ha86EbuOpBMt0/Lq6p8wTa3GKBXRReBDZy4SBABj4YntZhNRpnYuR
         v8idT7LOx/4d6JLW9EgSxyEj1zTiT7l9olNbYgpgNr5F1vPYE+kpB4NpJmXAmBsAIQDI
         nqWOYpxLJmtR6Smk04J6OzS6mCiDbnoPXv5m2WzO91BWwerykWvDv03bvSACCrREIg+c
         WbblxJX/tQW4apDwOJAmgOktlJnwSqaJvbpp6l82I/p+In9s2rKSb0LgxaurEPwDHyyb
         ZiMg==
X-Gm-Message-State: ANoB5pm5ax1yof+HaiQVoZDPHc35X5Hg4+yHimglvaACOe42k5foxErS
        /ypTRX9u+Uwe4XpP3FiWqL6ch1J4CII=
X-Google-Smtp-Source: AA0mqf7FV3ONffYbFG7nOGcOy4yAazLR9eEnXHy0zR7TOOKjqnhNNGtba+RT5+OXdhYUuaMlLTwJeQ==
X-Received: by 2002:a05:600c:3d12:b0:3cf:7903:5646 with SMTP id bh18-20020a05600c3d1200b003cf79035646mr13289098wmb.24.1670862678832;
        Mon, 12 Dec 2022 08:31:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iw3-20020a05600c54c300b003d220ef3232sm6535872wmb.34.2022.12.12.08.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:31:18 -0800 (PST)
Message-Id: <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 16:31:13 +0000
Subject: [PATCH v2 0/4] Optionally skip hashing index on write
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Writing the index is a critical action that takes place in multiple Git
commands. The recent performance improvements available with the sparse
index show how often the I/O costs around the index can affect different Git
commands, although reading the index takes place more often than a write.

The index is written through the hashfile API, both as a buffered write and
as a computation of its trailing hash. This trailing hash is an expectation
of the file format: several optional index extensions are provided using
indicators immediately preceding the trailing hash. 'git fsck' will complain
if the trailing hash does not match the contents of the file up to that
point.

However, computing the hash is expensive. This is even more expensive now
that we've moved to sha1dc instead of hardware-accelerated SHA1
computations.

This series provides a new config option, index.skipHash, that allows users
to disable computing the hash as Git writes the index. In this case, the
trailing hash is stored as the null hash (all bytes are zero).

The implementation is rather simple, but the patches organize different
aspects in a way that we could split things out:

 * Patch 1 adds a 'skip_hash' option to 'struct hashfile' that creates this
   as a general option to the hashwrite API.
 * The motivation in Patch 1 avoids the talk about the chunk-format API and
   instead focuses on the index as the first example that could make use of
   this.
 * Patch 2 creates the index.skipHash config option and updates 'git fsck'
   to ignore a null hash on the index. This is demonstrated by a very simple
   test.
 * Patch 3 creates a test helper to get the trailing hash of a file, and
   adds a concrete check on the trailing hash when index.skipHash=true.
 * Patch 4 (which could be deferred until later) adds index.skipHash=true as
   an implication of feature.manyFiles and as a setting in Scalar.

The end result is that index writes speed up significantly, enough that 'git
update-index --force-write' improves by 1.75x.

Similar patches appeared in my earlier refs RFC [1].

[1]
https://lore.kernel.org/git/pull.1408.git.1667846164.gitgitgadget@gmail.com/


Updates since v1
================

 * In Patch 1, use hashcler() instead of memset().
 * In Patches 2 and 4, be explicit about which Git versions will exhibit
   different behavior when reading an index with a null trailing hash.
 * In Patch 2, used a more compact way of loading from config.
 * In Patch 2 (and following) dropped the sub-shell in t1600-index.sh.
 * In Patch 3, dropped back-ticks when using a multi-line pipe.
 * In Patch 4, use "! cmp" instead of "! test_cmp"


Updates since RFC
=================

 * The config name is now index.skipHash to make it more clear that the
   default is to not skip the hash, and choosing this option requires a true
   value.
 * Use oidread() instead of an ad-hoc loop.
 * Patches 3 and 4 are new. 3 adds some extra test verification that wasn't
   in the RFC.
 * I think that patch 4 is helpful to see now, but I could understand if we
   wanted to defer that patch until after index.skipHash has had more time
   to bake.

Thanks, -Stolee

Derrick Stolee (4):
  hashfile: allow skipping the hash function
  read-cache: add index.skipHash config option
  test-lib-functions: add helper for trailing hash
  features: feature.manyFiles implies fast index writes

 Documentation/config/feature.txt |  5 +++++
 Documentation/config/index.txt   |  9 +++++++++
 csum-file.c                      | 14 +++++++++++---
 csum-file.h                      |  7 +++++++
 read-cache.c                     | 15 ++++++++++++++-
 repo-settings.c                  |  2 ++
 repository.h                     |  1 +
 scalar.c                         |  1 +
 t/t1600-index.sh                 | 20 ++++++++++++++++++++
 t/test-lib-functions.sh          |  8 ++++++++
 10 files changed, 78 insertions(+), 4 deletions(-)


base-commit: 805265fcf7a737664a8321aaf4a0587b78435184
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1439%2Fderrickstolee%2Fhashfile-skip-hash-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1439/derrickstolee/hashfile-skip-hash-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1439

Range-diff vs v1:

 1:  40ee8dbaef0 ! 1:  b582d681581 hashfile: allow skipping the hash function
     @@ csum-file.c: int finalize_hashfile(struct hashfile *f, unsigned char *result,
      -	the_hash_algo->final_fn(f->buffer, &f->ctx);
      +
      +	if (f->skip_hash)
     -+		memset(f->buffer, 0, the_hash_algo->rawsz);
     ++		hashclr(f->buffer);
      +	else
      +		the_hash_algo->final_fn(f->buffer, &f->ctx);
      +
 2:  5fb4b5a36ac ! 2:  c8a2fd3a470 read-cache: add index.skipHash config option
     @@ Commit message
          The one exception is 'git fsck' which checks the hash of the index file.
          This used to be a check on every index read, but was split out to just
          the index in a33fc72fe91 (read-cache: force_verify_index_checksum,
     -    2017-04-14).
     +    2017-04-14) and released first in Git 2.13.0. Document the versions that
     +    relaxed these restrictions, with the optimistic expectation that this
     +    change will be included in Git 2.40.0.
      
          Here, we disable this check if the trailing hash is all zeroes. We add a
          warning to the config option that this may cause undesirable behavior
          with older Git versions.
      
          As a quick comparison, I tested 'git update-index --force-write' with
     -    and without index.computeHash=false on a copy of the Linux kernel
     +    and without index.skipHash=true on a copy of the Linux kernel
          repository.
      
          Benchmark 1: with hash
     @@ Documentation/config/index.txt: index.version::
      +	Instead, write a trailing set of bytes with value zero, indicating
      +	that the computation was skipped.
      ++
     -+If you enable `index.skipHash`, then older Git clients may report that
     -+your index is corrupt during `git fsck`.
     ++If you enable `index.skipHash`, then Git clients older than 2.13.0 will
     ++refuse to parse the index and Git clients older than 2.40.0 will report an
     ++error during `git fsck`.
      
       ## read-cache.c ##
      @@ read-cache.c: static int verify_hdr(const struct cache_header *hdr, unsigned long size)
     @@ read-cache.c: static int verify_hdr(const struct cache_header *hdr, unsigned lon
       	return 0;
       }
      @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
     - 	int ieot_entries = 1;
     - 	struct index_entry_offset_table *ieot = NULL;
     - 	int nr, nr_threads;
     -+	int skip_hash;
       
       	f = hashfd(tempfile->fd, tempfile->filename.buf);
       
     -+	if (!git_config_get_maybe_bool("index.skiphash", &skip_hash))
     -+		f->skip_hash = skip_hash;
     ++	git_config_get_maybe_bool("index.skiphash", (int *)&f->skip_hash);
      +
       	for (i = removed = extended = 0; i < entries; i++) {
       		if (cache[i]->ce_flags & CE_REMOVE)
     @@ t/t1600-index.sh: test_expect_success 'out of bounds index.version issues warnin
       '
       
      +test_expect_success 'index.skipHash config option' '
     -+	(
     -+		rm -f .git/index &&
     -+		git -c index.skipHash=true add a &&
     -+		git fsck
     -+	)
     ++	rm -f .git/index &&
     ++	git -c index.skipHash=true add a &&
     ++	git fsck
      +'
      +
       test_index_version () {
 3:  a20bf8de864 ! 3:  813e81a0582 test-lib-functions: add helper for trailing hash
     @@ Commit message
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## t/t1600-index.sh ##
     -@@ t/t1600-index.sh: test_expect_success 'index.skipHash config option' '
     - 	(
     - 		rm -f .git/index &&
     - 		git -c index.skipHash=true add a &&
     -+		test_trailing_hash .git/index >hash &&
     -+		echo $(test_oid zero) >expect &&
     -+		test_cmp expect hash &&
     - 		git fsck
     - 	)
     +@@ t/t1600-index.sh: test_expect_success 'out of bounds index.version issues warning' '
     + test_expect_success 'index.skipHash config option' '
     + 	rm -f .git/index &&
     + 	git -c index.skipHash=true add a &&
     ++	test_trailing_hash .git/index >hash &&
     ++	echo $(test_oid zero) >expect &&
     ++	test_cmp expect hash &&
     + 	git fsck
       '
     + 
      
       ## t/test-lib-functions.sh ##
      @@ t/test-lib-functions.sh: test_cmp_config_output () {
     @@ t/test-lib-functions.sh: test_cmp_config_output () {
      +# Given a filename, extract its trailing hash as a hex string
      +test_trailing_hash () {
      +	local file="$1" &&
     -+	tail -c $(test_oid rawsz) "$file" | \
     -+		test-tool hexdump | \
     ++	tail -c $(test_oid rawsz) "$file" |
     ++		test-tool hexdump |
      +		sed "s/ //g"
      +}
 4:  77bf5d5ff27 ! 4:  e640dff53dd features: feature.manyFiles implies fast index writes
     @@ Documentation/config/feature.txt: feature.manyFiles::
       	`git checkout` may be slow and these new defaults improve performance:
       +
      +* `index.skipHash=true` speeds up index writes by not computing a trailing
     -+  checksum.
     ++  checksum. Note that this will cause Git versions earlier than 2.13.0 to
     ++  refuse to parse the index and Git versions earlier than 2.40.0 will report
     ++  a corrupted index during `git fsck`.
      ++
       * `index.version=4` enables path-prefix compression in the index.
       +
     @@ Documentation/config/feature.txt: feature.manyFiles::
      
       ## read-cache.c ##
      @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
     - 	int ieot_entries = 1;
     - 	struct index_entry_offset_table *ieot = NULL;
     - 	int nr, nr_threads;
     --	int skip_hash;
       
       	f = hashfd(tempfile->fd, tempfile->filename.buf);
       
     --	if (!git_config_get_maybe_bool("index.skiphash", &skip_hash))
     --		f->skip_hash = skip_hash;
     +-	git_config_get_maybe_bool("index.skiphash", (int *)&f->skip_hash);
      +	if (istate->repo) {
      +		prepare_repo_settings(istate->repo);
      +		f->skip_hash = istate->repo->settings.index_skip_hash;
     @@ scalar.c: static int set_recommended_config(int reconfigure)
      
       ## t/t1600-index.sh ##
      @@ t/t1600-index.sh: test_expect_success 'index.skipHash config option' '
     - 		test_trailing_hash .git/index >hash &&
     - 		echo $(test_oid zero) >expect &&
     - 		test_cmp expect hash &&
     --		git fsck
     -+		git fsck &&
     + 	test_trailing_hash .git/index >hash &&
     + 	echo $(test_oid zero) >expect &&
     + 	test_cmp expect hash &&
     +-	git fsck
     ++	git fsck &&
      +
     -+		rm -f .git/index &&
     -+		git -c feature.manyFiles=true add a &&
     -+		test_trailing_hash .git/index >hash &&
     -+		test_cmp expect hash &&
     ++	rm -f .git/index &&
     ++	git -c feature.manyFiles=true add a &&
     ++	test_trailing_hash .git/index >hash &&
     ++	test_cmp expect hash &&
      +
     -+		rm -f .git/index &&
     -+		git -c feature.manyFiles=true \
     -+		    -c index.skipHash=false add a &&
     -+		test_trailing_hash .git/index >hash &&
     -+		! test_cmp expect hash
     - 	)
     ++	rm -f .git/index &&
     ++	git -c feature.manyFiles=true \
     ++		-c index.skipHash=false add a &&
     ++	test_trailing_hash .git/index >hash &&
     ++	! cmp expect hash
       '
       
     + test_index_version () {

-- 
gitgitgadget
