From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv2] bash: teach 'git checkout' options
Date: Thu, 24 Sep 2009 14:23:15 +0200
Message-ID: <1253794995-9093-1-git-send-email-szeder@ira.uka.de>
References: <20090922152846.GQ14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 24 14:24:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqnMm-00060Q-Qg
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 14:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbZIXMXc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Sep 2009 08:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbZIXMXb
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 08:23:31 -0400
Received: from francis.fzi.de ([141.21.7.5]:12059 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752306AbZIXMX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 08:23:29 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 24 Sep 2009 14:23:30 +0200
X-Mailer: git-send-email 1.6.5.rc2.85.gd02ad
In-Reply-To: <20090922152846.GQ14660@spearce.org>
X-OriginalArrivalTime: 24 Sep 2009 12:23:30.0683 (UTC) FILETIME=[D392C4B0:01CA3D11]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129040>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 8c268a1..a08e471 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -809,7 +809,21 @@ _git_checkout ()
 {
 	__git_has_doubledash && return
=20
-	__gitcomp "$(__git_refs)"
+	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--conflict=3D*)
+		__gitcomp "diff3 merge" "" "${cur##--conflict=3D}"
+		;;
+	--*)
+		__gitcomp "
+			--quiet --ours --theirs --track --no-track --merge
+			--conflict=3D --patch
+			"
+		;;
+	*)
+		__gitcomp "$(__git_refs)"
+		;;
+	esac
 }
=20
 _git_cherry ()
--=20
1.6.5.rc2.85.gd02ad
