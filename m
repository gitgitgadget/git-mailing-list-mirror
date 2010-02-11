From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] cherry-pick: rewrap advice message
Date: Thu, 11 Feb 2010 16:06:01 -0500
Message-ID: <20100211210601.GA9066@coredump.intra.peff.net>
References: <20100211210445.GA8819@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 22:06:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfgEv-00050W-5e
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 22:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205Ab0BKVGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 16:06:01 -0500
Received: from peff.net ([208.65.91.99]:51468 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757196Ab0BKVF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 16:05:59 -0500
Received: (qmail 22003 invoked by uid 107); 11 Feb 2010 21:06:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 11 Feb 2010 16:06:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2010 16:06:01 -0500
Content-Disposition: inline
In-Reply-To: <20100211210445.GA8819@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139625>

The current message overflows on an 80-character terminal.
While we're at it, fix the spelling of 'committing'.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-revert.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 8ac86f0..83e5c0a 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -213,13 +213,13 @@ static char *help_msg(const unsigned char *sha1)
 		return msg;
 
 	strcpy(helpbuf, "  After resolving the conflicts,\n"
-	       "mark the corrected paths with 'git add <paths>' "
-	       "or 'git rm <paths>' and commit the result.");
+		"mark the corrected paths with 'git add <paths>' or 'git rm <paths>'\n"
+		"and commit the result.");
 
 	if (action == CHERRY_PICK) {
 		sprintf(helpbuf + strlen(helpbuf),
-			"\nWhen commiting, use the option "
-			"'-c %s' to retain authorship and message.",
+			"  When committing, use the option '-c %s'\n"
+			"to retain authorship and message.",
 			find_unique_abbrev(sha1, DEFAULT_ABBREV));
 	}
 	return helpbuf;
-- 
1.7.0.rc2.40.g33ed2.dirty
