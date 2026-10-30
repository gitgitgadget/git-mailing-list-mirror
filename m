Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370111;
	b=kAr7WFfqPqL/cAEMsxJsz5WT48oHdKxAV8yF80gqpFLpPUlavzWbfM5meim/eyXb5tWs
	 Hvf1wILTDeJNBzf7bcp0ILhn3NAI9LJzSsWpC+5JHEMoC2TggC5el78zIkiyBNS4ipQb8
	 UroluunE7+WXQUbtFokYnwcbYHBujOyAH/s4rSdGr18C860dLUsBNHL0ZSS1zV2Rph5lQ
	 4VLXoc7xN9IE2yMdrIJDzoxSls1uTEaSK/rmKaEuLzsHZ6jOd/bMAQDYhdhK5nduSi414
	 UqMv+5aU0AfjAukvwuFe2RZ0Iko0H5SalHWSkjm3nFeUD+eHm3KEu1euOC7XlbuR0BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B6nEcWNJ1LLUQ6xblQhrQyuZq7Y5ZwMKBTpsU8rwHLE=;
	b=2+SIFw3nzXVDc/9UMJjWJjZUHgumY7/VdddPxzFDAeMTtbJrsWwfYBTg2T7wJxurYUDY
	 x5LOL2dPu/jO1bCcaavkwxhZCXQNn+BZz99QMZssxD8HR6VjdR4JgMhzBIM0CtHQ/eKos
	 FDAJ/rQ0ewzFg7MtxKr9x61yl3SY3LcufUofwLkCvsl7vFtPBDBNe/q9uVNmLj10yqkhs
	 HTmMLh6qpDm3AtXAZpZUDk1s31Jjbj2KGx7UWMAeMCnqMakWCtF1/bm2jATZfqv3GJXWZ
	 vZqCyWjyZY3AcP+P0Puf2zDzXfiWgcsYJQbYnh++lmSBHEZYK/CJMEKmx8zWUiw7OoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=KSYd6pqt;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46D7606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 14:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D46D7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=KSYd6pqt
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f3c89594cso48063685a.2
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1793370110; x=1793974910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B6nEcWNJ1LLUQ6xblQhrQyuZq7Y5ZwMKBTpsU8rwHLE=;
        b=KSYd6pqtLSXohFa+TFc1d0BiXd0pJg5cyOLD0b5n/pMqx16IB7zGm9P4Sw4QeF2Ejo
         v4Zytop/LWv5n50UAmP8lYXG4QFlUPH2927tGHKKBoRPTrffofHVsoNF6EOMhUBsS0K/
         IXnywaqZFQyzii8lSkv3evaJIZ8BdTv9aywQ3Y+6LYW2KfD/hojg9eB8PiNljKl8q3xd
         KsEDlapgd9N+5QjGO5gKZjbqsMzCLc2QcDlxwNU7jm1QaOUxnlbZ+YP7sN9RaugYd/UO
         5CZaMu/az09i61x3wbxKewSzh1XDkr7WuJ+WCjM5UUfsPX+MEfH5Co7k+ygdg03mIzBG
         G9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370110; x=1793974910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B6nEcWNJ1LLUQ6xblQhrQyuZq7Y5ZwMKBTpsU8rwHLE=;
        b=BKaSGlDcccB8W1xgT8TxUwBaGkOEtTA+tx8eKWapR+1c/6f9zPrznoQNXWXmBi+FiL
         WE1ZcGvzj7VgOoJZyqezmOTioGydROXlhF05HnsGhIsa2JYw3AnptsPKMDleqinZ6u/c
         zaAOvidWbAR77gMqecDTbL25yUt73b+LQhnj2HDc+e7iNWL3ySjLMTQuwbyUpUghivlQ
         taoH0LD24V0oRMA6TbtCBIixipI5bj/VCsCPkBKuqQxGRXIsxoa3KP/FhvzWWClC89gg
         nbeCM+rlO4TJDftnbTerYT81b+CQKWvwZAoG324kxnuzOzMhJMpryhX0PqPuD189Q951
         Bqww==
X-Gm-Message-State: AFq9FYLf848kHZknmZ7e9MXaE94NYAY345KKXvcYvcmQp8LMDcOL3Jsk
	Ar8KGmpKxs+QF97NWJiXBMU9B2o1MhSEa3wnPI03Z3sQFw8HrZcuOvXvK+l9Tp2VbYj7xBij0Z3
	k7tcHcsaqxXu4sz6totgdGjDdzptuVyAwI+PEfPG4yp41YTPyIFhWZi1C0SiLkZ7h246JbDwz5o
	usHyYDiYHvNdsx4eaODdCRr3d9YuQm2gZthcFpgVXjlHoZDcQXvWePtxDzY4yp1VHl+Ls0VgzNg
	veRwen3KzyoD/6PlnuzvrJB4xKoeCk1yzcMibjnAQM=
