Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CD5255F28
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333408; cv=none; b=cLK6OQxGALO1VP1iGtu0ZmPQljDugo/Ui13o92dFwj2f2wKUolTo9vh0LOdes5mgqo5wnllzf/3XesXvVjyBbQjEfC5QQJPMlX6QPxyW0JgCFNkFf67lstrDvFhHR4oO+oXK+NH8Gnmg+ojqHbriGV2kxYAcgd+vfEbeUbfN0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333408; c=relaxed/simple;
	bh=UeuvJwQ6S71wV8ELfMpHJamTc/sbJ6E59XAzXkYkbjk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ADo4M0B0xLD2EiJa7Nzo5scNKg4uJ/GamlJX9nS+dSjBeZJwfSrgkDp6gQ0h6jgqauHlhAxDkv323OCDcU25uxV3M5ONDsB7WSaUVKSBB8pYcLwUNnG8qLTPhuI0rUws5+HMnap6S0JV0qXtuF6/cYRJvm0pOp3bX92lmbKJ7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsbm9jbu; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsbm9jbu"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-340f56c44b0so301547eec.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 03:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790333405; x=1790938205; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KwJoeGVzrHbmctaWxO48C4wq/7XJ0sMkR5qlomJLfkc=;
        b=nsbm9jbuyYcEdoseX5uhMfbabkcMt8zLujvT/IGdk+pf2cn9GSlTI/ql55iRKAKp27
         WsnsR70pZDXR2gD/saTd+g42S9+MZ07G/xFwyfN2oEMV7z3UvBC8xU7nDNl79U02eFHx
         5gd0cDHzt4nCAZvQW3P8iJa6Xp3CXhU5OIcfmE8fM16RvNiYBKygmtkNmxsK/ToH+EAt
         7WtHxdK43gBX7TjoTrP9U9fhOlFI09XgpTsY0zotOeR4x+sy6t0WrOPZZ0UY9rAhz6ii
         gO5JRD0t5g7LrdWQoUKQrltqHcfJV7lFe/1TjyV9CKuiJnihp5vLarq5iV7WvsBDTFZe
         YbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790333405; x=1790938205;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KwJoeGVzrHbmctaWxO48C4wq/7XJ0sMkR5qlomJLfkc=;
        b=ylfrM3+ZIdvjpLPL3BNmR9Q8z5DA6n6CAAe6JFkPnsy59NUrMOhIchdKe2NyvudsVI
         vn68Z5S2TUdWxTYLRnCHqxorecgRF2MP33+bKNvd5Q3n9Sxju4TxqaLtG3V5wJID1eU/
         pnc9OSWg8xw7n3kFwMsd46nHL9PgbO/9osOBkurXoSO7JOmDJhL8WM3MFRicCzwk0+Na
         i7s+HqSV3mEdBTI3qnC9zigoJmYf5LSGr0hq7TjU4mTRuDZC6Twda4O3M0j1pfwlzBmC
         8VJ7hsQopdpN+JNBsgdeQXLp1xRFB73rId/CZ3NjhTjcryzLctubfm0wGD+4OyxOqLEw
         P8ZQ==
X-Gm-Message-State: AFuF++nSpSBr/+r5dETAf04azKntj7dlMt5qT4j+DhhUG5Mi2iD7tTzv
	lwBpjG0lQO2JEAgbgQwL5zyJ/ZMwOs1pKcf0wFDNBGldgfYmMxptP0CvYvX220Sc
X-Gm-Gg: AYBFou3LU9UZfaaUlQ00nuPneLtIIsIxV8C3U6/eFidmwbek2GuJxvR6N65pzkuAqlT
	dZ/nxmXu9zJ3fVznStwrGSHGVPlWmqUavHfThDvM0I3ZZho5s+gmOzs7QhiLNJgBDxDNWCGB7wV
	cBUZquMwKWaicbSyO7+ash2otVUjgH3SotJC4Vljg+iNbvBRwpK02LBaBKTV1J672P4A4NrxdWJ
	xB0juvr0iJ+hujYPl/Oul4aLtKMxuP4AI8F0U9fnG72lTzU7qo2UI1iQdh+f6j38x+4+pstsfIT
	IlNmjsS652640boF56/4JfAVgVto4Cx6YFIhQ6j2yZTqFADSJdgQqiQBnNuNycFwdWIRsgw+z8J
	J0lySRu/9gtAxjUmlAfrpZgMg1447DYWIr5ViTYhK1ThoJSB9Ql5GrY02ABz6ZwAfLW2MPcnwP1
	kxn3yjWJtdRYu5H0/3E/K8TeghQdz3B/FDp1OZ22QvlNbUtlNEpqQqim2t8tvtj2Nk4544ITY=
