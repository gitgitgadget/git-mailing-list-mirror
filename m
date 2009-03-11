From: Ruth Alkema <ruth@diasoft.nl>
Subject: [PATCH JGIT] fix for 'negative position' error
Date: Wed, 11 Mar 2009 16:19:31 +0100
Message-ID: <49B7D683.1070805@diasoft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 16:28:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhQLy-0006Hs-2f
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 16:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbZCKP0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 11:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbZCKP0R
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 11:26:17 -0400
Received: from a82-93-20-178.adsl.xs4all.nl ([82.93.20.178]:49774 "EHLO
	www.diasoft.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751956AbZCKP0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 11:26:16 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Mar 2009 11:26:15 EDT
Received: (qmail 23351 invoked by uid 210); 11 Mar 2009 14:06:50 -0000
Received: from 192.168.12.5 by comms (envelope-from <ruth@diasoft.nl>, uid 201) with qmail-scanner-1.25st 
 (f-prot: 4.6.7/3.16.15. perlscan: 1.25st.  
 Clear:RC:1(192.168.12.5):. 
 Processed in 0.427208 secs); 11 Mar 2009 14:06:50 -0000
Received: from unknown (HELO ruth.diasoft.lan) (192.168.12.5)
  by 0 with SMTP; 11 Mar 2009 14:06:49 -0000
User-Agent: Thunderbird 2.0.0.19 (X11/20090109)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112940>

>From 78972d51ddd6bcbdf25bd49d2a033c005cf301b1 
From: Ruth Alkema <ruth@diasoft.nl>
Date: Wed, 11 Mar 2009 15:49:22 +0100

Signed-off-by: Ruth Alkema <ruth@diasoft.nl>
---
 .../src/org/spearce/jgit/lib/WindowCache.java      |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index 4b7e10d..5340da9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -253,7 +253,7 @@ private static synchronized final void getImpl(final WindowCursor curs,
 		releaseMemory();
 		runClearedWindowQueue();
 
-		wp.allocWindow(curs, id, id << windowSizeShift, wsz);
+		wp.allocWindow(curs, id, ((long) id) << windowSizeShift, wsz);
 		final ByteWindow<?> e = curs.window;
 		e.chainNext = cache[idx];
 		cache[idx] = e;
-- 
1.6.0.6
