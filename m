Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 486201F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeCXHoI (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:44:08 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:42824 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeCXHnd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:43:33 -0400
Received: by mail-lf0-f48.google.com with SMTP id a22-v6so21382132lfg.9
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mc2rCnyN1z69cNjPNQVjFT473q4NmHZAIu4Jc6Kn9Fs=;
        b=AKxXFgyg4eYzWc4bvOEvB3AXw8UQvXguIMmLSugV2TZw7CWNn4cPwPthDJeO6bBY6N
         35KCeOdwg/XlrfDurwaQ0B1LbfZbF90UD4K3yh+O+q/k8WbSO1b4c6DCT9wE5UnWb9Ic
         OaOAAtVxF0Wvqx6CNR0VhCaeW8HHdZbr6cFvqJoF6njMth2MxGfZUs2jutRB1l2FI0SH
         ahwas6JnQIExVD+5BYXp3Y0xMGS7vCE01uQmohusXkhrv48hDcClBjhUeBE/lxsdQgwf
         gm/anKxMITHOpzBLBIBnMQhLMJUvFDLwXivmZrDKdDCNbRgwhi0BoVsrm1JUNT6kZXjI
         LXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mc2rCnyN1z69cNjPNQVjFT473q4NmHZAIu4Jc6Kn9Fs=;
        b=SZWEHpbDgRT8zmrwTZXtxo5YYvX1pMk4iRqnIKfVbR41mGAx4zxMB8XM41T2vuYcV0
         IkssA3p7w2+HGA6NRrI4Pr/fx+GN7TcijL87UoZ/7xxyVYbawroXqcFLbP1KKJ/l/0QN
         kHfPd8g7KNuAhIGo44IaVVDqPscg8gYkpmeXqJH/AxSarIiASzdlWPJ9wChAosXmxc3W
         j+Al1Pe42A//VsZ9zDTXSqcZUPG9Xpgyn6Ug3RpdIJU341Y2xysfcMpNdeEa0EE/qeaY
         pSkAj0QLODrIQgilIkhY6IVVBtYYzGbPtb9iyt1VUseWxRStO0ha/WUEEggEVkeYEoLv
         5xKw==
X-Gm-Message-State: AElRT7H+VVcGxHnAJ++unWVJcDKuI9MRT18Hp3UPnubQI7c0uikNwhHa
        uMScI4qjlWEbOBtrDQ1CXvY=
X-Google-Smtp-Source: AIpwx4+5u5qA3xflLhFZ0DC0xn1wM+DMCJerMCrQEo5aRDJZZk/r0VHxFQB6GLmDGI/5fzmmla7Vrw==
X-Received: by 2002:a19:5750:: with SMTP id l77-v6mr7334632lfb.10.1521877411459;
        Sat, 24 Mar 2018 00:43:31 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o132-v6sm2642867lfe.91.2018.03.24.00.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:43:30 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/36] t/helper: merge test-chmtime into test-tool
Date:   Sat, 24 Mar 2018 08:42:29 +0100
Message-Id: <20180324074308.18934-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324074308.18934-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
 <20180324074308.18934-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile                             |  3 ++-
 t/helper/test-chmtime.c              | 15 +++++++-------
 t/helper/test-tool.c                 |  1 +
 t/helper/test-tool.h                 |  2 ++
 t/lib-git-svn.sh                     |  2 +-
 t/t1700-split-index.sh               | 12 +++++------
 t/t2022-checkout-paths.sh            |  4 ++--
 t/t3306-notes-prune.sh               |  2 +-
 t/t3404-rebase-interactive.sh        |  4 ++--
 t/t3418-rebase-continue.sh           |  4 ++--
 t/t3501-revert-cherry-pick.sh        |  2 +-
 t/t3510-cherry-pick-sequence.sh      |  4 ++--
 t/t3600-rm.sh                        |  2 +-
 t/t3700-add.sh                       |  2 +-
 t/t4011-diff-symlink.sh              |  2 +-
 t/t4013-diff-various.sh              |  2 +-
 t/t4035-diff-quiet.sh                |  2 +-
 t/t4151-am-abort.sh                  |  4 ++--
 t/t4200-rerere.sh                    | 22 ++++++++++----------
 t/t5000-tar-tree.sh                  |  2 +-
 t/t5304-prune.sh                     | 16 +++++++--------
 t/t5400-send-pack.sh                 |  2 +-
 t/t5516-fetch-push.sh                |  2 +-
 t/t6022-merge-rename.sh              | 30 ++++++++++++++--------------
 t/t6500-gc.sh                        |  2 +-
 t/t6501-freshen-objects.sh           |  4 ++--
 t/t7508-status.sh                    |  6 +++---
 t/t7701-repack-unpack-unreachable.sh |  6 +++---
 t/t9100-git-svn-basic.sh             |  4 ++--
 t/t9803-git-p4-shell-metachars.sh    |  4 ++--
 t/t9813-git-p4-preserve-users.sh     |  6 +++---
 t/t9820-git-p4-editor-handling.sh    |  2 +-
 t/test-lib.sh                        |  6 +++---
 33 files changed, 94 insertions(+), 89 deletions(-)

