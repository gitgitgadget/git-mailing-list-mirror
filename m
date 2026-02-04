Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C874410D26
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214810; cv=none; b=jWbQD2mY/6mRFzem2PbAc9rVQzSCefkUsQohHFrGqU21AN4qmIL9V2aAVY1OmGceklONbiE+iI79uyuMYw1i2n8kPWvUDCtL6nPgBEUMjOiYIABVLSfkk1ouxwPdmUnfPr0cr4tARGonOMhyyhZQkWv7iBMMe/SLSRX0L0x8JkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214810; c=relaxed/simple;
	bh=ccWdiLpy7kALrjGCju/Hp8/WI+glHU7XKduOYuanv90=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pYoJqWKRHVuWkvgFK4Au2ZC/PgLd/T49oZc3p08gxLYu4e77FtO3e9S+8GctnF0py2jKJBwTsQC+aSQZgBJztTe/Sn5/3tx7om0P2Rpa3rAu49wI/NzDrQcYI0Brfr6lVO4e/6AKmAhGjwiwkwUmRl4B+nd+6Ip7IJ5FBNM+wn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cljZqkPk; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cljZqkPk"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45c92df37fdso317465b6e.3
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 06:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770214809; x=1770819609; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdaCr6fROeY6WwNSIBp+wvIcQf490PPVQUHu146e4hs=;
        b=cljZqkPkUS0iwwn6Ft9RchZDOTEhLyH2x/1xpEysEoKTIERAi61Vnovtk1U1ZqHfez
         jBADbgXkz2E3ma5obL9uaHQYgPSvwqqhyRlg1FoeXL6WvpWvejMUQ9TzsWpRcAvktTfg
         zUCABb/Hx4j6qte4nLvD3w9KMa/yynLR48UGvc1qdiTuvEHPS5KPqx8LW2DnQonFkH7u
         B1kj2L/DNpnICGtWL2lkmok20FxgmO5cVSNDwIqqW8pRqpuXGjD8M81h5UCNAWXBIUQY
         X4gEBsOBKUmAmY1RC57O8xJU0hUnRLmQQS7sJed/BEkBNMgXgXtcb6msYvinKrCYZhEs
         /qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214809; x=1770819609;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gdaCr6fROeY6WwNSIBp+wvIcQf490PPVQUHu146e4hs=;
        b=dll2w92HUt9QtFjEVBZSEhGBG7OXh53T7HtYnT+iLUxPEu6xcaBEmXGeocM+h6w5tF
         FmO7jiaHE4ODy8HMGr4Ien2dgGSK0KJ3udrx2IuQ63RDfB8aqK23NFvwRWQ2/1ahIVYi
         K5KPUZ9Ef1W+XcL5x66lbGiZuVlOJd/KCZEC4VTqU9NhAibI7ArpJwX3OK/1N2d4Gim0
         DeZKhgE79BQJZsF4Mx6SgrFJYbfkY7HJSaQ0PtdYGAXHBtO4Jw+5PP2HJUdCuOkbl9dq
         MT044x1X9Sc4ajmLc26qojmNI5jzMX+ARD6Ngt0VyZfQDT9ZnpJkCzWsyMporbhdOe+f
         CCgA==
X-Gm-Message-State: AOJu0YzzB/UOenx4/Uar25rmUltE1lf1SqFUUsbI8bnzCLBrQ7a97sdF
	y47DmtJtB7uQlRClHmPp7qKlgVP2VJc7cDPxmW44S8whGETfTZrk1RxDkoPsow==
X-Gm-Gg: AZuq6aLRCZ4/2FII4cwhI8zPHZ7rXKCxBfQBIq3cD81aqIqTwgykscytFNAxpvgQBz6
	MOet2aSebP3zlcs3sPucsTp6y6euyLn+SBR8W6NxYHfMChGA300qsONLkyarnoT1+wobbvSi5vv
	HFdWYyrSe81suD+ARrBICuyc3S1ppz6PKu769MooWFDDbZljELq1gCWmFTK7xzoC6J08oQW9ArF
	reN7fy7NWnjSwSJl+ZZbOGQ57EuQpmsIVrNUqWutR1PvFMYVTmEE3V2tMFqG+VXJSKBAxlu6c+Z
	sSrTT8MODKygY2b+SPdgBNXkokttuNUp+0QA0td3LV9zYIeazTlBqh61Wx7T7vz85CZ7dI8pjAx
	F+s3ErnWh117+xxlLxVGk4MyZPVFPpb6oyinrObF6rOzNb1YVTPzDEU2WAuMsqGvgxQVfKWBZnW
	i12J35WRxwSDsiNk9GA3EF2Erw
