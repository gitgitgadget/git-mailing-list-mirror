Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8C02459C7
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568916; cv=none; b=ucl3hIJLmjnBRhHGTiIbTapz6k4WMJW5O00NxJuT2er2YyYdAd3nD+Z/RMeCLEA4YQqkjoyTXoD3VK3TliyumunK1bNKQMeDc4WfRR/4BBBClYzvUcriuhyJompMRJ8o0VVbfLWHZpxnhSj6py7h0Yh0cIdq4ew2PamtNeC/W+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568916; c=relaxed/simple;
	bh=NHgN15fMpxB+hXkoWXRQhy5YdwJ+I+qfLa3QRjbeG4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tBgtiE+R21ScKm4Rxvz27MhY9zRJlO4tIWOOnoTm1LQI1915RXDnYxfaJ8R45AFnFZneqDQf26Nug9bZ4vkEhbiVPhA7nId0ZDcyBITsQeXR8VpniFrhvfmep962Dft1TYWDTq0OWRG5p9ReFgQSyclqb9WJpLwy/ubC3HiNVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TA/0XTLT; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA/0XTLT"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a589b7dd5fso93254931cf.0
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 08:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749568913; x=1750173713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNa0AAuTH9wUe0OsPGFzizTW8L0HKiL2FkEBu612DZI=;
        b=TA/0XTLTVj+McsIG2BDAUNQt1G7MNZ3bk3KsAtgXo+r7oqwj3qkgIZl/c8aW6ep5I0
         qTdtL4/eaV6h3LXaCGBGuz7PqHd/NdDU2VMHpAjvSDgEKrlNZRyHnvbXl0ZjKQpDu1tD
         ZMGcMDS1kcaywBid7XP+CKcFTsuI2++XX0CjGFlsa8uIaj0Woj/ifBVv3wBt4pWDtrMc
         Fcm5Tl6lXOp3msbuk+SFxWagosD03JvWBcTb7bj/GwX1W2JlMCFLd0RHDVVrg6lmI+gH
         A5rmAKGNeNtOmOJB7DXy0jyllAfNvRUZJ8CtgLhpv3pbeZ8ucieI/Ze94JKsGxb77YVh
         4Fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568913; x=1750173713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNa0AAuTH9wUe0OsPGFzizTW8L0HKiL2FkEBu612DZI=;
        b=uETjbfQ1RUvJhGCbSylf4Sp3VRtPoRtwx0d4zaWzNJhvA0bbsKWq3gAFWaKIc40H2q
         1ET8Hyw9SKcyvPA7QUoULN57jlPkKR7VdJXrr9qeM1M6TStjUa8GUVLyfe4HFFcQEhn3
         fD6kl4Dn3F0XScNopqmw+k/YvyEiNshQxuQQUGKj8sGXNQbNQar1kZcvp3m2ajaxRVkr
         Cg702oPjnKeWkF2XkCe0cLjdKhi2lG7tklHmiKkXoAjsfYd/fzM6Nn7rCle7kqPIeV2v
         FfGYWSpZItjUetD/wLtLfSzIvfUp/p0Xl3Eg/sxJxSr6lL3Ria9st/xE+APpGJou7Mmw
         yppA==
X-Gm-Message-State: AOJu0Yx4tBt8+7aHQtsxorXUTBMzMgnZjJVqPzZSNShdNJ1nw8S0Q3/L
	fENZt54w1Ol/FCIR7Zna2kTAzKOlP2K9eVikZTCkXFnECWnGCO7KtlDVGrCS2g==
X-Gm-Gg: ASbGncv6hQRfCs1cmZXFmyiyfr8UN/0QgycPAnIba60fvqOt4Hti3BI4k38ZwlLvWp0
	JXCmc+D9mfPXEojunNWQcz8QQLw5ZDJ8txrThC0RltlTxFunqKmSBn819KX+jJlThWUltOBcFab
	WeEW9/h6cTHjWJ86FcSeT9fnR5NCpOoJeFH75Id8IF4WHxIxgOM4GXvy3icM0NYym1snkcdRtQP
	DBrsMxpsaZ9vmAtxENIinpJyGWBILbfqXQOJrAIzDh/hLwhK8PKEUSgy4sI2EIubba3Hxh1P+Q+
	O9VkntuNCYRJhWsEAaeRaLR3hg3Na+nahNO4qUL7GWEJPAqCMyLDDrIMKJgBkLqcCIkLv3BFxTD
	ds3RPQgTJh1IeEIaLQy4EV2q1Lg==
X-Google-Smtp-Source: AGHT+IHyMOgzzSvf0sA48hpjZhxpAow0sZ42PtNZFq4W38mj9FoZ/dv2OV+We7AELO819E/MnQODsw==
X-Received: by 2002:a05:622a:559b:b0:4a5:a5fb:d3fa with SMTP id d75a77b69052e-4a5b9db18e4mr267222431cf.47.1749568912746;
        Tue, 10 Jun 2025 08:21:52 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:93bc:ecb0:85aa:3d44:2d04])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87eeae4c86bsm1379180241.3.2025.06.10.08.21.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Jun 2025 08:21:52 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH 3/5] repo-info: add the field references.format
