From: Jeff King <peff@peff.net>
Subject: [PATCH 5/7] strbuf.h: reorganize api function grouping headers
Date: Fri, 16 Jan 2015 04:05:28 -0500
Message-ID: <20150116090528.GE31113@peff.net>
References: <20150116090225.GA30797@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 10:05:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YC2qf-0003qy-RE
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 10:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbbAPJFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 04:05:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:35436 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752082AbbAPJFb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 04:05:31 -0500
Received: (qmail 2997 invoked by uid 102); 16 Jan 2015 09:05:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 03:05:31 -0600
Received: (qmail 23504 invoked by uid 107); 16 Jan 2015 09:05:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 04:05:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jan 2015 04:05:28 -0500
Content-Disposition: inline
In-Reply-To: <20150116090225.GA30797@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262544>

The original API doc had something like:

    Functions
    ---------

    * Life cycle

      ... some life-cycle functions ...

    * Related to the contents of the buffer

      ... functions related to contents ....

    etc

This grouping can be hard to read in the comment sources,
given the "*" in the comment lines, and the amount of text
between each section.

Instead, let's make a flat list of groupings, and underline
each as a section header. That makes them stand out, and
eliminates the weird half-phrase of "Related to...". Like:

    Functions related to the contents of the buffer
    -----------------------------------------------

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index caa4dad..6fa7156 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -71,12 +71,8 @@ extern char strbuf_slopbuf[];
 #define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
 
 /**
- * Functions
- * ---------
- */
-
-/**
- * * Life Cycle
+ * Life Cycle Functions
+ * --------------------
  */
 
 /**
@@ -120,7 +116,8 @@ static inline void strbuf_swap(struct strbuf *a, struct strbuf *b)
 
 
 /**
- * * Related to the size of the buffer
+ * Functions related to the size of the buffer
+ * -------------------------------------------
  */
 
 /**
@@ -162,7 +159,8 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 
 
 /**
- * * Related to the contents of the buffer
+ * Functions related to the contents of the buffer
+ * -----------------------------------------------
  */
 
 /**
@@ -201,7 +199,8 @@ extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 
 
 /**
- * * Adding data to the buffer
+ * Adding data to the buffer
+ * -------------------------
  *
  * NOTE: All of the functions in this section will grow the buffer as
  * necessary.  If they fail for some reason other than memory shortage and the
-- 
2.2.1.425.g441bb3c
