Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D409410D2C
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214824; cv=none; b=e/SnT7sPlaPuL6LVviKN6UJJ2vxMTY1pXtsAMpQ/WfsGxyxTzg8wQZvADxS6n1Oc81qpKDLx/B6pf8WkU+/7R8BPfPEb9qBsHqSn/8Gowtx3INMoCE2XZ9e3DI9GdYjrwj8jdmJjvdY4EfJkeThYWlty/tv/0tTZTDj1wfxUqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214824; c=relaxed/simple;
	bh=Ju/PC+a8MoHmVTBkrWEq5CQClgrNqLgY+4AzQjVQSso=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eC+/053Kp/HMQ8zUtfbQ8J31zCAqtVgSOCpSS/cAgLi5U+Aw/YnyY71QtqJmdJzAqNMpCSmZA1WlAF2D8UAf7eqt9NmdnPXS1cXxNc6cEHNQOjIBFTzwUg/YA2qhhlHvqWnhMZPeDUfgd+TBQOh0U2jl+3FTuElRHyroIIcJd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQnNNKvM; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQnNNKvM"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d1916d1e24so5507688a34.3
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 06:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770214823; x=1770819623; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWiNYyFdyWrMI0rPhu6cZU6g7HXRH1b/5UVz9nhislk=;
        b=RQnNNKvMkSO5thYpd+xXwK3pah9Bzlxe7rX6Bfo9LYgMQnpwYCXQscy8TXPVZtTpjG
         0AExTA4cJ6t5RK9b7VvzPnBHvqi2ANFmnJl0crNSCD8dpAOdM31YcmOUApALi19d7SHF
         65tqu1HOpU8TteFovaakovqLZNrSvKtofnC4FeYosuBxqbCK1aL1KYOSlAx+WtRppAdB
         BA2gMVUPrTuRqPvMDNodSoL/beyU0KikSEZLvnV5V2aXIUzvqStELP3pnD0FIklPUsMy
         xPfXtJJ3lzRxHi+pBMvuEel4/ONU25mCCtt351tenKdYPEi1kBVabcO8NmgXQ3weHjoF
         jd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214823; x=1770819623;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mWiNYyFdyWrMI0rPhu6cZU6g7HXRH1b/5UVz9nhislk=;
        b=P3s+q1gIy3NT3LHW9V0CXiZgwPDNaHNYGelk9fVGnYtBuYL8LOZHXlKIt+DRKcxioe
         Qz+Ic/641gJTTSeK6TFB23xi8Jj4hRFWpD5HqMCIZQuRonsSvemCuvH+Kk9F9zmaaKIM
         TgGhryTDzK3yJBMgZQC+99zkAhlt/kg4pRwn0LBBtpit3r453g7JnHM80ArpRMBqq62/
         ef55NgBL8c1U33gwWxsyqIR/8Wt5/1BDBIpX7UJthOeSpQ070hrUzYX4TEsE7qjixjEH
         Pnlbeq53eNTw/CjVlSKtXDiMgqXY9cYAQh99yBN8R8oUUnhK+IPLksKkBYfTWIPEPenb
         lDNA==
X-Gm-Message-State: AOJu0YyDN0ytZVM8RFelWSgbnfhtjoEZkPgoSAFnX7Kj2xayoQRLqc0q
	/16a4KbC5OyFSnAgG6jjVt/YZQpaKaOTaQZY20Nswls4YXI0+5jTeuTLjQdwlA==
X-Gm-Gg: AZuq6aI/zyfL2uV93ghBk62rJr6kwZatM6uDkSQv+wwg9VmwRIu3Rdn64SSfWpzXVct
	dn5f7QxsFuY7TUBHqnQAyu1zfUUWxmYJ8sMcbi+Ihvfj6jdgrXI45kL9E78bjUlQnXWETU+lkkW
	3ZozIxq8Skc4sH5LIVSPgGurQalek6SJB7Eh09hv32xyDeyfSmU2Nvcl59K5lFwjlxa9NCBpF/X
	uJXwO9+AmB+3KoiJPOFoURb0JPUQ06UfA+l9RNtB0Lj7MZXte5lpd+BDnogQiS/G7HbIrQTmmjr
	5nI7yhHsBEHF3IhueOlCyNPnyzl8lDCmwb+syHI8NiWjn1dOG/M2YpsiaprcFI3SSuqcVwAbcXE
	9XNdBONVZGOiJd+TFb1Iotu9YwKq0P/ixdyvgB31uHeXQ2m+qtmxW4Esz8cKBL/wF/80iWSRN6p
	UQUus8ZAujdT1YGQ==
X-Received: by 2002:a05:6830:6f8c:b0:7cf:d2f3:af8a with SMTP id 46e09a7af769-7d448accbf9mr2084819a34.28.1770214822536;
        Wed, 04 Feb 2026 06:20:22 -0800 (PST)
