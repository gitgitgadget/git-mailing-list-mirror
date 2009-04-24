From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] am: simplify "sq" function by using "git rev-parse
	--sq-quote"
Date: Fri, 24 Apr 2009 08:29:01 +0200
Message-ID: <20090424062902.3705.34448.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 08:32:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxExr-0007Fu-Si
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 08:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971AbZDXGbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 02:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbZDXGbM
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 02:31:12 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:40125 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314AbZDXGbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 02:31:09 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6E65E8180EE;
	Fri, 24 Apr 2009 08:31:01 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 78A8781801E;
	Fri, 24 Apr 2009 08:30:59 +0200 (CEST)
X-git-sha1: 3bc5c3e7fade6688410750bed8b57febdf1904ae 
X-Mailer: git-mail-commits v0.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117414>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-am.sh |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 6d1848b..578780b 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -44,11 +44,7 @@ else
 fi
 
 sq () {
-	for sqarg
-	do
-		printf "%s" "$sqarg" |
-		sed -e 's/'\''/'\''\\'\'''\''/g' -e 's/.*/ '\''&'\''/'
-	done
+	git rev-parse --sq-quote "$@"
 }
 
 stop_here () {
-- 
1.6.3.rc1.112.g17e25
