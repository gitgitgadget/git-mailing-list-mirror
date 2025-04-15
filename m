Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170527FD76
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709907; cv=none; b=shVuhsuhUs64uof63aKWUFmeERn+n3joAJkD5LElUNAy8F24ELodSY8ZI832hkoKTZV6J9n/rbqxfCycLJKLZ/tSit7ixplr0BTaQ7eOvZhX0SZ6DM2z0DSEmhIW0VoxS95alDevkg86IEvMnYRJNN9K5nMRdKSlg1njUTCWs3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709907; c=relaxed/simple;
	bh=bukuBgXk9WBhHS7oy8A+Slz4gptEq2q9ubUgveVl/wk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nu5n2x26LIA3teBqqrCFVhi0ffuUyGkrxjdjPUlmfty4CMZK4ceXHnIb3o7De7ZOHOIVgeMKmOB8yBZT6mZZGXSuvHyExnrhQIHXIcmwyrQM+VtSgyqGmj+28PmQ+THFJpwr02mQHWpJ6bToBSV1ewXiTvwDYH+WCsQkaXLmB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IdXLS4zl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g3Yaf1QJ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IdXLS4zl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g3Yaf1QJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D637B2540382;
	Tue, 15 Apr 2025 05:38:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 15 Apr 2025 05:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744709902;
	 x=1744796302; bh=zawWlKfsus7QzNKOi5CU8ZKHYr4ax0tCPFrgj/6wnl0=; b=
	IdXLS4zllRxBXB7GBnKB2Fii7/UEt+TQo4z1za/Oh98fUgAyRpJZ8x2QXvxTh972
	JUP3BoA6621Hpffbb0bSsTQpz/RajJRDUimkTKsjDHQomtnTN4oFYz86D+z68dmb
	/HtKgHTYkY9gPpNJ4LeMSkvgeRoYUlgebQfU8CGZlqetU/0E6JKbGJ6/o94TT8Tf
	DgX1Y3y8sc1g/QgSyPkFZmDUjpcpZhkYHMpFv/2+Nh8cEY2uljByxau2ORXtW9FA
	d2iby23DT8xLU4bpFyWBt487sx2JJj6dxkrlnyTl+5ow8ukXs5Hjv6Nedmk9Vcbp
	l9K2gOrQigFnkQLAllmqcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744709902; x=
	1744796302; bh=zawWlKfsus7QzNKOi5CU8ZKHYr4ax0tCPFrgj/6wnl0=; b=g
	3Yaf1QJ5aEMFxrrLomjO8RAfzuXtzipk+zey8xQUPOYNjRbZ9NNsfiilczRP/wcy
	hjREbTmAesi5Er9xbOZDo11VcRdy92IQS4/HEwKUxJ2RFoPa+Vs8HWhvLSZZ6FIf
	smas6MowGh+RdxX978Z4b5BJmy3YiIW/6igeM3tlpmaEzy408bhw+f0G72wQtFu1
	mD9INEXr1t3oJinCdAQ5qFfAepBIYe7qlnlAy1Fcp3xYjigd5SW/7q7iwKt6XUCN
	BR+wskSvzXdiYghz7iJ1OEx6BvSOS77HT/XPE18tLG14fAc50Rw+Yd8Kv7L+4F/l
	T2KvxsUC66d7JoEQpM56w==
X-ME-Sender: <xms:Din-Zw_jb5fZw5Tsxj_NNToNhDMR5L25yvJbwAWazNqjWmYvQEBsWQ>
    <xme:Din-Z4tDbZwLgilccTdidLShllgVYlCRgMfFu1KXHQZLG3tvD7ZLkL032kvcUYh1f
    loSsMOOpKsHjTXnLA>
X-ME-Received: <xmr:Din-Z2D8uIrx7K8TdYuViWEC4QhdVD58Rt3nzmpTZT_SSimIgyEnmaGcPqqqBgpYldqibCUf7mLhEdhdOVIhNYjZu3D7XS5tM4B_upKRQ2P1Jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:Din-Zwch5XDFOkBS75w94HKwjhz2Z3M7LA2Ve2lZkMLb0XMAQRn0eg>
    <xmx:Din-Z1Me862rMJNB_JdefnA85Wu7JmRI8AFVJr0aRE4KjZIoa5McnQ>
    <xmx:Din-Z6kXLe1Iu0_9hrrZ1ty018WCYhUNeovYxs5VPa_UpyUDvdIXjg>
    <xmx:Din-Z3t63k9HCKu2WSQUqd1lLrM61dBObPWvd6Z9rvex6xIa0yPRpA>
    <xmx:Din-Z_1s_a7hV9aLDnmL3QkMP7es88FMRTfQEtsuY2sbPs2_di6EYaQY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:38:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4e0f74cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:38:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Apr 2025 11:38:15 +0200
Subject: [PATCH v3 02/10] object-file: move
 `safe_create_leading_directories()` into "path.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-pks-split-object-file-v3-2-6aa7db7ad7b0@pks.im>
