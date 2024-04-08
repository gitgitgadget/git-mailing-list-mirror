Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920D86126
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585795; cv=none; b=uxnFBZaZRIhEHTdKwKm8mJtp3QgTnSA/MFmN89nHytRnPVYcpbbT/A6Fekculvx425/iEz7eV7mu/kHhjM/6Q2abd2iHM3FF1Dr1/wXV2xckJVTpqhV3LH28r+j8XN8RLNFu2Pp1mf0932BGrN/Wgw54GQlCBdvObvAxYTS0ls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585795; c=relaxed/simple;
	bh=Yj3Hwq4MUaSGj3jjmzs0k7eplATRWgpGSTCiGEUjqXA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MtBJ8ytJoRbSckRus5EoMwF1yvaHNxe7qrCozOooQTaKdtIOQN2Mmo+5dBZkBP9GFDZLp3JMUcS8dz/QEf3gFdl3JgzDvAIPCVtA9mU61eOGhj8MJCJAbfA3EdMmdoLM/H5tydL8mN/GzyoCf5vqnQtvpOp5CipgyV+akvoqELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZF4H8Oi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZF4H8Oi"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-416920b1a2aso2186545e9.2
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712585790; x=1713190590; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCNHmarOGlTwRMu62nNEljkWhp9ziWnKwqa8SqeQ6pE=;
        b=mZF4H8Oi6va/v47Qj7oJ7Z+mx/7i2yLQDapG9XiQbej9rHHFd/EY4A6g2hn2dfDCjz
         XfzJpgfa8Pp8DPYIJyTiAZ85XmBvK7L02NMGvmFvroaf+lPAhSh+QNV6kagzisM4hV1g
         VjPNGa+p5k016LIZI/6eA5eL07hZ9vsxnsJsLgvfGUWTM+sMNwQFRmpaqBj+g/0Rp6cP
         ZlboRaUq2YH2R2KqFzQo7kMgS/rViGB01lXmd9jSQzFIEF5r8BoKqHqYjRw07VV+yfTp
         Evydtolq5yizoQ+GSJ8gUAMsyFGOm91mjoA9YwC+r0HK6rfsCXCqAiZ7HsF+u4ouKf3G
         +nMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712585790; x=1713190590;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCNHmarOGlTwRMu62nNEljkWhp9ziWnKwqa8SqeQ6pE=;
        b=dISR1ZhCibS2atYE/RI8udIQiSItQMTTAzJquSne4pGgrqxpMs7hhP7q3qe8I8uegd
         VFodwTHqFyaJ4aVBs/ns+4wP2uyzEt4C3y3mLBjuGf9F+GNSy6VCnARAGOdtZpgM76yF
         u+UX5ZHWZ2spNQ42QaHi8ueQj7K6AujaW+7PlU4Rl3Sq0DHGButlLZv93n+PKdUVGLIP
         sE7KUtz8Gv4Sq9W9XpWV4CBLBKtzX9h+x+6TtDpw6EVjUofn95hbSs5r52oIcNUbpDtv
         1OxyR8eQp835ZHdruTAi2MtEiVSaw8EQSOpRDyEt2ccPOw0h6xY6RuSjgscF1uz4l9zt
         sXWQ==
X-Gm-Message-State: AOJu0YxwNGEFWysqzjdpD38JUrB93FnBMCRFlb6Jhz8NV93Uz4GW4kFi
	PloZy/h02H6gaHx03ZU6V/ryNlcOZ7THchG3MoqCdQkw9kfPeieq85+Pjr9r
X-Google-Smtp-Source: AGHT+IHPNYumB9bTzbGnmjyn0dANVcdPYFYGI7AEZsj5aPpNHzyU3wkSMTzhUYvaha5Ypkh9oixQmQ==
X-Received: by 2002:a05:600c:1d14:b0:416:67a1:6989 with SMTP id l20-20020a05600c1d1400b0041667a16989mr2335431wms.41.1712585790522;
        Mon, 08 Apr 2024 07:16:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c314e00b0041698e78fe0sm81854wmo.37.2024.04.08.07.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:16:30 -0700 (PDT)
Message-Id: <1bcf92c6105e6e7ac2b2981575e112072fec383e.1712585787.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
	<pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Apr 2024 14:16:26 +0000
Subject: [PATCH v2 1/2] rebase -i: pass struct replay_opts to
 parse_insn_line()
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
Cc: Stefan Haller <lists@haller-berlin.de>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This new parameter will be used in the next commit. As adding the
parameter requires quite a few changes to plumb it through the call
chain these are separated into their own commit to avoid cluttering up
the next commit with incidental changes.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c     | 17 +++++++++++------
 rebase-interactive.c | 21 +++++++++++++--------
 rebase-interactive.h |  9 ++++++---
 sequencer.c          | 22 ++++++++++++----------
 sequencer.h          |  4 ++--
 5 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 891f28468e8..a33a2ed413a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -194,7 +194,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	return replay;
 }
 
