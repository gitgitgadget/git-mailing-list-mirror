Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545BC4756CA
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961465; cv=none; b=p5xbapTUizxk74rr41hWznPw6cA2xHuwVbdR5cwyIa++XcET3ADnSlHN5UsKy1bA2NSAOCq1YqHEdvbeE6ztK9tJkJeBnyFHF33QhjuZD2l9uA2ci5lOB5kxAWaZwV8x8sC0hEsCtxtksCkzg14PohjCmtVr/oVDO0Ck0v4Tx5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961465; c=relaxed/simple;
	bh=jTzwV6RPDjfFOt3Py4cw618HJyzQTyBU+E9DpX7q6xw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Die8HNt6S75z289Jset/nWjsp29D/QEd9l1+xHSUQSuVltTt861iPt+vM5DFWlnQWqLThpr7qgpyErXN/8RQgb0ggHd17D4EHVGkGx+fExL3aBhhJwGNdEXcsjZwuCFtUlp19mNNRhlC7APjkot3at2j8HtVWofazA8idNcwZcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmBQusz9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmBQusz9"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e946155442so983825ad.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 00:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791961464; x=1792566264; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JhmaEY53gOuhOV8Ppfqe0IwGpEzYid2aLyszRIZPlbY=;
        b=hmBQusz9SYb4vW+IJ548Wlj+yvVd0cLxyDPFq5kC7sylpnkLRuLl8lj6eFjwa200ry
         8wizAdJZrq4GC4k9dYYHThAzr/fHnCZE++D4twan14d7kFuUdaY0Mt6GudjOLll3t1An
         YVKPu/eN7kTNA7y+WD7h3SlPtNPtHeX1K+BfeYmmXXorpMP+LLjJ7J5O0RstZTiTwbAf
         tLKp6XrwtTtehN753ZLPQvHSW1G8NlXJBogj4GoDkP5GIo9+1JG1FhTfdedl/t+MDtXA
         UcKw8wtwrvoJ4JcQFjZ4+VNd+XyAlz6cnqXTUdTM/YWGuHynRt+wK6WtLbtJ2nIrwazY
         oBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791961464; x=1792566264;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JhmaEY53gOuhOV8Ppfqe0IwGpEzYid2aLyszRIZPlbY=;
        b=aaunzlGCyday8RY8nzeJacAh1zSOtz+BRb8oWP7ouMaGS45WJq1KJU2ZWONZEK3JUT
         ZOi4b2/RLNi7lGK4hobduhLgryaAmPJLpgh3AYkiIaSOrFgtK1/WAUd1K5Keo33NqlTX
         YOfZH6/TaplSMRRIsFjnNwCbt0lvja6PqCS1ol8o6joRV7r7ZpOTLyQ36GdL2K+XR++S
         Xhm9MeunJDD+c1lJ+kX0OH5ZZ3NCGLIC1BuasgMKPrjIw3FUXp/Mq/T/kAD98GYDuf4g
         SCYLS0c54WoIo++xc2Q3+58H7zRQ3JagJuMgt42FPINFO3S7Xmogl7ulYnchF79gDoUp
         2q4Q==
X-Gm-Message-State: AFq9FYIuJg5Q3brMNRhfmCi1cFmYnb0+q2g8sqzBBzpdnUG4UhJrM+z8
	QNhmn9n7zXIGIrjfmXmRyNd4k4Gh9nDxgAhV6nmZfWVk2Ak8PAje+tbsPlo0aA==
X-Gm-Gg: AYBFou2QNvZ/UvZYH+Oa9H6CT6zHL8i/1lxT3aDh6ACZ8Ik+NtZthO2qT5I7fGDixZ/
	KulWtsoflD9n2Q35VxUNSvAFmslj4TYeb/QxXmq122fUSzpfmNNFrzVcCXWh8rVgf39JHlGri5N
	aD0/iRoaYEqmTwAfN9JxDj0oemcMtQgVAmRaNA3V24H4OwuBRUJ9v3Jf/MTOjagmPKYHw4f1E4g
	BHA6pHv01nCWrup25MDU0Jm3wXbKdAZWeSZMZPI9UySI7DbMPJykx8K68qzLDUglKMOamk6XFJL
	zx7I7XQGXMWWM7YtU1UATegqK8QuUvskukIO/9efvrL81ONHFgN0BH8RThtLCnMolx7QJiCMc5X
	VUjxBhzWLHMQkVbNXrF7MmZ3V1ha8A+jIrXZfLje5KXie27kZiboRNVwUQvUR2Td68L5uxIKgTd
	sjjAUvUU0IcFreVvpwNp5Y9SEXX04QPeia0pw+wadquX/qo6DdI3lOJttEGRZBtxaW3wvoRoXah
	d1Ey18xPory
