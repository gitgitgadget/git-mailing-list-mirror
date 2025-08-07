Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DCD1758B
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754579044; cv=none; b=V85dCNrRUnKQhFdPenA0YwY4lKXAx6sWf4jcLrESHxVhHPio5J90HCjRYN49I7sGO3JugM3rlrnLnThDyKvRnab6r9mlhWib3bpXMdYbEkRrA+LCdWUL2bIIw07V1+1rF7UkeMdKlNyjrR7/GPTMWmoEF+4xNbOZJVSYCygkG20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754579044; c=relaxed/simple;
	bh=wvClg+WRCLLxUp55dWLwWW7AJGyFP+BGnw/Uuqa3KVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=klesR2K8cBLcvb1oqaNeBCyj5uWrfdxsPuW490RzVvsJ/lteBjlq55Xrv+UelSoeDMXpKLIAH8Lt3VGjwQpZ4/IlBG4AzcW8Msj+oZTyUOpDQUBfo4NfcVX9gTooSQWt93dN6YSHJqXnWzwE/0+n4bNWUoatz6A47JUChMwBzNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3lhRdxf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3lhRdxf"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24014cd385bso12719415ad.0
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 08:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754579040; x=1755183840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmdKslSkemJZT1zT2CS2vDgkEnYmH9VeGghTnXuqmRk=;
        b=f3lhRdxfxXyVAOY8+HHuY23SrzAwGWzleum3Mcfb/uzKG9Q2RmgQpIC55HE0VFb9Tq
         7RWeNByy63iBFtlyorGxEeYQilNz8+6N9BfjxMxECwD78mDvo9c1zJlnPYUOjFu2YP9U
         sa0gMQKPz3TS+rS7PnrhbyfJh6GmHDEMqX2Eg1LRbb2Ih0sRAGRec8WG0Deq2LxMRw1A
         5DrGvhV2RqSSAJqRfGjoc27LMM+DhZg+RUqQtSORZ79zs5RTd+uj4I30KaMv0ana6zdq
         6GH/tof1+u/CRQSoacKxcN5EuYo5BhIUTnbiXoo6ceCcIB3Ucu+YFwKDHV5RfaTmYJH7
         IYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754579040; x=1755183840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmdKslSkemJZT1zT2CS2vDgkEnYmH9VeGghTnXuqmRk=;
        b=BsUOEKkCsNvWeXRdlrO1F9qAoV8Tow9Dr3QB27MHeZfRZu8aleldxFBlYbW3pEW6pY
         FidcQGq57Dv52oMMdbkGgUnc7tFCkUUUMEMfE9D8cAC5FRRQcp7e0MW/u0s/A0nYUgNV
         38xpOwLnyo3qJx9YnLTFsYMCmsBu83QXL7toGWVa73aixKkxg+wKYi33kyyYcEfKwoXG
         f7sceJWS8hKsMf8iaa5AJ1C1o+O/Lns2t5rWbDdAT+b9K2FtHa5+l6smrIjk2eWKWvV8
         ASyWZJxYXnBdYcXcj+k4s6liVSaEKNINR1RhqxKJhPlZNS9mCt++YO41UNx1LxR3whE0
         YL+g==
X-Gm-Message-State: AOJu0YzQvmIH7Dqs2l77835xoOH2Lub7Dv/28mdoo3oo2UUMWVLf8qkg
	5jT8PRBY8r9gDLhyLyN2u54iT+Bugn+bOucfXlBtQ5wOOqbX7ay7ZXJ7Mpfh1A==
X-Gm-Gg: ASbGncvnTxAtynemTw6qwRLcZIEuhta/a7xVX3PUmPLVS5aY0Zt78s148PmgZtyMHhx
	4nbCreqsvbYDF58kDhaX1Qurn9vKwVOywNHaddFx3onDDj4N7o6sohD5/6+6373T+r+rUqY8jp5
	SU3TeKy14r/UrJQjhzOt6hQzHh0QDeTW5Ehr0yq3xQLx5mh6A0sqpJR+0HkKRRssRQed3ArCfWN
	O6yZ/nBInJ0pb6fsLWK2WqVvc9SpK618k9yeaSvGdf1n7qlU3MkbWfKd8OeShcLqBq09RHCPGfj
	bZfAo/LgWiaqBORtmw7vfwf2M2A8y2s8/H+TcINqt0Z05AA4QtrXjcfrZo6ZiTNqbbgo3zm26lL
	1c47LTKuF/04f0s+OB0mq7gWvKZZgfcsj/bVAcWX/DJCJKJ10rnAuEyfg4rGXWg==
X-Google-Smtp-Source: AGHT+IE642RXVofIelaLO1u8F2mWccIM3FEULLydGk0rD9MZU2twXhz09NIxW3ZELtgo/dCLFD8NJQ==
X-Received: by 2002:a17:903:350b:b0:240:5549:7094 with SMTP id d9443c01a7336-242a0ac2da9mr86749065ad.18.1754579040353;
        Thu, 07 Aug 2025 08:04:00 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8359:45d5:14c8:c621:17ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2426dec66desm106617065ad.54.2025.08.07.08.03.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Aug 2025 08:03:59 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de,
	ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	jn.avila@free.fr,
	sunshine@sunshineco.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v9 1/5] repo: declare the repo command
Date: Thu,  7 Aug 2025 12:02:35 -0300
Message-Id: <20250807150239.6987-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250807150239.6987-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, `git rev-parse` covers a wide range of functionality not
directly related to parsing revisions, as its name suggests. Over time,
many features like parsing datestrings, options, paths, and others
were added to it because there wasn't a more appropriate command
to place them.

Create a new Git command called `repo`. `git repo` will be the main
command for obtaining the information about a repository (such as
metadata and metrics).