diff --git a/Makefile b/Makefile
index 2376646e98..416a8e39c1 100644
--- a/Makefile
+++ b/Makefile
@@ -652,7 +652,8 @@ X =
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
-TEST_PROGRAMS_NEED_X += test-chmtime
+TEST_BUILTINS_OBJS += test-chmtime.o
+
 TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-date
diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
index e760256406..1790ceab51 100644
--- a/t/helper/test-chmtime.c
+++ b/t/helper/test-chmtime.c
@@ -5,28 +5,29 @@
  *
  * The mtime can be changed to an absolute value:
  *
- *	test-chmtime =<seconds> file...
+ *	test-tool chmtime =<seconds> file...
  *
  * Relative to the current time as returned by time(3):
  *
- *	test-chmtime =+<seconds> (or =-<seconds>) file...
+ *	test-tool chmtime =+<seconds> (or =-<seconds>) file...
  *
  * Or relative to the current mtime of the file:
  *
- *	test-chmtime <seconds> file...
- *	test-chmtime +<seconds> (or -<seconds>) file...
+ *	test-tool chmtime <seconds> file...
+ *	test-tool chmtime +<seconds> (or -<seconds>) file...
  *
  * Examples:
  *
  * To just print the mtime use --verbose and set the file mtime offset to 0:
  *
- *	test-chmtime -v +0 file
+ *	test-tool chmtime -v +0 file
  *
  * To set the mtime to current time:
  *
- *	test-chmtime =+0 file
+ *	test-tool chmtime =+0 file
  *
  */
+#include "test-tool.h"
 #include "git-compat-util.h"
 #include <utime.h>
 
