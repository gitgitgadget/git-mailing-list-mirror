Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959925;
	b=q7RcQ1xWvJNM4Wpk8airn0/jK3boM7lQi2pGDS0DrUu0kEmiIpk4cvCRxklW2Ba29ljA
	 T8JgL1K5CsS2MwPYxrYcyRoqCjAKu3YVO+Xh6QLAkiMJDM3arxUi+LyN4Cy9Z7p7g2OB0
	 GP5ANIG5QXKNupIX9cgzYbnSyvc3z2yNkqZhwqGol2G5DGjfBxNi3tfD7e3bwR1w23VXH
	 Sp3HKPlnzIEkwZEBxfJyBxU2cX2onOuPLsVo72/gN6pROSUoT5r3oSi5hzWkHNOOT9JGx
	 PksmsFIK3L2JBVLaHZf73mMatswfSDZemG/PaGyN9b1oON+1ewCxRu6yYtoq/HzWvaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=giU1U/BDeVZGEANWhNPP4Z/9rOBh/W3KFD4iFzi6xwQ=;
	b=mH5sCf9dbk9LXcCdljFYm245MeMnUIe2hP+mftVX7zkipfbI6GtNzLcRXyp2xylNDqbx
	 shYMrp/cgdh7a/3xdGIQ8C1DhUh4ntStUOgUy8CZd7Z99uxpMb8CSkM4Tc5+LWZiUJTi4
	 4xunsWfL5zxa/a8AkvW7PGR0yP0FwVNOOM+BjxmkcCmyQZQglk75XWhwsZN6NUT4QlBvT
	 fnEhSF4qHyibAKlkYEr9KjZFGZFF+uBgqk8fR2SLsAA5uYNiEPT5ZhHvTRWo30A6dcjWN
	 AqAgz6EqoIVGMjYIV7jyzH7vpSDMs+8mel6ph5kyEw4Z36Qm3qjvYfed5bsMkbBXQIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kwGdLwZD;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D0E606A31F
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 20:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9D0E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kwGdLwZD
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-369f33df08eso1613499eec.0
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792959924; x=1793564724; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=giU1U/BDeVZGEANWhNPP4Z/9rOBh/W3KFD4iFzi6xwQ=;
        b=kwGdLwZDB8RRyEkON2tYWFE/m/gFg6k0oY0oOLJO7CcUw4R2leqDnA9gVZ3BLBTz7s
         /gDcvLb28feF7zdy0ZPlAE/sCQrt91FBHxygOXGFIJUvgCKEmwdRD26zxppPrEl+ytOT
         WLlXbt2expgnHTWZTYg3d3YclqHsKzoZrb9wIPsOIyvSjovQMi33aqL80Ql2CbImYu5C
         IxeKEszbOXWsrqvHnZgkh77Rk/rMSWGu9KoOB0spN7R2QmLSTshR2g+SpKbC8QmVkaYd
         EBxcdgWCODMBCmhGdbVySy/pZUasf3kybQDG5MJqQX0zcaoUm7GFAfg0QIKercpCJ1Yk
         p/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959924; x=1793564724;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=giU1U/BDeVZGEANWhNPP4Z/9rOBh/W3KFD4iFzi6xwQ=;
        b=kpBq1D6/kLky8e81G1mLRnTygz5n36E/bH21yI1FbJmgfhlmc0rZnlZGjktM480V3t
         9uAYZgS8Su82CZ9uKbMXyz8dEYEm8LjxC0Rxm7y58lER2tbgGOaI1RWS+a9v25H7dEDc
         +vsI6c3RyWAJ3drSQFPXrhsPYaNcwyDx6r/78LhmXf63kSsWVsYq40IBZVEubs8s2AXc
         tPhOffh1YExr1/g7ojN3knEIaOjIoZvH/wTijyyQ81r9W1TzNjirulbI9bwdt5Us8Iu0
         yIRb1tIQ6qnDEr5UuIut1fCOSpIAMabvAYujZXu7UdcwNmKJ/PJoogPhIEBGGPZrnKV9
         tCvw==
X-Gm-Message-State: AFq9FYKzjpaZZpry650PkIIW27mDpyBAtfK1NkfHrLKBU+qdvnqs49za
	z17LK+j5PSNx+0F73av6mxP4fNKFqjiVp3+3urVcagMVJGVllq7MxUoBlLH/ZWUeSSI=
