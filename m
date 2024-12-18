Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9CB849C
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 00:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734481903; cv=none; b=H4xa6dp2p1NypsK8yqAkQqDpC7/iLoqb1ykSZzeLCPPMQdwY7whZeG0R/7LxTmn6A9tc4N0D2fpqH3MeoEVaALj39avGdwVQ02grFVr9pplGK/Glb3IkXCNFLmkYlkkKXv7+iUbUc1v4eUtE1sFu9OJLK91HksXXcX/5hEyxZNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734481903; c=relaxed/simple;
	bh=8O/97HJTe8/b1PimIXVW2Tr6UezdCaTJ0vpDumH8gJk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RsXdhRTpDJs0tRhz5nrrWNjsj3yuKfW1RqdhQhhLVhsSIQT0gygG1om003UAW0Xju2SpdGK4DxUdfkZKtMDYJZ3/KuCkw1ugrc/vnTJhii/nlVyfHFAtjOxa+rzG/JSOg5b1w8TXLxLKXJm6jznPyc1kkpFTBTO3B86zJcpzozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W74DXQRF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W74DXQRF"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43634b570c1so30046195e9.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 16:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734481900; x=1735086700; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5udHOzCAmmT2sCGLLkeOJ020EmJvphwSslgVwXpBvcg=;
        b=W74DXQRFshwCNQI1Cftclh9K6V99VcdoPSulLkV0PpHGNxJ1T4ZsiRD3XkXzEB3oO0
         3qDTCNadsxosoMrYrvxoKfAxMK4E5JTuNJ7FffszG4vFPrp1l0v6kNsH9F6X0gO3gLnV
         Hgrd5bxi75IjS5J0qPoDdKnbhxLo1s6Tfz5OxwZX1ChLRtgZvuwcZDqwTyTligT9wc36
         +Meo4+LbNn4UXhwynzkSMmMkYdMutmMf5gsQyM3ackGYl9OXo0FFVKqrAlMjTk0wuivd
         2ox0O81EUCvl8snqveYoXNEi9r8VJqcnfWXrYQdbE3eNw7LLN22zB7oFnWnCZoAfBGbL
         /ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734481900; x=1735086700;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5udHOzCAmmT2sCGLLkeOJ020EmJvphwSslgVwXpBvcg=;
        b=h764LbgRyVG47MaAzwUzBq5fbzD/lrzeqXDJ2PWxJR9PQ1x1B7Pm8Xd9CtX/a0119W
         y5x5kYgQyy9r7+oCpMuT1qTT7PfRBmtkyj0Fs1KzrInjjSG4WBngN1kziSXPnbQxfvQN
         LQQk3hH+SJlfICnSfA3CLnVyCSrebMmOCHeaXUjlYOFryCkUT5MQIvYczfjQWml2kM+p
         L74jZVVw84929hNJ13MlmEBnTYk4H278NacSQxrLXgHH3NSB9SBFMyRijJzphJ0wooAo
         z9KPzWLhNZ83ocp2HtuqmTNrpm34BZHQ7tYGp+U7RTmvw3QMNuDRoi+pcpYTH6ZgG2VH
         G1Kw==
X-Gm-Message-State: AOJu0YxoFJ32Oj9n61ncwDWV6eBfcX+vhuUj0G1/lNh8eU3tdgwrWSxc
	4YFlu2Bqc6uifgCAp6P9+P2iDthF6HcQlFVCjoJZdrOXDd50Cr+pw2T8pg==
X-Gm-Gg: ASbGncuOoYdKrfG3Oivzbk0bS8slWQi0W7BqNtlQ8vggIoepsGOJobhIrPHWABQmraL
	DERgXgVWajdJyfTvWuu9j4XGuEOx1p0+pyClMLSuHci2XoNlhdm/HNtorfbnTT/3BGsX9n7S663
	Jw+e0WIPFLYSFKJUHHbD4PEvynh0B6tB2fQhWu9be2fz+yAwe3Y3wJHBybM/F899la1Mdk8ssC1
	q5zLnub/Atf4Ahf3QVV4HL+L/MQ+vF3pS3sZQsODcW2SXBX0D53/2Wgeg==
X-Google-Smtp-Source: AGHT+IG6arAzVl6HLAMqN9z/MzZaWB5BcqXpxfP1UmLTloUHWHhnsCplk6ckF1vPV/+khfdOvVTJng==
X-Received: by 2002:a5d:64a9:0:b0:386:3803:bbd8 with SMTP id ffacd0b85a97d-388e4dadd3cmr537564f8f.59.1734481899583;
        Tue, 17 Dec 2024 16:31:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80163b8sm12278830f8f.35.2024.12.17.16.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:31:39 -0800 (PST)
