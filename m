Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5B1C688
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXNJIGoH"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032DA1AA
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 13:23:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da307fb7752so1931526276.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698697378; x=1699302178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kWNmdnf/I/GxoJPI/l4WEKJ+qxM4uERZnEBbP4Kk9PA=;
        b=UXNJIGoH5+/eX6khL/NEd58sQsbR4kwoU93Yv66qjuImRaQ1n/YbdLzDKDSSsCMO5i
         FmOhNrLpS90FxOPUvDY0F9Xg+8yh5pM/hcr34Qxev+xChNbJykFaUw0R2h6JPvW60lRU
         XVZ5ulYfX7Gyk9yJwvkXs8LoF9VOvX4HWmS0n0XX0yu7tGjLdh8vU5DwlAQ7gz5cuwPe
         5VBDt+VFbDSLbNRyVqmYHrOlWXgoQZpTj1e4uYNlREeBt3xcTbm3cseX8RGpv3EPM4lB
         ycH6z2cHSIWEiLUfMGJA/csrTloLjmOXEHt76IgTF9RtgVl2qZnUR1liikPoe8QKHtAH
         FnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698697378; x=1699302178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWNmdnf/I/GxoJPI/l4WEKJ+qxM4uERZnEBbP4Kk9PA=;
        b=I2iaQ9PQd4GIxKDJXA2dH+ATSkpQhiwynCpl8ChfWKGPVvmPMX4JWeILCegjAJlw8M
         fGemUFkVn3Mrxlwh4HRUpL8qZ/hNI/2JgAZT6sA+JCXzVbfxWC3/3SBTWbHPsKsCzBE+
         KCNcIMXutUGGEABGf44gCBxzLp8CSUt+vLJYHEijPy7w70hvrenk9QusDoWsexoLR2YI
         63GXVMFYq0A7lZvEROLIVMogdz9f/4guBIt4fO6mpBCkrRsCgPKHf4eJWgZMU3g1+u2r
         o1Xqxm2tRt6rQI2TFgRaHSDHy/yjgI1gUpqmlvhLH7LIUj6dMTazXbdnYT3Fl6kiVq+l
         S4bg==
X-Gm-Message-State: AOJu0Yx0LKxtwJ7yfh27/Zvh/wtkEfzBv/9hdVVrFcumLutBkoa35L7Z
	JxzoP8WQ6lzkr6upP3GkwFdpR4nw/12JeDxTt59PD/X39eAZmVxmoxI27wHSgkHfTFLA6JcylgB
	sJlU3BNRznqYw5AK0opBZFQ0UUXU9Hj7/U9p22HBKm+JLUaDAmnq+3dKVaBxrVFMtVxGKLXDdv9
	mE
X-Google-Smtp-Source: AGHT+IHwV8paL44mqlFY5W+Q2echhDLYUWS7JMuqKhVLj/V7bU9VcOnzmqGtX+NDCUrZx8gZ0yvfsn3rR7YT3QTFGN+l
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:3e1e:2bd9:a4cd:fa38])
 (user=jonathantanmy job=sendgmr) by 2002:a25:e082:0:b0:d9a:ec95:9687 with
 SMTP id x124-20020a25e082000000b00d9aec959687mr218938ybg.11.1698697378543;
 Mon, 30 Oct 2023 13:22:58 -0700 (PDT)
Date: Mon, 30 Oct 2023 13:22:48 -0700
In-Reply-To: <cover.1698696798.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com> <cover.1698696798.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <a1dd551107c804ab1dd4a9c17b1917b3ccec2279.1698696798.git.jonathantanmy@google.com>
Subject: [RFC PATCH 3/3] strbuf_add_commented_lines(): drop the
 comment_line_char parameter
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Dragan Simic <dsimic@manjaro.org>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Junio C Hamano <gitster@pobox.com>

All the callers of this function supply the global variable
comment_line_char as an argument to its last parameter.  Remove the
parameter to allow us in the future to change the reference to the
global variable with something else, like a function call.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/notes.c      |  9 ++++-----
 builtin/stripspace.c |  2 +-
 environment.c        | 15 ++++++++++++++-
 environment.h        |  7 +++++++
 fmt-merge-msg.c      |  9 +++------
 rebase-interactive.c |  6 +++---
 sequencer.c          | 10 ++++------
 strbuf.c             | 13 -------------
 strbuf.h             |  9 ---------
 wt-status.c          |  4 ++--
 10 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 9f38863dd5..355ecce07a 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -181,7 +181,7 @@ static void write_commented_object(int fd, const struct object_id *object)
 
 	if (strbuf_read(&buf, show.out, 0) < 0)
 		die_errno(_("could not read 'show' output"));
