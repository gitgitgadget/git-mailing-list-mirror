Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB76251792
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053902; cv=none; b=fB2nCMIJigxqI1n8kuSi48IWUhNY4ANa9Nnby5h9a121x5fgp/JuOXkhmaKkxOEdRJl87GlUOg85IlGSHRA6V2ExP7xi3VoU+TQBwWeL1Y7s2N9Q68f8My9mZZhKsYj9z+1MjUBFDfqBXdqFLoTcJllw0vHERZwlC0Dg/LKOUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053902; c=relaxed/simple;
	bh=HPDCmZdAyY7TbJkC7tI9CfT3RLu5kvLVQ9+Lznk/Ivs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5rjDX7Q3d4YPsOIUu8lDbNHC2u9LjK0M3gjBzhqJXSUTmKfvP0FtPvtOYyHQY8BG9LH1ESAQ+rgMLjZ+QNMJpX6OH3++pDEcbQ7hmClH+Mx/s7oCFLFTMgWdAAGr7BppbM1uWWgVK7gOh3fqJEOhrOYBr8EoZZ2juiwu8MoktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mbs0PeeZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mbs0PeeZ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76aea119891so2892857b3a.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 06:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754053900; x=1754658700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKRWcx1VsUZiZB8FuFM6dR36hiiBnoZYlPDOCU02Ywc=;
        b=Mbs0PeeZtygGba2PJPeIwkC4cNRyf559b5xyXd+Vm5169vrQz8qRv60LoeIcZflzTT
         m14IeOd1BwkAsSiFSUWDh8Kch9pY0k86njBW7r13GaFa7U8MBnPqMcwqsh7yhVoqDLgL
         k9m4zT2UC86oODUskGZNN74ncKmjBsF/uCH5kkxxtkaakuCix7nHU3pdD1BEVT1t6eVT
         0PUQpNKpbmbv95n+Mj/wVBxVFu8IDgG+B4U8S7cX6YSSxmbVieidNIxP/uTGUyjCLRZ2
         Ll/hhOm/G4dHlXk++90TILeyJdZ2x2JZWDlxogbn6TWAhdGKyGGmlMP+w56ah/Lp1530
         FlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754053900; x=1754658700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKRWcx1VsUZiZB8FuFM6dR36hiiBnoZYlPDOCU02Ywc=;
        b=IxFlikDFYX3bpVtmfIWeMZXmoboOVw6hk0Klbk8QxABa54N4OIO1KVjYa34+7Ok1D8
         D6wMiSqClqrB2soKxv9Ix+rO0J86HR6UUV/f3qzWd5tVNEolz1EvR5oNQ+qPucr6C3oA
         KvdlPXeDRJ1kr1Gy2flvpTUxqQ87rIn2GpqtfTzp2QmGFFU07WIS7cwi91e9BcTqPWQt
         wSmfrPTOul42DpB+qdLJF/xMAtxAV2cS3NA8y49QgRRFf6adG8gvcdZoBb9DP/Ph8CdH
         4E1B0xLggEYFpeA7NxsG0Rec4b3dYdsIR2FFa7Tx/rsu8rmgIRMghATnJ8gRciBbBhXQ
         kKWQ==
X-Gm-Message-State: AOJu0Yy3XgGCqaS7NwUcDdqGzjePq6I8K6WA2CXT2cv3x929WrD78DUA
	z85C0RaqeSuNRdftbuXj012oGtgMcukOihDxtiebBInhX+3+nUVNoTnrwITeOt6h
X-Gm-Gg: ASbGncvwKHWTUU9sDmRa+mdi9fcbxaELVWDM9sjvzrXkE3WLXo7LqyIGbXBcUSEFWS/
	siSmcHb8D9O2mUqIt2lV0eAY4kFcGJ40rjhS6E7hoDjkLs5s0BTyLVkxkpXd8nf7T0cuO7CVlIk
	PY0hHLahSuVQGIhxr72MbNSS+aVCKCrLufLTw6a0dZvetHoGdKuQOoOti0PFXCcZbMuFopV8MIQ
	BGh4k2JmatHdsgPYbTemtR3rnh/UDwVrowUgKaolBz+PAUCBR5p6y2epMIbma+UdDrxiewBK9iw
	3s6YC1c8y/WVAcsHf8tcyPSKSFJBT/0+gfl96/zZdZW/RILOdB/fItl8TWm1/hAfVsD+EeiY2Ew
	WJ4CBX9Mi3/x11HWMTaWHenoJtiMahvwhTnYj+hj+NIMI2kxE0OVI9lsPn5UcOpYbZQ==
