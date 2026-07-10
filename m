Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE26443932F
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701458; cv=none; b=LdFsGDzckgfrz0KW8wE633P/MkInbznJoZEj89gqgZTWIm+HLrRNRmgleNqrm95YqO/O2W7E2d5p1ZTJK4rmKE81RKf/9hNF/uqaWaGReF7JX6JCYKe4dLJxqfTOx6wHKu2FOlH15zGC6a4YOK99CICxuTwfWm3nQbGLirL6yjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701458; c=relaxed/simple;
	bh=ZPMusmpVJ+9p1ZI2K2IbEWU1Z3WFAPLrwpKdzoxBuc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWkX/hFIKMkJeWFohIjUFaEATm1LZkLHdG2zp7F0DzKuT984uJx43X+Br2FKPZ7Zi3j8I5Gl9t1XlSJubqQ5kqdLia74cm2dMWbOYKFtxf6c5sE0WMPoqHiT9+FyZV55Tx0cCGyujh0Zg/fW53EYclaVKdfrC9RokGTbItd4lFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxsC2jCt; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxsC2jCt"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6a3897109bfso431232eaf.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701456; x=1784306256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CmKmd5KMu8Ts9gO+brf0pjkR9F7NRby5t46IUKvQQ74=;
        b=DxsC2jCtQ/AYmMQmk6Lx2AZ7yauOdxyC8uqGYKPspyyzZ5Sk9MfnjVJd6uTOkXTCS1
         Zw/28hZwzFHKQke8pIfN/mvI20g/vWsrYYGkjfHx7b6vkci1cBPRfMWPqew0iI+CRsRp
         Hz5JZganZHfG2JqJx9tJeTU1aYNLRfmze7YqZk4p2VudnJRC0/jERlPP0mEyETfWMQLR
         hLavBVYkIDj8HcjBSBUrYDIzWX2D01q//LWYCw4WnLGxh1DB3z3PU4ozFkCZ5CePqHw5
         njQU4oOdHYsoeVKrWBcF3YsdF+dWDm6bBj4O3ZVcfASzp43f7283IaRFGYcDR8E70fa4
         9qzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701456; x=1784306256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CmKmd5KMu8Ts9gO+brf0pjkR9F7NRby5t46IUKvQQ74=;
        b=Ac05eLEIaUt4o65YFLHnjNk7Z+sKMuj4mqpzdYbQ9ELLf32qu9aHy+6O98wBc3nJgJ
         DJuiwlRJdVA8CKHS2dKkcwydrNHNN9wvy/1g6wmtN8qGGOHSaSa7krVk5do74birVqrA
         Hzjo5ZORKchapITwgAiJz6NkJYqLVPhV1dKU5b9gbu8M5gKwZA/aqSjm2CwdHJyhlMUK
         Zi0+XHbA0WCwCbWEBFIjAbxD7f7y0P3TKbfluEgktFevPk9lPnwCM1E96mM4Pnthg2/D
         zCrtIx8J0fqD/QT3uOLwX4JH0Ome4jrcDoLwQ1Tb3ATd4Q5YoWHEe74kcv+cO88U67Xf
         HsPg==
X-Gm-Message-State: AOJu0YwtL99FvTiUvxRXwwNv5tchLAIrcR0Pb6jOuT+jqVElCVXbKwet
	crWrCBtoidX4+TsZbBFfckboo5arsemdwXyitQk4cvQxvh5PLEKc03o5z8ANrw==
X-Gm-Gg: AfdE7cnMEwHhKHUwzES4Ef6hgBc/DBe/aMv5TiaTGVXCaKQK8THEhotSG4mv5tBpN4M
	gG3YRg1fccIytNk17cln6h2TKLqIgTHEDcOVZGuTyZKwwglK8FnkELMYMSiy5nBOjkEDrmgZrpO
	teC2wSIvPJ5FiYsaj/xwbxvbfw4iZa+Cb7S/uzEK+wVERQGTTYJSCiX4jTTRKQjpTTHxSNrFek2
	RPs7X+h1ostZ48OzJ489/enIvIpMKfYTt2jWSiSMCpsosvGtlcGRAHSPxI1pyuf9IFmrH9OSDII
	mn6avolmuMtkETxdN+GJUm+yObvz4vwN0DbTeyD2M864cFCRwB2a8U/YDBLca/P6hDNg6jEncx2
	pLTlDB5PAZiMxlam+bvSqFxKr9Yw57/AHSJ/DN34YZYoQ19ZfqhAAHIAVbfKzqferW+ARR+mCpl
	NRcREqDOEUiiXvMryamPNl
