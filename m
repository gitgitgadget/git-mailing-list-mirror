Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E222E1746
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786302078; cv=none; b=CyKexg4anb7mDO+6g8qnFAiEpNjMJaCkwaiVU0nZ+DkgkHWTJvz8IlH7B6nRFAo/MwjVgwM1Xw5Of3jD1jHhs3s5cMBIrRNuy0HyOaf4f5zZxCyTGvF3onWkoSyskU+dEzTUEDkPczp206Ejklt6RCVww5nRYfJElzxHmYoWbk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786302078; c=relaxed/simple;
	bh=Fh3HTh/lBHJRjvMUwYDnOkcDFcKUHMRK2MFkGw2LrXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8vZmDIXZ0YcJk7QRZFYIJI8MzpB1dDiy0uP16H/hB+2N877ddXGAoGkC4BmhnVJ9pDaOoMOFvPb3o3QLBcm1L3bb+7ZDNsQE40QxUvQNjS8ccVvUonjymtpSdK5lIzkqSLLizm/Ij19DRzbrls1RUMwrDaYZKdFbS15D4OJiVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7dBHqBv; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7dBHqBv"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4af81963f35so299527b6e.0
        for <git@vger.kernel.org>; Sun, 09 Aug 2026 12:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786302076; x=1786906876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=afM8LLbinUOInE4+9oOJgiJUXzqTF0qSkO2av8YQ/8M=;
        b=J7dBHqBvTWv5FrVMKAacSZXEEgDz9imprMy7Sv0L+I/KgcZfPTQ0OWwRxN4oLgDQSj
         WlRVaO7nb24e/iboAS8FainAFJl0t0gfHfOvoooHiQUAzc44DD2rDFy3zohHubgz/CT2
         8cbDJrLLhBVO3R0ptt3oZ/7yH4IQ3aixNSvXhaTfCjKbd0KWHwNPoJX8x7te3oSRmim/
         U5ppuGiPXuCDCJgDhKrIe3ZJo9O/Mrt6nL3j36phyJpHpdZNO5tpKqy5raa3NfUlfi4U
         HOgwwq/kKUsCbXKHNxraeK71qJ2qwlUz0sH0wqIEtBMSlVAD0mcZXO9ckhoJ+75YUhwU
         +yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786302076; x=1786906876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=afM8LLbinUOInE4+9oOJgiJUXzqTF0qSkO2av8YQ/8M=;
        b=Pr+S5MTQcL+v33PwWV51ttiWzAjgDhhgt/x5LOI2rn88TrUKVdqLPGWwetocHssy0z
         lGQNBB4d6DRuu8yoLKAI/KJW0n2rjMrc2Z2bM2krHkuTw8e/it3LohIVt/VCp1DRdqz4
         GSHhmNjdP7kzEn40XYRH8OgTLZCARPzi1TbWwAh0nPAzSJAzEp9izu76rZeGJ5Q7B2OU
         AuvLGHyZrOZ4rZXhXoxavDAsVFSidWuWkwCiGFnkvPBFc6vzfPvlihOyLZpj7KwMipZd
         jUEuf2rdYZyFmaB/jtnT6eza+8O3Jw33kZYW+TcX/1pho6EGYWcTNSkIt90NWL1VDkUz
         djZw==
X-Gm-Message-State: AOJu0YzdYp8UOctcy99bJG7+Bz/g0MG/tL4OZFaAupLcmyyNimX0ueBi
	LhGIkNAV4A0iRiWN/S8QdY3Ap+Lt8Tkj5Nkgd4O1zsUfy8sxNdydtW/xJTt7Dg==
