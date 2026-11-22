Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348655;
	b=U38CR2NkS+LQ0EkNERWsbXqYm4DIEo8foaFEEU3CfmI+6A59FyHujvKWPIwk6jpxoGND
	 v3bfzvUnBVEoXhuh7MFZ4n9bPz8s6CajKUvELMj8LMkhHmMBgjHzzy1B0OHmNfr0B8rko
	 EBeuDSShxMVd9NcH1MX8AysueCXohAqXWTK0PowNGQFOspfgFGDvCctL3R/moYzMX+bqT
	 c1FgvVvDcJjkSr4rj0rWi/6DPmXJwCvcEDV0RGxefp7NCkvLCrCSZE06E/nq1V1erDas2
	 VRETKDtc/zPoJiEwbSIcNzlpYdwJOJyzDnu0Zn0BEB3q8weawsuDX7VvDa1gN6ChQ/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=wjEi7VZDwZ4lcgChuXwhlVKbr2RCeuNgCTUkHokx5n8=;
	b=3GAGejlO3USOqu0Mb0vgA7CcTbL5Ji8TlNRFRo2CfHcXoMs2B2IUWyQ3+CRvQHtKy/Fr
	 hqQLUVV2uV0BeIm4R/1oJLqLeP6TAP0//9Tr9ZdqO193LRWRSN1X0gMYsqWCP327zc7lj
	 oaLqq4V/PhXJJ9YHYAi376CfB5L7AXf//psnS/mPEKw+58Tp3tnoFAqf/X4LpKkOi3dRS
	 xvQbKVOLTJV/H8/9E1rPVvX2aziWIFhjXHTdWMYObub/BRhqiMFAWFtxe3gJSKP0FRR7F
	 h+tvUMLuTYWrAJYFPCvmOqcA8nNHgXEU0r1GZTT1JQmjFz+HxoNWMYshouBMYnr9alQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n0OFmfu2;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBA1606A334
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 11:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CBA1606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n0OFmfu2
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-38644aedba1so3186248eec.0
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 03:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795348653; x=1795953453; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wjEi7VZDwZ4lcgChuXwhlVKbr2RCeuNgCTUkHokx5n8=;
        b=n0OFmfu2q00A3POapodQBlz65BOAnyMXX1SVTi2Ldq2Cp/MaLw9WN9386N1Se/46Kr
         cNJ8aTy27lnxVRIc0LQG/l3y0U+Yh2HHpmfQpczJIqy7XsXQ9bMIQmcxo1zit9cyAkLV
         4o4fU1amjcN/HiBrkdJ+Gqc2ULxB0cPeCd6x11SqBd1SYmssPML+mY9ai6t1EdkAkOxs
         3EI9XgWHfgqZws8oqACUnjRPPuBJy1m0AINwtwPCOsc6dm2ELVvFxtKJgmVk62TopZz0
         RULAa1Rll0H3AiEYCR86UA5Uwvlj1Eovwlrt8DrC/AzIn6ron3IZYttMMOdTrfOckSHa
         3shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348653; x=1795953453;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wjEi7VZDwZ4lcgChuXwhlVKbr2RCeuNgCTUkHokx5n8=;
        b=ljbqWSwtrRn3JGh5hAi6TgX0yRtwEhvZlac01wB1bB183Mwza0DLLo5AAPOGY5oBXr
         RVYuaS1928xPoJ+tDCucLeeTZtn7UfsZVBQ3+Tdmq7OZ8VUJUBf1D/h21YO36mNwX1D5
         ip6S9tM1tcA/LG9+xgUcRhMiserRiW0HZpfzSBgDpcTizUjImw9lFzjM5wvTzno1Ywtk
         uQXHt3GfMleGkGz6sGmW01QlFK8YNkwekNtVKw4VOq3V+1FTU9ei3aNo75k5ttefWFSw
         dsNHzSNUZZ4OKQ6LD1bWWudlcskLrnaR+Qil7mTcq+jhwNUgZCmU39G7/QnVZoHfESRo
         lumQ==
