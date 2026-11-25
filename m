Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633596;
	b=heynqazTVCxvazDZMQfb3+DQQqiPhBxAZhWLtzZ5B+X1esUdNvt38NBvbMUSci1o/Kl2
	 MC2EFJbqc3L9+GwyvXx0ACZhAzPif25nygEckZ0GnMXWtxnKORbvOapfVdOlUVAPK+MM+
	 mkov8G21Ok6yVxBG2a4cb8Ovaf4WmFyqGpbBoTBBxWvp3lwJfBbqBHiexLDvnEwdJAmE9
	 NfQ8mY9eahkD663Z7NnWI4Ya/C+uTmJE/tvv8GEOob3zbBbmOj39DeCUkDhNNrWENmr1d
	 4soPcHlRjSK7bb71xTJ4hBQ4QvM+deMSbGixciam98l0+pkYgrYVOfFiPWYkpAoB/hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=O0EqwTWJNsPHeRvRDUiyymiS0s/rJ0NFB/EpFVhsCVg=;
	b=DERfrj56S0reHXn9RVUZehc+9qlHjNkZBWm1/QVaUBEti70P8AX1IaypAd3/z0pEhp0n
	 BMDKvKUtQ+2JOVbVXhg5xyrlkWZFKKdSUnhLn1NfMOu50Ph9S38cPMCwm7Y0NU0Olc9OK
	 wq6n8SJuEojVDmLgnR4T243WDFjuqalTyDuyu/CoC0LUG1wmx4rBwzC4x+YSvYVv4Mrz4
	 aak0N2GsqLJlREyK+NY/L/2VH/7q+XwD+i18XJFI0iFEDV5DsCO1Ql1xdMiionordtoYw
	 ydiHUWbddy3UcNsfM5VqegWyl94nruXan2YKHVIvIMRNztaOdA6mFgKG7zEY3zYjBFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N7AobbkG;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D05606A32E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7D05606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N7AobbkG
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-71ac9e15640so3878419eaf.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 11:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795633595; x=1796238395; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O0EqwTWJNsPHeRvRDUiyymiS0s/rJ0NFB/EpFVhsCVg=;
        b=N7AobbkG9roE5WLZdeDK9k2TD+736jTuJv3kIg1SVCbF3DmjEhX2W7K6c13JAr8x0e
         Ssfm51WR25inuXnZrR3AaxlDIYnFZhQiapQL56yg6U+4XqnhPzGFK5RVMo0qyaW0GB72
         7ekpTvXelP/dApVIvDrAtJV/T7+Y2Mvx1jDgV6w/NGxKUh6hkI+8TsHgzYWVErrvJeZb
         mUihUCiNEkzZapIuvQ4RDXwXhmKddlFgcx2Ey4b4i9xQUdNFJGB5wtt0y60OISaAsItV
         wOZ96PFe4XPbWyW2gHa9fal+hUg6eFjyPZjF7I3arKL2X5XdC+GLQbYDPUtaRbKJKLzH
         HRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633595; x=1796238395;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O0EqwTWJNsPHeRvRDUiyymiS0s/rJ0NFB/EpFVhsCVg=;
        b=jRT09HiYo8m4mViV+n2pW8/+Ss7wwzj3o511+QtlOImdhkdOVFYbmemKnBXTQVZD77
         a+lf+l2w2sjDrOkvttYGd0Lu4fodVRY75RFkN5NAfB3BNx2YW0OABCOWBC/+AYTawdYh
         LLjjT2y6uxohrO3llUDqih+iINt/j9HkXgYH8mPbOHrFYPJYumGb0DS/tm+9PFmmCMGn
         vRm6UsTO90yLiHhROXP0+JgyPt9ojlFFe+u9kYusd6mA3sDqKh5QmsiETnAZxvcIbNDh
         ngL+Id/Po/BxN04QWey1cNNd+vNQXWhHmnomeB83qHHOTWX4lFQvVCSTCxw/RSjOB7Kq
         3DYg==
