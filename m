From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/3] Cleanup style nit of 'x == NULL' in remote.c
Date: Tue, 25 Sep 2007 00:13:14 -0400
Message-ID: <20070925041314.GA11363@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 06:13:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia1nZ-0000ku-K3
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 06:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280AbXIYENS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 00:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbXIYENS
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 00:13:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45059 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbXIYENR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 00:13:17 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ia1nQ-00073H-AE; Tue, 25 Sep 2007 00:13:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 93E5920FBAE; Tue, 25 Sep 2007 00:13:14 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59088>

Git style tends to prefer "!x" over "x == NULL".  Make it so in
these handful of locations that were not following along.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 remote.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index e3c3df5..ac354f3 100644
--- a/remote.c
+++ b/remote.c
@@ -416,7 +416,7 @@ int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 	int i;
 
 	if (find_src) {
-		if (refspec->dst == NULL)
+		if (!refspec->dst)
 			return error("find_tracking: need either src or dst");
 		needle = refspec->dst;
 		result = &refspec->src;
@@ -613,7 +613,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	if (!matched_src)
 		errs = 1;
 
-	if (dst_value == NULL)
+	if (!dst_value)
 		dst_value = matched_src->name;
 
 	switch (count_refspec_match(dst_value, dst, &matched_dst)) {
@@ -633,7 +633,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		      dst_value);
 		break;
 	}
-	if (errs || matched_dst == NULL)
+	if (errs || !matched_dst)
 		return 1;
 	if (matched_dst->peer_ref) {
 		errs = 1;
-- 
1.5.3.2.124.g2456-dirty
