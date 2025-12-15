Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2BF321457
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765793276; cv=none; b=W0LHEh4Ze66wNFL48dG1M6oNT3KagH2nByG5HSa/9Wu9XFdj+Ak+eXonL7PT3kkrXFC0BLArtvNkYH+86GkhmHq/BCUfHcjkUb1W07SQ/0dIcX6dt1ywJS7r900Fhwx3G6uL3RJQvls0v6d0SF9eeFrVAnbaRn1xMDUe2fZqoJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765793276; c=relaxed/simple;
	bh=RkDjFMHnWlJGdcD43PLFI9WFuWKE18PFp7sjocDkEuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHYlh7e1Oy9oAW28bR4pJRsUz3vF3xtj4SPXQ773hzxO27NxxCGFI2UE4/lDSYvnZW0+X6vazaHIrIn9BY36kJKi/N7LBF3SUSOjRD8vqmXhRsU35TqtdHDQjSSYoSy+VHpkwsd5+gTexUq+3yaABnC2xVP6FRoahd/DK8M6hes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEvcfZI0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEvcfZI0"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477563e28a3so24714455e9.1
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 02:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765793273; x=1766398073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v7S3Twwh26bXHPs3lxnMbzppHzpTCithcFYLwvFdIyA=;
        b=bEvcfZI0QkspbQ/6c66r6lqQetuA3vD2bfhfSxkpJ3aAzz4RZygF1f7ZBcOaPU0Zsp
         o+shITQnVBMnYDOmcFpo02YtjCwXBIYiGdLR6VSHaaoxfEZvqM7ai3GyHLupCc2dL4qs
         hyQwtHVYsfoLTAZqtX8PLsKfZ0khiPKcWAbpkDJyGrejfYSEcYeHfJIo6s83vAV0TLaF
         T1nAWskEb0fDaC1tc/9s4j9+A53EILiiZz2m5t3zKf4l7XJyq8XCMn1IOvJaQXacU1+F
         ZIVGl57X61qFXHq0dsZYNITG0nGL3qQqqBtIFQdQW8xWmt5yoCnXsEfbbFV3Yo82SxDL
         K70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765793273; x=1766398073;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7S3Twwh26bXHPs3lxnMbzppHzpTCithcFYLwvFdIyA=;
        b=qVvk0S/ls8E6rrSRWCW3m4kbNxIYTBDoMZcdDSpejV6L04jiSV0/neIc045K4KLnDJ
         Yx0Dci6Wt4t2530aqEA93V8tRlWXbxN4nfevfCl7SIw14w86oDMieF9idD1rVXpN99bH
         NtkU8Va6+/rv22mZGllAfZHBDth387IO7RCToAOqLt7fmI/pFiQ1/kzIElXnodMIXaI6
         sezvNcDKLajHBDwFQaC1WKI8fTlVLD+I32AVTyCeliJP1x+aDLKvMQ95c1KKAfD0Qyyu
         n+VPfboD5qSIX+inKo5lzwqMzzMw+dO11pJyzSbwNLAiFiNHPnKxdQbRjk4UvPls0jf/
         Oi5Q==
X-Gm-Message-State: AOJu0YwpbsRO5sLEdjv3mJwZVX8z7uEZt05QOG3p0/eBY5AyRqcPEP93
	+xk+79EAYtias4oVVKSRWyN2Akw35ORb88/rfrHsEhLa49UkhG4uQ22ethoR4Q==
X-Gm-Gg: AY/fxX7nlLZyZR9sdOGY1xfH8OU6tr+8RrRxS4mP0fGrjzflTV2RUL3VmMD+nHiF3aQ
	TOloBzOhfZIRkVBirK5I7mQ3mAG1fXccsMCZD/jAe+/3eViKjg0NPNPZILamUf+4gk18iaM29Qe
	6OoPykmHyLRd2IEZacwzLZDlWALW5KSJkaV/k93Lsk0bqtsJOzOwHBYAbKok93Ktlh7DzrzTvR9
	BzgqAAZlDdupCpA2A4NsUIJov5r/iwPcDaNl0OnzUbfhECyUL+xTrPU6m+OXiZJgTE4VPruR+rC
	mAB0pzwe171g4HAqCYN6W6Sy/ucFfV3xcA7+kd0P9UiLqS7GupxehWRv5ydlEm9nWS++g/BFvRr
	0JuLzeLwQQve0W1BxsvULPfR/SCX3v9LbieNr+VF3sos3xuI22I85x/3TOGB75/J2j8K/8FOyNa
	Mw1B+Xy0nFLunXlMb14pO9Ke9QXQ==
