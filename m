Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A7277CA3
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 23:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752537165; cv=none; b=E4zPUoX6tqcuEXq+uaRayw5XGvVWJvaiJdI/VM3wJpFSO23M7UJoflN/eHgx8ly7ia+EQANbileainOhn7nRs1vqcrmBVz8efxmdS/8YKV7L9S/PM4MqnXy7S3HQ2DWstPlTjXs1O+C/qjXRKl3PrKRdIE4yBn4LEowIYTmYnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752537165; c=relaxed/simple;
	bh=RuVLd7RNp45hBY0J545U6285umUMXW/Tf9+yIV3K39Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IXfD6N+r5Z6ebloBKwDcr18kq3qDSZFyTusIE38vLcRyJpJse5vwkzJX79lvptMfZ4CZY2i8wzFISfW0lBjBUG+KHAK2slkANlNX9c8Wu4HxLI8NTPEdiofUBxsTLosIku2gjMbvcg7YPYykRcUjfPq2KSYtudBEe21EwvU6CxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKWYkuv4; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKWYkuv4"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-531466622beso1990548e0c.1
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752537162; x=1753141962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNfqiC3eVFSiskpYvoGCkf0dLEQ6mt5PUSKjd7NLt4o=;
        b=bKWYkuv4N+HArsH3v/Y00T9+FVGWtUrRBXAoIokblj9cVXguZKybLdh9yAJbQapBy4
         k/RdG3vitrn92yPJa1FuGm/v3r+cm+PhFcveAqM1o8RAeytm+TVEQ7F5iD2x5SszeJVJ
         5x0f2kPbDAoEjPgeQk9o0ObENwHJV23Iwjs7OH79vvc9pf/ds0MNl4DAByUOPtZy3EYx
         IUH2Sz77L6BCLJ2r1s9oJVPHSRIqFUTKBFdvOOAh6G2o7BdeM3tC8avcDEdjrF0aCYaH
         ku3sZy6ZTegDkQheMjTZIvjAlonWE8xn7+H5WqrVgCtes1NKtxrzrABBf2ZyJeR8OEsF
         7MiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752537162; x=1753141962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNfqiC3eVFSiskpYvoGCkf0dLEQ6mt5PUSKjd7NLt4o=;
        b=eoc9si7YJAxFMlskCgQPA3mersr0Q+F5t7GDEtkPb8i3ThRYcTWNfezSqAfw+EIerc
         gxPrHmYKw5SAu6LbpfCM2bg2OzvfNGg7wzs33SeABkCld0/tpWNlj+6fZfDKoaWjC671
         0HK6SsbRQlvt+8dHJ8iKQUPsRHGih8g6IeFBfmUSkBzOvsKcazXOfVuM0zFFOsECIuMr
         ytng2xOVoiX+UURDGbgbr9L6pZBYTj5r8e3ZIFwuAVr26mulwhZd4qZZK1BmTA2/dY/9
         dYg/Kq14gyYI13pCbLPURmGX6ROojFINIeRrV2H5KEqn+5ToCbA0IOtp0/9f+DK9M14o
         Fuog==
X-Gm-Message-State: AOJu0YxXwqZZjMzcVcnvE4M5zTcqtyhmCn0X1J0D6C4fkpq7GWeTA8Dr
	xf4hYQEG5N21OOAMV6IJ0j5lxrjhpA9OLNFFxC1LR8SkPT79uADYTcIHoI2rDwFe
X-Gm-Gg: ASbGncuMOKewH9HijMq4Lv4WcFi9J8OqOy/eJ1CBXUvY53sqZ7De8Usgvk9fvMhXKGN
	zxdFfGfKXhMn3yTR30eBf0v/1/k5R08ntk8bGGese41tw6QF9tQdMRMcojA9W1/o+75aBCd9ECC
	TPOTymS/31OfbTQW388Agifw5C41QrwJgKW9q53adoeYQ6prySenqlv7t6M1xPmJTwPFLRJ0nhh
	9KCXy03wvUIXv1ifyrVLn3i0vplR1o02RUJxk93CEthOufEcjf2GTdNwGxnHkRxBz0OecMHNJ6g
	t2tpMa/kMNzYaPi2Dwzv5on+5whe+jms4Ejxxw00A7SY7aTjuPmPOyQZMIxV4CQtOFPRb936HrA
	mJ7lAVfIqT4UFlsDGr2ixxJYE/eGGzdXvu5GKGf7gSzQCYm2Eg2NLq6S54Kl0Gm8=
