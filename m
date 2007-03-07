From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/9] Don't build external_grep if its not used
Date: Tue, 6 Mar 2007 20:44:14 -0500
Message-ID: <20070307014414.GD26482@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 02:46:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOlEE-00070d-2s
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 02:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161181AbXCGBo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 20:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161186AbXCGBo0
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 20:44:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49205 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161181AbXCGBoU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 20:44:20 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOlCH-0003pH-7g; Tue, 06 Mar 2007 20:44:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8118620FBAE; Tue,  6 Mar 2007 20:44:14 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41644>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-grep.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 96b7022..e4f06f2 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -150,6 +150,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	return i;
 }
 
+#ifdef __unix__
 static int exec_grep(int argc, const char **argv)
 {
 	pid_t pid;
@@ -298,6 +299,7 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 	}
 	return hit;
 }
+#endif
 
 static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 {
-- 
1.5.0.3.863.gf0989
