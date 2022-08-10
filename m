Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A47C25B07
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 23:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiHJXfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 19:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbiHJXe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 19:34:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A3B86C19
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:43 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q30so19453126wra.11
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=QCIe/iFEAPCB2qM30bEnNTvDDykjX+xy4qW2EWl808E=;
        b=XspUrzLNJNB89t3JTa95Q3GW0O9+tnT1Eb69NV43rePTS8REpJc6mQVryTrRqlSJxN
         qMf0YSOL7AP9l4Wsj+4u+L1Y6lGesPyyt10KLawJ/W07bM1zoTpDTkjUZ8PbWXyZMxM8
         8A0yQ3nPjokGcrzAW86W8gidw/ua81B5xYHfrDDaJD7i4/5NY7Tj+9y3jwbJ37vD0QuH
         cDzzKXqOwGBcYVPqCLW0jctOL4g8fzUs0QTkyGbEHdzHPS21n4fO4bmrDUxl9jdZsEfo
         42cHOAs8lYor4kYCKV/Wg/eMZggkZy2c7FMYrWJPJpQ2UwFxCo2jKlLRSy4+u6vqnOSK
         tHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=QCIe/iFEAPCB2qM30bEnNTvDDykjX+xy4qW2EWl808E=;
        b=PKIY6cOE1cG3rI64RMtWtbkyq880omb0Pev4SrGmsw+LWDtuOcQPQLwxZGrmHrwR1p
         Km1APhGMA5MKi/85VODpOFDDDjZ/cJz7AexMcFLC3sPKUBUIo4KjJgmTCuUZtdF8WTnt
         s0xRuCUYuT3qu2NoL5jhPnihcIsm2dDJqTtek38X8y25psknu8+88bxOdgIk7IgrypD4
         /G92nyQHv5lBDPIx44Vi5NRyZSxlWbsFVeKz8C0z+y9fTuIJikCKyFFUDHb1EmNFehii
         rNxWqxyxugEFXyVo2WvCHjWm7OsxCIOV18IPEzptzo0AO5/1/aAofTV6EuTvq/7Iybeo
         bEfw==
X-Gm-Message-State: ACgBeo0Y4htJ/SvzTgTNhI5TVrU4hNFQqYoBLHe6nnjplfUZ4pjBUOhc
        EC6YP8jZt6VG3z/vFZZc8LxPZMOf8sY=
X-Google-Smtp-Source: AA6agR5Ufu7LYppXTrsOLcKO09KaP79hAVPTMdvUtB8hC0oqFCy6fn+NjXEzOZ4mz0Vl7WATpzKX6Q==
X-Received: by 2002:adf:d1e2:0:b0:223:611b:3f18 with SMTP id g2-20020adfd1e2000000b00223611b3f18mr7523189wrd.236.1660174481587;
        Wed, 10 Aug 2022 16:34:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l25-20020a1ced19000000b003a502c23f2asm3706292wmh.16.2022.08.10.16.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:34:41 -0700 (PDT)
Message-Id: <3da0cb725c927d08dd9486286e06bdb76896f5b7.1660174473.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
        <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 23:34:30 +0000
Subject: [PATCH v3 08/11] builtin/diagnose.c: add '--mode' option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Create '--mode=<mode>' option in 'git diagnose' to allow users to optionally
select non-default diagnostic information to include in the output archive.
Additionally, document the currently-available modes, emphasizing the
importance of not sharing a '--mode=all' archive publicly due to the
presence of sensitive information.

Note that the option parsing callback - 'option_parse_diagnose()' - is added
to 'diagnose.c' rather than 'builtin/diagnose.c' so that it may be reused in
future callers configuring a diagnostics archive.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-diagnose.txt | 17 ++++++++++++++++-
 builtin/diagnose.c             |  8 ++++++--
 diagnose.c                     | 30 ++++++++++++++++++++++++++++++
 diagnose.h                     |  2 ++
 t/t0092-diagnose.sh            | 30 +++++++++++++++++++++++++++++-
 5 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-diagnose.txt b/Documentation/git-diagnose.txt
index ce07dd0725d..3ec8cc7ad72 100644
--- a/Documentation/git-diagnose.txt
+++ b/Documentation/git-diagnose.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git diagnose' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
+	       [--mode=<mode>]
 
 DESCRIPTION
 -----------
@@ -17,7 +18,7 @@ repository state and packages that information into a zip archive. The
 generated archive can then, for example, be shared with the Git mailing list to
 help debug an issue or serve as a reference for independent debugging.
 
-The following information is captured in the archive:
+By default, the following information is captured in the archive:
 
   * 'git version --build-options'
   * The path to the repository root
@@ -27,6 +28,9 @@ The following information is captured in the archive:
   * The total count of loose objects, as well as counts broken down by
     `.git/objects` subdirectory
 
+Additional information can be collected by selecting a different diagnostic mode
+using the `--mode` option.
+
 This tool differs from linkgit:git-bugreport[1] in that it collects much more
 detailed information with a greater focus on reporting the size and data shape
 of repository contents.
@@ -45,6 +49,17 @@ OPTIONS
 	form of a strftime(3) format string; the current local time will be
 	used.
 