Also declare a subcommand for `repo` called `info`. `git repo info`
will bring the functionality of retrieving repository-related
information currently returned by `rev-parse`.

Add the required documentation and build changes to enable usage of
this subcommand.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 .gitignore                  |  1 +
 Documentation/git-repo.adoc | 32 ++++++++++++++++++++++++++++++++
 Documentation/meson.build   |  1 +
 Makefile                    |  1 +
 builtin.h                   |  1 +
 builtin/repo.c              | 27 +++++++++++++++++++++++++++
 command-list.txt            |  1 +
 git.c                       |  1 +
 meson.build                 |  1 +
 9 files changed, 66 insertions(+)
 create mode 100644 Documentation/git-repo.adoc
 create mode 100644 builtin/repo.c

diff --git a/.gitignore b/.gitignore
index 04c444404e..1803023427 100644
--- a/.gitignore
+++ b/.gitignore
@@ -139,6 +139,7 @@
 /git-repack
 /git-replace
 /git-replay
+/git-repo
 /git-request-pull
 /git-rerere
 /git-reset
diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
new file mode 100644
index 0000000000..68c706f5a0
--- /dev/null
+++ b/Documentation/git-repo.adoc
@@ -0,0 +1,32 @@
+git-repo(1)
+===========
+
+NAME
+----
+git-repo - Retrieve information about the repository
+
+SYNOPSIS
+--------
+[synopsis]
+git repo info [<key>...]
+
+DESCRIPTION
+-----------
+Retrieve information about the repository.
+
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
+COMMANDS
+--------
+`info [<key>...]`::
+	Retrieve metadata-related information about the current repository. Only
+	the requested data will be returned based on their keys (see "INFO KEYS"
+	section below).
+
+SEE ALSO
+--------
+linkgit:git-rev-parse[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 4404c623f0..41f43e0336 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -116,6 +116,7 @@ manpages = {
   'git-repack.adoc' : 1,
   'git-replace.adoc' : 1,
   'git-replay.adoc' : 1,
+  'git-repo.adoc' : 1,
   'git-request-pull.adoc' : 1,
   'git-rerere.adoc' : 1,
   'git-reset.adoc' : 1,
diff --git a/Makefile b/Makefile
index e11340c1ae..ec7ac58980 100644
--- a/Makefile
+++ b/Makefile
@@ -1306,6 +1306,7 @@ BUILTIN_OBJS += builtin/remote.o
 BUILTIN_OBJS += builtin/repack.o
 BUILTIN_OBJS += builtin/replace.o
 BUILTIN_OBJS += builtin/replay.o
+BUILTIN_OBJS += builtin/repo.o
 BUILTIN_OBJS += builtin/rerere.o
 BUILTIN_OBJS += builtin/reset.o
 BUILTIN_OBJS += builtin/rev-list.o
diff --git a/builtin.h b/builtin.h
index bff13e3069..e6458e6fb9 100644
--- a/builtin.h
+++ b/builtin.h
@@ -216,6 +216,7 @@ int cmd_remote_ext(int argc, const char **argv, const char *prefix, struct repos
 int cmd_remote_fd(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_repack(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_replay(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_repo(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_rerere(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_reset(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_restore(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/repo.c b/builtin/repo.c
new file mode 100644
index 0000000000..fd2a9b4216
--- /dev/null
+++ b/builtin/repo.c
@@ -0,0 +1,27 @@
+#include "builtin.h"
+#include "parse-options.h"
+
+static const char *const repo_usage[] = {
+	"git repo info [<key>...]",
+	NULL
+};
+
+static int repo_info(int argc UNUSED, const char **argv UNUSED,
+		     const char *prefix UNUSED, struct repository *repo UNUSED)
+{
+	return 0;
+}
+
+int cmd_repo(int argc, const char **argv, const char *prefix,
+	     struct repository *repo)
+{
+	parse_opt_subcommand_fn *fn = NULL;
+	struct option options[] = {
+		OPT_SUBCOMMAND("info", &fn, repo_info),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+
+	return fn(argc, argv, prefix, repo);
+}
diff --git a/command-list.txt b/command-list.txt
index b7ade3ab9f..1b0bdee00d 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -164,6 +164,7 @@ git-remote                              ancillarymanipulators           complete
 git-repack                              ancillarymanipulators           complete
 git-replace                             ancillarymanipulators           complete
 git-replay                              plumbingmanipulators
+git-repo                                plumbinginterrogators
 git-request-pull                        foreignscminterface             complete
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain           history
diff --git a/git.c b/git.c
index 83eac0aeab..d4ff4d5517 100644
--- a/git.c
+++ b/git.c
@@ -611,6 +611,7 @@ static struct cmd_struct commands[] = {
 	{ "repack", cmd_repack, RUN_SETUP },
 	{ "replace", cmd_replace, RUN_SETUP },
 	{ "replay", cmd_replay, RUN_SETUP },
+	{ "repo", cmd_repo, RUN_SETUP },
 	{ "rerere", cmd_rerere, RUN_SETUP },
 	{ "reset", cmd_reset, RUN_SETUP },
 	{ "restore", cmd_restore, RUN_SETUP | NEED_WORK_TREE },
diff --git a/meson.build b/meson.build
index 5dd299b496..e8ec0eca16 100644
--- a/meson.build
+++ b/meson.build
@@ -645,6 +645,7 @@ builtin_sources = [
   'builtin/repack.c',
   'builtin/replace.c',
   'builtin/replay.c',
+  'builtin/repo.c',
   'builtin/rerere.c',
   'builtin/reset.c',
   'builtin/rev-list.c',
-- 
2.39.5 (Apple Git-154)

