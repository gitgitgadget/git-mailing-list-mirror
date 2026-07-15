Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513F48B39E
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128950; cv=none; b=Ac+1zow9qOqpiUVKWAXrvSWGrI7bWdjsL+NLCknPFsgHyNKhaMG7aJ7E+6OAxFpEYRsgM6pmvesmK5Dc/+LDL+RY0mfiTWiB9sM4zdg3InyjyrWc4ASSv8HQwrokwiOsQ/Fz1clSz/tcPYzqA8BjKtdI/rlymOIuPFYc3FHasRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128950; c=relaxed/simple;
	bh=jKsBcFwBE1k+bSRWGyNjQxKfgT0FaYmEYKua0udDxLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cO+/YKtyWoOltQw8cL8pkPdyxeaW0dHpIT4YaoCtaUI1nuWU0clvZsvQqRaEd1/+JkZhGFjcl4G47ilF2ACPp7KrSfbluHLMMWdF4jKBmt30BAFPEBoxwjmUzA46fHTh6WFPRMJ2Rp0pntLm3RVIiuRv9mRoJ8inT4mrvidNVlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7JfvyDw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7JfvyDw"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b779003fso24277535e9.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128947; x=1784733747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:reply-to
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KQP0RqeE1RxYEV9XfwHx3yuFhoS9Xr8yjOe5Ik7GAXY=;
        b=L7JfvyDw2YCvoW08WrN574mc2aBmb04Pp9q5jZbag/PMtg5dgFSVG4y/TzS8Agk1nI
         obSefB82ZVFTCD1wjPvjw7ETGs8td7cnoYHmje0Ob8sFf2LPJoucIIWaWQTmnfGOLj9u
         JkZH0LYbS2CxNc9Bjq5NFuj5pN+Jzq1filGfa1oFXewFKX+cwO0pW1yrXVdOIJ0qjaK9
         +w319c7W72QY7wEfTH4ZdOdlN5THlAQKHzofXzMsEWaLF86HZZi0u6VbwOhGVml2hCjX
         RYojPmdQi80204woXOFji8Tv2ERv6+nYyeZH5P0eZE7CEbSrbmxJJztusIMsE3pYU/o8
         oK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128947; x=1784733747;
        h=content-transfer-encoding:content-type:mime-version:reply-to
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KQP0RqeE1RxYEV9XfwHx3yuFhoS9Xr8yjOe5Ik7GAXY=;
        b=mZRQPVbzp7jy9+ep5OONfnR6VydUWDlyLevTjUhDfrPWIFf9ddF9xJSolJ6O8y1XX4
         BZhgko1g7IvREPGRhh1gICLK3wosnl+Hs3cozExak0AOHdxBAjy5jE00U9BwOk/3R7E0
         Ra114w4MK5KugiqTavDddTFYhyadLB4TSY9NqWoHCCX72YQtiTkGGaBPmm8ZM98VgCns
         Kh2SYGgh9MSIMy2/mR8rXFAfEJHVbybyRUwybPJfA2aOVP9JmSNkN8XhKPoOnR80CEz7
         /imFcd9308LzgePajZWN1zlTywdrq6/ENTlXufGIzGB4cZJT2yrXc7x4IytDa6RZFQwR
         ONhQ==
X-Gm-Message-State: AOJu0YxdFmeT+fzUgiJZLGBJ4kaiIVkG2M/+qg3QSSyC5VK/c7U4tnMR
	6RS2dXXLtfr2RMS0mWHrgfftedkS5RcoJNQMulJIHHhhJuc0tU9ypDHWhhMzrQ==
X-Gm-Gg: AfdE7cksM8F2R9c5eMVWoc7Y0r8EbpKRmzob2qGqzk/GraFRG5rWnzJw9Ps0jgYc5kr
	EWv/85r/c/FmXWiiET4nYNEnlO2WRtEPWorHGD0v5js7yqcdZKMHr3XPMZ+WGG0GzVt7S5nSXnm
	AGnoM0An58Bpr61OwtlIRKjpG7vvHCnx53kPWah/4XuRyo7FqrPy/ocjFL6gbcZWQR1D/l23OlO
	aVT6AAZwTQkeEtgcW6+7i3P4QqZl3MJYoyjz1sZZSdxAKz1r8paC1wd/Z5IBb+OKMa1dfb39Z6g
	eRl0txNzzPPz66Mklg75JKf1Zq89l8aC77rVcYjGL1fMT4NU92z6XgRqQ/P8A5TZId9IkJCcPrk
	HZfokzWbbTjFokq0FIjNnAHzdAXFSenAmKYu8+FZjz4bhxKw/8dkfFv5gdUidBtYwTrD6zWHA1p
	5JLuip88dWtR4XXGRyGxS+PWB8gwQ=
X-Received: by 2002:a05:600c:54c8:b0:493:bc4a:fb50 with SMTP id 5b1f17b1804b1-495389e3322mr60742095e9.38.1784128947172;
        Wed, 15 Jul 2026 08:22:27 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953df0fc6esm51043395e9.9.2026.07.15.08.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:22:26 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Andrei Rybak <rybak.a.v@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 9/9] sequencer: do not record dropped commits as rewritten
Date: Wed, 15 Jul 2026 16:22:03 +0100
Message-ID: <2ef36b9ee5a399e1922e9b4620b04d33d0b10f02.1784128921.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1784128921.git.phillip.wood@dunelm.org.uk>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk> <cover.1784128921.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If a commit gets dropped because its changes are already upstream
then we should not record it as rewritten. As well as confusing any
post-rewrite hooks, it means we end up copying the notes from the
dropped commit to the commit that was picked immediately before the
one that was dropped.

