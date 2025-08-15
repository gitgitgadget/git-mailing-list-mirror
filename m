Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A864315F
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271798; cv=none; b=M4XyWORTuayGzhhrzeL8IO70LgVE+U5lh4z99hTcPA7r3/8lApGUZ/FmCugrtbMSr4Z8FIN+deI09cPGGRAVRFtGH3wZe1c8GUZDr06TEdpXNvfPmObhSFEIXOAF47sTeG+1K1aygXXJ4+LRDyoXjyb7MJ47//3Tx4qyHVuMpzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271798; c=relaxed/simple;
	bh=wvClg+WRCLLxUp55dWLwWW7AJGyFP+BGnw/Uuqa3KVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=frldiOc5VDHqojsb0zfIsNJv444GxWFBb0BvOErSBalIknKghpvOooNYyWgcvZBZg/v+T26D2cxqDy0e9BWi9BWC4Yq8Etr71+7zwEPXAHsfryF+q7DihWuX3VgrRxodBk3YkIaHsf4ENaVS5yRVBhsGtJpa60xGAE7uOE9QtVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAzEGBoE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAzEGBoE"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1980161b3a.1
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755271796; x=1755876596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmdKslSkemJZT1zT2CS2vDgkEnYmH9VeGghTnXuqmRk=;
        b=nAzEGBoE+EO5jEygkybWsb/dNigsM6nRYUVfsn/ENfLDC/SHz8QfnmfVFAaTbpx7fl
         04Cd8nuudF+xRt+/kdus1nMyIAdnUaBIfQPZSS9Wl5qUnBlIKlt6mBfI8biAvsTSwfNa
         8xvLM4kmWBBTOroj2rTfD5Ib8e6Hs7woVGm6+AYSOQK5xlUXI7DI7m88kor9yriKA67C
         c5sBc7HRN3a9WVs8dDKMrH4fdYIjIrW3Z+N9FhnfOF7anqzcREpgeylxnHa38x+wbW5O
         9jjcIudwuxw4AbFLmbl584RHIA8y6oDxQkxK4bPZDuGEEwPuUMoftOFkjGsS+l5aU1lJ
         Rd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271796; x=1755876596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmdKslSkemJZT1zT2CS2vDgkEnYmH9VeGghTnXuqmRk=;
        b=rMIfq6+C9zUsMzMEbf6ebKqYomqjK8nvFiZzuQdJFgiHbGtuptabhA/589vdY/a2zz
         GaUM+E45sJovT9CMnxhSaR2maGBUnrtBJCsZz8hhxhzQDTFJ3H0050HeVUepoH8FqXAb
         YAiGeOEdSifv3qat0lON10PSHlxdf2s9WtdNVkJ0yRGuKitdZ/WlwyMDgAm5noikh9aS
         kt3Kfyw+E4jtUqkNilzpOapFLtUza9O4vezU2oX7ifLwhoO16tYtG4GKRJ9S+F/a3m5F
         V3ZaKHZUgE84PJrazgoKj3cUXVTVmReNkAjWBOhgSGJSdoPN8MDGibY/F0F6QYJ4ImEw
         5dhg==
X-Gm-Message-State: AOJu0YzoX6PMSb1kjv/RrNEP8vPQyj9a3Ay8puppdVT/Pp6slwtVU7U+
	R6Ot7fB7HGAfkHE7HCvJ78avpS3+mUAJpd7nZe6alIBAaUMd/NFYUL2X6dXwMg==
X-Gm-Gg: ASbGncsyfNRDsWYAP5g4gJcsFpAf4UYKj6Awst+hLW5AMhbFR08Au76Xp3LKpyZYG8D
	1Kdqr4qheLIqDbk+/sZ0Fu7hP3Y0wkwoLCNIyd0btiZKz+GlZWhcQyEN1CQ/4YBLAxdYlpaonfo
	Oor+Dq4Qd27Pp2dteniBZVdyk1yPPU1TeAi6wNtHNnV0Qz3iNGfD+jgnBLZ2JobA4I3ou/TXp6N
	sPR29V2c17qtcOtzmc+lqQhIYMkir8F3K48dSXHIUdZ+ohfvUXt3RgzaBfBYtqexMKKtj4Ro98S
	ML/eTTY0g2Q2FNelPDY7tB2fR2Qot41/Kvgtq7+oJr3EqRp9Pr3kf/VSQbMPTq/c2hK8wptxLbH
	lfkSUAhLIovkl3MjDikEHu5WSiKTQzF2tlBn7BDOb3eT068iwfjbf8oddZHV8Ng==
X-Google-Smtp-Source: AGHT+IFw6iHuILaJvgtTZBfgz8lE4lvF7GjzNzghOFGuK+eXL/h7t+y7wWD1x6U1Ob06Ev751115fg==
X-Received: by 2002:a05:6a21:9996:b0:23d:45b2:8e3c with SMTP id adf61e73a8af0-240d284f304mr3997584637.6.1755271795953;
        Fri, 15 Aug 2025 08:29:55 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8e83:7089:f932:3359:f50e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e452666besm1393260b3a.1.2025.08.15.08.29.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 Aug 2025 08:29:55 -0700 (PDT)
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
Subject: [GSoC PATCH v10 1/5] repo: declare the repo command
Date: Fri, 15 Aug 2025 10:55:17 -0300
Message-Id: <20250815135521.44044-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250815135521.44044-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250815135521.44044-1-lucasseikioshiro@gmail.com>
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

