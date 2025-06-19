Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED0228DF50
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373886; cv=none; b=mddbCokImYMETtyDX/Xio7O84fpBut/KwK3mveamzZ/H2iVK3C2DTZJaJHpQY7WJlq3EWUa8TuoU7k9ICr3kIYMsYqpkyuFHeyZzMa0MCjBGMd7nnSursEe80giMt9B90wNSl3pECaLSDWcrTHe4MlG1lUnAZD7S9R/SZEg8H5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373886; c=relaxed/simple;
	bh=cQg2Io/jICmU1eeCSyjvU7b+G3GqmYKIQ+d5oC3dDo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j8ehsU8TWVo3Otw6ElCQ/JPVh1xljgXYDLP+LdW2ZRfsF8vB2NodIexj7YJH5EtTBTRbUu7rIHSs0sBDYobeJIITKL+66cIOkEnuq7Admrp4QQTWMhTFVuiPtku85lQ3jCscTlvrtCCYbzX8Leb6I74lmMqzxzLGZp538WaecC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjRpiKTp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjRpiKTp"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234f17910d8so11068175ad.3
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 15:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750373884; x=1750978684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoJSHP5VWQEwFRjcG5aKrsKS78EjIhASySUotcu5ci4=;
        b=NjRpiKTpMw78U96E4DH7yrtDgQ7w5Dq8UlLMQzKL7LmQM5raJ6oXUHblr79R4f/Dn8
         Qdm/uOYT0ZS9eH5Re51pSMH8T19CEVtyeFqeFPVXEPPfrpwzirQlcUzE+mvYvOB84AcC
         IdTF02vkURk3AJna1f2AOIKNvcSUTalxhDupZaQDl7we3b/zG4NS00eDngmBMaz7zKEg
         9uPi2GgfI1XuRBczhjP9+9zUlQ2NSVZB/BzG0zGtbBj8SdiAr/ZcNpRJ7Rgmhzh77q+W
         YdTiH6MuF1mIYfXlnLigvLv+32nwtWxgikX2K42A7d85icNrLBaHa3LOjg7197TJirpn
         fgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750373884; x=1750978684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoJSHP5VWQEwFRjcG5aKrsKS78EjIhASySUotcu5ci4=;
        b=buyeoC/bRFrj1MYY7J1gu4YBBEFpLHMC+SAbGyn24tku+W9hcrI3bnaIlaao0sOFCN
         m9hJCss0Vo4mVRDScYC8O4BqQ/cuKJv4nJCOwStc1nDnkj/B1ZdcFxHcJHZtIYCZZ0X3
         qn6mrS4W+Cb8kYjPvhgzVZXVTNFRObY5DluHqEQs8bKvcKXdTwGwRJBbV860qhPxseu4
         f4WKxd1ibh/c1nVcFnBCgf7pcZrvE9iWQ0hWZZ55x8XB08K4pmSw0lU4c42GvUwAnxOM
         7gjaUEMJ2R8t08WraYfucNlBf0OTSeuth/MM22iiZWLzKUEtuGpzGVcbs0jnw2jrWET6
         JjiQ==
X-Gm-Message-State: AOJu0Yy2ngSk33zeHzh13mRL+n5oQeto12TS7UegNprORmoXyeDQHN2Z
	K6N5+xHlhOwg8cVkL8Re82/D0hyOqW6VarHo1AExjrlLwvAFIy46M+001Pe3ZA==
X-Gm-Gg: ASbGnctwStwPyxOh6BrIGTe6Hs5d4BW3w35qcJUChRBHW8kggP91VBwAWhf0HXD4PC+
	c8Ttry0YSossWztvHY2Cddx9btUL/ZuMs54UIcMH3etKc+LbLM29Xhn1rcjp0tZnYYAU70BTdtW
	TJ2O27OmXz1XwGFZmn7usqOQJpf8PeZlR+h/rEbN86dLcAdu2o9/HCLIglBhJaaaNNSMLpxpLps
	GAWeGXmzvfiaoNJZ4RY4/6/1zwqqHiCKEb++ZisMiHm84FoUSj2ZxYsDuprb0/a77dK+dcchU85
	iG01fz48aGfC7POYlCfmFI9f7vLoGcJvvZvifbD6tnfThFH8TGmtYPOuW+Sz/QI34TNaV0MH8o2
	Uen6XbTTeZeS/TRHWQA==
X-Google-Smtp-Source: AGHT+IGpSesRCj3CEK4AJAlewmQdDiSeYBWRUAucMBp32XEw/qXr29xaYaWQ43OllQSZFcuqpKNkvg==
X-Received: by 2002:a17:903:1a83:b0:234:c549:d9dd with SMTP id d9443c01a7336-237d9ac3da1mr7182215ad.48.1750373884157;
        Thu, 19 Jun 2025 15:58:04 -0700 (PDT)
Received: from localhost.localdomain ([179.100.18.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8695440sm3470515ad.185.2025.06.19.15.58.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Jun 2025 15:58:03 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v2 1/7] repo-info: declare the repo-info command
Date: Thu, 19 Jun 2025 19:57:45 -0300
Message-Id: <20250619225751.99699-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250619225751.99699-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
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

In option parsing, use PARSE_OPT_KEEP_UNKNOWN_OPT to allow the users
specify after the flags the information that they want to retrieve.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 .gitignore          |  1 +
 Makefile            |  1 +
 builtin.h           |  1 +
 builtin/repo-info.c | 21 +++++++++++++++++++++
 git.c               |  1 +
 meson.build         |  1 +
 6 files changed, 26 insertions(+)
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
index 0000000000..a5c43e253f
--- /dev/null
+++ b/builtin/repo-info.c
@@ -0,0 +1,21 @@
+#include "builtin.h"
+#include "parse-options.h"
+
+int cmd_repo_info(int argc,
+		  const char **argv,
+		  const char *prefix,
+		  struct repository *repo UNUSED)
+{
+	const char *const repo_info_usage[] = {
+		"git repo-info",
+		NULL
+	};
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, repo_info_usage,
+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 07a5fe39fb..27a2b3569b 100644
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

