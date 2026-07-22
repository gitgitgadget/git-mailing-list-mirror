Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB321DDC35
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708112; cv=none; b=YEEOyQCug1QfO6oGsVTTGbayFEZCEPjUDkkI1R2E8V30L1XOYmrr24OEuJKyXlpOFlT4PNNGlLhke9/7jPn6eU+5d5Qj5lQ6ddA+T8Yc6WfDm0rVz6IsbORqy6SDR7hRZt+Cde/dVXF7VEUEmjGJHI3+SA2l+9Ki7vNCNpQw4Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708112; c=relaxed/simple;
	bh=fcb5RyM7um/cxRxir2DWCrONVVgQzLxqQKU31PtSuy0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jrq3yUyh2Mktp5U2O3ZGCajulKfcTvWMIcQ9D7v8Pm7KCoTDnyxVc+wVj9tRGRCNjUITHLT61ksn1JcmuOVRulqczRFavaMDT5y1Y5rSjroYfx9CEoJ4w8ewBbGDNmcn3Lr/lpcB/Iu9NjgaLCtalbQiVuIgEu0tk767g/SOv1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGYVpaWM; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGYVpaWM"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso5560348a12.2
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784708109; x=1785312909; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vKuncHk6R6XZPL52ErmAi+EIkX1H+5qrXTt06yMA450=;
        b=gGYVpaWMLqxZeDfO7lB4avKk7Cva3zlib5OouXyBk15DlPHMhR9vrE2ClEG+BRGkLe
         drc5sGjPzuQc+WScqTIRh8jVBq50YsuePga7p7aCilZvzrXmjVRG56Unrx4zE7k8A7gV
         lsce8ntJDSD8L7IRNVz1EMueP5BKkHiq8kFGPIcqTv/bjJpOz0EL4t4GqP1pclxruhtu
         seLZp/cvylZ/Lo2ic0PAPUX6VFK0CEd+HfOIXG7Ue4Awi5bDuYetTH5n0mxPZOWeXNxB
         prCHAmw0LPsKA338EJjzIN2sH5mDHpsk9kBQDlw1jWne65x5eqdSeaz/hhKV/qynZup9
         rj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784708109; x=1785312909;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vKuncHk6R6XZPL52ErmAi+EIkX1H+5qrXTt06yMA450=;
        b=pTuo/DIAsfUeO4vfuMlc0T3xDSbdzrY+/wwTKsaysi8G2WlZjr1sNcND4kMpVO7DTz
         TFSELdS/Ux4mTlwJRAXdKdm6PyYDRZAgY5PytHizutvvq2TCIXh6lKfllj5wy/+cBb0a
         6wBjFdioj7v/gyxEKGYr0ia9WdfZ00uh8vwW7bxjCHdHWx5gHXC6EWpvvpb/4L+b6kQS
         iBgMDeYgvWQmq/Fv+UaOBqXBpr75/DZj7qaIWqMSmY7zjpPTFhEltxId5VtLiQqbylnw
         89eqwC+oJt1nRG89ZygbQYOdIngekH8PqAbykj9feX/VcvhAh0HwfZ6ctbSJyKhnAIlv
         kcQQ==
X-Gm-Message-State: AOJu0YwEK1g3F+z0gvqhBAnqZWzOQzoAB0nE+mM7Iiti/dkbBs8QS6Ps
	6Rd304a4IgWaia/rZan+YQQFAxcYD014CD6T4hWE2AfMz7wi1SmpnQqfOk9FoA==
X-Gm-Gg: AR+sD118nLkE4xyCGU4fO5QBAlxecagb503PPznWoMphsRP7LlJSw11FFmc9d4Z4+q8
	Nyz338iStQKnKugedvQvdFhuRzohh+/H8lxpC+DqpqkDdSMkLxAquFM6I4BlgBHTbiykMCadfXy
	HAlnrOmlntd7mErUiWpOGgW8DROAYKftbYeBjWtoR8dGkkah1ZAG3dAzdscDttx28C0L5g6bWj4
	JxNtK/R9v9cVx9guZXMxdNvoOlEAPavMZwRaaNiZC7CUXqWsutxiBc45AcJdgwaed4ZIpgE+Fo0
	hEBcF+PvBoIrFGYj2NYMYTEdBnSzELMX9i9X9TJ7sa/vp7s4PMacrvgRk1GN333+j3/zuuuLpJn
	tIbx7JVCl+yv9L+Ibrf0limaJpCFYscXG3KTqdyWn5zgN8EpOWgAbN8G62s3NK+2+6p/5Ry1m25
	eEQ3c9eg==