X-Gm-Gg: AYBFou3xvKNHClXS/uSELvCErdc+LdXoMIwNq1wMxTK1xRnXrJAnlyX/fTySoL1v3gP
	AOJUPQgGNPG9xALoP2tlrUokTZL30N960Op6Wa7LZAeOLd6163/LBIhm6V6C/IM5LY1La4Ji2FA
	CiEOAVTaIaQR2I3h/21Y43r8UlfkcEweiG6QPtU8E5tV9E6LnIQHwCHU+7cgO4UTwwVaazql1qw
	Ad08pHWxs/vC9aT1Tk6vkp8vAkGTCLdq54KMogT2WMaoftUxepwB9nBH/G7Y7Pi0bUb9j7ibStD
	qk9KPLFttqmWBdVc0dZD6twktDNaCHTfNUh2TwGvDpV3mXDBlDY7hw4ok1msvGimjqN1B5teo10
	/AdICfNO384Ivjfzvl79Mah7l/ju6RLpoAErTxitd7d/kKyG0ryR2zQEcbvcu6HFhxCssDW54Os
	sGDrQX/wnIfXMFxSUny6Noh7USNv7g+VQcV4YBmhUAoztltWQcbTGzKtFdjOwR6qRYfoXetWflY
	YKiv+7+h8ZfJloJKfXtPr1God7gnB0ja3zWF7LNv12peyeb4tUP15i4ix6D31yfAp/kqo6A7549
	XgCnaW0Skzwn/GG2DneQVZH+0jWZfu6J/ljGozUTmrkZ2a1uYoKBM+STPuAE43WqfM87zEbIIo9
	C7WNH71mKiD4GRX5cqzy+qdgPrZEwu9th95lHSXnn9EdLUODL0FiIjMV+5B96ohYbpom/HktqCR
	7XDW4rOIY5DYHW4pYsimFhXzgplIwbhMUWxapKysE0kkDfLjH2S/pYfr3Gp9GFrspmBnwGmkk3L
	IxQZJqhmAYtbaD8BPlp1iDZO44HgJnSJbUpEdZL9nDJBosBl2ws
X-Received: by 2002:a05:620a:4404:b0:93c:9c0b:3898 with SMTP id af79cd13be357-944217217ccmr383889685a.59.1793370109498;
        Fri, 30 Oct 2026 07:21:49 -0700 (PDT)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944252e5492sm153831485a.1.2026.10.30.07.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:21:48 -0700 (PDT)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [PATCH 1/2] worktree remove: refuse a worktree in the middle of a rebase or bisect
Date: Fri, 30 Oct 2026 10:21:36 -0400
Message-ID: <20261030142137.54750-2-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030142137.54750-1-me@jaspermayone.com>
References: <20261024165311.57387-1-me@jaspermayone.com>
 <20261030142137.54750-1-me@jaspermayone.com>
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

"git worktree remove" refuses a worktree with modified or untracked
files unless --force is given, but it removes a worktree that is in
the middle of a rebase, a "git am" session, a bisect or a cherry-pick
or revert sequence when its files happen to be clean. The state of
that operation lives in the worktree's own $GIT_DIR, so it is lost
with the worktree. A rebase stopped at an "edit" or "break" line, an
"exec" that failed, or a cherry-pick sequence after a conflict was
resolved and committed is clean in this sense and still has work in
progress.

Treat such a worktree as unclean: refuse to remove it unless --force
is given, and name the operation in the message.

A worktree whose directory is already gone is still removed without
--force, as before: the check is part of the check for a clean
worktree, which is only done when the directory exists.

Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Jasper Mayone <me@jaspermayone.com>
---
 Documentation/git-worktree.adoc | 11 +++---
 builtin/worktree.c              | 31 ++++++++++++++++-
 t/t2403-worktree-move.sh        | 59 +++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index e6e77252ab..da4c38f909 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -142,9 +142,10 @@ the new working tree location.
 `remove`::
 
 Remove a worktree. Only clean worktrees (no untracked files and no
-modification in tracked files) can be removed. Unclean worktrees or ones
-with submodules can be removed with `--force`. The main worktree cannot be
-removed.
+modification in tracked files) can be removed. A worktree in the middle
+of a rebase, a `git am` session, a bisect or a cherry-pick or revert
+sequence is not clean either, because removing it loses that state. Unclean worktrees or ones with submodules
+can be removed with `--force`. The main worktree cannot be removed.
 
 `repair [<path>...]`::
 
@@ -189,7 +190,9 @@ twice. If the destination is already assigned to some other worktree but is
 missing (for instance, if _<new-path>_ was deleted manually), then `--force`
 allows the move to proceed; use `--force` twice if the destination is locked.
 +
-`remove` refuses to remove an unclean worktree unless `--force` is used.
+`remove` refuses to remove an unclean worktree, or one in the middle of a
+rebase, `git am` session, bisect, or cherry-pick or revert sequence,
+unless `--force` is used.
 To remove a locked worktree, specify `--force` twice.
 
 `-b <new-branch>`::
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 77ecd0f71f..ed08de1f43 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -26,6 +26,7 @@
 #include "submodule.h"
 #include "utf8.h"
 #include "worktree.h"
