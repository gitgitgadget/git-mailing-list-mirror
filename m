Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C5B473C89
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708113; cv=none; b=Ju9u7X9fmaxs6+h87Bl2dQtIU+6Kc3eZiZFleHFFehfY5AG6CtcvTYNTXIXzrJg5r8e4JUeoeDpe+qCo+LV3r0IfDQfqmgZmeL0n0VaXrk0kuNpCw3QqjewZ19Jucngfk4gta8VOYpX1rsjGZ8+e5qbU1BandqsLjwMy9XbpbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708113; c=relaxed/simple;
	bh=BBYV1Sffig7bFoZXKjSwdDZwoqPR6X8A5DiCPSaeiNo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SqQNECDRXddR52iQ7URBBjVkvpboMhNd7NWHncKUlLMhL08jFzdZnLDf8bV09LePcToAVs6rp/RTIPlPe8G4mhkPXgGyKeRxmzZ7GnkPE+O3S+m4KXIlZPe0naOjLvhw7si8DwTAA8UKUg4KjaPRtYPwPsXhjl/KAZPSG8wpam0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKRWYsSF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKRWYsSF"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc891373e0so153407935ad.2
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 01:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784708111; x=1785312911; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v1nsI58ZhQHlZ2rAjJMBGUipIlD3EqK6Az21Y6hVpcs=;
        b=dKRWYsSFMNqFzcMT8ANMuOlPq8AOZjjRau5dEJ7Hj+3Qt3ygdZOho0TCUZ/ZJ+Sm5w
         +BKy3sflCcGnddupLXqmvVm2HutvI2l31uORr041J+OCkAh0NXZyya5ghB+YuEMIPd7n
         LHZ0WCDikEi4XYDrtIXQMQDzWQUv5K2XTDx7pGhfRJwMXQB3bTbOZuuh60Daeqn4+aCf
         dJ0u4ihv1q9Wf/7LUKciHYuIOUn+F/8IxYiQwKm53+BQGU+C9lQpGcDKyWIz7mqcaN8q
         JN+Xzb9ORhrwMR2VxdHH+yf0nl1KYvxyBxi2fsWVrGWslllEmSdy2/iRZXylQVvHimgk
         UURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784708111; x=1785312911;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v1nsI58ZhQHlZ2rAjJMBGUipIlD3EqK6Az21Y6hVpcs=;
        b=YjzyOkqW/nbBmtyUJ6a5JSndp8ANLFNKfmolKRarluguTafLijmXSfzJUtosPDBqOY
         +B9qm2TibHRToxb5yfh3rrIKzP4YGi2KhwRL+IHbZzc/R0HbRPLhm1QEEh7PGBS7RR9w
         0AMPIViD1wKPXNsDKXxiPqkqfA1B24ZCWIjwepsN37CjfWSDeOB7Eo13j/66dMc69hnu
         hM3GGH/4I/R4kDJ/lILhf9piIxUku6OrF/PedINvlK5F2m1vW0ZTPi7vI+VDsRR4GIbT
         dxpazlFROESum+J34qWb3u00t4ItaXVkNs3JvluNIyS5RqPtwkNhaSo0Jg8rZpzB9P+X
         3SrA==
X-Gm-Message-State: AOJu0YysKtm31sAs3x4fQ9FBw+dpjnAMMjZBEgcmU5+QtfDQItWq/RYu
	Tbws+VGm1EWSYorOFMLwQaU398Bv+O1UT3UEzDWIUC9QzvG0j91i2F4QqN7dCfG7
