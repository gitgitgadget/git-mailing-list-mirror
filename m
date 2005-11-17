From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] git-repack: Fix variable name
Date: Thu, 17 Nov 2005 14:34:47 +0000
Message-ID: <20051117143447.GA13227@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 17 15:36:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eckqj-0002sH-Hj
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 15:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVKQOeu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 09:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVKQOeu
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 09:34:50 -0500
Received: from extgw-uk.mips.com ([62.254.210.129]:4876 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S1750870AbVKQOeu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 09:34:50 -0500
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jAHEYlhv013303
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 14:34:47 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jAHEYlrg013302
	for git@vger.kernel.org; Thu, 17 Nov 2005 14:34:47 GMT
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12116>

Three times remove_redandant -> remove_redundant.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Index: git.git/git-repack.sh
===================================================================
--- git.git.orig/git-repack.sh
+++ git.git/git-repack.sh
@@ -11,7 +11,7 @@ do
 	case "$1" in
 	-n)	no_update_info=t ;;
 	-a)	all_into_one=t ;;
-	-d)	remove_redandant=t ;;
+	-d)	remove_redundant=t ;;
 	-l)	local=t ;;
 	*)	break ;;
 	esac
@@ -42,7 +42,7 @@ name=$(git-rev-list --objects $rev_list 
 	exit 1
 if [ -z "$name" ]; then
 	echo Nothing new to pack.
-	if test "$remove_redandant" = t ; then
+	if test "$remove_redundant" = t ; then
 		echo "Removing redundant packs."
 		sync
 		redundant=$(git-pack-redundant --all)
@@ -60,7 +60,7 @@ mv .tmp-pack-$name.pack "$PACKDIR/pack-$
 mv .tmp-pack-$name.idx  "$PACKDIR/pack-$name.idx" ||
 exit
 
-if test "$remove_redandant" = t
+if test "$remove_redundant" = t
 then
 	sync
 	redundant=$(git-pack-redundant --all)
