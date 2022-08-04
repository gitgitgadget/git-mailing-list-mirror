Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C3CC19F29
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 01:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbiHDBqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 21:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbiHDBqH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 21:46:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AB65F12C
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 18:46:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j1so15193390wrw.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 18:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nYOsX9F7nY0Ed+IrZo8eRTVn9kyWPOsEaMyLyr8CXq8=;
        b=ZwoEgWRezg0z7agWalXKXZT6neldYaUbUh+zktvNzBtv9Ax5cww2gg/r4dz5OmUi2M
         nko1HmMEsW6WfZU3v8jbq1gueIQPBIHN/LdRN55VAvX0MXFQJWbFb89dhw12a9DUxspR
         ay0b2iOxqgSETpID+i1g0gsu3+FYfmNAXzK/mwUDmmYlnI7QRVYQYXTVHLnoiIIG3kJu
         ivoLvk0ZHhP+ckRziMXrYE2xdl6rT+xWeSqjZJqZbF8FemSLgJsGniZSblKAvxxPSraX
         +t9PdBaNsfsW9UcYvznwNuLb9v/SBNdzsKl9yYgO+IvGzoV+UUwxAjd/llZGHLFUuwwq
         Phjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nYOsX9F7nY0Ed+IrZo8eRTVn9kyWPOsEaMyLyr8CXq8=;
        b=L0ZUWwCh3g3HWExnKpzS+jX+deybXrZ9oMBNqvB6GqGPWHuzCKGRXDoaDxjPixt39g
         L4OcfMCBQLm1H4+ww67APMmvOeM4EKQ8XMb7qYu73r12eT6Q+UX2OVOCxsanhgi+oBUV
         lhfgoqa7LIwkv7vSQmvGViyJR9ekR3TTPOa2vrj1Yu64FkjEft8jSYMBYirQsrZs29FW
         evPniQoESj7I2wAKj81FieoaCx99ExBFvX+Dk1glYG3XhfYnAaXc+dXlGlnWd+vND01h
         TNxUKU6jvSRXTXzDGOvIuosY0fQhJ5n10eQn0V8ehGrpEK4+ncEBM05pD3BUn/fn1v+o
         aWBw==
X-Gm-Message-State: ACgBeo3OSin84BQGntNCFg1jNAvWd58cxl081ZUaBto6jaqiNXinMHDN
        X0dHHrWhMCcNHzSimnGvPCVdO8tE7KE=
X-Google-Smtp-Source: AA6agR5u9AODFBSyT6Z+nxBT9ymqDzQD8QJMzdgo87hizJmQhKn2u2dExnbrzcJm/xN6fh8H2QhRBg==
X-Received: by 2002:a05:6000:1a8e:b0:21d:a7a8:54f4 with SMTP id f14-20020a0560001a8e00b0021da7a854f4mr17782035wry.654.1659577558790;
        Wed, 03 Aug 2022 18:45:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003a4c6e67f01sm4408845wmz.6.2022.08.03.18.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 18:45:58 -0700 (PDT)
Message-Id: <a3e62a4a0418abbff5015302f0102ffacccf0ca4.1659577543.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 01:45:40 +0000
Subject: [PATCH v2 07/10] builtin/diagnose.c: gate certain data behind '--all'
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

Update 'git diagnose' to *not* include '.git/' directory contents by
default, instead requiring specification of a '--all' option to include it.
While helpful for debugging, the archived '.git/' directory contents may be
sensitive, as they can be used to reconstruct an entire repository.

To guard against users inadvertently including this information in
diagnostics and sharing it (e.g., with the mailing list), '.git/' directory
contents will only be included if '--all' is specified.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-diagnose.txt | 12 ++++++++++--
 builtin/diagnose.c             |  8 ++++++--
 contrib/scalar/scalar.c        |  2 +-
 diagnose.c                     | 14 ++++++++------
 diagnose.h                     |  2 +-
 t/t0092-diagnose.sh            | 17 ++++++++++++++++-
 6 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-diagnose.txt b/Documentation/git-diagnose.txt
index b12ef98f013..374b7402511 100644
--- a/Documentation/git-diagnose.txt
+++ b/Documentation/git-diagnose.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git diagnose' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
+	       [-a | --all]
 
 DESCRIPTION
 -----------
@@ -26,8 +27,6 @@ The following information is captured in the archive:
     stores
   * The total count of loose objects, as well as counts broken down by
     `.git/objects` subdirectory
-  * The contents of the `.git`, `.git/hooks`, `.git/info`, `.git/logs`, and
-    `.git/objects/info` directories
 
 This tool differs from linkgit:git-bugreport[1] in that it collects much more
 detailed information with a greater focus on reporting the size and data shape
@@ -47,6 +46,15 @@ OPTIONS
 	form of a strftime(3) format string; the current local time will be
 	used.
 
