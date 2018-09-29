Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D129E1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 15:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeI2V7R (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 17:59:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34743 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeI2V7R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 17:59:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so8483216ljk.1
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 08:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kk7fToAR4dcXU5TjoFrbint16ynTY9oD40OQ4B7Be2Q=;
        b=F8VY0akfrSQG4ZpmZoXeF0eFIw3C/aoShmsF/pZljQD6PM2xkjTmh0Agj2W+LF+I79
         m/K1c5lqFI1n2h77eHcBhyg+3HHbWoWKkUsy9GMB5usP03PJn/27jBiI85JNIkHrsBHZ
         mO+1Sa7ivkQxn5QwwY6XRtEHmf/cc5feyanpm7S3DtwLY+y80xC/1j1KoaACjiYkE/WQ
         jv9MeC90R3pBChU026vFeTkWOkPqwKDYGAkaguNtju6fq9X10i8bemNOW31UOa0hiqIH
         Y799TiDacwRedd9ik0UppZLnpXZ9eCcw9Ot3xUhokaNIDVlREiXv+x8+WVOMbk9CP2JB
         yAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kk7fToAR4dcXU5TjoFrbint16ynTY9oD40OQ4B7Be2Q=;
        b=uNPtL01DTDFXpX334vxchtfVRiVclnJeqtBWI8hrC9gzw36ThgnyhrFCON4fWKuAav
         YA3zqhwF/I2hQaBOgxMiYy3c0f2gUrvJIVnPe0SjhTG1/kkuolXVXYUVDFJLWSMRIKNu
         NOnc7KDYbn8P2FQgVOg5cF1vJIbPnd+I5IRFkvEXOWmNfOsXJAZbKXphOCr9oDZOEPMa
         6lPt7ZD7yFfqmtMF2e6iRnuYp0l96l3b44MoTYoqPjQcKSsMLFDc4x6XnO+iReD69VOV
         286Facq8rkBq/bF2oSNwIPD2GW3xql+a/6XbFpfzLqwz9DF/3dU2xFpXtmrP7oBV76/M
         lNuA==
X-Gm-Message-State: ABuFfohMalPu1XPK8zn5VfhBGOhuNpH1N8//LLXugsQahowBaOZUEYts
        x5OYH3u5XAseSYeIdpxL4wk=
X-Google-Smtp-Source: ACcGV60Fp4gvQUt6H08T4E5MszVdfIozBJdTWEzNJChF2QM/2nTAy4CJ8JDxwlXMAUd/8kyUEJaBJA==
X-Received: by 2002:a2e:9b04:: with SMTP id u4-v6mr1922433lji.29.1538235023468;
        Sat, 29 Sep 2018 08:30:23 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id m13-v6sm1600899lfj.39.2018.09.29.08.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 08:30:22 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>
Subject: [PATCH v2 0/2] Per-worktree config files
Date:   Sat, 29 Sep 2018 17:30:03 +0200
Message-Id: <20180929153005.10599-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.341.g3acb95d729
In-Reply-To: <20180923170438.23610-1-pclouds@gmail.com>
References: <20180923170438.23610-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Besides various doc/test changes. v2 has two code changes

- "git config --worktree" on a multiple worktree setup _without_ the
  new extension will now barf. The user is supposed to RTFM and enable
  the extension manually.

- I failed to update setup code to pick up config from per-worktree
  files. Granted, core.bare and core.worktree don't have much use in
  this context (except perhaps submodules). But let's make sure we
  have proper code path to handle it.

config.worktree should have a new scope, CONFIG_SCOPE_WORKTREE, on top
of CONFIG_SCOPE_REPO. But we would need to go over scope-sensitive
code (upload-pack and remote) to update if necessary. I don't think
it's worth getting into that just yet.

Range diff

-:  ---------- > 1:  8f334e0020 t1300: extract and use test_cmp_config()
1:  12a999e517 ! 2:  99337a52f2 worktree: add per-worktree config files
    @@ -9,7 +9,7 @@
            worktree setup.
     
          - The special treatment for core.bare and core.worktree, to stay
    -       effective only in main worktree, is gone. These config files are
    +       effective only in main worktree, is gone. These config settings are
            supposed to be in config.worktree.
     
         This extension is most useful in multiple worktree setup because you
    @@ -38,7 +38,8 @@
         isolated.
     
         (*) "git config --worktree" points back to "config" file when this
    -        extension is not present so that it works in any setup.
    +        extension is not present and there is only one worktree so that it
    +        works in any both single and multiple worktree setups.
     
      diff --git a/Documentation/config.txt b/Documentation/config.txt
      --- a/Documentation/config.txt
    @@ -50,7 +51,7 @@
     -the Git commands' behavior. The `.git/config` file in each repository
     -is used to store the configuration for that repository, and
     +the Git commands' behavior. The files `.git/config` and optionally
    -+`config.worktree` (see `extensions.worktreeConfig` below) are each
    ++`config.worktree` (see `extensions.worktreeConfig` below) in each
     +repository is used to store the configuration for that repository, and
      `$HOME/.gitconfig` is used to store a per-user configuration as
      fallback values for the `.git/config` file. The file `/etc/gitconfig`
    @@ -61,9 +62,10 @@
      
     +extensions.worktreeConfig::
     +	If set, by default "git config" reads from both "config" and
    -+	"config.worktree" file in that order. In multiple working
    -+	directory mode, "config" file is shared while
    -+	"config.worktree" is per-working directory.
    ++	"config.worktree" file from GIT_DIR in that order. In
    ++	multiple working directory mode, "config" file is shared while
    ++	"config.worktree" is per-working directory (i.e., it's in
    ++	GIT_COMMON_DIR/worktrees/<id>/config.worktree)
     +
      core.fileMode::
      	Tells Git if the executable bit of files in the working tree
    @@ -140,12 +142,12 @@
     +CONFIGURATION FILE
     +------------------
     +By default, the repository "config" file is shared across all working
    -+directories. If the config variables `core.bare` or `core.worktree`
    -+are already present in the config file, they will be applied to the
    -+main working directory only.
    ++trees. If the config variables `core.bare` or `core.worktree` are
    ++already present in the config file, they will be applied to the main
    ++working trees only.
     +
    -+In order to have configuration specific to working directories, you
    -+can turn on "worktreeConfig" extension, e.g.:
    ++In order to have configuration specific to working trees, you can turn
    ++on "worktreeConfig" extension, e.g.:
     +
     +------------
     +$ git config extensions.worktreeConfig true
    @@ -153,26 +155,19 @@
     +
     +In this mode, specific configuration stays in the path pointed by `git
     +rev-parse --git-path config.worktree`. You can add or update
    -+configuration in this file with `git config --worktree`. Git before
    -+version 2.20.0 will refuse to access repositories with this extension.
    ++configuration in this file with `git config --worktree`. Older Git
    ++versions may will refuse to access repositories with this extension.
     +
    -+Note that in this file, the exception for `core.bare` and
    -+`core.worktree` is gone. If you have them before, you need to move
    -+them to the `config.worktree` of the main working directory. You may
    -+also take this opportunity to move other configuration that you do not
    -+want to share to all working directories:
    ++Note that in this file, the exception for `core.bare` and `core.worktree`
    ++is gone. If you have them in $GIT_DIR/config before, you must move
    ++them to the `config.worktree` of the main working tree. You may also
    ++take this opportunity to review and move other configuration that you
    ++do not want to share to all working trees:
     +
     + - `core.worktree` and `core.bare` should never be shared
     +
    -+ - `core.sparseCheckout` is recommended per working directory, unless
    -+   you are sure you always use sparse checkout for all working
    -+   directories.
    -+
    -+When `git config --worktree` is used to set a configuration variable
    -+in multiple working directory setup, `extensions.worktreeConfig` will
    -+be automatically set. The two variables `core.worktree` and
    -+`core.bare` if present will be moved to `config.worktree` of the main
    -+working tree.
    ++ - `core.sparseCheckout` is recommended per working tree, unless you
    ++   are sure you always use sparse checkout for all working trees.
     +
      DETAILS
      -------
    @@ -248,10 +243,13 @@
     +		struct worktree **worktrees = get_worktrees(0);
     +		if (repository_format_worktree_config)
     +			given_config_source.file = git_pathdup("config.worktree");
    -+		else if (worktrees[0] && worktrees[1]) {
    -+			migrate_worktree_config(the_repository);
    -+			given_config_source.file = git_pathdup("config.worktree");
    -+		} else
    ++		else if (worktrees[0] && worktrees[1])
    ++			die(_("--worktree cannot be used with multiple "
    ++			      "working trees unless the config\n"
    ++			      "extension worktreeConfig is enabled. "
    ++			      "Please read \"CONFIGURATION FILE\"\n"
    ++			      "section in \"git help worktree\" for details"));
    ++		else
     +			given_config_source.file = git_pathdup("config");
     +		free_worktrees(worktrees);
     +	} else if (given_config_source.file) {
    @@ -284,6 +282,10 @@
      	if (repo_config && !access_or_die(repo_config, R_OK, 0))
      		ret += git_config_from_file(fn, repo_config, data);
      
    ++	/*
    ++	 * Note: this should have a new scope, CONFIG_SCOPE_WORKTREE.
    ++	 * But let's not complicate things before it's actually needed.
    ++	 */
     +	if (repository_format_worktree_config) {
     +		char *path = git_pathdup("config.worktree");
     +		if (!access_or_die(path, R_OK, 0))
    @@ -310,6 +312,27 @@
      diff --git a/setup.c b/setup.c
      --- a/setup.c
      +++ b/setup.c
    +@@
    + 	initialized = 1;
    + }
    + 
    ++static int read_worktree_config(const char *var, const char *value, void *vdata)
    ++{
    ++	struct repository_format *data = vdata;
    ++
    ++	if (strcmp(var, "core.bare") == 0) {
    ++		data->is_bare = git_config_bool(var, value);
    ++	} else if (strcmp(var, "core.worktree") == 0) {
    ++		if (!value)
    ++			return config_error_nonbool(var);
    ++		data->work_tree = xstrdup(value);
    ++	}
    ++	return 0;
    ++}
    ++
    + static int check_repo_format(const char *var, const char *value, void *vdata)
    + {
    + 	struct repository_format *data = vdata;
     @@
      			if (!value)
      				return config_error_nonbool(var);
    @@ -319,16 +342,40 @@
     +			data->worktree_config = git_config_bool(var, value);
     +		else
      			string_list_append(&data->unknown_extensions, ext);
    - 	} else if (strcmp(var, "core.bare") == 0) {
    - 		data->is_bare = git_config_bool(var, value);
    +-	} else if (strcmp(var, "core.bare") == 0) {
    +-		data->is_bare = git_config_bool(var, value);
    +-	} else if (strcmp(var, "core.worktree") == 0) {
    +-		if (!value)
    +-			return config_error_nonbool(var);
    +-		data->work_tree = xstrdup(value);
    + 	}
    +-	return 0;
    ++
    ++	return read_worktree_config(var, value, vdata);
    + }
    + 
    + static int check_repository_format_gently(const char *gitdir, struct repository_format *candidate, int *nongit_ok)
     @@
      
      	repository_format_precious_objects = candidate->precious_objects;
      	repository_format_partial_clone = candidate->partial_clone;
     +	repository_format_worktree_config = candidate->worktree_config;
      	string_list_clear(&candidate->unknown_extensions, 0);
    ++
    ++	if (repository_format_worktree_config) {
    ++		/*
    ++		 * pick up core.bare and core.worktree from per-worktree
    ++		 * config if present
    ++		 */
    ++		strbuf_addf(&sb, "%s/config.worktree", gitdir);
    ++		git_config_from_file(read_worktree_config, sb.buf, candidate);
    ++		strbuf_release(&sb);
    ++		has_common = 0;
    ++	}
    ++
      	if (!has_common) {
      		if (candidate->is_bare != -1) {
    + 			is_bare_repository_cfg = candidate->is_bare;
     
      diff --git a/t/t2029-worktree-config.sh b/t/t2029-worktree-config.sh
      new file mode 100755
    @@ -341,150 +388,76 @@
     +
     +. ./test-lib.sh
     +
    -+cmp_config() {
    -+	if [ "$1" = "-C" ]; then
    -+		shift &&
    -+		GD="-C $1" &&
    -+		shift
    -+	else
    -+		GD=
    -+	fi &&
    -+	echo "$1" >expected &&
    -+	shift &&
    -+	git $GD config "$@" >actual &&
    -+	test_cmp expected actual
    -+}
    -+
     +test_expect_success 'setup' '
    -+	test_commit start &&
    -+	git config --worktree per.worktree is-ok &&
    ++	test_commit start
    ++'
    ++
    ++test_expect_success 'config --worktree in single worktree' '
    ++	git config --worktree foo.bar true &&
    ++	test_cmp_config true foo.bar
    ++'
    ++
    ++test_expect_success 'add worktrees' '
     +	git worktree add wt1 &&
    -+	git worktree add wt2 &&
    -+	git config --worktree per.worktree is-ok &&
    -+	cmp_config true extensions.worktreeConfig
    ++	git worktree add wt2
    ++'
    ++
    ++test_expect_success 'config --worktree without extension' '
    ++	test_must_fail git config --worktree foo.bar false
    ++'
    ++
    ++test_expect_success 'enable worktreeConfig extension' '
    ++	git config extensions.worktreeConfig true &&
    ++	test_cmp_config true extensions.worktreeConfig
     +'
     +
     +test_expect_success 'config is shared as before' '
     +	git config this.is shared &&
    -+	cmp_config shared this.is &&
    -+	cmp_config -C wt1 shared this.is &&
    -+	cmp_config -C wt2 shared this.is
    ++	test_cmp_config shared this.is &&
    ++	test_cmp_config -C wt1 shared this.is &&
    ++	test_cmp_config -C wt2 shared this.is
     +'
     +
     +test_expect_success 'config is shared (set from another worktree)' '
     +	git -C wt1 config that.is also-shared &&
    -+	cmp_config also-shared that.is &&
    -+	cmp_config -C wt1 also-shared that.is &&
    -+	cmp_config -C wt2 also-shared that.is
    ++	test_cmp_config also-shared that.is &&
    ++	test_cmp_config -C wt1 also-shared that.is &&
    ++	test_cmp_config -C wt2 also-shared that.is
     +'
     +
     +test_expect_success 'config private to main worktree' '
     +	git config --worktree this.is for-main &&
    -+	cmp_config for-main this.is &&
    -+	cmp_config -C wt1 shared this.is &&
    -+	cmp_config -C wt2 shared this.is
    ++	test_cmp_config for-main this.is &&
    ++	test_cmp_config -C wt1 shared this.is &&
    ++	test_cmp_config -C wt2 shared this.is
     +'
     +
     +test_expect_success 'config private to linked worktree' '
     +	git -C wt1 config --worktree this.is for-wt1 &&
    -+	cmp_config for-main this.is &&
    -+	cmp_config -C wt1 for-wt1 this.is &&
    -+	cmp_config -C wt2 shared this.is
    ++	test_cmp_config for-main this.is &&
    ++	test_cmp_config -C wt1 for-wt1 this.is &&
    ++	test_cmp_config -C wt2 shared this.is
     +'
     +
     +test_expect_success 'core.bare no longer for main only' '
    -+	git config core.bare true &&
    -+	cmp_config true core.bare &&
    -+	cmp_config -C wt1 true core.bare &&
    -+	cmp_config -C wt2 true core.bare &&
    -+	git config --unset core.bare
    ++	test_config core.bare true &&
    ++	test "$(git rev-parse --is-bare-repository)" = true &&
    ++	test "$(git -C wt1 rev-parse --is-bare-repository)" = true &&
    ++	test "$(git -C wt2 rev-parse --is-bare-repository)" = true
     +'
     +
    -+test_expect_success 'config.worktree no longer read without extension' '
    -+	git config --unset extensions.worktreeConfig &&
    -+	cmp_config shared this.is &&
    -+	cmp_config -C wt1 shared this.is &&
    -+	cmp_config -C wt2 shared this.is
    ++test_expect_success 'per-worktree core.bare is picked up' '
    ++	git -C wt1 config --worktree core.bare true &&
    ++	test "$(git rev-parse --is-bare-repository)" = false &&
    ++	test "$(git -C wt1 rev-parse --is-bare-repository)" = true &&
    ++	test "$(git -C wt2 rev-parse --is-bare-repository)" = false
     +'
     +
    -+test_expect_success 'config --worktree migrate core.bare and core.worktree' '
    -+	git config core.bare true &&
    -+	git config --worktree foo.bar true &&
    -+	cmp_config true extensions.worktreeConfig &&
    -+	cmp_config true foo.bar &&
    -+	cmp_config true core.bare &&
    -+	! git -C wt1 config core.bare
    ++test_expect_success 'config.worktree no longer read without extension' '
    ++	git config --unset extensions.worktreeConfig &&
    ++	test_cmp_config shared this.is &&
    ++	test_cmp_config -C wt1 shared this.is &&
    ++	test_cmp_config -C wt2 shared this.is
     +'
     +
     +test_done
    -
    - diff --git a/worktree.c b/worktree.c
    - --- a/worktree.c
    - +++ b/worktree.c
    -@@
    - #include "worktree.h"
    - #include "dir.h"
    - #include "wt-status.h"
    -+#include "config.h"
    - 
    - void free_worktrees(struct worktree **worktrees)
    - {
    -@@
    - 	free_worktrees(worktrees);
    - 	return ret;
    - }
    -+
    -+void migrate_worktree_config(struct repository *r)
    -+{
    -+	struct strbuf worktree_path = STRBUF_INIT;
    -+	struct strbuf main_path = STRBUF_INIT;
    -+	struct repository_format format;
    -+
    -+	assert(repository_format_worktree_config == 0);
    -+
    -+	strbuf_git_common_path(&worktree_path, r, "config.worktree");
    -+	strbuf_git_path(&main_path, "config");
    -+
    -+	read_repository_format(&format, main_path.buf);
    -+	assert(format.worktree_config == 0);
    -+
    -+	if (format.is_bare >= 0) {
    -+		git_config_set_in_file(worktree_path.buf,
    -+				       "core.bare", "true");
    -+		git_config_set_in_file(main_path.buf,
    -+				       "core.bare", NULL);
    -+	}
    -+	if (format.work_tree) {
    -+		git_config_set_in_file(worktree_path.buf,
    -+				       "core.worktree",
    -+				       format.work_tree);
    -+		git_config_set_in_file(main_path.buf,
    -+				       "core.worktree", NULL);
    -+	}
    -+
    -+	git_config_set_in_file(main_path.buf,
    -+			       "extensions.worktreeConfig", "true");
    -+	if (format.version == 0)
    -+		git_config_set_in_file(main_path.buf,
    -+				       "core.repositoryFormatVersion", "1");
    -+
    -+	repository_format_worktree_config = 1;
    -+
    -+	strbuf_release(&main_path);
    -+	strbuf_release(&worktree_path);
    -+}
    -
    - diff --git a/worktree.h b/worktree.h
    - --- a/worktree.h
    - +++ b/worktree.h
    -@@
    - 				     const char *fmt, ...)
    - 	__attribute__((format (printf, 2, 3)));
    - 
    -+/*
    -+ * Called to add extensions.worktreeConfig to $GIT_DIR/config and move
    -+ * main worktree specific config variables to $GIT_DIR/config.worktree.
    -+ */
    -+void migrate_worktree_config(struct repository *r);
    -+
    - #endif


Nguyễn Thái Ngọc Duy (2):
  t1300: extract and use test_cmp_config()
  worktree: add per-worktree config files

 Documentation/config.txt               | 12 +++-
 Documentation/git-config.txt           | 26 ++++++---
 Documentation/git-worktree.txt         | 30 ++++++++++
 Documentation/gitrepository-layout.txt |  8 +++
 builtin/config.c                       | 19 ++++++-
 cache.h                                |  2 +
 config.c                               | 11 ++++
 environment.c                          |  1 +
 setup.c                                | 40 ++++++++++---
 t/t1300-config.sh                      | 79 +++++++-------------------
 t/t2029-worktree-config.sh             | 79 ++++++++++++++++++++++++++
 t/test-lib-functions.sh                | 24 ++++++++
 12 files changed, 253 insertions(+), 78 deletions(-)
 create mode 100755 t/t2029-worktree-config.sh

-- 
2.19.0.341.g3acb95d729

