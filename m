From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] git-revert: use GIT_DIR shell variable for the MERGE_MSG
Date: Thu, 12 Oct 2006 15:11:07 -0700 (PDT)
Message-ID: <20061012221107.73011.qmail@web31804.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Oct 13 00:31:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY8lm-0006aw-FV
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 00:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWJLWLK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 18:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWJLWLJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 18:11:09 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:59492 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751171AbWJLWLI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 18:11:08 -0400
Received: (qmail 73013 invoked by uid 60001); 12 Oct 2006 22:11:07 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VbyOcTLCHxpXEoiDm1gZlYG2Ggli5G2uXCkQbnD9AhS6ZpoFWy6VdE2rNClsU6EvCAIwRJADiO0vipE6OxpERHY3SCmU5+7F2IfE1vyU6GoaAW4NET0XtIGaazn/1Ump1IITTwI1CZ5W2CVy+a1VcQ7IlEJJXxkjtSnV5DGvhPM=  ;
Received: from [64.215.88.90] by web31804.mail.mud.yahoo.com via HTTP; Thu, 12 Oct 2006 15:11:07 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28806>

Ooops!

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 git-revert.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-revert.sh b/git-revert.sh
index 2e23cf4..6eab3c7 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -145,7 +145,7 @@ git-read-tree -m -u --aggressive $base $
 result=$(git-write-tree 2>/dev/null) || {
     echo >&2 "Simple $me fails; trying Automatic $me."
     git-merge-index -o git-merge-one-file -a || {
-	    mv -f .msg .git/MERGE_MSG
+	    mv -f .msg "$GIT_DIR/MERGE_MSG"
 	    {
 		echo '
 Conflicts:
-- 
1.4.3.rc2.gd9edb
