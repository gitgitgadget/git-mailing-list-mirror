Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430358;
	b=m6BD7P0GbY+3koCDpnyBUxjaYPuGTSLe47FxMCILuBHUJDrz44N/Z0bP0PncgCyNKf4S
	 OSohCcBat/b7to2B5fK1Pdoqhm+x6KakPHaEIzrT7g+2pXv378VOgAEwN65ScSM7lNkkF
	 AkSrylMoczpE55+dSBd+M5YA718RVNvteByttWwH7UObPWG42qiycFUNVKmccuvb/eS26
	 o+Y9494JCD2zIAXqVkvHOsrzAWZHlVmdD9l1L7e8R7Gvyfdui2c2oquncAJnIENBn6nSj
	 xLbKImqz8Zuo9f3xSXtCZqM3FdLpjVavlXNIr0q00pyN1qZnqCjFiDMEDxqQe6frh5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ggeqjSthJYPDS39YVCC0omTEG03LONxH2XxlVSkYr/I=;
	b=Lt2voZfpod/8j9Hr0aS7IeLoaJ6ehCDs6tNk95jNEPMhUiInLZ2KxlDKAiXZygl6M4eM
	 AJnaB9SyG3eYrSpJt5d5g1mXLLp8aIjaOi1PA8HQqQjr3UdX/t0TgdDz7/1T+9Cr0YIlt
	 hIsBupp4sPwyhLzAAEof/eVkwb1BaUq0BmcKEAoqWbp0xmQ2mO8Qh0o0CROlj4fQedMdW
	 3SZz/KA8lgM9jXRIdvjdb+hYWqvYuduwYIwyjr8xw3YC9kwZWu7s0RnMOTq29kChSt7CJ
	 2CbQPOqGweg/riMSTlsD2EgSndzkqPXyvhb1bClgjyfgtzyJewvbWr1BXXmsIOju/Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OrtZ5wpx;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75653606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 10:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75653606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OrtZ5wpx
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1ae58d17cd9so2893235c88.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 02:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795430357; x=1796035157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ggeqjSthJYPDS39YVCC0omTEG03LONxH2XxlVSkYr/I=;
        b=OrtZ5wpxVCf9oSlIqZek3IwneYbD7Z8u69xDvKxTtDPurm4uS2gx8kLFMaf/Rq/22v
         KUJ9VLqKV+gGJdjqbXzn7F/8vm8eWl+ERNutO/9tZutH+LjN1cO1cuOWCoODK01VNLME
         GUgDO9kVGcwpEil98UqsKDOp2uLaGedt3lrA+1nC/LcXPwNAW5cXjthMV1gA7cCMkxB+
         HWQkX8spOS/0AkpPW7hW3Zh81LDAbYUathVidpLUHEu5gfJtanhEi2GZImhpSRzmk5CT
         YfSF1AEMm7smGjouT+cdZqiiffnE+eOjeciM0xi5NT1/fL5yEJNKztXYUYyY1PHdTnDH
         QH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795430357; x=1796035157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ggeqjSthJYPDS39YVCC0omTEG03LONxH2XxlVSkYr/I=;
        b=Er+8PpqAS4tcCO3WlBpYFVyJf2fXdr7nMXgJ3w758U4/5AOsaBTNZjuwIzY83wcRWr
         vw2qwflaRYl9Un4vWMtmO98ozYwvWKHjJefXc4dit9/PeT//+T3QrWFI7dJq0NHoAItU
         413IbACDT4w4TdXuGnyxVX3uqLgcTJyyt8l/8aPoNfJ/gzm7IAOFLP7VCpTjM46n3iw3
         IvUl4c8JvNmNjpAQGLVhdzmbnOAh8UoyWSfXHYB5Y7RsGUhvcGCDW9twFiwEukIWppCg
         UF+VJVvmhH4ZBEfepD44RLJkF6ggH2AILEAekz3w9gyYSrHqFdmCU44LVWS8H4/1g/tE
         Qf8Q==
X-Gm-Message-State: APuU4Z/y069rdYwcaeX8UfrBldJhKultiYMcjb/nitgRK4BrJm0Bv/ib
	FVF4JindWL8BsZXOowWz1FYA6AAWI/Bla2jPoS823qUigEZ82SPgmS05octQiZHIMQI=
X-Gm-Gg: AZFdTZehKG6hXFjjn1nOgObW6624PwH8uSaSCbEn43aLwmANrZ5rqoTjo38AizFB1gt
	RyyxkugVHKChdkqptK6vocNBw/zlyikqoyfNeof5Czf5K9rDbxRGi7k7V84JKzH+l3uGGGrO//L
	uCL53gkVruRpnwMjiuyMz/5oROvoNJ6pWSrZlRGBua89CAoSnCTwoynaMOYRmAYO4/+iUuTKOle
	EmxT4eS+GuJUQvdy92qNEH4TggEaCkT0zZxen++n52tkuT0Yw4Jynx+eb1R6LM0vCDFI/22/E1B
	MljnSyztqYsI+lP+JCdPO3ElX0lmhxd+BaHtqqg0vZpMie9ITeOjCDsvcOq0Q1zgC/aEKv+DnX6
	td0YTVR8XZjzLFR+BXefyuLzdBLY5vucD8N+rwjjsa5FwBtniPoUs1YUhKcFaajCD6sZiwKEbWX
	BCOipjzBUYzn7GDQQNcu0T91zVh9lgQo8jMu0RG0gVmpk5xxqPDskZRSJIaBwOzXoIASGgHAEtH
	vNtmLhLov8ByTJXEFSBsOe9+nddsVCqecjqSn6AlGWZPx/wYf3v1eowB6zV6EaWdwEm5k203F+u
	VUrgtV/ar7HxUuLh6NT9ak15hejTMwXvPQb2EWTuomA59d51EdaJSp5hxeOtnhtIF0FKdmvLjKf
	N18H/eYSAn8ylZbHTbIbx
