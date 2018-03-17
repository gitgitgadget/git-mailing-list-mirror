Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 429BF1F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbeCQHz5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:55:57 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36954 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752361AbeCQHz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:56 -0400
Received: by mail-lf0-f65.google.com with SMTP id y19-v6so18545888lfd.4
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zuuyFSBqEXo5Ia/gakHK9KRXZZ5AMqs7lJisF4W+ML0=;
        b=AxzFDMycesnAGn2XCCNGtoEbLRlTxqvNsjiCjI5II0SNiRHESsWA2OIokly0e9cm8V
         /p2CRFBrkxZw2XIMsq5wsuxXIQWSgvktQ+AT07LDOcPOBq2PWnEUnyksTpKi4X7iFtGR
         UOfH4PEUJhj9qGWks7ghWU9t4a9T3hikl3ohUO4PfVmxHqGzPUf8qILJ37E/6WaDR0Ev
         gSncnZqTD360Weq9qEpmyq33tnteyVBX2Wpo9ANjZncJtuoPA1vRCCVTtnZOudNan2TH
         vAjJwWQ4/eIMqXb+nDgtJNMFHcADNH58GutcNqKvxtEJDBG/80VJWKkVDGaQWTtsoRwY
         Xb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zuuyFSBqEXo5Ia/gakHK9KRXZZ5AMqs7lJisF4W+ML0=;
        b=WPnT+4EZDTxXjc7U7PQTOZZDZBumDVnE5UtKpyts1+7z+r9Mczlh706AiT518ZjFBX
         51eoBDSGHK37fLHTJeUegC8OxmHKNw6MP9ilUVhHhbQu80Ps/B+8Ieo6xVQ1fgL9Viu0
         hgiuawUgTd/IelUQgBBnToesHJMldUVBbIzcHvY/XRsWFh3D/Mx4xqWLaHrCjM2umBkf
         vFGI4d4qRCUMfZepRb5FaFVZGAjzdwxJ9vg8A5o32zxeVwDv0+n0j8s0y40eUpxRgqRH
         DOI2VMxi/jWG1J4CsMaxfnwUwXzPmZ3RxX66qGLbQKx3rMR1qQpDSRUVRa9xn7pjIqRZ
         sakA==
X-Gm-Message-State: AElRT7Hn7pyJcFwV3RrjuO5SAm7anLWXr2z/Wo0V8Q6jr3IWeDLF56Xj
        B1zeUAFDE7G5xrDieTDgyD+mRA==
X-Google-Smtp-Source: AG47ELufnRoT7iIIP5aidl/ChjGTrt3npfaW3rqtHmdyq2kGxGsQJGy5UZUaEjBKIKxGuShwu2+XbQ==
X-Received: by 10.46.51.17 with SMTP id d17mr3399625ljc.99.1521273353520;
        Sat, 17 Mar 2018 00:55:53 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:52 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 20/36] t/helper: merge test-path-utils into test-tool
Date:   Sat, 17 Mar 2018 08:54:05 +0100
Message-Id: <20180317075421.22032-21-pclouds@gmail.com>
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
 Makefile                   |  2 +-
 t/helper/test-path-utils.c |  3 +-
 t/helper/test-tool.c       |  1 +
 t/helper/test-tool.h       |  1 +
 t/lib-git-p4.sh            |  2 +-
 t/t0060-path-utils.sh      | 60 +++++++++++++++++++-------------------
 t/t1501-work-tree.sh       |  8 ++---
 7 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/Makefile b/Makefile
index 91af906d08..751ea6cad7 100644
--- a/Makefile
+++ b/Makefile
@@ -669,6 +669,7 @@ TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
+TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
@@ -676,7 +677,6 @@ TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
-TEST_PROGRAMS_NEED_X += test-path-utils
 TEST_PROGRAMS_NEED_X += test-prio-queue
 TEST_PROGRAMS_NEED_X += test-read-cache
 TEST_PROGRAMS_NEED_X += test-write-cache
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 2b3c5092a1..e00e423325 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "string-list.h"
 
@@ -170,7 +171,7 @@ static struct test_data dirname_data[] = {
 	{ NULL,              NULL     }
 };
 
