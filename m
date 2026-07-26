Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97B3C109A
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785080365; cv=none; b=AQEe1WlAJxu0JzRauznGTC9BalVW5V/Y6VOnbfJudBWJsd0Mxn06YD/Um66Wq2I0mGxf6Mdwl+WAnRkpwIH4u1oaYQaw710qWWsdLibAsx+tS6EVMwgEI796Jt/g1yZs5uhMCfucuVWTZt7UNDHTkxjxUeVC/GjXhiNpuVDxELo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785080365; c=relaxed/simple;
	bh=HDbR5v3gKzKiPfracBHAQdSo0PNG250Qn4ikyebU0Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+iAbdotNHyZ/xte7bjp5Nc19J6PtFOukscANJlmWCWVKevK6e5mqH25kZ77Dv67+eq7qtTTPi/D8TynMma2dINOnJTx3tS0jIGBBIeRwpSdhPg+6Sj+ysisYZUbv/aAV8nj+6yahQw76rhJpPo8seX2CYNGdn51TooESCLuOeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNyYHybR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNyYHybR"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4955de8797cso11530455e9.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 08:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785080362; x=1785685162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5F6VaPGsduzNmRry2iv5GzFu2NnYJegylxoGR4sPoyk=;
        b=SNyYHybRZM3tMB3NwA+yEHjvEvOrhFGGk6jdYIDPTlovZAK+I99RcI48oZHZbxUgCH
         P11CEz88NSmDeWBhRXnQ4RxAv53JOPljZ789IKLulXM8AKfH8rD/9LItCNyzkvWJTLZ2
         eFLN6v/4MS4h4RiPBM1YCk/y6+RaYAqwl5b+x9YA3XKVoWjO1tIW9d8wew/CelnNl3rb
         x/ecBTcru4d7v9fQJXbDjjAucSUUGm6CMXNvfJ+W++m2BF/7w38G8VUhoHp2SEC33Kw9
         ECmWvA7wnlXDMf2dFrodMJy3INxtrS80CMOXfFd9OYLtMRtnCpk55boBGYMXCwq006Gz
         TSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785080362; x=1785685162;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5F6VaPGsduzNmRry2iv5GzFu2NnYJegylxoGR4sPoyk=;
        b=JoZcMAgjYeouxvYLQY+f9/KLVjrU4ZPcZNqjLJYqzCWrgc41uI6sW+8qAE/IG1ezKv
         6uFNboxiNkYXZJUnG5PCJNDkSI+CqGeoAaZx04XvSzxYlXF/r9BmcsaIGwoZJqG9omJU
         q1+VLwniGn/ysiON7rHLtsY+MfzN/PrhZuzAcDS8DmjjJ0KMr2UsBhHr3jBYfNeQ2OJR
         YO3ifuAlfo7QxlkR04FWQa9CWhvheXmJ0ivtZ6e250mn682mCAs5TJsIjoo0hcTBgmlQ
         +UiGSabJ7XgDfFrUTin6CE1po1GmPWc5XJwKZmnCIPL3FSyjrNPoBCuTTploB6aKSKHg
         8RzQ==
X-Gm-Message-State: AOJu0YwGcE25scO/p+cy2U/xbTE0X3cCSx1inElD3rm92hfVi3gxEcfO
	/l7Z8f5wluioDpPdu4f0SQc0Lx6SCYO12ErsCW1P7AMtoAma2AEBNme82fAh0A==
X-Gm-Gg: AR+sD106hwgiATnyToPxLysvashfg4+jkM3ZKiqBfat78Kk9+dK6VU5QYsRni3IWQEp
	W46o/t/dlIKVDwcbBOOP/yt3AYgXNH94wiZ1XA6TqlUt73fCuoveOr15JyizyLFFebfm9l/RY4u
	3O5i3DVEvi6S5U2YAA/BrA2c+hUe+gbLWe7D4IWKgtZp+ZVHEvBFM6sCqO3qjeSllV5k3iH/HC4
	QBh8I7nLwTOgDoHx+k43cE0vwNcKxcEef6ZQVgyqtyfivB6WZnHlVBRppNOw7U1kdJzeDVoCBFw
	fMnhn/vTjfpx8gfiMCnm2e+tFTWY0jHl1Ffv6hA3TNFCei/YbFitP78h2Al0AsptzT7msr+0VTS
	z8stQqH3aD/dbbw1fHGCNnpr6ylISV26JSqfP3W5I37lv+N7ucIENAVtYMVhbaUZIUQ+hXwLwm2
	zDmRe6/g==
X-Received: by 2002:a05:600c:a016:b0:495:63e6:5fb8 with SMTP id 5b1f17b1804b1-496b56fa3c4mr69775155e9.12.1785080362356;
        Sun, 26 Jul 2026 08:39:22 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f2639csm144035805e9.10.2026.07.26.08.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 08:39:21 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/2] rebase: remember fixup -c after skipping fixup/squash
