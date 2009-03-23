From: Jeff King <peff@peff.net>
Subject: [PATCH] t0060: fix whitespace in "wc -c" invocation
Date: Mon, 23 Mar 2009 02:22:29 -0400
Message-ID: <20090323062229.GA5535@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 07:24:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LldZv-0001dN-6g
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 07:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbZCWGWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 02:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754122AbZCWGWf
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 02:22:35 -0400
Received: from peff.net ([208.65.91.99]:39357 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753700AbZCWGWf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 02:22:35 -0400
Received: (qmail 19010 invoked by uid 107); 23 Mar 2009 06:22:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Mar 2009 02:22:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Mar 2009 02:22:29 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114244>

Some platforms like to stick extra whitespace in the output
of "wc -c"; using the result without quotes gets the shell
to collapse the whitespace.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of 'next'.

I noticed the breakage on Solaris; I suspect AIX is broken, too.

 t/t0060-path-utils.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 86000e2..53cf1f8 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -17,7 +17,7 @@ norm_path() {
 # which means that the path / accounts for this many characters:
 rootoff=$(test-path-utils normalize_path_copy / | wc -c)
 # Account for the trailing LF:
-if test "$rootoff" = 2; then
+if test $rootoff = 2; then
 	rootoff=	# we are on Unix
 else
 	rootoff=$(($rootoff-1))
-- 
1.6.2.1.276.gd47fa
