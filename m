Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C57421F42D
	for <e@80x24.org>; Mon, 28 May 2018 12:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425000AbeE1Mf4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 08:35:56 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40344 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424971AbeE1Mfe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 08:35:34 -0400
Received: by mail-wr0-f196.google.com with SMTP id l41-v6so20075885wre.7
        for <git@vger.kernel.org>; Mon, 28 May 2018 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1OakCe2d1xQRhBk+ze1ErMgXWwvDfiBV0DPKfc7gZE=;
        b=eH98JEc6Bzv2+5ORziGAErm5dM8vGqwrgvQs5figRF1rpBxaTllHJe3S3zWG1zrNQP
         IRQ+7jWXMYnzg8yw+XcxUIzQUR3jp8P8jcU+e9KxZEb0jfa3IQP3tiqPdO7IYzLwdyOW
         8GhcDz8NzXlzH05aLpQddCTyI6qz6H3ief7pmOYnS44Ukwwxdudi+yzkmhh7e81nlQFz
         VVdL1RWA0o8/mjBHxx3SIuId3oByTtIv9M34ieLcseyFkGSwmW243r/4XZF3kFw36pdb
         pVwxsA8FTSGnItPCy0fDmGXcDhBnv8aPlRZHH7Rf2zfsIo7M+nfTy5a3jIIwQxBaCyyj
         oT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1OakCe2d1xQRhBk+ze1ErMgXWwvDfiBV0DPKfc7gZE=;
        b=rzEA3HkSaZJUwh4NdES6uezzZ4R4Jmrz08dSPZvkgyNZtkZdHjZYaV/bFK7IS57Ewh
         vrDq72tU/EDCs0w6r4Y6Y4NOjUDCPY5qMJmNrSFq/jGfNszLaluL0fhbJEaM/qkwH3Lu
         8fyVKSvc1keYqhE5dInx84XUWfYCbwOTk8LZklFCfVa94CqBOnDhUW52wF8sahzC/jrR
         LXi+s6nZXLQEm8X6D83MtsDz+WC2Dw2X41cj0Cfhz8w+CJa7lyIg5gLjBpkhOv7SIjI6
         S4OBKbi3v4r9Deulw6Qsx8P83IubSus8+ZD6aevPx0RodKiyXjE9Sj6m9GvBWs1R7v2D
         Sr6w==
X-Gm-Message-State: ALKqPwcpprXHxeYrDq0xOI/ALyIl9mT1UvPBTtCC698jLhECOd3uEX2F
        gOFpU5rPmFGqqx6cQn6gSquJTJbCb0U=
X-Google-Smtp-Source: ADUXVKJHubZnidBIFQMWa4lq+Byhnxr61sk0v/n+T9VyMwk6HMfndat2ArxwUg300Gjo4sY+4IHEJA==
X-Received: by 2002:adf:c187:: with SMTP id x7-v6mr7391860wre.84.1527510933133;
        Mon, 28 May 2018 05:35:33 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-64.w86-221.abo.wanadoo.fr. [86.221.117.64])
        by smtp.googlemail.com with ESMTPSA id p5-v6sm13808895wre.83.2018.05.28.05.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 May 2018 05:35:32 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Wink Saville <wink@saville.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 2/4] rebase: strip unused code in git-rebase--preserve-merges.sh
Date:   Mon, 28 May 2018 14:34:20 +0200
Message-Id: <20180528123422.6718-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180528123422.6718-1-alban.gruin@gmail.com>
References: <20180524114958.26521-1-alban.gruin@gmail.com>
 <20180528123422.6718-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the code coming from git-rebase--interactive.sh that is not
needed by preserve-merges, and changes the header comment accordingly.

In a following commit, the -p code from git-rebase--interactive.sh will
be stripped out. As preserve-merges’ successor is already in the works,
this will be the only script to be converted.

This also seems to fix a bug where a failure in
`pick_one_preserving_merges()` would fallback to the non-preserve-merges
`pick_one()`.

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

