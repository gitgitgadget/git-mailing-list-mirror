Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F35F1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 22:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeDFWWY (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 18:22:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55833 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeDFWWX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 18:22:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id b127so6154919wmf.5
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 15:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Dk42QplrUim7JA1LQZ++GhcWdFeMRwB7RxhmBRtcdJM=;
        b=IOsbgq0JBhHCLGsSCsIqRKEGYYSV2H01+k2zxaBLy3eXZaGGBD+yRyty5nIR/1L4ft
         jwiWbjwFkLmMGG+0ouiQaynDMzK4SIibVYW/0SojS/ihE/8gtjoZEDLFJshMqjBRwap0
         Pi+ly5I0cExbIHxJebWv5NvOi2BGXjqTUYixY8rSwFaPE03TLv5LvUOgHEgNtTirNx5M
         nADDs0Nyth5Vyi8MNLnO0x9cY6DaNYitTGQy5KRP7SU8BRIjKuPzuhzYSlEv8wh5OYmw
         UJP7/xviukDHvjRTvYzAqUi8XAlc8ScWe4XkbbmtdDLRjrZsSyYCXpKLHH7I5RuMrb6x
         Wwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dk42QplrUim7JA1LQZ++GhcWdFeMRwB7RxhmBRtcdJM=;
        b=WkToX12tFgDasVDtcArZ/0bWPQ144W1F1by9awR5/a0zyIpyeEIftCBaFfIDvIMolk
         RYapCCcWWcv0g6u7wafFx8OtXRvAgPUmIzYRY1/f1yyQ3z0D+4L8KIuOc6CKjPRLpt42
         p0c3NCXDjxb6g/9cNmNVdUkdeceIWHiH4M0M0iC5B8xlOSZ22yhRh0Z7/rCvhc7p+nZX
         Qz6NX4jh7ODGhy/0hkvkmVDs9aLlpiT6y1C28t//kv99/i01sZpULlyswxQmnu5xar7p
         k20OqTHfz4K3QYV6rf+n+iHfevCZmiZxlEz3Z0AdKQK4P9FkRS186wdxhPSayW8aS27E
         8Vfg==
X-Gm-Message-State: ALQs6tD4lEHCi4XDhoO6YkIzy796hZ9wBQSBr41Jiv54Xfe3WLqrXOt1
        3sBYWdQHri8k7lR+24FcTm0tsg==
X-Google-Smtp-Source: AIpwx4+y+a+ZaSkkLfqFBbktyy1qennRY+byL0pDhB1BQ7IYwhCs8dPri2wCFHt1q60iAG2M8zvRFQ==
X-Received: by 10.28.112.11 with SMTP id l11mr3603755wmc.31.1523053341428;
        Fri, 06 Apr 2018 15:22:21 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([79.116.108.13])
        by smtp.gmail.com with ESMTPSA id p68sm14871497wmg.7.2018.04.06.15.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Apr 2018 15:22:20 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: [PATCH] t/helper: 'test-chmtime (--get|-g)' to print only the mtime
Date:   Sat,  7 Apr 2018 01:19:47 +0300
Message-Id: <20180406221947.28402-1-ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.16.2.751.g6be39c975.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compared to 'test-chmtime -v +0 file' which prints the mtime and
and the file name, 'test-chmtime --get file' displays only the mtime.
If it is used in combination with (+|=|=+|=-|-)seconds, it changes
and prints the new value.

	test-chmtime -v +0 file | sed 's/[^0-9].*$//'

is now equivalent to:

	test-chmtime --get file

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 t/helper/test-chmtime.c              | 44 +++++++++++++++++++++++-----
 t/t2022-checkout-paths.sh            |  4 +--
 t/t3404-rebase-interactive.sh        |  2 +-
 t/t3510-cherry-pick-sequence.sh      |  4 +--
 t/t4200-rerere.sh                    |  8 ++---
 t/t5000-tar-tree.sh                  |  2 +-
 t/t6022-merge-rename.sh              | 25 +++++++---------
 t/t6501-freshen-objects.sh           |  6 ++--
 t/t7508-status.sh                    |  4 +--
 t/t7701-repack-unpack-unreachable.sh |  6 ++--
 10 files changed, 63 insertions(+), 42 deletions(-)

diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
index e76025640..611e9520a 100644
--- a/t/helper/test-chmtime.c
+++ b/t/helper/test-chmtime.c
@@ -18,19 +18,29 @@
  *
  * Examples:
  *
- * To just print the mtime use --verbose and set the file mtime offset to 0:
+ * To print the mtime and the file name use --verbose and set
+ * the file mtime offset to 0:
  *
  *	test-chmtime -v +0 file
  *
+ * To print only the mtime use --get:
+ *
+ *	test-chmtime --get file
+ *
  * To set the mtime to current time:
  *
  *	test-chmtime =+0 file
  *
+ * To set the file mtime offset to +1 and print the new value:
+ *
+ *	test-chmtime --get +1 file
+ *
  */
 #include "git-compat-util.h"
 #include <utime.h>
 
-static const char usage_str[] = "-v|--verbose (+|=|=+|=-|-)<seconds> <file>...";
+static const char usage_str[] =
+	"(-v|--verbose|-g|--get) (+|=|=+|=-|-)<seconds> <file>...";
 
 static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
 {
@@ -46,7 +56,6 @@ static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
 	}
 	*set_time = strtol(timespec, &test, 10);
 	if (*test) {
-		fprintf(stderr, "Not a base-10 integer: %s\n", arg + 1);
 		return 0;
 	}
 	if ((*set_eq && *set_time < 0) || *set_eq == 2) {
@@ -59,6 +68,7 @@ static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
 int cmd_main(int argc, const char **argv)
 {
 	static int verbose;
+	static int get;
 
 	int i = 1;
 	/* no mtime change by default */
@@ -68,18 +78,34 @@ int cmd_main(int argc, const char **argv)
 	if (argc < 3)
 		goto usage;
 
-	if (strcmp(argv[i], "--verbose") == 0 || strcmp(argv[i], "-v") == 0) {
+	if (strcmp(argv[i], "--get") == 0 || strcmp(argv[i], "-g") == 0) {
+		get = 1;
+		++i;
+	} else if (strcmp(argv[i], "--verbose") == 0 || strcmp(argv[i], "-v") == 0) {
 		verbose = 1;
 		++i;
 	}
-	if (timespec_arg(argv[i], &set_time, &set_eq))
+
+	if (i == argc) {
+		goto usage;
+	}
+
+	if (timespec_arg(argv[i], &set_time, &set_eq)) {
 		++i;
-	else
+	} else {
+		if (get == 0) {
+			fprintf(stderr, "Not a base-10 integer: %s\n", argv[i] + 1);
+			goto usage;
+		}
+	}
+
+	if (i == argc)
 		goto usage;
 
 	for (; i < argc; i++) {
 		struct stat sb;
 		struct utimbuf utb;
+		uintmax_t mtime;
 
 		if (stat(argv[i], &sb) < 0) {
 			fprintf(stderr, "Failed to stat %s: %s\n",
@@ -99,8 +125,10 @@ int cmd_main(int argc, const char **argv)
 		utb.actime = sb.st_atime;
 		utb.modtime = set_eq ? set_time : sb.st_mtime + set_time;
 
-		if (verbose) {
-			uintmax_t mtime = utb.modtime < 0 ? 0: utb.modtime;
+		mtime = utb.modtime < 0 ? 0: utb.modtime;
+		if (get) {
+			printf("%"PRIuMAX"\n", mtime);
+		} else if (verbose) {
 			printf("%"PRIuMAX"\t%s\n", mtime, argv[i]);
 		}
 
diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
index f46d0499b..2a42083bf 100755
--- a/t/t2022-checkout-paths.sh
+++ b/t/t2022-checkout-paths.sh
@@ -73,8 +73,8 @@ test_expect_success 'do not touch files that are already up-to-date' '
 	git checkout HEAD -- file1 file2 &&
 	echo one >expect &&
 	test_cmp expect file1 &&
-	echo "1000000000	file2" >expect &&
-	test-chmtime -v +0 file2 >actual &&
+	echo "1000000000" >expect &&
+	test-chmtime --get file2 >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3b905406d..0e3724d58 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -717,7 +717,7 @@ test_expect_success 'avoid unnecessary reset' '
 	set_fake_editor &&
 	git rebase -i HEAD~4 &&
 	test $HEAD = $(git rev-parse HEAD) &&
-	MTIME=$(test-chmtime -v +0 file3 | sed 's/[^0-9].*$//') &&
+	MTIME=$(test-chmtime --get file3) &&
 	test 123456789 = $MTIME
 '
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 0acf4b146..34f2c7b49 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -247,9 +247,9 @@ test_expect_success '--abort after last commit in sequence' '
 test_expect_success 'cherry-pick does not implicitly stomp an existing operation' '
 	pristine_detach initial &&
 	test_expect_code 1 git cherry-pick base..anotherpick &&
-	test-chmtime -v +0 .git/sequencer >expect &&
+	test-chmtime --get .git/sequencer >expect &&
 	test_expect_code 128 git cherry-pick unrelatedpick &&
-	test-chmtime -v +0 .git/sequencer >actual &&
+	test-chmtime --get .git/sequencer >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index d97d2bebc..e49f9862c 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -166,7 +166,7 @@ test_expect_success 'first postimage wins' '
 	git commit -q -a -m "prefer first over second" &&
 	test -f $rr/postimage &&
 
-	oldmtimepost=$(test-chmtime -v -60 $rr/postimage | cut -f 1) &&
+	oldmtimepost=$(test-chmtime --get -60 $rr/postimage) &&
 
 	git checkout -b third master &&
 	git show second^:a1 | sed "s/To die: t/To die! T/" >a1 &&
@@ -179,7 +179,7 @@ test_expect_success 'first postimage wins' '
 '
 
 test_expect_success 'rerere updates postimage timestamp' '
-	newmtimepost=$(test-chmtime -v +0 $rr/postimage | cut -f 1) &&
+	newmtimepost=$(test-chmtime --get $rr/postimage) &&
 	test $oldmtimepost -lt $newmtimepost
 '
 
@@ -512,7 +512,7 @@ test_expect_success 'multiple identical conflicts' '
 	count_pre_post 2 0 &&
 
 	# Pretend that the conflicts were made quite some time ago
-	find .git/rr-cache/ -type f | xargs test-chmtime -172800 &&
+	test-chmtime -172800 $(find .git/rr-cache/ -type f) &&
 
 	# Unresolved entries have not expired yet
 	git -c gc.rerereresolved=5 -c gc.rerereunresolved=5 rerere gc &&
@@ -568,7 +568,7 @@ test_expect_success 'multiple identical conflicts' '
 	git rerere &&
 
 	# Pretend that the resolutions are old again
-	find .git/rr-cache/ -type f | xargs test-chmtime -172800 &&
+	test-chmtime -172800 $(find .git/rr-cache/ -type f) &&
 
 	# Resolved entries have not expired yet
 	git -c gc.rerereresolved=5 -c gc.rerereunresolved=5 rerere gc &&
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index fe2d4f15a..161a700af 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -192,7 +192,7 @@ test_expect_success \
     'validate file modification time' \
     'mkdir extract &&
      "$TAR" xf b.tar -C extract a/a &&
-     test-chmtime -v +0 extract/a/a |cut -f 1 >b.mtime &&
+     test-chmtime --get extract/a/a >b.mtime &&
      echo "1117231200" >expected.mtime &&
      test_cmp expected.mtime b.mtime'
 
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index c01f721f1..206aea0cc 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -635,10 +635,9 @@ test_expect_success 'setup avoid unnecessary update, normal rename' '
 
 test_expect_success 'avoid unnecessary update, normal rename' '
 	git checkout -q avoid-unnecessary-update-1^0 &&
-	test-chmtime =1000000000 rename &&
-	test-chmtime -v +0 rename >expect &&
+	test-chmtime --get =1000000000 rename >expect &&
 	git merge merge-branch-1 &&
-	test-chmtime -v +0 rename >actual &&
+	test-chmtime --get rename >actual &&
 	test_cmp expect actual # "rename" should have stayed intact
 '
 
@@ -668,10 +667,9 @@ test_expect_success 'setup to test avoiding unnecessary update, with D/F conflic
 
 test_expect_success 'avoid unnecessary update, with D/F conflict' '
 	git checkout -q avoid-unnecessary-update-2^0 &&
-	test-chmtime =1000000000 df &&
-	test-chmtime -v +0 df >expect &&
+	test-chmtime --get =1000000000 df >expect &&
 	git merge merge-branch-2 &&
-	test-chmtime -v +0 df >actual &&
+	test-chmtime --get df >actual &&
 	test_cmp expect actual # "df" should have stayed intact
 '
 
@@ -700,10 +698,9 @@ test_expect_success 'setup avoid unnecessary update, dir->(file,nothing)' '
 
 test_expect_success 'avoid unnecessary update, dir->(file,nothing)' '
 	git checkout -q master^0 &&
-	test-chmtime =1000000000 df &&
-	test-chmtime -v +0 df >expect &&
+	test-chmtime --get =1000000000 df >expect &&
 	git merge side &&
-	test-chmtime -v +0 df >actual &&
+	test-chmtime --get df >actual &&
 	test_cmp expect actual # "df" should have stayed intact
 '
 
@@ -730,10 +727,9 @@ test_expect_success 'setup avoid unnecessary update, modify/delete' '
 
 test_expect_success 'avoid unnecessary update, modify/delete' '
 	git checkout -q master^0 &&
-	test-chmtime =1000000000 file &&
-	test-chmtime -v +0 file >expect &&
+	test-chmtime --get =1000000000 file >expect &&
 	test_must_fail git merge side &&
-	test-chmtime -v +0 file >actual &&
+	test-chmtime --get file >actual &&
 	test_cmp expect actual # "file" should have stayed intact
 '
 
@@ -759,10 +755,9 @@ test_expect_success 'setup avoid unnecessary update, rename/add-dest' '
 
 test_expect_success 'avoid unnecessary update, rename/add-dest' '
 	git checkout -q master^0 &&
-	test-chmtime =1000000000 newfile &&
-	test-chmtime -v +0 newfile >expect &&
+	test-chmtime --get =1000000000 newfile >expect &&
 	git merge side &&
-	test-chmtime -v +0 newfile >actual &&
+	test-chmtime --get newfile >actual &&
 	test_cmp expect actual # "file" should have stayed intact
 '
 
diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index 394b169ea..fa12bba98 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -72,8 +72,7 @@ for repack in '' true; do
 	'
 
 	test_expect_success "simulate time passing ($title)" '
-		find .git/objects -type f |
-		xargs test-chmtime -v -86400
+		test-chmtime --get -86400 $(find .git/objects -type f)
 	'
 
 	test_expect_success "start writing new commit with old blob ($title)" '
@@ -103,8 +102,7 @@ for repack in '' true; do
 
 	test_expect_success "abandon objects again ($title)" '
 		git reset --hard HEAD^ &&
-		find .git/objects -type f |
-		xargs test-chmtime -v -86400
+		test-chmtime --get -86400 $(find .git/objects -type f)
 	'
 
 	test_expect_success "start writing new commit with same tree ($title)" '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 50052e287..2e19d590e 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1674,10 +1674,10 @@ test_expect_success '"Initial commit" should not be noted in commit template' '
 test_expect_success '--no-optional-locks prevents index update' '
 	test-chmtime =1234567890 .git/index &&
 	git --no-optional-locks status &&
-	test-chmtime -v +0 .git/index >out &&
+	test-chmtime --get .git/index >out &&
 	grep ^1234567890 out &&
 	git status &&
-	test-chmtime -v +0 .git/index >out &&
+	test-chmtime --get .git/index >out &&
 	! grep ^1234567890 out
 '
 
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 987573c41..47f22555f 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -55,8 +55,8 @@ test_expect_success '-A with -d option leaves unreachable objects unpacked' '
 
 compare_mtimes ()
 {
-	read tref rest &&
-	while read t rest; do
+	read tref &&
+	while read t; do
 		test "$tref" = "$t" || return 1
 	done
 }
@@ -90,7 +90,7 @@ test_expect_success 'unpacked objects receive timestamp of pack file' '
 	tmppack=".git/objects/pack/tmp_pack" &&
 	ln "$packfile" "$tmppack" &&
 	git repack -A -l -d &&
-	test-chmtime -v +0 "$tmppack" "$fsha1path" "$csha1path" "$tsha1path" \
+	test-chmtime --get "$tmppack" "$fsha1path" "$csha1path" "$tsha1path" \
 		> mtimes &&
 	compare_mtimes < mtimes
 '
-- 
2.16.2.751.g6be39c975.dirty

