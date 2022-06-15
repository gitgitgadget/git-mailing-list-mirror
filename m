Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAC6C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 13:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349010AbiFONqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345980AbiFONqA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 09:46:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700CE3631D
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 06:45:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso1151736wmc.4
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7/vAO19gmzQ/Zx+pfQQA3q44oXbvUGM07P1kiyB7n6s=;
        b=cT0utbXuems+f2UQfisB2GXDBKDTZzmBqc/5VEOLcWf6MymMyzEN16qVOKTy0b9JrN
         JIunuFN+uAL0bFoDCwfHMdhQ5c7btrM11c5qyUWLxxI/tVYk1KNoCW75zPQyOukXZGVN
         wbK5j2bL68B6EnYoBkBA0y2QnNa535l7/H/yKhWY7X+GO2Xl8Sb19ACJLKA/ZGrM/LES
         aT0G05Se31QwvTOXx/E/KNeX3HLWgB7TFELmuF80lTQLn1pqCuPspWN4y0T3fu4LurSL
         c3JtlHysSPWj3EHja4ECNMxbvVlTRT0oreUwl4pH/NumPP7QlzwVKEC7SP8ZeMumTxKO
         jIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7/vAO19gmzQ/Zx+pfQQA3q44oXbvUGM07P1kiyB7n6s=;
        b=kTWPX6eD+PkT+uIfcEdOn7hst3LdWQtxRS+0JvKosreTO6fvLMvb3hO6YFVSF3+1Bs
         XnRQjDu5vOse0+scf7xBCKRmwAcME1nRTAkrgJeXCRuFeAIB1f/tg2WaEgQ45MCvBVjD
         mHoJaMGmWqH4oSlcJSMxG+kxLnbCQ3b/AafmWfna2g7aNLVKyt7uC/Ri7NbtlhBj426X
         MfoQytDxDfqCZ+MmUmA0TFez8bYQoWJNsRAeSP9fLbcyGGGHA2OQ1t3oo2+jHE89voWl
         kAXanSVa9iTrPsE+57I8BX7Pd7+951aPiLlDyJ5KbWD+MNJN0tbxI9XcwaGJJLJiKON4
         hLXw==
X-Gm-Message-State: AOAM531pZJMZjd0zrECigovMmN8bd4EKPbr/XFl0MIUjmmsnELJdU+zB
        2qibxMQAeV1Lo6BWVHB3KxPorlCVlKdKaw==
X-Google-Smtp-Source: ABdhPJx6tMCAO3z982AeZUQpPXt7N1ew7RCqi2DgtMcFdzsv/CLJ6SYeHNn+wqW+mOLT5iXyXxnuug==
X-Received: by 2002:a1c:ed08:0:b0:39c:80b1:b0b3 with SMTP id l8-20020a1ced08000000b0039c80b1b0b3mr10074279wmh.134.1655300757545;
        Wed, 15 Jun 2022 06:45:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9-20020adffd89000000b002102d4ed579sm14401866wrr.39.2022.06.15.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 06:45:56 -0700 (PDT)
Message-Id: <81ae1280e8eb471c7a11dceb0aa7a8915948b2ce.1655300752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1262.git.1655300752.gitgitgadget@gmail.com>
References: <pull.1262.git.1655300752.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 13:45:52 +0000
Subject: [PATCH 2/2] ls-files: introduce "--object-only" option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

--object-only is an alias for --format=%(objectname),
which output objectname of index entries, taking
inspiration from the option with the same name in
the `git ls-tree` command.

--object-only cannot be used with --format, and -s, -o,
-k, --resolve-undo, --deduplicate, --debug.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-ls-files.txt |  8 +++++++-
 builtin/ls-files.c             | 36 +++++++++++++++++++++++++++++++++-
 t/t3013-ls-files-format.sh     | 34 ++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index b22860ec8c0..c3f46bb821b 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 		[-c|--cached] [-d|--deleted] [-o|--others] [-i|--|ignored]
 		[-s|--stage] [-u|--unmerged] [-k|--|killed] [-m|--modified]
 		[--directory [--no-empty-directory]] [--eol]
-		[--deduplicate]
+		[--deduplicate] [--object-only]
 		[-x <pattern>|--exclude=<pattern>]
 		[-X <file>|--exclude-from=<file>]
 		[--exclude-per-directory=<file>]
