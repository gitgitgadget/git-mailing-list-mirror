Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737BB2FA0C6
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781419051; cv=none; b=nsbSsuLN+VL4eRDnBpKf/WGjNikMGRrTyR/B/TM3QXOusT3ZXnUu9hIYXtBvLOi+3cRyBTljbi4kaWlEAgVfUL4yQ6DPUjDHBruwI+bixtbif33mW7QfIO1yzSzJz5Hcom9vyc9C65wTj7cX7RSB2jpvQ9ZRcw72UnAPGiVhd7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781419051; c=relaxed/simple;
	bh=0Eyk6z3O+ZYnFE1MSoDfrPL6WVfgqI5uLaw7Yv5tiJU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bTKGeltSGFudSl7GRTm2AHdtSZrrswqVztRrkBfGCkpfLMiDlrjsMrTJEEiw/pbN3gL1DiZsTUITZAImbnetQg6RPtiCNkiXDyDbHDXV1zNZPMbn4NTejhmoXVdElo65073/3yBe3wruTRKUoC9NNX2QO7kIBZ35yLpy1lxebeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlIRImBC; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlIRImBC"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ccf887de87so25836786d6.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 23:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781419048; x=1782023848; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHfA1z9joFPdYTQXzJajDqrl/ppaMk8ICjonoWbwjBo=;
        b=PlIRImBCGxDLbrDrCqVYrYWWqdW4TN1zCE3vzClQJeOitLfAoGG9nbtWmNtud67JhL
         0QjnKLpbM2nqRjx+8jJxQsIvy1ktpJsyWYkFTvE7B+z8pN0gnjXPcsv9mNGrUHjEHwDh
         AQLrtOf0BvCNuxluoVYWtXXifFFkANw2/WTzTJfUrqCxb5vI6U5r9dTgwK+uCFAlqhVc
         PF7zFXot7Y89/ilERZT0TANO56pgi28ZpgA0xIho4GYXJAB4+gTDuDUIZZERdsGWb1cc
         Ji9z5roFtR28GT0CCrrX6mdiSzTaMhwD5iZre1alwPl6da/zXedNmKkbCMNbTEWWaNgF
         L36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781419048; x=1782023848;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mHfA1z9joFPdYTQXzJajDqrl/ppaMk8ICjonoWbwjBo=;
        b=c17FD0tGI8mrjQ+EScTTjVo/tFbHUC0k5e7b4KFeA9C8jpHOzRs3JktBT3NMsCjqm3
         lKBVyrjdDiqFt/rhvdoE+PlX1V0Yit+JdKNWewjQPYvvPBwmw6zgGunNzZyNic54mkGC
         JiTlngV2XCffo+VBKiUxhcFQwAZPnIHPG7YXWhLLSHYZ5H4WxHcOt8r8qYK/vzR7hHk2
         d2IJzUUrz3BQW/apAPgjou09iM5tHJK9DACcFOrTZl8kxOt+znog1hnG3TU4UnDnCzVc
         IhpHXQd68myQfhOrsPETGzDorc1/3Q4fqyF4gN5kgrztfPc9UXuBeIHwhki0K1sgQHs0
         /SoA==
X-Gm-Message-State: AOJu0YyKRW17PFjw5/8WhMEvHunmqLEvmeFL/iKmlNmJ+iQT9wj/O7qT
	Bhu3Qpm7m6Jb8bKkKYxNcPk8ZbnydZKRhqmWfojKG9I3tm+7OY1VAPcW619arg==
X-Gm-Gg: Acq92OEU7B8pHl2NdR6ZfbuDRMNWjIRI5NSAmII1JYwVMwfYjUsKCU1I69+DHLCN4nk
	/GVhfDbl3cQOp1BL60ibmxjGIaM/LdD12WVcn6ekyWEWt6Yk3t5BiNdOaFmv8CjWY5TKVOITaH/
	BYHph40/j87lICvx+J7VL+zMIf8aDHCR9R/vGaoBj47qtU9aoWvRHyXGJg/y54P0arKUj1IaasJ
	yYmdwuOOiAjc2HgkLEYKh3J5aKG1E7OOji6lUU5qZTQmi7uFDEBPCViKrJJcRXsF9OJgLmXchE0
	q7wGoKjxSUTd/VxqtYtEsi6tBmEtsmOHR9vSndDESVtCvQajI0qrGYujywlCJwBL5LXKDw0/n+1
	itA+WzbI0tfpk3qWnIUiltkdjZ0HHJqO9VcfJ2MYM94rTjgOY7+ATFyUO4oupgBlf5R3/CFoovT
	YkMdesaeDrTezbBJdWo/GfMw==
X-Received: by 2002:a05:6214:1bcc:b0:8be:1620:a95a with SMTP id 6a1803df08f44-8d32de2c610mr161466296d6.27.1781419048265;
        Sat, 13 Jun 2026 23:37:28 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.15.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d301a32d5csm70533076d6.12.2026.06.13.23.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 23:37:27 -0700 (PDT)
