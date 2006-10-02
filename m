From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Do not create tag leading directories since git update-ref
 does it.
Date: Mon, 2 Oct 2006 06:36:15 +0200
Message-ID: <20061002063615.2ffb7eaa.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 06:30:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUFRO-0005Ne-6c
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 06:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWJBE3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 00:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWJBE3t
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 00:29:49 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:46565 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S932391AbWJBE3s (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Oct 2006 00:29:48 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g19.free.fr (Postfix) with SMTP id 4E20D4548D;
	Mon,  2 Oct 2006 06:29:46 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28213>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-tag.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-tag.sh b/git-tag.sh
index a3f1819..ac269e3 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -112,6 +112,5 @@ if [ "$annotate" ]; then
     object=$(git-mktag < "$GIT_DIR"/TAG_TMP)
 fi
 
-leading=`expr "refs/tags/$name" : '\(.*\)/'` &&
-mkdir -p "$GIT_DIR/$leading" &&
-GIT_DIR="$GIT_DIR" git update-ref "refs/tags/$name" "$object" "$prev"
+git update-ref "refs/tags/$name" "$object" "$prev"
+
-- 
1.4.2.2.gbcb49-dirty
