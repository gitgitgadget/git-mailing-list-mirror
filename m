From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] Change the sed seperator in t/t6000-lib.sh.
Date: Sat, 02 Jul 2005 01:02:04 +1000
Message-ID: <20050701150204.9523.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 01 16:56:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoMuf-0006Qv-TF
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 16:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbVGAPCL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 11:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbVGAPCK
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 11:02:10 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:41089 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S263366AbVGAPCH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2005 11:02:07 -0400
Received: (qmail 9533 invoked by uid 500); 1 Jul 2005 15:02:04 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This trivial patch removes the semicolon as the sed seperator in the t/t6000-lib.sh test script
and replaces it with white space.  This makes BSD sed(1) much happier.

Signed-off-by: Mark Allen <mrallen1@yahoo.com>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
I've applied this to the code that was moved from t/t6001... into t/t6000-lib.sh
---

 t/t6000-lib.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

d88e09bab26e42f0777b4244a62b21c37c01ceea
diff --git a/t/t6000-lib.sh b/t/t6000-lib.sh
--- a/t/t6000-lib.sh
+++ b/t/t6000-lib.sh
@@ -28,7 +28,9 @@ save_tag()
 	[ -n "$_tag" ] || error "usage: save_tag tag commit-args ..."
 	shift 1
     	"$@" >.git/refs/tags/$_tag
-    	sed_script="s/$(tag $_tag)/$_tag/g${sed_script+;}$sed_script"
+
+       sed_script="s/$(tag $_tag)/$_tag/g
+$sed_script"
 }
 
 # Replace unhelpful sha1 hashses with their symbolic equivalents 
------------
