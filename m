Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8E6C433F5
	for <git@archiver.kernel.org>; Sun, 30 Jan 2022 22:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiA3WB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Jan 2022 17:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiA3WB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jan 2022 17:01:57 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5A0C06173B
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 14:01:57 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a13so21767749wrh.9
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 14:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=7byPsTrAB6dmPYLhTkBq2W3S24n73+rzwDF5G68c3l8=;
        b=VxEHTkmRToPL0DnGvdC4rSAMc6WFWiaVHEpKJWVCatbWN5j5uC3YwXeh59i9QgKurT
         af2Ll2KkjSrEgQX/9+EcpzxQs85ZOIWyxYFZtC6qXFvQ0Wd0ABN2AyxcvrL9vvqbjsPM
         6/Ya6TAKyZANcsYr6AAr/ynhV6t9xDQ02BZk100zI/024kBSOuK07t9fNaDDvf5Y6B1r
         GiMR0kdNF4mricAi0FqnG7t88r+Qw6P4sV227CL/Xewv5ZZkeZEvQfoEv/M0tVhxfNiX
         RLw80/gRFVMX3SGzYQ06E7RUg1ppNdqszGYia0TVDp/Ia9LdvxzvrDnk/OqfmTKyHbqP
         dUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=7byPsTrAB6dmPYLhTkBq2W3S24n73+rzwDF5G68c3l8=;
        b=pMqNm7+Q++MoaH70anMOyxX91TnPMlat8phMtmCiR1l0AGqcutcd8bVU/57WHCP6Rf
         HsrKs/huNekqdA7S2F/dPZ9r6wZJW5lNT6dNnHxDZdX87w+JfMQLiT3nhTRTgUmkL0dG
         5HLFNBqt1ZGZSzVifkVzmghLPAOW8Je9OpPmWx5Ort99HF0uL2QHo2Hiq8zKJ2koe8X8
         rFZX33aHVMZrj7ANDKTprhFBMbYWV25whwxhc0HbpJRxM6WqJSCd5Rx0ZZWeIucQS7s5
         igg1KgcyJ68ffZZvg8HxBE+pyufr3hmQsI/IXHYs31I+ltMpUax6Ki9TsxHPcWuz4YyJ
         5JmA==
X-Gm-Message-State: AOAM530cvmf0JadVXP3wNwgeIuQMayxRFxeuEvuh1FkoyP44846cyER0
        rXgCRRFbd0tO35nxF/CVGOjuJHsdNV8=
X-Google-Smtp-Source: ABdhPJy4LRhJ1svS/+heutOU6OrnewcqtmznLcakjp3FafJiVoxm/z4c2VF8b/55crUpQjo4mFr8lA==
X-Received: by 2002:adf:ded0:: with SMTP id i16mr14996444wrn.64.1643580115901;
        Sun, 30 Jan 2022 14:01:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j12sm10034274wru.38.2022.01.30.14.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 14:01:55 -0800 (PST)
Message-Id: <aac3f9821c7f8927ab7cb65bd5c443f5a0174068.1643580113.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
References: <pull.1123.v2.git.1643408643.gitgitgadget@gmail.com>
        <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 30 Jan 2022 22:01:50 +0000
Subject: [PATCH v3 1/4] i18n: factorize more 'incompatible options' messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Find more incompatible options to factorize.

