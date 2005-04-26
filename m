From: Rhys Hardwick <rhys@rhyshardwick.co.uk>
Subject: [PATCH] cg-add checks to see if file exists
Date: Tue, 26 Apr 2005 23:17:49 +0100
Message-ID: <200504262317.49739.rhys@rhyshardwick.co.uk>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Apr 27 00:14:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQYIw-0001XV-9T
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 00:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVDZWSI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 18:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVDZWSI
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 18:18:08 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:38232 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261814AbVDZWRy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 18:17:54 -0400
Received: from unknown (HELO mail.rhyshardwick.co.uk) (rhys?hardwick@81.103.65.153 with plain)
  by smtp004.mail.ukl.yahoo.com with SMTP; 26 Apr 2005 22:17:50 -0000
Received: from [192.168.1.40] (helo=metatron.rhyshardwick.co.uk)
	by mail.rhyshardwick.co.uk with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50)
	id 1DQYNK-0006ej-3X
	for git@vger.kernel.org; Tue, 26 Apr 2005 23:17:50 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

This is a patch to check if the file being added exists, and if not, issues a 
warning and dies.

Rhys




Signed-off-by: Rhys Hardwick <rhys@rhyshardwick.co.uk

Index: cg-add
===================================================================
--- 6159f313b10f0cfcdfedd63d6fb044029fe46aaa/cg-add  (mode:100755 
sha1:8ba5351a4c7e28a577ea1aa4afa1078c54e9bccc)
+++ uncommitted/cg-add  (mode:100755)
@@ -10,4 +10,10 @@

 [ "$1" ] || die "usage: cg-add FILE..."

+if [ -f "$1" ]; then
+       echo "Adding file $1"
+else
+       die "$1 does not exist"
+fi
+
 update-cache --add -- "$@"


