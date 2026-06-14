Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9E529D288
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781465150; cv=none; b=cb4DOkS/f4W9gB/brZpsQ9SzlwX6u3NJrsS68EY2IdRmN6Su6Pqqm0EdTMamfKRIocJvoiZPwqjltjDoLi5/A+UGgCEXIwBT0arN6DWHBGGVl/Q0NpsirBpiQjw5f33l04DsQLEPLJ2aFlgSbarZY/aMbHCSA+wffeoKhlgyiPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781465150; c=relaxed/simple;
	bh=kSjy0lGur9+iyfDTALRSm8mygQU6PtGL7V7XK5hoAtI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=utfWzudAEApu+BcFfAsJghQEVIPHVJbWXp61OgMEoYHnyZc/0qdwnjhVZd2iSjdBy58j7mbShaFBBJhXBOp8VkzGu/xIm0DnJ7zMuZvO05ayhlXm7QX4qd7JFrM3bThZEojDmONYpnaqEC86bAVlTqiELZll7Ra1So/hidupAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQKGqoHl; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQKGqoHl"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1397e093f90so714887c88.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 12:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781465148; x=1782069948; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZOcleRdLiTwZeRXk4kS3G5C2Zeo5sFBQVL/wjBVuIw=;
        b=LQKGqoHlAJ0zuxyR+4TjCIJYe5VVur8kFMfhnVMzVr/tfy0L2wg2XlQ3ZyBPJ4D5Qb
         8iQSpeiIZJIMVzNoohwiQ0NV9aVVf0/l6R8f0reuVTmD79gmQz/HMQkd4sXyaO4AnYXA
         Jwn96EqTkhk1JrDt8h8w8yyl4G3SMohN+j5/Q2+spa1FVM8ImI6/IXrSkFbx4IRFLwSt
         KwBk3eLhMc8fA5be/QSY3Rn8qmP1C+Rh2URgzn0ZUAMGk99z1UAYmlxXJV8znLCYeOO5
         pEIys+Q/LCl/0zCxqyYFOvjrCjYcFpK93OO8STnAK1TFR+1G6HSuQiBq3aMo83El/w0n
         Mz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781465148; x=1782069948;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pZOcleRdLiTwZeRXk4kS3G5C2Zeo5sFBQVL/wjBVuIw=;
        b=fG9AXknE+QT7SEcaGIZRQBGOsDCEc6Pmno1XaFEOSJ9lTPvxBtv3rygUO31YrYcjQL
         5qwYYpGNpNDY13UYZwiJ+DhKifjrvvboVA+Sqhx9Oq6SHabzjegNyprftJy2OLmR7TqK
         h7T4zg/U/ZQXt75gA7UmfABA0sRN6E4omfrQB8+mSh9/16kk6EDqjdb4FHMqprIkHaP6
         /u5BnVs9P2xv+fZwu2YHpixP40ztogDkPzJEsR1ekdvoSahKLffuu5VUkNwOmniIxb60
         hfaWMqvLUq6DjcYUggzNOdtdi2Mkfk+CLncUBqDQvcig2emrmRTiFj2OsrvEQ81QTnPL
         3Aow==
X-Gm-Message-State: AOJu0Yy7OaOxJ6goe5Gh/kLKFWi92H8EYSjTImjAxUo2vdiDHSJhMzYV
	ghyeMsAJG3dBOeQoXgqMe69hbhMHjru1+aOESyBXCsT+DzrnkJEGxfioT6TDGzbg
