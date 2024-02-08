Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256BC77F33
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411642; cv=none; b=pmQ4eGCewxhfN/T/xlHVOlQgeiuyJNecmClC5tRw5GhuMwbzVDuz0MeRHNHhG8E/I1ln0apAz2lHzqkg0CdN8Vt+/H66OkXxTNHA4lWGo1M0Y3blZ5SWZQiXD9YMJ8QbpoXeZuXeyHDGrF4nm0U0Cx7g6kTFTCxbvKKQuIK4fq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411642; c=relaxed/simple;
	bh=DC6LDofZ8wcb1yW8Ss+07ZN060IIGD/FTkEM4ENpAaM=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=DSAQzfwcu9MTY+O7MhAunzB4GW996gjv8hRXeR4qwHD9OPFFRC6NK2h2D7oyZqEcSBNewFu2JV1ddoNbFjz9iBw4bEV3tLV8+zy7kHqzsUW8dXLuXf/sgsIToYy0DgM4PQQMZN0vZ6+/M8w9qFNwHlenCaZCBndOZ9NFZsiS16w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maOFRl6s; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maOFRl6s"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4104dee26bfso542445e9.3
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 09:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707411638; x=1708016438; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3DyBKSHXlMMt0UCKpbArTulR1UnkHRmk9PJeYMdWGms=;
        b=maOFRl6s0nh5fIk6wzEzEcV1RimwB1Gl8M+OVwdmAMd3JhuS4lcnXXNCvHzwUZ9Ii5
         e3eKz7gygdzbZZuVRWhc7lbh7exlmzs0AA7rubUi4KpUZNZd67eBELONEo0S/wOKvt3t
         WCRsnrGvZoFGKld1GDA/hxDivrHPHzp/PC3X+1EZ9xdXJeda3bSGAsp6DZyYvzjjpJ0C
         /nnnrnLhuQ+zjDHbtegsWiqvxwDwl54e2UeZ38yxzqmq7ccYu6WUHaXQoVQUdLADjlYI
         49JawKMLk1+qkWHv24v39kp67wlRENR01C8hj6FV/MtSto0fbGY0F2d1CL7BikbsFQUL
         +toA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707411638; x=1708016438;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DyBKSHXlMMt0UCKpbArTulR1UnkHRmk9PJeYMdWGms=;
        b=pOk31PjveSFwh7MM6YGjFpcuawtlv4qpSseV1IsOJqL/D9Z0NK3KTSgt32ckE44vb9
         udsSa2gDBenxmYTsC4jvJzgNwjn55lJE74IBsmbAWOWYxxIzFFMltBZXad9Q81eAvKe9
         oV+WYLKTrwTJC6IOHoF6ktfjf3WYCOiBfsDTalQDpKw6bqkHuqV1duWrTUJPe6HwAHLf
         DflCqeeeU5T4CeZosJykehFahPmDtBViRau7p8dwfGQ9+bXy1P+r1G99QAy64K9Fd+tU
         cOTRIbykBogl/uDgayUxS8rw8abFN1nM36K+R8OsEUa/mFPILkLXiy4VBL+kFfJQ34F9
         hxYg==
X-Gm-Message-State: AOJu0Yyvj1UGt/Lv3OKWGKB5R8uJefIIFOQ1NrgaukLhFUn/tfqYgVJC
	emimMEAkLN1Mi4KWqvNhBk7s3ih3JIBnDBV9Fvq0yvY39lol7gql6N0rSbgh
X-Google-Smtp-Source: AGHT+IF3vOW2W3qKcrGu6qgmliO2ZF5X+UPupzg0rqRAaXcvTw/aT6GMZmrY6V/kRgau0Vs3vPMpWg==
X-Received: by 2002:a05:6000:1086:b0:33b:1cba:d0e6 with SMTP id y6-20020a056000108600b0033b1cbad0e6mr55113wrw.37.1707411637395;
        Thu, 08 Feb 2024 09:00:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWB/b0BiwsbJB3MIMuWiUm50GoHeihavBbKrBLnfIBPA7P9A4kqVoICZH2NwstaYnwiPbFxIu3c67JezoLZ6fA6XPDlBiy4QfhAJQ==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d6dab000000b0033b495b1d10sm4050044wrs.8.2024.02.08.09.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:00:37 -0800 (PST)
Message-ID: <pull.1656.git.1707411636382.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 08 Feb 2024 17:00:36 +0000
Subject: [PATCH] prune: mark rebase autostash and orig-head as reachable
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
Cc: Orgad Shaneh <orgads@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Rebase records the oid of HEAD before rebasing and the commit created by
"--autostash" in files in the rebase state directory. This means that
the autostash commit is never reachable from any ref or reflog and when
rebasing a detached HEAD the original HEAD can become unreachable if the
user expires HEAD's the reflog while the rebase is running. Fix this by
reading the relevant files when marking reachable commits.

Note that it is possible for the commit recorded in
.git/rebase-merge/amend to be unreachable but pruning that object does
not affect the operation of "git rebase --continue" as we're only
interested in the object id, not in the object itself.

