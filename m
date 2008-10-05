From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] t4012: use test_cmp instead of cmp
Date: Sun, 5 Oct 2008 17:42:35 -0400
Message-ID: <20081005214235.GA21925@coredump.intra.peff.net>
References: <20081005214114.GA21875@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Oct 05 23:43:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmbOF-0001aj-Pl
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 23:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548AbYJEVmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 17:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754667AbYJEVmh
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 17:42:37 -0400
Received: from peff.net ([208.65.91.99]:2843 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754348AbYJEVmh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 17:42:37 -0400
Received: (qmail 17850 invoked by uid 111); 5 Oct 2008 21:42:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 05 Oct 2008 17:42:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Oct 2008 17:42:35 -0400
Content-Disposition: inline
In-Reply-To: <20081005214114.GA21875@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97538>

This makes erroneous output slightly easier to see. We also
flip the argument order to match our usual style.

Signed-off-by: Jeff King <peff@peff.net>
---
Just a cleanup I noticed while testing.

 t/t4012-diff-binary.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index b8ec6e9..0f954a3 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -25,11 +25,11 @@ cat > expected <<\EOF
 EOF
 test_expect_success 'diff without --binary' \
 	'git diff | git apply --stat --summary >current &&
-	 cmp current expected'
+	 test_cmp expected current'
 
 test_expect_success 'diff with --binary' \
 	'git diff --binary | git apply --stat --summary >current &&
-	 cmp current expected'
+	 test_cmp expected current'
 
 # apply needs to be able to skip the binary material correctly
 # in order to report the line number of a corrupt patch.
-- 
1.6.0.2.639.g4d7f.dirty
