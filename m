Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333EF357739
	for <git@vger.kernel.org>; Tue,  5 May 2026 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965758; cv=none; b=Bd1hFDcnn/sCWyM3EvUFO6ir8ZU3o+WmidwL2PN0GnRvTvdXBa1wHPvYfTb/GeMOOUnFt8aj83BmJGRflB9P1KZ3XCeBi3rxZp/Qul93tvo+qvZDx7O/he8NmJBxEOTnKuVENyrOTsn5YNmgYyEk7ztQWPNR6rWx6z9D1eN9oXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965758; c=relaxed/simple;
	bh=FeEE58wvSeuiaYA8aqR8wg3V0MSqOiAOLOWEcISGcWI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gUUz4OrVu8BRDO/RC3Ac+2N2Uw/YSsXWFXQGCQaKGeNCg9DKG66PAlQSwB/uZWiO2ixlERCLXSBtOxLktlM/w5G37lF7cVs1HTRmHhrFaHOIbceNwQgQm+kVicbQX6UfAE3dqS/g+FjvkB7x/gZT37da9qWDPAFilb1NiUlqNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/KeeNXj; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/KeeNXj"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d560ede296so528718285a.0
        for <git@vger.kernel.org>; Tue, 05 May 2026 00:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777965756; x=1778570556; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6M91F2cvEQpDh0TyGm5aygup8ivoZjO+KDlN8ekD80Q=;
        b=T/KeeNXjj9ey/HjLLmGMZXfwsUcpP8iXN3YekCJLgnKSR8f5h5+SNU+93rM5QqaSQu
         DImnBKww414fcDoN7Un6hv3hfbTDBYFXp+M81lLU0ZscCTZywvBSVwFEou53jFrsFVVL
         ysuDAJ+i5ut95tsCB4YqQnWBiipfXgduH2g0vfapmQ+VqjtqjLr8tnlfwTiT91L45HWc
         XCwz5EbRV/c2/0GpTYNEb3KojKm+6PyOePF7x0IMD2S5UVWezaTgToixXfMGcN0FFaJT
         TGk07tc5wfXvHcs8DG6esjOEkrQSXH6lPmJ3Q73H9gorvBALrw4PQ/0qTqjKDbEJmTA6
         OUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965756; x=1778570556;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6M91F2cvEQpDh0TyGm5aygup8ivoZjO+KDlN8ekD80Q=;
        b=sWU2q+Pl2FQsQEWdQ0peqIakQMPvVb89/tlSq66QpNaWurn+R8vP0Bz+bfGctdBJcK
         LAS/QS6m0WYrjiEPRC7aIqf2pQVid9b2deBiuK6z1ztk2w8WIdQUxjKG43SsAk/FkiOe
         6hGBY5k0/XM4+zsvCoxSAbsjYZRDdFBSHz5u7McAUgwL/H2im7Mmznad3Vkv86gnMisB
         BmIXNUZbDzMUkSylkrtzfRxdu4IXKqcswgoLuQtOtk/15CrH7Uv/SYnLBuQrTCmbCHQ0
         jrhNC9RGnz74EmJ+OHaXJtifoUr6Cbp5lrkl8JIAmY4FpPodNIQff4KOCclZtOEHJB3z
         kFKA==
X-Gm-Message-State: AOJu0Yybs3lHUSQW+luhcwHUCERBczPf74LRoqEHVkeYIogLw+eHozke
	DIB/h8/Xz9kWMXSvr7Y3PaIQvOSiWQlq5/4zuyKJlLOkFimJ87lSB1DNFOLcH4Fs
X-Gm-Gg: AeBDievNGk4qq/qCOKCmuB42b30b8Khlug5fr3QZlydbJ6DOWax9l/bwdRdNyEejy+x
	QOfdhc8mKCSAJ1ji9hOTXIwWjEE6u5M7N133MecDeRmOabRFH9BnFhdmBfdHQC7eUA/LuI7mkCW
	xN50kdWQriEh3r7nSQ4Sz5XbwjX+tDvaB7ZpBwGvjMFN9dsRdKgQnauPtL6Hk0yrtkmZwTy1rNO
	OeKCruw8ngqbrHpbzjoiB/NxpMPBod4UpmjY2xLswAqhXdCnJIxjfTtFj4sDaJIJfV1mwnpbYXe
	6SkeSyIcAnjEfaAh45MHF7gnIOoGyB8WBnhKeUpF2dIlspeZa/8z/kAf4ONbVZIhlU6faGLqg+Q
	unWJiD6eurKdySqEteDuhb0opRoyMiAoTR7fiXVAjxX5M03z0YmKvO2zh4Q+FBnaSJsqoR2vMqQ
	X6adpUv6WH4PNt9y94vZjlQDZKbRyaUIVZaJrq
X-Received: by 2002:a05:620a:2544:b0:8cd:b2e9:b964 with SMTP id af79cd13be357-8fd158e59d9mr2083000185a.10.1777965755580;
        Tue, 05 May 2026 00:22:35 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.126.87])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd057acsm1406813285a.47.2026.05.05.00.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:22:34 -0700 (PDT)
Message-Id: <b2e7c97298f7628a26a9a27c07cbc6e44646cd7c.1777965748.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
References: <pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
	<pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 07:22:26 +0000
Subject: [PATCH v3 5/6] branch: add branch.<name>.pruneMerged opt-out
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Setting branch.<name>.pruneMerged=false exempts that branch from
--prune-merged (and from fetch --prune-merged), even with --force.
Useful for keeping a topic branch around between rounds.

