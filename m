From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] bash: add git-branch options
Date: Tue,  4 Mar 2008 19:00:58 +0100
Message-ID: <d55a578b4b3f3b7d679b7f8b69497955c7a82a50.1204652001.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, spearce@spearce.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 19:18:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWbi8-0008HT-B1
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 19:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758497AbYCDSRT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2008 13:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756683AbYCDSRT
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 13:17:19 -0500
Received: from francis.fzi.de ([141.21.7.5]:5832 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757217AbYCDSRR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 13:17:17 -0500
X-Greylist: delayed 975 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Mar 2008 13:17:15 EST
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 4 Mar 2008 19:00:57 +0100
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
X-OriginalArrivalTime: 04 Mar 2008 18:00:57.0316 (UTC) FILETIME=[B2760A40:01C87E21]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76123>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 8f70e1e..8d6733a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -506,7 +506,16 @@ _git_bisect ()
=20
 _git_branch ()
 {
-	__gitcomp "$(__git_refs)"
+	case "${COMP_WORDS[COMP_CWORD]}" in
+	--*=3D*)	COMPREPLY=3D() ;;
+	--*)
+		__gitcomp "
+			--color --no-color --verbose --abbrev=3D --no-abbrev
+			--track --no-track
+			"
+		;;
+	*)	__gitcomp "$(__git_refs)" ;;
+	esac
 }
=20
 _git_bundle ()
--=20
1.5.4.3

