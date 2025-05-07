Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B96199924
	for <git@vger.kernel.org>; Wed,  7 May 2025 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746585211; cv=none; b=E5RCTNf8ComCOo5ESZp4UToy+emcGmtAhg86mCqm/VOYLfq2ETc2vYryD1XRZACSqn8hry+F/BvWGVC3p7K8hAdbsM1Xs6HxN+4tM0meHr0Hv6l1zfswAnmJugw53Cw+AGHErOpbQ7z4ojvSfWCMfI1t19fDzGnzirtJixOgf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746585211; c=relaxed/simple;
	bh=3rJWh8gi4ZqHd1T4z0xjVxa8OydaNosoOY/ifADo94g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hAy7/H/ZNfjPbTj+HQn1/bW+upjjBEDGzc6gmoFdUlEUcZVz3qDbmTE7pdC0GEo9/ljC8YXiDkVOu44wSr5LkFKzaMYTp/uS4gDkRzPXsDEhYh03PfgTMmad7QI4tBcqXA4eUJrLwPBOn6BP/caMW3uffQueisM1qxDfm88dUP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YT9YCh93; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YT9YCh93"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so3186145e9.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 19:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746585207; x=1747190007; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b2/TLiJGXjTn46TBjr4HdCOWPRhSESn3YG6eSr8yPY=;
        b=YT9YCh93rhTIUZ8ApQ5JTBpCEMPWOD/2U/TW2qlV4OxFWESdq8jYlZFk68D/1wA+S0
         QRfZdGyAyKzUs6S4GHkPyIyrdG8UIpNH2YWjJSGjKxlsBQU+/CHvX5XQt7L49nRKJxFo
         Iz1kYiTmbIsU1huEyOZReZ4XsAh7K3L5OXDWhK4cwYRnUsRtwqN9scBr1r4S5Z21c4N1
         QcxfNcK+MZSqwLIk6SstrLX+j3qARuWWoybTNdjvl4+hB26yQZMgC/IU2nXVplCauogo
         lPEYNXKJdmHcHdAdmrZOasrzGgqXZnsgP+5KPt66C0uLNFCI66cNgrzs+TTpxv6ym7R0
         F8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746585207; x=1747190007;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4b2/TLiJGXjTn46TBjr4HdCOWPRhSESn3YG6eSr8yPY=;
        b=F0FggAs2jwhiySaqZLNzqYZJrWCWSFg6aKmXuqxXRvJqFqVFmf2BQqygVUPA33BPrh
         UTQ4uzxdJumn57CvFAOcJHxRBqjuee8pR/VEEC8DRHg2HTPWsvzz4FHG9o2gEp1o2+oR
         1MFvgaitOB+uvemEZJNW+BlZqBj4IH5XSpLYclPQwdXMl/sCnpPXVWiebJcbaKaIQipO
         KxRF99MSFh9/dn4EcV9hIVsAP+ptjr5guxVqw9SHEySROQ3wrrzYctRhZTN/0VsfO8Zz
         zgRoLtLdpG8+z5Tsq0J1Toya1DvFdlP9EDalMG83+DvyOrAEseHOfzpFqwWa1LGegQWk
         yGgQ==
X-Gm-Message-State: AOJu0YytMk83GF5NiriWS5VB7Fm9EOYjVt5A3hldHzoyvKU7xQpC5s2O
	HivynyGzjX2kdZgYOk5u4mnZU9ZDN3TYQygXFeEJor5tnj+o6FSRmBr7pw==
X-Gm-Gg: ASbGncsF3taKAdbL1nn0dxRCWhBlA/PeHRBQb6Ash5bmvw1Y55TJEWWaON1+A06GHgG
	oQuiEsqFMkIt25uVyDbYgANHCJwjNKMRzBAA63/To3knf/Oy1GINvnxhUM6AjN6AAd/nDJGVcAU
	wqIYdSciyrsXVwoOG5jFK9/1+BkY6bWhoKa5128puDfZhE4siHCIcTFgTWmC5u+ljCrvD2JgoLG
	42pcjsaT4q5oG+lmOCy+l+FfwfLFrnX2pOMvEx4Rsdq+x34ucybcFadJOligTnSaX+faeTg0/4e
	JpMTzMtXPTvjKirOiy+ZF1HcQUacawIMYB3pqHBtCg==
X-Google-Smtp-Source: AGHT+IG9NzXxoWfy3fDYs03tbRW8sIjY0VACg+rugb5qebai6xS4bHCanmdM9yvVYGYHmZVO67WjVg==
X-Received: by 2002:a05:600c:cca:b0:442:7c40:fda4 with SMTP id 5b1f17b1804b1-4427c40ff41mr260795e9.1.1746585206857;
        Tue, 06 May 2025 19:33:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d434dc66sm13756095e9.18.2025.05.06.19.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 19:33:25 -0700 (PDT)
Message-Id: <7a5e2f295296265379551584a271a409a0ce3153.1746585203.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
References: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 May 2025 02:33:22 +0000
Subject: [PATCH 2/3] fix: replace bug where int was incorrectly used as bool
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
 parse-options.c                      | 12 ++++++--
 parse-options.h                      | 12 ++++----
 t/helper/test-free-unknown-options.c | 43 ++++++++++++++--------------
 t/helper/test-tool.c                 |  2 +-
 4 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 4279dfe4d313..12721b83000a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -638,7 +638,9 @@ static int has_subcommands(const struct option *options)
 	return 0;
 }
 
