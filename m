Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE563DB992
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674415; cv=none; b=X4IxA8Y0y9mvHrA2DOuove8Kc5UlzwIXodYL1GWkdP2icM5OueDdagkWK7bo5GofI/vsJjZREsBF8JIv6EGqc4g1sUm0egZwXG8BAaS+rvJbjbasvsSh4/b+V+SOaDq3oxmFyutSBnBwvH/IHdpvvnhAqxUrscunhBVYsdzE6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674415; c=relaxed/simple;
	bh=ozRlD4AWtxjb868HFVaODNABLpRITpdtz2Q7JV1D0dM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ffay+J4nDUCJ/qb5xqBdWHrh3KsluOF12YbdI7llf5apRa0pk8tcZBr49XYBivS5DPMtJBiKyz5NVbIZ22D50GJvDynCIjopEVivVfCMO+NeJZF8ixMJg5CJvo+4oO55wNfmC89ky07LfwpLVprD+Q6CgJbDiXCn15sonwdFmzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBAjKsNu; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBAjKsNu"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9f5637634so480828a34.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783674412; x=1784279212; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vSnfNB9yGGhjfO8aXn+qRSBRKqGTSMIajenTqsGu1II=;
        b=jBAjKsNuGg4v54jBYpm+MIVmRX2GOccJXBQ+7q7xeX5m+R9XmMWC3ykFUGIaRnGQ5J
         hnCP6Ue/3g8BE9Dj6Z0OVCODeXpR7IZ7FKda5MN+XALVnmsI/fiGnCbqGKaGhO5dl9bn
         43GdNZV1hYJRdQnyo5IjgKGfsS0wanvafoRyEasv14FmrmYDVmShsHLYdbxvicRYHHe8
         5yQl7jbngggb7yHsbG6CpF1it8W2K873S1MgKog87clWIt1BafXiDqWRVlDz4QWywzfs
         7RojEtihBNhs45bJvErSd48x/tZ6M33ZnA8bNP4eTSWdE6rOME+LcFQXpy1frWgsrI8s
         UtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674412; x=1784279212;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vSnfNB9yGGhjfO8aXn+qRSBRKqGTSMIajenTqsGu1II=;
        b=M3mjFjSzSE1+kqm/ppAVxPCVsOIom4dEYd5rDZHa8AJIvMwWIOGrqDIc9N0IqVfhMP
         gSWSxRF9hLxgaMWQK88pJ0VDd+dTlXDxdqFdmj1rsp7np/UNpDtXdkJEBYIjpWqBFStb
         Ke+NZF/HfyMnmmW5pKGKTnHXTFO8TIjP1X/1Sze01nqb1kEo3ZoYEbpLOYJEH896//xG
         npvEzFSsf1MIgXDGoC1FiczB94eupbnJW8YMtS2zlbyqyFBNvvF2Im3SJEqhcUbH6+pA
         UBW8KgPOWaayTjgFJBBIsnJhDXHvx4va1bIH84UcF60SFzW8KDkNEfQa8wz8vuRObqx1
         vt2g==
X-Gm-Message-State: AOJu0YztsdTarGDF2S8t7s6moGaJK8PagsRsGSqQXl9qSc0vBqwTaxGi
	YtWi1Ym1EH7nSCZ54YjO3hxOm03L8sk+lUaai3q7uVQ5PXRITuHTUF+JmJg93A==
X-Gm-Gg: AfdE7cm//O4uMBgtkpBIBzqQRZw+Eo+McITG3W9zfOvSAuPwmYNKbdQBg7jncrmKdio
	c0t2vhfJ04E9zbNLVy7owaTSwyKgqymYHjJTnuAgw0iBD+saFUYJiQyL31aJjQls4ytoWpJ2N8X
	ebdHt9u8WY8Of5JyUy11JAwOsl8ibhF7kBY9fv50InE3Lv8BH44vCAQi1m0vA1aMOemuay2fUI6
	si3EjkXIUAQv6d7rhXNqLUJFS/hhw4veaN9rFrZ7mf0FG0vj+bYyE0Zqwy4Svcn0yb6HpY0rKM5
	qFn3/gdDnARPDUMXusH6pu69nRWkFi/qxehgfiIdiScXfqDfXhtunaurIUFKf9brkIBysX5doOO
	at+dEV540kE7NAzJ8pnuiHcQ4y+MKlSAovbbJHWzaIE/HYcsiT3Rgv46CEYHvWVcHes/7G+vF3G
	PB7kOzeGaVHNsEVBXLqtBp1X60XA==
