Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6224C211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 15:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeL0P4d (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 10:56:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39747 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeL0P4c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 10:56:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so16596229ljh.6
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 07:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=42pZY4VLjNgy7X3rKRZvSf7imxZdopgZILKrP3V7QlI=;
        b=r6XOwlT9nS6OtjSBE9+UDdxJQi1DbJpryAja8SReVm1KKHKFk95wQKflvKSXa2ExYa
         RvGpK0oIcnyUCuNZS3DLrXstweVBzajjETHSjJN2OYunjFrb+mJR6lBlaiuEqOT8srVY
         YY8zV2bECgoCFOIC5KILwyssLnXqK6cNF38jkvUC/A8AiXLYOnYSBBLUSWkeFQMzwHko
         RWkF1UC6rmsKX7/60GKQk+xlkCThDUsaPYReLzJgjiytiKQiYw5sUkWE2rrQ4mKC0ljv
         H4Hf9RsSQBo5T20gOrClOG3EPV2KFMEnTadk9Fy9ZTSfT5+YG+z0y1WsRbFquiIIGVIH
         I0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=42pZY4VLjNgy7X3rKRZvSf7imxZdopgZILKrP3V7QlI=;
        b=qWgi+yYKlH3U0HCvndGe9bK+McnQzBFEZyDCvh6FRTusU1PvdKA+1r6f44gpOSt9EG
         L1mvdke2VD6k/deq/iz1PqBqPuqEPwhG6r95EfVjSi47vYGRbndhIIvLyfPfNDx5ED9y
         DeOXMijDnERMlpq1P79TwWpkkqMQbbipaPkSxyl84tlpp9PbThjouZs91W3eaEtgiUGC
         CMEdAuH5ib/fF0eremlelwACOqi7IuJ4CR7fSk9KBG97C599moRSdOAsN/tYmYoMUnRZ
         0sMNCrJmefXs+ugcte5rBoYp3Pd4CvfYaeVUx50ogaKOCqR+Mb/8C55UL6qNu8h984Pv
         Tapw==
X-Gm-Message-State: AJcUuketWReIrDhUiO2z+jqaonTcRaS5UmDQuokq4+3Je2PpCYrugBEq
        I+Mok7nRau+fSr7ylssiYx/FDS9o
X-Google-Smtp-Source: ALg8bN54uKRoNwfCNg6TIpps/2ekI4nfEGU7N7mxdKU21gMsomdXzml3+neX3uoIpDGHHAPhPd/M+A==
X-Received: by 2002:a2e:2d4:: with SMTP id y81-v6mr14102390lje.62.1545926188126;
        Thu, 27 Dec 2018 07:56:28 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id p77-v6sm9095367lja.0.2018.12.27.07.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 07:56:27 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 6/6] config: add --move-to
Date:   Thu, 27 Dec 2018 16:56:11 +0100
Message-Id: <20181227155611.10585-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227155611.10585-1-pclouds@gmail.com>
References: <20181227155611.10585-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option can be used to move one or multiple variables from one
place to another, e.g. to move some aliases from repo config to user
config, or from repo config to per-worktree config.

This will be useful for moving config variables around when
extensions.worktreeConfig is enabled. E.g.

    git config --local --move-to --worktree core.worktree
    git config --local --move-glob-to --worktree 'submodule.*.*'

The implementation is definitely not the best. We could for example
lock both source and destination files before doing any update, and
perhaps edit these files just once instead of once per key.

But it adds a lot more complication to config update code. Let's stay
with something simple for now. It's not worse than scripting using
"git config". Optimization could be done later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-config.txt   |  12 ++++
 Documentation/git-worktree.txt |  16 +++--
 builtin/config.c               | 120 +++++++++++++++++++++++++++++++++
 t/t1300-config.sh              |  54 +++++++++++++++
 4 files changed, 196 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 1bfe9f56a7..495bb57416 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -20,6 +20,9 @@ SYNOPSIS
 'git config' [<file-option>] --unset-all name [value_regex]
 'git config' [<file-option>] --rename-section old_name new_name
 'git config' [<file-option>] --remove-section name
+'git config' [<file-option>] --move-to name
+'git config' [<file-option>] --move-regexp-to name-regexp
+'git config' [<file-option>] --move-glob-to name-glob
 'git config' [<file-option>] [--show-origin] [-z|--null] [--name-only] -l | --list
 'git config' [<file-option>] --get-color name [default]
 'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
@@ -161,6 +164,15 @@ See also <<FILES>>.
 --unset-all::
 	Remove all lines matching the key from config file.
 