X-Gm-Gg: Acq92OExrsDzpCJrcHUUnS4VqKQDZDYIq9Hdm8CIpwmcaKgstfbMpMJ/2dR5j/RKZuY
	jqsarQAWVGkLEYod//M5DTlv481FcBs9yV9Imh7S4k4L6qqRTu9pA9sxxYbhMG1WnOxOYBx6FQN
	VDHrXZlgmG4qgSLpLqioEwrwHSNzPMYAp+6z3IjddEKQpVz6mzc95nLsKnM6kKQK7MMpKvsQAiP
	6My+nBpCeoyShMLCCxBZqoPQhVMAV0u81gfv8V3dRtemK92CKjAyYOfHEm52V2f3DqlbnUumI6G
	oblFgcMBlE0WZUoNKdv7fuHqE1XZSdODRICxt8VQfNcDYnhST6M631SCvLCTQH0EsLPzWZA+KhP
	CDOH/Oga5LxDtDIXJHez86smJo4q0llG43Vcsa5Dd7oPFjgP5sM6dsGvkPld5nmZ9Jsz15/5QTu
	/ueXrsiNrtywlXPt1Xy/83v9g=
X-Received: by 2002:a05:7022:fd08:b0:138:49ea:f463 with SMTP id a92af1059eb24-1384bb1613cmr4975049c88.16.1781465147958;
        Sun, 14 Jun 2026 12:25:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.42.67])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b964853sm8122954c88.11.2026.06.14.12.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 12:25:45 -0700 (PDT)
Message-Id: <bd1bc62aa81579e19180d06925940157d7f6f155.1781465141.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 19:25:41 +0000
Subject: [PATCH 2/2] rebase: add --fixup-all to fold a range
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

Folding a series of commits into one required either an interactive
rebase where each commit after the first was hand-edited to "fixup", or
a "git reset --soft" to the merge base followed by "git commit --amend".

Add "git rebase --autosquash --fixup-all [<upstream>]" to do this
directly. It keeps the first commit in the range as a "pick" and turns
every later commit into a "fixup", so the whole range collapses into a
single commit that reuses the first commit's message. With no <upstream>
argument the range is "@{upstream}..HEAD", folding all unpushed commits
into one.

Fold the commits in their original order, so that any fixup!/squash!
commits already present in the range are folded in as well. Allow the
flag only together with --autosquash, and reject --rebase-merges since a
merge commit cannot be folded into another commit.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-rebase.adoc |  11 ++++
 builtin/rebase.c              |  13 ++++-
 sequencer.c                   |  24 +++++++-
 sequencer.h                   |   2 +-
 t/t3415-rebase-autosquash.sh  | 105 ++++++++++++++++++++++++++++++++++
 5 files changed, 151 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..d1a3e4ef64 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -602,6 +602,16 @@ option can be used to override that setting.
 +
 See also INCOMPATIBLE OPTIONS below.
 
+--fixup-all::
+	Valid only when used with `--autosquash`.  Keep the first commit in
+	the range as a `pick` and change every later commit to a `fixup`, so
+	the whole range is folded into a single commit that reuses the first
+	commit's message.  With no `<upstream>` argument this folds all commits
+	since `@{upstream}` into one.  The commits are folded in their original
+	order, so any `fixup!`/`squash!` commits already in the range are folded
+	in as well.  Cannot be combined with `--rebase-merges`, as a merge
+	commit cannot be folded into another commit.
+
 --autostash::
 --no-autostash::
 	Automatically create a temporary stash entry before the operation
@@ -652,6 +662,7 @@ are incompatible with the following options:
  * --strategy
  * --strategy-option
  * --autosquash
+ * --fixup-all
  * --rebase-merges
  * --interactive
  * --exec
diff --git a/builtin/rebase.c b/builtin/rebase.c
index fa4f5d9306..a363fbc1f2 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -118,6 +118,7 @@ struct rebase_options {
 	int allow_rerere_autoupdate;
 	int keep_empty;
 	int autosquash;
+	int fixup_all;
 	char *gpg_sign_opt;
 	int autostash;
 	int committer_date_is_author_date;
@@ -329,7 +330,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	ret = complete_action(the_repository, &replay, flags,
 		shortrevisions, opts->onto_name, opts->onto,
 		&opts->orig_head->object.oid, &opts->exec,
-		opts->autosquash, opts->update_refs, &todo_list);
+		opts->autosquash, opts->fixup_all, opts->update_refs,
+		&todo_list);
 
 cleanup:
 	replay_opts_release(&replay);
