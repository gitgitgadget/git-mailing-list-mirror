Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D8CC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 21:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiHAVPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiHAVPK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 17:15:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8693FA29
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 14:15:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so6121043wmm.4
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 14:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jBanH8g650jd8hhYFKIlpC/xTXRfMgaS8p9up1D5wns=;
        b=heYIwKX0UVAsVQPyHgo+sWWknGtLJiQWudYmczXNzFbdTbf1icOyNXBCp5NCGcxPlW
         q5U5XDaxAGg9CwVZHZn0eMpoM6Ww/rhcByPIZuREvIFp6UrAXD4jvvdH4iVLuzBJFwwy
         8eB2w/Vbx1qV622li9VdGAWQeWoXlEArSlDzKMSE6olk17EszjC6YIdZZEC7KfZGL1Y9
         hMpt8dLCNbxXnwb/xo/38K/n45jHtX/jBxyESUQqJC+3NGCCGNDG2Qn4Xk1n/3US3Rdh
         UTpnWrh/7Yp/UufqEF70Hf5mRfZlLVIWJmHi9Mhh5t+lIzWoTCz3m7LyC99gjp0/mglK
         IB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jBanH8g650jd8hhYFKIlpC/xTXRfMgaS8p9up1D5wns=;
        b=I/nYNRZlGL5SshMKhpJJ3xES7x/YU3tvO1EEg5mwZZs4bqM7sLERtp2RwTLr2fW+43
         GIgxRGtklW5fOacnvDN2xehQCErXNsBK6U5y/4jNPrszoVlfVSMcn/klT4f4riMKcb/1
         kZLEDhEA65NYC4u5uVCtaCczcXULK3sDds5+LfOB4/GJSoWpsP9hS6aVnf7S13lXHt4a
         RZN5XRZywjIk/NduV4kqH9xclNCzj8vm/NYzIo/qRpRyXpcALbfGi5Qrnxm5fC/bPIOv
         wALXjhDSwN/KsF82wFkJJDjRK8ewoSZXyJ999J0nsnEgdAuVqNTOXN2Y/C+6vdjSTjwr
         9xqw==
X-Gm-Message-State: ACgBeo21jCKR0r6Quk5KvpR1AqMidwKAJBh+KTV9qI3XWCmHF0rxOLos
        M0DbWAG6AeXWocnEuWxbDdFP3z7LMNw=
X-Google-Smtp-Source: AA6agR5GVW4RhIWsqOrdnV+D4n5JXyanaPO+g5D6+QBYH+UZ7DfUHJt8CtEn3/3MwLffSv6MUxjQug==
X-Received: by 2002:a7b:cc94:0:b0:3a4:c228:b340 with SMTP id p20-20020a7bcc94000000b003a4c228b340mr6050070wma.13.1659388506225;
        Mon, 01 Aug 2022 14:15:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10-20020a7bc5ca000000b003a2e7c13a3asm15663110wmk.42.2022.08.01.14.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:15:05 -0700 (PDT)
Message-Id: <4eb3c43d48832150c53ee56c679ab13464185974.1659388498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Aug 2022 21:14:57 +0000
Subject: [PATCH 6/7] scalar: use 'git bugreport --diagnose' in 'scalar
 diagnose'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Replace implementation of 'scalar diagnose' with an internal invocation of
'git bugreport --diagnose --no-report'. The '--diagnose' option of 'git
bugreport' was implemented to mirror what 'scalar diagnose' does, taking
most of its code directly from 'scalar.c'. Remove the now-duplicate code in
'scalar.c' and have 'scalar diagnose' call 'git bugreport' to create the
diagnostics archive.

This introduces two (minor) changes to the output of 'scalar diagnose':
changing "Enlistment root" to "Repository root" in 'diagnostics.log'
("enlistment root" was inaccurate anyway, as the reported path always
pointed to the root of the repository), and changing the prefix of the zip
archive from 'scalar_' to 'git-diagnostics-'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c | 271 ++--------------------------------------
 1 file changed, 7 insertions(+), 264 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 97e71fe19cd..7b1953605bd 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -11,7 +11,6 @@
 #include "dir.h"
 #include "packfile.h"
 #include "help.h"
