Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD53031ED7C
	for <git@vger.kernel.org>; Thu, 14 May 2026 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777496; cv=none; b=gLTg+tiixhNygpofET/2/dUKUimu8kY/dxqMtlP9gkgM09HC5fJgMFl/HSRBFxUuanjXOFZz7GLD682nzsLJJC5thFOhJf+PI+myzile/fhWU1U1m/y5wV6K1+iIIvODd55XQMJpwKdjscC5H1ZQVIxn1nggKVeXwHFbhuvMmic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777496; c=relaxed/simple;
	bh=QKVsb3fS94wqSruko/HgLeh2lOW2BljQnCmBGXmZlzU=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=ATYhZbYF6DYpV0ng1aohfLPfknNDpBitISFu56jp3qHEn1Qa+Itwdv8+5Gunm/PRdCbB6lSiayFQS7qvUpIdR3YWJPSl9/7dJ+u7wKx++vPL2Yj3kgnYcMSatzSr9W+YAeEYdGH4I6NHaAlt27xIjkU3p11NYiY9i9O6Qw3b55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4qYGCIc; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4qYGCIc"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40427db1300so5956990fac.0
        for <git@vger.kernel.org>; Thu, 14 May 2026 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778777493; x=1779382293; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qsOXxqhtU4assb4aI1mEos9fsDO6SK/GoADEmiCafDU=;
        b=U4qYGCIcBrWEL+Qlp7XKOhaq4B0zjt8MOCP/EedQEYWsvmcNt/gRF/5s9Kaiq6++BU
         5zl7MTmL1DJso2Xb5mQeXJjOXZQIZUgKRdjbMTlM3oVAbHVynZvBTiOdv4Zo2/wm3Dxd
         JiVO8VfQEzj6yblIJ61hlyOA4WDK7mz7JSMJW14Zrtglj69rAHO28DWi5Kt5fhIWuaGz
         AhqnujY4ceLFksAMpJl2aRVVb0HlRnnOaaqByahQIa2MTUS129EkLk6Wtl3UBK29szIw
         6eliLv/TF26/tDIbrnwKZQKzCVJ738oG7VxvdyWmqfsVK36X7iAumeJq1/wLwcJxKtLt
         XlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777493; x=1779382293;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsOXxqhtU4assb4aI1mEos9fsDO6SK/GoADEmiCafDU=;
        b=FODnCamSGmWnFDlUQIo7jjQcqdgt9S1x8UhkTOhyBqs5TRK4SOGqdl2m05ke3L/a5w
         2qmrdO2/rupa4jCURkIMjNGnQjSf8oDe0qUGsghTYGV5P+PCxR9i4UB7NlbLA4uUhMQ+
         WhlbP6XteZYVhQ9ENNLDzKXRl3D0Y6dz57JKW5sclladLPuGd6MtgKLx36Tjyjw63c3m
         8stlnwIx27MGyv3FI+mr56Qm54ZgyhF3aVbZRxxCQAxck0iEAyyT+brZl8jhQmgqlXx9
         Qk9yIUcohCRXBql89dD/LjkRQZSd53JJIJgjpkh1vMIf04y3h8WmsZ8TDjoU/jIZFJZ9
         nklw==
X-Gm-Message-State: AOJu0YxBzlzTxtUFnFtkI+dTRvTk3NI/dKkaCflTzknWMhkkX08Sp5GB
	ZMpw2LMrFYQvQCAiqZK7nQTwd4TqAspBFYH6luVfGskX/zIKdDj3rN9AN6/DgA==
