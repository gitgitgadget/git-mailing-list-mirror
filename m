Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248272E1F08
	for <git@vger.kernel.org>; Sat, 24 Jan 2026 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769257300; cv=none; b=elP2ojNiu/XTH/uIO62DaPytqJWDpOfM7PzdtJGYbQto5J8zEh23VTnVl3Gyn8pCyzlaW7/6S1d9u3fjNDUcRebjbqTozZpeln/O5N4D0XjRs4BMPMQbx/GBT+zWwcPzDexYbP47ODpTB3X/1Cy+KOTeXSRmrFiYFDF6XH++6Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769257300; c=relaxed/simple;
	bh=eRdNop/YCpBFD96ibvryU8UA9oLA7q8GTKN2hDwOmuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eSyhsQ+V0oJ9ZW8T+cljuc2vMoGGLkc5m0hystf24fSLuH+ezFe1ynfCb0Yj7SmTcVWVK8uG7Iz7v4tNlaoDazs9T27DKMbJS34A6AsmFuWXVLXCGNXS5FEpzCPWUFSbVfbH+lcNRmn3RN/o6OmIiydlQhGxtJvZ2po0BD+uV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN7iVrb5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN7iVrb5"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee3da7447so23824915e9.0
        for <git@vger.kernel.org>; Sat, 24 Jan 2026 04:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769257297; x=1769862097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPujnOhts9xlmwbPs95MCayeL0YvXmwe9LZ/BbXHtYM=;
        b=QN7iVrb5HjqA8jAuJ8vlnj+BgmaM5wDdY5BYLmthtLgesCBK7pyaqBi0zs4Qs0zFYM
         SVkCoudZj2LXa2+F4FHRXhScjPJ5ZAtgnnyATrW25LNRS5filkVeJeCknSFliGCokbSg
         E2A56VeQ8/wjXihZgXUa8SnBaCUykCpDUKZThOXZZLHtst/cLnp0crKwJc13GvMDlHtx
         DlAiZ1X1GtSzU5pVzpUyo12aG7Oh7mJtiX0KeaQY95GlXmrJR6acnP9Us6iXrzqa3o5A
         qGOQIFndznh/3XkeVV/uSI0rl9bm2m2QgO+Dc/pUE3sVWSpyF1BqnGRXnnpryIcToBLq
         OJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769257297; x=1769862097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TPujnOhts9xlmwbPs95MCayeL0YvXmwe9LZ/BbXHtYM=;
        b=Rr2XhvHMZS3JvjdNdIGBfMaQ6p6Z7NfwTsMwvqfqD2wK+XXcCoAGzCtLjqrQgyLRzC
         tMY/OdeuQFX80/4OT3w3cAZQF3QU+Preu6LwH9zE2himSZY4p46tOReRcZfKr0lHLSz9
         aeW6j0Hv+8hUDGs/CFWN4ruQ0RBOLzqPAYPwJCAa4lNB3aWkhOUx5nT3/Ia7HrTMcHww
         Tyzc7cAG0acSbCuORgGYXafNaMVB7CXtH1yAi6lVTpl0STH6rfEl8AVNVc4VpcaUfUYq
         iXb29NksnqU0Y7oQi7ZbstFgB94oIrowUsxQcnSeolgvECB0cyvRS8NVeRiKoRdsXS+Q
         RWkA==
X-Gm-Message-State: AOJu0Yxk+cR199yilNEQSTONEEOqyJ3RqJ3QNhoynwmnOs7ZUtliTDLI
	jam0rN6v+IW5BTsfIwPzSDK0uwoiTyebTqWcOB3ozMemGfJg+hMEv192
X-Gm-Gg: AZuq6aKVdWZOM85Qn9hFGF1iKa3Zz5aAk1TIqCgd8QgtoNljZixcvGbZ61i0p94qX+K
	qXTly/LUJdhFWfnfTViJo6eVrnMeNBt/CnD8LgNP1mwlTFEMXAewG/sJBfdudDSwK0uYJ0qlDTO
	iz7dq843R2znFH1gKzXJCPvVvbv7oq4XPuEaFOibWXM+mff8c0JJR+2Qx7FwmGHHcUYhOXqro0N
	QvTXw/on0PTHGDWv1w/zPfUPwfqBCwU26a/p/Ux63SouvWibs51WUz+Is0x8v+Qd4miJtNpvLSD
	0MYkkIFbGmvozbVDKRJMc1Xfc1pjzjq6EfN5qyBPI8THZ+hyfaeBkkB2jtPhJniNQsEz/NDUtvo
	gYbmZfK5sOADjcIEKH7w40QaQKvTh7a91abEUSSZfhXsmqbu4If9eE5JrzH7Xt6fqqCul2I5f+l
	9kEA==