When more than two options are mutually exclusive, print the ones
which are actually on the command line.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/commit.c                          | 35 ++++++++++-------------
 builtin/difftool.c                        |  5 ++--
 builtin/grep.c                            |  8 ++----
 builtin/log.c                             |  5 ++--
 builtin/merge-base.c                      |  6 ++--
 parse-options.c                           | 34 ++++++++++++++++++++++
 parse-options.h                           | 17 +++++++++++
 t/t7500-commit-template-squash-signoff.sh |  2 +-
 8 files changed, 80 insertions(+), 32 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index b9ed0374e30..33ca9e99c80 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1242,8 +1242,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 				      struct commit *current_head,
 				      struct wt_status *s)
 {
-	int f = 0;
-
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	finalize_deferred_config(s);
 
@@ -1251,7 +1249,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		force_author = find_author_by_nickname(force_author);
 
 	if (force_author && renew_authorship)
-		die(_("Using both --reset-author and --author does not make sense"));
+		die(_("options '%s' and '%s' cannot be used together"), "--reset-author", "--author");
 
 	if (logfile || have_option_m || use_message)
 		use_editor = 0;
@@ -1268,20 +1266,16 @@ static int parse_and_validate_options(int argc, const char *argv[],
 			die(_("You are in the middle of a rebase -- cannot amend."));
 	}
 	if (fixup_message && squash_message)
-		die(_("Options --squash and --fixup cannot be used together"));
-	if (use_message)
-		f++;
-	if (edit_message)
-		f++;
-	if (fixup_message)
-		f++;
-	if (logfile)
-		f++;
-	if (f > 1)
-		die(_("Only one of -c/-C/-F/--fixup can be used."));
-	if (have_option_m && (edit_message || use_message || logfile))
-		die((_("Option -m cannot be combined with -c/-C/-F.")));
-	if (f || have_option_m)
+		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
+	die_for_incompatible_opt4(!!use_message, "-C",
+				  !!edit_message, "-c",
+				  !!logfile, "-F",
+				  !!fixup_message, "--fixup");
+	die_for_incompatible_opt4(have_option_m, "-m",
+				  !!edit_message, "-c",
+				  !!use_message, "-C",
+				  !!logfile, "-F");
+	if (use_message || edit_message || logfile ||fixup_message || have_option_m)
 		template_file = NULL;
 	if (edit_message)
 		use_message = edit_message;
@@ -1306,9 +1300,10 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (patch_interactive)
 		interactive = 1;
 
-	if (also + only + all + interactive > 1)
-		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
-
+	die_for_incompatible_opt4(also, "-i/--include",
+				  only, "-o/--only",
+				  all, "-a/--all",
+				  interactive, "--interactive/-p/--patch");
 	if (fixup_message) {
 		/*
 		 * We limit --fixup's suboptions to only alpha characters.
diff --git a/builtin/difftool.c b/builtin/difftool.c
index c79fbbf67e5..faa3507369a 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -732,8 +732,9 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	} else if (dir_diff)
 		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
 
-	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
-		die(_("options '%s', '%s', and '%s' cannot be used together"), "--gui", "--tool", "--extcmd");
+	die_for_incompatible_opt3(use_gui_tool, "--gui",
+				  !!difftool_cmd, "--tool",
+				  !!extcmd, "--extcmd");
 
 	if (use_gui_tool)
 		setenv("GIT_MERGETOOL_GUI", "true", 1);
diff --git a/builtin/grep.c b/builtin/grep.c
index 9e34a820ad4..88144f06300 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1167,11 +1167,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (!show_in_pager && !opt.status_only)
 		setup_pager();
 
-	if (!use_index && (untracked || cached))
-		die(_("--cached or --untracked cannot be used with --no-index"));
-
-	if (untracked && cached)
-		die(_("--untracked cannot be used with --cached"));
+	die_for_incompatible_opt3(!use_index, "--no-index",
+				  untracked, "--untracked",
+				  cached, "--cached");
 
 	if (!use_index || untracked) {
 		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
diff --git a/builtin/log.c b/builtin/log.c
index 4b493408cc5..970aa3483c4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1978,8 +1978,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (rev.show_notes)
 		load_display_notes(&rev.notes_opt);
 
-	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
-		die(_("options '%s', '%s', and '%s' cannot be used together"), "--stdout", "--output", "--output-directory");
+	die_for_incompatible_opt3(use_stdout, "--stdout",
+				  rev.diffopt.close_file, "--output",
+				  !!output_directory, "--output-directory");
 
 	if (use_stdout) {
 		setup_pager();
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 6719ac198dc..26b84980dbd 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -159,12 +159,14 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 		if (argc < 2)
 			usage_with_options(merge_base_usage, options);
 		if (show_all)
-			die("--is-ancestor cannot be used with --all");
+			die(_("options '%s' and '%s' cannot be used together"),
+			    "--is-ancestor", "--all");
 		return handle_is_ancestor(argc, argv);
 	}
 
 	if (cmdmode == 'r' && show_all)
-		die("--independent cannot be used with --all");
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--independent", "--all");
 
 	if (cmdmode == 'o')
 		return handle_octopus(argc, argv, show_all);
diff --git a/parse-options.c b/parse-options.c
index a8283037be9..276e3911a74 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1079,3 +1079,37 @@ void NORETURN usage_msg_opt(const char *msg,
 	die_message("%s\n", msg); /* The extra \n is intentional */
 	usage_with_options(usagestr, options);
 }
+
+void die_for_incompatible_opt4(int opt1, const char *opt1_name,
+			       int opt2, const char *opt2_name,
+			       int opt3, const char *opt3_name,
+			       int opt4, const char *opt4_name)
+{
+	int count = 0;
+	const char *options[4];
+
+	if (opt1)
+		options[count++] = opt1_name;
+	if (opt2)
+		options[count++] = opt2_name;
+	if (opt3)
+		options[count++] = opt3_name;
+	if (opt4)
+		options[count++] = opt4_name;
+	switch (count) {
+	case 4:
+		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"),
+		    opt1_name, opt2_name, opt3_name, opt4_name);
+		break;
+	case 3:
+		die(_("options '%s', '%s', and '%s' cannot be used together"),
+		    options[0], options[1], options[2]);
+		break;
+	case 2:
+		die(_("options '%s' and '%s' cannot be used together"),
+		    options[0], options[1]);
+		break;
+	default:
+		break;
+	}
+}
diff --git a/parse-options.h b/parse-options.h
index e22846d3b7b..68f7ae9c31a 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -225,6 +225,22 @@ NORETURN void usage_msg_opt(const char *msg,
 			    const char * const *usagestr,
 			    const struct option *options);
 
