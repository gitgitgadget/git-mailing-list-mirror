Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348652;
	b=a5q7E0wTGR6C57Yfosjvf7V3EPsgRMviywpx08OSTqPBF7CN291YCSVx+BQplRNFix5b
	 YzOOLAVavd4NgVgAkJbd9ZpmGEotK/xPbaffjKyVZ6SHW5mrWhSymq2cOkaVc7Q549DBo
	 7PGnhsLNoR2EyIb3QV6+GTzxKbKNZkvD63K6tIivENwvWbdqpRle+FGb/8qQaiHrql412
	 gKrckV29PxpJXdQD530I7lxGGs4ojXQrS2WGJabXbBMkFkMJWm1gD4CCjSaSisFgMt23z
	 Dw/P12ihMGIcwxY3UfREretXTmKQmCopkhUSzuZHpD8hk/YpR/kuvMolBrbuHAShWsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=9xyDRYwKzhDIAxvZxSrhLQJBOdipiBNOceT03a+6U+w=;
	b=yvERv2+1ZQ1QX8gUOoGc1xFcFY9cnO7vf1kq5DUirVDnzhefGc3brnVY9y8smbPuW36y
	 yhJG0Y5YSuaLo4PIu3dAE4dcAZ0FOvVeojvHFbij23vgy+PHCiwzQfhP1UXAnSxCZEL7D
	 /QZeG5ltC+HwX8Mgv+a5JlPk9QTV4CBo6ztSpZkYqLdgCDXeSKu3rjzOGMMjo1buMzimK
	 4VcbcaNZ+y7+5+s9mxB6+OCGP1ASUFmhr6uVHDEMtwL2p8L6X8bKXEeHaNQOO4luhRHFJ
	 gY08+bTQS45CZC/x0NW2dZfFlZABorKCZVJpxJbIwwKHxSQa6Fem+SWg7Y2bFwTBULw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="lZO/hFOo";
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9773C606A32A
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 11:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9773C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lZO/hFOo
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15ea896ddc8so3918776c88.0
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 03:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795348651; x=1795953451; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9xyDRYwKzhDIAxvZxSrhLQJBOdipiBNOceT03a+6U+w=;
        b=lZO/hFOoqCreh11b83OcTxz35MZYdO+/2f0/EIbdHJG6PwLo6rkxQh6Fk2WaoQI/Sl
         XECUhH3a0WtpySt+5gOS+muDVjAgt3rH5xjJqzzBVFBOq0M/s/LDmM+V1AjeD2ptrQfT
         6n7dudZaLSXdtISBGhQvBThheLDnyOL22riVBu66XY0wCUlJYL7WS2pJvWeDw8w4OiTU
         O+NY+0DdJu4uD3UXbbOiiQ8HCIhX6PeH5qaiT+T44JzMYpmKkzTwnUSdj5vZKIM9gVyu
         r6R8NHj6SNnsCsgPGkbr+VYAnNb/Gq+d00QCP5BhC7XFv25CLY3ObkkJoWPapscoQm+X
         zdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348651; x=1795953451;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9xyDRYwKzhDIAxvZxSrhLQJBOdipiBNOceT03a+6U+w=;
        b=wvxkRVc+2gDso0MiBI4UyabAABzCgzz3TrLr5kcfLjcx/+lVBYpriklDFCAXPYs4Yq
         j+/CJ546Dks9DUa2UQgQuOGhA1snuxT4cQZTABINwoceCZL5OwaLvBhD8Lsq8IHNTyf/
         B2Lhmb8BXeZZq08nh8v0vTYsxllZRKSx9hOZEQmjsxYd3VOusE1/TcsMlaHgv8LfRhlN
         lW9wXFNgbiqunVJ1GKz8FDQuBbwn2GN4LAbFD9ppC+JIwG3YPJU1FdluEyXJtVzMdxNt
         8waX2coW9BOC8Ogr1aQA5ugkNPkp9zKnIk6FgKD6/Y0JyEhxF40MfX2FRH2ZxSxVeopZ
         qlHQ==
X-Gm-Message-State: APuU4Z+NGaXNoP3HAB1I5QIRuv2UO+8El9k2J5SExVdbF84qc62wFxpC
	Kxhw4ZJ0T6KRhSrSThLUG0mY/nAJyXUcKBbFDYfMcmdBc5FTnQ04XwBJDnwVVQ==