Message-Id: <pull.1436.v2.git.git.1734481897905.gitgitgadget@gmail.com>
In-Reply-To: <pull.1436.git.git.1673992498572.gitgitgadget@gmail.com>
References: <pull.1436.git.git.1673992498572.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 00:31:37 +0000
Subject: [PATCH v2] git: replace strbuf_addstr with strbuf_addch for all
 strings of length 2
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

This helps reduce overhead of calculating the length

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: replace strbuf_addstr with strbuf_addch for all strings of length 2
    
    This helps reduce overhead of calculating the length
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1436%2FAreaZR%2Fstrbuf-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1436/AreaZR/strbuf-v2
Pull-Request: https://github.com/git/git/pull/1436

Range-diff vs v1:

 1:  8eed09a9df1 ! 1:  22c37ed6677 git: replace strbuf_addstr with strbuf_addch for all strings of length 2
     @@ Commit message
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
       ## bisect.c ##
     -@@ bisect.c: static int register_ref(const char *refname, const struct object_id *oid,
     +@@ bisect.c: static int register_ref(const char *refname, const char *referent UNUSED, const
       {
       	struct strbuf good_prefix = STRBUF_INIT;
       	strbuf_addstr(&good_prefix, term_good);
     @@ bisect.c: static int register_ref(const char *refname, const struct object_id *o
      +	strbuf_addch(&good_prefix, '-');
       
       	if (!strcmp(refname, term_bad)) {
     - 		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
     + 		free(current_bad_oid);
      
       ## builtin/am.c ##
      @@ builtin/am.c: static void write_author_script(const struct am_state *state)
     @@ protocol-caps.c: static void send_info(struct repository *r, struct packet_write
       				strbuf_addf(&send_buffer, " %lu", object_size);
       			}
      
     - ## reftable/readwrite_test.c ##
     -@@ reftable/readwrite_test.c: static void test_table_read_write_seek(int index, int hash_id)
     - 	}
     - 
     - 	strbuf_addstr(&pastLast, names[N - 1]);
     --	strbuf_addstr(&pastLast, "/");
     -+	strbuf_addch(&pastLast, '/');
     - 
     - 	err = reftable_reader_seek_ref(&rd, &it, pastLast.buf);
     - 	if (err == 0) {
     -
     - ## reftable/refname.c ##
     -@@ reftable/refname.c: int modification_validate(struct modification *mod)
     - 			goto done;
     - 		strbuf_reset(&slashed);
     - 		strbuf_addstr(&slashed, mod->add[i]);
     --		strbuf_addstr(&slashed, "/");
     -+		strbuf_addch(&slashed, '/');
     - 
     - 		err = modification_has_ref_with_prefix(mod, slashed.buf);
     - 		if (err == 0) {
     -
     - ## reftable/stack.c ##
     -@@ reftable/stack.c: static void stack_filename(struct strbuf *dest, struct reftable_stack *st,
     - {
     - 	strbuf_reset(dest);
     - 	strbuf_addstr(dest, st->reftable_dir);
     --	strbuf_addstr(dest, "/");
     -+	strbuf_addch(dest, '/');
     - 	strbuf_addstr(dest, name);
     - }
     - 
     -@@ reftable/stack.c: int reftable_addition_commit(struct reftable_addition *add)
     - 
     - 	for (i = 0; i < add->stack->merged->stack_len; i++) {
     - 		strbuf_addstr(&table_list, add->stack->readers[i]->name);
     --		strbuf_addstr(&table_list, "\n");
     -+		strbuf_addch(&table_list, '\n');
     - 	}
     - 	for (i = 0; i < add->new_tables_len; i++) {
     - 		strbuf_addstr(&table_list, add->new_tables[i]);
     --		strbuf_addstr(&table_list, "\n");
     -+		strbuf_addch(&table_list, '\n');
     - 	}
     - 
     - 	err = write(add->lock_file_fd, table_list.buf, table_list.len);
     -@@ reftable/stack.c: static int stack_compact_range(struct reftable_stack *st, int first, int last,
     - 
     - 	for (i = 0; i < first; i++) {
     - 		strbuf_addstr(&ref_list_contents, st->readers[i]->name);
     --		strbuf_addstr(&ref_list_contents, "\n");
     -+		strbuf_addch(&ref_list_contents, '\n');
     - 	}
     - 	if (!is_empty_table) {
     - 		strbuf_addbuf(&ref_list_contents, &new_table_name);
     --		strbuf_addstr(&ref_list_contents, "\n");
     -+		strbuf_addch(&ref_list_contents, '\n');
     - 	}
     - 	for (i = last + 1; i < st->merged->stack_len; i++) {
     - 		strbuf_addstr(&ref_list_contents, st->readers[i]->name);
     --		strbuf_addstr(&ref_list_contents, "\n");
     -+		strbuf_addch(&ref_list_contents, '\n');
     - 	}
     - 
     - 	err = write(lock_file_fd, ref_list_contents.buf, ref_list_contents.len);
     -
     - ## reftable/stack_test.c ##
     -@@ reftable/stack_test.c: static void test_reftable_stack_add_one(void)
     - 
     - 	strbuf_reset(&scratch);
     - 	strbuf_addstr(&scratch, dir);
     --	strbuf_addstr(&scratch, "/");
     -+	strbuf_addch(&scratch, '/');
     - 	/* do not try at home; not an external API for reftable. */
     - 	strbuf_addstr(&scratch, st->readers[0]->name);
     - 	err = stat(scratch.buf, &stat_result);
     -
     - ## reftable/writer.c ##
     -@@ reftable/writer.c: int reftable_writer_add_log(struct reftable_writer *w,
     - 			err = REFTABLE_API_ERROR;
     - 			goto done;
     - 		}
     --		strbuf_addstr(&cleaned_message, "\n");
     -+		strbuf_addch(&cleaned_message, '\n');
     - 		log->value.update.message = cleaned_message.buf;
     - 	}
     - 
     -
     - ## sequencer.c ##
     -@@ sequencer.c: static int do_pick_commit(struct repository *r,
     - 		} else {
     - 			strbuf_addstr(&msgbuf, "Revert \"");
     - 			strbuf_addstr(&msgbuf, msg.subject);
     --			strbuf_addstr(&msgbuf, "\"");
     -+			strbuf_addch(&msgbuf, '\"');
     - 		}
     - 		strbuf_addstr(&msgbuf, "\n\nThis reverts commit ");
     - 		refer_to_commit(opts, &msgbuf, commit);
     -
       ## setup.c ##
      @@ setup.c: static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
       				return GIT_DIR_DISALLOWED_BARE;


 bisect.c                | 2 +-
 builtin/am.c            | 6 ++----
 builtin/blame.c         | 8 +++-----
 builtin/ls-tree.c       | 2 +-
 diff.c                  | 2 +-
 log-tree.c              | 2 +-
 merge-ort.c             | 3 +--
 path.c                  | 2 +-
 protocol-caps.c         | 2 +-
 setup.c                 | 2 +-
 trace2/tr2_tgt_normal.c | 2 +-
 11 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/bisect.c b/bisect.c
index d71c4e4b44b..94bb53c9bf6 100644
--- a/bisect.c
+++ b/bisect.c
@@ -454,7 +454,7 @@ static int register_ref(const char *refname, const char *referent UNUSED, const
 {
 	struct strbuf good_prefix = STRBUF_INIT;
 	strbuf_addstr(&good_prefix, term_good);
-	strbuf_addstr(&good_prefix, "-");
+	strbuf_addch(&good_prefix, '-');
 
 	if (!strcmp(refname, term_bad)) {
 		free(current_bad_oid);
diff --git a/builtin/am.c b/builtin/am.c
index bfa95147cf4..6cb9fd4f45f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -341,13 +341,11 @@ static void write_author_script(const struct am_state *state)
 
 	strbuf_addstr(&sb, "GIT_AUTHOR_NAME=");
 	sq_quote_buf(&sb, state->author_name);
-	strbuf_addch(&sb, '\n');
 
-	strbuf_addstr(&sb, "GIT_AUTHOR_EMAIL=");
+	strbuf_addstr(&sb, "\nGIT_AUTHOR_EMAIL=");
 	sq_quote_buf(&sb, state->author_email);
-	strbuf_addch(&sb, '\n');
 
-	strbuf_addstr(&sb, "GIT_AUTHOR_DATE=");
+	strbuf_addstr(&sb, "\nGIT_AUTHOR_DATE=");
 	sq_quote_buf(&sb, state->author_date);
 	strbuf_addch(&sb, '\n');
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 6a7bb3b0724..c1ee2585ee8 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -148,11 +148,9 @@ static void get_ac_line(const char *inbuf, const char *what,
 
 	if (split_ident_line(&ident, tmp, len)) {
 	error_out:
-		/* Ugh */
-		tmp = "(unknown)";
-		strbuf_addstr(name, tmp);
-		strbuf_addstr(mail, tmp);
-		strbuf_addstr(tz, tmp);
+		strbuf_addstr(name, "(unknown)");
+		strbuf_addstr(mail, "(unknown)");
+		strbuf_addstr(tz, "(unknown)");
 		*time = 0;
 		return;
 	}
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 8542b5d53e4..605ddb5a719 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -37,7 +37,7 @@ static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
 	} else if (padded) {
 		strbuf_addf(line, "%7s", "-");
 	} else {
-		strbuf_addstr(line, "-");
+		strbuf_addch(line, '-');
 	}
 }
 
diff --git a/diff.c b/diff.c
index 266ddf18e73..61434c6cb45 100644
--- a/diff.c
+++ b/diff.c
@@ -1763,7 +1763,7 @@ static void add_line_count(struct strbuf *out, int count)
 		strbuf_addstr(out, "0,0");
 		break;
 	case 1:
-		strbuf_addstr(out, "1");
+		strbuf_addch(out, '1');
 		break;
 	default:
 		strbuf_addf(out, "1,%d", count);
diff --git a/log-tree.c b/log-tree.c
index 83cc4b1cfb7..d0dc065e4f3 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -452,7 +452,7 @@ void fmt_output_subject(struct strbuf *filename,
 
 		strbuf_addf(&temp, "v%s", info->reroll_count);
 		format_sanitized_subject(filename, temp.buf, temp.len);
-		strbuf_addstr(filename, "-");
+		strbuf_addch(filename, '-');
 		strbuf_release(&temp);
 	}
 	strbuf_addf(filename, "%04d-%s", nr, subject);
diff --git a/merge-ort.c b/merge-ort.c
index 11029c10be3..8bda8170863 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -827,8 +827,7 @@ static void path_msg(struct merge_options *opt,
 
 	va_start(ap, fmt);
 	if (opt->priv->call_depth) {
-		strbuf_addchars(dest, ' ', 2);
-		strbuf_addstr(dest, "From inner merge:");
+		strbuf_addstr(dest, "  From inner merge:");
 		strbuf_addchars(dest, ' ', opt->priv->call_depth * 2);
 	}
 	strbuf_vaddf(dest, fmt, ap);
diff --git a/path.c b/path.c
index 4dcf3c8d40d..04085c164d0 100644
--- a/path.c
+++ b/path.c
@@ -982,7 +982,7 @@ const char *remove_leading_path(const char *in, const char *prefix)
 
 	strbuf_reset(&buf);
 	if (!in[j])
-		strbuf_addstr(&buf, ".");
+		strbuf_addch(&buf, '.');
 	else
 		strbuf_addstr(&buf, in + j);
 	return buf.buf;
diff --git a/protocol-caps.c b/protocol-caps.c
index 855f279c2f7..a841a457bbd 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -65,7 +65,7 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 
 		if (info->size) {
 			if (oid_object_info(r, &oid, &object_size) < 0) {
-				strbuf_addstr(&send_buffer, " ");
+				strbuf_addch(&send_buffer, ' ');
 			} else {
 				strbuf_addf(&send_buffer, " %lu", object_size);
 			}
diff --git a/setup.c b/setup.c
index 39ff48d9dc5..27535f9f9a2 100644
--- a/setup.c
+++ b/setup.c
@@ -1550,7 +1550,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 				return GIT_DIR_DISALLOWED_BARE;
 			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report))
 				return GIT_DIR_INVALID_OWNERSHIP;
-			strbuf_addstr(gitdir, ".");
+			strbuf_addch(gitdir, '.');
 			return GIT_DIR_BARE;
 		}
 
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index baef48aa698..8a05cf2109a 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -226,7 +226,7 @@ static void fn_child_start_fl(const char *file, int line,
 	if (cmd->dir) {
 		strbuf_addstr(&buf_payload, " cd ");
 		sq_quote_buf_pretty(&buf_payload, cmd->dir);
-		strbuf_addstr(&buf_payload, ";");
+		strbuf_addch(&buf_payload, ';');
 	}
 
 	/*

base-commit: 2ccc89b0c16c51561da90d21cfbb4b58cc877bf6
-- 
gitgitgadget