X-Received: by 2002:a05:7301:700c:b0:33b:f588:805e with SMTP id 5a478bee46e88-34000738444mr4568407eec.20.1790333404632;
        Fri, 25 Sep 2026 03:50:04 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.7.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341460f5166sm5945157eec.29.2026.09.25.03.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 03:50:04 -0700 (PDT)
Message-Id: <pull.2412.v3.git.git.1790333402.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Sep 2026 10:49:58 +0000
Subject: [PATCH v3 0/4] fetch: avoid fetching every branch of a new remote in a shallow repo
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
    Harald Nordgren <haraldnordgren@gmail.com>

Avoid fetching every branch of a new remote in a shallow repo.

Changes in v3:

 * Replace the special ":"/"+:" fetch refspec with remote.<name>.refmap,
   reusing git's existing --refmap mechanism instead of inventing new
   refspec syntax.
 * Split the change into 4 commits.

Changes in v2:

 * Replaced the opt-in fetch.shallow config entirely with a new special
   fetch refspec (+:) that git remote add now defaults new remotes to in a
   shallow repository. The new refspec fetches whichever branches any local
   branch tracks at that remote, plus the remote's default branch.

Harald Nordgren (4):
  fetch: add remote.<name>.refmap
  fetch: infer branches to fetch from a refmap-only remote
  remote: add "git remote add --limited-fetch"
  remote: default to --limited-fetch in a shallow repository

 Documentation/config/remote.adoc |   7 ++
 Documentation/fetch-options.adoc |   7 ++
 Documentation/git-remote.adoc    |  14 ++-
 builtin/fetch.c                  | 142 +++++++++++++++++++++++++------
 builtin/remote.c                 |  31 +++++--
 remote.c                         |  41 ++++++++-
 remote.h                         |   9 ++
 t/meson.build                    |   1 +
 t/t5505-remote.sh                |  75 ++++++++++++++++
 t/t5510-fetch.sh                 |  17 ++++
 t/t5585-fetch-refmap.sh          | 124 +++++++++++++++++++++++++++
 11 files changed, 433 insertions(+), 35 deletions(-)
 create mode 100755 t/t5585-fetch-refmap.sh


base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v3
Pull-Request: https://github.com/git/git/pull/2412

