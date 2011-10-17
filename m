From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] use test number as port number
Date: Mon, 17 Oct 2011 21:55:47 +0200
Message-ID: <20111017195547.GB29479@ecki>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
 <20111017020103.GA18536@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 17 21:55:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFtHP-00054K-By
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 21:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624Ab1JQTzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 15:55:17 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:3333 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751238Ab1JQTzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 15:55:16 -0400
Received: from localhost (p5B22F233.dip.t-dialin.net [91.34.242.51])
	by bsmtp.bon.at (Postfix) with ESMTP id 4C799A7EBB;
	Mon, 17 Oct 2011 21:54:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20111017020103.GA18536@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183815>

Test 5550 was apparently using the default port number by mistake.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Sun, Oct 16, 2011 at 10:01:03PM -0400, Jeff King wrote:
> 
> LIB_DAEMON_PORT=${LIB_DAEMON_PORT-'5570'}

Thanks, I missed that.

Clemens

 t/t5550-http-fetch.sh |    2 +-
 t/t5570-git-daemon.sh |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index a1883ca..8a77750 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -8,8 +8,8 @@ if test -n "$NO_CURL"; then
 	test_done
 fi
 
-. "$TEST_DIRECTORY"/lib-httpd.sh
 LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5550'}
+. "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
 test_expect_success 'setup repository' '
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index e6482eb..a92d996 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -3,6 +3,7 @@
 test_description='test fetching over git protocol'
 . ./test-lib.sh
 
+LIB_DAEMON_PORT=${LIB_DAEMON_PORT-'5570'}
 . "$TEST_DIRECTORY"/lib-daemon.sh
 start_daemon
 
-- 
1.7.7
