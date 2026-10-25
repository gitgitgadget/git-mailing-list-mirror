Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959927;
	b=njwHJdWrpxJu+j30Jk/FXRUW/FKJ/u7dKjGOoa+KR3M55X11U+bCsVWG7wUcTNz69WBG
	 +aFgIAKlEfuMag+BnbjbYqZl5ncAVI3Gtp8HA4A4lYnDWPDY7EhlhY3ShJT0kEnJt4o9P
	 tLY6/4H9i8NW7WHs9jgqM/eim9Mp0o7LfddSiwD13LO+kTKxLG7HqNjic3b6DsWLeXEeL
	 Oi1c9HnYKCybZ3iXK0JxvladKwxUzkPOSRVyzpO4qQ/gVtMvquGXWOYqvn2RYApTaFZ7b
	 SAiS3P91lQF5x5f4dAG4ZAx2BTPP08ZM67dOgufZZu+lnn3/XmgKoFKWU9NlWu1q9dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=U+6nQmWSqgF1DXOMa6oajTtpQggp6aMp6f/gWenTaJs=;
	b=f5NbPFoW5iuOukvHZtLCYWIFRdAB7K7/wJzDivhw8X3Jde8CVh9f67QKn90yuuyT2/We
	 IGSNdU89S/L3zHTu+iYxI/bIbzTRg/5p6KrKItlOrVTCITMC8I6mlWBH248AuSR1Q+Zno
	 qE7MC8Bln2vGHuzvcuDpQEGXx6gJ/fpWrOBDOvcLMp2iP4oiFmvhfjvwz1ZehWuZ+qc89
	 9roBecst0Pjn73oa7uK4GMKoNKZizd/bXZp4zvQBRNdoY0DYTOpzfKlfAMrVMc71i+9kb
	 8Fm0KXkLHkECzvGMC9MXT3ESOQLBGyWFUVF/jwJQYgulhkNPoyGRNkBIDQQutRJ8+Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gf2NiYQD;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B26606A320
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 20:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52B26606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gf2NiYQD
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36681e85e87so1060605eec.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792959926; x=1793564726; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U+6nQmWSqgF1DXOMa6oajTtpQggp6aMp6f/gWenTaJs=;
        b=gf2NiYQDmt7CgGv/vp21kJriXRj04FfQ2QzsLerHJEeGKBgGbTsYd2LVi2Ya6FK70g
         3u4X9XccEiS/4lP+QPpXhi49pzKIitdQKUKwaWuHs4wxDemEyM9AS3Ups+oWCXl/FAl6
         sL2Bwe92BBSjiAbrM+zgxbzcRfhPbPIiw1W0DYwj2CS8RWzkPr+zXnJ9EZpFmHpNiz2S
         0jNeiWEQrODHmxaPOCXwYYwnNkxoeTqSjk5OKSAmjdzpTP9hr9RGAOECtD7hwJmBRfjr
         sypTgv4tbMy7kOfEOGHaPPiNubCfALnmrp+a3ymSkZdueQ9UPqQxhxL8IM8EZlTkbvz6
         bMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959926; x=1793564726;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+6nQmWSqgF1DXOMa6oajTtpQggp6aMp6f/gWenTaJs=;
        b=KmZeE6Rnacxrooxmrz+dodhs11b+gPFMfYN6CsRkbiYxYyyAKyb18iKlGXlX+U8KA1
         PI0MxmKOFAeqnAVZPfv7gqF5zkRZwRcBFfZl8v8U+Hlh6vo4EBAOUqkIWssE2WKPW1y1
         6kWEgFNh8yIT7GPejRh08fxcX8Pt794lAHV/bCir5Im4T5iS8TraK581uBq4sJcp6znV
         PToLEhyzvQzMvr9XsqFnP4jJlCjQrR8xMzVv3Q/NP3WVF0CDse04jxHCYnx2exiZsWRx
         C5J5qRPycM/u5ds1s4apmpdHlchDzPPGMWigDRs9jUy2l1P42zCYe7FgT1T9DWUceyjS
         XU+g==
X-Gm-Message-State: AFq9FYJ7rBW9YQ4QEb/HvvMVrVQyFdSLUIRuF1BUEJ/rSxGB0x/QLof7
	J1mmzGCjxm54GwWU13Q0uK16pov9Q0sSVZkapfRZ3zrPy6rx/YrIHpqG60znOOviyh4=