Range-diff vs v2:

 -:  ---------- > 1:  b04c00b974 fetch: add remote.<name>.refmap
 1:  f04f5ce219 ! 2:  4ec508a223 fetch: avoid fetching every branch of a new remote in a shallow repo
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    fetch: avoid fetching every branch of a new remote in a shallow repo
     +    fetch: infer branches to fetch from a refmap-only remote
      
     -    git remote add sets a new remote up to fetch every branch by default.
     -    In an already shallow repository, that turns the next plain fetch or
     -    pull into a slow or hanging one, even when only one or two branches
     -    are ever used.
     +    Configuring remote.<name>.refmap without remote.<name>.fetch used to
     +    make a refspec-less "git fetch <name>" fail with "--refmap option is
     +    only meaningful with command-line refspec(s)", since a refmap only
     +    says where to put fetched refs, not what to fetch.
      
     -    Add a special fetch refspec, "+:", that fetches only the branches our
     -    local branches are built on, plus the remote's default branch so a
     -    brand new remote is usable right away, without needing to first set
     -    anything up to track it. git remote add now uses it instead of the
     -    usual wildcard refspec whenever the repository is already shallow.
     +    Make that case infer what to fetch: the local branches whose
     +    @{upstream} is already on that remote, plus the remote's default
     +    branch, which is always included so it is available even before
     +    anything is set up to track it. This lets a remote be configured to
     +    fetch only the branches actually in use, without listing them by
     +    hand in remote.<name>.fetch, and without needing to touch the
     +    command line every time.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     - ## Documentation/git-remote.adoc ##
     -@@ Documentation/git-remote.adoc: Add a remote named _<name>_ for the repository at
     - _<URL>_.  The command `git fetch <name>` can then be used to create and
     - update remote-tracking branches `<name>/<branch>`.
     - +
     -+If the repository is already a shallow repository (see linkgit:git-clone[1]
     -+`--depth`) and neither `-t` nor `--mirror` is given, the remote is set up
     -+with the special tracking refspec (see the _<refspec>_ entry in
     -+linkgit:git-fetch[1]) instead of the default glob refspec, so that
     -+`git fetch <name>` does not need to negotiate history for every branch
     -+the remote has.
     -++
     - With `-f` option, `git fetch <name>` is run immediately after
     - the remote information is set up.
     - +
     + ## Documentation/config/remote.adoc ##
     +@@ Documentation/config/remote.adoc: remote.<name>.fetch::
     + 
     + remote.<name>.refmap::
     + 	The default value of the `--refmap` option for linkgit:git-fetch[1].
     +-	Only takes effect when the fetch names what to fetch explicitly,
     +-	either on the command line or via `remote.<name>.fetch`. See the
     +-	`--refmap` entry in linkgit:git-fetch[1].
     ++	If `remote.<name>.fetch` is not set either, a refspec-less fetch
     ++	infers what to fetch from local branches built on this remote,
     ++	instead of fetching every branch it has. See the `--refmap` entry
     ++	in linkgit:git-fetch[1].
     + 
     + remote.<name>.push::
     + 	The default set of "refspec" for linkgit:git-push[1]. See
      
     - ## Documentation/pull-fetch-param.adoc ##
     -@@ Documentation/pull-fetch-param.adoc: Negative refspecs can themselves be pattern refspecs. However, they may only
     - contain a _<src>_ and do not specify a _<dst>_. Fully spelled out hex object
     - names are also not supported.
     - +
     -+The special refspec `:` (or `+:` to allow non-fast-forward updates)
     -+directs Git to fetch whichever branches at the remote our local branches
     -+have as their `@{upstream}`, plus the remote's default branch, which is
     -+always included so that it is available even before anything is set up
     -+to track it. Unlike the same syntax when pushing, the local branch name
     -+plays no role here beyond identifying which remote branch to fetch: the
     -+result is written to `refs/remotes/<remote>/<branch>` using the remote's
     -+own branch name, and several local branches built on the same remote
     -+branch only cause it to be fetched once.
     -++
     - `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`;
     - it requests fetching everything up to the given tag.
     + ## Documentation/fetch-options.adoc ##
     +@@ Documentation/fetch-options.adoc: endif::git-pull[]
     + 	command-line arguments. See section on "Configured Remote-tracking
     + 	Branches" for details.
       +
     +-`remote.<name>.refmap` provides the default value for this option, the
     +-same way `remote.<name>.fetch` provides the default refspecs to fetch.
     ++When a refmap is active (from `--refmap` or `remote.<name>.refmap`) but
     ++there is nothing to fetch, neither on the command line nor from
     ++`remote.<name>.fetch`, Git infers what to fetch from the local branches
     ++whose `@{upstream}` is on that remote, plus the remote's default branch,
     ++which is always included so that it is available even before anything
     ++is set up to track it.
     + 
     + `-t`::
     + `--tags`::
      
       ## builtin/fetch.c ##
      @@ builtin/fetch.c: static void filter_prefetch_refspec(struct refspec *rs)
     - 	}
     - }
     - 
     -+static void fetch_tracked_branches(struct remote *remote,
     -+				   const struct ref *remote_refs,
     -+				   struct ref ***tail,
     -+				   char **default_branch_out,
     -+				   int force)
     -+{
     -+	struct string_list tracked = STRING_LIST_INIT_DUP;
     -+	struct string_list_item *item;
     -+	struct ref *head;
     -+	char *default_branch = NULL;
     -+
     -+	branches_tracking_remote(remote, &tracked);
     -+
     -+	head = get_remote_ref(remote_refs, "HEAD");
     -+	if (head && head->symref && *head->symref) {
     -+		default_branch = xstrdup(head->symref);
     -+		string_list_insert(&tracked, default_branch);
     -+	}
     -+	free_one_ref(head);
     -+
     -+	for_each_string_list_item(item, &tracked) {
     -+		struct refspec_item ref = { .force = force };
     -+		const char *branch_name = item->string;
     -+		int is_default_branch = default_branch &&
     -+			!strcmp(item->string, default_branch);
     -+
     -+		skip_prefix(branch_name, "refs/heads/", &branch_name);
     -+		ref.src = xstrdup(is_default_branch ? "HEAD" : item->string);
     -+		ref.dst = xstrfmt("refs/remotes/%s/%s", remote->name, branch_name);
     -+		get_fetch_map(remote_refs, &ref, tail, 1);
     -+		free(ref.src);
     -+		free(ref.dst);
     -+	}
     -+
     -+	if (default_branch && default_branch_out) {
     -+		const char *branch_name = default_branch;
     -+		skip_prefix(branch_name, "refs/heads/", &branch_name);
     -+		*default_branch_out = xstrdup(branch_name);
     -+	}
     -+
     -+	free(default_branch);
     -+	string_list_clear(&tracked, 0);
     -+}
     -+
       static struct ref *get_ref_map(struct remote *remote,
       			       const struct ref *remote_refs,
       			       struct refspec *rs,
     @@ builtin/fetch.c: static void filter_prefetch_refspec(struct refspec *rs)
       	int i;
       	struct ref *rm;
      @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     - 		     /* Note: has_merge implies non-NULL branch->remote_name */
     - 		     (has_merge && !strcmp(branch->remote_name, remote->name)))) {
     - 			for (i = 0; i < remote->fetch.nr; i++) {
     -+				if (remote->fetch.items[i].tracking) {
     -+					fetch_tracked_branches(remote, remote_refs, &tail,
     -+								bootstrap_head_branch,
     -+								remote->fetch.items[i].force);
     -+					continue;
     -+				}
     - 				get_fetch_map(remote_refs, &remote->fetch.items[i], &tail, 0);
     - 				if (remote->fetch.items[i].dst &&
     - 				    remote->fetch.items[i].dst[0])
     + 	struct ref **tail = &ref_map;
     + 	struct refspec *effective_refmap =
     + 		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
     ++	struct refspec inferred_rs;
     ++	int inferred_branches = 0;
     + 
     + 	/* opportunistically-updated references: */
     + 	struct ref *orefs = NULL, **oref_tail = &orefs;
     +@@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     + 	struct hashmap existing_refs;
     + 	int existing_refs_populated = 0;
     + 
     ++	refspec_init_fetch(&inferred_rs, the_hash_algo);
     ++
     + 	filter_prefetch_refspec(rs);
     + 	if (remote)
     + 		filter_prefetch_refspec(&remote->fetch);
     + 
     ++	if (!rs->nr && remote && !remote->fetch.nr &&
     ++	    effective_refmap && effective_refmap->nr) {
     ++		struct string_list tracked = STRING_LIST_INIT_DUP;
     ++		struct string_list_item *item;
     ++		struct ref *head;
     ++		char *default_branch = NULL;
     ++		char *default_branch_dst = NULL;
     ++
     ++		branches_tracking_remote(remote, &tracked);
     ++		for_each_string_list_item(item, &tracked)
     ++			refspec_append(&inferred_rs, item->string);
     ++
     ++		/* Always fetch the default branch too, as "HEAD". */
     ++		head = get_remote_ref(remote_refs, "HEAD");
     ++		if (head && head->symref && *head->symref)
     ++			default_branch = xstrdup(head->symref);
     ++		free_one_ref(head);
     ++
     ++		for (i = 0; default_branch && !default_branch_dst &&
     ++			    !string_list_has_string(&tracked, default_branch) &&
     ++			    i < effective_refmap->nr; i++) {
     ++			struct refspec_item *map = &effective_refmap->items[i];
     ++
     ++			if (map->pattern)
     ++				match_refname_with_pattern(map->src, default_branch,
     ++							    map->dst, &default_branch_dst);
     ++			else if (!strcmp(map->src, default_branch))
     ++				default_branch_dst = xstrdup(map->dst);
     ++		}
     ++
     ++		if (default_branch_dst) {
     ++			struct refspec_item head_item = { .force = 1 };
     ++
     ++			head_item.src = xstrdup("HEAD");
     ++			head_item.dst = default_branch_dst;
     ++			get_fetch_map(remote_refs, &head_item, &tail, 1);
     ++			free(head_item.src);
     ++		}
     ++
     ++		if (default_branch && bootstrap_head_branch) {
     ++			const char *branch_name = default_branch;
     ++			skip_prefix(branch_name, "refs/heads/", &branch_name);
     ++			*bootstrap_head_branch = xstrdup(branch_name);
     ++		}
     ++
     ++		free(default_branch);
     ++		free(default_branch_dst);
     ++		string_list_clear(&tracked, 0);
     ++
     ++		rs = &inferred_rs;
     ++		inferred_branches = 1;
     ++	}
     ++
     + 	if (rs->nr) {
     + 		struct refspec *fetch_refspec;
     + 
     + 		for (i = 0; i < rs->nr; i++) {
     +-			get_fetch_map(remote_refs, &rs->items[i], &tail, 0);
     ++			get_fetch_map(remote_refs, &rs->items[i], &tail,
     ++				      inferred_branches);
     + 			if (rs->items[i].dst && rs->items[i].dst[0])
     + 				*autotags = 1;
     + 		}
     +@@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     + 
     + 		for (i = 0; i < fetch_refspec->nr; i++)
     + 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
     ++	} else if (inferred_branches) {
     ++		/* Already fully handled above. */
     + 	} else if (effective_refmap && effective_refmap->nr) {
     + 		die("--refmap option is only meaningful with command-line refspec(s)");
     + 	} else {
     +@@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     + 	if (existing_refs_populated)
     + 		hashmap_clear_and_free(&existing_refs, struct refname_hash_entry, ent);
     + 
     ++	refspec_clear(&inferred_rs);
     + 	return ref_map;
     + }
     + 
      @@ builtin/fetch.c: static void warn_set_head(const char *remote, const char *head_name,
       }
       
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
       		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
       	} else {
       		struct branch *branch = branch_get(NULL);
     +-
     +-		if (transport->remote->fetch.nr) {
      +		int tracks_this_remote = branch && branch_has_merge_config(branch) &&
      +			!strcmp(branch->remote_name, transport->remote->name);
     -+		int tracking_refspec = transport->remote->fetch.nr == 1 &&
     -+			transport->remote->fetch.items[0].tracking;
     - 
     --		if (transport->remote->fetch.nr) {
     -+		if (tracking_refspec) {
     ++		struct refspec *effective_refmap = refmap.nr ? &refmap :
     ++			&transport->remote->refmap;
     ++		int inferred_branches = !transport->remote->fetch.nr &&
     ++			effective_refmap->nr;
     ++
     ++		if (inferred_branches) {
      +			struct string_list tracked = STRING_LIST_INIT_DUP;
      +			struct string_list_item *item;
      +
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
       		}
      -		if (branch && branch_has_merge_config(branch) &&
      -		    !strcmp(branch->remote_name, transport->remote->name)) {
     -+		if (transport->remote->fetch.nr &&
     ++		if ((transport->remote->fetch.nr || inferred_branches) &&
      +		    follow_remote_head != FOLLOW_REMOTE_NEVER)
      +			do_set_head = 1;
      +		if (tracks_this_remote) {
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
       	 * When using batched updates, we want to commit the non-rejected
       	 * updates and also handle the rejections.
      
     - ## builtin/remote.c ##
     -@@
     - #include "rebase.h"
     - #include "refs.h"
     - #include "refspec.h"
     -+#include "shallow.h"
     - #include "odb.h"
     - #include "strvec.h"
     - #include "commit-reach.h"
     -@@ builtin/remote.c: static void add_branch(const char *key, const char *branchname,
     - 		       const char *remotename, int mirror, struct strbuf *tmp)
     - {
     - 	strbuf_reset(tmp);
     --	strbuf_addch(tmp, '+');
     --	if (mirror)
     --		strbuf_addf(tmp, "refs/%s:refs/%s",
     --				branchname, branchname);
     --	else
     --		strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
     --				branchname, remotename, branchname);
     -+	if (!strcmp(branchname, ":")) {
     -+		strbuf_addstr(tmp, "+:");
     -+	} else {
     -+		strbuf_addch(tmp, '+');
     -+		if (mirror)
     -+			strbuf_addf(tmp, "refs/%s:refs/%s",
     -+					branchname, branchname);
     -+		else
     -+			strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
     -+					branchname, remotename, branchname);
     -+	}
     - 	repo_config_set_multivar(the_repository, key, tmp->buf, "^$", 0);
     - }
     - 
     -@@ builtin/remote.c: static int add(int argc, const char **argv, const char *prefix,
     - 		strbuf_reset(&buf);
     - 		strbuf_addf(&buf, "remote.%s.fetch", name);
     - 		if (track.nr == 0)
     --			string_list_append(&track, "*");
     --		for (size_t i = 0; i < track.nr; i++) {
     -+			string_list_append(&track,
     -+				mirror == MIRROR_NONE &&
     -+				is_repository_shallow(the_repository) ?
     -+				":" : "*");
     -+		for (size_t i = 0; i < track.nr; i++)
     - 			add_branch(buf.buf, track.items[i].string,
     - 				   name, mirror, &buf2);
     --		}
     - 	}
     - 
     - 	if (mirror & MIRROR_PUSH) {
     -
     - ## refspec.c ##
     -@@ refspec.c: static int parse_refspec(struct refspec_item *item, const char *refspec,
     - 		return 1;
     - 	}
     - 
     -+	if (fetch && rhs == lhs && rhs[1] == '\0') {
     -+		item->tracking = 1;
     -+		return 1;
     -+	}
     -+
     - 	if (rhs) {
     - 		size_t rlen = strlen(++rhs);
     - 		is_glob = (1 <= rlen && strchr(rhs, '*'));
     -@@ refspec.c: void refspec_item_clear(struct refspec_item *item)
     - 	item->force = 0;
     - 	item->pattern = 0;
     - 	item->matching = 0;
     -+	item->tracking = 0;
     - 	item->exact_sha1 = 0;
     - }
     - 
     -@@ refspec.c: static int refspec_find_negative_match(struct refspec *rs, struct refspec_item *
     - 		struct refspec_item *refspec = &rs->items[i];
     - 		char *expn_name;
     - 
     --		if (refspec->negative)
     -+		if (refspec->negative || refspec->tracking)
     - 			continue;
     - 
     - 		/* Note the reversal of src and dst */
     -
     - ## refspec.h ##
     -@@ refspec.h: struct refspec_item {
     - 	unsigned matching : 1;
     - 	unsigned exact_sha1 : 1;
     - 	unsigned negative : 1;
     -+	unsigned tracking : 1;
     - 
     - 	char *src;
     - 	char *dst;
     -
       ## remote.c ##
     -@@ remote.c: void ref_push_report_free(struct ref_push_report *report)
     - 
     - int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
     - {
     -+	if (remote->fetch.nr == 1 && remote->fetch.items[0].tracking) {
     -+		struct strbuf prefix = STRBUF_INIT;
     -+		const char *branch_name;
     -+		int ret = -1;
     -+
     -+		strbuf_addf(&prefix, "refs/remotes/%s/", remote->name);
     -+		if (!refspec->src) {
     -+			if (refspec->dst &&
     -+			    skip_prefix(refspec->dst, prefix.buf, &branch_name)) {
     -+				refspec->src = xstrfmt("refs/heads/%s", branch_name);
     -+				refspec->force = 1;
     -+				ret = 0;
     -+			}
     -+		} else if (skip_prefix(refspec->src, "refs/heads/", &branch_name)) {
     -+			free(refspec->dst);
     -+			refspec->dst = xstrfmt("%s%s", prefix.buf, branch_name);
     -+			refspec->force = 1;
     -+			ret = 0;
     -+		}
     -+		strbuf_release(&prefix);
     -+		return ret;
     -+	}
     -+
     - 	return refspec_find_match(&remote->fetch, refspec);
     - }
     - 
      @@ remote.c: int branch_merge_matches(struct branch *branch,
       	return refname_match(branch->merge[i]->src, refname);
       }
     @@ remote.c: int branch_merge_matches(struct branch *branch,
       __attribute__((format (printf,2,3)))
       static char *error_buf(struct strbuf *err, const char *fmt, ...)
       {
     -@@ remote.c: int get_fetch_map(const struct ref *remote_refs,
     - {
     - 	struct ref *ref_map, **rmp;
     - 
     --	if (refspec->negative)
     -+	if (refspec->negative || refspec->tracking)
     - 		return 0;
     - 
     - 	if (refspec->pattern) {
      
       ## remote.h ##
      @@ remote.h: int branch_has_merge_config(struct branch *branch);
     @@ t/meson.build: integration_tests = [
         't5582-fetch-negative-refspec.sh',
         't5583-push-branches.sh',
         't5584-http-429-retry.sh',
     -+  't5585-fetch-tracking-refspec.sh',
     ++  't5585-fetch-refmap.sh',
         't5600-clone-fail-cleanup.sh',
         't5601-clone.sh',
         't5602-clone-remote-exec.sh',
      
     - ## t/t5505-remote.sh ##
     -@@ t/t5505-remote.sh: test_expect_success 'filters are listed by git remote -v only' '
     - 	test_grep ! "\[blob:none\]" out
     - '
     - 
     -+test_expect_success 'add remote -t keeps an explicit refspec in a shallow repository' '
     -+	test_when_finished "rm -rf shallow-add" &&
     -+	git clone --no-local --depth=1 --branch main --single-branch \
     -+		one shallow-add &&
     -+	(
     -+		cd shallow-add &&
     -+		git remote add -t main upstream ../two &&
     -+		test_cmp_config "+refs/heads/main:refs/remotes/upstream/main" \
     -+			remote.upstream.fetch
     -+	)
     -+'
     -+
     -+test_expect_success 'add remote keeps the wildcard refspec in a full repository' '
     -+	test_when_finished "rm -rf full-add" &&
     -+	git clone --no-local one full-add &&
     -+	(
     -+		cd full-add &&
     -+		git remote add upstream ../two &&
     -+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
     -+			remote.upstream.fetch
     -+	)
     -+'
     -+
     -+test_expect_success 'a remote added in a shallow repository defaults to the tracking refspec' '
     -+	test_when_finished "rm -rf shallow-add" &&
     -+	git clone --no-local --depth=1 --branch main --single-branch \
     -+		one shallow-add &&
     -+	(
     -+		cd shallow-add &&
     -+		git remote add upstream ../two &&
     -+		test_cmp_config "+:" remote.upstream.fetch &&
     -+		git fetch upstream &&
     -+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
     -+		cat >expect <<-\EOF &&
     -+		refs/remotes/upstream/HEAD
     -+		refs/remotes/upstream/main
     -+		EOF
     -+		test_cmp expect actual &&
     -+		git branch --set-upstream-to=upstream &&
     -+		test_cmp_config upstream branch.main.remote &&
     -+		test_cmp_config refs/heads/main branch.main.merge
     -+	)
     -+'
     -+
     - test_expect_success 'check remote-tracking' '
     - 	(
     - 		cd test &&
     -
     - ## t/t5585-fetch-tracking-refspec.sh (new) ##
     + ## t/t5585-fetch-refmap.sh (new) ##
      @@
      +#!/bin/sh
      +
     -+test_description='"git fetch" with the tracking refspec ":" (or "+:")
     ++test_description='"git fetch" with a remote.<name>.refmap but no remote.<name>.fetch
      +
     -+The special refspec fetches whichever branches at the remote our local
     -+branches have as their @{upstream}, plus the default branch of that
     -+remote, which is always included so that it is available even before
     -+anything is set up to track it. git remote add uses it by default for
     -+a new remote in an already shallow repository, so that adding a
     -+second remote there does not turn the next plain fetch or pull into
     -+one that negotiates history for every branch the remote has.
     ++When a remote has a refmap configured but no fetch refspec, a
     ++refspec-less fetch infers what to fetch from the local branches whose
     ++@{upstream} is on that remote, plus the default branch of that remote,
     ++which is always included so that it is available even before anything
     ++is set up to track it.
      +'
      +
      +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     @@ t/t5585-fetch-tracking-refspec.sh (new)
      +	(
      +		cd client &&
      +		git remote add upstream .. &&
     -+		test_cmp_config "+:" remote.upstream.fetch
     ++		test_might_fail git config unset remote.upstream.fetch &&
     ++		git config remote.upstream.refmap \
     ++			"+refs/heads/*:refs/remotes/upstream/*"
      +	)
      +'
      +
     @@ t/t5585-fetch-tracking-refspec.sh (new)
      +	)
      +'
      +
     -+test_expect_success 'git remote show does not choke on the tracking refspec' '
     ++test_expect_success 'git remote show does not choke on a refmap-only remote' '
      +	(
      +		cd client &&
      +		git remote show upstream
 -:  ---------- > 3:  604e584956 remote: add "git remote add --limited-fetch"
 -:  ---------- > 4:  31462e9445 remote: default to --limited-fetch in a shallow repository

-- 
gitgitgadget