-	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_char);
+	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len);
 	write_or_die(fd, cbuf.buf, cbuf.len);
 
 	strbuf_release(&cbuf);
@@ -209,10 +209,9 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 			copy_obj_to_fd(fd, old_note);
 
 		strbuf_addch(&buf, '\n');
-		strbuf_add_commented_lines(&buf, "\n", strlen("\n"), comment_line_char);
-		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)),
-					   comment_line_char);
-		strbuf_add_commented_lines(&buf, "\n", strlen("\n"), comment_line_char);
+		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
+		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)));
+		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
 		write_or_die(fd, buf.buf, buf.len);
 
 		write_commented_object(fd, object);
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 7b700a9fb1..11e475760c 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -13,7 +13,7 @@ static void comment_lines(struct strbuf *buf)
 	size_t len;
 
 	msg = strbuf_detach(buf, &len);
-	strbuf_add_commented_lines(buf, msg, len, comment_line_char);
+	strbuf_add_commented_lines(buf, msg, len);
 	free(msg);
 }
 
diff --git a/environment.c b/environment.c
index d9f64cffa0..cc1b85afb6 100644
--- a/environment.c
+++ b/environment.c
@@ -428,9 +428,22 @@ void strbuf_commented_addf(struct strbuf *sb,
 	strbuf_vaddf(&buf, fmt, params);
 	va_end(params);
 
-	strbuf_add_commented_lines(sb, buf.buf, buf.len, comment_line_char);
+	strbuf_add_commented_lines(sb, buf.buf, buf.len);
 	if (incomplete_line)
 		sb->buf[--sb->len] = '\0';
 
 	strbuf_release(&buf);
 }
+
+void strbuf_add_commented_lines(struct strbuf *out,
+				const char *buf, size_t size)
+{
+	static char prefix1[3];
+	static char prefix2[2];
+
+	if (prefix1[0] != comment_line_char) {
+		xsnprintf(prefix1, sizeof(prefix1), "%c ", comment_line_char);
+		xsnprintf(prefix2, sizeof(prefix2), "%c", comment_line_char);
+	}
+	strbuf_add_lines(out, prefix1, prefix2, buf, size);
+}
diff --git a/environment.h b/environment.h
index 5778f5a8e4..f801dbe36e 100644
--- a/environment.h
+++ b/environment.h
@@ -236,4 +236,11 @@ int print_sha1_ellipsis(void);
 __attribute__((format (printf, 2, 3)))
 void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
 
+/**
+ * Add a NUL-terminated string to the buffer. Each line will be prepended
+ * by a comment character and a blank.
+ */
+void strbuf_add_commented_lines(struct strbuf *out,
+				const char *buf, size_t size);
+
 #endif
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 66e47449a0..adc85d2a72 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -509,8 +509,7 @@ static void fmt_tag_signature(struct strbuf *tagbuf,
 	strbuf_complete_line(tagbuf);
 	if (sig->len) {
 		strbuf_addch(tagbuf, '\n');
-		strbuf_add_commented_lines(tagbuf, sig->buf, sig->len,
-					   comment_line_char);
+		strbuf_add_commented_lines(tagbuf, sig->buf, sig->len);
 	}
 }
 
@@ -556,8 +555,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 				strbuf_addch(&tagline, '\n');
 				strbuf_add_commented_lines(&tagline,
 						origins.items[first_tag].string,
-						strlen(origins.items[first_tag].string),
-						comment_line_char);
+						strlen(origins.items[first_tag].string));
 				strbuf_insert(&tagbuf, 0, tagline.buf,
 					      tagline.len);
 				strbuf_release(&tagline);
@@ -565,8 +563,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 			strbuf_addch(&tagbuf, '\n');
 			strbuf_add_commented_lines(&tagbuf,
 					origins.items[i].string,
-					strlen(origins.items[i].string),
-					comment_line_char);
+					strlen(origins.items[i].string));
 			fmt_tag_signature(&tagbuf, &sig, buf, len);
 		}
 		strbuf_release(&payload);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 3f33da7f03..1138bd37ba 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -78,7 +78,7 @@ void append_todo_help(int command_count,
 				      shortrevisions, shortonto, command_count);
 	}
 
