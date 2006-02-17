From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/5] Fix cpio call
Date: Fri, 17 Feb 2006 15:22:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602171522300.24274@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Feb 17 15:23:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA6VW-00009b-8d
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 15:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWBQOWr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 09:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWBQOWr
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 09:22:47 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:6038 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751433AbWBQOWq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 09:22:46 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0DE2314668C; Fri, 17 Feb 2006 15:22:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 01AC1A03;
	Fri, 17 Feb 2006 15:22:46 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CB67A14668C; Fri, 17 Feb 2006 15:22:45 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16346>


To some cpio's, -a and -m options are mutually exclusive. Use only -m.

Signed-off-by: Johannes E. Schindelin <Johannes.Schindelin@gmx.de>

---

 git-clone.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

d2f8d0558bcf8d0d207e89137a04e8a97fedae03
diff --git a/git-clone.sh b/git-clone.sh
index e192b08..cf410fa 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -153,7 +153,7 @@ yes,yes)
 	    fi &&
 	    rm -f "$GIT_DIR/objects/sample" &&
 	    cd "$repo" &&
-	    find objects -depth -print | cpio -puamd$l "$GIT_DIR/" || exit 1
+	    find objects -depth -print | cpio -pumd$l "$GIT_DIR/" || exit 1
 	    ;;
 	yes)
 	    mkdir -p "$GIT_DIR/objects/info"
-- 
1.2.1.g09fe-dirty
