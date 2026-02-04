Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602B641B357
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214821; cv=none; b=JJTQJsxZsvxzgYKZEBIzR1dmLV9HZPSIju3iJu1kBBnybHY8Szemb+hQRcSl99OlLL8Jz0jpSimEsn6VtTZoyr+Ct/0GpVqGWm8uVr69PaGuwj3nvUah9U23g25gDrEjF5AZvd/bP225lYyLqcxGLOjIkK6x96npgeFVHZ+OTEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214821; c=relaxed/simple;
	bh=zB8XlH5itDak8dyCaYAVExeyOU0sey4+t8En9chFo+s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bxaU3ZbjnTVCKYxGYdix3skeVfgpK5TY2gWrTkW/qPuklC7riReMEE0YxcwNTx3f6ns60DgvuiA8dQZ8O4FoVKkurrUH5lxXirwztyq7d23nfM3ISvizwx5ZS01EyQXo3nv1v0QGwEmxInHBVgTPGE2h0Qu5PtZ/6Zt2MakS7ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xum6VBJ4; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xum6VBJ4"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-662f54771dcso2118179eaf.2
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 06:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770214820; x=1770819620; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqLu8xJa7cc1IfiswIMWh2C2LEXuJh5tR0kyjHIO5OA=;
        b=Xum6VBJ4/GLD7NUoZ/N3zmn/A5rFyMeIYudERlNAqQSS976mLlSsUWbN8l4EdTGr/X
         HUY3EJVJBtu4ysGSr8jv1GMhLue/U9nzHadNTe/KRyWqeadOINWX9FFzg4K8CZjSpCa8
         7DpmixhCHkgVXjokE69nwNJzKANGzmDmtBOTksAqBKBq/pP+cI3//wD063RH5KXODxLE
         5pR3wkmCxA2tOHI+9bZB+1hP4u6OwfaAJXbGqumzLgikWgtnNdmsr/hvHooQXUdFqGPa
         B/cOqvBTYQw1ik6MDovvptx4dgk4vdKtWkceAdYrfAbkBy67jvOYAGWWoboKAEFG5xTe
         sHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214820; x=1770819620;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QqLu8xJa7cc1IfiswIMWh2C2LEXuJh5tR0kyjHIO5OA=;
        b=CuMOMHRVaA53/rQTme01vBqrt2EV96Dz4mWcVdgU9jDcqzpBMV+zj3fO5miCvi/Cq4
         iJHCDknocbxHvnMmK1hRw4qF75ZP7cexV3wbub38HuuqhZaIg1EDSEPxptsXxkS/QCiR
         IYqsayzOcaqi0+llOnGfZESPJTHEoP5+VKDfZpeU3ii+B3JV0GDiiLeuzfSiCQkhpF8r
         fzg99DBE03HGIuZWFv2OPeXQWvZr2TpsVIS1Jv0ficeLYpIdJOflGqibUNRqiKBzzx86
         U6KARa9kt4oD3v+IZOp1LatICHess9kdiQGfhQFk88Gma9un0tMilFFwVIJUP+lhBwT/
         VE8g==
X-Gm-Message-State: AOJu0YyBfmrsDnlAYafWWlP6Fbr1ddLzfqPJM2qs0rSNChygJ6pfQdjd
	nRe+igc0f5zChv5i/gXeKsCyUjc608ZArr1y5be3gfFArZ/QSU323z8xw6Fo9Q==
