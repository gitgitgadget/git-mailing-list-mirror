Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC5255F28
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333413; cv=none; b=DEadQHRPwaefeVq4Z7zjzr7DGtYLX+qgxV0wBls56KsnIbGx9sUjBcqItdoBp5IPsTongu5nB5GcihMHVxT59xiZkTeWhGTo6SqYMVe/iaQsgZ6tHC7s2YYeUUUhDuop9eJqRbp86KF0BCyrFg6w41HaIalXyPs0Ly+C2/xUerk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333413; c=relaxed/simple;
	bh=zO4luX2XwjStIpgJxb6PGCeKZDHv/8wfBWTpF0viI94=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UjCYvrwM5PXmzHxA63TZzdU5yRWO2OPqedfJopYXun1nfINI+0j73s3YVv0qblgStqINaDvcTJIKtBQPC4j7o8Q1gcIuFtPO+RaPep9rt3mKtkLNavXmxuzft/fUiP6LwYb9CotuO3wa6XZtZa02Jogg+Om3yGORp+LsBOa/TOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkhn78/P; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkhn78/P"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3396cec93b6so800370eec.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790333409; x=1790938209; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qKLp60y8CqXXgbd8uGUE5r8TUEiMA8LJakIenvmJ1Ec=;
        b=nkhn78/PdIEQ3av3TD+HpLjVebTvKixjltatnFyRPE/qv/B/QtkjnHNLukkZPnHKmQ
         3wetXTeOjyJ3s1aiASa+P2kABsbWxKIEZ6YiqUqfhuEr0rp4hFridmOTyN1gKXQ48J2/
         rSEQqPri92ypqEdXjQKgtXia64fsZVswDk+/nC0b6BhP6XQW9kqHWhp4CD9QBrbfmllY
         8/hAgvfkZI5mDhHx0S7GdDZctyuuxVwSWpNwth7XaqvzwNfMcMYXtNUx+o423ku4fTVy
         zHtPKIUTdY5DnBtk1dlgtbeyaxQ7ij7ioYWIAApqAEp19uPbXBpJ7Yd/SWNK7UX/wPuT
         Vr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790333409; x=1790938209;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qKLp60y8CqXXgbd8uGUE5r8TUEiMA8LJakIenvmJ1Ec=;
        b=fVBLOBc7EtSd0qLLdYcaBxv1PuUJPriPIjDdxhJoX2eANMkxdO0N/2tw0zuC5C9iUF
         26cgPRl3PDMhV4QwVwn69x/hSVinGNKNcD4dIshi7MVpjtlFQ8cd/pXWS/VBB1EiVaaE
         NXShcJwRUp6AoqvQYznuYb0QVZ4S7hlYUI5huNrT0JdffRciminCMPy8h5FVrD9/yhoC
         PWo7rcCJAzb2OAE1gU0koVxxac3qj9T3a1CzyeIsF4VOhktYj3ej26dtqnTkZNfLFAdU
         cRYtLvRq8/T2ihZ5+cVeb3FIuU5ddx2rGlPsdIKnM45dCcw42yVSp5Ih7QcDljk6/YQp
         NFXA==
X-Gm-Message-State: AFuF++nyEn6zqG8YxPUt8D0m6yUCraOdLpaLCbsVgvkuTrl7fAETXVU5
	N9FqHrbNgoFthT2Yse3O83f0xsJAeXShrqm7YB2ykIE6YoEy91o+GF+8TBxSq/na