+#include "wt-status.h"
 #include "quote.h"
 
 #define BUILTIN_WORKTREE_ADD_USAGE \
@@ -1408,6 +1409,32 @@ static void check_clean_worktree(struct worktree *wt,
 			  original_path, ret);
 }
 
+/*
+ * A rebase, "git am", bisect or cherry-pick/revert sequence keeps its
+ * state in the worktree's own $GIT_DIR, and removing the worktree
+ * throws that away even when "git status" says the files are clean.
+ */
+static void check_no_operation_in_progress(struct worktree *wt,
+					   const char *original_path)
+{
+	struct wt_status_state state = { 0 };
+
+	if (wt_status_check_rebase(wt, &state)) {
+		if (state.am_in_progress)
+			die(_("'%s' is in the middle of an am session, use --force to delete it"),
+			    original_path);
+		die(_("'%s' is in the middle of a rebase, use --force to delete it"),
+		    original_path);
+	}
+	if (wt_status_check_bisect(wt, &state))
+		die(_("'%s' is in the middle of a bisect, use --force to delete it"),
+		    original_path);
+	wt_status_state_free_buffers(&state);
+	if (is_directory(worktree_git_path(wt, "sequencer")))
+		die(_("'%s' is in the middle of a cherry-pick or revert, use --force to delete it"),
+		    original_path);
+}
+
 static int delete_git_work_tree(struct worktree *wt)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -1461,8 +1488,10 @@ static int remove_worktree(int ac, const char **av, const char *prefix,
 	strbuf_release(&errmsg);
 
 	if (file_exists(wt->path)) {
-		if (!force)
+		if (!force) {
+			check_no_operation_in_progress(wt, av[0]);
 			check_clean_worktree(wt, av[0]);
+		}
 
 		ret |= delete_git_work_tree(wt);
 	}
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 69768c1207..4eb56a8911 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -271,4 +271,63 @@ test_expect_success 'move worktree with relative path to absolute path' '
 	test_cmp expect .git/worktrees/absolute/gitdir
 '
 
+test_expect_success 'remove worktree in the middle of a rebase' '
+	test_when_finished "rm -rf mid-rebase; git worktree prune" &&
+	git worktree add --detach mid-rebase init &&
+	test_commit -C mid-rebase rebase-me &&
+	test_must_fail git -C mid-rebase rebase -f -x false init &&
+	test_must_fail git worktree remove mid-rebase 2>err &&
+	test_grep "in the middle of a rebase" err &&
+	test_path_is_dir mid-rebase &&
+	git worktree remove --force mid-rebase &&
+	test_path_is_missing mid-rebase
+'
+
+test_expect_success 'remove worktree in the middle of an am session' '
+	test_when_finished "rm -rf mid-am patch; git worktree prune" &&
+	git worktree add --detach mid-am init &&
+	test_commit -C mid-am am-me &&
+	git -C mid-am format-patch -1 --stdout >patch &&
+	git -C mid-am reset --hard init &&
+	echo conflict >mid-am/am-me.t &&
+	git -C mid-am add am-me.t &&
+	git -C mid-am commit -m conflict &&
+	test_must_fail git -C mid-am am ../patch &&
+	git -C mid-am reset --hard &&
+	test_must_fail git worktree remove mid-am 2>err &&
+	test_grep "in the middle of an am session" err &&
+	git worktree remove --force mid-am
+'
+
+test_expect_success 'remove worktree in the middle of a bisect' '
+	test_when_finished "rm -rf mid-bisect; git worktree prune" &&
+	git worktree add --detach mid-bisect init &&
+	test_commit -C mid-bisect bisect-one &&
+	test_commit -C mid-bisect bisect-two &&
+	git -C mid-bisect bisect start HEAD init &&
+	test_must_fail git worktree remove mid-bisect 2>err &&
+	test_grep "in the middle of a bisect" err &&
+	git worktree remove --force mid-bisect
+'
+
+test_expect_success 'remove worktree in the middle of a cherry-pick sequence' '
+	test_when_finished "rm -rf mid-pick; git worktree prune" &&
+	git worktree add --detach mid-pick init &&
+	git -C mid-pick switch -c pick-src &&
+	test_commit -C mid-pick pick-one &&
+	test_commit -C mid-pick pick-two &&
+	git -C mid-pick switch --detach init &&
+	echo conflict >mid-pick/pick-one.t &&
+	git -C mid-pick add pick-one.t &&
+	git -C mid-pick commit -m conflict &&
+	test_must_fail git -C mid-pick cherry-pick pick-src~1 pick-src &&
+	git -C mid-pick checkout --theirs pick-one.t &&
+	git -C mid-pick add pick-one.t &&
+	git -C mid-pick commit --no-edit &&
+	test_path_is_dir .git/worktrees/mid-pick/sequencer &&
+	test_must_fail git worktree remove mid-pick 2>err &&
+	test_grep "in the middle of a cherry-pick or revert" err &&
+	git worktree remove --force mid-pick
+'
+
 test_done
-- 
2.56.0

