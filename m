Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19BD4399F7
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743750; cv=none; b=ckT1jfjvxvtnBWVUoS6DTEre2CjTJxkaTrxzZ3G8Z/jE59Vls79UHAiDqga/cjLJiyzxa8rT280FnR7YpJsMcWshOHFd9X6dvSn6HrSIOyhQ8vcBh1m9QyBHFz34O/RLYbQImXqGHeD2KyBzMFhPUwYN61FKN+Lz6i4Lkl7de9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743750; c=relaxed/simple;
	bh=WhaqEWgAKMLW0KI4z6y0/ZInz4HWxBWXO7FSlyYVtBk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MsXfUOggtjcrQjGm3ElXFLifCeo7MeD+Eno+CsAG/e9Cijs4BEKKpoyUYUWiKLYgSOcBsQzd28igRRPHcchZIXnyeib0pNXhaEOuOnMhPejjXxzse+MHFSMpRX+mKOKJ9FvotMV1P/OJUqfO3z/cV+NTn1AbHMorsCsbIUjni+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zluq5yjB; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zluq5yjB"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-caf707e3a70so4101354a12.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784743745; x=1785348545; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G9b6oJMOXzl8p9/xbYDTgCt3PaIEKBJXtdqiBCIHvFs=;
        b=Zluq5yjB8h/NE7IDSUE/mL54/Tptlx+27t8OqpPPgt+wOzb5ez097MommV5kmtFdNk
         7fpXoxuqdYzZW8IC8zSCsX+/cyezoQc5INMQrdBilsq3rnl1U5d7tDHsX40yfsGOdBVz
         +rTSDuYXWQukvasbeTrMzsQBP1ok1K8x9MThLD7hFQw7StJu6bWMoFVnTH/ob6zji+Bc
         YJ9N9SZeWNCrNWPOf1yw1fxXwTP82VAKPMx0lF4F9u5sde1oVIR87smDDzLLtpdGIMsL
         XziaceJs44XL2uTmm/SyVkVAc6t9EA0dfdtgjIqU8dG2mdCK9Ki+NWn3DFjKBgWBPLRA
         ycAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784743745; x=1785348545;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G9b6oJMOXzl8p9/xbYDTgCt3PaIEKBJXtdqiBCIHvFs=;
        b=LGQJFiksRihh4p6WkL+QfSdw2fu1ubkHUztrgwPDxon06Yu4AiErp0PEXbXJXxWRwL
         yvTrNgy/uYeia5ZrMgYl2cOqq2hkrpdDKg8E7Wc2v++NiGmuQzfM4bXZn37W96kDUlEs
         qzuMrMhbA46jbMtBGzmMJ60wWIQsUepNMrTp3vLPRinWfDxc4C1zKahrIc869dDcb3VX
         IzZm5kZkU64tsUwaQszD99RgjW6hFa4Z+vnJuFqfdwE0ZVttvJjwu1EjvUeXQjWwbEtz
         5lFSymCAYVPP5+D85SPhUGP/lG7ZnF7X4SGtcT7J/CZLUUi722h3bW/1YwzAsueZ9AHs
         RD8w==
X-Gm-Message-State: AOJu0YyvRkwquzc7Sgb1dfFfFe/UJ/5Zx7yUWpS2dbpDWKCNfdQlfkFg
	ObIb0Si+nWTthz17pdzuQasfkYy6xxeJ1fONE7yUmuaqoK2RApQ7f7czc7pwQRnA
X-Gm-Gg: AR+sD10LVKpl1jHdF5s79T+BT+Yl41J+6WMb5oA4eVYiKbjI4bypLuPytiE9RuO6mFd
	XBp0FPSKXy8rOSHcVTB6DyePkQe8PmcYNbJ3EktTIBGb+anrckneCoy6/kWGVhvt02D163iN/zv
	RzhuGc8ycBWGG6Bg37jiSXzqyugjmJHwGL3XtOXOZooGS2eBq8NVmEFFSAP4nlvsn9cbwuqHGA7
	XGr9sC2vAfb4f1JfU3PCXx9voo7zmC5it92HR9wUe2K3zWls+xn0wu5VtI5dQ3Gu/APpCm4bYFN
	ob4+OnMbiAVnEwCIPqjjy0VuunvihvL8WkqKLSmKMHgDPBir76TgbwcCJPAW9eC8zCIR8WW0ffE
	CMA7aJqbmLnE3o9M8NpY3iuWkFs3pEieX7FtuW/9LI5WHKpE+O1lQI+AxL/RXdG5q8clxbXwB5Z
	37cxqRm2bYL4/ExyA=
X-Received: by 2002:a05:6a20:2d21:b0:3bf:aa54:4cbc with SMTP id adf61e73a8af0-3c4294a6909mr5845292637.26.1784743745466;
        Wed, 22 Jul 2026 11:09:05 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.221.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e0818e4sm11538092eec.22.2026.07.22.11.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:09:04 -0700 (PDT)
