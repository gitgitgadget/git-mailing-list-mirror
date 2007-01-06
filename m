From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git-clean: Fix the -q option.
Date: Sat, 06 Jan 2007 11:19:44 +0100
Message-ID: <873b6oxxrz.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 06 11:19:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H38eW-0002Bb-Ek
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 11:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbXAFKTu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 05:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbXAFKTt
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 05:19:49 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:46748 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbXAFKTt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 05:19:49 -0500
Received: from adsl-84-227-145-235.adslplus.ch ([84.227.145.235] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1H38eR-0006Vv-Na
	for git@vger.kernel.org; Sat, 06 Jan 2007 04:19:48 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id EC1434F693; Sat,  6 Jan 2007 11:19:44 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36083>

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
1.5.0.rc0.g5a8e

-- 
Alexandre Julliard
julliard@winehq.org
