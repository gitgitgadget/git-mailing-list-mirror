Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C54EB84D
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673610; cv=none; b=UjV/sb20D7nOpVSRB9y2ppa8KwSJn1pIHYZ/VCYsYO6u3gP5OrWp3kZb+8gVYCoUqvNqTFkGM9NM6gTh12sSpuFUlAhz9SijGX1C6nuhesHME6FORl021xe/T7Rqp/wrV7KFNFo7ScmuvJFUWpr6WsdLJX62Rh3c4fng86jBC0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673610; c=relaxed/simple;
	bh=ZMV5uzYjuxCFNlgD/Xjw6ic0HcFjDOPftUQFpanImJ0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DHJ6LKDu8FvQZG1mN3GYn4k+M3GXfaHL4xiKPrOuk+b5FqOmI3X9Tckslqx95mOf/OygXVf3gUAsgjntBr38jTvHoNUaNNM5cFjc43lHbrRCPRIn2mzpm3RkXHWSHN5Nl0qrwEFMsM2R/T73jjSHGbRuidTcp9U9LdGSLLoImWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdFNv6yW; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdFNv6yW"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530d0d5ae11so47152841cf.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790673602; x=1791278402; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XTwUTUIkN2wzP2asOxDtVzkoYOGwzBdzkIlubJwweq4=;
        b=YdFNv6yWvLiWXXOM0YKoeJHoweKZv7mpdKGvs2O48i60/iLAKsUl993Ho0XgL82E5W
         0y9clpEtlOqMs3fQ5mMbEHAdITQANYnJiLqGvWYGmJtpM0vfT53z4p+ICURSW0BP4Euk
         EcXQiUSZU4+KEvvmdJLmw+yTMU6WNSjWZkcjqF7JRXvTB9aETYSQsmv3QufrWvzO+i3A
         5F/KYin0cToXad8wcg3nMNLtfV4IE+VroGypBLr4KBafyStC8PO+w011KMfz3a+seti0
         LjDDgZ1JLe/v5mAin3BoWca4/5bZmESwL3P5bJcCmLfGQGf/2e2yRvK1qa47FgGJneZh
         qBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790673602; x=1791278402;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTwUTUIkN2wzP2asOxDtVzkoYOGwzBdzkIlubJwweq4=;
        b=PShHnnk7ENra3ESpCzVViz1YeBI1qGdYqbZzQNLhfFI/dH6H0vcedkvge4Lb6YZsBn
         3EGNmUD4P/pBV3jSnEFkEbxKgu7YGGzvlb4ol/IixnYF+U0H6juoXYKxbaJYtj93DD6c
         oN4+OpYAf8Tz4rGUIsIJmPs7z5W60z0zrxfv2ZfktYyEVbyBudE5vD0h4uzWcuEJbqJj
         4eS9Fx2C9AoGQdjT2uFtH4hKeQWZMVB5WXGt4lt/+Y+Ik3WAKxwYZHmBozaDHnh3R9oK
         9vqC+HiijcSAx/lDPsYE7Sv64M9+OgFXexLErWEXLuuS0OvQqOoRbhgIKBTkz/arQ6iC
         JMQg==
X-Gm-Message-State: AFuF++ntjAR+PaRq3a5UpKMMzvhEwCgDHeyF+Sgw3elx4CvUagWrCIQ9
	nXGduQ1E9X/kfFoj7eDf1fOawDeYn/mIGjzeihwbso8GCq4XDIPWaiIo0Vj6A89a
