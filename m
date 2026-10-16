Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD64611E5
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142334; cv=none; b=tiUPXjGEQ51bFWNcUbFUng7g6qN9F6GI16WkIqXTzkFQq1X2stsfFu15NuuYmmHVl5tYHzTVmWZdZGvdrV8qOF51ZEZfUOMcivAstpOedtYfdHKBsM8P4/C5VuBBeAAo4cMCvc09BJ9WTGtjNBXkfvtKQldyCoyb1dloG1rEQTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142334; c=relaxed/simple;
	bh=Mw5cDoQaZWlUUamabmkC0tnSmqf8bYiQ0axaiXUOkRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qynHXaOHAdt8RnnpxWoWXSUhOGr0XS3fhlsLjz02vg9V5yKL96X7yUl/oa664QdtXhIiDDKN2ibRbdVAS3wqxhI9nUzMqDwEDkPy7BOQEwLOkYTkjSj6Cs2Xvy6/7KVCSyChjzS47ahZJ7JfFVzP1J5A9q+nP/m6TJeCogmLg54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ke3gkiDo; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke3gkiDo"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2e3846d1caso998597266b.0
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 02:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792142331; x=1792747131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ECVr6mkK7/zGW4naUsrJp5FsWnZ6Fb5O5VRzuLRUYk=;
        b=ke3gkiDo3BeAxuLiWkSMMNNNzSPsVrK/J2MpeFf8bUXjJp67ldIgvSlNFPYfcYMYiv
         rjtMGyhQ1lOtN1R4p0PbY7irdVz1hH5oDAtHgSjcOe69dW6MwafQWOYShC5cZPrC+ES3
         gpGbp4jkiF5XQvzc/ox1JC6lDtPhYJv6wkczO8Gw2c6/z7cXlBcdbr81dPwbni0PVIhN
         VP/9B/4eSW81RM3NYFrTZ6OSEBARU379qhjUHGm5n/CVqe4U2cmSeakhqz7Ukhx9gffw
         RMOoucD4veyX74CIm+z0ge9j7gmQlwK1sqM9/flZu3Dw03b20DrfIhFMXZH1k5LHMxEA
         HRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142331; x=1792747131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ECVr6mkK7/zGW4naUsrJp5FsWnZ6Fb5O5VRzuLRUYk=;
        b=Qug5xWNbCgXqDZSV4314vaQLf824sO1cYQeQSCYXwj3BC0wggBcHox66JuFETcw2h/
         y9a6Z5ZNVTdzDKQF0kkNddrnh/H1+w/Rt1Ok1Eurb1ki/qUYn/fA0QxE6msoS348VO8s
         SOQbvX8bVuR7FaptnHEjfXhRN0HvCStzWpe3UsyYTIEYZ7GQX1YKQMLq+0oUicy+eIpB
         uFJ1m9yjYRz6fsCWFn/asRTq2aYX7cf6wbUmebtOVQ1wHG2gOnPBdQcyqacvGd2il6bh
         wG5LROEcvN88a3h0gAU0XdcYMBLFjowIRxWr68aP8F2tac2UbOhsyrd1jV68+SpsN6+R
         OfkQ==
X-Gm-Message-State: AFq9FYLiYdeQzU5Z77YQ5orGwC20gVLNz2SKXIKO128plIjUC2UHQrcF
	zUGLGu6PN9doazdc8ovU8mqPCdJMcD+z0kYAn75TBGtTF8f0MwGT8pNdZf9wBw==
X-Gm-Gg: AYBFou1RuP4wq46H7117K9pyY0BrP73HrlMyL2YovX061/IaDwNhn8PtVSPzqJXWO6w
	ugYfl4nYD9nZpdjLr8rLYGwZ+3JQtM5FRV9OiCkrXio2vme0cL43PetUjYEqfi4QlCY2HTmKg5c
	/ZU1+2LgzuodLifKK96okOydqocn26MM/NWhkQH3kRjaWBB6tkM/Z64+Iz9fJ4jtCzQTUVsdRv1
	i5J4tyQKbnlHktO7Z8bQ0jbvkAgA1pv9dvyyXl0qd6pQvrE+Q3JirWFwZH0u+wkWDYhXhetcS9l
	4hTUfly9F45W1QnRWeRet6fBAfrtG02tmjKJrTVTdTfXPrQRZttHQKLAfNo64E9dAsiU9OeEQHa
	fY2e+NToIV57gWw6r+EM1YSDdcsTPUc1LPK9GKoJPHOE1vtI32OP43SAK/y6McO9XYjToDnNpMt
	lDYwRfywj2YGitmdkteQvJxoDqVNVh8zxbYIRDIYJrLfCQNVdkB61CpVUDaZuHFlH8YMek2zfzi
	3/p6mTUY6k6TW/5HA0qWc2mWPFjbg==
