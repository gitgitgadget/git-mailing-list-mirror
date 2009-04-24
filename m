From: Jeff King <peff@peff.net>
Subject: [PATCH] t7800: respect NO_PERL
Date: Fri, 24 Apr 2009 09:56:14 -0400
Message-ID: <20090424135614.GA10761@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 16:01:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxLud-0006Ii-Fr
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 15:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884AbZDXN4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 09:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756223AbZDXN4V
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 09:56:21 -0400
Received: from peff.net ([208.65.91.99]:40809 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755575AbZDXN4U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 09:56:20 -0400
Received: (qmail 28536 invoked by uid 107); 24 Apr 2009 13:56:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 09:56:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 09:56:14 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117437>

Difftool is written in perl, so we don't build it if NO_PERL
is set.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7800-difftool.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 2586f86..ebdccf9 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -10,6 +10,11 @@ Testing basic diff tool invocation
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL; then
+	say 'skipping difftool tests, perl not available'
+	test_done
+fi
+
 remove_config_vars()
 {
 	# Unset all config variables used by git-difftool
-- 
1.6.3.rc1.226.ga8d61c
