Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC72C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 06:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346975AbhLAGoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 01:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbhLAGoU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 01:44:20 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6852C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:40:59 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso340941wmr.5
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JSVhvkp1FiGBZ0JFwPBBmZojfgPMUtCV7G4Zda1n+BU=;
        b=nVjuV2rRlhM4o67W7E8ETq9tC6quoQrjjVjDn1+st6Fw7zfagKp4Gn1Jwzd0pkXzhq
         AWjpRZSCn/iXjhllOdw/2dyyTRWSzVp9C+Rxg4A3mr6Wm5fHM6Y9iOZT1DMBo67NzDVP
         pnMoqhRSWP42+zCzs+/NdA6i2A53yAdCadEQnNd4Wu7N4Pt+J9hnYkZa8T+joHwR4EQb
         yvx8tqdRESaxLsvKaOyqqOHxDfTUD2nDauvP/4+goRde/HPeNyNKig8M8L+JV2V6TPEL
         X7QKz+UPmTqoONPNFt+Bv7Uidb0FdyKLtXk7DVoDhW/aVVAyUsiHzHrejgTuoRLEyXoF
         XoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JSVhvkp1FiGBZ0JFwPBBmZojfgPMUtCV7G4Zda1n+BU=;
        b=LFkHHT7XLXGQUfSNVnyT9Bea4gQrqno3u7ufLRAxdtrhKXgced3dLYthv6DR19ahkv
         96x6GlMOE/pQEkW7fbqwjcJO6cvyE8de9784r0GIQqeBhyPepWvG7Igc+WGTmXUz4DpW
         t3AJH0Sja2edZ1UJrQbU00Q7VENVGpsx+9XCjuNMYk5IM32RDuFXo7yL7Cyspnhd7jxa
         E7j5jwLg4QfRJsZJLuy7tuPhdL1HNcwZ7j62j0hyd7KOuru5fG8rr8ALeluv/LG57UJl
         EoSADN9Lmqi8ZwywjRpC9LbWCCLc1h2pxZQoINgdMRdV3Ki/xcrPbCGvr5QvLxVqbXA7
         FqPw==
X-Gm-Message-State: AOAM531b39GRqbtCvNprV986acbZRb0s1HVzCUJHRSIX5bV8/vrhnWT6
        4vmiqwRY1+hO4E8sKkFp6Hc3S0d8pwI=
X-Google-Smtp-Source: ABdhPJzpFAfatIuvq4IhbmslvHMMIxkSFgc16WpodsrVnCjFWYdlwye0tL2TvBc9/ma7O7jYqDfHVQ==
X-Received: by 2002:a05:600c:3b0a:: with SMTP id m10mr4586411wms.130.1638340858125;
        Tue, 30 Nov 2021 22:40:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6sm5686924wmq.46.2021.11.30.22.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 22:40:57 -0800 (PST)
Message-Id: <37f333b20240e8da62f148945387044cefb39c14.1638340854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
        <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 06:40:45 +0000
Subject: [PATCH v5 02/11] setup: introduce startup_info->original_cwd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Removing the current working directory causes all subsequent git
commands run from that directory to get confused and fail with a message
about being unable to read the current working directory:

    $ git status
    fatal: Unable to read current working directory: No such file or directory

Non-git commands likely have similar warnings or even errors, e.g.

    $ bash -c 'echo hello'
    shell-init: error retrieving current directory: getcwd: cannot access parent directories: No such file or directory
    hello

This confuses end users, particularly since the command they get the
error from is not the one that caused the problem; the problem came from
the side-effect of some previous command.

We would like to avoid removing the current working directory of our
parent process; towards this end, introduce a new variable,
startup_info->original_cwd, that tracks the current working directory
that we inherited from our parent process.  For convenience of later
comparisons, we prefer that this new variable store a path relative to
the toplevel working directory (thus much like 'prefix'), except without
the trailing slash.

Subsequent commits will make use of this new variable.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h       |  2 ++
 common-main.c |  4 ++++
 setup.c       | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/cache.h b/cache.h
