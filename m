From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Better options in Makefile
Date: Tue, 19 Apr 2005 13:48:18 -0400
Message-ID: <1113932898.3793.14.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 19 19:45:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNwlx-0007Sa-BU
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 19:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVDSRsf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 13:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVDSRsf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 13:48:35 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:39368 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S261469AbVDSRsc
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 13:48:32 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1DNwpc-000460-9z
	for git@vger.kernel.org; Tue, 19 Apr 2005 13:48:18 -0400
Received: from proski by dv.roinet.com with local (Exim 3.36 #1 (Debian))
	id 1DNwpe-0007tU-00
	for <git@vger.kernel.org>; Tue, 19 Apr 2005 13:48:18 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

This patch allows to enable collision check and subsecond time
resolution by uncommenting one line.  Also, the corresponding comments
have been improved.

Signed-off-by: Pavel Roskin <proski@gnu.org>

--- a/Makefile
+++ b/Makefile
@@ -1,13 +1,18 @@
-# -DCOLLISION_CHECK if you believe that SHA1's
+# Define COLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
-# enough guarantees about no collisions between objects ever hapenning.
-#
-# -DNSEC if you want git to care about sub-second file mtimes and ctimes.
-# Note that you need some new glibc (at least >2.2.4) for this, and it will
+# sufficient guarantee the no collisions between objects will ever happen.
+
+# DEFINES += -DCOLLISION_CHECK
+
+# Define NSEC if you want git to care about sub-second file mtimes and ctimes.
+# Note that you will need recent glibc (at least 2.2.4) for this, and it will
 # BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely randomly
 # break unless your underlying filesystem supports those sub-second times
 # (my ext3 doesn't).
-CFLAGS=-g -O3 -Wall
+
+# DEFINES += -DNSEC
+
+CFLAGS=-g -O3 -Wall $(DEFINES)
 
 CC=gcc
 AR=ar


-- 
Regards,
Pavel Roskin