Explicit deletion via 'git branch -d' is unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |  7 ++++++
 Documentation/git-branch.adoc    | 17 +++++++-------
 builtin/branch.c                 | 23 ++++++++++++++++--
 t/t3200-branch.sh                | 40 ++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..60dba38e27 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -102,3 +102,10 @@ for details).
 	`git branch --edit-description`. Branch description is
 	automatically added to the `format-patch` cover letter or
 	`request-pull` summary.
+
+`branch.<name>.pruneMerged`::
+	If set to `false`, branch _<name>_ is exempt from
+	`git branch --prune-merged` (and `git fetch --prune-merged`).
+	Useful for topic branches you intend to develop further after
+	an initial round has been merged upstream. Defaults to true.
+	Explicit deletion via `git branch -d` is unaffected.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 80b20a55eb..9d4944d17e 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -216,16 +216,15 @@ Each _<remote>_ may be either the name of a configured remote
 	Delete the local branches that `--forked` would list for
 	the same _<remote>_ arguments, but only when the branch's
 	push destination remote-tracking branch (the branch `git push`
-	would update; see `branch_get_push` semantics) no longer
-	resolves locally. In other words: the branch was pushed
-	under some name on _<remote>_, and that name has since
-	been pruned upstream.
+	would update) no longer resolves locally. In other words:
+	the branch was pushed under some name on _<remote>_, and
+	that name has since been pruned upstream.
 +
-By default, the local tip must also be reachable from the
-upstream remote-tracking branch (see `--no-merged`); branches with
-unpushed commits are refused. With `--force` (or `-f`), delete
-them regardless. The currently checked-out branch in any worktree
-is always preserved.
+The local tip must also be reachable from the upstream
+remote-tracking branch; branches with unpushed commits are refused.
+With `--force` (or `-f`), delete them regardless. The currently
+checked-out branch in any worktree is always preserved, as is
+any branch with `branch.<name>.pruneMerged` set to `false`.
 
 `-v`::
 `-vv`::
diff --git a/builtin/branch.c b/builtin/branch.c
index d3ca320d4d..c2094ca34d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -809,23 +809,42 @@ static int prune_merged_branches(int argc, const char **argv, int force,
 	for_each_string_list_item(item, &candidates) {
 		const char *short_name = item->string;
 		struct strbuf full = STRBUF_INIT;
+		struct strbuf key = STRBUF_INIT;
 		struct branch *branch;
 		const char *push_ref;
+		int opt_out = 0;
 
 		strbuf_addf(&full, "refs/heads/%s", short_name);
 		if (branch_checked_out(full.buf)) {
 			strbuf_release(&full);
+			strbuf_release(&key);
 			continue;
 		}
 		strbuf_release(&full);
 
 		branch = branch_get(short_name);
 		push_ref = branch ? branch_get_push(branch, NULL) : NULL;
-		if (!push_ref)
+		if (!push_ref) {
+			strbuf_release(&key);
 			continue;
+		}
 		if (refs_ref_exists(get_main_ref_store(the_repository),
-				    push_ref))
+				    push_ref)) {
+			strbuf_release(&key);
+			continue;
+		}
+
+		strbuf_addf(&key, "branch.%s.prunemerged", short_name);
+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
+		    !opt_out) {
+			if (!quiet)
+				fprintf(stderr, _("Skipping '%s' "
+						  "(branch.%s.pruneMerged is false)\n"),
+					short_name, short_name);
+			strbuf_release(&key);
 			continue;
+		}
+		strbuf_release(&key);
 
 		strvec_push(&deletable, short_name);
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e6e6eab482..9af7de690e 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1852,4 +1852,44 @@ test_expect_success '--prune-merged deletes when push ref differs from upstream'
 	test_must_fail git -C pm-pushdiff rev-parse --verify refs/heads/topic-a
 '
 
+test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
+	test_when_finished "rm -rf pm-optout" &&
+	git clone pm-upstream pm-optout &&
+	git -C pm-optout branch one --track origin/one &&
+	git -C pm-optout branch two --track origin/two &&
+	git -C pm-optout config branch.one.pruneMerged false &&
+
+	git -C pm-optout update-ref -d refs/remotes/origin/one &&
+	git -C pm-optout update-ref -d refs/remotes/origin/two &&
+	git -C pm-optout branch --prune-merged origin 2>err &&
+
+	git -C pm-optout rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-optout rev-parse --verify refs/heads/two &&
+	test_grep "Skipping .one." err
+'
+
+test_expect_success '--prune-merged --force still honours pruneMerged=false' '
+	test_when_finished "rm -rf pm-optout-force" &&
+	git clone pm-upstream pm-optout-force &&
+	git -C pm-optout-force checkout -b one --track origin/one &&
+	test_commit -C pm-optout-force unpushed &&
+	git -C pm-optout-force checkout - &&
+	git -C pm-optout-force config branch.one.pruneMerged false &&
+
+	git -C pm-optout-force update-ref -d refs/remotes/origin/one &&
+	git -C pm-optout-force branch --force --prune-merged origin &&
+
+	git -C pm-optout-force rev-parse --verify refs/heads/one
+'
+
+test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
+	test_when_finished "rm -rf pm-optout-d" &&
+	git clone pm-upstream pm-optout-d &&
+	git -C pm-optout-d branch one --track origin/one &&
+	git -C pm-optout-d config branch.one.pruneMerged false &&
+
+	git -C pm-optout-d branch -d one &&
+	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
+'
+
 test_done
-- 
gitgitgadget

