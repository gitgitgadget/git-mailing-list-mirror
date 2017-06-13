Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B5501FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753902AbdFMVD2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:03:28 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33629 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753742AbdFMVD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:03:26 -0400
Received: by mail-pf0-f170.google.com with SMTP id 83so73425684pfr.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+tZBgePLGjSzivAu6OKu0LEo6J++ZBZZv/r6ya/VDv4=;
        b=CNA/PHI9JNFjo7eZL+gfLALc4oWYOvY1N5kA05vmPHwjem08/90g5MQjlG2TjLw+e6
         9Snbv7k8PYwmFjPQd9IDz/78HCCQidbzLEZrxPvNgm9CpmgcFxQdJphIIjLXdifBTArM
         cSOLWZxaGiVq9QjBrwuPvGNGuRd8wRjHeHti675kahlz+2AWTA7A/0ObZx8QIFNIon+/
         FG9VBplZSb9HQefhP1Yvl6SvSMa6oAYiyn/GQDrM0a7SO01mpdcGosRxcGyanJjyWA/C
         fOoZz2cCszKGjEkDbaa5vyjPwY4fzQcv1vcjoDMZ/nvCm9kYpvnbtTJEtDiSzSC2s2E2
         0QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+tZBgePLGjSzivAu6OKu0LEo6J++ZBZZv/r6ya/VDv4=;
        b=DPDKH3gxwM2cKS7NiOn4EUSqtGG5VDU26XvUU4YHb4+a9i9wIanHyEeV6XC8xky7Hn
         7JWbO4G+rph3/aGxFklqewmT2xvWahVXmojrsrizD0RLO9pxGdXWB3gNuslNgxo5ha89
         P9/N6fVGZ94lORKGvoz3ZOJvotkl1jSucYdOvqsifjqFioqw2Luo1LDHxZ7PHejGCRtR
         goWRpWhf5K2B+iEF1IHvmr7hk3TZxTd2BmtTO/dQn+svFtRxfcNi9lO7oJ5VJ1GTnnXC
         cKnaQlbnk6ShGRY5n7P0+6kikaORt850M1sgqQjXWWh+H685WSZIoGu87kqWFW3LJ+Nw
         IOnQ==
X-Gm-Message-State: AKS2vOwDfoCDlYHUHu2gFOLl28204++vmMukBtj8MbIT/swVHpM1COQB
        muojY1ry4dm56XTsJ9RAyw==
X-Received: by 10.84.233.204 with SMTP id m12mr1544690pln.273.1497387805600;
        Tue, 13 Jun 2017 14:03:25 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b65sm29154065pfm.29.2017.06.13.14.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:03:24 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, peff@peff.net,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 0/6] config.h
Date:   Tue, 13 Jun 2017 14:03:15 -0700
Message-Id: <20170613210321.152978-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612213406.83247-1-bmwill@google.com>
References: <20170612213406.83247-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:
 * Fix a small nit in builtin/config.c that Jonathan pointed out.
 * Added two patches which ensure that the repository wide config is properly
   read by providing 'commondir' as a field in the 'config_options' struct.

Brandon Williams (6):
  config: create config.h
  config: remove git_config_iter
  config: don't include config.h by default
  config: don't implicitly use gitdir
  setup: teach discover_git_directory to respect the commondir
  config: respect commondir

--- interdiff with 'origin/bw/config-h'

diff --git a/builtin/config.c b/builtin/config.c
index 90f49a6ee..8b6e227c5 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -539,8 +539,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		config_options.respect_includes = !given_config_source.file;
 	else
 		config_options.respect_includes = respect_includes_opt;
