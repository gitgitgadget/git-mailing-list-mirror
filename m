Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521334;
	b=zUDtHQsgbNKChqRJlNO4dd7t5Inyg2uSJ/wDY0Q70zc9AwKrzptWhAmEC1VfLkbBU04C
	 FAx4EBUtjIKpp66uDGNdVfJ2SvDlBHCyYE2mnNnaNNL/iT7m8VzR1OJZ/V8UNY0r0+wgw
	 Jj4wXd/7IONgTbaW5QGq3wv26lK50lBWAh/v5fFIvNtwiPzeiKh1UahyPtXYh8EXlbOlW
	 cvXVNJF6ea9xaJiHuLnJLWiHbT2lHAEtsaucXjJqtgqRDphoSUftogDQaoaO/tU7FvhHW
	 9okMU2nmqJsP7Wn1cyXF6o3OLXxpiZ1Fs9bL1lyDfGOMj5yhrjZL8bmSAHPxIykUuDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=enBI+pV804vf+s6ySVc+EoYmlornUTDzfe2ZDltAQWg=;
	b=pU3q4LxX2utS/G6+K0QiyRwgtEZQ+X20A9IAQJxtNjGVgyax918SMLlOEGqWg0VOhi4Y
	 7WkBFQ43c2iIs4ur703gi30IDjWvbnst1AppGzzI4JLxFH4gvutTovDypNjVr194e0Cnw
	 luWfUEzl1OcCoQjJJ12Zmkd/w0IEsMuazsr8rAy9DpDNIWYzEe+aiwsmxWTaIGT1/moLw
	 Pv9/ORYYCCEpEjd+MCYA/lPYQLJTwXc2vyC09EW8spe8Q9XA8/Ueqki9Yha+tVFbrIE9O
	 rDW6RJns0+MP74ZSnDJkAhCIUV7GdjYGQWjulMzWyzWIGKFv/XienkLMmxHrBOXpaiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bPE9k7uR;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D1A606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 08:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90D1A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bPE9k7uR
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3535a54bed9so3102866eec.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521333; x=1794126133; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=enBI+pV804vf+s6ySVc+EoYmlornUTDzfe2ZDltAQWg=;
        b=bPE9k7uRML2636+lGCzP9DA1BVQVCB0u5zdAXlJruqJs6s5VdoVZidiE+oFyuKIXwC
         G99YIT/1xk40t3DP26uxfu+7D0CGIQQPYCdfBdy6r7Q7PVgLyMtNs39b/+NmEPnCpTvP
         FXrls4aMC1ce9pg1VMYTuVgS1q6cByfbgjuqBl6/LcmML7h/9f4rLxIy/yEmA/X7ijGB
         iMiMMgElnaUvMpYnI2LvpwQsx3pWtnHxWIY/gDaeQ7LDYnMRKSr2xJS6EFRHwJMpI4Rh
         H06HK6PCmz50Vo9mK6ulzNbAghj3r0+IauUiBNKLJ40/2PHo5394sbnpsZS68jiBtvp+
         fbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521333; x=1794126133;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=enBI+pV804vf+s6ySVc+EoYmlornUTDzfe2ZDltAQWg=;
        b=MMEt/1dNNHM9Zs0UXNnMNl4KSICIk7gBh+qizJHh5YtGPyOqssZ37XCdDLdSrNcaEo
         2pj7B03cWZhVDzdPZQFn+fV8hmL5Vtldv5z4YLgzwmu2MgHzju5EjyoNXGUC62cULbFQ
         oIPIRlAdZT9gDDizcccWc4jDy6bLxDS6qbHu7AXXSJfLHPNJxjSpCfxox1qWX8PZOBcz
         8IWW7mKbDxDog0IXU3JBQBzurdGeAMYym+OeMfNUALSgv5AJlm6pfxXcORVVJYpRGRxy
         mOMNZEt3i6c/mzcEI4LfDkcFDWNmSOyFTvr1XYUNBkxrL54FmNIOSfnK33igdtY/S0pI
         xlEA==
X-Gm-Message-State: APuU4Z+YLiVhcHNNkxoNoh4TyjanIccdUczjDKZOwDMl2VQJgdv3iqXg
	t8txRs8kgbT2+GCpBxk7fo9jzt41nDCz6xi0lQV43pa8qML90wswjeMIfhkxxvyk