X-Gm-Gg: AYBFou27/QYkx4SXVkRHPq3d1l2VvFjQk+pL3dpG6zK0LlJcU2ZyHg+TP20lGrNiLwu
	4ZKCym2O4p2GtvRXHxcwXcoU6aK6ykuVuZXfYo3N63Cj9CKsl0oiSDUH3m55w7v3/ug00JHeRRB
	/JbCOgGI0p19NjAS8Wh4O0e95oufSd99Ae+rNvgIHql47vyoZqQc64FtRjpk05YZl/m+zaj1Y4A
	lAlklkNmCSXWHqd5oeaSiY0KrpQWWWZlGfP1G3SwmoifvPy30mHTQJFtUqB/LiNKaDfOvnC/c0D
	zhzklXjX4cLJ4ZggLvUjkommlZWcwxAXufdEn8z5Obt+Mjp5JeeZYSLQvvrHwgMsnkoHQ9vhvsG
	a55q5EDJXFC1pL6BewnGLbwNuFs0HT1MOEzQ0RU0wcHzK9X3wJXrWNLwzhoeuKQX7BzodwdfhRY
	QX7kuDkg1AAIW2CjNOjhng99rcvQUcagVzNnD2O7no7dDWTi0LVTjBM1wMIl1dL+slD8IDqqlU
X-Received: by 2002:a05:7300:3715:b0:341:67fc:98df with SMTP id 5a478bee46e88-34167fca954mr2633568eec.12.1790333408119;
        Fri, 25 Sep 2026 03:50:08 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.7.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm5848551eec.17.2026.09.25.03.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 03:50:07 -0700 (PDT)
Message-Id: <4ec508a223a19c3aac8cf368e3dc0314ff6de479.1790333402.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v3.git.git.1790333402.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v3.git.git.1790333402.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Sep 2026 10:50:00 +0000
Subject: [PATCH v3 2/4] fetch: infer branches to fetch from a refmap-only
 remote
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

Configuring remote.<name>.refmap without remote.<name>.fetch used to
make a refspec-less "git fetch <name>" fail with "--refmap option is
only meaningful with command-line refspec(s)", since a refmap only
says where to put fetched refs, not what to fetch.

Make that case infer what to fetch: the local branches whose
@{upstream} is already on that remote, plus the remote's default
branch, which is always included so it is available even before
anything is set up to track it. This lets a remote be configured to
fetch only the branches actually in use, without listing them by
hand in remote.<name>.fetch, and without needing to touch the
command line every time.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |   7 +-
 Documentation/fetch-options.adoc |   8 +-
 builtin/fetch.c                  | 134 +++++++++++++++++++++++++------
 remote.c                         |  29 +++++++
 remote.h                         |   3 +
 t/meson.build                    |   1 +
 t/t5585-fetch-refmap.sh          | 124 ++++++++++++++++++++++++++++
 7 files changed, 277 insertions(+), 29 deletions(-)
 create mode 100755 t/t5585-fetch-refmap.sh

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 00f9ed8d3d..5b68af3af1 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -35,9 +35,10 @@ remote.<name>.fetch::
 
 remote.<name>.refmap::
 	The default value of the `--refmap` option for linkgit:git-fetch[1].
-	Only takes effect when the fetch names what to fetch explicitly,
-	either on the command line or via `remote.<name>.fetch`. See the
-	`--refmap` entry in linkgit:git-fetch[1].
+	If `remote.<name>.fetch` is not set either, a refspec-less fetch
+	infers what to fetch from local branches built on this remote,
+	instead of fetching every branch it has. See the `--refmap` entry
+	in linkgit:git-fetch[1].
 
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 538914bc6e..c973a07caf 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -245,8 +245,12 @@ endif::git-pull[]
 	command-line arguments. See section on "Configured Remote-tracking
 	Branches" for details.
 +
