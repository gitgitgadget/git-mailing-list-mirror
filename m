Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ABB13959D
	for <git@vger.kernel.org>; Mon, 20 May 2024 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716236537; cv=none; b=dT0+tP/pg2YtF6hmDAkV5EufoJlMbZFTv//EaXcuVuLhRkRrGgaGKBmgIwsXPsg+yjZnkaDb4Vhmpfyt3YxJHduq3mKWIPSltg4Eg2gjjSOvSX0viTZvWanISEhFbA1WwRCYWU0k4b2BCLxcWtnVfET8FwW7yZy/4HyjBf+OOgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716236537; c=relaxed/simple;
	bh=lVlVuRjx8gjlzFTetk5MCJ3bUQmhiKmjB3YGwzs6oaQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HAnkFsb/G/M8cWIbIVyORG5nRam2cUX/nmPYPQ58CrwH6a5FmEwvqx3Yd0Y45XnPkr1Fl5lBxrKxlpYlGyNpyGHt7xEARsabKxt/IYfEuS6Z2M8npby+8UcqadSmPUEgm/EJEyA4M91J2Tg+N8MI+NX4kmutQeyBPIFNW0Fk3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExGR99EM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExGR99EM"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42016c8db2aso24591275e9.0
        for <git@vger.kernel.org>; Mon, 20 May 2024 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716236533; x=1716841333; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxtT5xN3WXiWC4lzK+9yatqNRwvBZc6woP7q6d5Fgzk=;
        b=ExGR99EMUOXnAj0ufThOa0rbmHkwAZydXyYkNA5qV7gJNo0goUVb2y/LNZ8It/12EK
         BDjoJyWZekZ7Ihd4mRWJvlapVunDZZhk9iMCKd70nt+gQWlyPKEn9ikl6jAgF3i4NgYu
         hg2pw1/zwAzjq7/pQuXMJqVifp0trfV/RGWVZWDDvwLELzkVDs2+5G76sVXo8zt7waFv
         c4LaW9UzhY9R4ZgDR/o0836EG6CPs0tNJBOpe077M+fPxpj0OL7zHrY1Y4X9JipvVUeM
         Q2sEpTJcVze62QLsiVlOXZtwZlf6S8wfB3RKJCVV2VRlO357MoOt7XlW5ArYnpFvpqjO
         7kMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716236533; x=1716841333;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxtT5xN3WXiWC4lzK+9yatqNRwvBZc6woP7q6d5Fgzk=;
        b=AMLB5SEzaLP4ln5xUXqb10qxFM5ANOQ1yTbsFw0+ccjradKXTcExYUNf0YkdQuXd+3
         0jxMurWDMEkGWthUyvP4R2QbsAmgM2OagqsRUlNdMB3fiXRwLRl37EYr+uLJo9BA6pyW
         RFEUBS0JST9jlxuUkNeUezclGeDswsR/obA8i303FbLO3Z8momyReNaX4o2r2P1ANW5k
         NDuvZEbB28EB4k+isBMuzBn4CFaXunynQxz4SWbroq+FiE30zr85aCzBrsGA8OH6BIBO
         75qxT0ZPsTqsMdQ3Qw6vx1QsS1qxS0M4yFh8arinzgN9T0l+i4H0tuMQZHYmXyuAsXPV
         gLMg==
X-Gm-Message-State: AOJu0YwF5pnQ2jZcQowWASTkoXj77wjjYvclShZ4tvF0NaagdHrcMcTg
	SlM+f3Yh3pn4uzCRsqy56K753IP+BbDVGMlOFC62tc6vIu6EZqcljiaMPw==
X-Google-Smtp-Source: AGHT+IGy/7sstPQWijPOB1lpCgu7A0gIiaI4VCfh7W0vPMXR3QuXPYrAD6QkZjBT5O0nncu706uDIQ==
X-Received: by 2002:a05:600c:1e15:b0:420:2986:cce1 with SMTP id 5b1f17b1804b1-4202986d034mr103296165e9.32.1716236533553;
        Mon, 20 May 2024 13:22:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee9292sm435399695e9.37.2024.05.20.13.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:22:12 -0700 (PDT)
Message-Id: <0044a35567417a552cc518576670b43f7141a02e.1716236526.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
References: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
	<pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 May 2024 20:22:04 +0000
Subject: [PATCH v3 5/6] clone: drop the protections where hooks aren't run
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As part of the security bug-fix releases v2.39.4, ..., v2.45.1, I
introduced logic to safeguard `git clone` from running hooks that were
installed _during_ the clone operation.

The rationale was that Git's CVE-2024-32002, CVE-2021-21300,
CVE-2019-1354, CVE-2019-1353, CVE-2019-1352, and CVE-2019-1349 should
have been low-severity vulnerabilities but were elevated to
critical/high severity by the attack vector that allows a weakness where
files inside `.git/` can be inadvertently written during a `git clone`
to escalate to a Remote Code Execution attack by virtue of installing a
malicious `post-checkout` hook that Git will then run at the end of the
operation without giving the user a chance to see what code is executed.

Unfortunately, Git LFS uses a similar strategy to install its own
`post-checkout` hook during a `git clone`; In fact, Git LFS is
installing four separate hooks while running the `smudge` filter.

While this pattern is probably in want of being improved by introducing
better support in Git for Git LFS and other tools wishing to register
hooks to be run at various stages of Git's commands, let's undo the
clone protections to unbreak Git LFS-enabled clones.

This reverts commit 8db1e8743c0 (clone: prevent hooks from running
during a clone, 2024-03-28).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/clone.c  | 12 +-----------
 hook.c           | 34 --------------------------------
 t/t5601-clone.sh | 51 ------------------------------------------------
 3 files changed, 1 insertion(+), 96 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index e7721f5c22c..9ec500d427e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -937,8 +937,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
 	int filter_submodules = 0;
