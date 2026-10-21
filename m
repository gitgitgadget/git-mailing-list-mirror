Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585721;
	b=pCQkPSBJpZ3q8qZubWJxY6A5c4cK6ojBoEelt8Ot9vjZtc4nGUr8dM2NcS4nMwtJxuml
	 2VnaSrE6a2Khqc5bfH2yoAZTxcl/HUsk6poahF2vWRg/6cuFF3MJN6WN7fAd37KjnAVE1
	 pIcrFKTnTtp9RaWM+af9L8idZLS1sAvAEplW8deBqJQ+qtUXx96hyAcsi0OV92Y7Cw3Pk
	 v+7IP4Bv2DCaLM7VQdmTeUTdsB1KtZJAyv8IkQ5pTeuW+fcEzCEmJxLiN0Mf72HuxQZ6m
	 PkwZV6Qm19P7ZifNF095P7K0NBH3ehaHFka5099lUkz/HtMP5DJuLvb8kgvfDwnEI6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Z8hMHYfCdxrgd55yWqvuXLU2qBnyHO572D2lXcMkpjo=;
	b=X13TiCjNCj+ah5j/KG7m9xjfu2F52lvInSAwGByLDcYue9w9Iby3B8EuQBpD0rslTCPp
	 4toWF1aFVBNmsZ+lDFLCQZdCxens3QXBFkvDIB0pLfx8yP/PFuP81eHPyShr3bd8eI3N7
	 HUCMYEqgEdRf8wgZQ3Sr1OaRUW2oD+wwSdSo80SsJjcnw/C59yhFhzER8vLcoxf2CEo+z
	 q7lUSWkk7YNZTG6c67OVZR3WV5ItPCKhzgQuiq+0FJkCJzACQrLab3GU2hdGStxkTrU8M
	 0D0XLgHj5AC6Dgp25y/Qsn5fM48+1SI5Xayl+2svGnehLL0selCqmxUUja+GVHQpx1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bBkQw3Ed;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798FE606A31B
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 12:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 798FE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bBkQw3Ed
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f3c89594cso49550285a.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585719; x=1793190519; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z8hMHYfCdxrgd55yWqvuXLU2qBnyHO572D2lXcMkpjo=;
        b=bBkQw3EdXshQ5Y/OjOOGLnTJwFVvl2/TP01NoIGy9IRucecQl4auExFVWs3rtFnjuA
         hsMMXORpanugA4KXETvLBh9kq25A6OuuGt4ACBO3pwj2hG6wKLwdiN5Dc+BRnzdflRSr
         rh6Hr1xRAFCfHpm4sVb/J0Y24TxluLLCiGefpcVXaQ5htd1JSZdxc9Dky2xPe/Ui29i5
         J9fTC+vwsjiR57VJQgI7/4iPTtUcrVOTbVcMer83F6dUB9IrYN5DlBsTDrsS96VHVrT8
         NJhSMB30JNYlxpxcurzuARqfPZVLT99preASPma7vAMbD/o4scWLDiSrILMGlpJTC3qV
         QdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585719; x=1793190519;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8hMHYfCdxrgd55yWqvuXLU2qBnyHO572D2lXcMkpjo=;
        b=UQFC1X18R+t+0x15RMXUJVFeT2fpa23jcN0WIx8Hu6P8ZirJujJv47UPgAV9wyFDLA
         SL8rBZ9v/kzdkIAWfwGc3P9zWhS/d2iyEM+evVhA1ziEY4VEWAfbSCbvOHIo01gxPIx5
         xZz43EmWBncsXYWWsW7C8gWFTvQRJ2orxbRkLuHKfg2Q0ZEmlJbW//mWq/KnaF1ivOuD
         LxKsroyoqQs4p5x8SkxdRMc/tuYV61xcmMpHCByfegF43/JCjZfygsVy297dDqaSFNuv
         GyY0Uh18sTLIjmhD1XNdQEU7My4mhhrZ5zjGQgjDAnc0NPpkRyc52Jdc5RBHgMCCnd+Y
         hLbg==
X-Gm-Message-State: AFq9FYLHDcRbLYfeU84obLpPSPVLcWiwRJ1QIzhVynHFX7aMBvWBATnr
	rVpVCLCfCS2YFE2Zzagiuyc1edNT0PrHuWId7jXSx5ECq9beKLqhc+JVNkolwA==
