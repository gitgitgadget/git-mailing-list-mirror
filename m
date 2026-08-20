Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E35839A7F4
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 23:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269796; cv=none; b=I6jEgI/9T8OSkoW0pANSGjOThiIUGbS65f66n6nXXVdcveZYa5DtQK5KiM/CEnbSAwMtZ0c60KrDUmwj3TTYSvamDYReA4cSVd55X4Y7ru0S8QAkx4sMqS6Lz3UKS/6jTFxU/67sbmYqffPzTkZq3qXFIQnYqpvYVfL6yZ4kgz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269796; c=relaxed/simple;
	bh=tDvHo6KwaRmetGVJ6tUb1oEmdVRV44c0WdHuipUaonc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hs7Ox37V/EhqLMxrBBuLmu9yKHSaBqOPC12kWfxzGwbfhq4A+M0LNZKVGJ8bPfW+J+LwVn9MNoiRcC+fRIYOa9DnaP/ZUXoz8NXfmmR7lNdBIKBqz+oZLM3GogUnCfvGF1XhdULu+kOT3jKgGbXR+J6HnfsjbXwy5VRxmpYM3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGz7J3GW; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGz7J3GW"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-45e2fd33133so285617fac.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 16:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787269793; x=1787874593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hw5QTI9+y5ozN+94qk/nzogKwf/ye41O8plycc/Q/rg=;
        b=dGz7J3GWP9oYbhe1xagf9a+7LDPjJ+x6npU0lMTVFOA4l1b/oQSujeKn8sYzWEaE5h
         2F5J8uPNuHahXtuHS0nrJEEYQr9WzJZZiRLz1WvvjbqSUerRh4nhOFKafRpac0JDRaiy
         WOScPapEHCo0t01Nq/ZQxnDD7AarCATcwv/rJ2ZB5zVNq3ezdIkKjbojURnGZ65jVr8n
         yOqebEcxWKZ84c2hKJrBpgI2o5va4BVtZMsMZ8gdDhl1cEJ5szkjrTrTAoz0JuIY2zO4
         /pfr7fNYMgbOAGpuEWMg2hB0ZTFg+TsPWNdSdiNhhi95pb/6Uj4blICONFmJX6DTKs76
         suzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787269793; x=1787874593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hw5QTI9+y5ozN+94qk/nzogKwf/ye41O8plycc/Q/rg=;
        b=SROvr70sX+7YkFfZM58Wd8ibBhu8tXFdj/YvtIuK7veNeL7j7WTq3uXs5QPR8CJype
         8o7lM0CvCA/fvw+b7YRb5F5nBGwQATtU+v6Lq8pMq5t5vfVP/zET3E14xoAj1PByXKls
         lf/Xp19l/50Ye9PzMCLAAXKD948/lFJ0WGZYhCMe4gqQFq23bAebH+XhN7YghSZCBxo0
         ORo930XKWGJ/cFxiQIbZp5B/x3evMohlQ7y6HiH6cNwpbZxlqg4XiK2Lj1dsq8hVTyrF
         BxwPfDrz97ccAEI/jYQNbFMSJYA4yi6S6QPQ9VCkZxXbqn41+ddz1FkxoxM4OYmvOXfP
         Gh6A==
X-Gm-Message-State: AOJu0YyyC6VaiPaiTRitWbSmQfyJ2MQCNTDvvUlyOol4bGgG5fuxIx8c
	Vew7SfPnzmo4P95X/UNJFKYFeR8asV1hcvCA4yCD07ObT/Q2jdfO1gzUY/wqdw==