-int cmd_main(int argc, const char **argv)
+int test_path_utils(int argc, const char **argv)
 {
 	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
 		char *buf = xmallocz(strlen(argv[2]));
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 29b04dd103..23e843ab46 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -24,6 +24,7 @@ static struct test_cmd cmds[] = {
 	{ "mergesort", test_mergesort },
 	{ "mktemp", test_mktemp },
 	{ "online-cpus", test_online_cpus },
+	{ "path-utils", test_path_utils },
 	{ "sha1", test_sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index b7dafee709..4bcca38f8e 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -18,6 +18,7 @@ int test_match_trees(int argc, const char **argv);
 int test_mergesort(int argc, const char **argv);
 int test_mktemp(int argc, const char **argv);
 int test_online_cpus(int argc, const char **argv);
+int test_path_utils(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 54fd5a6ca0..c27599474c 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -39,7 +39,7 @@ native_path () {
 	then
 		path=$(cygpath --windows "$path")
 	else
-		path=$(test-path-utils real_path "$path")
+		path=$(test-tool path-utils real_path "$path")
 	fi &&
 	echo "$path"
 }
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 7ea2bb515b..f46e3c4995 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -8,15 +8,15 @@ test_description='Test various path utilities'
 . ./test-lib.sh
 
 norm_path() {
-	expected=$(test-path-utils print_path "$2")
+	expected=$(test-tool path-utils print_path "$2")
 	test_expect_success $3 "normalize path: $1 => $2" \
-	"test \"\$(test-path-utils normalize_path_copy '$1')\" = '$expected'"
+	"test \"\$(test-tool path-utils normalize_path_copy '$1')\" = '$expected'"
 }
 
 relative_path() {
-	expected=$(test-path-utils print_path "$3")
+	expected=$(test-tool path-utils print_path "$3")
 	test_expect_success $4 "relative path: $1 $2 => $3" \
-	"test \"\$(test-path-utils relative_path '$1' '$2')\" = '$expected'"
+	"test \"\$(test-tool path-utils relative_path '$1' '$2')\" = '$expected'"
 }
 
 test_submodule_relative_url() {
@@ -37,7 +37,7 @@ test_git_path() {
 # On Windows, we are using MSYS's bash, which mangles the paths.
 # Absolute paths are anchored at the MSYS installation directory,
 # which means that the path / accounts for this many characters:
-rootoff=$(test-path-utils normalize_path_copy / | wc -c)
+rootoff=$(test-tool path-utils normalize_path_copy / | wc -c)
 # Account for the trailing LF:
 if test $rootoff = 2; then
 	rootoff=	# we are on Unix
@@ -46,7 +46,7 @@ else
 	# In MSYS2, the root directory "/" is translated into a Windows
 	# directory *with* trailing slash. Let's test for that and adjust
 	# our expected longest ancestor length accordingly.
-	case "$(test-path-utils print_path /)" in
+	case "$(test-tool path-utils print_path /)" in
 	*/) rootslash=1;;
 	*) rootslash=0;;
 	esac
@@ -61,7 +61,7 @@ ancestor() {
 		expected=$(($expected+$rootoff))
 	fi
 	test_expect_success "longest ancestor: $1 $2 => $expected" \
-	"actual=\$(test-path-utils longest_ancestor_length '$1' '$2') &&
+	"actual=\$(test-tool path-utils longest_ancestor_length '$1' '$2') &&
 	 test \"\$actual\" = '$expected'"
 }
 
@@ -77,8 +77,8 @@ case $(uname -s) in
 	;;
 esac
 
-test_expect_success basename 'test-path-utils basename'
-test_expect_success dirname 'test-path-utils dirname'
+test_expect_success basename 'test-tool path-utils basename'
+test_expect_success dirname 'test-tool path-utils dirname'
 
 norm_path "" ""
 norm_path . ""
@@ -157,48 +157,48 @@ ancestor /foo/bar /foo:/bar 4
 ancestor /foo/bar /bar -1
 
 test_expect_success 'strip_path_suffix' '
-	test c:/msysgit = $(test-path-utils strip_path_suffix \
+	test c:/msysgit = $(test-tool path-utils strip_path_suffix \
 		c:/msysgit/libexec//git-core libexec/git-core)
 '
 
 test_expect_success 'absolute path rejects the empty string' '
-	test_must_fail test-path-utils absolute_path ""
+	test_must_fail test-tool path-utils absolute_path ""
 '
 
 test_expect_success 'real path rejects the empty string' '
-	test_must_fail test-path-utils real_path ""
+	test_must_fail test-tool path-utils real_path ""
 '
 
 test_expect_success POSIX 'real path works on absolute paths 1' '
 	nopath="hopefully-absent-path" &&
-	test "/" = "$(test-path-utils real_path "/")" &&
-	test "/$nopath" = "$(test-path-utils real_path "/$nopath")"
+	test "/" = "$(test-tool path-utils real_path "/")" &&
+	test "/$nopath" = "$(test-tool path-utils real_path "/$nopath")"
 '
 
 test_expect_success 'real path works on absolute paths 2' '
 	nopath="hopefully-absent-path" &&
 	# Find an existing top-level directory for the remaining tests:
 	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
-	test "$d" = "$(test-path-utils real_path "$d")" &&
-	test "$d/$nopath" = "$(test-path-utils real_path "$d/$nopath")"
+	test "$d" = "$(test-tool path-utils real_path "$d")" &&
+	test "$d/$nopath" = "$(test-tool path-utils real_path "$d/$nopath")"
 '
 
 test_expect_success POSIX 'real path removes extra leading slashes' '
 	nopath="hopefully-absent-path" &&
-	test "/" = "$(test-path-utils real_path "///")" &&
-	test "/$nopath" = "$(test-path-utils real_path "///$nopath")" &&
+	test "/" = "$(test-tool path-utils real_path "///")" &&
+	test "/$nopath" = "$(test-tool path-utils real_path "///$nopath")" &&
 	# Find an existing top-level directory for the remaining tests:
 	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
-	test "$d" = "$(test-path-utils real_path "//$d")" &&
-	test "$d/$nopath" = "$(test-path-utils real_path "//$d/$nopath")"
+	test "$d" = "$(test-tool path-utils real_path "//$d")" &&
+	test "$d/$nopath" = "$(test-tool path-utils real_path "//$d/$nopath")"
 '
 
 test_expect_success 'real path removes other extra slashes' '
 	nopath="hopefully-absent-path" &&
 	# Find an existing top-level directory for the remaining tests:
 	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
-	test "$d" = "$(test-path-utils real_path "$d///")" &&
-	test "$d/$nopath" = "$(test-path-utils real_path "$d///$nopath")"
+	test "$d" = "$(test-tool path-utils real_path "$d///")" &&
+	test "$d/$nopath" = "$(test-tool path-utils real_path "$d///$nopath")"
 '
 
 test_expect_success SYMLINKS 'real path works on symlinks' '
@@ -209,35 +209,35 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	mkdir third &&
 	dir="$(cd .git; pwd -P)" &&
 	dir2=third/../second/other/.git &&
-	test "$dir" = "$(test-path-utils real_path $dir2)" &&
+	test "$dir" = "$(test-tool path-utils real_path $dir2)" &&
 	file="$dir"/index &&
-	test "$file" = "$(test-path-utils real_path $dir2/index)" &&
+	test "$file" = "$(test-tool path-utils real_path $dir2/index)" &&
 	basename=blub &&
-	test "$dir/$basename" = "$(cd .git && test-path-utils real_path "$basename")" &&
+	test "$dir/$basename" = "$(cd .git && test-tool path-utils real_path "$basename")" &&
 	ln -s ../first/file .git/syml &&
 	sym="$(cd first; pwd -P)"/file &&
-	test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
+	test "$sym" = "$(test-tool path-utils real_path "$dir2/syml")"
 '
 
 test_expect_success SYMLINKS 'prefix_path works with absolute paths to work tree symlinks' '
 	ln -s target symlink &&
-	test "$(test-path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"
+	test "$(test-tool path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"
 '
 
 test_expect_success 'prefix_path works with only absolute path to work tree' '
 	echo "" >expected &&
-	test-path-utils prefix_path prefix "$(pwd)" >actual &&
+	test-tool path-utils prefix_path prefix "$(pwd)" >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'prefix_path rejects absolute path to dir with same beginning as work tree' '
-	test_must_fail test-path-utils prefix_path prefix "$(pwd)a"
+	test_must_fail test-tool path-utils prefix_path prefix "$(pwd)a"
 '
 
 test_expect_success SYMLINKS 'prefix_path works with absolute path to a symlink to work tree having  same beginning as work tree' '
 	git init repo &&
 	ln -s repo repolink &&
-	test "a" = "$(cd repo && test-path-utils prefix_path prefix "$(pwd)/../repolink/a")"
+	test "a" = "$(cd repo && test-tool path-utils prefix_path prefix "$(pwd)/../repolink/a")"
 '
 
 relative_path /foo/a/b/c/	/foo/a/b/	c/
diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
index b06210ec5e..b07cb9140e 100755
--- a/t/t1501-work-tree.sh
+++ b/t/t1501-work-tree.sh
@@ -360,7 +360,7 @@ test_expect_success 'GIT_DIR set (1)' '
 	(
 		cd work &&
 		GIT_DIR=../gitfile git rev-parse --git-common-dir >actual &&
-		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
+		test-tool path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
 		test_cmp expect actual
 	)
 '
@@ -371,7 +371,7 @@ test_expect_success 'GIT_DIR set (2)' '
 	(
 		cd work &&
 		GIT_DIR=../gitfile git rev-parse --git-common-dir >actual &&
-		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
+		test-tool path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
 		test_cmp expect actual
 	)
 '
@@ -382,7 +382,7 @@ test_expect_success 'Auto discovery' '
 	(
 		cd work &&
 		git rev-parse --git-common-dir >actual &&
-		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
+		test-tool path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
 		test_cmp expect actual &&
 		echo haha >data1 &&
 		git add data1 &&
@@ -400,7 +400,7 @@ test_expect_success '$GIT_DIR/common overrides core.worktree' '
 	(
 		cd work &&
 		git rev-parse --git-common-dir >actual &&
-		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
+		test-tool path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
 		test_cmp expect actual &&
 		echo haha >data2 &&
 		git add data2 &&
-- 
2.16.2.903.gd04caf5039