X-Gm-Gg: AYBFou3zXfUf7VDauW4P7Af8WPsk5V0+sijfYAXDAb2BORI4hppvJLDTYUBsMSYHEfy
	qPJ064tIJq2pV3kS+nYZUtBJFhgZ8AT9LB/2Z4XM9+nYBw9F+/NWaMVRXEJlWki1KgLx59rcMAr
	7gviYb0BsN1RrfpV+peUdYD0jLWKMnpn2n8enVOyo1behQkTSsKbE8EK7mR2TaC4pEzVr008aTQ
	+dMd+r7KQAdkQe58JJhqH5FftH2R9VdX7R+EQbUiU5yl8ZrsRlFAVi1AcOCS4ZB1dvoAFhRWgzY
	PDq9S9N6a/yMuqBrZSH0AEALgxrrzjzHUSKwy4tJwJSxDoi/VC8OwBVjk9/gB16vXnQzLY5pV8U
	JkFrGBFqdxLla1ca0vUfGb0X1x6IaOJR5qgg73n9o66zTNtKM4PDOE+hxzMCBOl5XgTEn6S9ou4
	+83L5lrSKec4euK9FfrMqgHtrcVSsJW0cVJHTKw5Kxc4mLXfaELuknisjpMAJ4aIWyUARm4jXxh
	4gFYhejnKzIPSat8Q9EnFjx7Y57llfttL2CUcePd+ty8eRnwH/46Z3T+qg=
X-Received: by 2002:a05:620a:3707:b0:93c:b10:7243 with SMTP id af79cd13be357-93f57e459bfmr432259485a.5.1792585718998;
        Wed, 21 Oct 2026 05:28:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.95.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e071easm243792585a.31.2026.10.21.05.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:28:38 -0700 (PDT)
Message-Id: <pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 12:28:34 +0000
Subject: [PATCH v3 0/3] branch: let --delete-merged find squash merged branches
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Jasper Mayone <me@jaspermayone.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Branches merged on GitHub with "Squash and merge" or "Rebase and merge" are
never deleted by git branch --delete-merged, because their tips are not
reachable from the upstream. This treats such a branch as merged when some
upstream commit contains all of its changes, and names that commit in the
output:

Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).


This series finds the first upstream commit since the fork point that has
the branch's version of every file the branch changed, comparing only object
ids. With --squashed, a file that upstream also changed counts when merging
the branch's version into upstream's leaves it unchanged. Timed on my clone
with 65 branches, this takes 0.5s.

Other approaches:

 * Full merge-ort test merge per upstream commit: about 9s, because it
   builds a whole tree for every commit.
 * range-diff pairing for rebases: about 10s. It pairs on diffs alone,
   ignoring log messages, so it found nothing extra.
 * Patch ids: not tried. They tell whether a commit is the same patch, but
   deleting a branch only needs a commit that contains its changes. They
   miss a squash that was touched up and changes next to upstream edits, and
   they read file contents for every upstream commit touching the branch's
   files.

Changes in v3:

 * Split into multiple commits, one for rebase merges and one for squash
   merges.
 * By default a branch counts as merged when an upstream commit has its
   exact version of every file it changed. This never reads file contents,
   so it stays cheap in a partial clone. It finds rebase merges, and squash
   merges where upstream left those files alone.
 * Replace --no-squashed with an opt-in --squashed, which also finds
   branches merged after upstream changed the same files by merging those
   files.
 * Add a test for a rebase merge, and check that a squash onto changed files
   is kept without --squashed and deleted with it.

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

Harald Nordgren (3):
  branch: move the deleteMerged opt-out check into a helper
  branch: let --delete-merged find rebase merged branches
  branch: add --squashed to find squash merged branches

 Documentation/git-branch.adoc |  26 ++-
 builtin/branch.c              | 345 ++++++++++++++++++++++++++++++++--
 t/t3200-branch.sh             | 192 +++++++++++++++++++
 3 files changed, 537 insertions(+), 26 deletions(-)


base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2425%2FHaraldNordgren%2Fbranch-delete-squashed-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2425/HaraldNordgren/branch-delete-squashed-v3
Pull-Request: https://github.com/git/git/pull/2425

