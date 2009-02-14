From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] bash completion: offer more options for gitk
Date: Sat, 14 Feb 2009 20:54:30 +0100
Message-ID: <1234641270-14342-1-git-send-email-trast@student.ethz.ch>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 20:56:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYQcT-0003u3-Fy
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 20:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbZBNTym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752046AbZBNTyk
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:54:40 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:24631 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbZBNTyk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:54:40 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 20:54:39 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 20:54:38 +0100
X-Mailer: git-send-email 1.6.2.rc0.293.g947001
X-OriginalArrivalTime: 14 Feb 2009 19:54:38.0241 (UTC) FILETIME=[1163D910:01C98EDE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109909>

Add some more git-log options to the gitk completion.  Not all of them
make sense, unfortunately.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I was simply too lazy to keep typing --simplify-by-decoration.

I made two passes over the git-log manpage and simply selected all
options that seemed to make sense, _seemed_ to work, and that didn't
mangle the history view in horrible ways (such as disconnecting it
into little pieces).  It does handle --left-right correctly, very
nice!


 contrib/completion/git-completion.bash |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a7a10c0..cedca6d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1808,7 +1808,15 @@ _gitk ()
 	fi
 	case "$cur" in
 	--*)
-		__gitcomp "--not --all $merge"
+		__gitcomp "
+			--not --all $merge
+			--branches --tags --remotes
+			--first-parent
+			--dense --sparse --full-history
+			--simplify-merges --simplify-by-decoration
+			--since= --after= --until= --before=
+			--left-right
+			"
 		return
 		;;
 	esac
-- 
1.6.2.rc0.293.g947001
