Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B44239AE7
	for <git@vger.kernel.org>; Sat, 18 May 2024 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716028382; cv=none; b=bt/n1oF/lF2x6WH7F+UpOVOzmzk6d58mO+mfZjrksNDvgpuIo8WEUu2EiJmQgV3fMNKkTZK6mWOZS1NnGx1DeTFsl4DFoT8I/r4xOHnNwV8jp8pvmMFLS2d0nyM+C0wgFH4lyBKNJ2yVF4O12nhKVBEP/bYgG+T4Lz9jN9EUhKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716028382; c=relaxed/simple;
	bh=CxnrtJgGPZIIx/97URim9Dl9+EAgkdPBP+aIaFTfsdA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=vA/WKYMPWNJixiynL45IykueLk1yqw0myVHe10NVoZAUZ4ft/3+Bfq8LXNSZL3msN3NbQ7Y9PG+UkXgUbzaFnpFnQD8Nb7puJBpwdSlX+81f+5zt2z77qWh6TYvvFHqBfp0fY3zUNLk9BpjNpfFY3x7BjPdykN4Lym6cz5CAaWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6tr/sto; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6tr/sto"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-420180b5922so11622445e9.2
        for <git@vger.kernel.org>; Sat, 18 May 2024 03:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716028378; x=1716633178; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5iRr1/kZmqw5xIjvYHEIZu60wvxlWvTP3syrKM68bE=;
        b=R6tr/stow1Xo6rQ5C2sIWa5bDvc9jTc6EWfyXuxD0R4mmuwaMNk4AVDZoEDF0vqba2
         KIY0iMAXdPJ5c1SF53LSaCY1uG8quSQS9Kl8hL/X3cbP0aCDflCfq8d/FVxiFhsJjp5T
         uDWI57idMIV9d9QQYW+Yut5AtgaqHtccx8MNoHguJmkiQV0709Mh4n4mVARR1uQ1ud9J
         VpiiC6ZBNT0ZWKRv5ZdA880960HXp3DOgRV9Ed5UJadX9Pngb1DZYW+9WEymRP54qEZV
         /PaWa33KYtgLfA5T9zcHdTRKaupbngRXW4FckKr9cBoUnIFxujiXjmv/3F96iMS/IIhX
         1SLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716028378; x=1716633178;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5iRr1/kZmqw5xIjvYHEIZu60wvxlWvTP3syrKM68bE=;
        b=Xh3eNhjZJImbChh+eo2+UYrYd7U/ykYCqrbvq1/cjbHWbkogKVLUBNZX3mnZpmLqws
         uAf4scN6kyVS+z6zWHTCO2wQMi2AV4EfbI/hSl/4gZ2hRw8b7UUZRnlOT3VW2j/QR0o5
         9Dy2mcOMVqlOp6v42goFjLvNv94xKYL5SU5s9gU90NsZQS/MQjXH91CIUSFVdpuOvZCL
         T77jfgOCFy+VvsRZ4H4fo7Hjq2gYqaCsFbibFx9w7C+nc7AGNSvuz5rsQzbikXPf8Yn1
         4AvphHtsMkoW8dt1MPn5zLIfojOauCbJBZF8bo5nQXxNi7ogk9a9I+te5GsvKJkqPmEN
         tAgw==
X-Gm-Message-State: AOJu0Yx6jMIrDPKkEelxpA8xTNmxvhabL3B2v1EpUoL8Gv6khidaRlbd
	oGx7Fh+2Upy3ZpIilKRvhzOR9p8mtFDp4CnbyUWQLHtxFVC1OKDopWY6bQ==
X-Google-Smtp-Source: AGHT+IHTixptnmOOgn6Oxyh1ItQFI+Kezcm6o/BfaBRbHuiHUNh8PUFfDuI/d0bQpr66VsLQM8qigg==
X-Received: by 2002:a05:600c:190c:b0:41a:47db:290c with SMTP id 5b1f17b1804b1-41fea93a099mr270351945e9.5.1716028378210;
        Sat, 18 May 2024 03:32:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351b79e8e6bsm16163927f8f.65.2024.05.18.03.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 03:32:57 -0700 (PDT)
Message-Id: <bd6d72625f53e5983256da0ed7fe1a6431b3cfdf.1716028367.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
	<pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 May 2024 10:32:45 +0000
Subject: [PATCH v2 7/8] hooks(clone protections): simplify templates hooks
 validation
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When an active hook is encountered during a clone operation, to protect
against Remote Code Execution attack vectors, Git checks whether the
hook was copied over from the templates directory.

When that logic was introduced, there was no other way to check this
than to add a function to compare files.

In the meantime, we've added code to compute the SHA-256 checksum of a
given hook and compare that checksum against a list of known-safe ones.

Let's simplify the logic by adding to said list when copying the
templates' hooks.

We need to be careful to support multi-process operations such as
recursive submodule clones: In such a scenario, the list of SHA-256
checksums that is kept in memory is not enough, we also have to pass the
information down to child processes via `GIT_CONFIG_PARAMETERS`.

Extend the regression test in t5601 to ensure that recursive clones are
handled as expected.