-#include "archive.h"
 #include "object-store.h"
 
 /*
@@ -262,99 +261,6 @@ static int unregister_dir(void)
 	return res;
 }
 
-static int add_directory_to_archiver(struct strvec *archiver_args,
-					  const char *path, int recurse)
-{
-	int at_root = !*path;
-	DIR *dir = opendir(at_root ? "." : path);
-	struct dirent *e;
-	struct strbuf buf = STRBUF_INIT;
-	size_t len;
-	int res = 0;
-
-	if (!dir)
-		return error_errno(_("could not open directory '%s'"), path);
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
-#ifndef WIN32
-#include <sys/statvfs.h>
-#endif
-
-static int get_disk_info(struct strbuf *out)
-{
-#ifdef WIN32
-	struct strbuf buf = STRBUF_INIT;
-	char volume_name[MAX_PATH], fs_name[MAX_PATH];
-	DWORD serial_number, component_length, flags;
-	ULARGE_INTEGER avail2caller, total, avail;
-
-	strbuf_realpath(&buf, ".", 1);
-	if (!GetDiskFreeSpaceExA(buf.buf, &avail2caller, &total, &avail)) {
-		error(_("could not determine free disk size for '%s'"),
-		      buf.buf);
-		strbuf_release(&buf);
-		return -1;
-	}
-
-	strbuf_setlen(&buf, offset_1st_component(buf.buf));
-	if (!GetVolumeInformationA(buf.buf, volume_name, sizeof(volume_name),
-				   &serial_number, &component_length, &flags,
-				   fs_name, sizeof(fs_name))) {
-		error(_("could not get info for '%s'"), buf.buf);
-		strbuf_release(&buf);
-		return -1;
-	}
-	strbuf_addf(out, "Available space on '%s': ", buf.buf);
-	strbuf_humanise_bytes(out, avail2caller.QuadPart);
-	strbuf_addch(out, '\n');
-	strbuf_release(&buf);
-#else
-	struct strbuf buf = STRBUF_INIT;
-	struct statvfs stat;
-
-	strbuf_realpath(&buf, ".", 1);
-	if (statvfs(buf.buf, &stat) < 0) {
-		error_errno(_("could not determine free disk size for '%s'"),
-			    buf.buf);
-		strbuf_release(&buf);
-		return -1;
-	}
-
-	strbuf_addf(out, "Available space on '%s': ", buf.buf);
-	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
-	strbuf_addf(out, " (mount flags 0x%lx)\n", stat.f_flag);
-	strbuf_release(&buf);
-#endif
-	return 0;
-}
-
 /* printf-style interface, expects `<key>=<value>` argument */
 static int set_config(const char *fmt, ...)
 {
@@ -595,83 +501,6 @@ cleanup:
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
@@ -681,106 +510,20 @@ static int cmd_diagnose(int argc, const char **argv)
 		N_("scalar diagnose [<enlistment>]"),
 		NULL
 	};
-	struct strbuf zip_path = STRBUF_INIT;
-	struct strvec archiver_args = STRVEC_INIT;
-	char **argv_copy = NULL;
-	int stdout_fd = -1, archiver_fd = -1;
-	time_t now = time(NULL);
-	struct tm tm;
-	struct strbuf buf = STRBUF_INIT;
+	struct strbuf diagnostics_path = STRBUF_INIT;
 	int res = 0;
 
 	argc = parse_options(argc, argv, NULL, options,
 			     usage, 0);
 
-	setup_enlistment_directory(argc, argv, usage, options, &zip_path);
-
-	strbuf_addstr(&zip_path, "/.scalarDiagnostics/scalar_");
-	strbuf_addftime(&zip_path,
-			"%Y%m%d_%H%M%S", localtime_r(&now, &tm), 0, 0);
-	strbuf_addstr(&zip_path, ".zip");
-	switch (safe_create_leading_directories(zip_path.buf)) {
-	case SCLD_EXISTS:
-	case SCLD_OK:
-		break;
-	default:
-		error_errno(_("could not create directory for '%s'"),
-			    zip_path.buf);
-		goto diagnose_cleanup;
-	}
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
+	setup_enlistment_directory(argc, argv, usage, options, &diagnostics_path);
+	strbuf_addstr(&diagnostics_path, "/.scalarDiagnostics");
 
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
-
-	if (!res)
-		fprintf(stderr, "\n"
-		       "Diagnostics complete.\n"
-		       "All of the gathered info is captured in '%s'\n",
-		       zip_path.buf);
-
-diagnose_cleanup:
-	if (archiver_fd >= 0) {
-		close(1);
-		dup2(stdout_fd, 1);
-	}
-	free(argv_copy);
-	strvec_clear(&archiver_args);
-	strbuf_release(&zip_path);
-	strbuf_release(&buf);
+	if (run_git("bugreport", "--diagnose", "--no-report",
+		    "-s", "%Y%m%d_%H%M%S", "-o", diagnostics_path.buf, NULL) < 0)
+		res = -1;
 
+	strbuf_release(&diagnostics_path);
 	return res;
 }
 
-- 
gitgitgadget

