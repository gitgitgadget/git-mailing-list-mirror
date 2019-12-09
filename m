Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841ACC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 18:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FC12077B
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 18:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfLISfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:35:03 -0500
Received: from mail-gateway-shared12.cyon.net ([194.126.200.65]:49536 "EHLO
        mail-gateway-shared12.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbfLISfD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Dec 2019 13:35:03 -0500
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Dec 2019 13:35:02 EST
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared12.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1ieNmJ-0005SQ-Su
        for git@vger.kernel.org; Mon, 09 Dec 2019 19:29:05 +0100
Received: from [10.20.10.231] (port=46698 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.92)
        (envelope-from <bb@drbeat.li>)
        id 1ieNjN-0025n4-FR; Mon, 09 Dec 2019 19:26:01 +0100
Received: by drbeat.li (Postfix, from userid 1000)
        id 4B197180083; Mon,  9 Dec 2019 19:26:01 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 2/2] gitk: rename "commit summary" to "commit reference"
Date:   Mon,  9 Dec 2019 19:25:34 +0100
Message-Id: <20191209182534.309884-2-dev+git@drbeat.li>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <20191209182534.309884-1-dev+git@drbeat.li>
References: <20191209182534.309884-1-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the commit reference format has a canonical name, let's use this
name in gitk's UI and implementation.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
This commit is optional IMO, but I think it makes sense to use the same
words for the same things.

 gitk-git/gitk | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index cc89fb25d2..72c7feec9a 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2640,7 +2640,7 @@ proc makewindow {} {
 	{mc "Diff selected -> this" command {diffvssel 1}}
 	{mc "Make patch" command mkpatch}
 	{mc "Create tag" command mktag}
-	{mc "Copy commit summary" command copysummary}
+	{mc "Copy commit reference" command copyreference}
 	{mc "Write commit to file" command writecommit}
 	{mc "Create new branch" command mkbranch}
 	{mc "Cherry-pick this commit" command cherrypick}
@@ -9389,17 +9389,17 @@ proc mktaggo {} {
     mktagcan
 }
 
-proc copysummary {} {
+proc copyreference {} {
     global rowmenuid autosellen
 
     set cmd [list git show -s --pretty=reference]
     if {$autosellen < 40} {
         lappend cmd --abbrev=$autosellen
     }
-    set summary [eval exec $cmd $rowmenuid]
+    set reference [eval exec $cmd $rowmenuid]
 
     clipboard clear
-    clipboard append $summary
+    clipboard append $reference
 }
 
 proc writecommit {} {
-- 
2.23.0.13.gecf2037ff6

