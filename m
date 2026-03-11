Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F462C08A2
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242400; cv=none; b=PMdJY4h/dSfk22+UVBeAF6PSuY171e+CtADeX0bhoASJiUDf/BR0Gcel33AbgusLdfSNA+ns4YspWSVp124iBdUot37UOV1lejp37ZjzQLlW+P80vnvsFrnQCfdgcmYQlUxpfZ68fVp0YkQVDYyldNM6NOkK+WhISeLy3s6WPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242400; c=relaxed/simple;
	bh=DQpwKGa0jtpD5/K/ZCwdWOw7dpjjAe6VJ+xsic2/LfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYzU9Z6t2+xdbJoJvnBIh13+zK/eHq/HOtY/c8lTYGqze7PZdDXGgfn79WgdAHAb6hfaazCEuTaGR+7rgK+/JpY7cM0I683evt6Y8gPsVUqJNzKT8lTTlY5FWaz+dNjINuyb6e3EeeeOYSj+Yxy+dZhio5kvgm4MyklDEA/Ns1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G297GHJG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G297GHJG"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so47383365e9.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773242393; x=1773847193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4O/RX3EDtiyaLsURGZEVlFSMhbiyciOVJHX+7jzhB4=;
        b=G297GHJGV5zOBfy69Goh8PGNNyLZXeitjYkivUedcrfQoIR2aBLVYrQNJ+rhc+uBdA
         SpO0rz05EpFrYkkl7ka25MUtEId+YCqm6jbgajePn55AcyhtpXAD3lOjTXmYwUZz9awq
         EGdq+7kDb+6wD8UEv4p4nQs3XrcZLoleeR7cHB9zgYAy6JqTt7+1CfUPVITNgnXJDQyL
         6ALhQMrvoqZCl/+nt8OWzG/up5VgN0gUj3XPE0To/ysTWblKvezuAujhUe3jE7w0uJUY
         TNfLdmQ2TuMNosbVL+TdFqcBzCM0i2U8aFmq0AykK3TaXREuVdxnsRU+vEFka/lKfQyS
         SC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773242393; x=1773847193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G4O/RX3EDtiyaLsURGZEVlFSMhbiyciOVJHX+7jzhB4=;
        b=AKsR/bgu1FeFc7/U1RAJAxK0LfmTg4yJaBpCgIbONZBj0EwbuTYzwPVrvsRrUBpQuD
         Ns+qnfsIw/rzxC1hLAdL798zc1Jqr5twPRfLd8WL/k9vIGe6+L/cxYloUSmHAmJhcO2L
         T8yf+VU/1sq/rSDiSD6JWr89Ct3sSQfSZdZsKlPt+dSibukLIa00noH87Mvt+kwxEeZ2
         FcODSplq8SyoYqw2a7gbgUeLW/B9fj532RPM0K1806h2Q9/3/HgrWC4sIc4nku6yE3p1
         K2CVX7A8J7GVv5It7X1wfcWyg7IvKC+WMniGezu1OXHbrfDjTzifV4R6T4BgaJ3ow/rc
         lxwA==
X-Gm-Message-State: AOJu0YyJXbp+fHbjCY2kwRAWNfrR/Gz70au2VILz5OL5r4Or1Jxpjxo1
	3bttmNxqKZk9l/wyZ5ZOAZBeT1h0/5PZsewDYtY6Pg8VZGh8e8rmeWfYSKMOXA==
X-Gm-Gg: ATEYQzwunbIx9Fevdskg7VNO1BSy3KRlK5K7Fl6LwfCBd4mAbSnWrT0S9HmT5dCG/11
	JGbA7ZWTVAnJCjD+kHahZOoV0zh/815HCULzRRTUNMdga8lZsynIt6ClbdQ3U5+WYVxxRv2bgba
	QtOmLmgwkXpUlah9ziLwyaOr4xia7lgBhg0icNeHFchZ7GS7gd6pVWiuSuyV8e80IuvKcWz9Sl7
	v553YZH59Tz2TIqOeSAiZqh7qObd/F5TsvowjsnxxkQurEqDDkdETS4Drsm367Ix+UoNDBXcgN0
	yimhWNGu/tbQ7OVihWzd+dljbj1xPH+hhKIUJTFbLROXc8KxUU2/6D4i3FYrkMHNRUaKEbVUajx
	NOsxcHeZuJhHflqDrUzJvsLto7yqdu3Igz22A/VVRF1OsIIJd2SNRScjov2/wEDIB8A8xUFbXDv
	uWjotZUDRT86HWDp4=
X-Received: by 2002:a05:600c:4fd6:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-4854b0a6b99mr54452665e9.1.1773242393224;
        Wed, 11 Mar 2026 08:19:53 -0700 (PDT)
