Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B73185B48
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791711672; cv=none; b=OvQE/WL49VgU6+Mv4zYkJXP/WdQdvE25MZb7g7Qy+qIjTf5ttrOuVSYfQcGo/NorGm16ZFRkw+XLhzowIEvIs0epNsYwPdg2IL3LCDrkMbQLhD7lDzuVv7PrCId9I5VxMce2rPDv0VN/T/Ty4bpGySx6G48nkGGXU8vAJ4U5EpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791711672; c=relaxed/simple;
	bh=6gWGL2ukeS6lWWflYsAWKU4pugdIRpDRGTypbprTnoU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=s1hHvQjsuYMGm3UL4aOPcfQGlRDN9/koBDV2RKbJ5V/TrSksOGb289pmcoK91K9YFGLgXupiRoQ8uBaeCK24TYjfgMf0pkBGyJ9wOtDl38xIZoWYiu/IZ5vNgw7R3Ilt2yR7CYRcJKgXGPQGgFPG+pMHuexXoD61tGmk6NBQmMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmuEDdsG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmuEDdsG"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53396adbc53so13754911cf.3
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791711669; x=1792316469; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F32+2uAbaO1Qf5VQbeEk5ikSSxk/CuYSgmlPzcPoc0s=;
        b=HmuEDdsG52R3uEnwwJsdqf6zYpo6HP4aeKFcmhAocTYT/qjDt/4L8uB2iWIXGOTgoB
         OrRdldf5gu18Q/+GoZmumfzWFz6Yahzf0NZ0oQI0Z44YQDLALiWA4ajTDUvPG75JGHhV
         h5MRd2p5Ai5hUNWRJ+VJTBbLJGdvLbAPNjEm9lg2+/K8LB/XDraZum2Lh3STcYQZEfAl
         rOxnCpQpFk71ip8Zl05zexKACj5Pt97NC3mSll6cKD3rG8zTcGZ7lF2m7SK3jh5lM06m
         hK2oo5IMSjgc+2bpXOVJMDRmYys/QVRHDFbUVyLMnQIzorp9ao19yAcCYUh0hHsmlYzP
         ZC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791711669; x=1792316469;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F32+2uAbaO1Qf5VQbeEk5ikSSxk/CuYSgmlPzcPoc0s=;
        b=bEUFd0l2U7YFOK9Seahf0TwF+eVPSs9f/+6QAlhwAUp/TqNcVJlT3auzsikD24JdJJ
         18ikxr4v0jRoGd/5SiHjQIey7IM76N1Mm/vB0Z478D2vKzFdYiDoNbfARdU8ohy5MoIS
         6F5XglkP1QWOCHVqENaDvZFGRx46aCE23wQTN3awU8MJo1J2KFFRHnOIwluwcsrINPtB
         gsSvbO/fRimpF1BINBA9/TXbVpHu44yYhHhcAVYaDuFLKA9rsRAkgfmcAvJ/83v7sdr+
         zXLfgmwKY2OMcm8o6WoyG8HM/p13ewryXM6DR3SI6/+9qcXGAjzMkiiwQGdkI6nJGRmi
         83vw==
X-Gm-Message-State: AFq9FYKM/cKeQo7ix+Ce+pLt74jf71g/LCd+j4D6ky+CTQD+ShPhRhr/
	SwOzSeQ8UNZDZ4DFfkCnNJunBYkR/HX1BHmOL9Ta8MTtOrXipFvw7dwupMTLgRpU81w=