X-Received: by 2002:a05:6808:10d3:b0:459:a26c:2c3c with SMTP id 5614622812f47-462d58c1b66mr1760504b6e.26.1770214808878;
        Wed, 04 Feb 2026 06:20:08 -0800 (PST)
Received: from [127.0.0.1] ([52.173.182.164])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a5442668esm1686796fac.14.2026.02.04.06.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 06:20:08 -0800 (PST)
Message-Id: <ecd26a0f1fad5615aea07a388e34f02e9f33b870.1770214803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Feb 2026 14:19:54 +0000
Subject: [PATCH 02/11] config-batch: create parse loop and unknown command
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

As we build new features in the config-batch command, we define the
plaintext protocol with line-by-line output and responses. To think to the
future, we make sure that the protocol has a clear way to respond to an
unknown command or an unknown version of that command.

As some commands will allow the final argument to contain spaces or even be
able to parse "\ " as a non-split token, we only provide the remaining line
as data.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-config-batch.adoc |  23 ++++-
 builtin/config-batch.c              | 133 +++++++++++++++++++++++++++-
 t/t1312-config-batch.sh             |  19 +++-
 3 files changed, 170 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-config-batch.adoc b/Documentation/git-config-batch.adoc
index dfa0bd83e2..9ca04b0c1e 100644
--- a/Documentation/git-config-batch.adoc
+++ b/Documentation/git-config-batch.adoc
@@ -13,7 +13,28 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-TODO
+Tools frequently need to change their behavior based on values stored in
+Git's configuration files. These files may have complicated conditions
+for including extra files, so it is difficult to produce an independent
+parser. To avoid executing multiple processes to discover or modify
+multiple configuration values, the `git config-batch` command allows a
+single process to handle multiple requests using a machine-parseable
+interface across `stdin` and `stdout`.
+
+PROTOCOL
+--------
+By default, the protocol uses line feeds (`LF`) to signal the end of a
+command over `stdin` or a response over `stdout`.
+
+The protocol will be extended in the future, and consumers should be
+resilient to older Git versions not understanding the latest command
+set. Thus, if the Git version includes the `git config-batch` builtin
+but doesn't understand an input command, it will return a single line
+response:
+
+```
+unknown_command LF
+```
 
 SEE ALSO
 --------
diff --git a/builtin/config-batch.c b/builtin/config-batch.c
index ea4f408ecb..dffedb8ca2 100644
--- a/builtin/config-batch.c
+++ b/builtin/config-batch.c
@@ -3,17 +3,144 @@
 #include "config.h"
 #include "environment.h"
 #include "parse-options.h"
+#include "strbuf.h"
+#include "string-list.h"
 
 static const char *const builtin_config_batch_usage[] = {
 	N_("git config-batch <options>"),
 	NULL
 };
 
