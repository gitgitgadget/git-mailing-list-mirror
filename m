From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 1/7] Fix contrib/stg-whatchanged way of identifying a
	conflict.
Date: Mon, 25 Jun 2007 23:24:26 +0200
Message-ID: <20070625212426.17189.23900.stgit@gandelf.nowhere.earth>
References: <20070625212229.17189.79919.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 23:24:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2w39-0004iR-4q
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 23:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbXFYVYi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 17:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbXFYVYi
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 17:24:38 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51099 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269AbXFYVYh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 17:24:37 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 38CE55A09C;
	Mon, 25 Jun 2007 23:24:36 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 2B4FA1F150;
	Mon, 25 Jun 2007 23:24:26 +0200 (CEST)
In-Reply-To: <20070625212229.17189.79919.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50921>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-whatchanged |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/stg-whatchanged b/contrib/stg-whatchanged
index d5b6965..a416e97 100755
--- a/contrib/stg-whatchanged
+++ b/contrib/stg-whatchanged
@@ -24,7 +24,7 @@ fi
 # Merges via "push" leave top=bottom so we must look at old patch
 # in this case (unlike, eg., "pick --fold")
 patchdir="$(git-rev-parse --git-dir)/patches/$(stg branch)/patches/$(stg top)"
-if [ $(cat "$patchdir/bottom") = $(cat "$patchdir/top") ];
+if [ -s "$(git-rev-parse --git-dir)/conflicts" ];
 then
     current_cmd="stg show //top.old"
 else
