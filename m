Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C73B71D2
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900127; cv=none; b=KTpLJZFJa5BH6waw2koEGKLJshCfzPffWCDtrFf00SL1izjLZX9MKUL8Q0V1x/Hv1tQA7QPlG7W6uFnXumOuTxXDIYfF3lLtLw1ZXZApAqmYNmO6IAAGpvVmtVI/Jss+rH0EYQKUsUtLmzNff6eAg2N51VFWTeEFUU7js9W4+ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900127; c=relaxed/simple;
	bh=WtgryEIKdKb/k2PdREuUqAqG9k0fa0fgU/FePRajvGg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wf1K4E/8SznlUToIb1wC75/w49RgxI9zl+Hq5iVBQu5u8bWJqJ8+hr5bD/mqOi0SNciyygrJ6Qc1E8xqf9BTS7NGem0tlY25gCBaesSSXvBVwxn8lnykOcRWvlozkKU768RMjuntjyLah9SSl8/jtCbo/UlPh+vwH4bFp7BBNHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPcgA/eE; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPcgA/eE"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90e9e042ee1so53185686d6.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 13:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788900124; x=1789504924; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JaEBtkmYxIayU6lHp07mYi81kSwl5z5hzxNtube4cis=;
        b=VPcgA/eEWZKOxCvEEEFiAFEn6wHgXvikmB8AjZaI79SDHnZNdCC2hbO7r41Ahsmski
         gjrlG1YUkIKMBnaChjhGvIs0evRNXkNMBGN5rOL7IzJYqJnPP+i2PAoS3dFfklxOB48a
         DnYCs7v0i505tL4kXXKNglDjv2RiwdywmkWn2yJ0Bq9dPYkW+CW4bk+ZTsok6TxNHAEy
         /n5FdAAreabYRNKwThWtyOFcvriOPb0Vc6hwmgUleLiNNVP92fYYFnhiT2wSpwIoRkNj
         b7bsXrKtL0sBhonPdzscotNVc3EsnTc7V1sgQFF/at1v6vaeGv/Gvfs6oKWKG4x1d0V2
         Z3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788900124; x=1789504924;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JaEBtkmYxIayU6lHp07mYi81kSwl5z5hzxNtube4cis=;
        b=hS6V79n0uGaPu+OwLrZjP99rW5yGOMuXymbgIv9TlzVbxGbVUD38lvV+IzCIJP1zWm
         F7i1RrPYyrRj8VKbGo+PtlncsfmpKs8YSCznfTyYPzKeJQ4tFp/54PpVvrzHfIgA+zmg
         He2qeNSWzsnXHXxToWlb0eo3ha4oKDs0G87vcTOvpWfXs5NZh+ob45PyxoWcsKtQsQyi
         gZ6QvwmV02aw6JIw2+1C7rKJHSqa7pRyCDv+ZFZPXQ+HUL440I20gXDZ7gXI7aMW8rMz
         RrlvcXmLrsrOjRnWUPekZaaooUBeMOK+Ks/FwurWW+No59VJzmyFJ2VQAwC402mS3xA+
         emYg==
X-Gm-Message-State: AFuF++kFBq2l3Cnc3RSWGBUlpL0EugxRBnBhCC4pcB4tuuTDh43lrFd8
	ATYSXww0VHvW4UFQKW3rWJ0rmUQfwkeM48LeaaB4y35cnZ/OvdEoybzHHZoKfA==
X-Gm-Gg: AYBFou2cwO68nIfCwSokZKfAWApMT4f/jDYxE3mH+5u8IRaE+4eX+0+ebYflNMo8a1Q
	wqesMPHlhzw+Wqh+wHrwdU7w5ul8rVvAW4Y7rXEx9IUPUOVXkGlHbuqX2jJ2Zfv7fLd6wDCnpFl
	Q9VtkYeivEZx0L8+UuRJXiI4B34e2LkjHl2SquA0ZZWY6MjkeNQfmoPlrFVIrJuFBvGaPHNZIT9
	PaW4O3NMWafQb+xBOELD6D8BcpOu7DzVy+zylV654bE/+n1Rm13oJ9C3At/2IdEBlu9ptcOOcQT
	pUb/mk20iEUXJMM5xxS2quYPT5B1fSpkd3QCElbiQv2oQA+AMnKJ4/xWtE/GzQAop6ZkWmvedTU
	9g3vh/QiVjxnYRClF+FbUhJY6PjW1fw7wh98Nlh+A15ZmtemazMcPiasubJc2yHTYq2TfKkVkOZ
	79O+CHWrWhaHtpCLdSLJJQFaL1tRbUxtqmEyvzS+xs1AB2RHt/Wp3pEtDVio62nYFK
X-Received: by 2002:a05:6214:45a0:b0:90e:9138:c8ea with SMTP id 6a1803df08f44-9103ef0e61cmr369125036d6.9.1788900123737;
        Tue, 08 Sep 2026 13:42:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.198.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106412e038sm30022626d6.20.2026.09.08.13.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:42:03 -0700 (PDT)
Message-Id: <b7a1796838099d0fa2c9782f614c8db70d516a53.1788900119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v15.git.git.1788900119.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v15.git.git.1788900119.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 20:41:54 +0000
Subject: [PATCH v15 3/8] sequencer: share the squash message marker helpers
 and flags
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Tuomas Ahola <taahol@utu.fi>,
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
history squash" the same template.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 sequencer.c | 70 +++++++++++++++++++++++++++++------------------------
 sequencer.h | 30 +++++++++++++++++++++++
 2 files changed, 69 insertions(+), 31 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 65afd100d9..557149d62f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1881,18 +1881,38 @@ static int is_pick_or_similar(enum todo_command command)
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
@@ -2013,20 +2033,13 @@ static int append_squash_message(struct strbuf *buf, const char *body,
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
@@ -2091,9 +2104,8 @@ static int update_squash_messages(struct repository *r,
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
@@ -2117,12 +2129,9 @@ static int update_squash_messages(struct repository *r,
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
@@ -2141,9 +2150,8 @@ static int update_squash_messages(struct repository *r,
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

