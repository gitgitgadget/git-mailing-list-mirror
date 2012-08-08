From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] check-docs: update non-command documentation list
Date: Wed, 8 Aug 2012 14:34:33 -0400
Message-ID: <20120808183433.GB24574@sigill.intra.peff.net>
References: <20120808183132.GA24550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 20:34:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzB5h-0001Ot-29
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 20:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795Ab2HHSek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 14:34:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57539 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932561Ab2HHSej (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 14:34:39 -0400
Received: (qmail 9562 invoked by uid 107); 8 Aug 2012 18:34:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Aug 2012 14:34:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2012 14:34:33 -0400
Content-Disposition: inline
In-Reply-To: <20120808183132.GA24550@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203111>

The check-docs target looks at Documentation/git*txt and
complains if any entry does not have a matching command.
Therefore we need to explicitly ignore any entries which are
not meant to describe a command (like gitattributes.txt).
This list has grown stale over time, so let's bring it up to
date.

Signed-off-by: Jeff King <peff@peff.net>
---
I really wonder if we would do better to match git-*.txt, since most of
the ignores are gitfoo(7) types of pages. We'd probably want to add back
in "git", "gitweb" and "gitk" explicitly, but they are already handled
specially above and below.

 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 5e773cd..41d9db8 100644
--- a/Makefile
+++ b/Makefile
@@ -2853,6 +2853,9 @@ check-docs::
 		documented,git-bisect-lk2009 | \
 		documented,git-remote-helpers | \
 		documented,gitworkflows | \
+		documented,gitcredentials | \
+		documented,gitnamespaces | \
+		documented,gitweb.conf | \
 		sentinel,not,matching,is,ok ) continue ;; \
 		esac; \
 		case " $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git gitk gitweb " in \
-- 
1.7.12.rc2.2.g584e0d9
