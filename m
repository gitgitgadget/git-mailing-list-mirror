From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] strbuf.h: format asciidoc code blocks as 4-space indent
Date: Fri, 12 Dec 2014 16:30:56 -0500
Message-ID: <20141212213055.GC27451@peff.net>
References: <20141212212726.GA26284@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 22:31:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzXnh-0000d0-M4
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 22:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbaLLVa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 16:30:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:52322 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750948AbaLLVa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 16:30:57 -0500
Received: (qmail 20025 invoked by uid 102); 12 Dec 2014 21:30:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 15:30:57 -0600
Received: (qmail 14311 invoked by uid 107); 12 Dec 2014 21:31:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 16:31:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Dec 2014 16:30:56 -0500
Content-Disposition: inline
In-Reply-To: <20141212212726.GA26284@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261377>

This is much easier to read when the whole thing is stuffed
inside a comment block. And there is precedent for this
convention in markdown (and just in general ascii text).

Signed-off-by: Jeff King <peff@peff.net>
---
As a side note, I actually find markdown much more pleasant to read and
write than asciidoc. I think the output is not always as nice, as it
does not have some of the structured elements that let us produce nice
manpages, for example. But I wonder if it would be a better choice for
formatting API documentation.

Not something that is really relevant to this series, but just food for
thought if we do end up with an extract+format tool.

 strbuf.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 8f63b38..078b805 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -33,10 +33,9 @@
  *    NOTE: It is OK to "play" with the buffer directly if you work it this
  *    way:
  *
- *    ----
- *    strbuf_grow(sb, SOME_SIZE); <1>
- *    strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
- *    ----
+ *        strbuf_grow(sb, SOME_SIZE); <1>
+ *        strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
+ *
  *    <1> Here, the memory array starting at `sb->buf`, and of length
  *    `strbuf_avail(sb)` is all yours, and you can be sure that
  *    `strbuf_avail(sb)` is at least `SOME_SIZE`.
@@ -261,9 +260,7 @@ extern void strbuf_add(struct strbuf *, const void *, size_t);
  * NOTE: This function will *always* be implemented as an inline or a macro
  * using strlen, meaning that this is efficient to write things like:
  *
- * ----
- * strbuf_addstr(sb, "immediate string");
- * ----
+ *     strbuf_addstr(sb, "immediate string");
  *
  */
 static inline void strbuf_addstr(struct strbuf *sb, const char *s)
-- 
2.2.0.454.g7eca6b7