+--move-to::
+--move-regexp-to::
+--move-glob-to::
+	Move a config variable (or multiple variables matching the
+	given regular expression or glob pattern) to a new file. Any
+	option about the config file location after `--move-to` or
+	`--move-to-regexp` specifies the move destination. Existing
+	config of the same name remains.
+
 -l::
 --list::
 	List all variables set in config file, along with their values.
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index cb86318f3e..aae8e1d8b2 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -252,13 +252,17 @@ rev-parse --git-path config.worktree`. You can add or update
 configuration in this file with `git config --worktree`. Older Git
 versions will refuse to access repositories with this extension.
 
-Note that in this file, the exception for `core.bare` and `core.worktree`
-is gone. If you have them in $GIT_DIR/config before, you must move
-them to the `config.worktree` of the main working tree. You may also
-take this opportunity to review and move other configuration that you
-do not want to share to all working trees:
+Note that in this file, the exception for `core.bare` and
+`core.worktree` is gone. If you have them in $GIT_DIR/config before,
+you must move them to the `config.worktree` of the main working tree.
 
- - `core.worktree` and `core.bare` should never be shared
+------------
+$ git config --local --move-to --worktree core.bare
+$ git config --local --move-to --worktree core.worktree
+------------
+
+You may also take this opportunity to review and move other
+configuration that you do not want to share to all working trees:
 
  - `core.sparseCheckout` is recommended per working tree, unless you
    are sure you always use sparse checkout for all working trees.
diff --git a/builtin/config.c b/builtin/config.c
index 61a6a5a0e1..20266824f3 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -26,6 +26,7 @@ static char term = '\n';
 
 static int use_global_config, use_system_config, use_local_config;
 static int use_worktree_config;
+static struct git_config_source move_source;
 static struct git_config_source given_config_source;
 static int actions, type;
 static char *default_value;
@@ -50,6 +51,9 @@ static int show_origin;
 #define ACTION_GET_COLOR (1<<13)
 #define ACTION_GET_COLORBOOL (1<<14)
 #define ACTION_GET_URLMATCH (1<<15)
+#define ACTION_MOVE (1<<16)
+#define ACTION_MOVE_REGEXP (1<<17)
+#define ACTION_MOVE_GLOB (1<<18)
 
 /*
  * The actions "ACTION_LIST | ACTION_GET_*" which may produce more than
@@ -178,6 +182,25 @@ static int option_parse_type(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static int option_move_cb(const struct option *opt,
+			  const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+
+	set_config_source_file();
+	memcpy(&move_source, &given_config_source, sizeof(move_source));
+
+	memset(&given_config_source, 0, sizeof(given_config_source));
+	use_global_config = 0;
+	use_system_config = 0;
+	use_local_config = 0;
+	use_worktree_config = 0;
+
+	actions = opt->defval;
+	return 0;
+}
+
 static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Config file location")),
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
@@ -197,6 +220,18 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "unset-all", &actions, N_("remove all matches: name [value-regex]"), ACTION_UNSET_ALL),
 	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-name"), ACTION_RENAME_SECTION),
 	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTION_REMOVE_SECTION),
+	{ OPTION_CALLBACK, 0, "move-to", NULL, NULL,
+	  N_("move a variable to a different config file"),
+	  PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+	  option_move_cb, ACTION_MOVE },
+	{ OPTION_CALLBACK, 0, "move-regexp-to", NULL, NULL,
+	  N_("move matching variables to a different config file"),
+	  PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+	  option_move_cb, ACTION_MOVE_REGEXP },
+	{ OPTION_CALLBACK, 0, "move-glob-to", NULL, NULL,
+	  N_("move matching variables to a different config file"),
+	  PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+	  option_move_cb, ACTION_MOVE_GLOB },
 	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
 	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
@@ -426,6 +461,84 @@ static int get_value(const char *key_, const char *regex_)
 	return ret;
 }
 
+struct move_config_cb {
+	struct string_list keys;
+	const char *key;
+	regex_t key_re;
+};
+
+static int collect_move_config(const char *key, const char *value, void *cb)
+{
+	struct move_config_cb *data = cb;
+
+	switch (actions) {
+	case ACTION_MOVE:
+		if (strcasecmp(data->key, key))
+			return 0;
+		break;
+	case ACTION_MOVE_REGEXP:
+		if (regexec(&data->key_re, key, 0, NULL, 0))
+			return 0;
+		break;
+	case ACTION_MOVE_GLOB:
+		if (wildmatch(data->key, key, WM_CASEFOLD))
+			return 0;
+		break;
+	default:
+		BUG("action %d cannot get here", actions);
+	}
+
+	string_list_append(&data->keys, key)->util = xstrdup(value);
+	return 0;
+}
+
+static int move_config(const char *key)
+{
+	struct move_config_cb cb;
+	int i, ret = 0;
+
+	config_options.respect_includes = 0;
+	if (!move_source.file && !move_source.use_stdin && !move_source.blob)
+		die(_("unknown config source"));
+
+	string_list_init(&cb.keys, 1);
+	cb.key = key;
+	if (actions == ACTION_MOVE_REGEXP &&
+	    regcomp(&cb.key_re, key, REG_EXTENDED | REG_ICASE))
+		die(_("invalid key pattern: %s"), key);
+
+	config_with_options(collect_move_config, &cb,
+			    &move_source, &config_options);
+
+	for (i = 0; i < cb.keys.nr && !ret; i++) {
+		const char *key = cb.keys.items[i].string;
+		const char *value = cb.keys.items[i].util;
+		const char *dest = given_config_source.file;
+
+		ret = git_config_set_multivar_in_file_gently(
+			dest, key, value, CONFIG_REGEX_NONE, 0);
+	}
+
+	/*
+	 * OK all keys have been copied successfully, time to delete
+	 * old ones
+	 */
+	if (!ret && move_source.file) {
+		for (i = 0; i < cb.keys.nr; i++) {
+			const char *key = cb.keys.items[i].string;
+			const char *src = move_source.file;
+
+			git_config_set_multivar_in_file_gently(
+				src, key, NULL, NULL, 1);
+		}
+	}
+
+	string_list_clear(&cb.keys, 1);
+	if (actions == ACTION_MOVE_REGEXP)
+		regfree(&cb.key_re);
+	return ret;
+}
+
 static char *normalize_value(const char *key, const char *value)
 {
 	if (!value)
@@ -862,6 +975,13 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			color_stdout_is_tty = git_config_bool("command line", argv[1]);
 		return get_colorbool(argv[0], argc == 2);
 	}
+	else if (actions == ACTION_MOVE ||
+		 actions == ACTION_MOVE_REGEXP ||
+		 actions == ACTION_MOVE_GLOB) {
+		check_write();
+		check_argc(argc, 1, 1);
+		return move_config(argv[0]);
+	}
 
 	return 0;
 }
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9652b241c7..6969e6092b 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1844,4 +1844,58 @@ test_expect_success '--replace-all does not invent newlines' '
 	test_cmp expect .git/config
 '
 
+test_expect_success '--move-to moves keys' '
+	test_when_finished rm -f dest &&
+	git config single.foo bar &&
+	git config multi.foo bar1 &&
+	git config --add multi.foo bar2 &&
+	git config --local --move-to -f dest SINGLE.foo &&
+	! git config single.foo &&
+	test_cmp_config bar -f dest single.foo &&
+	git config --local --move-to -f dest multi.FOO &&
+	! git config multi.foo &&
+	git config -f dest --get-all multi.foo | sort >actual &&
+	cat >expected <<-\EOF &&
+	bar1
+	bar2
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success '--move-regexp-to moves keys' '
+	test_when_finished rm -f dest &&
+	git config single.foo bar &&
+	git config multi.foo bar1 &&
+	git config --add multi.foo bar2 &&
+	git config --local --move-regexp-to -f dest "S.*OO" &&
+	! git config single.foo &&
+	test_cmp_config bar -f dest single.foo &&
+	git config --local --move-regexp-to -f dest ^multi &&
+	! git config multi.foo &&
+	git config -f dest --get-all multi.foo | sort >actual &&
+	cat >expected <<-\EOF &&
+	bar1
+	bar2
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success '--move-glob-to moves keys' '
+	test_when_finished rm -f dest &&
+	git config single.foo bar &&
+	git config multi.foo bar1 &&
+	git config --add multi.foo bar2 &&
+	git config --local --move-glob-to -f dest "SINGLE.*" &&
+	! git config single.foo &&
+	test_cmp_config bar -f dest single.foo &&
+	git config --local --move-glob-to -f dest "m*.foo" &&
+	! git config multi.foo &&
+	git config -f dest --get-all multi.foo | sort >actual &&
+	cat >expected <<-\EOF &&
+	bar1
+	bar2
+	EOF
+	test_cmp expected actual
+'
+
 test_done
-- 
2.20.0.482.g66447595a7

