Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4E0200B9
	for <e@80x24.org>; Tue, 22 May 2018 21:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeEVVQm (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 17:16:42 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34762 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeEVVQh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 17:16:37 -0400
Received: by mail-wr0-f193.google.com with SMTP id j1-v6so11702959wrm.1
        for <git@vger.kernel.org>; Tue, 22 May 2018 14:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OzBhEEZQ3yuk5cHXISXbwZfSRiKx0XfKx2XBofoIgKE=;
        b=jdlMxu0RCn2mgBRJ6B9VfNOHjpp1YqBLwwGO+fMIg/XXl8O3d/v3HNoXZQhKL27+Ln
         aJw7aFQ/p6tl8mkY48Wo8f9hFfePHZKw5qxiV+yTY6IUVIvM05AjuxaUoh/24LikYPif
         nxI4FrNcTX6X9HtL5KfMlmhP59UW7zmRCsfGwIf/gMHDCkdcpePQzwQWuVfO5ihRurqy
         9Eop0hX1BD6XrcF3AqrrveGwmsP8BZ/29Sfam1GZmUJsfFlz466MaANvVOeZRhwmdcz7
         IEWiJ2s2LbilRarIylHd5mhHOYA6ghICV9YhYBWCuVeOBvVU8YUrBNnIkWvUL6UCD3AF
         iBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OzBhEEZQ3yuk5cHXISXbwZfSRiKx0XfKx2XBofoIgKE=;
        b=NkzFOeJcxIAMuOBTGVisv1hx+8hCf/g6GJ7buu718gpOpQmtXJ32DOOnOxbPU3k+bA
         Cf9jyuHUZZ8gTmp4mL6hduqjoW4AhGQmvTbTUHzWG4WQcktxzLh1UH1a//JU6UgFBS6F
         8sTet3gMe90uyLeFInMVIH9Hps5na5nPWHu9IiHmT8Yz1SXgGYRmC9I6sNdzHzIojjPt
         XxnsRni4OJnJEjIPg+EuxD0TB72PaQsbXmY5V4/fYjFMuGttoYXnOkARu+zK9B0GmD/g
         CEvT+kvGYrXkO+H3TvdXC/TvI+t5jsFgDQ6MJ7N3N8GT5nFFzC6SmhLZvzX82857SGlO
         b1Fw==
X-Gm-Message-State: ALKqPwfdgJNdh/skc12W/hn11mYYSmiLSjnUt1TaNgaifo6A7FD5A1DJ
        KUS7Joh4lDYecpluL7miOTIF9DLaLCI=
X-Google-Smtp-Source: AB8JxZreJXN6JUoITDGoCYUcc+lx/vZK+LP7z7KM4GlUoERTuZdVfexNVsgygywsC2H29N3Qsra/+w==
X-Received: by 2002:adf:86ed:: with SMTP id 42-v6mr99475wry.158.1527023796079;
        Tue, 22 May 2018 14:16:36 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-64.w86-221.abo.wanadoo.fr. [86.221.117.64])
        by smtp.googlemail.com with ESMTPSA id z66-v6sm941983wme.13.2018.05.22.14.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 May 2018 14:16:35 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Wink Saville <wink@saville.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 2/4] rebase: strip unused code in git-rebase--preserve-merges.sh
Date:   Tue, 22 May 2018 23:16:23 +0200
Message-Id: <20180522211625.23893-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180522211625.23893-1-alban.gruin@gmail.com>
References: <20180522133110.32723-1-alban.gruin@gmail.com>
 <20180522211625.23893-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the code coming from git-rebase--interactive.sh that is not needed
by preserve-merges.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 git-rebase--preserve-merges.sh | 65 +++---------------------------------------
 1 file changed, 4 insertions(+), 61 deletions(-)

diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
index 2f4941d0f..c51c7828e 100644
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
@@ -287,17 +283,7 @@ pick_one () {
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
@@ -761,11 +747,6 @@ get_missing_commit_check_level () {
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
@@ -824,12 +805,6 @@ first and then run 'git rebase --continue' again.")"
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
@@ -944,43 +919,11 @@ EOF
 	}
 
 	expand_todo_ids
-
-	test -d "$rewritten" || test -n "$force_rebase" ||
-	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
-	die "Could not skip unnecessary pick commands"
-
 	checkout_onto
-	if test ! -d "$rewritten"
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
-		${rebase_merges:+--rebase-merges} \
-		${rebase_cousins:+--rebase-cousins} \
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

