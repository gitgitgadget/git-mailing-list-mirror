From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH Cogito] Strip .git suffix from destination directory
Date: Mon, 09 May 2005 03:10:34 +0200
Message-ID: <1115601034.8949.99.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-iFKFGfPet21ExRM2FQ6i"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 03:03:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUwgD-0000NQ-Fv
	for gcvg-git@gmane.org; Mon, 09 May 2005 03:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbVEIBKS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 21:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbVEIBKS
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 21:10:18 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:9646 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S263004AbVEIBKK
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 21:10:10 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j491BTWX008454
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 9 May 2005 03:11:29 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-iFKFGfPet21ExRM2FQ6i
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

the attached patch brings back the feature where a .git suffix got
stripped from the directory name when cloning another tree.

It also fixes a $samedir vs. $same_dir spelling mistake.

Regards

Marcel


--=-iFKFGfPet21ExRM2FQ6i
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

cg-clone: needs update
Index: cg-clone
===================================================================
--- 00b94eea5b99d5dd1d1bbe9c9ca3502d11aec581/cg-clone  (mode:100755)
+++ uncommitted/cg-clone  (mode:100755)
@@ -28,10 +28,10 @@
 
 destdir=$2
 if [ "$destdir" ]; then
-	[ ! "$samedir" ] || die "specifying both -s and DESTDIR makes no sense"
+	[ ! "$same_dir" ] || die "specifying both -s and DESTDIR makes no sense"
 	dir=$destdir
 else
-	dir=${location%/.git}; dir=${dir##*/}
+	dir=${location%/.git}; dir=${dir##*/}; dir=${dir%.git}
 fi
 
 if ! echo "$location" | grep -q ":" ; then

--=-iFKFGfPet21ExRM2FQ6i--

