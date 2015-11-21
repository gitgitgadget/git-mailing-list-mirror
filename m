From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/3] bash prompt: remove a redundant command line option
Date: Sat, 21 Nov 2015 12:30:08 +0100
Message-ID: <1448105409-4494-2-git-send-email-szeder@ira.uka.de>
References: <1448105409-4494-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 21 12:31:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a06OB-0006Qt-Dy
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 12:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758649AbbKULaZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Nov 2015 06:30:25 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:52698 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751631AbbKULaY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Nov 2015 06:30:24 -0500
Received: from x4db28c43.dyn.telefonica.de ([77.178.140.67] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1a06N1-0003r7-1e; Sat, 21 Nov 2015 12:30:20 +0100
X-Mailer: git-send-email 2.6.3.402.geb6a0f7
In-Reply-To: <1448105409-4494-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1448105420.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281552>

To get the dirty state indicator __git_ps1() runs 'git diff' with
'--quiet --exit-code' options.  '--quiet' already implies
'--exit-code', so the latter is unnecessary and can be removed.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 07b52bedf1..7a95fbdcfd 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -476,7 +476,7 @@ __git_ps1 ()
 		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
 		   [ "$(git config --bool bash.showDirtyState)" !=3D "false" ]
 		then
-			git diff --no-ext-diff --quiet --exit-code || w=3D"*"
+			git diff --no-ext-diff --quiet || w=3D"*"
 			if [ -n "$short_sha" ]; then
 				git diff-index --cached --quiet HEAD -- || i=3D"+"
 			else
--=20
2.6.3.402.geb6a0f7