Received: from [127.0.0.1] ([52.173.182.164])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4499a49c9sm1569429a34.0.2026.02.04.06.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 06:20:21 -0800 (PST)
Message-Id: <59d19fee5f5bd34c5864bebb8243afdc6bc9ea7a.1770214803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Feb 2026 14:20:03 +0000
Subject: [PATCH 11/11] config-batch: add unset v1 command
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
Cc: gitster@pobox.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add a new 'unset' command with version 1 that mimics 'git config
--unset' with optional regex pattern or '--fixed-value' arguments.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-config-batch.adoc | 28 ++++++++
 builtin/config-batch.c              | 99 +++++++++++++++++++++++++++++
 t/t1312-config-batch.sh             | 61 ++++++++++++++++--
 3 files changed, 181 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-config-batch.adoc b/Documentation/git-config-batch.adoc
index feec85c4ef..bdfd872d65 100644
--- a/Documentation/git-config-batch.adoc
+++ b/Documentation/git-config-batch.adoc
@@ -135,6 +135,34 @@ set 1 success <scope> <key> <value>
 set 1 failed <scope> <key> <value>
 ------------
 
+`unset` version 1::
+	The `unset` command removes a single value from a config file.
+	It specifies which file by a `<scope>` parameter from among
+	`system`, `global`, `local`, and `worktree`. The `<key>` is the
+	next positional argument. There could be two additional
+	arguments used to match specific config values, where the first
+	is either `arg:regex` or `arg:fixed-value` to specify the type
+	of match.
++
+------------
+unset 1 <scope> <key>
+unset 1 <scope> <key> arg:regex <value-pattern>
+unset 1 <scope> <key> arg:fixed-value <value>
+------------
++
+These uses will match the behavior of `git config --unset --<scope> <key>`
+with the additional arguments of `<value-pattern>` if `arg:regex` is
+given or `--fixed-value <value>` if `arg:fixed-value` is given.
++
+The response of these commands will include a `success` message
+if matched values are found and removed as expected or `failed` if an
+unexpected failure occurs:
++
+------------
+unset 1 success <scope> <key>
+unset 1 failed <scope> <key>
+------------
+
 NUL-Terminated Format
 ~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/config-batch.c b/builtin/config-batch.c
index 373b0cad47..25a942ba61 100644
--- a/builtin/config-batch.c
+++ b/builtin/config-batch.c
@@ -17,6 +17,7 @@ static int zformat = 0;
 #define HELP_COMMAND "help"
 #define GET_COMMAND "get"
 #define SET_COMMAND "set"
+#define UNSET_COMMAND "unset"
 #define COMMAND_PARSE_ERROR "command_parse_error"
 
 static void print_word(const char *word, int start)
@@ -445,6 +446,99 @@ cleanup:
 	return res;
 }
 
