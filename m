From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Use rev-list --reverse in git-rebase.sh
Date: Sat, 14 Apr 2007 00:19:05 +0200
Message-ID: <20070413221905.GA3570@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Junio C Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 00:19:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcU6w-0006hP-El
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 00:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbXDMWTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 18:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030656AbXDMWTK
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 18:19:10 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:21895 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030314AbXDMWTI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 18:19:08 -0400
Received: from tigra.home (Fcab9.f.strato-dslnet.de [195.4.202.185])
	by post.webmailer.de (klopstock mo42) (RZmta 5.5)
	with ESMTP id C022adj3DK3ZnO ; Sat, 14 Apr 2007 00:19:06 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 009A4277B6;
	Sat, 14 Apr 2007 00:19:05 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 7C2A3BE85; Sat, 14 Apr 2007 00:19:05 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTv+FXw=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44436>

...and drop the last perl dependency in the script.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Resend.

 git-rebase.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 1d96f32..2dc2c4f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -339,8 +339,7 @@ prev_head=`git-rev-parse HEAD^0`
 echo "$prev_head" > "$dotest/prev_head"
 
 msgnum=0
-for cmt in `git-rev-list --no-merges "$upstream"..ORIG_HEAD \
-			| @@PERL@@ -e 'print reverse <>'`
+for cmt in `git-rev-list --reverse --no-merges "$upstream"..ORIG_HEAD`
 do
 	msgnum=$(($msgnum + 1))
 	echo "$cmt" > "$dotest/cmt.$msgnum"
-- 
1.5.1.147.gbaa5
