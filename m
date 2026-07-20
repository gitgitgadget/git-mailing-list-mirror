Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE173D25CC
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538626; cv=none; b=qsVVp9OKBxYvo9i2hOm+QYtty9axhb3Iyi2h4hmOarccHChthu4xtPY6Gb364KdXnqdavGsbU+54xLVqPMve2TrwnQrC547l63BPJsUx6wkcvvzV4wJX5SXcoLHQGHnZ2yOPfC6q29/OjWdu6fP1svt2llCs2y0YyGuXDl45npM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538626; c=relaxed/simple;
	bh=Rp5/ko686Az9mv001x7152rfw3rBAUdTlVJOf2EaTCQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RcS25IzcagQfTFczVQDENg4B8MKKSlLPHYasA3VZZdS2sYJU+1u7cXcEsqOwnBd/jjQXs1IKSabIoBEq97ZT7J1rzK9Lt8BKfsuttuBD/xfgbvV9OZNrntkJRqGXPTovamtP/quV9CXRraXxOvl9uk2hPh1p24IGB5GtYtIihLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEipMgc4; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEipMgc4"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e99ef0902so695352385a.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784538624; x=1785143424; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3X04/0GCXjzYHAlBnOogw3+DhzMpoYJEOrG+f+RfKK4=;
        b=UEipMgc4ojDxWIrIru9+iDXsRf1QZmrf3EURu3dkuykHj+epO65yb3MsII8IyVxuJv
         3RsSQ+GzoDKw8Rb45lox8AA04akaCNNHPwizrbVeMHjYyP29//y+tn3V7fqVy5C5n56x
         MwOIf5DIC8w+ljictO90V/P0wsZnjeesiIrXOt3hNdXyG5JxDpG3q1INO+UGnBCfPXDZ
         gSbK+RmEZbaJHx3Pa4DpROOsHBFb+9RszHWm4pkfkkcMua9Ew6LWkNfkEzPknOiX5EMa
         ACsb26V4y+JjygDz12AzicZJ99oXi6j2CHRUpU+tzZQr5u6YHnCLs4Q5xrU3raSf6oui
         /B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784538624; x=1785143424;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3X04/0GCXjzYHAlBnOogw3+DhzMpoYJEOrG+f+RfKK4=;
        b=Vhu4cAshhcq5NxHFV7p0GG7QqrN9b9gqWXSjWUatNkO0bITlNzbvcqXEimT+07gpdf
         tgYF1HnDNVVVMMGIiasMAoRwXnbtoO0d++oUdFxe2toEoyMTHyDtoj30FRHw8fxxvT6q
         LVDlQ+O6R/SksA/bHFO1xJOUxnAcMqHN5uRyyd7Bo0kE7Zkb0QCUCts7Qzlg0eDXSgXA
         jRrPTlZgVi/tuL9q3APbNlUP5bu0+SwnN2Swi7EYHZHIoQNEt4Ow1Qqapsfv4QyjrXVh
         pQAC2Qi0d3sEnC92SZ+b9JjuwWIyYdR+z6EFwbyRFAghLsNcGsimsbLPn+1ECepgVKZZ
         neRQ==
X-Gm-Message-State: AOJu0YzvgHBAjS0sCzxJDCEUJ/NI/Bvr9x+3f5Lxs5kYDEU+Vgmy3UJj
	TXuc3zRCoZBSSmR7k0o19oVL5eBzFIhRWeRM+8ryLCxhnxMpiNHk1Lng01fBGw==
X-Gm-Gg: AfdE7cmYxAFzNwh4NMKN7ocUITizVTC2vgjYp/I3sHEh3W9vRMTSxBFRGSK6vanRcL4
	E2NALZ2JBeZCz1F4mX3uY+sAyAR0fcHdjM8mVLFsgPr6qDdW7rSHrIDxI8oomY//kY66H66Svfz
	x5J5NbNhZkLc2rd7y2ZIZyN4037OA2bH727Ed//KLIRsmLgN/ARBrtL0V4Z9fCRZijBs1KBkSuH
	0YBLUkfxnGtMeAzUAxtv+csX8qJxwuSmfdKt2rzw1FFjp8JBr8VavkyneKwAG+VsvohTSI7GDaE
	fbhaFw8wv0CXF5B3RJpWnk6TI2za0arCt1X24ppMW7/1GYr1chkGdteMgqsg1uvnltuep2Kwj9R
	Hj+tZSioa9pP41cYUmWV7dL23WRunyKZpgJ+OX0QoUdQjr2TiCS9qRUUWK20TtKyaliwvngLufp
	D3DgM=