+void die_for_incompatible_opt4(int opt1, const char *opt1_name,
+			       int opt2, const char *opt2_name,
+			       int opt3, const char *opt3_name,
+			       int opt4, const char *opt4_name);
+
+
+inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
+				      int opt2, const char *opt2_name,
+				      int opt3, const char *opt3_name)
+{
+	die_for_incompatible_opt4(opt1, opt1_name,
+				  opt2, opt2_name,
+				  opt3, opt3_name,
+				  0, "");
+}
+
 /*
  * Use these assertions for callbacks that expect to be called with NONEG and
  * NOARG respectively, and do not otherwise handle the "unset" and "arg"
@@ -339,4 +355,5 @@ int parse_opt_tracking_mode(const struct option *, const char *, int);
 #define OPT_PATHSPEC_FILE_NUL(v)  OPT_BOOL(0, "pathspec-file-nul", v, N_("with --pathspec-from-file, pathspec elements are separated with NUL character"))
 #define OPT_AUTOSTASH(v) OPT_BOOL(0, "autostash", v, N_("automatically stash/stash pop before and after"))
 
+
 #endif
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 91964653a0b..5fcaa0b4f2a 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -442,7 +442,7 @@ test_expect_success '--fixup=reword: give error with pathsec' '
 '
 
 test_expect_success '--fixup=reword: -F give error message' '
-	echo "fatal: Only one of -c/-C/-F/--fixup can be used." >expect &&
+	echo "fatal: options '\''-F'\'' and '\''--fixup'\'' cannot be used together" >expect &&
 	test_must_fail git commit --fixup=reword:HEAD~ -F msg  2>actual &&
 	test_cmp expect actual
 '
-- 
gitgitgadget

