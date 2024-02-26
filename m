Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8EF1CD06
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945095; cv=none; b=kR6vPGVsI90tapTAnDZyA+pE+O3A8C/iMasO3MAqujv54gc3St3IYLhv80jWC5fhBRFRM7LPkJffd7gecF23/PbeTtE3BRX4vSkJx4OKy5VBVdiUK0A7sz7zc6wopOVXy06sNJSt12dgt1Z+X8kgUeNKk3gc45Al/0LLgnfjii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945095; c=relaxed/simple;
	bh=Ba8Y31V55P3ad0kwbBJ/xbylymnNqs/j2OiIamZT8wg=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=WQqK3CFtRQR/XKiTHG2u/sxTD3JAB02GRgHoZyOUhqBtiZ1kLflykYfvP0KfN+umiOEcus6OQAC2NUXjXCUGD8kN37y3jTZvy297BN+OFd77RzIrk6G3VZiKhhWc4orSoU02ly9AiJODhaVDNbrfeDciO0hYRL3GBJnqvK+ygHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duJGiB+q; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duJGiB+q"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412a8d9402eso1034705e9.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 02:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708945089; x=1709549889; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GJTpgTbs/7aKrkEWbUGSUdVDys5iUUE8GP2gKnCyfaw=;
        b=duJGiB+qKkpL3aThV8+ESY/LvvvGVdZW95i9FokSBwgCX0xUzwspXdnrr71uFzxAzC
         htfjp+D5+/ca6/QQnVyc04jsgtPQZY+Y8sDsmH/SnI5T2tYFxO09+QT+oUUarIRwsnNX
         AYdR2MCi7fqFGaiwYIFaznW9+qTDxSK4AqhJJptscUuCaY1ixl+y/EIRZads3kSr1zde
         hEBUYAl70OSTWQlQILXKp8LC24YCGKF3Fu+mxLLTJnBsKkxxX5+GIr2f3pVv01MgQD8Y
         AqDtP5gzn2adRBPpVHMAH6y76yD7IvUCIgrRoUkAA2e3B2IQAV/+lP9i4GNKAT/7AzBO
         kQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708945089; x=1709549889;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJTpgTbs/7aKrkEWbUGSUdVDys5iUUE8GP2gKnCyfaw=;
        b=IEjPn0yhW+Tdr0mA8gO9Gg7bwlD31JnWTbA03CayHzAzx2rSiIKoEh+8J6+FngEFGf
         eJyc47Gs/rbOQBkAvqSzbp55lr+YtgtLjreQ4g5t2Maiet054YEeQeeZrjY/qsF9FlLL
         9Zw8TTPHzAJBg79M2QeEJnQbIc/XMwdfjeE0QgRlswaW88w8c6iUF6agPHm5S7d49nz3
         aGTjXrSibNAoj5W1SUVwXPK0qO9pc+Y+1y5mAqERWY607QJSSJmZpWrzilIqTJzC2uBT
         S4QUMmQWuRAXyUUPKtDawK4pW2Djc0ojD6KpeTNrFC2KB8W4Jr2a1siYpBlce9bVDaRf
         zfsw==
X-Gm-Message-State: AOJu0YxAxwotCUKPD8A2P0GkKVboOujH/QnJtO1/3exGMZTxWrEp5dCM
	lAJpZXZIBiCff6Q0BXarhlqoK6R0xHT4OvV+IbBcQOHqZtRLhxpLRyFjJYrV
X-Google-Smtp-Source: AGHT+IHCBKc4sbzlG28A9DhlSowJS8/dMi/IYhDdu7oEjVEL6O6p0HzpELbLKGp50TcoCOEfisoOGQ==
X-Received: by 2002:a05:600c:4f46:b0:412:9434:fa38 with SMTP id m6-20020a05600c4f4600b004129434fa38mr5230627wmq.7.1708945088746;
        Mon, 26 Feb 2024 02:58:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b0040fd1629443sm7855166wmo.18.2024.02.26.02.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 02:58:08 -0800 (PST)
Message-ID: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 10:58:07 +0000
Subject: [PATCH] rebase -i: improve error message when picking merge
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
Cc: Stefan Haller <lists@haller-berlin.de>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The only todo commands that accept a merge commit are "merge" and
"reset". All the other commands like "pick" or "reword" fail when they
try to pick a a merge commit and print the message

    error: commit abc123 is a merge but no -m option was given.

