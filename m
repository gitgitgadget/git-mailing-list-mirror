Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003630;
	b=iut6oP5o/VKFizqsBRQjRT3n7HwEqM87NP1qNk6Cxu0V2XMk4Ti0r2Uw71lC8EEUP9jg
	 xNLrrvAJdUmYOyqE5lx7Dn+0KB9+cHd5/jCKwHEAjmvctB8H2WbwwWQSwxvW+8Tr6cn6k
	 j6cLsvV1x/u/r8nC0AMw0v2G3uHwbVjaOcBuWU6HSu1/ejLzbbdUFCxZlo5jwvEZLLpfW
	 4ZUo6YcHdAyufNm7TSIW0a2QA4F8MiJpUwDOXFvKwJocDWm84psYw+xOF0iwQrgkghFOR
	 tSlDV+1ISX/OxyzJ8/pq6JMOGsFsdfwHp6UOuABQ9OIEadAEtfzRA8eQKsRlKTiqUiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=rg3f9uEG+UIp/ePVWlUKBLguVn5LWrNEDs9ShsCu0lI=;
	b=lgrg+L8DX9L4l9DtzQNs/hdUXIS9gXG1CsM6bDrU4zTSLxfezYNB6BYJLhh6xN0lw7ep
	 7zlp3uUKwHzjKyFagMbJ9rVCidm3IMwhmSuOk5B5/KB2WmiuimLCBzzo3OJcw5a+gFztW
	 atHdpWbWG0/4ggAIBT3cRRDbwdUQ+oh94CcFuGpGWRmCIO7yMwq6SLW06SzTIEzdF/mc/
	 Xnz+RS/qRtZ89mhycBLMIWmVBOZYqMm5FV0OSB/pTfCF6L2ckpXOcCKVvwnxKq8kyCF52
	 XLt2a8JZpBLUOSnnfPC7bEelI/TVDE6t+Pga7aIqFu+L+OscQuqI6byqSjAPjZ3GP9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MPAsdx1Q;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFADF606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFADF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MPAsdx1Q
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ae0852df46so666866a91.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 01:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793003629; x=1793608429; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rg3f9uEG+UIp/ePVWlUKBLguVn5LWrNEDs9ShsCu0lI=;
        b=MPAsdx1Qiej4bmSExRDl7vJm+MK4LHe3VRRuUnw9uAJHHnAUy0n3ekMu6oa+uEARgu
         vj6v2NKOVJ3VFpQiYIf9upLvIGkwLm64u6pq63xWP8cJrHjjCKWeMOfROuCxO3GEPatn
         sqxFNaNa9krr0Lnc5YcCu3nmS72tHiUlBSe75RwtCu+RqGBoq0BUYI3TMYnxt0eNhUFv
         GAOBVeg81Smdz2VDN9m7j462gJnIY+eSjiDvDPyNMED8vH/UHdavV9d21u6M6/quKyha
         PMTiDcW2isUihSoSJhUp2t5I1a8B1v524MQOR8dwKPBrFru8W2J3qPW8BFUBtnO1gTX2
         m34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003629; x=1793608429;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rg3f9uEG+UIp/ePVWlUKBLguVn5LWrNEDs9ShsCu0lI=;
        b=uX29Ob+GCJaGsPuPy22e1eV1hy/DcCF4FiE5FIexDPErI06uQAAb1PWF+92+XQvxZ7
         YE7DKip4xWCqlFcrt7PgLvg8C8lgcMp28FUZNY3pnwpqy+75HmrDsfFo1u3C234Gz15J
         DBgAj3hH1wzubXhfBVNG+M5dRA24fD5A2l/yPcaw3sWJ8NsrVA4ozCunRMGkjS4F4Cyn
         glefIndc2IcSpuSgJVsdhgtkWpL9clFuTPXzbAC0sZ/wNxH474Ai4ab3ag33DdsTuwpq
         zjpL5H71QZeW/nEsMDwd4qe3tFiWdBhGzFTPguLNnnpVf5ZVGarALLADsM8XeOHgP5Uu
         08kA==
X-Gm-Message-State: AFq9FYIQQbw/+FA+E6S4z/sWz/DDz8KzmV+N3pqoKH2bmO2Y1kYeQhob
	xPwC4J8bXcjOiaikpSw9eOPU4Yl1C9WA2XrE0ZgS6gzf5ndSFDeIoUGBuVwnrd9N