-`remote.<name>.refmap` provides the default value for this option, the
-same way `remote.<name>.fetch` provides the default refspecs to fetch.
+When a refmap is active (from `--refmap` or `remote.<name>.refmap`) but
+there is nothing to fetch, neither on the command line nor from
+`remote.<name>.fetch`, Git infers what to fetch from the local branches
+whose `@{upstream}` is on that remote, plus the remote's default branch,
+which is always included so that it is available even before anything
+is set up to track it.
 
 `-t`::
 `--tags`::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7651b41139..c8ce89cf30 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -503,7 +503,8 @@ static void filter_prefetch_refspec(struct refspec *rs)
 static struct ref *get_ref_map(struct remote *remote,
 			       const struct ref *remote_refs,
 			       struct refspec *rs,
-			       int tags, int *autotags)
+			       int tags, int *autotags,
+			       char **bootstrap_head_branch)
 {
 	int i;
 	struct ref *rm;
@@ -511,6 +512,8 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct ref **tail = &ref_map;
 	struct refspec *effective_refmap =
 		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
+	struct refspec inferred_rs;
+	int inferred_branches = 0;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
@@ -518,15 +521,71 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct hashmap existing_refs;
 	int existing_refs_populated = 0;
 
+	refspec_init_fetch(&inferred_rs, the_hash_algo);
+
 	filter_prefetch_refspec(rs);
 	if (remote)
 		filter_prefetch_refspec(&remote->fetch);
 
+	if (!rs->nr && remote && !remote->fetch.nr &&
+	    effective_refmap && effective_refmap->nr) {
+		struct string_list tracked = STRING_LIST_INIT_DUP;
+		struct string_list_item *item;
+		struct ref *head;
+		char *default_branch = NULL;
+		char *default_branch_dst = NULL;
+
+		branches_tracking_remote(remote, &tracked);
+		for_each_string_list_item(item, &tracked)
+			refspec_append(&inferred_rs, item->string);
+
+		/* Always fetch the default branch too, as "HEAD". */
+		head = get_remote_ref(remote_refs, "HEAD");
+		if (head && head->symref && *head->symref)
+			default_branch = xstrdup(head->symref);
+		free_one_ref(head);
+
+		for (i = 0; default_branch && !default_branch_dst &&
+			    !string_list_has_string(&tracked, default_branch) &&
+			    i < effective_refmap->nr; i++) {
+			struct refspec_item *map = &effective_refmap->items[i];
+
+			if (map->pattern)
+				match_refname_with_pattern(map->src, default_branch,
+							    map->dst, &default_branch_dst);
+			else if (!strcmp(map->src, default_branch))
+				default_branch_dst = xstrdup(map->dst);
+		}
+
+		if (default_branch_dst) {
+			struct refspec_item head_item = { .force = 1 };
+
+			head_item.src = xstrdup("HEAD");
+			head_item.dst = default_branch_dst;
+			get_fetch_map(remote_refs, &head_item, &tail, 1);
+			free(head_item.src);
+		}
+
+		if (default_branch && bootstrap_head_branch) {
+			const char *branch_name = default_branch;
+			skip_prefix(branch_name, "refs/heads/", &branch_name);
+			*bootstrap_head_branch = xstrdup(branch_name);
+		}
+
+		free(default_branch);
+		free(default_branch_dst);
+		string_list_clear(&tracked, 0);
+
+		rs = &inferred_rs;
+		inferred_branches = 1;
+	}
+
 	if (rs->nr) {
 		struct refspec *fetch_refspec;
 
 		for (i = 0; i < rs->nr; i++) {
-			get_fetch_map(remote_refs, &rs->items[i], &tail, 0);
+			get_fetch_map(remote_refs, &rs->items[i], &tail,
+				      inferred_branches);
 			if (rs->items[i].dst && rs->items[i].dst[0])
 				*autotags = 1;
 		}
@@ -561,6 +620,8 @@ static struct ref *get_ref_map(struct remote *remote,
 
 		for (i = 0; i < fetch_refspec->nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
+	} else if (inferred_branches) {
+		/* Already fully handled above. */
 	} else if (effective_refmap && effective_refmap->nr) {
 		die("--refmap option is only meaningful with command-line refspec(s)");
 	} else {
@@ -656,6 +717,7 @@ static struct ref *get_ref_map(struct remote *remote,
 	if (existing_refs_populated)
 		hashmap_clear_and_free(&existing_refs, struct refname_hash_entry, ent);
 
+	refspec_clear(&inferred_rs);
 	return ref_map;
 }
 
@@ -1753,14 +1815,14 @@ static void warn_set_head(const char *remote, const char *head_name,
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
@@ -1771,19 +1833,23 @@ static int set_head(const struct ref *remote_refs, struct remote *remote,
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
@@ -1925,6 +1991,7 @@ static int do_fetch(struct transport *transport,
 	struct strmap rejected_refs = STRMAP_INIT;
 	int summary_width = 0;
 	int follow_remote_head;
+	char *bootstrap_head_branch = NULL;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1960,15 +2027,31 @@ static int do_fetch(struct transport *transport,
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
 		struct branch *branch = branch_get(NULL);
-
-		if (transport->remote->fetch.nr) {
+		int tracks_this_remote = branch && branch_has_merge_config(branch) &&
+			!strcmp(branch->remote_name, transport->remote->name);
+		struct refspec *effective_refmap = refmap.nr ? &refmap :
+			&transport->remote->refmap;
+		int inferred_branches = !transport->remote->fetch.nr &&
+			effective_refmap->nr;
+
+		if (inferred_branches) {
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
+		if ((transport->remote->fetch.nr || inferred_branches) &&
+		    follow_remote_head != FOLLOW_REMOTE_NEVER)
+			do_set_head = 1;
+		if (tracks_this_remote) {
 			int i;
 			for (i = 0; i < branch->merge_nr; i++) {
 				strvec_push(&transport_ls_refs_options.ref_prefixes,
@@ -2008,7 +2091,8 @@ static int do_fetch(struct transport *transport,
 	transport_ls_refs_options_release(&transport_ls_refs_options);
 
 	ref_map = get_ref_map(transport->remote, remote_refs, rs,
-			      tags, &autotags);
+			      tags, &autotags, &bootstrap_head_branch);
+
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
@@ -2171,10 +2255,12 @@ static int do_fetch(struct transport *transport,
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
diff --git a/remote.c b/remote.c
index 017cd9d13e..a5deb9b929 100644
--- a/remote.c
+++ b/remote.c
@@ -1884,6 +1884,35 @@ int branch_merge_matches(struct branch *branch,
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
diff --git a/remote.h b/remote.h
index ac485a584d..da6c3ef53a 100644
--- a/remote.h
+++ b/remote.h
@@ -359,6 +359,9 @@ int branch_has_merge_config(struct branch *branch);
 
 int branch_merge_matches(struct branch *, int n, const char *);
 
+/* fills tracked with the refname of every local branch's upstream on remote */
+void branches_tracking_remote(struct remote *remote, struct string_list *tracked);
+
 /* list of the remote in a group as configured */
 struct remote_group_data {
 	const char *name;
diff --git a/t/meson.build b/t/meson.build
index 3ca7b27104..ab83d5409c 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -728,6 +728,7 @@ integration_tests = [
   't5582-fetch-negative-refspec.sh',
   't5583-push-branches.sh',
   't5584-http-429-retry.sh',
+  't5585-fetch-refmap.sh',
   't5600-clone-fail-cleanup.sh',
   't5601-clone.sh',
   't5602-clone-remote-exec.sh',
diff --git a/t/t5585-fetch-refmap.sh b/t/t5585-fetch-refmap.sh
new file mode 100755
index 0000000000..4b1f51f6cd
--- /dev/null
+++ b/t/t5585-fetch-refmap.sh
@@ -0,0 +1,124 @@
+#!/bin/sh
+
+test_description='"git fetch" with a remote.<name>.refmap but no remote.<name>.fetch
+
+When a remote has a refmap configured but no fetch refspec, a
+refspec-less fetch infers what to fetch from the local branches whose
+@{upstream} is on that remote, plus the default branch of that remote,
+which is always included so that it is available even before anything
+is set up to track it.
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
+		test_might_fail git config unset remote.upstream.fetch &&
+		git config remote.upstream.refmap \
+			"+refs/heads/*:refs/remotes/upstream/*"
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
+test_expect_success 'git remote show does not choke on a refmap-only remote' '
+	(
+		cd client &&
+		git remote show upstream
+	)
+'
+
+test_done
-- 
gitgitgadget

