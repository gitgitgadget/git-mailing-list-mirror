Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23328C865
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 22:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373890; cv=none; b=DTcnR0ismNbwpFevwFWeQ6qkpI9yx/cS7lWAnnb06m+VjpsFui4fR1rIwLTCrUihkFdf64+4FF0Nl1ZpMx1xijuaetIIy2GsD2o3j079c6EMAJkg8xzgHZmVI4JyGr1FmbF2PipFOVuH2ANx5Ft5+rlAkbfux9GPaJnkC9NSUrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373890; c=relaxed/simple;
	bh=8++GTSKzb/9Dc6KP5QZzZ0mwKKEo2EwnvyKhViz8j1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ijgmD3MNLEuCk9MXp7KMCBgnlzIGqKtLNNs6ILwx5dxDBktUHNtmsTFXik1GRimlqS220cOTtnirDqBYAu/CD7J6T5A/N+7MdRby3A4TrV7OuA5LzfFc+uqcI2ZVso8Dnj5nig5x5/9GW0GQnYNGtGyg9rrceHPR6xEPFI/NFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXjZSabz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXjZSabz"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23636167b30so11603075ad.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 15:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750373887; x=1750978687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BewiJFB36CJi+awHv4y8jA6Q2DVEZdQ8LxZ5HJAcgFw=;
        b=fXjZSabzodDn6T7u70M+e9wvgSZPH/IdCT3QBUrV41ODg3fdUYfh/NGX7iFtsQAfmG
         6cUZrbo+DGhbMRRfTekjMTOlrcg+3D15qQulG2h0/olLh/rSrEYjmUrTeuo67lUdOTMn
         kLs7LGQDKC3I11YNF0C0g5wBBKFzG3amAsAlYDYxvQt7LhdnkNV7N1edIZN9b3E2ECLz
         EQkpLOlejsQ6wUGtluokoWrUMec7/TlP1CLvVxZul0VQNcRK7Q2nhkJ3IcKIID6gberq
         DCrPe5KvmI3XWHEOah6hJmKYo+On8Vippd+Vdy+PBYDMQ5g2t6VdzSVw1ZNJHY8A81eN
         u6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750373887; x=1750978687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BewiJFB36CJi+awHv4y8jA6Q2DVEZdQ8LxZ5HJAcgFw=;
        b=X3zAQ83Vfmy2vpYo10QyF1A5vsqkW0Hgcun1uY2oBQvcVTZF1qh8tLG1m9A6gljbuk
         QLntQ31bY0Up34OjgWycAMbirXug7X2TIDcyJnYMW/XVyoxoilBnoncEKypXNalhLBj9
         pE23eVabCahkapu/hXCR8mE7BDsJ/RMvQaXZQkwT5Ab5NZMw8nLs3S1upZDukRsWXP9c
         q2vTdAVi+DZ9elOj/tWOU9R736ieo5JbWcmGtUiWvxvCCsLes9EVWHJohicT+R/Cu9Pl
         OiSeGimY6PFQaAeAh2qydHvMc+E6JoP2ufL56vGnBsiZtJsZ54lDUM3SqSaCwK9+YNHj
         gdeA==
X-Gm-Message-State: AOJu0Yz28sHUYuDR1miHZBAWBbJM3QP9qtCDDzpve9K4f2WSnnOdC0XG
	5RuqKhP+3jI4Hj4xuqxeI801+8i+e8xoisrWzQps7udT+BYahCVSxdRik7O2jQ==
X-Gm-Gg: ASbGncso+0xdutPWg0NEyMMA6VU+ciyDahgyLEyG6clraGs2YmvOwUNqnQ+2dVTIyWo
	PEdje//IUCx4UcrO/w5FmdyAZnD2YPG5XPJ3i/aG/tqy5G1xJ6xxD6cbuxpAFaAunM3JyRmQ6wD
	c+yWL907faAi29l3ZMz0aLMCsl2fP06Bs8bilGPFPKXAOb9/O8jg/QRBzaM/1IC+TFWzaKW1Aoz
	GtytsWkL+8/sjpoKqHD3Fh9qUvqOLUiatvQZ81RpWZ0O6T2dQ3M6RClRYN4IjucM+ldWB2uQzvZ
	/5kKdZeTA3wUSKRIgRBOsJFxDBeOFuFdgtHw2C1Nk0MgJqTTUg31VM5y8BLKEO37tj8dTMiDV82
	UWTnBEjbM2C38ktTIog==