X-Received: by 2002:a05:6820:168e:b0:6a3:2b61:61b4 with SMTP id 006d021491bc7-6a39a82ac59mr32018eaf.56.1783701455599;
        Fri, 10 Jul 2026 09:37:35 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcaf742e1sm6882147a34.8.2026.07.10.09.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:37:35 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 11/11] builtin/receive-pack: stage incoming objects via ODB transactions
Date: Fri, 10 Jul 2026 11:37:22 -0500
Message-ID: <20260710163722.2962278-12-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260710163722.2962278-1-jltobler@gmail.com>
References: <20260708235925.3992097-1-jltobler@gmail.com>
 <20260710163722.2962278-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Objects received by git-receive-pack(1) are quarantined in a temporary
"incoming" directory and migrated into the object database prior to the
reference updates. The quarantine is currently managed through
`tmp_objdir` directly. In a pluggable ODB future, how exactly an object
gets written to a transaction may vary for a given ODB source. Refactor
git-receive-pack(1) to use the ODB transaction interfaces to manage the
object staging area in a more agnostic manner accordingly.

Note that the ODB transaction is now responsible for managing the
primary and alternate ODBs for the repository. One small change as a
result is that the temporary directory is now applied as the primary ODB
in the main process instead of an alternate. This does not change
anything for git-receive-pack(1) though because it only needs access to
the newly written objects and doesn't care how exactly it is set up.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 68 ++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 50bc05c70c..8b8c20dc1a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -37,7 +37,6 @@
 #include "sigchain.h"
 #include "string-list.h"
 #include "strvec.h"
-#include "tmp-objdir.h"
 #include "trace.h"
 #include "trace2.h"
 #include "version.h"
@@ -112,8 +111,6 @@ static enum {
 } use_keepalive;
 static int keepalive_in_sec = 5;
 
-static struct tmp_objdir *tmp_objdir;
-
 static struct proc_receive_ref {
 	unsigned int want_add:1,
 		     want_delete:1,
@@ -926,6 +923,7 @@ static void receive_hook_feed_state_free(void *data)
 static int run_receive_hook(struct command *commands,
 			    const char *hook_name,
 			    int skip_broken,
+			    struct odb_transaction *transaction,
 			    const struct string_list *push_options)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
@@ -959,8 +957,8 @@ static int run_receive_hook(struct command *commands,
 		strvec_push(&opt.env, "GIT_PUSH_OPTION_COUNT");
 	}
 
-	if (tmp_objdir)
-		strvec_pushv(&opt.env, tmp_objdir_env(tmp_objdir));
+	if (transaction)
+		odb_transaction_env(transaction, &opt.env);
 
 	prepare_push_cert_sha1(&opt);
 
@@ -1789,24 +1787,30 @@ static const struct object_id *command_singleton_iterator(void *cb_data)
 }
 
 static void set_connectivity_errors(struct command *commands,
-				    struct shallow_info *si)
+				    struct shallow_info *si,
+				    struct odb_transaction *transaction)
 {
 	struct command *cmd;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		struct command *singleton = cmd;
 		struct check_connected_options opt = CHECK_CONNECTED_INIT;
+		struct strvec env = STRVEC_INIT;
 
 		if (shallow_update && si->shallow_ref[cmd->index])
 			/* to be checked in update_shallow_ref() */
 			continue;
 
-		opt.env = tmp_objdir_env(tmp_objdir);
+		odb_transaction_env(transaction, &env);
+		opt.env = env.v;
+
 		if (!check_connected(command_singleton_iterator, &singleton,
 				     &opt))
 			continue;
 
 		cmd->error_string = "missing necessary objects";
+
+		strvec_clear(&env);
 	}
 }
 