X-Gm-Gg: AYBFou0iTLP9UCBp6M7p3Ikf/crpg1aq9nAsN94BkEBGAHxL6NPfrH9xSdSFCoJnsVd
	6o5PbsBPw8doJ9bnc90xe6J71Lqka0yUdVmBgX8NqL9eHqIyi70auNO41vA/cjiUIdOOcSwY6GF
	YU/1c8pmBgSNes5alympqYvzHv6UHMPKVXeeyFLXCJq8AFaQV0sp3w1eAXaEfhRzfva0Qy1od6z
	BuoWUwUAPwPbDyW+ocveiiuR4fzMyOKu82wT6DMqKRmXIMnpxXNNrXIwXxgV3g2d1ygDfENpo7Z
	iXieHBDngq5QCZK5oszt3WSn8bGXTmxCMbdWl+oIaKKAZF7RUSv+kFShAYDcf/1tTZWnB4zSwas
	jOZPp9zSmzO2JGQDfEQH51wpRCgWVR+T+CV6Lpg50cBqsj/SbXAUms74X7+MNY4a+yil2beQi79
	IIHQ81t3RavGzpl/J2F22csx1/QTjS5kj8jmHhIPVP5/XDvvhXLeOIyuXFxfG64M7CO8LmMtKsI
	ZI=
X-Received: by 2002:ac8:59c3:0:b0:535:9798:3f00 with SMTP id d75a77b69052e-5359fb87592mr117950171cf.47.1791711668723;
        Sun, 11 Oct 2026 02:41:08 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.108.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7ad30csm56686361cf.23.2026.10.11.02.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 02:41:07 -0700 (PDT)
Message-Id: <pull.2425.v2.git.git.1791711665.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 Oct 2026 09:41:03 +0000
Subject: [PATCH v2 0/2] branch: let --delete-merged find squash merged branches
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Branches merged on GitHub with "Squash and merge" or "Rebase and merge" are
never deleted by git branch --delete-merged, because their tips are not
reachable from the upstream. This treats such a branch as merged when some
upstream commit contains all of its changes, and names that commit in the
output:

Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).


Changes in v2:

 * Diff each upstream commit once and share the result between all branches,
   faster than v1.
 * Fix a branch merged with a merge commit being reported as "landed as" the
   merge when another branch was searched first, and add a test for it. Show
   the topic commit itself in "landed as" for work that arrived through a
   merge.
 * Use git merge --squash as the example in the commit message and mention
   GitHub's squash and rebase buttons.
 * Add --no-squashed to skip the squash search.

Harald Nordgren (2):
  branch: let --delete-merged find squash merged branches
  branch: add --no-squashed to skip the squash search

 Documentation/git-branch.adoc |  23 ++-
 builtin/branch.c              | 342 ++++++++++++++++++++++++++++++++--
 t/t3200-branch.sh             | 170 +++++++++++++++++
 3 files changed, 509 insertions(+), 26 deletions(-)


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2425%2FHaraldNordgren%2Fbranch-delete-squashed-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2425/HaraldNordgren/branch-delete-squashed-v2
Pull-Request: https://github.com/git/git/pull/2425