X-Gm-Gg: AYBFou0z3jDfS37UM9zbj5bTXM/K7xIzdL8mBn5vlQzdCmg9RgLuUyVEd2Mw5VucKH2
	ibqvWsNCJchJdmr3LLYHsyTeFymIPLSqdZnny8EaS7+Gs1St76tSBEq6nkwPpIUDRQw51I2a9oK
	s2FmXEIpi74Nup6ga3KzX9iBPDfpT3RNM3w07eBSJuGggzFyT2kOLQlVNIjfdm0LzMmQHblHxfB
	SNrPquY3AnbkFm9bJ7PCW1TJYNhQueDsm0evo2OI5Po1hkeG/fFMw+oIhhDWok25nZyuLYu2eJt
	URlTFejNLM9koEmifVBIBjVFrq8O8dd2E6TLBjIDZ0fBGaNvZzbHsF2uaI+Mml+3ZcCjcwb6VDp
	2/AQL/s88/a5pmCAwswtzRzR1w6//89bUugGsBjxIlO2XloCb2OSJ9oKYG7o1f4LH2FrNOhoHZZ
	8ZyAqLjfQT+AHEpYoWlerjtmWQwiJLe3gld+WZSwcClU73VPdn8YswOJF1apsEbbjkbG9FjsOVa
	moEoUc6+GWYJOoH4rxjE5tpgNI9qxjk+aYZP4sM0P9xsNN/ExMkXrcW
X-Received: by 2002:a05:7301:4303:b0:368:2548:c08d with SMTP id 5a478bee46e88-369e863bdd5mr7765513eec.25.1792959923538;
        Sun, 25 Oct 2026 13:25:23 -0700 (PDT)