@@ -56,7 +57,7 @@ static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
 	return 1;
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd__chmtime(int argc, const char **argv)
 {
 	static int verbose;
 
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index c730f718ca..63ec15cb56 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -7,6 +7,7 @@ struct test_cmd {
 };
 
 static struct test_cmd cmds[] = {
+	{ "chmtime", cmd__chmtime },
 };
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 6ce57ae0cc..3a35e70e79 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -1,4 +1,6 @@
 #ifndef __TEST_TOOL_H__
 #define __TEST_TOOL_H__
 
+int cmd__chmtime(int argc, const char **argv);
+
 #endif
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 4c1f81f167..a8130f9119 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -49,7 +49,7 @@ rawsvnrepo="$svnrepo"
 svnrepo="file://$svnrepo"
 
 poke() {
-	test-chmtime +1 "$1"
+	test-tool chmtime +1 "$1"
 }
 
 # We need this, because we should pass empty configuration directory to
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index a66936fe9b..4b5d443280 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -332,12 +332,12 @@ test_expect_success 'shared index files expire after 2 weeks by default' '
 	git update-index --add ten &&
 	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	just_under_2_weeks_ago=$((5-14*86400)) &&
-	test-chmtime =$just_under_2_weeks_ago .git/sharedindex.* &&
+	test-tool chmtime =$just_under_2_weeks_ago .git/sharedindex.* &&
 	: >eleven &&
 	git update-index --add eleven &&
 	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	just_over_2_weeks_ago=$((-1-14*86400)) &&
-	test-chmtime =$just_over_2_weeks_ago .git/sharedindex.* &&
+	test-tool chmtime =$just_over_2_weeks_ago .git/sharedindex.* &&
 	: >twelve &&
 	git update-index --add twelve &&
 	test $(ls .git/sharedindex.* | wc -l) -le 2
@@ -345,12 +345,12 @@ test_expect_success 'shared index files expire after 2 weeks by default' '
 
 test_expect_success 'check splitIndex.sharedIndexExpire set to 16 days' '
 	git config splitIndex.sharedIndexExpire "16.days.ago" &&
-	test-chmtime =$just_over_2_weeks_ago .git/sharedindex.* &&
+	test-tool chmtime =$just_over_2_weeks_ago .git/sharedindex.* &&
 	: >thirteen &&
 	git update-index --add thirteen &&
 	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	just_over_16_days_ago=$((-1-16*86400)) &&
-	test-chmtime =$just_over_16_days_ago .git/sharedindex.* &&
+	test-tool chmtime =$just_over_16_days_ago .git/sharedindex.* &&
 	: >fourteen &&
 	git update-index --add fourteen &&
 	test $(ls .git/sharedindex.* | wc -l) -le 2
@@ -359,13 +359,13 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to 16 days' '
 test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"' '
 	git config splitIndex.sharedIndexExpire never &&
 	just_10_years_ago=$((-365*10*86400)) &&
-	test-chmtime =$just_10_years_ago .git/sharedindex.* &&
+	test-tool chmtime =$just_10_years_ago .git/sharedindex.* &&
 	: >fifteen &&
 	git update-index --add fifteen &&
 	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	git config splitIndex.sharedIndexExpire now &&
 	just_1_second_ago=-1 &&
-	test-chmtime =$just_1_second_ago .git/sharedindex.* &&
+	test-tool chmtime =$just_1_second_ago .git/sharedindex.* &&
 	: >sixteen &&
 	git update-index --add sixteen &&
 	test $(ls .git/sharedindex.* | wc -l) -le 2
diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
index f46d0499bc..e74d58b9e1 100755
--- a/t/t2022-checkout-paths.sh
+++ b/t/t2022-checkout-paths.sh
@@ -68,13 +68,13 @@ test_expect_success 'do not touch files that are already up-to-date' '
 	git add file1 file2 &&
 	git commit -m base &&
 	echo modified >file1 &&
-	test-chmtime =1000000000 file2 &&
+	test-tool chmtime =1000000000 file2 &&
 	git update-index -q --refresh &&
 	git checkout HEAD -- file1 file2 &&
 	echo one >expect &&
 	test_cmp expect file1 &&
 	echo "1000000000	file2" >expect &&
-	test-chmtime -v +0 file2 >actual &&
+	test-tool chmtime -v +0 file2 >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t3306-notes-prune.sh b/t/t3306-notes-prune.sh
index 86bf909ee3..61748088eb 100755
--- a/t/t3306-notes-prune.sh
+++ b/t/t3306-notes-prune.sh
@@ -22,7 +22,7 @@ test_expect_success 'setup: create a few commits with notes' '
 	git commit -m 3rd &&
 	COMMIT_FILE=.git/objects/5e/e1c35e83ea47cd3cc4f8cbee0568915fbbbd29 &&
 	test -f $COMMIT_FILE &&
-	test-chmtime =+0 $COMMIT_FILE &&
+	test-tool chmtime =+0 $COMMIT_FILE &&
 	git notes add -m "Note #3"
 '
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3b905406df..961ac9d6b8 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -711,13 +711,13 @@ test_expect_success 'rebase -i continue with unstaged submodule' '
 test_expect_success 'avoid unnecessary reset' '
 	git checkout master &&
 	git reset --hard &&
-	test-chmtime =123456789 file3 &&
+	test-tool chmtime =123456789 file3 &&
 	git update-index --refresh &&
 	HEAD=$(git rev-parse HEAD) &&
 	set_fake_editor &&
 	git rebase -i HEAD~4 &&
 	test $HEAD = $(git rev-parse HEAD) &&
-	MTIME=$(test-chmtime -v +0 file3 | sed 's/[^0-9].*$//') &&
+	MTIME=$(test-tool chmtime -v +0 file3 | sed 's/[^0-9].*$//') &&
 	test 123456789 = $MTIME
 '
 
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 7c91a85f43..9214d0bb51 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -24,7 +24,7 @@ test_expect_success 'interactive rebase --continue works with touched file' '
 	git checkout master &&
 
 	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
-	test-chmtime =-60 F1 &&
+	test-tool chmtime =-60 F1 &&
 	git rebase --continue
 '
 
@@ -36,7 +36,7 @@ test_expect_success 'non-interactive rebase --continue works with touched file'
 	test_must_fail git rebase --onto master master topic &&
 	echo "Resolved" >F2 &&
 	git add F2 &&
-	test-chmtime =-60 F1 &&
+	test-tool chmtime =-60 F1 &&
 	git rebase --continue
 '
 
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 783bdbf59d..ccbc118514 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -86,7 +86,7 @@ test_expect_success 'cherry-pick on stat-dirty working tree' '
 	(
 		cd copy &&
 		git checkout initial &&
-		test-chmtime +40 oops &&
+		test-tool chmtime +40 oops &&
 		git cherry-pick added
 	)
 '
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 0acf4b1461..9f93445f1e 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -247,9 +247,9 @@ test_expect_success '--abort after last commit in sequence' '
 test_expect_success 'cherry-pick does not implicitly stomp an existing operation' '
 	pristine_detach initial &&
 	test_expect_code 1 git cherry-pick base..anotherpick &&
-	test-chmtime -v +0 .git/sequencer >expect &&
+	test-tool chmtime -v +0 .git/sequencer >expect &&
 	test_expect_code 128 git cherry-pick unrelatedpick &&
-	test-chmtime -v +0 .git/sequencer >actual &&
+	test-tool chmtime -v +0 .git/sequencer >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 46f15169f5..b8fbdefcdc 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -232,7 +232,7 @@ test_expect_success 'Call "rm" from outside the work tree' '
 test_expect_success 'refresh index before checking if it is up-to-date' '
 
 	git reset --hard &&
-	test-chmtime -86400 frotz/nitfol &&
+	test-tool chmtime -86400 frotz/nitfol &&
 	git rm frotz/nitfol &&
 	test ! -f frotz/nitfol
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 2748805642..07af05d7ae 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -187,7 +187,7 @@ test_expect_success 'git add --refresh with pathspec' '
 	echo >foo && echo >bar && echo >baz &&
 	git add foo bar baz && H=$(git rev-parse :foo) && git rm -f foo &&
 	echo "100644 $H 3	foo" | git update-index --index-info &&
-	test-chmtime -60 bar baz &&
+	test-tool chmtime -60 bar baz &&
 	>expect &&
 	git add --refresh bar >actual &&
 	test_cmp expect actual &&
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 13e7f621ab..cf0f3a1ee7 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -73,7 +73,7 @@ test_expect_success 'diff identical, but newly created symlink and file' '
 	>expected &&
 	rm -f frotz nitfol &&
 	echo xyzzy >nitfol &&
-	test-chmtime +10 nitfol &&
+	test-tool chmtime +10 nitfol &&
 	if test_have_prereq SYMLINKS
 	then
 		ln -s xyzzy frotz
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 3f9a24fd56..f8d853595b 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -76,7 +76,7 @@ test_expect_success setup '
 
 	mkdir dir3 &&
 	cp dir/sub dir3/sub &&
-	test-chmtime +1 dir3/sub &&
+	test-tool chmtime +1 dir3/sub &&
 
 	git config log.showroot false &&
 	git commit --amend &&
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index 2f1737fcef..0352bf81a9 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -147,7 +147,7 @@ test_expect_success 'git diff --ignore-all-space, both files outside repo' '
 '
 
 test_expect_success 'git diff --quiet ignores stat-change only entries' '
-	test-chmtime +10 a &&
+	test-tool chmtime +10 a &&
 	echo modified >>b &&
 	test_expect_code 1 git diff --quiet
 '
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 16432781d2..9d8d3c72e7 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -171,7 +171,7 @@ test_expect_success 'am --skip leaves index stat info alone' '
 	git checkout -f --orphan skip-stat-info &&
 	git reset &&
 	test_commit skip-should-be-untouched &&
-	test-chmtime =0 skip-should-be-untouched.t &&
+	test-tool chmtime =0 skip-should-be-untouched.t &&
 	git update-index --refresh &&
 	git diff-files --exit-code --quiet &&
 	test_must_fail git am 0001-*.patch &&
@@ -183,7 +183,7 @@ test_expect_success 'am --abort leaves index stat info alone' '
 	git checkout -f --orphan abort-stat-info &&
 	git reset &&
 	test_commit abort-should-be-untouched &&
-	test-chmtime =0 abort-should-be-untouched.t &&
+	test-tool chmtime =0 abort-should-be-untouched.t &&
 	git update-index --refresh &&
 	git diff-files --exit-code --quiet &&
 	test_must_fail git am 0001-*.patch &&
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index d97d2bebc9..deafaa3e07 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -166,7 +166,7 @@ test_expect_success 'first postimage wins' '
 	git commit -q -a -m "prefer first over second" &&
 	test -f $rr/postimage &&
 
-	oldmtimepost=$(test-chmtime -v -60 $rr/postimage | cut -f 1) &&
+	oldmtimepost=$(test-tool chmtime -v -60 $rr/postimage | cut -f 1) &&
 
 	git checkout -b third master &&
 	git show second^:a1 | sed "s/To die: t/To die! T/" >a1 &&
@@ -179,7 +179,7 @@ test_expect_success 'first postimage wins' '
 '
 
 test_expect_success 'rerere updates postimage timestamp' '
-	newmtimepost=$(test-chmtime -v +0 $rr/postimage | cut -f 1) &&
+	newmtimepost=$(test-tool chmtime -v +0 $rr/postimage | cut -f 1) &&
 	test $oldmtimepost -lt $newmtimepost
 '
 
@@ -220,9 +220,9 @@ test_expect_success 'set up for garbage collection tests' '
 	almost_60_days_ago=$((60-60*86400)) &&
 	just_over_60_days_ago=$((-1-60*86400)) &&
 
-	test-chmtime =$just_over_60_days_ago $rr/preimage &&
-	test-chmtime =$almost_60_days_ago $rr/postimage &&
-	test-chmtime =$almost_15_days_ago $rr2/preimage
+	test-tool chmtime =$just_over_60_days_ago $rr/preimage &&
+	test-tool chmtime =$almost_60_days_ago $rr/postimage &&
+	test-tool chmtime =$almost_15_days_ago $rr2/preimage
 '
 
 test_expect_success 'gc preserves young or recently used records' '
@@ -232,8 +232,8 @@ test_expect_success 'gc preserves young or recently used records' '
 '
 
 test_expect_success 'old records rest in peace' '
-	test-chmtime =$just_over_60_days_ago $rr/postimage &&
-	test-chmtime =$just_over_15_days_ago $rr2/preimage &&
+	test-tool chmtime =$just_over_60_days_ago $rr/postimage &&
+	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
 	git rerere gc &&
 	! test -f $rr/preimage &&
 	! test -f $rr2/preimage
@@ -249,8 +249,8 @@ rerere_gc_custom_expiry_test () {
 		>"$rr/postimage" &&
 
 		two_days_ago=$((-2*86400)) &&
-		test-chmtime =$two_days_ago "$rr/preimage" &&
-		test-chmtime =$two_days_ago "$rr/postimage" &&
+		test-tool chmtime =$two_days_ago "$rr/preimage" &&
+		test-tool chmtime =$two_days_ago "$rr/postimage" &&
 
 		find .git/rr-cache -type f | sort >original &&
 
@@ -512,7 +512,7 @@ test_expect_success 'multiple identical conflicts' '
 	count_pre_post 2 0 &&
 
 	# Pretend that the conflicts were made quite some time ago
-	find .git/rr-cache/ -type f | xargs test-chmtime -172800 &&
+	find .git/rr-cache/ -type f | xargs test-tool chmtime -172800 &&
 
 	# Unresolved entries have not expired yet
 	git -c gc.rerereresolved=5 -c gc.rerereunresolved=5 rerere gc &&
@@ -568,7 +568,7 @@ test_expect_success 'multiple identical conflicts' '
 	git rerere &&
 
 	# Pretend that the resolutions are old again
-	find .git/rr-cache/ -type f | xargs test-chmtime -172800 &&
+	find .git/rr-cache/ -type f | xargs test-tool chmtime -172800 &&
 
 	# Resolved entries have not expired yet
 	git -c gc.rerereresolved=5 -c gc.rerereunresolved=5 rerere gc &&
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index fe2d4f15a7..266d052efb 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -192,7 +192,7 @@ test_expect_success \
     'validate file modification time' \
     'mkdir extract &&
      "$TAR" xf b.tar -C extract a/a &&
-     test-chmtime -v +0 extract/a/a |cut -f 1 >b.mtime &&
+     test-tool chmtime -v +0 extract/a/a |cut -f 1 >b.mtime &&
      echo "1117231200" >expected.mtime &&
      test_cmp expected.mtime b.mtime'
 
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 6694c19a1e..f0f6e2a5f3 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -15,7 +15,7 @@ add_blob() {
 	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
 	verbose test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE &&
-	test-chmtime =+0 $BLOB_FILE
+	test-tool chmtime =+0 $BLOB_FILE
 }
 
 test_expect_success setup '
@@ -33,7 +33,7 @@ test_expect_success 'prune stale packs' '
 	orig_pack=$(echo .git/objects/pack/*.pack) &&
 	: > .git/objects/tmp_1.pack &&
 	: > .git/objects/tmp_2.pack &&
-	test-chmtime =-86501 .git/objects/tmp_1.pack &&
+	test-tool chmtime =-86501 .git/objects/tmp_1.pack &&
 	git prune --expire 1.day &&
 	test_path_is_file $orig_pack &&
 	test_path_is_file .git/objects/tmp_2.pack &&
@@ -47,7 +47,7 @@ test_expect_success 'prune --expire' '
 	git prune --expire=1.hour.ago &&
 	verbose test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE &&
-	test-chmtime =-86500 $BLOB_FILE &&
+	test-tool chmtime =-86500 $BLOB_FILE &&
 	git prune --expire 1.day &&
 	verbose test $before = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_missing $BLOB_FILE
@@ -57,11 +57,11 @@ test_expect_success 'prune --expire' '
 test_expect_success 'gc: implicit prune --expire' '
 
 	add_blob &&
-	test-chmtime =-$((2*$week-30)) $BLOB_FILE &&
+	test-tool chmtime =-$((2*$week-30)) $BLOB_FILE &&
 	git gc &&
 	verbose test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE &&
-	test-chmtime =-$((2*$week+1)) $BLOB_FILE &&
+	test-tool chmtime =-$((2*$week+1)) $BLOB_FILE &&
 	git gc &&
 	verbose test $before = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_missing $BLOB_FILE
@@ -141,7 +141,7 @@ test_expect_success 'prune: do not prune heads listed as an argument' '
 test_expect_success 'gc --no-prune' '
 
 	add_blob &&
-	test-chmtime =-$((5001*$day)) $BLOB_FILE &&
+	test-tool chmtime =-$((5001*$day)) $BLOB_FILE &&
 	git config gc.pruneExpire 2.days.ago &&
 	git gc --no-prune &&
 	verbose test 1 = $(git count-objects | sed "s/ .*//") &&
@@ -163,7 +163,7 @@ test_expect_success 'gc respects gc.pruneExpire' '
 test_expect_success 'gc --prune=<date>' '
 
 	add_blob &&
-	test-chmtime =-$((5001*$day)) $BLOB_FILE &&
+	test-tool chmtime =-$((5001*$day)) $BLOB_FILE &&
 	git gc --prune=5002.days.ago &&
 	test_path_is_file $BLOB_FILE &&
 	git gc --prune=5000.days.ago &&
@@ -205,7 +205,7 @@ test_expect_success 'prune --expire=never' '
 
 test_expect_success 'gc: prune old objects after local clone' '
 	add_blob &&
-	test-chmtime =-$((2*$week+1)) $BLOB_FILE &&
+	test-tool chmtime =-$((2*$week+1)) $BLOB_FILE &&
 	git clone --no-hardlinks . aclone &&
 	(
 		cd aclone &&
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index d375d7110d..911eae1bf7 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -180,7 +180,7 @@ test_expect_success 'receive-pack runs auto-gc in remote repo' '
 	    # And create a file that follows the temporary object naming
 	    # convention for the auto-gc to remove
 	    : >.git/objects/tmp_test_object &&
-	    test-chmtime =-1209601 .git/objects/tmp_test_object
+	    test-tool chmtime =-1209601 .git/objects/tmp_test_object
 	) &&
 	(
 	    cd parent &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 177897ea0b..82239138d5 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1418,7 +1418,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 		cd testrepo &&
 		git reset --hard HEAD^ &&
 		test $(git -C .. rev-parse HEAD^) = $(git rev-parse HEAD) &&
-		test-chmtime +100 path1
+		test-tool chmtime +100 path1
 	) &&
 	git push testrepo master &&
 	(
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index c01f721f13..a1fad6980b 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -635,10 +635,10 @@ test_expect_success 'setup avoid unnecessary update, normal rename' '
 
 test_expect_success 'avoid unnecessary update, normal rename' '
 	git checkout -q avoid-unnecessary-update-1^0 &&
-	test-chmtime =1000000000 rename &&
-	test-chmtime -v +0 rename >expect &&
+	test-tool chmtime =1000000000 rename &&
+	test-tool chmtime -v +0 rename >expect &&
 	git merge merge-branch-1 &&
-	test-chmtime -v +0 rename >actual &&
+	test-tool chmtime -v +0 rename >actual &&
 	test_cmp expect actual # "rename" should have stayed intact
 '
 
@@ -668,10 +668,10 @@ test_expect_success 'setup to test avoiding unnecessary update, with D/F conflic
 
 test_expect_success 'avoid unnecessary update, with D/F conflict' '
 	git checkout -q avoid-unnecessary-update-2^0 &&
-	test-chmtime =1000000000 df &&
-	test-chmtime -v +0 df >expect &&
+	test-tool chmtime =1000000000 df &&
+	test-tool chmtime -v +0 df >expect &&
 	git merge merge-branch-2 &&
-	test-chmtime -v +0 df >actual &&
+	test-tool chmtime -v +0 df >actual &&
 	test_cmp expect actual # "df" should have stayed intact
 '
 
@@ -700,10 +700,10 @@ test_expect_success 'setup avoid unnecessary update, dir->(file,nothing)' '
 
 test_expect_success 'avoid unnecessary update, dir->(file,nothing)' '
 	git checkout -q master^0 &&
-	test-chmtime =1000000000 df &&
-	test-chmtime -v +0 df >expect &&
+	test-tool chmtime =1000000000 df &&
+	test-tool chmtime -v +0 df >expect &&
 	git merge side &&
-	test-chmtime -v +0 df >actual &&
+	test-tool chmtime -v +0 df >actual &&
 	test_cmp expect actual # "df" should have stayed intact
 '
 
@@ -730,10 +730,10 @@ test_expect_success 'setup avoid unnecessary update, modify/delete' '
 
 test_expect_success 'avoid unnecessary update, modify/delete' '
 	git checkout -q master^0 &&
-	test-chmtime =1000000000 file &&
-	test-chmtime -v +0 file >expect &&
+	test-tool chmtime =1000000000 file &&
+	test-tool chmtime -v +0 file >expect &&
 	test_must_fail git merge side &&
-	test-chmtime -v +0 file >actual &&
+	test-tool chmtime -v +0 file >actual &&
 	test_cmp expect actual # "file" should have stayed intact
 '
 
@@ -759,10 +759,10 @@ test_expect_success 'setup avoid unnecessary update, rename/add-dest' '
 
 test_expect_success 'avoid unnecessary update, rename/add-dest' '
 	git checkout -q master^0 &&
-	test-chmtime =1000000000 newfile &&
-	test-chmtime -v +0 newfile >expect &&
+	test-tool chmtime =1000000000 newfile &&
+	test-tool chmtime -v +0 newfile >expect &&
 	git merge side &&
-	test-chmtime -v +0 newfile >actual &&
+	test-tool chmtime -v +0 newfile >actual &&
 	test_cmp expect actual # "file" should have stayed intact
 '
 
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 41b0be575d..d5255dd576 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -87,7 +87,7 @@ test_expect_success 'background auto gc does not run if gc.log is present and re
 	test_must_fail git gc --auto 2>err &&
 	test_i18ngrep "^error:" err &&
 	test_config gc.logexpiry 5.days &&
-	test-chmtime =-345600 .git/gc.log &&
+	test-tool chmtime =-345600 .git/gc.log &&
 	test_must_fail git gc --auto &&
 	test_config gc.logexpiry 2.days &&
 	run_and_wait_for_auto_gc &&
diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index 394b169ead..765cced60b 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -73,7 +73,7 @@ for repack in '' true; do
 
 	test_expect_success "simulate time passing ($title)" '
 		find .git/objects -type f |
-		xargs test-chmtime -v -86400
+		xargs test-tool chmtime -v -86400
 	'
 
 	test_expect_success "start writing new commit with old blob ($title)" '
@@ -104,7 +104,7 @@ for repack in '' true; do
 	test_expect_success "abandon objects again ($title)" '
 		git reset --hard HEAD^ &&
 		find .git/objects -type f |
-		xargs test-chmtime -v -86400
+		xargs test-tool chmtime -v -86400
 	'
 
 	test_expect_success "start writing new commit with same tree ($title)" '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 50052e2872..7afadb175a 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1672,12 +1672,12 @@ test_expect_success '"Initial commit" should not be noted in commit template' '
 '
 
 test_expect_success '--no-optional-locks prevents index update' '
-	test-chmtime =1234567890 .git/index &&
+	test-tool chmtime =1234567890 .git/index &&
 	git --no-optional-locks status &&
-	test-chmtime -v +0 .git/index >out &&
+	test-tool chmtime -v +0 .git/index >out &&
 	grep ^1234567890 out &&
 	git status &&
-	test-chmtime -v +0 .git/index >out &&
+	test-tool chmtime -v +0 .git/index >out &&
 	! grep ^1234567890 out
 '
 
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 987573c41f..8a586ab021 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -90,7 +90,7 @@ test_expect_success 'unpacked objects receive timestamp of pack file' '
 	tmppack=".git/objects/pack/tmp_pack" &&
 	ln "$packfile" "$tmppack" &&
 	git repack -A -l -d &&
-	test-chmtime -v +0 "$tmppack" "$fsha1path" "$csha1path" "$tsha1path" \
+	test-tool chmtime -v +0 "$tmppack" "$fsha1path" "$csha1path" "$tsha1path" \
 		> mtimes &&
 	compare_mtimes < mtimes
 '
@@ -103,7 +103,7 @@ test_expect_success 'do not bother loosening old objects' '
 	git prune-packed &&
 	git cat-file -p $obj1 &&
 	git cat-file -p $obj2 &&
-	test-chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
+	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
 	git repack -A -d --unpack-unreachable=1.hour.ago &&
 	git cat-file -p $obj1 &&
 	test_must_fail git cat-file -p $obj2
@@ -117,7 +117,7 @@ test_expect_success 'keep packed objects found only in index' '
 	git reset HEAD^ &&
 	git reflog expire --expire=now --all &&
 	git add file &&
-	test-chmtime =-86400 .git/objects/pack/* &&
+	test-tool chmtime =-86400 .git/objects/pack/* &&
 	git gc --prune=1.hour.ago &&
 	git cat-file blob :file
 '
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 8a8ba65a2a..c937330a5f 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -288,12 +288,12 @@ test_expect_success 'able to dcommit to a subdirectory' '
 
 test_expect_success 'dcommit should not fail with a touched file' '
 	test_commit "commit-new-file-foo2" foo2 &&
-	test-chmtime =-60 foo &&
+	test-tool chmtime =-60 foo &&
 	git svn dcommit
 '
 
 test_expect_success 'rebase should not fail with a touched file' '
-	test-chmtime =-60 foo &&
+	test-tool chmtime =-60 foo &&
 	git svn rebase
 '
 
diff --git a/t/t9803-git-p4-shell-metachars.sh b/t/t9803-git-p4-shell-metachars.sh
index d950c7d665..d5c3675100 100755
--- a/t/t9803-git-p4-shell-metachars.sh
+++ b/t/t9803-git-p4-shell-metachars.sh
@@ -28,7 +28,7 @@ test_expect_success 'shell metachars in filenames' '
 		echo f2 >"file with spaces" &&
 		git add "file with spaces" &&
 		git commit -m "add files" &&
-		P4EDITOR="test-chmtime +5" git p4 submit
+		P4EDITOR="test-tool chmtime +5" git p4 submit
 	) &&
 	(
 		cd "$cli" &&
@@ -47,7 +47,7 @@ test_expect_success 'deleting with shell metachars' '
 		git rm foo\$bar &&
 		git rm file\ with\ spaces &&
 		git commit -m "remove files" &&
-		P4EDITOR="test-chmtime +5" git p4 submit
+		P4EDITOR="test-tool chmtime +5" git p4 submit
 	) &&
 	(
 		cd "$cli" &&
diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
index bda222aa02..783c6ad165 100755
--- a/t/t9813-git-p4-preserve-users.sh
+++ b/t/t9813-git-p4-preserve-users.sh
@@ -53,7 +53,7 @@ test_expect_success 'preserve users' '
 		git commit --author "Alice <alice@example.com>" -m "a change by alice" file1 &&
 		git commit --author "Bob <bob@example.com>" -m "a change by bob" file2 &&
 		git config git-p4.skipSubmitEditCheck true &&
-		P4EDITOR="test-chmtime +5" P4USER=alice P4PASSWD=secret &&
+		P4EDITOR="test-tool chmtime +5" P4USER=alice P4PASSWD=secret &&
 		export P4EDITOR P4USER P4PASSWD &&
 		git p4 commit --preserve-user &&
 		p4_check_commit_author file1 alice &&
@@ -71,7 +71,7 @@ test_expect_success 'refuse to preserve users without perms' '
 		git config git-p4.skipSubmitEditCheck true &&
 		echo "username-noperms: a change by alice" >>file1 &&
 		git commit --author "Alice <alice@example.com>" -m "perms: a change by alice" file1 &&
-		P4EDITOR="test-chmtime +5" P4USER=bob P4PASSWD=secret &&
+		P4EDITOR="test-tool chmtime +5" P4USER=bob P4PASSWD=secret &&
 		export P4EDITOR P4USER P4PASSWD &&
 		test_must_fail git p4 commit --preserve-user &&
 		! git diff --exit-code HEAD..p4/master
@@ -89,7 +89,7 @@ test_expect_success 'preserve user where author is unknown to p4' '
 		git commit --author "Bob <bob@example.com>" -m "preserve: a change by bob" file1 &&
 		echo "username-unknown: a change by charlie" >>file1 &&
 		git commit --author "Charlie <charlie@example.com>" -m "preserve: a change by charlie" file1 &&
-		P4EDITOR="test-chmtime +5" P4USER=alice P4PASSWD=secret &&
+		P4EDITOR="test-tool chmtime +5" P4USER=alice P4PASSWD=secret &&
 		export P4EDITOR P4USER P4PASSWD &&
 		test_must_fail git p4 commit --preserve-user &&
 		! git diff --exit-code HEAD..p4/master &&
diff --git a/t/t9820-git-p4-editor-handling.sh b/t/t9820-git-p4-editor-handling.sh
index 6dc6df032e..3c22f74bd4 100755
--- a/t/t9820-git-p4-editor-handling.sh
+++ b/t/t9820-git-p4-editor-handling.sh
@@ -26,7 +26,7 @@ test_expect_success 'EDITOR with options' '
 		cd "$git" &&
 		echo change >file1 &&
 		git commit -m "change" file1 &&
-		P4EDITOR=": >\"$git/touched\" && test-chmtime +5" git p4 submit &&
+		P4EDITOR=": >\"$git/touched\" && test-tool chmtime +5" git p4 submit &&
 		test_path_is_file "$git/touched"
 	)
 '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7740d511d2..7ab8af47a5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -963,10 +963,10 @@ test -d "$GIT_BUILD_DIR"/templates/blt || {
 	error "You haven't built things yet, have you?"
 }
 
-if ! test -x "$GIT_BUILD_DIR"/t/helper/test-chmtime
+if ! test -x "$GIT_BUILD_DIR"/t/helper/test-tool
 then
-	echo >&2 'You need to build test-chmtime:'
-	echo >&2 'Run "make t/helper/test-chmtime" in the source (toplevel) directory'
+	echo >&2 'You need to build test-tool:'
+	echo >&2 'Run "make t/helper/test-tool" in the source (toplevel) directory'
 	exit 1
 fi
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