X-Received: by 2002:a05:600c:3f12:b0:480:20f1:7abd with SMTP id 5b1f17b1804b1-4804c9cf00cmr110396675e9.31.1769257297378;
        Sat, 24 Jan 2026 04:21:37 -0800 (PST)
Received: from ubuntu ([102.88.77.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d61f1f8sm49816105e9.5.2026.01.24.04.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 04:21:36 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v5 3/3] environment: move "branch.autoSetupMerge" into `struct repo_config_values`
Date: Sat, 24 Jan 2026 13:21:13 +0100
Message-Id: <e7f37bac87aac74ca13f85ae7e393a38d2079b9c.1769256839.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1769256839.git.belkid98@gmail.com>
References: <cover.1769256839.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config value `branch.autoSetupMerge` is parsed in
`git_default_branch_config()` and stored in the global variable
`git_branch_track`. This global variable can be overwritten
by another repository when multiple Git repos run in the the same process.

Move this value into `struct repo_config_values` in the_repository to
retain current behaviours and move towards libifying Git.
Since the variable is no longer a global variable, it has been renamed to
`branch_track` in the struct `repo_config_values`.

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
index c577b5d20f..7d27951a7e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -795,7 +795,7 @@ int cmd_branch(int argc,
 	if (!sorting_options.nr)
 		string_list_append(&sorting_options, "refname");
 
-	track = git_branch_track;
+	track = the_repository->config_values.branch_track;
 
 	head = refs_resolve_refdup(get_main_ref_store(the_repository), "HEAD",
 				   0, &head_oid, NULL);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 261699e2f5..ba6fea9aee 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1631,7 +1631,7 @@ static int checkout_branch(struct checkout_opts *opts,
 		if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 			die(_("'%s' cannot be used with '%s'"), "--detach", "-t");
 	} else if (opts->track == BRANCH_TRACK_UNSPECIFIED)
-		opts->track = git_branch_track;
+		opts->track = the_repository->config_values.branch_track;
 
 	if (new_branch_info->name && !new_branch_info->commit)
 		die(_("Cannot switch branch to a non-commit '%s'"),
diff --git a/builtin/push.c b/builtin/push.c
index 5b6cebbb85..7be20a1035 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -162,7 +162,7 @@ static NORETURN void die_push_simple(struct branch *branch,
 		advice_pushdefault_maybe = _("\n"
 				 "To choose either option permanently, "
 				 "see push.default in 'git help config'.\n");
-	if (git_branch_track != BRANCH_TRACK_SIMPLE)
+	if (the_repository->config_values.branch_track != BRANCH_TRACK_SIMPLE)
 		advice_automergesimple_maybe = _("\n"
 				 "To avoid automatically configuring "
 				 "an upstream branch when its name\n"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d537ab087a..f2b6f027d7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3128,7 +3128,7 @@ static int module_create_branch(int argc, const char **argv, const char *prefix,
 	};
 
 	repo_config(the_repository, git_default_config, NULL);
-	track = git_branch_track;
+	track = the_repository->config_values.branch_track;
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (argc != 3)
diff --git a/environment.c b/environment.c
index 269cac6d6e..de8721657e 100644
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
+			cfg->branch_track = BRANCH_TRACK_ALWAYS;
 			return 0;
 		} else if (value && !strcmp(value, "inherit")) {
-			git_branch_track = BRANCH_TRACK_INHERIT;
+			cfg->branch_track = BRANCH_TRACK_INHERIT;
 			return 0;
 		} else if (value && !strcmp(value, "simple")) {
-			git_branch_track = BRANCH_TRACK_SIMPLE;
+			cfg->branch_track = BRANCH_TRACK_SIMPLE;
 			return 0;
 		}
-		git_branch_track = git_config_bool(var, value);
+		cfg->branch_track = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "branch.autosetuprebase")) {
@@ -761,4 +762,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 {
 	cfg->attributes_file = NULL;
 	cfg->apply_sparse_checkout = 0;
+	cfg->branch_track = BRANCH_TRACK_REMOTE;
 }
diff --git a/environment.h b/environment.h
index ddce69c6ba..27161d56ab 100644
--- a/environment.h
+++ b/environment.h
@@ -2,6 +2,7 @@
 #define ENVIRONMENT_H
 
 #include "repo-settings.h"
+#include "branch.h"
 
 /* Double-check local_repo_env below if you add to this list. */
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
@@ -88,6 +89,9 @@ struct repo_config_values {
 	/* section "core" config values */
 	char *attributes_file;
 	int apply_sparse_checkout;
+
+	/* section "branch" config values */
+	enum branch_track branch_track;
 };
 
 /*
-- 
2.34.1

