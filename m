Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 25131 invoked by uid 111); 24 Sep 2008 23:39:30 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 24 Sep 2008 19:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbYIXXjZ (ORCPT <rfc822;peff@peff.net>);
	Wed, 24 Sep 2008 19:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbYIXXjZ
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 19:39:25 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:50360 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752082AbYIXXjY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 19:39:24 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 9A0732AC8DA; Thu, 25 Sep 2008 01:39:13 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	spearce@spearce.org
Subject: [PATCH] git-gui: Fix fetching from remotes when adding them
Date:	Thu, 25 Sep 2008 01:39:13 +0200
Message-Id: <1222299553-5217-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
In-Reply-To: <20080924204615.625864882@suse.cz>
References: <20080924204615.625864882@suse.cz>
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

As you can see, this particular code branch did not see a lot
of testing for some time now. Apologies for that.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 git-gui/lib/remote_add.tcl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-gui/lib/remote_add.tcl b/git-gui/lib/remote_add.tcl
index 8e3ad16..fb29422 100644
--- a/git-gui/lib/remote_add.tcl
+++ b/git-gui/lib/remote_add.tcl
@@ -130,9 +130,9 @@ method _add {} {
 	switch -- $opt_action {
 	fetch {
 		set c [console::new \
-			[mc "fetch %s" $remote] \
-			[mc "Fetching the %s" $remote]]
-		console::exec $c [list git fetch --all $name]
+			[mc "fetch %s" $name] \
+			[mc "Fetching the %s" $name]]
+		console::exec $c [list git fetch $name]
 	}
 	push {
 		set cmds [list]
-- 
tg: (17f0c43..) t/git-gui/remote-fetch (depends on: git-gui/remotes)