X-Gm-Gg: AYBFou0Q7uZ+wh8ZNgOTt+JEoLz9WFbXlManUHzRlhQg8UnnWtayj01+V1FlHJPq5b8
	ReGtnsjuV6oFvDPINikrlx0wa8G7uAzkIfbOtM476bNNCQZ0p1KAkRFJ0r5OdowPPaoUTR0hM1N
	xOHvJJnpHzMrm8Zl5G2SymrMEt4uwcNsPKxGuXpZbnPI572jotmv4cdOKBNhvwVDG4Q7uJSvj+f
	niXSxZeYoGLSFrqmrcTcfyPAn2fcfBe3GkEqSS6ibdezQiXDuyAEletF9wQ0/UAZJMyielyNmbv
	THMHimteRij/mTvBrDyJV4gBEYOAxK3hO6+EDnY/EpX/Hb28v6lgyvqktV2RYSrVnhy+GE2dMCg
	6Fp97mICj8DMKGBjYgu5Obu/APCccUd0IgbFmQ8v5/szF6IQlmNJSX2xbnAiqkVUh4GYCRM/tde
	gGilao5RXQF7A69RdUQA0ZvDu32AMjFAexyGtr1o08WSFSmUVh8FdH6tJF5qqz4EdqaA1HXSvLN
	AyIQqTorcRW1boiy7GlNnSnlPRpWVsAPbjsHEaQ932Rjgw3oErO0xsA
X-Received: by 2002:a05:7300:cc9f:b0:351:6b27:d67d with SMTP id 5a478bee46e88-369e84b9a24mr7341601eec.30.1792959926059;
        Sun, 25 Oct 2026 13:25:26 -0700 (PDT)
Received: from [127.0.0.1] ([4.242.195.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f27d5bf8sm15901445eec.4.2026.10.25.13.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:25:25 -0700 (PDT)
Message-Id: <5c76b3b88d3997e0fd9ae259d8fd5499560a1cb3.1792959921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v11.git.git.1792959921.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v11.git.git.1792959921.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 Oct 2026 20:25:19 +0000
Subject: [PATCH v11 3/5] fetch: infer branches to fetch from a refmap-only
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

We want remote.<name>.refmap to work on its own, without also setting
remote.<name>.fetch, so a remote can be limited to the branches
already in use locally, without listing them by hand or touching the
command line every time.

Infer what to fetch from the local branches whose @{upstream} is
already on that remote. The refmap itself still only controls where
those fetched refs land, not which branches are selected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |   5 +-
 Documentation/fetch-options.adoc |  11 ++-
 builtin/fetch.c                  |  72 ++++++++++++++-----
 remote.c                         |  25 +++++++
 remote.h                         |   5 ++
 t/meson.build                    |   1 +
 t/t5586-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
 7 files changed, 219 insertions(+), 19 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 103eada406..d524d599bc 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -36,7 +36,10 @@ remote.<name>.fetch::
 remote.<name>.refmap::
 	The default value of the `--refmap` option for linkgit:git-fetch[1].
 	Used to map remote refs being fetched to remote-tracking refs to
-	store. See the `--refmap` entry in linkgit:git-fetch[1].
+	store. If `remote.<name>.fetch` is not set either, a refspec-less
+	fetch infers what to fetch from local branches built on this
+	remote, instead of needing `remote.<name>.fetch` listed by hand.
+	See the `--refmap` entry in linkgit:git-fetch[1].
 
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index c2101a7b39..9c86570f8d 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -245,8 +245,15 @@ endif::git-pull[]
 	command-line arguments. See section on "Configured Remote-tracking
 	Branches" for details.
 +
-`remote.<name>.refmap` provides the default value for this option, the
-same way `remote.<name>.fetch` provides the default refspecs to fetch.
+When a refmap is active (from `--refmap` or `remote.<name>.refmap`) but
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
index 51bd5b0838..ad676985b4 100644
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
@@ -531,15 +533,31 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct hashmap existing_refs;
 	int existing_refs_populated = 0;
 
+	refspec_init_fetch(&inferred_rs, the_hash_algo);
+
 	filter_prefetch_refspec(rs);
 	if (remote)
 		filter_prefetch_refspec(&remote->fetch);
 
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
@@ -574,6 +592,8 @@ static struct ref *get_ref_map(struct remote *remote,
 
 		for (i = 0; i < fetch_refspec->nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
+	} else if (infer_from_refmap) {
+		/* Already fully handled above. */
 	} else if (refmap.nr) {
 		die("--refmap option is only meaningful with command-line refspec(s)");
 	} else {
@@ -669,6 +689,7 @@ static struct ref *get_ref_map(struct remote *remote,
 	if (existing_refs_populated)
 		hashmap_clear_and_free(&existing_refs, struct refname_hash_entry, ent);
 
+	refspec_clear(&inferred_rs);
 	return ref_map;
 }
 
@@ -1961,6 +1982,7 @@ static int do_fetch(struct transport *transport,
 	struct strmap rejected_refs = STRMAP_INIT;
 	int summary_width = 0;
 	int follow_remote_head = FOLLOW_REMOTE_NEVER;
+	bool apply_follow_remote_head_config = false;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1978,21 +2000,10 @@ static int do_fetch(struct transport *transport,
 
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
@@ -2001,6 +2012,22 @@ static int do_fetch(struct transport *transport,
 		 */
 		collect_upstream_from_remote(the_repository, transport->remote,
 					      NULL, &transport_ls_refs_options.ref_prefixes);
+	} else {
+		/*
+		 * The --refmap command line option, if given, takes
+		 * precedence over remote.<name>.refmap.
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
@@ -2011,6 +2038,19 @@ static int do_fetch(struct transport *transport,
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
index 43441945cf..d9a14114a1 100644
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

