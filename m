Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F204EC433EF
	for <git@archiver.kernel.org>; Fri, 13 May 2022 23:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiEMXs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 19:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiEMXsP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 19:48:15 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C343781CA
        for <git@vger.kernel.org>; Fri, 13 May 2022 16:37:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e29so3571415wrc.11
        for <git@vger.kernel.org>; Fri, 13 May 2022 16:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UP/bklt+IOa7R8jUvhox0eqPrMcD1+CQsz1aGIrsagA=;
        b=QSugMZv1k9tpQS3OpnpOS6+i80/4urjvv6CMf/tf26FqGIlPPjKcGcCc6iu673BfBW
         xU7OzjVcnSp4JPxY8gFgw0aOiahRAMbN343BrallMt7/KI3bqvhakq0bkYgCgj5vbjdp
         6G9oQnx9zpy1iJuXAxO/c1/HkkI59SRW4s/C91nRLxFD9EDHMwrLer5Hdm2ZrTVOHSHg
         MSxoy6saFLgRgxyLMvkHFdgEN3Po7pEfeZPR1+iCJoVM4iZXDAbWDks9hIPsujOTEr5E
         ftv/RmMh3bNSZmbWzq861iWJKxMiVsosMXLdo2L1y0ydfg1V9wx+xTsuQQxZ9ocxt4gZ
         MP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UP/bklt+IOa7R8jUvhox0eqPrMcD1+CQsz1aGIrsagA=;
        b=uFDN/kzpoTh8s3Vq/epp9CGnP9xuQGqMQaQxi9RQzU5JEcrGv9m0lP9BoHYLaDy5Io
         9w8S5OdFZq1GzztwSuPgNQRxe/ZkBvXfFQiEBNpQWWTIcpLbaMdNHGL/sNruH7Iy4QcJ
         4x6EMd66WsbuzgPVM5BDMdVNpKgMBUZ6AZ425upclLlKfONl/H5/PBLG+QinLpMNw/ed
         DCIOLJM9up+5asyyqzIptYFGS/41gDr+ipdlsNMhYQPRuEREV6c8tPrLBR0nToK9gJkb
         aVa56jNeFARx1SFnUPWlAMlWMiBdkuqKfbkgKu5fFSsNcdE7NxLzFdLBuw0QJn0XDQoR
         AMVw==
X-Gm-Message-State: AOAM532MKCsRyp0aBYGE63NMLU78bqMXwxG0bxwtBgXyoyhOApscxSXf
        UUKXAUDdxT8G/vcNkHkJq+7xQ5a1uWs=
X-Google-Smtp-Source: ABdhPJyX91BObnQTJgzgBHjz/T6obkgWExKaTfN59tvXZgEZHi9POpygczSx9qb50PgVKO2aC2djXQ==
X-Received: by 2002:adf:f64b:0:b0:20a:c685:89ee with SMTP id x11-20020adff64b000000b0020ac68589eemr5400246wrp.366.1652485062245;
        Fri, 13 May 2022 16:37:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9-20020adfa209000000b0020c5253d8d0sm3315471wra.28.2022.05.13.16.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 16:37:41 -0700 (PDT)
Message-Id: <62070aab7eb8734f82e3881e25ff0f9cee6bb077.1652485058.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
        <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 May 2022 23:37:38 +0000
Subject: [PATCH v2 2/2] setup.c: learn discovery.bareRepository=cwd
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

Add a 'cwd' option to discovery.bareRepository, which allows a bare
repository to be used if and only if the cwd is the root of a bare
repository. This covers the common case where a user works with a bare
repository by cd-ing into the repository's root.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/config/discovery.txt |  6 ++++--
 setup.c                            | 27 ++++++++++++++++++++-------
 t/t0034-discovery-bare.sh          | 10 ++++++++++
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/discovery.txt b/Documentation/config/discovery.txt
index 761cabe6e70..d7cdee3a5e1 100644
--- a/Documentation/config/discovery.txt
+++ b/Documentation/config/discovery.txt
@@ -10,8 +10,10 @@ config, not when it is specified in a repository config or via the command
 line option `-c discovery.bare=<value>`.
 +
 The currently supported values are `always` (Git always recognizes bare
-repositories) and `never` (Git never recognizes bare repositories).
-This defaults to `always`, but this default is likely to change.
+repositories), `cwd` (Git only recognizes bare repositories if they are the
+current working directory) and `never` (Git never recognizes bare
+repositories). This defaults to `always`, but this default is likely to
+change.
 +
 If your workflow does not rely on bare repositories, it is recommended that
 you set this value to `never`. This makes repository discovery easier to
diff --git a/setup.c b/setup.c
index cee01d86f0c..ead999f404c 100644
--- a/setup.c
+++ b/setup.c
@@ -14,6 +14,7 @@ enum discovery_bare_config {
 	DISCOVERY_BARE_UNKNOWN = -1,
 	DISCOVERY_BARE_NEVER = 0,
 	DISCOVERY_BARE_ALWAYS,
+	DISCOVERY_BARE_CWD,
 };
 static enum discovery_bare_config discovery_bare_config =
 	DISCOVERY_BARE_UNKNOWN;
