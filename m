From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/3] cg-admin-rewritehist: seed the map with the parent of the -r arg, not with itself
Date: Sun, 11 Jun 2006 14:05:00 +0200
Message-ID: <20060611120459.12116.87606.stgit@gandelf.nowhere.earth>
References: <20060611120431.12116.74005.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 11 14:05:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpOgi-0002tE-3I
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 14:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWFKMFA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 08:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWFKMFA
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 08:05:00 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:13457 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751233AbWFKME7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 08:04:59 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 1E1FF48D41;
	Sun, 11 Jun 2006 14:04:59 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FpOgh-0002vF-3P; Sun, 11 Jun 2006 14:05:03 +0200
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060611120431.12116.74005.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21651>


This is a fix for 95621e54cedef1c4a270af5570a72fc1331b5fcb.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 cg-admin-rewritehist |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-admin-rewritehist b/cg-admin-rewritehist
index 7cbdb30..6dd8b92 100755
--- a/cg-admin-rewritehist
+++ b/cg-admin-rewritehist
@@ -157,7 +157,7 @@ while optparse; do
 		git-rev-parse "$OPTARG" >/dev/null || die "Unknown revision '$OPTARG'"
 		git-rev-parse "$OPTARG^" >/dev/null || die "Revision '$OPTARG' does not have parents, check what you really want"
 		startrev="^$OPTARG^ $OPTARG $startrev"
-		startrevparents="$OPTARG $startrevparents"
+		startrevparents="$OPTARG^ $startrevparents"
 	elif optparse --env-filter=; then
 		filter_env="$OPTARG"
 	elif optparse --tree-filter=; then
