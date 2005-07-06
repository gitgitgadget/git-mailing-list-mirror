From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 11/13] Change the sed seperator in t/t6000-lib.sh.
Date: Thu, 07 Jul 2005 02:39:34 +1000
Message-ID: <20050706163934.9998.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 06 18:48:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqD3b-00067A-L2
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 18:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVGFQqT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 12:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVGFQoc
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 12:44:32 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:16259 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262354AbVGFQjx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 12:39:53 -0400
Received: (qmail 10008 invoked by uid 500); 6 Jul 2005 16:39:34 -0000
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

b49ca001a8b60bdcdce989a65b120a7183486cf8
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
