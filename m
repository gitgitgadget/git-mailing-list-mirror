From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] t4118: be nice to non-GNU sed
Date: Thu, 22 Mar 2007 21:05:28 -0400
Message-ID: <20070323010528.GB17773@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pipping@macports.org, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 02:05:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUYDp-00045F-LF
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 02:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934260AbXCWBFf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 21:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934264AbXCWBFf
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 21:05:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46746 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934260AbXCWBFe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 21:05:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HUYDX-0002Rt-FV; Thu, 22 Mar 2007 21:05:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EFE8A20FBAE; Thu, 22 Mar 2007 21:05:28 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42894>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Elias Pipping:
> I'm on a mac, hence /usr/bin/sed is not gnu sed, which makes
> t4118 fail.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Ack'd-by: Elias Pipping <pipping@macports.org>

---

 t/t4118-apply-empty-context.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t4118-apply-empty-context.sh b/t/t4118-apply-empty- 
context.sh
index 690a182..27cc6f2 100755
--- a/t/t4118-apply-empty-context.sh
+++ b/t/t4118-apply-empty-context.sh
@@ -23,7 +23,8 @@ test_expect_success setup '
 	cat file2 >file2.orig
 	git add file1 file2 &&
 	sed -e "/^B/d" <file1.orig >file1 &&
-	sed -e "/^B/d" <file2.orig >file2 &&
+	sed -e "/^[BQ]/d" <file2.orig >file2 &&
+	echo Q | tr -d "\\012" >>file2 &&
 	cat file1 >file1.mods &&
 	cat file2 >file2.mods &&
 	git diff |

-- 
Shawn.
