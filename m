Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D88B125A9
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764260167; cv=none; b=XXXqfPUnANqgfl9/+AzycKQcxPE2zW1V2578aXOjcheuOvekR7yHjb4WWoSxW+0DED6ZPiQ0aTRd1Ux1Fet/gsCTpAaq2HQQH/jXQUJ4aLT0hRQR4ewzChWRvid/bFW41n2Jbg9zdnuSwJUldQ9Rvm2DFqp57ltWXGKkjj0vmIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764260167; c=relaxed/simple;
	bh=zMHg/vieTMS4MjmBQyZfRB9n0pSNw+JdSrH/ni/P3uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oY6tokBZ0pMpFN22rDwWFxE0WEkVjnKE/QyqRStuIUwkg8cIeBamanZVL9utR7RRgu6VHog4WXDPDjypiqXF6kFcCXtNGnNj+2nsh3/TFcvkTAjz2n8jQ0zTofE9UFVpaXlQcDZO80SlJ+AIl1Y7xP1/mv8qDAVUaFbEFunXxTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hI0CYyNg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hI0CYyNg"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso10184295e9.3
        for <git@vger.kernel.org>; Thu, 27 Nov 2025 08:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764260164; x=1764864964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AJ8vuzsPFdPHBr/Toa7R6iQZAYxWAeEPGeTfJkSP9Lc=;
        b=hI0CYyNgUvomNlN6gr1lXuHVy9HmDhqM/nv1sjuu5Bh7PlDYHl7aDA8S+RvMPDy/sJ
         XDloyxgTtKODzmbl9GCN3xnCOeNfaKUiRd0F4U9s4qF8ND+5umgciQxmwKJeCzeydGu/
         ySz72Y2Q02Ygo+28OypD9vPzR6G4hmyqyzN+P4n7Z964eUUsVmcNyo61LnzFyl26gNqa
         K9i5nz1uhAlmJvmaUUIsnpRqGu0kPVKAKRyjVVgzAAvQypmOObwFA0DpQFw5LO9Ro3ad
         4p7vv4147QVXQ7M0wjPAkXYkgY/E3z5GlHGiDCotYrhuO/21APKH7E2KxwBb+N4ZKbQs
         xGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764260164; x=1764864964;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AJ8vuzsPFdPHBr/Toa7R6iQZAYxWAeEPGeTfJkSP9Lc=;
        b=ZFXGX2rfP/WK+oiKPLfPoOHPlZTyPS3l01YSx6/Ved+B06UpOjJFKeEqzRN1UE94BK
         UZincs/1iTBUijoZkb8pmHdwtj6AEGRm05pNH0nakk2hXObyqKAX0QJH7d+CwPx++Uyn
         L31cYa7NDKlyxQSSK88YGljDVZVNFxBPYdh55gmKmrDxaRJdGOjIGrzUyPZSrKUR6SC9
         1yXtMx5f3R0y81W79jE73HtWooiEx28JyCeVWORMbpo20XofnWHDzAJFqaC6a0VhSunm
         Go/FEWsTFgnvmrBe6OC6y6hTNIploHBSY1PANCRlzEooGddRGvHSOoBd3VAylvLwT7uw
         NQxA==
X-Gm-Message-State: AOJu0YzqqxgySwF/3PCuzGkOHtFRCs4ZVcGhr4O22nSR51PDcbP/gtjG
	RPGJwapW8+5mcNBBl3hWKvRzAX+3baOChm19nucjP8oqE6ylt7uLNiWDDLhDEA==
X-Gm-Gg: ASbGncv4U3niuwcNFHtXrMYVy2liaCQXGIperf5yjtdbDcXrXW0wzKg4Y08i8xXYjkS
	WF8Ry0c1WwM6q+GJjjNdI9fSuaP+TsaE8PZShdydNGC8AgMKfwwTpHoZw4607cPKDcxKiCVOpOr
	Ju2zIic8x1o8lRstOP2ANAvWTSDNzxeE/m6gVsrdzOx5QLMClpi8vWaKT9JJTI2nkpmorJXPNSj
	ADHiGYDYNySM/1R/8GZxnAZvJXpV/NG5FJYvc4TjDEHteZXc9GX5X036l5eURZ1RAn6u+n9/8gb
	F0puPJ2IPgPOhfBIGrr4RdOqJW7oMDZSNQ596HBTgk3m3Apgqm0NhtEctst7G5tyJYfTw48j5nK
	z4vgkC46k5tSa3R2UrfHsHn6MtrGdBocbgMd6BGJFOoV+3WsxoXYAuVNhjF+dhenWLBqdRfdqlA
	n2i5LYir9wNC+55Q==
X-Google-Smtp-Source: AGHT+IH5tQgzShjys2fW4arWYMwOePBIjU3CNrMoNr7waGs402slB+yrdKxLGq5PYV0sHDN5+sbgow==
X-Received: by 2002:a05:600c:1f85:b0:477:7b30:a6fe with SMTP id 5b1f17b1804b1-477c1116013mr219140075e9.18.1764260164119;
        Thu, 27 Nov 2025 08:16:04 -0800 (PST)
