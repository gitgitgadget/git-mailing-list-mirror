Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320933ADA7
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708114; cv=none; b=U92NcuOS0ykHAHCXAxwpgwkZ/WjufwpLf3csDMpx73ltLGWLHBFZuXlRJvtTtbxuVFQIctPF5W+yb+KaQiFe3JdhxgHw53aBJjTYvB6dAwaH+6UlNp5fapDCwc3XGPr/tsY/nHZllL9aaxRm02Ld0sZBgZq3/GfCYO2tA2WN4C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708114; c=relaxed/simple;
	bh=jLVO1kiJglyOZhfgl3k0OPc1cZijPET9e5ocqdWyGis=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qL5hW59GuFA8aPv2SFbE1sYGOkM2rtNbv/NUBSfsGD9oZZ2nUIXc2P+LmRk51OChnbcjzfj/XRNLSNk7CFG42+Je8IkO41J4GJXRmjBc3ZjuGiJKtKm77HQIKH+905fyHjszSTV6XyPzufTKv3FbGtuCRgJIgumNICaV/zn9knA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJeiv9n/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJeiv9n/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf50c6f235so44557975ad.0
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 01:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784708112; x=1785312912; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ofqXfQbo6Qa09puKZJieuRBfQ/FDoz3avvxrT0Gyy1U=;
        b=XJeiv9n/gMgH2qaJTsRWMl49wTPeq/kf48BLAV1rlvmdnXJ9XJcCIv4f9wb1fdzjBB
         WZxL0jfE2KDN3lYDLg0ZHb7eJENMKH0l7qzLFnmw5x1D8PpW6r1C9Gn8ezjj94F+chef
         FnG0KMAHZ7tEqDKeKIe4iKwYAKvMykic4x7ny71e4ui+YPVHPJpx/PubrD2TG1Dz0/V4
         jRfR0kmM8hwP9sO5Rhudaf8NpG4ltM0RxhyeXPzRE2/NtOy/RzSHlhGlbLEeQxvMihfL
         Az8NBSUWLjiOlxAHnm6QQRSJ8VyjdDUI2LdbhA3kWHNUgOtvVKjwkeC6UBnhp1vWzm5x
         4bPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784708112; x=1785312912;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ofqXfQbo6Qa09puKZJieuRBfQ/FDoz3avvxrT0Gyy1U=;
        b=LZ5jS+SNGB046+zea1qVrRREfiIQkBv5fuMgs3UZka9nRtJJrV4o9mRD9EZmxkurpL
         5mLe0+J4NJRxEzyfmohilwWl6l+2D9mqcy5daaMJwXAYMElO+LxrXm9wc6ok6yHi+0gE
         KziwpkF2pUYUNvqwAOSSJCVrwucIeSgSDRj2StG50mOIyk+hrFGzcpVGn+zPK9LcwIrw
         cB4oEpMUIi+hVpjw9Xf0lRHrBOrdazjY5yF1bZCNO6MMAlY3r32j+zET/ha8LYCy0g1d
         zCGsywgKFzFSbkPhb8GqKJ2fheFGX8ggY8o0DCWV1kfyjGIGhW7am95sySA+91y4Aw08
         Gn7Q==
X-Gm-Message-State: AOJu0YwONXxTTboR4ywdjPh8HM/KAqFeT1IcqQm5UE4ZA5sIbHSTjyHM
	R9az4a5me9238B9BcIaF7UYQyfj8zrNG3lcUtNIREOeGfjoWFfFuyx+ZDTF3Ew==
X-Gm-Gg: AR+sD10zn/wYmxLg6Kxot85w+IiVBSthjljPJuNgUUwxGOrr2TqUVkrrqIvPE++ny1S
	r/bygbiWiTvaEyz9iPdxDmCPt9sq92QJ81zNilnplwmnZ9P/lyKR4eLvRPsz0kB7fQ1jDiGp/6x
	gZsufYyPxiNcoHq3cfMwPsRncBMOIEqfWp8LUncAtYX5QN9iadFrAHIvDLAmgnEkmNot3Zjje1S
	X1fzQ/zwX0ekRvFcQyURkBUhRJU/Nkh2sHTnR1mSLQt3b4lhvkJUcy76nhKWzKZb/DwI1rPuVCU
	QMJaIR06jSFn+EPI58AjBVeDlkHp3I3fRNBbzM/SrNcrGIrXaHr5hddG3L3hq1QFDLLlBYSt2EU
	7sniR7iJYkP5nry8okm/mkZrZnqZwmHI82KmZ0+tWSPCwEfxDJq11ewvhEd6nnsRBE40cbB/len
	u2QJEKug==
