Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E20CCA47F
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382838AbiFHA3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451369AbiFGXMf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:12:35 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9583A2197
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:57:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m26so14303599wrb.4
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y8aPg96TISFn2JO438LDDwaA6S+BMcV3rQ1NYcZg6fM=;
        b=h4p9ZoJpH4NYnyuZPU/DctB5eN8JOE0B2wh1pagjaQyxBRamsPfStadhI2fpFK5DWB
         7cmLhyC48OJEp1qB1VvxKkxM+hJPoI5Mn8oEYMlKOsbPf/tIe2tdU3IVz2WdsfK/lmy5
         J/LYMv7Pc6iJ7SUqlucoaN6G6WEfHQ4cPy8hJgJInmlsnY1CAqg8aeUa0NW9sPmdpHXq
         6GLCeEW3V2qMuCzTJ620f1KVm+0My+z3sOCZVaOm/+Kddi/hHVx69RWtTw+hgBWYcQBu
         TnRs0vuZY71uWDGmJsAxTU9APrvEvDHvgcc14yMnLFJytPslTt9s4cXwv91Sh8l/B+l/
         l+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y8aPg96TISFn2JO438LDDwaA6S+BMcV3rQ1NYcZg6fM=;
        b=QsNSVncgdByP0H5Rhc8ApArRUYSzAs94WkRf8Jwyoyb+L0JbrXQopYWf2tt3lHWKN0
         249uV4kPXfyIMh+/jZJzBuUGB53HIv+qof/TPklpqucoauflAlspKzAFY9F6oB63OdvJ
         V35L5oyh4Y4DmK4ETaqVWrwdux0Ie6wyVqTU4SQ2BrYkpp1RLmL3rnSBiZEaAgnu6TwJ
         pZpsy9pF8nTgzZPTIN2+fZA3+uIPFTDEQuBKEe752ilKUG2ch6m8dM/cbWCKSkXFFQGo
         19NGWDs8M6Xk69vpwqlGBL+wNmys2KIC9/pI6cgcNA2QnshzpaBJvwfIGZVFCWSJrOHg
         dGKQ==
X-Gm-Message-State: AOAM531o3R+VOF3I6S6nzothEMKn640iVIrMXvWrs9fr1tPRr4y6/fB6
        GuBiTaXBiKmzvEVCllue35DsEMu42eb33EMN
X-Google-Smtp-Source: ABdhPJy9FNQtMcUEF5ouColoQfUp5/yRirTKuxJ9UlLhLNWdwCKZJnljex7ME2s1PFTx9hoqcwv2DQ==
X-Received: by 2002:a5d:65c1:0:b0:210:33b7:4525 with SMTP id e1-20020a5d65c1000000b0021033b74525mr30073231wrw.494.1654635440601;
        Tue, 07 Jun 2022 13:57:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003973b9d0447sm22665537wmq.36.2022.06.07.13.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:57:20 -0700 (PDT)
Message-Id: <29053d029f8ec61095a2ad557be38b1d485a158f.1654635432.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
References: <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
        <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 20:57:12 +0000
Subject: [PATCH v4 5/5] setup.c: create `discovery.bare`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
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

Create a config variable, `discovery.bare`, that tells Git whether or
not to die() when it discovers a bare repository. This only affects
repository discovery, thus it has no effect if discovery was not
done (e.g. `--git-dir` was passed).

This config is an enum of:

- "always": always allow bare repositories (this is the default)
- "never": never allow bare repositories

If we want to protect users from such attacks by default, neither value
will suffice - "always" provides no protection, but "never" is
impractical for bare repository users. A more usable default would be to
allow only non-embedded bare repositories ([2] contains one such
proposal), but detecting if a repository is embedded is potentially
non-trivial, so this work is not implemented in this series.

[1]: https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com
[2]: https://lore.kernel.org/git/5b969c5e-e802-c447-ad25-6acc0b784582@github.com

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/config.txt           |  2 +
 Documentation/config/discovery.txt | 19 +++++++++
 setup.c                            | 57 ++++++++++++++++++++++++-
 t/t0035-discovery-bare.sh          | 68 ++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/discovery.txt
 create mode 100755 t/t0035-discovery-bare.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e284b042f22..9a5e1329772 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -409,6 +409,8 @@ include::config/diff.txt[]
 
 include::config/difftool.txt[]
 
+include::config/discovery.txt[]
+
 include::config/extensions.txt[]
 
 include::config/fastimport.txt[]
diff --git a/Documentation/config/discovery.txt b/Documentation/config/discovery.txt
new file mode 100644
index 00000000000..fbe93597e7c
--- /dev/null
+++ b/Documentation/config/discovery.txt
@@ -0,0 +1,19 @@
+discovery.bare::
+	'(Protected config only)' Specifies whether Git will work with a
+	bare repository that it found during repository discovery. This
+	has no effect if the repository is specified directly via the
+	--git-dir command-line option or the GIT_DIR environment
+	variable (see linkgit:git[1]).
++
+The currently supported values are:
++
+* `always`: Git always works with bare repositories
+* `never`: Git never works with bare repositories
++
+This defaults to `always`, but this default may change in the future.
++
+If you do not use bare repositories in your workflow, then it may be
+beneficial to set `discovery.bare` to `never` in your global config.
+This will protect you from attacks that involve cloning a repository
+that contains a bare repository and running a Git command within that
+directory.
diff --git a/setup.c b/setup.c
index 847d47f9195..4d8d3c1bc7d 100644
--- a/setup.c
+++ b/setup.c
@@ -10,6 +10,10 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 static int work_tree_config_is_bogus;
+enum discovery_bare_allowed {
+	DISCOVERY_BARE_NEVER = 0,
+	DISCOVERY_BARE_ALWAYS,
+};
 
 static struct startup_info the_startup_info;
 struct startup_info *startup_info = &the_startup_info;
