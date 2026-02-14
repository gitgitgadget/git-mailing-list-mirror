Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA7321638D
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771030714; cv=none; b=fbE+N+QK3S27OI1h2Qbqmxq99jc2nh76E7qDwzkyKtt3ZSWTelCoqz08emxXFw4JaPGBu+vjOuwn0McAU83CYdkJbZyZb9nkcV+qLxiFrWtNozFwLDQ6McN/P1FLQlL2rr+PpHWhA+CscPpCqYrquHllpB2n+ZFkOOzX8gcY4GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771030714; c=relaxed/simple;
	bh=5g9HqDd7jppnM9ZlJMeB5PzpRlcRZXuhvUmmMWmFGXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoDifL+MIN7Z3BA/9HEJi9q3Q4YTbY2gy/8G1dxbn49vsGm9LIxfouOOCGrZ6Fg4kH3wrCUySVvikuYg4xuF/t3Imn5bZe9d5azptqx3vPtWCOjNdoZd7j8QwgMAL8fvoluVtZIy5vHf9myhGrkmI5D632Sc/7Ca///Hiaeb8ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FESMHKpg; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FESMHKpg"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-796d68083cdso23804397b3.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 16:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771030712; x=1771635512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6m/MQy5Z07BSPc8I/9/yx1IIJl7MB2oSO8xEOdh93M=;
        b=FESMHKpg9EwUIDcVa45Q28PcbE4Wh7y7IVjzG6obpXgzE+A6ZEWh6RClUfTRjGuinH
         uf0HgNzqOnnw+1/5KYknANDY7tIpB3sFQRVpR1DHDa/UvTpV+fdPE/rojWczKnNOGbmc
         DFKON6GoKSdj5T3UhKD+Dtzhbj6HZiJnN7E9iQFnHxEAXLQJ2VXJAjEOOw/gbF5/+e9I
         hhsNdWhevVYOorArO5ifaPa3pvV87vamIbrXyV5B/GB8XT8L0gGKjhPqMO3pFU9AaHMG
         HexqmhIYOr7PyDGjEP8pxzlSZHKZRmAoP5HT/wsPzYThVztCInOPLB+BYCd+QdJmr9m9
         Et3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771030712; x=1771635512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C6m/MQy5Z07BSPc8I/9/yx1IIJl7MB2oSO8xEOdh93M=;
        b=TpqnMUY6C2Iwi6Yw59YpcQX9BRZlmiBv71PZfggHe+XdI0nyS5yturpPdrbqhp2Zb8
         wLQ9eb3xzm7kAB/aIbfyJrHFjKju/d4u4qE6+wIrdHUxkz0XPA+eMA5bGQOBzU7vK2tt
         c7aLDIqA4NzrpHbgAffcoZ7iYIM7R7eIIUpXJAhIzOEEhRrs2mtL9tthbcaTDrI1fJfG
         Zf3tZi1S+CfbCYIR/J2Iqwsk98Rmzr1i5ga5mpcoSvyrTUoNJovpERgXIkOWZsR+Hwpu
         E0En1AwgbiHBUoTEKCNSQzwPooC9yDb3JPowFdPafHavYnSCRwJ6MgBmBZMlfDwFGIu6
         xpeg==
X-Gm-Message-State: AOJu0YwqiiJpAEpT3VF7g1unYX19i7kOBDtUC45adtMinp2Fp2w9E7rP
	JQOTeQG+2OvImw49FaRf03mCKc+YA1ZO6i89MfIEMjpcbx5lFgbw+3ZDl3gxuQ==
X-Gm-Gg: AZuq6aIFG8IBrjY3sAKKJnBxx5PAU0HbseFn2NBxakoqAPQWU0W7u0ELj5neRn6Ne1P
	YOfenuHKm8pcCRPQquFSk6w6ng5ij1RSr0GFy+scJpCyaNNm69CUbAzkWqkKhFf0cbm1OgpZKyc
	gRGwlY4ZoexsNuuKVKOcqJs1A/fHUgX6X9Q0JcDz64o1/7ONT5xCmn2wfk5gMwOcU2EFw7vxmm0
	LFJvQjZVlkl3FSWWmZyaqkWqI0o+HTdeGpzVssx/ixIM12bNFQQh8EVBIFinx4w0JmGNMsOZLLY
	xk/FKBmNyLU7wHWO9uL6ZRRL0qe06Jl/8U5t3kDNqvGtt0f6ZWLGMt2gaIrjSW2BweHn84+KRm7
	m++j1c7Da00K0VvcT7mbDObkeTvFHluY+6C93uVDdLi4pB9HAkq61oI8fx32B67UXmc3Li1ZszS
	tWsqHE78OqkEHhFg81EBK5ZBJX5aglaaTr3KGVnFp/WKa4SiUwQ4ldtQprIgAZsQ==
