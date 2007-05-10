From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Correct error message in revert/cherry-pick
Date: Thu, 10 May 2007 18:10:36 -0400
Message-ID: <20070510221036.GA31328@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 11 00:10:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmGqT-0005xm-5n
	for gcvg-git@gmane.org; Fri, 11 May 2007 00:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759406AbXEJWKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 18:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759373AbXEJWKk
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 18:10:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43666 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759304AbXEJWKk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 18:10:40 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HmGqC-00050f-Rv; Thu, 10 May 2007 18:10:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 06D8020FBAE; Thu, 10 May 2007 18:10:37 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46911>

We now write to MERGE_MSG, not .msg.  I missed this earlier
when I changed the target we write to.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-revert.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 55d4fa1..ea2f15b 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -133,7 +133,7 @@ static void add_to_msg(const char *string)
 {
 	int len = strlen(string);
 	if (write_in_full(msg_fd, string, len) < 0)
-		die ("Could not write to .msg");
+		die ("Could not write to MERGE_MSG");
 }
 
 static void add_message_to_msg(const char *message)
-- 
1.5.2.rc2.754.g40686
