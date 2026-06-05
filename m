Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825A5380FCD
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685375; cv=none; b=FDK8Obf/IcbFq2FMpeVbCz9ubFT3FJ+QH1w1EkpiiF+0UKE3EGazQtgxfRfqvkxhmdstAgzJMhmzPh+UKdQ+THLTjwJJsaRxgQ6ow/4Rg8u8FHyO0wrYxwhs4a+pMLCH6RTou9I0qq6+7O6E9Rg4WMzLVOj7bRFUokbX6ys6RVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685375; c=relaxed/simple;
	bh=3SnXU4r4C5ZxI6TjRfrqI7OHtxngZafcP8D8L2rxFMs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UAOyCGg0MfJnjgGBtR/KuhfUxqy0MhKTU/xTm5IdMMtT7lKI39ZfhDYMQJsXjeHaq7gcz0SEeb41LdREcTJ8P6EiF5TUPIUC9h4FpJlQ3rMbvKN4nDGnqBu7AEUfXBHY3T+qmPxeeAqk7ZUZYPuP+PiVVqthLTYf1tvGop8r8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzUK3exJ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzUK3exJ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9157b949fc7so285540585a.3
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 11:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780685371; x=1781290171; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/esw9eSny1fR0rP7VJOG5PFM7CZhzO0RL8SR/tBz9Zo=;
        b=LzUK3exJFkuShsqza7l1/ZTPraSv/uz0NBBFBOe32sirXCP7AJ4gc+YrJZDMAskxix
         I2y3A58XqGUh38hIFnTyHrdThTu9EHzuHoi1zdJm2BFm6gOmfUpGKHDeDkSZfyCnvBWd
         moO2e33WvJcsKL6bKT9qG9MTb4FwcTwn2yiYN23oOWjbBl1sgbIMxZCZ2/kxBcmYwk/Q
         HFzzUv6VMECPLZ0UOOo40cEgj2tAn28YKywTvXRz8BTNr3Zuvw2A1eTIin9lpQwoHA7r
         59GBq4JEGB6Wv+LIbP6HpZXd403PGmm+cbQipKthObyeyShjIuA/Muq3HGrTDOPFAorP
         ldKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780685371; x=1781290171;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/esw9eSny1fR0rP7VJOG5PFM7CZhzO0RL8SR/tBz9Zo=;
        b=DUSdn2o3X98YuPc77vXUXKmW6DeRUnReR4+N4gF59exqmlYvcqh2YUTEEBmmeXz8+J
         WyobCDru9x3aCOogBsRI9/gBtuoyo0+SVz0MICzFa06IS5v29uS8Fo66ucXK5inQVBCd
         yki2UmoBdyjtAnhSS3VaMQeAg6WO4fnuYtR+U5i9v2YJ9XAfqx8qQ4eNttoFkk6SzAjM
         0Sdk1qbJpNRvH8RzJJQ/X2BTyy14I92+hqpQ5ukHlWSO4omKS3VYSRHQstrGZmUZhUJm
         ePlGt1NfTz6hb0FW4dolZsl9QfXKLNuir0umpK784tmk1ayJPxVRiVeAqaUEASLMcmcq
         Hy6Q==
X-Gm-Message-State: AOJu0Yym5ZYzsxqYckEeP1lvIK+fveNUhfYEJx14xXo1fqwr9PzhWWEx
	eTS5xc3uy6fQyIBZL0ucD/b6FYYbT/6N0JiSESxB3tq6/ks7jlvuCRgFS8vyIg==
