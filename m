Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633592;
	b=GxjX8CMZbbZJQqTtyiBw9rnfsikfJvRAde3edZ/mLhWl2S822aojZgxYYJRQDyKYsLET
	 janAU69LneMoTptp/S5klrDqeK0p1l9nbIMzyuq2WZVJwoJlVjXIhYCgBUmqLqiM/SV2q
	 99bHe3XDPd92oARrCidtC7ICuw8jmRuMVlK4xfZX3JNIsD8XGCg0XQCqkDkgiucqRWI2k
	 T7y8Grt3BxBPn44VoO0rUF07o5ImFpYlKKWvIHciLrhwL5dvOgoxCBPoR6XGUzPpDxoam
	 Fuj/KfBbhtdnSZm6fXrjOi7xtuddi0WyJwytLMq9HYs3vYbcztKTt/7MlAhInkRYKZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=f31aMgKX8KzdrTngiqCGERXe6Inf5by5VFoLQry/F4M=;
	b=HCn7WYXIeT8VnOlGpKQ0mm2X1IH7dpR3i6O7bFHzPf3StWSDHJ9o6BpdFaQZfXr0Kntp
	 2a0v08vXX87PpFB4e2qeoBu4a4kYNVt0XxPztcPB1EWhUAkzIudHadABLXNDhAeLCzDhZ
	 qFe73+lYs+b+44PlwxPJHSWmc27l+QFszq3cDdJXLhQDjGLMc0FyUMPd/nnlTFyuT2qyG
	 qfdcsXGTizZbf4JgITZjUHQ3hqhwf0yM/tpg5+JlaLTAZhMLmUNAaXK1mkYoSu77EIN5z
	 IknR7hjFNQnMWx3GRGCSJy/mqFPz8e5offbwv94rm1YhENBntYJeoV/Nw3dAUcWmZvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hw67E3US;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D65606A329
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40D65606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hw67E3US
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4ad60ec5eaaso5531459fac.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 11:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795633591; x=1796238391; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f31aMgKX8KzdrTngiqCGERXe6Inf5by5VFoLQry/F4M=;
        b=Hw67E3USdmO0Y73vQSgRVAiSpH1J3kyTMaMe/Wki60xvuRRxVHrqasOKwjWGiiMSqH
         c09ZdLLL7EKKlUtUiyNrFAn5YQ0NuPLn29HskDr7jofYA25axuWmnxwZW1qFipo73WQ5
         t7Jk2oWjcBovSLWfu89eivhQ+l8OqXvAL654zGxmUCFaaOE0vk58fRmqyRXHC8xJaVNL
         8agkKuMQJ4mfb9Reurk2Hczo8rYgiorpKFhGD5YnJhgf6bD3wVN2JvMQKxe1Yc6MJ5ce
         aod7ylKR6w0WE+OOW4CyIalSNl9VRHTSqw2kj7Lzpn4W93T6M5EOnmyPm1qkROJJviBc
         UqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633591; x=1796238391;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f31aMgKX8KzdrTngiqCGERXe6Inf5by5VFoLQry/F4M=;
        b=ZaF8DQGGEhjG6WCkDOnisDZE/1kNzFBfHmwojjaki2hmXSgby8S5H+u2EjvmtiEw1n
         bI4/CgegmzdNS6CNKAwCmitHB0V8sZC1+/kB9cSnEUBnsjjp7g6XmylvxcHbpoV/sQ6q
         HKcveTcysR5kO7pJ6rGNxtO6XGL9BgPanzm6uVkODeYh5a+yBexhWd7re1M+I0YqJM1v
         8ksdCSTKIDTpfft5ITK2YYQntKOOy/GsttavqH4jpkY5opOy2/aht6R0/r6hXXsvm2oP
         An0lt9OJYXoWVARsHn1zDYECyYWxir60jOW7JCM+4IAsA/PjJJhPVQWXh49siKO1VDYU
         HWVw==
X-Gm-Message-State: APuU4Z9yFizff+Vb6a2KxL2wnBBPR/ZqVekhOdrU1reMgl9QQO5C4liH
	BdtQK+6lIxIQQeMZ9RabUV9mHIsszgAKfKrIJZC3XKGp4Iivr0a1LxJsZ0NJQd29