X-Received: by 2002:a05:7023:b88:b0:1ac:d029:70cb with SMTP id a92af1059eb24-1b5568c5127mr14143681c88.30.1795430357354;
        Mon, 23 Nov 2026 02:39:17 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm25684250c88.0.2026.11.23.02.39.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 02:39:17 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Nikita Bobko <nikita@nbobko.com>
Subject: [PATCH] history: refuse to rewrite branches used by other worktrees
Date: Mon, 23 Nov 2026 16:09:11 +0530
Message-ID: <20261123103911.98860-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default "git history" also rewrites every local branch that descends
from the commit it changes. If another worktree has such a branch
checked out, the branch moves but the index and working tree of that
worktree stay behind. So it shows staged changes that nobody made. If
the current worktree is in the middle of rebasing the branch, "git
rebase --continue" later fails because the branch is not where the
rebase expects it.

"git branch -f" refuses to move such branches and "git rebase
--update-refs" skips them. Do the same here: before replaying anything
look for local branches that contain the commit and are used by a
worktree and refuse to go on if there is one. Use branch_checked_out()
so that a branch that is being rebased or bisected counts as used. Skip
the branch that the current worktree has checked out, since the command
already takes care of the index and working tree of that worktree.
Refuse with --dry-run as well because it will show what a real run will
do.

Mention --update-refs=head, which leaves the other branches alone, with
the existing advice.historyUpdateRefs hint.

Reported-by: Toon Claes <toon@iotcl.com>
Reported-by: Nikita Bobko <nikita@nbobko.com>
Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
Patrick suggested this in [1] and Toon said I could pick it up [2].
This is based on master as it changes behavior.

[1] https://lore.kernel.org/git/aob_LsfI9cO3PewF@pks.im/
[2] https://lore.kernel.org/git/8733ssj5zt.fsf@dev.null.iotcl.com.invalid/

 Documentation/config/advice.adoc |   7 +-
 Documentation/git-history.adoc   |   6 ++
 builtin/history.c                |  61 +++++++++++++++
 t/t3450-history.sh               | 128 +++++++++++++++++++++++++++++++
 4 files changed, 199 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 3d91c90eda..bb0e24b745 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -60,9 +60,10 @@ all advice messages.
 		Shown when the user tries to delete a not fully merged
 		branch without the force option set.
 	historyUpdateRefs::
-		Shown when `git history squash` refuses because a local branch
-		cannot be rewritten as a descendant of the squashed commit, to
-		tell the user about `--update-refs=head`.
+		Shown when `git history` refuses because a local branch is used
+		by another worktree, or, for `squash`, because it cannot be
+		rewritten as a descendant of the squashed commit, to tell the
+		user about `--update-refs=head`.
 	ignoredHook::
 		Shown when a hook is ignored because the hook is not
 		set as executable.
diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 1fcc30150a..ce7c0a88c8 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -215,6 +215,12 @@ empty.
 	`branches`, all local branches that point to commits which are
 	descendants of the original commit will be rewritten. With `head`, only
 	the current `HEAD` reference will be rewritten. Defaults to `branches`.
++
+A branch that is used by another worktree, or that the current worktree is
+in the middle of rebasing or bisecting, cannot be rewritten, as the index and
+working tree of that worktree would not match the rewritten branch. With
+`branches` the command refuses in that case, so use `head` to rewrite only
+the current branch.
 
 EXAMPLES
 --------
diff --git a/builtin/history.c b/builtin/history.c
index 43ba76f5a1..90f00f676d 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -2,6 +2,7 @@
 
 #include "builtin.h"
 #include "advice.h"
+#include "branch.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "commit-reach.h"
@@ -295,6 +296,62 @@ static int revwalk_contains_merges(struct repository *repo,
 	return ret;
 }
 
