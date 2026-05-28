Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB80B34389E
	for <git@vger.kernel.org>; Thu, 28 May 2026 05:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946933; cv=none; b=iPZm93u73gBGn0xrcTe/zbKw8zV42oZMsBSCfZRfa0DRwB4iLqmvS4zFh9En0aC2BbWuvr5znJt6gity4xapZC2aE8S74FolWK/2PpGcMyrOrbv8DU0AaepKsTHjoaYYzT7TVcM9rCiKxtNtwZBlrzqyy+bV38WlG33c1D20ZUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946933; c=relaxed/simple;
	bh=BOggmc9vJ2PmKTBymzZHwiw/gFyHL+LQ1l/kPMgZF+c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XOZPbcjB6LFQUNiGN/2jb6zk0giOxlanvTDOJAmT2uURNmcevGF+fx5azpGziFLkf6JPNCGq4lzngkF1+FVwpR/Y2O1rqDE7HeApmg5pFv/r3jQYsrj5NVtsyDezyKmlj+Dy2rjUTNJsk/l3I8BsQuiPI6n7594UiuAAx5imDXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEptFDCM; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEptFDCM"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69de16f5e80so787953eaf.0
        for <git@vger.kernel.org>; Wed, 27 May 2026 22:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779946931; x=1780551731; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SD2lh/if50ZXfJaPuKv7ba1+jrsl2XhwvFMHJ53CJ8c=;
        b=OEptFDCMSlwaufQF2iOiahgnCpJY9ciR/Dp039lZypUZahGPajzBvIy4u775+alCdA
         quRogWqH1PVLlOVhCDrveIV/6Jt1frCpfpvg9unHXp+UMiYZWBY1jF3fuj2M47AgN7Xn
         9UuUVcfSGxH1ZIP6SnrH3gzYNiYQoHYBKocGsj5+C1KCvwTKEeGk1lJP5S0HVsDrEImH
         vXVf8Yi1IyGihBhKPfAL9l4fZ7eW5IlLugLdZb+ipC0rmnY+zhM8hQZh1pbCcckWN2Fu
         wKrjH1b70q5tLyLI/MQs7dCn/IlpFOP2sYIxTRAq/Jsz1WikatliOaChmYrUrvqwltCh
         ZXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946931; x=1780551731;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SD2lh/if50ZXfJaPuKv7ba1+jrsl2XhwvFMHJ53CJ8c=;
        b=VgHuN2lWVlPgSAy3aGl1tmo0y4rii7wiYJb23Rus47n+nS6cAVdHIWut/3mMlxMP1r
         T7stcl3cNLUogNYVCJxQK8MeUp0bIhZRzIOHb61slPC7ZhGqT73g90NkbHY1ikEdaHwz
         D8uozsO6NmqE6Vuu/S9CZkz5NrTcuKadJNhVAEdhOjGYEbFEuyjbvtlYfFo2adHE0DPb
         i/Xz5OezV6ThvTV1K2GkYQooWFX9Sp1bIWPD/+0oyjt6DiCHfTJr4TLpWls5jdzOdL9r
         aMYDhYR7fzgbQURi4i0iHhlcMj0/FwPr1yRGwGehbk84GiNQrN5SHk64UU7Q1tQ0i8p1
         sxqw==
X-Gm-Message-State: AOJu0Yw0tinwUIcYcjc/IcZEVnWFP2hKXCkXcV+0PcWuHEULtpLLuTVS
	s9N7BY7OiWL2sqVQIfZme/rRluoV0eOtWXgi7a1D53/O9cI/fwxvgpJc2BqdGQ==
X-Gm-Gg: Acq92OH5NbI7i/B/NeLKSWVJRppLQ+rJCWKWR73ntL7hKu0yRUuYtBr2LsDrPP1zhR9
	Rs3DDCidjKIPB7zyznB+nFYAJUeEjZLbs/HvqVLGDsgiWHmhAmx27BpgIT40aHKqcfKkq+GAhMv
	i48x5h9rK9Zn6JnFQv9gEuOGVmq3aCZIZDmywPE5BjGX48EKDhS8Md3GVg8rGiAlzpm6PHOTnWb
	v9DUZxV67u/fNg+yAb61LmPo9UkyrnHF+ZCPtfEH6Bl0XalEfHi/RJVpFoj/OITIttrniAahR0p
	+vXEwKW9PLQabKt7iRpzGCtwa7hl43TnuaFUfetJuT8TvhYzjJr1j52ply+Gx7CXh4dFHjpKpfZ
	E7aBMal3Nm/u7pXc42E1tFYR4TAvvtIvbQwmKyQfbpIegXJamWGY61pqtYwM6G2GKgctnt8DEyt
	ZKz2fKJ37JxZ3zUQZ/FEcls9UZuv55aZUaEG8=
X-Received: by 2002:a05:6820:222a:b0:69b:5696:e63f with SMTP id 006d021491bc7-69d7ebbfcb2mr12235081eaf.24.1779946930718;
        Wed, 27 May 2026 22:42:10 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.21.50])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d90813a6bsm9190749eaf.0.2026.05.27.22.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:42:09 -0700 (PDT)