X-Google-Smtp-Source: AGHT+IGKZJZSC5aIak6opBcJOeweZegyd7tCDhv/NWcxCccuipCR0LaIAjtCfQO7qpcS8wfc9QdRDQ==
X-Received: by 2002:a17:902:db02:b0:234:f580:a11 with SMTP id d9443c01a7336-237d98113cfmr7586205ad.19.1750373887384;
        Thu, 19 Jun 2025 15:58:07 -0700 (PDT)
Received: from localhost.localdomain ([179.100.18.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8695440sm3470515ad.185.2025.06.19.15.58.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Jun 2025 15:58:06 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v2 2/7] repo-info: add the --format flag
Date: Thu, 19 Jun 2025 19:57:46 -0300
Message-Id: <20250619225751.99699-3-lucasseikioshiro@gmail.com>
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

Add the --format flag to the repo-info command, allowing the user to
choose between output formats. Use 'json' by default.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo-info.c  | 54 +++++++++++++++++++++++++++++++++++++++++++-
 t/meson.build        |  1 +
 t/t1900-repo-info.sh | 22 ++++++++++++++++++
 3 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100755 t/t1900-repo-info.sh

diff --git a/builtin/repo-info.c b/builtin/repo-info.c
index a5c43e253f..cbe1475e30 100644
--- a/builtin/repo-info.c
+++ b/builtin/repo-info.c
@@ -1,21 +1,73 @@
 #include "builtin.h"
+#include "json-writer.h"
 #include "parse-options.h"
 
+enum output_format {
+	FORMAT_JSON
+};
+
+struct repo_info {
+	struct repository *repo;
+	enum output_format format;
+};
+
+static void repo_info_init(struct repo_info *repo_info,
+			   struct repository *repo,
+			   char *format)
+{
+	repo_info->repo = repo;
+
+	if (format == NULL || !strcmp(format, "json"))
+		repo_info->format = FORMAT_JSON;
+	else
+		die("invalid format %s", format);
+}
+
+static void repo_info_print_json(struct repo_info *repo_info UNUSED)
+{
+	struct json_writer jw;
+
+	jw_init(&jw);
+
+	jw_object_begin(&jw, 1);
+	jw_end(&jw);
+
+	puts(jw.json.buf);
+	jw_release(&jw);
+}
+
+static void repo_info_print(struct repo_info *repo_info)
+{
+	enum output_format format = repo_info->format;
+
+	switch (format) {
+	case FORMAT_JSON:
+		repo_info_print_json(repo_info);
+		break;
+	}
+}
+
 int cmd_repo_info(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  struct repository *repo)
 {
 	const char *const repo_info_usage[] = {
 		"git repo-info",
 		NULL
 	};
+	struct repo_info repo_info;
+	char *format = NULL;
 	struct option options[] = {
+		OPT_STRING(0, "format", &format, N_("format"),
+			   N_("output format")),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_info_usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT);
+	repo_info_init(&repo_info, repo, format);
+	repo_info_print(&repo_info);
 
 	return 0;
 }
diff --git a/t/meson.build b/t/meson.build
index 50e89e764a..d9ecaba3b7 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -246,6 +246,7 @@ integration_tests = [
   't1700-split-index.sh',
   't1701-racy-split-index.sh',
   't1800-hook.sh',
+  't1900-repo-info.sh',
   't2000-conflict-when-checking-files-out.sh',
   't2002-checkout-cache-u.sh',
   't2003-checkout-cache-mkdir.sh',
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
new file mode 100755
index 0000000000..f634e1a285
--- /dev/null
+++ b/t/t1900-repo-info.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+test_description='test git repo-info'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+parse_json () {
+	tr '\n' ' ' | "$PERL_PATH" "$TEST_DIRECTORY/t0019/parse_json.perl"
+}
+
+test_lazy_prereq PERLJSON '
+	perl -MJSON -e "exit 0"
+'
+
+test_expect_success PERLJSON 'json: returns empty output with allow-empty' '
+	git repo-info --format=json >output &&
+	test_line_count = 2 output
+'
+
+test_done
-- 
2.39.5 (Apple Git-154)