X-Received: by 2002:a17:902:f70f:b0:2df:accf:e873 with SMTP id d9443c01a7336-2e84280a617mr132228795ad.4.1791961463491;
        Wed, 14 Oct 2026 00:04:23 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.140.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b5fd2sm66204925ad.50.2026.10.14.00.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:04:21 -0700 (PDT)
Message-Id: <9ad8ad3eb40786c1340b53c7c74c6b61f9fcf210.1791961452.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v9.git.git.1791961452.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v9.git.git.1791961452.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 07:04:10 +0000
Subject: [PATCH v9 3/5] fetch: infer branches to fetch from a refmap-only
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
@{upstream} is already on that remote. This lets a remote be
configured to fetch only the branches actually in use, without
listing them by hand in remote.<name>.fetch, and without needing to
touch the command line every time.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |   5 +-
 Documentation/fetch-options.adoc |   6 +-
 builtin/fetch.c                  |  59 ++++++++++++---
 remote.c                         |  24 +++++++
 remote.h                         |   4 ++
 t/meson.build                    |   1 +
 t/t5586-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
 7 files changed, 207 insertions(+), 11 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 103eada406..7c52e443a5 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -36,7 +36,10 @@ remote.<name>.fetch::
 remote.<name>.refmap::
 	The default value of the `--refmap` option for linkgit:git-fetch[1].
 	Used to map remote refs being fetched to remote-tracking refs to
-	store. See the `--refmap` entry in linkgit:git-fetch[1].
+	store. If `remote.<name>.fetch` is not set either, a refspec-less
+	fetch infers what to fetch from local branches built on this
+	remote, instead of fetching every branch it has. See the
+	`--refmap` entry in linkgit:git-fetch[1].
 
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index c2101a7b39..90b9e13ac2 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -245,8 +245,10 @@ endif::git-pull[]
 	command-line arguments. See section on "Configured Remote-tracking
 	Branches" for details.
 +