References: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
In-Reply-To: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `safe_create_leading_directories()` function and its relatives are
located in "object-file.c", which is not a good fit as they provide
generic functionality not related to objects at all. Move them into
"path.c", which already hosts `safe_create_dir()` and its relative
`safe_create_dir_in_gitdir()`.

"path.c" is free of `the_repository`, but the moved functions depend on
`the_repository` to read the "core.sharedRepository" config. Adapt the
function signature to accept a repository as argument to fix the issue
and adjust callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/bugreport.c                |  4 +-
 builtin/clone.c                    |  4 +-
 builtin/credential-cache--daemon.c |  4 +-
 builtin/diagnose.c                 |  4 +-
 builtin/difftool.c                 | 29 ++++++++------
 builtin/fast-import.c              |  2 +-
 builtin/fsck.c                     |  2 +-
 builtin/gc.c                       |  7 ++--
 builtin/init-db.c                  |  3 +-
 builtin/log.c                      |  4 +-
 builtin/mv.c                       |  3 +-
 builtin/sparse-checkout.c          |  5 ++-
 builtin/submodule--helper.c        |  4 +-
 builtin/worktree.c                 |  8 ++--
 commit-graph.c                     |  2 +-
 dir.c                              |  5 +--
 merge-recursive.c                  |  4 +-
 midx-write.c                       |  2 +-
 notes-merge.c                      |  4 +-
 object-file.c                      | 81 +-------------------------------------
 object-file.h                      | 33 ----------------
 path.c                             | 80 +++++++++++++++++++++++++++++++++++++
 path.h                             | 34 ++++++++++++++++
 refs/files-backend.c               |  4 +-
 sequencer.c                        |  4 +-
 server-info.c                      |  2 +-
 submodule.c                        |  2 +-
 27 files changed, 173 insertions(+), 167 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 66d64bfd5ae..f78c3f2aed6 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -4,13 +4,13 @@
 #include "editor.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "path.h"
 #include "strbuf.h"
 #include "help.h"
 #include "compat/compiler.h"
 #include "hook.h"
 #include "hook-list.h"
 #include "diagnose.h"
-#include "object-file.h"
 #include "setup.h"
 #include "version.h"
 
@@ -141,7 +141,7 @@ int cmd_bugreport(int argc,
 	}
 	strbuf_addstr(&report_path, ".txt");
 
