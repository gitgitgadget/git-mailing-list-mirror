Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2CD31F6C1
	for <e@80x24.org>; Sun, 21 Aug 2016 14:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753184AbcHUOvG (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 10:51:06 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:61761 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751549AbcHUOvF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 10:51:05 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:86a6:c8ff:fe05:d3e0])
        by smtp1-g21.free.fr (Postfix) with ESMTP id F3CC1B004BA;
        Sun, 21 Aug 2016 14:50:33 +0200 (CEST)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH 2/3] i18n: fix git rebase interactive commit messages
Date:   Sun, 21 Aug 2016 16:50:38 +0200
Message-Id: <20160821145039.12121-2-jn.avila@free.fr>
X-Mailer: git-send-email 2.10.0.rc0.37.gd7d1c14.dirty
In-Reply-To: <20160821145039.12121-1-jn.avila@free.fr>
References: <xmqqy43rxqqz.fsf@gitster.mtv.corp.google.com>
 <20160821145039.12121-1-jn.avila@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For proper i18n, the logic cannot embed english specific processing.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 git-rebase--interactive.sh | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e2da524..7baf5f4 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -415,14 +415,6 @@ this_nth_commit_message () {
 	8) gettext "This is the 8th commit message:";;
 	9) gettext "This is the 9th commit message:";;
 	10) gettext "This is the 10th commit message:";;
-	# TRANSLATORS: if the language you are translating into
-	# doesn't allow you to compose a sentence in this fashion,
-	# consider translating as if this and the following few strings
-	# were "This is the commit message ${n}:"
-	*1[0-9]|*[04-9]) eval_gettext "This is the \${n}th commit message:";;
-	*1) eval_gettext "This is the \${n}st commit message:";;
-	*2) eval_gettext "This is the \${n}nd commit message:";;
-	*3) eval_gettext "This is the \${n}rd commit message:";;
 	*) eval_gettext "This is the commit message \${n}:";;
 	esac
 }
@@ -439,14 +431,6 @@ skip_nth_commit_message () {
 	8) gettext "The 8th commit message will be skipped:";;
 	9) gettext "The 9th commit message will be skipped:";;
 	10) gettext "The 10th commit message will be skipped:";;
-	# TRANSLATORS: if the language you are translating into
-	# doesn't allow you to compose a sentence in this fashion,
-	# consider translating as if this and the following few strings
-	# were "The commit message ${n} will be skipped:"
-	*1[0-9]|*[04-9]) eval_gettext "The \${n}th commit message will be skipped:";;
-	*1) eval_gettext "The \${n}st commit message will be skipped:";;
-	*2) eval_gettext "The \${n}nd commit message will be skipped:";;
-	*3) eval_gettext "The \${n}rd commit message will be skipped:";;
 	*) eval_gettext "The commit message \${n} will be skipped:";;
 	esac
 }
-- 
2.10.0.rc0.37.gd7d1c14.dirty

