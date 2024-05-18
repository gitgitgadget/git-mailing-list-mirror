Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1338384
	for <git@vger.kernel.org>; Sat, 18 May 2024 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716028380; cv=none; b=FfCL0z8wNMCe9ad5dUawsFNut96Hk3tc09zVrKqWuOD2vSzRI3Ps4DJolc6R9o7fSj2z5p2C9xCQT8JXSd2o6Kg8DDBk15igFWZIlbgp0Fve8jRK6/EaT/1jRdF0UNZEChOLPaya0DryiLwGi8g1fl4yAZD6FD+iJ5XQKNuTh6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716028380; c=relaxed/simple;
	bh=0xV52jjmT0eUFdfARNbKgVgZmDGiXMy05FdhFMXRJSc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gUodk9feM2JXU7sexbMGbBqVePPoDQcKxJFH00hqE6+ShMY4xPGcz7Q+W/igg8l3GQPZgnmYfbARVuJ9f3MvhnpRRVqfNkWAFZYCys13elHywJsI5XCK3v01ZlKmsI5oXmiieCSneIRkt+CW8c6C6aeDBO/KMKFLJMj5yzp7EMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnigFSOB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnigFSOB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-420160f8f52so8495885e9.0
        for <git@vger.kernel.org>; Sat, 18 May 2024 03:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716028376; x=1716633176; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLuolBlw/BCa8SAwGbeiIe56GkqWWJFI/oG0XotUlPk=;
        b=UnigFSOBDbwSgQUvkALOOqhaLhDtGaWealufghJUDZlHiZPKWHxiFv1VmWqBG3Yk/O
         MNiwen1HME/rL2sUTMYMHlX3/sSsc613Hji5If8ZUZtbN1VBvAounsWsocM39HGmpFYB
         8viAiM+bpYTukc2RfUu3l8lUmv9tz9MMAX+WFghHvkM0okYx+NzSLG50Xz55ylLkJiPN
         BkMXKgGMKtBfjoUF+3liVfu4A1bdYeZ9Y+/r8/oBUYPwqvct6T/cgIiTboK/yyuJnSFf
         M7wsWvtkW3JhreyAI2fcFj6gZh2xcJb79CWwasJyltPwcuXJWd4QAZwpHuL9sUh6q4y7
         XYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716028376; x=1716633176;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLuolBlw/BCa8SAwGbeiIe56GkqWWJFI/oG0XotUlPk=;
        b=F3uTy7CocW4bCxGfJTXL/YMiK4ubqXOZC8MxAIhrb8TKNwPRAuu+QJk/DIKhnSwccs
         QGPIAQMwFe20E9ze3oS7v9la8fMMvRX5GoCkedyA8kJmnz3hHz3113zthTukwsk8YsY/
         S/Q9DO7t+GNNvy2MhP4cvAfuyCc8BkIa1Ky7weceZ0Mb7ChwPka09KCbt+r5N0/ydfXK
         A0ky3aOLynN6blCObzeTu3aK7Yb8VEvrtjm9Ae0Nu0QR5S//z5I2mo6+QLW9b5NA2Meq
         7NuY2du0MrVWuGYcqbQBy5j9Gl5GjcDVJoYfPqaQjy5pQ9yUqZAm+15mNNtYhMh76KWD
         vpzQ==
X-Gm-Message-State: AOJu0Yx+NR3x1m5PIFS/0cRmkHNxm4pYMV/LFSMy5Cf4/AVbO1won0qM
	fuTae20KN53xgRSyybMcFOBCx6KqJ/TQlLHYKJjQGbIlWGyb8dedg4IBpQ==
X-Google-Smtp-Source: AGHT+IEusBEpD4ojbeeLBLEqnkcNn/gKe7qfBaNTyTr/TQ0O2ccrGVXQwVFRwDBdENsXDuoQGT4jeQ==
X-Received: by 2002:a05:600c:3544:b0:420:29dd:84d5 with SMTP id 5b1f17b1804b1-42029dd8898mr63171635e9.5.1716028375776;
        Sat, 18 May 2024 03:32:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4201da9895csm181294915e9.44.2024.05.18.03.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 03:32:54 -0700 (PDT)
Message-Id: <b841db8392ebd924d1893829a7e5e22240f1e9cf.1716028366.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
	<pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 May 2024 10:32:43 +0000
Subject: [PATCH v2 5/8] hook(clone protections): add escape hatch
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

As defense-in-depth measures, v2.39.4 and friends leading up to v2.45.1
introduced code that detects when hooks have been installed during a
`git clone`, which is indicative of a common attack vector with critical
severity that allows Remote Code Execution.

There are legitimate use cases for such behavior, though, for example
when those hooks stem from Git's own templates, which system
administrators are at liberty to modify to enforce, say, commit message
conventions. The git clone protections specifically add exceptions to
allow for that.

Another legitimate use case that has been identified too late to be
handled in these security bug-fix versions is Git LFS: It behaves
somewhat similar to common attack vectors by writing a few hooks while
running the `smudge` filter during a regular clone, which means that Git
has no chance to know that the hooks are benign and e.g. the
`post-checkout` hook can be safely executed as part of the clone
operation.

