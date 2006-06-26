From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] "test" in Solaris' /bin/sh does not support -e
Date: Mon, 26 Jun 2006 10:27:54 +0200
Message-ID: <20060626082754.G6ec0a61e@leonov.stosberg.net>
References: <20060625014703.29304.12715.stgit@machine.or.cz> <7vk676orjy.fsf@assigned-by-dhcp.cox.net> <20060626082428.G52c9608e@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 10:28:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FumRs-0004dT-NY
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 10:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWFZI15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 04:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWFZI15
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 04:27:57 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:7892 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S964875AbWFZI15 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 04:27:57 -0400
Received: from leonov.stosberg.net (p213.54.83.220.tisdip.tiscali.de [213.54.83.220])
	by ncs.stosberg.net (Postfix) with ESMTP id 777D1AEBA065;
	Mon, 26 Jun 2006 10:27:52 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id BF261110443; Mon, 26 Jun 2006 10:27:54 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060626082428.G52c9608e@leonov.stosberg.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22663>

Running "make clean" currently fails:
  [ ! -e perl/Makefile ] || make -C perl/ clean
  /bin/sh: test: argument expected
  make: *** [clean] Error 1
---

Pasky said in #git that a simple -f test would suffice.

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 3dc54fe..d41d224 100644
--- a/Makefile
+++ b/Makefile
@@ -761,7 +761,7 @@ clean:
 	rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	rm -f $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
-	[ ! -e perl/Makefile ] || $(MAKE) -C perl/ clean || $(MAKE) -C perl/ clean
+	[ ! -f perl/Makefile ] || $(MAKE) -C perl/ clean || $(MAKE) -C perl/ clean
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
 	rm -f GIT-VERSION-FILE GIT-CFLAGS
--
1.4.0
