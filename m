Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED99257980D
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195733; cv=none; b=Mwo4A5rvzg9b7s4WHJETZ4HhgowQGEve4Ke0qkG51GzNOTRDnB2YoHRxv91NynRNQOhIX3n/G4jDjtarbomWE057NBIhVs7dft06x5Pi3nMnRC383MUsv4RUuOCjrIbjnEQ8PUEQJohPSYl0EPKZQ8bwXZIZBCvxZ6p4Dmmq9Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195733; c=relaxed/simple;
	bh=ZTMqQqtf667hpPPw+rfEY1ktgX8294yW5EsxsVxMHvM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tWnxJsJXaTTzEzec/LRejQtxLW7XYTyPIr/CuulTGgF8kShj5FRMoDXP86y88L4pIeJ9UG5e0Eud8bpBGJ+z4oeVa9wBrNdsWjaDlINbBadDS0vvpx78UiUl9SFZfEh5s9V8CGO9uitOQ5M7PQuCrE98GOffJxCzmH6V0vloXp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NE6QTht8; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NE6QTht8"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c6b4783778so825496b6e.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 13:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790195723; x=1790800523; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AZl2e/P13IHWqteEoXMADoI/iZCTueZXp1qDcJOMtiI=;
        b=NE6QTht8VCrWTWscKst58C4c8u7vsTv5VXYtQnUhpTpf2Y43OsozpX6hCk/GCCZwwr
         8gd2MHHWJSqcMXwpAMYuG3bsJpmMzqHQZUjYkGnrzVPqrhiKYaXj9DjuzVWDiE+xVfFv
         kJU3x14dWqSl4V12Fe0qoU76XnPAW1yeOGz65GmOcF1DJALRWN+Kl3t/3lnG0HZ9+S41
         AYOcygPql+GiVPmiW+Kt8uInoQnCczyh3rExOaLjivTHN7yYqd6EUv04WPZBfQ9WEiFP
         gulLhufX9PTMdoQsmF8H6RVOGv0eAHXSqOMOJqLjH3uip6i9WlnLtgo1EQaa4Nqt1eoJ
         l9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790195723; x=1790800523;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AZl2e/P13IHWqteEoXMADoI/iZCTueZXp1qDcJOMtiI=;
        b=qkeW2jYz0d/qUnWH30HLGX0yxt61kR77UPdMnZ3HCvArZAZ+AYiiUDCt6/rn4ns60v
         OvCe2kb7LdDESHt3ZSNtfkBCtuMGn2K5EDHMmSLttYgXnsng9wwp18OnxiafqS3qTZ8R
         eEwRskGnfu9btrLyVsnNKPQRqNTUqBaBCy6YfftOQ4CgB/HcoqxrNop7Ks6LoO3ezSkl
         pNuULKrEWlGB9PIgejzRgyGvUspCo+RGrdzfHNksrXYHKm4kKTKoV8qGOtfFx6Xs0b/F
         9e3gWdAYmJ/wGg8G4E9xzk9kKKy3YKmckgcGG/aq45NiohFce4+jI74DwcrYilymUyNM
         J4LQ==
X-Gm-Message-State: AFuF++lxOwuDiN8vQJox9KuCCNLUWnTO2D6M2IStwTAiNiNlssfKVqVd
	w34z81f28QVJp68cQLCU7fpc9U+0R8Ga/lwUZ6hLcOhtd4tw7c7kciingfYECoxZ
X-Gm-Gg: AYBFou0+9RvgNBcpJwvV7h82riM5Oo782irmzKPNeLeUYmbOiKJl3wfEEISMmEioWul
	rnw6WVnzwUtFReYp+8bp5PA7iHFutHGzkyFoVRwQs7fpIEDOCIYp3EU96SoaLadatjLMS/W2qta
	0yHGXbalBzsZJFlda/UwfWXMmiJMCd523lEZyeehlaMfin8ppo+eoLC0YeB13F8IEfUbndVGCcX
	Fs8jY2prP3o14T/b173v0oxyIICU6XznVTx+TDMLOvmHoi1PNZ4sD8lqCUU1HpilDoZAEG00bk1
	sEZC5B862PFRRAT+YB9EqdjbrvNeHW7t8Z1eCGCVz8l9+25+elvI0Qmp2kWgU39vJzv+uEAYELd
	C6GNd40YUmH2ajdRcYH8P4QgR8cdBb1N4R83v5+Cz4kBQe/wcCSdSy7lbkFHHmIyOMX3QUypQiK
	xfGVJCl8cGIyTyamc/S9BKakQmJwXtVcIVT/3315AyuP9BPIIRIee25ETRdcYsEVeS3OjSQ4GO1
	A==
X-Received: by 2002:a05:6808:5394:b0:4c1:760:e5d6 with SMTP id 5614622812f47-4d728c287c5mr470230b6e.5.1790195722409;
        Wed, 23 Sep 2026 13:35:22 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.32.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81603ad0f20sm4457081a34.9.2026.09.23.13.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:35:21 -0700 (PDT)
Message-Id: <pull.2412.v2.git.git.1790195720941.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Sep 2026 20:35:20 +0000
Subject: [PATCH v2] fetch: avoid fetching every branch of a new remote in a
 shallow repo
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

git remote add sets a new remote up to fetch every branch by default.
In an already shallow repository, that turns the next plain fetch or
pull into a slow or hanging one, even when only one or two branches
are ever used.

Add a special fetch refspec, "+:", that fetches only the branches our
local branches are built on, plus the remote's default branch so a
brand new remote is usable right away, without needing to first set
anything up to track it. git remote add now uses it instead of the
usual wildcard refspec whenever the repository is already shallow.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    fetch: avoid fetching every branch of a new remote in a shallow repo
    
    Avoid fetching every branch of a new remote in a shallow repo.
    
    Changes in v2:
    
     * Replaced the opt-in fetch.shallow config entirely with a new special
       fetch refspec (+:) that git remote add now defaults new remotes to in
       a shallow repository. The new refspec fetches whichever branches any
       local branch tracks at that remote, plus the remote's default branch.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v2
Pull-Request: https://github.com/git/git/pull/2412

