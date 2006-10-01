From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Check that a tag exists using show-ref instead of looking
 for the ref file.
Date: Sun, 1 Oct 2006 22:33:04 +0200
Message-ID: <20061001223304.d37df36f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 22:26:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU7td-0004Uf-AV
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 22:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWJAU0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 16:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWJAU0m
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 16:26:42 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:22422 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932316AbWJAU0m (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 16:26:42 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with SMTP id 1614E75BE7;
	Sun,  1 Oct 2006 22:26:41 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28202>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-tag.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-tag.sh b/git-tag.sh
index 6463b31..a3f1819 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -66,7 +66,7 @@ done
 name="$1"
 [ "$name" ] || usage
 prev=0000000000000000000000000000000000000000
-if test -e "$GIT_DIR/refs/tags/$name"
+if git-show-ref --verify --quiet -- "refs/tags/$name"
 then
     test -n "$force" || die "tag '$name' already exists"
     prev=`git rev-parse "refs/tags/$name"`
-- 
1.4.2.1.gd567
