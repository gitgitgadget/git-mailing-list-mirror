Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894E6C433EF
	for <git@archiver.kernel.org>; Fri, 13 May 2022 23:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiEMXsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 19:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiEMXsK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 19:48:10 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B833778BC
        for <git@vger.kernel.org>; Fri, 13 May 2022 16:37:43 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so5487465wme.3
        for <git@vger.kernel.org>; Fri, 13 May 2022 16:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JYTCMUbZitm/3SgfT25HckEgLoveyG7b02gDgZu2ThI=;
        b=Gm8tinFa4m6+z0Xl8KI++mBL+/3kR9ge1fCn68pXlJ7dnCb5l/lH6ocGjelbshxuEy
         SePLUm3MOUf2Kz8y5tDh51jbHGxl+yWyGSIyBe4DaQCzgRKWzqhE9FmFpvwNBzH4rYan
         jfgEaoqAmIpAO1nnMSzFXQGTh/RtiC6vz5Hd2cB4e7Zik59OAa/f/rwjsxrWahyT78Yh
         ZQHOruqY7m6IqqbAqETHXQ1osRb0G+iJiv/zVX4rY7wz74/tvWWlz4amJdTOGMejhR1R
         I3Kpu1zv4OzlMx+5+Hqln9L3jNpI9iqM7nbGIw5wrw51fEZeFrAVhAHMQreTd+Ka4No8
         mH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JYTCMUbZitm/3SgfT25HckEgLoveyG7b02gDgZu2ThI=;
        b=MqGosWjuG5xuUwqFf/vkZzJyCMn7MPoEHeEnXmtVMQ+bb1UP4bx9D7Tp3GJDMUWQWA
         KCSDemnNpRBW3alGHmEZLoqKXLl4X4l26epr2KACUDv6KyF8RWZD2Cq6KvKC+NDAL+fZ
         MwuPQwCWETuTvQcRsymFI1LB9NUh2jOKC/HpTE2JbIhMglgEKONKd3LLzc2jUCfiQwRF
         YtGyM2WDg17eUvm7sDf4fJOls7Qw+atjF9hSMPqQymTMRcVggg/r26G2KOIbe4ZUw2wG
         4nnxOm29f+Kt6+PaPOFTOWOslvj8gC/SC5WsQQ4GEPBno9TlEG7BI0Bd0Xk/LbiS8sUM
         lfWg==
X-Gm-Message-State: AOAM531fGjY4x+tHm+8rTKVg1Iw5YdxCvXCNs0+SbrFJK9zx32zGMtb3
        9FR+TxE7Ylx5oMsUfr+Pu+SNzShtQtk=
X-Google-Smtp-Source: ABdhPJw3g28kUx0GF/BZLBhnce1uVSTwE/SiLaAnHf1Mb9YpLQryIu4e3ZJDUOTaaG7TTNxPEFWdlw==
X-Received: by 2002:a7b:cb8f:0:b0:394:30b5:edab with SMTP id m15-20020a7bcb8f000000b0039430b5edabmr6553176wmi.148.1652485061078;
        Fri, 13 May 2022 16:37:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg33-20020a05600c3ca100b003942a244f57sm1691502wmb.48.2022.05.13.16.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 16:37:40 -0700 (PDT)
Message-Id: <22b10bf9da8ccf4ae4da634aadfdaff5ee7a3508.1652485058.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
        <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 May 2022 23:37:37 +0000
Subject: [PATCH v2 1/2] setup.c: make bare repo discovery optional
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

Add a config variable, `discovery.bare`, that tells Git whether or not
it should work with the bare repository it has discovered i.e. Git will
die() if it discovers a bare repository, but it is not allowed by
`discovery.bare`. This only affects repository discovery, thus it has no
effect if discovery was not done (e.g. `--git-dir` was passed).

This is motivated by the fact that some workflows don't use bare
repositories at all, and users may prefer to opt out of bare repository
discovery altogether:

