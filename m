Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686901C1F0F
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041170; cv=none; b=V8dsM19I70pUweXlKf90epjYXW7tGyG3nHQQ24FnBURGun/DRzUdE6myBQcwiiJF9RJ8zw5f+cnS0iiH6q+EArw9J2rkWXP9MUA11VZBRMPfXl0xtakYB4lw7bUWeSUXToQh2kXFJG5iRQT/eMFIanMsnoWCoau8+drZ4bCQdEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041170; c=relaxed/simple;
	bh=S6dzj5WwCp6tknoXrgINPycxuFvEHC/Hx/S6PYNiHV8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=hsA73WcgiNqdC+R4cog+ZtCggJDnERkiNB9mor1TjSxFRJdVSPXaHhj/xVq1A9TjZ76yIvYArqwL0hrxn47aa410Yysy2cSYEsaouYREZ+d9+Bv+bhzqRBvFk+IUxx6Y0kuffXM9FSxRBCio++YumR5TY6adh7HRFc7NVQLxF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKDrp4dZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKDrp4dZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso49606215e9.3
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744041166; x=1744645966; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j/essJFnxu7HU3jH0heLbZHW7US20vv4OUKUezrfggs=;
        b=dKDrp4dZsCiF6qd0/PlqDuS/yJpZqTEKsiR+O6ptHcPpaCgRCEIddNL4BQfczudr6S
         mZ9bWb9Gpaa3Ihx2OvFR+eQy0kg8ShNWnYyr4PHUz1cdt73cUpULKkoZSGTw0EZhuHdD
         hLAfyS8pKFap8CwkBJyX80y0jmQSdIeA/H4DbNok0Dqi349U6bD4/SP0NERXWxiUSZ7P
         te2yYa36PLHArAYo8MSHAkEsWuAECpEUna8m5wflBHLH9M+dWGbx47/Bys8TC9m8pqCm
         uvtMHmKFNuC94tISRq3excw0M7OUOm0FM7fe8J1a0HLCgI5vpjpjm7uIbcYp1b7oKPf7
         r0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744041166; x=1744645966;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/essJFnxu7HU3jH0heLbZHW7US20vv4OUKUezrfggs=;
        b=vTlHR+AGf1FaDSx9TpUzfi512HJsrthp7md8kZftE3VP1dDyMYykHQfLrG+wxiv0jO
         LGWGYJ9GxL9VK5CCXHPN4z93UcF7NdbxsDEYk9H+KV1YOBOPTPL3lDS9JLO2kP7a/erJ
         WwXwwE60WhK5nOz4aKmyIp1MNw4t44C6T0Ftx9gyLVByA8M0z5a1ijh1S6mtG4hY+1wi
         +e5u1vZUG6HD3tydHDEibGGoEWo6O/kQDxoOienOFdeG9XYbeNXXKsY9zKYaHocUzH6M
         zhxDyJi1ByAsNNCuqCs5HF3awOUzLy21sK4pbLFVLRF6otYyNZkiBzesdxn4o0RC3Cdm
         4DaA==
X-Gm-Message-State: AOJu0Yz8eB4+kU0tACfvWCv7Umd15Y6mocNWXbBlPlGwUihRH+FgH7TK
	QqYdFuNzlE9/ronxXgbDyNOLwmLRYZIHSXLxh8PM42S3kez+bTiV+ULLBg==
X-Gm-Gg: ASbGncs/O6unu0ei9k5lcDsRCAABnFyUApTGfQHedyNwkIkPlHKo5bkUzdQc5CsL7Rg
	MOFrVOUtkSL5cbWnCzq+G7GG/XfH8PHF5Y04JCKG3kspsf4+G4UbadgLHacD7FPQveunUOMtXB1
	BaBiQc3jx0XBflQjpaIXKHF4SWsuaqzgUHuQ2bJkPEkMvvJOu0BnHxz61x2HbsJMbiaDOExk3lw
	D3hSZ4ICHctePkSQLRGxjYER4MZCAKAJOJCRGaLzjDpiBGOnmJwSE5/iXIrFW2KpcLbuSHvhIBs
	YLJzCloZrQGuvQw0GO3yEJ9ypLdLU4Wk7u2K+U8j39M77aq05qJi8mcm
