Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D1D3BB9F9
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326695; cv=none; b=DwhFWmUx+bQTbcO488kgrmDukkHBeguzADGJn0mII7FdOstf5BUa7WRkkr9sZjTblDS3wYx7zsrXFsEJpwTQ6Hp6UW1RL82NdGvJ7mCe6cmHTf6pfsnjb35x3Ok8B4nYKSESDd1D7bPWENC6HzvDg7prHOiuxpFJcVrOtUlBRkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326695; c=relaxed/simple;
	bh=K/eTo1TuuZg58oqZ25iJnACu8wGP3TG/tg2i51QTLHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VyERpmnEy8Y9i4KCXd2qMVw3mH99nTbzty2JBlXctAK9KZT0n0avWYyj+vPXPq4bopeclfhxTv/x6wiyn/MUKqTu3t3zboD/syzIk7cTAgktqnIS6qNU90Ge2X0rTna/xuvKWOlrlAVM1iiADxDAagBpmtFUaGnVA9PhEpBLo8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXifViHx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXifViHx"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso9979275e9.3
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 07:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773326689; x=1773931489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB6eomBC2uvdOoyFx+fZNRZrzx5fM84avBb9Rv0Kt0o=;
        b=LXifViHxcuAMNlCxXTy+td8Y4OXFjWSJ+0mN3MbnAdHSc+Hvd7HFy8Pd08Z74pFkmq
         k3reAP6BeDs/dTqC+vvAne2A5wL+7rziPHCLsIJ3icWXdPDJDzAe5a92CvFYetSQLhLi
         SLRzPeSdebylbMIXZy5cqH/4ngKsW+I5VauFJURNTxB/b6bl2U+cXDIT7ATRVFq6iU9+
         FiMma9pDXeia1M1PKHnMYNWaUsRTK/YqRutrtqOklKv4YCzOP/pBQB+XldLfDrE7VoUh
         HulbgmfGshvfev1QEw/FJzFZs99/3jvXYsQdZ8N9n7oDS/PmBCIjIU+pRcKNl+OCsyOo
         hJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773326689; x=1773931489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PB6eomBC2uvdOoyFx+fZNRZrzx5fM84avBb9Rv0Kt0o=;
        b=sGxVfqoTZb1rN0ZOscetsQM4tCjh32jjEX/8RBu4yxFJCtP4zR+u1pnuuLAUnfUSAg
         mHONKWFkNpt5InHZb7GLuxbPIRGz6z7Yp8uCbOsLR4YBxhbRJSsuNEKDYwejGS1rxlh4
         /ggMc1h+EBX4PHwPkGyzv9WC7PaLS2Gqjcpy37p8MaSIyYPn8IvQJn1dOaxODi0l+u8w
         GGgNQ7RBjWY/0Hxu19boeABnjrTIdOtHAk5dVhNxBFpv8MiEsPwNDyZiAZ5QTxcZcQAu
         4KgC6RiXc/y9ZB4/v6U3QKcciloqRYSmcqnCBsRHEB4eAmED1G4CvODooh8vn9Ov0qMm
         CKRA==
X-Gm-Message-State: AOJu0Yyt63f5l7EsIhjKBr1YF2kKpy3yGPtfuG/SmGnZdanD4KF7WcCs
	xG8SvIpic4QhXcruMuQ205gtKIFqi44d8+Yk8M/Q3oxiS1JisF6EmbUOV/Kfgw==
X-Gm-Gg: ATEYQzyQQuYQHvAHxwDjIQkjkefIlsDxuHiDOBK1kVYEnB6sukIMMwDjMldY8KruDsX
	+LjU51F5ozGqK5uwQVu8PMmwCpRhzccRpNSEPGXflWcWYD1ZeOWaiddbAsjnobqsgmTlvkC1LK9
	5tlw4NHLoDdr7B2U1r5Ml6KUGkGTH093NFlk0zJgN7UUxWfOdM/5SZMsat8r4TAAlxcebR9HkYi
	Yz8O2jWY+oBaOVYURaaJCUmGyhSLWTxboMvbpzhF0E+qlPMIxgkvVSlc3RzUk5C1RL0pp9ianaZ
	DUQQIDYrfeNMfqvP279dwjFSl4EPm4Rcne3/zgIXN8sfurKIKC+0yhYQ5xqmTPcYGJhB7nkRXWw
	2VUqXSlX9bi/IlwKtEuIOr6+J9KtkD/qHYHFx29wmKBAzqDqrdQMtaQ1an2a5erH0VHxVptud5+
	tQKA0/yyxA19QK9S0=
X-Received: by 2002:a05:600c:8b0a:b0:480:4a8f:2d5c with SMTP id 5b1f17b1804b1-4854b129f91mr108393795e9.29.1773326689119;
        Thu, 12 Mar 2026 07:44:49 -0700 (PDT)
Received: from fedora ([159.146.43.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b47145dsm130688015e9.0.2026.03.12.07.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 07:44:48 -0700 (PDT)
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
Subject: [PATCH v3 1/2] run-command: wean start_command() off the_repository
Date: Thu, 12 Mar 2026 17:44:36 +0300
Message-ID: <20260312144437.626392-2-bkkaracay@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312144437.626392-1-bkkaracay@gmail.com>
References: <20260311151923.4178655-1-bkkaracay@gmail.com>
 <20260312144437.626392-1-bkkaracay@gmail.com>
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
new 'struct object_database *odb_to_close' field. This allows callers to
specify the object store that needs to be closed.

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

