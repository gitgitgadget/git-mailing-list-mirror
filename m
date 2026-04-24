Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6AA280CFB
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042893; cv=none; b=aQ7JL/OvSK5hrmE2kKG8jiCY1xk0RSyxjMor8LRY0c6qIa2ku5FkchZNGYYLhVDep/eINYRGH104y45fITuxV2ZHc1S43MmiEy67GPZPO4srRIS9p8l8+iXXddFnZVpAAuxz1hCaKn0y24FxktJAh4BGO0dApUFjAE+kRVu5b5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042893; c=relaxed/simple;
	bh=pS0qRYyoKJl8T57rsP+ANZZYD40oyqq2wpoSgBTdGU8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=r25eIU2q7D1IwOS2jvXFirShgxPbmm1WudiBNKb6a40xGNGMTpc6ASY3P+obgjcUCXOccLLNJpf89VAPxmEHluvLRrhyDMYSoO7O9Fu7zkng5na0rOKTODtqpvbZ8/a/+vWwT2wgNGC+H03irrAGkrg50Q9c6sEZx5AF6Vlcshc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkuJGkeq; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkuJGkeq"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c70b5594f4so873735185a.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777042890; x=1777647690; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lzdBQotG7F1Znt3c9k1B+J65DF+wORqmE4AJc2gC1I=;
        b=HkuJGkeqednCCi8sIxP+uPWBd40PD+sbJNyRZhOC67nUYXICSr7ySMXFg0fkM43OnV
         Ttb0tGb8RqMwESa6JqxUQmy/4LQVhb78zYyKkuBE/R9A7L3A+LFc1O0q/ncCYjv2JX8s
         iFUCJJbYK0q6sdtZ2a9O+C1/IMVpR6q5moIeYo+lgSAG1vEQvGywh1FUvoI9/WS4FjjN
         NvI0AnN/ZRRqKN8LQ5QOk9c1pkYDVnW076cQodTRglGLhiiCYCk5Wf2M9dX5Qyx0HfY+
         aFHBnTDwW3trF2+XBfYt0Iot66O8zK5UEQ7BBYC0mkU+ubAzGW45ILAx05qnQfSrrNeJ
         FvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777042890; x=1777647690;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7lzdBQotG7F1Znt3c9k1B+J65DF+wORqmE4AJc2gC1I=;
        b=MlyqsPq7UJGC9GGfvq/qrIT1fL3jsibvGJ8KjKHGb/1OKuj3ILb7W1ZPk0xLrzbWqs
         Vpf/ucZ9728QuRSiu/ZYmm9u9/8sduH2LvM/SbJMp+M9CNinQrr8+WEaADtL7uAa4jkE
         9OEdQfTwOIDGGhypNk6QHAdMAE1VtcuykS2PzKKIMTCRzRfYlvaqla9Dg5vRhcvLjM5n
         EaHd9qYSZPFjWZIKaN9X99W3QSOWoBAeJTw+Xeb68qBvdM2UMCxnb3f/B7xMlkO+sxNe
         srE8QV7ATGL2+BlS3UuxVR9EmhRzifBpqSPrhtSiX2Vuv2HRAZu42IgWxmeQhq6CG0Ys
         wZWg==
X-Gm-Message-State: AOJu0YztWQyP8Ouwn9TLaBB86EVwHF4xkpZdJ7L/ugDeFjAS1bVCSAfk
	79e+z7p8sbFt9FFz/s7TRDEcCrQZ7ORXFS1hBcOUQHhVdZdr+BKIullHexzLNw==
X-Gm-Gg: AeBDieuSdURrwOSzyWWNuZNzFOGDlagOprP0E3L7+aJPm9gLAcEuQC+GsdrK1QcuV9l
	U8HxnZp4tk4s+3uv/0qHjoWwT8PnI5SGX6jyP6fWPcZFaMGvjzPlljzlWy6q9AV99+xpv8Z9TUp
	Cvl86TmFi0Y8MS89Q2pmCgKd+EeCeTOW8/3+mzCFAR//7QjjszXhITiGXOYB0xEVtAha11kMvt0
	PQPCuR/T63VzhPLnkXlJABAXe5IdEQBmnLJdMN1vYwNNq6+FER0E0W4zNtlzTN1Ji5MNjf4BOV/
	/MNbWNHdlUacFMdt0BMLGDGYR/2iPj7QL7pHYcOpsytqQfuMiE1QaoiPX1/mRU/chWXtMRvX/nm
	HiXcWv2NSCN/ziJEl/ux2lBeMLnjJjwQjqCLxC5R8XO5H2FADs8Yr1AOUSKFDdaoJqnmurM+sia
	kvAbsLLwIHzBUpwA25ol8DLKqkMpvwxh2ReVUa7MtgCjPWrm4r