Date: Tue, 10 Jun 2025 12:21:15 -0300
Message-Id: <20250610152117.14826-4-lucasseikioshiro@gmail.com>
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

Add the field references.format to the repo-info command. The data
retrieved in this field is the same that currently is obtained by
running `git rev-parse --show-ref-format`.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo-info.c  | 97 +++++++++++++++++++++++++++++++++++++++++---
 t/t1518-repo-info.sh | 20 +++++++++
 2 files changed, 112 insertions(+), 5 deletions(-)

diff --git a/builtin/repo-info.c b/builtin/repo-info.c
index 4d539a17fb..a1c9d3942e 100644
--- a/builtin/repo-info.c
+++ b/builtin/repo-info.c
@@ -9,18 +9,40 @@ enum output_format {
 	FORMAT_JSON
 };
 
+enum repo_info_category {
+	CATEGORY_REFERENCES = 1
+};
+
+enum repo_info_references_field {
+	FIELD_REFERENCES_FORMAT = 1
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
+};
+
+const char *default_fields[] = {
+	"references.format",
 };
 
 static void repo_info_init(struct repo_info *repo_info,
 			   struct repository *repo,
 			   char *format,
-			   int allow_empty UNUSED,
-			   int argc UNUSED,
-			   const char **argv UNUSED
+			   int allow_empty,
+			   int argc,
+			   const char **argv
 			   ) {
+	int i;
 	repo_info->repo = repo;
 
 	if (format == NULL || !strcmp(format, "json"))
@@ -29,18 +51,82 @@ static void repo_info_init(struct repo_info *repo_info,
 		repo_info->format = FORMAT_PLAINTEXT;
 	else
 		die("invalid format %s", format);
+
+	if (argc == 0 && !allow_empty) {
+		argc = ARRAY_SIZE(default_fields);
+		argv = default_fields;
+	}
+
+	repo_info->n_fields = argc;
+	repo_info->fields = xmalloc(argc * sizeof(struct repo_info_field));
+
+	for (i = 0; i < argc; i++) {
+		const char *arg = argv[i];
+		struct repo_info_field *field = repo_info->fields + i;
+
+		if (!strcmp(arg, "references.format")) {
+			field->category = CATEGORY_REFERENCES;
+			field->field.references = FIELD_REFERENCES_FORMAT;
+		}
+		else {
+			die("invalid field '%s'", arg);
+		}
+	}
+}
+
+static void repo_info_release(struct repo_info *repo_info) {
+	free(repo_info->fields);
 }
 
-static void repo_info_print_plaintext(struct repo_info *repo_info UNUSED) {
+static void repo_info_print_plaintext(struct repo_info *repo_info) {
+	struct repository *repo = repo_info->repo;
+	int i;
+	for (i = 0; i < repo_info->n_fields; i++) {
+		struct repo_info_field *field = &repo_info->fields[i];
+		switch (field->category) {
+		case CATEGORY_REFERENCES:
+			switch (field->field.references) {
+			case FIELD_REFERENCES_FORMAT:
+				puts(ref_storage_format_to_name(
+					repo->ref_storage_format));
+				break;
+			}
+			break;
+		}
+	}
 }
 
-static void repo_info_print_json(struct repo_info *repo_info UNUSED)
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
@@ -92,6 +178,7 @@ int cmd_repo_info(
 			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 	repo_info_init(&repo_info, repo, format, allow_empty, argc, argv);
 	repo_info_print(&repo_info);
+	repo_info_release(&repo_info);
 
 	return 0;
 }
diff --git a/t/t1518-repo-info.sh b/t/t1518-repo-info.sh
index 2e1a6f0c34..a99198b0f6 100755
--- a/t/t1518-repo-info.sh
+++ b/t/t1518-repo-info.sh
@@ -6,6 +6,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+DEFAULT_NUMBER_OF_FIELDS=1
+
 parse_json () {
 	tr '\n' ' ' | "$PERL_PATH" "$TEST_DIRECTORY/t0019/parse_json.perl"
 }
@@ -46,4 +48,22 @@ test_expect_success 'plaintext: returns empty output with allow-empty' '
 	test_line_count = 0 output
 '
 
+test_repo_info 'ref format files is retrieved correctly' \
+	'' \
+	'references.format' 'files'
+
+test_repo_info 'ref format reftable is retrieved correctly' \
+	'--ref-format=reftable' \
+	'references.format' 'reftable'
+
+test_expect_success 'plaintext: output all default fields' "
+	git repo-info --format=plaintext >actual &&
+	test_line_count = $DEFAULT_NUMBER_OF_FIELDS actual
+"
+
+test_expect_success 'json: output all default fields' "
+	git repo-info --format=json | parse_json | grep '.*\..*\..*' >actual &&
+	test_line_count = $DEFAULT_NUMBER_OF_FIELDS actual
+"
+
 test_done
-- 
2.39.5 (Apple Git-154)

