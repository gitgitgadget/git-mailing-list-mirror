From: Frank Sorenson <frank@tuxrocks.com>
Subject: [PATCH] Add commify function to cg-Xlib
Date: Wed, 06 Jul 2005 01:00:50 -0600
Message-ID: <42CB81A2.7080405@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jul 06 09:02:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq3uc-0007Ua-30
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 09:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVGFHBX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 03:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVGFHBX
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 03:01:23 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:51728 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261718AbVGFHBE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 03:01:04 -0400
Received: from [10.0.0.10] (216-190-206-130.customer.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j6670ogN021016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Jul 2005 01:00:53 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is a patch to add a commify function to cg-Xlib.  I'll follow 
this up with a patch that uses the new function to commify the 
number and size of objects pulled in cg-pull.

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

Add a commify function to cg-Xlib

- ---
commit de4fd646c8307777137b9a4c1b5735f9573167f6
tree 1b9d3d0db498fde457d60f6658f616a1aa6b9fe3
parent b21855b8734ca76ea08c0c17e4a204191b6e3add
author Frank Sorenson <frank@tuxrocks.com> Wed, 06 Jul 2005 00:38:16 -0600
committer Frank Sorenson <frank@tuxrocks.com> Wed, 06 Jul 2005 00:38:16 -0600

 cg-Xlib |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
- --- a/cg-Xlib
+++ b/cg-Xlib
@@ -128,6 +128,9 @@ update_index () {
 	git-update-cache --refresh | sed 's/needs update$/locally modified/'
 }
 
+commify() {
+	echo $1 | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta'
+}
 
 print_help () {
 	which "cg-$1" >/dev/null 2>&1 || exit 1


Frank
- -- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCy4GiaI0dwg4A47wRAg+vAJ9ZCn7ptBARMY+ELyS+uQ893/aDLgCgsk8b
dhfcgflxQRURowVFP2qiRe4=
=u7ap
-----END PGP SIGNATURE-----