X-Received: by 2002:a05:620a:44cb:b0:8f1:7ce7:5aff with SMTP id af79cd13be357-8f17ce7613fmr735710785a.1.1777042889855;
        Fri, 24 Apr 2026 08:01:29 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.133])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe90afsm2253891585a.3.2026.04.24.08.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:01:29 -0700 (PDT)
Message-Id: <64db45e38575015b6e0ffdeff39d9ba851eb1e38.1777042877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Apr 2026 15:01:17 +0000
Subject: [PATCH 8/8] safe.bareRepository: default to "explicit" with
 WITH_BREAKING_CHANGES
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

When an attacker can convince a user to clone a crafted repository
that contains an embedded bare repository with malicious hooks, any Git
command the user runs after entering that subdirectory will discover
the bare repository and execute the hooks. The user does not even need
to run a Git command explicitly: many shell prompts run `git status`
in the background to display branch and dirty state information, and
`git status` in turn may invoke the fsmonitor hook if so configured,
making the user vulnerable the moment they `cd` into the directory. The
`safe.bareRepository` configuration variable (introduced in 8959555cee7e
(setup_git_directory(): add an owner check for the top-level directory,
2022-03-02)) already provides protection against this attack vector by
allowing users to set it to "explicit", but the default remained "all"
for backwards compatibility.

Since Git 3.0 is the natural point to change defaults to safer
values, flip the default from "all" to "explicit" when built with
`WITH_BREAKING_CHANGES`. This means Git will refuse to work with bare
repositories that are discovered implicitly by walking up the directory
tree. Bare repositories specified via `--git-dir` or `GIT_DIR` continue
to work, and directories that look like `.git`, worktrees, or submodule
directories are unaffected (the existing `is_implicit_bare_repo()`
whitelist handles those cases).

Users who rely on implicit bare repository discovery can restore the
previous behavior by setting `safe.bareRepository=all` in their global
or system configuration.

The test for the "safe.bareRepository in the repository" scenario
needed a more involved fix: it writes a `safe.bareRepository=all`
entry into the bare repository's own config to verify that repo-local
config does not override the protected (global) setting. Previously,
`test_config -C` was used to write that entry, but its cleanup runs `git
-C <bare-repo> config --unset`, which itself fails when the default is
"explicit" and the global config has already been cleaned up. Switching
to direct git config --file access avoids going through repository
discovery entirely.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/BreakingChanges.adoc | 24 ++++++++++++++++++++++++
 Documentation/config/safe.adoc     | 10 ++++++++--
 setup.c                            |  4 ++++
 t/t0035-safe-bare-repository.sh    | 10 ++++++++--
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index af59c43f42..73bb939359 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -216,6 +216,30 @@ would be significant, we may decide to defer this change to a subsequent minor
 release. This evaluation will also take into account our own experience with
 how painful it is to keep Rust an optional component.
 
+* The default value of `safe.bareRepository` will change from `all` to
+  `explicit`. It is all too easy for an attacker to trick a user into cloning a
+  repository that contains an embedded bare repository with malicious hooks
+  configured. If the user enters that subdirectory and runs any Git command, Git
+  discovers the bare repository and the hooks fire. The user does not even need
+  to run a Git command explicitly: many shell prompts run `git status` in the
+  background to display branch and dirty state information, and `git status` in
+  turn may invoke the fsmonitor hook if so configured, making the user
+  vulnerable the moment they `cd` into the directory. The `safe.bareRepository`
+  configuration variable was introduced in 8959555cee (setup_git_directory():
+  add an owner check for the top-level directory, 2022-03-02) with a default of
+  `all` to preserve backwards compatibility.
++
+Changing the default to `explicit` means that Git will refuse to work with bare
+repositories that are discovered implicitly by walking up the directory tree.
+Bare repositories specified explicitly via the `--git-dir` command-line option
+or the `GIT_DIR` environment variable continue to work regardless of this
+setting. Repositories that look like a `.git` directory, a worktree, or a
+submodule directory are also unaffected.
++
+Users who rely on implicit discovery of bare repositories can restore the
+previous behavior by setting `safe.bareRepository=all` in their global or
+system configuration.
+
 === Removals
 
 * Support for grafting commits has long been superseded by git-replace(1).
