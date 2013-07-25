From: Jeff King <peff@peff.net>
Subject: [PATCH] commit.h: drop redundant comment
Date: Thu, 25 Jul 2013 16:01:00 -0400
Message-ID: <20130725200059.GA1225@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 25 22:01:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2Ril-0000yf-H0
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 22:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756524Ab3GYUBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 16:01:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:50970 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756080Ab3GYUBC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 16:01:02 -0400
Received: (qmail 3896 invoked by uid 102); 25 Jul 2013 20:01:02 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Jul 2013 15:01:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Jul 2013 16:01:00 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231147>

We mention twice that the from_ident field of struct
pretty_print_context is internal.

The first comment was added by 10f2fbf, which prepares the
struct for internal fields, and then the second by a908047,
which actually adds such a field. This was a mistake made
when re-rolling the series on the list; the comment should
have been removed from the latter commit.

Signed-off-by: Jeff King <peff@peff.net>
---
Not that important, really. I only bothered tracking down the source of
the error because I was curious if it was a mis-merge or something. But
nope, just me screwing up, and missing it in review.

 commit.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/commit.h b/commit.h
index 35cc4e2..d912a9d 100644
--- a/commit.h
+++ b/commit.h
@@ -102,8 +102,6 @@ struct pretty_print_context {
 	 * Fields below here are manipulated internally by pp_* functions and
 	 * should not be counted on by callers.
 	 */
-
-	/* Manipulated by the pp_* functions internally. */
 	struct string_list in_body_headers;
 };
 
-- 
1.8.3.rc1.30.gff0fb75
