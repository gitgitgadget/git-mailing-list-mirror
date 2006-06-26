From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] Makefile fix for Solaris
Date: Tue, 27 Jun 2006 00:21:07 +0200
Message-ID: <20060626222107.G1b760b67@leonov.stosberg.net>
References: <20060625014703.29304.12715.stgit@machine.or.cz> <7vk676orjy.fsf@assigned-by-dhcp.cox.net> <20060626082428.G52c9608e@leonov.stosberg.net> <20060626082754.G6ec0a61e@leonov.stosberg.net> <7vwtb4i89d.fsf@assigned-by-dhcp.cox.net> <20060626094211.G3b49c5c3@leonov.stosberg.net> <20060626100402.G5761a3ea@leonov.stosberg.net> <7vd5cvj1d0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 00:21:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuzSF-0001fm-Tq
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 00:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWFZWVN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 18:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWFZWVM
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 18:21:12 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:37092 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1751062AbWFZWVL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 18:21:11 -0400
Received: from leonov.stosberg.net (p213.54.83.220.tisdip.tiscali.de [213.54.83.220])
	by ncs.stosberg.net (Postfix) with ESMTP id 534B1AEBA065;
	Tue, 27 Jun 2006 00:20:58 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id DEA4C110CE9; Tue, 27 Jun 2006 00:21:07 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5cvj1d0.fsf@assigned-by-dhcp.cox.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22681>

Solaris' /bin/sh does not support $( )-style command substitution

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index a326f6e..f44fbd3 100644
--- a/Makefile
+++ b/Makefile
@@ -544,7 +544,7 @@ common-cmds.h: Documentation/git-*.txt
 $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/Makefile
 $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	rm -f $@ $@+
-	INSTLIBDIR=$$(make -s -C perl instlibdir) && \
+	INSTLIBDIR=`make -s -C perl instlibdir` && \
 	sed -e '1s|#!.*perl\(.*\)|#!$(PERL_PATH_SQ)\1|' \
 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-- 
1.4.1.rc1.g80bff-dirty