X-Gm-Gg: AR+sD121bLUtKuj8/qzaWbu7WjyVlGSPWLyJFPgrQaGkOD3axmDzTdIFDblB6qbOVPw
	gitUqZjLPYherAxRce9NRGgMDfMQFAVtL69WCGHOVzJXvAOxsEvQjh4psLfc8z0hlAvAFaha+rE
	C3wW7Oj45yx330pIkBUHVgrNKTaD3HOJM+eshkhZfnDGspQ37i/9W31hVERtbox57UvVIFELgNv
	FpNEFCQJhpHQMFEVEFXGTKIMwudpjdfAgi90RvhFPFge3jARhLArI/7n5gyETGDFNAjbeO21SkI
	h+7O0EDwERvL02DTbBSFV+8+Kj9qZ6ko4n/OSxxcWRt2a21ZLmHtcYnuKI4twPn6MJldVv+bhgS
	MSjQ1vo6O67zD8mmIgNNgTDsYsYYNcvSdShrY6N3RD5bYLbawVLXYMA1iDx76iTmt41oDqD6Xkd
	jDPY7Pgw==
X-Received: by 2002:a05:6a20:1713:b0:3c3:8651:b302 with SMTP id adf61e73a8af0-3c3ad7ac447mr17374785637.28.1784708110592;
        Wed, 22 Jul 2026 01:15:10 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.253.38])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df06864sm6687279eec.15.2026.07.22.01.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:15:09 -0700 (PDT)
Message-Id: <b9a01e9141d580606527cb1a658c7c72710fb013.1784708107.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
References: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
	<pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
From: "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Jul 2026 08:15:05 +0000
Subject: [PATCH v3 1/2] rebase: skip branch symref aliases
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

git rebase --update-refs can finish rewriting the current branch and
then fail while updating a local branch that is a symbolic ref. This can
happen during a default-branch rename where refs/heads/main points at
refs/heads/master while users migrate.

The problem is a partially applied ref update: the main rebase has
already succeeded when the later ref update fails.

The sequencer queues updates from local branch decorations. Commit
106b6885c7 (rebase: ignore non-branch update-refs) filters out
decorations such as HEAD and tags. A branch symref is still a local
branch decoration, but refs_update_ref() dereferences it, so an alias to
another branch duplicates the concrete branch update.

Resolve local branch decorations before queuing them. Skip symrefs whose
targets are under refs/heads/ so that only the concrete branch update is
queued. Keep an owned copy of the resolved HEAD and skip the current
branch before checked-out handling so later ref resolution cannot change
the comparison.