+/**
+ * 'unset' command, version 1.
+ *
+ * Positional arguments should be of the form:
+ *
+ * [0] scope ("system", "global", "local", or "worktree")
+ * [1] config key
+ * [2] config value
+ * [3*] match ("regex", "fixed-value")
+ * [4*] value regex OR value string
+ *
+ * [N*] indicates optional parameters that are not needed.
+ */
+static int unset_command_1(struct repository *repo,
+			 const char *prefix,
+			 char *data,
+			 size_t data_len)
+{
+	int res = 0, err = 0, flags = 0;
+	enum config_scope scope = CONFIG_SCOPE_UNKNOWN;
+	char *token = NULL, *key = NULL, *value_pattern = NULL;
+	size_t token_len;
+	struct config_location_options locopts = CONFIG_LOCATION_OPTIONS_INIT;
+
+	if (!parse_token(&data, &data_len, &token, &err) || err)
+		goto parse_error;
+
+	if (parse_scope(token, &scope) ||
+	    scope == CONFIG_SCOPE_UNKNOWN ||
+	    scope == CONFIG_SCOPE_SUBMODULE ||
+	    scope == CONFIG_SCOPE_COMMAND)
+		goto parse_error;
+
+	if (!parse_token(&data, &data_len, &key, &err) || err)
+		goto parse_error;
+
+	token_len = parse_token(&data, &data_len, &token, &err);
+	if (err)
+		goto parse_error;
+
+	if (token_len && !strncmp(token, "arg:", 4)) {
+		if (!strcmp(token + 4, "fixed-value"))
+			flags |= CONFIG_FLAGS_FIXED_VALUE;
+		/* no special logic for arg:regex. */
+		else if (strcmp(token + 4, "regex"))
+			goto parse_error; /* unknown arg. */
+
+		/* Use the remaining data as the value string. */
+		if (!zformat)
+			value_pattern = data;
+		else {
+			parse_token(&data, &data_len, &value_pattern, &err);
+			if (err)
+				goto parse_error;
+		}
+	} else if (token_len) {
+		/*
+		 * If we have remaining tokens not starting in "arg:",
+		 * then we don't understand them.
+		 */
+		goto parse_error;
+	}
+
+	if (location_options_set_scope(&locopts, scope))
+		goto parse_error;
+	location_options_init(repo, &locopts, prefix);
+
+	res = repo_config_set_multivar_in_file_gently(
+			repo,
+			locopts.source.file,
+			key,
+			/* value */ NULL,
+			value_pattern,
+			/* comment */ NULL,
+			flags);
+
+	if (res)
+		res = emit_response(UNSET_COMMAND, "1", "failure",
+				    scope_str(scope), key, NULL);
+	else
+		res = emit_response(UNSET_COMMAND, "1", "success",
+				    scope_str(scope), key, NULL);
+
+	goto cleanup;
+
+parse_error:
+	res = command_parse_error(UNSET_COMMAND);
+
+cleanup:
+	location_options_release(&locopts);
+	return res;
+}
+
 struct command {
 	const char *name;
 	command_fn fn;
@@ -467,6 +561,11 @@ static struct command commands[] = {
 		.fn = set_command_1,
 		.version = 1,
 	},
+	{
+		.name = UNSET_COMMAND,
+		.fn = unset_command_1,
+		.version = 1,
+	},
 	/* unknown_command must be last. */
 	{
 		.name = "",
diff --git a/t/t1312-config-batch.sh b/t/t1312-config-batch.sh
index 11380f4247..3bddbc0de3 100755
--- a/t/t1312-config-batch.sh
+++ b/t/t1312-config-batch.sh
@@ -47,10 +47,11 @@ test_expect_success 'help command' '
 	echo "help 1" >in &&
 
 	cat >expect <<-\EOF &&
-	help 1 count 3
+	help 1 count 4
 	help 1 help 1
 	help 1 get 1
 	help 1 set 1
+	help 1 unset 1
 	EOF
 
 	git config-batch >out <in &&
@@ -64,10 +65,11 @@ test_expect_success 'help -z' '
 	EOF
 
 	cat >expect <<-\EOF &&
-	4:help 1:1 5:count 1:3
+	4:help 1:1 5:count 1:4
 	4:help 1:1 4:help 1:1
 	4:help 1:1 3:get 1:1
 	4:help 1:1 3:set 1:1
+	4:help 1:1 5:unset 1:1
 	15:unknown_command
 	EOF
 
@@ -295,15 +297,60 @@ test_expect_success 'set config by scope with -z' '
 	test_cmp expect-values values
 '
 
-test_expect_success 'read/write interactions in sequence' '
-	test_when_finished git config remove-section test.rw &&
+test_expect_success 'unset config by scope and filter' '
+	GIT_CONFIG_SYSTEM=system-config-file &&
+	GIT_CONFIG_NOSYSTEM=0 &&
+	GIT_CONFIG_GLOBAL=global-config-file &&
+	export GIT_CONFIG_SYSTEM &&
+	export GIT_CONFIG_NOSYSTEM &&
+	export GIT_CONFIG_GLOBAL &&
+
+	cat >in <<-\EOF &&
+	set 1 system test.unset.key system
+	set 1 global test.unset.key global
+	set 1 local test.unset.key local with spaces
+	set 1 worktree test.unset.key worktree
+	unset 1 system test.unset.key
+	unset 1 global test.unset.key arg:regex g.*
+	unset 1 local test.unset.key arg:fixed-value local with spaces
+	unset 1 worktree test.unset.key arg:fixed-value submodule
+	unset 1 worktree test.unset.key arg:regex l.*
+	EOF
+
+	cat >expect <<-\EOF &&
+	set 1 success system test.unset.key system
+	set 1 success global test.unset.key global
+	set 1 success local test.unset.key local with spaces
+	set 1 success worktree test.unset.key worktree
+	unset 1 success system test.unset.key
+	unset 1 success global test.unset.key
+	unset 1 success local test.unset.key
+	unset 1 failure worktree test.unset.key
+	unset 1 failure worktree test.unset.key
+	EOF
+
+	git config-batch <in >out 2>err &&
 
+	test_must_be_empty err &&
+	test_cmp expect out &&
+
+	cat >expect-values <<-EOF &&
+	file:.git/config.worktree	worktree
+	EOF
+
+	git config get --show-origin --regexp --all test.unset.key >values &&
+	test_cmp expect-values values
+'
+
+test_expect_success 'read/write interactions in sequence' '
 	cat >in <<-\EOF &&
 	get 1 local test.rw.missing
 	set 1 local test.rw.found found
 	get 1 local test.rw.found
 	set 1 local test.rw.found updated
 	get 1 local test.rw.found
+	unset 1 local test.rw.found arg:fixed-value updated
+	get 1 local test.rw.found
 	EOF
 
 	cat >expect <<-\EOF &&
@@ -312,14 +359,14 @@ test_expect_success 'read/write interactions in sequence' '
 	get 1 found test.rw.found local found
 	set 1 success local test.rw.found updated
 	get 1 found test.rw.found local updated
+	unset 1 success local test.rw.found
+	get 1 missing test.rw.found
 	EOF
 
 	git config-batch <in >out 2>err &&
 
 	test_must_be_empty err &&
-	test_cmp expect out &&
-
-	test_cmp_config updated test.rw.found
+	test_cmp expect out
 '
 
 test_done
-- 
gitgitgadget
