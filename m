Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D9D41325E
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833371; cv=none; b=lNvBKN2Zdx0whA60X7QCqFvlDDN57hgaihoJZhjmTiqvOWm3V0/byyHx9za5wmJf4u1WKlMEpA57QZa7BBuAOD5GllCnZROLlY5dSRVgV3tzBIrJdEe59+z61WdOILqif3T2rf8T996bqJvkrDoSdECoa1m3Ku5/+UNBcMEGb40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833371; c=relaxed/simple;
	bh=VEmqp2R5t0W1YfK9l1XDmDtgJ9VM7Y8lr8rp3k3WmA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9CVjAW+R7Z4EzqCI/BBMmvlGOvXwRW17W4eVLAhlmXBCA607JMVXVWGhf8rhWrcqkdYqfpejfJFlFQcJl4rfTan6/mlWa2tkNgjEllEizTflSY8W9EiNGgAWDOQedark7YKDpuxh4SxiW1GdLXc2ndh320DXBW7STSuM5/sYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3O3o9w4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3O3o9w4"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4763b0c1dcdso561654f8f.2
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782833365; x=1783438165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WVKH06geH7RiKeZHAUMNHTV/e6X3Ae4hiNZOgWToVu0=;
        b=M3O3o9w4faKtAUcyNCzFXDzNQ1T7o/lHMbKWWYdPYFYCS8m8drEVVqkJN+g3XIZKJ7
         qtr9/MagaYkpD3jdxrb+GG92JsvHrsKVPw+A92qWfjtTxX39d2IaXFErigHz40cvPNRy
         ZdlWUOPndWq3TQywVdNzH6U2gLOO1eU7IPRjmWsaOT6uJ2OcFaPzLanR7SZPNF2k/Swb
         bmp/EeHzEeIwqS2UqdzegvRVDuQisuWTarG5jdlLSG92wT7R9m+qBmp98k6mr3ay9WLw
         +6shBOZx4OH61SjB+8pRVD9k2NJHoscGtXdVu+Ku8lIBa3j+kseHzFQIre1/YfDDERDn
         EGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833365; x=1783438165;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVKH06geH7RiKeZHAUMNHTV/e6X3Ae4hiNZOgWToVu0=;
        b=J60DiX/OStCRbMCCXD5Qdgd06mW6iqNR6r7SkxjQxXjSDqA9+8+lceNr0BW8ZTc0a4
         afwkak5rKsb2AyGbMfJNLYzWS6Zi0s4j/MOwWGIewz17Z/W0Ml0kkHK9kJoKLY7BeOUM
         3xiRx0ir3wmhOhj+9AW0X/UzkPXwTXCmegfkd3KQa8+mIukSR1UbinSbzenICtJnwjoq
         kmmzEG6W8MpV3BMmyP87ERORbRII2oheugFwa+l/rPOnjMok0zgFJqvQ4P0043f6m39m
         2nO73X8ApEI1tuGiPriJfD07vKPeNeH4Njyv6gOOWnnqy9Gk27z04trMgSOZTfjEXTVA
         04Nw==
X-Gm-Message-State: AOJu0Yzer/0lFys1z1v8h4Z6SmASlL7LGlKeUmdeE7No3HnYbi/mYG/1
	SJuSeztOyiQ9xZBDgCow5tYRevHrAVLO6QIYuMPqUl9ES0868jmwAuk9+pJzXQ==
X-Gm-Gg: AfdE7ck2mk++ybksGkkjxN6gNvXWdnSOAY2LCiOvgdBQzRqfQFoApPDIC7/E061D0al
	r+sCmCAbypR9p1/b8BysT5kFb8Y+nNy5tkdMG6UsS1JZvn1BCz+YInV9/PhCqc3uxo8nOVuqZhK
	Rf7fUTLEIWv7Dcb6lzrgtAhoPPAEigCyyc6BhstYUzdm8X+rFR8LJ0pgL+qAeyb8c5m4iSdqgJ9
	YwCYyRz+wQC6YYc9anTBryCkVRpprbcZUe9hZn4CN6hyCMCmQDfrie6FvHQygQlNMux9c0uqI0f
	P6PjAkNsnMx6f7XCSc8wdF0nOZVa5kzfo+3XliHlIGgD5AXnRqKJ/RlpOOyy0tNl79bM4YMFO3l
	wrLaKogCoaNjXDkak+eDx08UH0WIPNMhZ6XK5AdtPHnQohuBLRKRa7sFh15YGx21RwW3phkS9sg
	MoTkJ868tmZIo5rSNI
X-Received: by 2002:a5d:5d0f:0:b0:475:613c:c9f2 with SMTP id ffacd0b85a97d-475613cca4bmr5978936f8f.5.1782833365180;
        Tue, 30 Jun 2026 08:29:25 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567979eafsm8477378f8f.34.2026.06.30.08.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:29:24 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 11/11] sequencer: do not record dropped commits as rewritten
Date: Tue, 30 Jun 2026 16:29:01 +0100
Message-ID: <26551f2687be0f5c1d2f503bdd50729a20b0dade.1782833268.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com> <cover.1782833268.git.phillip.wood@dunelm.org.uk>
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
post-rewrite hooks this means we end up copying the notes from the
dropped commit to the commit that was picked immediately before the
one that was dropped.

While we do not want to record the dropped commit is rewritten, if
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
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                  | 24 +++++++++++++++++++-----
 t/t3400-rebase.sh            | 12 ++++++++++++
 t/t5407-post-rewrite-hook.sh | 23 +++++++++++++++++++++++
 3 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ca005b969c4..a85f9e8b77d 100644
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

