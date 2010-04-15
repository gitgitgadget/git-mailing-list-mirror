From: jari.aalto@cante.net
Subject: [PATCH] git-send-email.txt: Add EXAMPLES section. Write 1st level sections in uppercase
Date: Thu, 15 Apr 2010 18:37:03 +0300
Organization: Private
Message-ID: <1271345823-19685-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 18:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Rqt-0007R7-Ew
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 18:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572Ab0DOQXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 12:23:34 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:44910 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab0DOQXd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 12:23:33 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 548D58C28E
	for <git@vger.kernel.org>; Thu, 15 Apr 2010 19:23:32 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A03E890B8B2; Thu, 15 Apr 2010 19:23:32 +0300
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 429D92BD42
	for <git@vger.kernel.org>; Thu, 15 Apr 2010 19:23:30 +0300 (EEST)
Received: from mx2.cante.net ([192.168.1.7] helo=jondo.cante.net)
	by picasso.cante.net with esmtp (Exim 4.71)
	(envelope-from <jari.aalto@cante.net>)
	id 1O2R7l-0001Pe-Nt; Thu, 15 Apr 2010 18:37:01 +0300
X-Mailer: git-send-email 1.7.0
X-SA-Exim-Connect-IP: 192.168.1.7
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144997>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-send-email.txt |   36 ++++++++++++++++++++++++++++++++=
++--
 1 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-em=
ail.txt
index ced35b2..8b33eb0 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -299,8 +299,40 @@ sendemail.confirm::
 	one of 'always', 'never', 'cc', 'compose', or 'auto'. See '--confirm'
 	in the previous section for the meaning of these values.
=20
+EXAMPLES
+--------
=20
-Author
+To batch send all patches to a mailig list, no copies to oneself,
+messages in a relaxed single thread format (no nesting) and don't ask
+any confirmations:
+
+	git send-email \
+		--from $EMAIL \
+		--to address@list.example.com \
+		--suppress-cc=3Dauthor \
+		--suppress-from \
+		--no-chain-reply-to \
+		--confirm=3Dnever \
+		outgoing/
+
+Tip: in case the patches in a branch need rework, you might consider
+adjusting the subjects of each patch to "[PATCH v<number>]" with
+options '--subject-prefix'. The 'merge-base' inside command
+substitution is there to find out the initial commit of the branch:
+
+	git checkout BRANCH
+
+	git format-patch \
+		--subject-prefix=3D"PATCH v2" \
+		--signoff \
+		-M \
+		--output-directory outgoing/
+		$(git merge-base HEAD master)..
+
+Then proceed as in in the first example the send the patches out
+again.
+
+AUTHOR
 ------
 Written by Ryan Anderson <ryan@michonline.com>
=20
@@ -308,7 +340,7 @@ git-send-email is originally based upon
 send_lots_of_email.pl by Greg Kroah-Hartman.
=20
=20
-Documentation
+DOCUMENTATION
 --------------
 Documentation by Ryan Anderson
=20
--=20
1.7.0
