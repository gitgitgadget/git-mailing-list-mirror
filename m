From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] cg-clean: fix argument processing
Date: Mon, 14 Nov 2005 15:03:33 -0500
Message-ID: <1131998613.24084.18.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 21:04:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbkYS-0000yS-PE
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 21:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVKNUDu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 15:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVKNUDu
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 15:03:50 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:46743 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932071AbVKNUDt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 15:03:49 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EbkYF-0004Gu-9h
	for git@vger.kernel.org; Mon, 14 Nov 2005 15:03:43 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EbkYA-0005qH-8p; Mon, 14 Nov 2005 15:03:34 -0500
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11842>

cg-clean was broken by the "robustified usage checks".  This patch
restores the old behavior, i.e. cg-clean reports errors if there is
anything but switches on the command line.  Empty arguments are rejected
now as well.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-clean b/cg-clean
index f680aee..1cc1ae8 100755
--- a/cg-clean
+++ b/cg-clean
@@ -44,7 +44,7 @@ while optparse; do
 	fi
 done
 
-[ ${#ARGS[*]} -ge 1 ] || usage
+[ ${#ARGS[*]} = 0 ] || usage
 
 
 clean_dirs()


-- 
Regards,
Pavel Roskin
