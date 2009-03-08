From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] t3000: use test_cmp instead of diff
Date: Sat, 7 Mar 2009 20:22:07 -0500
Message-ID: <20090308012206.GA18714@coredump.intra.peff.net>
References: <20090308012049.GA18616@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 02:24:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg7l7-0001mL-J5
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 02:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbZCHBWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 20:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbZCHBWU
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 20:22:20 -0500
Received: from peff.net ([208.65.91.99]:53701 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736AbZCHBWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 20:22:19 -0500
Received: (qmail 18487 invoked by uid 107); 8 Mar 2009 01:22:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Mar 2009 20:22:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Mar 2009 20:22:07 -0500
Content-Disposition: inline
In-Reply-To: <20090308012049.GA18616@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112605>

These ancient tests predate test_cmp.

While we're at it, let's switch to our usual "expected
before actual" order of arguments; this makes the diff
output "here's what is changed from expected" instead of the
reverse.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3000-ls-files-others.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index bc0a351..36eee0f 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -42,7 +42,7 @@ test_expect_success \
 
 test_expect_success \
     'git ls-files --others should pick up symlinks.' \
-    'diff output expected1'
+    'test_cmp expected1 output'
 
 test_expect_success \
     'git ls-files --others --directory to show output.' \
@@ -51,6 +51,6 @@ test_expect_success \
 
 test_expect_success \
     'git ls-files --others --directory should not get confused.' \
-    'diff output expected2'
+    'test_cmp expected2 output'
 
 test_done
-- 
1.6.2.198.ge2a58
