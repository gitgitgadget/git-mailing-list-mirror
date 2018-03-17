Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17CBA1F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbeCQH4O (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:56:14 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40039 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752564AbeCQH4M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:56:12 -0400
Received: by mail-lf0-f66.google.com with SMTP id e5-v6so14500866lfb.7
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XauPUOfulmqbYyAM8Df2LIbvTGubIOL4sW/FyTBHGqw=;
        b=KbzuOmEGGIL1CQCAXn3BOs1w0lmJcFL5beMYW0sKPYiDCBsh3Cm81pPEorib5ncj4S
         DhOJ7F5JQ75ka/+Qvn8tS4EkF/6UZj9/1xURaWdndWGL4eSxynm7T2VW8P5ZYg2mMgyZ
         1rCc+6S2dwTKe0m5A1/WPD/VzcYuBOPJNGZ6bDQQ0gMiHhWmWnmE+cX5k9gSxjpqGB8V
         HLSu8Shf8+7L75KGfvdvzrpmMmIpHSnMiq50a6ZjBCYraOyj2ktMTEnABKehDpU9ZV9S
         Bw0syOnZjYDICqGi3AA2PEbfd0lYgLE424Dv9AzL1SrMIPPYi+ROQeFtRsVxt3REmnwV
         +xDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XauPUOfulmqbYyAM8Df2LIbvTGubIOL4sW/FyTBHGqw=;
        b=T0gvltST/DXqWzTa1qv7GdxCYUZFELXhquPEFPiRHQSZ4tPc2g8x76YDHH9og+XVIc
         YEiccQe98P0ND3ahWiAztj8fkpnq8/qjZjxpPWLMNI/+04nA0q1EHzA1W3jVe1DYJECl
         cFF4voSakrYTX1XdYAfsIXOn2CIN5Swr7W4jKeOd1aH5yBrmevbQ0RqGML4CK3enKluL
         4953zgKzc1hUq2E7B9jNpxzNWMg4SwUx9FaNq06zd6/2XNjPOvlmN3ohIpXSocFSTeQy
         4u6tEk6CbhHUV0iYsgDKu8hC0fWGyHxlxjgeRxR0WtWWE1WYo3HAT/ud9sMbydT8OROt
         Z2fQ==
X-Gm-Message-State: AElRT7HLyPDLVWYn+vjbNReVNBmSXFV+FZjIYzqGyIxrgbJ83HdFZOin
        4K50HeFtxHGIbS3WC5mvhPDcNQ==
X-Google-Smtp-Source: AG47ELu95NNS8Ki9sfG7RtJE8CLODJBg0orz6Prcq2AY5clqbq0fLqU01JM6X3hDydmMEHfPfnBqfA==
X-Received: by 10.46.129.215 with SMTP id s23mr3411811ljg.102.1521273370236;
        Sat, 17 Mar 2018 00:56:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:56:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 35/36] t/helper: merge test-wildmatch into test-tool
Date:   Sat, 17 Mar 2018 08:54:20 +0100
Message-Id: <20180317075421.22032-36-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180317075421.22032-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile                  |  2 +-
 t/helper/test-tool.c      |  1 +
 t/helper/test-tool.h      |  1 +
 t/helper/test-wildmatch.c |  3 ++-
 t/t3070-wildmatch.sh      | 14 +++++++-------
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 7923ec3747..2ab76c6838 100644
--- a/Makefile
+++ b/Makefile
@@ -685,6 +685,7 @@ TEST_BUILTINS_OBJS += test-string-list.o
 TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
+TEST_BUILTINS_OBJS += test-wildmatch.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
@@ -694,7 +695,6 @@ TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-tool
-TEST_PROGRAMS_NEED_X += test-wildmatch
 
 TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
 
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f2d60af898..ebf28859b4 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -40,6 +40,7 @@ static struct test_cmd cmds[] = {
 	{ "submodule-config", test_submodule_config },
 	{ "subprocess", test_subprocess },
 	{ "urlmatch-normalization", test_urlmatch_normalization },
+	{ "wildmatch", test_wildmatch },
 };
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 704ac9df35..b7c8272689 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -34,5 +34,6 @@ int test_string_list(int argc, const char **argv);
 int test_submodule_config(int argc, const char **argv);
 int test_subprocess(int argc, const char **argv);
 int test_urlmatch_normalization(int argc, const char **argv);
+int test_wildmatch(int argc, const char **argv);
 
 #endif
diff --git a/t/helper/test-wildmatch.c b/t/helper/test-wildmatch.c
index 66d33dfcfd..b5c6d10b5e 100644
--- a/t/helper/test-wildmatch.c
+++ b/t/helper/test-wildmatch.c
@@ -1,6 +1,7 @@
+#include "test-tool.h"
 #include "cache.h"
 
-int cmd_main(int argc, const char **argv)
+int test_wildmatch(int argc, const char **argv)
 {
 	int i;
 	for (i = 2; i < argc; i++) {
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index c1fc6ca730..dce102130f 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -79,12 +79,12 @@ match_with_function() {
 	if test "$match_expect" = 1
 	then
 		test_expect_success "$match_function: match '$text' '$pattern'" "
-			test-wildmatch $match_function '$text' '$pattern'
+			test-tool wildmatch $match_function '$text' '$pattern'
 		"
 	elif test "$match_expect" = 0
 	then
 		test_expect_success "$match_function: no match '$text' '$pattern'" "
-			test_must_fail test-wildmatch $match_function '$text' '$pattern'
+			test_must_fail test-tool wildmatch $match_function '$text' '$pattern'
 		"
 	else
 		test_expect_success "PANIC: Test framework error. Unknown matches value $match_expect" 'false'
@@ -148,7 +148,7 @@ match_with_ls_files() {
 match() {
 	if test "$#" = 6
 	then
-		# When test-wildmatch and git ls-files produce the same
+		# When test-tool wildmatch and git ls-files produce the same
 		# result.
 		match_glob=$1
 		match_file_glob=$match_glob
@@ -204,19 +204,19 @@ match() {
 		fi
 	'
 
-	# $1: Case sensitive glob match: test-wildmatch & ls-files
+	# $1: Case sensitive glob match: test-tool wildmatch & ls-files
 	match_with_function "$text" "$pattern" $match_glob "wildmatch"
 	match_with_ls_files "$text" "$pattern" $match_file_glob "wildmatch" " --glob-pathspecs"
 
-	# $2: Case insensitive glob match: test-wildmatch & ls-files
+	# $2: Case insensitive glob match: test-tool wildmatch & ls-files
 	match_with_function "$text" "$pattern" $match_iglob "iwildmatch"
 	match_with_ls_files "$text" "$pattern" $match_file_iglob "iwildmatch" " --glob-pathspecs --icase-pathspecs"
 
-	# $3: Case sensitive path match: test-wildmatch & ls-files
+	# $3: Case sensitive path match: test-tool wildmatch & ls-files
 	match_with_function "$text" "$pattern" $match_pathmatch "pathmatch"
 	match_with_ls_files "$text" "$pattern" $match_file_pathmatch "pathmatch" ""
 
-	# $4: Case insensitive path match: test-wildmatch & ls-files
+	# $4: Case insensitive path match: test-tool wildmatch & ls-files
 	match_with_function "$text" "$pattern" $match_pathmatchi "ipathmatch"
 	match_with_ls_files "$text" "$pattern" $match_file_pathmatchi "ipathmatch" " --icase-pathspecs"
 }
-- 
2.16.2.903.gd04caf5039

