From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH Cogito] Prevent '.git/merging: No such file or directory'
	error message
Date: Tue, 21 Jun 2005 00:15:14 +0200
Message-ID: <1119305714.26772.75.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-/YMJmA/lNl6DUk11iyL0"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 00:15:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkUY0-0001B1-Kq
	for gcvg-git@gmane.org; Tue, 21 Jun 2005 00:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVFTWTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 18:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVFTWTW
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 18:19:22 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:1998 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261958AbVFTWPU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2005 18:15:20 -0400
Received: from pegasus (p5487D28A.dip.t-dialin.net [84.135.210.138])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j5KMHQSs013674
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Tue, 21 Jun 2005 00:17:27 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV 0.85.1/947/Mon Jun 20 21:39:23 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-/YMJmA/lNl6DUk11iyL0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

the attached patch prevent the '.git/merging: No such file or directory'
error message.

Regards

Marcel


Signed-off-by: Marcel Holtmann <marcel@holtmann.org>


--=-/YMJmA/lNl6DUk11iyL0
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff --git a/cg-merge b/cg-merge
--- a/cg-merge
+++ b/cg-merge
@@ -48,7 +48,7 @@ branch=$(commit-id "$branchname") || exi
 
 [ -s $_git/blocked ] && die "merge blocked: $(cat $_git/blocked)"
 
-if grep -q "$branch" $_git/merging; then
+if grep -sq "$branch" $_git/merging; then
 	echo "Branch already merged in the working tree." >&2
 	echo 0
 fi

--=-/YMJmA/lNl6DUk11iyL0--