X-Received: by 2002:a17:903:2388:b0:2ca:f8ef:33dc with SMTP id d9443c01a7336-2cf349d0bcbmr229282715ad.40.1784708112115;
        Wed, 22 Jul 2026 01:15:12 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.253.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e621dsm10549825ad.48.2026.07.22.01.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:15:11 -0700 (PDT)
Message-Id: <a653f56ea214e74ea71ba31f5378f9cbf8b04dde.1784708107.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
References: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
	<pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
From: "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Jul 2026 08:15:06 +0000
Subject: [PATCH v3 2/2] rebase: guard non-branch symref targets
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Son Luong Ngoc <sluongng@gmail.com>,
    Son Luong Ngoc <sluongng@gmail.com>

From: Son Luong Ngoc <sluongng@gmail.com>

A local branch symbolic ref may point outside refs/heads/. Such an alias
cannot be skipped like a branch-to-branch alias because its concrete
target ref is absent from the local branch decoration list.

However, queuing each alias independently can update the same target ref
more than once and make the second compare-and-swap fail. A reservation
from another worktree can also name either an alias or its resolved
target ref, so checking only one form can miss an in-progress update.

Fix these cases by checking both the literal alias and its resolved
target ref against checked-out reservations. Deduplicate updates by
target ref. Also reserve both forms when loading another worktree's
update-refs state. This makes different aliases honor the same
in-progress update.

This keeps non-branch symrefs supported without allowing duplicate or
cross-worktree ref updates.

Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
---
 branch.c                      | 15 ++++++++
 sequencer.c                   | 19 +++++++++
 t/t3404-rebase-interactive.sh | 72 +++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)

diff --git a/branch.c b/branch.c
index 243db7d0fc..98a50d8368 100644
--- a/branch.c
+++ b/branch.c
@@ -442,10 +442,25 @@ static void prepare_checked_out_branches(void)
 						     &update_refs)) {
 			struct string_list_item *item;
 			for_each_string_list_item(item, &update_refs) {
+				char *resolved_ref;
+				int flags = 0;
+
 				old = strmap_put(&current_checked_out_branches,
 						 item->string,
 						 xstrdup(wt->path));
 				free(old);
+
+				resolved_ref = refs_resolve_refdup(
+					get_main_ref_store(the_repository),
+					item->string, RESOLVE_REF_READING,
+					NULL, &flags);
+				if (resolved_ref && (flags & REF_ISSYMREF)) {
+					old = strmap_put(
+						&current_checked_out_branches,
+						resolved_ref, xstrdup(wt->path));
+					free(old);
+				}
+				free(resolved_ref);
 			}
 			string_list_clear(&update_refs, 1);
 		}
