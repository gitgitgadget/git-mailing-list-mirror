Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB5B4C901D
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097976; cv=none; b=A0TxruS3Le0Xeh4IsHTtqk87C/NPUJ0J87Cpd5uk1xeA4ovNaygqA2jkysZVGmOVSJzRjDEbBdGINa5QCmNsMk5Z+xAhxtrs3pI3oDjULMRG8cV3bX3hyUdJufzmag71gVTXHrDK+B9H52958wJqOAv1FUBYN+jxq+1JJhVbyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097976; c=relaxed/simple;
	bh=a2BBE6oh35FiOBFGAimNQwzNv+/Bzd1PbVLoxPoOD5c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cBrTY0/ka81oyFcEDHVNbXPqgvW66vuweWXQmRLLLmaDmRVmYm9azu2fWCdPaE5vDcYQjuBtTalE50AqekxIEQwbBHjfCmsn9P5yP2fuZdXreDAVBgUMsS35LSBG7KQHBwmdAn87FuYn+EgiR3yaZzYiRjMJGG2wtWF8uOq8IqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWihS5MX; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWihS5MX"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b720bb90d0so1080966eec.0
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 08:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097961; x=1769702761; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHIdmJNkZBKQO2CuBXhZx4GXBttFU5GJ+MgmGcw6+j0=;
        b=cWihS5MXlvS1Mh4l5ZkpSiySxeNmoVrYEsFUyntYbFA5G3abh8h1/vhZZFbKKQhegZ
         btRLGFH9SORTU1AHzvrZfbSDxeR2JXHrrRTyIh3RKzCCWGS386p10lqQrbSOfRqknlH9
         dE0qYyAgoHXTWpqRXKE8SPZQ3uJ65P0VRkX3uFlpGQ5q5zSr/idb8hOlEnu9IYDQ/D9p
         YBx8Ro82KNVjLTj8UL+8dId2U5JH4oEyGIsDw6kQNbp/hvwMvbBx02k+cZZBflx/zn07
         0IMP4Fe6g5xUJ8AhmvPnEoFfPVdg22+nHQWE0L5/oVBAauirzrQWK+6ggBLHYzi9GZCg
         HxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097961; x=1769702761;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YHIdmJNkZBKQO2CuBXhZx4GXBttFU5GJ+MgmGcw6+j0=;
        b=YTSWVfgMHD8fp2F5M/5rASYkvOT7s/8MEb+bwlGjKFlt3wZR5BMEFC8HmT1C9/0V5t
         m/1+jxAuoLPaNFjkFnU+xcgx0Xwmh6kwuH4VaFqsKRnElmu0YtSpbhHvuYS1bxC4xbQk
         gY8TGKl0WT9m6NpucFq3kDj6B0WNddJ7SVpynhFYKmt9N47RdxTEkS7wsNUiMBCTD8Ci
         DfxTOG/n7uUZ5Yg8gz46xw1aELX5tszC/Yit++F/WvI1ooVTNR3AWNjtypWqKw8mhWxj
         wHMcBJSFwt05tajlCqPRzVfcjhYkcpsorIgHwiYJPio2T1x6QIZsSQMT3BXc4yLRdfcb
         iT3g==
X-Gm-Message-State: AOJu0YwNa1lQu2gl1ejtl3vK+j3pgax+nWC9F3q3D4JRgNWBHrC0N1l1
	zUjmjiAjhVSLqV9NDbHNru7tW9yc0bO/22m7IMvz8ZP0HrdtpLLgzEjXS6ABjQ==
X-Gm-Gg: AZuq6aK9xFX/cA1FBp4nneuRZuwZGgu65H9p/Vm1AnrP5/PTxMrtnwogv+EZ+mlWQjc
	ewmEl11Dn2nAcOWQI554BQOkMuRituv4RYjL/bJ9m2maID1iNoKt5s/Te7CksEqHYXcjgjyTsZA
	LkEtGj3/Iwd4TUnZ45LYPfNtqNsBByfsH4PD3TiC9CUSNZNOeMM9ysdr3R1mbDaRrAsRm4bZbV8
	NIUXoPaY5OPDmtfID5R9flgXg5Jkg+kTUebSAcjo9rjtWKCVd6o8z7MxmwjCo7vxXQqgw/N3wT/
	EaNeCmqJ1DDa1fFIY8id0BPFIbTEnMTN+vttdh8Bl1NQe8nZ5AJPY3VQdWYm2T+iY8F9F0wur3m
	a+qUnvwqc2gaeWBx2G1NXNKVI0i7lqEDBo+CnJUCKh7wtZcq7LefJTrQrM+2VrF06deetoVWpNn
	+fT4ag5NbaYp94
