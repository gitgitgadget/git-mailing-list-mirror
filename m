Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF5F3AB29C
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 23:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555183; cv=none; b=pwWE1WsGiouWVgRb0tpor9QXAZBxbKivw/eiLb+dOfiLcRXlQbm2JL2uyaYho/TxgIiCdMKX5MEwIIX8+UupPIReY8YlryKLcBHC/Ke9Xv/vmT/5pu/0dPXHSU7QcX/vW8jPo0+WDhTAxjy5dfm600CzBPJDrjNN+6sxVlfESwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555183; c=relaxed/simple;
	bh=ZPMusmpVJ+9p1ZI2K2IbEWU1Z3WFAPLrwpKdzoxBuc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=db/y9KVoRgj00By6fbyj25nn7JgspH6a15ff0MJoVFQqfM8rLrXl2NlXWQ318IjJy1GORgcwPMycAtn+m+CuI6qCoCQNk99RA3Nv+enYRf0TjI0GRXPmPRuw3TyTas9fwE6OtQJmSkNtLUSkFYfg7qBQU9H3biiQEKPwAtTw+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7DsKMcu; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7DsKMcu"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-44865cf3010so158096fac.2
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 16:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783555180; x=1784159980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CmKmd5KMu8Ts9gO+brf0pjkR9F7NRby5t46IUKvQQ74=;
        b=X7DsKMcuYUWKwMEewkKyohchtTEKyzYkWBrC6S66zJnq10KPspEtEdxf6r2t4U6Uk8
         zY/LMbe+sbLhyJsvvHpZPuoURtAVuoQE9AbzK4+/KRcZ29USr5xuF4mNooG875/tHRev
         6ya6rcaiiKkPhLOYYSUCOFq6BaJNXco+8MmfGqGyDrnsAdhX/0ctaX8FDMmXK+m6TvNG
         kFW4UIVdPUXyjP9+O/aw1sJSf/EeVxBxP/ZUFfvnoRcosSgWgBGhdZubgl+pCJh3umZO
         w9oyR+keAmSBQanWozWHLPxmhWaG1sgXG2Far5pp4witxRY/MCAmHiCAVeg1f+MMw51i
         rv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555180; x=1784159980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CmKmd5KMu8Ts9gO+brf0pjkR9F7NRby5t46IUKvQQ74=;
        b=D8fCy340dVhTlGGg3EiEmS4sy6vycHsVG5aCgEOTXs4tNvWYplJJbh1t0h40ph37SP
         ESbJQmjNiOHyRULwnOYRrMEOBC+py4FqxHodUO90O0BzG+iIGFqxmrSt/joAKbQyA3WL
         6ktPWGkmQ76ZjXYoBSDE4YKeg3PYWlp/mOyrxu7U9eoNtvCfMpxtukbjqHr5LZuMh6li
         i5jtUFljeqJfE32op2nPDkobOwbOf2CZIux28wFHvwQmCrU36fcarCq75GJcyEtij0mo
         KiOdI42E2Vk5KgKj8R5cQ18F7/XJoa7NdZKSjTmf1C510Dmr6s9UNQgv2cDF9d9MWgaE
         /YBA==
X-Gm-Message-State: AOJu0YzI0IPEesy3DShhCQtwbtMiwKUjZ+y5f13NHM9nw/WU9pi4PMnR
	rJVArn5b+hUPEXnaRqSKHBalYKXkxG75iF1nJWSUd5/XXEKRL1nKHMz70rjKbA==
X-Gm-Gg: AfdE7cn741Alt4SV8vDQPJWOEWAOgO1ojXmI/Q9cGaaRiPKEGEKu8fEv6F69Bul7cld
	5ToJla82LubKKqvh8scusskOaYDrah4yt7NKVcOiJwAFbFI2fR37hXj0pISBmCvTE9JLZXIkzK/
	EXgz3RFrmNBy+YJRQjd9W+K27NGjIQbV5BK7R7d9Pz2WfyNcdhRxRm8Q7lQhOtpM5R4lBKWCceN
	7galPHHnJH9Fs9C5P5wYRgyBmB6PmpukAq0uZ8ligHTYYYX7L+iQewuAvJ3pZY4rquZOKlVfk2L
	0zu0ex1NoBZy/16S4sHcrZAjsVg4ptxza+wqFAVWhep8xtqxtDKr/TxOYdbHRWtiG0zE/GalDqB
	XqzMB8XdjtSBZ0fj5TFzL6r16ZSNQyruQkKRY8vyIYe/n123DKiwfez9HAaF8QIjqwGiltfii0X
	D1/9n8Wk196rgTQWnCAA8Q
X-Received: by 2002:a05:6870:176f:b0:448:b799:e604 with SMTP id 586e51a60fabf-45163795f32mr3291121fac.2.1783555180536;
        Wed, 08 Jul 2026 16:59:40 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45191643994sm490110fac.9.2026.07.08.16.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:59:40 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 11/11] builtin/receive-pack: stage incoming objects via ODB transactions
Date: Wed,  8 Jul 2026 18:59:25 -0500
Message-ID: <20260708235925.3992097-12-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708235925.3992097-1-jltobler@gmail.com>
References: <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708235925.3992097-1-jltobler@gmail.com>
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