X-Gm-Gg: AZuq6aIhGRSpa4eSBtMAGzxS4h3UW68rLw+6F3YO2vmrCiff32gMwqiMvEIZNGU6ezZ
	8tn4Oww1DBZ8vuM0FByhY5D7uxi6O+IdzgaVczemO7tXHIDVUiUO48jCqYrwryDJiaKff4JNSsf
	kWrkKKqQ/kovJxyL33mj3p2UgY3ViK1drxt+a5YGv00ZHIEGN0L24Ge/flvwb9CuXQIdmfAzeFs
	GFPg8f0lE7soJ6Rh0hg846+BumweEyS8YOdZGeZCLE52QfDq3hx/kyl/5KIWFSariCblQpXf4xN
	woHC5mVi0D5MXd1TAsY8Y3ZyK5YjS5eJIahRRIzG+GcY2VuDR6yDAJ00aUjgdxrgcKtXGLwjjlG
	UcQQ2U060WFampjdIs5AewVm+xoIQ8QwLb133I/joh5qPeYIaZQwc158IIHWV+b5YuZ3KGNz0jm
	m+proyiwwH+4IjQg==
X-Received: by 2002:a4a:e844:0:b0:65f:6d6c:530d with SMTP id 006d021491bc7-66a2088256cmr1435629eaf.18.1770214819818;
        Wed, 04 Feb 2026 06:20:19 -0800 (PST)
Received: from [127.0.0.1] ([52.173.182.164])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66a32bb12d1sm1448621eaf.3.2026.02.04.06.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 06:20:19 -0800 (PST)
Message-Id: <fdeef536f649bec811e8335d1c7151be8e352ff0.1770214803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Feb 2026 14:20:01 +0000
Subject: [PATCH 09/11] config-batch: add 'set' v1 command
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

This new command is intended for single-value assignments to a specific
chosen scope. More complicated versions of the 'git config set' command
will be incorporated into future commands.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-config-batch.adoc | 24 ++++++++
 builtin/config-batch.c              | 71 ++++++++++++++++++++++
 config.c                            | 27 +++++++++
 config.h                            |  3 +
 t/t1312-config-batch.sh             | 94 ++++++++++++++++++++++++++++-
 5 files changed, 217 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-config-batch.adoc b/Documentation/git-config-batch.adoc
index 3c9a3bb763..feec85c4ef 100644
--- a/Documentation/git-config-batch.adoc
+++ b/Documentation/git-config-batch.adoc
@@ -111,6 +111,30 @@ get 1 missing <key> [<value-pattern>|<value>]
 where `<value-pattern>` or `<value>` is only supplied if provided in
 the command.
 
+`set` version 1::
+	The `set` command writes a single key-value pair to a config
+	file. It specifies which file by a `<scope>` parameter from
+	among `system`, `global`, `local`, and `worktree`. The `<key>`
+	is the next positional argument. The remaining data in the line
+	is provided as the `<value>` to assign the config.
++
+------------
+set 1 <scope> <key> <value>
+------------
++
+These uses will match the behavior of `git config --set --<scope> <key>
+<value>`. Note that replacing all values with the `--all` option or
+matching specific value patterns are not supported by this command.
++
+The response of these commands will include a `success` message if the
+value is written as expected or `failed` if an unexpected failure
+occurs:
++
+------------
+set 1 success <scope> <key> <value>
+set 1 failed <scope> <key> <value>
+------------
+
 NUL-Terminated Format
 ~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/config-batch.c b/builtin/config-batch.c
index 9829b16c6f..373b0cad47 100644
--- a/builtin/config-batch.c
+++ b/builtin/config-batch.c
@@ -16,6 +16,7 @@ static int zformat = 0;
 #define UNKNOWN_COMMAND "unknown_command"
 #define HELP_COMMAND "help"
 #define GET_COMMAND "get"
+#define SET_COMMAND "set"
 #define COMMAND_PARSE_ERROR "command_parse_error"
 
 static void print_word(const char *word, int start)
@@ -379,6 +380,71 @@ cleanup:
 	return res;
 }
 
