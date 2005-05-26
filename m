From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH Cogito] Fix cg-log -f behavior
Date: Thu, 26 May 2005 22:03:46 +0200
Message-ID: <1117137826.12036.57.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-67m1hAiP4+rSUvkSW4DU"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 22:03:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbOYR-0006zm-MF
	for gcvg-git@gmane.org; Thu, 26 May 2005 22:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVEZUD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 16:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVEZUD5
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 16:03:57 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:64440 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261260AbVEZUDz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 16:03:55 -0400
Received: from pegasus (p5487D46C.dip.t-dialin.net [84.135.212.108])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4QK5SId019552
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Thu, 26 May 2005 22:05:29 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-67m1hAiP4+rSUvkSW4DU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

the attached patch fixes the wrong behavior when calling cg-log -f. The
output format of git-diff-tree has changed and so we need to adapt to
that to be able to show the file list again.

Regards

Marcel


Signed-off-by: Marcel Holtmann <marcel@holtmann.org>


--=-67m1hAiP4+rSUvkSW4DU
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: cg-log
===================================================================
--- afc7419cdf2909781fa5dd9d57ea90738e515126/cg-log  (mode:100755)
+++ uncommitted/cg-log  (mode:100755)
@@ -78,7 +78,7 @@
 		list_cmd="git-diff-tree -r $tree1 $tree2"
 	fi
 	echo
-	$list_cmd | while read modes type sha1s file; do
+	$list_cmd | while read mode1 mode2 sha1a sha1b status file; do
 		echo -n "$sep"
 		sep=", "
 		if [ $(echo "$line$sep$file" | wc -c) -le 75 ]; then

--=-67m1hAiP4+rSUvkSW4DU--

