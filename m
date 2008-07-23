From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: offer only paths after '--' for 'git checkout'
Date: Wed, 23 Jul 2008 13:49:22 +0200
Message-ID: <1216813762-23511-2-git-send-email-szeder@ira.uka.de>
References: <1216808133-31919-2-git-send-email-madcoder@debian.org>
	<1216813762-23511-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 13:50:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLcrg-0008K5-PQ
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 13:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbYGWLt1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 07:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbYGWLt1
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 07:49:27 -0400
Received: from francis.fzi.de ([141.21.7.5]:50665 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751404AbYGWLtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 07:49:25 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 23 Jul 2008 13:49:22 +0200
X-Mailer: git-send-email 1.6.0.rc0.35.gb83a7
In-Reply-To: <1216813762-23511-1-git-send-email-szeder@ira.uka.de>
X-OriginalArrivalTime: 23 Jul 2008 11:49:22.0179 (UTC) FILETIME=[25C4DD30:01C8ECBA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89635>

Commit d773c631 (bash: offer only paths after '--', 2008-07-08) did the
same for several other git commands, but 'git checkout' went unnoticed.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 2edb341..9b51fda 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -626,6 +626,8 @@ _git_bundle ()
=20
 _git_checkout ()
 {
+	__git_has_doubledash && return
+
 	__gitcomp "$(__git_refs)"
 }
=20
--=20
1.6.0.rc0.35.gb83a7