X-Received: by 2002:a17:906:e10a:20b0:c33:cc6e:105a with SMTP id a640c23a62f3a-c33cc7d5804mr997260166b.23.1792142330965;
        Fri, 16 Oct 2026 02:18:50 -0700 (PDT)
Received: from prometheus.tail8f5cca.ts.net ([85.11.110.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4090dd3190sm55269766b.23.2026.10.16.02.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:18:48 -0700 (PDT)
From: Szymon Wilczek <swilczek.lx@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Szymon Wilczek <swilczek.lx@gmail.com>
Subject: [PATCH v2] cache-tree: do not die when the index is locked
Date: Fri, 16 Oct 2026 11:16:47 +0200
Message-ID: <20261016091647.1332692-1-swilczek.lx@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015214242.1196722-1-swilczek.lx@gmail.com>
References: <20261015214242.1196722-1-swilczek.lx@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a background process such as `git status` holds `index.lock` while
`git rebase` picks a commit, the rebase can die in the middle of the
pick and leave the sequencer in a state from which `git rebase
--continue` refuses to run:

    error: you have staged changes in your working tree

This happens because `try_to_commit()` calls `write_index_as_tree()`
right after the pick has updated the index and written
`CHERRY_PICK_HEAD`, and `write_index_as_tree()` dies when it cannot
take the index lock. We then die before writing `rebase-merge/message`.
Since 356ee4659b (sequencer: try to commit without forking 'git commit',
2017-11-24), this call happens in-process. Before that commit the
`die()` happened in a `git commit` child process, and the sequencer
stopped cleanly with its state saved.

`write_index_as_tree()` does two different things:

  - It turns the index into a tree object. This part must succeed.

  - When that succeeds, it also rewrites the index to populate the
    cache-tree extension. This part is allowed to fail without
    impacting the result; as the comment next to
    `write_locked_index()` already notes, failing to write the index
    here is fine.

Yet the function locks the index with `LOCK_DIE_ON_ERROR`, even though
we only need the lock for the optional second part.

Drop `LOCK_DIE_ON_ERROR` so that we take the lock gently, just like
other callers that only refresh the index, and skip writing the index
when the lock is held by someone else. This also lets `git write-tree`
and `git am` proceed while another process holds the lock.

Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>
---
Changes in v2:

  - Reordered the commit message to describe the symptom first, then
    its cause, and the fix last, and explained the two things that
    `write_index_as_tree()` does (thanks, Patrick).

  - Spelled the lock check as `fd >= 0` instead of `0 <= fd`.

Notes from v1:

I ran into this while rebasing a ~120-commit branch with Magit open,
which runs `git status` in the background. To recover from the
half-picked state, I had to commit the pick manually with
`git commit -C CHERRY_PICK_HEAD` before running `git rebase --continue`.

This can be reproduced within a few tries by rebasing a long branch
while running `git status --porcelain` in a loop, or triggered every
time in gdb:

    break try_to_commit
    run
    shell touch .git/index.lock
    continue

If the lock is taken slightly earlier, during `do_recursive_merge()`,
the pick still fails, but that path reports an error and reschedules the
pick, so `git rebase --continue` works there.

 cache-tree.c          | 10 +++++++---
 t/t0090-cache-tree.sh | 13 +++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index b8cbb5da22..671d4165bf 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -809,11 +809,15 @@ struct tree *write_in_core_index_as_tree(struct repository *repo,
 
 int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
 {
-	int entries, was_valid;
+	int entries, was_valid, fd;
 	struct lock_file lock_file = LOCK_INIT;
 	int ret;
 
-	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
+	/*
+	 * The lock only protects the cache-tree write-back below; if somebody
+	 * else holds it, compute the tree without updating the index.
+	 */
+	fd = hold_lock_file_for_update(&lock_file, index_path, 0);
 
 	entries = read_index_from(index_state, index_path,
 				  repo_get_git_dir(index_state->repo));
@@ -828,7 +832,7 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 
 	ret = write_index_as_tree_internal(oid, index_state, was_valid, flags,
 					   prefix);
-	if (!ret && !was_valid) {
+	if (!ret && !was_valid && fd >= 0) {
 		write_locked_index(index_state, &lock_file, COMMIT_LOCK);
 		/* Not being able to write is fine -- we are only interested
 		 * in updating the cache-tree part, and if the next caller
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 0964718d7f..4b7547e108 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -286,4 +286,17 @@ test_expect_success 'cache-tree is used by write-tree when valid' '
 	test_grep ! region_enter.*cache_tree.*update trace.output
 '
 
+test_expect_success 'write-tree succeeds while the index is locked' '
+	test_when_finished "rm -f .git/index.lock" &&
+	test_commit locked &&
+	>uncommitted &&
+	git add uncommitted &&
+	>.git/index.lock &&
+	git write-tree >actual &&
+	test_path_is_file .git/index.lock &&
+	rm .git/index.lock &&
+	git write-tree >expect &&
+	test_cmp expect actual
+'
+
 test_done

Range-diff against v1:
1:  d16173cf1c ! 1:  cdfdd81c3f cache-tree: do not die when the index is locked
    @@ Metadata
      ## Commit message ##
         cache-tree: do not die when the index is locked
     
    -    `write_index_as_tree()` locks the index with `LOCK_DIE_ON_ERROR`, even
    -    though we only need the lock for the optional write-back of the updated
    -    cache-tree. As the comment next to `write_locked_index()` already notes,
    -    failing to write the index here is fine.
    +    When a background process such as `git status` holds `index.lock` while
    +    `git rebase` picks a commit, the rebase can die in the middle of the
    +    pick and leave the sequencer in a state from which `git rebase
    +    --continue` refuses to run:
     
    -    Since 356ee4659b (sequencer: try to commit without forking 'git commit',
    -    2017-11-24), `try_to_commit()` calls `write_index_as_tree()` in-process
    +        error: you have staged changes in your working tree
    +
    +    This happens because `try_to_commit()` calls `write_index_as_tree()`
         right after the pick has updated the index and written
    -    `CHERRY_PICK_HEAD`. Before that commit the `die()` happened in a `git
    -    commit` child process, and the sequencer stopped cleanly with its state
    -    saved. Now, if a background `git status` holds `index.lock` at that
    -    moment, we die before writing `rebase-merge/message`, and a subsequent
    -    `git rebase --continue` refuses to run:
    +    `CHERRY_PICK_HEAD`, and `write_index_as_tree()` dies when it cannot
    +    take the index lock. We then die before writing `rebase-merge/message`.
    +    Since 356ee4659b (sequencer: try to commit without forking 'git commit',
    +    2017-11-24), this call happens in-process. Before that commit the
    +    `die()` happened in a `git commit` child process, and the sequencer
    +    stopped cleanly with its state saved.
     
    -        error: you have staged changes in your working tree
    +    `write_index_as_tree()` does two different things:
    +
    +      - It turns the index into a tree object. This part must succeed.
    +
    +      - When that succeeds, it also rewrites the index to populate the
    +        cache-tree extension. This part is allowed to fail without
    +        impacting the result; as the comment next to
    +        `write_locked_index()` already notes, failing to write the index
    +        here is fine.
    +
    +    Yet the function locks the index with `LOCK_DIE_ON_ERROR`, even though
    +    we only need the lock for the optional second part.
     
         Drop `LOCK_DIE_ON_ERROR` so that we take the lock gently, just like
         other callers that only refresh the index, and skip writing the index
    @@ cache-tree.c: int write_index_as_tree(struct object_id *oid, struct index_state
      	ret = write_index_as_tree_internal(oid, index_state, was_valid, flags,
      					   prefix);
     -	if (!ret && !was_valid) {
    -+	if (!ret && !was_valid && 0 <= fd) {
    ++	if (!ret && !was_valid && fd >= 0) {
      		write_locked_index(index_state, &lock_file, COMMIT_LOCK);
      		/* Not being able to write is fine -- we are only interested
      		 * in updating the cache-tree part, and if the next caller

base-commit: f57c9a73884400380bddd172acc88b569834f909
-- 
2.56.0

