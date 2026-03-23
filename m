Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C6396566
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266025; cv=none; b=jxDOdQvMXRgn2tEUqR1lGr7Gn3Xl4hk6pJwV2XYTNwHWo6e9iZpEIlU6Q7JfBJPM2O4OAsYZWdr4nmDdpRlqZcR9fqYt0P1hlRzqGjjGWJd7V4czhgC0nkMcsAIyXIHHkcHlYl3FbNfOHlrY/lpeH2Z4v2ZUHPuEYTBgdaSSj4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266025; c=relaxed/simple;
	bh=tvSlWWB+gHQ4hnz7ZphpPMzgpPZWo1BeD0oT/nq+B0U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BRcX/luBn+E3z3gqnYL4IHBHux78f6Vl5riQlCyJ99GMxZHLso5XMSFwvse2ZfvZmyPsx2AvYHdMGIN1vdUBz4xY4glTABR6Gk4Uvo623b2C+H0s6bjgQNl/4lTujZE6rhmLoP8j8FnSd2mNd1AYYALNIQ36qp3c+q86AFWsriM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMGPmPEd; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMGPmPEd"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-128b9b7e3edso6301113c88.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774266022; x=1774870822; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzKBTDDdIS9pRMAKs1/2p5bNP74Q+08mWED6lSnH5MA=;
        b=BMGPmPEdrAuka1eMyZw0sw1TjoU5pwPgE6zjY4nhzgUYyyyW4RynP+H1Q3he7eAL4G
         XfwPm03II1WxpJ4bQ/3884pQ6uDGggxR/wGG4xFCSRimU8EMeufI0awINbOEILAUGsVy
         pf5OhtH2mMb55PiosOp7ZNp+zixoq3t4dxcNUupqa75H7xUjcccXA/c4itKGVaeURmxu
         r+foA6ySRKJjTH4c8Dr/5VtTJkS/92c4y78FbcFwZRdGaDsfhjxC1d36Daj8Blrnz6js
         iSfZOPjRiZEEqn/JLLJXgbbo5Wp0YAqT9T9YKEsJRwZzHgfHbSn5JMLK0YqRNiHQPxN3
         EEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774266022; x=1774870822;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZzKBTDDdIS9pRMAKs1/2p5bNP74Q+08mWED6lSnH5MA=;
        b=KbAQIIPS5bci2txsztcYvYDEjyLks+FX50+FpHDyI1ad4+dypyjsRNID2ENrT3rnV6
         X5xOqFBykRoVy2VEqCXXzI97yv1w3izMiPPY8GO4ZhtJ6aXivCn1HDh83LQbheqqsXWh
         f5VnLAFL2/dSyy/C+HXgn17GKH0LBlgOP8jBzGXQWKWqoKCtwtapkXCobukaoe2sjEEd
         6MDdPBFYrzsk28enEEL1UIQiijjET23uWGlKTDY5FReDnYE/3S1Ny1PVjoV2emnNtob0
         rDZJGq8/vzuEZCZHUb44sZdCzYg/lpvxbzzug2fwz72LOvUI3+O9Ngbu96ua+S8angsb
         tiCA==
X-Gm-Message-State: AOJu0YxNQMYvh4RF2Ql2qz22iCOLpeX2O4nRoU17HZuIbKKOKOSRRuhW
	GXuFfAB9bPV0zsGtVhRtaUV9uKnnQDRY9blCSVSfFZm3/H2q40QEszS7OHn+pg==
X-Gm-Gg: ATEYQzyl6F/n5xyikuSnRa/uLKNpQzmQDVEwi0QdRPyEHDIPP2WaYZC1nCEz968BtuZ
	jSht+304V47pUNsk9rowSu6AO+KAUWGJ2AcmL9WwvccZo1qTF3s/dIoQOxT+/+zTaaPQHNUUQ4Y
	U1cq8xmYla3bLQdkAvBLRPTTHmmPbN1sQ7tQdRoUM78T4CGA+Q4gwZJqWygrIlwk9bTGIR2hAW4
	L9TLz28f+j2+0rcIqHelTZDp1U9Jhv5X+Osa6GP6vRZST9nZ8QxZ5TqPg6lvjTuFAbMlO8eIQdI
	PdywVMG9zaOGf6yg1hn4HFhG+9Ktu/zwHDiGpGajZo2kS8aSc3QaQ+ogesO5/UxWnve4W8eEzdT
	b1i4uRpWsEn0o5QRTc+hmBC6xDbR60t5hc2BsqZeykWeIs4sj0PD+o5RpVJCLoAtrbPRnZ4pkyc
	uLqkg71NkQmVxoMRzyMmHdMFZD2MM=