Range-diff vs v1:

 1:  ec05d3e2d6 ! 1:  f04f5ce219 fetch: add config to avoid fetching every branch in shallow repo
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    fetch: add config to avoid fetching every branch in shallow repo
     +    fetch: avoid fetching every branch of a new remote in a shallow repo
      
     -    In a shallow, sparsely checked out clone of a repository with many
     -    branches, plain git pull can take minutes or hang outright, even
     -    though only one branch is actually being worked on.
     +    git remote add sets a new remote up to fetch every branch by default.
     +    In an already shallow repository, that turns the next plain fetch or
     +    pull into a slow or hanging one, even when only one or two branches
     +    are ever used.
      
     -    Add fetch.shallow, off by default. When enabled, a fetch or pull for
     -    a shallow repository that isn't already scoped to specific refs
     -    fetches only the current branch's tracked upstream, instead of every
     -    branch the remote has. git pull ultimately runs such a fetch under
     -    the hood, so this fixes pull the same way. It has no effect once the
     -    repository is no longer shallow, and no effect on a fetch of a remote
     -    the current branch doesn't track, both fall back to the existing
     -    behavior.
     -
     -    This is opt-in rather than automatic because it changes what a plain
     -    fetch or pull leaves in refs/remotes/<name>/ for anyone who currently
     -    relies on it syncing every branch of a shallow remote, not just the
     -    one they are on. Scoping remote.<name>.fetch by hand already covers
     -    this for a single remote, but that requires knowing the config exists
     -    and applies it permanently, even to branches that are not currently
     -    checked out.
     -
     -    The remote's recorded default branch (remotes/<name>/HEAD) is kept up
     -    to date the same way it always is, only the other branches are
     -    skipped.
     +    Add a special fetch refspec, "+:", that fetches only the branches our
     +    local branches are built on, plus the remote's default branch so a
     +    brand new remote is usable right away, without needing to first set
     +    anything up to track it. git remote add now uses it instead of the
     +    usual wildcard refspec whenever the repository is already shallow.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     - ## Documentation/config/fetch.adoc ##
     -@@ Documentation/config/fetch.adoc: remove the value for the `fetch.bundleCreationToken` value before fetching.
     - `never`;;
     - 	Never create or modify the `remotes/<name>/HEAD` symbolic-ref.
     - --
     -+
     -+`fetch.shallow`::
     -+	If true, and the repository is a shallow repository (see
     -+	linkgit:git-clone[1] `--depth`), a fetch or `git pull` that names no
     -+	explicit refspec and would otherwise fall back to the remote's
     -+	configured `remote.<name>.fetch` refspec instead fetches only the
     -+	current branch's upstream, when that upstream is on the remote being
     -+	fetched. This avoids negotiating history for every branch the remote
     -+	advertises, which can be slow on a shallow repository that tracks
     -+	many disjoint shallow histories. It has no effect on a fetch that
     -+	names an explicit remote or refspec, and no effect on a repository
     -+	that is not shallow. Defaults to false.
     + ## Documentation/git-remote.adoc ##
     +@@ Documentation/git-remote.adoc: Add a remote named _<name>_ for the repository at
     + _<URL>_.  The command `git fetch <name>` can then be used to create and
     + update remote-tracking branches `<name>/<branch>`.
     + +
     ++If the repository is already a shallow repository (see linkgit:git-clone[1]
     ++`--depth`) and neither `-t` nor `--mirror` is given, the remote is set up
     ++with the special tracking refspec (see the _<refspec>_ entry in
     ++linkgit:git-fetch[1]) instead of the default glob refspec, so that
     ++`git fetch <name>` does not need to negotiate history for every branch
     ++the remote has.
     +++
     + With `-f` option, `git fetch <name>` is run immediately after
     + the remote information is set up.
     + +
     +
     + ## Documentation/pull-fetch-param.adoc ##
     +@@ Documentation/pull-fetch-param.adoc: Negative refspecs can themselves be pattern refspecs. However, they may only
     + contain a _<src>_ and do not specify a _<dst>_. Fully spelled out hex object
     + names are also not supported.
     + +
     ++The special refspec `:` (or `+:` to allow non-fast-forward updates)
     ++directs Git to fetch whichever branches at the remote our local branches
     ++have as their `@{upstream}`, plus the remote's default branch, which is
     ++always included so that it is available even before anything is set up
     ++to track it. Unlike the same syntax when pushing, the local branch name
     ++plays no role here beyond identifying which remote branch to fetch: the
     ++result is written to `refs/remotes/<remote>/<branch>` using the remote's
     ++own branch name, and several local branches built on the same remote
     ++branch only cause it to be fetched once.
      ++
     -+`remotes/<name>/HEAD` is still kept up to date per `fetch.followRemoteHEAD`
     -+while this is in effect, only the other branches are skipped.
     + `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`;
     + it requests fetching everything up to the given tag.
     + +
      
       ## builtin/fetch.c ##
     -@@ builtin/fetch.c: struct fetch_config {
     - 	int recurse_submodules;
     - 	int parallel;
     - 	int submodule_fetch_jobs;
     -+	int shallow;
     - };
     - 
     - static int git_fetch_config(const char *k, const char *v,
     -@@ builtin/fetch.c: static int git_fetch_config(const char *k, const char *v,
     - 		return 0;
     +@@ builtin/fetch.c: static void filter_prefetch_refspec(struct refspec *rs)
       	}
     + }
       
     -+	if (!strcmp(k, "fetch.shallow")) {
     -+		fetch_config->shallow = git_config_bool(k, v);
     -+		return 0;
     ++static void fetch_tracked_branches(struct remote *remote,
     ++				   const struct ref *remote_refs,
     ++				   struct ref ***tail,
     ++				   char **default_branch_out,
     ++				   int force)
     ++{
     ++	struct string_list tracked = STRING_LIST_INIT_DUP;
     ++	struct string_list_item *item;
     ++	struct ref *head;
     ++	char *default_branch = NULL;
     ++
     ++	branches_tracking_remote(remote, &tracked);
     ++
     ++	head = get_remote_ref(remote_refs, "HEAD");
     ++	if (head && head->symref && *head->symref) {
     ++		default_branch = xstrdup(head->symref);
     ++		string_list_insert(&tracked, default_branch);
     ++	}
     ++	free_one_ref(head);
     ++
     ++	for_each_string_list_item(item, &tracked) {
     ++		struct refspec_item ref = { .force = force };
     ++		const char *branch_name = item->string;
     ++		int is_default_branch = default_branch &&
     ++			!strcmp(item->string, default_branch);
     ++
     ++		skip_prefix(branch_name, "refs/heads/", &branch_name);
     ++		ref.src = xstrdup(is_default_branch ? "HEAD" : item->string);
     ++		ref.dst = xstrfmt("refs/remotes/%s/%s", remote->name, branch_name);
     ++		get_fetch_map(remote_refs, &ref, tail, 1);
     ++		free(ref.src);
     ++		free(ref.dst);
     ++	}
     ++
     ++	if (default_branch && default_branch_out) {
     ++		const char *branch_name = default_branch;
     ++		skip_prefix(branch_name, "refs/heads/", &branch_name);
     ++		*default_branch_out = xstrdup(branch_name);
      +	}
      +
     - 	if (!strcmp(k, "fetch.followremotehead")) {
     - 		if (!v)
     - 			return config_error_nonbool(k);
     ++	free(default_branch);
     ++	string_list_clear(&tracked, 0);
     ++}
     ++
     + static struct ref *get_ref_map(struct remote *remote,
     + 			       const struct ref *remote_refs,
     + 			       struct refspec *rs,
     +-			       int tags, int *autotags)
     ++			       int tags, int *autotags,
     ++			       char **bootstrap_head_branch)
     + {
     + 	int i;
     + 	struct ref *rm;
     +@@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     + 		     /* Note: has_merge implies non-NULL branch->remote_name */
     + 		     (has_merge && !strcmp(branch->remote_name, remote->name)))) {
     + 			for (i = 0; i < remote->fetch.nr; i++) {
     ++				if (remote->fetch.items[i].tracking) {
     ++					fetch_tracked_branches(remote, remote_refs, &tail,
     ++								bootstrap_head_branch,
     ++								remote->fetch.items[i].force);
     ++					continue;
     ++				}
     + 				get_fetch_map(remote_refs, &remote->fetch.items[i], &tail, 0);
     + 				if (remote->fetch.items[i].dst &&
     + 				    remote->fetch.items[i].dst[0])
     +@@ builtin/fetch.c: static void warn_set_head(const char *remote, const char *head_name,
     + }
     + 
     + static int set_head(const struct ref *remote_refs, struct remote *remote,
     +-			int follow_remote_head)
     ++			int follow_remote_head, const char *known_head_branch)
     + {
     + 	int result = 0, create_only, baremirror, was_detached;
     + 	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
     + 		      b_local_head = STRBUF_INIT;
     + 	const char *no_warn_branch = remote->no_warn_branch;
     + 	char *head_name = NULL;
     +-	struct ref *ref, *matches;
     ++	struct ref *ref, *matches = NULL;
     + 	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
     + 	struct refspec_item refspec = {
     + 		.force = 0,
     +@@ builtin/fetch.c: static int set_head(const struct ref *remote_refs, struct remote *remote,
     + 	struct string_list heads = STRING_LIST_INIT_DUP;
     + 	struct ref_store *refs = get_main_ref_store(the_repository);
     + 
     +-	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
     +-	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
     +-				    fetch_map, REMOTE_GUESS_HEAD_ALL);
     +-	for (ref = matches; ref; ref = ref->next) {
     +-		string_list_append(&heads, strip_refshead(ref->name));
     +-	}
     ++	if (known_head_branch) {
     ++		head_name = xstrdup(known_head_branch);
     ++	} else {
     ++		get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
     ++		matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
     ++					    fetch_map, REMOTE_GUESS_HEAD_ALL);
     ++		for (ref = matches; ref; ref = ref->next) {
     ++			string_list_append(&heads, strip_refshead(ref->name));
     ++		}
     + 
     +-	if (!heads.nr)
     +-		result = 1;
     +-	else if (heads.nr > 1)
     +-		result = 1;
     +-	else
     +-		head_name = xstrdup(heads.items[0].string);
     ++		if (!heads.nr)
     ++			result = 1;
     ++		else if (heads.nr > 1)
     ++			result = 1;
     ++		else
     ++			head_name = xstrdup(heads.items[0].string);
     ++	}
     + 
     + 	if (!head_name)
     + 		goto cleanup;
     +@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     + 	struct strmap rejected_refs = STRMAP_INIT;
     + 	int summary_width = 0;
     + 	int follow_remote_head;
     ++	char *bootstrap_head_branch = NULL;
     + 
     + 	if (tags == TAGS_DEFAULT) {
     + 		if (transport->remote->fetch_tags == 2)
      @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
       		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
       	} else {
       		struct branch *branch = branch_get(NULL);
      +		int tracks_this_remote = branch && branch_has_merge_config(branch) &&
      +			!strcmp(branch->remote_name, transport->remote->name);
     -+		int narrow_to_tracked_ref = config->shallow &&
     -+			is_repository_shallow(the_repository) && tracks_this_remote;
     ++		int tracking_refspec = transport->remote->fetch.nr == 1 &&
     ++			transport->remote->fetch.items[0].tracking;
       
     - 		if (transport->remote->fetch.nr) {
     --			refspec_ref_prefixes(&transport->remote->fetch,
     --					     &transport_ls_refs_options.ref_prefixes);
     -+			if (!narrow_to_tracked_ref)
     -+				refspec_ref_prefixes(&transport->remote->fetch,
     -+						     &transport_ls_refs_options.ref_prefixes);
     - 			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
     - 				do_set_head = 1;
     +-		if (transport->remote->fetch.nr) {
     ++		if (tracking_refspec) {
     ++			struct string_list tracked = STRING_LIST_INIT_DUP;
     ++			struct string_list_item *item;
     ++
     ++			branches_tracking_remote(transport->remote, &tracked);
     ++			for_each_string_list_item(item, &tracked)
     ++				strvec_push(&transport_ls_refs_options.ref_prefixes,
     ++					    item->string);
     ++			string_list_clear(&tracked, 0);
     ++			strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
     ++		} else if (transport->remote->fetch.nr) {
     + 			refspec_ref_prefixes(&transport->remote->fetch,
     + 					     &transport_ls_refs_options.ref_prefixes);
     +-			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
     +-				do_set_head = 1;
       		}
      -		if (branch && branch_has_merge_config(branch) &&
      -		    !strcmp(branch->remote_name, transport->remote->name)) {
     ++		if (transport->remote->fetch.nr &&
     ++		    follow_remote_head != FOLLOW_REMOTE_NEVER)
     ++			do_set_head = 1;
      +		if (tracks_this_remote) {
       			int i;
       			for (i = 0; i < branch->merge_nr; i++) {
       				strvec_push(&transport_ls_refs_options.ref_prefixes,
     +@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     + 	transport_ls_refs_options_release(&transport_ls_refs_options);
     + 
     + 	ref_map = get_ref_map(transport->remote, remote_refs, rs,
     +-			      tags, &autotags);
     ++			      tags, &autotags, &bootstrap_head_branch);
     ++
     + 	if (!update_head_ok)
     + 		check_not_current_branch(ref_map);
     + 
     +@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     + 		 * Way too many cases where this can go wrong so let's just
     + 		 * ignore errors and fail silently for now.
     + 		 */
     +-		set_head(remote_refs, transport->remote, follow_remote_head);
     ++		set_head(remote_refs, transport->remote, follow_remote_head,
     ++			 bootstrap_head_branch);
     + 	}
     + 
     + cleanup:
     ++	free(bootstrap_head_branch);
     + 	/*
     + 	 * When using batched updates, we want to commit the non-rejected
     + 	 * updates and also handle the rejections.
      
     - ## t/t5537-fetch-shallow.sh ##
     -@@ t/t5537-fetch-shallow.sh: commit() {
     - 	git commit -m "$1"
     + ## builtin/remote.c ##
     +@@
     + #include "rebase.h"
     + #include "refs.h"
     + #include "refspec.h"
     ++#include "shallow.h"
     + #include "odb.h"
     + #include "strvec.h"
     + #include "commit-reach.h"
     +@@ builtin/remote.c: static void add_branch(const char *key, const char *branchname,
     + 		       const char *remotename, int mirror, struct strbuf *tmp)
     + {
     + 	strbuf_reset(tmp);
     +-	strbuf_addch(tmp, '+');
     +-	if (mirror)
     +-		strbuf_addf(tmp, "refs/%s:refs/%s",
     +-				branchname, branchname);
     +-	else
     +-		strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
     +-				branchname, remotename, branchname);
     ++	if (!strcmp(branchname, ":")) {
     ++		strbuf_addstr(tmp, "+:");
     ++	} else {
     ++		strbuf_addch(tmp, '+');
     ++		if (mirror)
     ++			strbuf_addf(tmp, "refs/%s:refs/%s",
     ++					branchname, branchname);
     ++		else
     ++			strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
     ++					branchname, remotename, branchname);
     ++	}
     + 	repo_config_set_multivar(the_repository, key, tmp->buf, "^$", 0);
       }
       
     -+check_upstream_refs () {
     -+	git for-each-ref --format="%(refname)" refs/remotes/upstream/ >actual &&
     -+	cat >expect &&
     -+	test_cmp expect actual
     -+}
     +@@ builtin/remote.c: static int add(int argc, const char **argv, const char *prefix,
     + 		strbuf_reset(&buf);
     + 		strbuf_addf(&buf, "remote.%s.fetch", name);
     + 		if (track.nr == 0)
     +-			string_list_append(&track, "*");
     +-		for (size_t i = 0; i < track.nr; i++) {
     ++			string_list_append(&track,
     ++				mirror == MIRROR_NONE &&
     ++				is_repository_shallow(the_repository) ?
     ++				":" : "*");
     ++		for (size_t i = 0; i < track.nr; i++)
     + 			add_branch(buf.buf, track.items[i].string,
     + 				   name, mirror, &buf2);
     +-		}
     + 	}
     + 
     + 	if (mirror & MIRROR_PUSH) {
     +
     + ## refspec.c ##
     +@@ refspec.c: static int parse_refspec(struct refspec_item *item, const char *refspec,
     + 		return 1;
     + 	}
     + 
     ++	if (fetch && rhs == lhs && rhs[1] == '\0') {
     ++		item->tracking = 1;
     ++		return 1;
     ++	}
     ++
     + 	if (rhs) {
     + 		size_t rlen = strlen(++rhs);
     + 		is_glob = (1 <= rlen && strchr(rhs, '*'));
     +@@ refspec.c: void refspec_item_clear(struct refspec_item *item)
     + 	item->force = 0;
     + 	item->pattern = 0;
     + 	item->matching = 0;
     ++	item->tracking = 0;
     + 	item->exact_sha1 = 0;
     + }
     + 
     +@@ refspec.c: static int refspec_find_negative_match(struct refspec *rs, struct refspec_item *
     + 		struct refspec_item *refspec = &rs->items[i];
     + 		char *expn_name;
     + 
     +-		if (refspec->negative)
     ++		if (refspec->negative || refspec->tracking)
     + 			continue;
     + 
     + 		/* Note the reversal of src and dst */
     +
     + ## refspec.h ##
     +@@ refspec.h: struct refspec_item {
     + 	unsigned matching : 1;
     + 	unsigned exact_sha1 : 1;
     + 	unsigned negative : 1;
     ++	unsigned tracking : 1;
     + 
     + 	char *src;
     + 	char *dst;
     +
     + ## remote.c ##
     +@@ remote.c: void ref_push_report_free(struct ref_push_report *report)
     + 
     + int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
     + {
     ++	if (remote->fetch.nr == 1 && remote->fetch.items[0].tracking) {
     ++		struct strbuf prefix = STRBUF_INIT;
     ++		const char *branch_name;
     ++		int ret = -1;
     ++
     ++		strbuf_addf(&prefix, "refs/remotes/%s/", remote->name);
     ++		if (!refspec->src) {
     ++			if (refspec->dst &&
     ++			    skip_prefix(refspec->dst, prefix.buf, &branch_name)) {
     ++				refspec->src = xstrfmt("refs/heads/%s", branch_name);
     ++				refspec->force = 1;
     ++				ret = 0;
     ++			}
     ++		} else if (skip_prefix(refspec->src, "refs/heads/", &branch_name)) {
     ++			free(refspec->dst);
     ++			refspec->dst = xstrfmt("%s%s", prefix.buf, branch_name);
     ++			refspec->force = 1;
     ++			ret = 0;
     ++		}
     ++		strbuf_release(&prefix);
     ++		return ret;
     ++	}
     ++
     + 	return refspec_find_match(&remote->fetch, refspec);
     + }
     + 
     +@@ remote.c: int branch_merge_matches(struct branch *branch,
     + 	return refname_match(branch->merge[i]->src, refname);
     + }
     + 
     ++struct branches_tracking_remote_cb_data {
     ++	struct remote *remote;
     ++	struct string_list *tracked;
     ++};
     ++
     ++static int add_if_tracking_remote(const struct reference *ref, void *cb_data)
     ++{
     ++	struct branches_tracking_remote_cb_data *data = cb_data;
     ++	struct branch *branch;
     ++
     ++	branch = branch_get(ref->name);
     ++	if (!branch_has_merge_config(branch) ||
     ++	    strcmp(branch->remote_name, data->remote->name))
     ++		return 0;
      +
     -+check_upstream_head () {
     -+	git symbolic-ref refs/remotes/upstream/HEAD >actual &&
     -+	echo "refs/remotes/upstream/$1" >expect &&
     -+	test_cmp expect actual
     ++	for (int i = 0; i < branch->merge_nr; i++)
     ++		string_list_insert(data->tracked, branch->merge[i]->src);
     ++
     ++	return 0;
      +}
      +
     -+check_same_tip () {
     -+	git log --oneline -1 "$1" >expect &&
     -+	git -C "$2" log --oneline -1 "$3" >actual &&
     -+	test_cmp expect actual
     ++void branches_tracking_remote(struct remote *remote, struct string_list *tracked)
     ++{
     ++	struct branches_tracking_remote_cb_data data = { remote, tracked };
     ++
     ++	refs_for_each_branch_ref(get_main_ref_store(the_repository),
     ++				  add_if_tracking_remote, &data);
      +}
      +
     - test_expect_success 'setup' '
     - 	commit 1 &&
     - 	commit 2 &&
     -@@ t/t5537-fetch-shallow.sh: test_expect_success 'fetch --deepen does not truncate' '
     - 	test_cmp expect actual
     + __attribute__((format (printf,2,3)))
     + static char *error_buf(struct strbuf *err, const char *fmt, ...)
     + {
     +@@ remote.c: int get_fetch_map(const struct ref *remote_refs,
     + {
     + 	struct ref *ref_map, **rmp;
     + 
     +-	if (refspec->negative)
     ++	if (refspec->negative || refspec->tracking)
     + 		return 0;
     + 
     + 	if (refspec->pattern) {
     +
     + ## remote.h ##
     +@@ remote.h: int branch_has_merge_config(struct branch *branch);
     + 
     + int branch_merge_matches(struct branch *, int n, const char *);
     + 
     ++/* fills tracked with the refname of every local branch's upstream on remote */
     ++void branches_tracking_remote(struct remote *remote, struct string_list *tracked);
     ++
     + /* list of the remote in a group as configured */
     + struct remote_group_data {
     + 	const char *name;
     +
     + ## t/meson.build ##
     +@@ t/meson.build: integration_tests = [
     +   't5582-fetch-negative-refspec.sh',
     +   't5583-push-branches.sh',
     +   't5584-http-429-retry.sh',
     ++  't5585-fetch-tracking-refspec.sh',
     +   't5600-clone-fail-cleanup.sh',
     +   't5601-clone.sh',
     +   't5602-clone-remote-exec.sh',
     +
     + ## t/t5505-remote.sh ##
     +@@ t/t5505-remote.sh: test_expect_success 'filters are listed by git remote -v only' '
     + 	test_grep ! "\[blob:none\]" out
       '
       
     -+test_expect_success 'fetch.shallow setup' '
     -+	git branch narrow-side &&
     -+	git clone --no-local --depth=1 --branch main --single-branch \
     -+		.git narrow-default &&
     ++test_expect_success 'add remote -t keeps an explicit refspec in a shallow repository' '
     ++	test_when_finished "rm -rf shallow-add" &&
      +	git clone --no-local --depth=1 --branch main --single-branch \
     -+		.git narrow-enabled &&
     -+	(
     -+		cd narrow-default &&
     -+		git remote add upstream ../.git &&
     -+		git fetch --depth=1 upstream main:refs/remotes/upstream/main &&
     -+		git branch --set-upstream-to=upstream/main main
     -+	) &&
     ++		one shallow-add &&
      +	(
     -+		cd narrow-enabled &&
     -+		git remote add upstream ../.git &&
     -+		git fetch --depth=1 upstream main:refs/remotes/upstream/main &&
     -+		git branch --set-upstream-to=upstream/main main &&
     -+		git config fetch.shallow true
     ++		cd shallow-add &&
     ++		git remote add -t main upstream ../two &&
     ++		test_cmp_config "+refs/heads/main:refs/remotes/upstream/main" \
     ++			remote.upstream.fetch
      +	)
      +'
      +
     -+test_expect_success 'a refspec-less fetch expands to the configured refspec by default' '
     ++test_expect_success 'add remote keeps the wildcard refspec in a full repository' '
     ++	test_when_finished "rm -rf full-add" &&
     ++	git clone --no-local one full-add &&
      +	(
     -+		cd narrow-default &&
     -+		git fetch upstream &&
     -+		check_upstream_refs <<-\EOF
     -+		refs/remotes/upstream/HEAD
     -+		refs/remotes/upstream/main
     -+		refs/remotes/upstream/narrow-side
     -+		EOF
     ++		cd full-add &&
     ++		git remote add upstream ../two &&
     ++		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
     ++			remote.upstream.fetch
      +	)
      +'
      +
     -+test_expect_success 'fetch.shallow=true limits a refspec-less fetch to the tracked branch' '
     ++test_expect_success 'a remote added in a shallow repository defaults to the tracking refspec' '
     ++	test_when_finished "rm -rf shallow-add" &&
     ++	git clone --no-local --depth=1 --branch main --single-branch \
     ++		one shallow-add &&
      +	(
     -+		cd narrow-enabled &&
     ++		cd shallow-add &&
     ++		git remote add upstream ../two &&
     ++		test_cmp_config "+:" remote.upstream.fetch &&
      +		git fetch upstream &&
     -+		check_upstream_refs <<-\EOF
     ++		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
     ++		cat >expect <<-\EOF &&
      +		refs/remotes/upstream/HEAD
      +		refs/remotes/upstream/main
      +		EOF
     ++		test_cmp expect actual &&
     ++		git branch --set-upstream-to=upstream &&
     ++		test_cmp_config upstream branch.main.remote &&
     ++		test_cmp_config refs/heads/main branch.main.merge
      +	)
      +'
      +
     -+test_expect_success 'fetch.shallow=true still creates refs/remotes/<remote>/HEAD' '
     + test_expect_success 'check remote-tracking' '
     + 	(
     + 		cd test &&
     +
     + ## t/t5585-fetch-tracking-refspec.sh (new) ##
     +@@
     ++#!/bin/sh
     ++
     ++test_description='"git fetch" with the tracking refspec ":" (or "+:")
     ++
     ++The special refspec fetches whichever branches at the remote our local
     ++branches have as their @{upstream}, plus the default branch of that
     ++remote, which is always included so that it is available even before
     ++anything is set up to track it. git remote add uses it by default for
     ++a new remote in an already shallow repository, so that adding a
     ++second remote there does not turn the next plain fetch or pull into
     ++one that negotiates history for every branch the remote has.
     ++'
     ++
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     ++export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     ++
     ++. ./test-lib.sh
     ++
     ++test_expect_success 'setup' '
     ++	test_commit main-1 &&
     ++	test_commit main-2 &&
     ++	git checkout -b side main-1 &&
     ++	test_commit side-1 &&
     ++	git checkout -b next main-1 &&
     ++	test_commit next-1 &&
     ++	git checkout main
     ++'
     ++
     ++test_expect_success 'clone shallow and single-branch, then add a second remote' '
     ++	git clone --no-local --depth=1 --branch main --single-branch . client &&
      +	(
     -+		cd narrow-enabled &&
     -+		git symbolic-ref -d refs/remotes/upstream/HEAD &&
     -+		git fetch upstream &&
     -+		check_upstream_head main
     ++		cd client &&
     ++		git remote add upstream .. &&
     ++		test_cmp_config "+:" remote.upstream.fetch
      +	)
      +'
      +
     -+test_expect_success 'fetch.shallow=true with followRemoteHEAD=always corrects a stale HEAD' '
     -+	test_when_finished \
     -+		"git -C narrow-enabled update-ref -d refs/remotes/upstream/stale-branch" &&
     ++test_expect_success 'fetching the new remote does not need every branch it has' '
      +	(
     -+		cd narrow-enabled &&
     -+		git update-ref refs/remotes/upstream/stale-branch refs/remotes/upstream/main &&
     -+		git symbolic-ref refs/remotes/upstream/HEAD refs/remotes/upstream/stale-branch &&
     -+		git -c fetch.followRemoteHEAD=always fetch upstream &&
     -+		check_upstream_head main
     ++		cd client &&
     ++		git fetch upstream &&
     ++		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
     ++		cat >expect <<-\EOF &&
     ++		refs/remotes/upstream/HEAD
     ++		refs/remotes/upstream/main
     ++		EOF
     ++		test_cmp expect actual
      +	)
      +'
      +
     -+test_expect_success 'fetch.shallow=true still updates the tracked branch' '
     -+	commit 5 &&
     -+	git -C narrow-enabled fetch upstream &&
     -+	check_same_tip main narrow-enabled refs/remotes/upstream/main
     ++test_expect_success 'set-upstream-to now resolves right after that first fetch' '
     ++	(
     ++		cd client &&
     ++		git branch --set-upstream-to=upstream &&
     ++		test_cmp_config upstream branch.main.remote &&
     ++		test_cmp_config refs/heads/main branch.main.merge
     ++	)
      +'
      +
     -+test_expect_success 'fetch.shallow=true keeps git pull narrowed too' '
     -+	test_when_finished "git branch -D narrow-side" &&
     -+	commit 6 &&
     ++test_expect_success 'a branch checked out from a one-time fetch is kept updated by later plain fetches' '
     ++	(
     ++		cd client &&
     ++		git fetch upstream side:refs/remotes/upstream/side &&
     ++		git branch side-topic upstream/side
     ++	) &&
     ++	git checkout side &&
     ++	test_commit side-2 &&
     ++	git checkout main &&
      +	(
     -+		cd narrow-enabled &&
     -+		git pull &&
     -+		check_upstream_refs <<-\EOF
     ++		cd client &&
     ++		git fetch upstream &&
     ++		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
     ++		cat >expect <<-\EOF &&
      +		refs/remotes/upstream/HEAD
      +		refs/remotes/upstream/main
     ++		refs/remotes/upstream/side
      +		EOF
     -+	) &&
     -+	check_same_tip main narrow-enabled HEAD
     ++		test_cmp expect actual &&
     ++		git rev-parse refs/remotes/upstream/side >actual-oid &&
     ++		git -C .. rev-parse side >expect-oid &&
     ++		test_cmp expect-oid actual-oid
     ++	)
      +'
      +
     -+test_expect_success 'fetch.shallow=true has no effect on a non-shallow repository' '
     -+	git clone --no-local --branch main --single-branch .git narrow-full &&
     -+	(
     -+		cd narrow-full &&
     -+		git rev-parse --is-shallow-repository >actual &&
     -+		echo false >expect &&
     -+		test_cmp expect actual &&
     -+		git remote add upstream ../.git &&
     -+		git fetch upstream &&
     -+		git branch --set-upstream-to=upstream/main main &&
     -+		git config fetch.shallow true
     -+	) &&
     -+	test_when_finished "git branch -D narrow-full-side" &&
     -+	git branch narrow-full-side &&
     ++test_expect_success 'a second branch tracking the same upstream branch does not fetch it twice' '
      +	(
     -+		cd narrow-full &&
     ++		cd client &&
     ++		git branch side-topic-2 upstream/side &&
      +		git fetch upstream &&
     -+		check_upstream_refs <<-\EOF
     ++		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
     ++		cat >expect <<-\EOF &&
      +		refs/remotes/upstream/HEAD
      +		refs/remotes/upstream/main
     -+		refs/remotes/upstream/narrow-full-side
     ++		refs/remotes/upstream/side
      +		EOF
     ++		test_cmp expect actual
      +	)
      +'
      +
     -+test_expect_success 'fetch.shallow=true only narrows a fetch of the tracked remote' '
     -+	test_when_finished "git branch -D other-side" &&
     -+	git branch other-side &&
     -+	git clone --no-local --depth=1 --branch main --single-branch \
     -+		.git narrow-other-remote &&
     ++test_expect_success 'a branch tracking a different remote is not fetched from upstream' '
      +	(
     -+		cd narrow-other-remote &&
     -+		git remote add upstream ../.git &&
     -+		git config fetch.shallow true &&
     ++		cd client &&
     ++		git remote add other .. &&
     ++		git fetch other next:refs/remotes/other/next &&
     ++		git branch next-topic other/next &&
      +		git fetch upstream &&
     -+		check_upstream_refs <<-\EOF
     ++		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
     ++		cat >expect <<-\EOF &&
      +		refs/remotes/upstream/HEAD
      +		refs/remotes/upstream/main
     -+		refs/remotes/upstream/other-side
     ++		refs/remotes/upstream/side
      +		EOF
     ++		test_cmp expect actual
      +	)
      +'
      +
     - . "$TEST_DIRECTORY"/lib-httpd.sh
     - start_httpd
     - 
     ++test_expect_success 'git remote show does not choke on the tracking refspec' '
     ++	(
     ++		cd client &&
     ++		git remote show upstream
     ++	)
     ++'
     ++
     ++test_done


 Documentation/git-remote.adoc       |   7 ++
 Documentation/pull-fetch-param.adoc |  10 +++
 builtin/fetch.c                     | 117 +++++++++++++++++++++-----
 builtin/remote.c                    |  27 +++---
 refspec.c                           |   8 +-
 refspec.h                           |   1 +
 remote.c                            |  54 +++++++++++-
 remote.h                            |   3 +
 t/meson.build                       |   1 +
 t/t5505-remote.sh                   |  44 ++++++++++
 t/t5585-fetch-tracking-refspec.sh   | 124 ++++++++++++++++++++++++++++
 11 files changed, 362 insertions(+), 34 deletions(-)
 create mode 100755 t/t5585-fetch-tracking-refspec.sh

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index eaae30aa88..7856ccf54f 100644
--- a/Documentation/git-remote.adoc
+++ b/Documentation/git-remote.adoc
@@ -52,6 +52,13 @@ Add a remote named _<name>_ for the repository at
 _<URL>_.  The command `git fetch <name>` can then be used to create and
 update remote-tracking branches `<name>/<branch>`.
 +
+If the repository is already a shallow repository (see linkgit:git-clone[1]
+`--depth`) and neither `-t` nor `--mirror` is given, the remote is set up
+with the special tracking refspec (see the _<refspec>_ entry in
+linkgit:git-fetch[1]) instead of the default glob refspec, so that
+`git fetch <name>` does not need to negotiate history for every branch
+the remote has.
++
 With `-f` option, `git fetch <name>` is run immediately after
 the remote information is set up.
 +
diff --git a/Documentation/pull-fetch-param.adoc b/Documentation/pull-fetch-param.adoc
index d903dc8900..e1a42152d9 100644
--- a/Documentation/pull-fetch-param.adoc
+++ b/Documentation/pull-fetch-param.adoc
@@ -48,6 +48,16 @@ Negative refspecs can themselves be pattern refspecs. However, they may only
 contain a _<src>_ and do not specify a _<dst>_. Fully spelled out hex object
 names are also not supported.
 +
+The special refspec `:` (or `+:` to allow non-fast-forward updates)
+directs Git to fetch whichever branches at the remote our local branches
+have as their `@{upstream}`, plus the remote's default branch, which is
+always included so that it is available even before anything is set up
+to track it. Unlike the same syntax when pushing, the local branch name
+plays no role here beyond identifying which remote branch to fetch: the
+result is written to `refs/remotes/<remote>/<branch>` using the remote's
+own branch name, and several local branches built on the same remote
+branch only cause it to be fetched once.
++
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`;
 it requests fetching everything up to the given tag.
 +
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 533fdfe7d8..7a3387d733 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -500,10 +500,55 @@ static void filter_prefetch_refspec(struct refspec *rs)
 	}
 }
 
+static void fetch_tracked_branches(struct remote *remote,
+				   const struct ref *remote_refs,
+				   struct ref ***tail,
+				   char **default_branch_out,
+				   int force)
+{
+	struct string_list tracked = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	struct ref *head;
+	char *default_branch = NULL;
+
+	branches_tracking_remote(remote, &tracked);
+
+	head = get_remote_ref(remote_refs, "HEAD");
+	if (head && head->symref && *head->symref) {
+		default_branch = xstrdup(head->symref);
+		string_list_insert(&tracked, default_branch);
+	}
+	free_one_ref(head);
+
+	for_each_string_list_item(item, &tracked) {
+		struct refspec_item ref = { .force = force };
+		const char *branch_name = item->string;
+		int is_default_branch = default_branch &&
+			!strcmp(item->string, default_branch);
+
+		skip_prefix(branch_name, "refs/heads/", &branch_name);
+		ref.src = xstrdup(is_default_branch ? "HEAD" : item->string);
+		ref.dst = xstrfmt("refs/remotes/%s/%s", remote->name, branch_name);
+		get_fetch_map(remote_refs, &ref, tail, 1);
+		free(ref.src);
+		free(ref.dst);
+	}
+
+	if (default_branch && default_branch_out) {
+		const char *branch_name = default_branch;
+		skip_prefix(branch_name, "refs/heads/", &branch_name);
+		*default_branch_out = xstrdup(branch_name);
+	}
+
+	free(default_branch);
+	string_list_clear(&tracked, 0);
+}
+
 static struct ref *get_ref_map(struct remote *remote,
 			       const struct ref *remote_refs,
 			       struct refspec *rs,
-			       int tags, int *autotags)
+			       int tags, int *autotags,
+			       char **bootstrap_head_branch)
 {
 	int i;
 	struct ref *rm;
@@ -570,6 +615,12 @@ static struct ref *get_ref_map(struct remote *remote,
 		     /* Note: has_merge implies non-NULL branch->remote_name */
 		     (has_merge && !strcmp(branch->remote_name, remote->name)))) {
 			for (i = 0; i < remote->fetch.nr; i++) {
+				if (remote->fetch.items[i].tracking) {
+					fetch_tracked_branches(remote, remote_refs, &tail,
+								bootstrap_head_branch,
+								remote->fetch.items[i].force);
+					continue;
+				}
 				get_fetch_map(remote_refs, &remote->fetch.items[i], &tail, 0);
 				if (remote->fetch.items[i].dst &&
 				    remote->fetch.items[i].dst[0])
@@ -1751,14 +1802,14 @@ static void warn_set_head(const char *remote, const char *head_name,
 }
 
 static int set_head(const struct ref *remote_refs, struct remote *remote,
-			int follow_remote_head)
+			int follow_remote_head, const char *known_head_branch)
 {
 	int result = 0, create_only, baremirror, was_detached;
 	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
 		      b_local_head = STRBUF_INIT;
 	const char *no_warn_branch = remote->no_warn_branch;
 	char *head_name = NULL;
-	struct ref *ref, *matches;
+	struct ref *ref, *matches = NULL;
 	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
 	struct refspec_item refspec = {
 		.force = 0,
@@ -1769,19 +1820,23 @@ static int set_head(const struct ref *remote_refs, struct remote *remote,
 	struct string_list heads = STRING_LIST_INIT_DUP;
 	struct ref_store *refs = get_main_ref_store(the_repository);
 
-	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
-	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
-				    fetch_map, REMOTE_GUESS_HEAD_ALL);
-	for (ref = matches; ref; ref = ref->next) {
-		string_list_append(&heads, strip_refshead(ref->name));
-	}
+	if (known_head_branch) {
+		head_name = xstrdup(known_head_branch);
+	} else {
+		get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
+		matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
+					    fetch_map, REMOTE_GUESS_HEAD_ALL);
+		for (ref = matches; ref; ref = ref->next) {
+			string_list_append(&heads, strip_refshead(ref->name));
+		}
 
-	if (!heads.nr)
-		result = 1;
-	else if (heads.nr > 1)
-		result = 1;
-	else
-		head_name = xstrdup(heads.items[0].string);
+		if (!heads.nr)
+			result = 1;
+		else if (heads.nr > 1)
+			result = 1;
+		else
+			head_name = xstrdup(heads.items[0].string);
+	}
 
 	if (!head_name)
 		goto cleanup;
@@ -1923,6 +1978,7 @@ static int do_fetch(struct transport *transport,
 	struct strmap rejected_refs = STRMAP_INIT;
 	int summary_width = 0;
 	int follow_remote_head;
+	char *bootstrap_head_branch = NULL;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1958,15 +2014,29 @@ static int do_fetch(struct transport *transport,
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
 		struct branch *branch = branch_get(NULL);
+		int tracks_this_remote = branch && branch_has_merge_config(branch) &&
+			!strcmp(branch->remote_name, transport->remote->name);
+		int tracking_refspec = transport->remote->fetch.nr == 1 &&
+			transport->remote->fetch.items[0].tracking;
 
-		if (transport->remote->fetch.nr) {
+		if (tracking_refspec) {
+			struct string_list tracked = STRING_LIST_INIT_DUP;
+			struct string_list_item *item;
+
+			branches_tracking_remote(transport->remote, &tracked);
+			for_each_string_list_item(item, &tracked)
+				strvec_push(&transport_ls_refs_options.ref_prefixes,
+					    item->string);
+			string_list_clear(&tracked, 0);
+			strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+		} else if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
-			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
-				do_set_head = 1;
 		}
-		if (branch && branch_has_merge_config(branch) &&
-		    !strcmp(branch->remote_name, transport->remote->name)) {
+		if (transport->remote->fetch.nr &&
+		    follow_remote_head != FOLLOW_REMOTE_NEVER)
+			do_set_head = 1;
+		if (tracks_this_remote) {
 			int i;
 			for (i = 0; i < branch->merge_nr; i++) {
 				strvec_push(&transport_ls_refs_options.ref_prefixes,
@@ -2006,7 +2076,8 @@ static int do_fetch(struct transport *transport,
 	transport_ls_refs_options_release(&transport_ls_refs_options);
 
 	ref_map = get_ref_map(transport->remote, remote_refs, rs,
-			      tags, &autotags);
+			      tags, &autotags, &bootstrap_head_branch);
+
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
@@ -2169,10 +2240,12 @@ static int do_fetch(struct transport *transport,
 		 * Way too many cases where this can go wrong so let's just
 		 * ignore errors and fail silently for now.
 		 */
-		set_head(remote_refs, transport->remote, follow_remote_head);
+		set_head(remote_refs, transport->remote, follow_remote_head,
+			 bootstrap_head_branch);
 	}
 
 cleanup:
+	free(bootstrap_head_branch);
 	/*
 	 * When using batched updates, we want to commit the non-rejected
 	 * updates and also handle the rejections.
diff --git a/builtin/remote.c b/builtin/remote.c
index de989ea3ba..e407d67037 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -16,6 +16,7 @@
 #include "rebase.h"
 #include "refs.h"
 #include "refspec.h"
+#include "shallow.h"
 #include "odb.h"
 #include "strvec.h"
 #include "commit-reach.h"
@@ -127,13 +128,17 @@ static void add_branch(const char *key, const char *branchname,
 		       const char *remotename, int mirror, struct strbuf *tmp)
 {
 	strbuf_reset(tmp);
-	strbuf_addch(tmp, '+');
-	if (mirror)
-		strbuf_addf(tmp, "refs/%s:refs/%s",
-				branchname, branchname);
-	else
-		strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
-				branchname, remotename, branchname);
+	if (!strcmp(branchname, ":")) {
+		strbuf_addstr(tmp, "+:");
+	} else {
+		strbuf_addch(tmp, '+');
+		if (mirror)
+			strbuf_addf(tmp, "refs/%s:refs/%s",
+					branchname, branchname);
+		else
+			strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
+					branchname, remotename, branchname);
+	}
 	repo_config_set_multivar(the_repository, key, tmp->buf, "^$", 0);
 }
 
@@ -233,11 +238,13 @@ static int add(int argc, const char **argv, const char *prefix,
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.fetch", name);
 		if (track.nr == 0)
-			string_list_append(&track, "*");
-		for (size_t i = 0; i < track.nr; i++) {
+			string_list_append(&track,
+				mirror == MIRROR_NONE &&
+				is_repository_shallow(the_repository) ?
+				":" : "*");
+		for (size_t i = 0; i < track.nr; i++)
 			add_branch(buf.buf, track.items[i].string,
 				   name, mirror, &buf2);
-		}
 	}
 
 	if (mirror & MIRROR_PUSH) {
diff --git a/refspec.c b/refspec.c
index 7cb479983b..84a19b5b5c 100644
--- a/refspec.c
+++ b/refspec.c
@@ -49,6 +49,11 @@ static int parse_refspec(struct refspec_item *item, const char *refspec,
 		return 1;
 	}
 
+	if (fetch && rhs == lhs && rhs[1] == '\0') {
+		item->tracking = 1;
+		return 1;
+	}
+
 	if (rhs) {
 		size_t rlen = strlen(++rhs);
 		is_glob = (1 <= rlen && strchr(rhs, '*'));
@@ -181,6 +186,7 @@ void refspec_item_clear(struct refspec_item *item)
 	item->force = 0;
 	item->pattern = 0;
 	item->matching = 0;
+	item->tracking = 0;
 	item->exact_sha1 = 0;
 }
 
@@ -373,7 +379,7 @@ static int refspec_find_negative_match(struct refspec *rs, struct refspec_item *
 		struct refspec_item *refspec = &rs->items[i];
 		char *expn_name;
 
-		if (refspec->negative)
+		if (refspec->negative || refspec->tracking)
 			continue;
 
 		/* Note the reversal of src and dst */
diff --git a/refspec.h b/refspec.h
index fadef67933..97bd6ffef5 100644
--- a/refspec.h
+++ b/refspec.h
@@ -27,6 +27,7 @@ struct refspec_item {
 	unsigned matching : 1;
 	unsigned exact_sha1 : 1;
 	unsigned negative : 1;
+	unsigned tracking : 1;
 
 	char *src;
 	char *dst;
diff --git a/remote.c b/remote.c
index fe62068463..53b410f7e7 100644
--- a/remote.c
+++ b/remote.c
@@ -988,6 +988,29 @@ void ref_push_report_free(struct ref_push_report *report)
 
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
+	if (remote->fetch.nr == 1 && remote->fetch.items[0].tracking) {
+		struct strbuf prefix = STRBUF_INIT;
+		const char *branch_name;
+		int ret = -1;
+
+		strbuf_addf(&prefix, "refs/remotes/%s/", remote->name);
+		if (!refspec->src) {
+			if (refspec->dst &&
+			    skip_prefix(refspec->dst, prefix.buf, &branch_name)) {
+				refspec->src = xstrfmt("refs/heads/%s", branch_name);
+				refspec->force = 1;
+				ret = 0;
+			}
+		} else if (skip_prefix(refspec->src, "refs/heads/", &branch_name)) {
+			free(refspec->dst);
+			refspec->dst = xstrfmt("%s%s", prefix.buf, branch_name);
+			refspec->force = 1;
+			ret = 0;
+		}
+		strbuf_release(&prefix);
+		return ret;
+	}
+
 	return refspec_find_match(&remote->fetch, refspec);
 }
 
@@ -1874,6 +1897,35 @@ int branch_merge_matches(struct branch *branch,
 	return refname_match(branch->merge[i]->src, refname);
 }
 
+struct branches_tracking_remote_cb_data {
+	struct remote *remote;
+	struct string_list *tracked;
+};
+
+static int add_if_tracking_remote(const struct reference *ref, void *cb_data)
+{
+	struct branches_tracking_remote_cb_data *data = cb_data;
+	struct branch *branch;
+
+	branch = branch_get(ref->name);
+	if (!branch_has_merge_config(branch) ||
+	    strcmp(branch->remote_name, data->remote->name))
+		return 0;
+
+	for (int i = 0; i < branch->merge_nr; i++)
+		string_list_insert(data->tracked, branch->merge[i]->src);
+
+	return 0;
+}
+
+void branches_tracking_remote(struct remote *remote, struct string_list *tracked)
+{
+	struct branches_tracking_remote_cb_data data = { remote, tracked };
+
+	refs_for_each_branch_ref(get_main_ref_store(the_repository),
+				  add_if_tracking_remote, &data);
+}
+
 __attribute__((format (printf,2,3)))
 static char *error_buf(struct strbuf *err, const char *fmt, ...)
 {
@@ -2138,7 +2190,7 @@ int get_fetch_map(const struct ref *remote_refs,
 {
 	struct ref *ref_map, **rmp;
 
-	if (refspec->negative)
+	if (refspec->negative || refspec->tracking)
 		return 0;
 
 	if (refspec->pattern) {
diff --git a/remote.h b/remote.h
index cca02033b9..5ab187e00a 100644
--- a/remote.h
+++ b/remote.h
@@ -353,6 +353,9 @@ int branch_has_merge_config(struct branch *branch);
 
 int branch_merge_matches(struct branch *, int n, const char *);
 
+/* fills tracked with the refname of every local branch's upstream on remote */
+void branches_tracking_remote(struct remote *remote, struct string_list *tracked);
+
 /* list of the remote in a group as configured */
 struct remote_group_data {
 	const char *name;
diff --git a/t/meson.build b/t/meson.build
index 3ca7b27104..4c13048d46 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -728,6 +728,7 @@ integration_tests = [
   't5582-fetch-negative-refspec.sh',
   't5583-push-branches.sh',
   't5584-http-429-retry.sh',
+  't5585-fetch-tracking-refspec.sh',
   't5600-clone-fail-cleanup.sh',
   't5601-clone.sh',
   't5602-clone-remote-exec.sh',
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 5fbfcb0848..f7c3857098 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -137,6 +137,50 @@ test_expect_success 'filters are listed by git remote -v only' '
 	test_grep ! "\[blob:none\]" out
 '
 
+test_expect_success 'add remote -t keeps an explicit refspec in a shallow repository' '
+	test_when_finished "rm -rf shallow-add" &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		one shallow-add &&
+	(
+		cd shallow-add &&
+		git remote add -t main upstream ../two &&
+		test_cmp_config "+refs/heads/main:refs/remotes/upstream/main" \
+			remote.upstream.fetch
+	)
+'
+
+test_expect_success 'add remote keeps the wildcard refspec in a full repository' '
+	test_when_finished "rm -rf full-add" &&
+	git clone --no-local one full-add &&
+	(
+		cd full-add &&
+		git remote add upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.fetch
+	)
+'
+
+test_expect_success 'a remote added in a shallow repository defaults to the tracking refspec' '
+	test_when_finished "rm -rf shallow-add" &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		one shallow-add &&
+	(
+		cd shallow-add &&
+		git remote add upstream ../two &&
+		test_cmp_config "+:" remote.upstream.fetch &&
+		git fetch upstream &&
+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
+		cat >expect <<-\EOF &&
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		EOF
+		test_cmp expect actual &&
+		git branch --set-upstream-to=upstream &&
+		test_cmp_config upstream branch.main.remote &&
+		test_cmp_config refs/heads/main branch.main.merge
+	)
+'
+
 test_expect_success 'check remote-tracking' '
 	(
 		cd test &&
diff --git a/t/t5585-fetch-tracking-refspec.sh b/t/t5585-fetch-tracking-refspec.sh
new file mode 100755
index 0000000000..ebc3c5787f
--- /dev/null
+++ b/t/t5585-fetch-tracking-refspec.sh
@@ -0,0 +1,124 @@
+#!/bin/sh
+
+test_description='"git fetch" with the tracking refspec ":" (or "+:")
+
+The special refspec fetches whichever branches at the remote our local
+branches have as their @{upstream}, plus the default branch of that
+remote, which is always included so that it is available even before
+anything is set up to track it. git remote add uses it by default for
+a new remote in an already shallow repository, so that adding a
+second remote there does not turn the next plain fetch or pull into
+one that negotiates history for every branch the remote has.
+'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit main-1 &&
+	test_commit main-2 &&
+	git checkout -b side main-1 &&
+	test_commit side-1 &&
+	git checkout -b next main-1 &&
+	test_commit next-1 &&
+	git checkout main
+'
+
+test_expect_success 'clone shallow and single-branch, then add a second remote' '
+	git clone --no-local --depth=1 --branch main --single-branch . client &&
+	(
+		cd client &&
+		git remote add upstream .. &&
+		test_cmp_config "+:" remote.upstream.fetch
+	)
+'
+
+test_expect_success 'fetching the new remote does not need every branch it has' '
+	(
+		cd client &&
+		git fetch upstream &&
+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
+		cat >expect <<-\EOF &&
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'set-upstream-to now resolves right after that first fetch' '
+	(
+		cd client &&
+		git branch --set-upstream-to=upstream &&
+		test_cmp_config upstream branch.main.remote &&
+		test_cmp_config refs/heads/main branch.main.merge
+	)
+'
+
+test_expect_success 'a branch checked out from a one-time fetch is kept updated by later plain fetches' '
+	(
+		cd client &&
+		git fetch upstream side:refs/remotes/upstream/side &&
+		git branch side-topic upstream/side
+	) &&
+	git checkout side &&
+	test_commit side-2 &&
+	git checkout main &&
+	(
+		cd client &&
+		git fetch upstream &&
+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
+		cat >expect <<-\EOF &&
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		refs/remotes/upstream/side
+		EOF
+		test_cmp expect actual &&
+		git rev-parse refs/remotes/upstream/side >actual-oid &&
+		git -C .. rev-parse side >expect-oid &&
+		test_cmp expect-oid actual-oid
+	)
+'
+
+test_expect_success 'a second branch tracking the same upstream branch does not fetch it twice' '
+	(
+		cd client &&
+		git branch side-topic-2 upstream/side &&
+		git fetch upstream &&
+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
+		cat >expect <<-\EOF &&
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		refs/remotes/upstream/side
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'a branch tracking a different remote is not fetched from upstream' '
+	(
+		cd client &&
+		git remote add other .. &&
+		git fetch other next:refs/remotes/other/next &&
+		git branch next-topic other/next &&
+		git fetch upstream &&
+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
+		cat >expect <<-\EOF &&
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		refs/remotes/upstream/side
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'git remote show does not choke on the tracking refspec' '
+	(
+		cd client &&
+		git remote show upstream
+	)
+'
+
+test_done

base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
-- 
gitgitgadget
