From: Jeff King <peff@peff.net>
Subject: [PATCH] Makefile: turn on USE_ST_TIMESPEC for FreeBSD
Date: Sun, 22 Mar 2009 04:08:48 -0400
Message-ID: <20090322080847.GA9075@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kjetil Barvik <barvik@broadpark.no>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 09:10:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlIlD-0003CV-R9
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 09:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbZCVIIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 04:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbZCVIIy
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 04:08:54 -0400
Received: from peff.net ([208.65.91.99]:60595 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbZCVIIw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 04:08:52 -0400
Received: (qmail 10098 invoked by uid 107); 22 Mar 2009 08:09:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 22 Mar 2009 04:09:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2009 04:08:48 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114130>

Fixes broken compilation on FreeBSD 6.1.

Signed-off-by: Jeff King <peff@peff.net>
---
No idea if older versions support this, or if they just need NO_NSEC
instead.

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index aae3b09..320c897 100644
--- a/Makefile
+++ b/Makefile
@@ -713,6 +713,7 @@ ifeq ($(uname_S),FreeBSD)
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
+	USE_ST_TIMESPEC = YesPlease
 	THREADED_DELTA_SEARCH = YesPlease
 	ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
 		PTHREAD_LIBS = -pthread
-- 
1.6.2.1.276.gd47fa
