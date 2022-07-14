Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39D2C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 21:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbiGNV21 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbiGNV2X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 17:28:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F3E6E8AF
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:28:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b26so4251542wrc.2
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J2Cb2WV8SPtEBLtqk3N15f0DIedhfAPPcbM8ECmqUYk=;
        b=QUnynFfM4XStAJym8LTUm8t51Dg4lUZwz3Pa4eUoGgBXVGy4ScW1RwpaYoX073Xvbw
         o2HBFWJe4mBGP38BDrFOi9u+oUbaEWWth6wX1Oo+IumHVX42X2Y15culyWkaDQEiau7R
         VQ+fNKbGEKqA9noiybbSdNb0nyc0QrVdCAC1bl1ZRGTVSEaUGu3TQeYE6ZE/txYna2CD
         emrCjkTyk1VP4LudyydQ0qPD14UMiBs3jhjXARDXrZCUdBwxea9XgXNu+1BuHg5RRTNC
         h4HPk2mPbBbHHcO8MJVyNJW/4SuRgI/zsnODAnimhpoUkEQPIAqql5FS9UUpGWn4URbn
         0iLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J2Cb2WV8SPtEBLtqk3N15f0DIedhfAPPcbM8ECmqUYk=;
        b=fKfM+Fed+djpUz6kXrhA72Q8W+QyOUnDaP89KP0qDUzBENldklgIOg6Cfd+Vp6Y1Cs
         HepQmdG699P1Rie/PL15j6JDApDYu7yOUGFY3hepLtkgWn7WdMuWkL/lz52uSoOrH5Fe
         KLJvIrPujTmEFJJYQ4sIqMTGzyEAmuD6Cq8bnN8JXmg1qGUjXrlfGeEZnx4YzK+M9HQl
         qJTdsD3wy043vr7RiLySCjHZ63UFSvRfzoPGRbxIurpeYq8CJF02Fc08+o4qQVInBiOE
         dXGDY5gSwWc8nFXxKFzPX3VrfeAmHuYmy9IyXHMAaVj2EkgEeGwytGCQxYJrSgttKL5R
         WU9w==
X-Gm-Message-State: AJIora/Am0jFD9fHVF2//I/auKFj78g+gU75DblzqrXtFB5EDYqiuqAS
        t+wjMt3jDV1N8TGBSpIRZWBvvKpxQA0=
X-Google-Smtp-Source: AGRyM1sAtcWGXm6rBgsZN46S7LuY5W3UTS/AUDIBgCUPvkPycAaRjYos6mzoyA1wOUVG+OZ6qh+zvA==
X-Received: by 2002:a05:6000:1f0b:b0:21d:6dae:7d04 with SMTP id bv11-20020a0560001f0b00b0021d6dae7d04mr9967844wrb.414.1657834092162;
        Thu, 14 Jul 2022 14:28:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n66-20020a1ca445000000b003a02de5de80sm6665224wme.4.2022.07.14.14.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:28:11 -0700 (PDT)
Message-Id: <50069bba9a5933fd968a8aa52acefc2a305204f5.1657834082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v8.git.git.1657834081.gitgitgadget@gmail.com>
References: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
        <pull.1261.v8.git.git.1657834081.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 14 Jul 2022 21:28:01 +0000
Subject: [PATCH v8 5/5] setup.c: create `safe.bareRepository`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

There is a known social engineering attack that takes advantage of the
fact that a working tree can include an entire bare repository,
including a config file. A user could run a Git command inside the bare
repository thinking that the config file of the 'outer' repository would
be used, but in reality, the bare repository's config file (which is
attacker-controlled) is used, which may result in arbitrary code
execution. See [1] for a fuller description and deeper discussion.

A simple mitigation is to forbid bare repositories unless specified via
`--git-dir` or `GIT_DIR`. In environments that don't use bare
repositories, this would be minimally disruptive.

Create a config variable, `safe.bareRepository`, that tells Git whether
or not to die() when working with a bare repository. This config is an
enum of:

- "all": allow all bare repositories (this is the default)
- "explicit": only allow bare repositories specified via --git-dir
  or GIT_DIR.

If we want to protect users from such attacks by default, neither value
will suffice - "all" provides no protection, but "explicit" is
impractical for bare repository users. A more usable default would be to
allow only non-embedded bare repositories ([2] contains one such
proposal), but detecting if a repository is embedded is potentially
non-trivial, so this work is not implemented in this series.

[1]: https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com
[2]: https://lore.kernel.org/git/5b969c5e-e802-c447-ad25-6acc0b784582@github.com

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/config/safe.txt   | 19 +++++++++++
 setup.c                         | 57 ++++++++++++++++++++++++++++++++-
 t/t0035-safe-bare-repository.sh | 54 +++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100755 t/t0035-safe-bare-repository.sh

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index f72b4408798..bde7f31459b 100644
--- a/Documentation/config/safe.txt
+++ b/Documentation/config/safe.txt
@@ -1,3 +1,22 @@
+safe.bareRepository::
+	Specifies which bare repositories Git will work with. The currently
+	supported values are:
++
+* `all`: Git works with all bare repositories. This is the default.
+* `explicit`: Git only works with bare repositories specified via
+  the top-level `--git-dir` command-line option, or the `GIT_DIR`
+  environment variable (see linkgit:git[1]).
++
+If you do not use bare repositories in your workflow, then it may be
+beneficial to set `safe.bareRepository` to `explicit` in your global
+config. This will protect you from attacks that involve cloning a
+repository that contains a bare repository and running a Git command
+within that directory.
++
+This config setting is only respected in protected configuration (see
+<<SCOPES>>). This prevents the untrusted repository from tampering with
+this value.
+
 safe.directory::
 	These config entries specify Git-tracked directories that are
 	considered safe even if they are owned by someone other than the
