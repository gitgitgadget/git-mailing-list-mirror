Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DF51E8333
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756062420; cv=none; b=Ei/feEFIHx1GrO2JsbK9c6YA3qajTJEwMT6ETs5M2fzSYc8Aj0IwAvd4+OoJYw21Ls5hOiGHnQbLnIDrRZ8ZXFl4IFBDo9/n4m0SC6o9i1UOWzX9NBfIkeaZ30N5aaf6i0MjxNA6TJh6+w4Xof0AFBcm8oPL1IaMaBvF9v+Q0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756062420; c=relaxed/simple;
	bh=eSNplEZGzVRf2vCmqSE66nVI3J4hU3ixoP9d73969fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzTgVzoZWW/0ARAkM8Yxtd3WJGNV29gy4nic8Vt0D5C06kFXSS6QgYAP2uy4L9Ylqh9lPWidoL87I8qydOnU/hMrcLZuMXOikU1/nt4Bw3Mr8tcGfhxS0MqRhix2Og6I+Lv0pr+qIo0SSih5CdzjDTR9mlaDQvN7f1GuRvVLI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iF+L5U7b; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iF+L5U7b"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b5d49ae47so2316405e9.0
        for <git@vger.kernel.org>; Sun, 24 Aug 2025 12:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756062417; x=1756667217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1faCPfVxHSRwNUe6lguaAiSzhqXpzG7NT8ln6tPzYuM=;
        b=iF+L5U7b2oqjGvWyzMtEAtPbdXkFpsQpFDYIvMCTl/PDugbmVEaNV0UnWoHUpqX6F0
         +Tz8tHMomT8T7kmZhZlikhpcoEgBH2k2jEM8Qvxgik3EOUXdkb1ywTxRG8yGsZ1Ivigp
         VmUVtqZyR+44EXjTc/CeGyU7zL+qYDqwS+HFs8E8sGi+5es/rxWInqwMbQ1SfEr4yEID
         T2f3S5fC5Gz1wC6fVSGeyGD1TMN4Y/TegWX/peYC6T49GYqMcaUsG+E2uI+SbEIAfU8k
         O4M+M5iXHFfsTid45R3DrbS39/F0Xza0bIRV9dxWgEJEgq3ft/fEJbMr6+Ejt9oTRbqT
         gcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756062417; x=1756667217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1faCPfVxHSRwNUe6lguaAiSzhqXpzG7NT8ln6tPzYuM=;
        b=oWs/b/iT1iZWUdtuU52BDNdba5t7AtT6GGiT7YkmS2nyhx90jDA2YZicRb8w/pMjUt
         IziKWb4w1ipDCxyCbvaBVNK+bwxS+AAMUrfH1x7TkOu5VyE7iNPxAVk0M+Hb0FG2eGxB
         X48+4J8/4JCUm9kfCMKfsvr8JS6YJz/PlPTdyz868IHz1xLNFUe2S9RimCQivx9pzMfS
         0QDwz40B8AZyxDrWd/nzuiMXQOwNBEtZ+xv8uBsGyzhPNQH80we4G1FTuF6arSDH+/v3
         I6+D6CaQzrfN+H5ZsFmWhQpbZ9KWQeL3EjLCuRWE3PSmiQeYIQTSSnEFEOOHAK9eL8/5
         fBmw==
X-Gm-Message-State: AOJu0YyMqJh+mCcy/jy3z85eMA8ohvHdAxHKsX1woeqV/giGmjUMf4sV
	vj28SLdYnqlKzfO//l6Je71vbEJRbu0FISovcQkV0/8pcV8z4w3RjlQJeCM0dw==
X-Gm-Gg: ASbGncv1I89MMMtAJhbZ+I5u0knnTxVy8lgbiGW2Jd6G+rW7XGiTs79n1izrUbDlpX4
	dEKWNo7esYJFBO51tjn1XnPp3wH+NQSpyrLs67fSlF3UVfqTzDr+E0Y7vn4+Px9WdC++fBAOWfl
	xRxKV6WwovRMxJRHevJUzIyc6pWL5TZZ12vU0J62tkJvlDO99jSBVFtMmVW96+NHdaRAJaPzyUB
	9L4CX2Pqt3h+aZXujLTZCt3iR68cymJewL4tgDH6hANCniSgW31rtmeKBRcOHIlYAWPquB1+0nL
	Zi5r172BMtvuJ3C+uPF9f214IfDQZnT9VHeDXSyNGV8rBc/p5M0Jjjlo3NVuCtCYC1aEqdhopj7
	j87QI5Dk9rP/L/FuFuxqbS3TL6A+KNGcTuQEPl9McLcBEvJEBRESc
X-Google-Smtp-Source: AGHT+IGfLx7V441sjEqim9z4yQ4T+GgnISUqx7ACghqc8t01Pb+8oGJaHMqZlnHXHAI2FcBfKGZ9Zw==
X-Received: by 2002:a05:600c:1f1a:b0:45b:43cc:e557 with SMTP id 5b1f17b1804b1-45b517cbee2mr67209865e9.34.1756062416653;
        Sun, 24 Aug 2025 12:06:56 -0700 (PDT)
