Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293725;
	b=gyurQRlsACePNPWUDHO31/1g4yKpwmYA/YTUt8Pscp2NtSQCyPBABl+SkJvmR2wMdvJe
	 b6Z+QLPuQ2iDT6UcyFASHlGGZJUv5lsVLlVfPC+eW2utd4xwuEyy6zxW/odLK83SeKukf
	 aIEL/UuFfwW3YEYs9QXd+Gm1XVs/0gRGrsrN4XU5eKHeCGGcC7aS15IMpGQk1Dq1w+mkz
	 t6LjwbJe34tACOvykwlUpyLig93sbwzStBelL+cB6uMtftcf05VeY8sY6M/dc7lsqWip8
	 uRdpS/alGK1NaisnG5sHLrohw1cY3raqFDoZHeb/6NRYMtM/o78zP2XElwMa8MsxqMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=YQBbT4SzPrqTvV5G8uE+ouKdkbFwV885oE/3l7i0S2I=;
	b=P8BiCOLTBzO7zaaoIDOeUkoq9ziz/urLWo7gnJ3zJ39GDuI+uwoaJ4JfHM0166ZQbflW
	 DonPS0+4a6Z3BmkiPyFpz/c2scNygDMoKgGKKbA/fVfzSVmjsLv47y5frG63g8Usbh+GP
	 W88rbu+Tarf+MoXFFZ51+nJeKqjp06rxkRaOb+W3dF3BDlOO9LCmHqyWZ2HGTttxWZJLo
	 RxCxwRqrMGZ+dpeBgRjG5QUCgpEoZwgycFiTytowYRf2tTN9WuJ3T5D/d+kqRVLUPkx+K
	 frgXrCtpFQ5DPPEUu6AbODo8J1OV9vljhq0S6Vj9Tlv6ZX4SyuyNZ6xLeFe4ZGOd13g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=umPERE3u;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839C606A32A
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 20:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7839C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=umPERE3u
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5363316fa0cso25161241cf.3
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 12:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795293723; x=1795898523; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YQBbT4SzPrqTvV5G8uE+ouKdkbFwV885oE/3l7i0S2I=;
        b=umPERE3uVeSmWCUmPafs6Z18oVg0Gjto0lzkXG1yxrYgWuZwy0WAcB6HFQLfq1tGSN
         hgaGTg4EQwlNjsB8um/Rq9M+vHrNROTePcoc6cAXqnkiKrIQiTG0k4tvpiMXZa2AB8CR
         4paXvAWkct/cKB8fKpmxBMa/kplkqH9DnptN2wVxTyLTDfmjEQaQImAh/BKXEqmpqlci
         KZ4DHG5wefCU/wfuVhKPCiEZ3pLNu2Puypv3eFacmgL3KIX4xwyMQZKmvWF8L4gSBr+1
         78rqE+WXMiXcbfQAmmVDtfRqmbuguMZfSlvMFM0EOS8atUUixmqzLdGaMXAeAfUbX53r
         E7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795293723; x=1795898523;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YQBbT4SzPrqTvV5G8uE+ouKdkbFwV885oE/3l7i0S2I=;
        b=D3va1Sp2UxLxXx//QLn4f9UnlzrX6YIKK3ACMOMIr4yV4d2HVkbuFoxWxRzt5FGoTg
         BuYnatf796cMsDvRYIiSwTAmLujQ5QGCMmH1X3HQ6WTGx92EV5RQ8fWk6sFbFRV6lDRp
         l15QU0A+k3MvrAzG40NRP0U7NhCidAGpmyDP7waeBi0vXTj9lQ0moGKWcgR42zCxipwM
         9+yFwmJtz37Gf1/COaCAmHHODIsTeRG/s5ObNPm39z4gTIr3HNWS7ib0XJKj8Epe60Or
         birYN8TIYCcr0sSIRbVJMwIclRhHgB1RdE2tBqlHyTMfpjH2BwkWTpna8PjYBloWKMnT
         RjSw==
X-Gm-Message-State: APuU4Z9tDaKjNO93l/ks2gudx6dQJ8xKcgHsbU4x3NLhmMB8M7KfGOaA
	wT+Vv279qql8hIeXkcP03oas0lBdF/ofGISl5ml6I9laLH3YrtwdNPyKeJlUAA==
