From: Jeff King <peff@peff.net>
Subject: [PATCH 2/7] quote.h: fix bogus comment
Date: Tue, 13 Sep 2011 17:57:47 -0400
Message-ID: <20110913215747.GB24490@sigill.intra.peff.net>
References: <20110913215026.GA26743@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 23:57:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3azL-0001Tc-80
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 23:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932901Ab1IMV5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 17:57:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51522
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932834Ab1IMV5t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 17:57:49 -0400
Received: (qmail 1988 invoked by uid 107); 13 Sep 2011 21:58:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 17:58:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2011 17:57:47 -0400
Content-Disposition: inline
In-Reply-To: <20110913215026.GA26743@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181309>

Commit 758e915 made sq_quote_next static, removing it from
quote.h. However, it forgot to update the related comment,
making it appear as a confusing description of sq_quote_to_argv.

Let's remove the crufty bits, and elaborate more on sq_quote_to_argv.

Signed-off-by: Jeff King <peff@peff.net>
---
 quote.h |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/quote.h b/quote.h
index 024e21d..252b0df 100644
--- a/quote.h
+++ b/quote.h
@@ -40,9 +40,8 @@
 
 /*
  * Same as the above, but can be used to unwrap many arguments in the
- * same string separated by space. "next" is changed to point to the
- * next argument that should be passed as first parameter. When there
- * is no more argument to be dequoted, "next" is updated to point to NULL.
+ * same string separated by space. Like sq_quote, it works in place,
+ * modifying arg and appending pointers into it to argv.
  */
 extern int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc);
 
-- 
1.7.7.rc1.2.gb2409