diff --git a/Documentation/config/safe.adoc b/Documentation/config/safe.adoc
index 2d45c98b12..5b1690aebe 100644
--- a/Documentation/config/safe.adoc
+++ b/Documentation/config/safe.adoc
@@ -2,10 +2,12 @@ safe.bareRepository::
 	Specifies which bare repositories Git will work with. The currently
 	supported values are:
 +
-* `all`: Git works with all bare repositories. This is the default.
+* `all`: Git works with all bare repositories. This is the default in
+  Git 2.x.
 * `explicit`: Git only works with bare repositories specified via
   the top-level `--git-dir` command-line option, or the `GIT_DIR`
-  environment variable (see linkgit:git[1]).
+  environment variable (see linkgit:git[1]). This will be the default
+  in Git 3.0.
 +
 If you do not use bare repositories in your workflow, then it may be
 beneficial to set `safe.bareRepository` to `explicit` in your global
@@ -13,6 +15,10 @@ config. This will protect you from attacks that involve cloning a
 repository that contains a bare repository and running a Git command
 within that directory.
 +
+If you use bare repositories regularly and want to preserve the current
+behavior after upgrading to Git 3.0, set `safe.bareRepository` to `all`
+in your global or system config.
++
 This config setting is only respected in protected configuration (see
 <<SCOPES>>). This prevents untrusted repositories from tampering with
 this value.
diff --git a/setup.c b/setup.c
index 7ec4427368..17c0662076 100644
--- a/setup.c
+++ b/setup.c
@@ -1485,7 +1485,11 @@ static int allowed_bare_repo_cb(const char *key, const char *value,
 
 static enum allowed_bare_repo get_allowed_bare_repo(void)
 {
+#ifdef WITH_BREAKING_CHANGES
+	enum allowed_bare_repo result = ALLOWED_BARE_REPO_EXPLICIT;
+#else
 	enum allowed_bare_repo result = ALLOWED_BARE_REPO_ALL;
+#endif
 	git_protected_config(allowed_bare_repo_cb, &result);
 	return result;
 }
diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
index ae7ef092ab..1d3d19f5b4 100755
--- a/t/t0035-safe-bare-repository.sh
+++ b/t/t0035-safe-bare-repository.sh
@@ -44,11 +44,16 @@ test_expect_success 'setup an embedded bare repo, secondary worktree and submodu
 	test_path_is_dir outer-repo/.git/modules/subn
 '
 
-test_expect_success 'safe.bareRepository unset' '
+test_expect_success !WITH_BREAKING_CHANGES 'safe.bareRepository unset' '
 	test_unconfig --global safe.bareRepository &&
 	expect_accepted_implicit -C outer-repo/bare-repo
 '
 
+test_expect_success WITH_BREAKING_CHANGES 'safe.bareRepository unset (defaults to explicit)' '
+	test_unconfig --global safe.bareRepository &&
+	expect_rejected -C outer-repo/bare-repo
+'
+
 test_expect_success 'safe.bareRepository=all' '
 	test_config_global safe.bareRepository all &&
 	expect_accepted_implicit -C outer-repo/bare-repo
@@ -63,7 +68,8 @@ test_expect_success 'safe.bareRepository in the repository' '
 	# safe.bareRepository must not be "explicit", otherwise
 	# git config fails with "fatal: not in a git directory" (like
 	# safe.directory)
-	test_config -C outer-repo/bare-repo safe.bareRepository all &&
+	test_when_finished "git config --file outer-repo/bare-repo/config --unset safe.bareRepository" &&
+	git config --file outer-repo/bare-repo/config safe.bareRepository all &&
 	test_config_global safe.bareRepository explicit &&
 	expect_rejected -C outer-repo/bare-repo
 '
-- 
gitgitgadget
