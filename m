From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: offer refs instead of filenames for 'git revert'
Date: Thu, 27 Nov 2008 14:35:53 +0100
Message-ID: <1227792953-4095-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 27 14:38:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5h3X-0001MG-Oq
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 14:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbYK0Nfz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Nov 2008 08:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753378AbYK0Nfz
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 08:35:55 -0500
Received: from francis.fzi.de ([141.21.7.5]:54274 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753277AbYK0Nfy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 08:35:54 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 27 Nov 2008 14:35:53 +0100
X-Mailer: git-send-email 1.6.0.4.814.gfe502
X-OriginalArrivalTime: 27 Nov 2008 13:35:53.0185 (UTC) FILETIME=[11913D10:01C95095]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101811>

The completion script for 'git revert' currently offers options and
filenames.  However, 'git revert' doesn't take any filenames from the
command line, but a single commit.  Therefore, it's more sane to offer
refs instead.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 39bf18b..7e668d5 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1348,7 +1348,7 @@ _git_revert ()
 		return
 		;;
 	esac
-	COMPREPLY=3D()
+	__gitcomp "$(__git_refs)"
 }
=20
 _git_rm ()
--=20
1.6.0.4.814.gfe502
