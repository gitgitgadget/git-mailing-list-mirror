From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] mergetool: Make git-rm quiet when resolving a deleted file conflict
Date: Thu, 29 Mar 2007 11:44:24 -0400
Message-ID: <11751830652512-git-send-email-tytso@mit.edu>
References: <11751830653554-git-send-email-tytso@mit.edu> <11751830653871-git-send-email-tytso@mit.edu> <11751830651770-git-send-email-tytso@mit.edu> <11751830653157-git-send-email-tytso@mit.edu> <1175183065710-git-send-email-tytso@mit.edu> <11751830651361-git-send-email-tytso@mit.edu> <11751830654112-git-send-email-tytso@mit.edu> <11751830652803-git-send-email-tytso@mit.edu> <11751830653835-git-send-email-tytso@mit.edu> <11751830651076-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:45:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWwoL-0004BP-VQ
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 17:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbXC2Poo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 11:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbXC2Pon
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 11:44:43 -0400
Received: from thunk.org ([69.25.196.29]:36608 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030266AbXC2Poc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 11:44:32 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HWwtf-0007J5-J6; Thu, 29 Mar 2007 11:50:44 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HWwnZ-0000y5-Kl; Thu, 29 Mar 2007 11:44:25 -0400
X-Mailer: git-send-email 1.5.1.rc2.1.g8afe-dirty
In-Reply-To: <11751830651076-git-send-email-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43449>

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 git-mergetool.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index b0d28fd..b9d81f5 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -97,7 +97,7 @@ resolve_deleted_merge () {
 		return
 		;;
 	    [dD]*)
-		git-rm -- "$path"
+		git-rm -- "$path" > /dev/null
 		cleanup_temp_files
 		return
 		;;
-- 
1.5.1.rc2.1.g8afe-dirty
