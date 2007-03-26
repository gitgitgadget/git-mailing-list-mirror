From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Bisect: Use "git-show-ref --verify" when reseting.
Date: Mon, 26 Mar 2007 06:14:40 +0200
Message-ID: <20070326061440.26f506d4.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 06:06:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVgTZ-0007Qa-IL
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 06:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933535AbXCZEG3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 00:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933430AbXCZEG3
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 00:06:29 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:37966 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933535AbXCZEG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 00:06:28 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 33D049B880;
	Mon, 26 Mar 2007 06:06:27 +0200 (CEST)
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43110>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 936b4a4..fda1712 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -173,7 +173,7 @@ bisect_reset() {
 	   else
 	       branch=master
 	   fi ;;
-	1) test -f "$GIT_DIR/refs/heads/$1" || {
+	1) git-show-ref --verify --quiet -- "refs/heads/$1" || {
 	       echo >&2 "$1 does not seem to be a valid branch"
 	       exit 1
 	   }
-- 
1.5.1.rc2.1.g850a
