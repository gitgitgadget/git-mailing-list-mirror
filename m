Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999131C2A4
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="omFBASwv"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D9E121
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 13:22:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a8ee6a1801so53776847b3.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698697377; x=1699302177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfo8/CSFnTnIsaToydsJzXpp4ouXWIX3119SnI96MuM=;
        b=omFBASwvhtIebwf6tJo8RrME5/eJ93pBRsh+q0ue9Bdyda87W5HDfBpZvsi1+NE08L
         1cRDwa0GR+g/sJsk7SNEsBn4DYlvFcMb0uXAlfC4XxnBzgL4vffXMYzfpeYMsyN4QTcj
         dcoOhRQsNlugvLQktQbgzvngQy8WjvUCVoaG6Z7D6mKvdp1cUJhDgGqnA+KT20Ds5rVP
         u4ehrLvPSd3riaW2dXzTi/8rXa0x//bkR712OoeX9osfl25fyNLQDiv4RXaXZRWfRJ17
         V4s+dg7QWFagXf9CDo+MLZbMC6X+ZpKvUYtjFscNO2TAqvCIEt6bOAX5wqeVrpb5mAxl
         EU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698697377; x=1699302177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jfo8/CSFnTnIsaToydsJzXpp4ouXWIX3119SnI96MuM=;
        b=fa+wUg4nVqRWegWtxSkkg3AuU/pwoerCJHKJklSKSTndjX6kVturVo8pAaVxr+AvN+
         lrSwYOKdqsFBZb8/PGboJsX+IWHYAx7HGSfw2f01q6GH8Dfe4Ca4RvXKEcTiuWa8qdh8
         M773ufzOCg0Rd06LoF72D+rSKAfphnT6We1r77CFMmcYwIinXoyUrCp/JgA80KvOyysJ
         ajZzU1kvoPvl0kfkuRgc8Uis9a3lAnFPIiIVIUWjbgjXnPO/ObOxtjzJCi8Rx9VyJLRp
         2uxrapNmkjEuD/dG1HnBKwd0fg2SaREX6zHG6TGctrKwgouHMUIHQrhxV6N2D/r3XhoX
         LlpA==
X-Gm-Message-State: AOJu0Yz4SiW1k2r77kNfy8Gg8f1OS6p71lVZ0SVkklnpzBXAQH9E0q5d
	NiQ3f6xfi+fJkPd/tGirE6XKJBEPu5XeJHhy7xXJLl7xgReHs3aXlslYOQRWKrtSvahQRIDdX3A
	BIKtxJDxFPjBqgMw9LAAjkWmrB2H4kDTVAxvjiLEXZD94TyKMCTuNRsrBIwcj9gw60d1SE6C+Ku
	W2
X-Google-Smtp-Source: AGHT+IE9DWvEXV8Q3xwTrXXRfPRTRuV0vXBB6jnX8sTJW33GSZeBD7Yh5POfPmsc8PS+exCDaVC1dZGT0c8BRHZkSl7b
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:3e1e:2bd9:a4cd:fa38])
 (user=jonathantanmy job=sendgmr) by 2002:a0d:e294:0:b0:5a7:ccf3:3f28 with
 SMTP id l142-20020a0de294000000b005a7ccf33f28mr226149ywe.0.1698697376662;
 Mon, 30 Oct 2023 13:22:56 -0700 (PDT)
Date: Mon, 30 Oct 2023 13:22:47 -0700
In-Reply-To: <cover.1698696798.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com> <cover.1698696798.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <bb01336233b30d46960d6eb15f036e6346a9cd2b.1698696798.git.jonathantanmy@google.com>
Subject: [RFC PATCH 2/3] strbuf_commented_addf(): drop the comment_line_char parameter
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Dragan Simic <dsimic@manjaro.org>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Junio C Hamano <gitster@pobox.com>

All the callers of this function supply the global variable
comment_line_char as an argument to its second parameter.  Remove
the parameter to allow us in the future to change the reference to
the global variable with something else, like a function call.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 add-patch.c          |  8 ++++----
 builtin/branch.c     |  2 +-
 builtin/merge.c      |  8 ++++----
 builtin/tag.c        |  4 ++--
 environment.c        | 18 ++++++++++++++++++
 environment.h        |  7 +++++++
 rebase-interactive.c |  2 +-
 sequencer.c          |  4 ++--
 strbuf.c             | 19 +------------------
 strbuf.h             |  7 -------
 wt-status.c          |  2 +-
 11 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index bfe19876cd..471a0037be 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1106,11 +1106,11 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 	size_t i;
 
 	strbuf_reset(&s->buf);