X-Gm-Gg: AYBFou25offxf9BD+jTJG+MgdCADfLPmZh3YZcm+kH1YvsPgjbo0/tg9Nnvq73gA/SU
	yiktxw+MDIqB3Dxhv+fNP5DEHtR49HD+H5hUN0iwRh9q2JGoALB3nwN4uphIpy/2hEUtoHq2VzX
	fr3qPFrPrysL0KcELws/daHo/b8gOJDdZIs2avIqrg1pmWHH2f0SMMXXf2ae04inYzcYffqm0OU
	np/kbM0EqYswULowysCf0yimVGD80kyu+/TcuaOCLKGW0jTDRMzRRAfeDNhhnSAl5wwRWO09s0E
	BeUeMBctAurc4xA9jDEEoiv1KMjNF5ZLRHx3KED7hkufENIj1EWaPUVZnBO9t/T/w+eURksy4gj
	yQj1tRt9J5OovVr0Hx2dBTteOIVORymC5pZlgp5XSu0fN6QtG2/FTEDhe7gtspJGIE9kPtbPeDY
	z0e58qvDvNyCwjOZzBT636ObaQyq0lJ4mlHDuBBLXN6aIokXH37dpY2TRoXNprzjf5eAoZOwGZ1
	nKnpolbfGZ5z0cFyvbk+9lodfjTX6UC4p1bNtUim/B0WfE8GMjCK0HqgDA=
X-Received: by 2002:a17:90b:3e4f:b0:3ad:413f:5a1c with SMTP id 98e67ed59e1d1-3adead554c2mr3711473a91.11.1793003628732;
        Mon, 26 Oct 2026 01:33:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.211.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cccb7802sm1225822a12.22.2026.10.26.01.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:33:48 -0700 (PDT)
Message-Id: <pull.2425.v4.git.git.1793003627.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 08:33:43 +0000
Subject: [PATCH v4 0/4] branch: let --delete-merged find squash merged branches
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
the branch's version into upstream's leaves it unchanged.

Changes in v4:

 * --delete-merged works as it does on master again: it only deletes
   branches whose tip is reachable from their upstream
 * New --delete-irrelevant <pattern> also deletes branches that were rebase
   or squash merged, including those squashed after upstream changed the
   same files. It replaces --squashed
 * New prep commit lets delete_branches() take a map of where each branch
   landed, so "landed as" is printed there
 * Added Junio's test that --delete-merged keeps a branch when an unrelated
   upstream commit adds an identical file
 * --dry-run works with either option, and the two options can't be combined

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

Harald Nordgren (4):
  branch: move the deleteMerged opt-out check into a helper
  branch: let delete_branches() name where a branch landed
  branch: add --delete-integrated to delete rebase and squash merged
    branches
  branch: let --delete-integrated find branches merged onto changed
    files

 Documentation/config/branch.adoc |   8 +-
 Documentation/git-branch.adoc    |  22 +-
 builtin/branch.c                 | 355 +++++++++++++++++++++++++++++--
 t/t3200-branch.sh                | 217 +++++++++++++++++++
 4 files changed, 572 insertions(+), 30 deletions(-)


base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2425%2FHaraldNordgren%2Fbranch-delete-squashed-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2425/HaraldNordgren/branch-delete-squashed-v4
Pull-Request: https://github.com/git/git/pull/2425