X-Gm-Gg: AR+sD13b/jFun+WqmweY44Sw5obZ7D5fhnnQ+HQmf4YJkGaVoE9aXhbyXLUxtexSEg3
	KGtaRXXRevGa12uBbNOTUuzxmNTN1p8oMlCGufcSGOhExJ1mw4+yCu72OOZEZ8Bl5Zs4NTBZYjS
	LA9hdT252P0dfdeQ1azCJx2/lOucJ42uUxVXC6qUEsI69so2/UtGHwj5hRT9sPMk4vMU8Wzk9oL
	NLnKxNap6WYtqjN9CVr/+9d8QZeigdhKiEiSFywGc1S1cj1Bfn0PA9MeIxSjUZlDN0h5t05G+wN
	I8OZaUEt9FPDy2CTv9gbqV2TDVQmTgBk7kwV/SzDerr9G8T2LRfy/KIgCDJrftaPltyhVuRNNLH
	6sMbux/hDA3BGR878mLsQaGRvBJxY13B90+gwwuWyfm8uhBvkJo4DD/WaRAva6R6qDpjemHa+s1
	zYd/D0Ia3MN+tlH3rMQS2wVMe8t6wDAGytRukYgONviu4BVn/12A/n1J5sAZEoTsRzsoyb
X-Received: by 2002:a05:6870:e996:b0:456:baee:4819 with SMTP id 586e51a60fabf-463516496c7mr1834014fac.11.1787269793178;
        Thu, 20 Aug 2026 16:49:53 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632a6c360asm2961133fac.5.2026.08.20.16.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 16:49:52 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 9/9] odb/transaction: add transaction interface to write packfiles
Date: Thu, 20 Aug 2026 18:49:40 -0500
Message-ID: <20260820234940.894624-10-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260820234940.894624-1-jltobler@gmail.com>
References: <20260819215311.3880274-1-jltobler@gmail.com>
 <20260820234940.894624-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In git-receive-pack(1), the incoming packfile is written to the ODB via
`unpack()`, which spawns git-index-pack(1) or git-unpack-objects(1)
directly. With pluggable object databases, an alternative backend may
need to handle writing packfile data differently though.

Introduce `odb_transaction_write_pack()` as a generic interface to
handle writing a packfile to a transaction and use the logic from
`unpack()` as the "files" backend implementation. Note that when storing
the objects as a packfile, git-index-pack(1) also writes a ".keep"
lockfile next to it to prevent a concurrent repack from removing the new
pack prior to reference updates being performed. The "files" transaction
backend is responsible for managing these ".keep" files and removes them
post-commit once the transaction is finalized.

Call sites in git-receive-pack(1) are updated accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 160 +-----------------------------------
 object-file.c          | 178 +++++++++++++++++++++++++++++++++++++++++
 odb/transaction.c      |   7 ++
 odb/transaction.h      |  62 ++++++++++++++
 4 files changed, 250 insertions(+), 157 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b369466783..e6e54ba55f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -15,7 +15,6 @@
 #include "gpg-interface.h"
 #include "hex.h"
 #include "hook.h"
-#include "lockfile.h"
 #include "object.h"
 #include "object-file.h"
 #include "object-name.h"
@@ -23,7 +22,6 @@
 #include "oid-array.h"
 #include "oidset.h"
 #include "pack.h"
-#include "packfile.h"
 #include "parse-options.h"
 #include "pkt-line.h"
 #include "protocol.h"
@@ -2292,162 +2290,11 @@ static void read_push_options(struct packet_reader *reader,
 	}
 }
 