-`remote.<name>.refmap` provides the default value for this option, the
-same way `remote.<name>.fetch` provides the default refspecs to fetch.
+When a refmap is active (from `--refmap` or `remote.<name>.refmap`) but
+nothing to fetch is specified on the command line, nor is there a
+`remote.<name>.fetch`, branches from the remote that are used as the
+`@{upstream}` of our local branches are fetched.
 
 `-t`::
 `--tags`::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2eb58195a2..de3298c0b1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -515,6 +515,8 @@ static struct ref *get_ref_map(struct remote *remote,
 	 */
 	struct refspec *effective_refmap =
 		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
+	struct refspec inferred_rs;
+	int infer_from_refmap = 0;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
@@ -522,15 +524,32 @@ static struct ref *get_ref_map(struct remote *remote,
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
+
+		branches_tracking_remote(the_repository, remote, &tracked);
+		for_each_string_list_item(item, &tracked)
+			refspec_append(&inferred_rs, item->string);
+		string_list_clear(&tracked, 0);
+
+		rs = &inferred_rs;
+		infer_from_refmap = 1;
+	}
+
 	if (rs->nr) {
 		struct refspec *fetch_refspec;
 
 		for (i = 0; i < rs->nr; i++) {
-			get_fetch_map(remote_refs, &rs->items[i], &tail, 0);
+			get_fetch_map(remote_refs, &rs->items[i], &tail,
+				      infer_from_refmap);
 			if (rs->items[i].dst && rs->items[i].dst[0])
 				*autotags = 1;
 		}
@@ -565,6 +584,8 @@ static struct ref *get_ref_map(struct remote *remote,
 
 		for (i = 0; i < fetch_refspec->nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
+	} else if (infer_from_refmap) {
+		/* Already fully handled above. */
 	} else if (refmap.nr) {
 		die("--refmap option is only meaningful with command-line refspec(s)");
 	} else {
@@ -660,6 +681,7 @@ static struct ref *get_ref_map(struct remote *remote,
 	if (existing_refs_populated)
 		hashmap_clear_and_free(&existing_refs, struct refname_hash_entry, ent);
 
+	refspec_clear(&inferred_rs);
 	return ref_map;
 }
 
@@ -1962,16 +1984,14 @@ static int do_fetch(struct transport *transport,
 
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
-	} else {
+	} else if (transport->remote->fetch.nr) {
 		struct string_list tracked = STRING_LIST_INIT_DUP;
 		struct string_list_item *item;
 
-		if (transport->remote->fetch.nr) {
-			refspec_ref_prefixes(&transport->remote->fetch,
-					     &transport_ls_refs_options.ref_prefixes);
-			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
-				do_set_head = 1;
-		}
+		refspec_ref_prefixes(&transport->remote->fetch,
+				     &transport_ls_refs_options.ref_prefixes);
+		if (follow_remote_head != FOLLOW_REMOTE_NEVER)
+			do_set_head = 1;
 
 		/*
 		 * The configured refspec may not cover the current
@@ -1984,6 +2004,29 @@ static int do_fetch(struct transport *transport,
 			strvec_push(&transport_ls_refs_options.ref_prefixes,
 				    item->string);
 		string_list_clear(&tracked, 0);
+	} else {
+		/*
+		 * The --refmap command line option, if given, takes
+		 * precedence over remote.<name>.refmap.
+		 */
+		struct refspec *effective_refmap = refmap.nr ? &refmap :
+			&transport->remote->refmap;
+		struct string_list tracked = STRING_LIST_INIT_DUP;
+		struct string_list_item *item;
+
+		if (effective_refmap->nr) {
+			branches_tracking_remote(the_repository,
+						  transport->remote, &tracked);
+			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
+				do_set_head = 1;
+		} else {
+			collect_upstream_from_remote(the_repository, &tracked,
+						      transport->remote, NULL);
+		}
+		for_each_string_list_item(item, &tracked)
+			strvec_push(&transport_ls_refs_options.ref_prefixes,
+				    item->string);
+		string_list_clear(&tracked, 0);
 
 		/*
 		 * If there are no refs specified to fetch, then we just
diff --git a/remote.c b/remote.c
index 5e980625b8..703c71ba45 100644
--- a/remote.c
+++ b/remote.c
@@ -1899,6 +1899,30 @@ void collect_upstream_from_remote(struct repository *repo,
 		string_list_insert(tracked, branch->merge[i]->src);
 }
 
+struct branches_tracking_remote_cb_data {
+	struct repository *repo;
+	struct remote *remote;
+	struct string_list *tracked;
+};
+
+static int add_if_tracking_remote(const struct reference *ref, void *cb_data)
+{
+	struct branches_tracking_remote_cb_data *data = cb_data;
+
+	collect_upstream_from_remote(data->repo, data->tracked, data->remote,
+				      ref->name);
+	return 0;
+}
+
+void branches_tracking_remote(struct repository *repo, struct remote *remote,
+			       struct string_list *tracked)
+{
+	struct branches_tracking_remote_cb_data data = { repo, remote, tracked };
+
+	refs_for_each_branch_ref(get_main_ref_store(repo),
+				  add_if_tracking_remote, &data);
+}
+
 __attribute__((format (printf,2,3)))
 static char *error_buf(struct strbuf *err, const char *fmt, ...)
 {
diff --git a/remote.h b/remote.h
index 7c86c529b6..62265346d3 100644
--- a/remote.h
+++ b/remote.h
@@ -368,6 +368,10 @@ void collect_upstream_from_remote(struct repository *repo,
 				   struct remote *remote,
 				   const char *refname);
 
+/* fills tracked with the refname of every local branch's upstream on remote */
+void branches_tracking_remote(struct repository *repo, struct remote *remote,
+			       struct string_list *tracked);
+
 /* list of the remote in a group as configured */
 struct remote_group_data {
 	const char *name;
diff --git a/t/meson.build b/t/meson.build
index f65eb04684..e287a6b947 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -730,6 +730,7 @@ integration_tests = [
   't5582-fetch-negative-refspec.sh',
   't5583-push-branches.sh',
   't5584-http-429-retry.sh',
+  't5586-fetch-refmap.sh',
   't5600-clone-fail-cleanup.sh',
   't5601-clone.sh',
   't5602-clone-remote-exec.sh',
diff --git a/t/t5586-fetch-refmap.sh b/t/t5586-fetch-refmap.sh
new file mode 100755
index 0000000000..b81fc48cbe
--- /dev/null
+++ b/t/t5586-fetch-refmap.sh
@@ -0,0 +1,119 @@
+#!/bin/sh
+
+test_description='"git fetch" with a remote.<name>.refmap but no remote.<name>.fetch
+
+When a remote has a refmap configured but no fetch refspec, a
+refspec-less fetch infers what to fetch from the local branches whose
+@{upstream} is on that remote.
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
+test_expect_success 'a bare fetch needs nothing until a branch is tracked' '
+	(
+		cd client &&
+		git fetch upstream &&
+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
+		test_must_be_empty actual
+	)
+'
+
+test_expect_success 'an explicit one-time fetch lets a branch be tracked' '
+	(
+		cd client &&
+		git fetch upstream main &&
+		git branch --set-upstream-to=upstream/main &&
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