Date: Sun, 26 Jul 2026 16:39:00 +0100
Message-ID: <3089979e2daf5bc8532008539e37695091dd10b2.1785080337.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1785080337.git.phillip.wood@dunelm.org.uk>
References: <cover.1784304378.git.phillip.wood@dunelm.org.uk> <cover.1785080337.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When the final command in a chain of "fixup" and "squash" commands
is skipped, we should prompt the user to edit the commit message
if the chain contains a "fixup -c" command that was not skipped.
Unfortunately, commit_staged_changes() only looks for completed "squash"
commands and so does not prompt the user to edit the message. Fix
this by recording whether a fixup command has the "-c" flag set and
then checking whether we have seen either a "fixup -c" or a "squash"
command. Add regression tests for skipping a command in the middle
of the chain (which currently works but has no test coverage), and
for skipping the final command (which is fixed by this patch).

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                     | 20 +++++++++++---
 t/t3437-rebase-fixup-options.sh | 47 +++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4640ee9b7f5..1a0a283b42c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1924,6 +1924,13 @@ static int seen_squash(struct replay_ctx *ctx)
 {
 	return starts_with(ctx->current_fixups.buf, "squash") ||
 		strstr(ctx->current_fixups.buf, "\nsquash");
+}
+
+/* Does the current fixup chain contain a "fixup -c" command? */
+static int seen_fixup_edit_msg(struct replay_ctx *ctx)
+{
+	return starts_with(ctx->current_fixups.buf, "fixup -c") ||
+		strstr(ctx->current_fixups.buf, "\nfixup -c");
 }
 
 static void update_comment_bufs(struct strbuf *buf1, struct strbuf *buf2, int n)
@@ -2148,9 +2155,14 @@ static int update_squash_messages(struct repository *r,
 	strbuf_release(&buf);
 
 	if (!res) {
-		strbuf_addf(&ctx->current_fixups, "%s%s %s",
+		const char *fixup_flag = "";
+
+		if (is_fixup_flag(command, flag) && (flag & TODO_EDIT_FIXUP_MSG))
+			fixup_flag = " -c";
+
+		strbuf_addf(&ctx->current_fixups, "%s%s%s %s",
 			    ctx->current_fixups.len ? "\n" : "",
-			    command_to_string(command),
+			    command_to_string(command), fixup_flag,
 			    oid_to_hex(&commit->object.oid));
 		res = write_message(ctx->current_fixups.buf,
 				    ctx->current_fixups.len,
@@ -5391,8 +5403,8 @@ static int commit_staged_changes(struct repository *r,
 				 * message, no need to bother the user with
 				 * opening the commit message in the editor.
 				 */
-				if (!starts_with(p, "squash ") &&
-				    !strstr(p, "\nsquash "))
+				if (!seen_squash(ctx) &&
+				    !seen_fixup_edit_msg(ctx))
 					flags = (flags & ~EDIT_MSG) | CLEANUP_MSG;
 			} else if (is_fixup(peek_command(todo_list, 0))) {
 				/*
diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 5d306a47692..a4b2a631654 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -184,6 +184,53 @@ test_expect_success 'multiple fixup -c opens editor once' '
 	get_author HEAD >actual-author &&
 	test_cmp expected-author actual-author &&
 	test_commit_message HEAD expected-message
+'
+
+test_expect_success 'fixup -c is remembered after skipping final fixup' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	cat >todo <<-\EOF &&
+	pick B
+	fixup -c A1
+	fixup A3
+	EOF
+	(
+		set_fake_editor &&
+		set_replace_editor todo &&
+		test_must_fail git rebase -i A A &&
+		git show && cat .git/rebase-merge/message-squash &&
+		FAKE_COMMIT_AMEND=edited git rebase --skip
+	) &&
+	test_commit_message HEAD <<-\EOF
+	new subject
+
+	new
+	body
+
+	edited
+	EOF
+'
+test_expect_success 'fixup -c is remembered after skipping later fixup' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	cat >todo <<-\EOF &&
+	pick B
+	fixup -c A1
+	fixup A3
+	fixup A2
+	EOF
+	(
+		set_fake_editor &&
+		set_replace_editor todo &&
+		test_must_fail git rebase -i A A &&
+		FAKE_COMMIT_AMEND=edited git rebase --skip
+	) &&
+	test_commit_message HEAD <<-\EOF
+	new subject
+
+	new
+	body
+
+	edited
+	EOF
 '
 
 test_expect_success 'sequence squash, fixup & fixup -c gives combined message' '
-- 
2.54.0.200.gfd8d68259e3