Note: Technically there is no way that the checksums computed while
initializing the submodules' gitdirs can be passed to the process that
performs the checkout: For historical reasons, these operations are
performed in processes spawned in separate loops from the
super-project's `git clone` process. But since the templates from which
the submodules are initialized are the very same as the ones from which
the super-project is initialized, we can get away with using the list of
SHA-256 checksums that is computed when initializing the super-project
and passing that down to the `submodule--helper` processes that perform
the recursive checkout.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/init-db.c |  7 +++++++
 hook.c            | 43 ++++++++++++++++---------------------------
 hook.h            | 10 ++++++++++
 setup.c           |  1 +
 t/t5601-clone.sh  | 19 +++++++++++++++++++
 5 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index a101e7f94c1..64357fdada4 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -10,6 +10,8 @@
 #include "exec-cmd.h"
 #include "parse-options.h"
 #include "worktree.h"
+#include "run-command.h"
+#include "hook.h"
 
 #ifdef NO_TRUSTABLE_FILEMODE
 #define TEST_FILEMODE 0
@@ -28,6 +30,7 @@ static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
 	size_t path_baselen = path->len;
 	size_t template_baselen = template_path->len;
 	struct dirent *de;
+	int is_hooks_dir = ends_with(template_path->buf, "/hooks/");
 
 	/* Note: if ".git/hooks" file exists in the repository being
 	 * re-initialized, /etc/core-git/templates/hooks/update would
@@ -80,6 +83,10 @@ static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
 			strbuf_release(&lnk);
 		}
 		else if (S_ISREG(st_template.st_mode)) {
+			if (is_hooks_dir &&
+			    is_executable(template_path->buf))
+				add_safe_hook(template_path->buf);
+
 			if (copy_file(path->buf, template_path->buf, st_template.st_mode))
 				die_errno(_("cannot copy '%s' to '%s'"),
 					  template_path->buf, path->buf);
diff --git a/hook.c b/hook.c
index f81b13df142..9e762cc9af6 100644
--- a/hook.c
+++ b/hook.c
@@ -4,32 +4,6 @@
 #include "config.h"
 #include "strmap.h"
 
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
 static struct strset safe_hook_sha256s = STRSET_INIT;
 static int safe_hook_sha256s_initialized;
 
@@ -60,6 +34,22 @@ static int get_sha256_of_file_contents(const char *path, char *sha256)
 	return 0;
 }
 
+void add_safe_hook(const char *path)
+{
+	char sha256[GIT_SHA256_HEXSZ + 1] = { '\0' };
+
+	if (!get_sha256_of_file_contents(path, sha256)) {
+		char *p;
+
+		strset_add(&safe_hook_sha256s, sha256);
+
+		/* support multi-process operations e.g. recursive clones */
+		p = xstrfmt("safe.hook.sha256=%s", sha256);
+		git_config_push_parameter(p);
+		free(p);
+	}
+}
+
 static int safe_hook_cb(const char *key, const char *value, void *d)
 {
 	struct strset *set = d;
@@ -131,7 +121,6 @@ const char *find_hook(const char *name)
 		return NULL;
 	}
 	if (!git_hooks_path && git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0) &&
-	    !identical_to_template_hook(name, path.buf) &&
 	    !is_hook_safe_during_clone(name, path.buf, sha256))
 		die(_("active `%s` hook found during `git clone`:\n\t%s\n"
 		      "For security reasons, this is disallowed by default.\n"
diff --git a/hook.h b/hook.h
index 4258b13da0d..e2034ee8b23 100644
--- a/hook.h
+++ b/hook.h
@@ -82,4 +82,14 @@ int run_hooks(const char *hook_name);
  * hook. This function behaves like the old run_hook_le() API.
  */
 int run_hooks_l(const char *hook_name, ...);
+
+/**
+ * Mark the contents of the provided path as safe to run during a clone
+ * operation.
+ *
+ * This function is mainly used when copying templates to mark the
+ * just-copied hooks as benign.
+ */
+void add_safe_hook(const char *path);
+
 #endif
diff --git a/setup.c b/setup.c
index c3301f5ab82..7f7538c9bf7 100644
--- a/setup.c
+++ b/setup.c
@@ -7,6 +7,7 @@
 #include "promisor-remote.h"
 #include "quote.h"
 #include "exec-cmd.h"
+#include "hook.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 20deca0231b..71eaa3d1e14 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -819,6 +819,25 @@ test_expect_success 'clone with init.templatedir runs hooks' '
 		git config --unset init.templateDir &&
 		! grep "active .* hook found" err &&
 		test_path_is_missing hook-run-local-config/hook.run
+	) &&
+
+	test_config_global protocol.file.allow always &&
+	git -C tmpl/hooks submodule add "$(pwd)/tmpl/hooks" sub &&
+	test_tick &&
+	git -C tmpl/hooks add .gitmodules sub &&
+	git -C tmpl/hooks commit -m submodule &&
+
+	(
+		sane_unset GIT_TEMPLATE_DIR &&
+		NO_SET_GIT_TEMPLATE_DIR=t &&
+		export NO_SET_GIT_TEMPLATE_DIR &&
+
+		git -c init.templateDir="$(pwd)/tmpl" \
+			clone --recurse-submodules \
+			tmpl/hooks hook-run-submodule 2>err &&
+		! grep "active .* hook found" err &&
+		test_path_is_file hook-run-submodule/hook.run &&
+		test_path_is_file hook-run-submodule/sub/hook.run
 	)
 '
 
-- 
gitgitgadget