To help Git LFS, and other tools behaving similarly (if there are any),
let's add a new, multi-valued `safe.hook.sha256` config setting. Like
the already-existing `safe.*` settings, it is ignored in
repository-local configs, and it is interpreted as a list of SHA-256
checksums of hooks' contents that are safe to execute during a clone
operation. Future Git LFS versions will need to write those entries at
the same time they install the `smudge`/`clean` filters.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/safe.txt |  6 ++++
 hook.c                        | 66 ++++++++++++++++++++++++++++++++---
 t/t1800-hook.sh               | 15 ++++++++
 3 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index bde7f31459b..69ee845be89 100644
--- a/Documentation/config/safe.txt
+++ b/Documentation/config/safe.txt
@@ -59,3 +59,9 @@ which id the original user has.
 If that is not what you would prefer and want git to only trust
 repositories that are owned by root instead, then you can remove
 the `SUDO_UID` variable from root's environment before invoking git.
+
+safe.hook.sha256::
+	The value is the SHA-256 of hooks that are considered to be safe
+	to run during a clone operation.
++
+Multiple values can be added via `git config --global --add`.
diff --git a/hook.c b/hook.c
index fc974cee1d8..a2479738451 100644
--- a/hook.c
+++ b/hook.c
@@ -2,6 +2,7 @@
 #include "hook.h"
 #include "run-command.h"
 #include "config.h"
+#include "strmap.h"
 
 static int identical_to_template_hook(const char *name, const char *path)
 {
@@ -29,11 +30,65 @@ static int identical_to_template_hook(const char *name, const char *path)
 	return ret;
 }
 
+static struct strset safe_hook_sha256s = STRSET_INIT;
+static int safe_hook_sha256s_initialized;
+
+static int get_sha256_of_file_contents(const char *path, char *sha256)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int fd;
+	ssize_t res;
+
+	git_hash_ctx ctx;
+	const struct git_hash_algo *algo = &hash_algos[GIT_HASH_SHA256];
+	unsigned char hash[GIT_MAX_RAWSZ];
+
+	if ((fd = open(path, O_RDONLY)) < 0)
+		return -1;
+	res = strbuf_read(&sb, fd, 400);
+	close(fd);
+	if (res < 0)
+		return -1;
+
+	algo->init_fn(&ctx);
+	algo->update_fn(&ctx, sb.buf, sb.len);
+	strbuf_release(&sb);
+	algo->final_fn(hash, &ctx);
+
+	hash_to_hex_algop_r(sha256, hash, algo);
+
+	return 0;
+}
+
+static int safe_hook_cb(const char *key, const char *value, void *d)
+{
+	struct strset *set = d;
+
+	if (value && !strcmp(key, "safe.hook.sha256"))
+		strset_add(set, value);
+
+	return 0;
+}
+
+static int is_hook_safe_during_clone(const char *name, const char *path, char *sha256)
+{
+	if (get_sha256_of_file_contents(path, sha256) < 0)
+		return 0;
+
+	if (!safe_hook_sha256s_initialized) {
+		safe_hook_sha256s_initialized = 1;
+		git_protected_config(safe_hook_cb, &safe_hook_sha256s);
+	}
+
+	return strset_contains(&safe_hook_sha256s, sha256);
+}
+
 const char *find_hook(const char *name)
 {
 	static struct strbuf path = STRBUF_INIT;
 
 	int found_hook;
+	char sha256[GIT_SHA256_HEXSZ + 1] = { '\0' };
 
 	strbuf_reset(&path);
 	strbuf_git_path(&path, "hooks/%s", name);
@@ -65,13 +120,14 @@ const char *find_hook(const char *name)
 		return NULL;
 	}
 	if (!git_hooks_path && git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0) &&
-	    !identical_to_template_hook(name, path.buf))
+	    !identical_to_template_hook(name, path.buf) &&
+	    !is_hook_safe_during_clone(name, path.buf, sha256))
 		die(_("active `%s` hook found during `git clone`:\n\t%s\n"
 		      "For security reasons, this is disallowed by default.\n"
-		      "If this is intentional and the hook should actually "
-		      "be run, please\nrun the command again with "
-		      "`GIT_CLONE_PROTECTION_ACTIVE=false`"),
-		    name, path.buf);
+		      "If this is intentional and the hook is safe to run, "
+		      "please run the following command and try again:\n\n"
+		      "  git config --global --add safe.hook.sha256 %s"),
+		    name, path.buf, sha256);
 	return path.buf;
 }
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 2ef3579fa7c..0f74c9154d0 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -177,4 +177,19 @@ test_expect_success 'git hook run a hook with a bad shebang' '
 	test_cmp expect actual
 '
 
+test_expect_success '`safe.hook.sha256` and clone protections' '
+	git init safe-hook &&
+	write_script safe-hook/.git/hooks/pre-push <<-\EOF &&
+	echo "called hook" >safe-hook.log
+	EOF
+
+	test_must_fail env GIT_CLONE_PROTECTION_ACTIVE=true \
+		git -C safe-hook hook run pre-push 2>err &&
+	cmd="$(grep "git config --global --add safe.hook.sha256 [0-9a-f]" err)" &&
+	eval "$cmd" &&
+	GIT_CLONE_PROTECTION_ACTIVE=true \
+		git -C safe-hook hook run pre-push &&
+	test "called hook" = "$(cat safe-hook/safe-hook.log)"
+'
+
 test_done
-- 
gitgitgadget

