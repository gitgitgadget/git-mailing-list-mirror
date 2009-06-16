From: Jeff King <peff@peff.net>
Subject: [PATCH v2 2/2] Makefile: use compat regex on Solaris
Date: Tue, 16 Jun 2009 15:08:21 -0400
Message-ID: <20090616190821.GB23197@coredump.intra.peff.net>
References: <20090616190550.GA22905@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Bito <jwbito@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 16 21:08:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGe1H-0007ir-MB
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 21:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760846AbZFPTIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 15:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760418AbZFPTIW
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 15:08:22 -0400
Received: from peff.net ([208.65.91.99]:33638 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759965AbZFPTIV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 15:08:21 -0400
Received: (qmail 5945 invoked by uid 107); 16 Jun 2009 19:10:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Jun 2009 15:10:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2009 15:08:21 -0400
Content-Disposition: inline
In-Reply-To: <20090616190550.GA22905@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121706>

The system regex is either slow or buggy for complex
patterns, like the built-in xfuncname pattern for java
files.

Signed-off-by: Jeff King <peff@peff.net>
---
Rebased to today's master to resolve textual conflicts.

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 0cb21da..3bd0c08 100644
--- a/Makefile
+++ b/Makefile
@@ -725,6 +725,7 @@ ifeq ($(uname_S),SunOS)
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
+	NO_REGEX = YesPlease
 	ifeq ($(uname_R),5.7)
 		NEEDS_RESOLV = YesPlease
 		NO_IPV6 = YesPlease
-- 
1.6.3.2.411.gffb5