X-Gm-Message-State: APuU4Z+9z9NHZwuS0R5wi7l7SnVeDz/5hRoG2OvYUAu7s3Lj8uKOgc4l
	KIWV10ccg8EQYkTtXfF4U3Gyq+PW8ASmEuuCDSDerPh7RYdOrfErUy1b4Shun1aX
X-Gm-Gg: AZFdTZdzeQqtQzJ8QGtF4GCckbluDiEUNUC5JNtUOpnZW6xN/y6KGzS3p5ad0/h9UE7
	pGWLZWgFOh7ZnC3jRNMBU2qLFpueoiaDvB/qhBcjxv/AT/6NfJlgnS4VKVCPbL7rCOU8St5g2TR
	TRdGF4PDrO7xafRqP3xu2zDgoSjPWXyYglDVjC8xk+UcoQ816JJjSAoleWzvrd15eXIHb/NFaun
	C9cljIL6JfnaV2fIhEKIj7h8jDEuMnRIKMHb9u2JzFkuuq58D4aZgGuCM7Vs7aJ4LC0HXADCtax
	c54/ShwyYAy4vD9F8MKjLsZJW6TfJtlZsYyYbtPNpQGRXB1HJsgV+yS1DvH7NS9qNkchjXdC/ao
	yfkRmKc+G6HPEuTzLNr6n29uQj2jBWbsNFG549ZJcR6o5O3SCUp3tlqEfJdl74isaarNBsNzZle
	cgF8buv2PbKfyeFdEnfKS4M/54JnBAEMA3Fbazw5LltHQpb7NX1ah4OlOVIh+vKO87sXlJchSJ4
	svsLiV/dc08suIH/cHMrawlNUhQHuAsz1EqNQ7jyKVwAzySU6RCANGy7oDQ1L+Yr74iWin6QYDv
	r2zkSS5vhrFsR5WHtXeSgJhUQJBWtwxjJA==
X-Received: by 2002:a05:6820:1344:b0:71a:f121:3f7b with SMTP id 006d021491bc7-71b3955c796mr14168439eaf.68.1795633594733;
        Wed, 25 Nov 2026 11:06:34 -0800 (PST)
Received: from [127.0.0.1] ([40.124.78.245])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380bdff9sm12609078eaf.11.2026.11.25.11.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:06:34 -0800 (PST)
Message-Id: <8b43d460fef2d8ee30d22d7eb53022f738cdd0b1.1795633584.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 19:06:22 +0000
Subject: [PATCH v16 5/7] fetch: add remote.<name>.fetchUpstreams
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

In a repository that only works with a few branches of a large
remote, the default refspec makes every "git fetch" download all of
that remote's branches. Narrowing remote.<name>.fetch by hand works,
but the list has to be kept up to date whenever a branch is started
or dropped.

Add remote.<name>.fetchUpstreams. When it is set, "git fetch <name>"
without refspecs on the command line also fetches the upstream
branches that local branches have on that remote, in addition to
what remote.<name>.fetch asks for.

The setting only decides what to fetch. Where the result is stored
is still up to remote.<name>.fetch and remote.<name>.fetchRefmap, so
a remote with fetchUpstreams, a fetchRefmap and no fetch refspec
follows exactly the branches in use locally. Only the upstream of
the current branch is marked for merge, so "git pull" keeps
integrating that branch alone.

Let @{push} use the refmap too, so a branch pushed to such a remote
resolves to the remote-tracking branch the push updated, instead of
failing with "has no local tracking branch".

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |   8 ++
 builtin/fetch.c                  |  37 ++++++-
 remote.c                         |  29 +++++
 remote.h                         |  11 ++
 t/meson.build                    |   1 +
 t/t5586-fetch-refmap.sh          | 183 +++++++++++++++++++++++++++++++
 6 files changed, 265 insertions(+), 4 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index c088d6257d..cd9a86c8bb 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -42,6 +42,14 @@ remote.<name>.fetchRefmap::
 	only at that destination. See the `--refmap` entry in
 	linkgit:git-fetch[1].
 
