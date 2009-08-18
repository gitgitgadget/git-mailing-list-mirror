From: Jeff King <peff@peff.net>
Subject: [PATCH] tests: disable interactive hunk selection tests if perl
 not available
Date: Tue, 18 Aug 2009 02:12:44 -0400
Message-ID: <20090818061244.GA20659@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 08:12:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdHwC-00034J-Dj
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 08:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbZHRGMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 02:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbZHRGMn
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 02:12:43 -0400
Received: from peff.net ([208.65.91.99]:44488 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbZHRGMm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 02:12:42 -0400
Received: (qmail 8328 invoked by uid 107); 18 Aug 2009 06:12:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 18 Aug 2009 02:12:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Aug 2009 02:12:44 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126351>

These are all backed by git-add--interactive.perl under the
hood.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of tr/reset-checkout-patch.

 t/lib-patch-mode.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/lib-patch-mode.sh b/t/lib-patch-mode.sh
index afb4b66..75a3ee2 100755
--- a/t/lib-patch-mode.sh
+++ b/t/lib-patch-mode.sh
@@ -1,5 +1,10 @@
 . ./test-lib.sh
 
+if ! test_have_prereq PERL; then
+	say 'skipping --patch tests, perl not available'
+	test_done
+fi
+
 set_state () {
 	echo "$3" > "$1" &&
 	git add "$1" &&
-- 
1.6.4.301.g8099b
