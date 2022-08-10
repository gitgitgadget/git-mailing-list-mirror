Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F6AC25B06
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 23:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiHJXe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 19:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbiHJXep (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 19:34:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265C881B32
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v5so8647664wmj.0
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=0LEvMAnYM0Z5oCfQYNqyjgrBUeMv0eo6t4oWVAQ3ml4=;
        b=iFu7Fzdrh+H5obf76GbA9aDlE8BiOw/Djb+LKM21GuHzWROShuxSlWbiXn3FVB/acO
         nY10f83jp9Wh+oCslcZwcjgfTqtElN0RrtUS0s259T/sZinY2UJIMR4BlPF+4g2sdMAk
         14DooDJTnjSSrcAuGrqTV5+PhuTzWSpaeTOewvKRpmmDHGxw3Sbul/QaZX797WGihCrx
         PFxxGOd8pDlZgr26sLFmJQQcBTbGJuFrPC+MlExNzmqFlACZBJGozJUE1kwTHW29DZ97
         NqvAPcTG7U4yw6/cJQkVVqvNqCdx9hpIyHqvvXlNMVKe0EY6wAhI/Vht6sa+Ywk7nFlm
         O7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=0LEvMAnYM0Z5oCfQYNqyjgrBUeMv0eo6t4oWVAQ3ml4=;
        b=cWH+p3qNJio8Aw2F5lhmN0SkwBfEZ9hotnUbYwGa+GRyKBe4SEuLoPNYoUWEuMjzhB
         XKRqZ4P/l6kGfFIxighx+xmRF9ca38wYSCEZ/thoC5bIHakpObnw29njasQ/NQmWF70s
         eP5/v1kJjGZS30Tfib/MArHGz/agqxzzURtqH4EHqfwizoz+qK3rpFGtlZHxfiFrAUM+
         9DtdoZ5zFwOjE7F7gn0RPXUtkUIIOg1XQQ3lWmw2Ey2OACO6tvpprtVscV+5GyZhrHiw
         Sleon+Zou3WnZT01XxXy11jehQlZ0YnqiPzmSeyPRajnZRkXz1bbj0FKL/wHM9xn3AOH
         4JpA==
X-Gm-Message-State: ACgBeo0F2A9n8k3LnH34YuNQydM5/gGIQGhQwk0n6rHZJRzpgimQX5TO
        jhR1zlCZNfx85vG++yVy0q60Otiwx48=
X-Google-Smtp-Source: AA6agR6iO6tKexXdgGafIXEjrkxKXRUq1/YrZN6K5Qp87F0q7tWi4vsd8oFHK6/VH0Z/PcAob9tEyQ==
X-Received: by 2002:a7b:cc94:0:b0:3a5:a965:95ea with SMTP id p20-20020a7bcc94000000b003a5a96595eamr3809273wma.166.1660174479325;
        Wed, 10 Aug 2022 16:34:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n128-20020a1c2786000000b003a302fb9df7sm3970366wmn.21.2022.08.10.16.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:34:39 -0700 (PDT)
Message-Id: <7a51fad87a8a21058ac95970d9dd66c731f07cf1.1660174473.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
        <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 23:34:27 +0000
Subject: [PATCH v3 05/11] scalar-diagnose: move functionality to common
 location
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Move the core functionality of 'scalar diagnose' into a new 'diagnose.[c,h]'
library to prepare for new callers in the main Git tree generating
diagnostic archives. These callers will be introduced in subsequent patches.

While this patch appears large, it is mostly made up of moving code out of
'scalar.c' and into 'diagnose.c'. Specifically, the functions

- dir_file_stats_objects()
- dir_file_stats()
- count_files()
- loose_objs_stats()
- add_directory_to_archiver()

are all copied verbatim from 'scalar.c'. The 'create_diagnostics_archive()'
function is a mostly identical (partial) copy of 'cmd_diagnose()', with the
primary changes being that 'zip_path' is an input and "Enlistment root" is
corrected to "Repository root" in the archiver log.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 Makefile                |   1 +
 contrib/scalar/scalar.c | 202 +------------------------------------
 diagnose.c              | 217 ++++++++++++++++++++++++++++++++++++++++
 diagnose.h              |   8 ++
 4 files changed, 228 insertions(+), 200 deletions(-)
 create mode 100644 diagnose.c
 create mode 100644 diagnose.h

diff --git a/Makefile b/Makefile
index 2ec9b2dc6bb..ed66cb70e5a 100644
--- a/Makefile
+++ b/Makefile
@@ -932,6 +932,7 @@ LIB_OBJS += ctype.o
 LIB_OBJS += date.o
 LIB_OBJS += decorate.o
 LIB_OBJS += delta-islands.o
+LIB_OBJS += diagnose.o
 LIB_OBJS += diff-delta.o
 LIB_OBJS += diff-merges.o
 LIB_OBJS += diff-lib.o
diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 607fedefd82..3983def760a 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -11,9 +11,7 @@
 #include "dir.h"
 #include "packfile.h"
 #include "help.h"
-#include "archive.h"
-#include "object-store.h"
-#include "compat/disk.h"
+#include "diagnose.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -263,53 +261,6 @@ static int unregister_dir(void)
 	return res;
 }
 