X-Gm-Gg: AZFdTZdtuhV06fadGKMzDzu+49Svt7s3AsQl+9hk8qEZl6qlnkv+XWI7ULzStSip+JS
	MiEhbbr+FTqb08YZ//xz1r48Rq9sEEWWQ1U3KeS7KtuUxtNBu6jYifTJXxxEoimkdZCDSCh2P9r
	H7fjWuGx27GfUiFt39Es89pJZV5G6GgZEzVhC1WKjNWIowQRbZk0IeM2c4z94HAoInkm1kt68qS
	HhL7hGZ/aJ9oSJdUKkPo5AUTSzTqcVKef2KkD9jSrCkPkOmlZZ6MfoE1YaoNqj+QsmTsKdqgnyv
	gEpC/JB0S2qdueeoBkInEgBQATRg/H2pY45Cp2kkFYJVZJ4Xb//tQwF6vrSk0cVFvkEfoJrOTe8
	pZMTgZ6tilgjoVkgkw0t91RZEqA4Fh8ixmyLRHbUV/wgO8b8IKD/oVHryhkByjn1+nbwpH2kP2R
	u7O6DZBLxHE09BQxPW10sp7zxboF00iz9iXq7auknCqc3JhGzgLLhOwU80iCPVIzmrN7CRvMH3f
	pI8r2ckbMrTcGOvtD1/wwIazCgc/sv60FPyERRkx3G0JoUWUio06W1U2F+H47P6yhpPNxRgwwez
	lWhzjhK++1/3T0bJN4KYgI18kVgJfHUHyg==
X-Received: by 2002:a05:622a:2446:b0:54f:ba12:8496 with SMTP id d75a77b69052e-55d76a4a16amr115010191cf.46.1795293723139;
        Sat, 21 Nov 2026 12:42:03 -0800 (PST)