+remote.<name>.fetchUpstreams::
+	If true, a `git fetch <name>` without refspecs on the command
+	line also fetches the upstream branches that local branches
+	have on this remote, in addition to what `remote.<name>.fetch`
+	asks for. Combined with `remote.<name>.fetchRefmap` and no
+	`remote.<name>.fetch`, the remote is limited to the branches in
+	use locally. Defaults to false.
+
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0f91bccf1e..d9a51e5ff7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -274,6 +274,27 @@ static void add_merge_config(struct ref **head,
 	}
 }
 
+static void add_branch_upstreams(struct ref **head,
+				 const struct ref *remote_refs,
+				 struct remote *remote,
+				 struct ref ***tail)
+{
+	struct strvec upstreams = STRVEC_INIT;
+
+	branches_tracking_remote(the_repository, remote, &upstreams);
+	for (size_t i = 0; i < upstreams.nr; i++) {
+		struct refspec_item refspec = { .src = (char *)upstreams.v[i] };
+		struct ref *rm;
+
+		for (rm = *head; rm; rm = rm->next)
+			if (refname_match(upstreams.v[i], rm->name))
+				break;
+		if (!rm)
+			get_fetch_map(remote_refs, &refspec, tail, 1);
+	}
+	strvec_clear(&upstreams);
+}
+
 static void map_refs_without_dst(const struct ref *ref_map,
 				 const struct refspec *refmap,
 				 struct ref ***tail)
