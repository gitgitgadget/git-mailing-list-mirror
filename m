Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778432EA173
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768683746; cv=none; b=gX4Kcv1A/edNJyQMseHe/PILvW8VwLa3P5ug7OeB5pkBWzlXunp6ikaMMoDQCbmTfrXZWM2FLLtH+0kHrBuAoXK0nz7DvryEwV0nPp6KZoOBqh2wHlkk/VrHmgipgDYPD/az6+uX9BVRQ7W0LI46zKWK68o/FU5wrMRecKC2poI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768683746; c=relaxed/simple;
	bh=tPNGSUt0AyXgBGO7ska3B/wBwpcJfUxU8aejfcj7Jt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P9AOGLSr4Cn28k5dvJtvLTZ59jtzTpfwmbei2+tt6YKsEVzBCjgOSsKhcvV5R6/PBZkKAzjGf4p9MSB+BZ/MbObn4oX1HHtUOZD9sic4MMLza5ivqm8/BhxFkMYXt/O8PEmIodtjJYYdGK6hNBPb9vyt+7ceCqmObEUNtGC23uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B16G2RfE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B16G2RfE"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee807a4c5so22754305e9.2
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 13:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768683741; x=1769288541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaPW+LCwDxxHjcw/uc9X4sTqktWQTmHnHFVWoB2/Ygk=;
        b=B16G2RfEiSzO2cydI9OonElMDkz6G6g7pGVUrpWNMNlXkWQxnIniw7L4N5+O15fHDS
         GlgpxwPe0A0QsazZ4UbGQS4QQgUwTuHMutIZaAPGq4O2Ve8eo+ZtW3q/aR6NESGBE4kw
         SIiJvinr71CnKMdt+m2ZbJvaEvgsXc3d8ZHE0uifpSGrJciMADGOrm2bC1A5Y+L2wN1Q
         RiXeam+fPTx3HzMoQ/bGXiqbUb7YDvbqCGWqxSduHymbTEfkwUVKTmlt0e+gx0G6SzaD
         jsVTPRz1B0NMzwCZwb66UoXVHeFAXle2JPFJlktiPhFUQCNf5SeWiZTqyusLx5lrL+sL
         eeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768683741; x=1769288541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SaPW+LCwDxxHjcw/uc9X4sTqktWQTmHnHFVWoB2/Ygk=;
        b=JhkFbALrAClC1+7c+MUKsASL5JXW8kX1i+5s3QjKhV8qJl9oi27lUM1uHJnVg+ZtHb
         X0lHSpjsrT0iWtkJSfEps91rotsjzYbPx+B2E6r+EozSwF3dzYxaIjx17AfyUFbs2qLQ
         0xc9zwFIXIMY+EVcVJIA23uJsGWpVpo8mDXU7uRkjDuTYocbyFPLNEhTYHPnfxp7qGFF
         jFA6/0cXaXnb+bMY/0tYYYpi4+ti/cefaVCnUrkFFdtOSee5rJZa1qXoo6MnmeRxQ6Nj
         cXV1b290ZzAWGpp5UZ9bPmyiD5Ob8wqQ7vJf16vM55d+Hsc5FuP6dqUhIXQcKrg1aJjP
         yR1A==
X-Gm-Message-State: AOJu0YxdBo2Geye8muxpxoNUifnIUybEQbP7VLq88sCWAax/XEmGH1uC
	gOkPn4gG9bJqQK+Okgyw5PQ/zJIi81sRFESDz2FDaJzzclGwQSKavQtz
X-Gm-Gg: AY/fxX5J4zLkKe/NbSjlBzDlCSwex59s8AzoATiPxUpIdo+pku3PNIUOXykzY07rb0e
	X6L4Iz5jd/dnA663a9j4s8fAwN9/bBpBIEzZHql6lvc13pjJLipI1PDaYLg1TKyXw/ONOA72Hlx
	z+c7pBUoAhiVBNxH13rmlkjvpPxUqriK8ZXuKMtnFAnupB1x9lH/wGGTIC/tggC34IEVbgpb8XZ
	bXVj89p+dJDGIlCu5m2YLQCI/AWoy3wOlinw7KcwzgR+bGyEX8xhGEM6KR21+xwwToWcuvBohWy
	t5mY6HD/ImwjLUUSSdk3oMtDIjuJswdHLkL+RUk+RGa32MX+SpbZNUtfqhI3jQH5iuycZTNInY/
	jcEb4eXFxdt8aRdOh7xCcSVtONxf30Z25yiIvuBqZO2D6I98QDHUqBX0j5S4tiK+H21P0l+tWWd
	GfGA==
X-Received: by 2002:a05:600c:3f06:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-4801eb0359amr81147765e9.17.1768683741038;
        Sat, 17 Jan 2026 13:02:21 -0800 (PST)
