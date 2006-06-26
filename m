From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] Fix pkt-line.h to compile with a non-GCC compiler
Date: Mon, 26 Jun 2006 10:27:07 +0200
Message-ID: <20060626082707.G1c426a74@leonov.stosberg.net>
References: <20060625014703.29304.12715.stgit@machine.or.cz> <7vk676orjy.fsf@assigned-by-dhcp.cox.net> <20060626082428.G52c9608e@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 10:28:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FumRK-0004b6-R3
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 10:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWFZI1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 04:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWFZI1N
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 04:27:13 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:54995 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S964929AbWFZI1K (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 04:27:10 -0400
Received: from leonov.stosberg.net (p213.54.83.220.tisdip.tiscali.de [213.54.83.220])
	by ncs.stosberg.net (Postfix) with ESMTP id 39C1AAEBA065;
	Mon, 26 Jun 2006 10:27:05 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 78383110442; Mon, 26 Jun 2006 10:27:07 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060626082428.G52c9608e@leonov.stosberg.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22662>

pkt-line.h uses GCC's __attribute__ extension but does not include
git-compat-util.h.  So it will not compile with a compiler that does
not support this extension.
---
 pkt-line.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/pkt-line.h b/pkt-line.h
index 9abef24..9df653f 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -1,6 +1,8 @@
 #ifndef PKTLINE_H
 #define PKTLINE_H
 
+#include "git-compat-util.h"
+
 /*
  * Silly packetized line writing interface
  */
-- 
1.4.0.g64e8
