From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-commit.sh: Remove option -n from tail
Date: Tue, 16 Oct 2007 19:57:16 +0300
Message-ID: <1192553837-18302-3-git-send-email-jari.aalto@cante.net>
References: <1192553837-18302-1-git-send-email-jari.aalto@cante.net>
 <1192553837-18302-2-git-send-email-jari.aalto@cante.net>
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 19:06:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhpsB-0000Uz-DS
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758017AbXJPRGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758693AbXJPRGR
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:06:17 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:57600 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757740AbXJPRGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 13:06:16 -0400
X-Greylist: delayed 535 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Oct 2007 13:06:16 EDT
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id E6A5E1BCC7
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 19:57:20 +0300 (EEST)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A018FEE3D83; Tue, 16 Oct 2007 19:57:20 +0300
Received: from cante.cante.net (a81-197-175-198.elisa-laajakaista.fi [81.197.175.198])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id D6BEA4BB9F
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 19:57:19 +0300 (EEST)
Received: from jaalto by cante.cante.net with local (Exim 4.68)
	(envelope-from <jaalto@cante.cante.net>)
	id 1IhpjK-0004ll-1v; Tue, 16 Oct 2007 16:57:18 +0000
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1192553837-18302-2-git-send-email-jari.aalto@cante.net>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: jaalto@cante.cante.net
X-SA-Exim-Scanned: No (on cante.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61217>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 git-commit.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index fcb8443..637cf48 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -3,6 +3,8 @@
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2006 Junio C Hamano
 
+TAIL="tail"
+
 USAGE='[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [--template <file>] [[-i | -o] <path>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
@@ -442,10 +444,10 @@ t)
 		s/^/Signed-off-by: /
 		')
 	blank_before_signoff=
-	tail -n 1 "$GIT_DIR"/COMMIT_EDITMSG |
+	$TAIL 1 "$GIT_DIR"/COMMIT_EDITMSG |
 	grep 'Signed-off-by:' >/dev/null || blank_before_signoff='
 '
-	tail -n 1 "$GIT_DIR"/COMMIT_EDITMSG |
+	$TAIL 1 "$GIT_DIR"/COMMIT_EDITMSG |
 	grep "$sign"$ >/dev/null ||
 	printf '%s%s\n' "$blank_before_signoff" "$sign" \
 		>>"$GIT_DIR"/COMMIT_EDITMSG
-- 
1.5.3.2.81.g17ed