X-Gm-Gg: Acq92OEEpoEbQ92UVXYA1/GW/vIDnUBg8K7qWJI4eWi2GOgt83mbAA0SdfDpNpvGoeq
	vtt7YmjnJ/yPUFfjLrAI3BZ4ybWvk99Ng58hFoBWFWnJU1f1Vev2bK0aubHRuWEvgtjgrdTGwMj
	QowzHkMdWf1lXyksscjrjXiUWCZCeIFnC7BIAEo6eTNsLrNsMtEsMOJ9y0Q6fbwl9oixDU/j4Dq
	7OkAkLsAC+k0dZvxwR95mnq7NgzyHXSz3VJgXyOYvtQrhHdCfL8qvec6Jcb6XZSCCnaAiKQ0x9E
	PiMxStO29UvKTV/iT/NFl3aRsN+d/BBMfvRE0tTc9VLgORtcMpaGGmegP8quwvyJCvaAgQXdMMq
	t0y71Ppk8Pp0pxzXB5eva/gSeFHC0rtTu/VNqDrERW3a01KH5s08CKkmpIhDjrjI7qt9zaW4pJF
	6bJyqqB7gqpL2+3M7/PqGHpcDSbdw=
X-Received: by 2002:a05:6870:e988:b0:41c:bab:5f9d with SMTP id 586e51a60fabf-43a2d9143d1mr271197fac.4.1778777493217;
        Thu, 14 May 2026 09:51:33 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.40])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc1fc14csm2341613fac.6.2026.05.14.09.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:51:32 -0700 (PDT)
Message-Id: <pull.2114.git.1778777491939.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 May 2026 16:51:31 +0000
Subject: [PATCH] revision: use priority queue in limit_list()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

limit_list() maintains a date-sorted work queue of commits using a
linked list with commit_list_insert_by_date() for insertion.  Each
insertion walks the list to find the right position — O(n) per insert.
In repositories with merge-heavy histories, the symmetric difference
can contain thousands of commits, making this O(n) insertion the
dominant cost.

Replace the sorted linked list with a prio_queue (binary heap).  This
gives O(log n) insertion and O(log n) extraction instead of O(n)
insertion and O(1) extraction, which is a net win when the queue is
large.

The still_interesting() and everybody_uninteresting() helpers are
updated to scan the prio_queue's contiguous array instead of walking a
linked list.  process_parents() already accepts both a commit_list and
a prio_queue parameter, so the change in limit_list() simply switches
which one is passed.

Benchmark: git rev-list --left-right --count HEAD~N...HEAD
Repository: 2.3M commits, merge-heavy DAG (monorepo)
Best of 5 runs, times in seconds:

  commits in
  symmetric diff   baseline   patched    speedup
  --------------   --------   -------    -------
            10       0.01      0.01       1.0x
            50       0.01      0.01       1.0x
          3751      21.23      8.49       2.5x
          4524      21.70      8.29       2.6x
         10130      20.10      6.65       3.0x

No change for small traversals; 2.5-3.0x faster when the queue grows
to thousands of commits.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    revision: use priority queue in limit_list()
    
    This patch speeds up limit_list() by 2.5–3x on large, merge-heavy
    repositories by replacing a sorted linked list with a priority queue.
    
    The sorted linked list used as a work queue in limit_list() has O(n)
    insertion cost per commit, where n is the current queue length (the
    "width" of the active walk frontier). In merge-heavy DAGs this frontier
    grows wide — profiling on a 2.3M-commit monorepo showed 59% of total CPU
    time in commit_list_insert_by_date(). Total cost is O(N·w) where N is
    commits walked and w is peak queue width; in merge-heavy histories w
    scales with N, approaching O(N²).
    
    Switching to a prio_queue (binary heap) reduces insertion cost to O(log
    w), bringing total cost to O(N·log w). The practical result on the same
    repository:
    
    commits in
    symmetric diff   before     after      speedup
    --------------   --------   -------    -------
            3751      21.2s      8.5s       2.5x
            4524      21.7s      8.3s       2.6x
           10130      20.1s      6.6s       3.0x
    
    
    This affects any command that triggers limit_list() — i.e., when
    revs->limited is set — including --left-right, --cherry-mark,
    --cherry-pick, --ancestry-path, bisect, and rebase's fork-point
    computation. The practical trigger is git status --ahead-behind on a
    branch that has diverged from upstream in a merge-heavy repository.
    
    The change is minimal (+21/−17 lines, single file) because
    process_parents() already accepts both a commit_list and a prio_queue
    parameter — limit_list() just switches which one it passes.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2114%2Fspkrka%2Flimit-list-prio-queue-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2114/spkrka/limit-list-prio-queue-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2114

 revision.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/revision.c b/revision.c