X-Received: by 2002:a05:7300:3b06:b0:2b7:35c8:32cf with SMTP id 5a478bee46e88-2b735c839cdmr489608eec.28.1769097960381;
        Thu, 22 Jan 2026 08:06:00 -0800 (PST)
Received: from [127.0.0.1] ([52.160.166.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7081418f3sm9474179eec.34.2026.01.22.08.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:05:59 -0800 (PST)
Message-Id: <pull.2032.v2.git.1769097958549.gitgitgadget@gmail.com>
In-Reply-To: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Jan 2026 16:05:58 +0000
Subject: [PATCH v2] revision: add --maximal-only option
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
    Johannes Sixt <j6t@kdbg.org>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When inspecting a range of commits from some set of starting references, it
is sometimes useful to learn which commits are not reachable from any other
commits in the selected range.

One such application is in the creation of a sequence of bundles for the
bundle URI feature. Creating a stack of bundles representing different
slices of time includes defining which references to include. If all
references are used, then this may be overwhelming or redundant. Instead,
selecting commits that are maximal to the range could help defining a
smaller reference set to use in the bundle header.

Add a new '--maximal-only' option to restrict the output of a revision range
to be only the commits that are not reachable from any other commit in the
range, based on the reachability definition of the walk.

This is accomplished by adding a new 28th bit flag, CHILD_VISITED, that is
set as we walk. This does extend the bit range in object.h, but using an
earlier bit may collide with another feature.

The tests demonstrate the behavior of the feature with a positive-only
range, ranges with negative references, and walk-modifying flags like
--first-parent and --exclude-first-parent-only.

Since the --boundary option would not increase any results when used with
the --maximal-only option, mark them as incompatible.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    revision: add --maximal-only option
    
    My motivation for this feature is very similar to the bundle URI
    application. I can get around it by creating a tool that uses git
    rev-list --parents and then uses a hashset to collect the parent list
    and filter out any commits that ever appear as parents. It would be more
    efficient to use Git's native revision-walking feature.
    
    This does bring the object struct up to a 32-bit boundary with 28 flag
    bits, 3 type bits, and a parsed bit. That's the biggest concern I have
    about this update adding a new flag bit. I would understand if this
    feature is not worth running out of room for extensions there.
    
    I considered looking through the earlier bit positions to see the impact
    of an overlap, but they certainly looked potentially risky to reuse.
    
    I wonder if anyone else has thought about this as a useful technique.
    For instance, it could be part of a strategy for choosing commits for
    reachability bitmaps.
    
    
    Updates in v2
    =============
    
     * option is now called --maximal-only.
     * Documentation is moved within the commit-filtering options not the
       walk-altering options.
     * --boundary and --maximal-only are marked as incompatible.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2032%2Fderrickstolee%2Fmaximal-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2032/derrickstolee/maximal-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2032

Range-diff vs v1:

 1:  889a2737bc ! 1:  54fbf36a1f revision: add --maximal option
     @@ Metadata
      Author: Derrick Stolee <stolee@gmail.com>
      
       ## Commit message ##
     -    revision: add --maximal option
     +    revision: add --maximal-only option
      
          When inspecting a range of commits from some set of starting references, it
          is sometimes useful to learn which commits are not reachable from any other
     @@ Commit message
          selecting commits that are maximal to the range could help defining a
          smaller reference set to use in the bundle header.
      
     -    Add a new '--maximal' option to restrict the output of a revision range to
     -    be only the commits that are not reachable from any other commit in the
     +    Add a new '--maximal-only' option to restrict the output of a revision range
     +    to be only the commits that are not reachable from any other commit in the
          range, based on the reachability definition of the walk.
      
          This is accomplished by adding a new 28th bit flag, CHILD_VISITED, that is
     @@ Commit message
          range, ranges with negative references, and walk-modifying flags like
          --first-parent and --exclude-first-parent-only.
      
     +    Since the --boundary option would not increase any results when used with
     +    the --maximal-only option, mark them as incompatible.
     +
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/rev-list-options.adoc ##
     -@@ Documentation/rev-list-options.adoc: The following options affect the way the simplification is performed:
     - 	times; if so, a commit is included if it is any of the commits
     - 	given or if it is an ancestor or descendant of one of them.
     +@@ Documentation/rev-list-options.adoc: endif::git-log[]
     + 	from the point where it diverged from the remote branch, given
     + 	that arbitrary merges can be valid topic branch changes.
       
     -+`--maximal`::
     ++`--maximal-only`::
      +	Restrict the output commits to be those that are not reachable
      +	from any other commits in the revision range.
      +
     - A more detailed explanation follows.
     - 
     - Suppose you specified `foo` as the _<paths>_.  We shall call commits
     + `--not`::
     + 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
     + 	for all following revision specifiers, up to the next `--not`.
      
       ## object.h ##
      @@ object.h: void object_array_init(struct object_array *array);
     @@ revision.c: static int process_parents(struct rev_info *revs, struct commit *com
       			p->object.flags |= (SEEN | NOT_USER_GIVEN);
       			if (list)
      @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
     + 	} else if ((argcount = parse_long_opt("until", argv, &optarg))) {
     + 		revs->min_age = approxidate(optarg);
     + 		return argcount;
     ++	} else if (!strcmp(arg, "--maximal-only")) {
     ++		revs->maximal_only = 1;
     + 	} else if (!strcmp(arg, "--first-parent")) {
       		revs->first_parent_only = 1;
       	} else if (!strcmp(arg, "--exclude-first-parent-only")) {
     - 		revs->exclude_first_parent_only = 1;
     -+	} else if (!strcmp(arg, "--maximal")) {
     -+		revs->maximal = 1;
     - 	} else if (!strcmp(arg, "--ancestry-path")) {
     - 		revs->ancestry_path = 1;
     - 		revs->simplify_history = 0;
     +@@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
     + 				  !!revs->reverse, "--reverse",
     + 				  !!revs->reflog_info, "--walk-reflogs");
     + 
     ++	die_for_incompatible_opt2(!!revs->boundary, "--boundary",
     ++				  !!revs->maximal_only, "--maximal-only");
     ++
     + 	if (revs->no_walk && revs->graph)
     + 		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
     + 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
      @@ revision.c: enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
       {
       	if (commit->object.flags & SHOWN)
       		return commit_ignore;
     -+	if (revs->maximal && (commit->object.flags & CHILD_VISITED))
     ++	if (revs->maximal_only && (commit->object.flags & CHILD_VISITED))
      +		return commit_ignore;
       	if (revs->unpacked && has_object_pack(revs->repo, &commit->object.oid))
       		return commit_ignore;
     @@ revision.h
       #define DECORATE_SHORT_REFS	1
       #define DECORATE_FULL_REFS	2
      @@ revision.h: struct rev_info {
     - 			cherry_mark:1,
     - 			bisect:1,
     - 			ancestry_path:1,
     -+			maximal:1,
     + 			left_right:1,
     + 			left_only:1,
     + 			right_only:1,
     ++			maximal_only:1,
     + 			rewrite_parents:1,
     + 			print_parents:1,
     + 			show_decorations:1,
     +
     + ## t/t6000-rev-list-misc.sh ##
     +@@ t/t6000-rev-list-misc.sh: test_expect_success 'rev-list -z --boundary' '
     + 	test_cmp expect actual
     + '
       
     - 			/* True if --ancestry-path was specified without an
     - 			 * argument. The bottom revisions are implicitly
     ++test_expect_success 'rev-list --boundary incompatible with --maximal-only' '
     ++	test_when_finished rm -rf repo &&
     ++
     ++	git init repo &&
     ++	test_commit -C repo 1 &&
     ++	test_commit -C repo 2 &&
     ++
     ++	oid1=$(git -C repo rev-parse HEAD~) &&
     ++	oid2=$(git -C repo rev-parse HEAD) &&
     ++
     ++	test_must_fail git -C repo rev-list --boundary --maximal-only \
     ++		HEAD~1..HEAD 2>err &&
     ++	test_grep "cannot be used together" err
     ++'
     ++
     + test_done
      
       ## t/t6600-test-reach.sh ##
      @@ t/t6600-test-reach.sh: test_expect_success 'for-each-ref is-base: --sort' '
       		--sort=refname --sort=-is-base:commit-2-3
       '
       
     -+test_expect_success 'rev-list --maximal (all positive)' '
     ++test_expect_success 'rev-list --maximal-only (all positive)' '
      +	# Only one maximal.
      +	cat >input <<-\EOF &&
      +	refs/heads/commit-1-1
     @@ t/t6600-test-reach.sh: test_expect_success 'for-each-ref is-base: --sort' '
      +	cat >expect <<-EOF &&
      +	$(git rev-parse refs/heads/commit-8-4)
      +	EOF
     -+	run_all_modes git rev-list --maximal --stdin &&
     ++	run_all_modes git rev-list --maximal-only --stdin &&
      +
      +	# All maximal.
      +	cat >input <<-\EOF &&
     @@ t/t6600-test-reach.sh: test_expect_success 'for-each-ref is-base: --sort' '
      +	$(git rev-parse refs/heads/commit-3-4)
      +	$(git rev-parse refs/heads/commit-2-5)
      +	EOF
     -+	run_all_modes git rev-list --maximal --stdin &&
     ++	run_all_modes git rev-list --maximal-only --stdin &&
      +
      +	# Mix of both.
      +	cat >input <<-\EOF &&
     @@ t/t6600-test-reach.sh: test_expect_success 'for-each-ref is-base: --sort' '
      +	$(git rev-parse refs/heads/commit-5-2)
      +	$(git rev-parse refs/heads/commit-2-5)
      +	EOF
     -+	run_all_modes git rev-list --maximal --stdin
     ++	run_all_modes git rev-list --maximal-only --stdin
      +'
      +
     -+test_expect_success 'rev-list --maximal (range)' '
     ++test_expect_success 'rev-list --maximal-only (range)' '
      +	cat >input <<-\EOF &&
      +	refs/heads/commit-1-1
      +	refs/heads/commit-2-5
     @@ t/t6600-test-reach.sh: test_expect_success 'for-each-ref is-base: --sort' '
      +	cat >expect <<-EOF &&
      +	$(git rev-parse refs/heads/commit-6-4)
      +	EOF
     -+	run_all_modes git rev-list --maximal --stdin &&
     ++	run_all_modes git rev-list --maximal-only --stdin &&
      +
      +	# first-parent changes reachability: the first parent
      +	# reduces the second coordinate to 1 before reducing the
     @@ t/t6600-test-reach.sh: test_expect_success 'for-each-ref is-base: --sort' '
      +	$(git rev-parse refs/heads/commit-6-4)
      +	$(git rev-parse refs/heads/commit-2-5)
      +	EOF
     -+	run_all_modes git rev-list --maximal --stdin \
     ++	run_all_modes git rev-list --maximal-only --stdin \
      +		--first-parent --exclude-first-parent-only
      +'
      +


 Documentation/rev-list-options.adoc |  4 ++
 object.h                            |  4 +-
 revision.c                          | 12 ++++-
 revision.h                          |  5 +-
 t/t6000-rev-list-misc.sh            | 15 ++++++
 t/t6600-test-reach.sh               | 75 +++++++++++++++++++++++++++++
 6 files changed, 110 insertions(+), 5 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 453ec59057..a39cf88bbc 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -148,6 +148,10 @@ endif::git-log[]
 	from the point where it diverged from the remote branch, given
 	that arbitrary merges can be valid topic branch changes.
 
+`--maximal-only`::
+	Restrict the output commits to be those that are not reachable
+	from any other commits in the revision range.
+
 `--not`::
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
 	for all following revision specifiers, up to the next `--not`.
diff --git a/object.h b/object.h
index 4bca957b8d..dfe7a1f0ea 100644
--- a/object.h
+++ b/object.h
@@ -64,7 +64,7 @@ void object_array_init(struct object_array *array);
 
 /*
  * object flag allocation:
- * revision.h:               0---------10         15               23------27
+ * revision.h:               0---------10         15               23--------28
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
@@ -86,7 +86,7 @@ void object_array_init(struct object_array *array);
  * builtin/unpack-objects.c:                                 2021
  * pack-bitmap.h:                                              2122
  */
-#define FLAG_BITS  28
+#define FLAG_BITS  29
 
 #define TYPE_BITS 3
 
diff --git a/revision.c b/revision.c
index 1858e093ee..2dee78b838 100644
--- a/revision.c
+++ b/revision.c
@@ -1150,7 +1150,8 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			struct commit *p = parent->item;
 			parent = parent->next;
 			if (p)
-				p->object.flags |= UNINTERESTING;
+				p->object.flags |= UNINTERESTING |
+						   CHILD_VISITED;
 			if (repo_parse_commit_gently(revs->repo, p, 1) < 0)
 				continue;
 			if (p->parents)
@@ -1204,7 +1205,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			if (!*slot)
 				*slot = *revision_sources_at(revs->sources, commit);
 		}
-		p->object.flags |= pass_flags;
+		p->object.flags |= pass_flags | CHILD_VISITED;
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= (SEEN | NOT_USER_GIVEN);
 			if (list)
@@ -2377,6 +2378,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if ((argcount = parse_long_opt("until", argv, &optarg))) {
 		revs->min_age = approxidate(optarg);
 		return argcount;
+	} else if (!strcmp(arg, "--maximal-only")) {
+		revs->maximal_only = 1;
 	} else if (!strcmp(arg, "--first-parent")) {
 		revs->first_parent_only = 1;
 	} else if (!strcmp(arg, "--exclude-first-parent-only")) {
@@ -3147,6 +3150,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				  !!revs->reverse, "--reverse",
 				  !!revs->reflog_info, "--walk-reflogs");
 
+	die_for_incompatible_opt2(!!revs->boundary, "--boundary",
+				  !!revs->maximal_only, "--maximal-only");
+
 	if (revs->no_walk && revs->graph)
 		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
@@ -4125,6 +4131,8 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 {
 	if (commit->object.flags & SHOWN)
 		return commit_ignore;
+	if (revs->maximal_only && (commit->object.flags & CHILD_VISITED))
+		return commit_ignore;
 	if (revs->unpacked && has_object_pack(revs->repo, &commit->object.oid))
 		return commit_ignore;
 	if (revs->no_kept_objects) {
diff --git a/revision.h b/revision.h
index b36acfc2d9..69242ecb18 100644
--- a/revision.h
+++ b/revision.h
@@ -52,7 +52,9 @@
 #define NOT_USER_GIVEN	(1u<<25)
 #define TRACK_LINEAR	(1u<<26)
 #define ANCESTRY_PATH	(1u<<27)
-#define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR | PULL_MERGE)
+#define CHILD_VISITED	(1u<<28)
+#define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR \
+				      | PULL_MERGE | CHILD_VISITED)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
@@ -189,6 +191,7 @@ struct rev_info {
 			left_right:1,
 			left_only:1,
 			right_only:1,
+			maximal_only:1,
 			rewrite_parents:1,
 			print_parents:1,
 			show_decorations:1,
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index fec16448cf..d0a2a86610 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -248,4 +248,19 @@ test_expect_success 'rev-list -z --boundary' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-list --boundary incompatible with --maximal-only' '
+	test_when_finished rm -rf repo &&
+
+	git init repo &&
+	test_commit -C repo 1 &&
+	test_commit -C repo 2 &&
+
+	oid1=$(git -C repo rev-parse HEAD~) &&
+	oid2=$(git -C repo rev-parse HEAD) &&
+
+	test_must_fail git -C repo rev-list --boundary --maximal-only \
+		HEAD~1..HEAD 2>err &&
+	test_grep "cannot be used together" err
+'
+
 test_done
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 6638d1aa1d..2613075894 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -762,4 +762,79 @@ test_expect_success 'for-each-ref is-base: --sort' '
 		--sort=refname --sort=-is-base:commit-2-3
 '
 
+test_expect_success 'rev-list --maximal-only (all positive)' '
+	# Only one maximal.
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-4-2
+	refs/heads/commit-4-4
+	refs/heads/commit-8-4
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse refs/heads/commit-8-4)
+	EOF
+	run_all_modes git rev-list --maximal-only --stdin &&
+
+	# All maximal.
+	cat >input <<-\EOF &&
+	refs/heads/commit-5-2
+	refs/heads/commit-4-3
+	refs/heads/commit-3-4
+	refs/heads/commit-2-5
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse refs/heads/commit-5-2)
+	$(git rev-parse refs/heads/commit-4-3)
+	$(git rev-parse refs/heads/commit-3-4)
+	$(git rev-parse refs/heads/commit-2-5)
+	EOF
+	run_all_modes git rev-list --maximal-only --stdin &&
+
+	# Mix of both.
+	cat >input <<-\EOF &&
+	refs/heads/commit-5-2
+	refs/heads/commit-3-2
+	refs/heads/commit-2-5
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse refs/heads/commit-5-2)
+	$(git rev-parse refs/heads/commit-2-5)
+	EOF
+	run_all_modes git rev-list --maximal-only --stdin
+'
+
+test_expect_success 'rev-list --maximal-only (range)' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-2-5
+	refs/heads/commit-6-4
+	^refs/heads/commit-4-5
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse refs/heads/commit-6-4)
+	EOF
+	run_all_modes git rev-list --maximal-only --stdin &&
+
+	# first-parent changes reachability: the first parent
+	# reduces the second coordinate to 1 before reducing the
+	# first coordinate.
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-2-5
+	refs/heads/commit-6-4
+	^refs/heads/commit-4-5
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse refs/heads/commit-6-4)
+	$(git rev-parse refs/heads/commit-2-5)
+	EOF
+	run_all_modes git rev-list --maximal-only --stdin \
+		--first-parent --exclude-first-parent-only
+'
+
 test_done

base-commit: b5c409c40f1595e3e590760c6f14a16b6683e22c
-- 
gitgitgadget