-static void set_strdup_fn(struct parse_opt_ctx_t *ctx, const struct option *options) {
+static void set_strdup_fn(struct parse_opt_ctx_t *ctx,
+			  const struct option *options)
+{
 	for (; options->type != OPTION_END; options++)
 		;
 	if (options->value && options->strdup_fn) {
@@ -993,9 +995,13 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 					 * This is leaky, too bad.
 					 */
 					if (ctx->unknown_opts && ctx->strdup_fn) {
-						ctx->argv[0] = ctx->strdup_fn(ctx->unknown_opts, ctx->opt - 1);
+						ctx->argv[0] =
+							ctx->strdup_fn(ctx->unknown_opts,
+								       ctx->opt -
+									       1);
 					} else {
-						ctx->argv[0] = xstrdup(ctx->opt - 1);
+						ctx->argv[0] =
+							xstrdup(ctx->opt - 1);
 					}
 					*(char *)ctx->argv[0] = '-';
 					goto unknown;
diff --git a/parse-options.h b/parse-options.h
index af06a09abb8e..57037bd381a3 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -391,11 +391,12 @@ static char *parse_options_noop_ignored_value MAYBE_UNUSED;
 }
 #define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)
 
-#define OPT_UNKNOWN(v, fn) { \
-	.type = OPTION_END, \
-	.value = (v), \
-	.strdup_fn = (fn), \
-}
+#define OPT_UNKNOWN(v, fn)          \
+	{                           \
+		.type = OPTION_END, \
+		.value = (v),       \
+		.strdup_fn = (fn),  \
+	}
 
 /*
  * parse_options() will filter out the processed options and leave the
@@ -505,7 +506,6 @@ struct parse_opt_ctx_t {
 	const char *prefix;
 	const char **alias_groups; /* must be in groups of 3 elements! */
 	struct parse_opt_cmdmode_list *cmdmode_list;
-
 	void *unknown_opts;
 	parse_opt_strdup_fn *strdup_fn;
 };
diff --git a/t/helper/test-free-unknown-options.c b/t/helper/test-free-unknown-options.c
index 9d658115ba8f..59d732da23ca 100644
--- a/t/helper/test-free-unknown-options.c
+++ b/t/helper/test-free-unknown-options.c
@@ -2,34 +2,35 @@
 #include "parse-options.h"
 #include "setup.h"
 #include "strvec.h"
+#include "test-tool.h"
 
 static const char *const free_unknown_options_usage[] = {
-    "test-tool free-unknown-options",
-    NULL
+	"test-tool free-unknown-options", NULL
 };
 
-int cmd__free_unknown_options(int argc, const char **argv) {
-    struct strvec *unknown_opts = xmalloc(sizeof(struct strvec));
-    strvec_init(unknown_opts);
-    const char *prefix = setup_git_directory();
-
-    bool a, b;
+int cmd__free_unknown_options(int argc, const char **argv)
+{
+	struct strvec *unknown_opts = xmalloc(sizeof(struct strvec));
+	const char *prefix = setup_git_directory();
+	int a = 0, b = 0;
+	size_t i;
 	struct option options[] = {
 		OPT_BOOL('a', "test-a", &a, N_("option a, only for test use")),
-	OPT_BOOL('b', "test-b", &b, N_("option b, only for test use")),
-	OPT_UNKNOWN(unknown_opts, (parse_opt_strdup_fn *)&strvec_push),
+		OPT_BOOL('b', "test-b", &b, N_("option b, only for test use")),
+		OPT_UNKNOWN(unknown_opts, (parse_opt_strdup_fn *)&strvec_push),
 	};
 
-    parse_options(argc, argv, prefix, options,
-	free_unknown_options_usage, PARSE_OPT_KEEP_UNKNOWN_OPT);
+	strvec_init(unknown_opts);
+	parse_options(argc, argv, prefix, options, free_unknown_options_usage,
+		      PARSE_OPT_KEEP_UNKNOWN_OPT);
+
+	printf("a = %s\n", a ? "true" : "false");
+	printf("b = %s\n", b ? "true" : "false");
 
-    printf("a = %s\n", a? "true": "false");
-    printf("b = %s\n", b? "true": "false");
+	for (i = 0; i < unknown_opts->nr; i++)
+		printf("free unknown option: %s\n", unknown_opts->v[i]);
+	strvec_clear(unknown_opts);
+	free(unknown_opts);
 
-    int i;
-    for (i = 0; i < unknown_opts->nr; i++) {
-	printf("free unknown option: %s\n", unknown_opts->v[i]);
-    }
-    strvec_clear(unknown_opts);
-    free(unknown_opts);
-}
\ No newline at end of file
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 79ec4f9cda07..5af5acae1cb3 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -51,7 +51,7 @@ static struct test_cmd cmds[] = {
 	{ "parse-options-flags", cmd__parse_options_flags },
 	{ "parse-pathspec-file", cmd__parse_pathspec_file },
 	{ "parse-subcommand", cmd__parse_subcommand },
-	{ "free-unknown-options", cmd__free_unknown_options},
+	{ "free-unknown-options", cmd__free_unknown_options },
 	{ "partial-clone", cmd__partial_clone },
 	{ "path-utils", cmd__path_utils },
 	{ "path-walk", cmd__path_walk },
-- 
gitgitgadget

