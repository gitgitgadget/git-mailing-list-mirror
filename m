Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9393111BB
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343469; cv=none; b=Fs7mZrrmdWFEeD2iQujqoUC3PgatvAWDC3UoPkL9jdcqf72Nq8AHNJFZjjdhRqtAzmcKK9EtjNgdYMgSRE8BGXw5t1BvGp7ovKpcBuQcbOkAUhYxrULYIIRvCFknXC2lG7iKTOyQQLrSaSV3g3eKNBO1xplrJM7e94d9NUa9skg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343469; c=relaxed/simple;
	bh=YzF6nQgP7KUyHf9cAcLl8MWtV7azejRejAKM6N9aN+U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fv9iOmQ/u1FMF43d54MYn5swDH2f9sGT5LERpkWIIryywL9olsX04NM1QjkEIdCj+yp8kJ808zo9zMyy5p0jXV+kiMCUOIwxCBp6p91rp2wGLQfp22/Ybmj66ycuagiRQRLXdhGU7kwWYk/LD4KDlGs6MupLFMP591sJCv3/XrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4co39wc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4co39wc"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34c0f5f5cd0so3120623f8f.2
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 15:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714343466; x=1714948266; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzuacz24RkQLzVJk3LE2c4+sz1xjIlAMNjLoUa8zGSA=;
        b=N4co39wclxchVruokvb+UKpI2PhS6Hd4bYYRIvUFn0y+1Vga4HqWuSScHxgZC4RYIj
         Yws1i9a74CpeA9/mN/IP1YwoetYy4qlq1bOH4bFt/X7F7Bs3KueAsVE43qRZ0kkPhQIs
         TxCZZTFrFsNno6Xzfyz5T+ig3NmVxfJ+Kb1HDihCc5gia+Q/0KGB5sugMFF2bMmoOeXN
         MZMet8abZ0QsXqXAsFDEJKXbIW8igb0PEQEzp0yr3DNSLRxwmQmDlvFQb+KpYnuHuVi8
         YX1HP+XMmx5PA6M/DggX5f6w7UOdmauVAKD9IPYkqZNGogds2Ly9pBKrJHguPdgcobmu
         8f8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343466; x=1714948266;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzuacz24RkQLzVJk3LE2c4+sz1xjIlAMNjLoUa8zGSA=;
        b=eTLiVL8mISacL+QyemCzq8SgAePDkEarkwVRKEbI4A/5R+Iiwogv862c9syvHo99pE
         u8GJAhhU2F1TS96gQF7ePAwNQgWoDlqgvtccer9wfek03WJo7e1ljo4oH/Shln0+cNDD
         OuwmTLLLmH1Gp97beDkaQy004QddYo0AJA4wdftUCRdy2UydC6NzKAhxnt+VReMeE3zK
         yr2gQ0qrxul2mO1VKRqfyPWl/qJ9ZXXR4Zugh+2gbbUH1SMZK+ID4fW186ZF8vPBp3pP
         Q6zfGKEewhWI3nXw0T2o3kE/p1dpPcVHeVW1dPudo/grxL9EXODkXe6qBv6XixspADj8
         WORQ==
X-Gm-Message-State: AOJu0YwCnkObA8BQr4HXIeX4AnMltc7Ho1wlLlqpoRVDUeLY6rCo1EdZ
	ein8kAHABTOtXob2hgZk5QaXdvHakitxp0Z2FxzBPpmxrSb9E7WctOo+ZA==
X-Google-Smtp-Source: AGHT+IFXQ6V5NVenn4AuqLwnQp8N0smsoKWVad30H5+fh854D8VYM/S1YllrudiYaRyRhBU5x/SoQA==
X-Received: by 2002:a05:6000:1447:b0:34d:354:b9ba with SMTP id v7-20020a056000144700b0034d0354b9bamr1522934wrx.30.1714343465443;
        Sun, 28 Apr 2024 15:31:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4-20020adff3c4000000b00343c1cd5aedsm27873834wrp.52.2024.04.28.15.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:31:05 -0700 (PDT)
Message-Id: <e4781b36d546ee7ab43566c8c7f5f0c68064b249.1714343461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Apr 2024 22:30:51 +0000
Subject: [PATCH 03/13] builtin: create url-parse command
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Matheus Moreira <matheus.a.m.moreira@gmail.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