Message-Id: <pull.2096.v2.git.1781419047.gitgitgadget@gmail.com>
In-Reply-To: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 06:37:21 +0000
Subject: [PATCH v2 0/5] Duplicate entry hardening
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Christian Couder <christian.couder@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

We had some corrupt trees with duplicate entries in real world repositories,
which triggered an assertion failure in merge-ort. Further, the corrupt tree
creation in the third party tool would have been avoided had verify_cache()
correctly checked for D/F conflicts. Provide fixes for both issues,
including 3 preparatory changes for the merge-ort fix.

Changes since v1:

 * Add some more detail to the commit message of Patch 1
 * Split some code out in Patch 5 into a helper function.

Elijah Newren (5):
  merge-ort: propagate callback errors from traverse_trees_wrapper()
  merge-ort: drop unnecessary show_all_errors from collect_merge_info()
  merge-ort: free diff pairs queue in clear_or_reinit_internal_opts()
  merge-ort: abort merge when trees have duplicate entries
  cache-tree: fix verify_cache() to catch non-adjacent D/F conflicts

 cache-tree.c                         | 64 +++++++++++++++++++----
 merge-ort.c                          | 78 ++++++++++++++++------------
 t/meson.build                        |  1 +
 t/t0093-direct-index-write.pl        | 38 ++++++++++++++
 t/t0093-verify-cache-df-gap.sh       | 59 +++++++++++++++++++++
 t/t6422-merge-rename-corner-cases.sh | 54 +++++++++++++++++++
 6 files changed, 249 insertions(+), 45 deletions(-)
 create mode 100644 t/t0093-direct-index-write.pl
 create mode 100755 t/t0093-verify-cache-df-gap.sh


base-commit: e8955061076952cc5eab0300424fc48b601fe12d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2096%2Fnewren%2Fduplicate-entry-hardening-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2096/newren/duplicate-entry-hardening-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2096

