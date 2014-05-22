From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/8] test-lib: preserve GIT_CURL_VERBOSE from the
 environment
Date: Thu, 22 May 2014 05:28:50 -0400
Message-ID: <20140522092849.GA15032@sigill.intra.peff.net>
References: <20140522092824.GA14530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 11:28:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnPJ2-00027Y-8j
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 11:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052AbaEVJ2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 05:28:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:57231 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752805AbaEVJ2w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 05:28:52 -0400
Received: (qmail 11501 invoked by uid 102); 22 May 2014 09:28:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 04:28:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 05:28:50 -0400
Content-Disposition: inline
In-Reply-To: <20140522092824.GA14530@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249886>

Turning on this variable can be useful when debugging http
tests. It does break a few tests in t5541, but it is not
a variable that the user is likely to have enabled
accidentally.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c081668..f7e55b1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -91,6 +91,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
 		VALGRIND
 		UNZIP
 		PERF_
+		CURL_VERBOSE
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
-- 
2.0.0.rc1.436.g03cb729
