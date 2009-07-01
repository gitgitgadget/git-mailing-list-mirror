From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] log-tree: fix confusing comment
Date: Wed, 1 Jul 2009 03:26:28 -0400
Message-ID: <20090701072628.GA8101@sigio.peff.net>
References: <20090701070252.GA7987@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 09:24:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLuBV-0005HT-Kf
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 09:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983AbZGAHYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 03:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752575AbZGAHYf
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 03:24:35 -0400
Received: from peff.net ([208.65.91.99]:50424 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520AbZGAHYe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 03:24:34 -0400
Received: (qmail 8111 invoked by uid 1000); 1 Jul 2009 07:26:28 -0000
Content-Disposition: inline
In-Reply-To: <20090701070252.GA7987@sigio.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122569>

This comment mentions the case where use_terminator is set,
but this case is not handled at all by this chunk of code.

Signed-off-by: Jeff King <peff@peff.net>
---
This comment confused me quite a bit while tracking down the issue in
2/2.

 log-tree.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 59d63eb..6f73c17 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -321,7 +321,8 @@ void show_log(struct rev_info *opt)
 	}
 
 	/*
-	 * If use_terminator is set, add a newline at the end of the entry.
+	 * If use_terminator is set, we already handled any record termination
+	 * at the end of the last record.
 	 * Otherwise, add a diffopt.line_termination character before all
 	 * entries but the first.  (IOW, as a separator between entries)
 	 */
-- 
1.6.3.3.485.g0f5d4.dirty