X-Google-Smtp-Source: AGHT+IEDVnigoBVNnRsscsultVG9IdzIJKBbz9c4NZm2Y6sscIkJe8riV3IaaczLNcd2sOThiqBzIQ==
X-Received: by 2002:a05:600d:486:20b0:477:991c:a17c with SMTP id 5b1f17b1804b1-47a89da4685mr111295335e9.6.1765793272325;
        Mon, 15 Dec 2025 02:07:52 -0800 (PST)
Received: from berwick ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f71576csm65773645e9.18.2025.12.15.02.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 02:07:51 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2] replay: drop commits that become empty
Date: Mon, 15 Dec 2025 10:07:37 +0000
Message-ID: <9a81644a0ec670261a85c155fa32e5a1f4576ef4.1765793254.git.phillip.wood@dunelm.org.uk>
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
that the commits are being replayed onto then "git replay" creates an
empty commit. This is confusing because the commit message no longer
matches the contents of the commit. Drop the commit instead. Commits
that start off empty are not dropped. This matches the behavior of
"git rebase --reapply-cherry-pick --empty=drop" and "git cherry-pick
--empty-drop".

If a branch points to a commit that is dropped it will be updated to
point to the last commit that was not dropped. This can been seen
in the new test where "topic1" is updated to point to the rebased
"C" as "F" is dropped because it is already upstream. While this is
a breaking change "git replay" is marked as experimental to allow
improvements like this that change the behavior.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
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
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Freplay-drop-commits-that-become-empty%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/d37c42ea6...9a81644a0
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/replay-drop-commits-that-become-empty/v2

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
index cf3aacf3551..9d4b0dd1a77 100755
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

Range-diff against v1:
1:  8a2a1215306 ! 1:  9a81644a0ec replay: drop commits that become empty
    @@ Commit message
         matches the contents of the commit. Drop the commit instead. Commits
         that start off empty are not dropped. This matches the behavior of
         "git rebase --reapply-cherry-pick --empty=drop" and "git cherry-pick
    -    --empty-drop". If a branch points to a commit that is dropped it will
    -    be updated to point to the last commit that was not dropped. This can
    -    been seen in the new test where "topic1" is updated to point to the
    -    rebased "C" as "F" is dropped because it is already upstream. While
    -    this is a breaking change "git replay" is marked as experimental to
    -    allow improvements like this that change the behavior.
    -
    +    --empty-drop".
    +
    +    If a branch points to a commit that is dropped it will be updated to
    +    point to the last commit that was not dropped. This can been seen
    +    in the new test where "topic1" is updated to point to the rebased
    +    "C" as "F" is dropped because it is already upstream. While this is
    +    a breaking change "git replay" is marked as experimental to allow
    +    improvements like this that change the behavior.
    +
    +    Helped-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## Documentation/git-replay.adoc ##
    @@ t/t3650-replay-basics.sh: test_expect_success 'using replay on bare repo to perf
      '
      
     +test_expect_success 'commits that become empty are dropped' '
    -+	git replay --ref-action=print --advance main topic1^! >result &&
    -+	ONTO=$(cut -f 3 -d " " result) &&
    -+	git replay --ref-action=print --onto $ONTO \
    -+		--branches --ancestry-path=empty ^A >result &&
    -+	# Write the new value of refs/heads/empty to "new-empty" and
    -+	# generate a sed script that annotates the output of
    -+	# `git log --format="%H %s"` with the updated branches
    -+	SCRIPT="$(sed -e "
    -+		/empty/{
    -+			h
    -+			s|^.*empty \([^ ]*\) .*|\1|wnew-empty
    -+			g
    -+		}
    -+		s|^.*/\([^/ ]*\) \([^ ]*\).*|/^\2/s/\\\$/ (\1)/|
    -+		\$s|\$|;s/^[^ ]* //|" result)" &&
    -+	git log --format="%H %s" --stdin <new-empty >actual.raw &&
    -+	sed -e "$SCRIPT" actual.raw >actual &&
    ++	# Save original branches
    ++	git for-each-ref --format="update %(refname) %(objectname)" \
    ++		refs/heads/ >original-branches &&
    ++	test_when_finished "git update-ref --stdin <original-branches &&
    ++		rm original-branches" &&
    ++	# Cherry-pick tip of topic1 ("F"), from the middle of A..empty, to main
    ++	git replay --advance main topic1^! &&
    ++
    ++	# Replay all of A..empty onto main (which includes topic1 & thus F
    ++	# in the middle)
    ++	git replay --onto main --branches --ancestry-path=empty ^A \
    ++		>result &&
    ++	git log --format="%s%d" L..empty >actual &&
     +	test_write_lines >expect \
    -+		"empty (empty)" "H (topic3)" G "C (topic1)" F M L B A &&
    ++		"empty (empty)" "H (topic3)" G "C (topic1)" "F (main)" "M (tag: M)" &&
     +	test_cmp expect actual
     +'
     +
-- 
2.52.0.362.g884e03848a9

