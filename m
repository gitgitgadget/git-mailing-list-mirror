From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] git-clone --shared should imply --local
Date: Tue, 29 Nov 2005 01:20:49 -0500
Message-ID: <1133245249.27750.77.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 29 07:47:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgyrH-0007S6-J9
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 07:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbVK2GUx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 01:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVK2GUx
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 01:20:53 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:18593 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751323AbVK2GUw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 01:20:52 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EgyrC-0000IB-Vj
	for git@vger.kernel.org; Tue, 29 Nov 2005 01:20:51 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EgyrB-0004bc-EN
	for git@vger.kernel.org; Tue, 29 Nov 2005 01:20:49 -0500
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12923>

The "--shared" option to git-clone is silently ignored if "--local" is
not specified.  The manual doesn't mention such dependency.  Make
"--shared" imply "--local".

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/git-clone.sh b/git-clone.sh
index c09979a..699205e 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -73,7 +73,7 @@ while
 	*,-n) no_checkout=yes ;;
 	*,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local) use_local=yes ;;
         *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared) 
-          local_shared=yes ;;
+          local_shared=yes; use_local=yes ;;
 	*,-q|*,--quiet) quiet=-q ;;
 	1,-u|1,--upload-pack) usage ;;
 	*,-u|*,--upload-pack)


-- 
Regards,
Pavel Roskin
