From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] t5550: fix typo in $HTTPD_URL
Date: Thu, 28 Apr 2016 09:36:37 -0400
Message-ID: <20160428133636.GA25319@sigill.intra.peff.net>
References: <20160428133534.GA19056@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>, Jens.Lehmann@web.de
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 15:36:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avm7Y-0004VP-KH
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 15:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbcD1Ngk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 09:36:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:58286 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751837AbcD1Ngk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 09:36:40 -0400
Received: (qmail 25528 invoked by uid 102); 28 Apr 2016 13:36:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:36:39 -0400
Received: (qmail 9562 invoked by uid 107); 28 Apr 2016 13:36:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:36:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 09:36:37 -0400
Content-Disposition: inline
In-Reply-To: <20160428133534.GA19056@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292876>

Commit 14111fc (git: submodule honor -c credential.* from
command line, 2016-02-29) accidentally wrote $HTTP_URL. It
happened to work because we ended up with "credential..helper",
which we treat the same as "credential.helper", applying it
to all URLs.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5550-http-fetch-dumb.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 48e2ab6..81cc57f 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -103,7 +103,7 @@ test_expect_success 'cmdline credential config passes into submodules' '
 	test_must_fail git clone --recursive super super-clone &&
 	rm -rf super-clone &&
 	set_askpass wrong pass@host &&
-	git -c "credential.$HTTP_URL.username=user@host" \
+	git -c "credential.$HTTPD_URL.username=user@host" \
 		clone --recursive super super-clone &&
 	expect_askpass pass user@host
 '
-- 
2.8.1.617.gbdccc2d