+--mode=(stats|all)::
+	Specify the type of diagnostics that should be collected. The default behavior
+	of 'git diagnose' is equivalent to `--mode=stats`.
++
+The `--mode=all` option collects everything included in `--mode=stats`, as well
+as copies of `.git`, `.git/hooks`, `.git/info`, `.git/logs`, and
+`.git/objects/info` directories. This additional information may be sensitive,
+as it can be used to reconstruct the full contents of the diagnosed repository.
+Users should exercise caution when sharing an archive generated with
+`--mode=all`.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index 832493bba65..cd260c20155 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -3,7 +3,7 @@
 #include "diagnose.h"
 
 static const char * const diagnose_usage[] = {
-	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>]"),
+	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>] [--mode=<mode>]"),
 	NULL
 };
 
@@ -12,6 +12,7 @@ int cmd_diagnose(int argc, const char **argv, const char *prefix)
 	struct strbuf zip_path = STRBUF_INIT;
 	time_t now = time(NULL);
 	struct tm tm;
+	enum diagnose_mode mode = DIAGNOSE_STATS;
 	char *option_output = NULL;
 	char *option_suffix = "%Y-%m-%d-%H%M";
 	char *prefixed_filename;
@@ -21,6 +22,9 @@ int cmd_diagnose(int argc, const char **argv, const char *prefix)
 			   N_("specify a destination for the diagnostics archive")),
 		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
 			   N_("specify a strftime format suffix for the filename")),
+		OPT_CALLBACK_F(0, "mode", &mode, N_("(stats|all)"),
+			       N_("specify the content of the diagnostic archive"),
+			       PARSE_OPT_NONEG, option_parse_diagnose),
 		OPT_END()
 	};
 
@@ -47,7 +51,7 @@ int cmd_diagnose(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Prepare diagnostics */
-	if (create_diagnostics_archive(&zip_path, DIAGNOSE_STATS))
+	if (create_diagnostics_archive(&zip_path, mode))
 		die_errno(_("unable to create diagnostics archive %s"),
 			  zip_path.buf);
 
diff --git a/diagnose.c b/diagnose.c
index aadc3d4b21f..00c3e9438e2 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -8,6 +8,36 @@
 #include "object-store.h"
 #include "packfile.h"
 
+struct diagnose_option {
+	enum diagnose_mode mode;
+	const char *option_name;
+};
+
+static struct diagnose_option diagnose_options[] = {
+	{ DIAGNOSE_STATS, "stats" },
+	{ DIAGNOSE_ALL, "all" },
+};
+
+int option_parse_diagnose(const struct option *opt, const char *arg, int unset)
+{
+	int i;
+	enum diagnose_mode *diagnose = opt->value;
+
+	if (!arg) {
+		*diagnose = unset ? DIAGNOSE_NONE : DIAGNOSE_STATS;
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(diagnose_options); i++) {
+		if (!strcmp(arg, diagnose_options[i].option_name)) {
+			*diagnose = diagnose_options[i].mode;
+			return 0;
+		}
+	}
+
+	return error(_("invalid --%s value '%s'"), opt->long_name, arg);
+}
+
 static void dir_file_stats_objects(const char *full_path, size_t full_path_len,
 				   const char *file_name, void *data)
 {
diff --git a/diagnose.h b/diagnose.h
index 9bb6049bf0c..7a4951a7863 100644
--- a/diagnose.h
+++ b/diagnose.h
@@ -10,6 +10,8 @@ enum diagnose_mode {
 	DIAGNOSE_ALL
 };
 
+int option_parse_diagnose(const struct option *opt, const char *arg, int unset);
+
 int create_diagnostics_archive(struct strbuf *zip_path, enum diagnose_mode mode);
 
 #endif /* DIAGNOSE_H */
diff --git a/t/t0092-diagnose.sh b/t/t0092-diagnose.sh
index b6923726fd7..fca9b58489c 100755
--- a/t/t0092-diagnose.sh
+++ b/t/t0092-diagnose.sh
@@ -26,7 +26,35 @@ test_expect_success UNZIP 'creates diagnostics zip archive' '
 
 	# Should not include .git directory contents by default
 	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
-	grep "^Total: [0-9][0-9]*" out
+'
+
+test_expect_success UNZIP '--mode=stats excludes .git dir contents' '
+	test_when_finished rm -rf report &&
+
+	git diagnose -o report -s test --mode=stats >out &&
+
+	# Includes pack quantity/size info
+	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
+	grep ".git/objects" out &&
+
+	# Does not include .git directory contents
+	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
+'
+
+test_expect_success UNZIP '--mode=all includes .git dir contents' '
+	test_when_finished rm -rf report &&
+
+	git diagnose -o report -s test --mode=all >out &&
+
+	# Includes pack quantity/size info
+	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
+	grep ".git/objects" out &&
+
+	# Includes .git directory contents
+	"$GIT_UNZIP" -l "$zip_path" | grep ".git/" &&
+
+	"$GIT_UNZIP" -p "$zip_path" .git/HEAD >out &&
+	test_file_not_empty out
 '
 
 test_done
-- 
gitgitgadget

