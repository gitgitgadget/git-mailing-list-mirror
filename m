Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A82242905
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568911; cv=none; b=AfvsXp0onZi8lKVbneEdFqL5cDduqq6qGWGaCI7y9ExN6HZLlwmoa2/+gBg8IeOP6xwgwgjVywOiTavJXj7fh6lVI9zmFHZJDQJn4Wmbz+P2pJgxCHR+sDlgXG5TdXN3SxDXPxcrVj2e3JEPYj/qsDyJ2++ikfs2KGWWDKol1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568911; c=relaxed/simple;
	bh=MGpXmUI+I/prVqQ+floeM1+k15DbWCSJCnxow/H6FR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JaeDmyc8MMm/B7oa7rm3FtWqVx8q6n/cr8M540JT7ObjQZ7re+T74a1H69EYC3YoLk5885xYnXSzc3bMhtEzWkgrI+RuRZeFvO1M66BesIkn99fkZ4pp0SdOGaGJ6NJX4Re67av6Xbb7rVujDVOyDlU2rOviK8RIWrET/eOqA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsRPPkaM; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsRPPkaM"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a44b9b2af8so35059721cf.3
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 08:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749568908; x=1750173708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoTfLCO9PgWIy5uydo7E3UTzTPJ9upV0HueDTERF5IE=;
        b=hsRPPkaMDsA+zLOJ+vpjFjRAOn5S+yHgPpeuwp4nG+0t1eEkaQDdR7KSHtYr3TU94j
         8lNyu6MF6sWV5ZPwEkHvtBbB0JH1iM+ZqToBD9+j/Idw6cpXoUdn5aXjGifvc7JwAOip
         a22m0Kea39p8j+0r/Z6G9DaW/GpRg3vP4qzEO4oe3loh3wLVQa3bpt1VqbMwdgoGhRvs
         xa+nDNmQIvxLSw/0N8aSSsiP7KP7HJjCPspxP3E1REe2bKiNOTI16J8otWwdsRzOB0GJ
         MSK6zGsyX3w3BnFBSfCpUZYejEzizn3phvRvq8C+EXaNLJMHUDIp2YoHU2tSY/1wGbig
         pHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568908; x=1750173708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoTfLCO9PgWIy5uydo7E3UTzTPJ9upV0HueDTERF5IE=;
        b=rDWxV2pLuMitKjClqnO9IfZQj93ncK8t9ltT0oar+57U22S0B+5WhhiEwpFWBaNOhq
         qiPUmtwe3HktoVAKq8HfmDdEU4mO9Oa8grJKtL5Mt9Rs7dWBAbOxPLs03tWzN3vDaFg5
         6fHQQ9d74NeFXOnwf4sqTdKbs7wTNIi8OLugChBT5Pv7w8wEI5vmJPS/uktCRpd2G9IJ
         MPUjqdsURvJMesmUz+IVMZd3frUXovYvadnjwKNN4zhiTb1UGuUVcn9q8LyAAQ/PIsIB
         g/oymAvJbMil4BskMWaC7HJZJhRAXRWN5tKpy+MoycSeQmQgZ9n+9voijvW+HKGkcGCY
         Dplw==
X-Gm-Message-State: AOJu0Yw3evPqv/QVLFj2m/BrzlYbgLQRU39SyJImaWiv7rPPKdxwNieb
	TBseeUvT/QspnKyftfakG11sEUTTdwjFbgmDl0smZ7Muxr7L0U+NjeKIUfsJIw==
X-Gm-Gg: ASbGnctdHve/cKBRgjk7HfzvTXvfHjjPyOozGKPpCoVn0GbX1usok2P4SUUHsDRc27v
	JGOwMn1DvA/8EdYMi3q+iF1S3vlfmm8Lz7NsqEFU3hYaH3nuNdp/07NwSfxka2mggHOn64fUvXy
	AOi2bEqPvzvduYfPWQxrqFQrHRY1jMsD2A4yfZmK170Pfb7ML6yryN/RhD1hwwbLGvCrp5MZjc/
	ltbGvRq3O9GCwe6XofWCaaUW1TE7XSxzBz1rZDdDaCENS+0pPLO80RO3klm85w8iQHxFowkPT1S
	3ooZfP1VeCu1sKGgSPdJJkOO9yHBMILmuaYfku2LPiT3VDH/H3eovS3m4CT5Kg9KCglDcJVbW6b
	JLeHJRKxgX+ytqOY14gwkizC1Jw==
