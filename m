Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB3728D85D
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373899; cv=none; b=T4idQVvg/kFU4O/9sTnLqCKXO7HCd6SWclfiFS/+v3/4A5Xbem15kHRcQTc3wTv3SOOgJHMVwOGlAP3M38h+5EWO4MLQCUVxuHGvOJUaIsoc+5cHpFM+0PE9Hz9/K5c48Vt4sADpuSu9OO5ChcOqy/ct6XuemAKlPtixXQL/TPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373899; c=relaxed/simple;
	bh=hilTDbK/dBni5eMCB1r9fTqDbdtyWlMtmpY+SR5roHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RbQDirrmD3Dv85Wa1Tk6+brxt0qtjqpI+8yGDmkEolhO8tZfml4DCFyWTK/rbR86a9bFFRrvEl2URKVvRRCpEKljT51NUdsSMtl9o+Q0WtKBlf65Qw7l8W+ozUC4Vo+9pD2CdhEaFcE2fAO76x5z5mI1AjtPbi6oSl066WaIb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyWe+pKh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyWe+pKh"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2350b1b9129so9226935ad.0
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 15:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750373896; x=1750978696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06Njuc96iTaXZ5YpgYD+QhVXqMoOsx9KhzxcMPrDo1o=;
        b=iyWe+pKhbY2W9kqPSs93CLn1cG44rXNZWnPm25U0lZ53KDYcS4XvlXiNh8y0rYHU8q
         hDVLWAVIqsfnCabYgLoTyVJ35gBSdKpQMicvyalPbhd1gfxrqYITgKpak2gk7d1Dc1kt
         wdTPveewa/que72oFoE+f7U/ICtbQnKiM/0A/2r/+ut0PgCf0Pc0W/oOQE+efUy0gLhR
         CNkG0JborQzUTMS/qfObx/hfd3QM05YpWVvXLpqU5nkzZbUptvZaUlfDmGcRESQhkqFE
         2X1TAlUPCiptDCGxGpndILtO66dXbySr6Ln3iMihKxx4ZYtvPd5q5tq4fmqUI2LDpVTU
         Jz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750373896; x=1750978696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06Njuc96iTaXZ5YpgYD+QhVXqMoOsx9KhzxcMPrDo1o=;
        b=d1LUjSZbi6Te8UyiitGBoq+4qjZLggsztaNp3fOtDZTiu3tELpngMGFDgABU0k4O2D
         5V4jLKdoALHm4A5VHzamhjvKpkYulyU66hh8GiBcxiLzomwR+r0r2yzIqsOMW3t4Rrjb
         Xh/dIVeGyeh4Xzeygm4NEPJ9ZUdHt5rFNd4rukSOhxpTuMFcRW3pY7SNjcNhEAkTo8r/
         kC3d2e2K5jKdAS8VCk83A9zGK8A2lYf6lUU0OtCtdbMA4G1bPm+SH+J26g4fdhr+a+cm
         Ban+CnEAlQ//jNpj4bkRudKHYoqOc7t4iniRrn5FBxaBS6p00lQI6fLp/nspm/YV29iU
         QWoA==
X-Gm-Message-State: AOJu0YzBHsn6NnaiO0xTfSBv4vJPAE5VNDhcRk8OjtbgZfwLLZDi9xT5
	klOo+6gZAv5BFG+j9yPWNKPCr5FEP0p524ADsTT/FnqWt480geqJR6oQUGhD9w==
X-Gm-Gg: ASbGncvbTTf/cnM8N0M0WlvioCGWlOBSEF6LNZl78YwiJ9cLjZaFShpgQ2N0vnELp/C
	DFn0VmELDPUKUcLCT2ky9RGKVhRzUiLLpb1GqD3wWXU+8orqRIhDlYonfe5maaG41jNrP9mVZFx
	7B2fKFDSGmtxvzKZbB2dgoJDh/SFYaSVvW+IsKcbgeaQyfphtQ9OM9xJ++bMi/nJrXGC/km8/QL
	FMe/IKedhMcfYa23MPitr+cY1OFPuv10hVYpUoDwfW6fDn7OvtNwUzQjXY3+fL9Zu987bmp8229
	gqj0fxZRqaQ5en1lvFDxhQ+D/V/ACpkCurjeRicJShbjISpsLPKbQ6OvJz5b+Xczbf0K1yg+PdQ
	Ck0hSJMZg5lsX3njKcg==