Received: from fedora ([159.146.43.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b65fd3dsm62743975e9.10.2026.03.11.08.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 08:19:52 -0700 (PDT)
From: =?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	l.s.r@web.de,
	ps@pks.im,
	=?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
Subject: [PATCH 4/4] cocci: convert start_command() to repo_start_command()
Date: Wed, 11 Mar 2026 18:19:23 +0300
Message-ID: <20260311151923.4178655-5-bkkaracay@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311151923.4178655-1-bkkaracay@gmail.com>
References: <20260311151923.4178655-1-bkkaracay@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add and apply a semantic patch to migrate the remaining
'start_command()' calls to 'repo_start_command()' by passing
'the_repository' as the first parameter.

Signed-off-by: Burak Kaan Karaçay <bkkaracay@gmail.com>
---
 archive-tar.c                           |  2 +-
 branch.c                                |  2 +-
 builtin/credential-cache.c              |  2 +-
 builtin/gc.c                            | 16 ++++++++--------
 builtin/help.c                          |  2 +-
 builtin/index-pack.c                    |  2 +-
 builtin/merge.c                         |  2 +-
 builtin/notes.c                         |  2 +-
 builtin/receive-pack.c                  |  6 +++---
 builtin/remote-ext.c                    |  2 +-
 builtin/repack.c                        |  2 +-
 builtin/replace.c                       |  2 +-
 builtin/upload-archive.c                |  2 +-
 builtin/worktree.c                      |  2 +-
 bundle-uri.c                            |  2 +-
 bundle.c                                |  2 +-
 column.c                                |  2 +-
 compat/mingw.c                          |  2 +-
 connect.c                               |  4 ++--
 connected.c                             |  2 +-
 contrib/coccinelle/the_repository.cocci |  3 +++
 convert.c                               |  2 +-
 credential.c                            |  2 +-
 daemon.c                                |  6 +++---
 diff.c                                  |  2 +-
 editor.c                                |  2 +-
 fetch-pack.c                            |  4 ++--
 http-backend.c                          |  2 +-
 imap-send.c                             |  2 +-
 midx-write.c                            |  2 +-
 parallel-checkout.c                     |  2 +-
 promisor-remote.c                       |  2 +-
 prompt.c                                |  2 +-
 range-diff.c                            |  2 +-
 reachable.c                             |  2 +-
 remote-curl.c                           |  2 +-
 repack-cruft.c                          |  2 +-
 repack-filtered.c                       |  2 +-
 repack-midx.c                           |  2 +-
 repack-promisor.c                       |  2 +-
 run-command.c                           |  8 ++++----
 sub-process.c                           |  2 +-
 submodule.c                             | 12 ++++++------
 t/helper/test-run-command.c             |  4 ++--
 transport-helper.c                      |  6 +++---
 upload-pack.c                           |  4 ++--
 46 files changed, 73 insertions(+), 70 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 0fc70d13a8..78124443f5 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -503,7 +503,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
 	filter.in = -1;
 	filter.silent_exec_failure = 1;
 
-	if (start_command(&filter) < 0)
+	if (repo_start_command(the_repository, &filter) < 0)
 		die_errno(_("unable to start '%s' filter"), cmd.buf);
 	close(1);
 	if (dup2(filter.in, 1) < 0)
diff --git a/branch.c b/branch.c
index 243db7d0fc..878abff79d 100644
--- a/branch.c
+++ b/branch.c
@@ -728,7 +728,7 @@ static int submodule_create_branch(struct repository *r,
 
 	strvec_pushl(&child.args, name, start_oid, tracking_name, NULL);
 
-	if ((ret = start_command(&child)))
+	if ((ret = repo_start_command(the_repository, &child)))
 		return ret;
 	ret = finish_command(&child);
 	strbuf_read(&child_err, child.err, 0);
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index fb17aa87ba..642d94fca0 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -83,7 +83,7 @@ static void spawn_daemon(const char *socket)
 	daemon.no_stdin = 1;
 	daemon.out = -1;
 
-	if (start_command(&daemon))
+	if (repo_start_command(the_repository, &daemon))
 		die_errno("unable to start cache daemon");
 	r = read_in_full(daemon.out, buf, sizeof(buf));
 	if (r < 0)
diff --git a/builtin/gc.c b/builtin/gc.c
index fb329c2cff..01da48cc32 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1396,7 +1396,7 @@ static int pack_loose(struct maintenance_run_opts *opts)
 	 */
 	pack_proc.out = -1;
 
-	if (start_command(&pack_proc)) {
+	if (repo_start_command(the_repository, &pack_proc)) {
 		error(_("failed to start 'git pack-objects' process"));
 		return 1;
 	}
@@ -2435,7 +2435,7 @@ static int launchctl_boot_plist(int enable, const char *filename)
 	child.no_stderr = 1;
 	child.no_stdout = 1;
 
-	if (start_command(&child))
+	if (repo_start_command(the_repository, &child))
 		die(_("failed to start launchctl"));
 
 	result = finish_command(&child);
@@ -2474,7 +2474,7 @@ static int launchctl_list_contains_plist(const char *name, const char *cmd)
 	child.no_stderr = 1;
 	child.no_stdout = 1;
 
-	if (start_command(&child))
+	if (repo_start_command(the_repository, &child))
 		die(_("failed to start launchctl"));
 
 	/* Returns failure if 'name' doesn't exist. */
@@ -2766,7 +2766,7 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	child.no_stdout = 1;
 	child.no_stderr = 1;
 
-	if (start_command(&child))
+	if (repo_start_command(the_repository, &child))
 		die(_("failed to start schtasks"));
 	result = finish_command(&child);
 
@@ -2860,7 +2860,7 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 	crontab_list.out = dup(fd);
 	crontab_list.git_cmd = 0;
 
-	if (start_command(&crontab_list)) {
+	if (repo_start_command(the_repository, &crontab_list)) {
 		result = error(_("failed to run 'crontab -l'; your system might not support 'cron'"));
 		goto out;
 	}
@@ -2924,7 +2924,7 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 	strvec_push(&crontab_edit.args, get_tempfile_path(tmpedit));
 	crontab_edit.git_cmd = 0;
 
-	if (start_command(&crontab_edit)) {
+	if (repo_start_command(the_repository, &crontab_edit)) {
 		result = error(_("failed to run 'crontab'; your system might not support 'cron'"));
 		goto out;
 	}
@@ -2950,7 +2950,7 @@ static int real_is_systemd_timer_available(void)
 	child.no_stderr = 1;
 	child.silent_exec_failure = 1;
 
-	if (start_command(&child))
+	if (repo_start_command(the_repository, &child))
 		return 0;
 	if (finish_command(&child))
 		return 0;
@@ -3169,7 +3169,7 @@ static int systemd_timer_enable_unit(int enable,
 		     "--now", NULL);
 	strvec_pushf(&child.args, SYSTEMD_UNIT_FORMAT, frequency, "timer");
 
-	if (start_command(&child)) {
+	if (repo_start_command(the_repository, &child)) {
 		ret = error(_("failed to start systemctl"));
 		goto out;
 	}
diff --git a/builtin/help.c b/builtin/help.c
index 86a3d03a9b..3473a0ae9f 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -242,7 +242,7 @@ static int check_emacsclient_version(void)
 	strvec_pushl(&ec_process.args, "emacsclient", "--version", NULL);
 	ec_process.err = -1;
 	ec_process.stdout_to_stderr = 1;
-	if (start_command(&ec_process))
+	if (repo_start_command(the_repository, &ec_process))
 		return error(_("Failed to start emacsclient."));
 
 	strbuf_read(&buffer, ec_process.err, 20);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b67fb0256c..5be75cb0eb 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1840,7 +1840,7 @@ static void repack_local_links(void)
 			cmd.git_cmd = 1;
 			cmd.in = -1;
 			cmd.out = -1;
-			if (start_command(&cmd))
+			if (repo_start_command(the_repository, &cmd))
 				die(_("could not start pack-objects to repack local links"));
 		}
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 4e456a381c..fb5875d1b2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -357,7 +357,7 @@ static int save_state(struct object_id *stash)
 	cp.out = -1;
 	cp.git_cmd = 1;
 
-	if (start_command(&cp))
+	if (repo_start_command(the_repository, &cp))
 		die(_("could not run stash."));
 	len = strbuf_read(&buffer, cp.out, 1024);
 	close(cp.out);
diff --git a/builtin/notes.c b/builtin/notes.c
index 9af602bdd7..bf9a46461d 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -173,7 +173,7 @@ static void write_commented_object(int fd, const struct object_id *object)
 	show.out = -1;
 	show.err = 0;
 	show.git_cmd = 1;
-	if (start_command(&show))
+	if (repo_start_command(the_repository, &show))
 		die(_("unable to start 'show' for object '%s'"),
 		    oid_to_hex(object));
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d6225df890..9533179bd6 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1179,7 +1179,7 @@ static int run_proc_receive_hook(struct command *commands,
 		proc.err = 0;
 	}
 
-	code = start_command(&proc);
+	code = repo_start_command(the_repository, &proc);
 	if (code) {
 		if (use_sideband)
 			finish_async(&muxer);
@@ -2411,7 +2411,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		child.out = -1;
 		child.err = err_fd;
 		child.git_cmd = 1;
-		status = start_command(&child);
+		status = repo_start_command(the_repository, &child);
 		if (status)
 			return "index-pack fork failed";
 
@@ -2732,7 +2732,7 @@ int cmd_receive_pack(int argc,
 				proc.stdout_to_stderr = 1;
 				proc.err = use_sideband ? -1 : 0;
 
-				if (!start_command(&proc)) {
+				if (!repo_start_command(the_repository, &proc)) {
 					if (use_sideband)
 						copy_to_sideband(proc.err, -1, NULL);
 					finish_command(&proc);
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index ed2d551753..f12eb0243b 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -149,7 +149,7 @@ static int run_child(const char *arg, const char *service)
 	child.err = 0;
 	parse_argv(&child.args, arg, service);
 
-	if (start_command(&child) < 0)
+	if (repo_start_command(the_repository, &child) < 0)
 		die("Can't run specified command");
 
 	if (git_req)
diff --git a/builtin/repack.c b/builtin/repack.c
index f6bb04bef7..3f7d83238c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -356,7 +356,7 @@ int cmd_repack(int argc,
 	else
 		cmd.no_stdin = 1;
 
-	ret = start_command(&cmd);
+	ret = repo_start_command(the_repository, &cmd);
 	if (ret)
 		goto cleanup;
 
diff --git a/builtin/replace.c b/builtin/replace.c
index 4c62c5ab58..0abf5bc004 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -278,7 +278,7 @@ static int import_object(struct object_id *oid, enum object_type type,
 		cmd.in = fd;
 		cmd.out = -1;
 
-		if (start_command(&cmd)) {
+		if (repo_start_command(the_repository, &cmd)) {
 			close(fd);
 			return error(_("unable to spawn mktree"));
 		}
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 25312bb2a5..a840a78f6c 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -106,7 +106,7 @@ struct repository *repo UNUSED)
 	writer.git_cmd = 1;
 	strvec_push(&writer.args, "upload-archive--writer");
 	strvec_pushv(&writer.args, argv + 1);
-	if (start_command(&writer)) {
+	if (repo_start_command(the_repository, &writer)) {
 		int err = errno;
 		packet_write_fmt(1, "NACK unable to spawn subprocess\n");
 		die("upload-archive: %s", strerror(err));
diff --git a/builtin/worktree.c b/builtin/worktree.c
index bc2d0d645b..eb509470e2 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1363,7 +1363,7 @@ static void check_clean_worktree(struct worktree *wt,
 	cp.git_cmd = 1;
 	cp.dir = wt->path;
 	cp.out = -1;
-	ret = start_command(&cp);
+	ret = repo_start_command(the_repository, &cp);
 	if (ret)
 		die_errno(_("failed to run 'git status' on '%s'"),
 			  original_path);
diff --git a/bundle-uri.c b/bundle-uri.c
index 3b2e347288..b27b909785 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -341,7 +341,7 @@ static int download_https_uri_to_file(const char *file, const char *uri)
 	cp.in = -1;
 	cp.out = -1;
 
-	if (start_command(&cp))
+	if (repo_start_command(the_repository, &cp))
 		return 1;
 
 	child_in = fdopen(cp.in, "w");
diff --git a/bundle.c b/bundle.c
index 42327f9739..d2d385fef6 100644
--- a/bundle.c
+++ b/bundle.c
@@ -355,7 +355,7 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
 		}
 	}
 
-	if (start_command(&pack_objects))
+	if (repo_start_command(the_repository, &pack_objects))
 		return error(_("Could not spawn pack-objects"));
 
 	for (i = 0; i < revs->pending.nr; i++) {
diff --git a/column.c b/column.c
index 998b2ab458..a2e26b993d 100644
--- a/column.c
+++ b/column.c
@@ -388,7 +388,7 @@ int run_column_filter(int colopts, const struct column_options *opts)
 	column_process.out = dup(1);
 	column_process.git_cmd = 1;
 
-	if (start_command(&column_process))
+	if (repo_start_command(the_repository, &column_process))
 		return -2;
 
 	fd_out = dup(1);
diff --git a/compat/mingw.c b/compat/mingw.c
index c667a2dcda..4825cf596a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -35,7 +35,7 @@ void open_in_gdb(void)
 	strvec_pushl(&cp.args, "mintty", "gdb", NULL);
 	strvec_pushf(&cp.args, "--pid=%d", getpid());
 	cp.clean_on_exit = 1;
-	if (start_command(&cp) < 0)
+	if (repo_start_command(the_repository, &cp) < 0)
 		die_errno("Could not start gdb");
 	sleep(1);
 }
diff --git a/connect.c b/connect.c
index a02583a102..b223fe7644 100644
--- a/connect.c
+++ b/connect.c
@@ -1054,7 +1054,7 @@ static struct child_process *git_proxy_connect(int fd[2], char *host)
 	strvec_push(&proxy->args, port);
 	proxy->in = -1;
 	proxy->out = -1;
-	if (start_command(proxy))
+	if (repo_start_command(the_repository, proxy))
 		die(_("cannot start proxy %s"), git_proxy_command);
 	fd[0] = proxy->out; /* read from proxy stdout */
 	fd[1] = proxy->in;  /* write to proxy stdin */
@@ -1515,7 +1515,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		}
 		strvec_push(&conn->args, cmd.buf);
 
-		if (start_command(conn))
+		if (repo_start_command(the_repository, conn))
 			die(_("unable to fork"));
 
 		fd[0] = conn->out; /* read from child's stdout */
diff --git a/connected.c b/connected.c
index 79403108dd..278cc6a123 100644
--- a/connected.c
+++ b/connected.c
@@ -127,7 +127,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	else
 		rev_list.no_stderr = opt->quiet;
 
-	if (start_command(&rev_list)) {
+	if (repo_start_command(the_repository, &rev_list)) {
 		free(new_pack);
 		return error(_("Could not run 'git rev-list'"));
 	}
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index f1129f7985..ed0389ea12 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -12,6 +12,9 @@
 |
 - parse_tree_indirect
 + repo_parse_tree_indirect
+|
+- start_command
++ repo_start_command
 )
   (
 + the_repository,
diff --git a/convert.c b/convert.c
index a34ec6ecdc..db3e1996ea 100644
--- a/convert.c
+++ b/convert.c
@@ -662,7 +662,7 @@ static int filter_buffer_or_fd(int in UNUSED, int out, void *data)
 	child_process.in = -1;
 	child_process.out = out;
 
-	if (start_command(&child_process)) {
+	if (repo_start_command(the_repository, &child_process)) {
 		strbuf_release(&cmd);
 		return error(_("cannot fork to run external filter '%s'"),
 			     params->cmd);
diff --git a/credential.c b/credential.c
index a513355105..5497051df1 100644
--- a/credential.c
+++ b/credential.c
@@ -457,7 +457,7 @@ static int run_credential_helper(struct credential *c,
 	else
 		helper.no_stdout = 1;
 
-	if (start_command(&helper) < 0)
+	if (repo_start_command(the_repository, &helper) < 0)
 		return -1;
 
 	fp = xfdopen(helper.in, "w");
diff --git a/daemon.c b/daemon.c
index 0a7b1aae44..8eb22851da 100644
--- a/daemon.c
+++ b/daemon.c
@@ -328,7 +328,7 @@ static int run_access_hook(struct daemon_service *service, const char *dir,
 	child.no_stdin = 1;
 	child.no_stderr = 1;
 	child.out = -1;
-	if (start_command(&child)) {
+	if (repo_start_command(the_repository, &child)) {
 		logerror("daemon access hook '%s' failed to start",
 			 access_hook);
 		goto error_return;
@@ -454,7 +454,7 @@ static int run_service_command(struct child_process *cld)
 	strvec_push(&cld->args, ".");
 	cld->git_cmd = 1;
 	cld->err = -1;
-	if (start_command(cld))
+	if (repo_start_command(the_repository, cld))
 		return -1;
 
 	close(0);
@@ -906,7 +906,7 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 	cld.in = incoming;
 	cld.out = dup(incoming);
 
-	if (start_command(&cld))
+	if (repo_start_command(the_repository, &cld))
 		logerror("unable to fork");
 	else
 		add_child(&cld, addr, addrlen);
diff --git a/diff.c b/diff.c
index e87847fa4b..fbda03ac18 100644
--- a/diff.c
+++ b/diff.c
@@ -7467,7 +7467,7 @@ static char *run_textconv(struct repository *r,
 
 	child.use_shell = 1;
 	child.out = -1;
-	if (start_command(&child)) {
+	if (repo_start_command(the_repository, &child)) {
 		remove_tempfile();
 		return NULL;
 	}
diff --git a/editor.c b/editor.c
index fd174e6a03..c96311bb3f 100644
--- a/editor.c
+++ b/editor.c
@@ -92,7 +92,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 			strvec_pushv(&p.env, (const char **)env);
 		p.use_shell = 1;
 		p.trace2_child_class = "editor";
-		if (start_command(&p) < 0) {
+		if (repo_start_command(the_repository, &p) < 0) {
 			strbuf_release(&realpath);
 			return error("unable to start editor '%s'", editor);
 		}
diff --git a/fetch-pack.c b/fetch-pack.c
index 6ecd468ef7..64476f852f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1035,7 +1035,7 @@ static int get_pack(struct fetch_pack_args *args,
 
 	cmd.in = demux.out;
 	cmd.git_cmd = 1;
-	if (start_command(&cmd))
+	if (repo_start_command(the_repository, &cmd))
 		die(_("fetch-pack: unable to fork off %s"), cmd_name);
 	if (do_keep && (pack_lockfiles || fsck_objects)) {
 		int is_well_formed;
@@ -1841,7 +1841,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		cmd.git_cmd = 1;
 		cmd.no_stdin = 1;
 		cmd.out = -1;
-		if (start_command(&cmd))
+		if (repo_start_command(the_repository, &cmd))
 			die("fetch-pack: unable to spawn http-fetch");
 
 		if (read_in_full(cmd.out, packname, 5) < 0 ||
diff --git a/http-backend.c b/http-backend.c
index 1a171c5c5a..08ffb4a393 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -501,7 +501,7 @@ static void run_service(const char **argv, int buffer_input)
 	cld.git_cmd = 1;
 	cld.clean_on_exit = 1;
 	cld.wait_after_clean = 1;
-	if (start_command(&cld))
+	if (repo_start_command(the_repository, &cld))
 		exit(1);
 
 	close(1);
diff --git a/imap-send.c b/imap-send.c
index 26dda7f328..fefdb7a4ba 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1155,7 +1155,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		tunnel.use_shell = 1;
 		tunnel.in = -1;
 		tunnel.out = -1;
-		if (start_command(&tunnel))
+		if (repo_start_command(the_repository, &tunnel))
 			die("cannot start proxy %s", srvc->tunnel);
 
 		imap->buf.sock.fd[0] = tunnel.out;
diff --git a/midx-write.c b/midx-write.c
index a53f77f13a..a1051e7807 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1828,7 +1828,7 @@ int midx_repack(struct odb_source *source, size_t batch_size, unsigned flags)
 	cmd.git_cmd = 1;
 	cmd.in = cmd.out = -1;
 
-	if (start_command(&cmd)) {
+	if (repo_start_command(the_repository, &cmd)) {
 		error(_("could not start pack-objects"));
 		result = 1;
 		goto cleanup;
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 0bf4bd6d4a..bd4e8afcf8 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -476,7 +476,7 @@ static struct pc_worker *setup_workers(struct checkout *state, int num_workers)
 		strvec_push(&cp->args, "checkout--worker");
 		if (state->base_dir_len)
 			strvec_pushf(&cp->args, "--prefix=%s", state->base_dir);
-		if (start_command(cp))
+		if (repo_start_command(the_repository, cp))
 			die("failed to spawn checkout worker");
 	}
 
diff --git a/promisor-remote.c b/promisor-remote.c
index 96fa215b06..4e861260fe 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -48,7 +48,7 @@ static int fetch_objects(struct repository *repo,
 		     "--filter=blob:none", "--stdin", NULL);
 	if (!repo_config_get_bool(the_repository, "promisor.quiet", &quiet) && quiet)
 		strvec_push(&child.args, "--quiet");
-	if (start_command(&child))
+	if (repo_start_command(the_repository, &child))
 		die(_("promisor-remote: unable to fork off fetch subprocess"));
 	child_in = xfdopen(child.in, "w");
 
diff --git a/prompt.c b/prompt.c
index 20a8c34438..7ff5e8adf9 100644
--- a/prompt.c
+++ b/prompt.c
@@ -20,7 +20,7 @@ static char *do_askpass(const char *cmd, const char *prompt)
 
 	pass.out = -1;
 
-	if (start_command(&pass))
+	if (repo_start_command(the_repository, &pass))
 		return NULL;
 
 	strbuf_reset(&buffer);
diff --git a/range-diff.c b/range-diff.c
index 57edff40a8..a698d84ae1 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -75,7 +75,7 @@ static int read_patches(const char *range, struct string_list *list,
 	cp.no_stdin = 1;
 	cp.git_cmd = 1;
 
-	if (start_command(&cp))
+	if (repo_start_command(the_repository, &cp))
 		return error_errno(_("could not start `log`"));
 	if (strbuf_read(&contents, cp.out, 0) < 0) {
 		error_errno(_("could not read `log` output"));
diff --git a/reachable.c b/reachable.c
index 101cfc2727..64dcaa6b23 100644
--- a/reachable.c
+++ b/reachable.c
@@ -138,7 +138,7 @@ static int run_one_gc_recent_objects_hook(struct oidset *set,
 
 	strvec_push(&cmd.args, args);
 
-	if (start_command(&cmd))
+	if (repo_start_command(the_repository, &cmd))
 		return -1;
 
 	out = xfdopen(cmd.out, "r");
diff --git a/remote-curl.c b/remote-curl.c
index 92e40bb682..5db038302e 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1093,7 +1093,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 	client.out = -1;
 	client.git_cmd = 1;
 	strvec_pushv(&client.args, client_argv);
-	if (start_command(&client))
+	if (repo_start_command(the_repository, &client))
 		exit(1);
 	write_or_die(client.in, preamble->buf, preamble->len);
 	if (heads)
diff --git a/repack-cruft.c b/repack-cruft.c
index 0bfc77792a..af4665d029 100644
--- a/repack-cruft.c
+++ b/repack-cruft.c
@@ -62,7 +62,7 @@ int write_cruft_pack(const struct write_pack_opts *opts,
 
 	cmd.in = -1;
 
-	ret = start_command(&cmd);
+	ret = repo_start_command(the_repository, &cmd);
 	if (ret)
 		return ret;
 
diff --git a/repack-filtered.c b/repack-filtered.c
index 2f5d1dd709..b21a7d92a4 100644
--- a/repack-filtered.c
+++ b/repack-filtered.c
@@ -26,7 +26,7 @@ int write_filtered_pack(const struct write_pack_opts *opts,
 
 	cmd.in = -1;
 
-	ret = start_command(&cmd);
+	ret = repo_start_command(the_repository, &cmd);
 	if (ret)
 		return ret;
 
diff --git a/repack-midx.c b/repack-midx.c
index 8b4c0d95e3..32286b5507 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -344,7 +344,7 @@ int write_midx_included_packs(struct repack_write_midx_opts *opts)
 		strvec_pushf(&cmd.args, "--refs-snapshot=%s",
 			     opts->refs_snapshot);
 
-	ret = start_command(&cmd);
+	ret = repo_start_command(the_repository, &cmd);
 	if (ret)
 		goto done;
 
diff --git a/repack-promisor.c b/repack-promisor.c
index 70ef19d04f..03b17884a3 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -26,7 +26,7 @@ static int write_oid(const struct object_id *oid,
 	struct child_process *cmd = ctx->cmd;
 
 	if (cmd->in == -1) {
-		if (start_command(cmd))
+		if (repo_start_command(the_repository, cmd))
 			die(_("could not start pack-objects to repack promisor objects"));
 	}
 
diff --git a/run-command.c b/run-command.c
index af26c636a9..b7e7ebdf7d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1015,7 +1015,7 @@ int run_command(struct child_process *cmd)
 	if (cmd->out < 0 || cmd->err < 0)
 		BUG("run_command with a pipe can cause deadlock");
 
-	code = start_command(cmd);
+	code = repo_start_command(the_repository, cmd);
 	if (code)
 		return code;
 	return finish_command(cmd);
@@ -1430,7 +1430,7 @@ int pipe_command(struct child_process *cmd,
 	if (err)
 		cmd->err = -1;
 
-	if (start_command(cmd) < 0)
+	if (repo_start_command(the_repository, cmd) < 0)
 		return -1;
 
 	if (in) {
@@ -1652,7 +1652,7 @@ static int pp_start_one(struct parallel_processes *pp,
 		pp->children[i].process.stdout_to_stderr = 1;
 	}
 
-	if (start_command(&pp->children[i].process)) {
+	if (repo_start_command(the_repository, &pp->children[i].process)) {
 		if (opts->start_failure)
 			code = opts->start_failure(opts->ungroup ? NULL :
 						   &pp->children[i].err,
@@ -2006,7 +2006,7 @@ enum start_bg_result start_bg_command(struct child_process *cmd,
 	if (!cmd->trace2_child_class)
 		cmd->trace2_child_class = "background";
 
-	ret = start_command(cmd);
+	ret = repo_start_command(the_repository, cmd);
 	if (ret) {
 		/*
 		 * We assume that if `start_command()` fails, we
diff --git a/sub-process.c b/sub-process.c
index ae7493eb5c..abfa856860 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -93,7 +93,7 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
 	process->clean_on_exit_handler = subprocess_exit_handler;
 	process->trace2_child_class = "subprocess";
 
-	err = start_command(process);
+	err = repo_start_command(the_repository, process);
 	if (err) {
 		error("cannot fork to run subprocess '%s'", cmd);
 		return err;
diff --git a/submodule.c b/submodule.c
index 4f9aaa2c75..40c474f927 100644
--- a/submodule.c
+++ b/submodule.c
@@ -718,7 +718,7 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		strvec_push(&cp.env, GIT_WORK_TREE_ENVIRONMENT "=.");
 	}
 
-	if (start_command(&cp)) {
+	if (repo_start_command(the_repository, &cp)) {
 		diff_emit_submodule_error(o, "(diff failed)\n");
 		goto done;
 	}
@@ -1064,7 +1064,7 @@ static int submodule_needs_pushing(struct repository *r,
 		cp.no_stdin = 1;
 		cp.out = -1;
 		cp.dir = path;
-		if (start_command(&cp))
+		if (repo_start_command(the_repository, &cp))
 			die(_("Could not run 'git rev-list <commits> --not --remotes -n 1' command in submodule %s"),
 					path);
 		if (strbuf_read(&buf, cp.out, the_hash_algo->hexsz + 1))
@@ -1899,7 +1899,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	cp.no_stdin = 1;
 	cp.out = -1;
 	cp.dir = path;
-	if (start_command(&cp))
+	if (repo_start_command(the_repository, &cp))
 		die(_("Could not run 'git status --porcelain=2' in submodule %s"), path);
 
 	fp = xfdopen(cp.out, "r");
@@ -2020,7 +2020,7 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 	cp.no_stdin = 1;
 	cp.out = -1;
 	cp.dir = path;
-	if (start_command(&cp)) {
+	if (repo_start_command(the_repository, &cp)) {
 		if (flags & SUBMODULE_REMOVAL_DIE_ON_ERROR)
 			die(_("could not start 'git status' in submodule '%s'"),
 				path);
@@ -2076,7 +2076,7 @@ static int submodule_has_dirty_index(const struct submodule *sub)
 	cp.no_stdin = 1;
 	cp.no_stdout = 1;
 	cp.dir = sub->path;
-	if (start_command(&cp))
+	if (repo_start_command(the_repository, &cp))
 		die(_("could not recurse into submodule '%s'"), sub->path);
 
 	return finish_command(&cp);
@@ -2636,7 +2636,7 @@ int get_superproject_working_tree(struct strbuf *buf)
 	cp.out = -1;
 	cp.git_cmd = 1;
 
-	if (start_command(&cp))
+	if (repo_start_command(the_repository, &cp))
 		die(_("could not start ls-files in .."));
 
 	len = strbuf_read(&sb, cp.out, PATH_MAX);
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index dcd58f228c..fb2ba4b7b6 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -415,7 +415,7 @@ static int inherit_handle(const char *argv0)
 		     "test-tool", argv0, "inherited-handle-child", NULL);
 	cp.in = -1;
 	cp.no_stdout = cp.no_stderr = 1;
-	if (start_command(&cp) < 0)
+	if (repo_start_command(the_repository, &cp) < 0)
 		die("Could not start child process");
 
 	/* Then close it, and try to delete it. */
@@ -479,7 +479,7 @@ int cmd__run_command(int argc, const char **argv)
 	strvec_pushv(&proc.args, (const char **)argv + 2);
 
 	if (!strcmp(argv[1], "start-command-ENOENT")) {
-		if (start_command(&proc) < 0 && errno == ENOENT) {
+		if (repo_start_command(the_repository, &proc) < 0 && errno == ENOENT) {
 			ret = 0;
 			goto cleanup;
 		}
diff --git a/transport-helper.c b/transport-helper.c
index 4d95d84f9e..c2bfab4c6d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -154,7 +154,7 @@ static struct child_process *get_helper(struct transport *transport)
 
 	helper->trace2_child_class = helper->args.v[0]; /* "remote-<name>" */
 
-	code = start_command(helper);
+	code = repo_start_command(the_repository, helper);
 	if (code < 0 && errno == ENOENT)
 		die(_("unable to find remote helper for '%s'"), data->name);
 	else if (code != 0)
@@ -471,7 +471,7 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	}
 	fastimport->git_cmd = 1;
 
-	code = start_command(fastimport);
+	code = repo_start_command(the_repository, fastimport);
 	return code;
 }
 
@@ -500,7 +500,7 @@ static int get_exporter(struct transport *transport,
 		strvec_push(&fastexport->args, revlist_args->items[i].string);
 
 	fastexport->git_cmd = 1;
-	return start_command(fastexport);
+	return repo_start_command(the_repository, fastexport);
 }
 
 static int fetch_with_import(struct transport *transport,
diff --git a/upload-pack.c b/upload-pack.c
index e8c5cce1c7..a8143b7b18 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -338,7 +338,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 	pack_objects.err = -1;
 	pack_objects.clean_on_exit = 1;
 
-	if (start_command(&pack_objects))
+	if (repo_start_command(the_repository, &pack_objects))
 		die("git upload-pack: unable to fork git-pack-objects");
 
 	pipe_fd = xfdopen(pack_objects.in, "w");
@@ -661,7 +661,7 @@ static int do_reachable_revlist(struct child_process *cmd,
 	 */
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	if (start_command(cmd))
+	if (repo_start_command(the_repository, cmd))
 		goto error;
 
 	cmd_in = xfdopen(cmd->in, "w");
-- 
2.53.0