-static int add_directory_to_archiver(struct strvec *archiver_args,
-					  const char *path, int recurse)
-{
-	int at_root = !*path;
-	DIR *dir;
-	struct dirent *e;
-	struct strbuf buf = STRBUF_INIT;
-	size_t len;
-	int res = 0;
-
-	dir = opendir(at_root ? "." : path);
-	if (!dir) {
-		if (errno == ENOENT) {
-			warning(_("could not archive missing directory '%s'"), path);
-			return 0;
-		}
-		return error_errno(_("could not open directory '%s'"), path);
-	}
-
-	if (!at_root)
-		strbuf_addf(&buf, "%s/", path);
-	len = buf.len;
-	strvec_pushf(archiver_args, "--prefix=%s", buf.buf);
-
-	while (!res && (e = readdir(dir))) {
-		if (!strcmp(".", e->d_name) || !strcmp("..", e->d_name))
-			continue;
-
-		strbuf_setlen(&buf, len);
-		strbuf_addstr(&buf, e->d_name);
-
-		if (e->d_type == DT_REG)
-			strvec_pushf(archiver_args, "--add-file=%s", buf.buf);
-		else if (e->d_type != DT_DIR)
-			warning(_("skipping '%s', which is neither file nor "
-				  "directory"), buf.buf);
-		else if (recurse &&
-			 add_directory_to_archiver(archiver_args,
-						   buf.buf, recurse) < 0)
-			res = -1;
-	}
-
-	closedir(dir);
-	strbuf_release(&buf);
-	return res;
-}
-
 /* printf-style interface, expects `<key>=<value>` argument */
 static int set_config(const char *fmt, ...)
 {
@@ -550,83 +501,6 @@ cleanup:
 	return res;
 }
 
-static void dir_file_stats_objects(const char *full_path, size_t full_path_len,
-				   const char *file_name, void *data)
-{
-	struct strbuf *buf = data;
-	struct stat st;
-
-	if (!stat(full_path, &st))
-		strbuf_addf(buf, "%-70s %16" PRIuMAX "\n", file_name,
-			    (uintmax_t)st.st_size);
-}
-
-static int dir_file_stats(struct object_directory *object_dir, void *data)
-{
-	struct strbuf *buf = data;
-
-	strbuf_addf(buf, "Contents of %s:\n", object_dir->path);
-
-	for_each_file_in_pack_dir(object_dir->path, dir_file_stats_objects,
-				  data);
-
-	return 0;
-}
-
-static int count_files(char *path)
-{
-	DIR *dir = opendir(path);
-	struct dirent *e;
-	int count = 0;
-
-	if (!dir)
-		return 0;
-
-	while ((e = readdir(dir)) != NULL)
-		if (!is_dot_or_dotdot(e->d_name) && e->d_type == DT_REG)
-			count++;
-
-	closedir(dir);
-	return count;
-}
-
-static void loose_objs_stats(struct strbuf *buf, const char *path)
-{
-	DIR *dir = opendir(path);
-	struct dirent *e;
-	int count;
-	int total = 0;
-	unsigned char c;
-	struct strbuf count_path = STRBUF_INIT;
-	size_t base_path_len;
-
-	if (!dir)
-		return;
-
-	strbuf_addstr(buf, "Object directory stats for ");
-	strbuf_add_absolute_path(buf, path);
-	strbuf_addstr(buf, ":\n");
-
-	strbuf_add_absolute_path(&count_path, path);
-	strbuf_addch(&count_path, '/');
-	base_path_len = count_path.len;
-
-	while ((e = readdir(dir)) != NULL)
-		if (!is_dot_or_dotdot(e->d_name) &&
-		    e->d_type == DT_DIR && strlen(e->d_name) == 2 &&
-		    !hex_to_bytes(&c, e->d_name, 1)) {
-			strbuf_setlen(&count_path, base_path_len);
-			strbuf_addstr(&count_path, e->d_name);
-			total += (count = count_files(count_path.buf));
-			strbuf_addf(buf, "%s : %7d files\n", e->d_name, count);
-		}
-
-	strbuf_addf(buf, "Total: %d loose objects", total);
-
-	strbuf_release(&count_path);
-	closedir(dir);
-}
-
 static int cmd_diagnose(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -637,12 +511,8 @@ static int cmd_diagnose(int argc, const char **argv)
 		NULL
 	};
 	struct strbuf zip_path = STRBUF_INIT;
