From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 3/3] Change the sed seperator in t/t6000-lib.sh.
Date: Wed, 06 Jul 2005 20:11:29 +1000
Message-ID: <20050706101129.29982.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 06 12:39:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq7Im-0007BB-DJ
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 12:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVGFKem (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 06:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVGFKdt
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 06:33:49 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:20610 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262283AbVGFKLj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 06:11:39 -0400
Received: (qmail 29992 invoked by uid 500); 6 Jul 2005 10:11:29 -0000
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

ca2833542fed15371f9acde4c1bdeb6bc53046c0
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