followed by a hint about the command being rescheduled. This message is
designed to help the user when they cherry-pick a merge and forget to
pass "-m". For users who are rebasing the message is confusing as there
is no way for rebase to cherry-pick the merge.

Improve the user experience by detecting the error when the todo list is
parsed rather than waiting for the "pick" command to fail and print a
message recommending the "merge" command instead. We recommend "merge"
rather than "exec git cherry-pick -m ..." on the assumption that
cherry-picking merges is relatively rare and it is more likely that the
user chose "pick" by a mistake.

It would be possible to support cherry-picking merges by allowing the
user to pass "-m" to "pick" commands but that adds complexity to do
something that can already be achieved with

    exec git cherry-pick -m1 abc123

The change is relatively straight forward but is complicated slightly as
we now need to tell the parser if we're rebasing or not.

Reported-by: Stefan Haller <lists@haller-berlin.de>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    rebase -i: improve error message when picking merge

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1672%2Fphillipwood%2Frebase-reject-merges-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1672/phillipwood/rebase-reject-merges-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1672

 builtin/rebase.c              |  2 +-
 rebase-interactive.c          |  7 ++---
 sequencer.c                   | 49 ++++++++++++++++++++++++++++++-----
 sequencer.h                   |  2 +-
 t/t3404-rebase-interactive.sh | 33 +++++++++++++++++++++++
 5 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b086f651a6..a33e41c44da 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -297,7 +297,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	else {
 		discard_index(&the_index);
 		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
-						&todo_list))
+						&todo_list, 1))
 			BUG("unusable todo list");
 
 		ret = complete_action(the_repository, &replay, flags,
diff --git a/rebase-interactive.c b/rebase-interactive.c
index d9718409b3d..78d5ed1a41d 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -114,7 +114,8 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 	 * it.  If there is an error, we do not return, because the user
 	 * might want to fix it in the first place. */
 	if (!initial)
-		incorrect = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list) |
+		incorrect = todo_list_parse_insn_buffer(r, todo_list->buf.buf,
+							todo_list, 1) |
 			file_exists(rebase_path_dropped());
 
 	if (todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, shortonto,
@@ -134,7 +135,7 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 	if (initial && new_todo->buf.len == 0)
 		return -3;
 
-	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo)) {
+	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo, 1)) {
 		fprintf(stderr, _(edit_todo_list_advice));
 		return -4;
 	}
@@ -234,7 +235,7 @@ int todo_list_check_against_backup(struct repository *r, struct todo_list *todo_
 	int res = 0;
 
 	if (strbuf_read_file(&backup.buf, rebase_path_todo_backup(), 0) > 0) {
-		todo_list_parse_insn_buffer(r, backup.buf.buf, &backup);
+		todo_list_parse_insn_buffer(r, backup.buf.buf, &backup, 1);
 		res = todo_list_check(&backup, todo_list);
 	}
 
diff --git a/sequencer.c b/sequencer.c
index 91de546b323..cf808c24d20 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2550,8 +2550,37 @@ static int check_label_or_ref_arg(enum todo_command command, const char *arg)
 	return 0;
 }
 
+static int error_merge_commit(enum todo_command command)
+{
+	switch(command) {
+	case TODO_PICK:
+		return error(_("'%s' does not accept merge commits, "
+			       "please use '%s'"),
+			     todo_command_info[command].str, "merge -C");
+
+	case TODO_REWORD:
+		return error(_("'%s' does not accept merge commits, "
+			       "please use '%s'"),
+			     todo_command_info[command].str, "merge -c");
+
+	case TODO_EDIT:
+		return error(_("'%s' does not accept merge commits, "
+			       "please use '%s' followed by '%s'"),
+			     todo_command_info[command].str,
+			     "merge -C", "break");
+
+	case TODO_FIXUP:
+	case TODO_SQUASH:
+		return error(_("cannot squash merge commit into another commit"));
+
+	default:
+		BUG("unexpected todo_command");
+	}
+}
+
 static int parse_insn_line(struct repository *r, struct todo_item *item,
-			   const char *buf, const char *bol, char *eol)
+			   const char *buf, const char *bol, char *eol,
+			   int rebasing)
 {
 	struct object_id commit_oid;
 	char *end_of_object_name;
@@ -2655,7 +2684,12 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 		return status;
 
 	item->commit = lookup_commit_reference(r, &commit_oid);
-	return item->commit ? 0 : -1;
+	if (!item->commit)
+		return -1;
+	if (rebasing && item->command != TODO_MERGE &&
+	    item->commit->parents && item->commit->parents->next)
+		return error_merge_commit(item->command);
+	return 0;
 }
 
 int sequencer_get_last_command(struct repository *r UNUSED, enum replay_action *action)
