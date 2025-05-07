Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1551729CEB
	for <git@vger.kernel.org>; Wed,  7 May 2025 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746585210; cv=none; b=NtirIs347+etF5NArB1FD9AANomaIlvEGIRlLMvlSeCrnkBxE03+p/GEUKckKqCSG0/U+idcrgID/UjJfBZxWwNyFt3ROocgCcQEImnIej1p+11kNLgq5acULMHhlYnyA6/ux7xuiavnDBYfYNMlA7aHDtoGB1m3U9TpLJxKW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746585210; c=relaxed/simple;
	bh=25jwVPyHHgL/d5ElvdAScxIX4CiqgMQHLv1/Ch6BXl4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AzK7mzXkZ2yBRgZZHFLc9olMy/itNnsSlj54pYUsK7XdqfqO67V1qu3W/6oxc4t/se4W0er4nbE8J3jUUkOBZid8rgyruJ76qpJr1wMXoL86+0vvwR1tNO/FU6whRaZ0lrQpqEj4Jra/IMECIsQlcMQe3ELbcgK75GBIVcB9Kqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2QZF6p/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2QZF6p/"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c1efc4577so3286335f8f.0
        for <git@vger.kernel.org>; Tue, 06 May 2025 19:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746585205; x=1747190005; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZnbD0ebNcykwmrLkaBZduI7G8zAFDVkMa2Yk1mWsyo=;
        b=O2QZF6p/Z4TuayH4eo2GXfHr4gIsb5aNmTl+4Sg+3bRaDe1uoxZ7E3kcn15yyR79Ns
         acUiz0pDX5YmK0Jxx7RLVKfXYTWmbPZLCfuxmZFEKGOj5Q7bfgnMO7ASMsntOhjoS7GL
         PCSe8X93NrwhjtazYf8e2NVu2zdV814b0ZGuluY1Kw0ByFNiqJ6BrIVvaDyuf+FiEL+q
         7qUaWBw97osbaUW+gkS90u8A1a+NP8FoyORG815I+4JhUrEd/SR7j9qoSnLnoF/vmM6Q
         16kOwmiG0/nXI9u/65VgMCgYUJnt3IT6Ec8L4WBGkZbYVA2sZjWwSK9F/oB3bH8hIItm
         Y5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746585205; x=1747190005;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZnbD0ebNcykwmrLkaBZduI7G8zAFDVkMa2Yk1mWsyo=;
        b=wG0guZGcJPwR93IsjOFFyK5lGeO5mLSsgTnkqTcG0dDvzJKVeCdImo2Ii+BLT7M9Ct
         QBs8mdgt5h5vXzYBJ4Kt/nNi+BwQjvVrZF7frDd0RI9PXoLkQ/QyiOUolMnX3a5xXPw9
         WUIiAA4HmDskfpxdwuFBVJ5qLQwlF9C52hbZUyD77mgw7Fmjkp/UtEkui2FtGs16IjWL
         J5ryogixrH7D249taSgxmTkxjWirRYaWmayFaZgouVCgBUtWBE/ExCVPlK3WQYb6TSUo
         0LoATyY7b1eP2J4QiU5qLbos3xrEBE2lhzXR5h9T4Kmdg3DV+RuJ0KEvFFmNX9Z0VQNN
         jFVQ==
X-Gm-Message-State: AOJu0YyVXIpIyoMQ+X7Ot8ZmbVIVqdc/iXUYfDvBJvfpRkB1X5tyKqJi
	gUqvJY4ryTq3ouAXkRxgjq/jtL0yL6Pxsh7gcVpMP5XYRXfGLP73Gln10g==
X-Gm-Gg: ASbGncsobkxcHN0PYoYpCG7UsF7mtB/gNWqDGgPoSckmJD9ytET773BDsGIoYmg55NZ
	lcYT9AVfUFiy4BQnINE0OmnDzCVaia8HXFoFoYDIvn+7ObBIbWNYxCO/CAOjMiyGIJhJHQbj2VH
	MiOYRY4T21WubiH+GuWs5aRMjR8D/97wSwpn1+AM7JRLW5TeDXG3r8ADZnO/HI79ioultHIMKIS
	ItFa+PECEDrw3S5QqLGdR7U9bO8nfzl9/NgIgwkADNyWlwjvJzK1klxlcRjG+4YApjrGHIeUOXF
	ch8VTo7Q+5bdPRfuKcUFunEu8+gHn+eBRqApVNlQtQ==