Range-diff vs v1:

 1:  282f906d1b ! 1:  dc0f596f31 merge-ort: propagate callback errors from traverse_trees_wrapper()
     @@ Commit message
          traverse_trees_wrapper() saves entries from a first pass through
          traverse_trees() and then replays them through the real callback
          (collect_merge_info_callback).  However, the replay loop silently
     -    discards the callback return value.  This means any error reported by
     -    the callback during replay -- including a future check for malformed
     -    trees -- would be ignored, allowing the merge to proceed with corrupt
     -    state.
     +    discards the callback return value.  This is not a deferred error;
     +    it is an ignored error.
      
     -    Capture the return value, stop the loop on negative (error) returns,
     -    and propagate the error to the caller.  Note that the callback returns
     -    a positive mask value on success, so we normalize non-negative returns
     -    to 0 for the caller.
     +    Today the only originator of a negative return in this entire call
     +    graph is traverse_trees()'s "exceeded maximum allowed tree depth"
     +    check; everything else (collect_merge_info_callback,
     +    traverse_trees_wrapper, the inner traverse_trees recursion) only
     +    relays that.  So in current Git, the visible effect of dropping the
     +    replay callback's return value is narrow but bad: a tree nested past
     +    core.maxTreeDepth has its -1 swallowed, the subtree below the limit
     +    is silently pruned, and the merge completes as if that were the
     +    correct result.
     +
     +    A later patch in this series will teach collect_merge_info_callback()
     +    to return -1 on an additional path -- detecting duplicate
     +    entries in malformed trees -- which is similarly handled today by
     +    just ignoring the problem (resulting in mostly a "last one wins" rule,
     +    though the non-last entry can mutate various state flags).
     +
     +    Capture the return value, stop the loop on negative returns, and
     +    propagate the error to the caller.  The callback returns a positive mask
     +    value on success, so normalize non-negative returns to
     +    0 for the caller.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
 2:  949b5d8e3f = 2:  b4ff725a77 merge-ort: drop unnecessary show_all_errors from collect_merge_info()
 3:  d422f73e12 = 3:  673fbea13f merge-ort: free diff pairs queue in clear_or_reinit_internal_opts()
 4:  0d81c027aa = 4:  b5421244d4 merge-ort: abort merge when trees have duplicate entries
 5:  a87bbaa84f ! 5:  cf50f1aabc cache-tree: fix verify_cache() to catch non-adjacent D/F conflicts
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## cache-tree.c ##
     +@@ cache-tree.c: void cache_tree_invalidate_path(struct index_state *istate, const char *path)
     + 		istate->cache_changed |= CACHE_TREE_CHANGED;
     + }
     + 
     ++/*
     ++ * Check whether this_ce and the next entry in the index form a D/F
     ++ * conflict ("path" vs "path/file").  Returns the conflicting "path/..."
     ++ * name when one is found, or NULL otherwise.
     ++ *
     ++ * The cache is sorted, so "path/file" sorts after "path" and the
     ++ * conflict is usually visible as adjacent entries.  But other entries
     ++ * can sort between them -- e.g. "path-internal" sits between "path"
     ++ * and "path/file" because '-' (0x2D) precedes '/' (0x2F) -- so when
     ++ * the immediately following entry shares our prefix but starts with a
     ++ * character that sorts before '/', binary search for "path/" instead.
     ++ */
     ++static const char *find_df_conflict(struct index_state *istate,
     ++				    const struct cache_entry *this_ce,
     ++				    const struct cache_entry *next_ce)
     ++{
     ++	const char *this_name = this_ce->name;
     ++	const char *next_name = next_ce->name;
     ++	int this_len = ce_namelen(this_ce);
     ++	const struct cache_entry *other;
     ++	struct strbuf probe = STRBUF_INIT;
     ++	int pos;
     ++
     ++	if (this_len >= ce_namelen(next_ce) ||
     ++	    next_name[this_len] > '/' ||
     ++	    strncmp(this_name, next_name, this_len))
     ++		return NULL;
     ++
     ++	if (next_name[this_len] == '/')
     ++		return next_name;
     ++
     ++	strbuf_add(&probe, this_name, this_len);
     ++	strbuf_addch(&probe, '/');
     ++	pos = index_name_pos_sparse(istate, probe.buf, probe.len);
     ++	strbuf_release(&probe);
     ++
     ++	if (pos < 0)
     ++		pos = -pos - 1;
     ++	if (pos >= (int)istate->cache_nr)
     ++		return NULL;
     ++	other = istate->cache[pos];
     ++	if (ce_namelen(other) > this_len &&
     ++	    other->name[this_len] == '/' &&
     ++	    !strncmp(this_name, other->name, this_len))
     ++		return other->name;
     ++	return NULL;
     ++}
     ++
     + static int verify_cache(struct index_state *istate, int flags)
     + {
     + 	unsigned i, funny;
      @@ cache-tree.c: static int verify_cache(struct index_state *istate, int flags)
     + 	 */
     + 	funny = 0;
       	for (i = 0; i + 1 < istate->cache_nr; i++) {
     - 		/* path/file always comes after path because of the way
     - 		 * the cache is sorted.  Also path can appear only once,
     +-		/* path/file always comes after path because of the way
     +-		 * the cache is sorted.  Also path can appear only once,
      -		 * which means conflicting one would immediately follow.
     -+		 * so path/file is likely the immediately following path
     -+		 * but might be separated if there is e.g. a
     -+		 * path-internal/... file.
     - 		 */
     +-		 */
       		const struct cache_entry *this_ce = istate->cache[i];
       		const struct cache_entry *next_ce = istate->cache[i + 1];
     - 		const char *this_name = this_ce->name;
     - 		const char *next_name = next_ce->name;
     - 		int this_len = ce_namelen(this_ce);
     -+		const char *conflict_name = NULL;
     -+
     - 		if (this_len < ce_namelen(next_ce) &&
     +-		const char *this_name = this_ce->name;
     +-		const char *next_name = next_ce->name;
     +-		int this_len = ce_namelen(this_ce);
     +-		if (this_len < ce_namelen(next_ce) &&
      -		    next_name[this_len] == '/' &&
     -+		    next_name[this_len] <= '/' &&
     - 		    strncmp(this_name, next_name, this_len) == 0) {
     -+			if (next_name[this_len] == '/') {
     -+				conflict_name = next_name;
     -+			} else if (next_name[this_len] < '/') {
     -+				/*
     -+				 * The immediately next entry shares our
     -+				 * prefix but sorts before "path/" (e.g.,
     -+				 * "path-internal" between "path" and
     -+				 * "path/file", since '-' (0x2D) < '/'
     -+				 * (0x2F)).  Binary search to find where
     -+				 * "path/" would be and check for a D/F
     -+				 * conflict there.
     -+				 */
     -+				struct cache_entry *other;
     -+				struct strbuf probe = STRBUF_INIT;
     -+				int pos;
     -+
     -+				strbuf_add(&probe, this_name, this_len);
     -+				strbuf_addch(&probe, '/');
     -+				pos = index_name_pos_sparse(istate,
     -+							    probe.buf,
     -+							    probe.len);
     -+				strbuf_release(&probe);
     -+
     -+				if (pos < 0)
     -+					pos = -pos - 1;
     -+				if (pos >= (int)istate->cache_nr)
     -+					continue;
     -+				other = istate->cache[pos];
     -+				if (ce_namelen(other) > this_len &&
     -+				    other->name[this_len] == '/' &&
     -+				    !strncmp(this_name, other->name, this_len))
     -+					conflict_name = other->name;
     -+			}
     -+		}
     +-		    strncmp(this_name, next_name, this_len) == 0) {
     ++		const char *conflict_name;
      +
     ++		conflict_name = find_df_conflict(istate, this_ce, next_ce);
      +		if (conflict_name) {
       			if (10 < ++funny) {
       				fprintf(stderr, "...\n");
     @@ cache-tree.c: static int verify_cache(struct index_state *istate, int flags)
       			}
       			fprintf(stderr, "You have both %s and %s\n",
      -				this_name, next_name);
     -+				this_name, conflict_name);
     ++				this_ce->name, conflict_name);
       		}
       	}
       	if (funny)

-- 
gitgitgadget