@@ -2027,6 +2031,7 @@ static void execute_commands_atomic(struct command *commands,
 static void execute_commands(struct command *commands,
 			     const char *unpacker_error,
 			     struct shallow_info *si,
+			     struct odb_transaction *transaction,
 			     const struct string_list *push_options)
 {
 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
@@ -2043,6 +2048,8 @@ static void execute_commands(struct command *commands,
 	}
 
 	if (!skip_connectivity_check) {
+		struct strvec env = STRVEC_INIT;
+
 		if (use_sideband) {
 			memset(&muxer, 0, sizeof(muxer));
 			muxer.proc = copy_to_sideband;
@@ -2056,14 +2063,17 @@ static void execute_commands(struct command *commands,
 		data.si = si;
 		opt.err_fd = err_fd;
 		opt.progress = err_fd && !quiet;
-		opt.env = tmp_objdir_env(tmp_objdir);
+		odb_transaction_env(transaction, &env);
+		opt.env = env.v;
 		opt.exclude_hidden_refs_section = "receive";
 
 		if (check_connected(iterate_receive_command_list, &data, &opt))
-			set_connectivity_errors(commands, si);
+			set_connectivity_errors(commands, si, transaction);
 
 		if (use_sideband)
 			finish_async(&muxer);
+
+		strvec_clear(&env);
 	}
 
 	reject_updates_to_hidden(commands);
@@ -2084,7 +2094,7 @@ static void execute_commands(struct command *commands,
 		}
 	}
 
-	if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
+	if (run_receive_hook(commands, "pre-receive", 0, transaction, push_options)) {
 		for (cmd = commands; cmd; cmd = cmd->next) {
 			if (!cmd->error_string)
 				cmd->error_string = "pre-receive hook declined";
@@ -2105,14 +2115,13 @@ static void execute_commands(struct command *commands,
 	 * Now we'll start writing out refs, which means the objects need
 	 * to be in their final positions so that other processes can see them.
 	 */
-	if (tmp_objdir_migrate(tmp_objdir) < 0) {
+	if (odb_transaction_commit(transaction)) {
 		for (cmd = commands; cmd; cmd = cmd->next) {
 			if (!cmd->error_string)
 				cmd->error_string = "unable to migrate objects to permanent storage";
 		}
 		return;
 	}
-	tmp_objdir = NULL;
 
 	check_aliased_updates(commands);
 
@@ -2325,7 +2334,8 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
 		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
 }
 
-static const char *unpack(int err_fd, struct shallow_info *si)
+static const char *unpack(int err_fd, struct shallow_info *si,
+			  struct odb_transaction *transaction)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
@@ -2350,20 +2360,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		strvec_push(&child.args, alt_shallow_file);
 	}
 
-	tmp_objdir = tmp_objdir_create(the_repository, "incoming");
-	if (!tmp_objdir) {
-		if (err_fd > 0)
-			close(err_fd);
-		return "unable to create temporary object directory";
-	}
-	strvec_pushv(&child.env, tmp_objdir_env(tmp_objdir));
-
-	/*
-	 * Normally we just pass the tmp_objdir environment to the child
-	 * processes that do the heavy lifting, but we may need to see these
-	 * objects ourselves to set up shallow information.
-	 */
-	tmp_objdir_add_as_alternate(tmp_objdir);
+	odb_transaction_env(transaction, &child.env);
 
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
 		strvec_push(&child.args, "unpack-objects");
@@ -2430,13 +2427,14 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 	return NULL;
 }
 
-static const char *unpack_with_sideband(struct shallow_info *si)
+static const char *unpack_with_sideband(struct shallow_info *si,
+					struct odb_transaction *transaction)
 {
 	struct async muxer;
 	const char *ret;
 
 	if (!use_sideband)
-		return unpack(0, si);
+		return unpack(0, si, transaction);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
@@ -2445,7 +2443,7 @@ static const char *unpack_with_sideband(struct shallow_info *si)
 	if (start_async(&muxer))
 		return NULL;
 
-	ret = unpack(muxer.in, si);
+	ret = unpack(muxer.in, si, transaction);
 
 	finish_async(&muxer);
 	return ret;
@@ -2622,6 +2620,7 @@ int cmd_receive_pack(int argc,
 	struct oid_array ref = OID_ARRAY_INIT;
 	struct shallow_info si;
 	struct packet_reader reader;
+	struct odb_transaction *transaction = NULL;
 
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("quiet")),
@@ -2706,11 +2705,14 @@ int cmd_receive_pack(int argc,
 		if (!si.nr_ours && !si.nr_theirs)
 			shallow_update = 0;
 		if (!delete_only(commands)) {
-			unpack_status = unpack_with_sideband(&si);
+			if (odb_transaction_begin(the_repository->objects, &transaction, ODB_TRANSACTION_RECEIVE))
+				unpack_status = "unable to start object transaction";
+			else
+				unpack_status = unpack_with_sideband(&si, transaction);
 			update_shallow_info(commands, &si, &ref);
 		}
 		use_keepalive = KEEPALIVE_ALWAYS;
-		execute_commands(commands, unpack_status, &si,
+		execute_commands(commands, unpack_status, &si, transaction,
 				 &push_options);
 		delete_tempfile(&pack_lockfile);
 		sigchain_push(SIGPIPE, SIG_IGN);
@@ -2719,7 +2721,7 @@ int cmd_receive_pack(int argc,
 		else if (report_status)
 			report(commands, unpack_status);
 		sigchain_pop(SIGPIPE);
-		run_receive_hook(commands, "post-receive", 1,
+		run_receive_hook(commands, "post-receive", 1, NULL,
 				 &push_options);
 		run_update_post_hook(commands);
 		free_commands(commands);
-- 
2.55.0.122.gf85a7e6620

