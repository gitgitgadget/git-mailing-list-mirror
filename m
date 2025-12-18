Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C2630FC22
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766076643; cv=none; b=rW0CziUiwT9yX/HGG8w2nA6ELAWINSBktxDcHV00EbvfK20sOE9CPnJHioL8KYKYDwhUn5UY9VXCLlH97nWyyvaoMR0/XZzwHdE01Z7+hekjzBa6MVEs4LJK4HCwcRV/pJ6g6C9J8sINYr9C5h0bX0cADwc6zbPVn9Z51sv0gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766076643; c=relaxed/simple;
	bh=5Ppu3i9XM1+1op8gn+dtXffTucCuQn/5rjppTBixKeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlvsBDUORU856G4AQUmPJ7GJLJbZkbN6T4laDSAk5MTqvq0BTgDCdp1KXBZEmXI+3e49PFwpXRGhjN6DJA4p6m6F9XDllnKZY/hp7HLA9/4S/kGBzEWSc/zhHeh3mRWpByr6AENt7q3vt0900bhny/hDCOJrOWBBbDYKf5bMp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZFIRiFR; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZFIRiFR"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso1027525e9.1
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 08:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076640; x=1766681440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4OWiRjOZaJsMZf1yVn3b8KTQBKl0286OzP+0vm0bhPc=;
        b=IZFIRiFR/H1k9uOWr08YpxQWKjlqOyp2NycCctyec1UU7BgF5m+d6XajuufpVKTXfa
         U7Rm8XfQBrq8+onxr83kaORNdyyAEvPHieFclYXegfNUfJJcY/7Qe6/2yhdR5MeJhuh3
         fp9CqpJe0PwxWq36zOMEvwb6k9P2mrd7qf8cno4MKXFc80GNrSjAxtwfcxb20kIig68S
         FeB2HuRkehqfOdDyqXI8vqUE/h0EFACyGpUhPCt1LsLdQq3d3/JnLyzdYRCUDKM+SL+6
         Uq4U4rYpHxFmS2VIg92cNQqn8vd8t0JbYwv84RjQ28PElnhpBh6Z+u4LcbxZ0BlHW1KG
         54XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076640; x=1766681440;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OWiRjOZaJsMZf1yVn3b8KTQBKl0286OzP+0vm0bhPc=;
        b=gmNyIj5utRXFxjDVKRE1SBSkRi5NE9TRSrFNdeBRYBbFPd3aJFN9daEMaALqH/dSfu
         xkA4LKuTSlKOVSfOPEpniN0nF6vK1Q6+reyFw/r7NbhX4YeA9VJdQkAETLfwFwss6qc9
         ccKALHLuMFu8B9xiO/O44/+YX4MJ5Lm+IEvX8olkKGQTyukgr7zi6+Rwj56hvTF/F6j/
         C/7NREn4/Rh/rl09ruxsy0Elo6gKCQiK4wxPqo427LsjNgvBKqWA0W5R8rIlyYN8yxoY
         cAdq86pys+cgIsUw11Kv1FDtCpkN6K9oSVnZGgOsJsaoIAFl4O2W0XOY4nrDRQPfNTJ7
         cMNA==
X-Gm-Message-State: AOJu0Yw0krSCa+lWJFC/91MzWo2EYJKYYYdC6z9Y9lJVPbeidYlIlK9t
	3eTxF7VOTFn+KH1tYTP8XZUgfVwgW+sirVo6x20u6RyqMLQsHzL0bRoAqF1eu1vt
X-Gm-Gg: AY/fxX6EtuHIkM12vAoggsEST6RuWWhxRnvW0YDNiyZ4Mf3T4R/6BCicSNQ5HYORbcP
	AxtgEB3M34JFUGgPNxFd1usqWdz6SKaAW9DZVo36dOZAbG8qFKRIRISKB18qx/RJdzkdioDUG/R
	Dem8qy75xE2v3hb36VXGq8KY7DoGgw6r/ofVvWNXf9yOimSYiMhPtaHZg+Hh6+8jGQQmZKgT+r7
	oYrPmU6JeydhqqfJoWuMSAsUIRdzGACAL14RMO/yPsuQPwWIABgyQvh9uvWRKlgEJywBYeg380a
	BJ5a7Iz02Qux8RFEjls73DyVOxmoUzNx6G0BOu7P7S57iJICNDGEf/4OJHFTDU0qpanGwutrZ6/
	WS/7dKruU70mOUh3mrhyRxKocjTlGc8ndDjFraWOL52bfHY5FHXsZ4C31Hof1ZRU790uQMv5OaL
	uUWF/hg6wSnkY28Vk=