X-Received: by 2002:a05:6300:2285:b0:3c3:6c90:65b3 with SMTP id adf61e73a8af0-3c3adb086f8mr23411742637.65.1784708109045;
        Wed, 22 Jul 2026 01:15:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.253.38])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc7d8fbsm7338913eec.10.2026.07.22.01.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:15:08 -0700 (PDT)
Message-Id: <pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
In-Reply-To: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
References: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
From: "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Jul 2026 08:15:04 +0000
Subject: [PATCH v3 0/2] rebase: handle --update-refs branch symrefs
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
    Son Luong Ngoc <sluongng@gmail.com>

git rebase --update-refs can finish rewriting the current branch and then
fail while updating a local branch that is a symbolic ref. This can happen
during a default-branch rename where refs/heads/main points at
refs/heads/master while users migrate. The failure leaves refs partially
updated even though the main rebase has succeeded.

Resolve local branch decorations before adding update-ref commands. The
first patch skips aliases whose targets are other branches and preserves the
existing handling of the current branch. The second patch keeps aliases to
non-branch refs supported while preventing duplicate and cross-worktree
updates to their resolved targets.

Changes since v2:

 * Skip branch-to-branch symrefs before checked-out handling.
 * Restore the unconditional current-branch skip and keep an owned copy of
   the resolved HEAD name.
 * Check both a non-branch symref alias and its resolved target against
   checked-out reservations.
 * Deduplicate aliases that share a non-branch target.
 * Reserve resolved targets from other worktrees' in-progress update-refs
   state.
 * Split the branch-alias fix and non-branch safeguards into separate
   patches.
 * Rebase onto 48bbf81c29 (The 5th batch).

The focused t3400 and t3404 test suites pass with both the files and
reftable backends.

Son Luong Ngoc (2):
  rebase: skip branch symref aliases
  rebase: guard non-branch symref targets

 branch.c                      | 15 ++++++
 sequencer.c                   | 63 ++++++++++++++++++++-----
 t/t3400-rebase.sh             |  2 +-
 t/t3404-rebase-interactive.sh | 88 +++++++++++++++++++++++++++++++++++
 4 files changed, 155 insertions(+), 13 deletions(-)


base-commit: 48bbf81c29ca9a4479ec7850fe206518682cdb2f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2126%2Fsluongng%2Fsl%2Frebase-update-refs-symrefs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2126/sluongng/sl/rebase-update-refs-symrefs-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2126