-static int edit_todo_file(unsigned flags)
+static int edit_todo_file(unsigned flags, struct replay_opts *opts)
 {
 	const char *todo_file = rebase_path_todo();
 	struct todo_list todo_list = TODO_LIST_INIT,
@@ -205,7 +205,8 @@ static int edit_todo_file(unsigned flags)
 		return error_errno(_("could not read '%s'."), todo_file);
 
 	strbuf_stripspace(&todo_list.buf, comment_line_str);
-	res = edit_todo_list(the_repository, &todo_list, &new_todo, NULL, NULL, flags);
+	res = edit_todo_list(the_repository, opts, &todo_list, &new_todo,
+			     NULL, NULL, flags);
 	if (!res && todo_list_write_to_file(the_repository, &new_todo, todo_file,
 					    NULL, NULL, -1, flags & ~(TODO_LIST_SHORTEN_IDS)))
 		res = error_errno(_("could not write '%s'"), todo_file);
@@ -296,8 +297,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 		error(_("could not generate todo list"));
 	else {
 		discard_index(&the_index);
-		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
-						&todo_list))
+		if (todo_list_parse_insn_buffer(the_repository, &replay,
+						todo_list.buf.buf, &todo_list))
 			BUG("unusable todo list");
 
 		ret = complete_action(the_repository, &replay, flags,
@@ -352,9 +353,13 @@ static int run_sequencer_rebase(struct rebase_options *opts)
 		replay_opts_release(&replay_opts);
 		break;
 	}
-	case ACTION_EDIT_TODO:
-		ret = edit_todo_file(flags);
+	case ACTION_EDIT_TODO: {
+		struct replay_opts replay_opts = get_replay_opts(opts);
+
+		ret = edit_todo_file(flags, &replay_opts);
+		replay_opts_release(&replay_opts);
 		break;
+	}
 	case ACTION_SHOW_CURRENT_PATCH: {
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
diff --git a/rebase-interactive.c b/rebase-interactive.c
index c343e16fcdd..56fd7206a95 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -101,9 +101,10 @@ void append_todo_help(int command_count,
 	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_str);
 }
 
