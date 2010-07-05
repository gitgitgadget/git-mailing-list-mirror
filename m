From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 3/4] default core.clockskew variable to one day
Date: Mon, 5 Jul 2010 08:35:34 -0400
Message-ID: <20100705123533.GC25699@sigill.intra.peff.net>
References: <20100705122723.GB21146@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Mon Jul 05 14:35:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVkti-0002th-K8
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 14:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758574Ab0GEMfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 08:35:38 -0400
Received: from peff.net ([208.65.91.99]:38149 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758535Ab0GEMfg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 08:35:36 -0400
Received: (qmail 12196 invoked by uid 107); 5 Jul 2010 12:36:32 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 05 Jul 2010 08:36:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jul 2010 08:35:34 -0400
Content-Disposition: inline
In-Reply-To: <20100705122723.GB21146@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150264>

This is the slop value used by name-rev, so presumably is a
reasonable default.

Signed-off-by: Jeff King <peff@peff.net>
---
Actually, I think auto-detecting the skew in a repo during "gc" might be
an even better default. See:

  http://article.gmane.org/gmane.comp.version-control.git/150260

earlier in this thread for some numbers and discussion.

 commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/commit.c b/commit.c
index c849b50..4cbe756 100644
--- a/commit.c
+++ b/commit.c
@@ -7,7 +7,7 @@
 #include "revision.h"
 #include "notes.h"
 
-int core_clock_skew = -1;
+int core_clock_skew = 86400;
 int save_commit_buffer = 1;
 
 const char *commit_type = "commit";
-- 
1.7.2.rc1.209.g2a36c