@@ -607,7 +628,7 @@ static struct ref *get_ref_map(struct remote *remote,
 		struct branch *branch = branch_get(NULL);
 		int has_merge = branch_has_merge_config(branch);
 		if (remote &&
-		    (remote->fetch.nr ||
+		    (remote->fetch.nr || remote->fetch_upstreams ||
 		     /* Note: has_merge implies non-NULL branch->remote_name */
 		     (has_merge && !strcmp(branch->remote_name, remote->name)))) {
 			for (i = 0; i < remote->fetch.nr; i++) {
@@ -619,6 +640,9 @@ static struct ref *get_ref_map(struct remote *remote,
 				    !remote->fetch.items[0].pattern)
 					ref_map->fetch_head_status = FETCH_HEAD_MERGE;
 			}
+			if (remote->fetch_upstreams)
+				add_branch_upstreams(&ref_map, remote_refs,
+						     remote, &tail);
 			/*
 			 * if the remote we're fetching from is the same
 			 * as given in branch.<name>.remote, we add the
@@ -2032,7 +2056,8 @@ static int do_fetch(struct transport *transport,
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
-		if (transport->remote->fetch.nr) {
+		if (transport->remote->fetch.nr ||
+		    transport->remote->fetch_upstreams) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
 			/*
@@ -2052,8 +2077,12 @@ static int do_fetch(struct transport *transport,
 		 * branch's upstream (e.g. a narrowed -t refspec), so
 		 * make sure we can still fetch it regardless.
 		 */
-		collect_upstream_from_remote(the_repository, transport->remote,
-					      NULL, &transport_ls_refs_options.ref_prefixes);
+		if (transport->remote->fetch_upstreams)
+			branches_tracking_remote(the_repository, transport->remote,
+						  &transport_ls_refs_options.ref_prefixes);
+		else
+			collect_upstream_from_remote(the_repository, transport->remote,
+						      NULL, &transport_ls_refs_options.ref_prefixes);
 
 		/*
 		 * If there are no refs specified to fetch, then we just
diff --git a/remote.c b/remote.c
index 92fe44c026..c9ea6deae5 100644
--- a/remote.c
+++ b/remote.c
@@ -548,6 +548,8 @@ static int handle_config(const char *key, const char *value,
 			return -1;
 		refspec_append(&remote->refmap, v);
 		free(v);
+	} else if (!strcmp(subkey, "fetchupstreams")) {
+		remote->fetch_upstreams = git_config_bool(key, value);
 	} else if (!strcmp(subkey, "receivepack")) {
 		char *v;
 		if (git_config_string(&v, key, value))
@@ -1986,6 +1988,31 @@ void collect_upstream_from_remote(struct repository *repo,
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
@@ -2065,6 +2092,8 @@ static char *tracking_for_push_dest(struct repository *repo,
 
 	remote = repo_remote_for_push_tracking(repo, remote);
 	ret = apply_refspecs(&remote->fetch, refname);
+	if (!ret)
+		ret = apply_refspecs(&remote->refmap, refname);
 	if (!ret)
 		return error_buf(err,
 				 _("push destination '%s' on remote '%s' has no local tracking branch"),
diff --git a/remote.h b/remote.h
index 003c8fd180..73bbe729f5 100644
--- a/remote.h
+++ b/remote.h
@@ -96,6 +96,12 @@ struct remote {
 	 */
 	struct refspec refmap;
 
+	/*
+	 * Whether a fetch without refspecs on the command line also
+	 * fetches the upstreams that local branches have on this remote.
+	 */
+	bool fetch_upstreams;
+
 	/*
 	 * The setting for whether to fetch tags (as a separate rule from the
 	 * configured refspecs);
@@ -368,6 +374,11 @@ void collect_upstream_from_remote(struct repository *repo,
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
index 0000000000..080613eb23
--- /dev/null
+++ b/t/t5586-fetch-refmap.sh
@@ -0,0 +1,183 @@
+#!/bin/sh
+
+test_description='"git fetch" with remote.<name>.fetchUpstreams
+
+With remote.<name>.fetchUpstreams set, a refspec-less fetch also
+fetches the upstreams that local branches have on that remote, and
+remote.<name>.fetchRefmap decides where they are stored.
+'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+check_upstream_refs () {
+	git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+check_upstream_tip () {
+	git -C .. rev-parse "$2" >expect &&
+	git rev-parse "$1" >actual &&
+	test_cmp expect actual
+}
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
+			"+refs/heads/*:refs/remotes/upstream/*" &&
+		git config remote.upstream.fetchUpstreams true
+	)
+'
+
+test_expect_success 'a bare fetch needs nothing until a branch is tracked' '
+	(
+		cd client &&
+		git fetch upstream &&
+		check_upstream_refs <<-\EOF
+		EOF
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
+		check_upstream_refs <<-\EOF &&
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		refs/remotes/upstream/side
+		EOF
+		check_upstream_tip refs/remotes/upstream/side side &&
+		git rev-parse --verify refs/tags/side-2
+	)
+'
+
+test_expect_success 'a second branch tracking the same upstream branch does not fetch it twice' '
+	(
+		cd client &&
+		git branch side-topic-2 upstream/side &&
+		git fetch upstream &&
+		grep "branch .side. of" .git/FETCH_HEAD >fetched &&
+		test_line_count = 1 fetched
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
+		check_upstream_refs <<-\EOF
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		refs/remotes/upstream/side
+		EOF
+	)
+'
+
+test_expect_success 'upstreams are not fetched without remote.<name>.fetchUpstreams' '
+	git checkout side &&
+	test_commit side-3 &&
+	git checkout main &&
+	(
+		cd client &&
+		git rev-parse refs/remotes/upstream/side >expect &&
+		git -c remote.upstream.fetchUpstreams=false fetch upstream &&
+		git rev-parse refs/remotes/upstream/side >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'remote.<name>.fetch adds to the upstreams being fetched' '
+	(
+		cd client &&
+		git -c remote.upstream.fetch=next fetch upstream &&
+		check_upstream_refs <<-\EOF &&
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		refs/remotes/upstream/next
+		refs/remotes/upstream/side
+		EOF
+		check_upstream_tip refs/remotes/upstream/side side
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
+		check_upstream_tip refs/prefetch/remotes/upstream/main main
+	)
+'
+
+test_expect_success 'git pull merges only the upstream of the current branch' '
+	(
+		cd client &&
+		git pull &&
+		check_upstream_tip HEAD main
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

