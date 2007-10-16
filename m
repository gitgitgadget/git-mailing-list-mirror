From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-rebase--interactive.sh: Remove option -n from tail
Date: Tue, 16 Oct 2007 19:57:17 +0300
Message-ID: <1192553837-18302-4-git-send-email-jari.aalto@cante.net>
References: <1192553837-18302-1-git-send-email-jari.aalto@cante.net>
 <1192553837-18302-2-git-send-email-jari.aalto@cante.net>
 <1192553837-18302-3-git-send-email-jari.aalto@cante.net>
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 19:07:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihpt5-0000jW-UD
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760155AbXJPRHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760171AbXJPRHL
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:07:11 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:38642 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759835AbXJPRHK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 13:07:10 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 938D6EC224
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 19:57:21 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0623191049; Tue, 16 Oct 2007 19:57:21 +0300
Received: from cante.cante.net (a81-197-175-198.elisa-laajakaista.fi [81.197.175.198])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 7FE40158B57
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 19:57:20 +0300 (EEST)
Received: from jaalto by cante.cante.net with local (Exim 4.68)
	(envelope-from <jaalto@cante.cante.net>)
	id 1IhpjL-0004lp-9J; Tue, 16 Oct 2007 16:57:19 +0000
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1192553837-18302-3-git-send-email-jari.aalto@cante.net>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: jaalto@cante.cante.net
X-SA-Exim-Scanned: No (on cante.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61218>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 git-rebase--interactive.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 050140d..58e164c 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -10,6 +10,8 @@
 # The original idea comes from Eric W. Biederman, in
 # http://article.gmane.org/gmane.comp.version-control.git/22407
 
+TAIL="tail"
+
 USAGE='(--continue | --abort | --skip | [--preserve-merges] [--verbose]
 	[--onto <branch>] <upstream> [<branch>])'
 
@@ -204,7 +206,7 @@ nth_string () {
 make_squash_message () {
 	if test -f "$SQUASH_MSG"; then
 		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p" \
-			< "$SQUASH_MSG" | tail -n 1)+1))
+			< "$SQUASH_MSG" | $TAIL 1)+1))
 		echo "# This is a combination of $COUNT commits."
 		sed -n "2,\$p" < "$SQUASH_MSG"
 	else
-- 
1.5.3.2.81.g17ed
