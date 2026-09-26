Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A994A37C90E
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790439657; cv=none; b=RPMxi8B78LcpNUjqzUhjeF63QXxLebeVFGJEMiRX8mYzK8daeZw4JHpabjhL3H36MpNkSbuiVX22FdsiiReXGqnluWgycGhw41sX5KkTU97eRcfDvI1VT4wVQqpCf/FGns5yMh0A2RoVgUAf1RGIRzf7Z7OAmt8FofRjwAVOqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790439657; c=relaxed/simple;
	bh=Dpq5VoPv1kT3g0sYZcyQy3hN9Q20dfgYWJVKy8jw4Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5QLhgBVBv7LV8nDVfeA2wdxoDnUvBbvcfZamQJ86AfPKU9MQE5sdqscESirxMFY11k43YtiDY7BfSxvnIjgtgC1R/c0a13bc1Z/KE9wb1tR8OAEJdADQUuE66aGIxOr+RLO0lADiFLadDfwzPOF2Tmz8FSLPdXv0wuMwBa8VkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9y2+Ern; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9y2+Ern"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5b166acdso56672685a.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790439653; x=1791044453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f76pQ5EpaKyxZo2K2g+C4FI1+aYl3vV+bKhg0Hb1A/E=;
        b=S9y2+ErnNsiAfRv6gAGxTsuCvzNqFcWerTtdwhUgmhoFlHXEIEUEmFXFkYdycA3KLQ
         TCQTQ1Plo9OUfYBvn2HpVnDWHN5cbvE9/J8CqHb82XXTsSgKezDMsY/K5dSCAposozRv
         oqz/otji0Y3dWQ8U5Hh/2TEw0z4xSMcHkvXvnDFoUb15s4gkESxobODWgQREU7VR+QwC
         6oR0Puar0//a9fE+YwJStJa0SRZ2PS3IEyYZxfjX9onuxccW6ZJxrWlOzzb5ugFo67+V
         D2skC/1/1uuXbI6ELkaM/D0iGp258jIZ9unVw9lAADpsDVqUmOhu1PcxYmJv9K4aFI/+
         /A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790439653; x=1791044453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f76pQ5EpaKyxZo2K2g+C4FI1+aYl3vV+bKhg0Hb1A/E=;
        b=GSq66VNrgKAh1TiHi4QBAEwxwzg/Orw0k0VG3JmjzXbecADzjFq7oUmMIxXOBneZDD
         V6rFMRj0J68KYlHaYOetr5IHQ2CYEwo5T+iMsVle5ptsfRrLEUZ0XVyj2AO6qH/zmxtC
         uUUrwbJ0evdpsrMB/cndaOzc4pJ2DN402E3Npvhy3W1Y+Wap/GZU0GdblKQsuQ3pWkRf
         r43DFBYYRDGigwlO+4uEsY9Kz65kf0uDSkknwXKk9lfMbk2ouFRgw4fqK70hPx+JmkE2
         YD3tM/rNV1sUguI0WNR+vuE4EdlJG0XzQPCgT5r8uP7eWcdodLejCLmhsjgDoHi0UT8B
         Ez6Q==
X-Gm-Message-State: AFuF++m+clpbXdZotWlIHg5aqOJL6a6PbaafqbMxSSqb7K0zmVwLX/sj
	rgd996hV3FuGtVE0OiF0KuYI++ZPrL4UV5BGTGS95liq44d7l5UND46imNO0mnhw/A/Raw==
X-Gm-Gg: AYBFou2/B6COhH9jMOERN01FQ7n2cAHkUDujp/r6rSPxuWcTOSPGQS0q7v/m4qyzCAi
	ZjkHDlf2YSXWhPhFJFykqirImyyC43FvTQxWZEE3cFPPUw4rr7IZMDV9hNXmWYVW/oEF/pP/z0x
	ADpstnNLG2bwJI9sIteA2kF48QooNRWXSML4PZLRLg3SAiHoqRbnSoXe7oM4ST8z1SD8522Ze0X
	MrGOZqz7o49rJy7gcWofG8i2WI0dRoMCvUv1vMYJY0+UgftkGIHgDqosQ24PX1+pLWFL32XojYA
	c3FO9bZyZ66CrEXW0eHc/aRf4HSrzgi0PmZziv0fdp2pYdTblFjYF0bfNngpAoW8UaDhw4cIBUI
	+nya85Tv53ozvz0l/sQs+fIbWl539KGTQWTRa7EoSSQ4TiHiS7k3Tt6EVa3ZgBMvu8VaoTXr2YF
	YfBYt6Brmz+trhwerm3mMiW05haGEZy/PRTFh1QTXZg6MXbWdnjCFNXiIJ1TQyVAAjENDW6uQDs
	l9Rz4FnwmQ0YthNYaw85p09sXcNpBNJzPnMt2MtIEVxxhFrWak9gm9PdP60HwJ9sbZbVOUBisNq
	ojq5G4xwsy58JLcGlwJYCKenYjKU3T9NpLk13kSX0QJak6FpYImw