Message-Id: <08c432a2d4f52c202a2bebaa72330a17e94aedd1.1784743738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2358.v4.git.git.1784743738.gitgitgadget@gmail.com>
References: <pull.2358.v3.git.git.1784664859.gitgitgadget@gmail.com>
	<pull.2358.v4.git.git.1784743738.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Jul 2026 18:08:58 +0000
Subject: [PATCH v4 2/2] remote: find tracking branches for URL push
 destinations
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Git accepts a repository URL as branch.<name>.pushRemote and can push
to it. This branch setting takes precedence over remote.pushDefault.

A branch can be configured with a URL-valued pushRemote before any push
occurs. If the remotes are later rearranged with "git remote rename" and
"git remote add", the newly added remote may use that URL. The URL value
is unaffected by the rename and continues to take precedence over
remote.pushDefault. The URL and the remote then point to the same
repository, but Git does not connect them for tracking. Pushing works,
but @{push} cannot identify the remote's tracking branch. As a result,
"git status" cannot show the push branch, and an up-to-date push can
leave its tracking information stale.

When exactly one configured remote would push to the same URL, use that
remote for push tracking. Continue to push to the URL so the configured
remote's push settings do not change existing behavior. Keep the current
behavior when no remote matches or multiple remotes match.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |   1 +
 Documentation/revisions.adoc     |   3 +
 remote.c                         |  45 +++++++++-
 remote.h                         |   2 +
 t/t5505-remote.sh                | 144 +++++++++++++++++++++++++++++++
 transport.c                      |   5 +-
 6 files changed, 198 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..5a85fde8de 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -55,6 +55,7 @@ This option defaults to `never`.
 	repository), you would want to set `remote.pushDefault` to
 	specify the remote to push to for all branches, and use this
 	option to override it for a specific branch.
+	The value may be the name of a configured remote or a repository URL.
 
 `branch.<name>.merge`::
 	Defines, together with `branch.<name>.remote`, the upstream branch
diff --git a/Documentation/revisions.adoc b/Documentation/revisions.adoc
index 6ea6c7cead..3fbfbd3d5f 100644
--- a/Documentation/revisions.adoc
+++ b/Documentation/revisions.adoc
@@ -127,6 +127,9 @@ some output processing may assume ref names in UTF-8.
   `git push` were run while `branchname` was checked out (or the current
   `HEAD` if no branchname is specified). Like for '@\{upstream\}', we report
   the remote-tracking branch that corresponds to that branch at the remote.
+  If the push destination is a URL and exactly one configured remote uses
+  that URL for pushing, '@\{push}' reports that remote's remote-tracking
+  branch.
 +
 Here's an example to make it more clear:
 +
diff --git a/remote.c b/remote.c
index 0dc36956c3..3a6abf1258 100644
--- a/remote.c
+++ b/remote.c
@@ -954,6 +954,17 @@ struct strvec *push_url_of_remote(struct remote *remote)
 	return remote->pushurl.nr ? &remote->pushurl : &remote->url;
 }
 