X-Google-Smtp-Source: AGHT+IF3UDeb7IKbkgXSrg5WLIR/xYSRNVibdjBY0Nchdi624FY7lJGwNuEFGMP9i7ToPZQk31klSw==
X-Received: by 2002:a05:6000:1787:b0:391:4873:7940 with SMTP id ffacd0b85a97d-3a0b4a46829mr1132598f8f.54.1746585205443;
        Tue, 06 May 2025 19:33:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0b25159c9sm2850567f8f.50.2025.05.06.19.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 19:33:24 -0700 (PDT)
Message-Id: <b34445d166c9790e922c0fd6a7c4885031fb21bd.1746585203.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
References: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 May 2025 02:33:21 +0000
Subject: [PATCH 1/3] fix xstrdup leak in parse_short_opt
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 Makefile                             |  1 +
 parse-options.c                      | 17 +++++++++++++-
 parse-options.h                      | 12 ++++++++++
 t/helper/meson.build                 |  1 +
 t/helper/test-free-unknown-options.c | 35 ++++++++++++++++++++++++++++
 t/helper/test-tool.c                 |  1 +
 t/helper/test-tool.h                 |  1 +
 t/t0040-parse-options.sh             | 14 +++++++++++
 8 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-free-unknown-options.c

diff --git a/Makefile b/Makefile
index 8a7f1c76543f..af8ea677b820 100644
--- a/Makefile
+++ b/Makefile
@@ -822,6 +822,7 @@ TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-pack-mtimes.o
 TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
+TEST_BUILTINS_OBJS += test-free-unknown-options.o
 TEST_BUILTINS_OBJS += test-partial-clone.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-path-walk.o
diff --git a/parse-options.c b/parse-options.c
index a9a39ecaef6c..4279dfe4d313 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -638,6 +638,16 @@ static int has_subcommands(const struct option *options)
 	return 0;
 }
 
+static void set_strdup_fn(struct parse_opt_ctx_t *ctx, const struct option *options) {
+	for (; options->type != OPTION_END; options++)
+		;
+	if (options->value && options->strdup_fn) {
+		ctx->unknown_opts = options->value;
+		ctx->strdup_fn = options->strdup_fn;
+		return;
+	}
+}
+
 static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
 				  int argc, const char **argv, const char *prefix,
 				  const struct option *options,
@@ -655,6 +665,7 @@ static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
 	ctx->cpidx = ((flags & PARSE_OPT_KEEP_ARGV0) != 0);
 	ctx->flags = flags;
 	ctx->has_subcommands = has_subcommands(options);
