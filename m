From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 1/9] Fix contrib/stg-whatchanged way of identifying a
	conflict.
Date: Sun, 17 Jun 2007 00:00:34 +0200
Message-ID: <20070616220034.14941.949.stgit@gandelf.nowhere.earth>
References: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 00:00:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzgJy-00008k-1M
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 00:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621AbXFPWA0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 18:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753576AbXFPWA0
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 18:00:26 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45509 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbXFPWAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 18:00:25 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D46465A121;
	Sun, 17 Jun 2007 00:00:24 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 44D851F08A;
	Sun, 17 Jun 2007 00:00:34 +0200 (CEST)
In-Reply-To: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50312>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-whatchanged |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/stg-whatchanged b/contrib/stg-whatchanged
index d5b6965..27513d9 100755
--- a/contrib/stg-whatchanged
+++ b/contrib/stg-whatchanged
@@ -24,7 +24,7 @@ fi
 # Merges via "push" leave top=bottom so we must look at old patch
 # in this case (unlike, eg., "pick --fold")
 patchdir="$(git-rev-parse --git-dir)/patches/$(stg branch)/patches/$(stg top)"
-if [ $(cat "$patchdir/bottom") = $(cat "$patchdir/top") ];
+if [ -e "$(git-rev-parse --git-dir)/conflicts" ];
 then
     current_cmd="stg show //top.old"
 else