Message-Id: <0ab0a717441e9fc7c494da194065a948a35a7f01.1779946921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2126.git.1779946921.gitgitgadget@gmail.com>
References: <pull.2126.git.1779946921.gitgitgadget@gmail.com>
From: "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 May 2026 05:42:01 +0000
Subject: [PATCH 2/2] rebase: skip branch symref aliases
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
Cc: Son Luong Ngoc <sluongng@gmail.com>,
    Son Luong Ngoc <sluongng@gmail.com>

From: Son Luong Ngoc <sluongng@gmail.com>

rebase --update-refs records local branch decorations before replaying
commits. If a decoration is a symbolic branch such as refs/heads/main
pointing at refs/heads/master, updating it later dereferences back to
master and can fail because the normal rebase path already moved that
branch.

Resolve local branch symref decorations to their referents before
queuing update-ref commands, and skip duplicates. This keeps branch
aliases from scheduling a second update for the same underlying branch
while still using the existing old-OID check for the single queued
update.

Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
---
 sequencer.c                   | 63 +++++++++++++++++++++++++++++------
 t/t3404-rebase-interactive.sh |  2 +-
 2 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1ee4b2875b..4a83d1337c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6445,15 +6445,22 @@ static int add_decorations_to_list(const struct commit *commit,
 				   struct todo_add_branch_context *ctx)
 {
 	const struct name_decoration *decoration = get_name_decoration(&commit->object);
-	const char *head_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						       "HEAD",
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	const char *head_ref = refs_resolve_ref_unsafe(refs, "HEAD",
 						       RESOLVE_REF_READING,
-						       NULL,
-						       NULL);
+						       NULL, NULL);
+	char *resolved_head_ref = refs_resolve_refdup(refs, "HEAD",
+						       RESOLVE_REF_READING,
+						       NULL, NULL);
+	struct strbuf update_ref = STRBUF_INIT;
 
 	while (decoration) {
 		struct todo_item *item;
 		const char *path;
+		const char *ref = decoration->name;
+		const char *resolved_ref;
+		int is_symref = 0;
+		int flags = 0;
 		size_t base_offset = ctx->buf->len;
 
 		/*
@@ -6461,12 +6468,44 @@ static int add_decorations_to_list(const struct commit *commit,
 		 * updated by the default rebase behavior.
 		 * Exclude it from the list of refs to update,
 		 * as well as any non-branch decorations.
+		 *
+		 * Resolve branch symrefs after checking for the current HEAD so
+		 * that aliases do not schedule duplicate updates for their
+		 * referents.
+		 *
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
+		if (head_ref && !strcmp(head_ref, ref)) {
+			decoration = decoration->next;
+			continue;
+		}
+
+		strbuf_reset(&update_ref);
+		resolved_ref = refs_resolve_ref_unsafe(refs, ref,
+						       RESOLVE_REF_READING |
+						       RESOLVE_REF_NO_RECURSE,
+						       NULL, &flags);
+		if ((flags & REF_ISSYMREF) && resolved_ref) {
+			if (!starts_with(resolved_ref, "refs/heads/")) {
+				decoration = decoration->next;
+				continue;
+			}
+
+			strbuf_addstr(&update_ref, resolved_ref);
+			ref = update_ref.buf;
+			is_symref = 1;
+		}
+
+		if ((is_symref && resolved_head_ref &&
+		     !strcmp(resolved_head_ref, ref)) ||
+		    string_list_has_string(&ctx->refs_to_oids, ref)) {
 			decoration = decoration->next;
 			continue;
 		}
@@ -6478,19 +6517,19 @@ static int add_decorations_to_list(const struct commit *commit,
 		memset(item, 0, sizeof(*item));
 
 		/* If the branch is checked out, then leave a comment instead. */
-		if ((path = branch_checked_out(decoration->name))) {
+		if ((path = branch_checked_out(ref))) {
 			item->command = TODO_COMMENT;
 			strbuf_commented_addf(ctx->buf, comment_line_str,
 					      "Ref %s checked out at '%s'\n",
-					      decoration->name, path);
+					      ref, path);
 		} else {
 			struct string_list_item *sti;
 			item->command = TODO_UPDATE_REF;
-			strbuf_addf(ctx->buf, "%s\n", decoration->name);
+			strbuf_addf(ctx->buf, "%s\n", ref);
 
 			sti = string_list_insert(&ctx->refs_to_oids,
-						 decoration->name);
-			sti->util = init_update_ref_record(decoration->name);
+						 ref);
+			sti->util = init_update_ref_record(ref);
 		}
 
 		item->offset_in_buf = base_offset;
@@ -6501,6 +6540,8 @@ static int add_decorations_to_list(const struct commit *commit,
 		decoration = decoration->next;
 	}
 
+	strbuf_release(&update_ref);
+	free(resolved_head_ref);
 	return 0;
 }
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 42ba8cc313..29447c0fc3 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1978,7 +1978,7 @@ test_expect_success '--update-refs ignores non-branch decorations' '
 	test_cmp expect actual
 '
 
-test_expect_failure '--update-refs skips branch symrefs to current branch' '
+test_expect_success '--update-refs skips branch symrefs to current branch' '
 	test_when_finished "
 		test_might_fail git rebase --abort &&
 		git checkout primary &&
-- 
gitgitgadget
