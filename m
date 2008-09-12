From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT PATCH 1/3] Fix IncorrectObjectTypeException thrown for
	incorrect ^{blob}
Date: Fri, 12 Sep 2008 12:57:04 +0200
Message-ID: <20080912105703.GA7945@diku.dk>
References: <20080911213927.GA20238@diku.dk> <200809120047.58484.robin.rosenberg.lists@dewire.com> <20080912000007.GA31931@diku.dk> <200809120847.13541.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 12:58:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke6M0-00048b-Ej
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 12:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbYILK5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 06:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbYILK5J
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 06:57:09 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:46485 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137AbYILK5I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 06:57:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 3642719BBBF;
	Fri, 12 Sep 2008 12:57:05 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15532-07; Fri, 12 Sep 2008 12:57:04 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 2234319BBA8;
	Fri, 12 Sep 2008 12:57:04 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 692046DF823; Fri, 12 Sep 2008 12:56:50 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 08E361A4001; Fri, 12 Sep 2008 12:57:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809120847.13541.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95706>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../src/org/spearce/jgit/lib/Repository.java       |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index b27c23d..730a267 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -628,7 +628,7 @@ else if (item.equals("blob")) {
 									ref = mapObject(refId, null);
 								}
 								if (!(ref instanceof byte[]))
-									throw new IncorrectObjectTypeException(refId,  Constants.TYPE_COMMIT);
+									throw new IncorrectObjectTypeException(refId,  Constants.TYPE_BLOB);
 							}
 							else if (item.equals("")) {
 								ref = mapObject(refId, null);
-- 
1.6.0.1.451.gc8d31

-- 
Jonas Fonseca