@@ -1133,6 +1137,46 @@ static int ensure_valid_ownership(const char *path)
 	return data.is_safe;
 }
 
+static int discovery_bare_cb(const char *key, const char *value, void *d)
+{
+	enum discovery_bare_allowed *discovery_bare_allowed = d;
+
+	if (strcmp(key, "discovery.bare"))
+		return 0;
+
+	if (!strcmp(value, "never")) {
+		*discovery_bare_allowed = DISCOVERY_BARE_NEVER;
+		return 0;
+	}
+	if (!strcmp(value, "always")) {
+		*discovery_bare_allowed = DISCOVERY_BARE_ALWAYS;
+		return 0;
+	}
+	return -1;
+}
+
+static enum discovery_bare_allowed get_discovery_bare(void)
+{
+	enum discovery_bare_allowed result = DISCOVERY_BARE_ALWAYS;
+	git_protected_config(discovery_bare_cb, &result);
+	return result;
+}
+
+static const char *discovery_bare_allowed_to_string(
+	enum discovery_bare_allowed discovery_bare_allowed)
+{
+	switch (discovery_bare_allowed) {
+	case DISCOVERY_BARE_NEVER:
+		return "never";
+	case DISCOVERY_BARE_ALWAYS:
+		return "always";
+	default:
+		BUG("invalid discovery_bare_allowed %d",
+		    discovery_bare_allowed);
+	}
+	return NULL;
+}
+
 enum discovery_result {
 	GIT_DIR_NONE = 0,
 	GIT_DIR_EXPLICIT,
@@ -1142,7 +1186,8 @@ enum discovery_result {
 	GIT_DIR_HIT_CEILING = -1,
 	GIT_DIR_HIT_MOUNT_POINT = -2,
 	GIT_DIR_INVALID_GITFILE = -3,
-	GIT_DIR_INVALID_OWNERSHIP = -4
+	GIT_DIR_INVALID_OWNERSHIP = -4,
+	GIT_DIR_DISALLOWED_BARE = -5,
 };
 
 /*
@@ -1239,6 +1284,8 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		}
 
 		if (is_git_directory(dir->buf)) {
+			if (!get_discovery_bare())
+				return GIT_DIR_DISALLOWED_BARE;
 			if (!ensure_valid_ownership(dir->buf))
 				return GIT_DIR_INVALID_OWNERSHIP;
 			strbuf_addstr(gitdir, ".");
@@ -1385,6 +1432,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		*nongit_ok = 1;
 		break;
+	case GIT_DIR_DISALLOWED_BARE:
+		if (!nongit_ok) {
+			die(_("cannot use bare repository '%s' (discovery.bare is '%s')"),
+			    dir.buf,
+			    discovery_bare_allowed_to_string(get_discovery_bare()));
+		}
+		*nongit_ok = 1;
+		break;
 	case GIT_DIR_NONE:
 		/*
 		 * As a safeguard against setup_git_directory_gently_1 returning
diff --git a/t/t0035-discovery-bare.sh b/t/t0035-discovery-bare.sh
new file mode 100755
index 00000000000..0b345d361e6
--- /dev/null
+++ b/t/t0035-discovery-bare.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+test_description='verify discovery.bare checks'
+
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
+	grep "discovery.bare" err
+}
+
+test_expect_success 'setup bare repo in worktree' '
+	git init outer-repo &&
+	git init --bare outer-repo/bare-repo
+'
+
+test_expect_success 'discovery.bare unset' '
+	(
+		cd outer-repo/bare-repo &&
+		expect_accepted
+	)
+'
+
+test_expect_success 'discovery.bare=always' '
+	git config --global discovery.bare always &&
+	(
+		cd outer-repo/bare-repo &&
+		expect_accepted
+	)
+'
+
+test_expect_success 'discovery.bare=never' '
+	git config --global discovery.bare never &&
+	(
+		cd outer-repo/bare-repo &&
+		expect_rejected
+	)
+'
+
+test_expect_success 'discovery.bare in the repository' '
+	(
+		cd outer-repo/bare-repo &&
+		# Temporarily set discovery.bare=always, otherwise git
+		# config fails with "fatal: not in a git directory"
+		# (like safe.directory)
+		git config --global discovery.bare always &&
+		git config discovery.bare always &&
+		git config --global discovery.bare never &&
+		expect_rejected
+	)
+'
+
+test_expect_success 'discovery.bare on the command line' '
+	git config --global discovery.bare never &&
+	(
+		cd outer-repo/bare-repo &&
+		expect_accepted -c discovery.bare=always &&
+		expect_rejected -c discovery.bare=
+	)
+'
+
+test_done
-- 
gitgitgadget