X-Google-Smtp-Source: AGHT+IGG7aharX4KAkK6tF8I3sLgdT5faXr128tCfv7ys4kTn2d1IPCgYba85J0ZoGtpz661siFcGg==
X-Received: by 2002:a05:622a:4a86:b0:4a4:2e32:5a25 with SMTP id d75a77b69052e-4a5b9d327c2mr232825781cf.24.1749568908012;
        Tue, 10 Jun 2025 08:21:48 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:93bc:ecb0:85aa:3d44:2d04])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87eeae4c86bsm1379180241.3.2025.06.10.08.21.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Jun 2025 08:21:47 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH 1/5] repo-info: declare the repo-info command
Date: Tue, 10 Jun 2025 12:21:13 -0300
Message-Id: <20250610152117.14826-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a new Git subcommand called repo-info. `git repo-info` will query
metadata from the current repository and outputs it as JSON or plaintext.

Also add entries for this new command in:

- the build files (Makefile and meson.build)
- builtin.h
- git.c
- .gitignore

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 .gitignore          |  1 +
 Makefile            |  1 +
 builtin.h           |  1 +
 builtin/repo-info.c | 22 ++++++++++++++++++++++
 git.c               |  1 +
 meson.build         |  1 +
 6 files changed, 27 insertions(+)
 create mode 100644 builtin/repo-info.c

diff --git a/.gitignore b/.gitignore
index 04c444404e..b2f3fb0047 100644
--- a/.gitignore
+++ b/.gitignore
@@ -139,6 +139,7 @@
 /git-repack
 /git-replace
 /git-replay
+/git-repo-info
 /git-request-pull
 /git-rerere
 /git-reset
diff --git a/Makefile b/Makefile
index 70d1543b6b..50e3a3cbcc 100644
--- a/Makefile
+++ b/Makefile
@@ -1308,6 +1308,7 @@ BUILTIN_OBJS += builtin/remote.o
 BUILTIN_OBJS += builtin/repack.o
 BUILTIN_OBJS += builtin/replace.o
 BUILTIN_OBJS += builtin/replay.o
+BUILTIN_OBJS += builtin/repo-info.o
 BUILTIN_OBJS += builtin/rerere.o
 BUILTIN_OBJS += builtin/reset.o
 BUILTIN_OBJS += builtin/rev-list.o
diff --git a/builtin.h b/builtin.h
index bff13e3069..cc6bc95962 100644
--- a/builtin.h
+++ b/builtin.h
@@ -216,6 +216,7 @@ int cmd_remote_ext(int argc, const char **argv, const char *prefix, struct repos
 int cmd_remote_fd(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_repack(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_replay(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_repo_info(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_rerere(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_reset(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_restore(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/repo-info.c b/builtin/repo-info.c
new file mode 100644
index 0000000000..4615b988d8
--- /dev/null
+++ b/builtin/repo-info.c
@@ -0,0 +1,22 @@
+#include "builtin.h"
+#include "parse-options.h"
+
+int cmd_repo_info(
+	int argc,
+	const char **argv,
+	const char *prefix,
+	struct repository *repo UNUSED
+	)
+{
+	const char *const repo_info_usage[] = {
+		"git repo-info",
+		NULL
+	};
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, repo_info_usage, 0);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 7c37872a88..d1774de82f 100644
--- a/git.c
+++ b/git.c
@@ -611,6 +611,7 @@ static struct cmd_struct commands[] = {
 	{ "repack", cmd_repack, RUN_SETUP },
 	{ "replace", cmd_replace, RUN_SETUP },
 	{ "replay", cmd_replay, RUN_SETUP },
+	{ "repo-info", cmd_repo_info, RUN_SETUP },
 	{ "rerere", cmd_rerere, RUN_SETUP },
 	{ "reset", cmd_reset, RUN_SETUP },
 	{ "restore", cmd_restore, RUN_SETUP | NEED_WORK_TREE },
diff --git a/meson.build b/meson.build
index 7fea4a34d6..06f2f647ba 100644
--- a/meson.build
+++ b/meson.build
@@ -645,6 +645,7 @@ builtin_sources = [
   'builtin/repack.c',
   'builtin/replace.c',
   'builtin/replay.c',
+  'builtin/repo-info.c',
   'builtin/rerere.c',
   'builtin/reset.c',
   'builtin/rev-list.c',
-- 
2.39.5 (Apple Git-154)