-	switch (safe_create_leading_directories(report_path.buf)) {
+	switch (safe_create_leading_directories(the_repository, report_path.buf)) {
 	case SCLD_OK:
 	case SCLD_EXISTS:
 		break;
diff --git a/builtin/clone.c b/builtin/clone.c
index 2993acb630e..31f2198c1b3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1090,7 +1090,7 @@ int cmd_clone(int argc,
 	sigchain_push_common(remove_junk_on_signal);
 
 	if (!option_bare) {
-		if (safe_create_leading_directories_const(work_tree) < 0)
+		if (safe_create_leading_directories_const(the_repository, work_tree) < 0)
 			die_errno(_("could not create leading directories of '%s'"),
 				  work_tree);
 		if (dest_exists)
@@ -1111,7 +1111,7 @@ int cmd_clone(int argc,
 			junk_git_dir_flags |= REMOVE_DIR_KEEP_TOPLEVEL;
 		junk_git_dir = git_dir;
 	}
-	if (safe_create_leading_directories_const(git_dir) < 0)
+	if (safe_create_leading_directories_const(the_repository, git_dir) < 0)
 		die(_("could not create leading directories of '%s'"), git_dir);
 
 	if (0 <= option_verbosity) {
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index e707618e743..5065ff4660b 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -2,8 +2,8 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "gettext.h"
-#include "object-file.h"
 #include "parse-options.h"
+#include "path.h"
 
 #ifndef NO_UNIX_SOCKETS
 
@@ -271,7 +271,7 @@ static void init_socket_directory(const char *path)
 		 * condition in which somebody can chdir to it, sleep, then try to open
 		 * our protected socket.
 		 */
-		if (safe_create_leading_directories_const(dir) < 0)
+		if (safe_create_leading_directories_const(the_repository, dir) < 0)
 			die_errno("unable to create directories for '%s'", dir);
 		if (mkdir(dir, 0700) < 0)
 			die_errno("unable to mkdir '%s'", dir);
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index 33c39bd5981..ec86d66389e 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -3,8 +3,8 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "gettext.h"
-#include "object-file.h"
 #include "parse-options.h"
+#include "path.h"
 #include "diagnose.h"
 
 static const char * const diagnose_usage[] = {
@@ -50,7 +50,7 @@ int cmd_diagnose(int argc,
 	strbuf_addftime(&zip_path, option_suffix, localtime_r(&now, &tm), 0, 0);
 	strbuf_addstr(&zip_path, ".zip");
 
-	switch (safe_create_leading_directories(zip_path.buf)) {
+	switch (safe_create_leading_directories(the_repository, zip_path.buf)) {
 	case SCLD_OK:
 	case SCLD_EXISTS:
 		break;
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 41cd00066cc..8292aedaaf0 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -22,6 +22,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
+#include "path.h"
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "sparse-index.h"
@@ -271,9 +272,9 @@ static void changed_files(struct repository *repo,
 	strbuf_release(&buf);
 }
 
-static int ensure_leading_directories(char *path)
+static int ensure_leading_directories(struct repository *repo, char *path)
 {
-	switch (safe_create_leading_directories(path)) {
+	switch (safe_create_leading_directories(repo, path)) {
 		case SCLD_OK:
 		case SCLD_EXISTS:
 			return 0;
@@ -341,11 +342,12 @@ static int checkout_path(unsigned mode, struct object_id *oid,
 	return ret;
 }
 
-static void write_file_in_directory(struct strbuf *dir, size_t dir_len,
-			const char *path, const char *content)
+static void write_file_in_directory(struct repository *repo,
+				    struct strbuf *dir, size_t dir_len,
+				    const char *path, const char *content)
 {
 	add_path(dir, dir_len, path);
-	ensure_leading_directories(dir->buf);
+	ensure_leading_directories(repo, dir->buf);
 	unlink(dir->buf);
 	write_file(dir->buf, "%s", content);
 }
@@ -356,14 +358,15 @@ static void write_file_in_directory(struct strbuf *dir, size_t dir_len,
  * as text files, resulting in behavior that is analogous to what "git diff"
  * displays for symlink and submodule diffs.
  */
-static void write_standin_files(struct pair_entry *entry,
-			struct strbuf *ldir, size_t ldir_len,
-			struct strbuf *rdir, size_t rdir_len)
+static void write_standin_files(struct repository *repo,
+				struct pair_entry *entry,
+				struct strbuf *ldir, size_t ldir_len,
+				struct strbuf *rdir, size_t rdir_len)
 {
 	if (*entry->left)
-		write_file_in_directory(ldir, ldir_len, entry->path, entry->left);
+		write_file_in_directory(repo, ldir, ldir_len, entry->path, entry->left);
 	if (*entry->right)
-		write_file_in_directory(rdir, rdir_len, entry->path, entry->right);
+		write_file_in_directory(repo, rdir, rdir_len, entry->path, entry->right);
 }
 
 static int run_dir_diff(struct repository *repo,
@@ -533,7 +536,7 @@ static int run_dir_diff(struct repository *repo,
 						ADD_CACHE_JUST_APPEND);
 
 				add_path(&rdir, rdir_len, dst_path);
-				if (ensure_leading_directories(rdir.buf)) {
+				if (ensure_leading_directories(repo, rdir.buf)) {
 					ret = error("could not create "
 						    "directory for '%s'",
 						    dst_path);
@@ -576,7 +579,7 @@ static int run_dir_diff(struct repository *repo,
 	 */
 	hashmap_for_each_entry(&submodules, &iter, entry,
 				entry /* member name */) {
-		write_standin_files(entry, &ldir, ldir_len, &rdir, rdir_len);
+		write_standin_files(repo, entry, &ldir, ldir_len, &rdir, rdir_len);
 	}
 
 	/*
@@ -587,7 +590,7 @@ static int run_dir_diff(struct repository *repo,
 	hashmap_for_each_entry(&symlinks2, &iter, entry,
 				entry /* member name */) {
 
-		write_standin_files(entry, &ldir, ldir_len, &rdir, rdir_len);
+		write_standin_files(repo, entry, &ldir, ldir_len, &rdir, rdir_len);
 	}
 
 	strbuf_setlen(&ldir, ldir_len);
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 63880b595cc..e4523cc6f1b 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1720,7 +1720,7 @@ static void dump_marks(void)
 	if (!export_marks_file || (import_marks_file && !import_marks_file_done))
 		return;
 
-	if (safe_create_leading_directories_const(export_marks_file)) {
+	if (safe_create_leading_directories_const(the_repository, export_marks_file)) {
 		failure |= error_errno("unable to create leading directories of %s",
 				       export_marks_file);
 		return;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9c8a6d6a8df..92312b59591 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -332,7 +332,7 @@ static void check_unreachable_object(struct object *obj)
 				describe_object(&obj->oid));
 			FILE *f;
 
-			if (safe_create_leading_directories_const(filename)) {
+			if (safe_create_leading_directories_const(the_repository, filename)) {
 				error(_("could not create lost-found"));
 				free(filename);
 				return;
diff --git a/builtin/gc.c b/builtin/gc.c
index 99431fd4674..dae1e545514 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -28,7 +28,6 @@
 #include "commit.h"
 #include "commit-graph.h"
 #include "packfile.h"
-#include "object-file.h"
 #include "object-store-ll.h"
 #include "pack.h"
 #include "pack-objects.h"
@@ -2099,7 +2098,7 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 	}
 	strbuf_addstr(&plist, "</array>\n</dict>\n</plist>\n");
 
-	if (safe_create_leading_directories(filename))
+	if (safe_create_leading_directories(the_repository, filename))
 		die(_("failed to create directories for '%s'"), filename);
 
 	if ((long)lock_file_timeout_ms < 0 &&
@@ -2565,7 +2564,7 @@ static int systemd_timer_write_timer_file(enum schedule_priority schedule,
 
 	filename = xdg_config_home_systemd(local_timer_name);
 
-	if (safe_create_leading_directories(filename)) {
+	if (safe_create_leading_directories(the_repository, filename)) {
 		error(_("failed to create directories for '%s'"), filename);
 		goto error;
 	}
@@ -2638,7 +2637,7 @@ static int systemd_timer_write_service_template(const char *exec_path)
 	char *local_service_name = xstrfmt(SYSTEMD_UNIT_FORMAT, "", "service");
 
 	filename = xdg_config_home_systemd(local_service_name);
-	if (safe_create_leading_directories(filename)) {
+	if (safe_create_leading_directories(the_repository, filename)) {
 		error(_("failed to create directories for '%s'"), filename);
 		goto error;
 	}
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 196dccdd77a..91c2563e341 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -8,7 +8,6 @@
 #include "abspath.h"
 #include "environment.h"
 #include "gettext.h"
-#include "object-file.h"
 #include "parse-options.h"
 #include "path.h"
 #include "refs.h"
@@ -134,7 +133,7 @@ int cmd_init_db(int argc,
 				 */
 				saved = repo_settings_get_shared_repository(the_repository);
 				repo_settings_set_shared_repository(the_repository, 0);
-				switch (safe_create_leading_directories_const(argv[0])) {
+				switch (safe_create_leading_directories_const(the_repository, argv[0])) {
 				case SCLD_OK:
 				case SCLD_PERMS:
 					break;
diff --git a/builtin/log.c b/builtin/log.c
index 0d4c579dad7..516c9ec8400 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -14,7 +14,6 @@
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
-#include "object-file.h"
 #include "object-name.h"
 #include "object-store-ll.h"
 #include "pager.h"
@@ -29,6 +28,7 @@
 #include "tag.h"
 #include "reflog-walk.h"
 #include "patch-ids.h"
+#include "path.h"
 #include "shortlog.h"
 #include "remote.h"
 #include "string-list.h"
@@ -2311,7 +2311,7 @@ int cmd_format_patch(int argc,
 		 */
 		saved = repo_settings_get_shared_repository(the_repository);
 		repo_settings_set_shared_repository(the_repository, 0);
-		switch (safe_create_leading_directories_const(output_directory)) {
+		switch (safe_create_leading_directories_const(the_repository, output_directory)) {
 		case SCLD_OK:
 		case SCLD_EXISTS:
 			break;
diff --git a/builtin/mv.c b/builtin/mv.c
index 55a7d471dca..99fe7a0c561 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -15,6 +15,7 @@
 #include "gettext.h"
 #include "name-hash.h"
 #include "object-file.h"
+#include "path.h"
 #include "pathspec.h"
 #include "lockfile.h"
 #include "dir.h"
@@ -555,7 +556,7 @@ int cmd_mv(int argc,
 					 */
 					char *dst_dup = xstrdup(dst);
 					string_list_append(&dirty_paths, dst);
-					safe_create_leading_directories(dst_dup);
+					safe_create_leading_directories(the_repository, dst_dup);
 					FREE_AND_NULL(dst_dup);
 					rename(src, dst);
 				}
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 14dcace5f8f..1bf01591b27 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -9,6 +9,7 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "parse-options.h"
+#include "path.h"
 #include "pathspec.h"
 #include "strbuf.h"
 #include "string-list.h"
@@ -335,7 +336,7 @@ static int write_patterns_and_update(struct pattern_list *pl)
 
 	sparse_filename = get_sparse_checkout_filename();
 
-	if (safe_create_leading_directories(sparse_filename))
+	if (safe_create_leading_directories(the_repository, sparse_filename))
 		die(_("failed to create directory for sparse-checkout file"));
 
 	hold_lock_file_for_update(&lk, sparse_filename, LOCK_DIE_ON_ERROR);
@@ -491,7 +492,7 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix,
 		FILE *fp;
 
 		/* assume we are in a fresh repo, but update the sparse-checkout file */
-		if (safe_create_leading_directories(sparse_filename))
+		if (safe_create_leading_directories(the_repository, sparse_filename))
 			die(_("unable to create leading directories of %s"),
 			    sparse_filename);
 		fp = xfopen(sparse_filename, "w");
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 570226ea166..cc001d0b4cd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1739,7 +1739,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		    !is_empty_dir(clone_data_path))
 			die(_("directory not empty: '%s'"), clone_data_path);
 
-		if (safe_create_leading_directories_const(sm_gitdir) < 0)
+		if (safe_create_leading_directories_const(the_repository, sm_gitdir) < 0)
 			die(_("could not create directory '%s'"), sm_gitdir);
 
 		prepare_possible_alternates(clone_data->name, reference);
@@ -1800,7 +1800,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		if (clone_data->require_init && !stat(clone_data_path, &st) &&
 		    !is_empty_dir(clone_data_path))
 			die(_("directory not empty: '%s'"), clone_data_path);
-		if (safe_create_leading_directories_const(clone_data_path) < 0)
+		if (safe_create_leading_directories_const(the_repository, clone_data_path) < 0)
 			die(_("could not create directory '%s'"), clone_data_path);
 		path = xstrfmt("%s/index", sm_gitdir);
 		unlink_or_warn(path);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 87ccd47794c..88a36ea9f86 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -348,7 +348,7 @@ static void copy_sparse_checkout(const char *worktree_git_dir)
 	char *to_file = xstrfmt("%s/info/sparse-checkout", worktree_git_dir);
 
 	if (file_exists(from_file)) {
-		if (safe_create_leading_directories(to_file) ||
+		if (safe_create_leading_directories(the_repository, to_file) ||
 			copy_file(to_file, from_file, 0666))
 			error(_("failed to copy '%s' to '%s'; sparse-checkout may not work correctly"),
 				from_file, to_file);
@@ -367,7 +367,7 @@ static void copy_filtered_worktree_config(const char *worktree_git_dir)
 		struct config_set cs = { { 0 } };
 		int bare;
 
-		if (safe_create_leading_directories(to_file) ||
+		if (safe_create_leading_directories(the_repository, to_file) ||
 			copy_file(to_file, from_file, 0666)) {
 			error(_("failed to copy worktree config from '%s' to '%s'"),
 				from_file, to_file);
@@ -466,7 +466,7 @@ static int add_worktree(const char *path, const char *refname,
 	name = sb_name.buf;
 	repo_git_path_replace(the_repository, &sb_repo, "worktrees/%s", name);
 	len = sb_repo.len;
-	if (safe_create_leading_directories_const(sb_repo.buf))
+	if (safe_create_leading_directories_const(the_repository, sb_repo.buf))
 		die_errno(_("could not create leading directories of '%s'"),
 			  sb_repo.buf);
 
@@ -498,7 +498,7 @@ static int add_worktree(const char *path, const char *refname,
 		write_file(sb.buf, _("initializing"));
 
 	strbuf_addf(&sb_git, "%s/.git", path);
-	if (safe_create_leading_directories_const(sb_git.buf))
+	if (safe_create_leading_directories_const(the_repository, sb_git.buf))
 		die_errno(_("could not create leading directories of '%s'"),
 			  sb_git.buf);
 	junk_work_tree = xstrdup(path);
diff --git a/commit-graph.c b/commit-graph.c
index 8286d5dda24..3b5bae00af9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2065,7 +2065,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		ctx->graph_name = get_commit_graph_filename(ctx->odb);
 	}
 
-	if (safe_create_leading_directories(ctx->graph_name)) {
+	if (safe_create_leading_directories(the_repository, ctx->graph_name)) {
 		error(_("unable to create leading directories of %s"),
 			ctx->graph_name);
 		return -1;
diff --git a/dir.c b/dir.c
index 28b0e03feb4..49008739b9b 100644
--- a/dir.c
+++ b/dir.c
@@ -17,7 +17,6 @@
 #include "environment.h"
 #include "gettext.h"
 #include "name-hash.h"
-#include "object-file.h"
 #include "object-store-ll.h"
 #include "path.h"
 #include "refs.h"
@@ -4063,12 +4062,12 @@ void connect_work_tree_and_git_dir(const char *work_tree_,
 
 	/* Prepare .git file */
 	strbuf_addf(&gitfile_sb, "%s/.git", work_tree_);
-	if (safe_create_leading_directories_const(gitfile_sb.buf))
+	if (safe_create_leading_directories_const(the_repository, gitfile_sb.buf))
 		die(_("could not create directories for %s"), gitfile_sb.buf);
 
 	/* Prepare config file */
 	strbuf_addf(&cfg_sb, "%s/config", git_dir_);
-	if (safe_create_leading_directories_const(cfg_sb.buf))
+	if (safe_create_leading_directories_const(the_repository, cfg_sb.buf))
 		die(_("could not create directories for %s"), cfg_sb.buf);
 
 	git_dir = real_pathdup(git_dir_, 1);
diff --git a/merge-recursive.c b/merge-recursive.c
index 9aedffc546b..f71490517e1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -910,7 +910,7 @@ static int make_room_for_path(struct merge_options *opt, const char *path)
 	}
 
 	/* Make sure leading directories are created */
-	status = safe_create_leading_directories_const(path);
+	status = safe_create_leading_directories_const(the_repository, path);
 	if (status) {
 		if (status == SCLD_EXISTS)
 			/* something else exists */
@@ -1003,7 +1003,7 @@ static int update_file_flags(struct merge_options *opt,
 			close(fd);
 		} else if (S_ISLNK(contents->mode)) {
 			char *lnk = xmemdupz(buf, size);
-			safe_create_leading_directories_const(path);
+			safe_create_leading_directories_const(the_repository, path);
 			unlink(path);
 			if (symlink(lnk, path))
 				ret = err(opt, _("failed to symlink '%s': %s"),
diff --git a/midx-write.c b/midx-write.c
index a628ac24dcb..fbba55f9d92 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1086,7 +1086,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			    object_dir);
 	else
 		get_midx_filename(r->hash_algo, &midx_name, object_dir);
-	if (safe_create_leading_directories(midx_name.buf))
+	if (safe_create_leading_directories(r, midx_name.buf))
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name.buf);
 
diff --git a/notes-merge.c b/notes-merge.c
index 5008faef450..fce45043655 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -296,7 +296,7 @@ static void check_notes_merge_worktree(struct notes_merge_options *o)
 				    "(%s exists)."), repo_git_path_replace(the_repository, &buf, "NOTES_MERGE_*"));
 		}
 
-		if (safe_create_leading_directories_const(repo_git_path_replace(the_repository, &buf,
+		if (safe_create_leading_directories_const(the_repository, repo_git_path_replace(the_repository, &buf,
 				NOTES_MERGE_WORKTREE "/.test")))
 			die_errno("unable to create directory %s",
 				  repo_git_path_replace(the_repository, &buf, NOTES_MERGE_WORKTREE));
@@ -314,7 +314,7 @@ static void write_buf_to_worktree(const struct object_id *obj,
 {
 	int fd;
 	char *path = repo_git_path(the_repository, NOTES_MERGE_WORKTREE "/%s", oid_to_hex(obj));
-	if (safe_create_leading_directories_const(path))
+	if (safe_create_leading_directories_const(the_repository, path))
 		die_errno("unable to create directory for '%s'", path);
 
 	fd = xopen(path, O_WRONLY | O_EXCL | O_CREAT, 0666);
diff --git a/object-file.c b/object-file.c
index 00451876bd0..6228e1c40f8 100644
--- a/object-file.c
+++ b/object-file.c
@@ -90,83 +90,6 @@ static int get_conv_flags(unsigned flags)
 		return 0;
 }
 
-static enum scld_error safe_create_leading_directories_1(char *path, int share)
-{
-	char *next_component = path + offset_1st_component(path);
-	enum scld_error ret = SCLD_OK;
-
-	while (ret == SCLD_OK && next_component) {
-		struct stat st;
-		char *slash = next_component, slash_character;
-
-		while (*slash && !is_dir_sep(*slash))
-			slash++;
-
-		if (!*slash)
-			break;
-
-		next_component = slash + 1;
-		while (is_dir_sep(*next_component))
-			next_component++;
-		if (!*next_component)
-			break;
-
-		slash_character = *slash;
-		*slash = '\0';
-		if (!stat(path, &st)) {
-			/* path exists */
-			if (!S_ISDIR(st.st_mode)) {
-				errno = ENOTDIR;
-				ret = SCLD_EXISTS;
-			}
-		} else if (mkdir(path, 0777)) {
-			if (errno == EEXIST &&
-			    !stat(path, &st) && S_ISDIR(st.st_mode))
-				; /* somebody created it since we checked */
-			else if (errno == ENOENT)
-				/*
-				 * Either mkdir() failed because
-				 * somebody just pruned the containing
-				 * directory, or stat() failed because
-				 * the file that was in our way was
-				 * just removed.  Either way, inform
-				 * the caller that it might be worth
-				 * trying again:
-				 */
-				ret = SCLD_VANISHED;
-			else
-				ret = SCLD_FAILED;
-		} else if (share && adjust_shared_perm(the_repository, path)) {
-			ret = SCLD_PERMS;
-		}
-		*slash = slash_character;
-	}
-	return ret;
-}
-
-enum scld_error safe_create_leading_directories(char *path)
-{
-	return safe_create_leading_directories_1(path, 1);
-}
-
-enum scld_error safe_create_leading_directories_no_share(char *path)
-{
-	return safe_create_leading_directories_1(path, 0);
-}
-
-enum scld_error safe_create_leading_directories_const(const char *path)
-{
-	int save_errno;
-	/* path points to cache entries, so xstrdup before messing with it */
-	char *buf = xstrdup(path);
-	enum scld_error result = safe_create_leading_directories(buf);
-
-	save_errno = errno;
-	free(buf);
-	errno = save_errno;
-	return result;
-}
-
 int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
 {
 	int fd;
@@ -183,7 +106,7 @@ int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
 	/* slow path */
 	/* some mkstemp implementations erase temp_filename on failure */
 	repo_git_path_replace(the_repository, temp_filename, "objects/%s", pattern);
-	safe_create_leading_directories(temp_filename->buf);
+	safe_create_leading_directories(the_repository, temp_filename->buf);
 	return xmkstemp_mode(temp_filename->buf, mode);
 }
 
@@ -196,7 +119,7 @@ int odb_pack_keep(const char *name)
 		return fd;
 
 	/* slow path */
-	safe_create_leading_directories_const(name);
+	safe_create_leading_directories_const(the_repository, name);
 	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 }
 
diff --git a/object-file.h b/object-file.h
index 4649a3f37d4..922f2bba8c9 100644
--- a/object-file.h
+++ b/object-file.h
@@ -21,39 +21,6 @@ extern int fetch_if_missing;
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
-/*
- * Create the directory containing the named path, using care to be
- * somewhat safe against races. Return one of the scld_error values to
- * indicate success/failure. On error, set errno to describe the
- * problem.
- *
- * SCLD_VANISHED indicates that one of the ancestor directories of the
- * path existed at one point during the function call and then
- * suddenly vanished, probably because another process pruned the
- * directory while we were working.  To be robust against this kind of
- * race, callers might want to try invoking the function again when it
- * returns SCLD_VANISHED.
- *
- * safe_create_leading_directories() temporarily changes path while it
- * is working but restores it before returning.
- * safe_create_leading_directories_const() doesn't modify path, even
- * temporarily. Both these variants adjust the permissions of the
- * created directories to honor core.sharedRepository, so they are best
- * suited for files inside the git dir. For working tree files, use
- * safe_create_leading_directories_no_share() instead, as it ignores
- * the core.sharedRepository setting.
- */
-enum scld_error {
-	SCLD_OK = 0,
-	SCLD_FAILED = -1,
-	SCLD_PERMS = -2,
-	SCLD_EXISTS = -3,
-	SCLD_VANISHED = -4
-};
-enum scld_error safe_create_leading_directories(char *path);
-enum scld_error safe_create_leading_directories_const(const char *path);
-enum scld_error safe_create_leading_directories_no_share(char *path);
-
 int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
 
diff --git a/path.c b/path.c
index c688f874580..62d67166dff 100644
--- a/path.c
+++ b/path.c
@@ -931,6 +931,86 @@ int safe_create_dir_in_gitdir(struct repository *repo, const char *path)
 	return adjust_shared_perm(repo, path);
 }
 
+static enum scld_error safe_create_leading_directories_1(struct repository *repo,
+							 char *path)
+{
+	char *next_component = path + offset_1st_component(path);
+	enum scld_error ret = SCLD_OK;
+
+	while (ret == SCLD_OK && next_component) {
+		struct stat st;
+		char *slash = next_component, slash_character;
+
+		while (*slash && !is_dir_sep(*slash))
+			slash++;
+
+		if (!*slash)
+			break;
+
+		next_component = slash + 1;
+		while (is_dir_sep(*next_component))
+			next_component++;
+		if (!*next_component)
+			break;
+
+		slash_character = *slash;
+		*slash = '\0';
+		if (!stat(path, &st)) {
+			/* path exists */
+			if (!S_ISDIR(st.st_mode)) {
+				errno = ENOTDIR;
+				ret = SCLD_EXISTS;
+			}
+		} else if (mkdir(path, 0777)) {
+			if (errno == EEXIST &&
+			    !stat(path, &st) && S_ISDIR(st.st_mode))
+				; /* somebody created it since we checked */
+			else if (errno == ENOENT)
+				/*
+				 * Either mkdir() failed because
+				 * somebody just pruned the containing
+				 * directory, or stat() failed because
+				 * the file that was in our way was
+				 * just removed.  Either way, inform
+				 * the caller that it might be worth
+				 * trying again:
+				 */
+				ret = SCLD_VANISHED;
+			else
+				ret = SCLD_FAILED;
+		} else if (repo && adjust_shared_perm(repo, path)) {
+			ret = SCLD_PERMS;
+		}
+		*slash = slash_character;
+	}
+	return ret;
+}
+
+enum scld_error safe_create_leading_directories(struct repository *repo,
+						char *path)
+{
+	return safe_create_leading_directories_1(repo, path);
+}
+
+enum scld_error safe_create_leading_directories_no_share(char *path)
+{
+	return safe_create_leading_directories_1(NULL, path);
+}
+
+enum scld_error safe_create_leading_directories_const(struct repository *repo,
+						      const char *path)
+{
+	int save_errno;
+	/* path points to cache entries, so xstrdup before messing with it */
+	char *buf = xstrdup(path);
+	enum scld_error result = safe_create_leading_directories(repo, buf);
+
+	save_errno = errno;
+	free(buf);
+	errno = save_errno;
+	return result;
+}
+
 static int have_same_root(const char *path1, const char *path2)
 {
 	int is_abs1, is_abs2;
diff --git a/path.h b/path.h
index a427516d818..fd1a194b060 100644
--- a/path.h
+++ b/path.h
@@ -232,6 +232,40 @@ void safe_create_dir(struct repository *repo, const char *dir, int share);
  */
 int safe_create_dir_in_gitdir(struct repository *repo, const char *path);
 
+/*
+ * Create the directory containing the named path, using care to be
+ * somewhat safe against races. Return one of the scld_error values to
+ * indicate success/failure. On error, set errno to describe the
+ * problem.
+ *
+ * SCLD_VANISHED indicates that one of the ancestor directories of the
+ * path existed at one point during the function call and then
+ * suddenly vanished, probably because another process pruned the
+ * directory while we were working.  To be robust against this kind of
+ * race, callers might want to try invoking the function again when it
+ * returns SCLD_VANISHED.
+ *
+ * safe_create_leading_directories() temporarily changes path while it
+ * is working but restores it before returning.
+ * safe_create_leading_directories_const() doesn't modify path, even
+ * temporarily. Both these variants adjust the permissions of the
+ * created directories to honor core.sharedRepository, so they are best
+ * suited for files inside the git dir. For working tree files, use
+ * safe_create_leading_directories_no_share() instead, as it ignores
+ * the core.sharedRepository setting.
+ */
+enum scld_error {
+	SCLD_OK = 0,
+	SCLD_FAILED = -1,
+	SCLD_PERMS = -2,
+	SCLD_EXISTS = -3,
+	SCLD_VANISHED = -4
+};
+enum scld_error safe_create_leading_directories(struct repository *repo, char *path);
+enum scld_error safe_create_leading_directories_const(struct repository *repo,
+						      const char *path);
+enum scld_error safe_create_leading_directories_no_share(char *path);
+
 # ifdef USE_THE_REPOSITORY_VARIABLE
 #  include "strbuf.h"
 #  include "repository.h"
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 91d3aca70a7..10c439a56f8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -705,7 +705,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	files_ref_path(refs, &ref_file, refname);
 
 retry:
-	switch (safe_create_leading_directories(ref_file.buf)) {
+	switch (safe_create_leading_directories(the_repository, ref_file.buf)) {
 	case SCLD_OK:
 		break; /* success */
 	case SCLD_EXISTS:
@@ -1109,7 +1109,7 @@ static int raceproof_create_file(const char *path, create_file_fn fn, void *cb)
 			strbuf_addstr(&path_copy, path);
 
 		do {
-			scld_result = safe_create_leading_directories(path_copy.buf);
+			scld_result = safe_create_leading_directories(the_repository, path_copy.buf);
 			if (scld_result == SCLD_OK)
 				goto retry_fn;
 		} while (scld_result == SCLD_VANISHED && create_directories_remaining-- > 0);
diff --git a/sequencer.c b/sequencer.c
index c112d2e1c43..9fda9be9266 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4411,7 +4411,7 @@ static int write_update_refs_state(struct string_list *refs_to_oids)
 		goto cleanup;
 	}
 
-	if (safe_create_leading_directories(path)) {
+	if (safe_create_leading_directories(the_repository, path)) {
 		result = error(_("unable to create leading directories of %s"),
 			       path);
 		goto cleanup;
@@ -4677,7 +4677,7 @@ static void create_autostash_internal(struct repository *r,
 		strbuf_add_unique_abbrev(&buf, &oid, DEFAULT_ABBREV);
 
 		if (path) {
-			if (safe_create_leading_directories_const(path))
+			if (safe_create_leading_directories_const(the_repository, path))
 				die(_("Could not create directory for '%s'"),
 				    path);
 			write_file(path, "%s", oid_to_hex(&oid));
diff --git a/server-info.c b/server-info.c
index 1ca0e00d51e..f0646ac92a9 100644
--- a/server-info.c
+++ b/server-info.c
@@ -88,7 +88,7 @@ static int update_info_file(struct repository *r, char *path,
 		.old_sb = STRBUF_INIT
 	};
 
-	safe_create_leading_directories(path);
+	safe_create_leading_directories(r, path);
 	f = mks_tempfile_m(tmp, 0666);
 	if (!f)
 		goto out;
diff --git a/submodule.c b/submodule.c
index 0821507ecaa..218c8c17603 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2384,7 +2384,7 @@ static void relocate_single_git_dir_into_superproject(const char *path,
 	if (validate_submodule_git_dir(new_gitdir.buf, sub->name) < 0)
 		die(_("refusing to move '%s' into an existing git dir"),
 		    real_old_git_dir);
-	if (safe_create_leading_directories_const(new_gitdir.buf) < 0)
+	if (safe_create_leading_directories_const(the_repository, new_gitdir.buf) < 0)
 		die(_("could not create directory '%s'"), new_gitdir.buf);
 	real_new_git_dir = real_pathdup(new_gitdir.buf, 1);
 

-- 
2.49.0.805.g082f7c87e0.dirty

