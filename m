From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] use xstrdup please
Date: Thu, 15 Mar 2007 21:02:51 -0400
Message-ID: <20070316010251.GA31023@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 16 02:02:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS0qQ-0007sN-JZ
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 02:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbXCPBCz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 21:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbXCPBCz
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 21:02:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58585 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbXCPBCy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 21:02:54 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HS0q9-0004m6-Vy; Thu, 15 Mar 2007 21:02:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A6B7120FBAE; Thu, 15 Mar 2007 21:02:51 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42307>

We generally prefer xstrdup to just plain strdup.
Make it so.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 config.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index a3c7b77..d537311 100644
--- a/config.c
+++ b/config.c
@@ -351,12 +351,12 @@ int git_default_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "i18n.commitencoding")) {
-		git_commit_encoding = strdup(value);
+		git_commit_encoding = xstrdup(value);
 		return 0;
 	}
 
 	if (!strcmp(var, "i18n.logoutputencoding")) {
-		git_log_output_encoding = strdup(value);
+		git_log_output_encoding = xstrdup(value);
 		return 0;
 	}
 
-- 
1.5.0.4.1009.gd3da
