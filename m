From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] git-clone: don't unpack objects
Date: Wed, 19 Oct 2005 15:43:41 +0300
Message-ID: <20051019154341.2aed6998.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Oct 19 14:45:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESDIN-0004hb-MP
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 14:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbVJSMns (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 08:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbVJSMns
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 08:43:48 -0400
Received: from magister.suomi.net ([212.50.131.141]:62207 "EHLO
	magister.suomi.net") by vger.kernel.org with ESMTP id S1750894AbVJSMns
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 08:43:48 -0400
Received: from spam2.suomi.net (spam2.suomi.net [212.50.131.166])
 by magister.suomi.net
 (Sun Java System Messaging Server 6.2 (built Dec  2 2004))
 with ESMTP id <0IOL00LHYXUCZY80@magister.suomi.net> for git@vger.kernel.org;
 Wed, 19 Oct 2005 15:39:48 +0300 (EEST)
Received: from garlic.home.net (addr-82-128-203-69.suomi.net [82.128.203.69])
	by spam2.suomi.net (Postfix) with SMTP id 11DF2118970; Wed,
 19 Oct 2005 15:43:40 +0300 (EEST)
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.0.2 (GTK+ 2.8.6; i686-pc-linux-gnu)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Not virus scanned: please contact OPOY for details
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.19,	required 5,
 autolearn=not spam, AWL 0.71, BAYES_00 -4.90)
X-MailScanner-From: tihirvon@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10288>

Pass --keep flag to git-clone-pack.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>

---

 git-clone.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

applies-to: 984b42b74993da2be26cd2b50ac1d3e74b0c4cd5
63a266005116dd914c85b4c5f97d0e628f0b37ec
diff --git a/git-clone.sh b/git-clone.sh
index 18e692a..152ba15 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -184,8 +184,8 @@ yes,yes)
 		;;
 	*)
 		cd "$D" && case "$upload_pack" in
-		'') git-clone-pack $quiet "$repo" ;;
-		*) git-clone-pack $quiet "$upload_pack" "$repo" ;;
+		'') git-clone-pack $quiet --keep "$repo" ;;
+		*) git-clone-pack $quiet --keep "$upload_pack" "$repo" ;;
 		esac
 		;;
 	esac
---
0.99.8.GIT