X-Google-Smtp-Source: AGHT+IEyyn6hNw5coKUVY7y174K4hMKev9mvE+DNkDXSoRs1wDwgbQ7Y47zm5rg5wwIhsCK0+YPVmQ==
X-Received: by 2002:a05:600c:3e10:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-47a8f8ab731mr232145705e9.5.1766076639951;
        Thu, 18 Dec 2025 08:50:39 -0800 (PST)
Received: from berwick ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b09sm5907984f8f.9.2025.12.18.08.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:50:38 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4] replay: drop commits that become empty
Date: Thu, 18 Dec 2025 16:50:26 +0000
Message-ID: <375adc4e941f3bb22a2b12ee26a083951ed724dd.1766076625.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
References: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
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
that the commits are being replayed onto, then "git replay" creates an
empty commit. This is confusing because the commit message no longer
matches the contents of the commit. Drop the commit instead. Commits
that start off empty are not dropped. This matches the behavior of
"git rebase --reapply-cherry-pick --empty=drop" and "git cherry-pick
--empty-drop".

If a branch points to a commit that is dropped it will be updated
to point to the last commit that was not dropped. This can be seen
in the new test where "topic1" is updated to point to the rebased
"C" as "F" is dropped because it is already upstream. While this is
a breaking change, "git replay" is marked as experimental to allow
improvements like this that change the behavior.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
Changes since v3:

 - dropped "--only" when creating an empty commit

Changes since v2:

 - added a couple of commas to the commit message as suggested by Junio

Changes since v1:

 - modified test to update refs as suggested by Elijah. I've kept
   --ancestry-path --branches rather than switching to --contained as
   I think it is useful to have test coverage for those options and it
   means we can check that empty commits are dropped with out replying
   on --contained working.

This patch is based on ps/history

I think dropping commits that become empty is the sensible default,
if it turns out that some users are relying on the current behavior
we can add an option to retain the empty commits.

Base-Commit: d37c42ea661434c347d2047f01b338341099fa60
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Freplay-drop-commits-that-become-empty%2Fv4
View-Changes-At: https://github.com/phillipwood/git/compare/d37c42ea6...375adc4e9
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/replay-drop-commits-that-become-empty/v4

 Documentation/git-replay.adoc |  4 +++-
 replay.c                      | 10 +++++++---
 t/t3650-replay-basics.sh      | 21 +++++++++++++++++++++
 3 files changed, 31 insertions(+), 4 deletions(-)

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
index 13983dbc566..2864c213993 100644
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
index cf3aacf3551..b3fb8869600 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -25,6 +25,8 @@ test_expect_success 'setup' '
 	git switch -c topic3 &&
 	test_commit G &&
 	test_commit H &&
+	git switch -c empty &&
+	git commit --allow-empty -m empty &&
 	git switch -c topic4 main &&
 	test_commit I &&
 	test_commit J &&
@@ -106,6 +108,25 @@ test_expect_success 'using replay on bare repo to perform basic cherry-pick' '
 	test_cmp expect result-bare
 '
 
+test_expect_success 'commits that become empty are dropped' '
+	# Save original branches
+	git for-each-ref --format="update %(refname) %(objectname)" \
+		refs/heads/ >original-branches &&
+	test_when_finished "git update-ref --stdin <original-branches &&
+		rm original-branches" &&
+	# Cherry-pick tip of topic1 ("F"), from the middle of A..empty, to main
+	git replay --advance main topic1^! &&
+
+	# Replay all of A..empty onto main (which includes topic1 & thus F
+	# in the middle)
+	git replay --onto main --branches --ancestry-path=empty ^A \
+		>result &&
+	git log --format="%s%d" L..empty >actual &&
+	test_write_lines >expect \
+		"empty (empty)" "H (topic3)" G "C (topic1)" "F (main)" "M (tag: M)" &&
+	test_cmp expect actual
+'
+
 test_expect_success 'replay on bare repo fails with both --advance and --onto' '
 	test_must_fail git -C bare replay --advance main --onto main topic1..topic2 >result-bare
 '

Range-diff against v3:
1:  73ba74b8a2e ! 1:  375adc4e941 replay: drop commits that become empty
    @@ t/t3650-replay-basics.sh: test_expect_success 'setup' '
      	test_commit G &&
      	test_commit H &&
     +	git switch -c empty &&
    -+	git commit --allow-empty --only -m empty &&
    ++	git commit --allow-empty -m empty &&
      	git switch -c topic4 main &&
      	test_commit I &&
      	test_commit J &&
-- 
2.52.0.362.g884e03848a9

