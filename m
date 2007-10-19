From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Thu, 18 Oct 2007 20:45:27 -0400
Message-ID: <20071019004527.GA12930@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 02:46:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iifzo-0002Ww-SN
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 02:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758923AbXJSApc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 20:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756665AbXJSApb
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 20:45:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39982 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185AbXJSApb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 20:45:31 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IifzG-0001WD-UD; Thu, 18 Oct 2007 20:45:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BA6A420FBAE; Thu, 18 Oct 2007 20:45:27 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61585>

Recently I was referred to the Grammar Police as the git-pack-objects
progress message 'Deltifying %u objects' is considered to be not
proper English to at least some small but vocal segment of the
English speaking population.  Techncially we are applying delta
compression to these objects at this stage, so the new term is
slightly more acceptable to the Grammar Police but is also just
as correct.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 To go on top of your 'np/progress' series that is currently in next.
 I think it might keep us out of trouble with certain individuals...

 builtin-pack-objects.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 15d3750..f79fc0b 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1718,7 +1718,7 @@ static void prepare_pack(int window, int depth)
 	if (nr_deltas && n > 1) {
 		unsigned nr_done = 0;
 		if (progress)
-			start_progress(&progress_state, "Deltifying objects",
+			start_progress(&progress_state, "Delta compressing objects",
 					nr_deltas);
 		qsort(delta_list, n, sizeof(*delta_list), type_size_sort);
 		ll_find_deltas(delta_list, n, window+1, depth, &nr_done);
-- 
1.5.3.4.1249.g895be
