Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56597480950
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128583; cv=none; b=uTkc5ft0tYEGrKD+tyQUx1ymH0WY7gLSkwRMYswWmoJ5rJWBh6Sd9da09MnEWOJVlOfdiT8CUm8xtiQkaHyIs+4JdgMjG2gQWwIRAUUyGbG46d/tSvA3f99BGrAjDS6sj0hAkcJej+MLckaTMAlRaZMAut9mh+tKajE+5NBCCvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128583; c=relaxed/simple;
	bh=ozRlD4AWtxjb868HFVaODNABLpRITpdtz2Q7JV1D0dM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sGx6o3qmh4VxvFt/Q8xpRfLaeKY82NdTEVG8QFry8eBhCd9PxumZdme/Y/Ty75QrDlgzXf2RwwrhYjAiI0Uzf16FaQ9qrBbYR2hahI6fvurwICZah4KOfF5murL5LTeMSdY2STRG3BBcCS6inH6QkzYilRaUVP8yrpeJkYF+OPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoYuRQxl; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoYuRQxl"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c2808dbc3so33772481cf.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128581; x=1784733381; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vSnfNB9yGGhjfO8aXn+qRSBRKqGTSMIajenTqsGu1II=;
        b=ZoYuRQxlhMqUog4/N5QGq4xSzQANep8Nb2We2PqXwZ2uknaBkI+pyQAcwWJAF3oh6V
         pNepisnz1xlvhhlnkxmpsHiYMSd9zf6UMLuddktl78p6DF4mj7tVhGjH5/PlAgctwjFZ
         1SkFrjTDX7S7Iq2vfQ/KcCY4OO8gPjVfTtQIa5Ld0MFC1rkh8Ht1PkM5cxe16sPnifTI
         EY4ACpG3mqxnJntfLrHU/jRpctE+0ghOuHYnqyg9sLUyuuFMPrWTqNbDOGLapu7jiiQD
         zTTNWg5NnuV/x5C0XD5qgY9opXjuu5i8XRdswBqnQfMssdBFa3ZNc0/dDmR2NDk+SJ1A
         mWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128581; x=1784733381;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vSnfNB9yGGhjfO8aXn+qRSBRKqGTSMIajenTqsGu1II=;
        b=jDdomLhGAjx1XdxUiDYbGBQ/H0Mhc432NS+8Xg1A4ln8eth+daiZ0nCO0FC9BUQneV
         3Cxz5Fwq3wyIBOYMidFh52Ab+lu9Ec2/0G72PbAkz7nWkeypsmbe72nuiTmPT8U5p1Rq
         6R91Wjk2B649tWAPrDVReeL9gmlW6XaVXRQpsWxsuiI9Wh3xlr6BQE3EooSl1yjBRW5D
         HAzuyKdAUTisnQ/zfopH8HI4DabFJVZMcbN/XQeyJwPyhUKs6KENdLtU8TiEkTsUGLqC
         Ic+pbHG7Ke0w3UqfBfHMBGIMDr7fl/ihWybXogngd/atpOuvx0QnjWCIPEPUti3i9vlD
         sk0w==
X-Gm-Message-State: AOJu0YySJL4Ha6MtFQUJsniKjFzKCy8aUmxSQvthdpp6yz2LkkHfFT56
	MfFjtabuZay7Lk9ZNlfDhpk0M7gMBZXWoxT5rB2WlM07Zypnp8LMG+aUBoNI/n8n
X-Gm-Gg: AfdE7cm19qZQN4ojozLzYJhDLHGa7TTXeJL2hqnFJBr/ciyERPOdIQP1HJ5YVTmJnmv
	olfGJ6ImR8rXL1lGTf6LKVmbgEjmAhs75Wiuh21HLpEBGoaaRTD6E81ejGqMG1EE4EOi8Rl0tW6
	9brK2M23IKqSpxUMKLvlpWH8t0/QQXy9/1sZnzfz7V4FGb3+IUvTpfkWRkxh6sv03vKKfpGH+4s
	Un9at6NR2Dz0+mu/kYOr9NvBKRhNE30cUExhvUv6X4Iw7WRWj4+2KZwbq90D2Sc5MxOC8t8dP0G
	0sdhINwrEMWApfDKxu2AV9/eZR/yEfx01r5rt8LHm2m3wJ7ecbOX8RAkmvz1F7IsFsMoOeGbsog
	N/N7Wi5mM4ZfPbNjAy/GT8gVlTnCRvICXlX9uaW5r3FfsFWeVBYuwzqbmnja417wDh8f51XEWcM
	PVUmas5FEpyjsWH+U0/nv4TKIYSw==
X-Received: by 2002:a05:622a:1b8b:b0:517:8e65:68ea with SMTP id d75a77b69052e-51e424540a8mr66229101cf.54.1784128580468;
        Wed, 15 Jul 2026 08:16:20 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.175.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf671e2sm134810431cf.25.2026.07.15.08.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:16:19 -0700 (PDT)
Message-Id: <08915cee51f49b6fff6608e718febbe48d3bc3d4.1784128573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com>
References: <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
	<pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 15:16:12 +0000
Subject: [PATCH v9 4/5] sequencer: share the squash message marker helpers and
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

