Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBEB3FB042
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088380; cv=none; b=cte7lrBx5Y//AYK+A9dA8ttY98tjWpfxTAWhVOz33eEx9wrAO7qi9RS1mYXnK8jSs2choUges8qSrIV45Dss5O44qYYMtOXOA5kdUCSjL/DTPl9iTquF6qeI+5nUeySU8ITkylXRh0ceZf4p2dK4pB1VqecMyr2QHhJr44tdcUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088380; c=relaxed/simple;
	bh=zTBLbCY42qzEPfo3FsH7g6zI610YC+mC3Skd9pT2eRY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=p5nskg5hVlj9xQteL6XjNW0YnwVcWR4pw4/4SRUJFqk7vsMmpIc/7dGLdLZNcW36fUZOtvJl4qFsOkxzBBDwnnDxtwNPd81m4oO7IcU+a7a6hF13TH9R14O67j8K43tV5F4ScCOCYbF7jeRk7nl7KVLkIhO6+5Wqc/gUpWX4Mo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx2Lyj3f; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx2Lyj3f"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caced6038eso21932795ad.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 00:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786088378; x=1786693178; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mhb8wnXFctJ0aaIPK5apOuJQxue+/A2xZsLxk7nvcks=;
        b=kx2Lyj3ffYu6dWJ/3JZIRvhWLWKkuHQLD/Cxqh0ya9CjuNyob7ZTbnxjRpg9KbIu8M
         k9sQc/04nreV0GdPHDbjLoQVYnmIsqX1VToTpKzMTdb0vdnzKSnUr61lzrm6M0kvRH5f
         KOdKTS1R0AhjDkiY2H0f5heVAUocq8ncTk/cPTp7j4sG3hr5BMwvJqNHQBc1z0Ngl1rV
         ojlZIQZqvFIGmMejw2R/BBJ6GMHY4L5E3iZhGA8tah6wG83KBCQYxoo5p13oTeqPCpBY
         iMUmMLy5B0KC1z149Jou+CJEBZECTgonUxlqdfLC7HUyDkMIl4tUwOiQLQUixxBxrHI/
         lTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786088378; x=1786693178;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mhb8wnXFctJ0aaIPK5apOuJQxue+/A2xZsLxk7nvcks=;
        b=O/lgFKz4z3UGPctaioYmA0bIgR9Ap6jbGNpi767GgmStMLcTXWwnHnvv3iupwIHoJn
         7jttpmk6ew/JpFlzUmadtPlgO5YkOfDXrhEF4X82OWrYLaeiFWaTYZ004f7IaTvGWixW
         yUmDtoeftQjvOigLgjoLgL6TSZ27xCn0/xtbT17WD56p4C55oJjIiiVc7uiiqEU24T4h
         f6Fdv1aoEPvjpEkeESFIAFgL3MIAg18b5L6vt3OmpLJy+2MGNgKL7mgZBKiOIMGk6upo
         crf73XmjfoSINXMtaUljzOzlNi4wOXkBmXZZj/R+RF06gil4C/k5skIgLyCrUIgvikSr
         CVuA==
X-Gm-Message-State: AOJu0Yz/sXGS9pyJvW7bwo57szH2SpWzRfrXgAbacVP5uN/v9Gm3CmYe
	0R/QHC1/GOPz2sizx9WOH5Qrxh7eE3h0EpOi4BQMeLQzjURa1Ub0/0i0+VUGaw==
X-Gm-Gg: AR+sD125tL8JarLznDwVtKGFsQBdLPiXsnCK8vRuxWCyqMo7n5s/KS3+vubJ173/gct
	UmvEXrJjNEPFSBvUI2mbtHuT5tWxq+L0BM5Vvlr8pSQWuRZbIttJVRUkfaMjAvQUuaS1SKBanLq
	YjIUgqbaO51N2OhuqepVj6+bEA3acRxhzfZ0oTt9cTIOA+B5vBfK5GYJbliW0jSRdDr3t/DAnsK
	Nb7FOMIDWOOpz8GfthDSjAVBgjWvYBvInRL99qJ36gpAafNU97Q3RpSs41DdAzGWl3W1P9vv1zg
	8GjrHn6c/qbfuEqo1PXU1xeVF9Senp722LHIlWHbYX//dHsgKPhBQHySWKB2hld++aq7qkZt17K
	cph/hGx4/FBHcRtxcGPIanZDr0sqE3BVHQPqassXyTuUvGVxouqmo24xmRtx/l8Rnp7Ygy7IzDP
	SohBO4O/yPeonJiXNOO9i7BTeo4cYvRT3tMNnJ6ftdw01hagvpEAyoMBTC1Ilmocw=
X-Received: by 2002:a17:903:308d:b0:2d2:72b6:556b with SMTP id d9443c01a7336-2d272b6577bmr14478605ad.13.1786088378482;
        Fri, 07 Aug 2026 00:39:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.82.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c50cfc1sm4791515ad.82.2026.08.07.00.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 00:39:37 -0700 (PDT)
Message-Id: <cdbdd766b26e467749266a778ddc97bd0492c278.1786088371.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 07 Aug 2026 07:39:26 +0000
Subject: [PATCH v13 3/8] sequencer: share the squash message marker helpers
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
index 83c3849205..4d2d59ecbe 100644
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
@@ -2012,20 +2032,13 @@ static int append_squash_message(struct strbuf *buf, const char *body,
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
@@ -2090,9 +2103,8 @@ static int update_squash_messages(struct repository *r,
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
@@ -2116,12 +2128,9 @@ static int update_squash_messages(struct repository *r,
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
@@ -2140,9 +2149,8 @@ static int update_squash_messages(struct repository *r,
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