diff --git a/sequencer.c b/sequencer.c
index 63aba60a08..040b5bf645 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6459,6 +6459,7 @@ struct todo_add_branch_context {
 	size_t items_alloc;
 	struct strbuf *buf;
 	struct string_list refs_to_oids;
+	struct string_list symref_update_targets;
 };
 
 static int add_decorations_to_list(const struct commit *commit,
@@ -6473,6 +6474,7 @@ static int add_decorations_to_list(const struct commit *commit,
 	while (decoration) {
 		struct todo_item *item;
 		const char *path;
+		const char *checked_ref;
 		char *resolved_ref;
 		int flags = 0;
 		size_t base_offset = ctx->buf->len;
@@ -6508,6 +6510,17 @@ static int add_decorations_to_list(const struct commit *commit,
 		}
 
 		path = branch_checked_out(decoration->name);
+		if (!path && resolved_ref && (flags & REF_ISSYMREF)) {
+			checked_ref = resolved_ref;
+			path = branch_checked_out(checked_ref);
+		}
+		if (!path && resolved_ref && (flags & REF_ISSYMREF) &&
+		    string_list_has_string(&ctx->symref_update_targets,
+					   resolved_ref)) {
+			free(resolved_ref);
+			decoration = decoration->next;
+			continue;
+		}
 
 		ALLOC_GROW(ctx->items,
 			ctx->items_nr + 1,
@@ -6523,6 +6536,10 @@ static int add_decorations_to_list(const struct commit *commit,
 					      decoration->name, path);
 		} else {
 			struct string_list_item *sti;
+
+			if (resolved_ref && (flags & REF_ISSYMREF))
+				string_list_insert(&ctx->symref_update_targets,
+						   resolved_ref);
 			item->command = TODO_UPDATE_REF;
 			strbuf_addf(ctx->buf, "%s\n", decoration->name);
 
@@ -6554,6 +6571,7 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
 	struct todo_add_branch_context ctx = {
 		.buf = &todo_list->buf,
 		.refs_to_oids = STRING_LIST_INIT_DUP,
+		.symref_update_targets = STRING_LIST_INIT_DUP,
 	};
 
 	ctx.items_alloc = 2 * todo_list->nr + 1;
@@ -6579,6 +6597,7 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
 	res = write_update_refs_state(&ctx.refs_to_oids);
 
 	string_list_clear(&ctx.refs_to_oids, 1);
+	string_list_clear(&ctx.symref_update_targets, 0);
 
 	if (res) {
 		/* we failed, so clean up the new list. */
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 11afa8be56..110ed8ae63 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -2024,6 +2024,78 @@ test_expect_success '--update-refs updates refs correctly' '
 	test_cmp expect err.trimmed
 '
 
+test_expect_success '--update-refs checks resolved non-branch symref target' '
+	test_when_finished "
+		git worktree remove --force checked-out-target-wt &&
+		git symbolic-ref -d refs/heads/non-branch-alias &&
+		git tag -d checked-out-target
+	" &&
+	git tag checked-out-target HEAD~1 &&
+	git symbolic-ref refs/heads/non-branch-alias refs/tags/checked-out-target &&
+	git worktree add --detach checked-out-target-wt checked-out-target &&
+	git -C checked-out-target-wt symbolic-ref HEAD refs/tags/checked-out-target &&
+
+	GIT_SEQUENCE_EDITOR="cat >todo" git rebase -i --update-refs HEAD~2 &&
+
+	test_grep "^# Ref refs/heads/non-branch-alias checked out at" todo &&
+	test_write_lines refs/tags/checked-out-target >expect &&
+	git symbolic-ref refs/heads/non-branch-alias >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--update-refs deduplicates non-branch symref targets' '
+	test_when_finished "
+		git symbolic-ref -d refs/heads/non-branch-alias-one &&
+		git symbolic-ref -d refs/heads/non-branch-alias-two &&
+		git tag -d shared-non-branch-target
+	" &&
+	git tag shared-non-branch-target HEAD~1 &&
+	git symbolic-ref refs/heads/non-branch-alias-one \
+		refs/tags/shared-non-branch-target &&
+	git symbolic-ref refs/heads/non-branch-alias-two \
+		refs/tags/shared-non-branch-target &&
+
+	GIT_SEQUENCE_EDITOR=: git rebase -i --force-rebase --update-refs HEAD~2 &&
+
+	test_cmp_rev HEAD~1 refs/heads/non-branch-alias-one &&
+	test_cmp_rev HEAD~1 refs/heads/non-branch-alias-two &&
+	test_write_lines refs/tags/shared-non-branch-target >expect &&
+	git symbolic-ref refs/heads/non-branch-alias-one >actual &&
+	test_cmp expect actual &&
+	git symbolic-ref refs/heads/non-branch-alias-two >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--update-refs honors non-branch symref reservations' '
+	test_when_finished "
+		test_might_fail git worktree remove --force reserved-target-wt &&
+		test_might_fail git symbolic-ref -d \
+			refs/heads/reserved-non-branch-alias-one &&
+		test_might_fail git symbolic-ref -d \
+			refs/heads/reserved-non-branch-alias-two &&
+		test_might_fail git tag -d reserved-non-branch-target
+	" &&
+	git tag reserved-non-branch-target HEAD~1 &&
+	git symbolic-ref refs/heads/reserved-non-branch-alias-one \
+		refs/tags/reserved-non-branch-target &&
+	git symbolic-ref refs/heads/reserved-non-branch-alias-two \
+		refs/tags/reserved-non-branch-target &&
+	git worktree add --detach reserved-target-wt HEAD &&
+	wt_gitdir=$(git -C reserved-target-wt rev-parse --absolute-git-dir) &&
+	mkdir -p "$wt_gitdir/rebase-merge" &&
+	old_oid=$(git rev-parse refs/heads/reserved-non-branch-alias-one) &&
+	test_write_lines refs/heads/reserved-non-branch-alias-one \
+		"$old_oid" "$old_oid" >"$wt_gitdir/rebase-merge/update-refs" &&
+
+	GIT_SEQUENCE_EDITOR="cat >todo" git rebase -i --update-refs HEAD~2 &&
+
+	test_grep "^# Ref refs/heads/reserved-non-branch-alias-one checked out at" \
+		todo &&
+	test_grep "^# Ref refs/heads/reserved-non-branch-alias-two checked out at" \
+		todo &&
+	test_grep ! "^update-ref refs/heads/reserved-non-branch-alias" todo
+'
+
 test_expect_success 'respect user edits to update-ref steps' '
 	git checkout -B update-refs-break no-conflict-branch &&
 	git branch -f base HEAD~4 &&
-- 
gitgitgadget
