Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357568;
	b=zMXr2EFNVrTC0owQNW9ME8VWWBD2vHZWJSDgGfBnzyC5VY1y/d9qVtw9Xyynp8PAgVfx
	 bw5m23ps+LHvJbSV/NB5seWyOY8c2r+pqb1kEnDODmtKe4YhGtljT5tWqi86yVMYJQGmx
	 TOMn6oayqonpXyBipl/tX7oYw/SUV9mkG7fKU8qGJPBxbGX8oSFuXgAd9UnMYl1dCA2CW
	 RERXHWRO5zEJHABOP6hTD8F+IOoruifmxDoWfOPJP7WqPrK85EKSUQaf02FbkxIB2uJqO
	 Uf7mbjm9DxqnwioRxxqmdB9JRdmBKV6yaWbrgjV1LPBW1F/dARIGxfbgGbIcuSM/5Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=2UPOycqdSkPChRjDl0CODGA6LBAsRsoqkCw2PS5QfjM=;
	b=WsBny6RRLdADcU7YYo/60mFHl6/oU/CzeaSXSahd3JBvfa82o2efW//IFy/ktre0KUmY
	 ZTmhJBhzOLTPhyzUbu+azQSytYgcfbi64vsmYhyzSi/GWXoPht3QJbAdxBi++PAoVYFnZ
	 5fvqDD76Xx/LjJxLh0Hb2F3YGabxyP/6JRAQrYFu6ZRMWKC2usnuJkRLfbACSWM6BLP5F
	 Zpp0f3+dfaowfv6SlFVP9HobV6DG/qjT45m1pvS0yylOogmrMeOzAYCMBN515wAGjzCxN
	 rLqA0W4vG3Pe8OCLXTwH825mRhOmRgdS4tTXxvTC0jZQ5MYwoHk7pTt5dd2ze5j1N1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L0DRaHcm;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81555606B944
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81555606B944
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L0DRaHcm
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-70b875f6f13so492403eaf.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357566; x=1793962366; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2UPOycqdSkPChRjDl0CODGA6LBAsRsoqkCw2PS5QfjM=;
        b=L0DRaHcmrm9sq6B+xKh4Hui79RcDMpSjMbCakQ4L2W+s8Y7qiyQt0TSDNbnwN9fMhi
         mMS1chXgi2bvF80m58/CR8qwHrO4cej4IBSRBURd1mHdOhh8bwPPFNRN7YZn+5eeT/EJ
         8DK6SXSE9V+SDRGJ8GQNBGScW8W1jkjbwbsZ/vm3ih5VHtB1kR0Km9yEWT74m7MgWLK1
         rb3kfE/QBjWFdaHj4E07hnRJHqFBJzUZgEsTNTpbK+Lw+TmG1L8nE9jxEHU2rHAdmqRX
         NZZxhoI1z74/ipHieW7LMY5Smfg+9zBYv+hCGrDZrWNmcw3T/kUc9GR2PW423N6swI1E
         Ok8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357566; x=1793962366;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2UPOycqdSkPChRjDl0CODGA6LBAsRsoqkCw2PS5QfjM=;
        b=W47UFuV9Ws4GCY/srj6D9wgbUMUUGB7LCAxcYl74Dh6N5TnZNqS31+U46Mnsb/sP3h
         obszhZakNQC9s3Iy4EiYdwmht9UqZY1OTo7xdTuuHx2hnMAwfncaQt+U7CHuTTbDwa0X
         gOqoY7aOc3MUHF3giIGhm1S1BN92pErWvgpjROlKq+DMlUMtJf/TeGw/tdemC92qbG9d
         RmTJETp9QYRgWhCSRXsUt0Gm446aetNC1T4U/gMjCvnpI/sDqzwdu0Mjb1XR83ySnNOo
         e/jMhMSScWpHfKRrlVwowm/dpjG3rsi8YY1doKUDUtI9NBahx7MU/a5rKApCujM1of7c
         tqpQ==
X-Gm-Message-State: AFq9FYJewfsPumveE5Rodm5m9pZGOVI2A1/1wl4zgvHTfWTE9XlX9oo3
	DFTL0EheTty8Eoz9HLxKcglR7RzyxD9jr1D7P+X5NRVVN8OfF/miIBUXvQ615gi2SrA=