X-Gm-Gg: AZFdTZfFtSFaqf9ROzngtnBDWUOYMnaBpSiL28d4JPj+sBTiUfmI+U/zwJMkA4h4bn5
	lZMx9BajsG+dDhLMQt/DlFpfrUnR0PTClWdlGrq0bv58pXdtqfp/oUNsw1lpvkgZ70keW7EyQPi
	9YS+hCcvM7Udq5UZrYNOBbNojloUNMgQkkHOZzMs/80+n0yE16/xhBgy6jfJzP1PmdabZu4jzUk
	Yg9y1lsLimN+O3Y1FejW52br3M5uICB3VoThaxX2nxSsvdr9eJDBuFfhGFF4cULptX4a8tlqI9X
	+VaaSLIx4lfzqZhXjSipMQLhN2dSxcDp9AUM7zaUzSuif252LEzGKTzc7DLGYF0A7QOGUH5NJjw
	Db4Q0OcCWp7vjfViOu8isbtJW+0oysQIi+/UN9/P8hX9tmV/DlfjmUw9YY3MR51Poo1RZQe2SPp
	Ie3fcwYyZ9Wwjb13Rw6gfeLBDWJhzdMApOlO3B719+QNY1uis4v2cbBA1HneIbkE8ryAkhV0RM1
	U8Td5eZIPumkqJLGwmTTygKqYO5c8vNixlcNOIrXbxnZ0TFzy9TkuuS3deytKWrur5UFdpHhw69
	PglBDX8ZD7++FVXUeE7B+bRhqRJbWrk4GnWYtCdFtvcZkf7c9jX7Yjo=
X-Received: by 2002:a05:7300:c72d:b0:369:f9c4:1fda with SMTP id 5a478bee46e88-38570845628mr8013754eec.27.1795348650481;
        Sun, 22 Nov 2026 03:57:30 -0800 (PST)
Received: from [127.0.0.1] ([20.184.150.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm28872916eec.14.2026.11.22.03.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:57:29 -0800 (PST)
Message-Id: <1169013f2e99f4b92b6c55ce4714d1103ad9db07.1795348644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Nov 2026 11:57:20 +0000
Subject: [PATCH v15 3/7] fetch: add remote.<name>.fetchRefmap
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

Looking up the remote-tracking branch for a remote branch, as
@{upstream} and "git branch --track" do, falls back to the refmap when
remote.<name>.fetch has no match, so that these work for such
branches too. A branch excluded by a negative refspec in
remote.<name>.fetch stays excluded.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |   9 ++
 Documentation/fetch-options.adoc |   3 +
 builtin/fetch.c                  |  22 +++--
 remote.c                         |  20 +++-
 remote.h                         |   6 ++
 t/t5510-fetch.sh                 | 154 +++++++++++++++++++++++++++++++
 6 files changed, 207 insertions(+), 7 deletions(-)

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
index 27f2ac6dc7..842bcc6fe5 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -250,6 +250,9 @@ endif::git-pull[]
 	refspecs and rely entirely on the refspecs supplied as
 	command-line arguments. See section on "Configured Remote-tracking
 	Branches" for details.
++
+`remote.<name>.fetchRefmap` provides the default value for this option, the
+same way `remote.<name>.fetch` provides the default refspecs to fetch.
 
 `-t`::
 `--tags`::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ccff0075c9..b83f9e5cc9 100644
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
@@ -628,10 +637,11 @@ static struct ref *get_ref_map(struct remote *remote,
 			tail = &ref_map->next;
 		}
 
-		if (refmap.nr) {
+		if (refmap.nr)
 			drop_destinations(ref_map);
-			map_refs_without_dst(ref_map, &refmap, &oref_tail);
-		}
+		if (effective_refmap)
+			map_refs_without_dst(ref_map, effective_refmap,
+					     &oref_tail);
 	}
 
 	if (tags == TAGS_SET) {
diff --git a/remote.c b/remote.c
index df069e802f..6a6e2717c1 100644
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
@@ -996,7 +1004,17 @@ void ref_push_report_free(struct ref_push_report *report)
 
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
index 412a5401a8..dd28639eac 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -944,6 +944,160 @@ test_expect_success '--refmap is not applied to a refspec with a destination' '
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