-	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
+	strbuf_add_commented_lines(buf, msg, strlen(msg));
 
 	if (get_missing_commit_check_level() == MISSING_COMMIT_CHECK_ERROR)
 		msg = _("\nDo not remove any line. Use 'drop' "
@@ -87,7 +87,7 @@ void append_todo_help(int command_count,
 		msg = _("\nIf you remove a line here "
 			 "THAT COMMIT WILL BE LOST.\n");
 
-	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
+	strbuf_add_commented_lines(buf, msg, strlen(msg));
 
 	if (edit_todo)
 		msg = _("\nYou are editing the todo file "
@@ -98,7 +98,7 @@ void append_todo_help(int command_count,
 		msg = _("\nHowever, if you remove everything, "
 			"the rebase will be aborted.\n\n");
 
-	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
+	strbuf_add_commented_lines(buf, msg, strlen(msg));
 }
 
 int edit_todo_list(struct repository *r, struct todo_list *todo_list,
diff --git a/sequencer.c b/sequencer.c
index 5d348a3f12..29c8b5e32b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1859,7 +1859,7 @@ static void add_commented_lines(struct strbuf *buf, const void *str, size_t len)
 		s += count;
 		len -= count;
 	}
-	strbuf_add_commented_lines(buf, s, len, comment_line_char);
+	strbuf_add_commented_lines(buf, s, len);
 }
 
 /* Does the current fixup chain contain a squash command? */
@@ -1958,7 +1958,7 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 	strbuf_addf(buf, _(nth_commit_msg_fmt),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
-	strbuf_add_commented_lines(buf, body, commented_len, comment_line_char);
+	strbuf_add_commented_lines(buf, body, commented_len);
 	/* buf->buf may be reallocated so store an offset into the buffer */
 	fixup_off = buf->len;
 	strbuf_addstr(buf, body + commented_len);
@@ -2048,8 +2048,7 @@ static int update_squash_messages(struct repository *r,
 			      _(first_commit_msg_str));
 		strbuf_addstr(&buf, "\n\n");
 		if (is_fixup_flag(command, flag))
-			strbuf_add_commented_lines(&buf, body, strlen(body),
-						   comment_line_char);
+			strbuf_add_commented_lines(&buf, body, strlen(body));
 		else
 			strbuf_addstr(&buf, body);
 
@@ -2068,8 +2067,7 @@ static int update_squash_messages(struct repository *r,
 		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
 			    ++opts->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
-		strbuf_add_commented_lines(&buf, body, strlen(body),
-					   comment_line_char);
+		strbuf_add_commented_lines(&buf, body, strlen(body));
 	} else
 		return error(_("unknown command: %d"), command);
 	repo_unuse_commit_buffer(r, commit, message);
diff --git a/strbuf.c b/strbuf.c
index b1717270a2..43027eab76 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -340,19 +340,6 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 	va_end(ap);
 }
 
-void strbuf_add_commented_lines(struct strbuf *out, const char *buf,
-				size_t size, char comment_line_char)
-{
-	static char prefix1[3];
-	static char prefix2[2];
-
-	if (prefix1[0] != comment_line_char) {
-		xsnprintf(prefix1, sizeof(prefix1), "%c ", comment_line_char);
-		xsnprintf(prefix2, sizeof(prefix2), "%c", comment_line_char);
-	}
-	strbuf_add_lines(out, prefix1, prefix2, buf, size);
-}
-
 void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
 {
 	int len;
diff --git a/strbuf.h b/strbuf.h
index 4c58dc25e9..ffa2fe3055 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -282,15 +282,6 @@ void strbuf_remove(struct strbuf *sb, size_t pos, size_t len);
 void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
 		   const void *data, size_t data_len);
 
-/**
- * Add a NUL-terminated string to the buffer. Each line will be prepended
- * by a comment character and a blank.
- */
-void strbuf_add_commented_lines(struct strbuf *out,
-				const char *buf, size_t size,
-				char comment_line_char);
-
-
 /**
  * Add data of given length to the buffer.
  */
diff --git a/wt-status.c b/wt-status.c
index 54b2775730..b390c77334 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1027,7 +1027,7 @@ static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncom
 	if (s->display_comment_prefix) {
 		size_t len;
 		summary_content = strbuf_detach(&summary, &len);
-		strbuf_add_commented_lines(&summary, summary_content, len, comment_line_char);
+		strbuf_add_commented_lines(&summary, summary_content, len);
 		free(summary_content);
 	}
 
@@ -1103,7 +1103,7 @@ void wt_status_append_cut_line(struct strbuf *buf)
 	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
 
 	strbuf_commented_addf(buf, "%s", cut_line);
-	strbuf_add_commented_lines(buf, explanation, strlen(explanation), comment_line_char);
+	strbuf_add_commented_lines(buf, explanation, strlen(explanation));
 }
 
 void wt_status_add_cut_line(FILE *fp)
-- 
2.42.0.820.g83a721a137-goog

