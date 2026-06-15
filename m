Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756413CF1FD
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512635; cv=none; b=CGbmz6k4s6zPB+bn2GPN9HuWhlWOYpr1cjQGlgC+9HhsItQjRr+pPPtlHty1FRVWRCWpaaUbQI5vuYCq6e3BBWgjshmvF8qPc/65vIQNea8rYyfzLe/8nVBQtXe981BbSphdwX+y0Mn59D3dw/Q6bIdBzOW5zIvg4F9WKZk1Gdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512635; c=relaxed/simple;
	bh=CFbW6lU93DTuT7XKoF24I7CijeG3vJrSXFQWhm4r6lA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YN/9PKzGwUydYNfy2CigxeQYZTUAY0OVxIsRBficmATync+uVyfWTquxPoSOPNIm3aZSXLCyW7cpDDOnX5P23udbft3IGMjikuK/+7xb0FWVJh05CdY2ZfyK075Ual7bZWgk5KH3Xmr2a2YxoBmBB0swVJuIbQMm2kv3VVv4ZEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnPzsNep; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnPzsNep"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51764768c36so44528161cf.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781512629; x=1782117429; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDGEm0H8i69HehstNqC3OZYMDdXHoyciX/2FOkFBjIg=;
        b=MnPzsNep/PyAxjVoBeBs3JBnoII3sqmIhTUvDOymC9St/bItssCVslTmETX/uIGxqP
         7Ven7uZUuYSu66EGM2egKMDuRUj1mDKgwepG/iG/c835NSnJUtdn9U4sT+hAke8ga6OP
         xnKxX+TzkWvF+jY4WharrrA7v/vQo06U9jv/q5lEnLjuk8AMR1hDkymZLA9NDgw7mU5L
         vHGWEgjsg7Daz94Z8P2ayxdWPfxBia1h5Gh2u4c7p3N9Y3FmtUUU2mpRd3vnIvs/xcTV
         lBXz/8M72I5nqorhWtulcSYYgr4CquWAZcwSMwTIYTKoqCTN3DUcvYZ768jRarWI7tWn
         0wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781512629; x=1782117429;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HDGEm0H8i69HehstNqC3OZYMDdXHoyciX/2FOkFBjIg=;
        b=jw4KoJcgB4Dm7rLy6hYbOURtxTOW7FysSvZ1JprWIP5HKx6xc08fRfud9VRiwR1mjZ
         rekxzCs8+vjiVQqRWxw5mOSbEkeKZ/6J7oKHsGJpW6rhdDLD4izSPWkfwtvQTKAJgcRl
         47cWlEHvq/LcUAfGg74C3IcLYVmyybtrPmRS0AuKAKKzA0+i7slnVjwn+GaaKcYCG31Q
         R7kCSlRUvvpouv6OKNljHnsn3JUlG9jCS9ckFK3C9Z9eeSvTq3GqZqQ06VF8f8YpDEao
         Z/Iq4aDn6lemJxmA6EawYZTL3wiO4yA7CcrGnd1xSUEnep4i6+juxtRNfwdYMgI+BAB5
         Z7jA==
X-Gm-Message-State: AOJu0YwyJjVWhzMRmFG2yFc+3nkCwOnxc0SD8BASAVWEbwOjBRrZ9pfI
	j4qeSL17HPG4Wt8MdjsqLI1xPYPHtv9kAZ+US9qk6CC12FSC99jmEfMOxJIjgrnQ
X-Gm-Gg: Acq92OEEpM61T8e0cUDvS1cHQNzbqDxRg7j2+J1iAKXDRLUD03qc8L6nk/UFuyPCZmc
	fLqKQ7/NMOHKLErXgW9gZneXnlo4Wax9wAV8PeAubGufUdklrwE0g0Okl1y4+whkYiBSSxc4NER
	/9L/yh0JCCTlbffCm2NUkBpjqsQNopkTOGaW06t68ghPdXPcASJWWqWt7BTfnfBZ0jGIfMi71dm
	2f5HP6dNjd8w1nt/njTagFCbJVoN6101cpzunhzUA3q/RP25AkDS6ctqUE2lBoeUy15q9mgA0Fm
	jlidtFMdJRKupEDfEhYUsMpP0tazexWCkuU9pKD8y3Tl4QNYphCHxpGvR0JnAqo3JJboZdlbb0u
	Me773NwVHLqpoqysLdkYQnmqdUPwtc8fdx/3r7oV2Delq+/xY7lawFqU5ErMODusA25mN967S6X
	7V0KCyY8TQftqbmf3BgSrsnlJ2IkHi
X-Received: by 2002:a05:622a:8312:b0:514:5d67:7a30 with SMTP id d75a77b69052e-519535e989fmr129587871cf.43.1781512628786;
        Mon, 15 Jun 2026 01:37:08 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.157.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7a2227sm100045001cf.16.2026.06.15.01.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:37:08 -0700 (PDT)
Message-Id: <22d4276ff59629c820e721e042f0b02d93b0693a.1781512625.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v2.git.git.1781512625.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 08:37:05 +0000
Subject: [PATCH v2 2/2] rebase: add --squash to fold a range
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