X-Received: by 2002:a05:690c:313:b0:796:203c:6829 with SMTP id 00721157ae682-797aa809c50mr17233007b3.3.1771030712112;
        Fri, 13 Feb 2026 16:58:32 -0800 (PST)
Received: from localhost.localdomain ([177.118.182.126])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c2533ccsm77824947b3.36.2026.02.13.16.58.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Feb 2026 16:58:31 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v6 1/2] repo: rename the output format "keyvalue" to "lines"
Date: Fri, 13 Feb 2026 21:35:15 -0300
Message-ID: <20260214005818.37349-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260214005818.37349-1-lucasseikioshiro@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20260214005818.37349-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both subcommands in git-repo(1) accept the "keyvalue" format. This
format is newline-delimited, where the key is separated from the
value with an equals sign.

The name of this option is suboptimal though, as it is both too
limiting while at the same time not really indicating what it
actually does:

  - There is no mention of the format being newline-delimited, which
    is the key differentiator to the "nul" format.

  - Both "nul" and "keyvalue" have a key and a value, so the latter
    is not exactly giving any hint what makes it so special.

  - "keyvalue" requires there to be, well, a key and a value, but we
    want to add additional output that is only going to be newline
    delimited.

Taken together, "keyvalue" is kind of a bad name for this output
format.

Luckily, the git-repo(1) command is still rather new and marked as
experimental, so things aren't cast into stone yet. Rename the
format to "lines" instead to better indicate that the major
difference is that we'll get newline-delimited output. This new name
will also be a better fit for a subsequent extension in git-repo(1).

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 21 +++++++++++----------
 builtin/repo.c              | 19 ++++++++++---------
 t/t1900-repo.sh             |  4 ++--
 t/t1901-repo-structure.sh   |  4 ++--
 4 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 7d70270dfa..693e1bbced 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,8 +8,8 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
-git repo structure [--format=(table|keyvalue|nul) | -z]
+git repo info [--format=(lines|nul) | -z] [--all | <key>...]
+git repo structure [--format=(table|lines|nul) | -z]
 
 DESCRIPTION
 -----------
@@ -19,7 +19,7 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-`info [--format=(keyvalue|nul) | -z] [--all | <key>...]`::
+`info [--format=(lines|nul) | -z] [--all | <key>...]`::
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
@@ -30,21 +30,22 @@ requested. The `--all` flag requests the values for all the available keys.
 The output format can be chosen through the flag `--format`. Two formats are
 supported:
 +
-`keyvalue`:::
+
+`lines`:::
 	output key-value pairs one per line using the `=` character as
 	the delimiter between the key and the value. Values containing "unusual"
 	characters are quoted as explained for the configuration variable
 	`core.quotePath` (see linkgit:git-config[1]). This is the default.
 
 `nul`:::
-	similar to `keyvalue`, but using a newline character as the delimiter
+	similar to `lines`, but using a newline character as the delimiter
 	between the key and the value and using a NUL character after each value.
 	This format is better suited for being parsed by another applications than
-	`keyvalue`. Unlike in the `keyvalue` format, the values are never quoted.
+	`lines`. Unlike in the `lines` format, the values are never quoted.
 +
 `-z` is an alias for `--format=nul`.
 