X-Gm-Gg: AYBFou0QiRoEmJldHyhG7DyFGlyuoHRxPZV+LgmGT6r2inXf77aZei2tH2xFjB9fV7g
	lrwW6u5B39v79fh1NqvCwzfFM2dSj7p1xIX1BqAcKtIZJPAO4DB80dYy2wvGGifGJnMEvjvFdy7
	CQY0wUDpT0zhyMuZfKQi6kCssyEF7cNV/r2shLmxBLdCoLg1p+ESjufyoUtDaHWWloxy0tydNdo
	HFmQU4391hLQ0FdvkqfAUrilLRnJZpbXUS6EabXjJVaTqfeayyjRiVnV/Y0nS2aCCBr9Fa4sc6W
	2x5EHAEszwdBq+laoyU2F2TaOX9QqgFWgX5WuDlD4I+/dBzgr/sHvIKHLAT8BCWnnwjuT2BI1VI
	2NpZsu/ettp8IspWmQ0E79RtFqAK4+2rL4UfW02YIRr1SOpSnZAzqiZS4n1Pbmu/L9D1A0XFWYV
	uXntMqwRaQtd0jZom3jh4EodHEFwNfqVRKDJCB+/XqNopivZR9wWcJFdJ4Vg4OAtV6Eg4RtuA9a
	dooTwAFeYVeMTCkys1x/JwNpQjxMCrefDnEcCJk5Ls0ogNzrcA2z0pwysm5wIOjg6Y9v5AKcNZO
	Nch8QAGjyjcDKk8whtz42DJJNABGNJA=
X-Received: by 2002:a05:693c:87cd:20b0:366:fbdb:2070 with SMTP id 5a478bee46e88-36a424de53amr11363585eec.34.1793521332523;
        Sun, 01 Nov 2026 01:22:12 -0700 (PDT)