X-Gm-Gg: AYBFou2z5akl2hbtz5qZfCQDJ15jjm6YdiyzmBa514SW8KUg08UHXWjA9aApk8+IUsR
	zOQUishdxxb6a3jcsB25cf9awog96bFPMGTmUTSB/wE6SK9+hP5I0g67i1MGBqwOP9vLE/JVXJL
	V9Q9BCnmbfvSp2YOOrfnFwA9dMmqBE61jhlYIUmTATPPTuyu2Ut0px0dfzF7xsD4/wQ79DwvUva
	b/Y5uHcnCwy6Gsu393UaZ/RA8qnFzzHmDy8DVdNcmTouF9ZaUFW5ZY9wm72PmEtb4TkhzFwJMAr
	ZegkR8abbILvx1/GqHLNwBwrAplYu3v8xzLgog7fBT+omUvFCMZSepuMGMzJVnzkXpKJrvWt6rQ
	Q81C5uuM1GP34fsRBccuYEVRe4ec/pBKBLRiwONd5aHq04HT4Wgka2r5ylGlQUDGWqxPS0fAJhg
	eXLT9SpnId/MhLXjPN+zIO0j2+Tw9CDQ3iNHEf7hpWuymk5r07fXu+2wTGD6FvDgMwvSUK4gNYo
	1ll
X-Received: by 2002:a05:622a:e496:10b0:533:24e3:49cf with SMTP id d75a77b69052e-53324e3507emr127934591cf.21.1790673602266;
        Tue, 29 Sep 2026 02:20:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.104.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9178d39627asm5968526d6.45.2026.09.29.02.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:20:01 -0700 (PDT)
Message-Id: <45b26e2bb292f31eb36d88e2fcf8801eb8313374.1790673598.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v4.git.git.1790673598.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v4.git.git.1790673598.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 29 Sep 2026 09:19:56 +0000
Subject: [PATCH v4 2/4] fetch: infer branches to fetch from a refmap-only
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
 builtin/fetch.c                  |  52 ++++++++++++--
 remote.c                         |  29 ++++++++
 remote.h                         |   3 +
 t/meson.build                    |   1 +
 t/t5585-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
 7 files changed, 205 insertions(+), 10 deletions(-)
 create mode 100755 t/t5585-fetch-refmap.sh

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
index 538914bc6e..315daf97d7 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -245,8 +245,10 @@ endif::git-pull[]
 	command-line arguments. See section on "Configured Remote-tracking
 	Branches" for details.
 +
-`remote.<name>.refmap` provides the default value for this option, the
-same way `remote.<name>.fetch` provides the default refspecs to fetch.
+When a refmap is active (from `--refmap` or `remote.<name>.refmap`) but
+there is nothing to fetch, neither on the command line nor from
+`remote.<name>.fetch`, Git infers what to fetch from the local branches
+whose `@{upstream}` is on that remote.
 
 `-t`::
 `--tags`::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7651b41139..7ef2776f17 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -511,6 +511,8 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct ref **tail = &ref_map;
 	struct refspec *effective_refmap =
 		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
+	struct refspec inferred_rs;
+	int inferred_branches = 0;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
@@ -518,15 +520,32 @@ static struct ref *get_ref_map(struct remote *remote,
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
+		branches_tracking_remote(remote, &tracked);
+		for_each_string_list_item(item, &tracked)
+			refspec_append(&inferred_rs, item->string);
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
@@ -561,6 +580,8 @@ static struct ref *get_ref_map(struct remote *remote,
 
 		for (i = 0; i < fetch_refspec->nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
+	} else if (inferred_branches) {
+		/* Already fully handled above. */
 	} else if (effective_refmap && effective_refmap->nr) {
 		die("--refmap option is only meaningful with command-line refspec(s)");
 	} else {
@@ -656,6 +677,7 @@ static struct ref *get_ref_map(struct remote *remote,
 	if (existing_refs_populated)
 		hashmap_clear_and_free(&existing_refs, struct refname_hash_entry, ent);
 
+	refspec_clear(&inferred_rs);
 	return ref_map;
 }
 
@@ -1960,15 +1982,30 @@ static int do_fetch(struct transport *transport,
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
@@ -2009,6 +2046,7 @@ static int do_fetch(struct transport *transport,
 
 	ref_map = get_ref_map(transport->remote, remote_refs, rs,
 			      tags, &autotags);
+
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
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
index 0000000000..b81fc48cbe
--- /dev/null
+++ b/t/t5585-fetch-refmap.sh
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

