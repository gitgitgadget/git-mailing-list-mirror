From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 01/21] completion: improve __git_refs()'s in-code documentation
Date: Thu, 25 Feb 2016 23:50:30 +0100
Message-ID: <1456440650-32623-2-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:51:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4l0-0005Xs-2n
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbcBYWve convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:51:34 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35717 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750850AbcBYWvd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:51:33 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4kr-0007uU-Nx; Thu, 25 Feb 2016 23:51:30 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440690.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287450>

That "first argument is passed to __gitdir()" statement in particular
is not really helpful, and after this series it won't be the case
anyway.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index e3918c87e3ad..0e1fd778bfe8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -332,9 +332,11 @@ __git_tags ()
 	fi
 }
=20
-# __git_refs accepts 0, 1 (to pass to __gitdir), or 2 arguments
-# presence of 2nd argument means use the guess heuristic employed
-# by checkout for tracking branches
+# Lists refs from the local (by default) or from a remote repository.
+# It accepts 0, 1 or 2 arguments:
+# 1: The remote to lists refs from (optional; ignored, if set but empt=
y).
+# 2: In addition to local refs, list unique branches from refs/remotes=
/ for
+#    'git checkout's tracking DWIMery (optional; ignored, if set but e=
mpty).
 __git_refs ()
 {
 	local i hash dir=3D"$(__gitdir "${1-}")" track=3D"${2-}"
--=20
2.7.2.410.g92cb358
