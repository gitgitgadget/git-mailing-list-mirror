Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C83C19F29
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 01:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiHDBqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 21:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbiHDBqH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 21:46:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5D35F137
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 18:46:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so1662409wmj.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 18:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=F+lS+Pmk1OaU9Cd2V+JhyD1ZsWXZ6h5pLvh6eyu9lYM=;
        b=mgZpzcRPYbPfm8Er0vB08bPCb/89cC1XQ/JZxZc8ZPTxOR9UO0fDQg91bburor0BS2
         RlN4xivOw6kmbGpo1mAmc/ruKKHO/cPKcXt4j4paNRAQPdBBbIK75eCz7VbDP1Woa22I
         Qp9OL7AM6t224GMN0m2329xKUrxlp8qhUPOKbCVUHdiZrdyT7uBvt41BPz3Iihr0ZjrA
         qcQHXcRlTwo3M8JCLJy+itpTSgGcVLm2CXEvyS8ydM8xD81WlBKKbjWW69Wky095P3lZ
         iG9brFd5FdgtR+3kVZFMgFwmbWZfHcOWgoERzwzSiJe8Q/pVtIVjGdEDaGVeQiLWRnPT
         u/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=F+lS+Pmk1OaU9Cd2V+JhyD1ZsWXZ6h5pLvh6eyu9lYM=;
        b=JwVf2bFiKz024CoHQvu5mbVt3y5Ygy4p5V6dm7yGmTSFZUvAgcsEZ34b/iVgk48TKF
         IZBnBEg1U3IUfC/J949Ifhi0wa/bCQCSK1gn9oWHAwlwkt4VXCHQl3kSsZyKHuCv0qL/
         sgL2DNnAh8ExDtcEP8nQHv/pFcvjdB4HgPkB9xQ504oKlPWS8nuDnT18EfyNYw+MB2qS
         tTsFTQwmOvQItepWO4UMvHGWGUWet9LU5CH6Uw7dh7EkYzG741F3Dljhku6HltiS4aAg
         fgi0gD1DkfiGuCCgEwPOjsFVNKCz2ySydX20KJMebgksMsVU0vckMg5OHBU0HDRyBjHo
         Kasg==
X-Gm-Message-State: ACgBeo3LWW3EvccB+EMyte1Qp48m8DactOhRK0Pa6TYB663zXVRiASzq
        AbaIzmtmHA/ONcRPCXAUGOAQLZGV66g=
X-Google-Smtp-Source: AA6agR54eh1IzA/EwiKZ44jFSMGKpeRw4wSreZmGxghRC0d2TxH5Wrj1L7BZYgauGtNhCbhhCDcKcw==
X-Received: by 2002:a1c:3846:0:b0:3a4:f574:aa36 with SMTP id f67-20020a1c3846000000b003a4f574aa36mr3805918wma.21.1659577560243;
        Wed, 03 Aug 2022 18:46:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd14-20020a05600c1f0e00b003a4eea0aa48sm4453538wmb.0.2022.08.03.18.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 18:45:59 -0700 (PDT)
Message-Id: <d81e7c10997e9e8dc211d241019fbafa6b25fb04.1659577543.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 01:45:41 +0000
Subject: [PATCH v2 08/10] builtin/bugreport.c: create '--diagnose' option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Create a '--diagnose' option for 'git bugreport' to collect additional
information about the repository and write it to a zipped archive.

The '--diagnose' option behaves effectively as an alias for simultaneously
running 'git bugreport' and 'git diagnose'. In the documentation, users are
explicitly recommended to attach the diagnostics alongside a bug report to
provide additional context to readers, ideally reducing some back-and-forth
between reporters and those debugging the issue.

Note that '--diagnose' may take an optional string arg (either 'basic' or
'all'). If specified without the arg or with 'basic', the behavior
corresponds to running 'git diagnose' without '--all'; this default is meant
to help reduce unintentional leaking of sensitive information). However, a
user can still manually specify '--diagnose=all' to generate the equivalent
archive to one created with 'git diagnose --all'.

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-bugreport.txt | 18 +++++++++++++
 builtin/bugreport.c             | 47 +++++++++++++++++++++++++++++++--
 t/t0091-bugreport.sh            | 44 ++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index d8817bf3cec..a4d984a77be 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
+		[--diagnose[=(basic|all)]]
 
 DESCRIPTION
 -----------
@@ -31,6 +32,10 @@ The following information is captured automatically:
  - A list of enabled hooks
  - $SHELL
 
+Additional information may be gathered into a separate zip archive using the
+`--diagnose` option, and can be attached alongside the bugreport document to
+provide additional context to readers.
+
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
 is unreadable. In this kind of scenario, it may be helpful to manually gather
@@ -49,6 +54,19 @@ OPTIONS
 	named 'git-bugreport-<formatted suffix>'. This should take the form of a
 	strftime(3) format string; the current local time will be used.
 
