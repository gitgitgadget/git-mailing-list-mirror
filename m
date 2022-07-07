Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2547C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 23:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbiGGXCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 19:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiGGXCE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 19:02:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694C865D58
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 16:02:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o4so28275838wrh.3
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 16:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Dubs6AAl7Oy/A3rvgA7PHKaHn0sZ1RdxAvUqFkWj+rU=;
        b=Sfg/SAa5jEI87cLc3uOCKjvPta9DqgT//VYZ78t5AsaYWVm4AwOQ/JNcK04GqUEKJt
         qrsxCfXKNWfLNyH9sCxhi38Vv1WVTaNLrM6X84zVwvRa0Sc6SuQvU4oTgtnf6IoB+Lyn
         pZcmooo1XT4Fxc+BsmWOf1lwcdjfKhDeMRpdp71lZiKO+ne5FnmGTnp7FBXHZQuWeqcp
         cL4kSjzl7VWpiT4qFSEPTzgg3oBO/LHwb+itJZXxMzcvBuERXbNNL5xzzdXVXkmHEq9k
         k0k/Xl1NzSN2bmUNWeW0FtDp3PO+y/iwmaLejX5YHYSZUFg5gllzt6xVW4dyjbN1aAjZ
         FE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Dubs6AAl7Oy/A3rvgA7PHKaHn0sZ1RdxAvUqFkWj+rU=;
        b=MqmOceEBt9+U8h6dWzzKi8y9yIYy48MULb/9hCvl/w2snPOFfi8wRY2/uqc62hBQgT
         /wt8Ml1DG8I0BlsfPG5UB7XcKFgQ5eax0afWY+DZ904KXWWiuYe4Ve1if7/l1FLRifE5
         dfAKRh0eaMY1Jl82+KRpvNpN5z34VbrkgLBrT58PUs+oRQP88R88eF/pxLVYcJUCvQci
         RNNGjZSwlDUedAMykM2S7ztWU5Xlm9hEVd3DsWqtpSKSITB/RywcDpp7ozHp9PqE50CB
         PcKqheTfT4trEGR4gL5B1ozt+34Esplu0kVwESC8foh+/bnF9s5pRBT45L/QRV33VER+
         znpg==
X-Gm-Message-State: AJIora/U7tcv0BLo4VnWWaAC3vCWDqlyf9IZsDO8/86KDJ9KS/PcCxi7
        EWIsJ2lfqQZYrlrLOrl2xfQhYJ3NsCM=
X-Google-Smtp-Source: AGRyM1vwYTD3GrZ7p9+InEiDTenshGhjw/5PI74tFg/vX02vxWg2ygsMDN9+5brzJY/peRuHBZtRFQ==
X-Received: by 2002:a5d:5e8d:0:b0:21b:a919:7da with SMTP id ck13-20020a5d5e8d000000b0021ba91907damr265248wrb.530.1657234922672;
        Thu, 07 Jul 2022 16:02:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18-20020a05600c4e1200b003a2d47d3051sm193754wmq.41.2022.07.07.16.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:02:02 -0700 (PDT)
Message-Id: <eff4b07480ebfadb072faccc36a527cf78c9d2c3.1657234915.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
References: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
        <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jul 2022 23:01:54 +0000
Subject: [PATCH v7 5/5] setup.c: create `discovery.bare`
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
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
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
done, e.g. if the user passes `--git-dir=my-dir`, discovery will be
skipped and my-dir will be used as the repo regardless of the
`discovery.bare` value.

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
 Documentation/config.txt           |  2 ++
 Documentation/config/discovery.txt | 21 +++++++++++
 setup.c                            | 57 +++++++++++++++++++++++++++++-
 t/t0035-discovery-bare.sh          | 52 +++++++++++++++++++++++++++
 4 files changed, 131 insertions(+), 1 deletion(-)
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
index 00000000000..6f38b86884b
--- /dev/null
+++ b/Documentation/config/discovery.txt
@@ -0,0 +1,21 @@
+discovery.bare::
+	Specifies whether Git will work with a bare repository that
+	wasn't specified via the top-level `--git-dir` command-line
+	option, or the `GIT_DIR` environment variable (see
+	linkgit:git[1]). If the repository is specified, Git will always
+	use the specified repository, regardless of this value.
++
+This config setting is only respected in protected configuration (see
+<<SCOPES>>). This prevents the untrusted repository from tampering with
+this value.
++
+The currently supported values are:
++
+* `always`: Git always works with bare repositories
+* `never`: Git never works with bare repositories
++
+If you do not use bare repositories in your workflow, then it may be
+beneficial to set `discovery.bare` to `never` in your global config.
+This will protect you from attacks that involve cloning a repository
+that contains a bare repository and running a Git command within that
+directory.
diff --git a/setup.c b/setup.c
index c8e3c32814d..84cd02a1209 100644
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
@@ -1142,6 +1146,46 @@ static int ensure_valid_ownership(const char *path)
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
@@ -1151,7 +1195,8 @@ enum discovery_result {
 	GIT_DIR_HIT_CEILING = -1,
 	GIT_DIR_HIT_MOUNT_POINT = -2,
 	GIT_DIR_INVALID_GITFILE = -3,
-	GIT_DIR_INVALID_OWNERSHIP = -4
+	GIT_DIR_INVALID_OWNERSHIP = -4,
+	GIT_DIR_DISALLOWED_BARE = -5,
 };
 
 /*
@@ -1248,6 +1293,8 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		}
 
 		if (is_git_directory(dir->buf)) {
+			if (get_discovery_bare() == DISCOVERY_BARE_NEVER)
+				return GIT_DIR_DISALLOWED_BARE;
 			if (!ensure_valid_ownership(dir->buf))
 				return GIT_DIR_INVALID_OWNERSHIP;
 			strbuf_addstr(gitdir, ".");
@@ -1394,6 +1441,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
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
index 00000000000..8f802746530
--- /dev/null
+++ b/t/t0035-discovery-bare.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='verify discovery.bare checks'
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
+test_expect_success 'discovery.bare unset' '
+	expect_accepted -C outer-repo/bare-repo
+'
+
+test_expect_success 'discovery.bare=always' '
+	test_config_global discovery.bare always &&
+	expect_accepted -C outer-repo/bare-repo
+'
+
+test_expect_success 'discovery.bare=never' '
+	test_config_global discovery.bare never &&
+	expect_rejected -C outer-repo/bare-repo
+'
+
+test_expect_success 'discovery.bare in the repository' '
+	# discovery.bare must not be "never", otherwise git config fails
+	# with "fatal: not in a git directory" (like safe.directory)
+	test_config -C outer-repo/bare-repo discovery.bare always &&
+	test_config_global discovery.bare never &&
+	expect_rejected -C outer-repo/bare-repo
+'
+
+test_expect_success 'discovery.bare on the command line' '
+	test_config_global discovery.bare never &&
+	expect_accepted -C outer-repo/bare-repo \
+		-c discovery.bare=always
+'
+
+test_done
-- 
gitgitgadget