Received: from berwick ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790addeeaasm103803495e9.7.2025.11.27.08.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 08:16:03 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] replay: drop commits that become empty
Date: Thu, 27 Nov 2025 16:15:54 +0000
Message-ID: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the changes in a commit being replayed are already in the branch
that the commits are being replayed onto then "git replay" creates an
empty commit. This is confusing because the commit message no longer
matches the contents of the commit. Drop the commit instead. Commits
that start off empty are not dropped. This matches the behavior of
"git rebase --reapply-cherry-pick --empty=drop" and "git cherry-pick
--empty-drop". If a branch points to a commit that is dropped it will
be updated to point to the last commit that was not dropped. This can
been seen in the new test where "topic1" is updated to point to the
rebased "C" as "F" is dropped because it is already upstream. While
this is a breaking change "git replay" is marked as experimental to
allow improvements like this that change the behavior.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
Elijah - I'm not really clear why we were setting result->tree before
calling merge_incore_nonrecursive(), was it just for convenience to
avoid declaring a local variable or have I missed something?

This patch is based on ps/history

I think dropping commits that become empty is the sensible default,
if it turns out that some users are relying on the current behavior
we can add an option to retain the empty commits.

Base-Commit: 4ac8283def34401e50908903b89fa22498bb23a2
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Freplay-drop-commits-that-become-empty%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/4ac8283de...8a2a12153
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/replay-drop-commits-that-become-empty/v1

 Documentation/git-replay.adoc |  4 +++-
 replay.c                      | 10 +++++++---
 t/t3650-replay-basics.sh      | 25 +++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index dcb26e8a8e8..96a3a557bf3 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -59,7 +59,9 @@ The default mode can be configured via the `replay.refAction` configuration vari
 	be passed, but in `--advance <branch>` mode, they should have
 	a single tip, so that it's clear where <branch> should point
 	to. See "Specifying Ranges" in linkgit:git-rev-parse[1] and the
-	"Commit Limiting" options below.
+	"Commit Limiting" options below. Any commits in the range whose
+	changes are already present in the branch the commits are being
+	replayed onto will be dropped.
 
 include::rev-list-options.adoc[]
 
diff --git a/replay.c b/replay.c
index 58fdc20140b..7cd7206eee5 100644
--- a/replay.c
+++ b/replay.c
@@ -88,12 +88,12 @@ struct commit *replay_pick_regular_commit(struct repository *repo,
 					  struct merge_result *result)
 {
 	struct commit *base, *replayed_base;
-	struct tree *pickme_tree, *base_tree;
+	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
 
 	base = pickme->parents->item;
 	replayed_base = mapped_commit(replayed_commits, base, onto);
 
-	result->tree = repo_get_commit_tree(repo, replayed_base);
+	replayed_base_tree = repo_get_commit_tree(repo, replayed_base);
 	pickme_tree = repo_get_commit_tree(repo, pickme);
 	base_tree = repo_get_commit_tree(repo, base);
 
@@ -103,13 +103,17 @@ struct commit *replay_pick_regular_commit(struct repository *repo,
 
 	merge_incore_nonrecursive(merge_opt,
 				  base_tree,
-				  result->tree,
+				  replayed_base_tree,
 				  pickme_tree,
 				  result);
 
 	free((char*)merge_opt->ancestor);
 	merge_opt->ancestor = NULL;
 	if (!result->clean)
 		return NULL;
+	/* Drop commits that become empty */
+	if (oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&
+	    !oideq(&pickme_tree->object.oid, &base_tree->object.oid))
+		return replayed_base;
 	return replay_create_commit(repo, result->tree, pickme, replayed_base);
 }
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index cf3aacf3551..d73ab16908a 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -25,6 +25,8 @@ test_expect_success 'setup' '
 	git switch -c topic3 &&
 	test_commit G &&
 	test_commit H &&
+	git switch -c empty &&
+	git commit --allow-empty --only -m empty &&
 	git switch -c topic4 main &&
 	test_commit I &&
 	test_commit J &&
@@ -106,6 +108,29 @@ test_expect_success 'using replay on bare repo to perform basic cherry-pick' '
 	test_cmp expect result-bare
 '
 
+test_expect_success 'commits that become empty are dropped' '
+	git replay --ref-action=print --advance main topic1^! >result &&
+	ONTO=$(cut -f 3 -d " " result) &&
+	git replay --ref-action=print --onto $ONTO \
+		--branches --ancestry-path=empty ^A >result &&
+	# Write the new value of refs/heads/empty to "new-empty" and
+	# generate a sed script that annotates the output of
+	# `git log --format="%H %s"` with the updated branches
+	SCRIPT="$(sed -e "
+		/empty/{
+			h
+			s|^.*empty \([^ ]*\) .*|\1|wnew-empty
+			g
+		}
+		s|^.*/\([^/ ]*\) \([^ ]*\).*|/^\2/s/\\\$/ (\1)/|
+		\$s|\$|;s/^[^ ]* //|" result)" &&
+	git log --format="%H %s" --stdin <new-empty >actual.raw &&
+	sed -e "$SCRIPT" actual.raw >actual &&
+	test_write_lines >expect \
+		"empty (empty)" "H (topic3)" G "C (topic1)" F M L B A &&
+	test_cmp expect actual
+'
+
 test_expect_success 'replay on bare repo fails with both --advance and --onto' '
 	test_must_fail git -C bare replay --advance main --onto main topic1..topic2 >result-bare
 '
-- 
2.52.0.362.g884e03848a9