X-Gm-Gg: AYBFou0FyydtTCk33aFofUFzLSgL+FFLatRAnr/z68F/5yjmz8x6B7ivZXZEmy2tkJu
	8+TsF/g5LAzJ1YNxWlQcNsL+jmREeO5o6LSSjs1ZkW41oCGea69OCbW8SCzTIZmloEc5MWmo75B
	g32arkmUxZPiBh1ZpjOnHgPBsa+bmFjUWcoNHy+HZicGhM+/iXOTMpyt9Igw/xIJ4tUKgiZPm13
	Ilj3v0w1oEgaywvenifocZOTYJpaKJ4sdeQIRDBdETkX1kiD+hDEJfYyyd2bsjjcu+4lX2aINeC
	ht5k7ujFPzdca5T4VL51ltY249QZ0eBHGk7btjLDcEo9HQnT8yI+QH7GSgp/uS4XmhCSTKFMKGK
	cVXjv5c6hXrRorypO9CBTp22jWXYDmeqT6zMnRZogUdGv8wWLcr57ReDgzA9Ylq8OKsm71sMewO
	7O+PvKSkHK56qHPbPN0jx2bJxvk9sQnkIqxiAPRzqrTgA4THqNQKdurytbsX1Lyc9D0Pqy0ZC6k
	Wvijx5NU3yl6X52NvnSNXZ7agl2bg5Rb82sRX0oNdm0O++K38loVIxGP8u1r51MA9WeUg0xUb/6
	Tp0+kplhF+UJOeTc2Uwugwy04NYeYQ==
X-Received: by 2002:a05:6820:162a:b0:709:fa95:9929 with SMTP id 006d021491bc7-714f2552f3fmr1199535eaf.62.1793357566404;
        Fri, 30 Oct 2026 03:52:46 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.38.98])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f3190fe6sm1521650eaf.14.2026.10.30.03.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:52:45 -0700 (PDT)
Message-Id: <b02e0a53972a294d80618be7f7f3bbf2d2710234.1793357550.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 10:52:27 +0000
Subject: [PATCH v13 3/6] fetch: infer branches to fetch from a refmap-only
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

We want remote.<name>.fetchRefmap to work on its own, without also
setting remote.<name>.fetch, so a remote can be limited to the
branches already in use locally, without listing them by hand or
touching the command line every time.

Infer what to fetch from the local branches whose @{upstream} is
already on that remote. The refmap itself still only controls where
those fetched refs land, not which branches are selected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |   4 +-
 Documentation/fetch-options.adoc |  11 ++-
 builtin/fetch.c                  |  72 +++++++++++++----
 remote.c                         |  25 ++++++
 remote.h                         |   5 ++
 t/meson.build                    |   1 +
 t/t5586-fetch-refmap.sh          | 133 +++++++++++++++++++++++++++++++
 7 files changed, 232 insertions(+), 19 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 236ccca93e..0d24abfcbd 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -38,7 +38,9 @@ remote.<name>.fetchRefmap::
 	fetched to remote-tracking refs to store, the same way
 	`remote.<name>.fetch` does for an explicit refspec.
 	`remote.<name>.fetch`, if also configured, still decides what is
-	fetched. See the `--refmap` entry in linkgit:git-fetch[1].
+	fetched. If it is not set either, a refspec-less fetch instead
+	infers what to fetch from local branches built on this remote.
+	See the `--refmap` entry in linkgit:git-fetch[1].
 
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index c2101a7b39..be27c03de7 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -245,8 +245,15 @@ endif::git-pull[]
 	command-line arguments. See section on "Configured Remote-tracking
 	Branches" for details.
 +
-`remote.<name>.refmap` provides the default value for this option, the
-same way `remote.<name>.fetch` provides the default refspecs to fetch.
+When a refmap is active (from `--refmap` or `remote.<name>.fetchRefmap`) but
+nothing to fetch is specified on the command line, nor is there a
+`remote.<name>.fetch`, infer what to fetch from local branches built on
+this remote: remote-tracking branches from this remote that are also
+configured as the `@{upstream}` of a local branch are fetched. The
+refmap only decides where those fetched refs land, the same as it
+would for an explicit refspec, and does not narrow which branches are
+selected. It is what turns this on, since without it the fetched
+branches would have nowhere to land.
 
 `-t`::
 `--tags`::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 31ec963db7..3a3cb311b7 100644
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
@@ -531,17 +533,33 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct hashmap existing_refs;
 	int existing_refs_populated = 0;
 
+	refspec_init_fetch(&inferred_rs, the_hash_algo);
+
 	filter_prefetch_refspec(rs);
 	if (remote)
 		filter_prefetch_refspec(&remote->fetch);
 	if (effective_refmap)
 		filter_prefetch_refspec(effective_refmap);
 