Range-diff vs v2:

 -:  ---------- > 1:  82413e5cd7 branch: move the deleteMerged opt-out check into a helper
 1:  94a6d23f8b ! 2:  9a7e88ced6 branch: let --delete-merged find squash merged branches
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    branch: let --delete-merged find squash merged branches
     +    branch: let --delete-merged find rebase merged branches
      
          A branch that upstream integrated with
      
     -        git merge --squash topic
     -        git commit
     +        git rebase main topic
     +        git checkout main
     +        git merge --ff-only topic
      
     -    is never deleted by "git branch --delete-merged". The same goes for a
     -    branch that was rebased or cherry-picked onto upstream. The upstream
     -    holds a rewritten copy of its work, so its tip is not reachable from
     -    it and it looks unmerged forever.
     -
     -    This happens all the time on hosting services. The "Squash and merge"
     -    and "Rebase and merge" buttons on GitHub land pull requests this way,
     -    so contributors to such projects collect local branches that
     -    "--delete-merged" never cleans up.
     +    is never deleted by "git branch --delete-merged". This is what the
     +    "Rebase and merge" button on GitHub does. The upstream holds rewritten
     +    copies of the branch's commits, so its tip is not reachable from it and
     +    it looks unmerged forever.
      
          Treat such a branch as merged when some upstream commit since the fork
     -    point contains all of its changes, so that merging the branch into
     -    that commit would change nothing. Name that commit in the output so
     -    the user can see where the work went:
     +    point has the branch's version of every file the branch changed. Name
     +    that commit in the output so the user can see where the work went:
      
              Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).
      
     -    The first upstream commit that contains the changes is used, so the
     -    branch is deleted even if upstream later reverted or reworked them.
     -    Nothing is lost, since that commit keeps them in the upstream history.
     -    A branch whose changes only partly landed is kept.
     +    The first upstream commit that has them is used, so the branch is
     +    deleted even if upstream later reverted or reworked them. Nothing is
     +    lost, since that commit keeps them in the upstream history. A branch
     +    whose changes only partly landed is kept.
     +
     +    The same check finds a squash merge when upstream did not change the
     +    same files between the fork point and the squash. It never reads file
     +    contents, so it stays cheap in a partial clone.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mod
      +	_<pattern>_, but only when their work has already landed on that
      +	upstream, so the local copy is no longer needed. This is the case
      +	when their tip is reachable from the upstream, or when some
     -+	upstream commit contains all of their changes, as happens after
     -+	a squash or rebase merge, even if those changes were later
     ++	upstream commit has their version of every file they changed, as
     ++	happens after a rebase merge, even if those changes were later
      +	reverted. The message for such a branch names the first upstream
     -+	commit that contains its changes. _<pattern>_ may name a ref, a
     -+	remote (using the branch its `HEAD` points at), or a shell-style
     -+	glob. The option can be repeated to widen the upstream match.
     ++	commit that has them. _<pattern>_ may name a ref, a remote (using
     ++	the branch its `HEAD` points at), or a shell-style glob. The
     ++	option can be repeated to widen the upstream match.
       	Optional _<branch-pattern>_ arguments limit which local branches
       	are considered, e.g. `git branch --delete-merged 'origin/*'
       	'topic-*'`.
     @@ builtin/branch.c
      +#include "diff.h"
      +#include "diffcore.h"
      +#include "hex.h"
     -+#include "merge-ll.h"
      +#include "revision.h"
      +#include "tree-walk.h"
     -+#include "xdiff-interface.h"
       
       static const char * const builtin_branch_usage[] = {
       	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
       	return ret;
       }
       
     -+enum change_state {
     -+	CHANGE_MISSING,
     -+	CHANGE_LANDED,
     -+	CHANGE_NEEDS_MERGE,
     -+};
     -+
      +struct branch_change {
      +	char *path;
     -+	struct object_id base_oid, branch_oid, upstream_oid;
     ++	struct object_id branch_oid;
      +	unsigned short branch_mode;
     -+	enum change_state state;
      +};
      +
      +struct landing_search {
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +			   search->changes_alloc);
      +		change = &search->changes[search->changes_nr++];
      +		change->path = xstrdup(p->two->path);
     -+		oidcpy(&change->base_oid, DIFF_FILE_VALID(p->one) ?
     -+		       &p->one->oid : null_oid(the_hash_algo));
      +		oidcpy(&change->branch_oid, DIFF_FILE_VALID(p->two) ?
      +		       &p->two->oid : null_oid(the_hash_algo));
      +		change->branch_mode = p->two->mode;
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +	diff_flush(&opt);
      +}
      +
     -+static int merge_keeps_upstream(const struct branch_change *change)
     -+{
     -+	mmfile_t base, upstream, branch;
     -+	mmbuffer_t result = { 0 };
     -+	int ret;
     -+
     -+	read_mmblob(&base, the_repository->objects, &change->base_oid);
     -+	read_mmblob(&upstream, the_repository->objects, &change->upstream_oid);
     -+	read_mmblob(&branch, the_repository->objects, &change->branch_oid);
     -+	ret = ll_merge(&result, change->path, &base, "base",
     -+		       &upstream, "upstream", &branch, "branch",
     -+		       the_repository->index, NULL) == LL_MERGE_OK &&
     -+	      result.size == upstream.size &&
     -+	      !memcmp(result.ptr, upstream.ptr, upstream.size);
     -+
     -+	free(base.ptr);
     -+	free(upstream.ptr);
     -+	free(branch.ptr);
     -+	free(result.ptr);
     -+	return ret;
     -+}
     -+
     -+static enum change_state change_state_at(struct branch_change *change,
     -+					 struct commit *commit)
     ++static int change_landed(const struct branch_change *change,
     ++			 struct commit *commit)
      +{
     ++	struct object_id oid;
      +	unsigned short mode;
      +
      +	if (get_tree_entry(the_repository, get_commit_tree_oid(commit),
     -+			   change->path, &change->upstream_oid, &mode))
     -+		return is_null_oid(&change->branch_oid) ?
     -+			CHANGE_LANDED : CHANGE_MISSING;
     -+	if (oideq(&change->upstream_oid, &change->branch_oid))
     -+		return mode == change->branch_mode ?
     -+			CHANGE_LANDED : CHANGE_MISSING;
     -+	if (is_null_oid(&change->base_oid) ||
     -+	    is_null_oid(&change->branch_oid) ||
     -+	    oideq(&change->upstream_oid, &change->base_oid) ||
     -+	    mode != change->branch_mode || !S_ISREG(mode))
     -+		return CHANGE_MISSING;
     -+	return CHANGE_NEEDS_MERGE;
     ++			   change->path, &oid, &mode))
     ++		return is_null_oid(&change->branch_oid);
     ++	return oideq(&oid, &change->branch_oid) &&
     ++	       mode == change->branch_mode;
      +}
      +
      +static int changes_landed(struct landing_search *search,
      +			  struct commit *commit)
      +{
     -+	for (size_t i = 0; i < search->changes_nr; i++) {
     -+		struct branch_change *change = &search->changes[i];
     -+
     -+		change->state = change_state_at(change, commit);
     -+		if (change->state == CHANGE_MISSING)
     -+			return 0;
     -+	}
     -+	for (size_t i = 0; i < search->changes_nr; i++) {
     -+		struct branch_change *change = &search->changes[i];
     -+
     -+		if (change->state == CHANGE_NEEDS_MERGE &&
     -+		    !merge_keeps_upstream(change))
     ++	for (size_t i = 0; i < search->changes_nr; i++)
     ++		if (!change_landed(&search->changes[i], commit))
      +			return 0;
     -+	}
      +	return 1;
      +}
      +
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +	diff_free(&opt);
      +}
      +
     -+static int branch_opted_out(struct strbuf *key, const char *branch_name,
     -+			    unsigned int flags)
     -+{
     -+	int opt_out;
     -+
     -+	strbuf_reset(key);
     -+	strbuf_addf(key, "branch.%s.deletemerged", branch_name);
     -+	if (repo_config_get_bool(the_repository, key->buf, &opt_out) ||
     -+	    opt_out)
     -+		return 0;
     -+	if (!(flags & DELETE_BRANCH_QUIET))
     -+		fprintf(stderr,
     -+			_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
     -+			branch_name, branch_name);
     -+	return 1;
     -+}
     -+
     - static int delete_merged_branches(const struct strvec *upstreams,
     - 				 const char **argv, unsigned int flags)
     + static bool branch_opted_out(struct strbuf *key, const char *branch_name,
     + 			     unsigned int flags)
       {
      @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
       	struct ref_array candidates = { 0 };
     @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
       	struct strvec branches_to_delete = STRVEC_INIT;
       	struct strbuf key = STRBUF_INIT;
       	struct hashmap_iter iter;
     -@@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
     - 		const char *branch_name;
     - 		struct branch *branch;
     - 		const char *upstream_refname;
     --		int opt_out;
     - 
     - 		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
     - 			BUG("filter returned non-branch ref '%s'", branch_refname);
      @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
       			continue;
       		if (check_branch_commit(branch_name, branch_name,
       					&candidates.items[i]->objectname, NULL,
      -					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
     --			continue;
     --
     --		strbuf_reset(&key);
     --		strbuf_addf(&key, "branch.%s.deletemerged", branch_name);
     --		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
     --		    !opt_out) {
     --			if (!(flags & DELETE_BRANCH_QUIET))
     --				fprintf(stderr,
     --					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
     --					branch_name, branch_name);
      +					FILTER_REFS_BRANCHES,
      +					DELETE_BRANCH_SKIP_UNMERGED)) {
      +			struct commit *rev = lookup_commit_reference(
     @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
      +				.upstream = upstream,
      +			};
       			continue;
     - 		}
     ++		}
     + 
     + 		if (!branch_opted_out(&key, branch_name, flags))
     + 			strset_add(&deletable_branch_names, branch_name);
     + 	}
       
     --		strset_add(&deletable_branch_names, branch_name);
     -+		if (!branch_opted_out(&key, branch_name, flags))
     -+			strset_add(&deletable_branch_names, branch_name);
     -+	}
     -+
      +	find_landed_commits(searches, searches_nr, &landed_commits);
      +	for (size_t i = 0; i < searches_nr; i++) {
      +		const char *branch_name = searches[i].branch_name;
     @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
      +		if (strmap_contains(&landed_commits, branch_name) &&
      +		    !branch_opted_out(&key, branch_name, flags))
      +			strset_add(&deletable_branch_names, branch_name);
     - 	}
     - 
     ++	}
     ++
       	protect_stacked_branch_bases(refs, &deletable_branch_names,
     + 				     &protected_branch_names);
     + 
      @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
       				      FILTER_REFS_BRANCHES,
       				      DELETE_BRANCH_SKIP_UNMERGED |
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
      +	)
      +}
      +
     ++rebase_merge_upstream () {
     ++	(
     ++		cd upstream &&
     ++		git rebase next "$1" &&
     ++		git checkout next &&
     ++		git merge --ff-only "$1" &&
     ++		git checkout main
     ++	)
     ++}
     ++
     ++test_expect_success '--delete-merged deletes a rebase merged branch' '
     ++	setup_repo_for_delete_merged &&
     ++	push_topic rebased rebased-one rebased-two &&
     ++	(
     ++		cd upstream &&
     ++		git checkout next &&
     ++		test_commit before-rebase &&
     ++		git checkout main
     ++	) &&
     ++	rebase_merge_upstream rebased &&
     ++	landed=$(git -C upstream rev-parse --short next) &&
     ++	(
     ++		cd repo &&
     ++		git fetch origin &&
     ++		sha=$(git rev-parse --short rebased) &&
     ++
     ++		git branch --delete-merged origin/next >actual 2>&1 &&
     ++		echo "Deleted branch rebased (was $sha, landed as $landed)." >expect &&
     ++		test_cmp expect actual &&
     ++
     ++		check_branches <<-\EOF
     ++		main
     ++		EOF
     ++	)
     ++'
     ++
      +test_expect_success '--delete-merged deletes a squash merged branch' '
      +	setup_repo_for_delete_merged &&
      +	push_topic squashed squashed-one squashed-two &&
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
      +	)
      +'
      +
     -+test_expect_success '--delete-merged deletes a squash merged branch after upstream changed the same file' '
     -+	(
     -+		cd upstream &&
     -+		git checkout next &&
     -+		test_write_lines 1 2 3 4 5 6 7 8 9 10 >shared &&
     -+		git add shared &&
     -+		git commit -m "add shared" &&
     -+		git checkout main
     -+	) &&
     -+	setup_repo_for_delete_merged &&
     -+	(
     -+		cd repo &&
     -+		git checkout -b edits-shared --track origin/next &&
     -+		test_write_lines 1 two 3 4 5 6 7 8 9 10 >shared &&
     -+		git commit -a -m "edit line 2" &&
     -+		git push origin edits-shared &&
     -+		git checkout --detach
     -+	) &&
     -+	(
     -+		cd upstream &&
     -+		git checkout next &&
     -+		test_write_lines 1 2 3 4 five 6 7 8 9 10 >shared &&
     -+		git commit -a -m "edit line 5" &&
     -+		git checkout main
     -+	) &&
     -+	squash_merge_upstream edits-shared &&
     -+	squash=$(git -C upstream rev-parse --short next) &&
     -+	(
     -+		cd repo &&
     -+		git fetch origin &&
     -+		sha=$(git rev-parse --short edits-shared) &&
     -+
     -+		git branch --delete-merged origin/next >actual 2>&1 &&
     -+		echo "Deleted branch edits-shared (was $sha, landed as $squash)." >expect &&
     -+		test_cmp expect actual &&
     -+
     -+		check_branches <<-\EOF
     -+		main
     -+		EOF
     -+	)
     -+'
     -+
      +test_expect_success '--delete-merged reports a merge plainly next to an unmerged branch' '
      +	setup_repo_for_delete_merged &&
      +	push_topic a-unmerged unmerged-work &&
 2:  ec88bde252 ! 3:  2befb182dc branch: add --no-squashed to skip the squash search
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    branch: add --no-squashed to skip the squash search
     +    branch: add --squashed to find squash merged branches
      
     -    Finding branches that were squash or rebase merged makes "git branch
     -    --delete-merged" slower, and in a partial clone it may have to
     -    download blobs. Users who do not need it have no way to skip that
     -    search.
     +    A branch that upstream integrated with
      
     -    Add --no-squashed, which only deletes branches whose tip is reachable
     -    from their upstream.
     +        git merge --squash topic
     +        git commit
     +
     +    after upstream had also changed the files the branch touches is still
     +    kept by "git branch --delete-merged". The squash commit has neither the
     +    branch's version of those files nor the fork point's, so the previous
     +    check cannot see that the work landed. This happens all the time on
     +    hosting services, where the "Squash and merge" button on GitHub lands
     +    pull requests this way while the main branch keeps moving. A rebase
     +    merge onto such changes looks the same.
     +
     +    Add --squashed, which for each such file merges the branch's version
     +    into the upstream one and treats the change as landed when that leaves
     +    the upstream version unchanged. This has to read the files, so it is
     +    slower, and in a partial clone it may download blobs. It is therefore
     +    only done when asked for.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       git branch (-d|-D) [-r] <branch-name>...
       git branch --edit-description [<branch-name>]
      -git branch [--dry-run] (--delete-merged <pattern>)... [<branch-pattern>...]
     -+git branch [--dry-run] [--no-squashed] (--delete-merged <pattern>)... [<branch-pattern>...]
     ++git branch [--dry-run] [--squashed] (--delete-merged <pattern>)... [<branch-pattern>...]
       
       DESCRIPTION
       -----------
     @@ Documentation/git-branch.adoc: remove it anyway.
       	sanity-checking a wide pattern like `'origin/*'` before
       	committing to the deletion.
       
     -+`--no-squashed`::
     -+	With `--delete-merged`, only delete branches whose tip is
     -+	reachable from their upstream. This skips the search for
     -+	branches that were squash or rebase merged, which takes longer
     -+	and may have to download blobs in a partial clone.
     ++`--squashed`::
     ++	With `--delete-merged`, also delete a branch that was squash or
     ++	rebase merged after upstream changed the same files. Upstream
     ++	then has neither the branch's version of those files nor the fork
     ++	point's, so the branch's version is merged into upstream's, and
     ++	the file counts as landed when that leaves upstream's version
     ++	unchanged. This reads those files, so it takes longer and may
     ++	download blobs in a partial clone.
      +
       `-v`::
       `-vv`::
       `--verbose`::
      
       ## builtin/branch.c ##
     +@@
     + #include "diff.h"
     + #include "diffcore.h"
     + #include "hex.h"
     ++#include "merge-ll.h"
     + #include "revision.h"
     + #include "tree-walk.h"
     ++#include "xdiff-interface.h"
     + 
     + static const char * const builtin_branch_usage[] = {
     + 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
      @@ builtin/branch.c: enum delete_branch_flags {
       	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
       	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
       	DELETE_BRANCH_DRY_RUN = (1 << 4),
     -+	DELETE_BRANCH_NO_SQUASHED = (1 << 5),
     ++	DELETE_BRANCH_SQUASHED = (1 << 5),
       };
       
       static int check_branch_commit(const char *branchname, const char *refname,
     +@@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
     + 	return ret;
     + }
     + 
     ++enum change_state {
     ++	CHANGE_MISSING,
     ++	CHANGE_LANDED,
     ++	CHANGE_NEEDS_MERGE,
     ++};
     ++
     + struct branch_change {
     + 	char *path;
     +-	struct object_id branch_oid;
     ++	struct object_id base_oid, branch_oid, upstream_oid;
     + 	unsigned short branch_mode;
     ++	enum change_state state;
     + };
     + 
     + struct landing_search {
     +@@ builtin/branch.c: static void collect_branch_changes(struct landing_search *search,
     + 			   search->changes_alloc);
     + 		change = &search->changes[search->changes_nr++];
     + 		change->path = xstrdup(p->two->path);
     ++		oidcpy(&change->base_oid, DIFF_FILE_VALID(p->one) ?
     ++		       &p->one->oid : null_oid(the_hash_algo));
     + 		oidcpy(&change->branch_oid, DIFF_FILE_VALID(p->two) ?
     + 		       &p->two->oid : null_oid(the_hash_algo));
     + 		change->branch_mode = p->two->mode;
     +@@ builtin/branch.c: static void collect_branch_changes(struct landing_search *search,
     + 	diff_flush(&opt);
     + }
     + 
     +-static int change_landed(const struct branch_change *change,
     +-			 struct commit *commit)
     ++static int merge_keeps_upstream(const struct branch_change *change)
     ++{
     ++	mmfile_t base, upstream, branch;
     ++	mmfile_t result = { 0 };
     ++	int ret;
     ++
     ++	read_mmblob(&base, the_repository->objects, &change->base_oid);
     ++	read_mmblob(&upstream, the_repository->objects, &change->upstream_oid);
     ++	read_mmblob(&branch, the_repository->objects, &change->branch_oid);
     ++	ret = ll_merge(&result, change->path, &base, "base",
     ++		       &upstream, "upstream", &branch, "branch",
     ++		       the_repository->index, NULL) == LL_MERGE_OK &&
     ++	      result.size == upstream.size &&
     ++	      !memcmp(result.ptr, upstream.ptr, upstream.size);
     ++
     ++	free(base.ptr);
     ++	free(upstream.ptr);
     ++	free(branch.ptr);
     ++	free(result.ptr);
     ++	return ret;
     ++}
     ++
     ++static enum change_state change_state_at(struct branch_change *change,
     ++					 struct commit *commit)
     + {
     +-	struct object_id oid;
     + 	unsigned short mode;
     + 
     + 	if (get_tree_entry(the_repository, get_commit_tree_oid(commit),
     +-			   change->path, &oid, &mode))
     +-		return is_null_oid(&change->branch_oid);
     +-	return oideq(&oid, &change->branch_oid) &&
     +-	       mode == change->branch_mode;
     ++			   change->path, &change->upstream_oid, &mode))
     ++		return is_null_oid(&change->branch_oid) ?
     ++			CHANGE_LANDED : CHANGE_MISSING;
     ++	if (oideq(&change->upstream_oid, &change->branch_oid))
     ++		return mode == change->branch_mode ?
     ++			CHANGE_LANDED : CHANGE_MISSING;
     ++	if (is_null_oid(&change->base_oid) ||
     ++	    is_null_oid(&change->branch_oid) ||
     ++	    oideq(&change->upstream_oid, &change->base_oid) ||
     ++	    mode != change->branch_mode || !S_ISREG(mode))
     ++		return CHANGE_MISSING;
     ++	return CHANGE_NEEDS_MERGE;
     + }
     + 
     + static int changes_landed(struct landing_search *search,
     +-			  struct commit *commit)
     ++			  struct commit *commit, unsigned int flags)
     + {
     +-	for (size_t i = 0; i < search->changes_nr; i++)
     +-		if (!change_landed(&search->changes[i], commit))
     ++	for (size_t i = 0; i < search->changes_nr; i++) {
     ++		struct branch_change *change = &search->changes[i];
     ++
     ++		change->state = change_state_at(change, commit);
     ++		if (change->state == CHANGE_MISSING ||
     ++		    (change->state == CHANGE_NEEDS_MERGE &&
     ++		     !(flags & DELETE_BRANCH_SQUASHED)))
     + 			return 0;
     ++	}
     ++	for (size_t i = 0; i < search->changes_nr; i++) {
     ++		struct branch_change *change = &search->changes[i];
     ++
     ++		if (change->state == CHANGE_NEEDS_MERGE &&
     ++		    !merge_keeps_upstream(change))
     ++			return 0;
     ++	}
     + 	return 1;
     + }
     + 
     +@@ builtin/branch.c: static int touches_changes(struct string_list *paths,
     + 
     + static struct commit *find_landed_commit(struct landing_search *search,
     + 					 struct changed_paths *cache,
     +-					 struct diff_options *opt)
     ++					 struct diff_options *opt,
     ++					 unsigned int flags)
     + {
     + 	struct commit *commit, *landed = NULL;
     + 	struct strvec args = STRVEC_INIT;
     +@@ builtin/branch.c: static struct commit *find_landed_commit(struct landing_search *search,
     + 	while (!landed && (commit = get_revision(&revs)))
     + 		if (touches_changes(changed_paths_of(cache, opt, commit),
     + 				    search) &&
     +-		    changes_landed(search, commit))
     ++		    changes_landed(search, commit, flags))
     + 			landed = commit;
     + 	release_revisions(&revs);
     + 	clear_commit_marks(search->upstream, ALL_REV_FLAGS);
     +@@ builtin/branch.c: static struct commit *find_landed_commit(struct landing_search *search,
     + 
     + static void find_landed_commits(struct landing_search *searches,
     + 				size_t searches_nr,
     +-				struct strmap *landed_commits)
     ++				struct strmap *landed_commits,
     ++				unsigned int flags)
     + {
     + 	struct changed_paths cache;
     + 	struct diff_options opt;
     +@@ builtin/branch.c: static void find_landed_commits(struct landing_search *searches,
     + 
     + 		if (!searches[i].changes_nr)
     + 			continue;
     +-		landed = find_landed_commit(&searches[i], &cache, &opt);
     ++		landed = find_landed_commit(&searches[i], &cache, &opt, flags);
     + 		if (landed)
     + 			strmap_put(landed_commits, searches[i].branch_name,
     + 				   landed);
      @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
     - 			struct commit *upstream = lookup_commit_reference_by_name(
     - 				upstream_refname);
     - 
     --			if (!rev || !upstream)
     -+			if ((flags & DELETE_BRANCH_NO_SQUASHED) ||
     -+			    !rev || !upstream)
     - 				continue;
     - 			ALLOC_GROW(searches, searches_nr + 1, searches_alloc);
     - 			searches[searches_nr++] = (struct landing_search) {
     + 			strset_add(&deletable_branch_names, branch_name);
     + 	}
     + 
     +-	find_landed_commits(searches, searches_nr, &landed_commits);
     ++	find_landed_commits(searches, searches_nr, &landed_commits, flags);
     + 	for (size_t i = 0; i < searches_nr; i++) {
     + 		const char *branch_name = searches[i].branch_name;
     + 
      @@ builtin/branch.c: int cmd_branch(int argc,
       	    unset_upstream = 0, show_current = 0, edit_description = 0;
       	struct strvec delete_merged = STRVEC_INIT;
       	int dry_run = 0;
     -+	int no_squashed = 0;
     ++	int squashed = 0;
       	const char *new_upstream = NULL;
       	int noncreate_actions = 0;
       	/* possible options */
     @@ builtin/branch.c: int cmd_branch(int argc,
       			PARSE_OPT_NONEG, parse_opt_strvec),
       		OPT_BOOL(0, "dry-run", &dry_run,
       			N_("with --delete-merged, only print which branches would be deleted")),
     -+		OPT_BOOL(0, "no-squashed", &no_squashed,
     -+			N_("with --delete-merged, skip the search for squash merged branches")),
     ++		OPT_BOOL(0, "squashed", &squashed,
     ++			N_("with --delete-merged, also find branches merged after upstream changed their files")),
       		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
       		OPT_MERGED(&filter, N_("print only branches that are merged")),
       		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
     @@ builtin/branch.c: int cmd_branch(int argc,
       
       	if (dry_run && !delete_merged.nr)
       		die(_("--dry-run requires --delete-merged"));
     -+	if (no_squashed && !delete_merged.nr)
     -+		die(_("--no-squashed requires --delete-merged"));
     ++	if (squashed && !delete_merged.nr)
     ++		die(_("--squashed requires --delete-merged"));
       
       	if (recurse_submodules_explicit) {
       		if (!submodule_propagate_branches)
     @@ builtin/branch.c: int cmd_branch(int argc,
       					     (quiet ? DELETE_BRANCH_QUIET : 0) |
      -					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
      +					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0) |
     -+					     (no_squashed ? DELETE_BRANCH_NO_SQUASHED : 0));
     ++					     (squashed ? DELETE_BRANCH_SQUASHED : 0));
       		goto out;
       	} else if (show_current) {
       		print_current_branch_name();
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes a squash merged branch after upstre
     +@@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes a squash merged branch that was rev
       	)
       '
       
     -+test_expect_success '--delete-merged --no-squashed deletes only reachable branches' '
     ++test_expect_success '--delete-merged --squashed deletes a squash merged branch after upstream changed the same file' '
     ++	(
     ++		cd upstream &&
     ++		git checkout next &&
     ++		test_write_lines 1 2 3 4 5 6 7 8 9 10 >shared &&
     ++		git add shared &&
     ++		git commit -m "add shared" &&
     ++		git checkout main
     ++	) &&
      +	setup_repo_for_delete_merged &&
     -+	create_merged_branch merged &&
     -+	push_topic squash-merged squash-merged-work &&
     -+	squash_merge_upstream squash-merged &&
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
      +	(
      +		cd repo &&
      +		git fetch origin &&
     -+		sha=$(git rev-parse --short merged) &&
     ++		sha=$(git rev-parse --short edits-shared) &&
     ++
     ++		git branch --delete-merged origin/next >actual 2>&1 &&
     ++		test_must_be_empty actual &&
     ++		check_branches <<-\EOF &&
     ++		edits-shared
     ++		main
     ++		EOF
      +
     -+		git branch --delete-merged origin/next --no-squashed \
     ++		git branch --delete-merged origin/next --squashed \
      +			>actual 2>&1 &&
     -+		echo "Deleted branch merged (was $sha)." >expect &&
     ++		echo "Deleted branch edits-shared (was $sha, landed as $squash)." >expect &&
      +		test_cmp expect actual &&
      +
      +		check_branches <<-\EOF
      +		main
     -+		squash-merged
      +		EOF
      +	)
      +'
     @@ t/t3200-branch.sh: test_expect_success "branch -d still deletes a deleteMerged=f
       	)
       '
       
     -+test_expect_success '--no-squashed without --delete-merged is rejected' '
     -+	test_must_fail git -C forked branch --no-squashed 2>err &&
     ++test_expect_success '--squashed without --delete-merged is rejected' '
     ++	test_must_fail git -C forked branch --squashed 2>err &&
      +	test_grep "requires --delete-merged" err
      +'
      +

-- 
gitgitgadget