Git commands can accept a rather wide variety of URLs syntaxes.
The range of accepted inputs might expand even more in the future.
This makes the parsing of URL components difficult since standard URL
parsers cannot be used. Extracting the components of a git URL would
require implementing all the schemes that git itself supports, not to
mention tracking its development continuously in case new URL schemes
are added.

The url-parse builtin command is designed to solve this problem
by exposing git's native URL parsing facilities as a plumbing command.
Other programs can then call upon git itself to parse the git URLs and
extract their components. This should be quite useful for scripts.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 .gitignore          |  1 +
 Makefile            |  1 +
 builtin.h           |  1 +
 builtin/url-parse.c | 18 ++++++++++++++++++
 command-list.txt    |  1 +
 git.c               |  1 +
 6 files changed, 23 insertions(+)
 create mode 100644 builtin/url-parse.c

diff --git a/.gitignore b/.gitignore
index 612c0f6a0ff..4f8dde600a5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -174,6 +174,7 @@
 /git-update-server-info
 /git-upload-archive
 /git-upload-pack
+/git-url-parse
 /git-var
 /git-verify-commit
 /git-verify-pack
diff --git a/Makefile b/Makefile
index 1e31acc72ec..b6054b5c1f4 100644
--- a/Makefile
+++ b/Makefile
@@ -1326,6 +1326,7 @@ BUILTIN_OBJS += builtin/update-ref.o
 BUILTIN_OBJS += builtin/update-server-info.o
 BUILTIN_OBJS += builtin/upload-archive.o
 BUILTIN_OBJS += builtin/upload-pack.o
+BUILTIN_OBJS += builtin/url-parse.o
 BUILTIN_OBJS += builtin/var.o
 BUILTIN_OBJS += builtin/verify-commit.o
 BUILTIN_OBJS += builtin/verify-pack.o
diff --git a/builtin.h b/builtin.h
index 28280636da8..e8858808943 100644
--- a/builtin.h
+++ b/builtin.h
@@ -240,6 +240,7 @@ int cmd_update_server_info(int argc, const char **argv, const char *prefix);
 int cmd_upload_archive(int argc, const char **argv, const char *prefix);
 int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix);
 int cmd_upload_pack(int argc, const char **argv, const char *prefix);
+int cmd_url_parse(int argc, const char **argv, const char *prefix);
 int cmd_var(int argc, const char **argv, const char *prefix);
 int cmd_verify_commit(int argc, const char **argv, const char *prefix);
 int cmd_verify_tag(int argc, const char **argv, const char *prefix);
diff --git a/builtin/url-parse.c b/builtin/url-parse.c
new file mode 100644
index 00000000000..994ccec4b2e
--- /dev/null
+++ b/builtin/url-parse.c
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * url-parse - parses git URLs and extracts their components
+ *
+ * Copyright © 2024 Matheus Afonso Martins Moreira
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2.
+ */
+
+#include "builtin.h"
+#include "gettext.h"
+
+int cmd_url_parse(int argc, const char **argv, const char *prefix)
+{
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index c4cd0f352b8..6d89b6c4dc6 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -196,6 +196,7 @@ git-update-ref                          plumbingmanipulators
 git-update-server-info                  synchingrepositories
 git-upload-archive                      synchelpers
 git-upload-pack                         synchelpers
+git-url-parse                           plumbinginterrogators
 git-var                                 plumbinginterrogators
 git-verify-commit                       ancillaryinterrogators
 git-verify-pack                         plumbinginterrogators
diff --git a/git.c b/git.c
index 654d615a188..7aac812d9d4 100644
--- a/git.c
+++ b/git.c
@@ -625,6 +625,7 @@ static struct cmd_struct commands[] = {
 	{ "upload-archive", cmd_upload_archive, NO_PARSEOPT },
 	{ "upload-archive--writer", cmd_upload_archive_writer, NO_PARSEOPT },
 	{ "upload-pack", cmd_upload_pack },
+	{ "url-parse", cmd_url_parse, NO_PARSEOPT },
 	{ "var", cmd_var, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "verify-commit", cmd_verify_commit, RUN_SETUP },
 	{ "verify-pack", cmd_verify_pack },
-- 
gitgitgadget