@@ -199,6 +199,12 @@ followed by the  ("attr/<eolattr>").
 	interpolates to `\0` (NUL), `%09` to `\t` (TAB) and %0a to `\n` (LF).
 	--format cannot be combined with `-s`, `-o`, `-k`, `--resolve-undo`,
 	`--debug`.
+
+--object-only::
+	List only names of the objects, one per line. This is equivalent
+	to specifying `--format='%(objectname)'`. Cannot be combined with
+	`--format=<format>`.
+
 \--::
 	Do not interpret any more arguments as options.
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 9dd6c55eeb9..4ac8f34baac 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -60,6 +60,27 @@ static const char *tag_modified = "";
 static const char *tag_skip_worktree = "";
 static const char *tag_resolve_undo = "";
 
+static enum ls_files_cmdmode {
+	MODE_DEFAULT = 0,
+	MODE_OBJECT_ONLY,
+} ls_files_cmdmode;
+
+struct ls_files_cmdmodee_to_fmt {
+	enum ls_files_cmdmode mode;
+	const char *const fmt;
+};
+
+static struct ls_files_cmdmodee_to_fmt ls_files_cmdmode_format[] = {
+	{
+		.mode = MODE_DEFAULT,
+		.fmt = NULL,
+	},
+	{
+		.mode = MODE_OBJECT_ONLY,
+		.fmt = "%(objectname)",
+	},
+};
+
 static void write_eolinfo_internal(struct strbuf *sb, struct index_state *istate,
 				   const struct cache_entry *ce, const char *path)
 {
@@ -747,6 +768,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			DIR_SHOW_IGNORED),
 		OPT_BOOL('s', "stage", &show_stage,
 			N_("show staged contents' object name in the output")),
+		OPT_CMDMODE(0, "object-only", &ls_files_cmdmode, N_("list only objects"),
+			    MODE_OBJECT_ONLY),
 		OPT_BOOL('k', "killed", &show_killed,
 			N_("show files on the filesystem that need to be removed")),
 		OPT_BIT(0, "directory", &dir.flags,
@@ -815,9 +838,20 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args);
 	}
 
+	if (format && ls_files_cmdmode)
+		die(_("--format can't be combined with other format-altering options"));
+
+	for (i = 0; !format && i < ARRAY_SIZE(ls_files_cmdmode_format); i++) {
+		if (ls_files_cmdmode == ls_files_cmdmode_format[i].mode) {
+			format = ls_files_cmdmode_format[i].fmt;
+			break;
+		}
+	}
+
 	if (format && (show_stage || show_others || show_killed ||
 		show_resolve_undo || skipping_duplicates || debug_mode))
-			die(_("ls-files --format cannot used with -s, -o, -k, --resolve-undo, --deduplicate, --debug"));
+		die(_("ls-files --format or other format-altering options "
+		      "cannot used with -s, -o, -k, --resolve-undo, --deduplicate, --debug"));
 
 	if (show_tag || show_valid_bit || show_fsmonitor_bit) {
 		tag_cached = "H ";
diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
index 61a2e68713a..1c982ea13e0 100755
--- a/t/t3013-ls-files-format.sh
+++ b/t/t3013-ls-files-format.sh
@@ -139,4 +139,38 @@ test_expect_success 'git ls-files --format with --debug must fail' '
 	test_must_fail git ls-files --format="%(objectname)" --debug
 '
 
+test_expect_success 'git ls-files --object-only equal to --format=%(objectname)' '
+	git ls-files --format="%(objectname)" >expect &&
+	git ls-files --object-only >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --object-only with --format must fail' '
+	test_must_fail git ls-files --format="%(path)" --object-only
+'
+
+test_expect_success 'git ls-files --object-only with -s must fail' '
+	test_must_fail git ls-files --object-only -s
+'
+
+test_expect_success 'git ls-files --object-only with -o must fail' '
+	test_must_fail git ls-files --object-only -o
+'
+
+test_expect_success 'git ls-files --object-only with -k must fail' '
+	test_must_fail git ls-files --object-only -k
+'
+
+test_expect_success 'git ls-files --object-only with --resolve-undo must fail' '
+	test_must_fail git ls-files --object-only --resolve-undo
+'
+
+test_expect_success 'git ls-files --object-only with --deduplicate must fail' '
+	test_must_fail git ls-files --object-only --deduplicate
+'
+
+test_expect_success 'git ls-files --object-only with --debug must fail' '
+	test_must_fail git ls-files --object-only --debug
+'
+
 test_done
-- 
gitgitgadget