X-Google-Smtp-Source: AGHT+IHprzpH1v58XwO0U8ulGaCpK9X0L+IDdvBINwQT2atSj2lgsOIPd5q1ivKSEOZY+BeIvEyO9A==
X-Received: by 2002:a05:6a20:94ca:b0:232:22a4:bd50 with SMTP id adf61e73a8af0-23dd7af497amr11691249637.9.1754053900018;
        Fri, 01 Aug 2025 06:11:40 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8c1d:878:ec5d:4583:4785])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7e4fc1sm3542272a12.28.2025.08.01.06.11.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Aug 2025 06:11:39 -0700 (PDT)
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
Subject: [GSoC PATCH v7 5/5] repo: add the --format flag
Date: Fri,  1 Aug 2025 10:11:10 -0300
Message-Id: <20250801131111.8115-6-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250801131111.8115-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the --format flag to git-repo-info. By using this flag, the users
can choose the format for obtaining the data they requested.

Given that this command can be used for generating input for other
applications and for being read by end users, it requires at least two
formats: one for being read by humans and other for being read by
machines. Some other Git commands also have two output formats, notably
git-config which was the inspiration for the two formats that were
chosen here:

- keyvalue, where the retrieved data is printed one per line, using =
  for delimiting the key and the value. This is the default format,
  targeted for end users.
- nul, where the retrieved data is separated by null characters, using
  the newline character for delimiting the key and the value. This
  format is targeted for being read by machines.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 31 +++++++++++++++++++-
 builtin/repo.c              | 58 +++++++++++++++++++++++++++++++------
 t/t1900-repo.sh             | 21 ++++++++++++--
 3 files changed, 97 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 140ee3a0aa..b735cf4737 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -18,12 +18,23 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-`info [<key>...]`::
+`info [--format=<keyvalue|nul>] [<key>...]`::
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
 +
 The returned data is lexicographically sorted by the keys.
++
+The output format can be chosen through the flag `--format`. Two formats are
+supported:
++
+* `keyvalue`: output key-value pairs one per line using the `=` character as
+the delimiter between the key and the value. This is the default.
+
+* `nul`: similar to `keyvalue`, but using a newline character as the delimiter
+between the key and the value and using a null character after each value.
+This format is better suited for being parsed by another applications than
+`keyvalue`.
 
 INFO KEYS
 ---------
@@ -43,6 +54,24 @@ The reference storage format. The valid values are:
 +
 include::ref-storage-format.adoc[]
 
+
+Examples
+--------
+
+* Retrieves the reference format of the current repository:
++
+------------
+git repo info references.format
+------------
++
+
+* Retrieves whether the current repository is bare and whether it is shallow
+using the `nul` format:
++
+------------
+git repo info --format=nul layout.bare layout.shallow
+------------
+
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
diff --git a/builtin/repo.c b/builtin/repo.c
index 56c3a4027f..4015cf88b7 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -9,12 +9,17 @@
 #include "shallow.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [<key>...]",
+	"git repo info [--format=<keyvalue|nul>] [<key>...]",
 	NULL
 };
 
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
+enum output_format {
+	FORMAT_KEYVALUE,
+	FORMAT_NUL_TERMINATED,
+};
+
 struct field {
 	const char *key;
 	get_value_fn *get_value;
@@ -74,18 +79,33 @@ static int qsort_strcmp(const void *va, const void *vb)
 	return strcmp(a, b);
 }
 
