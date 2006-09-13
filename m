From: Jeff King <peff@peff.net>
Subject: [PATCH] wt-status: remove extraneous newline from 'deleted:' output
Date: Wed, 13 Sep 2006 18:37:14 -0400
Message-ID: <20060913223713.GA6406@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 00:37:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNdM9-000100-Vm
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 00:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWIMWhS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 18:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWIMWhS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 18:37:18 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:30602 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751237AbWIMWhR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 18:37:17 -0400
Received: (qmail 13028 invoked from network); 13 Sep 2006 18:36:26 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 13 Sep 2006 18:36:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2006 18:37:14 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26961>

This was accidentally introduced during the fixes to avoid putting newlines
inside of colorized output.

Signed-off-by: Jeff King <peff@peff.net>
---
 wt-status.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index ec2c728..c90aade 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -77,7 +77,7 @@ static void wt_status_print_filepair(int
 				p->one->path, p->two->path);
 		break;
 	case DIFF_STATUS_DELETED:
-		color_printf_ln(c, "deleted: %s", p->one->path); break;
+		color_printf(c, "deleted: %s", p->one->path); break;
 	case DIFF_STATUS_MODIFIED:
 		color_printf(c, "modified: %s", p->one->path); break;
 	case DIFF_STATUS_RENAMED:
-- 
1.4.2.gd89c-dirty