-	struct strvec archiver_args = STRVEC_INIT;
-	char **argv_copy = NULL;
-	int stdout_fd = -1, archiver_fd = -1;
 	time_t now = time(NULL);
 	struct tm tm;
-	struct strbuf buf = STRBUF_INIT;
 	int res = 0;
 
 	argc = parse_options(argc, argv, NULL, options,
@@ -663,79 +533,11 @@ static int cmd_diagnose(int argc, const char **argv)
 			    zip_path.buf);
 		goto diagnose_cleanup;
 	}
-	stdout_fd = dup(1);
-	if (stdout_fd < 0) {
-		res = error_errno(_("could not duplicate stdout"));
-		goto diagnose_cleanup;
-	}
-
-	archiver_fd = xopen(zip_path.buf, O_CREAT | O_WRONLY | O_TRUNC, 0666);
-	if (archiver_fd < 0 || dup2(archiver_fd, 1) < 0) {
-		res = error_errno(_("could not redirect output"));
-		goto diagnose_cleanup;
-	}
-
-	init_zip_archiver();
-	strvec_pushl(&archiver_args, "scalar-diagnose", "--format=zip", NULL);
-
-	strbuf_reset(&buf);
-	strbuf_addstr(&buf, "Collecting diagnostic info\n\n");
-	get_version_info(&buf, 1);
-
-	strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree);
-	get_disk_info(&buf);
-	write_or_die(stdout_fd, buf.buf, buf.len);
-	strvec_pushf(&archiver_args,
-		     "--add-virtual-file=diagnostics.log:%.*s",
-		     (int)buf.len, buf.buf);
-
-	strbuf_reset(&buf);
-	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
-	dir_file_stats(the_repository->objects->odb, &buf);
-	foreach_alt_odb(dir_file_stats, &buf);
-	strvec_push(&archiver_args, buf.buf);
-
-	strbuf_reset(&buf);
-	strbuf_addstr(&buf, "--add-virtual-file=objects-local.txt:");
-	loose_objs_stats(&buf, ".git/objects");
-	strvec_push(&archiver_args, buf.buf);
-
-	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
-	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
-	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
-	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
-	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
-		goto diagnose_cleanup;
-
-	strvec_pushl(&archiver_args, "--prefix=",
-		     oid_to_hex(the_hash_algo->empty_tree), "--", NULL);
-
-	/* `write_archive()` modifies the `argv` passed to it. Let it. */
-	argv_copy = xmemdupz(archiver_args.v,
-			     sizeof(char *) * archiver_args.nr);
-	res = write_archive(archiver_args.nr, (const char **)argv_copy, NULL,
-			    the_repository, NULL, 0);
-	if (res) {
-		error(_("failed to write archive"));
-		goto diagnose_cleanup;
-	}
 
