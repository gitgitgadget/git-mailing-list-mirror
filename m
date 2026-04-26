Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD3E366814
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214335; cv=none; b=LYgzmCwhbEOejIagY+g91peNXPYuzETM20cQABIl+YYWtNVEM0gZ35gxcbEYt0kKyVmLyi6nNSmz4pylMSDPjjv6xA3WCTKzhllG5R8/mz+ubZ153f1/JUZOzTMy9dLIldmEPK4VjRrfibBOHDR1U0LwNScIzb8a6j45z2SOD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214335; c=relaxed/simple;
	bh=pS0qRYyoKJl8T57rsP+ANZZYD40oyqq2wpoSgBTdGU8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DJxci56lqDNCF40fmYwMRVjhhXguc1RAmfgdDpwgm3fZrLTyHX5JKwNG+9kOYlfiUIMGLfgGsISsennXHySZypmT0jmZ2zRB73gCk4YDv/CC5GjdFvh0QHSzQpg56Z3XEQkC4+arN2fGhcXWSRDkP4OWa02oOY0xH6Dg/qfxUgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDDhiRyE; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDDhiRyE"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8e0a768331cso1037418085a.0
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214332; x=1777819132; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lzdBQotG7F1Znt3c9k1B+J65DF+wORqmE4AJc2gC1I=;
        b=DDDhiRyEyX+98ooG4o7Q0Fj2z9hb3jsDUdZyIyMnl7nh29N9huTYugI93+fJpm5DN1
         jHGWdu4P1Lbm8hVwjSSsriQoxY0SKmWpMyhYLYBDbbS0IvWhgIFL/Us4TYm2bjOUIFhR
         6LBGQrqIHV4q0oUuV0SaBoepNEBBXylJdLvyN18QVicbKg46wBrNVFjf0SO9Xf63gGV2
         srq7/kGmcvX6kDZvgX/4uXRZQNT89348VciOrRPN2N+DUCG/kd8RJXd9WFgB4VFkRs+C
         kfam0dstv3r5zuXtXnfP2wInxBMx+m1QLN94JBdLWVgd66V3zK6w9dFZuJjyo/1mhykD
         YUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214332; x=1777819132;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7lzdBQotG7F1Znt3c9k1B+J65DF+wORqmE4AJc2gC1I=;
        b=LWuyHOmYy3pMqzE9OObEqzsPtCvLMslWowrOObMvHdnmWDvBMRb5UnjEiBRuWnePQJ
         0nRzeztQZYvGaRN8bJCTCd8N4D4iF2UXdCCrFKy6Vpw6HPnIhHYQMfoOqEe3ObUj+3TT
         Cb/YhFQjzlmfWCm7CmiTF4RcAuxD/ZQwAkv8lvurW9kgYppDxe0kXhWWZmBWiU90XM+e
         Oy3CDl2rX8IFfkhCrOKm/2vh1y4Y2BaJsuykNdunMvcTRJUycrEKZVI/EfeMnNzNUVob
         Wof2PIc6264bBXHxK7uZr8yi2fq1z38DWtjD3jJEDxtjiLOTXW86r/lh+NExzgiNShYZ
         pAFA==
X-Gm-Message-State: AOJu0YwQn/5dqGfsq3h3MTitJp76wMoueq4kRxEhQjBwYnT2ybmdObwq
	VcbZy6H2zRld9ya41DcS+/s6l7MWD5Tu8ZyOck3JhE3SSI4VStoYrDyMYdxJVZ7X
X-Gm-Gg: AeBDievpfKjLXWGX49uHOAtvQMkL4UqrC2iq867hBrXccZJOvxOrs0EZBAHepieHslO
	udYzLapDH5Khk25Beh4ozLEwHdDkZs5SJ+cjima7pOzVnfCul9+zMq35Il5REMws5sVDmgjFTub
	CC2YlRJtmoEvcM6w8WXnTijMPeFUrG9tc54aoko+xcz/CxK3tvfvINlghffXvUR+dhmFT1x1C5D
	7VO3y5Srj0s0x5Qlv8YVPQ7xpp9QdUkgZy8L5QGTWD7AamGPsqKsUfApXVWPKTVSCqr8pB0fZ14
	8cIwh4SP3tkFbVb+uDWMbo24DhAwok9cUigTjdJq54oEaQo5Y6PLeHQibTxpFNyk6AH2dVHj57p
	p7+QRBSLEdFnnZOCy8jldhftE9Ba3dK06mnL3fUUK85dJwYUWWFwMnempwgqkz5/oTTuDU7+bby
	KchVeoGYLobdpJ2AW9yQih9Xz8fjDvX/b3EA==
X-Received: by 2002:a05:620a:2682:b0:8f2:8bb8:cb52 with SMTP id af79cd13be357-8f28bb8cf74mr1226087885a.4.1777214332233;
        Sun, 26 Apr 2026 07:38:52 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.18.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe9800sm2432394185a.5.2026.04.26.07.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:38:51 -0700 (PDT)
Message-Id: <73bb1aa17141077cf7cd1004feeee36b05886979.1777214316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
	<pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Apr 2026 14:38:36 +0000
Subject: [PATCH v2 8/8] safe.bareRepository: default to "explicit" with
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