X-Gm-Gg: AZFdTZd1UyFczCFdWIiwVlslDNHXiNe+c+cix1siVRaUB3SkGIs6Ay1fxAmClUMeAKz
	qJ7N/ih2qUKEdPxTnHbWggeu75q3XZGfKhpF1GD1wXtM/9TTJM0iW8UaR9YkBtt2aMSC4ZiwGuE
	GqinPoLO54Fh3V8a56u9a310Yig5coXZIt68f/wTj8/O1eRKhptRQ4JrfwboX56aXpjjJac5Lpa
	hLqSefwpe2yKSPOAlli/jRBKsaZ9xKdn0qxubK+hw4NJa2rrN8gYhlKWrw0PP5kU4hHWVrLvfC0
	RGrCrJEVxWApMRhJ1JGPd6EAWNkLuqlyCOmXAldf6ocS4/KSjDcihOfGTZuuF/JFt7BGgXAY4RA
	7lOSNyvG2OAGG5M7zM5opV7Jfh9vysTn9k1OthLO8xl2ztgOvuY6zV5fH9l/suzg2q7cNVZxEMz
	r/y8poqosgBB6HUmshhZVQ/l3BU6yoULEcP8Hn0RIjUaLWbOBsOWLSbHLF+IYW5z48+9Tm5DE7w
	fkd3djDvP7SBtA0Fr6sNdxX5266iBqDKNy06kTXt4YJiZziC7vfm39zIh3IlSvArH1J65qPJ6Ht
	nDSN+DOrrwAblJGXe7j8Ag7FzeUABocY
X-Received: by 2002:a05:6870:1b86:b0:48f:e0f6:bff2 with SMTP id 586e51a60fabf-4bc85902ca1mr11835323fac.30.1795633591012;
        Wed, 25 Nov 2026 11:06:31 -0800 (PST)
Received: from [127.0.0.1] ([40.124.78.245])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc6108104esm16782609fac.14.2026.11.25.11.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:06:29 -0800 (PST)
Message-Id: <f94dd7244335206114930d33b2bbaa577fece4f0.1795633584.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 19:06:20 +0000
Subject: [PATCH v16 3/7] fetch: add remote.<name>.fetchRefmap
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

Add a per-remote config variable, remote.<name>.fetchRefmap, that
provides the default value for --refmap the same way
remote.<name>.fetch already provides the default refspecs to fetch.
--refmap on the command line overrides it.

The refmap only says where fetched refs are stored. Configuring it
does not change what a fetch without refspecs fetches.