+	set_strdup_fn(ctx, options);
 	if (!ctx->has_subcommands && (flags & PARSE_OPT_SUBCOMMAND_OPTIONAL))
 		BUG("Using PARSE_OPT_SUBCOMMAND_OPTIONAL without subcommands");
 	if (ctx->has_subcommands) {
@@ -981,7 +992,11 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 					 *
 					 * This is leaky, too bad.
 					 */
-					ctx->argv[0] = xstrdup(ctx->opt - 1);
+					if (ctx->unknown_opts && ctx->strdup_fn) {
+						ctx->argv[0] = ctx->strdup_fn(ctx->unknown_opts, ctx->opt - 1);
+					} else {
+						ctx->argv[0] = xstrdup(ctx->opt - 1);
+					}
 					*(char *)ctx->argv[0] = '-';
 					goto unknown;
 				case PARSE_OPT_NON_OPTION:
diff --git a/parse-options.h b/parse-options.h
index 91c3e3c29b3d..af06a09abb8e 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -77,6 +77,8 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
 typedef int parse_opt_subcommand_fn(int argc, const char **argv,
 				    const char *prefix, struct repository *repo);
 
+typedef char *parse_opt_strdup_fn(void *value, const char *s);
+
 /*
  * `type`::
  *   holds the type of the option, you must have an OPTION_END last in your
@@ -165,6 +167,7 @@ struct option {
 	parse_opt_ll_cb *ll_callback;
 	intptr_t extra;
 	parse_opt_subcommand_fn *subcommand_fn;
+	parse_opt_strdup_fn *strdup_fn;
 };
 
 #define OPT_BIT_F(s, l, v, h, b, f) { \
@@ -388,6 +391,12 @@ static char *parse_options_noop_ignored_value MAYBE_UNUSED;
 }
 #define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)
 
+#define OPT_UNKNOWN(v, fn) { \
+	.type = OPTION_END, \
+	.value = (v), \
+	.strdup_fn = (fn), \
+}
+
 /*
  * parse_options() will filter out the processed options and leave the
  * non-option arguments in argv[]. argv0 is assumed program name and
@@ -496,6 +505,9 @@ struct parse_opt_ctx_t {
 	const char *prefix;
 	const char **alias_groups; /* must be in groups of 3 elements! */
 	struct parse_opt_cmdmode_list *cmdmode_list;
+
+	void *unknown_opts;
+	parse_opt_strdup_fn *strdup_fn;
 };
 
 void parse_options_start(struct parse_opt_ctx_t *ctx,
diff --git a/t/helper/meson.build b/t/helper/meson.build
index d2cabaa2bcfc..476e32781761 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -39,6 +39,7 @@ test_tool_sources = [
   'test-pack-mtimes.c',
   'test-parse-options.c',
   'test-parse-pathspec-file.c',
+  'test-free-unknown-options.c',
   'test-partial-clone.c',
   'test-path-utils.c',
   'test-path-walk.c',
diff --git a/t/helper/test-free-unknown-options.c b/t/helper/test-free-unknown-options.c
new file mode 100644
index 000000000000..9d658115ba8f
--- /dev/null
+++ b/t/helper/test-free-unknown-options.c
@@ -0,0 +1,35 @@
+#include "git-compat-util.h"
+#include "parse-options.h"
+#include "setup.h"
+#include "strvec.h"
+
+static const char *const free_unknown_options_usage[] = {
+    "test-tool free-unknown-options",
+    NULL
+};
+
+int cmd__free_unknown_options(int argc, const char **argv) {
+    struct strvec *unknown_opts = xmalloc(sizeof(struct strvec));
+    strvec_init(unknown_opts);
+    const char *prefix = setup_git_directory();
+
+    bool a, b;
+	struct option options[] = {
+		OPT_BOOL('a', "test-a", &a, N_("option a, only for test use")),
+	OPT_BOOL('b', "test-b", &b, N_("option b, only for test use")),
+	OPT_UNKNOWN(unknown_opts, (parse_opt_strdup_fn *)&strvec_push),
+	};
+
+    parse_options(argc, argv, prefix, options,
+	free_unknown_options_usage, PARSE_OPT_KEEP_UNKNOWN_OPT);
+
+    printf("a = %s\n", a? "true": "false");
+    printf("b = %s\n", b? "true": "false");
+
+    int i;
+    for (i = 0; i < unknown_opts->nr; i++) {
+	printf("free unknown option: %s\n", unknown_opts->v[i]);
+    }
+    strvec_clear(unknown_opts);
+    free(unknown_opts);
+}
\ No newline at end of file
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 50dc4dac4ed6..79ec4f9cda07 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -51,6 +51,7 @@ static struct test_cmd cmds[] = {
 	{ "parse-options-flags", cmd__parse_options_flags },
 	{ "parse-pathspec-file", cmd__parse_pathspec_file },
 	{ "parse-subcommand", cmd__parse_subcommand },
+	{ "free-unknown-options", cmd__free_unknown_options},
 	{ "partial-clone", cmd__partial_clone },
 	{ "path-utils", cmd__path_utils },
 	{ "path-walk", cmd__path_walk },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 6d62a5b53d95..33fa7828b9f6 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -44,6 +44,7 @@ int cmd__parse_options(int argc, const char **argv);
 int cmd__parse_options_flags(int argc, const char **argv);
 int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__parse_subcommand(int argc, const char **argv);
+int cmd__free_unknown_options(int argc, const char **argv);
 int cmd__partial_clone(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__path_walk(int argc, const char **argv);
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ca55ea8228c3..773f54103fd3 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -822,4 +822,18 @@ test_expect_success 'u16 limits range' '
 	test_grep "value 65536 for option .u16. not in range \[0,65535\]" err
 '
 
+cat >expect <<\EOF
+a = true
+b = true
+free unknown option: -c
+free unknown option: -d
+EOF
+
+test_expect_success 'free unknown options' '
+	test-tool free-unknown-options -ac -bd \
+	>output 2>output.err &&
+	test_cmp expect output &&
+	test_must_be_empty output.err
+'
+
 test_done
-- 
gitgitgadget

