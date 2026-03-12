Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2432BEC2C
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305641; cv=none; b=sPZDdXMljC/pUgShcIalAAU7bPkdaXwyPcdAXC5ioSst+eWIX77JN2Q7cPGgNxND8YQWz6bUEs/GDw+fHeFrJTkqe2F5lxvPoRUY+g8mge6YZXQ8iQ4i2DDxjecu+UCmIfx0ZsVice6LGgs7Px2h5GAHRKj4pZ8DIS1RcnNZLMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305641; c=relaxed/simple;
	bh=TG6JP8D6RX5tM/ilhKUor1rRImNqtX2ppmGoXmNfZk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUkXTtOE+38I/okhtozbNnFICq4UikH8c0eifBJtGWhrQJtYoZwNrjs/8JSPfkD5BqZQ2kuuJrj7PynkjF0lnUE9lKo5JE499POT5mMblofMsbmqkv4Aow4GhRqwr3De2qUmpEtQK56HfPig0SA0L6agjrhCOOpFkccVMaVgLJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdP3EZmL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdP3EZmL"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso8700755e9.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 01:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773305638; x=1773910438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eq2SdatqzujYk0R0h9woFR9dJhgmqYM+T/olUDlwb2Y=;
        b=CdP3EZmLlLcESpsMGAfyQc7NjP4hkVi0ZVv5UD8nL8cWb4qGEr8mVYaE9YjFxU0eWB
         kT3x3UPLzQQnMl0N+3t+UsMLhdzUvSPUTWeBQq19pL/RkTPuoDUg85P7Ae1Dg/GIUtYl
         E/JXmTK9HDpGyZCWvtint1f3SHdXNAqTh/TxJ4ig7SRhKcAq0WwmBtpWJdmkBZg0OqCi
         vEDdiyRSo3M0GyM+WyC7fAmEQbVFxMzsTodZmWza9RxgGeERhMDnitBKuuDS48WTQUkL
         F9KCwjFAattdOnaLqwWfQygsoGx9YdRMMEY6+IUqseuHioMDjQF/bmU2zs+SRVrYEbcI
         3OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773305638; x=1773910438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eq2SdatqzujYk0R0h9woFR9dJhgmqYM+T/olUDlwb2Y=;
        b=EfNgp+bGzJAbgZB+0tDPzN5DC2vdgq1rGdK7U6rk4g8x4oLF56UhWCYxll9yUzhJ3x
         /zZsnGJVhPBswSO09Yrf6PXUV6ehMIKBDDcWFYz3Yl2kgqAxyEETrWYgO3PWYPQexD8y
         WS5p9igGme7nf3OiTGhaq+xw2Zrtl+7QYdgiRjrSRiMnWIMUh6nepcoIjtrEd5u0prPA
         KU+LJrl5Xj84aojFbU3bexMO+BZfknvToC4eAcIz3zrTOalX4G6NerCDFVsOxTTozIvM
         VIbxh6ys6Cv6++SNclZiK8tuPil0zHNP4n+4lsVBYeiw5jr8+2CECLLlkFLsSuL2xaGD
         +Gkw==
X-Gm-Message-State: AOJu0YwiwwPH9kpQDI85eeQJ3ZBs7YXk3ZhwQeBnl2mOnPvOXV2RSHNG
	HxTrZ9QYuAS1C53Vn4xPdkwylZrPOu8oeQOiBZ9fRN35AIxIfY+pWdPwor6KLKVb
X-Gm-Gg: ATEYQzwNnINp3exfL6aoVMQzGzJkY49sI63Ti4cRfTnG4lIWev3AKWRri6AY8v0PsUb
	CHZ6gdxKbkOKXkDeJkcrDS45FYH8SHVk08ChBZDh+VjLbfbtivK+p5RyBOaJXKgffMHDBTSR77D
	WZoh8lGllnyA+qaROMmlycXeokNGGmdwywLuvgesQjNJf8xapqa4zG0k5ICjNe1HmscFmWXlOQP
	J3H7TQLaUZAHABA8ATmXlJ/yVHhzgi/WLxt4FytBSaWyWpJVgAOc5KeBE+71nIOpOH4K2i5xKXO
	psJHQPHIkbginiKbPWl/OmXwxZqPWZbuQzsihJhZ9nbaCPSJzMI2euU40WBmSBNPyQ7Oz/FfOaT
	+g2TzlJN18UhwDfQrCUqW1VCa/f6+MLSXwOuOnzDbM1R6EQQXf/XKug+ayIGvg1Q8uuq90zxqr/
	xx1tVzUe0ipP7JhUbK8kq7LgJiXDXqPkJ6CQ==
X-Received: by 2002:a05:600c:3551:b0:485:3f72:324d with SMTP id 5b1f17b1804b1-4854b0cabe4mr98881965e9.14.1773305637811;
        Thu, 12 Mar 2026 01:53:57 -0700 (PDT)