Received: from localhost (78-131-14-231.pool.digikabel.hu. [78.131.14.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57498b37sm82250665e9.23.2025.08.24.12.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 12:06:56 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/4] line-log: avoid unnecessary tree diffs when processing merge commits
Date: Sun, 24 Aug 2025 21:06:41 +0200
Message-ID: <20250824190644.2573279-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.51.0.433.g1a66b3fb12
In-Reply-To: <20250824190644.2573279-1-szeder.dev@gmail.com>
References: <20250824190644.2573279-1-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In process_ranges_merge_commit(), the line-level log first creates an
array of diff queues by iterating over all parents of a merge commit
and computing a tree diff for each.  Then in a second loop it iterates
over those diff queues, and if it finds that none of the interesting
paths were modified in one of them, then it will return early.  This
means that when none of the interesting paths were modified between a
merge and its first parent, then the tree diff between the merge and
its second (Nth...) parent was computed in vain.

Unify these two loops, so when it iterates over all parents of a merge
commit, then it first computes the tree diff between the merge and
that particular parent and then processes the resulting diff queue
right away.  This way we can spare some tree diff computing, thereby
speeding up line-level log in repositories with mergy history:

  # git.git, 25.8% of commits are merges:
  Benchmark 1: ./git_v2.51.0 -C ~/src/git log -L:'lookup_commit(':commit.c v2.51.0
    Time (mean ± σ):      1.001 s ±  0.009 s    [User: 0.906 s, System: 0.095 s]
    Range (min … max):    0.991 s …  1.023 s    10 runs

  Benchmark 2: ./git -C ~/src/git log -L:'lookup_commit(':commit.c v2.51.0
    Time (mean ± σ):     445.5 ms ±   3.4 ms    [User: 358.8 ms, System: 84.3 ms]
    Range (min … max):   440.1 ms … 450.3 ms    10 runs

  Summary
    './git -C ~/src/git log -L:'lookup_commit(':commit.c v2.51.0' ran
      2.25 ± 0.03 times faster than './git_v2.51.0 -C ~/src/git log -L:'lookup_commit(':commit.c v2.51.0'

  # linux.git, 7.5% of commits are merges:
  Benchmark 1: ./git_v2.51.0 -C ~/src/linux.git log -L:build_restore_work_registers:arch/mips/mm/tlbex.c v6.16
    Time (mean ± σ):      3.246 s ±  0.007 s    [User: 2.835 s, System: 0.409 s]
    Range (min … max):    3.232 s …  3.255 s    10 runs

  Benchmark 2: ./git -C ~/src/linux.git log -L:build_restore_work_registers:arch/mips/mm/tlbex.c v6.16
    Time (mean ± σ):      2.467 s ±  0.014 s    [User: 2.113 s, System: 0.353 s]
    Range (min … max):    2.455 s …  2.505 s    10 runs

  Summary
    './git -C ~/src/linux.git log -L:build_restore_work_registers:arch/mips/mm/tlbex.c v6.16' ran
      1.32 ± 0.01 times faster than './git_v2.51.0 -C ~/src/linux.git log -L:build_restore_work_registers:arch/mips/mm/tlbex.c v6.16'

And since now each iteration computes a tree diff and processes its
result, there is no reason to store the diff queues for each merge
parent anymore, so replace that diff queue array with a loop-local
diff queue variable.  With this change the static free_diffqueues()
helper function in 'line-log.c' has no more callers left, remove it.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 line-log.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/line-log.c b/line-log.c
index 07f2154e84..cf30915c94 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1087,13 +1087,6 @@ static struct diff_filepair *diff_filepair_dup(struct diff_filepair *pair)
 	return new_filepair;
 }
 
-static void free_diffqueues(int n, struct diff_queue_struct *dq)
-{
-	for (int i = 0; i < n; i++)
-		diff_queue_clear(&dq[i]);
-	free(dq);
-}
-
 static int process_all_files(struct line_log_data **range_out,
 			     struct rev_info *rev,
 			     struct diff_queue_struct *queue,
@@ -1209,7 +1202,6 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
 static int process_ranges_merge_commit(struct rev_info *rev, struct commit *commit,
 				       struct line_log_data *range)
 {
-	struct diff_queue_struct *diffqueues;
 	struct line_log_data **cand;
 	struct commit **parents;
 	struct commit_list *p;
@@ -1220,20 +1212,19 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 	if (nparents > 1 && rev->first_parent_only)
 		nparents = 1;
 
-	ALLOC_ARRAY(diffqueues, nparents);
 	CALLOC_ARRAY(cand, nparents);
 	ALLOC_ARRAY(parents, nparents);
 
 	p = commit->parents;
 	for (i = 0; i < nparents; i++) {
+		struct diff_queue_struct diffqueue = DIFF_QUEUE_INIT;
+		int changed;
 		parents[i] = p->item;
 		p = p->next;
-		queue_diffs(range, &rev->diffopt, &diffqueues[i], commit, parents[i]);
-	}
+		queue_diffs(range, &rev->diffopt, &diffqueue, commit, parents[i]);
 
-	for (i = 0; i < nparents; i++) {
-		int changed;
-		changed = process_all_files(&cand[i], rev, &diffqueues[i], range);
+		changed = process_all_files(&cand[i], rev, &diffqueue, range);
+		diff_queue_clear(&diffqueue);
 		if (!changed) {
 			/*
 			 * This parent can take all the blame, so we
@@ -1267,7 +1258,6 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 		free(cand[i]);
 	}
 	free(cand);
-	free_diffqueues(nparents, diffqueues);
 	return ret;
 
 	/* NEEDSWORK evil merge detection stuff */
-- 
2.51.0.433.g1a66b3fb12

