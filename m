Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA972459EE
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568914; cv=none; b=fHlsHeUfQ6KvKBE6t/yXRXYFdd6sfX2e9KZLh4CpntqeYpCK3wGjDTg+KbBLAoR4Bi/8GU2N2kQoe6u5pTuXRFKDYkFdUTHCgch0kpvXyXTesS76FXAZ1yrzKkOd2ttzRuGJhuD/Ov3PBZCuEA9/ltsuVQEmtlrxYtM/fH5GKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568914; c=relaxed/simple;
	bh=iRbi6xx5rJNZXUll4jY3W84lOyBS7LQ9rES82mdqIGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRrDCDAra4v0TOAXnkNZ9ErINSdzAlrbXFhb3YY9pFZRnZE/qXLmpThxLXFTnOTGNf+Ln8f0EHaGi5VbArrKCPomf8TO9v1hA4jkdo5d4QMevtIZ9wxQehvIRuOSjT6w80xIVw7vsvZ3mUGjxr2j/6kVAPk2mrnfH7MHxzLA/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmYf55JQ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmYf55JQ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a43e277198so46515281cf.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 08:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749568911; x=1750173711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SUoF/gG7McQhqdIE+v9O9KRdq3uNw+UT4gh8LEr0ek=;
        b=WmYf55JQpI00kvl3yRYXdkCdDV9fwpx+ijY5CjkCML54dUcx8jSnWNpqMSvbW6kpVQ
         jxf5dZVGNyE13nCkgLatTtAYcBwMKss8IVLH7t+zwgpT3p3YQTetaMxmreLNXeYKTi4j
         3eAytYMzZAV0w+1JZYuFxH4qufpR3KXX20E24PGBvUSLOkg8ssUszq/CPF+SFD0acqbc
         RN2EDTzedyPPi4kOwRdQ347zyVyHESCkrk82Jo0aDrS/hJkgTzZc7hxtYGu1yTwXxJW7
         YKUorzcFCZaVnJv7wSUwVJGCuE6SmhsN+rP6gAYtoZbtVBYG+SaDWQ4KPqlRFYvRpsTp
         njng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568911; x=1750173711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SUoF/gG7McQhqdIE+v9O9KRdq3uNw+UT4gh8LEr0ek=;
        b=gjNcbmI7VZEJAhTgoZ36bMKHqOQjWokRn/XyZLjfhrFxg97wACl1kZeeoWm4Z07iG/
         HoH4ekLgdLapVjG9f/Y8RnObjt4GH6MmCQbeEPac+U1Gq01m0c/C45tqNvfxiQaahJ5I
         xaqYHcjTwW5KWhYKsN4mYztQv0QAGz0i5P0/uBY8dcBTvSYzSUc0rui714RHh0eMxEb+
         d6D7Gvc0iUkJYH+BBczLzKYkN6Ge7k+iie7t2iH6SGJ1vjXO+EByiPWUyOG9Z33V7XKu
         vFY3oo45IK9sfLSdxUDW9AgJWsuc5Sgx6VogGA0UetwYfbOjrsYneupo1dHvjhy/Px6I
         VAJA==
X-Gm-Message-State: AOJu0YwoBbi3s/GtCkZJbBKahfYDmSjDsOV7mbPBJ3TpS0AotfOzXhPs
	7bkbBqrfcHJYxf+cPYjanlLPYWkipchXfCf+RywuQNxWwxLZZxteosvM9uZyKw==
X-Gm-Gg: ASbGncvnRVAO3lr7tMYBZM/H2gt1NEzL3tEgI6F72gAhdhxgEYp0EF5qSDNoWPPj0LH
	7eXQCx6IZmVGHEgZ6x17NmVhQ8J4zLfG+oRdt66fOZv2YOlcEx82h8+dx+5a1/6dl7sjAOMRv3C
	8bWGIhafThHi7pKVCmdq5jvWtxrCAn+1clhh6ihcTWsshjyWM6HqvBdn/PFxV0yjatXNEu0ziYJ
	3eIwlRGTh1HoBlWc0tWVXU8WoFjUY96WzfLEtysXJuh4netbAEVKoK4RElENRQ8MlZs8/r7wkZt
	8yjl6i7709wfZ0ZEk6YPJKzduXWf1RE+6E+bGWDmItPGtHEzxADcXB70mTlPuhmdoPsteBYnVKX
	/VyspesVDtydNu7CJqKZ0vkvxhA==
X-Google-Smtp-Source: AGHT+IHAsZKPoo08ibxTiTtocMZC9bB8n7++QVIS10PFbDV/FBbB7OcnqCEEkEYN7OS9UlWoWtGZFA==
X-Received: by 2002:ac8:7dcd:0:b0:4a6:e7a8:65b2 with SMTP id d75a77b69052e-4a6e7a866a8mr218130531cf.10.1749568910346;
        Tue, 10 Jun 2025 08:21:50 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:93bc:ecb0:85aa:3d44:2d04])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87eeae4c86bsm1379180241.3.2025.06.10.08.21.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Jun 2025 08:21:49 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH 2/5] repo-info: add the --format flag
