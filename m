From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] bash: remove unnecessary conditions when checking for subcommands
Date: Mon, 10 Mar 2008 16:02:22 +0100
Message-ID: <1205161345-21120-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 16:03:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYjXC-0003YV-DG
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 16:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbYCJPC1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2008 11:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbYCJPC1
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 11:02:27 -0400
Received: from francis.fzi.de ([141.21.7.5]:44346 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751096AbYCJPC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 11:02:26 -0400
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 10 Mar 2008 16:02:24 +0100
X-Mailer: git-send-email 1.5.4.4.481.g5075
X-OriginalArrivalTime: 10 Mar 2008 15:02:24.0642 (UTC) FILETIME=[BFB03620:01C882BF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76735>

Checking emptyness of $command is sufficient.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 86b7ebe..39b2186 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -505,7 +505,7 @@ _git_bisect ()
 		c=3D$((++c))
 	done
=20
-	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
+	if [ -z "$command" ]; then
 		__gitcomp "start bad good reset visualize replay log"
 		return
 	fi
@@ -1050,7 +1050,7 @@ _git_remote ()
 		c=3D$((++c))
 	done
=20
-	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
+	if [ -z "$command" ]; then
 		__gitcomp "add rm show prune update"
 		return
 	fi
@@ -1143,7 +1143,7 @@ _git_submodule ()
 		c=3D$((++c))
 	done
=20
-	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
+	if [ -z "$command" ]; then
 		local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 		case "$cur" in
 		--*)
@@ -1206,7 +1206,7 @@ _git ()
 		c=3D$((++c))
 	done
=20
-	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
+	if [ -z "$command" ]; then
 		case "${COMP_WORDS[COMP_CWORD]}" in
 		--*=3D*) COMPREPLY=3D() ;;
 		--*)   __gitcomp "
--=20
1.5.4.4.481.g5075
