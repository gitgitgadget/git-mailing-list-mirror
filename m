Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9242DC76C
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810236; cv=none; b=i61gdK8kMnL5m4khtBX/YaPn3lG9q/wHrFHDgchrPLEY8mILgwVR5cD/5c2UfaXNzL/77VYK7jdgIO9xemus+SXwm35/sVE/fnGmGw144EeJ10spjaA3pV04CEi++vUN9hOUCW0E0Kr7a9Xt8DRuxCibz7QGXrmz7ilZ3wGNhaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810236; c=relaxed/simple;
	bh=qw+dtpRqwaegG0OdHPH6K4Td4HKKEfoCs7ufiBbQZXw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EHp2zF0alV44r/lmsOiJACkfZAOwWQmTRIDq7PDtneMYN1DhLyc3rnd9jdxs+PIo34YGGS3Nal+Zt1XHATjPiriuLZDeEwJA8UwWMiSllc93VMV9nQZMhoJlFzUu+rbMfwTqFybCAF5cOfIlwzqcWdEKTqEP0CYMp/3V5FsxAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2LGhBEz; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2LGhBEz"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7e2fd65f968so15036237b3.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781810234; x=1782415034; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Hv5hqonEKr/JoQdH2+ea5hWuF7wFurf6kdra76V/js=;
        b=N2LGhBEzjMdY8pJKJkRF6z/7in24HzgB933jmrbkMaelEFhKkEpWbQhtS5IiEf75P5
         x2XtRd7JrNjRv8PGr5/nxXMJ66j5IgptFqBnyVCkT1r7KYdAIb4O+dy/8GmrnIvTNOHq
         wqVD5QV1LBV498/krhqrH7GzzOj9z+y9o+usuAVPIgTje/GELUqUgU7+K7j44F+rlCyN
         qgDDvVu3smCFcQaAaN30hQ7G47sR3D+ux0m18kOcK1a5ByDnB4Pqo2XPjt70uEXrgdv6
         cPMJTrbOkEtE7+eCxbTAKGJUBdlOWn1buaJY7N5xuJmUYYIxrrZv4FFbkJfmg3ZSsErV
         prYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810234; x=1782415034;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Hv5hqonEKr/JoQdH2+ea5hWuF7wFurf6kdra76V/js=;
        b=MMRsADhEKN5QYrwOwTS3A8TPDezIMjaSnUXAi06y2TyZyX7Uoi6SEdspt/wfl62XRV
         dG8ky2fHPxPI+gkAu66OXh7YCH95Xlw23QN0kHtj1cCmL23abiJ+2NscZcCMBcXjpp6c
         O6cjcpJDsDKIE0qDGWI5q3jcVe27SxISrdxFhVgFlzX4FEXfv+xVbcf0pVNTC8F7DNqS
         NqOsEj2xRgugGrHkGakMi+DiEkR7uUHUnAOgaQB8/QI1XDluZAXBzkS7rJs0D7BkkO5c
         Ao9+7k4vkFoluP1S7Mr7/zlwJS/6t726cf9twmw5HcyG2nNfnmsjwQ9rU6ZrS5GdqN3R
         vZUw==
X-Gm-Message-State: AOJu0YwESSVbumDCtGqqwBAfQr3AteKaO/Vgmao+Wy1wSou7SVxHHru6
	i9Jdnfx7K2l4ubX1OkM//9muOUtGQA8xzXDobSBGyd0ha/T5UudQf1CbWeWUQg==
X-Gm-Gg: AfdE7ckgLlDm7+UjvXNRFE02I/VdE8fp8q4VfGuewt3E3zY1KcvPgAy0V5m/zvUmPhT
	o0Y8N67h/8jK0eTi7yyQKM3bktSm+11tiZhCAFXBH+uw1lRZV4s+ggBt7lWFRAOpcb2tue5fBgk
	yi0j8HUfOTbiDZpBIRMD64HdFzRFqHqSlbNgIg4VH6NAMy019WIz+6r9OUuQQ0s2O0XBDvCzD4j
	X23W97NR1NHSZpMdp2uKyWa4zZoAgQKEK8LOxnZMbwIPTRawd2n1+SUNDh3pSFh0z0t2daJ+4n0
	Tam5Ccl5Gu5NFZYMF2i3Nkpq3kEgY12tOlfMadddKTQdk6QsBKbMk9z/CLP4RdLtGt6kDGW9RUU
	4IJ2+EHrmkPSFgCiTNXmu5RzQnSuad30XpeC1gTWEdGxHRaLX9tG6wqVE+/2c7Px9VV9j34hrZd
	qa87FfB8unCh1ucG0=