Add "git rebase --squash [<upstream>]" to do this directly. It keeps
the first commit in the range as a "pick" and turns every later commit
into a "fixup", so the whole range collapses into a single commit that
reuses the first commit's message. With no <upstream> argument the range
is "@{upstream}..HEAD", folding all unpushed commits into one.

The option implies the merge backend, so it works on its own without
--autosquash. Fold the commits in their original order, so that any
fixup!/squash! commits already present in the range are folded in as
well. Reject --rebase-merges since a merge commit cannot be folded into
another commit.

Inspired-by: Sergey Chernov <serega.morph@gmail.com>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-rebase.adoc |  11 ++++
 builtin/rebase.c              |  16 ++++-
 sequencer.c                   |  24 ++++++-
 sequencer.h                   |   2 +-
 t/t3415-rebase-autosquash.sh  | 117 ++++++++++++++++++++++++++++++++++
 5 files changed, 165 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..4244288148 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -602,6 +602,16 @@ option can be used to override that setting.
 +
 See also INCOMPATIBLE OPTIONS below.
 
+--squash::
+	Keep the first commit in the range as a `pick` and change every later
+	commit to a `fixup`, so the whole range is folded into a single commit
+	that reuses the first commit's message.  With no `<upstream>` argument
+	this folds all commits since `@{upstream}` into one.  The commits are
+	folded in their original order, so any `fixup!`/`squash!` commits
+	already in the range are folded in as well.  Cannot be combined with
+	`--rebase-merges`, as a merge commit cannot be folded into another
+	commit.
+
 --autostash::
 --no-autostash::
 	Automatically create a temporary stash entry before the operation
@@ -652,6 +662,7 @@ are incompatible with the following options:
  * --strategy
  * --strategy-option
  * --autosquash
+ * --squash
  * --rebase-merges
  * --interactive
  * --exec
diff --git a/builtin/rebase.c b/builtin/rebase.c
index fa4f5d9306..2df9f04728 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -118,6 +118,7 @@ struct rebase_options {
 	int allow_rerere_autoupdate;
 	int keep_empty;
 	int autosquash;
+	int squash;
 	char *gpg_sign_opt;
 	int autostash;
 	int committer_date_is_author_date;
@@ -329,7 +330,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	ret = complete_action(the_repository, &replay, flags,
 		shortrevisions, opts->onto_name, opts->onto,
 		&opts->orig_head->object.oid, &opts->exec,
-		opts->autosquash, opts->update_refs, &todo_list);
+		opts->autosquash, opts->squash, opts->update_refs,
+		&todo_list);
 
 cleanup:
 	replay_opts_release(&replay);