@@ -1205,6 +1207,8 @@ int cmd_rebase(int argc,
 		OPT_BOOL(0, "autosquash", &options.autosquash,
 			 N_("move commits that begin with "
 			    "squash!/fixup! under -i")),
+		OPT_BOOL(0, "fixup-all", &options.fixup_all,
+			 N_("fold all commits in the range into the first one")),
 		OPT_BOOL(0, "update-refs", &options.update_refs,
 			 N_("update branches that point to commits "
 			    "that are being rebased")),
@@ -1594,6 +1598,13 @@ int cmd_rebase(int argc,
 	options.rebase_merges = (options.rebase_merges >= 0) ? options.rebase_merges :
 				((options.config_rebase_merges >= 0) ? options.config_rebase_merges : 0);
 
+	if (options.fixup_all && options.autosquash != 1)
+		die(_("--fixup-all requires --autosquash"));
+
+	if (options.fixup_all && options.rebase_merges)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--fixup-all", "--rebase-merges");
+
 	if (options.autosquash == 1) {
 		imply_merge(&options, "--autosquash");
 	} else if (options.autosquash == -1) {
diff --git a/sequencer.c b/sequencer.c
index 57855b0066..eeaf6226fe 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6554,11 +6554,29 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
 	return 0;
 }
 
+static void todo_list_fixup_all_but_first(struct todo_list *todo_list)
+{
+	int i, seen_first = 0;
+
+	for (i = 0; i < todo_list->nr; i++) {
+		struct todo_item *item = todo_list->items + i;
+
+		if (!item->commit || item->command == TODO_DROP)
+			continue;
+		if (!seen_first) {
+			seen_first = 1;
+			item->command = TODO_PICK;
+			continue;
+		}
+		item->command = TODO_FIXUP;
+	}
+}
+
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    struct commit *onto, const struct object_id *orig_head,
 		    struct string_list *commands, unsigned autosquash,
-		    unsigned update_refs,
+		    unsigned fixup_all, unsigned update_refs,
 		    struct todo_list *todo_list)
 {
 	char shortonto[GIT_MAX_HEXSZ + 1];
@@ -6581,7 +6599,9 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	if (update_refs && todo_list_add_update_ref_commands(todo_list))
 		return -1;
 
-	if (autosquash && todo_list_rearrange_squash(todo_list))
+	if (fixup_all)
+		todo_list_fixup_all_but_first(todo_list);
+	else if (autosquash && todo_list_rearrange_squash(todo_list))
 		return -1;
 
 	if (commands->nr)
diff --git a/sequencer.h b/sequencer.h
index 3164bd437d..9bb6b42c94 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -196,7 +196,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		    const char *shortrevisions, const char *onto_name,
 		    struct commit *onto, const struct object_id *orig_head,
 		    struct string_list *commands, unsigned autosquash,
-		    unsigned update_refs,
+		    unsigned fixup_all, unsigned update_refs,
 		    struct todo_list *todo_list);
 int todo_list_rearrange_squash(struct todo_list *todo_list);
 
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 8964d1cc88..21d4159ebd 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -511,4 +511,109 @@ test_expect_success 'pick and fixup respect commit.cleanup' '
 	test_commit_message HEAD -m "something"
 '
 
+test_expect_success '--fixup-all folds the range into the first commit' '
+	git reset --hard base &&
+	test_commit --no-tag fold1 file_fold a &&
+	test_commit --no-tag fold2 file_fold b &&
+	test_commit --no-tag fold3 file_fold c &&
+	git rebase --autosquash --fixup-all HEAD~3 &&
+	test_cmp_rev base HEAD~1 &&
+	test_commit_message HEAD -m "fold1" &&
+	echo c >expect &&
+	test_cmp expect file_fold
+'
+
+test_expect_success '--fixup-all folds smoothly when a fixup! commit is in the series' '
+	git reset --hard base &&
+	test_commit --no-tag foldA file_fold a &&
+	test_commit --no-tag foldB file_fold b &&
+	git commit --allow-empty --fixup HEAD~1 &&
+	git rebase --autosquash --fixup-all HEAD~3 &&
+	test_cmp_rev base HEAD~1 &&
+	test_commit_message HEAD -m "foldA" &&
+	echo b >expect &&
+	test_cmp expect file_fold
+'
+
+test_expect_success '--fixup-all picks the first commit even if it is a fixup!' '
+	git reset --hard base &&
+	test_commit --no-tag fixupbase file_fix a &&
+	git commit --allow-empty --fixup HEAD &&
+	test_commit --no-tag fixuptail file_fix b &&
+	git rebase --autosquash --fixup-all HEAD~3 &&
+	test_cmp_rev base HEAD~1 &&
+	echo b >expect &&
+	test_cmp expect file_fix
+'
+
+test_expect_success '--fixup-all with a single commit in range is a no-op' '
+	git reset --hard base &&
+	test_commit --no-tag solo file_solo a &&
+	git rev-parse HEAD >expect &&
+	git rebase --autosquash --fixup-all HEAD~1 &&
+	git rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--fixup-all with an empty range succeeds' '
+	git reset --hard base &&
+	git rebase --autosquash --fixup-all HEAD &&
+	test_cmp_rev base HEAD
+'
+
+test_expect_success '--fixup-all skips a dropped commit in the range' '
+	git reset --hard base &&
+	test_commit --no-tag fixdrop1 file_drop a &&
+	git commit --allow-empty -m "empty in the middle" &&
+	test_commit --no-tag fixdrop3 file_drop b &&
+	git rebase --autosquash --empty=drop --fixup-all HEAD~3 &&
+	test_cmp_rev base HEAD~1 &&
+	test_commit_message HEAD -m "fixdrop1" &&
+	echo b >expect &&
+	test_cmp expect file_drop
+'
+
+test_expect_success '--fixup-all folds a merge commit in the middle of the range' '
+	git reset --hard base &&
+	test_commit --no-tag mid-first &&
+	git checkout -b mid-side &&
+	test_commit --no-tag mid-merged &&
+	git checkout - &&
+	git merge --no-ff -m "merge mid-side" mid-side &&
+	test_commit --no-tag mid-last &&
+	git rebase --autosquash --fixup-all base &&
+	test_cmp_rev base HEAD~1 &&
+	test_commit_message HEAD -m "mid-first" &&
+	test_path_is_file mid-merged.t
+'
+
+test_expect_success '--fixup-all keeps the first flattened commit when a merge sorts first' '
+	git reset --hard base &&
+	git checkout -b head-side &&
+	test_commit --no-tag head-merged &&
+	git checkout - &&
+	git merge --no-ff -m "merge head-side" head-side &&
+	test_commit --no-tag head-last &&
+	git rebase --autosquash --fixup-all base &&
+	test_cmp_rev base HEAD~1 &&
+	test_commit_message HEAD -m "head-merged" &&
+	test_path_is_file head-merged.t
+'
+
+test_expect_success '--fixup-all requires --autosquash' '
+	git reset --hard base &&
+	test_must_fail git rebase --fixup-all HEAD~1 2>err &&
+	test_grep "fixup-all requires --autosquash" err &&
+	test_must_fail git rebase --no-autosquash --fixup-all HEAD~1 2>err &&
+	test_grep "fixup-all requires --autosquash" err
+'
+
+test_expect_success '--fixup-all and --rebase-merges cannot be combined' '
+	git reset --hard base &&
+	test_must_fail git rebase --autosquash --rebase-merges \
+		--fixup-all HEAD~1 2>err &&
+	test_grep "cannot be used together" err &&
+	test_path_is_missing .git/rebase-merge
+'
+
 test_done
-- 
gitgitgadget
