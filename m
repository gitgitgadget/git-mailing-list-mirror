From: Jeff King <peff@peff.net>
Subject: [PATCH 3/7] cat-file: move batch_options definition to top of file
Date: Mon, 22 Jun 2015 06:41:03 -0400
Message-ID: <20150622104102.GC14475@peff.net>
References: <20150622103321.GB12584@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 12:41:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6zA6-00049d-IH
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 12:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbbFVKlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 06:41:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:49767 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753401AbbFVKlF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 06:41:05 -0400
Received: (qmail 17210 invoked by uid 102); 22 Jun 2015 10:41:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 05:41:06 -0500
Received: (qmail 7479 invoked by uid 107); 22 Jun 2015 10:41:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 06:41:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2015 06:41:03 -0400
Content-Disposition: inline
In-Reply-To: <20150622103321.GB12584@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272326>

That way all of the functions can make use of it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 6cbcccc..d4101b7 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -10,6 +10,13 @@
 #include "streaming.h"
 #include "tree-walk.h"
 
+struct batch_options {
+	int enabled;
+	int follow_symlinks;
+	int print_contents;
+	const char *format;
+};
+
 static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			int unknown_type)
 {
@@ -232,12 +239,6 @@ static void print_object_or_die(int fd, struct expand_data *data)
 	}
 }
 
-struct batch_options {
-	int enabled;
-	int follow_symlinks;
-	int print_contents;
-	const char *format;
-};
 
 static int batch_one_object(const char *obj_name, struct batch_options *opt,
 			    struct expand_data *data)
-- 
2.4.4.719.g3984bc6
