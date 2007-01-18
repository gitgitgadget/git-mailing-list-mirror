From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Document the master@{n} reflog query syntax.
Date: Wed, 17 Jan 2007 21:08:04 -0500
Message-ID: <20070118020804.GA23488@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 03:08:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7MhS-0000Us-LD
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 03:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbXARCIJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 21:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbXARCIJ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 21:08:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57652 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbXARCII (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 21:08:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H7Mh1-00010s-3m; Wed, 17 Jan 2007 21:07:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A61C720FBAE; Wed, 17 Jan 2007 21:08:04 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37057>

In ab2a1a32 Junio improved the reflog query logic to support
obtaining the n-th prior value of a ref, but this was never
documented in git-rev-parse.  Now it is.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-rev-parse.txt |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 4eaf5a0..7bfbe1b 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -148,10 +148,18 @@ blobs contained in a commit.
   enclosed in a brace
   pair (e.g. '\{yesterday\}', '\{1 month 2 weeks 3 days 1 hour 1
   second ago\}' or '\{1979-02-26 18:30:00\}') to specify the value
-  of the ref at a prior point in time.  This suffix may only be
+  of the ref at a prior point in time.This suffix may only be
   used immediately following a ref name and the ref must have an
   existing log ($GIT_DIR/logs/<ref>).
 
+* A ref followed by the suffix '@' with an ordinal specification
+  enclosed in a brace pair (e.g. '\{1\}', '\{15\}') to specify
+  the n-th prior value of that ref.  For example 'master@\{1\}'
+  is the immediate prior value of 'master' while 'master@\{5\}'
+  is the 5th prior value of 'master'. This suffix may only be used
+  immediately following a ref name and the ref must have an existing
+  log ($GIT_DIR/logs/<ref>).
+
 * A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   'rev{caret}'
-- 
1.5.0.rc1.g556b
