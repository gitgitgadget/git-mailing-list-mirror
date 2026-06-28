Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF982344D88
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782635360; cv=none; b=KEMOavirnAk4bx2lO0GZHbMydzlNodrft3Y8NYFkgqYKwmaFt10+UpI6xtGhDJJ8HcHwV3Md9ytSrfsEYwUbebx8iNILE8q//eZDx8V+59TH21Pv1aUqPfXj1psdGVIoRFJm2nYV1qlXvqD6/CZv/ySPhFvejmnAn6g2RGLSORM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782635360; c=relaxed/simple;
	bh=k8dNrHF2pOfrXI4cf0nvAgknGuzoID/WZLnJOD212lo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cyTWREKsuc/9walg7s5v16V+hra4DN4qmlsn/TvJuYKXqJiidW9JFkPCIgvcWzyXaqc9T2NBQHdDGuqAw3mjHsXOgvEYoEF9Op2L9PhLWHLNVZ9oAFgx/xLjYOlyOMjAFYyML0XoLYmJMtJHOzFP84DK2FYLz89f8SpBqaIHNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dmai/+JK; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dmai/+JK"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30c09f29b64so1646054eec.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 01:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782635358; x=1783240158; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUzo2qzhBFyQWs9UzwRd5t8SvECUjJKfgGcxws+EbJw=;
        b=Dmai/+JKpXkPflJyHGYzf9uOtdHkNZa4D/4RMBQ8N+A+VJYhl6a9ZKa2DJZAAgtXS7
         X0o2aDWGRqefWLrAIKDAKNHOJl3pteqTBV2itJVNNyAzM+0wgEtpRbHZWTwo5zAOXImi
         7t7cgPTAEPUd2p5nayMGAabHRd0McC9YHXrd/5BvzexZETr4+/mRB9A8IzbEjBgI+rcD
         CV8Phyf9Xoaog+F+7RlN/9RPwAwK+vl6YGByBj6B30dvoDkLTNEAhIOtq0oCJwb1zDcB
         7TEs/UgUL2VVSRXGd1MsMljuuQmKy5w5bdtB72aQAjqohuWzenRoiJWtKp1P1ZiJPifV
         7sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782635358; x=1783240158;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZUzo2qzhBFyQWs9UzwRd5t8SvECUjJKfgGcxws+EbJw=;
        b=jWW7vIdSWOeZrmrqDyjVII3Wkuxf4H/5lVjQHv239ipAxoRu8rj0cgABG8q0/3G2TJ
         +IOovYhDI7mqVwtIauWdPms7SF91xgXR2xsZcXdfjbZgTXsVOSIogjG3649w1MiJKsZ2
         K0KXD3pjXKllw8xWcnPB5ERduKotOnRDiXARMm9NVO1BZRMx91R5E6YvEbVx+EEpeJt/
         hv0gatnwdhH/yH9cPvKLRQtzGcVAUrge5V1L/QIFnDtvUlwcSYRyesvnSndEvU5XqNiW
         UFQ03RjTQzmbTu7NR+xlU3hOn4GKq9eg9djEwmmdVKSnBKWiBW6SqlHw0bs5dVWwjL50
         olfA==
X-Gm-Message-State: AOJu0YwzjhTY3CCgyO4NCi57gQ5p3UiUJ1xDIX5k4EB5WiQASvxN9NR1
	XWIPUno/CiEJfOW8PEjQc0Xbya41/QpWboU/UkK0CPwqXD8ysgUEaDu3tbwVsTjJ
X-Gm-Gg: AfdE7cmsu03gmHv7TY+c/rYuw5z5qdf5t541GdzEqK/66ystlXnKPq0u+CyzV8PHjV1
	iku6tigfDCU96JnEQfKRmhMfi8EwHYXMQerzP5WT4K5DfSRlYjFRqsiTEyUruu9Cdu6DQ8/zhuo
	kFPI072mF0E+c/xNOI9wUBv2xp/+bNRGunMe1GX0ZTNAx4dJQQU5HfNo+zkyJWuq3nSnAuOTU7d
	Zy5cwZNd5p7s4m1g5Xlpwslkeh+BrnRYD88H3dnF5OSfDeQpRW60avWIowxplmMsvBOTpoqNPex
	zyf63VHIgfzYjgRpma9B35nESgNchwH0eMt+QjZQQfQcIq7dLOj30zF4KPpFfIB53bNe5mWpHWy
	qDxdwLjPDTAe8FAbXV+iqImUT2m5rQpExYTYzDnq2btpmk6XVLWF6BZUvCWIi/d0okYj1QSQ2pk
	qpnDwpECz2svdklA==
X-Received: by 2002:a05:693c:62dc:b0:30e:c85b:d69b with SMTP id 5a478bee46e88-30ec85be289mr114482eec.19.1782635357769;
        Sun, 28 Jun 2026 01:29:17 -0700 (PDT)