X-Google-Smtp-Source: AGHT+IEfoMMPNSQSYns0qc5Vyw9IC9h0UgTGoAQkxO5XVl8lYaOgiEO3x/2uu5DJpE7JOOwLj0E4Rw==
X-Received: by 2002:a05:6122:1e0d:b0:531:1904:203a with SMTP id 71dfb90a1353d-535f454ecccmr7735030e0c.0.1752537162578;
        Mon, 14 Jul 2025 16:52:42 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:fc3:f915:3491:9732:5741])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-535e73de3c8sm1999201e0c.48.2025.07.14.16.52.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Jul 2025 16:52:42 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v4 1/4] repo: declare the repo command
Date: Mon, 14 Jul 2025 20:52:28 -0300
Message-Id: <20250714235231.10137-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250714235231.10137-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, `git rev-parse` covers a wide range of functionality not
directly related to parsing revisions, as its name says. Over time,
many features like parsing datestrings, options, paths, and others
were added to it because there wasn't a more appropriated command
to place them.

Create a new Git command called `repo`. `git repo` will be the main
command for obtaining the information about a repository (such as
metadata and metrics), returning them in a machine readable format
following the syntax "field<LF>value<NUL>".

Also declare a subcommand for `repo` called `info`. `git repo info`
will bring the functionality of retrieving repository-related
information currently returned by `rev-parse`.

Also add entries for this new command in:

- the build files (Makefile, meson.build, Documentation/meson.build)
- builtin.h
- git.c
- .gitignore
- command-list.txt
- Documentation

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 .gitignore                  |  1 +
 Documentation/git-repo.adoc | 54 +++++++++++++++++++++++++++++++++++++
 Documentation/meson.build   |  1 +
 Makefile                    |  1 +
 builtin.h                   |  1 +
 builtin/repo.c              | 38 ++++++++++++++++++++++++++
 command-list.txt            |  1 +
 git.c                       |  1 +
 meson.build                 |  1 +
 9 files changed, 99 insertions(+)
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
index 0000000000..6f8fe3f6ea
--- /dev/null
+++ b/Documentation/git-repo.adoc
@@ -0,0 +1,54 @@
+git-repo(1)
+===========
+
+NAME
+----
+git-repo - Retrieve information about a repository
+
+SYNOPSIS
+--------
+[synopsis]
+git repo info [<key>...]
+
+DESCRIPTION
+-----------
+Retrieve information about the current repository in a machine-readable format.
+
+`git repo` will be the primary tool to query repository-specific information,
+such as metadata that currently can also be done by calling `git rev-parse` (see
+linkgit:git-rev-parse[1]). `git repo` doesn't query information unrelated to the
+current repository or that is already retrieved by a specialized command, for
+example, `git config` (see linkgit:git-config[1]) or `git var` (see
+linkgit:git-var[1]).
+
+This command returns the retrieved data following a null-terminated format with
+this syntax:
++
+----------------
+key1<LF>value1<NUL>
+key2<LF>value2<NUL>
+...
+----------------
++
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
+COMMANDS
+--------
+info [<key>...]::
+	Retrieve metadata-related information about the current repository. Only
+	the requested data will be returned based on their keys (see "INFO KEYS"
+	section below).
+
+INFO KEYS
+---------
+
+The set of data that `git repo` can return is grouped into the following
+categories:
+
+SEE ALSO
+--------
+linkgit:git-rev-parse[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 2fe1a1369d..1ebdd57789 100644
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
index 5f7dd79dfa..9dce446309 100644
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
index 0000000000..a1787a3cc5
--- /dev/null
+++ b/builtin/repo.c
@@ -0,0 +1,38 @@
+#include "builtin.h"
+#include "parse-options.h"
+
+static int repo_info(int argc UNUSED,
+		     const char **argv UNUSED,
+		     const char *prefix UNUSED,
+		     struct repository *repo UNUSED)
+{
+	return 0;
+}
+
+int cmd_repo(int argc,
+	     const char **argv,
+	     const char *prefix,
+	     struct repository *repo)
+{
+	parse_opt_subcommand_fn *fn = NULL;
+	const char *const repo_usage[] = {
+		"git repo info",
+		NULL
+	};
+	struct option options[] = {
+		OPT_SUBCOMMAND("info", &fn, repo_info),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+
+	if (fn) {
+		return fn(argc, argv, prefix, repo);
+	} else {
+		if (argc) {
+			error(_("unknown subcommand: `%s'"), argv[0]);
+			usage_with_options(repo_usage, options);
+		}
+		return 1;
+	}
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
index 07a5fe39fb..8290d8b8c8 100644
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
index 9579377f3d..15d3e3701f 100644
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