X-Gm-Gg: AR+sD10gv+anvGsebW20kic+7ysVYPBOuZxgUEahZyagicMQtaxAU/DZyVOKLPtgx8a
	MfON/nFXxVzIfilOThGjSwMe3QUSbt/SekyMWCd9IJSrRL0agXR7YMkSJ9APNWMvVHlpgMH+aJ2
	yblFfpE41ww2fVcb7FNX1wF4q9TaS6VBPzidDZVqZv/1dCFETNVqfITmH+uJu+mcsNpDxCni9dH
	xT1D6Gcak1UNXYsGQQheOyKfQ0jmAocf2SKrONRRlzhmUlygKXxT7s74ZLgbtmnN6+CRSpEHyv8
	TZ2DRKge+ZAaUIF9hERgNAIeY3R0ruQob12nySVLpc0PQdqe3/qylUo2Hy5+hjQ/VztD+IpTd+2
	8/l9aivxzheVIJYpGLQ/M09I/AZ1eFnrWKLFXccYvwrEtuamgnML2bGqGMDVRD82QQLqxVUHYXP
	TRwe4DYI2339zER+Y/O5DuWHg02yx9/Ure2H4JPBqGY00ZrDSJwOo1FJRve10l+JVnOB1r/+eff
	2iP824D
X-Received: by 2002:a05:6808:1a0b:b0:4ab:2abe:f031 with SMTP id 5614622812f47-4afadf10208mr20663287b6e.6.1786302075618;
        Sun, 09 Aug 2026 12:01:15 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af5e7b77sm4872188b6e.10.2026.08.09.12.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 12:01:15 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 5/7] builtin/receive-pack: report unpack errors via strbuf
Date: Sun,  9 Aug 2026 14:01:04 -0500
Message-ID: <20260809190106.1565882-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260809190106.1565882-1-jltobler@gmail.com>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260809190106.1565882-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing packfiles via `unpack()`, error messages are returned
directly by the function. In preparation for `unpack()` logic being
moved behind a generic ODB transaction interface, update the function to
instead write any error messages to a caller provided strbuf and return
a negative value on error. Call sites are updated to use the error
strbuf accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 63 ++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 21dab851ad..896439d46d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2015,7 +2015,7 @@ static void execute_commands_atomic(struct command *commands,
 }
 
 static void execute_commands(struct command *commands,
-			     const char *unpacker_error,
+			     int unpacker_error,
 			     struct shallow_info *si,
 			     struct odb_transaction *transaction,
 			     const struct string_list *push_options)
@@ -2354,8 +2354,8 @@ struct unpack_opts {
 	int quiet;
 };
 