- An easy assumption for a user to make is that Git commands run
  anywhere inside a repository's working tree will use the same
  repository. However, if the working tree contains a bare repository
  below the root-level (".git" is preferred at the root-level), any
  operations inside that bare repository use the bare repository
  instead.

  In the worst case, attackers can use this confusion to trick users
  into running arbitrary code (see [1] for a deeper discussion). But
  even in benign situations (e.g. a user renames ".git/" to ".git.old/"
  and commits it for archival purposes), disabling bare repository
  discovery can be a simpler mode of operation (e.g. because the user
  doesn't actually want to use ".git.old/") [2].

- Git won't "accidentally" recognize a directory that wasn't meant to be
  a bare repository, but happens to resemble one. While such accidents
  are probably very rare in practice, this lets users reduce the chance
  to zero.

This config is an enum of:

- ["always"|(unset)]: always recognize bare repositories (like Git does
  today)
- "never": never recognize bare repositories

More values are expected to be added later, and the default is expected
to change (i.e. to something other than "always").

[1]: https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com
[2]: I don't personally know anyone who does this as part of their
normal workflow, but a cursory search on GitHub suggests that there is a
not insubstantial number of people who munge ".git" in order to store
its contents.

https://github.com/search?l=&o=desc&p=1&q=ref+size%3A%3C1000+filename%3AHEAD&s=indexed&type=Code
(aka search for the text "ref", size:<1000, filename:HEAD)

Signed-off-by: Glen Choo <chooglen@google.com>

WIP setup.c: make discovery.bare die on failure

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/config/discovery.txt | 24 +++++++++++
 setup.c                            | 66 +++++++++++++++++++++++++++++-
 t/t0034-discovery-bare.sh          | 59 ++++++++++++++++++++++++++
 3 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/discovery.txt
 create mode 100755 t/t0034-discovery-bare.sh

diff --git a/Documentation/config/discovery.txt b/Documentation/config/discovery.txt
new file mode 100644
index 00000000000..761cabe6e70
--- /dev/null
+++ b/Documentation/config/discovery.txt
@@ -0,0 +1,24 @@
+discovery.bare::
+	Specifies what kinds of directories Git can recognize as a bare
+	repository when looking for the repository (aka repository
+	discovery). This has no effect if repository discovery is not
+	performed e.g. the path to the repository is set via `--git-dir`
+	(see linkgit:git[1]).
++
+This config setting is only respected when specified in a system or global
+config, not when it is specified in a repository config or via the command
+line option `-c discovery.bare=<value>`.
++
+The currently supported values are `always` (Git always recognizes bare
+repositories) and `never` (Git never recognizes bare repositories).
+This defaults to `always`, but this default is likely to change.
++
+If your workflow does not rely on bare repositories, it is recommended that
+you set this value to `never`. This makes repository discovery easier to
+reason about and prevents certain types of security and non-security
+problems, such as:
+
+* `git clone`-ing a repository containing a malicious bare repository
+  inside it.
+* Git recognizing a directory that isn't meant to be a bare repository,
+  but happens to look like one.
diff --git a/setup.c b/setup.c
index a7b36f3ffbf..cee01d86f0c 100644
--- a/setup.c
+++ b/setup.c
@@ -10,6 +10,13 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 static int work_tree_config_is_bogus;
+enum discovery_bare_config {
+	DISCOVERY_BARE_UNKNOWN = -1,
+	DISCOVERY_BARE_NEVER = 0,
+	DISCOVERY_BARE_ALWAYS,
+};
+static enum discovery_bare_config discovery_bare_config =
+	DISCOVERY_BARE_UNKNOWN;
 
 static struct startup_info the_startup_info;
 struct startup_info *startup_info = &the_startup_info;
@@ -1133,6 +1140,52 @@ static int ensure_valid_ownership(const char *path)
 	return data.is_safe;
 }
 