diff --git a/setup.c b/setup.c
index ec5b9139e32..8c683e92b62 100644
--- a/setup.c
+++ b/setup.c
@@ -10,6 +10,10 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 static int work_tree_config_is_bogus;
+enum allowed_bare_repo {
+	ALLOWED_BARE_REPO_EXPLICIT = 0,
+	ALLOWED_BARE_REPO_ALL,
+};
 
 static struct startup_info the_startup_info;
 struct startup_info *startup_info = &the_startup_info;
@@ -1160,6 +1164,46 @@ static int ensure_valid_ownership(const char *gitfile,
 	return data.is_safe;
 }
 
+static int allowed_bare_repo_cb(const char *key, const char *value, void *d)
+{
+	enum allowed_bare_repo *allowed_bare_repo = d;
+
+	if (strcasecmp(key, "safe.bareRepository"))
+		return 0;
+
+	if (!strcmp(value, "explicit")) {
+		*allowed_bare_repo = ALLOWED_BARE_REPO_EXPLICIT;
+		return 0;
+	}
+	if (!strcmp(value, "all")) {
+		*allowed_bare_repo = ALLOWED_BARE_REPO_ALL;
+		return 0;
+	}
+	return -1;
+}
+
+static enum allowed_bare_repo get_allowed_bare_repo(void)
+{
+	enum allowed_bare_repo result = ALLOWED_BARE_REPO_ALL;
+	git_protected_config(allowed_bare_repo_cb, &result);
+	return result;
+}
+
+static const char *allowed_bare_repo_to_string(
+	enum allowed_bare_repo allowed_bare_repo)
+{
+	switch (allowed_bare_repo) {
+	case ALLOWED_BARE_REPO_EXPLICIT:
+		return "explicit";
+	case ALLOWED_BARE_REPO_ALL:
+		return "all";
+	default:
+		BUG("invalid allowed_bare_repo %d",
+		    allowed_bare_repo);
+	}
+	return NULL;
+}
+
 enum discovery_result {
 	GIT_DIR_NONE = 0,
 	GIT_DIR_EXPLICIT,
@@ -1169,7 +1213,8 @@ enum discovery_result {
 	GIT_DIR_HIT_CEILING = -1,
 	GIT_DIR_HIT_MOUNT_POINT = -2,
 	GIT_DIR_INVALID_GITFILE = -3,
-	GIT_DIR_INVALID_OWNERSHIP = -4
+	GIT_DIR_INVALID_OWNERSHIP = -4,
+	GIT_DIR_DISALLOWED_BARE = -5,
 };
 
 /*
@@ -1297,6 +1342,8 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		}
 
 		if (is_git_directory(dir->buf)) {
+			if (get_allowed_bare_repo() == ALLOWED_BARE_REPO_EXPLICIT)
+				return GIT_DIR_DISALLOWED_BARE;
 			if (!ensure_valid_ownership(NULL, NULL, dir->buf))
 				return GIT_DIR_INVALID_OWNERSHIP;
 			strbuf_addstr(gitdir, ".");
@@ -1443,6 +1490,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		*nongit_ok = 1;
 		break;
+	case GIT_DIR_DISALLOWED_BARE:
+		if (!nongit_ok) {
+			die(_("cannot use bare repository '%s' (safe.bareRepository is '%s')"),
+			    dir.buf,
+			    allowed_bare_repo_to_string(get_allowed_bare_repo()));
+		}
+		*nongit_ok = 1;
+		break;
 	case GIT_DIR_NONE:
 		/*
 		 * As a safeguard against setup_git_directory_gently_1 returning
diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
new file mode 100755
index 00000000000..ecbdc8238db
--- /dev/null
+++ b/t/t0035-safe-bare-repository.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+
+test_description='verify safe.bareRepository checks'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+pwd="$(pwd)"
+
+expect_accepted () {
+	git "$@" rev-parse --git-dir
+}
+
+expect_rejected () {
+	test_must_fail git "$@" rev-parse --git-dir 2>err &&
+	grep -F "cannot use bare repository" err
+}
+
+test_expect_success 'setup bare repo in worktree' '
+	git init outer-repo &&
+	git init --bare outer-repo/bare-repo
+'
+
+test_expect_success 'safe.bareRepository unset' '
+	expect_accepted -C outer-repo/bare-repo
+'
+
+test_expect_success 'safe.bareRepository=all' '
+	test_config_global safe.bareRepository all &&
+	expect_accepted -C outer-repo/bare-repo
+'
+
+test_expect_success 'safe.bareRepository=explicit' '
+	test_config_global safe.bareRepository explicit &&
+	expect_rejected -C outer-repo/bare-repo
+'
+
+test_expect_success 'safe.bareRepository in the repository' '
+	# safe.bareRepository must not be "explicit", otherwise
+	# git config fails with "fatal: not in a git directory" (like
+	# safe.directory)
+	test_config -C outer-repo/bare-repo safe.bareRepository \
+		all &&
+	test_config_global safe.bareRepository explicit &&
+	expect_rejected -C outer-repo/bare-repo
+'
+
+test_expect_success 'safe.bareRepository on the command line' '
+	test_config_global safe.bareRepository explicit &&
+	expect_accepted -C outer-repo/bare-repo \
+		-c safe.bareRepository=all
+'
+
+test_done
-- 
gitgitgadget