-int edit_todo_list(struct repository *r, struct todo_list *todo_list,
-		   struct todo_list *new_todo, const char *shortrevisions,
-		   const char *shortonto, unsigned flags)
+int edit_todo_list(struct repository *r, struct replay_opts *opts,
+		   struct todo_list *todo_list, struct todo_list *new_todo,
+		   const char *shortrevisions, const char *shortonto,
+		   unsigned flags)
 {
 	const char *todo_file = rebase_path_todo(),
 		*todo_backup = rebase_path_todo_backup();
@@ -114,7 +115,9 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 	 * it.  If there is an error, we do not return, because the user
 	 * might want to fix it in the first place. */
 	if (!initial)
-		incorrect = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list) |
+		incorrect = todo_list_parse_insn_buffer(r, opts,
+							todo_list->buf.buf,
+							todo_list) |
 			file_exists(rebase_path_dropped());
 
 	if (todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, shortonto,
@@ -134,13 +137,13 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 	if (initial && new_todo->buf.len == 0)
 		return -3;
 
-	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo)) {
+	if (todo_list_parse_insn_buffer(r, opts, new_todo->buf.buf, new_todo)) {
 		fprintf(stderr, _(edit_todo_list_advice));
 		return -4;
 	}
 
 	if (incorrect) {
-		if (todo_list_check_against_backup(r, new_todo)) {
+		if (todo_list_check_against_backup(r, opts, new_todo)) {
 			write_file(rebase_path_dropped(), "%s", "");
 			return -4;
 		}
@@ -228,13 +231,15 @@ int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo)
 	return res;
 }
 
-int todo_list_check_against_backup(struct repository *r, struct todo_list *todo_list)
+int todo_list_check_against_backup(struct repository *r,
+				   struct replay_opts *opts,
+				   struct todo_list *todo_list)
 {
 	struct todo_list backup = TODO_LIST_INIT;
 	int res = 0;
 
 	if (strbuf_read_file(&backup.buf, rebase_path_todo_backup(), 0) > 0) {
-		todo_list_parse_insn_buffer(r, backup.buf.buf, &backup);
+		todo_list_parse_insn_buffer(r, opts, backup.buf.buf, &backup);
 		res = todo_list_check(&backup, todo_list);
 	}
 
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 7239c60f791..8e5b181b334 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -3,17 +3,20 @@
 
 struct strbuf;
 struct repository;
+struct replay_opts;
 struct todo_list;
 
 void append_todo_help(int command_count,
 		      const char *shortrevisions, const char *shortonto,
 		      struct strbuf *buf);
-int edit_todo_list(struct repository *r, struct todo_list *todo_list,
-		   struct todo_list *new_todo, const char *shortrevisions,
-		   const char *shortonto, unsigned flags);
+int edit_todo_list(struct repository *r, struct replay_opts *opts,
+		   struct todo_list *todo_list, struct todo_list *new_todo,
+		   const char *shortrevisions, const char *shortonto,
+		   unsigned flags);
 
 int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
 int todo_list_check_against_backup(struct repository *r,
+				   struct replay_opts *opts,
 				   struct todo_list *todo_list);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index 2c19846385b..a3154ba3347 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2573,8 +2573,9 @@ static int check_label_or_ref_arg(enum todo_command command, const char *arg)
 	return 0;
 }
 
-static int parse_insn_line(struct repository *r, struct todo_item *item,
-			   const char *buf, const char *bol, char *eol)
+static int parse_insn_line(struct repository *r, struct replay_opts *opts UNUSED,
+			   struct todo_item *item, const char *buf,
+			   const char *bol, char *eol)
 {
 	struct object_id commit_oid;
 	char *end_of_object_name;
@@ -2708,8 +2709,8 @@ int sequencer_get_last_command(struct repository *r UNUSED, enum replay_action *
 	return ret;
 }
 
-int todo_list_parse_insn_buffer(struct repository *r, char *buf,
-				struct todo_list *todo_list)
+int todo_list_parse_insn_buffer(struct repository *r, struct replay_opts *opts,
+				char *buf, struct todo_list *todo_list)
 {
 	struct todo_item *item;
 	char *p = buf, *next_p;
@@ -2727,7 +2728,7 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 
 		item = append_new_todo(todo_list);
 		item->offset_in_buf = p - todo_list->buf.buf;
-		if (parse_insn_line(r, item, buf, p, eol)) {
+		if (parse_insn_line(r, opts, item, buf, p, eol)) {
 			res = error(_("invalid line %d: %.*s"),
 				i, (int)(eol - p), p);
 			item->command = TODO_COMMENT + 1;
@@ -2875,7 +2876,7 @@ static int read_populate_todo(struct repository *r,
 	if (strbuf_read_file_or_whine(&todo_list->buf, todo_file) < 0)
 		return -1;
 
-	res = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
+	res = todo_list_parse_insn_buffer(r, opts, todo_list->buf.buf, todo_list);
 	if (res) {
 		if (is_rebase_i(opts))
 			return error(_("please fix this using "
@@ -2905,7 +2906,7 @@ static int read_populate_todo(struct repository *r,
 		struct todo_list done = TODO_LIST_INIT;
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
-		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done))
+		    !todo_list_parse_insn_buffer(r, opts, done.buf.buf, &done))
 			todo_list->done_nr = count_commands(&done);
 		else
 			todo_list->done_nr = 0;
@@ -5251,7 +5252,8 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 			goto release_todo_list;
 
 		if (file_exists(rebase_path_dropped())) {
-			if ((res = todo_list_check_against_backup(r, &todo_list)))
+			if ((res = todo_list_check_against_backup(r, opts,
+								  &todo_list)))
 				goto release_todo_list;
 
 			unlink(rebase_path_dropped());
@@ -6294,7 +6296,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return error(_("nothing to do"));
 	}
 
-	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
+	res = edit_todo_list(r, opts, todo_list, &new_todo, shortrevisions,
 			     shortonto, flags);
 	if (res == -1)
 		return -1;
@@ -6322,7 +6324,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	strbuf_release(&buf2);
 	/* Nothing is done yet, and we're reparsing, so let's reset the count */
 	new_todo.total_nr = 0;
-	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
+	if (todo_list_parse_insn_buffer(r, opts, new_todo.buf.buf, &new_todo) < 0)
 		BUG("invalid todo list after expanding IDs:\n%s",
 		    new_todo.buf.buf);
 
diff --git a/sequencer.h b/sequencer.h
index 437eabd38af..33943e5ed28 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -137,8 +137,8 @@ struct todo_list {
 	.buf = STRBUF_INIT, \
 }
 
-int todo_list_parse_insn_buffer(struct repository *r, char *buf,
-				struct todo_list *todo_list);
+int todo_list_parse_insn_buffer(struct repository *r, struct replay_opts *opts,
+				char *buf, struct todo_list *todo_list);
 int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
 			    const char *file, const char *shortrevisions,
 			    const char *shortonto, int num, unsigned flags);
-- 
gitgitgadget