-	const char *template_dir;
-	char *template_dir_dup = NULL;
 
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
@@ -958,13 +956,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		usage_msg_opt(_("You must specify a repository to clone."),
 			builtin_clone_usage, builtin_clone_options);
 
-	xsetenv("GIT_CLONE_PROTECTION_ACTIVE", "true", 0 /* allow user override */);
-	template_dir = get_template_dir(option_template);
-	if (*template_dir && !is_absolute_path(template_dir))
-		template_dir = template_dir_dup =
-			absolute_pathdup(template_dir);
-	xsetenv("GIT_CLONE_TEMPLATE_DIR", template_dir, 1);
-
 	if (option_depth || option_since || option_not.nr)
 		deepen = 1;
 	if (option_single_branch == -1)
@@ -1112,7 +1103,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	init_db(git_dir, real_git_dir, template_dir, GIT_HASH_UNKNOWN, NULL,
+	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
 		INIT_DB_QUIET);
 
 	if (real_git_dir) {
@@ -1430,7 +1421,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	free(unborn_head);
 	free(dir);
 	free(path);
-	free(template_dir_dup);
 	UNLEAK(repo);
 	junk_mode = JUNK_LEAVE_ALL;
 
diff --git a/hook.c b/hook.c
index fc974cee1d8..22b274b60b1 100644
--- a/hook.c
+++ b/hook.c
@@ -3,32 +3,6 @@
 #include "run-command.h"
 #include "config.h"
 
-static int identical_to_template_hook(const char *name, const char *path)
-{
-	const char *env = getenv("GIT_CLONE_TEMPLATE_DIR");
-	const char *template_dir = get_template_dir(env && *env ? env : NULL);
-	struct strbuf template_path = STRBUF_INIT;
-	int found_template_hook, ret;
-
-	strbuf_addf(&template_path, "%s/hooks/%s", template_dir, name);
-	found_template_hook = access(template_path.buf, X_OK) >= 0;
-#ifdef STRIP_EXTENSION
-	if (!found_template_hook) {
-		strbuf_addstr(&template_path, STRIP_EXTENSION);
-		found_template_hook = access(template_path.buf, X_OK) >= 0;
-	}
-#endif
-	if (!found_template_hook) {
-		strbuf_release(&template_path);
-		return 0;
-	}
-
-	ret = do_files_match(template_path.buf, path);
-
-	strbuf_release(&template_path);
-	return ret;
-}
-
 const char *find_hook(const char *name)
 {
 	static struct strbuf path = STRBUF_INIT;
@@ -64,14 +38,6 @@ const char *find_hook(const char *name)
 		}
 		return NULL;
 	}
-	if (!git_hooks_path && git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0) &&
-	    !identical_to_template_hook(name, path.buf))
-		die(_("active `%s` hook found during `git clone`:\n\t%s\n"
-		      "For security reasons, this is disallowed by default.\n"
-		      "If this is intentional and the hook should actually "
-		      "be run, please\nrun the command again with "
-		      "`GIT_CLONE_PROTECTION_ACTIVE=false`"),
-		    name, path.buf);
 	return path.buf;
 }
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 20deca0231b..fd029843307 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -771,57 +771,6 @@ test_expect_success 'batch missing blob request does not inadvertently try to fe
 	git clone --filter=blob:limit=0 "file://$(pwd)/server" client
 '
 
-test_expect_success 'clone with init.templatedir runs hooks' '
-	git init tmpl/hooks &&
-	write_script tmpl/hooks/post-checkout <<-EOF &&
-	echo HOOK-RUN >&2
-	echo I was here >hook.run
-	EOF
-	git -C tmpl/hooks add . &&
-	test_tick &&
-	git -C tmpl/hooks commit -m post-checkout &&
-
-	test_when_finished "git config --global --unset init.templateDir || :" &&
-	test_when_finished "git config --unset init.templateDir || :" &&
-	(
-		sane_unset GIT_TEMPLATE_DIR &&
-		NO_SET_GIT_TEMPLATE_DIR=t &&
-		export NO_SET_GIT_TEMPLATE_DIR &&
-
-		git -c core.hooksPath="$(pwd)/tmpl/hooks" \
-			clone tmpl/hooks hook-run-hookspath 2>err &&
-		! grep "active .* hook found" err &&
-		test_path_is_file hook-run-hookspath/hook.run &&
-
-		git -c init.templateDir="$(pwd)/tmpl" \
-			clone tmpl/hooks hook-run-config 2>err &&
-		! grep "active .* hook found" err &&
-		test_path_is_file hook-run-config/hook.run &&
-
-		git clone --template=tmpl tmpl/hooks hook-run-option 2>err &&
-		! grep "active .* hook found" err &&
-		test_path_is_file hook-run-option/hook.run &&
-
-		git config --global init.templateDir "$(pwd)/tmpl" &&
-		git clone tmpl/hooks hook-run-global-config 2>err &&
-		git config --global --unset init.templateDir &&
-		! grep "active .* hook found" err &&
-		test_path_is_file hook-run-global-config/hook.run &&
-
-		# clone ignores local `init.templateDir`; need to create
-		# a new repository because we deleted `.git/` in the
-		# `setup` test case above
-		git init local-clone &&
-		cd local-clone &&
-
-		git config init.templateDir "$(pwd)/../tmpl" &&
-		git clone ../tmpl/hooks hook-run-local-config 2>err &&
-		git config --unset init.templateDir &&
-		! grep "active .* hook found" err &&
-		test_path_is_missing hook-run-local-config/hook.run
-	)
-'
-
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
gitgitgadget

