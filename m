From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH Cogito] Fix file list wrapping of cg-log
Date: Fri, 13 May 2005 13:25:49 +0200
Message-ID: <1115983549.18499.117.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-7kA1mc8Ah7Wp8yvJuF8q"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 13 13:19:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWYC7-00031C-KL
	for gcvg-git@gmane.org; Fri, 13 May 2005 13:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVEML0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 07:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVEML0N
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 07:26:13 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:33969 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261430AbVEMLZ0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2005 07:25:26 -0400
Received: from pegasus (p5487CC4D.dip.t-dialin.net [84.135.204.77])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4DBQlWX024343
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Fri, 13 May 2005 13:26:48 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV 0.83/875/Tue May 10 13:27:59 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-7kA1mc8Ah7Wp8yvJuF8q
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

the attached patch fixes the file list wrapping for the second and
following lines by adding two extra spaces. It also corrects the line
width counting that is wrong after the first line break.

Regards

Marcel


Signed-off-by: Marcel Holtmann <marcel@holtmann.org>


--=-7kA1mc8Ah7Wp8yvJuF8q
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: cg-log
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-log  (mode:100755)
+++ uncommitted/cg-log  (mode:100755)
@@ -69,6 +69,7 @@
 {
 	tree1="$1"
 	tree2="$2"
+	line=
 	sep="    * $colfiles"
 	# List all files for for the initial commit
 	if [ -z $tree2 ]; then
@@ -84,9 +85,9 @@
 			line="$line$sep$file"
 			echo -n "$file"
 		else
-			line="$file"
+			line="      $file"
 			echo "$coldefault"
-			echo -n "    $colfiles$file"
+			echo -n "      $colfiles$file"
 		fi
 	done
 	echo "$coldefault:"

--=-7kA1mc8Ah7Wp8yvJuF8q--