@@ -1205,6 +1207,8 @@ int cmd_rebase(int argc,
 		OPT_BOOL(0, "autosquash", &options.autosquash,
 			 N_("move commits that begin with "
 			    "squash!/fixup! under -i")),
+		OPT_BOOL(0, "squash", &options.squash,
+			 N_("fold all commits in the range into the first one")),
 		OPT_BOOL(0, "update-refs", &options.update_refs,
 			 N_("update branches that point to commits "
 			    "that are being rebased")),
@@ -1471,7 +1475,8 @@ int cmd_rebase(int argc,
 	if ((options.flags & REBASE_INTERACTIVE_EXPLICIT) ||
 	    (options.action != ACTION_NONE) ||
 	    (options.exec.nr > 0) ||
-	    options.autosquash == 1) {
+	    options.autosquash == 1 ||
+	    options.squash) {
 		allow_preemptive_ff = 0;
 	}
 	if (options.committer_date_is_author_date || options.ignore_date)
@@ -1594,6 +1599,13 @@ int cmd_rebase(int argc,
 	options.rebase_merges = (options.rebase_merges >= 0) ? options.rebase_merges :
 				((options.config_rebase_merges >= 0) ? options.config_rebase_merges : 0);
 
+	if (options.squash && options.rebase_merges)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--squash", "--rebase-merges");
+
+	if (options.squash)
+		imply_merge(&options, "--squash");
+
 	if (options.autosquash == 1) {
 		imply_merge(&options, "--autosquash");
 	} else if (options.autosquash == -1) {
diff --git a/sequencer.c b/sequencer.c
index 57855b0066..bb42b40796 100644
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
+		    unsigned squash, unsigned update_refs,
 		    struct todo_list *todo_list)
 {
 	char shortonto[GIT_MAX_HEXSZ + 1];
@@ -6581,7 +6599,9 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	if (update_refs && todo_list_add_update_ref_commands(todo_list))
 		return -1;
 
-	if (autosquash && todo_list_rearrange_squash(todo_list))
+	if (squash)
+		todo_list_fixup_all_but_first(todo_list);
+	else if (autosquash && todo_list_rearrange_squash(todo_list))
 		return -1;
 
 	if (commands->nr)
diff --git a/sequencer.h b/sequencer.h
index 3164bd437d..1d5a164f02 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -196,7 +196,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		    const char *shortrevisions, const char *onto_name,
 		    struct commit *onto, const struct object_id *orig_head,
 		    struct string_list *commands, unsigned autosquash,
-		    unsigned update_refs,
+		    unsigned squash, unsigned update_refs,
 		    struct todo_list *todo_list);
 int todo_list_rearrange_squash(struct todo_list *todo_list);
 
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 8964d1cc88..ce9abe5147 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -511,4 +511,121 @@ test_expect_success 'pick and fixup respect commit.cleanup' '
 	test_commit_message HEAD -m "something"
 '
 
+test_expect_success '--squash folds the range into the first commit' '
+	git reset --hard base &&
+	test_commit --no-tag fold1 file_fold a &&
+	test_commit --no-tag fold2 file_fold b &&
+	test_commit --no-tag fold3 file_fold c &&
+	git rebase --squash HEAD~3 &&
+	test_cmp_rev base HEAD~1 &&
+	test_commit_message HEAD -m "fold1" &&
+	echo c >expect &&
+	test_cmp expect file_fold
+'
+
+test_expect_success '--squash folds smoothly when a fixup! commit is in the series' '
+	git reset --hard base &&
+	test_commit --no-tag foldA file_fold a &&
+	test_commit --no-tag foldB file_fold b &&
+	git commit --allow-empty --fixup HEAD~1 &&
+	git rebase --squash HEAD~3 &&
+	test_cmp_rev base HEAD~1 &&
+	test_commit_message HEAD -m "foldA" &&
+	echo b >expect &&
+	test_cmp expect file_fold
+'
+
+test_expect_success '--squash picks the first commit even if it is a fixup!' '
+	git reset --hard base &&
+	test_commit --no-tag fixupbase file_fix a &&
+	git commit --allow-empty --fixup HEAD &&
+	test_commit --no-tag fixuptail file_fix b &&
+	git rebase --squash HEAD~3 &&
+	test_cmp_rev base HEAD~1 &&
+	echo b >expect &&
+	test_cmp expect file_fix
+'
+
+test_expect_success '--squash with a single commit in range is a no-op' '
+	git reset --hard base &&
+	test_commit --no-tag solo file_solo a &&
+	git rev-parse HEAD >expect &&
+	git rebase --squash HEAD~1 &&
+	git rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--squash with an empty range succeeds' '
+	git reset --hard base &&
+	git rebase --squash HEAD &&
+	test_cmp_rev base HEAD
+'
+
+test_expect_success '--squash skips a dropped commit in the range' '
+	git reset --hard base &&
+	test_commit --no-tag fixdrop1 file_drop a &&
+	git commit --allow-empty -m "empty in the middle" &&
+	test_commit --no-tag fixdrop3 file_drop b &&
+	git rebase --squash --empty=drop HEAD~3 &&
+	test_cmp_rev base HEAD~1 &&
+	test_commit_message HEAD -m "fixdrop1" &&
+	echo b >expect &&
+	test_cmp expect file_drop
+'
+
+test_expect_success '--squash folds a merge commit in the middle of the range' '
+	git reset --hard base &&
+	test_commit --no-tag mid-first &&
+	git checkout -b mid-side &&
+	test_commit --no-tag mid-merged &&
+	git checkout - &&
+	git merge --no-ff -m "merge mid-side" mid-side &&
+	test_commit --no-tag mid-last &&
+	git rebase --squash base &&
+	test_cmp_rev base HEAD~1 &&
+	test_commit_message HEAD -m "mid-first" &&
+	test_path_is_file mid-merged.t
+'
+
+test_expect_success '--squash keeps the first flattened commit when a merge sorts first' '
+	git reset --hard base &&
+	git checkout -b head-side &&
+	test_commit --no-tag head-merged &&
+	git checkout - &&
+	git merge --no-ff -m "merge head-side" head-side &&
+	test_commit --no-tag head-last &&
+	git rebase --squash base &&
+	test_cmp_rev base HEAD~1 &&
+	test_commit_message HEAD -m "head-merged" &&
+	test_path_is_file head-merged.t
+'
+
+test_expect_success '--squash takes precedence over --autosquash' '
+	git reset --hard base &&
+	test_commit --no-tag combo-first &&
+	test_commit --no-tag combo-mid &&
+	git commit --allow-empty --fixup HEAD~1 &&
+	test_commit --no-tag combo-last &&
+	git rebase --autosquash --squash base &&
+	test_cmp_rev base HEAD~1 &&
+	test_commit_message HEAD -m "combo-first"
+'
+
+test_expect_success '--squash folds the range with rebase.autosquash set' '
+	test_config rebase.autosquash true &&
+	git reset --hard base &&
+	test_commit --no-tag cfg-first &&
+	test_commit --no-tag cfg-last &&
+	git rebase --squash base &&
+	test_cmp_rev base HEAD~1 &&
+	test_commit_message HEAD -m "cfg-first"
+'
+
+test_expect_success '--squash and --rebase-merges cannot be combined' '
+	git reset --hard base &&
+	test_must_fail git rebase --rebase-merges --squash HEAD~1 2>err &&
+	test_grep "cannot be used together" err &&
+	test_path_is_missing .git/rebase-merge
+'
+
 test_done
-- 
gitgitgadget