-static const char *unpack(struct odb_transaction *transaction,
-			  const struct unpack_opts *opts)
+static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
+		  const struct unpack_opts *opts)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
@@ -2367,7 +2367,8 @@ static const char *unpack(struct odb_transaction *transaction,
 	if (hdr_err) {
 		if (err_fd > 0)
 			close(err_fd);
-		return hdr_err;
+		strbuf_addstr(err_msg, hdr_err);
+		return -1;
 	}
 
 	if (opts->shallow_file) {
@@ -2392,8 +2393,10 @@ static const char *unpack(struct odb_transaction *transaction,
 		child.err = err_fd;
 		child.git_cmd = 1;
 		status = run_command(&child);
-		if (status)
-			return "unpack-objects abnormal exit";
+		if (status) {
+			strbuf_addstr(err_msg, "unpack-objects abnormal exit");
+			return -1;
+		}
 	} else {
 		char hostname[HOST_NAME_MAX + 1];
 		char *lockfile;
@@ -2424,8 +2427,10 @@ static const char *unpack(struct odb_transaction *transaction,
 		child.err = err_fd;
 		child.git_cmd = 1;
 		status = start_command(&child);
-		if (status)
-			return "index-pack fork failed";
+		if (status) {
+			strbuf_addstr(err_msg, "index-pack fork failed");
+			return -1;
+		}
 
 		lockfile = index_pack_lockfile(the_repository, child.out, NULL);
 		if (lockfile) {
@@ -2435,15 +2440,18 @@ static const char *unpack(struct odb_transaction *transaction,
 		close(child.out);
 
 		status = finish_command(&child);
-		if (status)
-			return "index-pack abnormal exit";
+		if (status) {
+			strbuf_addstr(err_msg, "index-pack abnormal exit");
+			return -1;
+		}
 		odb_reprepare(the_repository->objects);
 	}
-	return NULL;
+	return 0;
 }
 
-static const char *unpack_with_sideband(struct odb_transaction *transaction,
-					const char *shallow_file)
+static int unpack_with_sideband(struct odb_transaction *transaction,
+				const char *shallow_file,
+				struct strbuf *err_msg)
 {
 	struct unpack_opts opts = {
 		.fsck_objects = (receive_fsck_objects >= 0
@@ -2458,20 +2466,20 @@ static const char *unpack_with_sideband(struct odb_transaction *transaction,
 		.quiet = quiet,
 	};
 	struct async muxer;
-	const char *ret;
+	int ret;
 
 	if (!use_sideband)
-		return unpack(transaction, &opts);
+		return unpack(transaction, err_msg, &opts);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
 	muxer.proc = copy_to_sideband;
 	muxer.in = -1;
 	if (start_async(&muxer))
-		return NULL;
+		return 0;
 
 	opts.err_fd = muxer.in;
-	ret = unpack(transaction, &opts);
+	ret = unpack(transaction, err_msg, &opts);
 
 	finish_async(&muxer);
 	return ret;
@@ -2560,13 +2568,13 @@ static void update_shallow_info(struct command *commands,
 	free(ref_status);
 }
 
-static void report(struct command *commands, const char *unpack_status)
+static void report(struct command *commands, const struct strbuf *unpack_status)
 {
 	struct command *cmd;
 	struct strbuf buf = STRBUF_INIT;
 
 	packet_buf_write(&buf, "unpack %s\n",
-			 unpack_status ? unpack_status : "ok");
+			 unpack_status->len ? unpack_status->buf : "ok");
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->error_string)
 			packet_buf_write(&buf, "ok %s\n",
@@ -2584,14 +2592,14 @@ static void report(struct command *commands, const char *unpack_status)
 	strbuf_release(&buf);
 }
 
-static void report_v2(struct command *commands, const char *unpack_status)
+static void report_v2(struct command *commands, const struct strbuf *unpack_status)
 {
 	struct command *cmd;
 	struct strbuf buf = STRBUF_INIT;
 	struct ref_push_report *report;
 
 	packet_buf_write(&buf, "unpack %s\n",
-			 unpack_status ? unpack_status : "ok");
+			 unpack_status->len ? unpack_status->buf : "ok");
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		int count = 0;
 
@@ -2715,8 +2723,8 @@ int cmd_receive_pack(int argc,
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	if ((commands = read_head_info(&reader, &shallow))) {
-		const char *unpack_status = NULL;
 		struct string_list push_options = STRING_LIST_INIT_DUP;
+		struct strbuf unpack_status = STRBUF_INIT;
 
 		if (use_push_options)
 			read_push_options(&reader, &push_options);
@@ -2736,22 +2744,22 @@ int cmd_receive_pack(int argc,
 				alt_shallow_file = setup_temporary_shallow(si.shallow);
 
 			if (odb_transaction_begin(the_repository->objects, &transaction, ODB_TRANSACTION_RECEIVE))
-				unpack_status = "unable to start object transaction";
+				strbuf_addstr(&unpack_status, "unable to start object transaction");
 			else
-				unpack_status = unpack_with_sideband(transaction, alt_shallow_file);
+				unpack_with_sideband(transaction, alt_shallow_file, &unpack_status);
 
 			update_shallow_info(commands, &si, &ref, alt_shallow_file);
 		}
 		use_keepalive = KEEPALIVE_ALWAYS;
-		execute_commands(commands, unpack_status, &si, transaction,
+		execute_commands(commands, !!unpack_status.len, &si, transaction,
 				 &push_options);
 		odb_transaction_finalize(transaction);
 		delete_tempfile(&pack_lockfile);
 		sigchain_push(SIGPIPE, SIG_IGN);
 		if (report_status_v2)
-			report_v2(commands, unpack_status);
+			report_v2(commands, &unpack_status);
 		else if (report_status)
-			report(commands, unpack_status);
+			report(commands, &unpack_status);
 		sigchain_pop(SIGPIPE);
 		run_receive_hook(commands, "post-receive", 1, NULL,
 				 &push_options);
@@ -2776,6 +2784,7 @@ int cmd_receive_pack(int argc,
 		if (auto_update_server_info)
 			update_server_info(the_repository, 0);
 		clear_shallow_info(&si);
+		strbuf_release(&unpack_status);
 	}
 	if (use_sideband)
 		packet_flush(1);
-- 
2.55.0.424.g13c7afec21