+#define UNKNOWN_COMMAND "unknown_command"
+
+static int emit_response(const char *response, ...)
+{
+	va_list params;
+	const char *token;
+
+	printf("%s", response);
+
+	va_start(params, response);
+	while ((token = va_arg(params, const char *)))
+		printf(" %s", token);
+	va_end(params);
+
+	printf("\n");
+	fflush(stdout);
+	return 0;
+}
+
+/**
+ * A function pointer type for defining a command. The function is
+ * responsible for handling different versions of the command name.
+ *
+ * Provides the remaining 'data' for the command, to be parsed by
+ * the function as needed according to its parsing rules.
+ *
+ * These functions should only return a negative value if they result
+ * in such a catastrophic failure that the process should end.
+ *
+ * Return 0 on success.
+ */
+typedef int (*command_fn)(struct repository *repo,
+			  char *data, size_t data_len);
+
+static int unknown_command(struct repository *repo UNUSED,
+			  char *data UNUSED, size_t data_len UNUSED)
+{
+	return emit_response(UNKNOWN_COMMAND, NULL);
+}
+
+struct command {
+	const char *name;
+	command_fn fn;
+	int version;
+};
+
+static struct command commands[] = {
+	/* unknown_command must be last. */
+	{
+		.name = "",
+		.fn   = unknown_command,
+	},
+};
+
+#define COMMAND_COUNT ((size_t)(sizeof(commands) / sizeof(*commands)))
+
+/**
+ * Process a single line from stdin and process the command.
+ *
+ * Returns 0 on successful processing of command, including the
+ * unknown_command output.
+ *
+ * Returns 1 on natural exit due to exist signal of empty line.
+ *
+ * Returns negative value on other catastrophic error.
+ */
+static int process_command(struct repository *repo)
+{
+	static struct strbuf line = STRBUF_INIT;
+	struct string_list tokens = STRING_LIST_INIT_NODUP;
+	const char *command;
+	int version;
+	char *data = NULL;
+	size_t data_len = 0;
+	int res = 0;
+
+	strbuf_getline(&line, stdin);
+
+	if (!line.len)
+		return 1;
+
+	/* Parse out the first two tokens, command and version. */
+	string_list_split_in_place(&tokens, line.buf, " ", 2);
+
+	if (tokens.nr < 2) {
+		res = error(_("expected at least 2 tokens, got %"PRIu32),
+			    (uint32_t)tokens.nr);
+		goto cleanup;
+	}
+
+	command = tokens.items[0].string;
+
+	if (!git_parse_int(tokens.items[1].string, &version)) {
+		res = error(_("unable to parse '%s' to integer"),
+			    tokens.items[1].string);
+		goto cleanup;
+	}
+
+	if (tokens.nr >= 3) {
+		data = tokens.items[2].string;
+		data_len = strlen(tokens.items[2].string);
+	}
+
+	for (size_t i = 0; i < COMMAND_COUNT; i++) {
+		/*
+		 * Run the ith command if we have hit the unknown
+		 * command or if the name and version match.
+		 */
+		if (!commands[i].name[0] ||
+		    (!strcmp(command, commands[i].name) &&
+		     commands[i].version == version)) {
+			res = commands[i].fn(repo, data, data_len);
+			goto cleanup;
+		}
+	}
+
+	BUG(_("scanned to end of command list, including 'unknown_command'"));
+
+cleanup:
+	strbuf_reset(&line);
+	string_list_clear(&tokens, 0);
+	return res;
+}
+
 int cmd_config_batch(int argc,
 		     const char **argv,
 		     const char *prefix,
 		     struct repository *repo)
 {
+	int res = 0;
 	struct option options[] = {
 		OPT_END(),
 	};
@@ -26,5 +153,9 @@ int cmd_config_batch(int argc,
 
 	repo_config(repo, git_default_config, NULL);
 
-	return 0;
+	while (!(res = process_command(repo)));
+
+	if (res == 1)
+		return 0;
+	die(_("an unrecoverable error occurred during command execution"));
 }
diff --git a/t/t1312-config-batch.sh b/t/t1312-config-batch.sh
index f59ba4a0f3..f60ef35e38 100755
--- a/t/t1312-config-batch.sh
+++ b/t/t1312-config-batch.sh
@@ -4,9 +4,22 @@ test_description='Test git config-batch'
 
 . ./test-lib.sh
 
-test_expect_success 'help text' '
-	test_must_fail git config-batch -h >out &&
-	grep usage out
+test_expect_success 'no commands' '
+	echo | git config-batch >out &&
+	test_must_be_empty out
+'
+
+test_expect_success 'unknown_command' '
+	echo unknown_command >expect &&
+	echo "bogus 1 line of tokens" >in &&
+	git config-batch >out <in &&
+	test_cmp expect out
+'
+
+test_expect_success 'failed to parse version' '
+	echo "bogus BAD_VERSION line of tokens" >in &&
+	test_must_fail git config-batch 2>err <in &&
+	test_grep BAD_VERSION err
 '
 
 test_done
-- 
gitgitgadget