X-Received: by 2002:a05:7022:4590:b0:11a:51f9:db0 with SMTP id a92af1059eb24-12a726821f2mr5665472c88.11.1774266021927;
        Mon, 23 Mar 2026 04:40:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a734bbbc5sm9188609c88.11.2026.03.23.04.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 04:40:21 -0700 (PDT)
Message-Id: <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Mar 2026 11:40:13 +0000
Subject: [PATCH v2 0/6] backfill: accept revision arguments
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
Cc: gitster@pobox.com,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    r.siddharth.shrimali@gmail.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>

The git backfill command assists in downloading missing blobs for blobless
partial clones. However, its current version lacks some valuable
functionality. It currently:

 1. Only walks commits reachable from HEAD.
 2. It walks all reachable commits to the full history.
 3. It can focus on the current sparse-checkout definition, but otherwise it
    doesn't focus on a given pathspec.

All of these are being updated by this patch series, which allows rev-list
options to impact the path-walk. These include:

 1. Specifying a given refspec, including --all.
 2. Modifying the commit walk, including --first-parent, commit ranges, or
    recency using --since.
 3. Modifying the set of paths to download using pathspecs.

One particularly valuable situation here is that now a user can run git
backfill -- <path> to download all versions of a specific file or a specific
directory, accelerating history queries within that path without downloading
more than necessary. This can accelerate git blame or git log -L for these
paths, where normally those commands download missing blobs one-by-one
during its diff algorithms.

This patch series is organized in the following way:

 1. A missing #include is added to prevent future compilation issues.
 2. The test repo in t5620 is expanded to make later tests more interesting.
 3. The backfill builtin parses the rev-list arguments. We test the top
    arguments that work as expected, though the pathspec arguments need
    extra work.
 4. Update the path-walk logic to work efficiently with some pathspecs, such
    as fixed prefix pathspecs, accelerating the computation.
 5. For more complicated pathspecs, do a post-filter in builtin/backfill.c
    instead of restricting the walk in the path-walk API.

The main goal of this series is to make such customizations possible, and to
improve performance where common use cases are expected. I'm open to
feedback as to whether we should consider more detailed performance analysis
or whether we should wait for how users interact with these new options
before overoptimizing unlikely use cases.


Updates in v2
=============

 * Hard stops are replaced with a comma (and no punctuation) in the docs.
 * add_head_to_pending() simplifies some code.
 * My poor explanation of "starting commits" is updated.
 * Language around temporary prefix restriction is clarified.
 * Prefix match logic is simplified with dir_prefix().
 * Temporary memory leak (introduced in v1's patch 4 and removed in v1's
   patch 5) is removed in v2's patch 4.
 * Commit pruning is reenabled in v2's patch 5. There was no need for that
   with the way the logic works in the patch.
 * Add a new patch with a test demonstrating the new behavior that was being
   discussed in [1].

[1]
https://lore.kernel.org/git/20260321031643.5185-1-r.siddharth.shrimali@gmail.com/

Thanks, -Stolee

Derrick Stolee (6):
  revision: include object-name.h
  t5620: prepare branched repo for revision tests
  backfill: accept revision arguments
  backfill: work with prefix pathspecs
  path-walk: support wildcard pathspecs for blob filtering
  t5620: test backfill's unknown argument handling

 Documentation/git-backfill.adoc |   5 +-
 builtin/backfill.c              |  19 ++-
 path-walk.c                     |  44 +++++++
 path.c                          |   2 +-
 path.h                          |   6 +
 revision.h                      |   1 +
 t/t5620-backfill.sh             | 211 +++++++++++++++++++++++++++++++-
 7 files changed, 278 insertions(+), 10 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2070%2Fderrickstolee%2Fbackfill-revs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2070/derrickstolee/backfill-revs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2070

