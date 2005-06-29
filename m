From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Adjust t5300 test for unpack-objects change
Date: Tue, 28 Jun 2005 23:07:34 -0700
Message-ID: <7v4qbhk861.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0506290021050.1667@localhost.localdomain>
	<7vmzp9kbcf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506282217010.19755@ppc970.osdl.org>
	<7virzxk9nd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506282244110.19755@ppc970.osdl.org>
	<Pine.LNX.4.63.0506290146270.1667@localhost.localdomain>
	<7vacl9k8iz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 08:00:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnVcp-0001Zo-EA
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 08:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVF2GHt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 02:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVF2GHt
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 02:07:49 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37016 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262441AbVF2GHj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 02:07:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050629060735.NPPU23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 29 Jun 2005 02:07:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vacl9k8iz.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Tue, 28 Jun 2005 22:59:48 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It now always read from standard input and rejects non-flag
arguments.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff
# - linus: Fix packed_delta_info() that was broken by the delta header packing change
# + (working tree)
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -45,7 +45,8 @@ test_expect_success \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
      git-init-db &&
-     git-unpack-objects test-1'
+     git-unpack-objects -n <test-1.pack &&
+     git-unpack-objects <test-1.pack'
 
 unset GIT_OBJECT_DIRECTORY
 cd $TRASH/.git2
@@ -75,7 +76,8 @@ test_expect_success \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
      git-init-db &&
-     git-unpack-objects test-2'
+     git-unpack-objects -n <test-2.pack &&
+     git-unpack-objects <test-2.pack'
 
 unset GIT_OBJECT_DIRECTORY
 cd $TRASH/.git2

Compilation finished at Tue Jun 28 23:06:08
