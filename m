Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B66CC00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 20:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiHLULB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 16:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbiHLUKg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 16:10:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C472DB1C7
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z16so2233733wrh.12
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=pj2xyvIUYdcDH2UsS/0PcbbfCcss9zcoh3OIoFN9ukY=;
        b=gG1KVkd3Sdva0m5hvGfJLEFyzSZVAF+ipX/w+fjThLV/6yQOktH258t9WJZ7L3iTzd
         txPaW30iW6Ld+s7OnpZzVxAG7N/KrZg692Oes76u5ypqvVVNcPVhWLmK4Yrit+tnQn6a
         JSyAk0SfVyAXLfO+oMl7Tu5zt510zkcjI4/NszjP25dePRkNmU3wiD2HObLf6BiuRd0n
         xBKA9du8MulEFDAxMkCcP+/nzD1m2gFpsDvnlKU1+vWRsHDxfXv7Qy11NLC7sYB2JCDs
         rlhle6OkirLC+DP/cH0AenVwN/BPynzEbzZ46gP+o/ngUyzFkdNYnQGjYW399kASUo4O
         qiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=pj2xyvIUYdcDH2UsS/0PcbbfCcss9zcoh3OIoFN9ukY=;
        b=2fVnlHEmRIz2XKOuCyruddTpSezqBOuie19TsjU/cJelzU6HFkngDJWb70Jk4jdaAO
         BDxEXPeEYwhvqDra+MZYBDDWnAiRhoqJ6ykxxYwNXEJjSeHum7sbJkVAGSQT1wUoQTvi
         YqUlyM+stu5UN6URj3ewxDyPAgwb4SxSxkroWyalz67nHFMSRXeVBX4KsiISyE1JbCEV
         xcP8vVtBNcm2Ji/pdzb/Ik55SuuYdPBM3HXHLySnH1cquMg1ob/LsYKE9nneQgu17bit
         09Sj30hxvr+7UwT4M8IGXylmLNZV+Bbugp0hhCyeHLgasB154QvAu2X8vbwKpNMpoZBb
         AlMA==
X-Gm-Message-State: ACgBeo1TCEW8KY4uQD4uiYUghfjmZ4ZMKOsAa/hxaP6hHqsk1s8aR1Ww
        hhSEi5OE5fzbxPfkLXdpjwmiTLt0w7c=
X-Google-Smtp-Source: AA6agR7HQI4BL9/mSlTagcio+5Iiral4JVVPMedcneSmgAtJ3whKayEO+iqWV3/4f7tp6rgqdx1d+Q==
X-Received: by 2002:a5d:5223:0:b0:21e:fc10:b818 with SMTP id i3-20020a5d5223000000b0021efc10b818mr2976554wra.676.1660335029016;
        Fri, 12 Aug 2022 13:10:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j36-20020a05600c1c2400b003a4c6e67f01sm594523wms.6.2022.08.12.13.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 13:10:28 -0700 (PDT)
Message-Id: <82be069e5e965c7193f15bb38ef523dc4b7b3592.1660335019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
        <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Aug 2022 20:10:16 +0000
Subject: [PATCH v4 08/11] builtin/diagnose.c: add '--mode' option
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
 diagnose.h                     |  3 +++
 t/t0092-diagnose.sh            | 30 +++++++++++++++++++++++++++++-
 5 files changed, 84 insertions(+), 4 deletions(-)

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
index 9270056db2f..beb0a8741ba 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -13,6 +13,36 @@ struct archive_dir {
 	int recursive;
 };
 
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
index 998775857a0..7a4951a7863 100644
--- a/diagnose.h
+++ b/diagnose.h
@@ -2,6 +2,7 @@
 #define DIAGNOSE_H
 
 #include "strbuf.h"
+#include "parse-options.h"
 
 enum diagnose_mode {
 	DIAGNOSE_NONE,
@@ -9,6 +10,8 @@ enum diagnose_mode {
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