This prevents a successful rebase from being followed by a failed,
partially applied ref update while preserving each alias as a symref.

Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
---
 sequencer.c                   | 44 +++++++++++++++++++++++++----------
 t/t3400-rebase.sh             |  2 +-
 t/t3404-rebase-interactive.sh | 16 +++++++++++++
 3 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1355a99a09..63aba60a08 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6465,32 +6465,50 @@ static int add_decorations_to_list(const struct commit *commit,
 				   struct todo_add_branch_context *ctx)
 {
 	const struct name_decoration *decoration = get_name_decoration(&commit->object);
-	const char *head_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						       "HEAD",
-						       RESOLVE_REF_READING,
-						       NULL,
-						       NULL);
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	char *head_ref = refs_resolve_refdup(refs, "HEAD",
+					     RESOLVE_REF_READING,
+					     NULL, NULL);
 
 	while (decoration) {
 		struct todo_item *item;
 		const char *path;
+		char *resolved_ref;
+		int flags = 0;
 		size_t base_offset = ctx->buf->len;
 
 		/*
-		 * If the branch is the current HEAD, then it will be
-		 * updated by the default rebase behavior.
-		 * Exclude it from the list of refs to update,
-		 * as well as any non-branch decorations.
 		 * Non-branch decorations may be present if the pretty format
 		 * includes "%d", which would have loaded all refs
 		 * into the global decoration table.
 		 */
-		if ((head_ref && !strcmp(head_ref, decoration->name)) ||
-		    (decoration->type != DECORATION_REF_LOCAL)) {
+		if (decoration->type != DECORATION_REF_LOCAL) {
+			decoration = decoration->next;
+			continue;
+		}
+
+		resolved_ref = refs_resolve_refdup(refs, decoration->name,
+						      RESOLVE_REF_READING,
+						      NULL, &flags);
+		if (resolved_ref && (flags & REF_ISSYMREF) &&
+		    starts_with(resolved_ref, "refs/heads/")) {
+			free(resolved_ref);
+			decoration = decoration->next;
+			continue;
+		}
+
+		/*
+		 * If the branch is the current HEAD, then it will be
+		 * updated by the default rebase behavior.
+		 */
+		if (head_ref && !strcmp(head_ref, decoration->name)) {
+			free(resolved_ref);
 			decoration = decoration->next;
 			continue;
 		}
 
+		path = branch_checked_out(decoration->name);
+
 		ALLOC_GROW(ctx->items,
 			ctx->items_nr + 1,
 			ctx->items_alloc);
@@ -6498,7 +6516,7 @@ static int add_decorations_to_list(const struct commit *commit,
 		memset(item, 0, sizeof(*item));
 
 		/* If the branch is checked out, then leave a comment instead. */
-		if ((path = branch_checked_out(decoration->name))) {
+		if (path) {
 			item->command = TODO_COMMENT;
 			strbuf_commented_addf(ctx->buf, comment_line_str,
 					      "Ref %s checked out at '%s'\n",
@@ -6518,9 +6536,11 @@ static int add_decorations_to_list(const struct commit *commit,
 		item->arg_len = ctx->buf->len - base_offset;
 		ctx->items_nr++;
 
+		free(resolved_ref);
 		decoration = decoration->next;
 	}
 
+	free(head_ref);
 	return 0;
 }
 
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index e62e07b894..1a02f6546b 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -471,7 +471,7 @@ test_expect_success 'git rebase --update-ref with core.commentChar and branch on
 	GIT_SEQUENCE_EDITOR="cat >actual" git -c core.commentChar=% \
 		 rebase -i --update-refs base &&
 	test_grep "% Ref refs/heads/wt-topic checked out at" actual &&
-	test_grep "% Ref refs/heads/topic2 checked out at" actual
+	test_grep ! "% Ref refs/heads/topic2 checked out at" actual
 '
 
 test_done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e64816770a..11afa8be56 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1975,15 +1975,23 @@ test_expect_success '--update-refs ignores non-branch decorations' '
 	) &&
 	grep ^update-ref todo >actual &&
 	test_write_lines "update-ref refs/heads/no-conflict-branch" >expect &&
+	test_grep ! "^# Ref refs/heads/update-refs checked out" todo &&
 	test_cmp expect actual
 '
 
 test_expect_success '--update-refs updates refs correctly' '
+	test_when_finished "
+		test_might_fail git symbolic-ref -d refs/heads/no-conflict-branch-alias &&
+		test_might_fail git symbolic-ref -d refs/heads/second-alias
+	" &&
 	git checkout -B update-refs no-conflict-branch &&
 	git branch -f base HEAD~4 &&
 	git branch -f first HEAD~3 &&
 	git branch -f second HEAD~3 &&
 	git branch -f third HEAD~1 &&
+	git symbolic-ref refs/heads/no-conflict-branch-alias \
+		refs/heads/no-conflict-branch &&
+	git symbolic-ref refs/heads/second-alias refs/heads/second &&
 	test_commit extra2 fileX &&
 	git commit --amend --fixup=L &&
 
@@ -1991,8 +1999,16 @@ test_expect_success '--update-refs updates refs correctly' '
 
 	test_cmp_rev HEAD~3 refs/heads/first &&
 	test_cmp_rev HEAD~3 refs/heads/second &&
+	test_cmp_rev HEAD~3 refs/heads/second-alias &&
 	test_cmp_rev HEAD~1 refs/heads/third &&
 	test_cmp_rev HEAD refs/heads/no-conflict-branch &&
+	test_cmp_rev HEAD refs/heads/no-conflict-branch-alias &&
+	test_write_lines refs/heads/no-conflict-branch >expect &&
+	git symbolic-ref refs/heads/no-conflict-branch-alias >actual &&
+	test_cmp expect actual &&
+	test_write_lines refs/heads/second >expect &&
+	git symbolic-ref refs/heads/second-alias >actual &&
+	test_cmp expect actual &&
 
 	q_to_tab >expect <<-\EOF &&
 	Successfully rebased and updated refs/heads/update-refs.
-- 
gitgitgadget

