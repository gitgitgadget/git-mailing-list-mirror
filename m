From: Jeff King <peff@peff.net>
Subject: [PATCH 7/4] check-docs: drop git-help special-case
Date: Wed, 8 Aug 2012 16:57:13 -0400
Message-ID: <20120808205713.GC12838@sigill.intra.peff.net>
References: <20120808205456.GB29528@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 22:57:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzDJq-0005sn-Sv
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 22:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759304Ab2HHU5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 16:57:21 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57689 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482Ab2HHU5T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 16:57:19 -0400
Received: (qmail 11696 invoked by uid 107); 8 Aug 2012 20:57:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Aug 2012 16:57:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2012 16:57:13 -0400
Content-Disposition: inline
In-Reply-To: <20120808205456.GB29528@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203129>

The check-docs target special-cases git-help to avoid
mentioning it as "documented but removed". This dates back
to the early implementation of git-help, when its code was
simply included inside git.c.

These days it is a full-fledged builtin (in builtin/help.c)
and does not need special-casing.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4b3c366..b9da511 100644
--- a/Makefile
+++ b/Makefile
@@ -2838,7 +2838,6 @@ check-docs::
 	) | while read how cmd; \
 	do \
 		case "$$how,$$cmd" in \
-		*,git-help | \
 		documented,gitattributes | \
 		documented,gitignore | \
 		documented,gitmodules | \
-- 
1.7.12.rc2.36.gb1dc81b
