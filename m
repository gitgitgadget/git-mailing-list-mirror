Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681508;
	b=xI4QkmO5gmHnd0m5ra9St6zJN7Qawjog/VpFQwFeYnOc5I0qIKNlyacknOhGk+ON8o98
	 xQafSboKM0LLFj3v9kJn8PoB+u35RxMx9OS5GI3r1oy5aPyUkB2mQ7cxFld3YrpHlIklO
	 Jmc6nf6IB6wqiiburTxmIULSffLzyi2cfyf4lAkNF/Rv6QisQ58Fr+19RoMknVgWcBCxg
	 D1Da0Kfv6n+lhkJYfL8LkBTAqyy5QNXdNFdoX4afoArGdFVzIQ0EgVuG95sdY9LqC8lkG
	 OWpki1oKpe48uCmjBbkCqW7t27LYzt0eKUVn+Sv06FmYvAly4gln5IKGZd+Xtc3oPww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=/DDUNt1uUneeAy60iO+bK70oObuL6WOCNkPpL/Yp+MQ=;
	b=uxfFaaOMNij2X7bRcL6qgpSv39vK6MJJEsZj2hkib4WB2hl3UBuXB0MMJBSj5BUb2dO/
	 yBhMxund8U+rt3XSfeT/Kq0YD0cPsII4KhSQlsELhIVDx8cNA7yP6O/CUEhrRPryAuUqb
	 q3v2APQ3NZr+PrOhm5GktsNEPNjHBvHNT9/VultFEsaXyO2lKV7Y9b1aGHMItiOhUiaP+
	 ukm7rJzwSxl0f7aTVQmseSyhduhxBF1O3UopHMYQeMfCNvxsTJgLKIlbx3/o59wkCsmfQ
	 sRu4z5aHRMc214/DC4O6P2eyjhfh3xQdir4f7FOLlnZsTEYl8dVLWiEgVqY3badOYtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nI3cvlYV;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4D8606A32D
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 18:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E4D8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nI3cvlYV
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso1059940a91.1
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 10:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794681507; x=1795286307; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/DDUNt1uUneeAy60iO+bK70oObuL6WOCNkPpL/Yp+MQ=;
        b=nI3cvlYV1GFuwwbS74hC8jmUxFgPiSM6+7Xei/JZW8MiDEFVXlGctAv0jdfHMKXbEF
         qx4B9CxTm1Q8OgpO3blDlHSTr/td4EMy6HDGmG8ayKFqZeBgGWZQDeF++La7GkesjO9T
         ILrUtH5obTseblPq4PMSqGFDBsgBt+f+OYNUijWRZHPT8+uG1fG2JrPCeRvn9OjijgO3
         lebX/uOOSugy5Df6eLJIUKtEsHiOb+JpSqXTtTU/AZ/5WUM9CNZgE7lioiy0ndOLwtDF
         g0z9XnaHlJURTlzHz2WfeqpYLOSZkVHPqeYvnfL9a3c777em2SMsrATX7xKWqi9+Mc13
         QoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794681507; x=1795286307;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/DDUNt1uUneeAy60iO+bK70oObuL6WOCNkPpL/Yp+MQ=;
        b=X9oPnkOiZqgUqQ0wHK58I/0uZ3scu/ZBc/yK03NSaQdTXl3cIMH+zxGjFUQXo5CQYH
         Gkj2g3H79FzmHMa4J0VouMCYkOcG2mpntcPAk2aQvxefpRL0QLpZh0qWyUyjVejYB6Kw
         rNGpyYf9Qo1hfa23DO8Nubt0gHeASPl/S/KegQCA2LLYF6p38+mhJCE/zA1F9ji3T0BU
         2DkdnW/SRbNW9Hb1Vm8fr0lcw/48BFqF5pEN5uYJaMLmpu8AUcJj4xN6DeX/34O8vJl6
         R8pTclmpanuPpCwzpjYMJv0jnJnPYsf6w9IHCc+HqdcEqjR1TCyNvfdFnfvNisf4iVMO
         74YQ==
X-Gm-Message-State: APuU4Z+RTsmg86mCE1SX4uey2S8Bwv1QPDmTCuAn6A142r20Z3JfSFBt
	Xfq35GGWePp3Cp/ZC5mGUbn+Yec0LVitpHh7ab4QcO0zxxq02j3KQcN072boVdd5