Range-diff vs v2:

 1:  68f698225c ! 1:  b9a01e9141 rebase: skip branch symref aliases
     @@ Metadata
       ## Commit message ##
          rebase: skip branch symref aliases
      
     -    git rebase --update-refs can fail after the normal rebase path has
     -    updated the current branch when another local branch is a symref to it.
     -    This can happen during a default-branch rename where refs/heads/main
     -    points at refs/heads/master while users migrate.
     +    git rebase --update-refs can finish rewriting the current branch and
     +    then fail while updating a local branch that is a symbolic ref. This can
     +    happen during a default-branch rename where refs/heads/main points at
     +    refs/heads/master while users migrate.
      
     -    The sequencer queues update-ref commands from local branch decorations.
     -    Commit 106b6885c7 (rebase: ignore non-branch update-refs) filters out
     -    decorations that are not local branches, such as HEAD and tags. A branch
     -    symref is different: it is still a local branch decoration, but if it
     -    resolves to another branch then that target branch is itself present in
     -    the decoration list and will be updated as a concrete branch.
     +    The problem is a partially applied ref update: the main rebase has
     +    already succeeded when the later ref update fails.
      
     -    Skip branch decorations whose symrefs resolve to refs/heads/*, because
     -    those targets are already represented by concrete branch decorations.
     -    This prevents aliases from scheduling a second update for the same
     -    branch. Keep symrefs to non-branch targets on the existing path.
     +    The sequencer queues updates from local branch decorations. Commit
     +    106b6885c7 (rebase: ignore non-branch update-refs) filters out
     +    decorations such as HEAD and tags. A branch symref is still a local
     +    branch decoration, but refs_update_ref() dereferences it, so an alias to
     +    another branch duplicates the concrete branch update.
      
     -    Preserve the existing checked-out branch handling before applying these
     -    skips. Such refs still need a todo-list comment instead of an update-ref
     -    command, even when the checked-out ref is the branch being rebased or a
     -    branch symref alias. Use a copy of the resolved HEAD ref so later ref
     -    resolution does not overwrite it.
     +    Resolve local branch decorations before queuing them. Skip symrefs whose
     +    targets are under refs/heads/ so that only the concrete branch update is
     +    queued. Keep an owned copy of the resolved HEAD and skip the current
     +    branch before checked-out handling so later ref resolution cannot change
     +    the comparison.
     +
     +    This prevents a successful rebase from being followed by a failed,
     +    partially applied ref update while preserving each alias as a symref.
      
          Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
      
     @@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
       	while (decoration) {
       		struct todo_item *item;
       		const char *path;
     -+		const char *resolved_ref;
     ++		char *resolved_ref;
      +		int flags = 0;
       		size_t base_offset = ctx->buf->len;
       
     @@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
      +			continue;
      +		}
      +
     -+		path = branch_checked_out(decoration->name);
     -+
     -+		/*
     -+		 * If the branch is the current HEAD, then it will be
     -+		 * updated by the default rebase behavior. Exclude it from
     -+		 * the list of refs to update, unless it is checked out and
     -+		 * needs a comment in the todo list.
     -+		 */
     -+		if (!path && head_ref && !strcmp(head_ref, decoration->name)) {
     ++		resolved_ref = refs_resolve_refdup(refs, decoration->name,
     ++						      RESOLVE_REF_READING,
     ++						      NULL, &flags);
     ++		if (resolved_ref && (flags & REF_ISSYMREF) &&
     ++		    starts_with(resolved_ref, "refs/heads/")) {
     ++			free(resolved_ref);
      +			decoration = decoration->next;
      +			continue;
      +		}
      +
     -+		resolved_ref = refs_resolve_ref_unsafe(refs, decoration->name,
     -+						       RESOLVE_REF_READING,
     -+						       NULL, &flags);
     -+		if (!path && resolved_ref && (flags & REF_ISSYMREF) &&
     -+		    starts_with(resolved_ref, "refs/heads/")) {
     ++		/*
     ++		 * If the branch is the current HEAD, then it will be
     ++		 * updated by the default rebase behavior.
     ++		 */
     ++		if (head_ref && !strcmp(head_ref, decoration->name)) {
     ++			free(resolved_ref);
       			decoration = decoration->next;
       			continue;
       		}
     + 
     ++		path = branch_checked_out(decoration->name);
     ++
     + 		ALLOC_GROW(ctx->items,
     + 			ctx->items_nr + 1,
     + 			ctx->items_alloc);
      @@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
       		memset(item, 0, sizeof(*item));
       
     @@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
       			strbuf_commented_addf(ctx->buf, comment_line_str,
       					      "Ref %s checked out at '%s'\n",
      @@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
     + 		item->arg_len = ctx->buf->len - base_offset;
     + 		ctx->items_nr++;
     + 
     ++		free(resolved_ref);
       		decoration = decoration->next;
       	}
       
     @@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
       }
       
      
     + ## t/t3400-rebase.sh ##
     +@@ t/t3400-rebase.sh: test_expect_success 'git rebase --update-ref with core.commentChar and branch on
     + 	GIT_SEQUENCE_EDITOR="cat >actual" git -c core.commentChar=% \
     + 		 rebase -i --update-refs base &&
     + 	test_grep "% Ref refs/heads/wt-topic checked out at" actual &&
     +-	test_grep "% Ref refs/heads/topic2 checked out at" actual
     ++	test_grep ! "% Ref refs/heads/topic2 checked out at" actual
     + '
     + 
     + test_done
     +
       ## t/t3404-rebase-interactive.sh ##
      @@ t/t3404-rebase-interactive.sh: test_expect_success '--update-refs ignores non-branch decorations' '
     + 	) &&
     + 	grep ^update-ref todo >actual &&
     + 	test_write_lines "update-ref refs/heads/no-conflict-branch" >expect &&
     ++	test_grep ! "^# Ref refs/heads/update-refs checked out" todo &&
     + 	test_cmp expect actual
       '
       
       test_expect_success '--update-refs updates refs correctly' '
 -:  ---------- > 2:  a653f56ea2 rebase: guard non-branch symref targets

-- 
gitgitgadget
