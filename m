Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A674C33F588
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619343; cv=none; b=kbZr40pvj4v+h52ISo5rzjcUzIRV6D4xLJ9GEM4z53siaUNhPgnO18EbJ5acEfBECO6RDbo92vJBbrzHnu6YVDlydRcZbE4yVYORNBjpsKoiawSp4Qf1ZI21zyuyFOt56t69f2GSs+y+m7ul2toCHgwHYtnu8zZUWyGenry8IJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619343; c=relaxed/simple;
	bh=pYUlp20ffoPzPA9dFviQYYl/deECwu0lUMInxsMQBV4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m8k/vTs4OtgovDGrcaIivBH6N1VnR7oTgGMe0sljKQmsMCJrpvsKW9pDHX8x4GGSFB/U4oX1yUXHZXFnlGPotGBNTO9rYocRArvJoAoxS0ucZL33gw3RSwDxonljzD3KQmEeZWbmYDHGNR2zn2vdHqrxfMUHfZftRa7waS2u3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH8GFhxN; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH8GFhxN"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-919abb3335fso7158436d6.0
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 01:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791619340; x=1792224140; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SXkMFn6P7vfM7XL+i1a1/m6lyzBaGPyGM8b6Fgmcio4=;
        b=iH8GFhxNucZMvW00Zj77yjl+x3Uir53fH9m4EjRlrubRb2wHC/1+mCQNf01Bnv6oAM
         UKVA0V5ZbhUxjI9PDDmHfPqoDcUnDc2sBeaF2b9mNGDi/hIrxrA2KcytCbSfGo5VYfRx
         aNx7Q65Gfg+dzScWuDIMkSGoy4GdKb4fB6eDEXf2uTzFomuJDyreSLmQY8hHTKwyPcl/
         5e2JRk+cl4Xp89FO9RVgBGf/eWoc0ML8tC3UlXgQtxYaxAC1MXFSW6wVlfJY2zqMYN2l
         vRzGvMcDSPM6W7btbR6U6wLgsOkISgkyPlzooD8i/6nrtJtxpBMalLMbjLuquCDn3EO7
         K4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791619340; x=1792224140;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SXkMFn6P7vfM7XL+i1a1/m6lyzBaGPyGM8b6Fgmcio4=;
        b=A6QGkR0Q5RrE5U2f2xJKs+Ip1Z5DDZsMCsGvr/HrUfNuKUTcK2Pqucl0BtKrhSi88F
         fl/9fwACdIu2Mbm8OgrbAqNf3O+B836IJVkBzoTHWYTSuL6mM9zzcZSE0rBVH3LWcnYn
         2b6n3Clb22mb9Q30Suq/cdCTEZT4Irvz2YB2+8BnXyBb+mDEceA58yGSIhCYacxqghCP
         05VoEK1hX7LfG5p8B8ED+ql2WtETwODQyDLvYoZ7ztgTO6EN6MVArpCYa7mUzKv6QI0r
         a3V+i2ZaeYBLo+/jHBmIsd3nXB3iCqdKthBmhXTdhVsmtdMMRnnjmkiYZyMiFXIF3G9A
         KIQw==
X-Gm-Message-State: AFq9FYJUG/eHe5lKCXhs73Ib+dhDYHAFQbGNHnolUCwr/UG227Cabs43
	nkfm00fokmFziTHuj+iliOO78twU3ewNQFvNvBR1kjT+k43uc6ZbHzP+6VetDg==
X-Gm-Gg: AYBFou0FnYwMqaxE637VkT1CZk4ta00d6GqRfj0BBn0HyRiSrhwEqFkb5PiWEZvd6zF
	41EnyZTzUv7Q3t4meDbe7TUtlx+6vHOVW6OKYIQbpCYi47cBjqZYxafW7jFPnVvZlIbr3H91X4p
	9yM0ESHB8YrbJ6mPhQ8octvwhjAHpsPZgKDyGsjvrXjz/EdSlT9ERsvl7sE/qccWH8oaSg8kkVR
	MRdto5GqbjLL/X4EYZxaq7MSTxgQpjdj7cZ59v39Y0ATpryPMtMubsrcU4ca0gX0xwt4dO0cOtg
	yfzx7tp+JxnGC/xsYv/n+4D3NS3xCW2vd1mmjmIPv2hRwVNocCnQi+2O5mqUgQgV+b9zYz+9VTj
	M4wpaYKPyRlw7ZVjvGauEMxUXKMLsCD0DwlN6Vn9K4EzScNlCGwq2SMBOO4etO5PmfuRyS6/8k8
	9fFaOYsxENOs6ZDBiNWYAWTYtN3QVzXExgxrDEJyoLn3r1uD/zRbfISyr/CJl8SMID6H9bJZS/d
	h4=
X-Received: by 2002:a05:620a:6f05:b0:93e:5fff:db02 with SMTP id af79cd13be357-93ebd1dc7camr682358385a.28.1791619340531;
        Sat, 10 Oct 2026 01:02:20 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.190.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9896ac4sm367563885a.31.2026.10.10.01.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 01:02:19 -0700 (PDT)
Message-Id: <a39316d233ee656c6e003927e9e3e526ada0553e.1791619334.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v8.git.git.1791619334.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v8.git.git.1791619334.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Oct 2026 08:02:12 +0000
Subject: [PATCH v8 3/5] fetch: infer branches to fetch from a refmap-only
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
 builtin/fetch.c                  |  41 ++++++++++-
 remote.c                         |  24 +++++++
 remote.h                         |   4 ++
 t/meson.build                    |   1 +
 t/t5586-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
 7 files changed, 194 insertions(+), 6 deletions(-)
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
index 4753656288..de3298c0b1 100644
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
 
@@ -1983,11 +2005,24 @@ static int do_fetch(struct transport *transport,
 				    item->string);
 		string_list_clear(&tracked, 0);
 	} else {
+		/*
+		 * The --refmap command line option, if given, takes
+		 * precedence over remote.<name>.refmap.
+		 */
+		struct refspec *effective_refmap = refmap.nr ? &refmap :
+			&transport->remote->refmap;
 		struct string_list tracked = STRING_LIST_INIT_DUP;
 		struct string_list_item *item;
 
-		collect_upstream_from_remote(the_repository, &tracked,
-					      transport->remote, NULL);
+		if (effective_refmap->nr) {
+			branches_tracking_remote(the_repository,
+						  transport->remote, &tracked);
+			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
+				do_set_head = 1;
+		} else {
+			collect_upstream_from_remote(the_repository, &tracked,
+						      transport->remote, NULL);
+		}
 		for_each_string_list_item(item, &tracked)
 			strvec_push(&transport_ls_refs_options.ref_prefixes,
 				    item->string);
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