Received: from [127.0.0.1] ([4.242.197.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm28547814eec.15.2026.11.01.01.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:22:11 -0700 (PDT)
Message-Id: <pull.2425.v6.git.git.1793521331.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 01 Nov 2026 08:22:07 +0000
Subject: [PATCH v6 0/4] branch: let --delete-merged find squash merged branches
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

Harald Nordgren (4):
  branch: move the deleteMerged opt-out check into a helper
  branch: let delete_branches() name where a branch landed
  branch: add --delete-integrated to delete rebase and squash merged
    branches
  branch: let --delete-integrated find branches merged onto changed
    files

 Documentation/config/branch.adoc |   8 +-
 Documentation/git-branch.adoc    |  22 +-
 builtin/branch.c                 | 361 +++++++++++++++++++++++++++++--
 t/t3200-branch.sh                | 218 +++++++++++++++++++
 4 files changed, 579 insertions(+), 30 deletions(-)


base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2425%2FHaraldNordgren%2Fbranch-delete-squashed-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2425/HaraldNordgren/branch-delete-squashed-v6
Pull-Request: https://github.com/git/git/pull/2425

Range-diff vs v5:

 1:  090aec5725 = 1:  e728b4ed0d branch: move the deleteMerged opt-out check into a helper
 2:  24180bf4a2 = 2:  9858c8c81e branch: let delete_branches() name where a branch landed
 3:  bf30f57ceb ! 3:  92bd9afda4 branch: add --delete-integrated to delete rebase and squash merged branches
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +static void collect_branch_changes(struct landing_search *search,
      +				   struct commit *base)
      +{
     -+	struct diff_options opt;
     ++	struct diff_options diffopt;
      +
     -+	repo_diff_setup(the_repository, &opt);
     -+	opt.flags.recursive = 1;
     -+	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
     -+	diff_setup_done(&opt);
     ++	repo_diff_setup(the_repository, &diffopt);
     ++	diffopt.flags.recursive = 1;
     ++	diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
     ++	diff_setup_done(&diffopt);
      +	diff_tree_oid(get_commit_tree_oid(base),
     -+		      get_commit_tree_oid(search->rev), "", &opt);
     ++		      get_commit_tree_oid(search->rev), "", &diffopt);
      +	for (int i = 0; i < diff_queued_diff.nr; i++) {
      +		struct diff_filepair *p = diff_queued_diff.queue[i];
      +		struct branch_change *change;
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +		       &p->two->oid : null_oid(the_hash_algo));
      +		change->branch_mode = p->two->mode;
      +	}
     -+	diff_flush(&opt);
     ++	diff_flush(&diffopt);
      +}
      +
      +static int change_landed(const struct branch_change *change,
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +}
      +
      +static struct string_list *changed_paths_of(struct changed_paths *cache,
     -+					    struct diff_options *opt,
     ++					    struct diff_options *diffopt,
      +					    struct commit *commit)
      +{
      +	struct string_list **paths = changed_paths_at(cache, commit);
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +		die(_("could not parse commit %s"),
      +		    oid_to_hex(&parent->object.oid));
      +	diff_tree_oid(parent ? get_commit_tree_oid(parent) : NULL,
     -+		      get_commit_tree_oid(commit), "", opt);
     ++		      get_commit_tree_oid(commit), "", diffopt);
      +	for (int i = 0; i < diff_queued_diff.nr; i++) {
      +		struct diff_filepair *p = diff_queued_diff.queue[i];
      +
      +		string_list_append(*paths, p->two->path);
      +	}
     -+	diff_flush(opt);
     ++	diff_flush(diffopt);
      +	string_list_sort(*paths);
      +	return *paths;
      +}
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +
      +static struct commit *find_landed_commit(struct landing_search *search,
      +					 struct changed_paths *cache,
     -+					 struct diff_options *opt)
     ++					 struct diff_options *diffopt)
      +{
      +	struct commit *commit, *landed = NULL;
      +	struct strvec args = STRVEC_INIT;
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +	if (prepare_revision_walk(&revs))
      +		die(_("revision walk setup failed"));
      +	while (!landed && (commit = get_revision(&revs)))
     -+		if (touches_changes(changed_paths_of(cache, opt, commit),
     ++		if (touches_changes(changed_paths_of(cache, diffopt, commit),
      +				    search) &&
      +		    changes_landed(search, commit))
      +			landed = commit;
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +				struct strmap *landed_commits)
      +{
      +	struct changed_paths cache;
     -+	struct diff_options opt;
     ++	struct diff_options diffopt;
      +
      +	for (size_t i = 0; i < searches_nr; i++) {
      +		struct landing_search *search = &searches[i];
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +		commit_list_free(merge_bases);
      +	}
      +
     -+	repo_diff_setup(the_repository, &opt);
     -+	opt.flags.recursive = 1;
     -+	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
     -+	opt.no_free = 1;
     -+	diff_setup_done(&opt);
     ++	repo_diff_setup(the_repository, &diffopt);
     ++	diffopt.flags.recursive = 1;
     ++	diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
     ++	diffopt.no_free = 1;
     ++	diff_setup_done(&diffopt);
      +	init_changed_paths(&cache);
      +
      +	for (size_t i = 0; i < searches_nr; i++) {
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
      +
      +		if (!searches[i].changes_nr)
      +			continue;
     -+		landed = find_landed_commit(&searches[i], &cache, &opt);
     ++		landed = find_landed_commit(&searches[i], &cache, &diffopt);
      +		if (landed)
      +			strmap_put(landed_commits, searches[i].branch_name,
      +				   landed);
      +	}
      +
      +	deep_clear_changed_paths(&cache, free_changed_paths);
     -+	opt.no_free = 0;
     -+	diff_free(&opt);
     ++	diffopt.no_free = 0;
     ++	diff_free(&diffopt);
      +}
      +
       static bool branch_opted_out(struct strbuf *key, const char *branch_name,
 4:  9443055242 ! 4:  006a57d7d1 branch: let --delete-integrated find branches merged onto changed files
     @@ builtin/branch.c: static void collect_branch_changes(struct landing_search *sear
       		       &p->two->oid : null_oid(the_hash_algo));
       		change->branch_mode = p->two->mode;
      @@ builtin/branch.c: static void collect_branch_changes(struct landing_search *search,
     - 	diff_flush(&opt);
     + 	diff_flush(&diffopt);
       }
       
      -static int change_landed(const struct branch_change *change,
     @@ builtin/branch.c: static void collect_branch_changes(struct landing_search *sear
      +	mmfile_t result = { 0 };
      +	int ret;
      +
     ++	repo_read_index(the_repository);
      +	read_mmblob(&base, the_repository->objects, &change->base_oid);
      +	read_mmblob(&upstream, the_repository->objects, &change->upstream_oid);
      +	read_mmblob(&branch, the_repository->objects, &change->branch_oid);

-- 
gitgitgadget