@@ -2686,7 +2720,7 @@ int sequencer_get_last_command(struct repository *r UNUSED, enum replay_action *
 }
 
 int todo_list_parse_insn_buffer(struct repository *r, char *buf,
-				struct todo_list *todo_list)
+				struct todo_list *todo_list, int rebasing)
 {
 	struct todo_item *item;
 	char *p = buf, *next_p;
@@ -2704,7 +2738,7 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 
 		item = append_new_todo(todo_list);
 		item->offset_in_buf = p - todo_list->buf.buf;
-		if (parse_insn_line(r, item, buf, p, eol)) {
+		if (parse_insn_line(r, item, buf, p, eol, rebasing)) {
 			res = error(_("invalid line %d: %.*s"),
 				i, (int)(eol - p), p);
 			item->command = TODO_COMMENT + 1;
@@ -2852,7 +2886,8 @@ static int read_populate_todo(struct repository *r,
 	if (strbuf_read_file_or_whine(&todo_list->buf, todo_file) < 0)
 		return -1;
 
-	res = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
+	res = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list,
+					  is_rebase_i(opts));
 	if (res) {
 		if (is_rebase_i(opts))
 			return error(_("please fix this using "
@@ -2882,7 +2917,7 @@ static int read_populate_todo(struct repository *r,
 		struct todo_list done = TODO_LIST_INIT;
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
-		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done))
+		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done, 1))
 			todo_list->done_nr = count_commands(&done);
 		else
 			todo_list->done_nr = 0;
@@ -6286,7 +6321,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	strbuf_release(&buf2);
 	/* Nothing is done yet, and we're reparsing, so let's reset the count */
 	new_todo.total_nr = 0;
-	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
+	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo, 1) < 0)
 		BUG("invalid todo list after expanding IDs:\n%s",
 		    new_todo.buf.buf);
 
diff --git a/sequencer.h b/sequencer.h
index dcef7bb99c0..ed2c4b38514 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -136,7 +136,7 @@ struct todo_list {
 }
 
 int todo_list_parse_insn_buffer(struct repository *r, char *buf,
-				struct todo_list *todo_list);
+				struct todo_list *todo_list, int rebasing);
 int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
 			    const char *file, const char *shortrevisions,
 			    const char *shortonto, int num, unsigned flags);
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 64b641002e4..20b8589ad07 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -2203,6 +2203,39 @@ test_expect_success 'bad labels and refs rejected when parsing todo list' '
 	test_path_is_missing execed
 '
 
+test_expect_success 'non-merge commands reject merge commits' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout E &&
+	git merge I &&
+	oid=$(git rev-parse HEAD) &&
+	cat >todo <<-EOF &&
+	pick $oid
+	reword $oid
+	edit $oid
+	fixup $oid
+	squash $oid
+	EOF
+	(
+		set_replace_editor todo &&
+		test_must_fail git rebase -i HEAD 2>actual
+	) &&
+	cat >expect <<-EOF &&
+	error: ${SQ}pick${SQ} does not accept merge commits, please use ${SQ}merge -C${SQ}
+	error: invalid line 1: pick $oid
+	error: ${SQ}reword${SQ} does not accept merge commits, please use ${SQ}merge -c${SQ}
+	error: invalid line 2: reword $oid
+	error: ${SQ}edit${SQ} does not accept merge commits, please use ${SQ}merge -C${SQ} followed by ${SQ}break${SQ}
+	error: invalid line 3: edit $oid
+	error: cannot squash merge commit into another commit
+	error: invalid line 4: fixup $oid
+	error: cannot squash merge commit into another commit
+	error: invalid line 5: squash $oid
+	You can fix this with ${SQ}git rebase --edit-todo${SQ} and then run ${SQ}git rebase --continue${SQ}.
+	Or you can abort the rebase with ${SQ}git rebase --abort${SQ}.
+	EOF
+	test_cmp expect actual
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged

base-commit: c875e0b8e036c12cfbf6531962108a063c7a821c
-- 
gitgitgadget