X-Gm-Gg: AYBFou2FZYIFZZo7L/wHzbF4/eas8e0oJYkQdcwXwCKmdckC85x4vdwrPLAfe7ZM0kJ
	cbxAZoLcu538BTbBe7oqGYmNpdFyEawV6q8hvwHOySKbdFDuYtdwlGcav5dtmTxA0ArTDYs8Qsf
	X3aHpmdcO/xmtlFMF4ryAZGlQp4FBIpnWvA4Yyx19lMHIGnhlpQKZ8anDCbEyo4eWr2e6quOIDg
	DTY9W3o5gi0n6DOKVXtMPJ8WGi5b7KIJW93SVRcjJxw6jskugOuqz5OSJQXPXUh7NCHKb+gXxxk
	Ze1iuJnwhJU1iIVItd+X+fB9jtR5MunezUZW2BxonIfa971vd4B2sthju5t7ve93d3G+GrymAYM
	4rCRkZSRMtHJmO8vIVlLuHV74Fyg+dlqYi8NqyzCk6I67xsty9tZ9HlMEGvzCMmgHOjZQb3fe/W
	j+VkCTRPYEz4fYFPVPaJj+mIzxk2+RpcvRC1uPmlIfwfouN+K/+Jho6Bfkz6+Wg8TG5CGED6T4+
	PbImvGyD41oYhO9wkdQvpoHgAxu5dKl6wr3eSvdKtXbACRK+Yjmcf4TwKafC7mOksihVJ2ciXfP
	UZOtK6LWYSipsEfJjC0f66vziKFtyhdQzyPznrMNB7V+Zo3DDV9hqeJXn30nVfN22fIJpIDQcLK
	rMudc3xGO
X-Received: by 2002:a17:90b:1b09:b0:3ac:a11a:7c84 with SMTP id 98e67ed59e1d1-3b1b0cccc43mr5737433a91.65.1794681507353;
        Sat, 14 Nov 2026 10:38:27 -0800 (PST)
Received: from [127.0.0.1] (ec2-3-42-157-139.us-west-2.compute.amazonaws.com. [3.42.157.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d282fdsm14969969a91.14.2026.11.14.10.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:38:25 -0800 (PST)
Message-Id: <6724152e69a605a3677c26f221f9e9ef30f606b9.1794681496.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v14.git.git.1794681496.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v14.git.git.1794681496.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 14 Nov 2026 18:38:14 +0000
Subject: [PATCH v14 3/5] fetch: infer branches to fetch from a refmap-only
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
    Matt Hunter <m@lfurio.us>,
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

Let @{push} use the refmap too, so a branch pushed to such a remote
resolves to the remote-tracking branch the push updated, instead of
failing with "has no local tracking branch".

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |   4 +-
 Documentation/fetch-options.adoc |  11 ++-
 builtin/fetch.c                  |  72 +++++++++++----
 remote.c                         |  27 ++++++
 remote.h                         |   5 ++
 t/meson.build                    |   1 +
 t/t5586-fetch-refmap.sh          | 147 +++++++++++++++++++++++++++++++
 7 files changed, 248 insertions(+), 19 deletions(-)
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
index 3614d576dc..47c42b0c08 100644
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
 
@@ -1984,6 +2005,7 @@ static int do_fetch(struct transport *transport,
 	struct strmap rejected_refs = STRMAP_INIT;
 	int summary_width = 0;
 	int follow_remote_head = FOLLOW_REMOTE_NEVER;
+	bool apply_follow_remote_head_config = false;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -2001,21 +2023,10 @@ static int do_fetch(struct transport *transport,
 
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
@@ -2024,6 +2035,22 @@ static int do_fetch(struct transport *transport,
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
@@ -2034,6 +2061,19 @@ static int do_fetch(struct transport *transport,
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
index 4e250ba393..989986d2a2 100644
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
@@ -1993,6 +2018,8 @@ static char *tracking_for_push_dest(struct repository *repo,
 
 	remote = repo_remote_for_push_tracking(repo, remote);
 	ret = apply_refspecs(&remote->fetch, refname);
+	if (!ret)
+		ret = apply_refspecs(&remote->refmap, refname);
 	if (!ret)
 		return error_buf(err,
 				 _("push destination '%s' on remote '%s' has no local tracking branch"),
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
index 1cf1d95f70..92f877da1c 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -737,6 +737,7 @@ integration_tests = [
   't5582-fetch-negative-refspec.sh',
   't5583-push-branches.sh',
   't5584-http-429-retry.sh',
+  't5586-fetch-refmap.sh',
   't5600-clone-fail-cleanup.sh',
   't5601-clone.sh',
   't5602-clone-remote-exec.sh',
diff --git a/t/t5586-fetch-refmap.sh b/t/t5586-fetch-refmap.sh
new file mode 100755
index 0000000000..7b54861fb1
--- /dev/null
+++ b/t/t5586-fetch-refmap.sh
@@ -0,0 +1,147 @@
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
+test_expect_success '@{push} resolves for a branch pushed to a refmap-only remote' '
+	(
+		cd client &&
+		git config push.default current &&
+		git checkout -b topic upstream/main &&
+		test_commit topic-1 &&
+		git push &&
+		echo refs/remotes/upstream/topic >expect &&
+		git rev-parse --symbolic-full-name topic@{push} >actual &&
+		test_cmp expect actual &&
+		test_cmp_rev topic topic@{push}
+	)
+'
+
+test_done
-- 
gitgitgadget