index 599b3a66c3..2b1b3bb10e 100644
--- a/revision.c
+++ b/revision.c
@@ -473,10 +473,10 @@ static struct commit *handle_commit(struct rev_info *revs,
 	die("%s is unknown object", name);
 }
 
-static int everybody_uninteresting(struct commit_list *orig,
+static int everybody_uninteresting(struct prio_queue *orig,
 				   struct commit **interesting_cache)
 {
-	struct commit_list *list = orig;
+	size_t i;
 
 	if (*interesting_cache) {
 		struct commit *commit = *interesting_cache;
@@ -484,9 +484,8 @@ static int everybody_uninteresting(struct commit_list *orig,
 			return 0;
 	}
 
-	while (list) {
-		struct commit *commit = list->item;
-		list = list->next;
+	for (i = 0; i < orig->nr; i++) {
+		struct commit *commit = orig->array[i].data;
 		if (commit->object.flags & UNINTERESTING)
 			continue;
 
@@ -1300,20 +1299,17 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 /* How many extra uninteresting commits we want to see.. */
 #define SLOP 5
 
-static int still_interesting(struct commit_list *src, timestamp_t date, int slop,
+static int still_interesting(struct prio_queue *src, timestamp_t date, int slop,
 			     struct commit **interesting_cache)
 {
 	/*
-	 * No source list at all? We're definitely done..
+	 * Since src is sorted by date, it is enough to peek at the
+	 * first entry to compare dates.  No entry at all means done.
 	 */
-	if (!src)
+	struct commit *commit = prio_queue_peek(src);
+	if (!commit)
 		return 0;
-
-	/*
-	 * Does the destination list contain entries with a date
-	 * before the source list? Definitely _not_ done.
-	 */
-	if (date <= src->item->date)
+	if (date <= commit->date)
 		return SLOP;
 
 	/*
@@ -1451,6 +1447,7 @@ static int limit_list(struct rev_info *revs)
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
 	struct commit *interesting_cache = NULL;
+	struct prio_queue queue = { .compare = compare_commits_by_commit_date };
 
 	if (revs->ancestry_path_implicit_bottoms) {
 		collect_bottom_commits(original_list,
@@ -1461,6 +1458,11 @@ static int limit_list(struct rev_info *revs)
 
 	while (original_list) {
 		struct commit *commit = pop_commit(&original_list);
+		prio_queue_put(&queue, commit);
+	}
+
+	while (queue.nr) {
+		struct commit *commit = prio_queue_get(&queue);
 		struct object *obj = &commit->object;
 
 		if (commit == interesting_cache)
@@ -1468,11 +1470,13 @@ static int limit_list(struct rev_info *revs)
 
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
-		if (process_parents(revs, commit, &original_list, NULL) < 0)
+		if (process_parents(revs, commit, NULL, &queue) < 0) {
+			clear_prio_queue(&queue);
 			return -1;
+		}
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(revs, commit);
-			slop = still_interesting(original_list, date, slop, &interesting_cache);
+			slop = still_interesting(&queue, date, slop, &interesting_cache);
 			if (slop)
 				continue;
 			break;
@@ -1509,7 +1513,7 @@ static int limit_list(struct rev_info *revs)
 		}
 	}
 
-	commit_list_free(original_list);
+	clear_prio_queue(&queue);
 	revs->commits = newlist;
 	return 0;
 }

base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
-- 
gitgitgadget
