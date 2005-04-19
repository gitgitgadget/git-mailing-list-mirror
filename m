From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH] Automerge fix
Date: Tue, 19 Apr 2005 03:02:43 +0200
Message-ID: <20050419010242.GS5554@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 02:59:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNh58-0006Kb-JX
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 02:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVDSBDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 21:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVDSBDE
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 21:03:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:7347 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261154AbVDSBCr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 21:02:47 -0400
Received: (qmail 29142 invoked by uid 2001); 19 Apr 2005 01:02:43 -0000
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

this patch fixes git-merge-one-file-script's automerge.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

git-merge-one-file-script: 7ebf5dac4c69043cd2ff89bf7ee552152802f8d1
--- a/git-merge-one-file-script
+++ b/git-merge-one-file-script
@@ -43,7 +43,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 	orig=$(unpack-file $1)
 	src1=$(unpack-file $2)
 	src2=$(unpack-file $3)
-	merge "$src2" "$orig" "$src1" || echo Leaving conflict merge in $src2 && exit 1
+	merge "$src2" "$orig" "$src1" || (echo Leaving conflict merge in $src2 && exit 1)
 	cp "$src2" "$4" && update-cache --add -- "$4" && exit 0
 	;;
 


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