X-Received: by 2002:a05:620a:2956:b0:93c:6993:f648 with SMTP id af79cd13be357-93c699423f5mr98588485a.29.1790439652697;
        Sat, 26 Sep 2026 09:20:52 -0700 (PDT)
Received: from localhost.localdomain ([2603:7002:a00:5733:58df:3319:3c13:321f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c448ae8ecsm440919985a.9.2026.09.26.09.20.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 09:20:52 -0700 (PDT)
From: Andrew Pleeter <andrewpleeter@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	ben.knoble@gmail.com,
	peff@peff.net,
	sandals@crustytoothpaste.net
Subject: [PATCH v9 3/4] var: accept more than one variable
Date: Sat, 26 Sep 2026 12:20:47 -0400
Message-ID: <20260926162048.30853-4-andrewpleeter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqq33va1lcg.fsf@gitster.g>
References: <xmqq33va1lcg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git var" takes exactly one variable and shows its value, so a script
that needs several of them has to run the command once per variable,
paying process startup and configuration parsing each time.

Teach "git var" to take any number of variables and show them the way
"git var -l" does, i.e. as "VARIABLE=value" (or "VARIABLE\nvalue\0"
under "-z"), but limited to the variables the user asked for.  A single
variable still shows its bare value, and still exits with status 1 when
it has no value, so existing users are unaffected.

When more than one variable is asked for, a variable that has no value
is simply left out of the output and the rest are still shown.  That a
variable is unset is not an error in itself: a caller asking for both
GIT_CONFIG_SYSTEM and GIT_CONFIG_GLOBAL should not be told that
something went wrong merely because the user set GIT_CONFIG_NOSYSTEM.
Keeping a non-zero status for genuine errors, such as naming a variable
that does not exist, also lets callers detect those by looking at the
exit code alone.

Signed-off-by: Andrew Pleeter <andrewpleeter@gmail.com>
---
 Documentation/git-var.adoc | 32 +++++++++++-------
 builtin/var.c              | 56 +++++++++++++++++++------------
 t/t0007-git-var.sh         | 67 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 32 deletions(-)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index 9052fbc549..d0772d9743 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -10,17 +10,22 @@ SYNOPSIS
 --------
 [synopsis]
 git var [-z] -l
-git var [-z] <variable>
+git var [-z] <variable>...
 
 DESCRIPTION
 -----------
-Prints a Git logical variable. Exits with code 1 if the variable has
-no value.
+Prints Git logical variables. When a single variable is requested, its
+bare value is printed, and the command exits with code 1 if it has no
+value. When multiple variables are requested, they are printed as
+`VARIABLE=value` pairs, separated by newlines; a variable that has no
+value is omitted from the output, which is not by itself an error.
 
-If `-z` is given, the value is terminated by a NUL byte instead of a
-newline. With `-l`, the variable name and its value are separated by a
-newline, and each entry is terminated by a NUL byte
-(`VARIABLE\nvalue\0`), in the same way as `git config list -z`.
+If `-z` is given, the output format changes depending on the mode:
+
+* With a single variable, the bare value is terminated by a NUL byte.
+* With multiple variables or with `-l`, the variable name and value are
+  separated by a newline, and each entry is terminated by a NUL byte
+  (`VARIABLE\nvalue\0`), in the same way as `git config list -z`.
 
 OPTIONS
 -------
@@ -32,8 +37,9 @@ OPTIONS
 
 `-z`::
 	Terminate entries with NUL instead of newline. When used with
-	`-l`, the variable name and its value are separated by a
-	newline, and each entry is terminated with a NUL byte.
+	`-l` or when multiple variables are requested, the variable name
+	and its value are separated by a newline, and each entry is
+	terminated with a NUL byte.
 
 EXAMPLES
 --------
@@ -97,9 +103,11 @@ endif::git-default-pager[]
     This variable can have multiple values.
 
 Most path values contain only one value. However, some can contain multiple
-values, which are separated by newlines (or NUL bytes if `-z` is given), and are
-listed in order from highest to lowest priority.  Callers should be prepared for
-any such path value to contain multiple items.
+values, which are separated by newlines (or NUL bytes if `-z` is given),
+and are listed in order from highest to lowest priority. When querying
+multiple variables (or using `-l`), each value is output as a separate
+`VARIABLE=value` entry (or `VARIABLE\nvalue\0` with `-z`). Callers should
+be prepared for any such path value to contain multiple items.
 
 Note that paths are printed even if they do not exist, but not if they are
 disabled by other environment variables.
diff --git a/builtin/var.c b/builtin/var.c
index c9691070b8..5fbebc62e2 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -23,7 +23,7 @@
 
 static const char * const var_usage[] = {
 	N_("git var [-z] -l"),
-	N_("git var [-z] <variable>"),
+	N_("git var [-z] <variable>..."),
 	NULL
 };
 
@@ -225,9 +225,9 @@ int cmd_var(int argc,
 	    const char *prefix,
 	    struct repository *repo UNUSED)
 {
-	const struct git_var *git_var;
 	int list = 0;
 	int nul_term = 0;
+	char delim;
 	char term;
 	struct option options[] = {
 		OPT_BOOL('l', NULL, &list,
@@ -248,36 +248,52 @@ int cmd_var(int argc,
 		return 0;
 	}
 
-	if (argc != 1)
+	if (!argc)
 		usage_with_options(var_usage, options);
 
 	repo_config(the_repository, git_default_config, NULL);
 
+	delim = nul_term ? '\n' : '=';
 	term = nul_term ? '\0' : '\n';
 
-	git_var = get_git_var(argv[0]);
-	if (!git_var)
-		usage_with_options(var_usage, options);
+	for (int i = 0; i < argc; i++) {
+		const struct git_var *git_var = get_git_var(argv[i]);
 
-	if (git_var->read) {
-		char *val = git_var->read(IDENT_STRICT);
+		if (!git_var)
+			usage_with_options(var_usage, options);
 
-		if (!val)
-			return 1;
+		if (git_var->read) {
+			char *val = git_var->read(IDENT_STRICT);
 
-		printf("%s%c", val, term);
-		free(val);
-	} else {
-		struct string_list list = STRING_LIST_INIT_DUP;
+			if (!val) {
+				if (argc == 1)
+					return 1;
+				continue;
+			}
+			if (argc == 1)
+				printf("%s%c", val, term);
+			else
+				printf("%s%c%s%c", git_var->name, delim,
+				       val, term);
+			free(val);
+		} else {
+			struct string_list list = STRING_LIST_INIT_DUP;
 
-		git_var->multiread(&list);
-		if (!list.nr) {
+			git_var->multiread(&list);
+			if (argc == 1 && !list.nr) {
+				string_list_clear(&list, 0);
+				return 1;
+			}
+			for (size_t j = 0; j < list.nr; j++) {
+				if (argc == 1)
+					printf("%s%c", list.items[j].string,
+					       term);
+				else
+					printf("%s%c%s%c", git_var->name, delim,
+					       list.items[j].string, term);
+			}
 			string_list_clear(&list, 0);
-			return 1;
 		}
-		for (size_t i = 0; i < list.nr; i++)
-			printf("%s%c", list.items[i].string, term);
-		string_list_clear(&list, 0);
 	}
 
 	return 0;
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 661d0539c0..593610300a 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -306,4 +306,71 @@ test_expect_success 'options must precede variable arguments' '
 	test_must_fail git var GIT_AUTHOR_IDENT -z
 '
 
+test_expect_success 'get multiple variables' '
+	test_tick &&
+	cat >expect <<-EOF &&
+	GIT_AUTHOR_IDENT=$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	GIT_COMMITTER_IDENT=$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	EOF
+	git var GIT_AUTHOR_IDENT GIT_COMMITTER_IDENT >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multiple variables with -z' '
+	test_tick &&
+	printf "GIT_AUTHOR_IDENT\n%sQGIT_COMMITTER_IDENT\n%sQ" \
+		"$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE" \
+		"$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" >expect &&
+	git var -z GIT_AUTHOR_IDENT GIT_COMMITTER_IDENT >actual.raw &&
+	nul_to_q <actual.raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multiple variables including multi-valued variable' '
+	test_tick &&
+	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
+	cat >expect <<-EOF &&
+	GIT_AUTHOR_IDENT=$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	GIT_CONFIG_GLOBAL=$TRASHDIR/foo/git/config
+	GIT_CONFIG_GLOBAL=$TRASHDIR/.gitconfig
+	GIT_COMMITTER_IDENT=$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	EOF
+	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" \
+		git var GIT_AUTHOR_IDENT GIT_CONFIG_GLOBAL GIT_COMMITTER_IDENT >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multiple variables including multi-valued variable with -z' '
+	test_tick &&
+	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
+	printf "GIT_AUTHOR_IDENT\n%sQGIT_CONFIG_GLOBAL\n%sQGIT_CONFIG_GLOBAL\n%sQ" \
+		"$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE" \
+		"$TRASHDIR/foo/git/config" "$TRASHDIR/.gitconfig" >expect &&
+	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" \
+		git var -z GIT_AUTHOR_IDENT GIT_CONFIG_GLOBAL >actual.raw &&
+	nul_to_q <actual.raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'variable without a value is omitted but is not an error' '
+	test_tick &&
+	cat >expect <<-EOF &&
+	GIT_AUTHOR_IDENT=$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+	GIT_COMMITTER_IDENT=$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	EOF
+	test_env GIT_CONFIG_GLOBAL= \
+		git var GIT_AUTHOR_IDENT GIT_CONFIG_GLOBAL GIT_COMMITTER_IDENT >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'a single variable without a value still exits with 1' '
+	test_env GIT_CONFIG_GLOBAL= test_expect_code 1 git var GIT_CONFIG_GLOBAL >out &&
+	test_must_be_empty out
+'
+
+test_expect_success 'unknown variable is a usage error' '
+	test_must_fail git var GIT_AUTHOR_IDENT NO_SUCH_VARIABLE 2>err &&
+	test_grep usage err
+'
+
 test_done
-- 
2.54.0 (Apple Git-157)

