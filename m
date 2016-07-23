Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 523D1203E5
	for <e@80x24.org>; Sat, 23 Jul 2016 04:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbcGWE0W (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 00:26:22 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37166 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712AbcGWE0U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2016 00:26:20 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86DE6203E3;
	Sat, 23 Jul 2016 04:26:17 +0000 (UTC)
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Cc:	Eric Wong <e@80x24.org>, Clemens Buchacher <drizzd@aon.at>,
	Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] t/t91*: do not say how to avoid the tests
Date:	Sat, 23 Jul 2016 04:26:07 +0000
Message-Id: <20160723042608.27489-2-e@80x24.org>
In-Reply-To: <20160723042608.27489-1-e@80x24.org>
References: <20160723042608.27489-1-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Michael J Gruber <git@drmicha.warpmail.net>

Some of the tests "say" how to stop the svn tests from running, some do
not.

The test suite is directed at people reading t/README where we keep all
information about running the test suite (partly, with options etc.).

Remove said "say" occurences.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Eric Wong <e@80x24.org>
---
 t/t9100-git-svn-basic.sh               | 2 --
 t/t9158-git-svn-mergeinfo.sh           | 2 --
 t/t9160-git-svn-preserve-empty-dirs.sh | 1 -
 3 files changed, 5 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 28082b1..c23b11f 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -8,8 +8,6 @@ GIT_SVN_LC_ALL=${LC_ALL:-$LANG}
 
 . ./lib-git-svn.sh
 
-say 'define NO_SVN_TESTS to skip git svn tests'
-
 case "$GIT_SVN_LC_ALL" in
 *.UTF-8)
 	test_set_prereq UTF8
diff --git a/t/t9158-git-svn-mergeinfo.sh b/t/t9158-git-svn-mergeinfo.sh
index 13f78f2..a875b45 100755
--- a/t/t9158-git-svn-mergeinfo.sh
+++ b/t/t9158-git-svn-mergeinfo.sh
@@ -7,8 +7,6 @@ test_description='git svn mergeinfo propagation'
 
 . ./lib-git-svn.sh
 
-say 'define NO_SVN_TESTS to skip git svn tests'
-
 test_expect_success 'initialize source svn repo' '
 	svn_cmd mkdir -m x "$svnrepo"/trunk &&
 	svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
index b4a4434..0ede3cf 100755
--- a/t/t9160-git-svn-preserve-empty-dirs.sh
+++ b/t/t9160-git-svn-preserve-empty-dirs.sh
@@ -11,7 +11,6 @@ local Git repository with placeholder files.'
 
 . ./lib-git-svn.sh
 
-say 'define NO_SVN_TESTS to skip git svn tests'
 GIT_REPO=git-svn-repo
 
 test_expect_success 'initialize source svn repo containing empty dirs' '
-- 
EW

