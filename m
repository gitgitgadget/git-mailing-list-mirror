From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] use "git init-db" in tests
Date: Thu, 8 Dec 2005 21:59:41 +0100
Message-ID: <20051208205941.GA19423@steel.home>
References: <20051208202555.GA3046@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Dec 08 22:02:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkSsI-00009D-Vn
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 22:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVLHVAT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 16:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVLHVAT
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 16:00:19 -0500
Received: from devrace.com ([198.63.210.113]:59151 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751088AbVLHVAR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 16:00:17 -0500
Received: from tigra.home (p54A0D4D7.dip.t-dialin.net [84.160.212.215])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jB8KxhlK006205;
	Thu, 8 Dec 2005 14:59:44 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EkSre-0001H5-00; Thu, 08 Dec 2005 21:59:42 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EkSrd-0005we-R9; Thu, 08 Dec 2005 21:59:41 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051208202555.GA3046@steel.home>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13374>

Alex Riesen, Thu, Dec 08, 2005 21:25:55 +0100:
> -git-init-db --template=../../templates/blt/ 2>/dev/null ||
> -error "cannot run git-init-db"
> +git init-db --template=../../templates/blt/ 2>/dev/null ||
> +error "cannot run git init-db"

"$GIT_EXEC_PATH/git init-db", of course.

Signed-off-by: Alex Riesen <fork0@users.sf.net>

---

 t/test-lib.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

33dbb3dacf1b38c40f091dd800ea2dafdfa1fd3f
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0539dac..777c748 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -190,8 +190,8 @@ test=trash
 rm -fr "$test"
 mkdir "$test"
 cd "$test"
-git-init-db --template=../../templates/blt/ 2>/dev/null ||
-error "cannot run git-init-db"
+"$GIT_EXEC_PATH/git" init-db --template=../../templates/blt/ 2>/dev/null ||
+error "cannot run $GIT_EXEC_PATH/git init-db"
 
 mv .git/hooks .git/hooks-disabled
 
-- 
0.99.9.GIT