Received: from [127.0.0.1] ([20.189.186.0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab28fasm37739434eec.30.2026.06.28.01.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 01:29:17 -0700 (PDT)
Message-Id: <4edf012b77fd2f2fb2a51eb10863bbf852fffa40.1782635349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
References: <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
	<pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 08:29:09 +0000
Subject: [PATCH v6 4/4] history: re-edit a squash with every message
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

By default "git history squash" reuses the oldest commit's message.
When --reedit-message is given it only reopened that one message, so the
messages of the folded-in commits were lost.

Gather the messages of every commit in the range, oldest first, and use
them as the editor template when re-editing, mirroring how "git rebase
-i" presents a squash.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-history.adoc |  5 +--
 builtin/history.c              | 61 +++++++++++++++++++++++++++++++++-
 t/t3455-history-squash.sh      | 37 +++++++++++++++++++++
 3 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 123ad5d4bc..8d4398ab1b 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -114,8 +114,9 @@ arguments to linkgit:git-rev-list[1], so several arguments may be given,
 for example `@~3.. ^topic` to additionally exclude what is already on
 `topic`.
 +
-The oldest commit's message and authorship are preserved by default,
-unless you specify `--reedit-message`. A merge commit inside the range is
+The oldest commit's message and authorship are preserved by default. With
+`--reedit-message`, an editor opens pre-filled with the messages of all the
+folded commits so you can combine them. A merge commit inside the range is
 folded like any other, but the range must have a single base, so a range
 that reaches more than one entry point (for example a side branch that
 forked before the range and was later merged into it) is rejected.
diff --git a/builtin/history.c b/builtin/history.c
index 5a1b42c063..1c31ea9118 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1097,6 +1097,56 @@ static int find_interior_ref(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
+static int build_squash_message(struct repository *repo,
+				struct commit *base,
+				struct commit *tip,
+				struct strbuf *out)
+{
+	struct rev_info revs;
+	struct commit *commit;
+	struct strvec args = STRVEC_INIT;
+	int n = 0, ret;
+
+	repo_init_revisions(repo, &revs, NULL);
+	strvec_push(&args, "ignored");
+	strvec_push(&args, "--reverse");
+	strvec_push(&args, "--topo-order");
+	strvec_pushf(&args, "%s..%s", oid_to_hex(&base->object.oid),
+		     oid_to_hex(&tip->object.oid));
+	setup_revisions_from_strvec(&args, &revs, NULL);
+
+	if (prepare_revision_walk(&revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+
+	while ((commit = get_revision(&revs))) {
+		const char *message, *body;
+		struct strbuf one = STRBUF_INIT;
+
+		message = repo_logmsg_reencode(repo, commit, NULL, NULL);
+		find_commit_subject(message, &body);
+		strbuf_addstr(&one, body);
+		strbuf_trim_trailing_newline(&one);
+
+		if (n++)
+			strbuf_addch(out, '\n');
+		strbuf_addbuf(out, &one);
+		strbuf_addch(out, '\n');
+
+		strbuf_release(&one);
+		repo_unuse_commit_buffer(repo, commit, message);
+	}
+
+	ret = 0;
+
+out:
+	reset_revision_walk();
+	release_revisions(&revs);
+	strvec_clear(&args);
+	return ret;
+}
+
 static int cmd_history_squash(int argc,
 			      const char **argv,
 			      const char *prefix,
@@ -1121,6 +1171,7 @@ static int cmd_history_squash(int argc,
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
+	struct strbuf message = STRBUF_INIT;
 	struct oidset interior = OIDSET_INIT;
 	struct commit *base, *oldest, *tip, *rewritten;
 	const struct object_id *base_tree_oid, *tip_tree_oid;
@@ -1160,6 +1211,12 @@ static int cmd_history_squash(int argc,
 		}
 	}
 
+	if (flags & COMMIT_TREE_EDIT_MESSAGE) {
+		ret = build_squash_message(repo, base, tip, &message);
+		if (ret < 0)
+			goto out;
+	}
+
 	ret = setup_revwalk(repo, action, tip, &revs);
 	if (ret < 0)
 		goto out;
@@ -1168,7 +1225,8 @@ static int cmd_history_squash(int argc,
 	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
 	commit_list_append(base, &parents);
 
-	ret = commit_tree_ext(repo, "squash", oldest, NULL, parents,
+	ret = commit_tree_ext(repo, "squash", oldest,
+			      message.len ? message.buf : NULL, parents,
 			      base_tree_oid, tip_tree_oid, &rewritten, flags);
 	if (ret < 0) {
 		ret = error(_("failed writing squashed commit"));
@@ -1189,6 +1247,7 @@ static int cmd_history_squash(int argc,
 
 out:
 	strbuf_release(&reflog_msg);
+	strbuf_release(&message);
 	oidset_clear(&interior);
 	commit_list_free(parents);
 	release_revisions(&revs);
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index 94ee54eb24..5ef6768826 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -164,6 +164,43 @@ test_expect_success 'preserves authorship of the oldest commit' '
 	test_cmp expect actual
 '
 
+test_expect_success '--reedit-message offers every folded-in message' '
+	git reset --hard start &&
+	echo b >file &&
+	git add file &&
+	git commit -m "re-one subject" -m "re-one body line" &&
+	test_commit --no-tag re-two file c &&
+	test_commit re-three file d &&
+
+	write_script editor <<-\EOF &&
+	cp "$1" buffer &&
+	echo combined >"$1"
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash --reedit-message start.. &&
+
+	test_grep "re-one subject" buffer &&
+	test_grep "re-one body line" buffer &&
+	test_grep re-two buffer &&
+	test_grep re-three buffer &&
+	git log --format="%s" -1 >actual &&
+	echo combined >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--reedit-message aborts on an empty message' '
+	git reset --hard three &&
+	head_before=$(git rev-parse HEAD) &&
+
+	write_script editor <<-\EOF &&
+	>"$1"
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	test_must_fail git history squash --reedit-message start.. &&
+
+	test_cmp_rev "$head_before" HEAD
+'
+
 test_expect_success '--dry-run predicts the rewrite without performing it' '
 	git reset --hard three &&
 	head_before=$(git rev-parse HEAD) &&
-- 
gitgitgadget
