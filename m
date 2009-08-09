From: Jeff King <peff@peff.net>
Subject: [PATCH 4/3] t/Makefile: include config.mak
Date: Sun, 9 Aug 2009 04:50:37 -0400
Message-ID: <20090809085037.GA31406@coredump.intra.peff.net>
References: <20090809083518.GA8147@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 10:50:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma478-0001Db-Bl
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 10:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbZHIIuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 04:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbZHIIuj
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 04:50:39 -0400
Received: from peff.net ([208.65.91.99]:58080 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674AbZHIIuj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 04:50:39 -0400
Received: (qmail 2810 invoked by uid 107); 9 Aug 2009 08:52:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 04:52:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 04:50:37 -0400
Content-Disposition: inline
In-Reply-To: <20090809083518.GA8147@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125333>

This is useful if you want to specify GIT_TEST_OPTS that you
always use.

Signed-off-by: Jeff King <peff@peff.net>
---
On Sun, Aug 09, 2009 at 04:35:19AM -0400, Jeff King wrote:

>   [1/3] tests: use "$TEST_DIRECTORY" instead of ".."
>   [2/3] tests: provide $TRASH_DIRECTORY variable
>   [3/3] tests: allow user to specify trash directory location

I think a 4/3 like this is nice to let you use --root without extra
typing each time.  And when you do "cd t && make t$WHATEVER.sh
GIT_TEST_OPTS='-v -i'", it will automatically be overridden, which is
probably what you want, so you can inspect the failed tests in t/trash*.

 t/Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index bf816fc..bd09390 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -3,6 +3,8 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
+-include ../config.mak
+
 #GIT_TEST_OPTS=--verbose --debug
 SHELL_PATH ?= $(SHELL)
 TAR ?= $(TAR)
-- 
1.6.4.178.g7a987