-static int print_fields(int argc, const char **argv, struct repository *repo)
+static int print_fields(int argc, const char **argv,
+			struct repository *repo,
+			enum output_format format)
 {
 	int ret = 0;
 	const char *last = "";
 	struct strbuf sb = STRBUF_INIT;
 
+	char kv_sep;
+	char field_sep;
+
+	switch (format) {
+	case FORMAT_KEYVALUE:
+		kv_sep = '=';
+		field_sep = '\n';
+		break;
+	case FORMAT_NUL_TERMINATED:
+		kv_sep = '\n';
+		field_sep = '\0';
+		break;
+	}
+
 	QSORT(argv, argc, qsort_strcmp);
 
 	for (int i = 0; i < argc; i++) {
 		get_value_fn *get_value;
 		const char *key = argv[i];
-		char *value;
 
 		if (!strcmp(key, last))
 			continue;
@@ -100,11 +120,14 @@ static int print_fields(int argc, const char **argv, struct repository *repo)
 		strbuf_reset(&sb);
 		get_value(repo, &sb);
 
-		value = strbuf_detach(&sb, NULL);
-		quote_c_style(value, &sb, NULL, 0);
-		free(value);
+		if (format == FORMAT_KEYVALUE) {
+			char *value;
+			value = strbuf_detach(&sb, NULL);
+			quote_c_style(value, &sb, NULL, 0);
+			free(value);
+		}
 
-		printf("%s=%s\n", key, sb.buf);
+		printf("%s%c%s%c", key, kv_sep, sb.buf, field_sep);
 		last = key;
 	}
 
@@ -112,10 +135,27 @@ static int print_fields(int argc, const char **argv, struct repository *repo)
 	return ret;
 }
 
-static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
+static int repo_info(int argc, const char **argv, const char *prefix,
 		     struct repository *repo)
 {
-	return print_fields(argc - 1, argv + 1, repo);
+	const char *format_str = "keyvalue";
+	enum output_format format;
+	struct option options[] = {
+		OPT_STRING(0, "format", &format_str, N_("format"),
+			   N_("output format")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+
+	if (!strcmp(format_str, "keyvalue"))
+		format = FORMAT_KEYVALUE;
+	else if (!strcmp(format_str, "nul"))
+		format = FORMAT_NUL_TERMINATED;
+	else
+		die(_("invalid format '%s'"), format_str);
+
+	return print_fields(argc, argv, repo, format);
 }
 
 int cmd_repo(int argc, const char **argv, const char *prefix,
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 6706cb4c44..463ec3af92 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -21,10 +21,17 @@ test_repo_info () {
 	key=$4
 	expected_value=$5
 
-	test_expect_success "$label" '
-		eval "$init_command $repo_name" &&
+	test_expect_success "keyvalue: $label" '
+		eval "$init_command keyvalue-$repo_name" &&
 		echo "$key=$expected_value" >expected &&
-		git -C $repo_name repo info "$key" >actual &&
+		git -C keyvalue-$repo_name repo info "$key" >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "nul: $label" '
+		eval "$init_command nul-$repo_name" &&
+		printf "%s\n%s\0" "$key" "$expected_value" >expected &&
+		git -C nul-$repo_name repo info --format=nul "$key" >actual &&
 		test_cmp expected actual
 	'
 }
@@ -45,6 +52,7 @@ test_repo_info 'shallow repository = false is retrieved correctly' '
 	git init' 'nonshallow' 'layout.shallow' 'false'
 
 test_repo_info 'shallow repository = true is retrieved correctly' '
+	test_when_finished "rm -rf remote" &&
 	git init remote &&
 	echo x >remote/x &&
 	git -C remote add x &&
@@ -79,4 +87,11 @@ test_expect_success 'output is returned correctly when two keys are requested' '
 	git -C two-keys repo info layout.bare references.format
 '
 
+test_expect_success 'git-repo-info aborts when requesting an invalid format' '
+	test_when_finished "rm -f err expected" &&
+	echo "fatal: invalid format '\'foo\''" >expected &&
+	test_must_fail git repo info --format=foo 2>err &&
+	test_cmp expected err
+'
+
 test_done
-- 
2.39.5 (Apple Git-154)

