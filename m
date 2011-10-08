From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] completion: unite --format and --pretty for 'log' and
	'show'
Date: Sat, 8 Oct 2011 03:09:34 +0200
Message-ID: <20111008010934.GC11561@goldbirke>
References: <1317926431-609-1-git-send-email-teemu.matilainen@iki.fi>
	<7vd3e9yap7.fsf@alter.siamese.dyndns.org>
	<20111008010432.GA11561@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Teemu Matilainen <teemu.matilainen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 08 03:10:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCLQk-00021H-CH
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 03:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab1JHBJp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 21:09:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:58464 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1JHBJo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 21:09:44 -0400
Received: from localhost6.localdomain6 (p5B131159.dip0.t-ipconnect.de [91.19.17.89])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0M2CHo-1Qta2r3bwy-00s75K; Sat, 08 Oct 2011 03:09:34 +0200
Content-Disposition: inline
In-Reply-To: <20111008010432.GA11561@goldbirke>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:pi1OYt7JrprJCDqRUQswkyR/z6XPGsgDIXMiAPuuaZd
 6R7OQBe4wjSRkzQPO74MqOxvMfgaeTB1FGzxOxiAAFX1lejWuW
 6P+eUjUeM7mvDnS6tVFzF31pLYsx1P7uEH6D/N34r3GG9goWm5
 2I1SQ6UtPha/rg5dHSct627vFcEw6ObZdWxUCw1foh4vgDg+XY
 KX+r3im7nJ2+ERhlLarrZXRnAjnbYqx5ZIpcXI4wBmp391A08V
 +B0L3ZQY5ET77JnZljJ0E9rAGgqGPRojo+dL32SLp5DzcQjJxD
 CukDSlp0vm3tc1cEqghB/fYFnn3Ja6KVzXyYuE2UELQWGz1ruX
 9pcCQJHtyLXR79ZWuRZs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183132>

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   18 ++++--------------
 1 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 98282435..b36f9e70 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1553,14 +1553,9 @@ _git_log ()
 		merge=3D"--merge"
 	fi
 	case "$cur" in
-	--pretty=3D*)
+	--pretty=3D*|--format=3D*)
 		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
-			" "" "${cur##--pretty=3D}"
-		return
-		;;
-	--format=3D*)
-		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
-			" "" "${cur##--format=3D}"
+			" "" "${cur#*=3D}"
 		return
 		;;
 	--date=3D*)
@@ -2365,14 +2360,9 @@ _git_show ()
 	__git_has_doubledash && return
=20
 	case "$cur" in
-	--pretty=3D*)
-		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
-			" "" "${cur##--pretty=3D}"
-		return
-		;;
-	--format=3D*)
+	--pretty=3D*|--format=3D*)
 		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
-			" "" "${cur##--format=3D}"
+			" "" "${cur#*=3D}"
 		return
 		;;
 	--*)
--=20
1.7.7.187.ga41de