While we do not want to record the dropped commit as rewritten, if
it is the final commit in a chain of fixups then we need to flush
the list of rewritten commits. The behavior of an "edit" command
where the commit is dropped is changed so that "rebase --continue"
will not amend the previous pick. However, as the code comment notes
it will still be erroneously recorded as rewritten when the rebase
continues. That will need to be addressed separately along with not
recording skipped commits as rewritten.

The initialization of "drop_commit" is moved to ensure it is initialized
when rewording a fast-forwarded commit.

Reported-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Tested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                  | 24 +++++++++++++++++++-----
 t/t3400-rebase.sh            | 12 ++++++++++++
 t/t5407-post-rewrite-hook.sh | 23 +++++++++++++++++++++++
 3 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4b3092dc9bb..7a5898b215d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2264,6 +2264,7 @@ enum pick_result {
 	PICK_RESULT_ERROR = -1,
 	PICK_RESULT_OK,
 	PICK_RESULT_CONFLICTS,
+	PICK_RESULT_DROPPED,
 };
 
 static enum pick_result do_pick_commit(struct repository *r,
@@ -2279,7 +2280,7 @@ static enum pick_result do_pick_commit(struct repository *r,
 	const char *base_label, *next_label, *reflog_action;
 	char *author = NULL;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
-	int res, unborn = 0, reword = 0, allow, drop_commit;
+	int res, unborn = 0, reword = 0, allow, drop_commit = 0;
 	enum todo_command command = item->command;
 	struct commit *commit = item->commit;
 
@@ -2509,7 +2510,6 @@ static enum pick_result do_pick_commit(struct repository *r,
 		goto leave;
 	}
 
-	drop_commit = 0;
 	allow = allow_empty(r, opts, commit);
 	if (allow < 0) {
 		res = allow;
@@ -2574,6 +2574,8 @@ static enum pick_result do_pick_commit(struct repository *r,
 		return PICK_RESULT_ERROR;
 	else if (res > 0)
 		return PICK_RESULT_CONFLICTS;
+	else if (drop_commit)
+		return PICK_RESULT_DROPPED;
 	else
 		return PICK_RESULT_OK;
 }
@@ -4994,18 +4996,30 @@ static int pick_one_commit(struct repository *r,
 	} else if (item->command == TODO_EDIT) {
 		struct commit *commit = item->commit;
 		int res = pick_res == PICK_RESULT_CONFLICTS;
+		int to_amend = pick_res != PICK_RESULT_CONFLICTS &&
+				pick_res != PICK_RESULT_DROPPED;
 
-		if (pick_res == PICK_RESULT_OK) {
+		/*
+		 * NEEDSWORK: Do not record the commit as rewritten when
+		 * continuing if it was dropped. Does it even make sense
+		 * to stop if the commit was dropped?
+		 */
+		if (pick_res == PICK_RESULT_OK ||
+		    pick_res == PICK_RESULT_DROPPED) {
 			if (!opts->verbose)
 				term_clear_line();
 			fprintf(stderr, _("Stopped at %s...  %.*s\n"),
 				short_commit_name(r, commit), item->arg_len, arg);
 		}
-		return error_with_patch(r, commit,
-					arg, item->arg_len, opts, res, !res);
+		return error_with_patch(r, commit, arg, item->arg_len, opts,
+					res, to_amend);
 	} else if (pick_res == PICK_RESULT_OK) {
 		record_in_rewritten(&item->commit->object.oid,
 				    peek_command(todo_list, 1));
+		return 0;
+	} else if (pick_res == PICK_RESULT_DROPPED) {
+		if (is_final_fixup(todo_list))
+			flush_rewritten_pending();
 		return 0;
 	} else if (pick_res == PICK_RESULT_CONFLICTS &&
 		   is_fixup(item->command)) {
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index f0e7fcf649a..1d09886ea35 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -274,6 +274,18 @@ test_expect_success 'rebase --apply can copy notes' '
 	git reset --hard n3 &&
 	git rebase --apply --onto n1 n2 &&
 	test "a note" = "$(git notes show HEAD)"
+'
+
+test_expect_success 'rebase drops notes of dropped commits' '
+	git checkout n1 &&
+	echo n3 >n3.t &&
+	echo n4 >n4.t &&
+	git add n3.t n4.t &&
+	git commit -m n34 &&
+	git rebase HEAD n3 &&
+	test_commit_message HEAD -m n2 &&
+	test_must_fail git notes list HEAD >actual &&
+	test_must_be_empty actual
 '
 
 test_expect_success 'rebase commit with an ancient timestamp' '
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index ad7f8c6f002..51991956d1d 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -306,6 +306,29 @@ test_expect_success 'git rebase -i (exec)' '
 	cat >expected.data <<-EOF &&
 	$(git rev-parse C) $(git rev-parse HEAD^)
 	$(git rev-parse D) $(git rev-parse HEAD)
+	EOF
+	verify_hook_input
+'
+
+test_expect_success 'rebase with commits that become empty' '
+	cat >todo <<-\EOF &&
+	pick H
+	pick E
+	fixup I
+	fixup H
+	pick G
+	pick I
+	EOF
+	(
+		set_replace_editor todo &&
+		git rebase -i --empty=drop A A
+	) &&
+	echo rebase >expected.args &&
+	cat >expected.data <<-EOF &&
+	$(git rev-parse H) $(git rev-parse HEAD~2)
+	$(git rev-parse E) $(git rev-parse HEAD~1)
+	$(git rev-parse I) $(git rev-parse HEAD~1)
+	$(git rev-parse G) $(git rev-parse HEAD)
 	EOF
 	verify_hook_input
 '
-- 
2.54.0.200.gfd8d68259e3