X-Gm-Message-State: APuU4Z+0HXv3K9/5Q7Fl4DK5esIPlsCA4xzpCtHniLabKFe+yMHOziwj
	1rmfRk1jjBZgMi6jswFvRIp8lzX8MrpD49Hvn8SuqAFnvQHa1Kn3ZBVYJo1ryg==
X-Gm-Gg: AZFdTZcnzy4hqpf3F3AzyGWWuaYFo4xqHg5zZKAU2/j4ms0gJCir+7TPezJ276uLlNB
	a4YNt9hrnzXSeZjAZlcfzasJqBiiCX6ob4oNPEbWoSjiCrMGTLIViy8ei3VhT1/4ju40WUcFtta
	9rw8/3PHG3IjYvMi8nuucxQGgs0t9Gd15xexzvvCTWHlBeaj+DSCt8VX9JoMdYSgZoZgBLyd5V2
	LiIDLgDmbMzaiizTqMqspVk/CxKhgRxsb8DOr+cuoe/Afc2+AqzExXQCCyc17vmppNl/MGwdW8O
	kPhDAY8kabum6pmmqO3S7QBQ/3g/rgW9QFcK83VIR4T/aXAdTuAmokVAbmph+S26jtdjN+y5J9B
	cXU45ocZrVNtZMGtwug70gHWOaBI3CcLTBncaEg2br8rlynujupFYhNryjlb7vdO4vFTnTNxTSq
	FW7gR3PbPSCGh2Alz+qGdQIxi4a0rQ8hTulBS/R0PJJgFSswgGzZXRN22gOtnkrDmvy1l39aFW2
	UECaZIASKprqwasEkWvPiZqhYqXsAFDsdi3eEdSpODHulvpd2BUX2ToaEUQNqq4Ddsy2zShNlJF
	dpewAnjUl+lpPJWVFnym2gj0Z8LNYJLhJw==
X-Received: by 2002:a05:7301:f02:b0:386:a3a1:6f24 with SMTP id 5a478bee46e88-386a3a17d5fmr3364562eec.24.1795348653406;
        Sun, 22 Nov 2026 03:57:33 -0800 (PST)
Received: from [127.0.0.1] ([20.184.150.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm30271490eec.10.2026.11.22.03.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:57:32 -0800 (PST)
Message-Id: <ece6bd824b8cc42dd13001cac0a60be41fb68a51.1795348644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Nov 2026 11:57:22 +0000
Subject: [PATCH v15 5/7] fetch: add remote.<name>.fetchUpstreams
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
 t/t5586-fetch-refmap.sh          | 182 +++++++++++++++++++++++++++++++
 6 files changed, 264 insertions(+), 4 deletions(-)
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
index a9b7305f5f..0cfcd5bdd1 100644
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
@@ -2028,7 +2052,8 @@ static int do_fetch(struct transport *transport,
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
-		if (transport->remote->fetch.nr) {
+		if (transport->remote->fetch.nr ||
+		    transport->remote->fetch_upstreams) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
 			/*
@@ -2048,8 +2073,12 @@ static int do_fetch(struct transport *transport,
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
index ffe892a326..72b4c15a04 100644
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
@@ -1982,6 +1984,31 @@ void collect_upstream_from_remote(struct repository *repo,
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
@@ -2061,6 +2088,8 @@ static char *tracking_for_push_dest(struct repository *repo,
 
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
index 0000000000..4af59868e6
--- /dev/null
+++ b/t/t5586-fetch-refmap.sh
@@ -0,0 +1,182 @@
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
+		check_upstream_tip refs/remotes/upstream/side side
+	)
+'
+
+test_expect_success 'a second branch tracking the same upstream branch does not fetch it twice' '
+	(
+		cd client &&
+		git branch side-topic-2 upstream/side &&
+		git fetch upstream &&
+		grep side .git/FETCH_HEAD >fetched &&
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

