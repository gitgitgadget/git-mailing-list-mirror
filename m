Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FD51420B3
	for <git@vger.kernel.org>; Fri, 17 May 2024 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715987767; cv=none; b=FD1xv/8GmcV5adCwLuig96r9k3oi9bVdEt7Ij87sCnXY/D9HmBW9jgLmoDE7i0oi0ymDr9eibobA5C2AURYT5pTkEUkC/b0nixvwOtMo2jqnYB5+6BjlpHWyn34H1OUBelx6rE5v0hTnanXvYk21kQKPkSx+NUFalWv74SDSODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715987767; c=relaxed/simple;
	bh=0xV52jjmT0eUFdfARNbKgVgZmDGiXMy05FdhFMXRJSc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i31g8uDA/0TbvhludzGjWmQTBK4DqF/WDz+gmEBYdMdgWY3SEU7JlHk/qp9AvY2cgKeQx5qyFr0r7se2jBGAh3SvwZT976hmZt7mj6jcVXkSSLqsoCbv3KW1GqrQywJLII21sjIZVGr0/KLhrI8z0uZ+QJVd3TDywElWrVUwFm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0SiGMt+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0SiGMt+"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4202dd90dcfso6427055e9.0
        for <git@vger.kernel.org>; Fri, 17 May 2024 16:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715987763; x=1716592563; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLuolBlw/BCa8SAwGbeiIe56GkqWWJFI/oG0XotUlPk=;
        b=f0SiGMt+E0Xiq8wI1w1f42XmyWQxSd2CObsQEgCmYgFNQzfmYv4fp2qmNTZ/W+qFh5
         v7BtJ26n/ChSj6XhIYrj4LK+kjkL7sLuqdmOetbKDr/CjmcqbdJp3RbVC4Yt3ZIzrC3c
         Nlhs8G8GFi1Ko16qWED6jW+o/I8sBSqp146PyxzDMDhTFHvANsX3ZY7aH2rkVw9Jdy8b
         naAQFtB5HLg+wX9iLt2N1V0vGde/w7zrpi8ueCRfw1IRdjiLhOapCCH8iNt1qqrXNwGx
         pEdiadxh/3ObiL1a50ZeQ0g1D2ByVj6X/vuImKbsapigKFkgcVwANgMwCAse2KhOodFY
         ZKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715987763; x=1716592563;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLuolBlw/BCa8SAwGbeiIe56GkqWWJFI/oG0XotUlPk=;
        b=dMarSQv8bBS9I7aT5PNAqwmCgg/3+2pXE1akKY6+krpx6Zah+s6uitgf2yHJt+ST+U
         mui1Xp8f9oamPMmPLuiBdRIPT78OLBpLb4WG0SDChZevS6sQWpGGmD/VIl2fafOM+Jyr
         KUlrwd3ZnKYAeguUkD3nwECW5Vt1znvto2iSibSG4HLmM9l7UloA/w8f40P/fOlUk9B7
         3+/HjZi49XUs5AN13Ml8pzssfDWEjiFuPwUoBasV8+PKjuXCcR9osQMFtBxeC0YsYFtT
         3LNxJs0QrW1+m8UbfGk+HghC2V14HkhueGCk2RHVTHW0c0oALA/V0REl+oZra9n8Gn7r
         ErwA==
X-Gm-Message-State: AOJu0YxDKxGpfx2au4rzv/LgXAc/jg3sVFWzKE2XQnmUB0Jl0SxTebtU
	pAOsxLxxodJaTrvlmT/hNb8dJSua2oFtdgFc4wl/JUOG+FbZg9+G9d+KoA==
X-Google-Smtp-Source: AGHT+IHR/Ta3WwsuA1/z1A0kP1Oj+iR7LUpuO8FsvsRoC4AUL2PEEmkuQXjnHDSF6G/ECwZEnU4aPg==
X-Received: by 2002:a05:600c:1e13:b0:420:2986:ccee with SMTP id 5b1f17b1804b1-4202986d070mr54799705e9.30.1715987763256;
        Fri, 17 May 2024 16:16:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8fa6sm321993255e9.2.2024.05.17.16.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 16:16:02 -0700 (PDT)
Message-Id: <a4f5eeef6677462267d1dbf4b2b58d30aa013684.1715987756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 May 2024 23:15:53 +0000
Subject: [PATCH 5/8] hook(clone protections): add escape hatch
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
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