Received: from ubuntu ([102.88.77.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8c05c3sm106993015e9.11.2026.01.17.13.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 13:02:20 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v3 3/3] environment: move "branch.autoSetupMerge" into `struct repo_config_values`
Date: Sat, 17 Jan 2026 21:59:28 +0100
Message-Id: <9a411db9f8f9df37c7a5f100d97c8d5ff5f6ba97.1768681947.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1768681947.git.belkid98@gmail.com>
References: <cover.1768681947.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config value `brach.autoSetupMerge` is parsed in
`git_default_branch_config()` and stored in the global variable
`git_branch_track`. This global variable can cause unexpected behaviours
when multiple Git repos run in the the same process.

Move this value into `struct repo_config_values` to retain current
behaviours while achieving repository scoped access.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 branch.h                    |  2 --
 builtin/branch.c            |  2 +-
 builtin/checkout.c          |  2 +-
 builtin/push.c              |  2 +-
 builtin/submodule--helper.c |  2 +-
 environment.c               | 12 +++++++-----
 environment.h               |  4 ++++
 7 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/branch.h b/branch.h
index ec2f35fda4..3dc6e2a0ff 100644
--- a/branch.h
+++ b/branch.h
@@ -15,8 +15,6 @@ enum branch_track {
 	BRANCH_TRACK_SIMPLE,
 };
 
-extern enum branch_track git_branch_track;
-
 /* Functions for acting on the information about branches. */
 
 /**
diff --git a/builtin/branch.c b/builtin/branch.c
index c577b5d20f..d75114b41c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -795,7 +795,7 @@ int cmd_branch(int argc,
 	if (!sorting_options.nr)
 		string_list_append(&sorting_options, "refname");
 
-	track = git_branch_track;
+	track = the_repository->config_values.git_branch_track;
 
 	head = refs_resolve_refdup(get_main_ref_store(the_repository), "HEAD",
 				   0, &head_oid, NULL);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 261699e2f5..6c1cb9713c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1631,7 +1631,7 @@ static int checkout_branch(struct checkout_opts *opts,
 		if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 			die(_("'%s' cannot be used with '%s'"), "--detach", "-t");
 	} else if (opts->track == BRANCH_TRACK_UNSPECIFIED)
-		opts->track = git_branch_track;
+		opts->track = the_repository->config_values.git_branch_track;
 
 	if (new_branch_info->name && !new_branch_info->commit)
 		die(_("Cannot switch branch to a non-commit '%s'"),
diff --git a/builtin/push.c b/builtin/push.c
index 5b6cebbb85..68105ecb2d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -162,7 +162,7 @@ static NORETURN void die_push_simple(struct branch *branch,
 		advice_pushdefault_maybe = _("\n"
 				 "To choose either option permanently, "
 				 "see push.default in 'git help config'.\n");
-	if (git_branch_track != BRANCH_TRACK_SIMPLE)
+	if (the_repository->config_values.git_branch_track != BRANCH_TRACK_SIMPLE)
 		advice_automergesimple_maybe = _("\n"
 				 "To avoid automatically configuring "
 				 "an upstream branch when its name\n"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d537ab087a..7239722e48 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3128,7 +3128,7 @@ static int module_create_branch(int argc, const char **argv, const char *prefix,
 	};
 
 	repo_config(the_repository, git_default_config, NULL);
-	track = git_branch_track;
+	track = the_repository->config_values.git_branch_track;
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (argc != 3)
diff --git a/environment.c b/environment.c
index 6633542750..2092a5c3c6 100644
--- a/environment.c
+++ b/environment.c
@@ -66,7 +66,6 @@ enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 char *check_roundtrip_encoding;
-enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
@@ -607,18 +606,20 @@ static int git_default_i18n_config(const char *var, const char *value)
 
 static int git_default_branch_config(const char *var, const char *value)
 {
+	struct repo_config_values *cfg = &the_repository->config_values;
+
 	if (!strcmp(var, "branch.autosetupmerge")) {
 		if (value && !strcmp(value, "always")) {
-			git_branch_track = BRANCH_TRACK_ALWAYS;
+			cfg->git_branch_track = BRANCH_TRACK_ALWAYS;
 			return 0;
 		} else if (value && !strcmp(value, "inherit")) {
-			git_branch_track = BRANCH_TRACK_INHERIT;
+			cfg->git_branch_track = BRANCH_TRACK_INHERIT;
 			return 0;
 		} else if (value && !strcmp(value, "simple")) {
-			git_branch_track = BRANCH_TRACK_SIMPLE;
+			cfg->git_branch_track = BRANCH_TRACK_SIMPLE;
 			return 0;
 		}
-		git_branch_track = git_config_bool(var, value);
+		cfg->git_branch_track = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "branch.autosetuprebase")) {
@@ -761,4 +762,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 {
 	cfg->attributes_file_path = NULL;
 	cfg->sparse_checkout = 0;
+	cfg->git_branch_track = BRANCH_TRACK_REMOTE;
 }
diff --git a/environment.h b/environment.h
index 3b5ff7094a..bfcdffe836 100644
--- a/environment.h
+++ b/environment.h
@@ -2,6 +2,7 @@
 #define ENVIRONMENT_H
 
 #include "repo-settings.h"
+#include "branch.h"
 
 /* Double-check local_repo_env below if you add to this list. */
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
@@ -89,6 +90,9 @@ struct repo_config_values {
 	/* core config values */
 	char *attributes_file_path;
 	int sparse_checkout;
+
+	/* branch config values */
+	enum branch_track git_branch_track;
 };
 
 /*
-- 
2.34.1