-`structure [--format=(table|keyvalue|nul) | -z]`::
+`structure [--format=(table|lines|nul) | -z]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
 +
@@ -61,17 +62,17 @@ supported:
 	change and is not intended for machine parsing. This is the default
 	format.
 
-`keyvalue`:::
+`lines`:::
 	Each line of output contains a key-value pair for a repository stat.
 	The '=' character is used to delimit between the key and the value.
 	Values containing "unusual" characters are quoted as explained for the
 	configuration variable `core.quotePath` (see linkgit:git-config[1]).
 
 `nul`:::
-	Similar to `keyvalue`, but uses a NUL character to delimit between
+	Similar to `lines`, but uses a NUL character to delimit between
 	key-value pairs instead of a newline. Also uses a newline character as
 	the delimiter between the key and value instead of '='. Unlike the
-	`keyvalue` format, values containing "unusual" characters are never
+	`lines` format, values containing "unusual" characters are never
 	quoted.
 +
 `-z` is an alias for `--format=nul`.
diff --git a/builtin/repo.c b/builtin/repo.c
index 0ea045abc1..23c5ee88b0 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -17,8 +17,8 @@
 #include "utf8.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
-	"git repo structure [--format=(table|keyvalue|nul) | -z]",
+	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
+	"git repo structure [--format=(table|lines|nul) | -z]",
 	NULL
 };
 
@@ -26,7 +26,7 @@ typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
 enum output_format {
 	FORMAT_TABLE,
-	FORMAT_KEYVALUE,
+	FORMAT_NEWLINE_TERMINATED,
 	FORMAT_NUL_TERMINATED,
 };
 
@@ -91,7 +91,7 @@ static void print_field(enum output_format format, const char *key,
 			const char *value)
 {
 	switch (format) {
-	case FORMAT_KEYVALUE:
+	case FORMAT_NEWLINE_TERMINATED:
 		printf("%s=", key);
 		quote_c_style(value, NULL, stdout, 0);
 		putchar('\n');
@@ -157,8 +157,8 @@ static int parse_format_cb(const struct option *opt,
 		*format = FORMAT_NUL_TERMINATED;
 	else if (!strcmp(arg, "nul"))
 		*format = FORMAT_NUL_TERMINATED;
-	else if (!strcmp(arg, "keyvalue"))
-		*format = FORMAT_KEYVALUE;
+	else if (!strcmp(arg, "lines"))
+		*format = FORMAT_NEWLINE_TERMINATED;
 	else if (!strcmp(arg, "table"))
 		*format = FORMAT_TABLE;
 	else
@@ -170,7 +170,7 @@ static int parse_format_cb(const struct option *opt,
 static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			 struct repository *repo)
 {
-	enum output_format format = FORMAT_KEYVALUE;
+	enum output_format format = FORMAT_NEWLINE_TERMINATED;
 	int all_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
@@ -185,7 +185,8 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
-	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
+
+	if (format != FORMAT_NEWLINE_TERMINATED && format != FORMAT_NUL_TERMINATED)
 		die(_("unsupported output format"));
 
 	if (all_keys && argc)
@@ -671,7 +672,7 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 		stats_table_setup_structure(&table, &stats);
 		stats_table_print_structure(&table);
 		break;
-	case FORMAT_KEYVALUE:
+	case FORMAT_NEWLINE_TERMINATED:
 		structure_keyvalue_print(&stats, '=', '\n');
 		break;
 	case FORMAT_NUL_TERMINATED:
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 51d55f11a5..4155211e5d 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -34,7 +34,7 @@ test_repo_info () {
 		eval "$init_command $repo_name"
 	'
 
-	test_expect_success "keyvalue: $label" '
+	test_expect_success "lines: $label" '
 		echo "$key=$expected_value" > expect &&
 		git -C "$repo_name" repo info "$key" >actual &&
 		test_cmp expect actual
@@ -115,7 +115,7 @@ test_expect_success '-z uses nul-terminated format' '
 
 test_expect_success 'git repo info uses the last requested format' '
 	echo "layout.bare=false" >expected &&
-	git repo info --format=nul -z --format=keyvalue layout.bare >actual &&
+	git repo info --format=nul -z --format=lines layout.bare >actual &&
 	test_cmp expected actual
 '
 
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 17ff164b05..a6f2591d9a 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -113,7 +113,7 @@ test_expect_success SHA1 'repository with references and objects' '
 	)
 '
 
-test_expect_success SHA1 'keyvalue and nul format' '
+test_expect_success SHA1 'lines and nul format' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -140,7 +140,7 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		objects.tags.disk_size=$(object_type_disk_usage tag)
 		EOF
 
-		git repo structure --format=keyvalue >out 2>err &&
+		git repo structure --format=lines >out 2>err &&
 
 		test_cmp expect out &&
 		test_line_count = 0 err &&
-- 
2.50.1 (Apple Git-155)

