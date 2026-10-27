Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098698;
	b=B8k1ydg8MFkD+v6rHvFIumN0edVsvlSf5n95dGeu5M4/3bS8WSJbyM2roibvD3W9Want
	 o9DlKG2ZQVkUoTf3XGl1lcFnce1EooHfiqQ8MQBoKf3hQ72GU3L4gLppgLJybFv1iQOTN
	 xopoiXan/mI7j7NmJLZYFQgxcCjm3kfGpNfsC6cbbUZ8hwCyV+ynjPR0tl1sH2LWjKoYz
	 d+LjQNeorWWgeanc3IagTuBcca8vSWyPPtrcs2BlbtfSNmDCck/cGvtw5fj1uApaaRjG2
	 6wwhjjYU5gqHEvqLvH/QnrrpG7Gd8sBbgqjN4qW2IPcDhHzmmwA7ixPyQswYta7OatQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K4VUOpaCoyrccYXMvQVN97ZNMfkE2WRmYnZ5ArwDJes=;
	b=24eCSC/zyP4jH4cWnBbllJ34Nus9FN7w4DaLH0XtrZexEMRoaXdcDlH1b+wQYK4ynsv2
	 VLRrfFPZ18LJcwaXF3+U3hhFAOdThKrd46nazHyDfSKUXvxlJb+Zcm2LKJrkjGGR4XBAz
	 VVaAkrrUkV/l8w8y/2AjplBE6nwMQ6cIJSP1Btr5lKVicV/e5q8e6ZG7bQWejrS9H4vty
	 YLha81SWLZXJ8Q56GL0eAx3oIou9QWMaou6c5sdqD7xrZvIzCqyWDTyAXsJMpv66YS3Bz
	 Tn8/DU9TTpuMLiHqm2mb7yUe0UjGnu01GSJm52JA1uRkqVivS/4BqZyauoFjE800BPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="rXZtD/CK";
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42591606A31D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42591606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rXZtD/CK
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so22067915e9.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 03:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793098697; x=1793703497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K4VUOpaCoyrccYXMvQVN97ZNMfkE2WRmYnZ5ArwDJes=;
        b=rXZtD/CKre/qgIf1bZTN11CWezTGA1tIfDjmykuiKSNLuNf2ys/K5r1WqYl7wiUVa1
         7R9bazycGOtnijwwD4VFytBZsEKz0m12v2Jn+0BXGskoKOkQRDmtZwGqAG+NTe0f1bWa
         0i8hGl38colVaByVcoXOZ+mjbGL7uFt7zt3Am62QPvBkljhoFHqZHT1BgqVGHN4Eh7Bl
         478nLxEDD0ztWyJI90/tUyNjUWbC4IsCazSHamDwn7aGxdXrIZp9kww6tO/yhx4WhuAn
         zx+5+hY/OKMGpUE/RAsozt5pyP6Exsgc8iqS7vhPX1BposvAsvr3+xkGgPGilk9BaQM2
         Z6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098697; x=1793703497;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K4VUOpaCoyrccYXMvQVN97ZNMfkE2WRmYnZ5ArwDJes=;
        b=1vXN2DfQ/g3rEZ1e/zNAmxJs5TX4RKGMdWRtnKNf0YUJoMiSUVlJ/s/BkbVnj/CfbO
         mmPEVYIGGGu7TGQVBe0kprnnbpemoc9G6cReXPE3YOPQt4YoejsRBl2356/NKlXKMlvX
         Ur2gyEciU7gR2+vT2F+mNdDS9T1tKOM+4UJyknI6eL3T84/cT6Bl0b/fTFRG3jx+fGak
         hJqzOgpS/CnG29nyN8HuNVWYKygGWS1QBSCekVHb9JcM5SUUQTkOa2jq8PSVnp2E1/2w
         8AcvrnEBAp4QaTGbdaR/0BCoepWlBFCK3NVzbE8kfqR4/v0o7i/f06ZX54ZliQ4D9W45
         AXZA==
X-Gm-Message-State: AFq9FYItcuvJ3GZV8uVkq4rEt/7j+0QZiuRwMEHeI58nOdp5nEYsHeQn
	Ts7TV+cZOZL3S8ioUdo9f2dW4SkX9V8Ys/XVSuqDi9fKmayp3/5BM2rnChR+1w==
X-Gm-Gg: AYBFou2w+az9AT+UAsDjbhysFnnYA0zQbe9xDG1tHliIQ9tKMjJNJDV1ws/OixxvU3j
	1fsg9GwmLW3EwQt8MUc8DUJ4YnklHgra/vrUmUo+uAR8205v3jrQtVqy9iJKdEKcxZfB/Ik/eeS
	mIxMjXs3u2yvGd/vL6hBw0nz/NkEwHdYOJ6TU1IYcwp3avriKL2Rt2H3SpFo+dEJGu4ax7RMxZJ
	8Py0lrgPbp5Ivj1a7NEQUmGW2UzKHWZ/hGBvOlX1aMdt8qGqQfzMvdm5MBNGzvJCMgWJom7yX47
	zrzwnG7qDI9HS7eW+It7HIIVodmZEO1l8kNanWd3DfZ6vspK1luVZC9ZSkf4H6WY77+YEx3Bgtv
	0g3r9DdtrnTd9tZKILNW5suloGpaK3H68c3jC0znsfVWjHxMyucPqTP/v3jXh3hByEGZCfaNrKG
	Rhi7fiML/JLbIqzVOxGguHkEZgjDf4lCdZo+xDyJwiQ5vGtMFe7s+N+VJcavzU5LkTwoJQiRe1M
	rV+CUnni2CxUIIV24OE0BCpPmwlD36x3XH4ye7bb/VUiy13J6T2yDWBqRc=
