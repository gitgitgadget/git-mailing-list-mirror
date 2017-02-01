Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C675320A78
	for <e@80x24.org>; Wed,  1 Feb 2017 23:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbdBAXI2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 18:08:28 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:7863 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbdBAXI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 18:08:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 1E1A41E308C;
        Thu,  2 Feb 2017 00:08:24 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id djGDM0CJuShm; Thu,  2 Feb 2017 00:08:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 9B54E1E308A;
        Thu,  2 Feb 2017 00:08:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DSd9ByuXuL70; Thu,  2 Feb 2017 00:08:23 +0100 (CET)
Received: from localhost.localdomain (aftr-185-17-206-21.dynamic.mnet-online.de [185.17.206.21])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 3D8931E3089;
        Thu,  2 Feb 2017 00:08:23 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     bmwill@google.com, sbeller@google.com,
        Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH 1/2] doc: add doc for git-push --recurse-submodules=only
Date:   Thu,  2 Feb 2017 00:07:52 +0100
Message-Id: <20170201230753.19462-1-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Add documentation for the `--recurse-submodules=only` option of
git-push. The feature was added in commit 225e8bf (add option to
push only submodules).

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
---

Notes:
    This feature is already in 'next' but was undocumented. Unless somebody reads
    the release notes, there is no way of knowing about it.

 Documentation/git-push.txt | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 8eefabd..1624a35 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -272,7 +272,7 @@ origin +master` to force a push to the `master` branch). See the
 	standard error stream is not directed to a terminal.
 
 --no-recurse-submodules::
---recurse-submodules=check|on-demand|no::
+--recurse-submodules=check|on-demand|only|no::
 	May be used to make sure all submodule commits used by the
 	revisions to be pushed are available on a remote-tracking branch.
 	If 'check' is used Git will verify that all submodule commits that
@@ -280,11 +280,12 @@ origin +master` to force a push to the `master` branch). See the
 	remote of the submodule. If any commits are missing the push will
 	be aborted and exit with non-zero status. If 'on-demand' is used
 	all submodules that changed in the revisions to be pushed will be
-	pushed. If on-demand was not able to push all necessary revisions
-	it will also be aborted and exit with non-zero status. A value of
-	'no' or using `--no-recurse-submodules` can be used to override the
-	push.recurseSubmodules configuration variable when no submodule
-	recursion is required.
+	pushed. If on-demand was not able to push all necessary revisions it will
+	also be aborted and exit with non-zero status. If 'only' is used all
+	submodules will be recursively pushed while the superproject is left
+	unpushed. A value of 'no' or using `--no-recurse-submodules` can be used
+	to override the push.recurseSubmodules configuration variable when no
+	submodule recursion is required.
 
 --[no-]verify::
 	Toggle the pre-push hook (see linkgit:githooks[5]).  The
-- 
2.10.2