When remote.<name>.fetch is also configured, it still decides what to
fetch. Its entries without a destination are stored through the
refmap, and an entry with its own destination is stored only there.
This lets a remote name only a few branches and store them all
through one refmap:

    [remote "cabal"]
        fetch = master
        fetch = next
        fetch = seen
        fetchRefmap = +refs/heads/*:refs/remotes/cabal/*

Tags are followed for refs stored through the refmap, the same as
for refs stored through remote.<name>.fetch.

Looking up the remote-tracking branch for a remote branch, as
@{upstream} and "git branch --track" do, falls back to the refmap when
remote.<name>.fetch has no match, so that these work for such
branches too. A branch excluded by a negative refspec in
remote.<name>.fetch stays excluded.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |   9 ++
 Documentation/fetch-options.adoc |   3 +
 builtin/fetch.c                  |  26 ++++--
 remote.c                         |  20 +++-
 remote.h                         |   6 ++
 t/t5510-fetch.sh                 | 155 +++++++++++++++++++++++++++++++
 6 files changed, 210 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 3a20d0f752..c088d6257d 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -33,6 +33,15 @@ remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
 
+remote.<name>.fetchRefmap::
+	The default value of the `--refmap` option, used to map refs being
+	fetched to remote-tracking refs to store, the same way
+	`remote.<name>.fetch` does for an explicit refspec.
+	`remote.<name>.fetch`, if also configured, still decides what is
+	fetched, and an entry there with its own destination is stored
+	only at that destination. See the `--refmap` entry in
+	linkgit:git-fetch[1].
+
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index e4b9e47806..aed38790bb 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -251,6 +251,9 @@ endif::git-pull[]
 	refspecs and rely entirely on the refspecs supplied as
 	command-line arguments. See section on "Configured Remote-tracking
 	Branches" for details.
++
+`remote.<name>.fetchRefmap` provides the default value for this option, the
+same way `remote.<name>.fetch` provides the default refspecs to fetch.
 
 `-t`::
 `--tags`::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 00f427800e..d9c0e8c2f7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -543,6 +543,12 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct ref *rm;
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
+	/*
+	 * The --refmap command line option, if given, takes precedence
+	 * over remote.<name>.fetchRefmap.
+	 */
+	struct refspec *effective_refmap =
+		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
@@ -553,6 +559,8 @@ static struct ref *get_ref_map(struct remote *remote,
 	filter_prefetch_refspec(rs);
 	if (remote)
 		filter_prefetch_refspec(&remote->fetch);
+	if (effective_refmap)
+		filter_prefetch_refspec(effective_refmap);
 
 	if (rs->nr) {
 		for (i = 0; i < rs->nr; i++) {
@@ -585,10 +593,11 @@ static struct ref *get_ref_map(struct remote *remote,
 		 * opportunistic entries with FETCH_HEAD_IGNORE.
 		 *
 		 * A refspec that names its own destination is not
-		 * mapped through --refmap.
+		 * mapped through the refmap.
 		 */
-		if (refmap.nr)
-			map_refs_without_dst(ref_map, &refmap, &oref_tail);
+		if (effective_refmap && effective_refmap->nr)
+			map_refs_without_dst(ref_map, effective_refmap,
+					     &oref_tail);
 		else
 			for (i = 0; i < remote->fetch.nr; i++)
 				get_fetch_map(ref_map, &remote->fetch.items[i],
@@ -630,12 +639,13 @@ static struct ref *get_ref_map(struct remote *remote,
 			tail = &ref_map->next;
 		}
 
-		if (refmap.nr) {
+		if (refmap.nr)
 			drop_destinations(ref_map);
-			map_refs_without_dst(ref_map, &refmap, &oref_tail);
-			if (orefs)
-				*autotags = 1;
-		}
+		if (effective_refmap)
+			map_refs_without_dst(ref_map, effective_refmap,
+					     &oref_tail);
+		if (orefs)
+			*autotags = 1;
 	}
 
 	if (tags == TAGS_SET) {
diff --git a/remote.c b/remote.c
index 2b7d26b844..d3bb874ed5 100644
--- a/remote.c
+++ b/remote.c
@@ -153,6 +153,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	ret->name = xstrndup(name, len);
 	refspec_init_push(&ret->push, the_hash_algo);
 	refspec_init_fetch(&ret->fetch, the_hash_algo);
+	refspec_init_fetch(&ret->refmap, the_hash_algo);
 	string_list_init_dup(&ret->server_options);
 	string_list_init_dup(&ret->negotiation_restrict);
 	string_list_init_dup(&ret->negotiation_include);
@@ -177,6 +178,7 @@ static void remote_clear(struct remote *remote)
 
 	refspec_clear(&remote->push);
 	refspec_clear(&remote->fetch);
+	refspec_clear(&remote->refmap);
 
 	free((char *)remote->receivepack);
 	free((char *)remote->uploadpack);
@@ -540,6 +542,12 @@ static int handle_config(const char *key, const char *value,
 			return -1;
 		refspec_append(&remote->fetch, v);
 		free(v);
+	} else if (!strcmp(subkey, "fetchrefmap")) {
+		char *v;
+		if (git_config_string(&v, key, value))
+			return -1;
+		refspec_append(&remote->refmap, v);
+		free(v);
 	} else if (!strcmp(subkey, "receivepack")) {
 		char *v;
 		if (git_config_string(&v, key, value))
@@ -1000,7 +1008,17 @@ void ref_push_report_free(struct ref_push_report *report)
 
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
-	return refspec_find_match(&remote->fetch, refspec);
+	char **result = refspec->src ? &refspec->dst : &refspec->src;
+
+	if (remote->fetch.nr && !refspec_find_match(&remote->fetch, refspec))
+		return 0;
+	if (refspec_find_match(&remote->refmap, refspec))
+		return -1;
+	if (refname_matches_negative_refspec_item(refspec->src, &remote->fetch)) {
+		FREE_AND_NULL(*result);
+		return -1;
+	}
+	return 0;
 }
 
 static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
diff --git a/remote.h b/remote.h
index cca02033b9..ac485a584d 100644
--- a/remote.h
+++ b/remote.h
@@ -90,6 +90,12 @@ struct remote {
 
 	struct refspec fetch;
 
+	/*
+	 * How to map refs fetched without an explicit destination into our
+	 * own namespace, the same as the --refmap command line option.
+	 */
+	struct refspec refmap;
+
 	/*
 	 * The setting for whether to fetch tags (as a separate rule from the
 	 * configured refspecs);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index f9a5a1361f..6a72975aae 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -988,6 +988,161 @@ test_expect_success '--refmap is not applied to a refspec with a destination' '
 	)
 '
 
+test_expect_success 'remote.*.fetchRefmap acts like --refmap on the command line' '
+	test_when_finished "git -C three config --unset remote.origin.fetchRefmap" &&
+	git branch -f side &&
+	git -C three config remote.origin.fetchRefmap \
+		"refs/heads/*:refs/remotes/other/*" &&
+	(
+		cd three &&
+		git update-ref refs/remotes/origin/main base-origin-main &&
+		o=$(git rev-parse --verify refs/remotes/origin/main) &&
+		git fetch origin main &&
+		n=$(git rev-parse --verify refs/remotes/origin/main) &&
+		test "$o" = "$n" &&
+		test_must_fail git rev-parse --verify refs/remotes/origin/side &&
+		git rev-parse --verify refs/remotes/other/main
+	)
+'
+
+check_fetched_refs () {
+	git for-each-ref --format="%(refname)" refs/remotes/ >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+setup_refmap_repos () {
+	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
+	git init -b "$1" fetch-refmap-upstream &&
+	test_commit -C fetch-refmap-upstream base &&
+	shift &&
+	for branch
+	do
+		git -C fetch-refmap-upstream branch "$branch" || return 1
+	done &&
+	git init downstream &&
+	(
+		cd downstream &&
+		git remote add cabal ../fetch-refmap-upstream &&
+		git config --unset-all remote.cabal.fetch &&
+		git config remote.cabal.fetchRefmap \
+			"+refs/heads/*:refs/remotes/cabal/*"
+	)
+}
+
+test_expect_success 'remote.<name>.fetchRefmap without tracking (baseline)' '
+	setup_refmap_repos main other &&
+	(
+		cd downstream &&
+
+		# Nothing tracked, nothing fetched, no error.
+		git fetch cabal &&
+		check_fetched_refs <<-\EOF &&
+		EOF
+
+		# An ordinary remote.<name>.fetch still decides what is
+		# fetched and where it is stored.
+		git config remote.cabal.fetch "+refs/heads/*:refs/remotes/cabal/*" &&
+		git fetch cabal &&
+		check_fetched_refs <<-\EOF
+		refs/remotes/cabal/HEAD
+		refs/remotes/cabal/main
+		refs/remotes/cabal/other
+		EOF
+	)
+'
+
+test_expect_success 'remote.<name>.fetchRefmap stores branches named in remote.<name>.fetch' '
+	setup_refmap_repos master next seen other &&
+	(
+		cd downstream &&
+		git config --add remote.cabal.fetch master &&
+		git config --add remote.cabal.fetch next &&
+		git config --add remote.cabal.fetch seen &&
+		git fetch cabal &&
+		check_fetched_refs <<-\EOF &&
+		refs/remotes/cabal/HEAD
+		refs/remotes/cabal/master
+		refs/remotes/cabal/next
+		refs/remotes/cabal/seen
+		EOF
+		git rev-parse --verify refs/tags/base &&
+		git branch --track topic cabal/next &&
+		echo refs/remotes/cabal/next >expect &&
+		git rev-parse --symbolic-full-name topic@{upstream} >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--refmap on the command line overrides remote.<name>.fetchRefmap' '
+	setup_refmap_repos master next &&
+	(
+		cd downstream &&
+		git config --add remote.cabal.fetch master &&
+		git fetch --refmap="refs/heads/*:refs/remotes/other/*" cabal &&
+		check_fetched_refs <<-\EOF
+		refs/remotes/other/master
+		EOF
+	)
+'
+
+test_expect_success 'remote.<name>.fetchRefmap is not applied to a remote.<name>.fetch entry with a destination' '
+	setup_refmap_repos master next &&
+	(
+		cd downstream &&
+		git config --add remote.cabal.fetch \
+			"+refs/heads/master:refs/remotes/custom/master" &&
+		git config --add remote.cabal.fetch next &&
+		git fetch cabal &&
+		check_fetched_refs <<-\EOF
+		refs/remotes/cabal/next
+		refs/remotes/custom/master
+		EOF
+	)
+'
+
+test_expect_success 'remote.<name>.fetchRefmap is not applied to a command-line refspec with a destination' '
+	setup_refmap_repos master next &&
+	(
+		cd downstream &&
+		git fetch cabal master:refs/remotes/custom/master next &&
+		check_fetched_refs <<-\EOF
+		refs/remotes/cabal/next
+		refs/remotes/custom/master
+		EOF
+	)
+'
+
+test_expect_success 'remote.<name>.fetchRefmap tracks a branch outside remote.<name>.fetch' '
+	setup_refmap_repos main other &&
+	(
+		cd downstream &&
+		git config --add remote.cabal.fetch \
+			"+refs/heads/main:refs/remotes/cabal/main" &&
+		git fetch cabal other &&
+		git branch --track topic cabal/other &&
+		test_cmp_config cabal branch.topic.remote &&
+		test_cmp_config refs/heads/other branch.topic.merge &&
+		echo refs/remotes/cabal/other >expect &&
+		git rev-parse --symbolic-full-name topic@{upstream} >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'remote.<name>.fetchRefmap does not track a branch excluded by remote.<name>.fetch' '
+	setup_refmap_repos main secret &&
+	(
+		cd downstream &&
+		git config --add remote.cabal.fetch \
+			"+refs/heads/*:refs/remotes/cabal/*" &&
+		git config --add remote.cabal.fetch "^refs/heads/secret" &&
+		git fetch cabal secret &&
+		git rev-parse --verify refs/remotes/cabal/secret &&
+		test_must_fail git branch --track topic cabal/secret 2>err &&
+		test_grep "not a branch" err
+	)
+'
+
 test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
 	git branch -f side &&
 	(
-- 
gitgitgadget