Range-diff vs v1:

 1:  fda0239103 = 1:  fda0239103 revision: include object-name.h
 2:  55a45b2fc8 = 2:  55a45b2fc8 t5620: prepare branched repo for revision tests
 3:  dc6652c84c ! 3:  610a162973 backfill: accept revision arguments
     @@ Documentation/git-backfill.adoc: OPTIONS
      +
       SEE ALSO
       --------
     - linkgit:git-clone[1].
     -+linkgit:git-rev-list[1].
     +-linkgit:git-clone[1].
     ++linkgit:git-clone[1],
     ++linkgit:git-rev-list[1]
       
       GIT
       ---
     @@ builtin/backfill.c: static int do_backfill(struct backfill_context *ctx)
      -	handle_revision_arg("HEAD", &revs, 0, 0);
      +	/* Walk from HEAD if otherwise unspecified. */
      +	if (!ctx->revs.pending.nr)
     -+		handle_revision_arg("HEAD", &ctx->revs, 0, 0);
     ++		add_head_to_pending(&ctx->revs);
       
       	info.blobs = 1;
       	info.tags = info.commits = info.trees = 0;
 4:  977f62faa5 ! 4:  f8f2c61326 backfill: work with prefix pathspecs
     @@ Commit message
          backfill: work with prefix pathspecs
      
          The previous change allowed specifying revision arguments over the 'git
     -    backfill' command-line. This created the opportunity for pathspecs that
     -    specify a smaller set of starting commits, but otherwise did not restrict
     -    the blob paths that were downloaded.
     +    backfill' command-line. This created the opportunity for restricting the
     +    initial commit set by filtering the revision walk through a pathspec. Other
     +    than filtering the commit set (and thereby the root trees), this did not
     +    restrict the path-walk implementation of 'git backfill' and did not restrict
     +    the blobs that were downloaded to only those matching the pathspec.
      
          Update the path-walk API to accept certain kinds of pathspecs and to
     -    silently ignore anything too complex. The current behavior focuses on
     -    pathspecs that match paths exactly. This includes exact filenames,
     -    including directory names as prefixes. Pathspecs containing wildcards
     -    or magic are cleared so the path walk downloads all blobs, as before.
     +    silently ignore anything too complex, for now. We will update this in the
     +    next change to properly restrict to even complex pathspecs.
     +
     +    The current behavior focuses on pathspecs that match paths exactly. This
     +    includes exact filenames, including directory names as prefixes. Pathspecs
     +    containing wildcards or magic are cleared so the path walk downloads all
     +    blobs, as before.
      
          The reason for this restriction is to allow for a faster execution by
          pruning the path walk to only trees that could contribute towards one of
     @@ Commit message
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## path-walk.c ##
     +@@
     + #include "list-objects.h"
     + #include "object.h"
     + #include "oid-array.h"
     ++#include "path.h"
     + #include "prio-queue.h"
     + #include "repository.h"
     + #include "revision.h"
      @@ path-walk.c: static int add_tree_entries(struct path_walk_context *ctx,
       				 match != MATCHED)
       				continue;
     @@ path-walk.c: static int add_tree_entries(struct path_walk_context *ctx,
      +			struct pathspec *pd = &ctx->revs->prune_data;
      +			bool found = false;
      +
     ++			/* remove '/' for these checks. */
     ++			path.buf[path.len - 1] = 0;
     ++
      +			for (int i = 0; i < pd->nr; i++) {
      +				struct pathspec_item *item = &pd->items[i];
      +
      +				/*
     -+				 * Is this path a parent directory of
     -+				 * the pathspec item?
     -+				 */
     -+				if (path.len < (size_t)item->len &&
     -+				    !strncmp(path.buf, item->match, path.len) &&
     -+				    item->match[path.len - 1] == '/') {
     -+					found = true;
     -+					break;
     -+				}
     -+
     -+				/*
     -+				 * Or, is the pathspec an exact match?
     -+				 */
     -+				if (path.len == (size_t)item->len &&
     -+				    !strcmp(path.buf, item->match)) {
     -+					found = true;
     -+					break;
     -+				}
     -+
     -+				/*
     -+				 * Or, is the pathspec a directory prefix
     -+				 * match?
     ++				 * Continue if either is a directory prefix
     ++				 * of the other.
      +				 */
     -+				if (path.len > (size_t)item->len &&
     -+				    !strncmp(path.buf, item->match, item->len) &&
     -+				    path.buf[item->len] == '/') {
     ++				if (dir_prefix(path.buf, item->match) ||
     ++				    dir_prefix(item->match, path.buf)) {
      +					found = true;
      +					break;
      +				}
      +			}
      +
     ++			/* return '/' after these checks. */
     ++			path.buf[path.len - 1] = '/';
     ++
      +			/* Skip paths that do not match the prefix. */
      +			if (!found)
      +				continue;
     @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
      +		 * Clear any wildcard or magic pathspecs to avoid
      +		 * incorrect prefix matching.
      +		 */
     -+		struct pathspec *pd = &ctx.revs->prune_data;
     -+
     -+		if (pd->has_wildcard || pd->magic)
     -+			pd->nr = 0;
     ++		if (ctx.revs->prune_data.has_wildcard ||
     ++		    ctx.revs->prune_data.magic)
     ++			clear_pathspec(&ctx.revs->prune_data);
      +	}
      +
       	/* Insert a single list for the root tree into the paths. */
       	CALLOC_ARRAY(root_tree_list, 1);
       	root_tree_list->type = OBJ_TREE;
      
     + ## path.c ##
     +@@ path.c: static void strbuf_cleanup_path(struct strbuf *sb)
     + 		strbuf_remove(sb, 0, path - sb->buf);
     + }
     + 
     +-static int dir_prefix(const char *buf, const char *dir)
     ++int dir_prefix(const char *buf, const char *dir)
     + {
     + 	int len = strlen(dir);
     + 	return !strncmp(buf, dir, len) &&
     +
     + ## path.h ##
     +@@ path.h: const char *repo_submodule_path_replace(struct repository *repo,
     + 					const char *fmt, ...)
     + 	__attribute__((format (printf, 4, 5)));
     + 
     ++/*
     ++ * Given a directory name 'dir' (not ending with a trailing '/'),
     ++ * determine if 'buf' is equal to 'dir' or has prefix 'dir'+'/'.
     ++ */
     ++int dir_prefix(const char *buf, const char *dir);
     ++
     + void report_linked_checkout_garbage(struct repository *r);
     + 
     + /*
     +
       ## t/t5620-backfill.sh ##
      @@ t/t5620-backfill.sh: test_expect_success 'backfill with prefix pathspec' '
       	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
 5:  beb1c92554 ! 5:  1168edfb96 path-walk: support wildcard pathspecs for blob filtering
     @@ Commit message
          "d/file.*.txt" are useful for narrowing which blobs to process (e.g.,
          during 'git backfill').
      
     -    Support wildcard pathspecs by making three changes:
     +    Support wildcard pathspecs by making two changes:
      
           1. Add an 'exact_pathspecs' flag to path_walk_context. When the
              pathspec has no wildcards or magic, set this flag and use the
     @@ Commit message
              wildcards are present, skip that block since prefix matching
              cannot handle glob patterns.
      
     -     2. Disable revision-level commit pruning (revs->prune = 0) for
     -        wildcard pathspecs. The revision walk uses the pathspec to filter
     -        commits via TREESAME detection. For exact prefix pathspecs this
     -        works well, but wildcard pathspecs may fail to match through
     -        TREESAME because fnmatch with WM_PATHNAME does not cross directory
     -        boundaries. Disabling pruning ensures all commits are visited and
     -        their trees are available for the path-walk to filter.
     -
     -     3. Add a match_pathspec() check in walk_path() to filter out blobs
     +     2. Add a match_pathspec() check in walk_path() to filter out blobs
              whose full path does not match the pathspec. This provides the
              actual blob-level filtering for wildcard pathspecs.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
     -    Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
      
       ## path-walk.c ##
      @@ path-walk.c: struct path_walk_context {
     @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
      -		 * Clear any wildcard or magic pathspecs to avoid
      -		 * incorrect prefix matching.
      -		 */
     - 		struct pathspec *pd = &ctx.revs->prune_data;
     - 
     --		if (pd->has_wildcard || pd->magic)
     --			pd->nr = 0;
     -+		if (!pd->has_wildcard && !pd->magic)
     +-		if (ctx.revs->prune_data.has_wildcard ||
     +-		    ctx.revs->prune_data.magic)
     +-			clear_pathspec(&ctx.revs->prune_data);
     ++		if (!ctx.revs->prune_data.has_wildcard &&
     ++		    !ctx.revs->prune_data.magic)
      +			ctx.exact_pathspecs = 1;
     -+		else
     -+			ctx.revs->prune = 0;
       	}
       
       	/* Insert a single list for the root tree into the paths. */
 -:  ---------- > 6:  9699650aa7 t5620: test backfill's unknown argument handling

-- 
gitgitgadget
