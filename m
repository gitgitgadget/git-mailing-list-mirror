From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/4] strbuf_split*(): document functions
Date: Sun,  4 Nov 2012 07:46:54 +0100
Message-ID: <1352011614-29334-5-git-send-email-mhagger@alum.mit.edu>
References: <1352011614-29334-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 07:47:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUtzp-0006Ts-8b
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 07:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab2KDGrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 01:47:36 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:53396 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752037Ab2KDGre (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2012 01:47:34 -0500
X-AuditID: 1207440f-b7fde6d00000095c-2c-50960f85a8b0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id DE.F2.02396.58F06905; Sun,  4 Nov 2012 01:47:33 -0500 (EST)
Received: from michael.fritz.box (p57A25973.dip.t-dialin.net [87.162.89.115])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA46lFQs027771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 4 Nov 2012 01:47:32 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352011614-29334-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqNvKPy3AoPWAuUXXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE749y0dtaC
	79IVHfOmszcwnhfrYuTkkBAwkVjduIoNwhaTuHBvPZDNxSEkcJlRouX4LSjnDJPEt6mNTCBV
	bAK6Eot6msFsEQFZie+HNzKC2MwCuRKL391mB7GFBSwkeqb+YQGxWQRUJb6cOAJUw8HBK+Ai
	8empF8QyOYkPex6BlXMKuErcO3UArFwIqOTi7WUsExh5FzAyrGKUS8wpzdXNTczMKU5N1i1O
	TszLSy3SNdHLzSzRS00p3cQICR/+HYxd62UOMQpwMCrx8C5cNjVAiDWxrLgy9xCjJAeTkijv
	V85pAUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeLd8BirnTUmsrEotyodJSXOwKInzqi9R9xMS
	SE8sSc1OTS1ILYLJynBwKEnw7uEDGipYlJqeWpGWmVOCkGbi4AQRXCAbeIA2HAAp5C0uSMwt
	zkyHKDrFqCglzrsdJCEAksgozYMbAIv0V4ziQP8IQ7TzAJMEXPcroMFMQIO3X5oCMrgkESEl
	1cCotTnT77+Y0q0dU2MMW6siDR/qZF9O1di+q9OUZfUPOb154bO6TtSpdcezxUwRrjxVLr1N
	k1HD8+eTDY2R3E3OaRndp45Ov3L+TZ1yopqM9GMuHtUT7asc3uT0PJx+IrD0TM5K7kX743j/
	aevrp0Z8S7LX3rne98XzjJCn73rkmyxlb8r6z1NiKc5INNRiLipOBAAmwgVjzwIA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209013>

Document strbuf_split_buf(), strbuf_split_str(), strbuf_split_max(),
strbuf_split(), and strbuf_list_free() in the header file and in
api-strbuf.txt.  (These functions were previously completely
undocumented.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-strbuf.txt | 16 ++++++++++++++++
 strbuf.h                               | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index 95a8bf3..84686b5 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -279,6 +279,22 @@ same behaviour as well.
 	Strip whitespace from a buffer. The second parameter controls if
 	comments are considered contents to be removed or not.
 
+`strbuf_split_buf`::
+`strbuf_split_str`::
+`strbuf_split_max`::
+`strbuf_split`::
+
+	Split a string or strbuf into a list of strbufs at a specified
+	terminator character.  The returned substrings include the
+	terminator characters.  Some of these functions take a `max`
+	parameter, which, if positive, limits the output to that
+	number of substrings.
+
+`strbuf_list_free`::
+
+	Free a list of strbufs (for example, the return values of the
+	`strbuf_split()` functions).
+
 `launch_editor`::
 
 	Launch the user preferred editor to edit a file and fill the buffer
diff --git a/strbuf.h b/strbuf.h
index c896a47..aa386c6 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -44,23 +44,56 @@ extern void strbuf_rtrim(struct strbuf *);
 extern void strbuf_ltrim(struct strbuf *);
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 
+/*
+ * Split str (of length slen) at the specified terminator character.
+ * Return a null-terminated array of pointers to strbuf objects
+ * holding the substrings.  The substrings include the terminator,
+ * except for the last substring, which might be unterminated if the
+ * original string did not end with a terminator.  If max is positive,
+ * then split the string into at most max substrings (with the last
+ * substring containing everything following the (max-1)th terminator
+ * character).
+ *
+ * For lighter-weight alternatives, see string_list_split() and
+ * string_list_split_in_place().
+ */
 extern struct strbuf **strbuf_split_buf(const char *, size_t,
 					int terminator, int max);
+
+/*
+ * Split a NUL-terminated string at the specified terminator
+ * character.  See strbuf_split_buf() for more information.
+ */
 static inline struct strbuf **strbuf_split_str(const char *str,
 					       int terminator, int max)
 {
 	return strbuf_split_buf(str, strlen(str), terminator, max);
 }
+
+/*
+ * Split a strbuf at the specified terminator character.  See
+ * strbuf_split_buf() for more information.
+ */
 static inline struct strbuf **strbuf_split_max(const struct strbuf *sb,
 						int terminator, int max)
 {
 	return strbuf_split_buf(sb->buf, sb->len, terminator, max);
 }
+
+/*
+ * Split a strbuf at the specified terminator character.  See
+ * strbuf_split_buf() for more information.
+ */
 static inline struct strbuf **strbuf_split(const struct strbuf *sb,
 					   int terminator)
 {
 	return strbuf_split_max(sb, terminator, 0);
 }
+
+/*
+ * Free a NULL-terminated list of strbufs (for example, the return
+ * values of the strbuf_split*() functions).
+ */
 extern void strbuf_list_free(struct strbuf **);
 
 /*----- add data in your buffer -----*/
-- 
1.8.0
