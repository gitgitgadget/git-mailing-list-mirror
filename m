From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git-clean: Fix the -q option.
Date: Sat, 30 Dec 2006 12:47:43 +0100
Message-ID: <87hcvdzjts.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 30 12:47:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0cgp-0007MS-LZ
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 12:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbWL3Lrr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 06:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754362AbWL3Lrr
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 06:47:47 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:38575 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357AbWL3Lrr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 06:47:47 -0500
Received: from adsl-84-227-18-131.adslplus.ch ([84.227.18.131] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1H0cgj-0008Tw-JS
	for git@vger.kernel.org; Sat, 30 Dec 2006 05:47:46 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 553CE4F66D; Sat, 30 Dec 2006 12:47:43 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35616>

The 'quiet' flag is set by -q, but it's not used anywhere.
Remove it and set the 'echo1' variable instead.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 git-clean.sh |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/git-clean.sh b/git-clean.sh
index 3834323..071b974 100755
--- a/git-clean.sh
+++ b/git-clean.sh
@@ -18,7 +18,6 @@ SUBDIRECTORY_OK=Yes
 ignored=
 ignoredonly=
 cleandir=
-quiet=
 rmf="rm -f --"
 rmrf="rm -rf --"
 rm_refuse="echo Not removing"
@@ -31,14 +30,13 @@ do
 		cleandir=1
 		;;
 	-n)
-		quiet=1
 		rmf="echo Would remove"
 		rmrf="echo Would remove"
 		rm_refuse="echo Would not remove"
 		echo1=":"
 		;;
 	-q)
-		quiet=1
+		echo1=":"
 		;;
 	-x)
 		ignored=1
-- 
1.5.0.rc0.g3710-dirty

-- 
Alexandre Julliard
julliard@winehq.org