X-Received: by 2002:a05:690c:6186:b0:7f5:69b8:4287 with SMTP id 00721157ae682-80133fc5dd4mr1385607b3.9.1781810233899;
        Thu, 18 Jun 2026 12:17:13 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.77.168])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8de62de5904sm55996d6.43.2026.06.18.12.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:17:12 -0700 (PDT)
Message-Id: <43e4270614adc26811ddb3fcd69dd90b17dfa5a7.1781810227.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
References: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
	<pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 19:17:06 +0000
Subject: [PATCH v3 4/4] history: re-edit a squash with every message
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
-i" presents a squash. The combined message is built before the
descendant walk so it is not disturbed by the flags that walk leaves on
the commits.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-history.adoc |  5 +--
 builtin/history.c              | 61 +++++++++++++++++++++++++++++++++-
 t/t3454-history-squash.sh      | 37 +++++++++++++++++++++
 3 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index d3a5ad28a3..dd3544832d 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -111,8 +111,9 @@ history squash @~3..` folds the three most recent commits into one, and
 `git history squash @~5..@~2` squashes an interior range while leaving
 the two newest commits in place.
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
index 9d9416870f..eb12a5d7e8 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1047,6 +1047,56 @@ out:
 	return ret;
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
@@ -1071,6 +1121,7 @@ static int cmd_history_squash(int argc,
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
+	struct strbuf message = STRBUF_INIT;
 	struct commit *base, *oldest, *tip, *rewritten;
 	const struct object_id *base_tree_oid, *tip_tree_oid;
 	struct commit_list *parents = NULL;
@@ -1091,6 +1142,12 @@ static int cmd_history_squash(int argc,
 	if (ret < 0)
 		goto out;
 
+	if (flags & COMMIT_TREE_EDIT_MESSAGE) {
+		ret = build_squash_message(repo, base, tip, &message);
+		if (ret < 0)
+			goto out;
+	}
+
 	ret = setup_revwalk(repo, action, tip, &revs);
 	if (ret < 0)
 		goto out;
@@ -1099,7 +1156,8 @@ static int cmd_history_squash(int argc,
 	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
 	commit_list_append(base, &parents);
 
-	ret = commit_tree_ext(repo, "squash", oldest, NULL, parents,
+	ret = commit_tree_ext(repo, "squash", oldest,
+			      message.len ? message.buf : NULL, parents,
 			      base_tree_oid, tip_tree_oid, &rewritten, flags);
 	if (ret < 0) {
 		ret = error(_("failed writing squashed commit"));
@@ -1120,6 +1178,7 @@ static int cmd_history_squash(int argc,
 
 out:
 	strbuf_release(&reflog_msg);
+	strbuf_release(&message);
 	commit_list_free(parents);
 	release_revisions(&revs);
 	return ret;
diff --git a/t/t3454-history-squash.sh b/t/t3454-history-squash.sh
index 6c6a75bf00..1edd148295 100755
--- a/t/t3454-history-squash.sh
+++ b/t/t3454-history-squash.sh
@@ -135,6 +135,43 @@ test_expect_success 'preserves authorship of the oldest commit' '
 	test_cmp expect actual
 '
 
+test_expect_success '--reedit-message offers every folded-in message' '
+	git reset --hard start &&
+	echo b >file &&
+	git add file &&
+	git commit -m "re-one subject" -m "re-one body line" &&
+	test_commit re-two file c &&
+	test_commit re-three file d &&
+
+	write_script editor <<-\EOF &&
+	cp "$1" buffer &&
+	echo combined >"$1"
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash --reedit-message start.. &&
+
+	grep "re-one subject" buffer &&
+	grep "re-one body line" buffer &&
+	grep re-two buffer &&
+	grep re-three buffer &&
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