index eba12487b99..92e181ea759 100644
--- a/cache.h
+++ b/cache.h
@@ -1834,8 +1834,10 @@ void overlay_tree_on_index(struct index_state *istate,
 struct startup_info {
 	int have_repository;
 	const char *prefix;
+	const char *original_cwd;
 };
 extern struct startup_info *startup_info;
+extern const char *tmp_original_cwd;
 
 /* merge.c */
 struct commit_list;
diff --git a/common-main.c b/common-main.c
index 71e21dd20a3..aa8d5aba5bb 100644
--- a/common-main.c
+++ b/common-main.c
@@ -26,6 +26,7 @@ static void restore_sigpipe_to_default(void)
 int main(int argc, const char **argv)
 {
 	int result;
+	struct strbuf tmp = STRBUF_INIT;
 
 	trace2_initialize_clock();
 
@@ -49,6 +50,9 @@ int main(int argc, const char **argv)
 	trace2_cmd_start(argv);
 	trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
 
+	if (!strbuf_getcwd(&tmp))
+		tmp_original_cwd = strbuf_detach(&tmp, NULL);
+
 	result = cmd_main(argc, argv);
 
 	trace2_cmd_exit(result);
diff --git a/setup.c b/setup.c
index 347d7181ae9..af3b8c09abe 100644
--- a/setup.c
+++ b/setup.c
@@ -12,6 +12,7 @@ static int work_tree_config_is_bogus;
 
 static struct startup_info the_startup_info;
 struct startup_info *startup_info = &the_startup_info;
+const char *tmp_original_cwd;
 
 /*
  * The input parameter must contain an absolute path, and it must already be
@@ -432,6 +433,69 @@ void setup_work_tree(void)
 	initialized = 1;
 }
 
+static void setup_original_cwd(void)
+{
+	struct strbuf tmp = STRBUF_INIT;
+	const char *worktree = NULL;
+	int offset = -1;
+
+	if (!tmp_original_cwd)
+		return;
+
+	/*
+	 * startup_info->original_cwd points to the current working
+	 * directory we inherited from our parent process, which is a
+	 * directory we want to avoid removing.
+	 *
+	 * For convience, we would like to have the path relative to the
+	 * worktree instead of an absolute path.
+	 *
+	 * Yes, startup_info->original_cwd is usually the same as 'prefix',
+	 * but differs in two ways:
+	 *   - prefix has a trailing '/'
+	 *   - if the user passes '-C' to git, that modifies the prefix but
+	 *     not startup_info->original_cwd.
+	 */
+
+	/* Normalize the directory */
+	strbuf_realpath(&tmp, tmp_original_cwd, 1);
+	free((char*)tmp_original_cwd);
+	tmp_original_cwd = NULL;
+	startup_info->original_cwd = strbuf_detach(&tmp, NULL);
+
+	/*
+	 * Get our worktree; we only protect the current working directory
+	 * if it's in the worktree.
+	 */
+	worktree = get_git_work_tree();
+	if (!worktree)
+		goto no_prevention_needed;
+
+	offset = dir_inside_of(startup_info->original_cwd, worktree);
+	if (offset >= 0) {
+		/*
+		 * If startup_info->original_cwd == worktree, that is already
+		 * protected and we don't need original_cwd as a secondary
+		 * protection measure.
+		 */
+		if (!*(startup_info->original_cwd + offset))
+			goto no_prevention_needed;
+
+		/*
+		 * original_cwd was inside worktree; precompose it just as
+		 * we do prefix so that built up paths will match
+		 */
+		startup_info->original_cwd = \
+			precompose_string_if_needed(startup_info->original_cwd
+						    + offset);
+		return;
+	}
+
+no_prevention_needed:
+	free((char*)startup_info->original_cwd);
+	startup_info->original_cwd = NULL;
+}
+
 static int read_worktree_config(const char *var, const char *value, void *vdata)
 {
 	struct repository_format *data = vdata;
@@ -1330,6 +1394,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
 	}
 
+	setup_original_cwd();
 
 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
-- 
gitgitgadget