-static const char *parse_pack_header(struct pack_header *hdr, int pack_fd)
-{
-	switch (read_pack_header(pack_fd, hdr)) {
-	case PH_ERROR_EOF:
-		return "eof before pack header was fully read";
-
-	case PH_ERROR_PACK_SIGNATURE:
-		return "protocol error (pack signature mismatch detected)";
-
-	case PH_ERROR_PROTOCOL:
-		return "protocol error (pack version unsupported)";
-
-	default:
-		return "unknown error in parse_pack_header";
-
-	case 0:
-		return NULL;
-	}
-}
-
-static struct tempfile *pack_lockfile;
-
-static void push_header_arg(struct strvec *args, struct pack_header *hdr)
-{
-	strvec_pushf(args, "--pack_header=%"PRIu32",%"PRIu32,
-		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
-}
-
-static unsigned int get_unpack_limit(struct repository *repo)
-{
-	unsigned int limit = 100;
-
-	repo_config_get_uint(repo, "transfer.unpacklimit", &limit);
-	repo_config_get_uint(repo, "receive.unpacklimit", &limit);
-
-	return limit;
-}
-
-struct unpack_opts {
-	const char *fsck_msg_types;
-	const char *shallow_file;
-	off_t max_input_size;
-	int fsck_objects;
-	int reject_thin;
-	int err_fd;
-	int quiet;
-};
-
-static int unpack(struct odb_transaction *transaction, int pack_fd,
-		  struct strbuf *err_msg, const struct unpack_opts *opts)
-{
-	struct pack_header hdr;
-	const char *hdr_err;
-	int status;
-	struct child_process child = CHILD_PROCESS_INIT;
-	int err_fd = opts->err_fd;
-
-	hdr_err = parse_pack_header(&hdr, pack_fd);
-	if (hdr_err) {
-		if (err_fd > 0)
-			close(err_fd);
-		strbuf_addstr(err_msg, hdr_err);
-		return -1;
-	}
-
-	if (opts->shallow_file) {
-		strvec_push(&child.args, "--shallow-file");
-		strvec_push(&child.args, opts->shallow_file);
-	}
-
-	odb_transaction_env(transaction, &child.env);
-
-	if (ntohl(hdr.hdr_entries) < get_unpack_limit(the_repository)) {
-		strvec_push(&child.args, "unpack-objects");
-		push_header_arg(&child.args, &hdr);
-		if (opts->quiet)
-			strvec_push(&child.args, "-q");
-		if (opts->fsck_objects)
-			strvec_pushf(&child.args, "--strict%s",
-				     opts->fsck_msg_types);
-		if (opts->max_input_size)
-			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
-				     (uintmax_t)opts->max_input_size);
-		child.no_stdout = 1;
-		child.in = pack_fd;
-		child.err = err_fd;
-		child.git_cmd = 1;
-		status = run_command(&child);
-		if (status) {
-			strbuf_addstr(err_msg, "unpack-objects abnormal exit");
-			return -1;
-		}
-	} else {
-		char hostname[HOST_NAME_MAX + 1];
-		char *lockfile;
-
-		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
-		push_header_arg(&child.args, &hdr);
-
-		if (xgethostname(hostname, sizeof(hostname)))
-			xsnprintf(hostname, sizeof(hostname), "localhost");
-		strvec_pushf(&child.args,
-			     "--keep=receive-pack %"PRIuMAX" on %s",
-			     (uintmax_t)getpid(),
-			     hostname);
-
-		if (!opts->quiet && err_fd)
-			strvec_push(&child.args, "--show-resolving-progress");
-		if (err_fd)
-			strvec_push(&child.args, "--report-end-of-input");
-		if (opts->fsck_objects)
-			strvec_pushf(&child.args, "--strict%s",
-				     opts->fsck_msg_types);
-		if (!opts->reject_thin)
-			strvec_push(&child.args, "--fix-thin");
-		if (opts->max_input_size)
-			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
-				     (uintmax_t)opts->max_input_size);
-		child.out = -1;
-		child.in = pack_fd;
-		child.err = err_fd;
-		child.git_cmd = 1;
-		status = start_command(&child);
-		if (status) {
-			strbuf_addstr(err_msg, "index-pack fork failed");
-			return -1;
-		}
-
-		/*
-		 * The lockfile filepath is expected to be the final location of
-		 * the ".keep" file after being migrated to the main ODB source.
-		 * This ensures the lockfile can be found and removed later
-		 * after the ODB transaction has been committed.
-		 */
-		lockfile = index_pack_lockfile(transaction->source, child.out, NULL);
-		if (lockfile) {
-			pack_lockfile = register_tempfile(lockfile);
-			free(lockfile);
-		}
-		close(child.out);
-
-		status = finish_command(&child);
-		if (status) {
-			strbuf_addstr(err_msg, "index-pack abnormal exit");
-			return -1;
-		}
-		odb_reprepare(the_repository->objects);
-	}
-	return 0;
-}
-
 static int unpack_with_sideband(struct odb_transaction *transaction,
 				const char *shallow_file,
 				struct strbuf *err_msg)
 {
-	struct unpack_opts opts = {
+	struct odb_transaction_write_pack_opts opts = {
 		.fsck_objects = (receive_fsck_objects >= 0
 				 ? receive_fsck_objects
 				 : transfer_fsck_objects >= 0
@@ -2463,7 +2310,7 @@ static int unpack_with_sideband(struct odb_transaction *transaction,
 	int ret;
 
 	if (!use_sideband)
-		return unpack(transaction, 0, err_msg, &opts);
+		return odb_transaction_write_pack(transaction, 0, err_msg, &opts);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
@@ -2473,7 +2320,7 @@ static int unpack_with_sideband(struct odb_transaction *transaction,
 		return 0;
 
 	opts.err_fd = muxer.in;
-	ret = unpack(transaction, 0, err_msg, &opts);
+	ret = odb_transaction_write_pack(transaction, 0, err_msg, &opts);
 
 	finish_async(&muxer);
 	return ret;
@@ -2748,7 +2595,6 @@ int cmd_receive_pack(int argc,
 		execute_commands(commands, !!unpack_status.len, &si, transaction,
 				 &push_options);
 		odb_transaction_finalize(transaction);
-		delete_tempfile(&pack_lockfile);
 		sigchain_push(SIGPIPE, SIG_IGN);
 		if (report_status_v2)
 			report_v2(commands, &unpack_status);
diff --git a/object-file.c b/object-file.c
index db63587f6d..265c5f7a3c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -10,6 +10,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
+#include "config.h"
 #include "convert.h"
 #include "dir.h"
 #include "environment.h"
@@ -26,6 +27,7 @@
 #include "packfile.h"
 #include "path.h"
 #include "read-cache-ll.h"
+#include "run-command.h"
 #include "setup.h"
 #include "strvec.h"
 #include "tempfile.h"
@@ -483,11 +485,16 @@ struct transaction_packfile {
 
 struct odb_transaction_files {
 	struct odb_transaction base;
+	enum odb_transaction_flags flags;
 
 	struct tmp_objdir *objdir;
 	struct odb_source *quarantine;
 	struct transaction_packfile packfile;
 	const char *prefix;
+
+	struct tempfile **pack_lockfiles;
+	size_t pack_lockfiles_nr;
+	size_t pack_lockfiles_alloc;
 };
 
 int odb_transaction_files_prepare(struct odb_transaction *base)
@@ -1291,6 +1298,174 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 	return 0;
 }
 
+static const char *parse_pack_header(struct pack_header *hdr, int pack_fd)
+{
+	switch (read_pack_header(pack_fd, hdr)) {
+	case PH_ERROR_EOF:
+		return "eof before pack header was fully read";
+
+	case PH_ERROR_PACK_SIGNATURE:
+		return "protocol error (pack signature mismatch detected)";
+
+	case PH_ERROR_PROTOCOL:
+		return "protocol error (pack version unsupported)";
+
+	default:
+		return "unknown error in parse_pack_header";
+
+	case 0:
+		return NULL;
+	}
+}
+
+static void push_header_arg(struct strvec *args, struct pack_header *hdr)
+{
+	strvec_pushf(args, "--pack_header=%"PRIu32",%"PRIu32,
+		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
+}
+
+static unsigned int get_unpack_limit(struct repository *repo,
+				     enum odb_transaction_flags flags)
+{
+	unsigned int limit = 0;
+
+	if (flags & ODB_TRANSACTION_RECEIVE) {
+		limit = 100;
+		repo_config_get_uint(repo, "transfer.unpacklimit", &limit);
+		repo_config_get_uint(repo, "receive.unpacklimit", &limit);
+	}
+
+	return limit;
+}
+
+static int odb_transaction_files_write_pack(struct odb_transaction *base,
+					    int pack_fd, struct strbuf *err_msg,
+					    const struct odb_transaction_write_pack_opts *opts)
+{
+	struct odb_transaction_files *transaction =
+		container_of(base, struct odb_transaction_files, base);
+	struct repository *repo = base->source->odb->repo;
+	struct child_process child = CHILD_PROCESS_INIT;
+	struct pack_header hdr;
+	const char *hdr_err;
+	int err_fd = opts->err_fd;
+	int status;
+
+	hdr_err = parse_pack_header(&hdr, pack_fd);
+	if (hdr_err) {
+		if (err_fd > 0)
+			close(err_fd);
+		strbuf_addstr(err_msg, hdr_err);
+		return -1;
+	}
+
+	if (opts->shallow_file) {
+		strvec_push(&child.args, "--shallow-file");
+		strvec_push(&child.args, opts->shallow_file);
+	}
+
+	odb_transaction_env(base, &child.env);
+
+	if (ntohl(hdr.hdr_entries) < get_unpack_limit(repo, transaction->flags)) {
+		strvec_push(&child.args, "unpack-objects");
+		push_header_arg(&child.args, &hdr);
+		if (opts->quiet)
+			strvec_push(&child.args, "-q");
+		if (opts->fsck_objects)
+			strvec_pushf(&child.args, "--strict%s",
+				     opts->fsck_msg_types);
+		if (opts->max_input_size)
+			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
+				     (uintmax_t)opts->max_input_size);
+		child.no_stdout = 1;
+		child.in = pack_fd;
+		child.err = err_fd;
+		child.git_cmd = 1;
+		status = run_command(&child);
+		if (status) {
+			strbuf_addstr(err_msg, "unpack-objects abnormal exit");
+			return -1;
+		}
+	} else {
+		char hostname[HOST_NAME_MAX + 1];
+		char *lockfile;
+
+		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
+		push_header_arg(&child.args, &hdr);
+
+		if (xgethostname(hostname, sizeof(hostname)))
+			xsnprintf(hostname, sizeof(hostname), "localhost");
+		strvec_pushf(&child.args,
+			     "--keep=receive-pack %"PRIuMAX" on %s",
+			     (uintmax_t)getpid(),
+			     hostname);
+
+		if (!opts->quiet && err_fd)
+			strvec_push(&child.args, "--show-resolving-progress");
+		if (err_fd)
+			strvec_push(&child.args, "--report-end-of-input");
+		if (opts->fsck_objects)
+			strvec_pushf(&child.args, "--strict%s",
+				     opts->fsck_msg_types);
+		if (!opts->reject_thin)
+			strvec_push(&child.args, "--fix-thin");
+		if (opts->max_input_size)
+			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
+				     (uintmax_t)opts->max_input_size);
+		child.out = -1;
+		child.in = pack_fd;
+		child.err = err_fd;
+		child.git_cmd = 1;
+		status = start_command(&child);
+		if (status) {
+			strbuf_addstr(err_msg, "index-pack fork failed");
+			return -1;
+		}
+
+		/*
+		 * The lockfile filepath is expected to be the final location of
+		 * the ".keep" file after being migrated to the main ODB source.
+		 * This ensures the lockfile can be found and removed later
+		 * after the ODB transaction has been committed.
+		 */
+		lockfile = index_pack_lockfile(base->source, child.out, NULL);
+		if (lockfile) {
+			ALLOC_GROW(transaction->pack_lockfiles,
+				   transaction->pack_lockfiles_nr + 1,
+				   transaction->pack_lockfiles_alloc);
+			transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
+				register_tempfile(lockfile);
+			free(lockfile);
+		}
+		close(child.out);
+
+		status = finish_command(&child);
+		if (status) {
+			strbuf_addstr(err_msg, "index-pack abnormal exit");
+			return -1;
+		}
+
+		odb_source_prepare(transaction->quarantine,
+				   ODB_PREPARE_FLUSH_CACHES);
+	}
+
+	return 0;
+}
+
+static int odb_transaction_files_finalize(struct odb_transaction *base)
+{
+	struct odb_transaction_files *transaction =
+		container_of(base, struct odb_transaction_files, base);
+	int ret = 0;
+
+	for (size_t i = 0; i < transaction->pack_lockfiles_nr; i++)
+		ret |= delete_tempfile(&transaction->pack_lockfiles[i]);
+
+	free(transaction->pack_lockfiles);
+
+	return ret;
+}
+
 static int odb_transaction_files_env(struct odb_transaction *base,
 				     struct strvec *env)
 {
@@ -1314,8 +1489,11 @@ int odb_transaction_files_begin(struct odb_source *source,
 	transaction = xcalloc(1, sizeof(*transaction));
 	transaction->base.source = source;
 	transaction->base.commit = odb_transaction_files_commit;
+	transaction->base.finalize = odb_transaction_files_finalize;
 	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
+	transaction->base.write_pack = odb_transaction_files_write_pack;
 	transaction->base.env = odb_transaction_files_env;
+	transaction->flags = flags;
 
 	transaction->prefix = "bulk-fsync";
 	if (flags & ODB_TRANSACTION_RECEIVE) {
diff --git a/odb/transaction.c b/odb/transaction.c
index 9e9a982778..c9144e6cd6 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -59,6 +59,13 @@ int odb_transaction_write_object_stream(struct odb_transaction *transaction,
 	return transaction->write_object_stream(transaction, stream, len, oid);
 }
 
+int odb_transaction_write_pack(struct odb_transaction *transaction, int pack_fd,
+			       struct strbuf *err_msg,
+			       const struct odb_transaction_write_pack_opts *opts)
+{
+	return transaction->write_pack(transaction, pack_fd, err_msg, opts);
+}
+
 int odb_transaction_env(struct odb_transaction *transaction, struct strvec *env)
 {
 	if (!transaction)
diff --git a/odb/transaction.h b/odb/transaction.h
index 6ed39b3d0e..8cb06c1191 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -4,6 +4,50 @@
 #include "gettext.h"
 #include "odb.h"
 
+/*
+ * Options controlling how odb_transaction_write_pack() ingests a packfile.
+ */
+struct odb_transaction_write_pack_opts {
+	/*
+	 * Optional fsck severity configuration to apply when incoming objects
+	 * are verified.
+	 */
+	const char *fsck_msg_types;
+
+	/*
+	 * Path to an alternative shallow file describing the shallow boundaries
+	 * to honor while ingesting the pack.
+	 */
+	const char *shallow_file;
+
+	/*
+	 * The max size in bytes of the incoming packfile allowed. No limit is
+	 * enforced when set to 0.
+	 */
+	off_t max_input_size;
+
+	/*
+	 * Whether the validity of incoming objects should be verified.
+	 */
+	int fsck_objects;
+
+	/*
+	 * Whether to reject an incoming packfile if it is "thin".
+	 */
+	int reject_thin;
+
+	/*
+	 * Optional file descriptor for reporting progress and errors. Set to 0
+	 * for none.
+	 */
+	int err_fd;
+
+	/*
+	 * Suppresses progress reporting.
+	 */
+	int quiet;
+};
+
 /*
  * A transaction may be started for an object database prior to writing new
  * objects via odb_transaction_begin(). These objects are not committed until
@@ -40,6 +84,15 @@ struct odb_transaction {
 	int (*write_object_stream)(struct odb_transaction *transaction,
 				   struct odb_write_stream *stream, size_t len,
 				   struct object_id *oid);
+	/*
+	 * This callback is expected to ingest the packfile readable via
+	 * `pack_fd` into the transaction. Returns 0 on success, a negative
+	 * error code otherwise. On failure, a human-readable description is
+	 * appended to `err_msg`.
+	 */
+	int (*write_pack)(struct odb_transaction *transaction, int pack_fd,
+			  struct strbuf *err_msg,
+			  const struct odb_transaction_write_pack_opts *opts);
 
 	/*
 	 * This callback is expected to populate the provided strvec with the
@@ -107,6 +160,15 @@ int odb_transaction_write_object_stream(struct odb_transaction *transaction,
 					struct odb_write_stream *stream,
 					size_t len, struct object_id *oid);
 
+/*
+ * Ingests the packfile readable via `pack_fd` into the transaction. Returns 0
+ * on success, a negative error code otherwise. On failure, a human-readable
+ * description is appended to `err_msg`.
+ */
+int odb_transaction_write_pack(struct odb_transaction *transaction, int pack_fd,
+			       struct strbuf *err_msg,
+			       const struct odb_transaction_write_pack_opts *opts);
+
 /*
  * Populates the provided strvec with the environment variables that a child
  * process should inherit so that its object writes participate in the
-- 
2.55.0.424.g13c7afec21