Range-diff vs v1:

 1:  c9ab56d8b2 ! 1:  94a6d23f8b branch: let --delete-merged find squash merged branches
     @@ Metadata
       ## Commit message ##
          branch: let --delete-merged find squash merged branches
      
     -    Branches merged on GitHub with "Squash and merge" or "Rebase and
     -    merge" are never deleted by "git branch --delete-merged". The upstream
     -    holds a rewritten copy of their work, so their tips are not reachable
     -    from it and they look unmerged forever.
     +    A branch that upstream integrated with
     +
     +        git merge --squash topic
     +        git commit
     +
     +    is never deleted by "git branch --delete-merged". The same goes for a
     +    branch that was rebased or cherry-picked onto upstream. The upstream
     +    holds a rewritten copy of its work, so its tip is not reachable from
     +    it and it looks unmerged forever.
     +
     +    This happens all the time on hosting services. The "Squash and merge"
     +    and "Rebase and merge" buttons on GitHub land pull requests this way,
     +    so contributors to such projects collect local branches that
     +    "--delete-merged" never cleans up.
      
          Treat such a branch as merged when some upstream commit since the fork
          point contains all of its changes, so that merging the branch into
     @@ builtin/branch.c
       #include "help.h"
       #include "advice.h"
       #include "commit-reach.h"
     ++#include "commit-slab.h"
      +#include "diff.h"
      +#include "diffcore.h"
      +#include "hex.h"
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
       	return ret;
       }
       
     ++enum change_state {
     ++	CHANGE_MISSING,
     ++	CHANGE_LANDED,
     ++	CHANGE_NEEDS_MERGE,
     ++};
     ++
      +struct branch_change {
      +	char *path;
     -+	struct object_id base_oid, branch_oid;
     ++	struct object_id base_oid, branch_oid, upstream_oid;
      +	unsigned short branch_mode;
     ++	enum change_state state;
     ++};
     ++
     ++struct landing_search {
     ++	const char *branch_name;
     ++	struct commit *rev;
     ++	struct commit *upstream;
     ++	struct branch_change *changes;
     ++	size_t changes_nr, changes_alloc;
      +};
      +
     -+static void collect_branch_changes(struct commit *base, struct commit *rev,
     -+				   struct branch_change **changes,
     -+				   size_t *nr, size_t *alloc)
     ++define_commit_slab(changed_paths, struct string_list *);
     ++
     ++static void collect_branch_changes(struct landing_search *search,
     ++				   struct commit *base)
      +{
      +	struct diff_options opt;
      +
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +	opt.flags.recursive = 1;
      +	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
      +	diff_setup_done(&opt);
     -+	diff_tree_oid(get_commit_tree_oid(base), get_commit_tree_oid(rev),
     -+		      "", &opt);
     ++	diff_tree_oid(get_commit_tree_oid(base),
     ++		      get_commit_tree_oid(search->rev), "", &opt);
      +	for (int i = 0; i < diff_queued_diff.nr; i++) {
      +		struct diff_filepair *p = diff_queued_diff.queue[i];
      +		struct branch_change *change;
      +
     -+		ALLOC_GROW(*changes, *nr + 1, *alloc);
     -+		change = &(*changes)[(*nr)++];
     ++		ALLOC_GROW(search->changes, search->changes_nr + 1,
     ++			   search->changes_alloc);
     ++		change = &search->changes[search->changes_nr++];
      +		change->path = xstrdup(p->two->path);
      +		oidcpy(&change->base_oid, DIFF_FILE_VALID(p->one) ?
      +		       &p->one->oid : null_oid(the_hash_algo));
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +	diff_flush(&opt);
      +}
      +
     -+static int merge_keeps_upstream(const struct branch_change *change,
     -+				const struct object_id *upstream_oid)
     ++static int merge_keeps_upstream(const struct branch_change *change)
      +{
      +	mmfile_t base, upstream, branch;
      +	mmbuffer_t result = { 0 };
      +	int ret;
      +
      +	read_mmblob(&base, the_repository->objects, &change->base_oid);
     -+	read_mmblob(&upstream, the_repository->objects, upstream_oid);
     ++	read_mmblob(&upstream, the_repository->objects, &change->upstream_oid);
      +	read_mmblob(&branch, the_repository->objects, &change->branch_oid);
      +	ret = ll_merge(&result, change->path, &base, "base",
      +		       &upstream, "upstream", &branch, "branch",
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +	return ret;
      +}
      +
     -+static int change_landed(const struct branch_change *change,
     -+			 struct commit *commit)
     ++static enum change_state change_state_at(struct branch_change *change,
     ++					 struct commit *commit)
      +{
     -+	struct object_id oid;
      +	unsigned short mode;
      +
      +	if (get_tree_entry(the_repository, get_commit_tree_oid(commit),
     -+			   change->path, &oid, &mode))
     -+		return is_null_oid(&change->branch_oid);
     -+	if (oideq(&oid, &change->branch_oid))
     -+		return mode == change->branch_mode;
     ++			   change->path, &change->upstream_oid, &mode))
     ++		return is_null_oid(&change->branch_oid) ?
     ++			CHANGE_LANDED : CHANGE_MISSING;
     ++	if (oideq(&change->upstream_oid, &change->branch_oid))
     ++		return mode == change->branch_mode ?
     ++			CHANGE_LANDED : CHANGE_MISSING;
      +	if (is_null_oid(&change->base_oid) ||
      +	    is_null_oid(&change->branch_oid) ||
     -+	    oideq(&oid, &change->base_oid) ||
     ++	    oideq(&change->upstream_oid, &change->base_oid) ||
      +	    mode != change->branch_mode || !S_ISREG(mode))
     -+		return 0;
     -+	return merge_keeps_upstream(change, &oid);
     ++		return CHANGE_MISSING;
     ++	return CHANGE_NEEDS_MERGE;
      +}
      +
     -+static struct commit *find_landed_commit(struct commit *rev,
     -+					 struct commit *upstream)
     ++static int changes_landed(struct landing_search *search,
     ++			  struct commit *commit)
     ++{
     ++	for (size_t i = 0; i < search->changes_nr; i++) {
     ++		struct branch_change *change = &search->changes[i];
     ++
     ++		change->state = change_state_at(change, commit);
     ++		if (change->state == CHANGE_MISSING)
     ++			return 0;
     ++	}
     ++	for (size_t i = 0; i < search->changes_nr; i++) {
     ++		struct branch_change *change = &search->changes[i];
     ++
     ++		if (change->state == CHANGE_NEEDS_MERGE &&
     ++		    !merge_keeps_upstream(change))
     ++			return 0;
     ++	}
     ++	return 1;
     ++}
     ++
     ++static struct string_list *changed_paths_of(struct changed_paths *cache,
     ++					    struct diff_options *opt,
     ++					    struct commit *commit)
     ++{
     ++	struct string_list **paths = changed_paths_at(cache, commit);
     ++	struct commit *parent;
     ++
     ++	if (*paths)
     ++		return *paths;
     ++
     ++	CALLOC_ARRAY(*paths, 1);
     ++	string_list_init_dup(*paths);
     ++	parent = commit->parents ? commit->parents->item : NULL;
     ++	if (parent && repo_parse_commit(the_repository, parent))
     ++		die(_("could not parse commit %s"),
     ++		    oid_to_hex(&parent->object.oid));
     ++	diff_tree_oid(parent ? get_commit_tree_oid(parent) : NULL,
     ++		      get_commit_tree_oid(commit), "", opt);
     ++	for (int i = 0; i < diff_queued_diff.nr; i++) {
     ++		struct diff_filepair *p = diff_queued_diff.queue[i];
     ++
     ++		string_list_append(*paths, p->two->path);
     ++	}
     ++	diff_flush(opt);
     ++	string_list_sort(*paths);
     ++	return *paths;
     ++}
     ++
     ++static void free_changed_paths(struct string_list **paths)
     ++{
     ++	if (!*paths)
     ++		return;
     ++	string_list_clear(*paths, 0);
     ++	free(*paths);
     ++}
     ++
     ++static int touches_changes(struct string_list *paths,
     ++			   const struct landing_search *search)
     ++{
     ++	for (size_t i = 0; i < search->changes_nr; i++)
     ++		if (string_list_has_string(paths, search->changes[i].path))
     ++			return 1;
     ++	return 0;
     ++}
     ++
     ++static struct commit *find_landed_commit(struct landing_search *search,
     ++					 struct changed_paths *cache,
     ++					 struct diff_options *opt)
      +{
     -+	struct commit_list *merge_bases = NULL;
     -+	struct branch_change *changes = NULL;
     -+	size_t changes_nr = 0, changes_alloc = 0;
      +	struct commit *commit, *landed = NULL;
      +	struct strvec args = STRVEC_INIT;
      +	struct rev_info revs;
      +
     -+	if (repo_get_merge_bases(the_repository, upstream, rev,
     -+				 &merge_bases) < 0)
     -+		exit(128);
     -+	if (!merge_bases)
     -+		return NULL;
     -+	collect_branch_changes(merge_bases->item, rev, &changes,
     -+			       &changes_nr, &changes_alloc);
     -+	commit_list_free(merge_bases);
     -+	if (!changes_nr)
     -+		return NULL;
     -+
      +	strvec_pushl(&args, "rev-list", "--reverse",
     -+		     oid_to_hex(&upstream->object.oid), NULL);
     -+	strvec_pushf(&args, "^%s", oid_to_hex(&rev->object.oid));
     -+	strvec_push(&args, "--");
     -+	for (size_t i = 0; i < changes_nr; i++)
     -+		strvec_pushf(&args, ":(literal)%s", changes[i].path);
     ++		     oid_to_hex(&search->upstream->object.oid), NULL);
     ++	strvec_pushf(&args, "^%s", oid_to_hex(&search->rev->object.oid));
      +
      +	repo_init_revisions(the_repository, &revs, NULL);
      +	setup_revisions_from_strvec(&args, &revs, NULL);
      +	if (prepare_revision_walk(&revs))
      +		die(_("revision walk setup failed"));
     -+	while (!landed && (commit = get_revision(&revs))) {
     -+		size_t i;
     -+
     -+		for (i = 0; i < changes_nr; i++)
     -+			if (!change_landed(&changes[i], commit))
     -+				break;
     -+		if (i == changes_nr)
     ++	while (!landed && (commit = get_revision(&revs)))
     ++		if (touches_changes(changed_paths_of(cache, opt, commit),
     ++				    search) &&
     ++		    changes_landed(search, commit))
      +			landed = commit;
     -+	}
      +	release_revisions(&revs);
     -+	clear_commit_marks(upstream, ALL_REV_FLAGS);
     -+	clear_commit_marks(rev, ALL_REV_FLAGS);
     ++	clear_commit_marks(search->upstream, ALL_REV_FLAGS);
     ++	clear_commit_marks(search->rev, ALL_REV_FLAGS);
      +	strvec_clear(&args);
     -+
     -+	for (size_t i = 0; i < changes_nr; i++)
     -+		free(changes[i].path);
     -+	free(changes);
      +	return landed;
      +}
     ++
     ++static void find_landed_commits(struct landing_search *searches,
     ++				size_t searches_nr,
     ++				struct strmap *landed_commits)
     ++{
     ++	struct changed_paths cache;
     ++	struct diff_options opt;
     ++
     ++	for (size_t i = 0; i < searches_nr; i++) {
     ++		struct landing_search *search = &searches[i];
     ++		struct commit_list *merge_bases = NULL;
     ++
     ++		if (repo_get_merge_bases(the_repository, search->upstream,
     ++					 search->rev, &merge_bases) < 0)
     ++			exit(128);
     ++		if (merge_bases)
     ++			collect_branch_changes(search, merge_bases->item);
     ++		commit_list_free(merge_bases);
     ++	}
     ++
     ++	repo_diff_setup(the_repository, &opt);
     ++	opt.flags.recursive = 1;
     ++	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
     ++	opt.no_free = 1;
     ++	diff_setup_done(&opt);
     ++	init_changed_paths(&cache);
     ++
     ++	for (size_t i = 0; i < searches_nr; i++) {
     ++		struct commit *landed;
     ++
     ++		if (!searches[i].changes_nr)
     ++			continue;
     ++		landed = find_landed_commit(&searches[i], &cache, &opt);
     ++		if (landed)
     ++			strmap_put(landed_commits, searches[i].branch_name,
     ++				   landed);
     ++	}
     ++
     ++	deep_clear_changed_paths(&cache, free_changed_paths);
     ++	opt.no_free = 0;
     ++	diff_free(&opt);
     ++}
     ++
     ++static int branch_opted_out(struct strbuf *key, const char *branch_name,
     ++			    unsigned int flags)
     ++{
     ++	int opt_out;
     ++
     ++	strbuf_reset(key);
     ++	strbuf_addf(key, "branch.%s.deletemerged", branch_name);
     ++	if (repo_config_get_bool(the_repository, key->buf, &opt_out) ||
     ++	    opt_out)
     ++		return 0;
     ++	if (!(flags & DELETE_BRANCH_QUIET))
     ++		fprintf(stderr,
     ++			_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
     ++			branch_name, branch_name);
     ++	return 1;
     ++}
      +
       static int delete_merged_branches(const struct strvec *upstreams,
       				 const char **argv, unsigned int flags)
     @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
       	struct strset deletable_branch_names = STRSET_INIT;
       	struct strset protected_branch_names = STRSET_INIT;
      +	struct strmap landed_commits = STRMAP_INIT;
     ++	struct landing_search *searches = NULL;
     ++	size_t searches_nr = 0, searches_alloc = 0;
       	struct strvec branches_to_delete = STRVEC_INIT;
       	struct strbuf key = STRBUF_INIT;
       	struct hashmap_iter iter;
     @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
       		const char *branch_name;
       		struct branch *branch;
       		const char *upstream_refname;
     -+		struct commit *landed = NULL;
     - 		int opt_out;
     +-		int opt_out;
       
       		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
     + 			BUG("filter returned non-branch ref '%s'", branch_refname);
      @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
       			continue;
       		if (check_branch_commit(branch_name, branch_name,
       					&candidates.items[i]->objectname, NULL,
      -					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
      -			continue;
     +-
     +-		strbuf_reset(&key);
     +-		strbuf_addf(&key, "branch.%s.deletemerged", branch_name);
     +-		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
     +-		    !opt_out) {
     +-			if (!(flags & DELETE_BRANCH_QUIET))
     +-				fprintf(stderr,
     +-					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
     +-					branch_name, branch_name);
      +					FILTER_REFS_BRANCHES,
      +					DELETE_BRANCH_SKIP_UNMERGED)) {
      +			struct commit *rev = lookup_commit_reference(
     @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
      +			struct commit *upstream = lookup_commit_reference_by_name(
      +				upstream_refname);
      +
     -+			if (!rev || !upstream ||
     -+			    !(landed = find_landed_commit(rev, upstream)))
     ++			if (!rev || !upstream)
      +				continue;
     -+		}
     - 
     - 		strbuf_reset(&key);
     - 		strbuf_addf(&key, "branch.%s.deletemerged", branch_name);
     -@@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
     ++			ALLOC_GROW(searches, searches_nr + 1, searches_alloc);
     ++			searches[searches_nr++] = (struct landing_search) {
     ++				.branch_name = branch_name,
     ++				.rev = rev,
     ++				.upstream = upstream,
     ++			};
     + 			continue;
       		}
       
     - 		strset_add(&deletable_branch_names, branch_name);
     -+		if (landed)
     -+			strmap_put(&landed_commits, branch_name, landed);
     +-		strset_add(&deletable_branch_names, branch_name);
     ++		if (!branch_opted_out(&key, branch_name, flags))
     ++			strset_add(&deletable_branch_names, branch_name);
     ++	}
     ++
     ++	find_landed_commits(searches, searches_nr, &landed_commits);
     ++	for (size_t i = 0; i < searches_nr; i++) {
     ++		const char *branch_name = searches[i].branch_name;
     ++
     ++		if (strmap_contains(&landed_commits, branch_name) &&
     ++		    !branch_opted_out(&key, branch_name, flags))
     ++			strset_add(&deletable_branch_names, branch_name);
       	}
       
       	protect_stacked_branch_bases(refs, &deletable_branch_names,
     @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
       
       	strbuf_release(&key);
       	strvec_clear(&branches_to_delete);
     ++	for (size_t i = 0; i < searches_nr; i++) {
     ++		for (size_t j = 0; j < searches[i].changes_nr; j++)
     ++			free(searches[i].changes[j].path);
     ++		free(searches[i].changes);
     ++	}
     ++	free(searches);
      +	strmap_clear(&landed_commits, 0);
       	strset_clear(&protected_branch_names);
       	strset_clear(&deletable_branch_names);
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
      +test_expect_success '--delete-merged deletes a squash merged branch' '
      +	setup_repo_for_delete_merged &&
      +	push_topic squashed squashed-one squashed-two &&
     -+	push_topic partial partial-landed partial-pending &&
     ++	push_topic partial lands-upstream stays-local &&
      +	squash_merge_upstream partial~1 &&
      +	squash_merge_upstream squashed &&
      +	squash=$(git -C upstream rev-parse --short next) &&
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
      +		EOF
      +	)
      +'
     ++
     ++test_expect_success '--delete-merged deletes a squash merged branch after upstream changed the same file' '
     ++	(
     ++		cd upstream &&
     ++		git checkout next &&
     ++		test_write_lines 1 2 3 4 5 6 7 8 9 10 >shared &&
     ++		git add shared &&
     ++		git commit -m "add shared" &&
     ++		git checkout main
     ++	) &&
     ++	setup_repo_for_delete_merged &&
     ++	(
     ++		cd repo &&
     ++		git checkout -b edits-shared --track origin/next &&
     ++		test_write_lines 1 two 3 4 5 6 7 8 9 10 >shared &&
     ++		git commit -a -m "edit line 2" &&
     ++		git push origin edits-shared &&
     ++		git checkout --detach
     ++	) &&
     ++	(
     ++		cd upstream &&
     ++		git checkout next &&
     ++		test_write_lines 1 2 3 4 five 6 7 8 9 10 >shared &&
     ++		git commit -a -m "edit line 5" &&
     ++		git checkout main
     ++	) &&
     ++	squash_merge_upstream edits-shared &&
     ++	squash=$(git -C upstream rev-parse --short next) &&
     ++	(
     ++		cd repo &&
     ++		git fetch origin &&
     ++		sha=$(git rev-parse --short edits-shared) &&
     ++
     ++		git branch --delete-merged origin/next >actual 2>&1 &&
     ++		echo "Deleted branch edits-shared (was $sha, landed as $squash)." >expect &&
     ++		test_cmp expect actual &&
     ++
     ++		check_branches <<-\EOF
     ++		main
     ++		EOF
     ++	)
     ++'
     ++
     ++test_expect_success '--delete-merged reports a merge plainly next to an unmerged branch' '
     ++	setup_repo_for_delete_merged &&
     ++	push_topic a-unmerged unmerged-work &&
     ++	push_topic b-merged merged-work &&
     ++	(
     ++		cd upstream &&
     ++		git checkout next &&
     ++		test_commit upstream-work &&
     ++		git merge --no-ff b-merged &&
     ++		git checkout main
     ++	) &&
     ++	(
     ++		cd repo &&
     ++		git fetch origin &&
     ++		sha=$(git rev-parse --short b-merged) &&
     ++
     ++		git branch --delete-merged origin/next >actual 2>&1 &&
     ++		echo "Deleted branch b-merged (was $sha)." >expect &&
     ++		test_cmp expect actual &&
     ++
     ++		check_branches <<-\EOF
     ++		a-unmerged
     ++		main
     ++		EOF
     ++	)
     ++'
      +
       test_expect_success '--delete-merged keeps main despite a different default push remote' '
       	setup_repo_for_delete_merged &&
 -:  ---------- > 2:  ec88bde252 branch: add --no-squashed to skip the squash search

-- 
gitgitgadget