Received: from [127.0.0.1] ([4.242.195.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ef6a71a4sm17294042eec.8.2026.10.25.13.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:25:22 -0700 (PDT)
Message-Id: <d66b3c0bb1b04c59412b80eba8be50c30c934f14.1792959921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v11.git.git.1792959921.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v11.git.git.1792959921.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 Oct 2026 20:25:17 +0000
Subject: [PATCH v11 1/5] fetch: add remote.<name>.refmap
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

Add a per-remote config variable, remote.<name>.refmap, that provides
the default value for --refmap the same way remote.<name>.fetch
already provides the default refspecs to fetch. Like --refmap itself,
it only maps refs that are actually being fetched, so it has nothing
to do when there is nothing explicit to fetch, on the command line or
via remote.<name>.fetch.

A refspec-less fetch with a refmap configured but nothing else to say
what to fetch falls back to the same defaults as a remote with no
refspec or refmap at all. Only an explicit --refmap given on the
command line with no command-line refspec to go with it is still
rejected, since that combination is a plain mistake to type, unlike a
remote.<name>.refmap configured on its own. A remote.<name>.fetch
that is also configured is used as before.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |   5 ++
 Documentation/fetch-options.adoc |   3 +
 builtin/fetch.c                  |  10 ++-
 remote.c                         |  20 +++++-
 remote.h                         |   6 ++
 t/t5510-fetch.sh                 | 101 +++++++++++++++++++++++++++++++
 6 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 3a20d0f752..103eada406 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -33,6 +33,11 @@ remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
 
+remote.<name>.refmap::
+	The default value of the `--refmap` option for linkgit:git-fetch[1].
+	Used to map remote refs being fetched to remote-tracking refs to
+	store. See the `--refmap` entry in linkgit:git-fetch[1].
+
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 47dea1de8e..c2101a7b39 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -244,6 +244,9 @@ endif::git-pull[]
 	refspecs and rely entirely on the refspecs supplied as
 	command-line arguments. See section on "Configured Remote-tracking
 	Branches" for details.
++
+`remote.<name>.refmap` provides the default value for this option, the
+same way `remote.<name>.fetch` provides the default refspecs to fetch.
 
 `-t`::
 `--tags`::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1f76ae6242..ffcb5ba29a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -518,6 +518,12 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct ref *rm;
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
+	/*
+	 * The --refmap command line option, if given, takes precedence
+	 * over remote.<name>.refmap.
+	 */
+	struct refspec *effective_refmap =
+		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
@@ -561,8 +567,8 @@ static struct ref *get_ref_map(struct remote *remote,
 		 * by ref_remove_duplicates() in favor of one of these
 		 * opportunistic entries with FETCH_HEAD_IGNORE.
 		 */
-		if (refmap.nr)
-			fetch_refspec = &refmap;
+		if (effective_refmap && effective_refmap->nr)
+			fetch_refspec = effective_refmap;
 		else
 			fetch_refspec = &remote->fetch;
 
diff --git a/remote.c b/remote.c
index 49ee2ea318..06c61bbc5f 100644
--- a/remote.c
+++ b/remote.c
@@ -152,6 +152,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	ret->name = xstrndup(name, len);
 	refspec_init_push(&ret->push, the_hash_algo);
 	refspec_init_fetch(&ret->fetch, the_hash_algo);
+	refspec_init_fetch(&ret->refmap, the_hash_algo);
 	string_list_init_dup(&ret->server_options);
 	string_list_init_dup(&ret->negotiation_restrict);
 	string_list_init_dup(&ret->negotiation_include);
@@ -176,6 +177,7 @@ static void remote_clear(struct remote *remote)
 
 	refspec_clear(&remote->push);
 	refspec_clear(&remote->fetch);
+	refspec_clear(&remote->refmap);
 
 	free((char *)remote->receivepack);
 	free((char *)remote->uploadpack);
@@ -539,6 +541,12 @@ static int handle_config(const char *key, const char *value,
 			return -1;
 		refspec_append(&remote->fetch, v);
 		free(v);
+	} else if (!strcmp(subkey, "refmap")) {
+		char *v;
+		if (git_config_string(&v, key, value))
+			return -1;
+		refspec_append(&remote->refmap, v);
+		free(v);
 	} else if (!strcmp(subkey, "receivepack")) {
 		char *v;
 		if (git_config_string(&v, key, value))
@@ -995,7 +1003,17 @@ void ref_push_report_free(struct ref_push_report *report)
 
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
index 17c0be499c..994327c55b 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -927,6 +927,107 @@ test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
 	)
 '
 
+test_expect_success 'remote.*.refmap acts like --refmap on the command line' '
+	test_when_finished "git -C three config --unset remote.origin.refmap" &&
+	git branch -f side &&
+	git -C three config remote.origin.refmap \
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
+test_expect_success 'remote.<name>.refmap without tracking (baseline)' '
+	test_when_finished "rm -fr fetch-refmap-baseline fetch-refmap-upstream" &&
+	git init -b main fetch-refmap-upstream &&
+	test_commit -C fetch-refmap-upstream base &&
+	git -C fetch-refmap-upstream branch other &&
+	git init fetch-refmap-baseline &&
+	(
+		cd fetch-refmap-baseline &&
+		git remote add origin ../fetch-refmap-upstream &&
+
+		# Without fetch refspec, but with fetch refmap.
+		git config --unset-all remote.origin.fetch &&
+		git config remote.origin.refmap "+refs/heads/*:refs/remotes/origin/*" &&
+
+		# Nothing tracked, nothing fetched, no error.
+		git fetch origin &&
+		check_fetched_refs <<-\EOF &&
+		EOF
+
+		# Nothing tracked, explicit ref on the command line.
+		git fetch origin main &&
+		check_fetched_refs <<-\EOF &&
+		refs/remotes/origin/main
+		EOF
+
+		# With both refmap and fetch configured, remote.<name>.fetch
+		# wins: a refspec-less fetch follows it as usual, and
+		# remote.<name>.refmap plays no part in deciding what to
+		# fetch, only in remapping something that is already being
+		# fetched by name.
+		git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
+		git fetch origin &&
+		check_fetched_refs <<-\EOF
+		refs/remotes/origin/HEAD
+		refs/remotes/origin/main
+		refs/remotes/origin/other
+		EOF
+	)
+'
+
+test_expect_success 'remote.<name>.refmap tracks a branch outside remote.<name>.fetch' '
+	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
+	git init -b main fetch-refmap-upstream &&
+	test_commit -C fetch-refmap-upstream base &&
+	git -C fetch-refmap-upstream branch other &&
+	git init downstream &&
+	(
+		cd downstream &&
+		git remote add -t main origin ../fetch-refmap-upstream &&
+		git config remote.origin.refmap "+refs/heads/*:refs/remotes/origin/*" &&
+		git fetch origin other &&
+		git branch --track topic origin/other &&
+		test_cmp_config origin branch.topic.remote &&
+		test_cmp_config refs/heads/other branch.topic.merge &&
+		echo refs/remotes/origin/other >expect &&
+		git rev-parse --symbolic-full-name topic@{upstream} >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'remote.<name>.refmap does not track a branch excluded by remote.<name>.fetch' '
+	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
+	git init -b main fetch-refmap-upstream &&
+	test_commit -C fetch-refmap-upstream base &&
+	git -C fetch-refmap-upstream branch secret &&
+	git init downstream &&
+	(
+		cd downstream &&
+		git remote add origin ../fetch-refmap-upstream &&
+		git config --add remote.origin.fetch "^refs/heads/secret" &&
+		git config remote.origin.refmap "+refs/heads/*:refs/remotes/origin/*" &&
+		git fetch origin secret &&
+		git rev-parse --verify refs/remotes/origin/secret &&
+		test_must_fail git branch --track topic origin/secret 2>err &&
+		test_grep "not a branch" err
+	)
+'
+
 test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
 	git branch -f side &&
 	(
-- 
gitgitgadget

