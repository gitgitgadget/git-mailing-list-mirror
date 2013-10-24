From: Jeff King <peff@peff.net>
Subject: [PATCH] drop redundant semicolon in empty while
Date: Thu, 24 Oct 2013 04:42:17 -0400
Message-ID: <20131024084217.GA4748@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 10:42:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZGUp-0005ud-U3
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 10:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064Ab3JXImU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 04:42:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:54640 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753875Ab3JXImT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 04:42:19 -0400
Received: (qmail 6219 invoked by uid 102); 24 Oct 2013 08:42:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 03:42:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Oct 2013 04:42:17 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236572>

The extra semi-colon is harmless, since we really do want
the while loop to do nothing. But it does trigger a warning
from clang.

Signed-off-by: Jeff King <peff@peff.net>
---
 date.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 29f1540..83b4166 100644
--- a/date.c
+++ b/date.c
@@ -907,7 +907,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 	const char *end = date;
 	int i;
 
-	while (isalpha(*++end));
+	while (isalpha(*++end))
 		;
 
 	for (i = 0; i < 12; i++) {
-- 
1.8.4.1.898.g8bf8a41.dirty
