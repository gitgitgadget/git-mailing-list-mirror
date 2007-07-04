From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH] Document shortcoming of stg-k and stg-unnew.
Date: Wed, 04 Jul 2007 21:18:47 +0200
Message-ID: <20070704191846.15788.35842.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 21:19:26 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6ANn-0007CJ-Be
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 21:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756475AbXGDTTL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 15:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756389AbXGDTTL
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 15:19:11 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:58507 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755880AbXGDTTK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 15:19:10 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A60935A2C7;
	Wed,  4 Jul 2007 21:19:09 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 4CEC61F019;
	Wed,  4 Jul 2007 21:18:47 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51634>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-k     |    8 +++++---
 contrib/stg-unnew |    3 +++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/contrib/stg-k b/contrib/stg-k
index 0134c25..62211be 100755
--- a/contrib/stg-k
+++ b/contrib/stg-k
@@ -8,11 +8,13 @@ set -e
 # essence, "stg-k pop" is a "stg pop -k" that works better, hence its
 # name.
 
-# CAVEAT: this script relies on the operation to run ignoring hidden
+# CAVEATS:
+# - this script relies on the operation to run ignoring hidden
 # patches, so in 0.12 (where "stg push" can push an hidden patch)
 # "stg-k push" will fail midway, albeit with no information loss -
-# you'll just have to finish manually.  Luckilly this appears to work
-# on master branch.
+# you'll just have to finish manually.  This is fixed in 0.13
+# - running this script to pop all patches in the stack fails, since
+# stg-unnew does not support this case.
 
 # Copyright (c) 2007 Yann Dirson <ydirson@altern.org>
 # Subject to the GNU GPL, version 2.
diff --git a/contrib/stg-unnew b/contrib/stg-unnew
index 5ac8781..2a38264 100755
--- a/contrib/stg-unnew
+++ b/contrib/stg-unnew
@@ -6,6 +6,9 @@ set -e
 # Remove the current patch from the stack, keeping its contents as
 # uncommitted changes.
 
+# CAVEAT: running this script on the bottom-most patch fails, since
+# "stg pick --fold" does not allow this situation.
+
 # Copyright (c) 2007 Yann Dirson <ydirson@altern.org>
 # Subject to the GNU GPL, version 2.
 
