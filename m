From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 4/4] Use INADDR_NONE instead of -1 to check inet_addr() result
Date: Tue, 13 Jun 2006 00:32:33 -0400
Message-ID: <20060613043233.16681.68343.stgit@dv.roinet.com>
References: <20060613043224.16681.98358.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Jun 13 06:32:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fq0a2-0005Mg-BK
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 06:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870AbWFMEci (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 00:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932871AbWFMEci
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 00:32:38 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:47246 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932870AbWFMEcf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 00:32:35 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fq0Zv-0003Sb-11
	for git@vger.kernel.org; Tue, 13 Jun 2006 00:32:35 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1Fq0Zt-0004MH-Ee; Tue, 13 Jun 2006 00:32:33 -0400
To: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org,
	cvsps@dm.cobite.com
In-Reply-To: <20060613043224.16681.98358.stgit@dv.roinet.com>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21766>

From: Pavel Roskin <proski@gnu.org>

INADDR_NONE is not equal to -1 on 64-bit systems.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 cbtcommon/tcpsocket.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cbtcommon/tcpsocket.c b/cbtcommon/tcpsocket.c
index a174007..f31060e 100644
--- a/cbtcommon/tcpsocket.c
+++ b/cbtcommon/tcpsocket.c
@@ -198,7 +198,7 @@ #ifdef __linux__
     memcpy(dest, &ip.s_addr, sizeof(ip.s_addr));
   }
 #else
-  if ( (*dest = inet_addr(addr_str)) != -1)
+  if ( (*dest = inet_addr(addr_str)) != INADDR_NONE)
   {
     /* nothing */
   }