X-Google-Smtp-Source: AGHT+IF7oCfoD7n4oVGvNjySB+ekdxLpe8D69gxXeFOPl/tw0+HOxbAqjmLzzsGE2miiPby6BpQ4ew==
X-Received: by 2002:a17:902:da47:b0:237:d25b:8f07 with SMTP id d9443c01a7336-237d9a00d6amr8290405ad.44.1750373896025;
        Thu, 19 Jun 2025 15:58:16 -0700 (PDT)
Received: from localhost.localdomain ([179.100.18.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8695440sm3470515ad.185.2025.06.19.15.58.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Jun 2025 15:58:15 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v2 5/7] repo-info: add the field references.format
Date: Thu, 19 Jun 2025 19:57:49 -0300
Message-Id: <20250619225751.99699-6-lucasseikioshiro@gmail.com>
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

Add the field references.format to the repo-info command. The data
retrieved in this field is the same that currently is obtained by
running `git rev-parse --show-ref-format`.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo-info.c  | 108 +++++++++++++++++++++++++++++++++++++++++--
 t/t1900-repo-info.sh |  58 +++++++++++++++++++++++
 2 files changed, 162 insertions(+), 4 deletions(-)

diff --git a/builtin/repo-info.c b/builtin/repo-info.c
index 6499be0eae..6ce3e6134f 100644
--- a/builtin/repo-info.c
+++ b/builtin/repo-info.c
@@ -1,21 +1,56 @@
 #include "builtin.h"
 #include "json-writer.h"
 #include "parse-options.h"
+#include "quote.h"
+#include "refs.h"
 
 enum output_format {
 	FORMAT_JSON,
 	FORMAT_PLAINTEXT
 };
 
+enum repo_info_category {
+	CATEGORY_REFERENCES = 1 << 0
+};
+
+enum repo_info_references_field {
+	FIELD_REFERENCES_FORMAT = 1 << 0
+};
+
+struct repo_info_field {
+	enum repo_info_category category;
+	union {
+		enum repo_info_references_field references;
+	} field;
+};
+
 struct repo_info {
 	struct repository *repo;
 	enum output_format format;
+	int n_fields;
+	struct repo_info_field *fields;
 };
 
+static struct repo_info_field default_fields[] = {
+	{
+		.category = CATEGORY_REFERENCES,
+		.field.references = FIELD_REFERENCES_FORMAT
+	}
+};
+
+static void print_key_value(const char *key, const char *value) {
+	printf("%s=", key);
+	quote_c_style(value, NULL, stdout, 0);
+	putchar('\n');
+}
+
 static void repo_info_init(struct repo_info *repo_info,
 			   struct repository *repo,
-			   char *format)
+			   char *format,
+			   int allow_empty,
+			   int argc, const char **argv)
 {
+	int i;
 	repo_info->repo = repo;
 
 	if (format == NULL || !strcmp(format, "json"))
@@ -24,19 +59,83 @@ static void repo_info_init(struct repo_info *repo_info,
 		repo_info->format = FORMAT_PLAINTEXT;
 	else
 		die("invalid format %s", format);
+
+	if (argc == 0 && !allow_empty) {
+		repo_info->n_fields = ARRAY_SIZE(default_fields);
+		repo_info->fields = default_fields;
+	} else {
+		repo_info->n_fields = argc;
+		ALLOC_ARRAY(repo_info->fields, argc);
+
+		for (i = 0; i < argc; i++) {
+			const char *arg = argv[i];
+			struct repo_info_field *field = repo_info->fields + i;
+
+			if (!strcmp(arg, "references.format")) {
+				field->category = CATEGORY_REFERENCES;
+				field->field.references = FIELD_REFERENCES_FORMAT;
+			} else {
+				die("invalid field '%s'", arg);
+			}
+		}
+	}
 }
 
-static void repo_info_print_plaintext(struct repo_info *repo_info UNUSED)
+static void repo_info_release(struct repo_info *repo_info)
 {
+	if (repo_info->fields != default_fields) free(repo_info->fields);
 }
 
-static void repo_info_print_json(struct repo_info *repo_info UNUSED)
+static void repo_info_print_plaintext(struct repo_info *repo_info) {
+	struct repository *repo = repo_info->repo;
+	int i;
+	for (i = 0; i < repo_info->n_fields; i++) {
+		struct repo_info_field *field = &repo_info->fields[i];
+		switch (field->category) {
+		case CATEGORY_REFERENCES:
+			switch (field->field.references) {
+			case FIELD_REFERENCES_FORMAT:
+				print_key_value("references.format",
+						ref_storage_format_to_name(
+							repo->ref_storage_format));
+				break;
+			}
+			break;
+		}
+	}
+}
+
+static void repo_info_print_json(struct repo_info *repo_info)
 {
 	struct json_writer jw;
+	int i;
+	unsigned int categories = 0;
+	unsigned int references_fields = 0;
+	struct repository *repo = repo_info->repo;
+
+	for (i = 0; i < repo_info->n_fields; i++) {
+		struct repo_info_field *field = repo_info->fields + i;
+		categories |= field->category;
+		switch (field->category) {
+		case CATEGORY_REFERENCES:
+			references_fields |= field->field.references;
+			break;
+		}
+	}
 
 	jw_init(&jw);
 
 	jw_object_begin(&jw, 1);
+
+	if (categories & CATEGORY_REFERENCES) {
+		jw_object_inline_begin_object(&jw, "references");
+		if (references_fields & FIELD_REFERENCES_FORMAT) {
+			const char *format_name = ref_storage_format_to_name(
+				repo->ref_storage_format);
+			jw_object_string(&jw, "format", format_name);
+		}
+		jw_end(&jw);
+	}
 	jw_end(&jw);
 
 	puts(jw.json.buf);
@@ -79,8 +178,9 @@ int cmd_repo_info(int argc,
 
 	argc = parse_options(argc, argv, prefix, options, repo_info_usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT);
-	repo_info_init(&repo_info, repo, format);
+	repo_info_init(&repo_info, repo, format, allow_empty, argc, argv);
 	repo_info_print(&repo_info);
+	repo_info_release(&repo_info);
 
 	return 0;
 }
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index db4a6aad17..d6e6f6ed1d 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -6,6 +6,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+DEFAULT_NUMBER_OF_FIELDS=1
+
 parse_json () {
 	tr '\n' ' ' | "$PERL_PATH" "$TEST_DIRECTORY/t0019/parse_json.perl"
 }
@@ -14,6 +16,45 @@ test_lazy_prereq PERLJSON '
 	perl -MJSON -e "exit 0"
 '
 
+# Test if a field is correctly returned in both plaintext and json formats.
+#
+# Usage: test_repo_info <label> <init command> <key> <expected value>
+#
+# Arguments:
+#   label: the label of the test
+#   init command: a command that creates a repository called 'repo', configured
+#      accordingly to what is being tested
+#   key: the key of the field that is being tested
+#   expected value: the value that the field should contain
+test_repo_info () {
+        label=$1
+        init_command=$2
+        key=$3
+        expected_value=$4
+
+        test_expect_success PERLJSON "json: $label" "
+                test_when_finished 'rm -rf repo' &&
+                '$SHELL_PATH' -c '$init_command' &&
+                cd repo &&
+                echo '$expected_value' >expect &&
+                git repo-info '$key' >output &&
+                cat output | parse_json >parsed &&
+                grep -F 'row[0].$key' parsed | cut -d ' ' -f 2 >value &&
+                cat value | sed 's/^0$/false/' | sed 's/^1$/true/' >actual &&
+                test_cmp expect actual
+        "
+
+        test_expect_success "plaintext: $label" "
+                test_when_finished 'rm -rf repo' &&
+                '$SHELL_PATH' -c '$init_command' &&
+                cd repo &&
+                echo '$expected_value' >expect &&
+                git repo-info --format=plaintext '$key' >output &&
+                cat output | cut -d '=' -f 2 >actual &&
+                test_cmp expect actual
+        "
+}
+
 test_expect_success PERLJSON 'json: returns empty output with allow-empty' '
 	git repo-info --allow-empty --format=json >output &&
 	test_line_count = 2 output
@@ -24,4 +65,21 @@ test_expect_success 'plaintext: returns empty output with allow-empty' '
 	test_line_count = 0 output
 '
 
+test_repo_info 'ref format files is retrieved correctly' '
+	git init --ref-format=files repo' 'references.format' 'files'
+
+test_repo_info 'ref format reftable is retrieved correctly' '
+	git init --ref-format=reftable repo' 'references.format' 'reftable'
+
+test_expect_success 'plaintext: output all default fields' "
+	git repo-info --format=plaintext >actual &&
+	test_line_count = $DEFAULT_NUMBER_OF_FIELDS actual
+"
+
+test_expect_success PERLJSON 'json: output all default fields' "
+	git repo-info --format=json > output &&
+	cat output | parse_json | grep '.*\..*\..*' >actual &&
+	test_line_count = $DEFAULT_NUMBER_OF_FIELDS actual
+"
+
 test_done
-- 
2.39.5 (Apple Git-154)