X-Gm-Gg: Acq92OFKrMfpHr1disr3syNZdnjNGYxTsXFiBLnSwA0t/NuDb3ira8L1JIp+sQ9yx2L
	flOOphBatvVCcQw4qEB453H9lNswoekkkaDeoobSyJ1YVo/BUThJa6++VGg2TnK+tQft1VO+xOL
	GP9MuF0RvjFLIZfqKc+Z7RMUcEZgPsvRaHvFYVtST6ZGBLslOD5QHaAAy52kSESv0O6APG2lIVK
	xIzBZvB+xseWg8H+SYoJwPd93B/Bc1vDbogXRXERvGpRzUkKiTvdWPBg3AVUWgCT751Qs5NhF6y
	W+8NSeF1z7FMNVuj9g9/1uhFvNbiYOHt74Qjkg0Fs6XQrUE75Iea5pp3qBgOOhWiXNBeat7qcH3
	cH218WqUZ56vnY80Ds7dGVNPiG2EZSbInhzzsVUFK6lNkd44ixM5Yfrtiy0AUUGaLgI/F6LMWVA
	T6LnMe9vH6ET7NPt+ItTJrSAU/sj6vRebMOTRd
X-Received: by 2002:a05:620a:2602:b0:915:9531:f6da with SMTP id af79cd13be357-915a9c4af1bmr879415685a.3.1780685371299;
        Fri, 05 Jun 2026 11:49:31 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.126.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd277bbcsm87668206d6.49.2026.06.05.11.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:49:30 -0700 (PDT)
Message-Id: <97f0fdad9bd32aa5eeb6fc2d524823df55e5b61e.1780685368.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
From: "Jason Newton via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Jun 2026 18:49:28 +0000
Subject: [PATCH 2/2] worktree: allow sharing a checked-out branch across
 worktrees
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
Cc: Jason Newton <nevion@gmail.com>,
    Jason Newton <nevion@gmail.com>

From: Jason Newton <nevion@gmail.com>

When spinning up several worktrees on the same checkout for parallel
work (for example a fleet of agents working from one branch), git's
refusal to check out a branch that is already checked out elsewhere is
just in the way. The restriction exists to stop two worktrees from
moving the same branch underneath each other, but plain parallel
checkouts do not need that protection.

Drop the restriction: "git worktree add <branch>" now checks out a
branch even if it is in use by another worktree. The genuinely
dangerous case is kept -- a branch that another worktree is in the
middle of rebasing or bisecting is still refused, because a second
checkout could corrupt that operation. die_if_branch_busy() performs
that narrower check in place of the old die_if_checked_out(). The
separate guard against force-updating (e.g. with -B) a branch in use
elsewhere is left untouched.

Signed-off-by: Jason Newton <nevion@gmail.com>
---
 Documentation/git-worktree.adoc | 17 +++++++++--------
 builtin/worktree.c              | 30 +++++++++++++++++++++++++++++-
 t/t2400-worktree-add.sh         | 31 ++++++++++++++++++++++++-------
 3 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index 1ca81718b7..cc4c91b787 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -93,8 +93,9 @@ then, as a convenience, the new worktree is associated with a branch (call
 it _<branch>_) named after `$(basename <path>)`.  If _<branch>_ doesn't
 exist, a new branch based on `HEAD` is automatically created as if
 `-b <branch>` was given.  If _<branch>_ does exist, it will be checked out