X-Received: by 2002:a05:6820:2106:b0:6a1:460a:3bd1 with SMTP id 006d021491bc7-6a36d76accbmr8124557eaf.0.1783674412136;
        Fri, 10 Jul 2026 02:06:52 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.20.197])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb262db2sm5993694a34.16.2026.07.10.02.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:06:50 -0700 (PDT)
Message-Id: <0a735117ad16f10013823b4c70c171962b4ce235.1783674396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
References: <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
	<pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 09:06:35 +0000
Subject: [PATCH v8 4/5] sequencer: share the squash message marker helpers and
 flags
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When "git rebase -i" squashes commits it builds an editor template with a
"This is a combination of N commits." banner, a "This is the 1st/Nth
commit message:" header above each kept message (or a "will be skipped"
header for a dropped one), and a commented-out subject for any fixup!,
squash! or amend! commit. The banner, the headers and the
subject-commenting all live in static helpers in sequencer.c wired to the
rebase state, so no other command can present a squash the same way.

Pull the three pieces out into add_squash_combination_header(),
add_squash_message_header() (which takes a flag for the "will be skipped"
variant) and squash_subject_comment_len(), and use them from
update_squash_messages() and append_squash_message(). Also move the
todo_item_flags enum to the header, so a caller reading the output of
todo_list_rearrange_squash() can tell an amend! (TODO_REPLACE_FIXUP_MSG)
from a plain fixup!. A later change reuses all of this to give "git
history squash --reedit-message" the same template.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 sequencer.c | 70 +++++++++++++++++++++++++++++------------------------
 sequencer.h | 30 +++++++++++++++++++++++
 2 files changed, 69 insertions(+), 31 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0fe8fed6c3..2387afd9b5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1880,18 +1880,38 @@ static int is_pick_or_similar(enum todo_command command)
 	}
 }
 
-enum todo_item_flags {
-	TODO_EDIT_MERGE_MSG    = (1 << 0),
-	TODO_REPLACE_FIXUP_MSG = (1 << 1),
-	TODO_EDIT_FIXUP_MSG    = (1 << 2),
-};
-
 static const char first_commit_msg_str[] = N_("This is the 1st commit message:");
 static const char nth_commit_msg_fmt[] = N_("This is the commit message #%d:");
 static const char skip_first_commit_msg_str[] = N_("The 1st commit message will be skipped:");
 static const char skip_nth_commit_msg_fmt[] = N_("The commit message #%d will be skipped:");
 static const char combined_commit_msg_fmt[] = N_("This is a combination of %d commits.");
 