X-Google-Smtp-Source: AGHT+IFF3+SAIK2YQoN56vbd2Hz5BDTtdoWlRS2jgYsPHZDx2xu3O1qgp8ZcaK7bizE8fGofUpsKWg==
X-Received: by 2002:a05:600c:34d3:b0:43d:1824:aadc with SMTP id 5b1f17b1804b1-43ee0780603mr85223795e9.29.1744041166060;
        Mon, 07 Apr 2025 08:52:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d943sm12576611f8f.74.2025.04.07.08.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:52:45 -0700 (PDT)
Message-Id: <pull.1902.git.1744041163929.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Apr 2025 15:52:43 +0000
Subject: [PATCH] [RFC] rebase -m: partial support for copying extra commit
 headers
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

There are external projects such as GitButler that add extra headers to
the commit objects that they create. Unfortunately these headers are
lost when the user runs "git rebase". In the absence of merge conflicts
copying these headers across to the rebased commit is relatively
straight forward as the sequencer creates the rebased commits using
commit_tree_extended() rather than forking "git commit". Preserving them
in the presence of merge conflict would mean that we either need to add
a way to creating extra headers when running "git commit" or modifying
the sequencer to stop using git commit when the commit message needs to
be edited. Both of these options involve a significant amount of more
work.

While losing the extra headers if there are merge conflicts is a
significant shortcoming for users rebasing their branches it is not such
a problem on the server where forges typically reject a rebase if it has
conflicts. Therefore even though this commit is far from a complete
solution it is a significant improvement for forges that have not yet
moved to using "git replay" which already preserves extra commit
headers.

In the long run we would also want to preserve extra headers when
cherry-picking a commit. As we cannot currently preserve extra headers
when the user wishes to edit the commit message of the cherry-picked
commit this patch only changes the behavior of "git rebase"

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    [RFC] rebase -m: partial support for copying extra commit headers
    
    This patch is largely a response to
    https://lore.kernel.org/git/Z-5rpWKAVPmz32jC@pks.im/ . I'm in two minds
    about whether we should consider merging such partial support but if it
    helps forges preserve extra commit headers then it may well be worth it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1902%2Fphillipwood%2Frebase-preserve-extra-commit-headers-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1902/phillipwood/rebase-preserve-extra-commit-headers-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1902

 sequencer.c                   | 25 +++++++++++++-----
 t/t3404-rebase-interactive.sh | 48 +++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ad0ab75c8d4..5b92f77b660 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1527,6 +1527,9 @@ static int parse_head(struct repository *r, struct commit **head)
 	return 0;
 }
 