+	if (!rs->nr && remote && !remote->fetch.nr &&
+	    effective_refmap && effective_refmap->nr) {
+		struct strvec tracked = STRVEC_INIT;
+
+		branches_tracking_remote(the_repository, remote, &tracked);
+		for (size_t i = 0; i < tracked.nr; i++)
+			refspec_append(&inferred_rs, tracked.v[i]);
+		strvec_clear(&tracked);
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
@@ -576,6 +594,8 @@ static struct ref *get_ref_map(struct remote *remote,
 
 		for (i = 0; i < fetch_refspec->nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
+	} else if (infer_from_refmap) {
+		/* Already fully handled above. */
 	} else if (refmap.nr) {
 		die("--refmap option is only meaningful with command-line refspec(s)");
 	} else {
@@ -675,6 +695,7 @@ static struct ref *get_ref_map(struct remote *remote,
 	if (existing_refs_populated)
 		hashmap_clear_and_free(&existing_refs, struct refname_hash_entry, ent);
 
+	refspec_clear(&inferred_rs);
 	return ref_map;
 }
 
@@ -1967,6 +1988,7 @@ static int do_fetch(struct transport *transport,
 	struct strmap rejected_refs = STRMAP_INIT;
 	int summary_width = 0;
 	int follow_remote_head = FOLLOW_REMOTE_NEVER;
+	bool apply_follow_remote_head_config = false;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1984,21 +2006,10 @@ static int do_fetch(struct transport *transport,
 
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
-	} else {
-		if (transport->remote->fetch.nr) {
-			refspec_ref_prefixes(&transport->remote->fetch,
-					     &transport_ls_refs_options.ref_prefixes);
-			/*
-			 * See remote.c's handling of remote.<name>.followRemoteHEAD
-			 * for the analogous, still-unresolved case.
-			 */
-			if (transport->remote->follow_remote_head)
-				follow_remote_head = transport->remote->follow_remote_head;
-			else if (config->follow_remote_head_seen)
-				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
-			else
-				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
-		}
+	} else if (transport->remote->fetch.nr) {
+		refspec_ref_prefixes(&transport->remote->fetch,
+				     &transport_ls_refs_options.ref_prefixes);
+		apply_follow_remote_head_config = true;
 
 		/*
 		 * The configured refspec may not cover the current
@@ -2007,6 +2018,22 @@ static int do_fetch(struct transport *transport,
 		 */
 		collect_upstream_from_remote(the_repository, transport->remote,
 					      NULL, &transport_ls_refs_options.ref_prefixes);
+	} else {
+		/*
+		 * The --refmap command line option, if given, takes
+		 * precedence over remote.<name>.fetchRefmap.
+		 */
+		struct refspec *effective_refmap = refmap.nr ? &refmap :
+			&transport->remote->refmap;
+
+		if (effective_refmap->nr) {
+			branches_tracking_remote(the_repository, transport->remote,
+						  &transport_ls_refs_options.ref_prefixes);
+			apply_follow_remote_head_config = true;
+		} else {
+			collect_upstream_from_remote(the_repository, transport->remote,
+						      NULL, &transport_ls_refs_options.ref_prefixes);
+		}
 
 		/*
 		 * If there are no refs specified to fetch, then we just
@@ -2017,6 +2044,19 @@ static int do_fetch(struct transport *transport,
 				    "HEAD");
 	}
 
+	if (apply_follow_remote_head_config) {
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
+	}
+
 	if (tags == TAGS_SET || tags == TAGS_DEFAULT)
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "refs/tags/");
diff --git a/remote.c b/remote.c
index d4259fe7f3..15cd96aa8e 100644
--- a/remote.c
+++ b/remote.c
@@ -1914,6 +1914,31 @@ void collect_upstream_from_remote(struct repository *repo,
 		strvec_push(tracked, branch->merge[i]->src);
 }
 
+struct branches_tracking_remote_cb_data {
+	struct repository *repo;
+	const struct remote *remote;
+	struct strvec *tracked;
+};
+
+static int add_if_tracking_remote(const struct reference *ref, void *cb_data)
+{
+	struct branches_tracking_remote_cb_data *data = cb_data;
+
+	collect_upstream_from_remote(data->repo, data->remote, ref->name,
+				      data->tracked);
+	return 0;
+}
+
+void branches_tracking_remote(struct repository *repo,
+			       const struct remote *remote,
+			       struct strvec *tracked)
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
index 003c8fd180..6fd9b05a79 100644
--- a/remote.h
+++ b/remote.h
@@ -368,6 +368,11 @@ void collect_upstream_from_remote(struct repository *repo,
 				   const char *refname,
 				   struct strvec *tracked);
 
+/* Same as collect_upstream_from_remote(), but checked for every local branch. */
+void branches_tracking_remote(struct repository *repo,
+			       const struct remote *remote,
+			       struct strvec *tracked);
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
index 0000000000..d4214b12b0
--- /dev/null
+++ b/t/t5586-fetch-refmap.sh
@@ -0,0 +1,133 @@
+#!/bin/sh
+
+test_description='"git fetch" with a remote.<name>.fetchRefmap but no remote.<name>.fetch
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
+		git config remote.upstream.fetchRefmap \
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
+test_expect_success 'prefetch stores tracked branches under refs/prefetch/' '
+	test_commit main-3 &&
+	(
+		cd client &&
+		git rev-parse refs/remotes/upstream/main >expect &&
+		git fetch --prefetch upstream &&
+		git rev-parse refs/remotes/upstream/main >actual &&
+		test_cmp expect actual &&
+		git -C .. rev-parse main >expect &&
+		git rev-parse refs/prefetch/remotes/upstream/main >actual &&
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