+void add_squash_combination_header(struct strbuf *buf, int n)
+{
+	strbuf_addf(buf, "%s ", comment_line_str);
+	strbuf_addf(buf, _(combined_commit_msg_fmt), n);
+}
+
+void add_squash_message_header(struct strbuf *buf, int n, int skip)
+{
+	strbuf_addf(buf, "%s ", comment_line_str);
+	if (n == 1)
+		strbuf_addstr(buf, skip ? _(skip_first_commit_msg_str) :
+				   _(first_commit_msg_str));
+	else
+		strbuf_addf(buf, skip ? _(skip_nth_commit_msg_fmt) :
+			    _(nth_commit_msg_fmt), n);
+}
+
+size_t squash_subject_comment_len(const char *body, int squashing)
+{
+	if (starts_with(body, "amend!") ||
+	    (squashing && (starts_with(body, "squash!") ||
+			   starts_with(body, "fixup!"))))
+		return commit_subject_length(body);
+	return 0;
+}
+
 static int is_fixup_flag(enum todo_command command, unsigned flag)
 {
 	return command == TODO_FIXUP && ((flag & TODO_REPLACE_FIXUP_MSG) ||
@@ -2005,20 +2025,13 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 {
 	struct replay_ctx *ctx = opts->ctx;
 	const char *fixup_msg;
-	size_t commented_len = 0, fixup_off;
-	/*
-	 * amend is non-interactive and not normally used with fixup!
-	 * or squash! commits, so only comment out those subjects when
-	 * squashing commit messages.
-	 */
-	if (starts_with(body, "amend!") ||
-	    ((command == TODO_SQUASH || seen_squash(ctx)) &&
-	     (starts_with(body, "squash!") || starts_with(body, "fixup!"))))
-		commented_len = commit_subject_length(body);
+	size_t commented_len, fixup_off;
+
+	commented_len = squash_subject_comment_len(body,
+				command == TODO_SQUASH || seen_squash(ctx));
 
-	strbuf_addf(buf, "\n%s ", comment_line_str);
-	strbuf_addf(buf, _(nth_commit_msg_fmt),
-		    ++ctx->current_fixup_count + 1);
+	strbuf_addch(buf, '\n');
+	add_squash_message_header(buf, ++ctx->current_fixup_count + 1, 0);
 	strbuf_addstr(buf, "\n\n");
 	strbuf_add_commented_lines(buf, body, commented_len, comment_line_str);
 	/* buf->buf may be reallocated so store an offset into the buffer */
@@ -2083,9 +2096,8 @@ static int update_squash_messages(struct repository *r,
 		eol = !starts_with(buf.buf, comment_line_str) ?
 			buf.buf : strchrnul(buf.buf, '\n');
 
-		strbuf_addf(&header, "%s ", comment_line_str);
-		strbuf_addf(&header, _(combined_commit_msg_fmt),
-			    ctx->current_fixup_count + 2);
+		add_squash_combination_header(&header,
+					      ctx->current_fixup_count + 2);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
 		if (is_fixup_flag(command, flag) && !seen_squash(ctx))
@@ -2109,12 +2121,9 @@ static int update_squash_messages(struct repository *r,
 			repo_unuse_commit_buffer(r, head_commit, head_message);
 			return error(_("cannot write '%s'"), rebase_path_fixup_msg());
 		}
-		strbuf_addf(&buf, "%s ", comment_line_str);
-		strbuf_addf(&buf, _(combined_commit_msg_fmt), 2);
-		strbuf_addf(&buf, "\n%s ", comment_line_str);
-		strbuf_addstr(&buf, is_fixup_flag(command, flag) ?
-			      _(skip_first_commit_msg_str) :
-			      _(first_commit_msg_str));
+		add_squash_combination_header(&buf, 2);
+		strbuf_addch(&buf, '\n');
+		add_squash_message_header(&buf, 1, is_fixup_flag(command, flag));
 		strbuf_addstr(&buf, "\n\n");
 		if (is_fixup_flag(command, flag))
 			strbuf_add_commented_lines(&buf, body, strlen(body),
@@ -2133,9 +2142,8 @@ static int update_squash_messages(struct repository *r,
 	if (command == TODO_SQUASH || is_fixup_flag(command, flag)) {
 		res = append_squash_message(&buf, body, command, opts, flag);
 	} else if (command == TODO_FIXUP) {
-		strbuf_addf(&buf, "\n%s ", comment_line_str);
-		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
-			    ++ctx->current_fixup_count + 1);
+		strbuf_addch(&buf, '\n');
+		add_squash_message_header(&buf, ++ctx->current_fixup_count + 1, 1);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body),
 					   comment_line_str);
diff --git a/sequencer.h b/sequencer.h
index 64a9c7fb1b..b01f897020 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -119,6 +119,13 @@ enum todo_command {
 	TODO_COMMENT
 };
 
+/* Bits for the "flags" member of struct todo_item */
+enum todo_item_flags {
+	TODO_EDIT_MERGE_MSG    = (1 << 0),
+	TODO_REPLACE_FIXUP_MSG = (1 << 1),
+	TODO_EDIT_FIXUP_MSG    = (1 << 2),
+};
+
 struct todo_item {
 	enum todo_command command;
 	struct commit *commit;
@@ -208,6 +215,29 @@ int todo_list_rearrange_squash(struct todo_list *todo_list);
  */
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
 
+/*
+ * Append the "This is a combination of N commits." banner that "git rebase
+ * -i" writes at the top of a squashed commit's message, commented out with
+ * the comment character.
+ */
+void add_squash_combination_header(struct strbuf *buf, int n);
+
+/*
+ * Append the header (1-based N) that "git rebase -i" writes above each message
+ * when squashing, commented out with the comment character. With SKIP it reads
+ * "The ... commit message will be skipped" for a message that is dropped (a
+ * fixup), otherwise "This is the ... commit message".
+ */
+void add_squash_message_header(struct strbuf *buf, int n, int skip);
+
+/*
+ * Return the length of the leading subject of BODY when it should be commented
+ * out in a squash message, or 0 otherwise. An "amend!" subject always
+ * qualifies; "squash!" and "fixup!" subjects only when SQUASHING, since a
+ * plain fixup chain keeps them.
+ */
+size_t squash_subject_comment_len(const char *body, int squashing);
+
 void append_conflicts_hint(struct index_state *istate,
 		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
-- 
gitgitgadget

