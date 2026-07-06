Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79983F6C3B
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327876; cv=none; b=teUv6fmgnYlkwV10K23h74qK0AsilaB/8DgMEOhpP/St5dqdB7Aty9VH29Yyw7xcq04QJQuKfZskRzoxelYefF6W5oA/EZ6WDR/fC83ZEA4Xemd30vZ/NRROfbOlHekht4Z6VLuxlD5RxusrJQfop//bJsGUwaz0ISzPdj+T0S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327876; c=relaxed/simple;
	bh=Fn9vIqWqRCFlcj0GUFAqXHAtw+PdEcB5ivXIUIJsv9s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hc2A6WfGPuOOt/fWeRiSE6Df0wLmwrZT6d0LKkJvHsT1av1sgRXQADFEgmhmCppz4sJDIeoNII56MfVLjetfWImykoqpcUF0rnW7Wv/1BiIzKIsncgeha9jBNDdIQNqQPdYQrMiv8jcDPJRYm6rYNCz13bKYnggnSFhm4byfUk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sNw8cRQn; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNw8cRQn"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c2a449c57so17928041cf.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 01:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783327863; x=1783932663; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mU3SaapAyZbkMy7psEZJuclYzSENvywJ28qjpQwKiG8=;
        b=sNw8cRQnRM/Dps1/gSxVIlZLjJoXvKWB/0JCdnJR26XgTsfMw6nObNqtyX+KsgCEv9
         yACE7EpNL+M8SJNEHLVS1llwnlz2O+CxlPfJuo1OCQBx5we8C5Fj6LMmw/5z0hNgZ0yy
         pUSYOMiFm/C4nBTC7DXhn8wH/hi2m0MRSlQxKSLXic/9z+/kK4E9nX54oUpOmAGdTFqZ
         +mSqemlgrjwzw27VGTmRB3imUeDONiHW7Jkka5FrWlwovLxAyTYQ7Jq2pXpMRCISF5LA
         EWFvggIN5YtANNnnsLRXok9M//toJzrTMv4yYME2jji86gu8bVHLrdOAbTUUz4xw4GZE
         S3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783327863; x=1783932663;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mU3SaapAyZbkMy7psEZJuclYzSENvywJ28qjpQwKiG8=;
        b=WeLWkS3ia9S/YPQ1JeRoSJuVpdDJ7em6pMeFGui7XO4LAz+5E0Jnx4XKpTPeGhrk84
         /8aqBkXyalQbqdiPjlShfAYEITIuIcYjKFy9Au5tSRmemkPqxV/ibd1RCVkb5D+w7HVE
         DaZFtX4JYAyOcNTrlya+yDGGryVMUmNKfKGRuk7/qhqZ1/LntsKOunDDmEJIyP9FLGWd
         0TnMmCBLFnJR/O3XABPxu6DGNhUPjIXDqwPV1ppElaQZ8iCTAatYkOa34n2N0b1Q3rxM
         yce5RNrag/NlBBMUzBobVrnBxkvfFKAaeUmNdqOBRp1lBG/3QR0SkIuYw8VYiT7zhvbO
         wC4g==
X-Gm-Message-State: AOJu0YzW6pU4sZSR0nc4IZWc/fW8esiKXgUrTlzRtuwnBF1EapUX/u5v
	hZIL1AGxpwCYu+BUvgNzXCyl5miZsELIYURg1MOwlds0d0000djkHBpKsGeAOCpY
X-Gm-Gg: AfdE7cnyHz2tFSkDDBiitIb/8041oAtcGXhkLjbb6cSXi4xt4RvbpF0pJlLQzP80Q33
	OhnCSOy/zswFQOUzJLbWtIJTm5naULbt8KoCzP9H1JzPAP9l4uR8cBs1mPlY+1I8y4vXo1aWddu
	GtucZ8rEU0QVvwa6Tr3cEkgLOeAzD1OIFWdwoE0b8SDMq6ZE8dexah1J7u5p9h4+ghoZa9Dlpjf
	ZXdbNgmRl1imX31uObAvWv0E3I87UUDGgsxQYyp7klU5nZ9tISKxG6aQ/neZUgVxMHCTTDsRk9y
	drL5OOPZDiTl651ksIlV3URlocjDNLEFcGf0sVssOLLpBtqAaWcwN5caEghq87WEmg/rtpISJIz
	FI7shHCRlLkJ1j8LoS0E7LSc/cOSNoYpr72xXWZBl2jI7KWk282sZg9EFh0hoD5t+32li02qTDp
	uJ95ilBPLJyfwgfvSlsN6jSNELFQ==
X-Received: by 2002:a05:622a:250a:b0:51c:1cbd:5fdc with SMTP id d75a77b69052e-51c4c1d8d58mr135652521cf.10.1783327861641;
        Mon, 06 Jul 2026 01:51:01 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.174.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41abe73csm91574671cf.5.2026.07.06.01.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:50:59 -0700 (PDT)
Message-Id: <001356db93594bca92747ab8f443373f1e9025ed.1783327849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
References: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
	<pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 08:50:48 +0000
Subject: [PATCH v7 4/5] sequencer: extract helpers for the squash message
 markers
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
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
update_squash_messages() and append_squash_message(). A later change
reuses them to give "git history squash --reedit-message" the same
template.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 sequencer.c | 64 ++++++++++++++++++++++++++++++++---------------------
 sequencer.h | 23 +++++++++++++++++++
 2 files changed, 62 insertions(+), 25 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 57855b0066..f4893e8f40 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1892,6 +1892,32 @@ static const char skip_first_commit_msg_str[] = N_("The 1st commit message will
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
@@ -2005,20 +2031,13 @@ static int append_squash_message(struct strbuf *buf, const char *body,
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
@@ -2083,9 +2102,8 @@ static int update_squash_messages(struct repository *r,
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
@@ -2109,12 +2127,9 @@ static int update_squash_messages(struct repository *r,
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
@@ -2133,9 +2148,8 @@ static int update_squash_messages(struct repository *r,
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
index 3164bd437d..feed0e9de3 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -208,6 +208,29 @@ int todo_list_rearrange_squash(struct todo_list *todo_list);
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