+static bool remote_has_push_url(struct remote *remote, const char *url)
+{
+	const struct strvec *push_urls = push_url_of_remote(remote);
+
+	for (size_t i = 0; i < push_urls->nr; i++) {
+		if (!strcmp(push_urls->v[i], url))
+			return true;
+	}
+	return false;
+}
+
 void ref_push_report_free(struct ref_push_report *report)
 {
 	while (report) {
@@ -1887,13 +1898,45 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
 	return branch->merge[0]->dst;
 }
 
-static char *tracking_for_push_dest(struct repository *repo UNUSED,
+struct remote *repo_remote_for_push_tracking(struct repository *repo,
+					     struct remote *remote)
+{
+	const struct strvec *push_urls;
+	struct remote *first_match = NULL;
+	struct remote_state *remote_state = repo->remote_state;
+	const char *check_url;
+
+	if (remote->origin != REMOTE_UNCONFIGURED)
+		return remote;
+
+	push_urls = push_url_of_remote(remote);
+	if (push_urls->nr != 1)
+		return remote;
+	check_url = push_urls->v[0];
+
+	for (int i = 0; i < remote_state->remotes_nr; i++) {
+		struct remote *candidate = remote_state->remotes[i];
+
+		if (!candidate || candidate == remote ||
+		    !remote_is_configured(candidate, 0) ||
+		    !remote_has_push_url(candidate, check_url))
+			continue;
+		if (first_match)
+			return remote;
+		first_match = candidate;
+	}
+
+	return first_match ? first_match : remote;
+}
+
+static char *tracking_for_push_dest(struct repository *repo,
 				    struct remote *remote,
 				    const char *refname,
 				    struct strbuf *err)
 {
 	char *ret;
 
+	remote = repo_remote_for_push_tracking(repo, remote);
 	ret = apply_refspecs(&remote->fetch, refname);
 	if (!ret)
 		return error_buf(err,
diff --git a/remote.h b/remote.h
index 72a54d84ad..cca02033b9 100644
--- a/remote.h
+++ b/remote.h
@@ -345,6 +345,8 @@ char *remote_ref_for_branch(struct branch *branch, int for_push);
 
 const char *repo_default_remote(struct repository *repo);
 const char *repo_remote_from_url(struct repository *repo, const char *url);
+struct remote *repo_remote_for_push_tracking(struct repository *repo,
+					     struct remote *remote);
 
 /* returns true if the given branch has merge configuration given. */
 int branch_has_merge_config(struct branch *branch);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 6f5e86dede..9c2f140d5a 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -24,6 +24,28 @@ setup_repository () {
 	)
 }
 
+setup_url_pushremote () {
+	rm -rf fork.git client &&
+	git clone --bare one fork.git &&
+	git clone one client &&
+	fork_url="file://$TRASH_DIRECTORY/fork.git" &&
+	(
+		cd client &&
+		git checkout -b topic --track origin/main &&
+		git commit --allow-empty -m topic-change &&
+		git config push.default current &&
+		git config status.compareBranches "@{upstream} @{push}" &&
+		git config branch.topic.pushRemote "$fork_url" &&
+		git push
+	)
+}
+
+check_status () {
+	git -C client status >actual &&
+	cat >expected &&
+	test_cmp expected actual
+}
+
 tokens_match () {
 	echo "$1" | tr ' ' '\012' | sort | sed -e '/^$/d' >expect &&
 	echo "$2" | tr ' ' '\012' | sort | sed -e '/^$/d' >actual &&
@@ -1018,6 +1040,128 @@ test_expect_success 'rename a remote renames repo remote.pushDefault but keeps g
 	)
 '
 
+test_expect_success 'URL-valued pushRemote without matching remote is not trackable' '
+	setup_url_pushremote &&
+
+	check_status <<-EOF
+	On branch topic
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+'
+
+test_expect_success 'adding matching remote makes URL-valued pushRemote trackable' '
+	setup_url_pushremote &&
+
+	(
+		cd client &&
+		git remote rename origin upstream &&
+		git remote add -f origin "$fork_url"
+	) &&
+
+	check_status <<-EOF
+	On branch topic
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	Your branch is up to date with ${SQ}origin/topic${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+'
+
+test_expect_success 'configured pushurl makes URL-valued pushRemote trackable' '
+	setup_url_pushremote &&
+
+	(
+		cd client &&
+		git remote rename origin upstream &&
+		git remote add -f origin ../fork.git &&
+		git remote set-url --push origin "$fork_url"
+	) &&
+
+	check_status <<-EOF
+	On branch topic
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	Your branch is up to date with ${SQ}origin/topic${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+'
+
+test_expect_success 'pushInsteadOf URL pushRemote is trackable' '
+	setup_url_pushremote &&
+	(
+		cd client &&
+		git remote rename origin upstream &&
+		git remote add -f origin "$fork_url" &&
+		git config "url.$fork_url.pushInsteadOf" fork: &&
+		git config branch.topic.pushRemote fork:
+	) &&
+
+	check_status <<-EOF
+	On branch topic
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	Your branch is up to date with ${SQ}origin/topic${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+'
+
+test_expect_success 'up-to-date URL push refreshes stale tracking branch' '
+	setup_url_pushremote &&
+	(
+		cd client &&
+		git remote rename origin upstream &&
+		git remote add -f origin "$fork_url" &&
+		git commit --allow-empty -m another-topic-change &&
+		git -C ../fork.git fetch ../client topic:topic
+	) &&
+
+	check_status <<-EOF &&
+	On branch topic
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 2 commits.
+
+	Your branch is ahead of ${SQ}origin/topic${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+
+	git -C client push >actual 2>&1 &&
+	test_grep "Everything up-to-date" actual &&
+
+	check_status <<-EOF
+	On branch topic
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 2 commits.
+
+	Your branch is up to date with ${SQ}origin/topic${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+'
+
+test_expect_success 'duplicate remote URL leaves URL-valued pushRemote ambiguous' '
+	setup_url_pushremote &&
+	(
+		cd client &&
+		git remote rename origin upstream &&
+		git remote add -f origin "$fork_url" &&
+		git remote add duplicate "$fork_url"
+	) &&
+
+	check_status <<-EOF
+	On branch topic
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+'
+
 test_expect_success 'rename handles remote without fetch refspec' '
 	git clone --bare one no-refspec.git &&
 	# confirm assumption that bare clone does not create refspec
diff --git a/transport.c b/transport.c
index fc144f0aed..30a4ab2cd5 100644
--- a/transport.c
+++ b/transport.c
@@ -1553,8 +1553,11 @@ int transport_push(struct repository *r,
 	if (!(flags & (TRANSPORT_PUSH_DRY_RUN |
 		       TRANSPORT_RECURSE_SUBMODULES_ONLY))) {
 		struct ref *ref;
+		struct remote *tracking_remote = repo_remote_for_push_tracking(
+			r, transport->remote);
+
 		for (ref = remote_refs; ref; ref = ref->next)
-			transport_update_tracking_ref(transport->remote, ref, verbose);
+			transport_update_tracking_ref(tracking_remote, ref, verbose);
 	}
 
 	if (porcelain && !push_ret)
-- 
gitgitgadget