Received: from [127.0.0.1] ([172.203.213.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a24e91sm61250586d6.43.2026.11.21.12.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:42:02 -0800 (PST)
Message-Id: <pull.2425.v10.git.git.1795293722.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 20:41:57 +0000
Subject: [PATCH v10 0/5] branch: let --delete-merged find squash merged branches
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
    Tuomas Ahola <taahol@utu.fi>,
    Harald Nordgren <haraldnordgren@gmail.com>

Branches merged on GitHub with "Squash and merge" or "Rebase and merge" are
never deleted by git branch --delete-merged, because their tips are not
reachable from the upstream. This adds git branch --delete-integrated
<pattern>, which works like --delete-merged and also deletes such a branch
when some upstream commit contains all of its changes. It names that commit
in the output:

Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).


Changes in v10:

 * The file merge is now a plain text merge that ignores merge drivers set
   in .gitattributes. With a driver that favors one side, such as union, a
   branch could be deleted although its change was nowhere upstream. This
   also drops the index read added in v6.
 * Fix a branch that replaced a file or a submodule with a directory never
   being found as landed.
 * New commit: --dry-run also works with -d and -D. It is still rejected
   with options that do not delete branches.
 * Print the "Deleted" and "Would delete" messages in delete_branches() from
   one table of templates.
 * Rename branch_opted_out() to opted_out_of_delete_merged().
 * Reword the subject of the --delete-integrated commit to say "rebased or
   squash-merged branches".
 * Add tests for --dry-run, --quiet and branch.<name>.deleteMerged=false
   with --delete-integrated.

Changes in v9:

 * Fix --delete-integrated dying with "unable to read blob object" when a
   path was a submodule at the fork point and both the branch and upstream
   replaced it with different regular files. Such a branch is now kept.
 * Add a test for that case.

Changes in v8:

 * Reword commit messages.

Changes in v7:

 * Added a test that --delete-integrated keeps a branch whose changes did
   not land.
 * Read the index once before the walk in find_landed_commits(), instead of
   for every file merge at every candidate commit.
 * The commit message now says the merge uses this repository's attributes
   from the working tree and the index.

Changes in v6:

 * Read the index before the file merge, so .gitattributes that are only in
   the index are honored too.
 * Renamed the diff_options variables from opt to diffopt.

Changes in v5:

 * git branch -h lists --delete-integrated in the usage lines
 * Giving both --delete-merged and --delete-integrated dies with a short
   "cannot be used together" message instead of the full usage text

Changes in v4:

 * --delete-merged works as it does on master again: it only deletes
   branches whose tip is reachable from their upstream
 * New --delete-integrated <pattern> also deletes branches that were rebase
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

Harald Nordgren (5):
  branch: move the deleteMerged opt-out check into a helper
  branch: let delete_branches() name where a branch landed
  branch: let --dry-run preview -d and -D
  branch: add --delete-integrated for rebased or squash-merged branches
  branch: let --delete-integrated find branches merged onto changed
    files

 Documentation/config/branch.adoc |   8 +-
 Documentation/git-branch.adoc    |  24 +-
 builtin/branch.c                 | 400 ++++++++++++++++++++++---
 t/t3200-branch.sh                | 486 ++++++++++++++++++++++++++++++-
 4 files changed, 873 insertions(+), 45 deletions(-)


base-commit: f7de81456940dd6f3274e461149bba12965de609
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2425%2FHaraldNordgren%2Fbranch-delete-squashed-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2425/HaraldNordgren/branch-delete-squashed-v10
Pull-Request: https://github.com/git/git/pull/2425

Range-diff vs v9:

 1:  37ef7636e0 ! 1:  bccb3f4647 branch: move the deleteMerged opt-out check into a helper
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
       	return ret;
       }
       
     -+static bool branch_opted_out(struct strbuf *key, const char *branch_name,
     -+			     unsigned int flags)
     ++static bool opted_out_of_delete_merged(struct strbuf *key,
     ++				       const char *branch_name,
     ++				       unsigned int flags)
      +{
      +	int opt_out;
      +
     @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
      -		}
      -
      -		strset_add(&deletable_branch_names, branch_name);
     -+		if (!branch_opted_out(&key, branch_name, flags))
     ++		if (!opted_out_of_delete_merged(&key, branch_name, flags))
      +			strset_add(&deletable_branch_names, branch_name);
       	}
       
 2:  c4513f9ec1 ! 2:  efdf710038 branch: let delete_branches() name where a branch landed
     @@ builtin/branch.c: static void delete_branch_config(const char *branchname)
       {
       	struct commit *head_rev = NULL;
       	struct object_id oid;
     +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
     + 	struct string_list_item *item;
     + 	int branch_name_pos;
     + 	const char *fmt_remotes = "refs/remotes/%s";
     ++	static const char *const msg_templates[2][3] = {
     ++		{
     ++			N_("Would delete branch %s (was %s, landed as %s).\n"),
     ++			N_("Would delete remote-tracking branch %s (was %s).\n"),
     ++			N_("Would delete branch %s (was %s).\n"),
     ++		},
     ++		{
     ++			N_("Deleted branch %s (was %s, landed as %s).\n"),
     ++			N_("Deleted remote-tracking branch %s (was %s).\n"),
     ++			N_("Deleted branch %s (was %s).\n"),
     ++		},
     ++	};
     ++	bool dry_run = flags & DELETE_BRANCH_DRY_RUN;
     ++	const char *const *use_msg = msg_templates[!dry_run];
     + 
     + 	switch (kinds) {
     + 	case FILTER_REFS_REMOTES:
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
       		}
       
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int ki
       					flags)) {
       			if (!(flags & DELETE_BRANCH_SKIP_UNMERGED))
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
     + 		free(target);
     + 	}
     + 
     +-	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
     ++	if (!dry_run &&
     + 	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
     + 		ret = 1;
     + 
       	for_each_string_list_item(item, &refs_to_delete) {
       		char *describe_ref = item->util;
       		char *name = item->string;
     -+		struct commit *landed = landed_commits ?
     -+			strmap_get(landed_commits, name + branch_name_pos) : NULL;
     -+		const char *landed_abbrev = landed ?
     -+			repo_find_unique_abbrev(the_repository,
     -+						&landed->object.oid,
     -+						DEFAULT_ABBREV) : NULL;
     -+
     - 		if (flags & DELETE_BRANCH_DRY_RUN) {
     +-		if (flags & DELETE_BRANCH_DRY_RUN) {
      -			if (!(flags & DELETE_BRANCH_QUIET))
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
     +-				printf(remote_branch
     +-					? _("Would delete remote-tracking branch %s (was %s).\n")
     +-					: _("Would delete branch %s (was %s).\n"),
     +-					name + branch_name_pos, describe_ref);
     +-		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
     +-			char *refname = name + branch_name_pos;
      -			if (!(flags & DELETE_BRANCH_QUIET))
     +-				printf(remote_branch
     +-					? _("Deleted remote-tracking branch %s (was %s).\n")
     +-					: _("Deleted branch %s (was %s).\n"),
     +-					name + branch_name_pos, describe_ref);
     +-
     +-			delete_branch_config(refname);
     ++		char *refname = name + branch_name_pos;
     ++		struct commit *landed = landed_commits ?
     ++			strmap_get(landed_commits, refname) : NULL;
     ++
     ++		if (dry_run ||
     ++		    !refs_ref_exists(get_main_ref_store(the_repository), name)) {
      +			if (flags & DELETE_BRANCH_QUIET)
      +				;
      +			else if (landed)
     -+				printf(_("Deleted branch %s (was %s, landed as %s).\n"),
     -+				       refname, describe_ref, landed_abbrev);
     ++				printf(_(use_msg[0]), refname, describe_ref,
     ++				       repo_find_unique_abbrev(the_repository,
     ++							       &landed->object.oid,
     ++							       DEFAULT_ABBREV));
     ++			else if (remote_branch)
     ++				printf(_(use_msg[1]), refname, describe_ref);
      +			else
     - 				printf(remote_branch
     - 					? _("Deleted remote-tracking branch %s (was %s).\n")
     - 					: _("Deleted branch %s (was %s).\n"),
     ++				printf(_(use_msg[2]), refname, describe_ref);
     ++			if (!dry_run)
     ++				delete_branch_config(refname);
     + 		}
     + 		free(describe_ref);
     + 	}
      @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
       				      FILTER_REFS_BRANCHES,
       				      DELETE_BRANCH_SKIP_UNMERGED |
 -:  ---------- > 3:  43b6b02f69 branch: let --dry-run preview -d and -D
 3:  1f922a0034 ! 4:  d691a0463f branch: add --delete-integrated to delete rebase and squash merged branches
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    branch: add --delete-integrated to delete rebase and squash merged branches
     +    branch: add --delete-integrated for rebased or squash-merged branches
      
          A branch that upstream integrated with
      
     @@ Documentation/config/branch.adoc: for details).
      
       ## Documentation/git-branch.adoc ##
      @@ Documentation/git-branch.adoc: git branch (-c|-C) [<old-branch>] <new-branch>
     - git branch (-d|-D) [-r] <branch-name>...
     + git branch (-d|-D) [-r] [--dry-run] <branch-name>...
       git branch --edit-description [<branch-name>]
       git branch [--dry-run] (--delete-merged <pattern>)... [<branch-pattern>...]
      +git branch [--dry-run] (--delete-integrated <pattern>)... [<branch-pattern>...]
     @@ Documentation/git-branch.adoc: A branch whose work has not yet been merged into
      +	which branches are kept apply as for `--delete-merged`.
      +
       `--dry-run`::
     --	With `--delete-merged`, print which branches would be
     --	deleted and exit without touching any ref.  Useful for
     --	sanity-checking a wide pattern like `'origin/*'` before
     --	committing to the deletion.
     -+	With `--delete-merged` or `--delete-integrated`, print which
     -+	branches would be deleted and exit without touching any ref.
     -+	Useful for sanity-checking a wide pattern like `'origin/*'`
     -+	before committing to the deletion.
     +-	With `-d`, `-D` or `--delete-merged`, print which branches
     +-	would be deleted and exit without touching any ref.  A branch
     +-	that cannot be deleted is reported as an error, the same as
     +-	without `--dry-run`.  Useful for sanity-checking a wide pattern
     +-	like `'origin/*'` before committing to the deletion.
     ++	With `-d`, `-D`, `--delete-merged` or `--delete-integrated`,
     ++	print which branches would be deleted and exit without touching
     ++	any ref.  A branch that cannot be deleted is reported as an
     ++	error, the same as without `--dry-run`.  Useful for
     ++	sanity-checking a wide pattern like `'origin/*'` before
     ++	committing to the deletion.
       
       `-v`::
       `-vv`::
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +	unsigned short mode;
      +
      +	if (get_tree_entry(the_repository, get_commit_tree_oid(commit),
     -+			   change->path, &oid, &mode))
     ++			   change->path, &oid, &mode) || S_ISDIR(mode))
      +		return is_null_oid(&change->branch_oid);
      +	return oideq(&oid, &change->branch_oid) &&
      +	       mode == change->branch_mode;
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +	diff_free(&diffopt);
      +}
      +
     - static bool branch_opted_out(struct strbuf *key, const char *branch_name,
     - 			     unsigned int flags)
     - {
     + static bool opted_out_of_delete_merged(struct strbuf *key,
     + 				       const char *branch_name,
     + 				       unsigned int flags)
      @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstreams,
       	struct ref_array candidates = { 0 };
       	struct strset deletable_branch_names = STRSET_INIT;
     @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
       			continue;
      +		}
       
     - 		if (!branch_opted_out(&key, branch_name, flags))
     + 		if (!opted_out_of_delete_merged(&key, branch_name, flags))
       			strset_add(&deletable_branch_names, branch_name);
       	}
       
     @@ builtin/branch.c: static int delete_merged_branches(const struct strvec *upstrea
      +		const char *branch_name = searches[i].branch_name;
      +
      +		if (strmap_contains(&landed_commits, branch_name) &&
     -+		    !branch_opted_out(&key, branch_name, flags))
     ++		    !opted_out_of_delete_merged(&key, branch_name, flags))
      +			strset_add(&deletable_branch_names, branch_name);
      +	}
      +
     @@ builtin/branch.c: int cmd_branch(int argc,
      +			N_("like --delete-merged, but also delete branches whose changes landed upstream (repeatable)"),
      +			PARSE_OPT_NONEG, parse_opt_strvec),
       		OPT_BOOL(0, "dry-run", &dry_run,
     --			N_("with --delete-merged, only print which branches would be deleted")),
     -+			N_("with --delete-merged or --delete-integrated, only print which branches would be deleted")),
     + 			N_("only print which branches would be deleted")),
       		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
     - 		OPT_MERGED(&filter, N_("print only branches that are merged")),
     - 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
      @@ builtin/branch.c: int cmd_branch(int argc,
       
       	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
     @@ builtin/branch.c: int cmd_branch(int argc,
       	if (noncreate_actions > 1)
       		usage_with_options(builtin_branch_usage, options);
       
     --	if (dry_run && !delete_merged.nr)
     --		die(_("--dry-run requires --delete-merged"));
     -+	if (dry_run && !delete_merged.nr && !delete_integrated.nr)
     -+		die(_("--dry-run requires --delete-merged or --delete-integrated"));
     +-	if (dry_run && !delete && !delete_merged.nr)
     ++	if (dry_run && !delete && !delete_merged.nr && !delete_integrated.nr)
     + 		die(_("--dry-run can only be used when deleting branches"));
       
       	if (recurse_submodules_explicit) {
     - 		if (!submodule_propagate_branches)
      @@ builtin/branch.c: int cmd_branch(int argc,
       					     (quiet ? DELETE_BRANCH_QUIET : 0) |
       					     (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
     @@ t/t3200-branch.sh: test_expect_success '--delete-merged deletes only selected me
      +		EOF
      +	)
      +'
     ++
     ++test_expect_success '--delete-integrated deletes a squash merged branch that turned a file into a directory' '
     ++	(
     ++		cd upstream &&
     ++		git checkout next &&
     ++		echo content >item &&
     ++		git add item &&
     ++		git commit -m "add item" &&
     ++		git checkout main
     ++	) &&
     ++	setup_repo_for_delete_merged &&
     ++	(
     ++		cd repo &&
     ++		git checkout -b file-to-dir --track origin/next &&
     ++		git rm item &&
     ++		mkdir item &&
     ++		echo content >item/part &&
     ++		git add item &&
     ++		git commit -m "turn item into a directory" &&
     ++		git push origin file-to-dir &&
     ++		git checkout --detach
     ++	) &&
     ++	squash_merge_upstream file-to-dir &&
     ++	squash=$(git -C upstream rev-parse --short next) &&
     ++	(
     ++		cd repo &&
     ++		git fetch origin &&
     ++		sha=$(git rev-parse --short file-to-dir) &&
     ++
     ++		git branch --delete-integrated origin/next >actual 2>&1 &&
     ++		echo "Deleted branch file-to-dir (was $sha, landed as $squash)." >expect &&
     ++		test_cmp expect actual &&
     ++
     ++		check_branches <<-\EOF
     ++		main
     ++		EOF
     ++	)
     ++'
     ++
     ++test_expect_success '--delete-integrated honors --dry-run and --quiet' '
     ++	setup_repo_for_delete_merged &&
     ++	push_topic previewed previewed-work &&
     ++	squash_merge_upstream previewed &&
     ++	squash=$(git -C upstream rev-parse --short next) &&
     ++	(
     ++		cd repo &&
     ++		git fetch origin &&
     ++		sha=$(git rev-parse --short previewed) &&
     ++
     ++		git branch --dry-run --delete-integrated origin/next >actual 2>&1 &&
     ++		echo "Would delete branch previewed (was $sha, landed as $squash)." >expect &&
     ++		test_cmp expect actual &&
     ++
     ++		check_branches <<-\EOF &&
     ++		main
     ++		previewed
     ++		EOF
     ++
     ++		git branch --quiet --delete-integrated origin/next >actual 2>&1 &&
     ++		test_must_be_empty actual &&
     ++
     ++		check_branches <<-\EOF
     ++		main
     ++		EOF
     ++	)
     ++'
      +
       test_expect_success '--delete-merged keeps main despite a different default push remote' '
       	setup_repo_for_delete_merged &&
       	create_merged_branch on-next &&
     -@@ t/t3200-branch.sh: test_expect_success '--dry-run without --delete-merged is rejected' '
     - 	test_grep "requires --delete-merged" err
     +@@ t/t3200-branch.sh: test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '
     + 	)
     + '
     + 
     ++test_expect_success '--delete-integrated honours branch.<name>.deleteMerged=false' '
     ++	setup_repo_for_delete_merged &&
     ++	push_topic deleted opted-in-work &&
     ++	push_topic kept opted-out-work &&
     ++	squash_merge_upstream deleted &&
     ++	squash_merge_upstream kept &&
     ++	(
     ++		cd repo &&
     ++		git fetch origin &&
     ++		git config branch.kept.deleteMerged false &&
     ++
     ++		git branch --delete-integrated origin/next 2>err &&
     ++
     ++		test_grep "Skipping .kept." err &&
     ++		check_branches <<-\EOF
     ++		kept
     ++		main
     ++		EOF
     ++	)
     ++'
     ++
     + test_expect_success "branch -d still deletes a deleteMerged=false branch" '
     + 	setup_repo_for_delete_merged &&
     + 	create_merged_branch kept &&
     +@@ t/t3200-branch.sh: test_expect_success '--dry-run is rejected when not deleting branches' '
     + 	test_grep "can only be used when deleting branches" err
       '
       
      +test_expect_success '--delete-integrated cannot be combined with --delete-merged' '
 4:  ef65700303 ! 5:  5718110ba2 branch: let --delete-integrated find branches merged onto changed files
     @@ Commit message
          unchanged. This has to read the files, so in a partial clone it may
          download blobs.
      
     -    The merge uses the attributes of this repository, from the working tree
     -    and the index, the same as a merge run here would. A merge driver that
     -    only the upstream repository has is not seen. In a bare repository only
     -    info/attributes and the global file apply.
     +    The merge is always the built-in text merge, and merge drivers set
     +    with attributes are not used. A driver that favors one side, as "union"
     +    or a custom driver may, can leave the upstream version unchanged even
     +    though the branch's change is nowhere upstream, and the branch would
     +    then be deleted. A custom driver is also an arbitrary command that a
     +    branch cleanup should not run.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-branch.adoc: remove it anyway.
      +	that commit. A file counts when the commit has the branch's
      +	version of it. It also counts when merging the branch's version
      +	into the commit's version leaves the commit's version unchanged.
     -+	That merge reads the file, and in a partial clone it may download
     -+	blobs. The same rules for which branches are kept apply as for
     -+	`--delete-merged`.
     ++	That merge is a plain text merge that ignores merge drivers set
     ++	in linkgit:gitattributes[5]. It reads the file, and in a partial
     ++	clone it may download blobs. The same rules for which branches
     ++	are kept apply as for `--delete-merged`.
       
       `--dry-run`::
     - 	With `--delete-merged` or `--delete-integrated`, print which
     + 	With `-d`, `-D`, `--delete-merged` or `--delete-integrated`,
      
       ## builtin/branch.c ##
      @@
     - #include "diff.h"
     - #include "diffcore.h"
       #include "hex.h"
     -+#include "merge-ll.h"
       #include "revision.h"
       #include "tree-walk.h"
      +#include "xdiff-interface.h"
     @@ builtin/branch.c: static void collect_branch_changes(struct landing_search *sear
       
      -static int change_landed(const struct branch_change *change,
      -			 struct commit *commit)
     ++static bool mergeable_as_text(const mmfile_t *file)
     ++{
     ++	return file->size <= MAX_XDIFF_SIZE &&
     ++	       !buffer_is_binary(file->ptr, file->size);
     ++}
     ++
      +static int merge_keeps_upstream(const struct branch_change *change)
      +{
      +	mmfile_t base, upstream, branch;
      +	mmfile_t result = { 0 };
     ++	xmparam_t xmp = { .level = XDL_MERGE_ZEALOUS };
      +	int ret;
      +
      +	read_mmblob(&base, the_repository->objects, &change->base_oid);
      +	read_mmblob(&upstream, the_repository->objects, &change->upstream_oid);
      +	read_mmblob(&branch, the_repository->objects, &change->branch_oid);
     -+	ret = ll_merge(&result, change->path, &base, "base",
     -+		       &upstream, "upstream", &branch, "branch",
     -+		       the_repository->index, NULL) == LL_MERGE_OK &&
     ++	ret = mergeable_as_text(&base) && mergeable_as_text(&upstream) &&
     ++	      mergeable_as_text(&branch) &&
     ++	      !xdl_merge(&base, &upstream, &branch, &xmp, &result) &&
      +	      result.size == upstream.size &&
      +	      !memcmp(result.ptr, upstream.ptr, upstream.size);
      +
     @@ builtin/branch.c: static void collect_branch_changes(struct landing_search *sear
       	unsigned short mode;
       
       	if (get_tree_entry(the_repository, get_commit_tree_oid(commit),
     --			   change->path, &oid, &mode))
     +-			   change->path, &oid, &mode) || S_ISDIR(mode))
      -		return is_null_oid(&change->branch_oid);
      -	return oideq(&oid, &change->branch_oid) &&
      -	       mode == change->branch_mode;
     -+			   change->path, &change->upstream_oid, &mode))
     ++			   change->path, &change->upstream_oid, &mode) ||
     ++	    S_ISDIR(mode))
      +		return is_null_oid(&change->branch_oid) ?
      +			CHANGE_LANDED : CHANGE_MISSING;
      +	if (oideq(&change->upstream_oid, &change->branch_oid))
     @@ builtin/branch.c: static void collect_branch_changes(struct landing_search *sear
       	return 1;
       }
       
     -@@ builtin/branch.c: static void find_landed_commits(struct landing_search *searches,
     - 	diffopt.no_free = 1;
     - 	diff_setup_done(&diffopt);
     - 	init_changed_paths(&cache);
     -+	repo_read_index(the_repository);
     - 
     - 	for (size_t i = 0; i < searches_nr; i++) {
     - 		struct commit *landed;
      
       ## t/t3200-branch.sh ##
      @@ t/t3200-branch.sh: test_expect_success '--delete-integrated deletes a squash merged branch that was
     @@ t/t3200-branch.sh: test_expect_success '--delete-integrated deletes a squash mer
      +		EOF
      +	)
      +'
     ++
     ++test_expect_success '--delete-integrated ignores merge drivers' '
     ++	(
     ++		cd upstream &&
     ++		git checkout next &&
     ++		test_write_lines 1 2 3 4 5 6 7 8 9 10 >unioned &&
     ++		git add unioned &&
     ++		git commit -m "add unioned" &&
     ++		git checkout main
     ++	) &&
     ++	setup_repo_for_delete_merged &&
     ++	(
     ++		cd repo &&
     ++		mkdir -p .git/info &&
     ++		echo "unioned merge=union" >.git/info/attributes &&
     ++		git checkout -b drops-line --track origin/next &&
     ++		test_write_lines 1 2 3 4 6 7 8 9 10 >unioned &&
     ++		git commit -a -m "drop line 5" &&
     ++		git push origin drops-line &&
     ++		git checkout --detach
     ++	) &&
     ++	(
     ++		cd upstream &&
     ++		git checkout next &&
     ++		test_write_lines 1 2 3 4 five 6 7 8 9 10 >unioned &&
     ++		git commit -a -m "edit line 5" &&
     ++		git checkout main
     ++	) &&
     ++	(
     ++		cd repo &&
     ++		git fetch origin &&
     ++
     ++		git branch --delete-integrated origin/next >actual 2>&1 &&
     ++		test_must_be_empty actual &&
     ++
     ++		check_branches <<-\EOF
     ++		drops-line
     ++		main
     ++		EOF
     ++	)
     ++'
      +
       test_expect_success '--delete-integrated reports a merge plainly next to an unmerged branch' '
       	setup_repo_for_delete_merged &&

-- 
gitgitgadget
