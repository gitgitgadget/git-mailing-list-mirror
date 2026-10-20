Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503801;
	b=sZD+IGa7xWMZhHmoUdL2pWt0OuQ5O/F+Cqry3dHqAQ3jVrraQhfa5mbkb4+BJ5bYNacS
	 L0s12/eDPMT6vlQUvhD1vqbTh5aXfWZc+wIzqMwmC8GXc8sgL257Pco8ou+USc9hRmEoG
	 KC9m6PgTMGIqDd3raV9LZ6sJnWrY+Jcbpd6Q2KobhWqg33ZVVz0saWM3MbfCviI1dC3NJ
	 SbbKTLJAZlcK9OHIQJDqobJT4j8ZEYWUOvWm+riig75lLmFJQ9JGoVKbL3c1/fK0rnJUV
	 PWEPsaqxFKJZrARcHQyXVWxgOlwm48Zw5mfyP7Mfhxkw7Bmrl83OJBVNRjq1Qjs3s3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=PxIOxxWA/Krm0OyeZzJFj0M//q6kXYB2LQYB8hav9Ro=;
	b=tkgg/tVHoDEAlhptrv9cfky7DhRDJqlz1qQdNlLwO6x7Zui2++o7frfRzWIGRbqb3/ud
	 vEE9pA2cARcpk3kdCHDaw5v5dDJhnXckVaaGzmi/O7K7f8jhMKYZ0hmTxRkS7N3HDeGsN
	 4yMORoKpS9Fs6EflSwfaL7cLzTncLD3oMp0rqCBAGr0ADWuAN86QrTDXfwJ3KVHSBIzK9
	 nhlP3VXDGqJP9R7LvWtNcBYg5wB0b4bNHvqZ78Wp25nOimzV5eB7FdohOdzjfRFqdMznr
	 PQ+869fKj4WWTxHsVeq2LSWSUTYAeCf12TjS8KT4ExFzjuJfSUjJT75Y7RNHEt/MqRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=onJH87Vp;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A2606A31D
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF1A2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=onJH87Vp
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35c76e9614aso6018814eec.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792503800; x=1793108600; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PxIOxxWA/Krm0OyeZzJFj0M//q6kXYB2LQYB8hav9Ro=;
        b=onJH87Vpx6ijDaZydU6FHIE4kDs2v5cr8suVeZSh8JQbtegRx3vivbDFmuvljiEKme
         qsdepWlr74pQPmsbte2WsmDCbJYzQ/XUptnSBZG4dG76WziHpOCREZzy37X47AX3Hm2F
         y7WHvAUHGrhwly5YBPAY1kaW8CrKnLsVSDVFDOLpcz4vbXIzqDTYMqdOVGgaRUN3uM0C
         0FXwlnq2f2VzBxZWabBuLPUPnuqUI02cYJ7C4GfaRSQ+1Nolz1y7rimBBK8sG8fc9Gcg
         wolhnFgS0XSVNK4aiw8f4yRRz9jadOtT9mEH9Z4k3ZxijWYDyk/kG7b7yvAUhEyUPcZi
         r2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792503800; x=1793108600;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PxIOxxWA/Krm0OyeZzJFj0M//q6kXYB2LQYB8hav9Ro=;
        b=rrE0zRSpCYSJWfoyUbQaA5HJN5BNAezVdQc8lhK5qGaGwZv83hZIl6bBoeTDUMVWO2
         Kmnk50GvETdC+TybXzM+BPygmkFZ+w0E1jamikR1M1MEmuuoNRgfnyBoAbgfNSdCcEk1
         LvGyqqLIRnK9B5RVnrN8IbF0w+ix5ugmY4ayEiPgfdd9Yh9XAtRO3dm9/XRPoHHUR1/c
         4oEIihNyx7Qh6uoj4u7PmT6V+m34ZeDUKDzBCaNGTbjRsuLQClgXklhDEALwvJVayxhV
         /AbVC4oAJE66v+JszxUPKnz8PwBEOYJkzh3RTY1d5Z9chDBSi3SrPbSl1PAsrXzIwLGs
         8DVw==
X-Gm-Message-State: AFq9FYJkiIijJC22IdQf/S6x8cvScm5Smkc521XP/P2l2vmrm6pQySue
	x5alQGyvytXOL7oZicdJYfJpDlISPVdJv5/WJqfx+G3gg/zub8zJVHuQXAjgkjtA
X-Gm-Gg: AYBFou0g5hBBkQF6xVVfKapw6zrdSsNUzZIyQa/jk0RUKLTO3M2oRyd2VVfNvi8L0U6
	0n3O9y9nXY1zlNiyfnbbz0w3kaQetMun3qYcQ5i4vSx+h9yTeGfyH8VsQPN2f361+ABskorEzzt
	U5Hck4oG/E7b/n9RubUU77lH70KcjmaesXpE93V3tvZOGYNh/eaTjXzRx2sLHSw/4Ec+Eqr4LUe
	etvUYFbiYMWDpkOkStOPK67gKQIn1nGj2KZEKr5Ck2RFKZDugiMEyZEgqD5HNMx1PoJpuJ4lPTh
	hzSy9nWfhseIXRXepzmOM0/C0zOiYyq3zTDI0qFwXpsEaYLkbM5O7zFpp7PZzFgSY4nBY+jUhLd
	gQlXpCyinLpSuKXJRvoySuKaWbjcvc+DmuhPSD48Jd4BshfG27/GCs9LuDFm9UG2xgJiwo0VzYy
	4gzKL1N/r5zNY71ctGq7bqV33q1KzQmOH7wH4pqBqnRXMlzOW/ksZcOc/gYA0Ab4VqhMvoo0HPa
	fn64REsdg==