Range-diff vs v3:

 1:  82413e5cd7 ! 1:  1d01085b75 branch: move the deleteMerged opt-out check into a helper
     @@ Metadata
       ## Commit message ##
          branch: move the deleteMerged opt-out check into a helper
      
     -    The next commit lets "git branch --delete-merged" delete branches whose
     -    tips are not reachable from their upstream, and those must honor
     -    branch.<name>.deleteMerged=false as well. Move the check into a helper
     -    so it can be used in both places.
     +    A later commit adds "git branch --delete-integrated", which deletes
     +    branches whose tips are not reachable from their upstream. Those must
     +    honor branch.<name>.deleteMerged=false as well. Move the check into a
     +    helper so it can be used in both places.
      
          No change in behavior.
      
 -:  ---------- > 2:  592562d7e7 branch: let delete_branches() name where a branch landed
 2:  9a7e88ced6 ! 3:  deb1e649cf branch: let --delete-merged find rebase merged branches
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    branch: let --delete-merged find rebase merged branches
     +    branch: add --delete-integrated to delete rebase and squash merged branches
      
          A branch that upstream integrated with
      
     @@ Commit message
              git checkout main
              git merge --ff-only topic
      
     +    or with
     +
     +        git merge --squash topic
     +        git commit
     +
          is never deleted by "git branch --delete-merged". This is what the
     -    "Rebase and merge" button on GitHub does. The upstream holds rewritten
     -    copies of the branch's commits, so its tip is not reachable from it and
     -    it looks unmerged forever.
     +    "Rebase and merge" and "Squash and merge" buttons on GitHub do. The
     +    upstream holds rewritten copies of the branch's work, so its tip is not
     +    reachable from it and it looks unmerged forever.
      
     -    Treat such a branch as merged when some upstream commit since the fork
     -    point has the branch's version of every file the branch changed. Name
     -    that commit in the output so the user can see where the work went:
     +    Add --delete-integrated, which does what --delete-merged does and also
     +    deletes a branch when some upstream commit since the fork point has the
     +    branch's version of every file the branch changed. That commit is named
     +    in the output so the user can see where the work went:
      
              Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).
      
     -    The first upstream commit that has them is used, so the branch is
     -    deleted even if upstream later reverted or reworked them. Nothing is
     -    lost, since that commit keeps them in the upstream history. A branch
     -    whose changes only partly landed is kept.
     +    The first such commit is used, so the branch is deleted even if
     +    upstream later reverted or reworked the changes. Nothing is lost, since
     +    that commit keeps them in the upstream history. Who made that commit
     +    does not matter, since the local branch is no longer needed either way.
     +    A branch whose changes only partly landed is kept.
      
     -    The same check finds a squash merge when upstream did not change the
     -    same files between the fork point and the squash. It never reads file
     -    contents, so it stays cheap in a partial clone.
     +    --delete-merged keeps deleting only branches whose own commits are in
     +    the upstream, so it never removes a branch because somebody else made
     +    the same change.
     +
     +    The check never reads file contents, so it stays cheap in a partial
     +    clone.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     + ## Documentation/config/branch.adoc ##
     +@@ Documentation/config/branch.adoc: for details).
     + 
     + `branch.<name>.deleteMerged`::
     + 	If set to `false`, branch _<name>_ is exempt from
     +-	`git branch --delete-merged`.  Useful for a topic branch you
     +-	intend to develop further after an initial round has been
     +-	merged upstream.  Defaults to true.  Explicit deletion via
     +-	`git branch -d` is unaffected.
     ++	`git branch --delete-merged` and `--delete-integrated`.  Useful
     ++	for a topic branch you intend to develop further after an
     ++	initial round has been merged upstream.  Defaults to true.
     ++	Explicit deletion via `git branch -d` is unaffected.
     +
       ## Documentation/git-branch.adoc ##
     -@@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mode.
     +@@ Documentation/git-branch.adoc: git branch (-c|-C) [<old-branch>] <new-branch>
     + git branch (-d|-D) [-r] <branch-name>...
     + git branch --edit-description [<branch-name>]
     + git branch [--dry-run] (--delete-merged <pattern>)... [<branch-pattern>...]
     ++git branch [--dry-run] (--delete-integrated <pattern>)... [<branch-pattern>...]
     + 
     + DESCRIPTION
     + -----------
     +@@ Documentation/git-branch.adoc: A branch whose work has not yet been merged into its upstream is
     + silently skipped. Delete it with `git branch -D` if you want to
     + remove it anyway.
       
     - `--delete-merged <pattern>`::
     - 	Delete local branches whose configured upstream matches
     --	_<pattern>_, but only when their tip is reachable from that
     --	upstream. In other words, the work on the branch has already
     --	landed on the upstream it tracks, so the local copy is no longer
     --	needed. _<pattern>_ may name a ref, a remote (using the branch its
     --	`HEAD` points at), or a shell-style glob. The option can be
     --	repeated to widen the upstream match.
     -+	_<pattern>_, but only when their work has already landed on that
     -+	upstream, so the local copy is no longer needed. This is the case
     -+	when their tip is reachable from the upstream, or when some
     -+	upstream commit has their version of every file they changed, as
     -+	happens after a rebase merge, even if those changes were later
     -+	reverted. The message for such a branch names the first upstream
     -+	commit that has them. _<pattern>_ may name a ref, a remote (using
     -+	the branch its `HEAD` points at), or a shell-style glob. The
     -+	option can be repeated to widen the upstream match.
     - 	Optional _<branch-pattern>_ arguments limit which local branches
     - 	are considered, e.g. `git branch --delete-merged 'origin/*'
     - 	'topic-*'`.
     ++`--delete-integrated <pattern>`::
     ++	Like `--delete-merged`, but also delete a branch whose changes
     ++	the upstream already has even though its commits are not there,
     ++	as happens after a squash or rebase merge. Such a branch is
     ++	deleted when some upstream commit since the fork point has its
     ++	version of every file it changed, even if those changes were
     ++	later reverted, and the message names the first such commit.
     ++	It does not matter who made that commit. The same rules for
     ++	which branches are kept apply as for `--delete-merged`.
     ++
     + `--dry-run`::
     +-	With `--delete-merged`, print which branches would be
     +-	deleted and exit without touching any ref.  Useful for
     +-	sanity-checking a wide pattern like `'origin/*'` before
     +-	committing to the deletion.
     ++	With `--delete-merged` or `--delete-integrated`, print which
     ++	branches would be deleted and exit without touching any ref.
     ++	Useful for sanity-checking a wide pattern like `'origin/*'`
     ++	before committing to the deletion.
     + 
     + `-v`::
     + `-vv`::
      
       ## builtin/branch.c ##
      @@
     @@ builtin/branch.c
       
       static const char * const builtin_branch_usage[] = {
       	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
     -@@ builtin/branch.c: static void delete_branch_config(const char *branchname)
     - }
     +@@ builtin/branch.c: enum delete_branch_flags {
     + 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
     + 	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
     + 	DELETE_BRANCH_DRY_RUN = (1 << 4),
     ++	DELETE_BRANCH_INTEGRATED = (1 << 5),
     + };
       
     - static int delete_branches(int argc, const char **argv, int kinds,
     --			   unsigned int flags)
     -+			   unsigned int flags, struct strmap *landed_commits)
     - {
     - 	struct commit *head_rev = NULL;
     - 	struct object_id oid;
     -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
     - 		}
     - 
     - 		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
     -+		    !(landed_commits &&
     -+		      strmap_contains(landed_commits, bname.buf)) &&
     - 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
     - 					flags)) {
     - 			if (!(flags & DELETE_BRANCH_SKIP_UNMERGED))
     -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
     - 	for_each_string_list_item(item, &refs_to_delete) {
     - 		char *describe_ref = item->util;
     - 		char *name = item->string;
     -+		struct commit *landed = landed_commits ?
     -+			strmap_get(landed_commits, name + branch_name_pos) : NULL;
     -+		const char *landed_abbrev = landed ?
     -+			repo_find_unique_abbrev(the_repository,
     -+						&landed->object.oid,
     -+						DEFAULT_ABBREV) : NULL;
     -+
     - 		if (flags & DELETE_BRANCH_DRY_RUN) {
     --			if (!(flags & DELETE_BRANCH_QUIET))
     -+			if (flags & DELETE_BRANCH_QUIET)
     -+				;
     -+			else if (landed)
     -+				printf(_("Would delete branch %s (was %s, landed as %s).\n"),
     -+				       name + branch_name_pos, describe_ref,
     -+				       landed_abbrev);
     -+			else
     - 				printf(remote_branch
     - 					? _("Would delete remote-tracking branch %s (was %s).\n")
     - 					: _("Would delete branch %s (was %s).\n"),
     - 					name + branch_name_pos, describe_ref);
     - 		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
     - 			char *refname = name + branch_name_pos;
     --			if (!(flags & DELETE_BRANCH_QUIET))
     -+			if (flags & DELETE_BRANCH_QUIET)
     -+				;
     -+			else if (landed)
     -+				printf(_("Deleted branch %s (was %s, landed as %s).\n"),
     -+				       refname, describe_ref, landed_abbrev);
     -+			else
     - 				printf(remote_branch
     - 					? _("Deleted remote-tracking branch %s (was %s).\n")
     - 					: _("Deleted branch %s (was %s).\n"),
     + static int check_branch_commit(const char *branchname, const char *refname,
      @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
       	return ret;
       }
     @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
      -					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
      +					FILTER_REFS_BRANCHES,
      +					DELETE_BRANCH_SKIP_UNMERGED)) {
     -+			struct commit *rev = lookup_commit_reference(
     -+				the_repository, &candidates.items[i]->objectname);
     -+			struct commit *upstream = lookup_commit_reference_by_name(
     -+				upstream_refname);
     ++			struct commit *rev, *upstream;
      +
     ++			if (!(flags & DELETE_BRANCH_INTEGRATED))
     ++				continue;
     ++			rev = lookup_commit_reference(
     ++				the_repository, &candidates.items[i]->objectname);
     ++			upstream = lookup_commit_reference_by_name(upstream_refname);
      +			if (!rev || !upstream)
      +				continue;
      +			ALLOC_GROW(searches, searches_nr + 1, searches_alloc);
     @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
       				      FILTER_REFS_BRANCHES,
       				      DELETE_BRANCH_SKIP_UNMERGED |
       				      DELETE_BRANCH_NO_HEAD_FALLBACK |
     --				      flags);
     +-				      flags, NULL);
      +				      flags, &landed_commits);
       
       	if (!ret && !(flags & DELETE_BRANCH_DRY_RUN))
     @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
       	strset_clear(&deletable_branch_names);
       	ref_array_clear(&candidates);
      @@ builtin/branch.c: int cmd_branch(int argc,
     - 			die(_("branch name required"));
     - 		ret = delete_branches(argc, argv, filter.kind,
     - 				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
     --				      (quiet ? DELETE_BRANCH_QUIET : 0));
     -+				      (quiet ? DELETE_BRANCH_QUIET : 0), NULL);
     + 	int delete = 0, rename = 0, copy = 0, list = 0,
     + 	    unset_upstream = 0, show_current = 0, edit_description = 0;
     + 	struct strvec delete_merged = STRVEC_INIT;
     ++	struct strvec delete_integrated = STRVEC_INIT;
     + 	int dry_run = 0;
     + 	const char *new_upstream = NULL;
     + 	int noncreate_actions = 0;
     +@@ builtin/branch.c: int cmd_branch(int argc,
     + 		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("pattern"),
     + 			N_("delete merged branches whose upstream matches <pattern> (repeatable)"),
     + 			PARSE_OPT_NONEG, parse_opt_strvec),
     ++		OPT_CALLBACK_F(0, "delete-integrated", &delete_integrated, N_("pattern"),
     ++			N_("like --delete-merged, but also delete branches whose changes landed upstream (repeatable)"),
     ++			PARSE_OPT_NONEG, parse_opt_strvec),
     + 		OPT_BOOL(0, "dry-run", &dry_run,
     +-			N_("with --delete-merged, only print which branches would be deleted")),
     ++			N_("with --delete-merged or --delete-integrated, only print which branches would be deleted")),
     + 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
     + 		OPT_MERGED(&filter, N_("print only branches that are merged")),
     + 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
     +@@ builtin/branch.c: int cmd_branch(int argc,
     + 
     + 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
     + 	    !show_current && !unset_upstream && !delete_merged.nr &&
     +-	    argc == 0)
     ++	    !delete_integrated.nr && argc == 0)
     + 		list = 1;
     + 
     + 	if (filter.with_commit || filter.no_commit ||
     +@@ builtin/branch.c: int cmd_branch(int argc,
     + 
     + 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
     + 			    !!show_current + !!list + !!edit_description +
     +-			    !!unset_upstream + !!delete_merged.nr;
     ++			    !!unset_upstream + !!delete_merged.nr +
     ++			    !!delete_integrated.nr;
     + 	if (noncreate_actions > 1)
     + 		usage_with_options(builtin_branch_usage, options);
     + 
     +-	if (dry_run && !delete_merged.nr)
     +-		die(_("--dry-run requires --delete-merged"));
     ++	if (dry_run && !delete_merged.nr && !delete_integrated.nr)
     ++		die(_("--dry-run requires --delete-merged or --delete-integrated"));
     + 
     + 	if (recurse_submodules_explicit) {
     + 		if (!submodule_propagate_branches)
     +@@ builtin/branch.c: int cmd_branch(int argc,
     + 					     (quiet ? DELETE_BRANCH_QUIET : 0) |
     + 					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
       		goto out;
     - 	} else if (delete_merged.nr) {
     - 		ret = delete_merged_branches(&delete_merged, argv,
     ++	} else if (delete_integrated.nr) {
     ++		ret = delete_merged_branches(&delete_integrated, argv,
     ++					     (quiet ? DELETE_BRANCH_QUIET : 0) |
     ++					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0) |
     ++					     DELETE_BRANCH_INTEGRATED);
     ++		goto out;
     + 	} else if (show_current) {
     + 		print_current_branch_name();
     + 		ret = 0;
     +@@ builtin/branch.c: int cmd_branch(int argc,
     + 
     + out:
     + 	strvec_clear(&delete_merged);
     ++	strvec_clear(&delete_integrated);
     + 	string_list_clear(&sorting_options, 0);
     + 	return ret;
     + }
      
       ## t/t3200-branch.sh ##
     +@@ t/t3200-branch.sh: check_branches () {
     + 	test_cmp expect actual
     + }
     + 
     ++test_expect_success '--delete-merged does not delete unrelated branches' '
     ++	setup_repo_for_delete_merged &&
     ++	(
     ++		cd repo &&
     ++		git checkout -b unrelated-topic --track origin/next &&
     ++		test_write_lines 1 2 3 4 >file &&
     ++		git add file &&
     ++		git commit -m "add file" &&
     ++		git push origin unrelated-topic &&
     ++		git checkout --detach
     ++	) &&
     ++	(
     ++		cd upstream &&
     ++		git checkout next &&
     ++		test_write_lines 1 2 3 4 >file &&
     ++		test_write_lines 5 6 7 >elif &&
     ++		git add file elif &&
     ++		git commit --author="unrelated user <uu@example.com>" \
     ++			-m "unrelated commit adding an identical file" &&
     ++		git checkout main
     ++	) &&
     ++	(
     ++		cd repo &&
     ++		git fetch origin &&
     ++		git branch --delete-merged origin/next >actual 2>&1 &&
     ++		test_must_be_empty actual &&
     ++		check_branches <<-\EOF
     ++		main
     ++		unrelated-topic
     ++		EOF
     ++	)
     ++'
     ++
     + test_expect_success '--delete-merged keeps cloned main without explicit push configuration' '
     + 	setup_repo_for_delete_merged &&
     + 	(
      @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected merged branches' '
       	)
       '
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
      +	)
      +}
      +
     -+test_expect_success '--delete-merged deletes a rebase merged branch' '
     ++test_expect_success '--delete-integrated deletes a rebase merged branch' '
      +	setup_repo_for_delete_merged &&
      +	push_topic rebased rebased-one rebased-two &&
      +	(
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
      +		git fetch origin &&
      +		sha=$(git rev-parse --short rebased) &&
      +
     -+		git branch --delete-merged origin/next >actual 2>&1 &&
     ++		git branch --delete-integrated origin/next >actual 2>&1 &&
      +		echo "Deleted branch rebased (was $sha, landed as $landed)." >expect &&
      +		test_cmp expect actual &&
      +
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
      +	)
      +'
      +
     -+test_expect_success '--delete-merged deletes a squash merged branch' '
     ++test_expect_success '--delete-integrated deletes a squash merged branch' '
      +	setup_repo_for_delete_merged &&
      +	push_topic squashed squashed-one squashed-two &&
      +	push_topic partial lands-upstream stays-local &&
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
      +		git fetch origin &&
      +		sha=$(git rev-parse --short squashed) &&
      +
     -+		git branch --delete-merged origin/next >actual 2>&1 &&
     ++		git branch --delete-integrated origin/next >actual 2>&1 &&
      +		echo "Deleted branch squashed (was $sha, landed as $squash)." >expect &&
      +		test_cmp expect actual &&
      +
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
      +	)
      +'
      +
     -+test_expect_success '--delete-merged deletes a squash merged branch that was reverted' '
     ++test_expect_success '--delete-integrated deletes a squash merged branch that was reverted' '
      +	setup_repo_for_delete_merged &&
      +	push_topic reverted reverted-work &&
      +	squash_merge_upstream reverted &&
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
      +		git fetch origin &&
      +		sha=$(git rev-parse --short reverted) &&
      +
     -+		git branch --delete-merged origin/next >actual 2>&1 &&
     ++		git branch --delete-integrated origin/next >actual 2>&1 &&
      +		echo "Deleted branch reverted (was $sha, landed as $squash)." >expect &&
      +		test_cmp expect actual &&
      +
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
      +	)
      +'
      +
     -+test_expect_success '--delete-merged reports a merge plainly next to an unmerged branch' '
     ++test_expect_success '--delete-integrated reports a merge plainly next to an unmerged branch' '
      +	setup_repo_for_delete_merged &&
      +	push_topic a-unmerged unmerged-work &&
      +	push_topic b-merged merged-work &&
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
      +		git fetch origin &&
      +		sha=$(git rev-parse --short b-merged) &&
      +
     -+		git branch --delete-merged origin/next >actual 2>&1 &&
     ++		git branch --delete-integrated origin/next >actual 2>&1 &&
      +		echo "Deleted branch b-merged (was $sha)." >expect &&
      +		test_cmp expect actual &&
      +
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
       test_expect_success '--delete-merged keeps main despite a different default push remote' '
       	setup_repo_for_delete_merged &&
       	create_merged_branch on-next &&
     +@@ t/t3200-branch.sh: test_expect_success '--dry-run without --delete-merged is rejected' '
     + 	test_grep "requires --delete-merged" err
     + '
     + 
     ++test_expect_success '--delete-integrated cannot be combined with --delete-merged' '
     ++	test_must_fail git -C forked branch --delete-merged origin/next \
     ++		--delete-integrated origin/next
     ++'
     ++
     + test_done
 3:  2befb182dc ! 4:  19a9630c13 branch: add --squashed to find squash merged branches
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    branch: add --squashed to find squash merged branches
     +    branch: let --delete-integrated find branches merged onto changed files
      
          A branch that upstream integrated with
      
     @@ Commit message
              git commit
      
          after upstream had also changed the files the branch touches is still
     -    kept by "git branch --delete-merged". The squash commit has neither the
     -    branch's version of those files nor the fork point's, so the previous
     -    check cannot see that the work landed. This happens all the time on
     -    hosting services, where the "Squash and merge" button on GitHub lands
     -    pull requests this way while the main branch keeps moving. A rebase
     -    merge onto such changes looks the same.
     +    kept by "git branch --delete-integrated". The squash commit has neither
     +    the branch's version of those files nor the fork point's, so the
     +    previous check cannot see that the work landed. This happens all the
     +    time on hosting services, where the "Squash and merge" button on GitHub
     +    lands pull requests this way while the main branch keeps moving. A
     +    rebase merge onto such changes looks the same.
      
     -    Add --squashed, which for each such file merges the branch's version
     -    into the upstream one and treats the change as landed when that leaves
     -    the upstream version unchanged. This has to read the files, so it is
     -    slower, and in a partial clone it may download blobs. It is therefore
     -    only done when asked for.
     +    For each such file, merge the branch's version into the upstream one
     +    and treat the change as landed when that leaves the upstream version
     +    unchanged. This has to read the files, so in a partial clone it may
     +    download blobs.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/git-branch.adoc ##
     -@@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
     - git branch (-c|-C) [<old-branch>] <new-branch>
     - git branch (-d|-D) [-r] <branch-name>...
     - git branch --edit-description [<branch-name>]
     --git branch [--dry-run] (--delete-merged <pattern>)... [<branch-pattern>...]
     -+git branch [--dry-run] [--squashed] (--delete-merged <pattern>)... [<branch-pattern>...]
     - 
     - DESCRIPTION
     - -----------
      @@ Documentation/git-branch.adoc: remove it anyway.
     - 	sanity-checking a wide pattern like `'origin/*'` before
     - 	committing to the deletion.
     - 
     -+`--squashed`::
     -+	With `--delete-merged`, also delete a branch that was squash or
     -+	rebase merged after upstream changed the same files. Upstream
     -+	then has neither the branch's version of those files nor the fork
     -+	point's, so the branch's version is merged into upstream's, and
     -+	the file counts as landed when that leaves upstream's version
     -+	unchanged. This reads those files, so it takes longer and may
     -+	download blobs in a partial clone.
     -+
     - `-v`::
     - `-vv`::
     - `--verbose`::
     + 	Like `--delete-merged`, but also delete a branch whose changes
     + 	the upstream already has even though its commits are not there,
     + 	as happens after a squash or rebase merge. Such a branch is
     +-	deleted when some upstream commit since the fork point has its
     +-	version of every file it changed, even if those changes were
     +-	later reverted, and the message names the first such commit.
     +-	It does not matter who made that commit. The same rules for
     +-	which branches are kept apply as for `--delete-merged`.
     ++	deleted when some upstream commit since the fork point has all
     ++	of its changes, even if they were later reverted, and the
     ++	message names the first such commit. It does not matter who made
     ++	that commit. A file counts when the commit has the branch's
     ++	version of it, or when merging the branch's version into the
     ++	commit's leaves it unchanged, which reads the file and may
     ++	download blobs in a partial clone. The same rules for which
     ++	branches are kept apply as for `--delete-merged`.
     + 
     + `--dry-run`::
     + 	With `--delete-merged` or `--delete-integrated`, print which
      
       ## builtin/branch.c ##
      @@
     @@ builtin/branch.c
       
       static const char * const builtin_branch_usage[] = {
       	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
     -@@ builtin/branch.c: enum delete_branch_flags {
     - 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
     - 	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
     - 	DELETE_BRANCH_DRY_RUN = (1 << 4),
     -+	DELETE_BRANCH_SQUASHED = (1 << 5),
     - };
     - 
     - static int check_branch_commit(const char *branchname, const char *refname,
      @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
       	return ret;
       }
     @@ builtin/branch.c: static void collect_branch_changes(struct landing_search *sear
       }
       
       static int changes_landed(struct landing_search *search,
     --			  struct commit *commit)
     -+			  struct commit *commit, unsigned int flags)
     + 			  struct commit *commit)
       {
      -	for (size_t i = 0; i < search->changes_nr; i++)
      -		if (!change_landed(&search->changes[i], commit))
     @@ builtin/branch.c: static void collect_branch_changes(struct landing_search *sear
      +		struct branch_change *change = &search->changes[i];
      +
      +		change->state = change_state_at(change, commit);
     -+		if (change->state == CHANGE_MISSING ||
     -+		    (change->state == CHANGE_NEEDS_MERGE &&
     -+		     !(flags & DELETE_BRANCH_SQUASHED)))
     ++		if (change->state == CHANGE_MISSING)
       			return 0;
      +	}
      +	for (size_t i = 0; i < search->changes_nr; i++) {
     @@ builtin/branch.c: static void collect_branch_changes(struct landing_search *sear
       	return 1;
       }
       
     -@@ builtin/branch.c: static int touches_changes(struct string_list *paths,
     - 
     - static struct commit *find_landed_commit(struct landing_search *search,
     - 					 struct changed_paths *cache,
     --					 struct diff_options *opt)
     -+					 struct diff_options *opt,
     -+					 unsigned int flags)
     - {
     - 	struct commit *commit, *landed = NULL;
     - 	struct strvec args = STRVEC_INIT;
     -@@ builtin/branch.c: static struct commit *find_landed_commit(struct landing_search *search,
     - 	while (!landed && (commit = get_revision(&revs)))
     - 		if (touches_changes(changed_paths_of(cache, opt, commit),
     - 				    search) &&
     --		    changes_landed(search, commit))
     -+		    changes_landed(search, commit, flags))
     - 			landed = commit;
     - 	release_revisions(&revs);
     - 	clear_commit_marks(search->upstream, ALL_REV_FLAGS);
     -@@ builtin/branch.c: static struct commit *find_landed_commit(struct landing_search *search,
     - 
     - static void find_landed_commits(struct landing_search *searches,
     - 				size_t searches_nr,
     --				struct strmap *landed_commits)
     -+				struct strmap *landed_commits,
     -+				unsigned int flags)
     - {
     - 	struct changed_paths cache;
     - 	struct diff_options opt;
     -@@ builtin/branch.c: static void find_landed_commits(struct landing_search *searches,
     - 
     - 		if (!searches[i].changes_nr)
     - 			continue;
     --		landed = find_landed_commit(&searches[i], &cache, &opt);
     -+		landed = find_landed_commit(&searches[i], &cache, &opt, flags);
     - 		if (landed)
     - 			strmap_put(landed_commits, searches[i].branch_name,
     - 				   landed);
     -@@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
     - 			strset_add(&deletable_branch_names, branch_name);
     - 	}
     - 
     --	find_landed_commits(searches, searches_nr, &landed_commits);
     -+	find_landed_commits(searches, searches_nr, &landed_commits, flags);
     - 	for (size_t i = 0; i < searches_nr; i++) {
     - 		const char *branch_name = searches[i].branch_name;
     - 
     -@@ builtin/branch.c: int cmd_branch(int argc,
     - 	    unset_upstream = 0, show_current = 0, edit_description = 0;
     - 	struct strvec delete_merged = STRVEC_INIT;
     - 	int dry_run = 0;
     -+	int squashed = 0;
     - 	const char *new_upstream = NULL;
     - 	int noncreate_actions = 0;
     - 	/* possible options */
     -@@ builtin/branch.c: int cmd_branch(int argc,
     - 			PARSE_OPT_NONEG, parse_opt_strvec),
     - 		OPT_BOOL(0, "dry-run", &dry_run,
     - 			N_("with --delete-merged, only print which branches would be deleted")),
     -+		OPT_BOOL(0, "squashed", &squashed,
     -+			N_("with --delete-merged, also find branches merged after upstream changed their files")),
     - 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
     - 		OPT_MERGED(&filter, N_("print only branches that are merged")),
     - 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
     -@@ builtin/branch.c: int cmd_branch(int argc,
     - 
     - 	if (dry_run && !delete_merged.nr)
     - 		die(_("--dry-run requires --delete-merged"));
     -+	if (squashed && !delete_merged.nr)
     -+		die(_("--squashed requires --delete-merged"));
     - 
     - 	if (recurse_submodules_explicit) {
     - 		if (!submodule_propagate_branches)
     -@@ builtin/branch.c: int cmd_branch(int argc,
     - 	} else if (delete_merged.nr) {
     - 		ret = delete_merged_branches(&delete_merged, argv,
     - 					     (quiet ? DELETE_BRANCH_QUIET : 0) |
     --					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
     -+					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0) |
     -+					     (squashed ? DELETE_BRANCH_SQUASHED : 0));
     - 		goto out;
     - 	} else if (show_current) {
     - 		print_current_branch_name();
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes a squash merged branch that was rev
     +@@ t/t3200-branch.sh: test_expect_success '--delete-integrated deletes a squash merged branch that was
       	)
       '
       
     -+test_expect_success '--delete-merged --squashed deletes a squash merged branch after upstream changed the same file' '
     ++test_expect_success '--delete-integrated deletes a squash merged branch after upstream changed the same file' '
      +	(
      +		cd upstream &&
      +		git checkout next &&
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes a squash merged
      +		git fetch origin &&
      +		sha=$(git rev-parse --short edits-shared) &&
      +
     -+		git branch --delete-merged origin/next >actual 2>&1 &&
     -+		test_must_be_empty actual &&
     -+		check_branches <<-\EOF &&
     -+		edits-shared
     -+		main
     -+		EOF
     -+
     -+		git branch --delete-merged origin/next --squashed \
     -+			>actual 2>&1 &&
     ++		git branch --delete-integrated origin/next >actual 2>&1 &&
      +		echo "Deleted branch edits-shared (was $sha, landed as $squash)." >expect &&
      +		test_cmp expect actual &&
      +
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes a squash merged
      +	)
      +'
      +
     - test_expect_success '--delete-merged reports a merge plainly next to an unmerged branch' '
     + test_expect_success '--delete-integrated reports a merge plainly next to an unmerged branch' '
       	setup_repo_for_delete_merged &&
       	push_topic a-unmerged unmerged-work &&
     -@@ t/t3200-branch.sh: test_expect_success "branch -d still deletes a deleteMerged=false branch" '
     - 	)
     - '
     - 
     -+test_expect_success '--squashed without --delete-merged is rejected' '
     -+	test_must_fail git -C forked branch --squashed 2>err &&
     -+	test_grep "requires --delete-merged" err
     -+'
     -+
     - test_expect_success '--dry-run without --delete-merged is rejected' '
     - 	test_must_fail git -C forked branch --dry-run 2>err &&
     - 	test_grep "requires --delete-merged" err

-- 
gitgitgadget