X-Received: by 2002:a05:600c:4e12:b0:4a2:5ca:767f with SMTP id 5b1f17b1804b1-4a35ac3f07amr177475455e9.4.1793098696427;
        Tue, 27 Oct 2026 03:58:16 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0aa0bcsm321638925e9.4.2026.10.27.03.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:58:15 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Long 76 <long76.git@mail.ru>,
	Matt Hunter <m@lfurio.us>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/3] sequencer: remove REBASE_HEAD at the end of a rebase
Date: Tue, 27 Oct 2026 10:57:56 +0000
Message-ID: <ba13c74698d2af3bd2ababbf2ff1a9738a81d501.1793098652.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.336.g97505d19352
In-Reply-To: <cover.1793098652.git.phillip.wood@dunelm.org.uk>
References: <cover.1793098652.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
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

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When "git rebase" stops for an "edit" command, a rescheduled command,
or for the user to resolve conflicts, it creates a ref called
REBASE_HEAD pointing to the commit that is being picked. The ref is
deleted at the start of each iteration of the loop that picks commits,
but not after the loop ends. That means if there are conflicts on the
last commit to be picked, REBASE_HEAD is left behind after the rebase
finishes. Fix that by deleting REBASE_HEAD where it is created in
do_commit() if the commit succeeds, and before we enter the loop in
pick_commits() so that it is removed when continuing a rebase after
a conflict resolution or failed commit.

Several existing tests are extended to check that REBASE_HEAD is
present when we stop for conflicts and is absent when the rebase
finishes.

Reported-by: Long 76 <long76.git@mail.ru>
Reported-by: Matt Hunter <m@lfurio.us>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                | 9 ++++++---
 t/t3403-rebase-skip.sh     | 4 +++-
 t/t3407-rebase-abort.sh    | 2 ++
 t/t3418-rebase-continue.sh | 8 ++++++--
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 2ac78e15b89..2d6a5f525c7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1781,7 +1781,10 @@ static int do_commit(struct repository *r,
 		if (is_rebase_i(opts) && oid)
 			if (write_rebase_head(oid))
 			    return -1;
-		return run_git_commit(msg_file, reflog_action, opts, flags);
+		res = run_git_commit(msg_file, reflog_action, opts, flags);
+		if (!res && is_rebase_i(opts) && oid)
+			refs_delete_ref(get_main_ref_store(r), "", "REBASE_HEAD",
+					NULL, REF_NO_DEREF);
 	}
 
 	return res;
@@ -5178,6 +5181,8 @@ static int pick_commits(struct repository *r,
 	unlink(rebase_path_amend());
 	unlink(rebase_path_patch());
 	unlink(git_path_merge_labels(r));
+	refs_delete_ref(get_main_ref_store(r), "", "REBASE_HEAD", NULL,
+			REF_NO_DEREF);
 
 	while (todo_list->current < todo_list->nr) {
 		struct todo_item *item = todo_list->items + todo_list->current;
@@ -5206,8 +5211,6 @@ static int pick_commits(struct repository *r,
 			unlink(git_path_merge_head(r));
 			refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
 					NULL, REF_NO_DEREF);
-			refs_delete_ref(get_main_ref_store(r), "", "REBASE_HEAD",
-					NULL, REF_NO_DEREF);
 
 			if (item->command == TODO_BREAK) {
 				if (!opts->verbose)
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index a1911c4a9d6..a2a5ac8ae01 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -97,10 +97,12 @@ test_expect_success 'moved back to branch correctly' '
 
 test_debug 'gitk --all & sleep 1'
 
-test_expect_success 'skipping final pick removes .git/MERGE_MSG' '
+test_expect_success 'skipping final pick removes REBASE_HEAD & .git/MERGE_MSG' '
 	test_must_fail git rebase --onto hello reverted-goodbye^ \
 		reverted-goodbye &&
+	test_cmp_rev reverted-goodbye REBASE_HEAD &&
 	git rebase --skip &&
+	test_ref_missing REBASE_HEAD &&
 	test_path_is_missing .git/MERGE_MSG
 '
 
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 9f49c4228b6..1703b5ae9b5 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -35,7 +35,9 @@ testrebase() {
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
 		test_path_is_dir "$state_dir" &&
+		test_cmp_rev d REBASE_HEAD &&
 		git rebase --abort &&
+		test_ref_missing REBASE_HEAD &&
 		check_head &&
 		test_path_is_missing "$state_dir"
 	'
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 8c43ef64fce..f35cd130921 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -28,7 +28,9 @@ test_expect_success 'merge based rebase --continue with works with touched file'
 
 	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
 	test-tool chmtime =-60 F1 &&
-	git rebase --continue
+	test_cmp_rev commit-new-file-F2 REBASE_HEAD &&
+	git rebase --continue &&
+	test_ref_missing REBASE_HEAD
 '
 
 test_expect_success 'merge based rebase --continue removes .git/MERGE_MSG' '
@@ -37,8 +39,10 @@ test_expect_success 'merge based rebase --continue removes .git/MERGE_MSG' '
 	test_must_fail git rebase --onto main HEAD^ &&
 	git read-tree --reset -u HEAD &&
 	test_path_is_file .git/MERGE_MSG &&
+	test_cmp_rev commit-new-file-F2-on-topic-branch REBASE_HEAD &&
 	git rebase --continue &&
-	test_path_is_missing .git/MERGE_MSG
+	test_path_is_missing .git/MERGE_MSG &&
+	test_ref_missing REBASE_HEAD
 '
 
 test_expect_success 'apply based rebase --continue works with touched file' '
-- 
2.56.0.336.g97505d19352