-	if (!res)
-		fprintf(stderr, "\n"
-		       "Diagnostics complete.\n"
-		       "All of the gathered info is captured in '%s'\n",
-		       zip_path.buf);
+	res = create_diagnostics_archive(&zip_path);
 
 diagnose_cleanup:
-	if (archiver_fd >= 0) {
-		close(1);
-		dup2(stdout_fd, 1);
-	}
-	free(argv_copy);
-	strvec_clear(&archiver_args);
 	strbuf_release(&zip_path);
-	strbuf_release(&buf);
-
 	return res;
 }
 
diff --git a/diagnose.c b/diagnose.c
new file mode 100644
index 00000000000..509d582f0ea
--- /dev/null
+++ b/diagnose.c
@@ -0,0 +1,217 @@
+#include "cache.h"
+#include "diagnose.h"
+#include "compat/disk.h"
+#include "archive.h"
+#include "dir.h"
+#include "help.h"
+#include "strvec.h"
+#include "object-store.h"
+#include "packfile.h"
+
+static void dir_file_stats_objects(const char *full_path, size_t full_path_len,
+				   const char *file_name, void *data)
+{
+	struct strbuf *buf = data;
+	struct stat st;
+
+	if (!stat(full_path, &st))
+		strbuf_addf(buf, "%-70s %16" PRIuMAX "\n", file_name,
+			    (uintmax_t)st.st_size);
+}
+
+static int dir_file_stats(struct object_directory *object_dir, void *data)
+{
+	struct strbuf *buf = data;
+
+	strbuf_addf(buf, "Contents of %s:\n", object_dir->path);
+
+	for_each_file_in_pack_dir(object_dir->path, dir_file_stats_objects,
+				  data);
+
+	return 0;
+}
+
+static int count_files(char *path)
+{
+	DIR *dir = opendir(path);
+	struct dirent *e;
+	int count = 0;
+
+	if (!dir)
+		return 0;
+
+	while ((e = readdir(dir)) != NULL)
+		if (!is_dot_or_dotdot(e->d_name) && e->d_type == DT_REG)
+			count++;
+
+	closedir(dir);
+	return count;
+}
+
+static void loose_objs_stats(struct strbuf *buf, const char *path)
+{
+	DIR *dir = opendir(path);
+	struct dirent *e;
+	int count;
+	int total = 0;
+	unsigned char c;
+	struct strbuf count_path = STRBUF_INIT;
+	size_t base_path_len;
+
+	if (!dir)
+		return;
+
+	strbuf_addstr(buf, "Object directory stats for ");
+	strbuf_add_absolute_path(buf, path);
+	strbuf_addstr(buf, ":\n");
+
+	strbuf_add_absolute_path(&count_path, path);
+	strbuf_addch(&count_path, '/');
+	base_path_len = count_path.len;
+
+	while ((e = readdir(dir)) != NULL)
+		if (!is_dot_or_dotdot(e->d_name) &&
+		    e->d_type == DT_DIR && strlen(e->d_name) == 2 &&
+		    !hex_to_bytes(&c, e->d_name, 1)) {
+			strbuf_setlen(&count_path, base_path_len);
+			strbuf_addstr(&count_path, e->d_name);
+			total += (count = count_files(count_path.buf));
+			strbuf_addf(buf, "%s : %7d files\n", e->d_name, count);
+		}
+
+	strbuf_addf(buf, "Total: %d loose objects", total);
+
+	strbuf_release(&count_path);
+	closedir(dir);
+}
+
+static int add_directory_to_archiver(struct strvec *archiver_args,
+				     const char *path, int recurse)
+{
+	int at_root = !*path;
+	DIR *dir;
+	struct dirent *e;
+	struct strbuf buf = STRBUF_INIT;
+	size_t len;
+	int res = 0;
+
+	dir = opendir(at_root ? "." : path);
+	if (!dir) {
+		if (errno == ENOENT) {
+			warning(_("could not archive missing directory '%s'"), path);
+			return 0;
+		}
+		return error_errno(_("could not open directory '%s'"), path);
+	}
+
+	if (!at_root)
+		strbuf_addf(&buf, "%s/", path);
+	len = buf.len;
+	strvec_pushf(archiver_args, "--prefix=%s", buf.buf);
+
+	while (!res && (e = readdir(dir))) {
+		if (!strcmp(".", e->d_name) || !strcmp("..", e->d_name))
+			continue;
+
+		strbuf_setlen(&buf, len);
+		strbuf_addstr(&buf, e->d_name);
+
+		if (e->d_type == DT_REG)
+			strvec_pushf(archiver_args, "--add-file=%s", buf.buf);
+		else if (e->d_type != DT_DIR)
+			warning(_("skipping '%s', which is neither file nor "
+				  "directory"), buf.buf);
+		else if (recurse &&
+			 add_directory_to_archiver(archiver_args,
+						   buf.buf, recurse) < 0)
+			res = -1;
+	}
+
+	closedir(dir);
+	strbuf_release(&buf);
+	return res;
+}
+
+int create_diagnostics_archive(struct strbuf *zip_path)
+{
+	struct strvec archiver_args = STRVEC_INIT;
+	char **argv_copy = NULL;
+	int stdout_fd = -1, archiver_fd = -1;
+	struct strbuf buf = STRBUF_INIT;
+	int res;
+
+	stdout_fd = dup(STDOUT_FILENO);
+	if (stdout_fd < 0) {
+		res = error_errno(_("could not duplicate stdout"));
+		goto diagnose_cleanup;
+	}
+
+	archiver_fd = xopen(zip_path->buf, O_CREAT | O_WRONLY | O_TRUNC, 0666);
+	if (dup2(archiver_fd, STDOUT_FILENO) < 0) {
+		res = error_errno(_("could not redirect output"));
+		goto diagnose_cleanup;
+	}
+
+	init_zip_archiver();
+	strvec_pushl(&archiver_args, "git-diagnose", "--format=zip", NULL);
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "Collecting diagnostic info\n\n");
+	get_version_info(&buf, 1);
+
+	strbuf_addf(&buf, "Repository root: %s\n", the_repository->worktree);
+	get_disk_info(&buf);
+	write_or_die(stdout_fd, buf.buf, buf.len);
+	strvec_pushf(&archiver_args,
+		     "--add-virtual-file=diagnostics.log:%.*s",
+		     (int)buf.len, buf.buf);
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
+	dir_file_stats(the_repository->objects->odb, &buf);
+	foreach_alt_odb(dir_file_stats, &buf);
+	strvec_push(&archiver_args, buf.buf);
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "--add-virtual-file=objects-local.txt:");
+	loose_objs_stats(&buf, ".git/objects");
+	strvec_push(&archiver_args, buf.buf);
+
+	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
+	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
+	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
+	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
+	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
+		goto diagnose_cleanup;
+
+	strvec_pushl(&archiver_args, "--prefix=",
+		     oid_to_hex(the_hash_algo->empty_tree), "--", NULL);
+
+	/* `write_archive()` modifies the `argv` passed to it. Let it. */
+	argv_copy = xmemdupz(archiver_args.v,
+			     sizeof(char *) * archiver_args.nr);
+	res = write_archive(archiver_args.nr, (const char **)argv_copy, NULL,
+			    the_repository, NULL, 0);
+	if (res) {
+		error(_("failed to write archive"));
+		goto diagnose_cleanup;
+	}
+
+	if (!res)
+		fprintf(stderr, "\n"
+			"Diagnostics complete.\n"
+			"All of the gathered info is captured in '%s'\n",
+			zip_path->buf);
+
+diagnose_cleanup:
+	if (archiver_fd >= 0) {
+		dup2(stdout_fd, STDOUT_FILENO);
+		close(stdout_fd);
+		close(archiver_fd);
+	}
+	free(argv_copy);
+	strvec_clear(&archiver_args);
+	strbuf_release(&buf);
+
+	return res;
+}
diff --git a/diagnose.h b/diagnose.h
new file mode 100644
index 00000000000..06dca69bdac
--- /dev/null
+++ b/diagnose.h
@@ -0,0 +1,8 @@
+#ifndef DIAGNOSE_H
+#define DIAGNOSE_H
+
+#include "strbuf.h"
+
+int create_diagnostics_archive(struct strbuf *zip_path);
+
+#endif /* DIAGNOSE_H */
-- 
gitgitgadget