-	strbuf_commented_addf(&s->buf, comment_line_char,
+	strbuf_commented_addf(&s->buf,
 			      _("Manual hunk edit mode -- see bottom for "
 				"a quick guide.\n"));
 	render_hunk(s, hunk, 0, 0, &s->buf);
-	strbuf_commented_addf(&s->buf, comment_line_char,
+	strbuf_commented_addf(&s->buf,
 			      _("---\n"
 				"To remove '%c' lines, make them ' ' lines "
 				"(context).\n"
@@ -1119,13 +1119,13 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 			      s->mode->is_reverse ? '+' : '-',
 			      s->mode->is_reverse ? '-' : '+',
 			      comment_line_char);
-	strbuf_commented_addf(&s->buf, comment_line_char, "%s",
+	strbuf_commented_addf(&s->buf, "%s",
 			      _(s->mode->edit_hunk_hint));
 	/*
 	 * TRANSLATORS: 'it' refers to the patch mentioned in the previous
 	 * messages.
 	 */
-	strbuf_commented_addf(&s->buf, comment_line_char,
+	strbuf_commented_addf(&s->buf,
 			      _("If it does not apply cleanly, you will be "
 				"given an opportunity to\n"
 				"edit again.  If all lines of the hunk are "
diff --git a/builtin/branch.c b/builtin/branch.c
index 2ec190b14a..b2f171e10b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -668,7 +668,7 @@ static int edit_branch_description(const char *branch_name)
 	exists = !read_branch_desc(&buf, branch_name);
 	if (!buf.len || buf.buf[buf.len-1] != '\n')
 		strbuf_addch(&buf, '\n');
-	strbuf_commented_addf(&buf, comment_line_char,
+	strbuf_commented_addf(&buf,
 		    _("Please edit the description for the branch\n"
 		      "  %s\n"
 		      "Lines starting with '%c' will be stripped.\n"),
diff --git a/builtin/merge.c b/builtin/merge.c
index d748d46e13..8f0e8be7c3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -857,15 +857,15 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		strbuf_addch(&msg, '\n');
 		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
 			wt_status_append_cut_line(&msg);
-			strbuf_commented_addf(&msg, comment_line_char, "\n");
+			strbuf_commented_addf(&msg, "\n");
 		}
-		strbuf_commented_addf(&msg, comment_line_char,
+		strbuf_commented_addf(&msg,
 				      _(merge_editor_comment));
 		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
-			strbuf_commented_addf(&msg, comment_line_char,
+			strbuf_commented_addf(&msg,
 					      _(scissors_editor_comment));
 		else
-			strbuf_commented_addf(&msg, comment_line_char,
+			strbuf_commented_addf(&msg,
 				_(no_scissors_editor_comment), comment_line_char);
 	}
 	if (signoff)
diff --git a/builtin/tag.c b/builtin/tag.c
index 3918eacbb5..a85a0d8def 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -314,10 +314,10 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 			struct strbuf buf = STRBUF_INIT;
 			strbuf_addch(&buf, '\n');
 			if (opt->cleanup_mode == CLEANUP_ALL)
-				strbuf_commented_addf(&buf, comment_line_char,
+				strbuf_commented_addf(&buf,
 				      _(tag_template), tag, comment_line_char);
 			else
-				strbuf_commented_addf(&buf, comment_line_char,
+				strbuf_commented_addf(&buf,
 				      _(tag_template_nocleanup), tag, comment_line_char);
 			write_or_die(fd, buf.buf, buf.len);
 			strbuf_release(&buf);
diff --git a/environment.c b/environment.c
index bb3c2a96a3..d9f64cffa0 100644
--- a/environment.c
+++ b/environment.c
@@ -416,3 +416,21 @@ int print_sha1_ellipsis(void)
 	}
 	return cached_result;
 }
+
+void strbuf_commented_addf(struct strbuf *sb,
+			   const char *fmt, ...)
+{
+	va_list params;
+	struct strbuf buf = STRBUF_INIT;
+	int incomplete_line = sb->len && sb->buf[sb->len - 1] != '\n';
+
+	va_start(params, fmt);
+	strbuf_vaddf(&buf, fmt, params);
+	va_end(params);
+
+	strbuf_add_commented_lines(sb, buf.buf, buf.len, comment_line_char);
+	if (incomplete_line)
+		sb->buf[--sb->len] = '\0';
+
+	strbuf_release(&buf);
+}
diff --git a/environment.h b/environment.h
index e5351c9dd9..5778f5a8e4 100644
--- a/environment.h
+++ b/environment.h
@@ -229,4 +229,11 @@ extern const char *excludes_file;
  */
 int print_sha1_ellipsis(void);
 
+/**
+ * Add a formatted string prepended by a comment character and a
+ * blank to the buffer.
+ */
+__attribute__((format (printf, 2, 3)))
+void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
+
 #endif
diff --git a/rebase-interactive.c b/rebase-interactive.c
index d9718409b3..3f33da7f03 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -71,7 +71,7 @@ void append_todo_help(int command_count,
 
 	if (!edit_todo) {
 		strbuf_addch(buf, '\n');
-		strbuf_commented_addf(buf, comment_line_char,
+		strbuf_commented_addf(buf,
 				      Q_("Rebase %s onto %s (%d command)",
 					 "Rebase %s onto %s (%d commands)",
 					 command_count),
diff --git a/sequencer.c b/sequencer.c
index d584cac8ed..5d348a3f12 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -675,11 +675,11 @@ void append_conflicts_hint(struct index_state *istate,
 	}
 
 	strbuf_addch(msgbuf, '\n');
-	strbuf_commented_addf(msgbuf, comment_line_char, "Conflicts:\n");
+	strbuf_commented_addf(msgbuf, "Conflicts:\n");
 	for (i = 0; i < istate->cache_nr;) {
 		const struct cache_entry *ce = istate->cache[i++];
 		if (ce_stage(ce)) {
-			strbuf_commented_addf(msgbuf, comment_line_char,
+			strbuf_commented_addf(msgbuf,
 					      "\t%s\n", ce->name);
 			while (i < istate->cache_nr &&
 			       !strcmp(ce->name, istate->cache[i]->name))
diff --git a/strbuf.c b/strbuf.c
index 9ee639519a..b1717270a2 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex-ll.h"
 #include "strbuf.h"
@@ -352,24 +353,6 @@ void strbuf_add_commented_lines(struct strbuf *out, const char *buf,
 	strbuf_add_lines(out, prefix1, prefix2, buf, size);
 }
 
-void strbuf_commented_addf(struct strbuf *sb, char comment_line_char,
-			   const char *fmt, ...)
-{
-	va_list params;
-	struct strbuf buf = STRBUF_INIT;
-	int incomplete_line = sb->len && sb->buf[sb->len - 1] != '\n';
-
-	va_start(params, fmt);
-	strbuf_vaddf(&buf, fmt, params);
-	va_end(params);
-
-	strbuf_add_commented_lines(sb, buf.buf, buf.len, comment_line_char);
-	if (incomplete_line)
-		sb->buf[--sb->len] = '\0';
-
-	strbuf_release(&buf);
-}
-
 void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
 {
 	int len;
diff --git a/strbuf.h b/strbuf.h
index 3559e73dd8..4c58dc25e9 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -374,13 +374,6 @@ void strbuf_humanise_rate(struct strbuf *buf, off_t bytes);
 __attribute__((format (printf,2,3)))
 void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
 
-/**
- * Add a formatted string prepended by a comment character and a
- * blank to the buffer.
- */
-__attribute__((format (printf, 3, 4)))
-void strbuf_commented_addf(struct strbuf *sb, char comment_line_char, const char *fmt, ...);
-
 __attribute__((format (printf,2,0)))
 void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
diff --git a/wt-status.c b/wt-status.c
index 9f45bf6949..54b2775730 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1102,7 +1102,7 @@ void wt_status_append_cut_line(struct strbuf *buf)
 {
 	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
 
-	strbuf_commented_addf(buf, comment_line_char, "%s", cut_line);
+	strbuf_commented_addf(buf, "%s", cut_line);
 	strbuf_add_commented_lines(buf, explanation, strlen(explanation), comment_line_char);
 }
 
-- 
2.42.0.820.g83a721a137-goog