+-a::
+--all::
+	Include more complete repository diagnostic information in the archive.
+	Specifically, this will add copies of `.git`, `.git/hooks`, `.git/info`,
+	`.git/logs`, and `.git/objects/info` directories to the output archive.
+	This additional data may be sensitive; a user can reconstruct the full
+	contents of the diagnosed repository with this information. Users should
+	exercise caution when sharing an archive generated with this option.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index c545c6bae1d..0a2a63fdfbc 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -4,7 +4,7 @@
 
 
 static const char * const diagnose_usage[] = {
-	N_("git diagnose [-o|--output-directory <file>] [-s|--suffix <format>]"),
+	N_("git diagnose [-o|--output-directory <file>] [-s|--suffix <format>] [-a|--all]"),
 	NULL
 };
 
@@ -13,6 +13,7 @@ int cmd_diagnose(int argc, const char **argv, const char *prefix)
 	struct strbuf zip_path = STRBUF_INIT;
 	time_t now = time(NULL);
 	struct tm tm;
+	int include_everything = 0;
 	char *option_output = NULL;
 	char *option_suffix = "%Y-%m-%d-%H%M";
 	char *prefixed_filename;
@@ -22,6 +23,9 @@ int cmd_diagnose(int argc, const char **argv, const char *prefix)
 			   N_("specify a destination for the diagnostics archive")),
 		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
 			   N_("specify a strftime format suffix for the filename")),
+		OPT_BOOL_F('a', "all", &include_everything,
+			   N_("collect complete diagnostic information"),
+			   PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -48,7 +52,7 @@ int cmd_diagnose(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Prepare diagnostics */
-	if (create_diagnostics_archive(&zip_path))
+	if (create_diagnostics_archive(&zip_path, include_everything))
 		die_errno(_("unable to create diagnostics archive %s"),
 			  zip_path.buf);
 
diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 3983def760a..b10955531ce 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -534,7 +534,7 @@ static int cmd_diagnose(int argc, const char **argv)
 		goto diagnose_cleanup;
 	}
 
-	res = create_diagnostics_archive(&zip_path);
+	res = create_diagnostics_archive(&zip_path, 1);
 
 diagnose_cleanup:
 	strbuf_release(&zip_path);
diff --git a/diagnose.c b/diagnose.c
index 6c3774afb19..6be53d7a1f8 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -131,7 +131,7 @@ static int add_directory_to_archiver(struct strvec *archiver_args,
 	return res;
 }
 
-int create_diagnostics_archive(struct strbuf *zip_path)
+int create_diagnostics_archive(struct strbuf *zip_path, int include_everything)
 {
 	struct strvec archiver_args = STRVEC_INIT;
 	char **argv_copy = NULL;
@@ -176,11 +176,13 @@ int create_diagnostics_archive(struct strbuf *zip_path)
 	loose_objs_stats(&buf, ".git/objects");
 	strvec_push(&archiver_args, buf.buf);
 
-	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
-	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
-	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
-	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
-	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
+	/* Only include this if explicitly requested */
+	if (include_everything &&
+	    ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
+	     (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
+	     (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
+	     (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
+	     (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0))))
 		goto diagnose_cleanup;
 
 	strvec_pushl(&archiver_args, "--prefix=",
diff --git a/diagnose.h b/diagnose.h
index e86e8a3c962..c0c5daf65e7 100644
--- a/diagnose.h
+++ b/diagnose.h
@@ -4,6 +4,6 @@
 #include "cache.h"
 #include "strbuf.h"
 
-int create_diagnostics_archive(struct strbuf *zip_path);
+int create_diagnostics_archive(struct strbuf *zip_path, int include_everything);
 
 #endif /* DIAGNOSE_H */
diff --git a/t/t0092-diagnose.sh b/t/t0092-diagnose.sh
index fa05bf6046f..3c808698d3f 100755
--- a/t/t0092-diagnose.sh
+++ b/t/t0092-diagnose.sh
@@ -22,7 +22,22 @@ test_expect_success UNZIP 'creates diagnostics zip archive' '
 	grep ".git/objects" out &&
 
 	"$GIT_UNZIP" -p "$zip_path" objects-local.txt >out &&
-	grep "^Total: [0-9][0-9]*" out
+	grep "^Total: [0-9][0-9]*" out &&
+
+	# Should not include .git directory contents
+	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
+'
+
+test_expect_success UNZIP '--all includes .git data in archive' '
+	test_when_finished rm -rf report &&
+
+	git diagnose -o report -s test --all >out &&
+
+	# Should include .git directory contents
+	"$GIT_UNZIP" -l "$zip_path" | grep ".git/" &&
+
+	"$GIT_UNZIP" -p "$zip_path" .git/HEAD >out &&
+	test_file_not_empty out
 '
 
 test_done
-- 
gitgitgadget

