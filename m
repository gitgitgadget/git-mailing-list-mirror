From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] Solaris needs inclusion of signal.h for signal()
Date: Mon, 26 Jun 2006 10:26:13 +0200
Message-ID: <20060626082613.G7dd5c243@leonov.stosberg.net>
References: <20060625014703.29304.12715.stgit@machine.or.cz> <7vk676orjy.fsf@assigned-by-dhcp.cox.net> <20060626082428.G52c9608e@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 10:26:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FumQF-0004RM-Hm
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 10:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWFZI0Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 04:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWFZI0Q
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 04:26:16 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:11731 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S964915AbWFZI0P (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 04:26:15 -0400
Received: from leonov.stosberg.net (p213.54.83.220.tisdip.tiscali.de [213.54.83.220])
	by ncs.stosberg.net (Postfix) with ESMTP id 388A5AEBA065;
	Mon, 26 Jun 2006 10:26:11 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 4BD9A10EF30; Mon, 26 Jun 2006 10:26:13 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060626082428.G52c9608e@leonov.stosberg.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22661>

Currently the compilation fails in connect.c and merge-index.c
---

 connect.c     |    1 +
 merge-index.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/connect.c b/connect.c
index db7342e..66e78a2 100644
--- a/connect.c
+++ b/connect.c
@@ -8,6 +8,7 @@ #include <sys/socket.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include <netdb.h>
+#include <signal.h>
 
 static char *server_capabilities = NULL;
 
diff --git a/merge-index.c b/merge-index.c
index 190e12f..0498a6f 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -1,5 +1,6 @@
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <signal.h>
 
 #include "cache.h"
 
-- 
1.4.0.g64e8
