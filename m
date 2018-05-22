Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D057E1F51C
	for <e@80x24.org>; Tue, 22 May 2018 13:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeEVNbr (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 09:31:47 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37322 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbeEVNbn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 09:31:43 -0400
Received: by mail-wr0-f196.google.com with SMTP id i12-v6so7053886wrc.4
        for <git@vger.kernel.org>; Tue, 22 May 2018 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C86tcdgzDWGJkDBs3hXndF923bxnqW6v9q/CjNeM1aY=;
        b=nFIT8SsS9c9GklqHZrKBEOmb3L0Xt+ML6pZRMXhlYqlUQMBmbJOO9ZGGgHPCxijQyV
         zP3y3Mre30MfilIn0AMpXas0bCZZ9m3eLYUQpKzgNONXyrbi/0UMyHNH9f8eb2ELZBMw
         VZVnEr5IZY51KlXppfVFlp6XcUJb3OLukaMmK5Sku76BqVSixZxNtMLptQKW6PikkL6U
         ikAHT7rjdXGbFU7pexbBtEzuHLMWWpOvNCeBAbd/pXswnWSVxwVLkjPe5/GuMAavo8PT
         aYbT0G7wEXbdiXBnf0sxotFWDgyzGN0eyoEWVhGmLn0ZAU3UaHdqIlI64eumIZj2i9gs
         NQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C86tcdgzDWGJkDBs3hXndF923bxnqW6v9q/CjNeM1aY=;
        b=t3NJ8Pg/Nz/VFc6YWRONKWVPSUh/J/vIX3RGWSms/PQoqxeNY4FSqaQ5ekCIcMSQ3u
         W2WxfLksK0ZrdR3gvKWp6XBksVbtkQogut2CMuXUAxx25XO2qOuDuq322p3L0iUgKQTi
         i1nsrH/v68sbx1DF4VFcq+Hg5fi1aGwM/3/ySAElLVtm7B+jPy3k2Bk7zUq2ybLKduo2
         iFiJ53Byxi5gBByPSY1+ef0W7OFkfvWXHdUZDm23GW+O7DiLPDwnZSapRjsHYTrk3he4
         NQx9Sn7wNKtB+6N8xkY0qZOTIW9wyXoi/zYc+v+9TQiu7lpzrNWOa4qmrqXC6R7NVBp1
         tcmA==
X-Gm-Message-State: ALKqPwdafX3C1iCEjgTYiiDcNDSqmSIXQs6xOYl2SWpbbbs1SmwlAU6n
        JONTycX+hV/f1qOMFRNWZ4o1vaCA9IQ=
X-Google-Smtp-Source: AB8JxZpW+JQbYhREElBT96ZPrey4tFrwBTcZ3Fzbx+u2LdJUS4KM4mjN6RECXSvf0UG2WQDHwo+VCQ==
X-Received: by 2002:adf:8b85:: with SMTP id o5-v6mr2158244wra.169.1526995901821;
        Tue, 22 May 2018 06:31:41 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-45-152.w86-221.abo.wanadoo.fr. [86.221.52.152])
        by smtp.googlemail.com with ESMTPSA id w40-v6sm29109785wrc.69.2018.05.22.06.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 May 2018 06:31:40 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Wink Saville <wink@saville.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH 2/4] rebase: strip unused code in git-rebase--preserve-merges.sh
Date:   Tue, 22 May 2018 15:31:08 +0200
Message-Id: <20180522133110.32723-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180522133110.32723-1-alban.gruin@gmail.com>
References: <20180522133110.32723-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the code coming from git-rebase--interactive.sh that is not needed
by preserve-merges.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 git-rebase--preserve-merges.sh | 63 +++---------------------------------------
 1 file changed, 4 insertions(+), 59 deletions(-)

diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
index 9947e6265..7bbbb2438 100644
--- a/git-rebase--preserve-merges.sh
+++ b/git-rebase--preserve-merges.sh
@@ -1,12 +1,8 @@
-# This shell script fragment is sourced by git-rebase to implement
-# its interactive mode.  "git rebase --interactive" makes it easy
-# to fix up commits in the middle of a series and rearrange commits.
+# This shell script fragment is sourced by git-rebase to implement its
+# preserve-merges mode.
 #
 # Copyright (c) 2006 Johannes E. Schindelin
 #
-# The original idea comes from Eric W. Biederman, in
-# https://public-inbox.org/git/m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com/
-#
 # The file containing rebase commands, comments, and empty lines.
 # This file is created by "git rebase -i" then edited by the user.  As
 # the lines are processed, they are removed from the front of this
@@ -281,17 +277,7 @@ pick_one () {
 		empty_args="--allow-empty"
 	fi
 
-	test -d "$rewritten" &&
-		pick_one_preserving_merges "$@" && return
-	output eval git cherry-pick $allow_rerere_autoupdate $allow_empty_message \
-			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
-			$signoff "$strategy_args" $empty_args $ff "$@"
-
-	# If cherry-pick dies it leaves the to-be-picked commit unrecorded. Reschedule
-	# previous task so this commit is not lost.
-	ret=$?
-	case "$ret" in [01]) ;; *) reschedule_last_action ;; esac
-	return $ret
+	pick_one_preserving_merges "$@"
 }
 
 pick_one_preserving_merges () {
@@ -755,11 +741,6 @@ get_missing_commit_check_level () {
 initiate_action () {
 	case "$1" in
 	continue)
-		if test ! -d "$rewritten"
-		then
-			exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-				--continue
-		fi
 		# do we have anything to commit?
 		if git diff-index --cached --quiet HEAD --
 		then
@@ -818,12 +799,6 @@ first and then run 'git rebase --continue' again.")"
 		;;
 	skip)
 		git rerere clear
-
-		if test ! -d "$rewritten"
-		then
-			exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-				--continue
-		fi
 		do_rest
 		return 0
 		;;
@@ -936,41 +911,11 @@ EOF
 	}
 
 	expand_todo_ids
-
-	test -d "$rewritten" || test -n "$force_rebase" ||
-	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
-	die "Could not skip unnecessary pick commands"
-
 	checkout_onto
-	if test -z "$rebase_root" && test ! -d "$rewritten"
-	then
-		require_clean_work_tree "rebase"
-		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-			--continue
-	fi
 	do_rest
 }
 
-git_rebase__interactive () {
-	initiate_action "$action"
-	ret=$?
-	if test $ret = 0; then
-		return 0
-	fi
-
-	setup_reflog_action
-	init_basic_state
-
-	init_revisions_and_shortrevisions
-
-	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
-		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
-	die "$(gettext "Could not generate todo list")"
-
-	complete_action
-}
-
-git_rebase__interactive__preserve_merges () {
+git_rebase__preserve_merges () {
 	initiate_action "$action"
 	ret=$?
 	if test $ret = 0; then
-- 
2.16.1

