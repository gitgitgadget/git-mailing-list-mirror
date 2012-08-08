From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] check-docs: mention gitweb specially
Date: Wed, 8 Aug 2012 14:32:37 -0400
Message-ID: <20120808183236.GA24574@sigill.intra.peff.net>
References: <20120808183132.GA24550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 20:32:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzB3n-0006qn-QF
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 20:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542Ab2HHScn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 14:32:43 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57530 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182Ab2HHScm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 14:32:42 -0400
Received: (qmail 9504 invoked by uid 107); 8 Aug 2012 18:32:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Aug 2012 14:32:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2012 14:32:37 -0400
Content-Disposition: inline
In-Reply-To: <20120808183132.GA24550@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203109>

Like gitk, gitweb is not listed in the usual Makefile
variables and must be fed to check-docs specially. Otherwise
check-docs thinks it is documented but removed.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 15d1319..5e773cd 100644
--- a/Makefile
+++ b/Makefile
@@ -2805,7 +2805,7 @@ endif
 ### Check documentation
 #
 check-docs::
-	@(for v in $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git gitk; \
+	@(for v in $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git gitk gitweb; \
 	do \
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
@@ -2855,7 +2855,7 @@ check-docs::
 		documented,gitworkflows | \
 		sentinel,not,matching,is,ok ) continue ;; \
 		esac; \
-		case " $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git gitk " in \
+		case " $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git gitk gitweb " in \
 		*" $$cmd "*)	;; \
 		*) echo "removed but $$how: $$cmd" ;; \
 		esac; \
-- 
1.7.12.rc2.2.g584e0d9