+--diagnose[=(basic|all)]::
+	Create a zip archive of information about the repository including logs
+	and certain statistics describing the data shape of the repository. The
+	archive is written to the same output directory as the bug report and is
+	named 'git-diagnostics-<formatted suffix>'.
++
+By default, `--diagnose` (equivalent to `--diagnose=basic`) will collect only
+statistics and summarized data about the repository and filesystem. Specifying
+`--diagnose=all` will create an archive with the same contents generated by `git
+diagnose --all`; this archive will be much larger, and will contain potentially
+sensitive information about the repository. See linkgit:git-diagnose[1] for more
+details on the contents of the diagnostic archive.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 9de32bc96e7..1907258d61d 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -5,7 +5,13 @@
 #include "compat/compiler.h"
 #include "hook.h"
 #include "hook-list.h"
+#include "diagnose.h"
 
+enum diagnose_mode {
+	DIAGNOSE_NONE,
+	DIAGNOSE_BASIC,
+	DIAGNOSE_ALL
+};
 
 static void get_system_info(struct strbuf *sys_info)
 {
@@ -91,6 +97,23 @@ static void get_header(struct strbuf *buf, const char *title)
 	strbuf_addf(buf, "\n\n[%s]\n", title);
 }
 
+static int option_parse_diagnose(const struct option *opt,
+				 const char *arg, int unset)
+{
+	enum diagnose_mode *diagnose = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (!arg || !strcmp(arg, "basic"))
+		*diagnose = DIAGNOSE_BASIC;
+	else if (!strcmp(arg, "all"))
+		*diagnose = DIAGNOSE_ALL;
+	else
+		die(_("diagnose mode must be either 'basic' or 'all'"));
+
+	return 0;
+}
+
 int cmd_bugreport(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buffer = STRBUF_INIT;
@@ -98,16 +121,21 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	int report = -1;
 	time_t now = time(NULL);
 	struct tm tm;
+	enum diagnose_mode diagnose = DIAGNOSE_NONE;
 	char *option_output = NULL;
 	char *option_suffix = "%Y-%m-%d-%H%M";
 	const char *user_relative_path = NULL;
 	char *prefixed_filename;
+	size_t output_path_len;
 
 	const struct option bugreport_options[] = {
+		OPT_CALLBACK_F(0, "diagnose", &diagnose, N_("(basic|all)"),
+			       N_("create an additional zip archive of detailed diagnostics"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, option_parse_diagnose),
 		OPT_STRING('o', "output-directory", &option_output, N_("path"),
-			   N_("specify a destination for the bugreport file")),
+			   N_("specify a destination for the bugreport file(s)")),
 		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
-			   N_("specify a strftime format suffix for the filename")),
+			   N_("specify a strftime format suffix for the filename(s)")),
 		OPT_END()
 	};
 
@@ -119,6 +147,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 					    option_output ? option_output : "");
 	strbuf_addstr(&report_path, prefixed_filename);
 	strbuf_complete(&report_path, '/');
+	output_path_len = report_path.len;
 
 	strbuf_addstr(&report_path, "git-bugreport-");
 	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
@@ -133,6 +162,20 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 		    report_path.buf);
 	}
 
+	/* Prepare diagnostics, if requested */
+	if (diagnose != DIAGNOSE_NONE) {
+		struct strbuf zip_path = STRBUF_INIT;
+		strbuf_add(&zip_path, report_path.buf, output_path_len);
+		strbuf_addstr(&zip_path, "git-diagnostics-");
+		strbuf_addftime(&zip_path, option_suffix, localtime_r(&now, &tm), 0, 0);
+		strbuf_addstr(&zip_path, ".zip");
+
+		if (create_diagnostics_archive(&zip_path, diagnose == DIAGNOSE_ALL))
+			die_errno(_("unable to create diagnostics archive %s"), zip_path.buf);
+
+		strbuf_release(&zip_path);
+	}
+
 	/* Prepare the report contents */
 	get_bug_template(&buffer);
 
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index 08f5fe9caef..1a63b3803f3 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -78,4 +78,48 @@ test_expect_success 'indicates populated hooks' '
 	test_cmp expect actual
 '
 
+test_expect_success UNZIP '--diagnose creates diagnostics zip archive' '
+	test_when_finished rm -rf report &&
+
+	git bugreport --diagnose -o report -s test >out &&
+
+	zip_path=report/git-diagnostics-test.zip &&
+	grep "Available space" out &&
+	test_path_is_file "$zip_path" &&
+
+	# Check zipped archive content
+	"$GIT_UNZIP" -p "$zip_path" diagnostics.log >out &&
+	test_file_not_empty out &&
+
+	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
+	grep ".git/objects" out &&
+
+	"$GIT_UNZIP" -p "$zip_path" objects-local.txt >out &&
+	grep "^Total: [0-9][0-9]*" out &&
+
+	# Should not include .git directory contents by default
+	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
+'
+
+test_expect_success UNZIP '--diagnose=basic excludes .git dir contents' '
+	test_when_finished rm -rf report &&
+
+	git bugreport --diagnose=basic -o report -s test >out &&
+
+	# Should not include .git directory contents
+	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
+'
+
+test_expect_success UNZIP '--diagnose=all includes .git dir contents' '
+	test_when_finished rm -rf report &&
+
+	git bugreport --diagnose=all -o report -s test >out &&
+
+	# Should include .git directory contents
+	"$GIT_UNZIP" -l "$zip_path" | grep ".git/" &&
+
+	"$GIT_UNZIP" -p "$zip_path" .git/HEAD >out &&
+	test_file_not_empty out
+'
+
 test_done
-- 
gitgitgadget

