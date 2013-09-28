From: Jeff King <peff@peff.net>
Subject: [PATCH 1/9] http_get_file: style fixes
Date: Sat, 28 Sep 2013 04:31:00 -0400
Message-ID: <20130928083059.GA2131@sigill.intra.peff.net>
References: <20130928082956.GA22610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 10:31:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPpvh-0001tB-WB
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 10:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675Ab3I1IbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 04:31:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:35128 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab3I1IbC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 04:31:02 -0400
Received: (qmail 8580 invoked by uid 102); 28 Sep 2013 08:31:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Sep 2013 03:31:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Sep 2013 04:31:00 -0400
Content-Disposition: inline
In-Reply-To: <20130928082956.GA22610@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235490>

Besides being ugly, the extra parentheses are idiomatic for
suppressing compiler warnings when we are assigning within a
conditional. We aren't doing that here, and they just
confuse the reader.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index f3e1439..a985c40 100644
--- a/http.c
+++ b/http.c
@@ -958,7 +958,7 @@ static int http_get_file(const char *url, const char *filename, int options)
 
 	strbuf_addf(&tmpfile, "%s.temp", filename);
 	result = fopen(tmpfile.buf, "a");
-	if (! result) {
+	if (!result) {
 		error("Unable to open local file %s", tmpfile.buf);
 		ret = HTTP_ERROR;
 		goto cleanup;
@@ -967,7 +967,7 @@ static int http_get_file(const char *url, const char *filename, int options)
 	ret = http_request_reauth(url, NULL, result, HTTP_REQUEST_FILE, options);
 	fclose(result);
 
-	if ((ret == HTTP_OK) && move_temp_to_file(tmpfile.buf, filename))
+	if (ret == HTTP_OK && move_temp_to_file(tmpfile.buf, filename))
 		ret = HTTP_ERROR;
 cleanup:
 	strbuf_release(&tmpfile);
-- 
1.8.4.rc3.19.g9da5bf6