+/*
+ * Rewriting a branch that is used by another worktree moves the branch
+ * without updating the index and working tree of that worktree. The same
+ * goes for the branch that the current worktree is rebasing. Refuse to
+ * rewrite such branches, but not the branch that the current worktree has
+ * checked out, as we update that one ourselves.
+ */
+static int reject_checked_out_branches(struct repository *repo,
+				       struct commit *original)
+{
+	struct ref_filter filter = REF_FILTER_INIT;
+	struct ref_array refs = { 0 };
+	char *head_target;
+	int ret = 0;
+
+	head_target = refs_resolve_refdup(get_main_ref_store(repo), "HEAD",
+					  RESOLVE_REF_NO_RECURSE, NULL, NULL);
+
+	commit_list_insert(original, &filter.with_commit);
+	filter.kind = FILTER_REFS_BRANCHES;
+	if (filter_refs(&refs, &filter, filter.kind)) {
+		ret = error(_("could not filter refs"));
+		goto out;
+	}
+
+	for (int i = 0; i < refs.nr; i++) {
+		const char *refname = refs.items[i]->refname;
+		const char *branch, *path;
+
+		if (head_target && !strcmp(refname, head_target))
+			continue;
+
+		path = branch_checked_out(refname);
+		if (!path)
+			continue;
+
+		if (!skip_prefix(refname, "refs/heads/", &branch))
+			BUG("branch filter returned '%s'", refname);
+		error(_("cannot rewrite branch '%s' used by worktree at '%s'"),
+		      branch, path);
+		ret = -1;
+	}
+
+	if (ret)
+		advise_if_enabled(ADVICE_HISTORY_UPDATE_REFS,
+				  _("Use --update-refs=head to rewrite only "
+				    "the current branch and leave such branches "
+				    "untouched."));
+
+out:
+	free(head_target);
+	ref_filter_clear(&filter);
+	ref_array_clear(&refs);
+	return ret;
+}
+
 static int setup_revwalk(struct repository *repo,
 			 enum ref_action action,
 			 struct commit *original,
@@ -350,6 +407,10 @@ static int setup_revwalk(struct repository *repo,
 
 		strvec_push(&args, "HEAD");
 	} else {
+		ret = reject_checked_out_branches(repo, original);
+		if (ret < 0)
+			goto out;
+
 		strvec_push(&args, "--branches");
 		strvec_push(&args, "HEAD");
 	}
diff --git a/t/t3450-history.sh b/t/t3450-history.sh
index f513463b92..f7ca66edc6 100755
--- a/t/t3450-history.sh
+++ b/t/t3450-history.sh
@@ -14,4 +14,132 @@ test_expect_success 'raises an error with unknown argument' '
 	test_grep "unknown subcommand: .garbage." err
 '
 
+test_expect_success 'refuses to rewrite a branch checked out in another worktree' '
+	test_when_finished "rm -rf repo wt" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git worktree add ../wt -b other &&
+
+		git refs list >refs-expect &&
+		test_must_fail git history drop second 2>err &&
+		test_grep "^error: cannot rewrite branch .other. used by worktree at .*wt" err &&
+		test_grep "^hint: .* --update-refs=head" err &&
+		test_grep ! "branch .main." err &&
+		git refs list >refs-actual &&
+		test_cmp refs-expect refs-actual
+	)
+'
+
+test_expect_success 'refusing to rewrite checked out branches honors --dry-run' '
+	test_when_finished "rm -rf repo wt" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git worktree add ../wt -b other &&
+
+		test_must_fail git history drop --dry-run second >out 2>err &&
+		test_grep "^error: cannot rewrite branch .other. used by worktree at" err &&
+		test_must_be_empty out
+	)
+'
+
+test_expect_success 'advice.historyUpdateRefs silences the hint for checked out branches' '
+	test_when_finished "rm -rf repo wt" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git worktree add ../wt -b other &&
+
+		test_must_fail git -c advice.historyUpdateRefs=false \
+			history drop second 2>err &&
+		test_grep "^error: cannot rewrite branch .other. used by worktree at" err &&
+		test_grep ! "hint:" err
+	)
+'
+
+test_expect_success '--update-refs=head leaves branches of other worktrees alone' '
+	test_when_finished "rm -rf repo wt" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git worktree add ../wt -b other &&
+		git rev-parse other >other-expect &&
+
+		git history drop --update-refs=head second &&
+
+		git rev-parse other >other-actual &&
+		test_cmp other-expect other-actual &&
+		git log --format=%s main >actual &&
+		test_write_lines third first >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'rewrites the branch of the current worktree' '
+	test_when_finished "rm -rf repo wt" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		git worktree add ../wt -b other &&
+		test_commit -C ../wt second &&
+		test_commit -C ../wt third &&
+
+		git -C ../wt history drop second &&
+
+		git log --format=%s other >actual &&
+		test_write_lines third first >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'refuses to rewrite a branch that is being rebased' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		test_must_fail git rebase -x false first &&
+
+		git refs list >refs-expect &&
+		test_must_fail git history drop second 2>err &&
+		test_grep "^error: cannot rewrite branch .main. used by worktree at" err &&
+		git refs list >refs-actual &&
+		test_cmp refs-expect refs-actual &&
+
+		git rebase --abort
+	)
+'
+
+test_expect_success 'refuses to rewrite a branch that is being bisected' '
+	test_when_finished "rm -rf repo wt" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git worktree add ../wt -b other &&
+		git -C ../wt bisect start HEAD first &&
+
+		test_must_fail git history drop second 2>err &&
+		test_grep "^error: cannot rewrite branch .other. used by worktree at" err
+	)
+'
+
 test_done

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
2.54.0 (Apple Git-157)