-	if (have_git_dir())
-		config_options.git_dir = get_git_common_dir();
+	if (!nongit) {
+		config_options.commondir = get_git_common_dir();
+		config_options.git_dir = get_git_dir();
+	}
 
 	if (end_null) {
 		term = '\0';
diff --git a/cache.h b/cache.h
index fd45b8c55..a4176436d 100644
--- a/cache.h
+++ b/cache.h
@@ -530,7 +530,8 @@ extern void setup_work_tree(void);
  * appended to gitdir. The return value is either NULL if no repository was
  * found, or pointing to the path inside gitdir's buffer.
  */
-extern const char *discover_git_directory(struct strbuf *gitdir);
+extern const char *discover_git_directory(struct strbuf *commondir,
+					  struct strbuf *gitdir);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
 extern char *prefix_path(const char *prefix, int len, const char *path);
diff --git a/config.c b/config.c
index 4e2842689..81151fb54 100644
--- a/config.c
+++ b/config.c
@@ -1544,8 +1544,8 @@ static int do_git_config_sequence(const struct config_options *opts,
 	char *user_config = expand_user_path("~/.gitconfig", 0);
 	char *repo_config;
 
-	if (opts->git_dir)
-		repo_config = mkpathdup("%s/config", opts->git_dir);
+	if (opts->commondir)
+		repo_config = mkpathdup("%s/config", opts->commondir);
 	else
 		repo_config = NULL;
 
@@ -1609,8 +1609,11 @@ static void git_config_raw(config_fn_t fn, void *data)
 	struct config_options opts = {0};
 
 	opts.respect_includes = 1;
-	if (have_git_dir())
-		opts.git_dir = get_git_common_dir();
+	if (have_git_dir()) {
+		opts.commondir = get_git_common_dir();
+		opts.git_dir = get_git_dir();
+	}
+
 	if (git_config_with_options(fn, data, NULL, &opts) < 0)
 		/*
 		 * git_config_with_options() normally returns only
@@ -1652,11 +1655,13 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 void read_early_config(config_fn_t cb, void *data)
 {
 	struct config_options opts = {0};
-	struct strbuf buf = STRBUF_INIT;
+	struct strbuf commondir = STRBUF_INIT;
+	struct strbuf gitdir = STRBUF_INIT;
 
 	opts.respect_includes = 1;
 
-	if (have_git_dir())
+	if (have_git_dir()) {
+		opts.commondir = get_git_common_dir();
 		opts.git_dir = get_git_dir();
 	/*
 	 * When setup_git_directory() was not yet asked to discover the
@@ -1666,12 +1671,15 @@ void read_early_config(config_fn_t cb, void *data)
 	 * notably, the current working directory is still the same after the
 	 * call).
 	 */
-	else if (discover_git_directory(&buf))
-		opts.git_dir = buf.buf;
+	} else if (discover_git_directory(&commondir, &gitdir)) {
+		opts.commondir = commondir.buf;
+		opts.git_dir = gitdir.buf;
+	}
 
 	git_config_with_options(cb, data, NULL, &opts);
 
-	strbuf_release(&buf);
+	strbuf_release(&commondir);
+	strbuf_release(&gitdir);
 }
 
 static void git_config_check_init(void);
diff --git a/config.h b/config.h
index c70599bd5..63b92784c 100644
--- a/config.h
+++ b/config.h
@@ -30,6 +30,7 @@ enum config_origin_type {
 
 struct config_options {
 	unsigned int respect_includes : 1;
+	const char *commondir;
 	const char *git_dir;
 };
 
diff --git a/setup.c b/setup.c
index e99a82cbe..7bbb8736f 100644
--- a/setup.c
+++ b/setup.c
@@ -946,10 +946,12 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 	}
 }
 
-const char *discover_git_directory(struct strbuf *gitdir)
+const char *discover_git_directory(struct strbuf *commondir,
+				   struct strbuf *gitdir)
 {
 	struct strbuf dir = STRBUF_INIT, err = STRBUF_INIT;
 	size_t gitdir_offset = gitdir->len, cwd_len;
+	size_t commondir_offset = commondir->len;
 	struct repository_format candidate;
 
 	if (strbuf_getcwd(&dir))
@@ -974,8 +976,10 @@ const char *discover_git_directory(struct strbuf *gitdir)
 		strbuf_insert(gitdir, gitdir_offset, dir.buf, dir.len);
 	}
 
+	get_common_dir(commondir, gitdir->buf + gitdir_offset);
+
 	strbuf_reset(&dir);
-	strbuf_addf(&dir, "%s/config", gitdir->buf + gitdir_offset);
+	strbuf_addf(&dir, "%s/config", commondir->buf + commondir_offset);
 	read_repository_format(&candidate, dir.buf);
 	strbuf_release(&dir);
 
@@ -983,6 +987,7 @@ const char *discover_git_directory(struct strbuf *gitdir)
 		warning("ignoring git dir '%s': %s",
 			gitdir->buf + gitdir_offset, err.buf);
 		strbuf_release(&err);
+		strbuf_setlen(commondir, commondir_offset);
 		return NULL;
 	}

-- 
2.13.1.518.g3df882009-goog