Received: from fedora.marun.edu.tr ([193.255.169.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ad1e4esm218574695e9.8.2026.03.12.01.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:53:57 -0700 (PDT)
From: =?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	l.s.r@web.de,
	ps@pks.im,
	peff@peff.net,
	gitster@pobox.com,
	=?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
Subject: [PATCH v2] run-command: wean start_command() off the_repository
Date: Thu, 12 Mar 2026 11:53:41 +0300
Message-ID: <20260312085341.631318-1-bkkaracay@gmail.com>
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

The start_command() relies on the_repository due to the
close_object_store flag in 'struct child_process'. When this flag is
set, start_command() closes the object store associated with
the_repository before spawning a child process.

To eliminate this dependency, replace the 'close_object_store' with the
new 'odb_to_close' field. This allows callers to specify the object
store that needs to be closed.

Suggested-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Burak Kaan Karaçay <bkkaracay@gmail.com>
---
 builtin/gc.c   | 14 +++++++++-----
 builtin/pull.c |  2 +-
 run-command.c  |  6 +++---
 run-command.h  |  2 +-
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index fb329c2cff..5d8d358f7a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1030,7 +1030,7 @@ int cmd_gc(int argc,
 		struct child_process repack_cmd = CHILD_PROCESS_INIT;
 
 		repack_cmd.git_cmd = 1;
-		repack_cmd.close_object_store = 1;
+		repack_cmd.odb_to_close = the_repository->objects;
 		strvec_pushv(&repack_cmd.args, repack_args.v);
 		if (run_command(&repack_cmd))
 			die(FAILED_RUN, repack_args.v[0]);
@@ -1199,7 +1199,8 @@ static int run_write_commit_graph(struct maintenance_run_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	child.git_cmd = child.close_object_store = 1;
+	child.git_cmd = 1;
+	child.odb_to_close = the_repository->objects;
 	strvec_pushl(&child.args, "commit-graph", "write",
 		     "--split", "--reachable", NULL);
 
@@ -1268,7 +1269,8 @@ static int maintenance_task_gc_background(struct maintenance_run_opts *opts,
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	child.git_cmd = child.close_object_store = 1;
+	child.git_cmd = 1;
+	child.odb_to_close = the_repository->objects;
 	strvec_push(&child.args, "gc");
 
 	if (opts->auto_flag)
@@ -1484,7 +1486,8 @@ static int multi_pack_index_expire(struct maintenance_run_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	child.git_cmd = child.close_object_store = 1;
+	child.git_cmd = 1;
+	child.odb_to_close = the_repository->objects;
 	strvec_pushl(&child.args, "multi-pack-index", "expire", NULL);
 
 	if (opts->quiet)
@@ -1542,7 +1545,8 @@ static int multi_pack_index_repack(struct maintenance_run_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	child.git_cmd = child.close_object_store = 1;
+	child.git_cmd = 1;
+	child.odb_to_close = the_repository->objects;
 	strvec_pushl(&child.args, "multi-pack-index", "repack", NULL);
 
 	if (opts->quiet)
diff --git a/builtin/pull.c b/builtin/pull.c
index 6ad420ce6f..7e67fdce97 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -454,7 +454,7 @@ static int run_fetch(const char *repo, const char **refspecs)
 	} else if (*refspecs)
 		BUG("refspecs without repo?");
 	cmd.git_cmd = 1;
-	cmd.close_object_store = 1;
+	cmd.odb_to_close = the_repository->objects;
 	return run_command(&cmd);
 }
 
diff --git a/run-command.c b/run-command.c
index b27064ef57..ed5e8be976 100644
--- a/run-command.c
+++ b/run-command.c
@@ -742,8 +742,8 @@ int start_command(struct child_process *cmd)
 
 	fflush(NULL);
 
-	if (cmd->close_object_store)
-		odb_close(the_repository->objects);
+	if (cmd->odb_to_close)
+		odb_close(cmd->odb_to_close);
 
 #ifndef GIT_WINDOWS_NATIVE
 {
@@ -1955,7 +1955,7 @@ int prepare_auto_maintenance(int quiet, struct child_process *maint)
 		auto_detach = git_env_bool("GIT_TEST_MAINT_AUTO_DETACH", true);
 
 	maint->git_cmd = 1;
-	maint->close_object_store = 1;
+	maint->odb_to_close = the_repository->objects;
 	strvec_pushl(&maint->args, "maintenance", "run", "--auto", NULL);
 	strvec_push(&maint->args, quiet ? "--quiet" : "--no-quiet");
 	strvec_push(&maint->args, auto_detach ? "--detach" : "--no-detach");
diff --git a/run-command.h b/run-command.h
index e1ca965b5b..af4c9da279 100644
--- a/run-command.h
+++ b/run-command.h
@@ -136,7 +136,7 @@ struct child_process {
 	 * want to repack because that would delete `.pack` files (and on
 	 * Windows, you cannot delete files that are still in use).
 	 */
-	unsigned close_object_store:1;
+	struct object_database *odb_to_close;
 
 	unsigned stdout_to_stderr:1;
 	unsigned clean_on_exit:1;
-- 
2.53.0

