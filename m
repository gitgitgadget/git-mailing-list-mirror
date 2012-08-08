From: Jeff King <peff@peff.net>
Subject: [PATCH 6/4] check-docs: list git-gui as a command
Date: Wed, 8 Aug 2012 16:56:42 -0400
Message-ID: <20120808205642.GB12838@sigill.intra.peff.net>
References: <20120808205456.GB29528@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 22:56:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzDJF-0004tU-37
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 22:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758516Ab2HHU4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 16:56:48 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57685 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482Ab2HHU4r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 16:56:47 -0400
Received: (qmail 11666 invoked by uid 107); 8 Aug 2012 20:56:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Aug 2012 16:56:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2012 16:56:42 -0400
Content-Disposition: inline
In-Reply-To: <20120808205456.GB29528@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203128>

git-gui is already documented and mentioned in command-list,
but adding it to the Makefile makes sure it is so. We also
add its alias git-citool (which is also documented).

As a result, we can drop them from the special case
statement that avoids them being listed as "documented but
does not exist".

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 6ae868d..4b3c366 100644
--- a/Makefile
+++ b/Makefile
@@ -2808,6 +2808,7 @@ ALL_COMMANDS = $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS)
 ALL_COMMANDS += git
 ALL_COMMANDS += gitk
 ALL_COMMANDS += gitweb
+ALL_COMMANDS += git-gui git-citool
 check-docs::
 	@(for v in $(ALL_COMMANDS); \
 	do \
@@ -2837,8 +2838,6 @@ check-docs::
 	) | while read how cmd; \
 	do \
 		case "$$how,$$cmd" in \
-		*,git-citool | \
-		*,git-gui | \
 		*,git-help | \
 		documented,gitattributes | \
 		documented,gitignore | \
-- 
1.7.12.rc2.36.gb1dc81b
