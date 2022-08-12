Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB09C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 20:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbiHLUK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 16:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbiHLUKg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 16:10:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C6DBF70
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q30so2234058wra.11
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=mARxQC56HROeHfnGhKZI2tZ091Okd3Z5usLlYR6Qcug=;
        b=E25iyBYPgiMAkT28b3wtZ/e5hPa8+GEMpzXuQGvbkfb+C21Jc3OdMmicUK2+h8e/ZZ
         gCOaitR9QOJmPpuxF+Kdnk9gijzn3dqkN/ijWx1+pkbSUXEh8cVYo6N6X8ph7oHNIM+V
         MD4SzwKHOoa7NaREwgR7MGpC9pfsE3wj+RlBUmXAtEroezvglZbz8yr/iTRJsSX0xjs4
         G+YqG1ZwBHC2IIVgVpTDfs/A7E2NrZ9w9c2NMx+cLlORucNihYDkvGk4HU58Sosf3oAS
         njgGynm08SFuvVmpVW8X+q67MogPJhvmD6YzTUByg4Hro9LScpedKw4pxPWLMOe9wOH5
         WXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=mARxQC56HROeHfnGhKZI2tZ091Okd3Z5usLlYR6Qcug=;
        b=yxi1xIHMQ5WQQ3t+AxwSvIxYRKBdp6txiJYk6b1jsBSDUNdsk1kv8ZqaW7X8KVW9YO
         ptktBqeUTWDX8pVm0f1xwA/URtsEuF7l95IFL/Kne1a4v8/MHVun0hvClm1Pxt7ndX5j
         YL8IEXs3hfBvQmnWS3fEZXtvM6k9fwCQYttf5yyAVvMLsn2Bx82SQDLhIz8wJFrxObRQ
         J5k8fprYVyPbEK5zTxDrxtd+6tst50sqMtQiUxn3FBj9kKJUSfIbR24wBRCxVlrWWbba
         hgfV9KiOJLtY7XkDV6npFWC2wXYfF18qz8KQnqfJCaj5awf5ojFKmewkyjXlWp7ijLG+
         PJ7w==
X-Gm-Message-State: ACgBeo2uVL3T7purd9klCCiS3HGtV3Ip3cUsqIlSFseIhyvJzZlp9k97
        SNNjy4mpSEEA48ojj0bSftTLKzJS+Qo=
X-Google-Smtp-Source: AA6agR4YbplWWnjqOvbin+Zetilc2dlLASgl/o8yPbWZqrmByhchJcgsc4ujGPxatFXBGePEESInsw==
X-Received: by 2002:a05:6000:811:b0:220:6262:ac66 with SMTP id bt17-20020a056000081100b002206262ac66mr2809392wrb.529.1660335030055;
        Fri, 12 Aug 2022 13:10:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f4-20020a1c6a04000000b003a54f1d007csm534916wmc.10.2022.08.12.13.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 13:10:29 -0700 (PDT)
Message-Id: <718e3f434841ee4697a505d83f2e4acbeed364fd.1660335019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
        <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Aug 2022 20:10:17 +0000
Subject: [PATCH v4 09/11] builtin/bugreport.c: create '--diagnose' option
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

Note that '--diagnose' may take an optional string arg (either 'stats' or
'all'). If specified without the arg, the behavior corresponds to running
'git diagnose' without '--mode'. As with 'git diagnose', this default is
intended to help reduce unintentional leaking of sensitive information).
Users can also explicitly specify '--diagnose=(stats|all)' to generate the
respective archive created by 'git diagnose --mode=(stats|all)'.

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-bugreport.txt | 18 +++++++++++++
 builtin/bugreport.c             | 27 ++++++++++++++++---
 t/t0091-bugreport.sh            | 48 +++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index d8817bf3cec..eca726e5791 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
+		[--diagnose[=<mode>]]
 
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
 
+--no-diagnose::
+--diagnose[=<mode>]::
+	Create a zip archive of supplemental information about the user's
+	machine, Git client, and repository state. The archive is written to the
+	same output directory as the bug report and is named
+	'git-diagnostics-<formatted suffix>'.
++
+Without `mode` specified, the diagnostic archive will contain the default set of
+statistics reported by `git diagnose`. An optional `mode` value may be specified
+to change which information is included in the archive. See
+linkgit:git-diagnose[1] for the list of valid values for `mode` and details
+about their usage.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 9de32bc96e7..530895be55f 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -5,6 +5,7 @@
 #include "compat/compiler.h"
 #include "hook.h"
 #include "hook-list.h"
+#include "diagnose.h"
 
 
 static void get_system_info(struct strbuf *sys_info)
@@ -59,7 +60,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
+	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>] [--diagnose[=<mode>]"),
 	NULL
 };
 
@@ -98,16 +99,21 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
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
+		OPT_CALLBACK_F(0, "diagnose", &diagnose, N_("mode"),
+			       N_("create an additional zip archive of detailed diagnostics (default 'stats')"),
+			       PARSE_OPT_OPTARG, option_parse_diagnose),
 		OPT_STRING('o', "output-directory", &option_output, N_("path"),
-			   N_("specify a destination for the bugreport file")),
+			   N_("specify a destination for the bugreport file(s)")),
 		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
-			   N_("specify a strftime format suffix for the filename")),
+			   N_("specify a strftime format suffix for the filename(s)")),
 		OPT_END()
 	};
 
@@ -119,6 +125,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 					    option_output ? option_output : "");
 	strbuf_addstr(&report_path, prefixed_filename);
 	strbuf_complete(&report_path, '/');
+	output_path_len = report_path.len;
 
 	strbuf_addstr(&report_path, "git-bugreport-");
 	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
@@ -133,6 +140,20 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
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
+		if (create_diagnostics_archive(&zip_path, diagnose))
+			die_errno(_("unable to create diagnostics archive %s"), zip_path.buf);
+
+		strbuf_release(&zip_path);
+	}
+
 	/* Prepare the report contents */
 	get_bug_template(&buffer);
 
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index 08f5fe9caef..b6d2f591acd 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -78,4 +78,52 @@ test_expect_success 'indicates populated hooks' '
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
+test_expect_success UNZIP '--diagnose=stats excludes .git dir contents' '
+	test_when_finished rm -rf report &&
+
+	git bugreport --diagnose=stats -o report -s test >out &&
+
+	# Includes pack quantity/size info
+	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
+	grep ".git/objects" out &&
+
+	# Does not include .git directory contents
+	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
+'
+
+test_expect_success UNZIP '--diagnose=all includes .git dir contents' '
+	test_when_finished rm -rf report &&
+
+	git bugreport --diagnose=all -o report -s test >out &&
+
+	# Includes .git directory contents
+	"$GIT_UNZIP" -l "$zip_path" | grep ".git/" &&
+
+	"$GIT_UNZIP" -p "$zip_path" .git/HEAD >out &&
+	test_file_not_empty out
+'
+
 test_done
-- 
gitgitgadget