+static int discovery_bare_cb(const char *key, const char *value, void *d)
+{
+	if (strcmp(key, "discovery.bare"))
+		return 0;
+
+	if (!strcmp(value, "never")) {
+		discovery_bare_config = DISCOVERY_BARE_NEVER;
+		return 0;
+	}
+	if (!strcmp(value, "always")) {
+		discovery_bare_config = DISCOVERY_BARE_ALWAYS;
+		return 0;
+	}
+	return -1;
+}
+
+static int check_bare_repo_allowed(void)
+{
+	if (discovery_bare_config == DISCOVERY_BARE_UNKNOWN) {
+		read_very_early_config(discovery_bare_cb, NULL);
+		/* We didn't find a value; use the default. */
+		if (discovery_bare_config == DISCOVERY_BARE_UNKNOWN)
+			discovery_bare_config = DISCOVERY_BARE_ALWAYS;
+	}
+	switch (discovery_bare_config) {
+	case DISCOVERY_BARE_NEVER:
+		return 0;
+	case DISCOVERY_BARE_ALWAYS:
+		return 1;
+	default:
+		BUG("invalid discovery_bare_config %d", discovery_bare_config);
+	}
+}
+
+static const char *discovery_bare_config_to_string(void)
+{
+	switch (discovery_bare_config) {
+	case DISCOVERY_BARE_NEVER:
+		return "never";
+	case DISCOVERY_BARE_ALWAYS:
+		return "always";
+	default:
+		BUG("invalid discovery_bare_config %d", discovery_bare_config);
+	}
+}
+
 enum discovery_result {
 	GIT_DIR_NONE = 0,
 	GIT_DIR_EXPLICIT,
@@ -1142,7 +1195,8 @@ enum discovery_result {
 	GIT_DIR_HIT_CEILING = -1,
 	GIT_DIR_HIT_MOUNT_POINT = -2,
 	GIT_DIR_INVALID_GITFILE = -3,
-	GIT_DIR_INVALID_OWNERSHIP = -4
+	GIT_DIR_INVALID_OWNERSHIP = -4,
+	GIT_DIR_DISALLOWED_BARE = -5
 };
 
 /*
@@ -1239,6 +1293,8 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		}
 
 		if (is_git_directory(dir->buf)) {
+			if (!check_bare_repo_allowed())
+				return GIT_DIR_DISALLOWED_BARE;
 			if (!ensure_valid_ownership(dir->buf))
 				return GIT_DIR_INVALID_OWNERSHIP;
 			strbuf_addstr(gitdir, ".");
@@ -1385,6 +1441,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		*nongit_ok = 1;
 		break;
+	case GIT_DIR_DISALLOWED_BARE:
+		if (!nongit_ok) {
+			die(_("cannot use bare repository '%s' (discovery.bare is '%s')"),
+			    dir.buf,
+			    discovery_bare_config_to_string());
+		}
+		*nongit_ok = 1;
+		break;
 	case GIT_DIR_NONE:
 		/*
 		 * As a safeguard against setup_git_directory_gently_1 returning
diff --git a/t/t0034-discovery-bare.sh b/t/t0034-discovery-bare.sh
new file mode 100755
index 00000000000..9c774872c4e
--- /dev/null
+++ b/t/t0034-discovery-bare.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='verify discovery.bare checks'
+
+. ./test-lib.sh
+
+pwd="$(pwd)"
+
+expect_allowed () {
+	git rev-parse --absolute-git-dir >actual &&
+	echo "$pwd/outer-repo/bare-repo" >expected &&
+	test_cmp expected actual
+}
+
+expect_rejected () {
+	test_must_fail git rev-parse --absolute-git-dir 2>err &&
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
+		expect_allowed &&
+		cd refs/ &&
+		expect_allowed
+	)
+'
+
+test_expect_success 'discovery.bare=always' '
+	git config --global discovery.bare always &&
+	(
+		cd outer-repo/bare-repo &&
+		expect_allowed &&
+		cd refs/ &&
+		expect_allowed
+	)
+'
+
+test_expect_success 'discovery.bare=never' '
+	git config --global discovery.bare never &&
+	(
+		cd outer-repo/bare-repo &&
+		expect_rejected &&
+		cd refs/ &&
+		expect_rejected
+	) &&
+	(
+		GIT_DIR=outer-repo/bare-repo &&
+		export GIT_DIR &&
+		expect_allowed
+	)
+'
+
+test_done
-- 
gitgitgadget

