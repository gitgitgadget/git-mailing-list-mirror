Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF871339B8
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608118; cv=none; b=LewwXP3OqBGtSbWI6kOdq8DX+NQ2czIrOGCldugg013GJz7hkpIg1t1t3PWICkH9XhIWhH7WGsx8gmHKlcfN6l7z+yO6TevQmBnolMV9xK5R9ictuf5ooikq7g/OxyOQavJCMGeZj3VRMdv35EFrPaD89qVvlgu/q3S7YzlNIEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608118; c=relaxed/simple;
	bh=CRu7dk3RPZpuuSQLt92YZSKmpj5oDeAMCw9Ol2pcFnA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cGUiu9kWvS6Vpugf3X4ThRhx6DleVjaVgziwO5d6nwoki4JrVbwaChmFQnoQFn9rOU9T5iXiMLQN31USLdm08Pe9ITlf6skGoc1jnZrC2tRTPBn1xusrGpsCVfQmlMqzrZp1FH/7txAWAJmRnzePcjs2awHG+5BMj0pCVQS8AvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIwxjJBd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIwxjJBd"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4128f3eea18so103135e9.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 05:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708608113; x=1709212913; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D50Q7R+euCNOeXtQmdiHOoEYcsiGynNflu/bTavn4r8=;
        b=hIwxjJBdHGv0QSvv2/tZzuXkuArOO7WkYgHRMz+chUacBobKb0tg9jrpKpRcUVXmyb
         Wm6kB/ydBjFVOP4ovYk0XSLBRwvR0VHqP2hdjc0Sp9w3Wdfz2nfOvVRyV45cdhXbkVqF
         /gm5Uu127XWNlzw5RHdGwcfYsnTJaj29iaJQ9cMzUEiuKiFMbOvXfnFbLJvCdsTQco6A
         wAkrQBlBXhVi4IfHLpzdh6HGlGERZlOIbnGyN5Zy8FuXq+Jac40D1UqVRSnlV4EvYEZM
         VhFWlqxyldrltXi+eFg7e3zxXRVNc90GcAziKv1uHMiDABeIwyyT/NkveBuVIwDD7Uuy
         i2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608113; x=1709212913;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D50Q7R+euCNOeXtQmdiHOoEYcsiGynNflu/bTavn4r8=;
        b=S5owWGZMp/rakdRuyLOMMMOF/uf/p/7fZeRF2y3nFDntsrNH08xq1P434HZA2Ijuk3
         GrNEjYWt6qjXEwZ3udTLbHOS8qmIV+lKZMHnzKYlkFABS8JwY9S+Qq3etIrkTTVoLp7M
         iy24mn8/x4I9vgbFZ12Gy6hpTlFMoEJxwID2xdcMpihFG7zSWiArA1Ps7gOhwUgX8qoh
         KUN/OIyNjXfCPoXBp5ziRu1aIDNH8nnFLTKW6s+7mT3PP5zWhNOi2vSA2bZPnovHGryV
         qa36zHAP6mi73rk1dQdt39J2/O/D8uAZH6AkqekFdp+tk/aoJX62N3fm2Ko5g1nxGGRw
         kaog==
X-Gm-Message-State: AOJu0YwVmu9/2awiL1Udl+9ZoUQVNlDGxO3ytpEWniMeHy8PTWpqZAWk
	57/ZzLmFP/ugYAlf3gQoC+ElfSSwpClC5TCishQ327pJ9GKnrppvSiNEsUNM
X-Google-Smtp-Source: AGHT+IH2ZpeSmepHDSAMRgILsigKuaRfpDCSV3vjfmW1ZESj8698hm2zFl05/VzP7LNDYf+4CXGlOQ==
X-Received: by 2002:a05:600c:1c1d:b0:412:5757:e87e with SMTP id j29-20020a05600c1c1d00b004125757e87emr11008389wms.31.1708608112790;
        Thu, 22 Feb 2024 05:21:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d660f000000b0033b1b1da2adsm20230111wru.99.2024.02.22.05.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:21:52 -0800 (PST)