+
+/**
+ * 'set' command, version 1.
+ *
+ * Positional arguments should be of the form:
+ *
+ * [0] scope ("system", "global", "local", or "worktree")
+ * [1] config key
+ * [2] config value
+ */
+static int set_command_1(struct repository *repo,
+			 const char *prefix,
+			 char *data,
+			 size_t data_len)
+{
+	int res = 0, err = 0;
+	enum config_scope scope = CONFIG_SCOPE_UNKNOWN;
+	char *token = NULL, *key = NULL, *value = NULL;
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
+	/* Use the remaining data as the value string. */
+	if (!zformat)
+		value = data;
+	else {
+		parse_token(&data, &data_len, &value, &err);
+		if (err)
+			goto parse_error;
+	}
+
+	if (location_options_set_scope(&locopts, scope))
+		goto parse_error;
+	location_options_init(repo, &locopts, prefix);
+
+	res = repo_config_set_in_file_gently(repo, locopts.source.file,
+					     key, NULL, value);
+
+	if (res)
+		res = emit_response(SET_COMMAND, "1", "failure",
+				    scope_str(scope), key, value, NULL);
+	else
+		res = emit_response(SET_COMMAND, "1", "success",
+				    scope_str(scope), key, value, NULL);
+
+	goto cleanup;
+
+parse_error:
+	res = command_parse_error(SET_COMMAND);
+
+cleanup:
+	location_options_release(&locopts);
+	return res;
+}
+
 struct command {
 	const char *name;
 	command_fn fn;
@@ -396,6 +462,11 @@ static struct command commands[] = {
 		.fn = get_command_1,
 		.version = 1,
 	},
+	{
+		.name = SET_COMMAND,
+		.fn = set_command_1,
+		.version = 1,
+	},
 	/* unknown_command must be last. */
 	{
 		.name = "",
diff --git a/config.c b/config.c
index 9f1a7b45cf..fa72234750 100644
--- a/config.c
+++ b/config.c
@@ -3594,6 +3594,33 @@ int lookup_config(const char **mapping, int nr_mapping, const char *var)
 	return -1;
 }
 
+int location_options_set_scope(struct config_location_options *opts,
+			       enum config_scope scope)
+{
+	switch (scope) {
+	case CONFIG_SCOPE_SYSTEM:
+		opts->use_system_config = 1;
+		break;
+
+	case CONFIG_SCOPE_GLOBAL:
+		opts->use_global_config = 1;
+		break;
+
+	case CONFIG_SCOPE_LOCAL:
+		opts->use_local_config = 1;
+		break;
+
+	case CONFIG_SCOPE_WORKTREE:
+		opts->use_worktree_config = 1;
+		break;
+
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
 void location_options_init(struct repository *repo,
 			   struct config_location_options *opts,
 			   const char *prefix)
diff --git a/config.h b/config.h
index 6663964977..f6432c1ec2 100644
--- a/config.h
+++ b/config.h
@@ -180,6 +180,9 @@ struct config_location_options {
 	.respect_includes_opt = -1, \
 }
 
+int location_options_set_scope(struct config_location_options *opts,
+			       enum config_scope scope);
+
 void location_options_init(struct repository *repo,
 			   struct config_location_options *opts,
 			   const char *prefix);
diff --git a/t/t1312-config-batch.sh b/t/t1312-config-batch.sh
index f7a74ddc2c..40f6f90ef2 100755
--- a/t/t1312-config-batch.sh
+++ b/t/t1312-config-batch.sh
@@ -47,9 +47,10 @@ test_expect_success 'help command' '
 	echo "help 1" >in &&
 
 	cat >expect <<-\EOF &&
-	help 1 count 2
+	help 1 count 3
 	help 1 help 1
 	help 1 get 1
+	help 1 set 1
 	EOF
 
 	git config-batch >out <in &&
@@ -63,9 +64,10 @@ test_expect_success 'help -z' '
 	EOF
 
 	cat >expect <<-\EOF &&
-	4:help 1:1 5:count 1:2
+	4:help 1:1 5:count 1:3
 	4:help 1:1 4:help 1:1
 	4:help 1:1 3:get 1:1
+	4:help 1:1 3:set 1:1
 	15:unknown_command
 	EOF
 
@@ -205,4 +207,92 @@ test_expect_success 'get config with -z' '
 	test_cmp expect out
 '
 
+test_expect_success 'set config by scope' '
+	test_when_finished git config remove-section test.set &&
+	GIT_CONFIG_SYSTEM=system-config-file &&
+	GIT_CONFIG_NOSYSTEM=0 &&
+	GIT_CONFIG_GLOBAL=global-config-file &&
+	export GIT_CONFIG_SYSTEM &&
+	export GIT_CONFIG_NOSYSTEM &&
+	export GIT_CONFIG_GLOBAL &&
+
+	cat >in <<-\EOF &&
+	set 1 system test.set.system system
+	set 1 global test.set.global global
+	set 1 local test.set.local local with spaces
+	set 1 worktree test.set.worktree worktree
+	set 1 submodule test.set.submodule submodule
+	set 1 command test.set.command command
+	set 1 inherited test.set.inherited inherited
+	EOF
+
+	cat >expect <<-\EOF &&
+	set 1 success system test.set.system system
+	set 1 success global test.set.global global
+	set 1 success local test.set.local local with spaces
+	set 1 success worktree test.set.worktree worktree
+	command_parse_error set
+	command_parse_error set
+	command_parse_error set
+	EOF
+
+	git config-batch <in >out 2>err &&
+
+	test_must_be_empty err &&
+	test_cmp expect out &&
+
+	cat >expect-values <<-EOF &&
+	file:system-config-file	system
+	file:global-config-file	global
+	file:.git/config	local with spaces
+	file:.git/config.worktree	worktree
+	EOF
+
+	git config get --show-origin --regexp --all test.set.* >values &&
+	test_cmp expect-values values
+'
+
+test_expect_success 'set config by scope with -z' '
+	test_when_finished git config remove-section test.set &&
+	GIT_CONFIG_SYSTEM=system-config-file &&
+	GIT_CONFIG_NOSYSTEM=0 &&
+	GIT_CONFIG_GLOBAL=global-config-file &&
+	export GIT_CONFIG_SYSTEM &&
+	export GIT_CONFIG_NOSYSTEM &&
+	export GIT_CONFIG_GLOBAL &&
+
+	cat >in <<-\EOF &&
+	3:set NUL 1:1 NUL 6:system NUL 15:test.set.system NUL 6:system NUL NUL
+	3:set NUL 1:1 NUL 6:global NUL 15:test.set.global NUL 6:global NUL NUL
+	3:set NUL 1:1 NUL 5:local NUL 14:test.set.local NUL 17:local with spaces NUL NUL
+	3:set NUL 1:1 NUL 8:worktree NUL 17:test.set.worktree NUL 8:worktree NUL NUL
+	3:set NUL 1:1 NUL 9:submodule NUL 18:test.set.submodule NUL 9:submodule NUL NUL
+	3:set NUL 1:1 NUL 7:command NUL 16:test.set.command NUL 7:command NUL NUL
+	3:set NUL 1:1 NUL 9:inherited NUL 18:test.set.inherited NUL 9:inherited NUL NUL
+	EOF
+
+	cat >expect <<-\EOF &&
+	3:set 1:1 7:success 6:system 15:test.set.system 6:system
+	3:set 1:1 7:success 6:global 15:test.set.global 6:global
+	3:set 1:1 7:success 5:local 14:test.set.local 17:local with spaces
+	3:set 1:1 7:success 8:worktree 17:test.set.worktree 8:worktree
+	19:command_parse_error 3:set
+	19:command_parse_error 3:set
+	19:command_parse_error 3:set
+	EOF
+
+	test_zformat git config-batch -z >out <in &&
+	test_cmp expect out &&
+
+	cat >expect-values <<-EOF &&
+	file:system-config-file	system
+	file:global-config-file	global
+	file:.git/config	local with spaces
+	file:.git/config.worktree	worktree
+	EOF
+
+	git config get --show-origin --regexp --all test.set.* >values &&
+	test_cmp expect-values values
+'
+
 test_done
-- 
gitgitgadget