X-Received: by 2002:a05:620a:45a4:b0:930:af44:c3f6 with SMTP id af79cd13be357-930b416db87mr1280140885a.43.1784538623445;
        Mon, 20 Jul 2026 02:10:23 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.37.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b5494c02sm835959685a.45.2026.07.20.02.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:10:21 -0700 (PDT)
Message-Id: <ff645b21591a4b365b30acaf67a295510889141c.1784538618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2358.git.git.1784538618.gitgitgadget@gmail.com>
References: <pull.2358.git.git.1784538618.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Jul 2026 09:10:18 +0000
Subject: [PATCH 2/2] remote: resolve URL-valued push tracking remotes
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A branch may name its push destination with a URL instead of a
configured remote. This is useful in fork workflows, where the original
remote is renamed to "upstream", the fork is added as "origin", and an
existing branch.<name>.pushRemote continues to contain the fork URL.

Git can still push through the anonymous remote created for that URL.
However, the anonymous remote has no fetch refspec. Git therefore cannot
resolve @{push} to origin/<branch> or update that remote-tracking branch
after a push. The push can succeed, or report that everything is up to
date, while status continues to compare against a stale tracking ref or
cannot show the push branch at all.

A uniquely matching configured remote already provides the missing
mapping. Use its fetch refspec when resolving the push tracking branch
and when updating tracking refs after a push. This changes neither the
push destination nor configuration. Keep the existing behavior when no
remote matches or multiple remotes share the URL, since either case is
ambiguous.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/revisions.adoc |   3 +
 remote.c                     |  27 ++++++++-
 remote.h                     |   2 +
 t/t5505-remote.sh            | 104 +++++++++++++++++++++++++++++++++++
 transport.c                  |   5 +-
 5 files changed, 139 insertions(+), 2 deletions(-)

diff --git a/Documentation/revisions.adoc b/Documentation/revisions.adoc
index 6ea6c7cead..b691691c8c 100644
--- a/Documentation/revisions.adoc
+++ b/Documentation/revisions.adoc
@@ -127,6 +127,9 @@ some output processing may assume ref names in UTF-8.
   `git push` were run while `branchname` was checked out (or the current
   `HEAD` if no branchname is specified). Like for '@\{upstream\}', we report
   the remote-tracking branch that corresponds to that branch at the remote.
+  If the push remote is specified as a URL, the fetch refspec of a uniquely
+  matching configured remote is used to find and update the remote-tracking
+  branch.
 +
 Here's an example to make it more clear:
 +
diff --git a/remote.c b/remote.c
index 89d0f9e2d8..03908dfe8d 100644
--- a/remote.c
+++ b/remote.c
@@ -1887,13 +1887,38 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
 	return branch->merge[0]->dst;
 }
 
-static char *tracking_for_push_dest(struct repository *repo UNUSED,
+struct remote *repo_remote_for_push_tracking(struct repository *repo,
+					     struct remote *remote)
+{
+	struct remote *first_match = NULL;
+	struct remote_state *remote_state = repo->remote_state;
+
+	if (remote->origin != REMOTE_UNCONFIGURED || remote->url.nr != 1)
+		return remote;
+
+	for (int i = 0; i < remote_state->remotes_nr; i++) {
+		struct remote *candidate = remote_state->remotes[i];
+
+		if (!candidate || candidate == remote ||
+		    !remote_is_configured(candidate, 0) ||
+		    !remote_has_url(candidate, remote->url.v[0]))
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
index e592c0bcde..e16b3f320a 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -24,6 +24,28 @@ setup_repository () {
 	)
 }
 
+setup_url_pushremote () {
+	rm -rf fork.git client &&
+	git clone --bare one fork.git &&
+	git clone one client &&
+	fork_url="$TRASH_DIRECTORY/fork.git" &&
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
@@ -1018,6 +1040,88 @@ test_expect_success 'rename a remote renames repo remote.pushDefault but keeps g
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
+test_expect_success 'adding fork remote makes URL-valued pushRemote trackable' '
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