@@ -1153,10 +1154,14 @@ static int discovery_bare_cb(const char *key, const char *value, void *d)
 		discovery_bare_config = DISCOVERY_BARE_ALWAYS;
 		return 0;
 	}
+	if (!strcmp(value, "cwd")) {
+		discovery_bare_config = DISCOVERY_BARE_CWD;
+		return 0;
+	}
 	return -1;
 }
 
-static int check_bare_repo_allowed(void)
+static int check_bare_repo_allowed(const char *cwd, const char *path)
 {
 	if (discovery_bare_config == DISCOVERY_BARE_UNKNOWN) {
 		read_very_early_config(discovery_bare_cb, NULL);
@@ -1169,6 +1174,8 @@ static int check_bare_repo_allowed(void)
 		return 0;
 	case DISCOVERY_BARE_ALWAYS:
 		return 1;
+	case DISCOVERY_BARE_CWD:
+		return !strcmp(cwd, path);
 	default:
 		BUG("invalid discovery_bare_config %d", discovery_bare_config);
 	}
@@ -1181,6 +1188,8 @@ static const char *discovery_bare_config_to_string(void)
 		return "never";
 	case DISCOVERY_BARE_ALWAYS:
 		return "always";
+	case DISCOVERY_BARE_CWD:
+		return "cwd";
 	default:
 		BUG("invalid discovery_bare_config %d", discovery_bare_config);
 	}
@@ -1212,7 +1221,8 @@ enum discovery_result {
  * the discovered .git/ directory, if any. If `gitdir` is not absolute, it
  * is relative to `dir` (i.e. *not* necessarily the cwd).
  */
-static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
+static enum discovery_result setup_git_directory_gently_1(struct strbuf *cwd,
+							  struct strbuf *dir,
 							  struct strbuf *gitdir,
 							  int die_on_error)
 {
@@ -1293,7 +1303,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		}
 
 		if (is_git_directory(dir->buf)) {
-			if (!check_bare_repo_allowed())
+			if (!check_bare_repo_allowed(cwd->buf, dir->buf))
 				return GIT_DIR_DISALLOWED_BARE;
 			if (!ensure_valid_ownership(dir->buf))
 				return GIT_DIR_INVALID_OWNERSHIP;
@@ -1319,16 +1329,18 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 int discover_git_directory(struct strbuf *commondir,
 			   struct strbuf *gitdir)
 {
-	struct strbuf dir = STRBUF_INIT, err = STRBUF_INIT;
+	struct strbuf cwd = STRBUF_INIT, dir = STRBUF_INIT, err = STRBUF_INIT;
 	size_t gitdir_offset = gitdir->len, cwd_len;
 	size_t commondir_offset = commondir->len;
 	struct repository_format candidate = REPOSITORY_FORMAT_INIT;
 
-	if (strbuf_getcwd(&dir))
+	if (strbuf_getcwd(&cwd))
 		return -1;
+	strbuf_addbuf(&dir, &cwd);
 
 	cwd_len = dir.len;
-	if (setup_git_directory_gently_1(&dir, gitdir, 0) <= 0) {
+	if (setup_git_directory_gently_1(&cwd, &dir, gitdir, 0) <= 0) {
+		strbuf_release(&cwd);
 		strbuf_release(&dir);
 		return -1;
 	}
@@ -1351,6 +1363,7 @@ int discover_git_directory(struct strbuf *commondir,
 	strbuf_reset(&dir);
 	strbuf_addf(&dir, "%s/config", commondir->buf + commondir_offset);
 	read_repository_format(&candidate, dir.buf);
+	strbuf_release(&cwd);
 	strbuf_release(&dir);
 
 	if (verify_repository_format(&candidate, &err) < 0) {
@@ -1400,7 +1413,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die_errno(_("Unable to read current working directory"));
 	strbuf_addbuf(&dir, &cwd);
 
-	switch (setup_git_directory_gently_1(&dir, &gitdir, 1)) {
+	switch (setup_git_directory_gently_1(&cwd, &dir, &gitdir, 1)) {
 	case GIT_DIR_EXPLICIT:
 		prefix = setup_explicit_git_dir(gitdir.buf, &cwd, &repo_fmt, nongit_ok);
 		break;
diff --git a/t/t0034-discovery-bare.sh b/t/t0034-discovery-bare.sh
index 9c774872c4e..ba44cf19c99 100755
--- a/t/t0034-discovery-bare.sh
+++ b/t/t0034-discovery-bare.sh
@@ -56,4 +56,14 @@ test_expect_success 'discovery.bare=never' '
 	)
 '
 
+test_expect_success 'discovery.bare=cwd' '
+	git config --global discovery.bare cwd &&
+	(
+		cd outer-repo/bare-repo &&
+		expect_allowed &&
+		cd refs/ &&
+		expect_rejected
+	)
+'
+
 test_done
-- 
gitgitgadget
