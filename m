From: Unknown <borg@uu3.net>
Subject: [commit 4ecbc178704] Incosistency?
Date: Tue, 14 Jul 2009 23:41:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0907142335210.31779@cube>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 23:41:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQpl1-00044h-Th
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 23:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101AbZGNVln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 17:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756014AbZGNVln
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 17:41:43 -0400
Received: from borg.uu3.net ([87.99.63.19]:33484 "EHLO borg.uu3.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756000AbZGNVln (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 17:41:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by borg.uu3.net (Postfix) with ESMTP id 88067633F9
	for <git@vger.kernel.org>; Tue, 14 Jul 2009 23:41:40 +0200 (CEST)
X-X-Sender: borg@cube
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123272>

commit 4ecbc178704ca6c1027a38483e98f5fe493b1322
Author: Jeff King <peff@peff.net>
Date:   Thu Jul 9 02:37:35 2009 -0400

bla bla.. some strange SUDO fix (who the hell uses git that way?)
I dont like it.. git-add in libexecdir was good!

diff --git a/Makefile b/Makefile
index 78cc113..311ce7d 100644
--- a/Makefile
+++ b/Makefile
@@ -1641,15 +1641,15 @@ ifneq (,$X)
  endif
         bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
         execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
-       { $(RM) "$$execdir/git-add$X" && \
+       { $(RM) "$$execdir/git$X" && \
                 test -z "$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
-               ln "$$bindir/git$X" "$$execdir/git-add$X" 2>/dev/null || \
-               cp "$$bindir/git$X" "$$execdir/git-add$X"; } && \
-       { for p in $(filter-out git-add$X,$(BUILT_INS)); do \
+               ln "$$bindir/git$X" "$$execdir/git$X" 2>/dev/null || \
+               cp "$$bindir/git$X" "$$execdir/git$X"; } && \
+       { for p in $(BUILT_INS); do \
                 $(RM) "$$execdir/$$p" && \
-               ln "$$execdir/git-add$X" "$$execdir/$$p" 2>/dev/null || \
-               ln -s "git-add$X" "$$execdir/$$p" 2>/dev/null || \
-               cp "$$execdir/git-add$X" "$$execdir/$$p" || exit; \
+               ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
+               ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
+               cp "$$execdir/git$X" "$$execdir/$$p" || exit; \
           done; } && \
         ./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"

Isnt check_bindir is broken now?
git-add is no more..