Message-ID: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 13:21:39 +0000
Subject: [PATCH v2 00/11] The merge-base logic vs missing commit objects
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
    Johannes Schindelin <johannes.schindelin@gmx.de>

This patch series is in the same spirit as what I proposed in
https://lore.kernel.org/git/pull.1651.git.1707212981.gitgitgadget@gmail.com/,
where I tackled missing tree objects. This here patch series tackles missing
commit objects instead: Git's merge-base logic handles these missing commit
objects as if there had not been any commit object at all, i.e. if two
commits' merge base commit is missing, they will be treated as if they had
no common commit history at all, which is a bug. Those commit objects should
not be missing, of course, i.e. this is only a problem in corrupt
repositories.

This patch series is a bit more tricky than the "missing tree objects" one,
though: The function signature of quite a few functions need to be changed
to allow callers to discern between "missing commit object" vs "no
merge-base found".

And of course it gets even more tricky because in shallow and partial clones
we expect commit objects to be missing, and that must not be treated like an
error but the existing logic is actually desirable in those scenarios.

I am deeply sorry both about the length of this patch series as well as
having to lean so heavily on reviews on the Git mailing list.

Changes since v1:

 * Addressed a lot of memory leaks.
 * Reordered patch 2 and 3 to render the commit message's comment about
   unchanged behavior true.
 * Fixed the incorrectly converted condition in the merge_submodule()
   function.
 * The last patch ("paint_down_to_common(): special-case shallow/partial
   clones") was dropped because it is not actually necessary, and the
   explanation for that was added to the commit message of "Prepare
   paint_down_to_common() for handling shallow commits".
 * An inconsistently-named variable i was renamed to be consistent with the
   other variables called ret.

Johannes Schindelin (11):
  paint_down_to_common: plug two memory leaks
  Prepare `repo_in_merge_bases_many()` to optionally expect missing
    commits
  Start reporting missing commits in `repo_in_merge_bases_many()`
  Prepare `paint_down_to_common()` for handling shallow commits
  commit-reach: start reporting errors in `paint_down_to_common()`
  merge_bases_many(): pass on errors from `paint_down_to_common()`
  get_merge_bases_many_0(): pass on errors from `merge_bases_many()`
  repo_get_merge_bases(): pass on errors from `merge_bases_many()`
  get_octopus_merge_bases(): pass on errors from `merge_bases_many()`
  repo_get_merge_bases_many(): pass on errors from `merge_bases_many()`
  repo_get_merge_bases_many_dirty(): pass on errors from
    `merge_bases_many()`

 bisect.c                         |   7 +-
 builtin/branch.c                 |  12 +-
 builtin/fast-import.c            |   6 +-
 builtin/fetch.c                  |   2 +
 builtin/log.c                    |  30 +++--
 builtin/merge-base.c             |  23 +++-
 builtin/merge-tree.c             |   5 +-
 builtin/merge.c                  |  26 ++--
 builtin/pull.c                   |   9 +-
 builtin/rebase.c                 |   8 +-
 builtin/receive-pack.c           |   6 +-
 builtin/rev-parse.c              |   5 +-
 commit-reach.c                   | 209 ++++++++++++++++++++-----------
 commit-reach.h                   |  26 ++--
 commit.c                         |   7 +-
 diff-lib.c                       |   5 +-
 http-push.c                      |   5 +-
 log-tree.c                       |   5 +-
 merge-ort.c                      |  87 +++++++++++--
 merge-recursive.c                |  58 +++++++--
 notes-merge.c                    |   3 +-
 object-name.c                    |   7 +-
 remote.c                         |   2 +-
 revision.c                       |  12 +-
 sequencer.c                      |   8 +-
 shallow.c                        |  21 ++--
 submodule.c                      |   7 +-
 t/helper/test-reach.c            |  11 +-
 t/t4301-merge-tree-write-tree.sh |  12 ++
 29 files changed, 441 insertions(+), 183 deletions(-)


base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1657%2Fdscho%2Fmerge-base-and-missing-objects-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1657/dscho/merge-base-and-missing-objects-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1657

Range-diff vs v1:

  1:  818eef0a644 !  1:  6e4e409cd43 paint_down_to_common: plug a memory leak
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    paint_down_to_common: plug a memory leak
     +    paint_down_to_common: plug two memory leaks
      
          When a commit is missing, we return early (currently pretending that no
          merge basis could be found in that case). At that stage, it is possible
          that a merge base could have been found already, and added to the
          `result`, which is now leaked.
      
     -    Let's release it, to address that memory leak.
     +    The priority queue has a similar issue: There might still be a commit in
     +    that queue.
     +
     +    Let's release both, to address the potential memory leaks.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ commit-reach.c: static struct commit_list *paint_down_to_common(struct repositor
       				continue;
      -			if (repo_parse_commit(r, p))
      +			if (repo_parse_commit(r, p)) {
     ++				clear_prio_queue(&queue);
      +				free_commit_list(result);
       				return NULL;
      +			}
  3:  8395c3efbc3 !  2:  5c16becfb9b Prepare `repo_in_merge_bases_many()` to optionally expect missing commits
     @@ commit-reach.c: int repo_is_descendant_of(struct repository *r,
       
       			other = with_commit->item;
       			with_commit = with_commit->next;
     --			ret = repo_in_merge_bases_many(r, other, 1, &commit);
     -+			ret = repo_in_merge_bases_many(r, other, 1, &commit, 0);
     - 			if (ret)
     - 				return ret;
     +-			if (repo_in_merge_bases_many(r, other, 1, &commit))
     ++			if (repo_in_merge_bases_many(r, other, 1, &commit, 0))
     + 				return 1;
       		}
     + 		return 0;
      @@ commit-reach.c: int repo_is_descendant_of(struct repository *r,
        * Is "commit" an ancestor of one of the "references"?
        */
     @@ commit-reach.c: int repo_is_descendant_of(struct repository *r,
       {
       	struct commit_list *bases;
       	int ret = 0, i;
     - 	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
     - 
     - 	if (repo_parse_commit(r, commit))
     --		return -1;
     -+		return ignore_missing_commits ? 0 : -1;
     - 	for (i = 0; i < nr_reference; i++) {
     - 		if (repo_parse_commit(r, reference[i]))
     --			return -1;
     -+			return ignore_missing_commits ? 0 : -1;
     - 
     - 		generation = commit_graph_generation(reference[i]);
     - 		if (generation > max_generation)
      
       ## commit-reach.h ##
      @@ commit-reach.h: int repo_in_merge_bases(struct repository *r,
     @@ remote.c: static int is_reachable_in_reflog(const char *local, const struct ref
       ## shallow.c ##
      @@ shallow.c: static void post_assign_shallow(struct shallow_info *info,
       		for (j = 0; j < bitmap_nr; j++)
     - 			if (bitmap[0][j]) {
     - 				/* Step 7, reachability test at commit level */
     --				int ret = repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits);
     -+				int ret = repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits, 1);
     - 				if (ret < 0)
     - 					exit(128);
     - 				if (!ret) {
     + 			if (bitmap[0][j] &&
     + 			    /* Step 7, reachability test at commit level */
     +-			    !repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits)) {
     ++			    !repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits, 1)) {
     + 				update_refstatus(ref_status, info->ref->nr, *bitmap);
     + 				dst++;
     + 				break;
      @@ shallow.c: int delayed_reachability_test(struct shallow_info *si, int c)
       		si->reachable[c] = repo_in_merge_bases_many(the_repository,
       							    commit,
     @@ shallow.c: int delayed_reachability_test(struct shallow_info *si, int c)
      -							    si->commits);
      +							    si->commits,
      +							    1);
     - 		if (si->reachable[c] < 0)
     - 			exit(128);
       		si->need_reachability_test[c] = 0;
     + 	}
     + 	return si->reachable[c];
      
       ## t/helper/test-reach.c ##
      @@ t/helper/test-reach.c: int cmd__reach(int ac, const char **av)
  2:  5f0af7fc0b9 !  3:  4dd214f91d4 Let `repo_in_merge_bases()` report missing commits
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    Let `repo_in_merge_bases()` report missing commits
     +    Start reporting missing commits in `repo_in_merge_bases_many()`
      
          Some functions in Git's source code follow the convention that returning
          a negative value indicates a fatal error, e.g. repository corruption.
     @@ Commit message
          Also adjust the callers of `repo_in_merge_bases()` to handle such
          negative return values.
      
     +    Note: As of this patch, errors are returned only if any of the specified
     +    merge heads is missing. Over the course of the next patches, missing
     +    commits will also be reported by the `paint_down_to_common()` function,
     +    which is called by `repo_in_merge_bases_many()`, and those errors will
     +    be properly propagated back to the caller at that stage.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/branch.c ##
     @@ commit-reach.c: int repo_is_descendant_of(struct repository *r,
       
       			other = with_commit->item;
       			with_commit = with_commit->next;
     --			if (repo_in_merge_bases_many(r, other, 1, &commit))
     +-			if (repo_in_merge_bases_many(r, other, 1, &commit, 0))
      -				return 1;
     -+			ret = repo_in_merge_bases_many(r, other, 1, &commit);
     ++			ret = repo_in_merge_bases_many(r, other, 1, &commit, 0);
      +			if (ret)
      +				return ret;
       		}
     @@ commit-reach.c: int repo_in_merge_bases_many(struct repository *r, struct commit
       
       	if (repo_parse_commit(r, commit))
      -		return ret;
     -+		return -1;
     ++		return ignore_missing_commits ? 0 : -1;
       	for (i = 0; i < nr_reference; i++) {
       		if (repo_parse_commit(r, reference[i]))
      -			return ret;
     -+			return -1;
     ++			return ignore_missing_commits ? 0 : -1;
       
       		generation = commit_graph_generation(reference[i]);
       		if (generation > max_generation)
     @@ http-push.c: static int verify_merge_base(struct object_id *head_oid, struct ref
       	struct commit *head = lookup_commit_or_die(head_oid, "HEAD");
       	struct commit *branch = lookup_commit_or_die(&remote->old_oid,
       						     remote->name);
     -+	int i = repo_in_merge_bases(the_repository, branch, head);
     ++	int ret = repo_in_merge_bases(the_repository, branch, head);
       
      -	return repo_in_merge_bases(the_repository, branch, head);
     -+	if (i < 0)
     ++	if (ret < 0)
      +		exit(128);
     -+	return i;
     ++	return ret;
       }
       
       static int delete_remote_branch(const char *pattern, int force)
     @@ merge-ort.c: static int find_first_merges(struct repository *repo,
      -		if (repo_in_merge_bases(repo, b, commit))
      +		int ret = repo_in_merge_bases(repo, b, commit);
      +
     -+		if (ret < 0)
     ++		if (ret < 0) {
     ++			object_array_clear(&merges);
     ++			release_revisions(&revs);
      +			return ret;
     ++		}
      +		if (ret > 0)
       			add_object_array(o, NULL, &merges);
       	}
     @@ merge-ort.c: static int find_first_merges(struct repository *repo,
      -				break;
      +			if (i != j) {
      +				int ret = repo_in_merge_bases(repo, m2, m1);
     -+				if (ret < 0)
     ++				if (ret < 0) {
     ++					object_array_clear(&merges);
     ++					release_revisions(&revs);
      +					return ret;
     ++				}
      +				if (ret > 0) {
      +					contains_another = 1;
      +					break;
     @@ merge-ort.c: static int merge_submodule(struct merge_options *opt,
      -	if (!repo_in_merge_bases(&subrepo, commit_o, commit_a) ||
      -	    !repo_in_merge_bases(&subrepo, commit_o, commit_b)) {
      +	ret2 = repo_in_merge_bases(&subrepo, commit_o, commit_a);
     -+	if (ret2 < 1) {
     ++	if (ret2 < 0) {
      +		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
      +			 path, NULL, NULL, NULL,
      +			 _("Failed to merge submodule %s "
     @@ merge-ort.c: static int merge_submodule(struct merge_options *opt,
      +			 path);
      +		goto cleanup;
      +	}
     -+	if (!ret2)
     ++	if (ret2 > 0)
      +		ret2 = repo_in_merge_bases(&subrepo, commit_o, commit_b);
     -+	if (ret2 < 1) {
     ++	if (ret2 < 0) {
      +		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
      +			 path, NULL, NULL, NULL,
      +			 _("Failed to merge submodule %s "
     @@ merge-recursive.c: static int find_first_merges(struct repository *repo,
       		struct object *o = &(commit->object);
      -		if (repo_in_merge_bases(repo, b, commit))
      +		int ret = repo_in_merge_bases(repo, b, commit);
     -+		if (ret < 0)
     ++		if (ret < 0) {
     ++			object_array_clear(&merges);
     ++			release_revisions(&revs);
      +			return ret;
     ++		}
      +		if (ret)
       			add_object_array(o, NULL, &merges);
       	}
     @@ merge-recursive.c: static int find_first_merges(struct repository *repo,
      -				break;
      +			if (i != j) {
      +				int ret = repo_in_merge_bases(repo, m2, m1);
     -+				if (ret < 0)
     ++				if (ret < 0) {
     ++					object_array_clear(&merges);
     ++					release_revisions(&revs);
      +					return ret;
     ++				}
      +				if (ret > 0) {
      +					contains_another = 1;
      +					break;
     @@ merge-recursive.c: static int merge_submodule(struct merge_options *opt,
      +		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"), path);
      +		goto cleanup;
      +	}
     -+	if (ret2)
     ++	if (ret2 > 0)
      +		ret2 = repo_in_merge_bases(&subrepo, commit_base, commit_b);
      +	if (ret2 < 0) {
      +		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"), path);
     @@ shallow.c: static void post_assign_shallow(struct shallow_info *info,
       		for (j = 0; j < bitmap_nr; j++)
      -			if (bitmap[0][j] &&
      -			    /* Step 7, reachability test at commit level */
     --			    !repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits)) {
     +-			    !repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits, 1)) {
      -				update_refstatus(ref_status, info->ref->nr, *bitmap);
      -				dst++;
      -				break;
      +			if (bitmap[0][j]) {
      +				/* Step 7, reachability test at commit level */
     -+				int ret = repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits);
     ++				int ret = repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits, 1);
      +				if (ret < 0)
      +					exit(128);
      +				if (!ret) {
     @@ shallow.c: static void post_assign_shallow(struct shallow_info *info,
       	}
       	info->nr_ours = dst;
      @@ shallow.c: int delayed_reachability_test(struct shallow_info *si, int c)
     - 							    commit,
       							    si->nr_commits,
     - 							    si->commits);
     + 							    si->commits,
     + 							    1);
      +		if (si->reachable[c] < 0)
      +			exit(128);
       		si->need_reachability_test[c] = 0;
  4:  7477b18adeb !  4:  53bdeddb4cb Prepare `paint_down_to_common()` for handling shallow commits
     @@ Commit message
          able to handle this situation gracefully.
      
          Currently, that logic pretends that a missing parent commit is
     -    equivalent to a a missing parent commit, and for the purpose of
     +    equivalent to a missing parent commit, and for the purpose of
          `--update-shallow` that is exactly what we need it to do.
      
          Therefore, let's introduce a flag to indicate when that is precisely the
     @@ Commit message
          shallow root with receive.updateshallow on") and t5538.4 ("add new
          shallow root with receive.updateshallow on").
      
     +    Note: shallow commits' parents are set to `NULL` internally already,
     +    therefore there is no need to special-case shallow repositories here, as
     +    the merge-base logic will not try to access parent commits of shallow
     +    commits.
     +
     +    Likewise, partial clones aren't an issue either: If a commit is missing
     +    during the revision walk in the merge-base logic, it is fetched via
     +    `promisor_remote_get_direct()`. And not only the single missing commit
     +    object: Due to the way the "promised" objects are fetched (in
     +    `fetch_objects()` in `promisor-remote.c`, using `fetch
     +    --filter=blob:none`), there is no actual way to fetch a single commit
     +    object, as the remote side will pass that commit OID to `pack-objects
     +    --revs [...]` which in turn passes it to `rev-list` which interprets
     +    this as a commit _range_ instead of a single object. Therefore, in
     +    partial clones (unless they are shallow in addition), all commits
     +    reachable from a commit that is in the local object database are also
     +    present in that local database.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## commit-reach.c ##
     @@ commit-reach.c: static int queue_has_nonstale(struct prio_queue *queue)
       	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
       	struct commit_list *result = NULL;
      @@ commit-reach.c: static struct commit_list *paint_down_to_common(struct repository *r,
     - 			if ((p->object.flags & flags) == flags)
     - 				continue;
       			if (repo_parse_commit(r, p)) {
     + 				clear_prio_queue(&queue);
     + 				free_commit_list(result);
      +				/*
      +				 * At this stage, we know that the commit is
      +				 * missing: `repo_parse_commit()` uses
     @@ commit-reach.c: static struct commit_list *paint_down_to_common(struct repositor
      +				 * corrupt commits would already have been
      +				 * dispatched with a `die()`.
      +				 */
     - 				free_commit_list(result);
       				return NULL;
       			}
     + 			p->object.flags |= flags;
      @@ commit-reach.c: static struct commit_list *merge_bases_many(struct repository *r,
       			return NULL;
       	}
  5:  f8aedb89f1c !  5:  ec3ebf0ed17 commit-reach: start reporting errors in `paint_down_to_common()`
     @@ commit-reach.c: static struct commit_list *paint_down_to_common(struct repositor
       			}
       			/* Mark parents of a found merge stale */
       			flags |= STALE;
     +@@ commit-reach.c: static struct commit_list *paint_down_to_common(struct repository *r,
     + 				continue;
     + 			if (repo_parse_commit(r, p)) {
     + 				clear_prio_queue(&queue);
     +-				free_commit_list(result);
     ++				free_commit_list(*result);
     ++				*result = NULL;
     + 				/*
     + 				 * At this stage, we know that the commit is
     + 				 * missing: `repo_parse_commit()` uses
      @@ commit-reach.c: static struct commit_list *paint_down_to_common(struct repository *r,
       				 * corrupt commits would already have been
       				 * dispatched with a `die()`.
       				 */
     --				free_commit_list(result);
      -				return NULL;
     -+				free_commit_list(*result);
      +				if (ignore_missing_commits)
      +					return 0;
      +				return error(_("could not parse commit %s"),
     @@ commit-reach.c: static struct commit_list *merge_bases_many(struct repository *r
       	}
       
      -	list = paint_down_to_common(r, one, n, twos, 0, 0);
     -+	if (paint_down_to_common(r, one, n, twos, 0, 0, &list) < 0)
     ++	if (paint_down_to_common(r, one, n, twos, 0, 0, &list) < 0) {
     ++		free_commit_list(list);
      +		return NULL;
     ++	}
       
       	while (list) {
       		struct commit *commit = pop_commit(&list);
     @@ commit-reach.c: static int remove_redundant_no_gen(struct repository *r,
      -		common = paint_down_to_common(r, array[i], filled,
      -					      work, min_generation, 0);
      +		if (paint_down_to_common(r, array[i], filled,
     -+					 work, min_generation, 0, &common))
     ++					 work, min_generation, 0, &common)) {
     ++			clear_commit_marks(array[i], all_flags);
     ++			clear_commit_marks_many(filled, work, all_flags);
     ++			free_commit_list(common);
     ++			free(work);
     ++			free(redundant);
     ++			free(filled_index);
      +			return -1;
     ++		}
       		if (array[i]->object.flags & PARENT2)
       			redundant[i] = 1;
       		for (j = 0; j < filled; j++)
  6:  0aca08a2cb5 !  6:  05756fbf71a merge_bases_many(): pass on errors from `paint_down_to_common()`
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
      +				     oid_to_hex(&twos[i]->object.oid));
       	}
       
     - 	if (paint_down_to_common(r, one, n, twos, 0, 0, &list) < 0)
     + 	if (paint_down_to_common(r, one, n, twos, 0, 0, &list) < 0) {
     + 		free_commit_list(list);
      -		return NULL;
      +		return -1;
     + 	}
       
       	while (list) {
       		struct commit *commit = pop_commit(&list);
  7:  03734cc09da =  7:  e3d37a326e5 get_merge_bases_many_0(): pass on errors from `merge_bases_many()`
  8:  43c33e2eac4 !  8:  9ca504525b9 repo_get_merge_bases(): pass on errors from `merge_bases_many()`
     @@ object-name.c: int repo_get_oid_mb(struct repository *r,
       	if (!two)
       		return -1;
      -	mbs = repo_get_merge_bases(r, one, two);
     -+	if (repo_get_merge_bases(r, one, two, &mbs) < 0)
     ++	if (repo_get_merge_bases(r, one, two, &mbs) < 0) {
     ++		free_commit_list(mbs);
      +		return -1;
     ++	}
       	if (!mbs || mbs->next)
       		st = -1;
       	else {
     @@ revision.c: static int handle_dotdot_1(const char *arg, char *dotdot,
       			return dotdot_missing(arg, dotdot, revs, symmetric);
       
      -		exclude = repo_get_merge_bases(the_repository, a, b);
     -+		if (repo_get_merge_bases(the_repository, a, b, &exclude) < 0)
     ++		if (repo_get_merge_bases(the_repository, a, b, &exclude) < 0) {
     ++			free_commit_list(exclude);
      +			return -1;
     ++		}
       		add_rev_cmdline_list(revs, exclude, REV_CMD_MERGE_BASE,
       				     flags_exclude);
       		add_pending_commit_list(revs, exclude, flags_exclude);
  9:  7fbf660e371 !  9:  b11879edb73 get_octopus_merge_bases(): pass on errors from `merge_bases_many()`
     @@ builtin/merge-base.c: static int handle_independent(int count, const char **args
       		commit_list_insert(get_commit_reference(args[i]), &revs);
       
      -	result = get_octopus_merge_bases(revs);
     -+	if (get_octopus_merge_bases(revs, &result) < 0)
     ++	if (get_octopus_merge_bases(revs, &result) < 0) {
     ++		free_commit_list(revs);
     ++		free_commit_list(result);
      +		return 128;
     ++	}
       	free_commit_list(revs);
       	reduce_heads_replace(&result);
       
 10:  55757c3a35d = 10:  602a7383f72 repo_get_merge_bases_many(): pass on errors from `merge_bases_many()`
 11:  e7fcc96196c ! 11:  96850ed2d69 repo_get_merge_bases_many_dirty(): pass on errors from `merge_bases_many()`
     @@ builtin/merge-base.c
      -	result = repo_get_merge_bases_many_dirty(the_repository, rev[0],
      -						 rev_nr - 1, rev + 1);
      +	if (repo_get_merge_bases_many_dirty(the_repository, rev[0],
     -+					    rev_nr - 1, rev + 1, &result) < 0)
     ++					    rev_nr - 1, rev + 1, &result) < 0) {
     ++		free_commit_list(result);
      +		return -1;
     ++	}
       
       	if (!result)
       		return 1;
 12:  33894600ae7 <  -:  ----------- paint_down_to_common(): special-case shallow/partial clones

-- 
gitgitgadget
