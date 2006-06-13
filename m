From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 3/4] Use __linux__ conditional, not LINUX.
Date: Tue, 13 Jun 2006 00:32:31 -0400
Message-ID: <20060613043231.16681.13655.stgit@dv.roinet.com>
References: <20060613043224.16681.98358.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Jun 13 06:32:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fq0a0-0005Mg-TQ
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 06:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932868AbWFMEcf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 00:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932871AbWFMEcf
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 00:32:35 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:45710 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932868AbWFMEce
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 00:32:34 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fq0Zt-0003S2-EQ
	for git@vger.kernel.org; Tue, 13 Jun 2006 00:32:33 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1Fq0Zr-0004LO-Br; Tue, 13 Jun 2006 00:32:31 -0400
To: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org,
	cvsps@dm.cobite.com
In-Reply-To: <20060613043224.16681.98358.stgit@dv.roinet.com>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21765>

From: Pavel Roskin <proski@gnu.org>

__linux__ is defined automatically, LINUX is not.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 cbtcommon/tcpsocket.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cbtcommon/tcpsocket.c b/cbtcommon/tcpsocket.c
index 27cc13a..a174007 100644
--- a/cbtcommon/tcpsocket.c
+++ b/cbtcommon/tcpsocket.c
@@ -185,14 +185,14 @@ #endif
 int
 convert_address(long *dest, const char *addr_str)
 {
-#ifdef LINUX
+#ifdef __linux__
   struct in_addr ip;
 #endif
   int retval = 0;
   char errstr[256];
   
   /* first try converting "numbers and dots" notation */
-#ifdef LINUX
+#ifdef __linux__
   if ( inet_aton(addr_str, &ip) )
   {
     memcpy(dest, &ip.s_addr, sizeof(ip.s_addr));