Reported-by: Orgad Shaneh <orgads@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    prune: mark rebase autostash and orig-head as reachable
    
    Thanks for reporting this Orgad, it reminded me that I've been meaning
    to clean up this patch for a while.
    
    I've got a patch on top of this that marks selected pseudorefs such as
    ORIG_HEAD and AUTO_MERGE as reachable but I've held off sending that as
    I think it would be better to rebase it on kn/for-all-refs once that has
    stabilized as that will hopefully allows us to mark all pseudorefs as
    reachable rather than using a hard-coded list.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1656%2Fphillipwood%2Fprune-protect-rebase-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1656/phillipwood/prune-protect-rebase-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1656

 reachable.c                 | 51 +++++++++++++++++++++++++++++++++++++
 t/t3407-rebase-abort.sh     | 17 ++++++++++++-
 t/t3420-rebase-autostash.sh | 10 ++++++++
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/reachable.c b/reachable.c
index f29b06a5d05..fef29422d4a 100644
--- a/reachable.c
+++ b/reachable.c
@@ -17,6 +17,7 @@
 #include "pack-mtimes.h"
 #include "config.h"
 #include "run-command.h"
+#include "sequencer.h"
 
 struct connectivity_progress {
 	struct progress *progress;
@@ -30,6 +31,53 @@ static void update_progress(struct connectivity_progress *cp)
 		display_progress(cp->progress, cp->count);
 }
 
+static int add_one_file(const char *path, struct rev_info *revs)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct object_id oid;
+	struct object *object;
+
+	if (!read_oneliner(&buf, path, READ_ONELINER_SKIP_IF_EMPTY)) {
+		strbuf_release(&buf);
+		return 0;
+	}
+	strbuf_trim(&buf);
+	if (!get_oid_hex(buf.buf, &oid)) {
+		object = parse_object_or_die(&oid, buf.buf);
+		add_pending_object(revs, object, "");
+	}
+	return 0;
+}
+
+/* Mark objects recored in rebase state files as reachable. */
+static int add_rebase_files(struct rev_info *revs)
+{
+	struct strbuf buf = STRBUF_INIT;
+	size_t len;
+	const char *path[] = {
+		"rebase-apply/autostash",
+		"rebase-apply/orig-head",
+		"rebase-merge/autostash",
+		"rebase-merge/orig-head",
+	};
+	struct worktree **worktrees = get_worktrees();
+
+	for (struct worktree **wt = worktrees; *wt; wt++) {
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, get_worktree_git_dir(*wt));
+		strbuf_complete(&buf, '/');
+		len = buf.len;
+		for (size_t i = 0; i < ARRAY_SIZE(path); i++) {
+			strbuf_setlen(&buf, len);
+			strbuf_addstr(&buf, path[i]);
+			add_one_file(buf.buf, revs);
+		}
+	}
+	strbuf_release(&buf);
+	free_worktrees(worktrees);
+	return 0;
+}
+
 static int add_one_ref(const char *path, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
@@ -322,6 +370,9 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	head_ref(add_one_ref, revs);
 	other_head_refs(add_one_ref, revs);
 
+	/* rebase autostash and orig-head */
+	add_rebase_files(revs);
+
 	/* Add all reflog info */
 	if (mark_reflog)
 		add_reflogs_to_pending(revs, 0);
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index ebbaed147a6..9f49c4228b6 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -40,9 +40,24 @@ testrebase() {
 		test_path_is_missing "$state_dir"
 	'
 
+	test_expect_success "pre rebase$type head is marked as reachable" '
+		# Clean up the state from the previous one
+		git checkout -f --detach pre-rebase &&
+		test_tick &&
+		git commit --amend --only -m "reworded" &&
+		orig_head=$(git rev-parse HEAD) &&
+		test_must_fail git rebase$type main &&
+		# Stop ORIG_HEAD marking $state_dir/orig-head as reachable
+		git update-ref -d ORIG_HEAD &&
+		git reflog expire --expire="$GIT_COMMITTER_DATE" --all &&
+		git prune --expire=now &&
+		git rebase --abort &&
+		test_cmp_rev $orig_head HEAD
+	'
+
 	test_expect_success "rebase$type --abort after --skip" '
 		# Clean up the state from the previous one
-		git reset --hard pre-rebase &&
+		git checkout -B to-rebase pre-rebase &&
 		test_must_fail git rebase$type main &&
 		test_path_is_dir "$state_dir" &&
 		test_must_fail git rebase --skip &&
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 693934ee8be..1a820f14815 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -333,4 +333,14 @@ test_expect_success 'never change active branch' '
 	test_cmp_rev not-the-feature-branch unrelated-onto-branch
 '
 
+test_expect_success 'autostash commit is marked as reachable' '
+	echo changed >file0 &&
+	git rebase --autostash --exec "git prune --expire=now" \
+		feature-branch^ feature-branch &&
+	# git rebase succeeds if the stash cannot be applied so we need to check
+	# the contents of file0
+	echo changed >expect &&
+	test_cmp expect file0
+'
+
 test_done

base-commit: 2a540e432fe5dff3cfa9d3bf7ca56db2ad12ebb9
-- 
gitgitgadget