Date: Tue, 10 Jun 2025 12:21:14 -0300
Message-Id: <20250610152117.14826-3-lucasseikioshiro@gmail.com>
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

Add the --format flag to the repo-info command, allowing the user to
choose betwen the 'json' and 'plaintext' formats as output.

Also add a flag --allow-empty, which will force the output data to be
empty when no field is requested.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo-info.c  | 79 ++++++++++++++++++++++++++++++++++++++++++--
 t/meson.build        |  1 +
 t/t1518-repo-info.sh | 49 +++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 2 deletions(-)
 create mode 100755 t/t1518-repo-info.sh

diff --git a/builtin/repo-info.c b/builtin/repo-info.c
index 4615b988d8..4d539a17fb 100644
--- a/builtin/repo-info.c
+++ b/builtin/repo-info.c
@@ -1,22 +1,97 @@
 #include "builtin.h"
+#include "hash.h"
+#include "json-writer.h"
 #include "parse-options.h"
+#include "refs.h"
+
+enum output_format {
+	FORMAT_PLAINTEXT,
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
+			   char *format,
+			   int allow_empty UNUSED,
+			   int argc UNUSED,
+			   const char **argv UNUSED
+			   ) {
+	repo_info->repo = repo;
+
+	if (format == NULL || !strcmp(format, "json"))
+		repo_info->format = FORMAT_JSON;
+	else if (!strcmp(format, "plaintext"))
+		repo_info->format = FORMAT_PLAINTEXT;
+	else
+		die("invalid format %s", format);
+}
+
+static void repo_info_print_plaintext(struct repo_info *repo_info UNUSED) {
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
+	case FORMAT_PLAINTEXT:
+		repo_info_print_plaintext(repo_info);
+		break;
+	case FORMAT_JSON:
+		repo_info_print_json(repo_info);
+		break;
+	}
+}
 
 int cmd_repo_info(
 	int argc,
 	const char **argv,
 	const char *prefix,
-	struct repository *repo UNUSED
+	struct repository *repo
 	)
 {
 	const char *const repo_info_usage[] = {
 		"git repo-info",
 		NULL
 	};
+	struct repo_info repo_info;
+	char *format = NULL;
+	int allow_empty = 0;
 	struct option options[] = {
+		OPT_STRING(0,
+			     "format",
+			     &format,
+			     N_("format"),
+			     N_("output format")),
+		OPT_BOOL(0,
+			 "allow-empty",
+			 &allow_empty,
+			 "when set, it will use an empty set of fields if no field is requested"),
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, repo_info_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, repo_info_usage,
+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
+	repo_info_init(&repo_info, repo, format, allow_empty, argc, argv);
+	repo_info_print(&repo_info);
 
 	return 0;
 }
diff --git a/t/meson.build b/t/meson.build
index 50e89e764a..c24e197c60 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -241,6 +241,7 @@ integration_tests = [
   't1514-rev-parse-push.sh',
   't1515-rev-parse-outside-repo.sh',
   't1517-outside-repo.sh',
+  't1518-repo-info.sh',
   't1600-index.sh',
   't1601-index-bogus.sh',
   't1700-split-index.sh',
diff --git a/t/t1518-repo-info.sh b/t/t1518-repo-info.sh
new file mode 100755
index 0000000000..2e1a6f0c34
--- /dev/null
+++ b/t/t1518-repo-info.sh
@@ -0,0 +1,49 @@
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
+test_repo_info () {
+	label=$1
+	init_args=$2
+	key=$3
+	expected_value=$4
+
+	test_expect_success "json: $label" "
+		test_when_finished 'rm -rf repo' &&
+		git init $init_args repo &&
+		cd repo &&
+		echo '$expected_value' >expect &&
+		git repo-info '$key'| parse_json >output &&
+		grep -F 'row[0].$key' output | cut -d ' ' -f 2 >actual &&
+		test_cmp expect actual
+	"
+
+	test_expect_success "plaintext: $label" "
+		test_when_finished 'rm -rf repo' &&
+		git init $init_args repo &&
+		cd repo &&
+		echo '$expected_value' >expect &&
+		git repo-info --format=plaintext '$key' >actual &&
+		test_cmp expect actual
+	"
+}
+
+test_expect_success 'json: returns empty output with allow-empty' '
+	git repo-info --allow-empty --format=json >output &&
+	test_line_count = 2 output
+'
+
+test_expect_success 'plaintext: returns empty output with allow-empty' '
+	git repo-info --allow-empty --format=plaintext >output &&
+	test_line_count = 0 output
+'
+
+test_done
-- 
2.39.5 (Apple Git-154)