X-Received: by 2002:a05:693c:864e:20b0:35f:2bc:82d3 with SMTP id 5a478bee46e88-361a195c9aemr15683049eec.15.1792503798281;
        Tue, 20 Oct 2026 06:43:18 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.77.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608219f838sm41414880eec.19.2026.10.20.06.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:43:17 -0700 (PDT)
Message-Id: <9fb7e77a862640007339df639d03e61db37b6f70.1792503778.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 13:42:56 +0000
Subject: [PATCH v10 3/5] fetch: infer branches to fetch from a refmap-only
 remote
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
 builtin/fetch.c                  |  75 +++++++++++++++----
 remote.c                         |  24 +++++++
 remote.h                         |   4 ++
 t/meson.build                    |   1 +
 t/t5586-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
 7 files changed, 219 insertions(+), 15 deletions(-)
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
index 136a59154a..0fc1fb66d5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -524,6 +524,8 @@ static struct ref *get_ref_map(struct remote *remote,
 	 */
 	struct refspec *effective_refmap =
 		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
+	struct refspec inferred_rs;
+	int infer_from_refmap = 0;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
@@ -531,15 +533,32 @@ static struct ref *get_ref_map(struct remote *remote,
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
@@ -574,6 +593,8 @@ static struct ref *get_ref_map(struct remote *remote,
 
 		for (i = 0; i < fetch_refspec->nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
+	} else if (infer_from_refmap) {
+		/* Already fully handled above. */
 	} else if (refmap.nr) {
 		die("--refmap option is only meaningful with command-line refspec(s)");
 	} else {
@@ -669,6 +690,7 @@ static struct ref *get_ref_map(struct remote *remote,
 	if (existing_refs_populated)
 		hashmap_clear_and_free(&existing_refs, struct refname_hash_entry, ent);
 
+	refspec_clear(&inferred_rs);
 	return ref_map;
 }
 
@@ -1978,13 +2000,47 @@ static int do_fetch(struct transport *transport,
 
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
+	} else if (transport->remote->fetch.nr) {
+		struct string_list tracked = STRING_LIST_INIT_DUP;
+		struct string_list_item *item;
+
+		refspec_ref_prefixes(&transport->remote->fetch,
+				     &transport_ls_refs_options.ref_prefixes);
+		/*
+		 * See remote.c's handling of remote.<name>.followRemoteHEAD
+		 * for the analogous, still-unresolved case.
+		 */
+		if (transport->remote->follow_remote_head)
+			follow_remote_head = transport->remote->follow_remote_head;
+		else if (config->follow_remote_head_seen)
+			follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
+		else
+			follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
+
+		/*
+		 * The configured refspec may not cover the current
+		 * branch's upstream (e.g. a narrowed -t refspec), so
+		 * make sure we can still fetch it regardless.
+		 */
+		collect_upstream_from_remote(the_repository, &tracked,
+					      transport->remote, NULL);
+		for_each_string_list_item(item, &tracked)
+			strvec_push(&transport_ls_refs_options.ref_prefixes,
+				    item->string);
+		string_list_clear(&tracked, 0);
 	} else {
+		/*
+		 * The --refmap command line option, if given, takes
+		 * precedence over remote.<name>.refmap.
+		 */
+		struct refspec *effective_refmap = refmap.nr ? &refmap :
+			&transport->remote->refmap;
 		struct string_list tracked = STRING_LIST_INIT_DUP;
 		struct string_list_item *item;
 
-		if (transport->remote->fetch.nr) {
-			refspec_ref_prefixes(&transport->remote->fetch,
-					     &transport_ls_refs_options.ref_prefixes);
+		if (effective_refmap->nr) {
+			branches_tracking_remote(the_repository,
+						  transport->remote, &tracked);
 			/*
 			 * See remote.c's handling of remote.<name>.followRemoteHEAD
 			 * for the analogous, still-unresolved case.
@@ -1995,15 +2051,10 @@ static int do_fetch(struct transport *transport,
 				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
 			else
 				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
+		} else {
+			collect_upstream_from_remote(the_repository, &tracked,
+						      transport->remote, NULL);
 		}
-
-		/*
-		 * The configured refspec may not cover the current
-		 * branch's upstream (e.g. a narrowed -t refspec), so
-		 * make sure we can still fetch it regardless.
-		 */
-		collect_upstream_from_remote(the_repository, &tracked,
-					      transport->remote, NULL);
 		for_each_string_list_item(item, &tracked)
 			strvec_push(&transport_ls_refs_options.ref_prefixes,
 				    item->string);
diff --git a/remote.c b/remote.c
index 965e42ff52..6467496a0f 100644
--- a/remote.c
+++ b/remote.c
@@ -1906,6 +1906,30 @@ void collect_upstream_from_remote(struct repository *repo,
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
index 11b3752f00..0953a4112f 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -736,6 +736,7 @@ integration_tests = [
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

