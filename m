From: Jeff King <peff@peff.net>
Subject: [PATCH 23/25] t7004: fix embedded single-quotes
Date: Fri, 20 Mar 2015 06:13:29 -0400
Message-ID: <20150320101328.GW12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:13:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtvw-00064y-6F
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbbCTKNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:13:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:35729 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752070AbbCTKNb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:13:31 -0400
Received: (qmail 5948 invoked by uid 102); 20 Mar 2015 10:13:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:13:31 -0500
Received: (qmail 21727 invoked by uid 107); 20 Mar 2015 10:13:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:13:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:13:29 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265899>

This test uses single quotes inside the single-quoted test
snippet, which effectively makes the contents unquoted.
Since they don't need quoted anyway, this isn't a problem,
but let's switch them to double-quotes to make it more
obviously correct.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7004-tag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 347d3be..efb08c3 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1181,7 +1181,7 @@ test_expect_success \
 	'message in editor has initial comment: remainder' '
 	# remove commented lines from the remainder -- should be empty
 	>rest.expect &&
-	sed -e 1d -e '/^#/d' <actual >rest.actual &&
+	sed -e 1d -e "/^#/d" <actual >rest.actual &&
 	test_cmp rest.expect rest.actual
 '
 
-- 
2.3.3.520.g3cfbb5d