+/* Headers to exclude when copying extra commit headers */
+static const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
+
 /*
  * Try to commit without forking 'git commit'. In some cases we need
  * to run 'git commit' to display an error message
@@ -1538,6 +1541,7 @@ static int parse_head(struct repository *r, struct commit **head)
  */
 static int try_to_commit(struct repository *r,
 			 struct strbuf *msg, const char *author,
+			 struct commit_extra_header *extra_header,
 			 struct replay_opts *opts, unsigned int flags,
 			 struct object_id *oid)
 {
@@ -1545,7 +1549,7 @@ static int try_to_commit(struct repository *r,
 	struct object_id tree;
 	struct commit *current_head = NULL;
 	struct commit_list *parents = NULL;
-	struct commit_extra_header *extra = NULL;
+	struct commit_extra_header *extra = extra_header;
 	struct strbuf err = STRBUF_INIT;
 	struct strbuf commit_msg = STRBUF_INIT;
 	char *amend_author = NULL;
@@ -1561,7 +1565,6 @@ static int try_to_commit(struct repository *r,
 		return -1;
 
 	if (flags & AMEND_MSG) {
-		const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
 		const char *out_enc = get_commit_output_encoding();
 		const char *message = repo_logmsg_reencode(r, current_head,
 							   NULL, out_enc);
@@ -1714,7 +1717,8 @@ static int try_to_commit(struct repository *r,
 		commit_post_rewrite(r, current_head, oid);
 
 out:
-	free_commit_extra_headers(extra);
+	if (extra != extra_header)
+		free_commit_extra_headers(extra);
 	free_commit_list(parents);
 	strbuf_release(&err);
 	strbuf_release(&commit_msg);
@@ -1734,6 +1738,7 @@ static int write_rebase_head(struct object_id *oid)
 
 static int do_commit(struct repository *r,
 		     const char *msg_file, const char *author,
+		     struct commit_extra_header *extra_header,
 		     struct replay_opts *opts, unsigned int flags,
 		     struct object_id *oid)
 {
@@ -1749,7 +1754,7 @@ static int do_commit(struct repository *r,
 					   msg_file);
 
 		res = try_to_commit(r, msg_file ? &sb : NULL,
-				    author, opts, flags, &oid);
+				    author, extra_header, opts, flags, &oid);
 		strbuf_release(&sb);
 		if (!res) {
 			refs_delete_ref(get_main_ref_store(r), "",
@@ -2251,6 +2256,7 @@ static int do_pick_commit(struct repository *r,
 	int res, unborn = 0, reword = 0, allow, drop_commit;
 	enum todo_command command = item->command;
 	struct commit *commit = item->commit;
+	struct commit_extra_header *extra_header = NULL;
 
 	if (opts->no_commit) {
 		/*
@@ -2391,8 +2397,12 @@ static int do_pick_commit(struct repository *r,
 			strbuf_addstr(&ctx->message, oid_to_hex(&commit->object.oid));
 			strbuf_addstr(&ctx->message, ")\n");
 		}
-		if (!is_fixup(command))
+		if (!is_fixup(command)) {
 			author = get_author(msg.message);
+			if (is_rebase_i(opts))
+				extra_header = read_commit_extra_headers(commit,
+								exclude_gpgsig);
+		}
 	}
 	ctx->have_message = 1;
 
@@ -2503,8 +2513,8 @@ static int do_pick_commit(struct repository *r,
 	} /* else allow == 0 and there's nothing special to do */
 	if (!opts->no_commit && !drop_commit) {
 		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
-			res = do_commit(r, msg_file, author, opts, flags,
-					commit? &commit->object.oid : NULL);
+			res = do_commit(r, msg_file, author, extra_header, opts,
+					flags, commit? &commit->object.oid : NULL);
 		else
 			res = error(_("unable to parse commit author"));
 		*check_todo = !!(flags & EDIT_MSG);
@@ -2535,6 +2545,7 @@ fast_forward_edit:
 leave:
 	free_message(commit, &msg);
 	free(author);
+	free_commit_extra_headers(extra_header);
 	update_abort_safety_file();
 
 	return res;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 2aee9789a2f..200f55824c7 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -2297,6 +2297,54 @@ test_expect_success 'non-merge commands reject merge commits' '
 	test_cmp expect actual
 '
 
+test_expect_success 'unconflicted pick copies extra commit headers' '
+	tree="$(git rev-parse C^{tree})" &&
+	parent="$(git rev-parse C^{commit})" &&
+	for i in 1 2 3 4 5 6 7
+	do
+		cat >commit <<-EOF &&
+		tree $tree
+		parent $parent
+		author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		x-extra-header value $i
+
+		An empty commit with an extra header $i
+		EOF
+
+		parent="$(git hash-object -t commit -w commit)" &&
+		eval "oid$i=\$parent" &&
+		test_tick || return 1
+	done &&
+
+	cat >todo <<-EOF &&
+	pick $oid1
+	pick $oid2
+	fixup $oid3
+	reword $oid4
+	edit $oid5
+	pick $oid6
+	squash $oid7
+	EOF
+
+	(
+		set_replace_editor todo &&
+		FAKE_COMMIT_AMEND=EDITED git rebase -i --onto A $oid1^ $oid5
+	) &&
+	echo changed >file2 &&
+	git add file2 &&
+	FAKE_COMMIT_AMEND=EDITED git rebase --continue &&
+	j=4 &&
+	for i in 1 2 4 5 6
+	do
+		git cat-file commit HEAD~$j >actual &&
+		sed -n -e /^\$/q -e /^x-extra/p actual >actual.extra-header &&
+		echo "x-extra-header value $i" >expect &&
+		test_cmp expect actual.extra-header &&
+		j=$((j-1)) || return 1
+	done
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged

base-commit: a36e024e989f4d35f35987a60e3af8022cac3420
-- 
gitgitgadget