-in the new worktree, if it's not checked out anywhere else, otherwise the
-command will refuse to create the worktree (unless `--force` is used).
+in the new worktree, even if it is already checked out in another worktree.
+(A branch that another worktree is in the middle of rebasing or bisecting is
+refused unless `--force` is used.)
 +
 If _<commit-ish>_ is omitted, neither `--detach`, or `--orphan` is
 used, and there are no valid local branches (or remote branches if
@@ -177,12 +178,12 @@ OPTIONS
 
 `-f`::
 `--force`::
-	By default, `add` refuses to create a new worktree when
-	_<commit-ish>_ is a branch name and is already checked out by
-	another worktree, or if _<path>_ is already assigned to some
-	worktree but is missing (for instance, if _<path>_ was deleted
-	manually). This option overrides these safeguards. To add a missing but
-	locked worktree path, specify `--force` twice.
+	`add` refuses to create a new worktree when _<commit-ish>_ is a
+	branch that another worktree is in the middle of rebasing or
+	bisecting, or if _<path>_ is already assigned to some worktree but
+	is missing (for instance, if _<path>_ was deleted manually). This
+	option overrides these safeguards. To add a missing but locked
+	worktree path, specify `--force` twice.
 +
 `move` refuses to move a locked worktree unless `--force` is specified
 twice. If the destination is already assigned to some other worktree but is
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 973da33051..b457b015d1 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -648,6 +648,34 @@ static void setup_alternate_ref_dir(struct worktree *wt, const char *wt_git_path
 	strbuf_release(&sb);
 }
 
+/*
+ * Checking out a branch that is already checked out in another worktree is
+ * fine -- it is exactly what you want when spinning up several worktrees on
+ * the same checkout for parallel work. The one case that is still unsafe is a
+ * branch that another worktree is in the middle of rebasing or bisecting,
+ * since a second checkout could corrupt that operation, so refuse only that.
+ */
+static void die_if_branch_busy(const char *branch)
+{
+	struct worktree **worktrees = get_worktrees();
+	int i;
+
+	for (i = 0; worktrees[i]; i++) {
+		const struct worktree *wt = worktrees[i];
+
+		if (is_worktree_being_rebased(wt, branch) ||
+		    is_worktree_being_bisected(wt, branch)) {
+			const char *shortname = branch;
+
+			skip_prefix(branch, "refs/heads/", &shortname);
+			die(_("'%s' is already used by worktree at '%s'"),
+			    shortname, wt->path);
+		}
+	}
+
+	free_worktrees(worktrees);
+}
+
 static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
@@ -675,7 +703,7 @@ static int add_worktree(const char *path, const char *refname,
 	    refs_ref_exists(get_main_ref_store(the_repository), symref.buf)) {
 		is_branch = 1;
 		if (!opts->force)
-			die_if_checked_out(symref.buf, 0);
+			die_if_branch_busy(symref.buf);
 	}
 	commit = lookup_commit_reference_by_name(refname);
 	if (!commit && !opts->orphan)
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 56fb79179a..6a1eb72ac7 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -40,10 +40,24 @@ test_expect_success '"add" using - shorthand' '
 	test_cmp expect actual
 '
 
-test_expect_success '"add" refuses to checkout locked branch' '
-	test_must_fail git worktree add zere main &&
-	test_path_is_missing zere &&
-	test_path_is_missing .git/worktrees/zere
+test_expect_success '"add" can check out a branch in use by another worktree' '
+	test_when_finished "git worktree remove -f zere || :" &&
+	git worktree add zere main &&
+	echo refs/heads/main >expect &&
+	git -C zere symbolic-ref HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'the same branch can be checked out in several worktrees' '
+	test_when_finished "git worktree remove -f shared1 || :; git worktree remove -f shared2 || :" &&
+	git branch -f sharedbr main &&
+	git worktree add shared1 sharedbr &&
+	git worktree add shared2 sharedbr &&
+	echo refs/heads/sharedbr >expect &&
+	git -C shared1 symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
+	git -C shared2 symbolic-ref HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'checking out paths not complaining about linked checkouts' '
@@ -304,10 +318,13 @@ test_expect_success '"add" checks out existing branch of dwimd name' '
 	)
 '
 
-test_expect_success '"add <path>" dwim fails with checked out branch' '
+test_expect_success '"add <path>" dwim shares a checked out branch' '
 	git checkout -b test-branch &&
-	test_must_fail git worktree add test-branch &&
-	test_path_is_missing test-branch
+	git worktree add test-branch &&
+	echo refs/heads/test-branch >expect &&
+	git -C test-branch symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
+	git worktree remove test-branch
 '
 
 test_expect_success '"add --force" with existing dwimd name doesnt die' '
-- 
gitgitgadget
