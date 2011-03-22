From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] git-am.txt: advertise 'git am --abort' instead of 'rm
	.git/rebase-apply'
Date: Tue, 22 Mar 2011 19:42:25 +0100
Message-ID: <1300819345-28279-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:42:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q26XS-00061a-Ad
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 19:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185Ab1CVSmh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 14:42:37 -0400
Received: from ex-e-1.perimeter.fzi.de ([141.21.8.250]:51002 "EHLO
	EX-E-1.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab1CVSmg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 14:42:36 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by EX-E-1.perimeter.fzi.de
 (141.21.8.250) with Microsoft SMTP Server (TLS) id 14.1.270.1; Tue, 22 Mar
 2011 19:42:29 +0100
Received: from localhost6.localdomain6 (141.21.7.126) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.270.1; Tue, 22 Mar
 2011 19:42:31 +0100
X-Mailer: git-send-email 1.7.4.1.372.g95585
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169761>

'git am --abort' is around for quite a long time now, and users should
normally not poke around inside the .git directory, yet the
documentation of 'git am' still recommends the following:

  ... if you decide to start over from scratch,
  run `rm -f -r .git/rebase-apply` ...

Suggest 'git am --abort' instead.

It's not quite the same as the original, because 'git am --abort' will
restore the original branch, while simply removing '.git/rebase-apply'
won't, but that's rather a thinko in the original wording, because
that won't actually "start over _from scratch_".

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-am.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 621b720..03fb214 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -173,9 +173,9 @@ aborts in the middle.  You can recover from this in=
 one of two ways:
   the index file to bring it into a state that the patch should
   have produced.  Then run the command with the '--resolved' option.
=20
-The command refuses to process new mailboxes while the `.git/rebase-ap=
ply`
-directory exists, so if you decide to start over from scratch,
-run `rm -f -r .git/rebase-apply` before running the command with mailb=
ox
+The command refuses to process new mailboxes before the current
+operation isn't finished, so if you decide to start over from scratch,
+run `git am --abort` before running the command with mailbox
 names.
=20
 Before any patches are applied, ORIG_HEAD is set to the tip of the
--=20
1.7.4.1.372.g95585
